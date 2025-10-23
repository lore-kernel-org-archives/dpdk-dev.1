Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DFCCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A03B40151;
	Thu, 23 Oct 2025 18:41:41 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 793F240144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:41:40 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6B044489B6; Thu, 23 Oct 2025 18:41:40 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1806] ipsec_mb does not compile
Date: Thu, 23 Oct 2025 16:41:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 20.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1806-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1806

            Bug ID: 1806
           Summary: ipsec_mb does not compile
           Product: DPDK
           Version: 20.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Built ipsec mb library from source here:
  https://github.com/intel/intel-ipsec-mb/tree/main
and installed it for build testing

The crypto driver using that library does not build with current code.
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function
=E2=80=98aesni_mb_set_session_auth_parameters=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:173:55: error:
=E2=80=98IMB_AUTH_ZUC256_EIA3_BITLEN=E2=80=99 undeclared (first use in this=
 function); did you
mean =E2=80=98IMB_AUTH_ZUC_EIA3_BITLEN=E2=80=99?
  173 |                         sess->template_job.hash_alg =3D
IMB_AUTH_ZUC256_EIA3_BITLEN;
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
IMB_AUTH_ZUC_EIA3_BITLEN
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:173:55: note: each undeclared
identifier is reported only once for each function it appears in
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function
=E2=80=98aesni_mb_digest_appended_in_src=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:1453:34: error:
=E2=80=98IMB_AUTH_ZUC256_EIA3_BITLEN=E2=80=99 undeclared (first use in this=
 function); did you
mean =E2=80=98IMB_AUTH_ZUC_EIA3_BITLEN=E2=80=99?
 1453 |                 job->hash_alg =3D=3D IMB_AUTH_ZUC256_EIA3_BITLEN) {
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                  IMB_AUTH_ZUC_EIA3_BITLEN
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function =E2=80=98set_mb_job_=
params=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:1571:14: error:
=E2=80=98IMB_AUTH_ZUC256_EIA3_BITLEN=E2=80=99 undeclared (first use in this=
 function); did you
mean =E2=80=98IMB_AUTH_ZUC_EIA3_BITLEN=E2=80=99?
 1571 |         case IMB_AUTH_ZUC256_EIA3_BITLEN:
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |              IMB_AUTH_ZUC_EIA3_BITLEN
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c: In function =E2=80=98post_proces=
s_mb_job=E2=80=99:
../drivers/crypto/ipsec_mb/pmd_aesni_mb.c:2047:66: error:
=E2=80=98IMB_AUTH_ZUC256_EIA3_BITLEN=E2=80=99 undeclared (first use in this=
 function); did you
mean =E2=80=98IMB_AUTH_ZUC_EIA3_BITLEN=E2=80=99?
 2047 |                                                 job->hash_alg =3D=3D
IMB_AUTH_ZUC256_EIA3_BITLEN) {
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
IMB_AUTH_ZUC_EIA3_BITLEN

--=20
You are receiving this mail because:
You are the assignee for the bug.=
