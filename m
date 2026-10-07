Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6207CA6004
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 20:38:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8FE140268;
	Wed,  7 Oct 2026 22:38:34 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 76C7C40265
 for <dev@dpdk.org>; Wed,  7 Oct 2026 22:38:33 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id CE3424BFA2; Wed,  7 Oct 2026 22:38:32 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 2050] ninja compile failure for arm
Date: Wed, 07 Oct 2026 20:38:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abailey@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2050-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2050

            Bug ID: 2050
           Summary: ninja compile failure for arm
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: abailey@iol.unh.edu
  Target Milestone: ---

Compiling dpdk on dpdk-next-crypto main branch yields a compile error on arm
systems. I believe This is due to the supported version of ipsec mb library=
 in
DPDK being v2.0.0 while the latest version available on arm is 1.5.0. The a=
rm
fork of ipsec mb can be found here:=20
  * https://gitlab.arm.com/arm-reference-solutions/ipsec-mb/-/tree/main/

The build commands to produce this error are:

"meson setup --default-library=3Dstatic -Dlibdir=3Dlib /tmp/dts.9zK3U/dpdk
/tmp/dts.9zK3U/dpdk/aarch64-linux-gcc"

"ninja -C /tmp/dts.9zK3U/dpdk/aarch64-linux-gcc"

Yields error:

[2747/3503] Compiling C object
drivers/libtmp_rte_crypto_ipsec_mb.a.p/crypto_ipsec_mb_pmd_aesni_mb.c.o
FAILED: drivers/libtmp_rte_crypto_ipsec_mb.a.p/crypto_ipsec_mb_pmd_aesni_mb=
.c.o=20
ccache gcc -Idrivers/libtmp_rte_crypto_ipsec_mb.a.p -Idrivers -I../drivers
-Idrivers/crypto/ipsec_mb -I../drivers/crypto/ipsec_mb -Ilib/cryptodev
-I../lib/cryptodev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig
-I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include
-I../lib/eal/linux/include -Ilib/eal/arm/include -I../lib/eal/arm/include
-I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib=
/log
-I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/teleme=
try
-Ilib/argparse -I../lib/argparse -Ilib/mbuf -I../lib/mbuf -Ilib/mempool
-I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/rcu -I../lib/rcu
-Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/net -I../lib/net -Ilib/secur=
ity
-I../lib/security -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wa=
ll
-Winvalid-pch -Wextra -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual
-Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs
-Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare
-Wstrict-prototypes -Wundef -Wwrite-strings -Wno-packed-not-aligned
-Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -mcpu=3Dneoverse-n1
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-Wno-address-of-packed-member -Wno-vla -DRTE_COMPONENT_CLASS=3Dpmd_crypto
-DRTE_COMPONENT_NAME=3Dipsec_mb -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.crypto.ipse=
c_mb -MD
-MQ drivers/libtmp_rte_crypto_ipsec_mb.a.p/crypto_ipsec_mb_pmd_aesni_mb.c.o=
 -MF
drivers/libtmp_rte_crypto_ipsec_mb.a.p/crypto_ipsec_mb_pmd_aesni_mb.c.o.d -o
drivers/libtmp_rte_crypto_ipsec_mb.a.p/crypto_ipsec_mb_pmd_aesni_mb.c.o -c
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function =E2=80=98is_aead_alg=
o=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32: error: =E2=80=98IMB_CIPHER=
_SM4_GCM=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98IMB_CIPHER_S=
M4_ECB=E2=80=99?
   24 |                 cipher_mode =3D=3D IMB_CIPHER_SM4_GCM
      |                                ^~~~~~~~~~~~~~~~~~
      |                                IMB_CIPHER_SM4_ECB
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32: note: each undeclared
identifier is reported only once for each function it appears in
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function
=E2=80=98aesni_mb_set_session_aead_parameters=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:716:50: error: =E2=80=98IMB_CIPHE=
R_SM4_GCM=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98IMB_CIPHER_S=
M4_ECB=E2=80=99?
  716 |                 sess->template_job.cipher_mode =3D IMB_CIPHER_SM4_G=
CM;
      |                                                  ^~~~~~~~~~~~~~~~~~
      |                                                  IMB_CIPHER_SM4_ECB
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:717:47: error: =E2=80=98IMB_AUTH_=
SM4_GCM=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98IMB_AUTH_AES=
_CCM=E2=80=99?
  717 |                 sess->template_job.hash_alg =3D IMB_AUTH_SM4_GCM;
      |                                               ^~~~~~~~~~~~~~~~
      |                                               IMB_AUTH_AES_CCM
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:725:17: warning: implicit declara=
tion
of function =E2=80=98imb_sm4_gcm_pre=E2=80=99 [-Wimplicit-function-declarat=
ion]
  725 |                 imb_sm4_gcm_pre(mb_mgr, xform->aead.key.data,
&sess->cipher.gcm_key);
      |                 ^~~~~~~~~~~~~~~
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:725:17: warning: nested extern
declaration of =E2=80=98imb_sm4_gcm_pre=E2=80=99 [-Wnested-externs]
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function =E2=80=98set_cpu_mb_=
job_params=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:1055:14: error: =E2=80=98IMB_AUTH=
_SM4_GCM=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98IMB_AUTH_AES=
_CCM=E2=80=99?
 1055 |         case IMB_AUTH_SM4_GCM:
      |              ^~~~~~~~~~~~~~~~
      |              IMB_AUTH_AES_CCM
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function =E2=80=98set_mb_job_=
params=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:1607:14: error: =E2=80=98IMB_AUTH=
_SM4_GCM=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98IMB_AUTH_AES=
_CCM=E2=80=99?
 1607 |         case IMB_AUTH_SM4_GCM:
      |              ^~~~~~~~~~~~~~~~
      |              IMB_AUTH_AES_CCM
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:1798:14: error: =E2=80=98IMB_CIPH=
ER_SM4_GCM=E2=80=99
undeclared (first use in this function); did you mean =E2=80=98IMB_CIPHER_S=
M4_ECB=E2=80=99?
 1798 |         case IMB_CIPHER_SM4_GCM:
      |              ^~~~~~~~~~~~~~~~~~
      |              IMB_CIPHER_SM4_ECB
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function =E2=80=98is_aead_alg=
o=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:26:1: warning: control reaches en=
d of
non-void function [-Wreturn-type]
   26 | }
      | ^

--=20
You are receiving this mail because:
You are the assignee for the bug.=
