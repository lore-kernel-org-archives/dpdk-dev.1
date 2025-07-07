Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026ADC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 09:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D46C940287;
	Mon,  7 Jul 2025 11:12:59 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DBF804025D
 for <dev@dpdk.org>; Mon,  7 Jul 2025 11:12:57 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A710846B20; Mon,  7 Jul 2025 11:12:57 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1748] Clarification on Possible Buffer Overflow
 Issues Reported by Fortify Tool
Date: Mon, 07 Jul 2025 09:12:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nagendra.balagani@oracle.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1748-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17518795770.2d8FC7.4194189
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


--17518795770.2d8FC7.4194189
Date: Mon, 7 Jul 2025 11:12:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1748

            Bug ID: 1748
           Summary: Clarification on Possible Buffer Overflow Issues
                    Reported by Fortify Tool
           Product: DPDK
           Version: 23.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: nagendra.balagani@oracle.com
  Target Milestone: ---

Hello Team,

While running Fortify static analysis on our code base that uses DPDK, we
observed some potential buffer overflow issues being reported within DPDK
library calls. At first glance, these instances appear to be false positive=
s,
but we would like to confirm with the community and maintainers to ensure t=
here
are no hidden risks.
Could you please help review these findings or suggest if there are any kno=
wn
false positives in this area?

here are the detailed Fortify reports with exact file paths and line numbers
for your reference.

### Instance 1:  rte_crypto.h Line 207
memset(op->asym, 0, sizeof(struct rte_crypto_asym_op));

Tool Description : The function __rte_crypto_op_reset() in rte_crypto.h wri=
tes
outside the bounds of asym on line 207, which could corrupt data, cause the
program to crash, or lead to the execution of malicious code.

Analysis Trace
rte_crypto.h:181 - Buffer asym Declared
rte_crypto.h:207 - memset()
Buffer Size: 0 bytes Write Length: 168 bytes


### Instance 2: rte_crypto_sym.h: 885
memset(op, 0, sizeof(*op));

Tool Description: The program writes outside the bounds of allocated memory,
which could corrupt data, crash the program, or lead to the execution of
malicious code.

Analysis Trace
rte_crypto.h:204 - Caller: __rte_crypto_op_reset
Buffer Size: 0
rte_crypto_sym.h:885 - memset()
Buffer Size: 0 bytes Write Length: 64 bytes [var 0] op.$offset: 0


### Instance3: rte_lpm.h: 347
            tbl24_indexes[i] =3D ips[i] >> 8;

Tool Description: The function rte_lpm_lookup_bulk_func() in rte_lpm.h writ=
es
outside the bounds of tbl24_indexes on line 347, which could corrupt data,
cause the program to crash, or lead to the execution of malicious code.

Analysis Trace
rte_lpm.h:339 - Buffer tbl24_indexes Allocated
rte_lpm.h:347 - Assignment to tbl24_indexes
Buffer Size: 262143 bytes Write Length: 1048572 bytes [var 0]
tbl24_indexes.$offset: 0 [var 1] i: 262142


Thank you in advance for your support and guidance.

Regards,
Nagendra

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17518795770.2d8FC7.4194189
Date: Mon, 7 Jul 2025 11:12:57 +0200
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
   title=3D"UNCONFIRMED - Clarification on Possible Buffer Overflow Issues =
Reported by Fortify Tool"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1748">1748</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Clarification on Possible Buffer Overflow Issues Reported by =
Fortify Tool
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>23.11
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
          <td>nagendra.balagani&#64;oracle.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Hello Team,

While running Fortify static analysis on our code base that uses DPDK, we
observed some potential buffer overflow issues being reported within DPDK
library calls. At first glance, these instances appear to be false positive=
s,
but we would like to confirm with the community and maintainers to ensure t=
here
are no hidden risks.
Could you please help review these findings or suggest if there are any kno=
wn
false positives in this area?

here are the detailed Fortify reports with exact file paths and line numbers
for your reference.

### Instance 1:  rte_crypto.h Line 207
memset(op-&gt;asym, 0, sizeof(struct rte_crypto_asym_op));

Tool Description : The function __rte_crypto_op_reset() in rte_crypto.h wri=
tes
outside the bounds of asym on line 207, which could corrupt data, cause the
program to crash, or lead to the execution of malicious code.

Analysis Trace
rte_crypto.h:181 - Buffer asym Declared
rte_crypto.h:207 - memset()
Buffer Size: 0 bytes Write Length: 168 bytes


### Instance 2: rte_crypto_sym.h: 885
memset(op, 0, sizeof(*op));

Tool Description: The program writes outside the bounds of allocated memory,
which could corrupt data, crash the program, or lead to the execution of
malicious code.

Analysis Trace
rte_crypto.h:204 - Caller: __rte_crypto_op_reset
Buffer Size: 0
rte_crypto_sym.h:885 - memset()
Buffer Size: 0 bytes Write Length: 64 bytes [var 0] op.$offset: 0


### Instance3: rte_lpm.h: 347
            tbl24_indexes[i] =3D ips[i] &gt;&gt; 8;

Tool Description: The function rte_lpm_lookup_bulk_func() in rte_lpm.h writ=
es
outside the bounds of tbl24_indexes on line 347, which could corrupt data,
cause the program to crash, or lead to the execution of malicious code.

Analysis Trace
rte_lpm.h:339 - Buffer tbl24_indexes Allocated
rte_lpm.h:347 - Assignment to tbl24_indexes
Buffer Size: 262143 bytes Write Length: 1048572 bytes [var 0]
tbl24_indexes.$offset: 0 [var 1] i: 262142


Thank you in advance for your support and guidance.

Regards,
Nagendra
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
?id=3D1748">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17518795770.2d8FC7.4194189--
