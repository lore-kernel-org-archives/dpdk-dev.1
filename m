Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FE710854BE
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 08:39:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08552402A0;
	Wed, 18 Mar 2026 09:39:08 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id EDF814026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 09:39:05 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D8EFF4AD35; Wed, 18 Mar 2026 09:39:05 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1903] [dpdk-26.03]cryptodev_qat_asym_autotest:
 Segmentation fault
Date: Wed, 18 Mar 2026 08:39:05 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.03
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
Message-ID: <bug-1903-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1903

            Bug ID: 1903
           Summary: [dpdk-26.03]cryptodev_qat_asym_autotest: Segmentation
                    fault
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

[DPDK 26.03RC2]

[Reproduced steps]:
1, Build dpdk

rm -rf x86_64-native-linuxapp-gcc/
CC=3Dgcc meson -Dlibdir=3Dlib  --default-library=3Dstatic x86_64-native-lin=
uxapp-gcc/
ninja -C x86_64-native-linuxapp-gcc/=20=20

2, Bind qat vf device

./usertools/dpdk-devbind.py -b vfio-pci 0000:81:00.1

3, Run cryptodev_qat_asym_autotest=20
./x86_64-native-linuxapp-gcc/app/test/dpdk-test -l 9,10 -a 0000:81:00.1
RTE>>cryptodev_qat_asym_autotest

[Logs]:
.................
 + TestCase [ 1] : ECDSA Elliptic Curve tests succeeded
 + ------------------------------------------------------- +
 + Test Suite Summary : Cryptodev ASYM ECDSA Unit Test Suite
 + ------------------------------------------------------- +
 + Tests Total :        2
 + Tests Skipped :      0
 + Tests Executed :     2
 + Tests Unsupported:   0
 + Tests Passed :       1
 + Tests Failed :       1
 + ------------------------------------------------------- +
 + ------------------------------------------------------- +
 + Test Suite : Cryptodev ASYM ECPM Unit Test Suite
 + ------------------------------------------------------- +
Segmentation fault

[Bad commit]
commit 064ef1b098d1827d62a053d5424db9a1b10b5029 (HEAD -> 2-064ef1b098)
Author: Rupesh Chiluka <rchiluka@marvell.com>
Date:   Tue Dec 30 14:33:26 2025 +0530

    test/crypto: remove PMD-specific asym test suites

    Change PMD specific asymmetric testsuites to
    capabilities based testsuites.

    Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
    Acked-by: Akhil Goyal <gakhil@marvell.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
