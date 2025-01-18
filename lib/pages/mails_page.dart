import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opengoalz/models/profile.dart';
import 'package:opengoalz/models/mail.dart';
import 'package:opengoalz/constants.dart';
import 'package:opengoalz/extensionBuildContext.dart';
import 'package:opengoalz/postgresql_requests.dart';
import 'package:opengoalz/provider_user.dart';
import 'package:opengoalz/widgets/appDrawer.dart';
import 'package:opengoalz/functions/descriptionParser.dart';
import 'package:opengoalz/widgets/goBackToolTip.dart';
import 'package:opengoalz/widgets/max_width_widget.dart';
import 'package:opengoalz/widgets/tab_widget_with_icon.dart';
import 'package:provider/provider.dart';

class MailsPage extends StatefulWidget {
  final int idClub;
  const MailsPage({Key? key, required this.idClub}) : super(key: key);

  static Route<void> route(int idClub) {
    return MaterialPageRoute(
      builder: (context) => MailsPage(idClub: idClub),
    );
  }

  @override
  State<MailsPage> createState() => _MailsPageState();
}

class _MailsPageState extends State<MailsPage> {
  // late Stream<Club> _clubStream;

  @override
  void initState() {
    // _clubStream = supabase
    //     // Fetch the club
    //     .from('clubs')
    //     .stream(primaryKey: ['id'])
    //     .eq('id', widget.idClub)
    //     .map((maps) => maps.map((map) => Club.fromMap(map)).first)
    // Fetch the user mails
    // .switchMap((Club club) {
    //   if (club.userName == null) {
    //     Exception('The club does not have a username');
    //   }
    //   return supabase
    //       .from('messages_mail')
    //       .stream(primaryKey: ['id'])
    //       .eq('username_to', club.userName!)
    //       .order('created_at', ascending: false)
    //       .map((maps) => maps.map((map) => Mail.fromMap(map)).toList())
    //       .map((List<Mail> mails) {
    //         club.userMails = mails;
    //         return club;
    //       });
    // })
    // .switchMap((Club club) {
    //   return supabase
    //       .from('messages_mail')
    //       .stream(primaryKey: ['id'])
    //       .eq('id_club_to', club.id)
    //       .order('created_at', ascending: false)
    //       .map((maps) => maps.map((map) => Mail.fromMap(map)).toList())
    //       .map((List<Mail> mails) {
    //         club.mails = mails;
    //         return club;
    //       });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Mail> clubMails = Provider.of<SessionProvider>(context, listen: false)
    //     .user!
    //     .selectedClub!
    //     .mails
    //     .where((mail) => mail.dateDelete == null)
    //     .toList();
    // List<Mail> clubMailsThrash =
    //     Provider.of<SessionProvider>(context, listen: false)
    //         .user!
    //         .selectedClub!
    //         .mails
    //         .where((mail) => mail.dateDelete != null)
    //         .toList();
    // List<Mail> userMails = Provider.of<SessionProvider>(context, listen: false)
    //     .user!
    //     .mails
    //     .where((mail) => mail.dateDelete == null)
    //     .toList();
    // List<Mail> userMailsThrash =
    //     Provider.of<SessionProvider>(context, listen: false)
    //         .user!
    //         .mails
    //         .where((mail) => mail.dateDelete != null)
    //         .toList();

    return Consumer<SessionProvider>(
      builder: (context, sessionProvider, child) {
        final clubMails = sessionProvider.user!.selectedClub!.mails
            .where((mail) => mail.dateDelete == null)
            .toList();
        final clubMailsThrash = sessionProvider.user!.selectedClub!.mails
            .where((mail) => mail.dateDelete != null)
            .toList();
        final userMails = sessionProvider.user!.mails
            .where((mail) => mail.dateDelete == null)
            .toList();
        final userMailsThrash = sessionProvider.user!.mails
            .where((mail) => mail.dateDelete != null)
            .toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Mails (${userMails.where((mail) => mail.isRead == false).length}) (${clubMails.where((mail) => mail.isRead == false).length})'),
            leading: goBackIconButton(context),
          ),
          body: MaxWidthContainer(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      buildTabWithIcon(
                          icon: iconClub,
                          text: 'Club Mails (${clubMails.length})'),
                      buildTabWithIcon(
                          icon: iconUser,
                          text: 'User Mails (${userMails.length})'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        /// Club mails
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                tabs: [
                                  buildTabWithIcon(
                                      icon: Icons.inbox,
                                      text: 'Inbox (${clubMails.length})'),
                                  buildTabWithIcon(
                                      icon: Icons.auto_delete,
                                      text:
                                          'Thrash (${clubMailsThrash.length})'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    _buildInbox(context, clubMails),
                                    _buildThrash(context, clubMailsThrash),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// User mails
                        DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                tabs: [
                                  buildTabWithIcon(
                                      icon: Icons.inbox,
                                      text: 'Inbox (${userMails.length})'),
                                  buildTabWithIcon(
                                      icon: Icons.auto_delete,
                                      text:
                                          'Thrash (${userMailsThrash.length})'),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    _buildInbox(context, userMails),
                                    _buildThrash(context, userMailsThrash),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInbox(BuildContext context, List<Mail> mails) {
    if (mails.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 100, color: Colors.blueGrey),
            Text('Your inbox is empty'),
          ],
        ),
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Mark all as read
            widgetManageMails(context, mails, operationType: 'markRead'),
            // Mark all as unread
            widgetManageMails(context, mails, operationType: 'markUnread'),
            // Delete all
            widgetManageMails(context, mails, operationType: 'delete'),
          ],
        ),
        // Expanded widget to make _buildMailsList take the remaining space
        Expanded(
          child: _buildMailsList(mails),
        ),
      ],
    );
  }

  Widget _buildThrash(BuildContext context, List<Mail> mails) {
    if (mails.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox, size: 100, color: Colors.blueGrey),
            Text('Your delete box is empty'),
          ],
        ),
      );
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Mark all as read
            widgetManageMails(context, mails, operationType: 'markRead'),
            // Mark all as unread
            widgetManageMails(context, mails, operationType: 'markUnread'),
            // Restore all
            widgetManageMails(context, mails, operationType: 'restore'),
          ],
        ),
        // Expanded widget to make _buildMailsList take the remaining space
        Expanded(
          child: _buildMailsList(mails),
        ),
      ],
    );
  }

  Widget _buildMailsList(List<Mail> mails) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isNarrow =
            constraints.maxWidth < maxWidth; // Adjust the threshold as needed

        return ListView.builder(
          itemCount: mails.length,
          itemBuilder: (context, index) {
            final mail = mails[index];
            return Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(8.0),
                color: mail.isRead
                    ? Colors.grey[800]
                    : null, // Background color based on read status
              ),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: mail.isRead
                              ? Icon(Icons.mark_email_read)
                              : Icon(Icons.mail),
                          onPressed: () async {
                            if (mail.isRead) {
                              bool isOk = await operationInDB(
                                  context, 'UPDATE', 'messages_mail',
                                  data: {
                                    'is_read': false
                                  },
                                  matchCriteria: {
                                    'id': mail.id,
                                  });
                              // if (isOk) {
                              //   context.showSnackBar(
                              //       'The mail has been set to unread',
                              //       icon: Icon(Icons.mark_email_read,
                              //           color: Colors.green));
                              // }
                            } else {
                              await operationInDB(
                                  context, 'UPDATE', 'messages_mail',
                                  data: {
                                    'is_read': true,
                                  },
                                  matchCriteria: {
                                    'id': mail.id,
                                  });
                            }
                          },
                        ),
                        Text('From:'),
                        formSpacer3,
                        if (mail.userNameFrom != null)
                          getUserNameClickable(context,
                              userName: mail.userNameFrom),
                        if (mail.userNameFrom == null)
                          Row(
                            children: [
                              Icon(iconStaff),
                              formSpacer3,
                              Text(mail.senderRole!),
                            ],
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        // Favorite button
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color:
                                mail.isFavorite ? Colors.red : Colors.blueGrey,
                          ),
                          onPressed: () async {
                            if (mail.isFavorite) {
                              await operationInDB(
                                  context, 'UPDATE', 'messages_mail',
                                  data: {
                                    'is_favorite': false,
                                  },
                                  matchCriteria: {
                                    'id': mail.id,
                                  });
                            } else {
                              await operationInDB(
                                  context, 'UPDATE', 'messages_mail',
                                  data: {
                                    'is_favorite': true,
                                  },
                                  matchCriteria: {
                                    'id': mail.id,
                                  });
                            }
                          },
                        ),
                        // Delete button
                        if (mail.dateDelete == null)
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              bool isOk = await operationInDB(
                                  context, 'UPDATE', 'messages_mail',
                                  data: {
                                    'date_delete': DateTime.now()
                                        .add(Duration(days: 7))
                                        .toIso8601String(),
                                  },
                                  matchCriteria: {
                                    'id': mail.id,
                                  });
                              // if (isOk) {
                              //   context.showSnackBar(
                              //       'The mail will be deleted in 7 days',
                              //       icon: Icon(Icons.mark_email_read,
                              //           color: Colors.green));
                              // }
                            },
                          ),
                        // Restore button
                        if (mail.dateDelete != null)
                          IconButton(
                            icon: Icon(Icons.restore_from_trash),
                            onPressed: () async {
                              bool isOk = await operationInDB(
                                  context, 'UPDATE', 'messages_mail',
                                  data: {
                                    'date_delete': null,
                                  },
                                  matchCriteria: {
                                    'id': mail.id,
                                  });
                              if (isOk) {
                                context.showSnackBar(
                                    'The mail has been moved back to your inbox',
                                    icon: Icon(Icons.mark_email_read,
                                        color: Colors.green));
                              }
                            },
                          ),
                      ],
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.label_important),
                    Expanded(
                      child: Tooltip(
                        message: mail.title,
                        // child: Text(
                        //   mail.title,
                        //   style: TextStyle(
                        //     fontStyle: FontStyle.italic,
                        //     fontWeight: FontWeight.bold,
                        //     // color: Colors.blueGrey
                        //   ),
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        // ),
                        child: RichText(
                          text: parseDescriptionTextSpan(context, mail.title),
                        ),
                      ),
                    ),
                    formSpacer6,
                    Icon(Icons.calendar_month),
                    SizedBox(width: 3),
                    Text(
                      mail.createdAt.year == DateTime.now().year
                          ? DateFormat('MMM dd, kk:mm').format(mail.createdAt)
                          : DateFormat('MMM dd, yyyy, kk:mm')
                              .format(mail.createdAt),
                    ),
                  ],
                ),
                showTrailingIcon: isNarrow ? false : true,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      // child: Text(
                      //   mail.message,
                      //   style: TextStyle(
                      //     fontStyle: FontStyle.italic,
                      //   ),
                      // ),
                      child: RichText(
                        text: parseDescriptionTextSpan(context, mail.message),
                      ),
                    ),
                  ),
                ],
                onExpansionChanged: (isExpanded) async {
                  if (isExpanded && !mail.isRead) {
                    await operationInDB(context, 'UPDATE', 'messages_mail',
                        data: {
                          'is_read': true,
                        },
                        matchCriteria: {
                          'id': mail.id,
                        });
                  }
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget widgetManageMails(
    BuildContext context,
    List<Mail> mails, {
    required String operationType,
  }) {
    final String textMessage;
    final String confirmationMessage;
    final String successMessage;
    final Map<String, dynamic>? data;
    final Icon icon;

    switch (operationType) {
      case 'markRead':
        textMessage = 'Mark all as read';
        confirmationMessage =
            'Are you sure you want to mark all mails as read ?';
        successMessage = 'All ${mails.length} mails have been set to read';
        icon = Icon(Icons.mark_email_read);
        data = {'is_read': true};
        break;
      case 'markUnread':
        textMessage = 'Mark all as unread';
        confirmationMessage =
            'Are you sure you want to mark all mails as unread ?';
        successMessage = 'All ${mails.length} mails have been set to unread';
        icon = Icon(Icons.markunread);
        data = {'is_read': false};
        break;
      case 'delete':
        textMessage = 'Delete all';
        confirmationMessage =
            'Are you sure you want to throw all mails in the thrash ?';
        successMessage = 'All ${mails.length} mails will be deleted in 7 days';
        icon = Icon(Icons.delete, color: Colors.red);
        data = {
          'date_delete': DateTime.now().add(Duration(days: 7)).toIso8601String()
        };
        break;
      case 'restore':
        textMessage = 'Restore all';
        confirmationMessage =
            'Are you sure you want to restore all mails from the thrash ?';
        successMessage =
            'All ${mails.length} mails have been restored from the thrash';
        icon = Icon(Icons.restore_from_trash, color: Colors.green);
        data = {'date_delete': null};
        break;
      default:
        throw Exception('Invalid operation type: $operationType');
    }

    return InkWell(
      onTap: () async {
        bool? shouldUpdate =
            await context.showConfirmationDialog(confirmationMessage);

        if (shouldUpdate == true) {
          bool isOk;
          isOk = await operationInDB(
            context,
            'UPDATE',
            'messages_mail',
            data: data,
            inFilterMatchCriteria: {
              'id': mails.map((mail) => mail.id).toList()
            },
          );

          if (isOk) {
            context.showSnackBar(successMessage,
                icon: Icon(iconSuccessfulOperation, color: Colors.green));
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            icon,
            SizedBox(width: 3),
            Text(textMessage),
          ],
        ),
      ),
    );
  }
}
