Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65672C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 09:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 771F440650;
	Mon, 31 Mar 2025 11:20:07 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7770B40156
 for <dev@dpdk.org>; Mon, 31 Mar 2025 11:20:05 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5BBD5464C7; Mon, 31 Mar 2025 11:20:05 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1686] [dpdk-22.11.8RC1]
 unit_tests_cryptodev_func/cryptodev_aesni_gcm_autotest: test
 failing-Segmentation fault
Date: Mon, 31 Mar 2025 09:20:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yux.jiang@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1686-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17434128050.eCBD37.285735
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


--17434128050.eCBD37.285735
Date: Mon, 31 Mar 2025 11:20:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1686

            Bug ID: 1686
           Summary: [dpdk-22.11.8RC1]
                    unit_tests_cryptodev_func/cryptodev_aesni_gcm_autotest
                    : test failing-Segmentation fault
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

[Environment]
DPDK version:=20=20
commit 684d996a201182b5335012055df33284e753d832 (tag: v22.11.8-rc1,
origin/22.11)
Author: Luca Boccassi <luca.boccassi@gmail.com>
Date:   Wed Mar 26 11:26:26 2025 +0000    version: 22.11.8-rc1=20=20=20
Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
OS:  Ubuntu 18.04.5 LTS/5.4.0-150-generic
Compiler:  gcc version 7.5.0
Hardware platform:  Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
intel-ipsec-mb: tag v1.5

