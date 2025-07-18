Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A53C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:54:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E477C40DDD;
	Fri, 18 Jul 2025 18:54:54 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CF2F340DCA
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:54:53 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B9E5646BAE; Fri, 18 Jul 2025 18:54:53 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1755] Re-evaluate the link requirement decorators on
 all testsuites/testcases
Date: Fri, 18 Jul 2025 16:54:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: probb@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1755-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17528576930.73F6.1243374
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


--17528576930.73F6.1243374
Date: Fri, 18 Jul 2025 18:54:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1755

            Bug ID: 1755
           Summary: Re-evaluate the link requirement decorators on all
                    testsuites/testcases
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: probb@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

There are currently some testsuites/testcases that are decorated with
"requires_2_links" but in reality there is no logic associated with having 2
physical ports on the SUT. These testsuites just configure the SUT ports (e=
ven
if it's just 1) according to the testsuite requirements, and then
ingress/egress based on topology.ingress_port and topology.egress_port. For
these testsuites/testcases, we should rewrite their decorator to
"requires_1_link."

So, assess the whole list of testcases and submit a patch rewriting their
decorators.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17528576930.73F6.1243374
Date: Fri, 18 Jul 2025 18:54:53 +0200
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
   title=3D"UNCONFIRMED - Re-evaluate the link requirement decorators on al=
l testsuites/testcases"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1755">1755</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Re-evaluate the link requirement decorators on all testsuites=
/testcases
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
          <td>DTS
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>CC</th>
          <td>juraj.linkes&#64;pantheon.tech, probb&#64;iol.unh.edu
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">There are currently some testsuite=
s/testcases that are decorated with
&quot;requires_2_links&quot; but in reality there is no logic associated wi=
th having 2
physical ports on the SUT. These testsuites just configure the SUT ports (e=
ven
if it's just 1) according to the testsuite requirements, and then
ingress/egress based on topology.ingress_port and topology.egress_port. For
these testsuites/testcases, we should rewrite their decorator to
&quot;requires_1_link.&quot;

So, assess the whole list of testcases and submit a patch rewriting their
decorators.
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
?id=3D1755">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17528576930.73F6.1243374--
