Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C5FC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 20:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F22F24026A;
	Wed,  8 Jul 2026 22:13:17 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 423B540265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 22:13:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 360ED4B84D; Wed,  8 Jul 2026 22:13:16 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 1966] crypto-perf application segmentation
 faults where it previously didn't
Date: Wed, 08 Jul 2026 20:13:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
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
Message-ID: <bug-1966-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1966

            Bug ID: 1966
           Summary: crypto-perf application segmentation faults where it
                    previously didn't
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: abailey@iol.unh.edu
  Target Milestone: ---

Running the dpdk-crypto-perf application with the following args creates a
segmentation fault. I am testing on an Intel QAT 8970 on an aarch64 system =
with
a single virtual function bound to vfio-pci. To the best of my knowledge, t=
his
was not seen in testing prior to the merge of 26.07-rc2.

sudo ./dpdk-test-crypto-perf=20
-l 1-2=20
-n 4=20
--file-prefix=3Ddpdk_1_20260708200005=20
-a 0000:03:01.0=20
--=20
--aead-aad-sz=3D16=20
--aead-algo=3Daes-gcm=20
--aead-iv-sz=3D12=20
--aead-key-sz=3D16=20
--aead-op=3Dencrypt=20
--buffer-sz=3D64,512,2048=20
--devtype=3Dcrypto_qat=20
--digest-sz=3D16=20
--optype=3Daead=20
--ptest=3Dthroughput=20
--silent=20
--total-ops=3D10000000'

' returned a non-zero exit code: 139
16:00:57  Stderr: EAL: Detected CPU lcores: 160
16:00:57  EAL: Detected NUMA nodes: 2
16:00:57  EAL: Detected static linkage of DPDK
16:00:57  EAL: Multi-process socket
/var/run/dpdk/dpdk_1_20260708200005/mp_socket
16:00:57  EAL: Selected IOVA mode 'PA'
16:00:57  EAL: VFIO support initialized
16:00:57  EAL: Using IOMMU type 1 (Type 1)
16:00:57  CRYPTODEV: Creating cryptodev 0000:03:01.0_qat_asym
16:00:57  CRYPTODEV: Initialisation parameters - name:
0000:03:01.0_qat_asym,socket id: 0, max queue pairs: 0
16:00:57  CRYPTODEV: Creating cryptodev 0000:03:01.0_qat_sym
16:00:57  CRYPTODEV: Initialisation parameters - name:
0000:03:01.0_qat_sym,socket id: 0, max queue pairs: 0
16:00:57  Segmentation fault (core dumped)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