[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1, Build dpdk

rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib  --default-library=3Dstatic x86_64-native-lin=
uxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2, Run unit tests: cryptodev_aesni_gcm_autotest cryptodev_aesni_mb_autotest
cryptodev_openssl_autotest

x86_64-native-linuxapp-gcc/app/test/dpdk-test -c 0xff --vdev=3Dcrypto_aesni=
_mb
--vdev=3Dcrypto_aesni_gcm --vdev=3Dcrypto_openssl
RTE>>cryptodev_aesni_gcm_autotest=20

[Actual Result]:
 root@dpdk-yaobing-purely147:~/dpdk#
x86_64-native-linuxapp-gcc/app/test/dpdk-test -c 0xff --vdev=3Dcrypto_aesni=
_mb
--vdev=3Dcrypto_aesni_gcm --vdev=3Dcrypto_openssl -a 0000:00:00.0
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
CRYPTODEV: Creating cryptodev crypto_aesni_mb
CRYPTODEV: Initialisation parameters - name: crypto_aesni_mb,socket id: 0, =
max
queue pairs: 8
ipsec_mb_create() line 169: IPSec Multi-buffer library version used:
1.5.0CRYPTODEV: Creating cryptodev crypto_aesni_gcm
CRYPTODEV: Initialisation parameters - name: crypto_aesni_gcm,socket id: 0,=
 max
queue pairs: 8
ipsec_mb_create() line 169: IPSec Multi-buffer library version used:
1.5.0CRYPTODEV: Creating cryptodev crypto_openssl
CRYPTODEV: Initialisation parameters - name: crypto_openssl,socket id: 0, m=
ax
queue pairs: 8
APP: HPET is not enabled, using TSC as default timer
RTE>>cryptodev_aesni_gcm_autotest
 + TestCase [55] : test_AES_GCM_authenticated_decryption_oop_test_case_1
succeeded
aad: at [0x17d9e3700], len=3D8
00000000: FE ED FA CE DE AD BE EF                         | ........
iv: at [0x17d5275f8], len=3D12
00000000: CA FE BA BE FA CE DB AD DE CA F8 88             | ............
plaintext: at [0x17d9e3710], len=3D60
00000000: D9 31 32 25 F8 84 06 E5 A5 59 09 C5 AF F5 26 9A | .12%.....Y....&.
00000010: 86 A7 A9 53 15 34 F7 DA 2E 4C 30 3D 8A 31 8A 72 | ...S.4...L0=3D.=
1.r
00000020: 1C 3C 0C 95 95 68 09 53 2F CF 0E 24 49 A6 B5 25 | .<...h.S/..$I..%
00000030: B1 6A ED F5 AA 0D E6 57 BA 63 7B 39             | .j.....W.c{9
key: at [0x7ffe52c4eb20], len=3D16
00000000: FE FF E9 92 86 65 73 1C 6D 6A 8F 94 67 30 83 08 | .....es.mj..g0..
Segmentation fault (core dumped)
root@dpdk-yaobing-purely147:~/dpdk#

[Expected Result]
Test OK

Is this issue a regression: Y
Version the regression was introduced:=20
Bad commit bb8feaacb4897e3ee4341dd838de538869d8225e (HEAD -> bb8feaacb4)
Author: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Date:   Wed Feb 26 08:16:45 2025 +0000

    test/crypto: fix check for OOP header data

    [ upstream commit 27eb74ea6e25966d3857539cb15ddd4f20f05ebe ]

    The data of the out-of-place header is never checked. Therefore,
    the faulty PMD, which overwrites this data, will not be able to
    verify that with tests. New checks to support that were added to
    the GCM OOP functions.

    Fixes: 51e202f0596f ("test/crypto: rename GCM test code")

    Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>

Stack Trace or Log
1, Revert the bad commit, unit test can work well.
2, Impact three cases:=E3=80=80
    cryptodev_aesni_gcm_autotest=20
    cryptodev_aesni_mb_autotest=20
    cryptodev_openssl_autotest

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17434128050.eCBD37.285735
Date: Mon, 31 Mar 2025 11:20:05 +0200
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
   title=3D"UNCONFIRMED - [dpdk-22.11.8RC1] unit_tests_cryptodev_func/crypt=
odev_aesni_gcm_autotest: test failing-Segmentation fault"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1686">1686</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-22.11.8RC1] unit_tests_cryptodev_func/cryptodev_aesni_g=
cm_autotest: test failing-Segmentation fault
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
          <td>cryptodev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>yux.jiang&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">[Environment]
DPDK version:=20=20
commit 684d996a201182b5335012055df33284e753d832 (tag: v22.11.8-rc1,
origin/22.11)
Author: Luca Boccassi &lt;<a href=3D"mailto:luca.boccassi&#64;gmail.com">lu=
ca.boccassi&#64;gmail.com</a>&gt;
Date:   Wed Mar 26 11:26:26 2025 +0000    version: 22.11.8-rc1=20=20=20
Signed-off-by: Luca Boccassi &lt;<a href=3D"mailto:luca.boccassi&#64;gmail.=
com">luca.boccassi&#64;gmail.com</a>&gt;
OS:  Ubuntu 18.04.5 LTS/5.4.0-150-generic
Compiler:  gcc version 7.5.0
Hardware platform:  Intel(R) Xeon(R) Platinum 8180 CPU &#64; 2.50GHz
intel-ipsec-mb: tag v1.5

[Test Setup]
Steps to reproduce
List the steps to reproduce the issue.

1, Build dpdk

rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib  --default-library=3Dstatic x86_64-native-lin=
uxapp-gcc
ninja -C x86_64-native-linuxapp-gcc

2, Run unit tests: cryptodev_aesni_gcm_autotest cryptodev_aesni_mb_autotest
cryptodev_openssl_autotest

x86_64-native-linuxapp-gcc/app/test/dpdk-test -c 0xff --vdev=3Dcrypto_aesni=
_mb
--vdev=3Dcrypto_aesni_gcm --vdev=3Dcrypto_openssl
RTE&gt;&gt;cryptodev_aesni_gcm_autotest=20

[Actual Result]:
 root&#64;dpdk-yaobing-purely147:~/dpdk#
x86_64-native-linuxapp-gcc/app/test/dpdk-test -c 0xff --vdev=3Dcrypto_aesni=
_mb
--vdev=3Dcrypto_aesni_gcm --vdev=3Dcrypto_openssl -a 0000:00:00.0
EAL: Detected CPU lcores: 112
EAL: Detected NUMA nodes: 2
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
CRYPTODEV: Creating cryptodev crypto_aesni_mb
CRYPTODEV: Initialisation parameters - name: crypto_aesni_mb,socket id: 0, =
max
queue pairs: 8
ipsec_mb_create() line 169: IPSec Multi-buffer library version used:
1.5.0CRYPTODEV: Creating cryptodev crypto_aesni_gcm
CRYPTODEV: Initialisation parameters - name: crypto_aesni_gcm,socket id: 0,=
 max
queue pairs: 8
ipsec_mb_create() line 169: IPSec Multi-buffer library version used:
1.5.0CRYPTODEV: Creating cryptodev crypto_openssl
CRYPTODEV: Initialisation parameters - name: crypto_openssl,socket id: 0, m=
ax
queue pairs: 8
APP: HPET is not enabled, using TSC as default timer
RTE&gt;&gt;cryptodev_aesni_gcm_autotest
 + TestCase [55] : test_AES_GCM_authenticated_decryption_oop_test_case_1
succeeded
aad: at [0x17d9e3700], len=3D8
00000000: FE ED FA CE DE AD BE EF                         | ........
iv: at [0x17d5275f8], len=3D12
00000000: CA FE BA BE FA CE DB AD DE CA F8 88             | ............
plaintext: at [0x17d9e3710], len=3D60
00000000: D9 31 32 25 F8 84 06 E5 A5 59 09 C5 AF F5 26 9A | .12%.....Y....&=
amp;.
00000010: 86 A7 A9 53 15 34 F7 DA 2E 4C 30 3D 8A 31 8A 72 | ...S.4...L0=3D.=
1.r
00000020: 1C 3C 0C 95 95 68 09 53 2F CF 0E 24 49 A6 B5 25 | .&lt;...h.S/..$=
I..%
00000030: B1 6A ED F5 AA 0D E6 57 BA 63 7B 39             | .j.....W.c{9
key: at [0x7ffe52c4eb20], len=3D16
00000000: FE FF E9 92 86 65 73 1C 6D 6A 8F 94 67 30 83 08 | .....es.mj..g0..
Segmentation fault (core dumped)
root&#64;dpdk-yaobing-purely147:~/dpdk#

[Expected Result]
Test OK

Is this issue a regression: Y
Version the regression was introduced:=20
Bad commit bb8feaacb4897e3ee4341dd838de538869d8225e (HEAD -&gt; bb8feaacb4)
Author: Arkadiusz Kusztal &lt;<a href=3D"mailto:arkadiuszx.kusztal&#64;inte=
l.com">arkadiuszx.kusztal&#64;intel.com</a>&gt;
Date:   Wed Feb 26 08:16:45 2025 +0000

    test/crypto: fix check for OOP header data

    [ upstream commit 27eb74ea6e25966d3857539cb15ddd4f20f05ebe ]

    The data of the out-of-place header is never checked. Therefore,
    the faulty PMD, which overwrites this data, will not be able to
    verify that with tests. New checks to support that were added to
    the GCM OOP functions.

    Fixes: 51e202f0596f (&quot;test/crypto: rename GCM test code&quot;)

    Signed-off-by: Arkadiusz Kusztal &lt;<a href=3D"mailto:arkadiuszx.kuszt=
al&#64;intel.com">arkadiuszx.kusztal&#64;intel.com</a>&gt;

Stack Trace or Log
1, Revert the bad commit, unit test can work well.
2, Impact three cases:=E3=80=80
    cryptodev_aesni_gcm_autotest=20
    cryptodev_aesni_mb_autotest=20
    cryptodev_openssl_autotest
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
?id=3D1686">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17434128050.eCBD37.285735--
