Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8F7CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 02:44:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 255A140292;
	Thu, 21 Aug 2025 04:44:12 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 24D004026C
 for <dev@dpdk.org>; Thu, 21 Aug 2025 04:44:11 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 191A046D80; Thu, 21 Aug 2025 04:44:11 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1777] --max-pkt-len below 1500 does not seem to to
 be enforced
Date: Thu, 21 Aug 2025 02:44:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: canary.overflow@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1777-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17557442500.A5fecf.1818085
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


--17557442500.A5fecf.1818085
Date: Thu, 21 Aug 2025 04:44:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1777

            Bug ID: 1777
           Summary: --max-pkt-len below 1500 does not seem to to be
                    enforced
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: minor
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: canary.overflow@gmail.com
  Target Milestone: ---

I observed that setting --max-pkt-len to a value lower than 1500 does not
enforce this value even though "show port info X" showed that the MTU was s=
et
to the value passed in.

(e.g. packets larger than 800 bytes (> 1000 bytes) were still observed even
though --max-pkt-len=3D800 was set)

I believe that there is a default value that --max-pkt-len falls back on if=
 the
value is too low. If this is the case, this value should also be reflected =
in
the port info.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17557442500.A5fecf.1818085
Date: Thu, 21 Aug 2025 04:44:10 +0200
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
   title=3D"UNCONFIRMED - --max-pkt-len below 1500 does not seem to to be e=
nforced"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1777">1777</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>--max-pkt-len below 1500 does not seem to to be enforced
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>22.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>minor
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>testpmd
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>canary.overflow&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">I observed that setting --max-pkt-=
len to a value lower than 1500 does not
enforce this value even though &quot;show port info X&quot; showed that the=
 MTU was set
to the value passed in.

(e.g. packets larger than 800 bytes (&gt; 1000 bytes) were still observed e=
ven
though --max-pkt-len=3D800 was set)

I believe that there is a default value that --max-pkt-len falls back on if=
 the
value is too low. If this is the case, this value should also be reflected =
in
the port info.
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
?id=3D1777">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17557442500.A5fecf.1818085--
