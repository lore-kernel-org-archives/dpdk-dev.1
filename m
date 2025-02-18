Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81ADC021AF
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 21:04:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7CC9402A0;
	Tue, 18 Feb 2025 22:04:31 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 35AF140264
 for <dev@dpdk.org>; Tue, 18 Feb 2025 22:04:30 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 29DFA46260; Tue, 18 Feb 2025 22:04:30 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1664] rte_ipv6_addr_is_v4mapped wrong logic
Date: Tue, 18 Feb 2025 21:04:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sunnylandh@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1664-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17399126700.df7bAA46.182922
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: http://bugs.dpdk.org/
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


--17399126700.df7bAA46.182922
Date: Tue, 18 Feb 2025 22:04:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1664

            Bug ID: 1664
           Summary: rte_ipv6_addr_is_v4mapped wrong logic
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: sunnylandh@gmail.com
  Target Milestone: ---

rte_ipv6_addr_is_v4mapped() is implemented by comparing the first 32 bits o=
f an
IPv6 address with the ::ffff:0.0.0.0/96 prefix.
https://git.dpdk.org/dpdk/tree/lib/net/rte_ip6.h?id=3Dfba9875559906e04eaeb7=
4532f4cfd51194259a2#n313

The following snippet prints "1", but the loopback address is not a v4mapped
address.

#include <stdio.h>
#include <rte_ip6.h>

int main() {
  struct rte_ipv6_addr a =3D RTE_IPV6_ADDR_LOOPBACK;
  printf("%d\n", rte_ipv6_addr_is_v4mapped(&a));
}

The function should compare the first 96 bits instead.

rte_ipv6_addr_is_v4compat() has the same mistake.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17399126700.df7bAA46.182922
Date: Tue, 18 Feb 2025 22:04:30 +0100
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - rte_ipv6_addr_is_v4mapped wrong logic"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1664">1664</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>rte_ipv6_addr_is_v4mapped wrong logic
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>unspecified
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
          <td>ethdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>sunnylandh&#64;gmail.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">rte_ipv6_addr_is_v4mapped() is imp=
lemented by comparing the first 32 bits of an
IPv6 address with the ::ffff:0.0.0.0/96 prefix.
<a href=3D"https://git.dpdk.org/dpdk/tree/lib/net/rte_ip6.h?id=3Dfba9875559=
906e04eaeb74532f4cfd51194259a2#n313">https://git.dpdk.org/dpdk/tree/lib/net=
/rte_ip6.h?id=3Dfba9875559906e04eaeb74532f4cfd51194259a2#n313</a>

The following snippet prints &quot;1&quot;, but the loopback address is not=
 a v4mapped
address.

#include &lt;stdio.h&gt;
#include &lt;rte_ip6.h&gt;

int main() {
  struct rte_ipv6_addr a =3D RTE_IPV6_ADDR_LOOPBACK;
  printf(&quot;%d\n&quot;, rte_ipv6_addr_is_v4mapped(&amp;a));
}

The function should compare the first 96 bits instead.

rte_ipv6_addr_is_v4compat() has the same mistake.
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
?id=3D1664">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17399126700.df7bAA46.182922--
