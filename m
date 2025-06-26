Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DDCC7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 09:37:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 666DA40156;
	Thu, 26 Jun 2025 11:37:00 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7497B400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 11:36:59 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6424446A62; Thu, 26 Jun 2025 11:36:59 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1731] FIB insertion error(-28) after remove all rules
Date: Thu, 26 Jun 2025 09:36:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kipi@servers.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1731-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17509306190.EBB6bBC9B.170225
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org


--17509306190.EBB6bBC9B.170225
Date: Thu, 26 Jun 2025 11:36:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1731

            Bug ID: 1731
           Summary: FIB insertion error(-28) after remove all rules
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: kipi@servers.com
  Target Milestone: ---

Created attachment 321
  --> https://bugs.dpdk.org/attachment.cgi?id=3D321&action=3Dedit
FIB error example

The error is due to overflow of the internal FIB counter "rsvd_tbl8s". After
this error occurs, it is impossible to add any rules even the FIB is empty.

To reproduce this error, simply insert two IP addresses of the following ty=
pe
with the same next-hope parameter (this is important):
struct Network {
    uint32_t ip;
    uint16_t prefix;
};

/*
    first insertion with prefix less than 25 doesn't allocate tbl8 entry
    second insertion with prefix more than 24 will allocate tbl8 entry BUT =
only
when we pass the different next hope
*/
const struct Network state[] =3D {
    {0x3000000, 15}, {0x3000520, 29}
};

and delete them. Deleting the first rule will allocate tbl8 entry but
"rsvd_tbl8s" counter won't increment. Deleting the second rule will decrease
the counter "rsvd_tbl8s" and it will overflow.

The full reproduce program is in attachment.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17509306190.EBB6bBC9B.170225
Date: Thu, 26 Jun 2025 11:36:59 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - FIB insertion error(-28) after remove all rules"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1731">1731</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>FIB insertion error(-28) after remove all rules
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>other
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>kipi&#64;servers.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D321" name=3D"attach_321" title=3D"FIB error example=
">attachment 321</a> <a href=3D"attachment.cgi?id=3D321&amp;action=3Dedit" =
title=3D"FIB error example">[details]</a></span>
FIB error example

The error is due to overflow of the internal FIB counter &quot;rsvd_tbl8s&q=
uot;. After
this error occurs, it is impossible to add any rules even the FIB is empty.

To reproduce this error, simply insert two IP addresses of the following ty=
pe
with the same next-hope parameter (this is important):
struct Network {
    uint32_t ip;
    uint16_t prefix;
};

/*
    first insertion with prefix less than 25 doesn't allocate tbl8 entry
    second insertion with prefix more than 24 will allocate tbl8 entry BUT =
only
when we pass the different next hope
*/
const struct Network state[] =3D {
    {0x3000000, 15}, {0x3000520, 29}
};

and delete them. Deleting the first rule will allocate tbl8 entry but
&quot;rsvd_tbl8s&quot; counter won't increment. Deleting the second rule wi=
ll decrease
the counter &quot;rsvd_tbl8s&quot; and it will overflow.

The full reproduce program is in attachment.
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1731">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17509306190.EBB6bBC9B.170225--
