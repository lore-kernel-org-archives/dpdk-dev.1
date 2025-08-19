Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF09CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 20:58:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 224794026C;
	Tue, 19 Aug 2025 22:58:43 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4290940151
 for <dev@dpdk.org>; Tue, 19 Aug 2025 22:58:41 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 254E046D6E; Tue, 19 Aug 2025 22:58:41 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1774] Build error: static assertion failed:
 "GMAC_LARGE_PLAINTEXT_LENGTH should not be greater than
 LARGE_MBUF_DATAPAYLOAD_SIZE"
Date: Tue, 19 Aug 2025 20:58:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: parthakumar.roy@ibm.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1774-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17556371200.e1A53.818719
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


--17556371200.e1A53.818719
Date: Tue, 19 Aug 2025 22:58:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1774

            Bug ID: 1774
           Summary: Build error: static assertion failed:
                    "GMAC_LARGE_PLAINTEXT_LENGTH should not be greater
                    than LARGE_MBUF_DATAPAYLOAD_SIZE"
           Product: DPDK
           Version: 25.07
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: parthakumar.roy@ibm.com
  Target Milestone: ---

This commit
https://github.com/DPDK/dpdk/commit/6a9f3f6df9ef51e30ff5bf3eea00f27ffef87a16
enables RTE_PKTMBUF_HEADROOM to be tuned from the build process. However,
GMAC_LARGE_PLAINTEXT_LENGTH setting of 65344 fails a static assert if
RTE_PKTMBUF_HEADROOM is set to 192. Changing it to 65343 would pass the bui=
ld.


meson setup -Dplatform=3Dx86_64 -Dpkt_mbuf_headroom=3D192 -Dmax_lcores=3D128
-Dmax_ethports=3D64
-Denable_drivers=3Dbus/auxiliary,bus/pci,common/mlx5,net/mlx5,net/tap
-Denable_driver_sdk=3Dtrue -Dcpu_instruction_set=3Dbroadwell -Dprefix=3D/ b=
uild; cd
build &&=20

...

[896/1072] Compiling C object app/dpdk-test.p/test_test_cryptodev.c.o=20=20=
=20=20=20=20=20=20=20=20=20

FAILED: app/dpdk-test.p/test_test_cryptodev.c.o=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

...=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20

In file included from ../lib/net/rte_ether.h:14,=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

                 from ../app/test/test_cryptodev.c:16:=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

../app/test/test_cryptodev_aead_test_vectors.h:15:1: error: static assertion
failed: "GMAC_LARGE_PLAINTEXT_LENGTH should not be greater than
LARGE_MBUF_DATAPAYLOAD_SIZE"=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20

   15 | static_assert(GMAC_LARGE_PLAINTEXT_LENGTH <=3D
LARGE_MBUF_DATAPAYLOAD_SIZE,=20=20=20=20=20=20=20=20=20=20=20=20=20

      | ^~~~~~~~~~~~~

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17556371200.e1A53.818719
Date: Tue, 19 Aug 2025 22:58:40 +0200
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
   title=3D"UNCONFIRMED - Build error: static assertion failed: &quot;GMAC_=
LARGE_PLAINTEXT_LENGTH should not be greater than LARGE_MBUF_DATAPAYLOAD_SI=
ZE&quot;"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1774">1774</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>Build error: static assertion failed: &quot;GMAC_LARGE_PLAINT=
EXT_LENGTH should not be greater than LARGE_MBUF_DATAPAYLOAD_SIZE&quot;
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.07
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
          <td>parthakumar.roy&#64;ibm.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">This commit
<a href=3D"https://github.com/DPDK/dpdk/commit/6a9f3f6df9ef51e30ff5bf3eea00=
f27ffef87a16">https://github.com/DPDK/dpdk/commit/6a9f3f6df9ef51e30ff5bf3ee=
a00f27ffef87a16</a>
enables RTE_PKTMBUF_HEADROOM to be tuned from the build process. However,
GMAC_LARGE_PLAINTEXT_LENGTH setting of 65344 fails a static assert if
RTE_PKTMBUF_HEADROOM is set to 192. Changing it to 65343 would pass the bui=
ld.


meson setup -Dplatform=3Dx86_64 -Dpkt_mbuf_headroom=3D192 -Dmax_lcores=3D128
-Dmax_ethports=3D64
-Denable_drivers=3Dbus/auxiliary,bus/pci,common/mlx5,net/mlx5,net/tap
-Denable_driver_sdk=3Dtrue -Dcpu_instruction_set=3Dbroadwell -Dprefix=3D/ b=
uild; cd
build &amp;&amp;=20

...

[896/1072] Compiling C object app/dpdk-test.p/test_test_cryptodev.c.o=20=20=
=20=20=20=20=20=20=20=20=20

FAILED: app/dpdk-test.p/test_test_cryptodev.c.o=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

...=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20

In file included from ../lib/net/rte_ether.h:14,=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

                 from ../app/test/test_cryptodev.c:16:=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20

../app/test/test_cryptodev_aead_test_vectors.h:15:1: error: static assertion
failed: &quot;GMAC_LARGE_PLAINTEXT_LENGTH should not be greater than
LARGE_MBUF_DATAPAYLOAD_SIZE&quot;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20

   15 | static_assert(GMAC_LARGE_PLAINTEXT_LENGTH &lt;=3D
LARGE_MBUF_DATAPAYLOAD_SIZE,=20=20=20=20=20=20=20=20=20=20=20=20=20

      | ^~~~~~~~~~~~~
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
?id=3D1774">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17556371200.e1A53.818719--
