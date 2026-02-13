Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1D9EDF170
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 15:23:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3BDB40655;
	Fri, 13 Feb 2026 16:22:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id B997540647
 for <dev@dpdk.org>; Fri, 13 Feb 2026 16:22:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770996168; x=1802532168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Trrg/DTfE3ouqyk5ft3QvX0WiUZLWFBcdxDIy9TbGvI=;
 b=Cmt9AsFLew+B2JC4U27dZdHBu1Ac8gOkReQqfhiscgPposPq9/Jmu8pk
 Y2S2TzilkPIRsIhSnbLBOJDTBXu9V+bMjNzq9AG8TqkRniJI6t2y+JDwF
 QxyBXC2gPGaywy53AkUL0KQFRh39Nsq9lPvm9MU7keSU0L3jT6rV3oPbZ
 ICj32rDZcskMp+M+U0T6Cyx7oInC6IQQa1NKsgYKxMOiEI2MWNbIOxJ3P
 rOB+Cy8p9hCeVfUOUFUPBk7tJQiyYdgv45xj5fCYKO2mq+MCFviPmuo8U
 Sn8e0w1Tsqrgv6c8ZwvrMEgOSc/HAoLfT5EjTPue8faMTf/apU0luzDsW w==;
X-CSE-ConnectionGUID: DmIma9BGT1W2l0pylhA/Dg==
X-CSE-MsgGUID: Iq7JNhmiQm61kBSsaIWasQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="75803798"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="75803798"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 07:22:47 -0800
X-CSE-ConnectionGUID: jhzZ9mceTzeNu1L7/2GBCA==
X-CSE-MsgGUID: tIxQW5UcR+uWm/Wz8D3J7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217094211"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 07:22:47 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] test/eal_flags: remove PCI probing for recursive calls
Date: Fri, 13 Feb 2026 15:22:26 +0000
Message-ID: <20260213152227.879170-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213152227.879170-1-bruce.richardson@intel.com>
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
 <20260213152227.879170-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When creating another primary process as part of EAL flag testing, avoid
unexpected side-effects due to the HW being used by disabling PCI
probing at process startup.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_flags.c | 67 ++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 83e906a069..bebddf1c98 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -121,6 +121,7 @@ test_misc_flags(void)
 #define no_shconf "--no-shconf"
 #define allow "--allow"
 #define vdev "--vdev"
+#define no_pci "--no-pci"
 #define eal_debug_logs "--log-level=lib.eal:debug"
 #define bus_debug_logs "--log-level=bus.*:debug"
 
@@ -930,28 +931,28 @@ test_misc_flags(void)
 	const char *argv5[] = {prgname, prefix, mp_flag, eal_debug_logs, "--syslog=invalid"};
 
 	/* With no-sh-conf, also use no-huge to ensure this test runs on BSD */
-	const char *argv6[] = {prgname, eal_debug_logs, "-m", DEFAULT_MEM_SIZE,
+	const char *argv6[] = {prgname, eal_debug_logs, no_pci, "-m", DEFAULT_MEM_SIZE,
 			no_shconf, nosh_prefix, no_huge};
 
 	/* With --huge-dir */
 	const char *argv7[] = {prgname, "-m", DEFAULT_MEM_SIZE,
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", hugepath};
 	/* With empty --huge-dir (should fail) */
 	const char *argv8[] = {prgname, "-m", DEFAULT_MEM_SIZE,
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir"};
 	/* With invalid --huge-dir */
 	const char *argv9[] = {prgname, "-m", DEFAULT_MEM_SIZE,
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", "invalid"};
 	/* With invalid --huge-dir sub-directory */
 	const char *argv10[] = {prgname, "-m", DEFAULT_MEM_SIZE,
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", hugepath_dir};
 	/* With valid --huge-dir sub-directory */
 	const char *argv11[] = {prgname, "-m", DEFAULT_MEM_SIZE,
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", hugepath_dir2};
 	/* Secondary process with invalid --huge-dir (should run as flag has no
 	 * effect on secondary processes) */
@@ -960,41 +961,41 @@ test_misc_flags(void)
 
 	/* try running with base-virtaddr param */
 	const char *argv13[] = {prgname, "--file-prefix=virtaddr",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--base-virtaddr=0x23456789"};
 
 	/* try running with --vfio-intr INTx flag */
 	const char *argv14[] = {prgname, "--file-prefix=intr",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--vfio-intr=legacy"};
 
 	/* try running with --vfio-intr MSI flag */
 	const char *argv15[] = {prgname, "--file-prefix=intr",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--vfio-intr=msi"};
 
 	/* try running with --vfio-intr MSI-X flag */
 	const char *argv16[] = {prgname, "--file-prefix=intr",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--vfio-intr=msix"};
 
 	/* try running with --vfio-intr invalid flag */
 	const char *argv17[] = {prgname, "--file-prefix=intr",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--vfio-intr=invalid"};
 
 	/* With process type as auto-detect */
 	const char * const argv18[] = {prgname, "--file-prefix=auto",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--proc-type=auto"};
 
 	/* With process type as auto-detect with no-shconf */
-	const char * const argv19[] = {prgname, "--proc-type=auto", eal_debug_logs,
+	const char * const argv19[] = {prgname, "--proc-type=auto", eal_debug_logs, no_pci,
 			no_shconf, nosh_prefix, no_huge};
 
 	/* With process type as --create-uio-dev flag */
 	const char * const argv20[] = {prgname, "--file-prefix=uiodev",
-			eal_debug_logs,
+			eal_debug_logs, no_pci,
 			"--create-uio-dev"};
 
 	/* Try running with --huge-worker-stack flag */
@@ -1227,43 +1228,43 @@ test_file_prefix(void)
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest };
 
 	/* primary process with memtest1 and default mem mode */
-	const char *argv1[] = {prgname, eal_debug_logs, "-m",
+	const char *argv1[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest1 };
 
 	/* primary process with memtest1 and legacy mem mode */
-	const char *argv2[] = {prgname, eal_debug_logs, "-m",
+	const char *argv2[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest1,
 			"--legacy-mem" };
 
 	/* primary process with memtest2 and legacy mem mode */
-	const char *argv3[] = {prgname, eal_debug_logs, "-m",
+	const char *argv3[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest2,
 			"--legacy-mem" };
 
 	/* primary process with memtest2 and default mem mode */
-	const char *argv4[] = {prgname, eal_debug_logs, "-m",
+	const char *argv4[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest2 };
 
 	/* primary process with --in-memory mode */
-	const char * const argv5[] = {prgname, eal_debug_logs, "-m",
+	const char * const argv5[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--in-memory" };
 
 	/* primary process with memtest1 and --in-memory mode */
-	const char * const argv6[] = {prgname, eal_debug_logs, "-m",
+	const char * const argv6[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--in-memory",
 		"--file-prefix=" memtest1 };
 
 	/* primary process with parent file-prefix and --in-memory mode */
-	const char * const argv7[] = {prgname, eal_debug_logs, "-m",
+	const char * const argv7[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--in-memory", "--file-prefix", prefix };
 
 	/* primary process with memtest1 and --single-file-segments mode */
-	const char * const argv8[] = {prgname, eal_debug_logs, "-m",
+	const char * const argv8[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--single-file-segments",
 		"--file-prefix=" memtest1 };
 
 	/* primary process with memtest1 and --huge-unlink=never mode */
-	const char * const argv9[] = {prgname, eal_debug_logs, "-m",
+	const char * const argv9[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--huge-unlink=never",
 		"--file-prefix=" memtest1 };
 
@@ -1518,41 +1519,41 @@ test_memory_flags(void)
 			"-m", DEFAULT_MEM_SIZE};
 
 	/* valid -m flag */
-	const char *argv1[] = {prgname, eal_debug_logs,
+	const char *argv1[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, "-m", DEFAULT_MEM_SIZE};
 
 	/* valid (zero) --socket-mem flag */
 	char arg2_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv2[] = {prgname, eal_debug_logs,
+	const char *argv2[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg2_socket_mem};
 
 	/* invalid (incomplete) --socket-mem flag */
 	char arg3_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv3[] = {prgname, eal_debug_logs,
+	const char *argv3[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg3_socket_mem};
 
 	/* invalid (mixed with invalid data) --socket-mem flag */
 	char arg4_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv4[] = {prgname, eal_debug_logs,
+	const char *argv4[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg4_socket_mem};
 
 	/* invalid (with numeric value as last character) --socket-mem flag */
 	char arg5_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv5[] = {prgname, eal_debug_logs,
+	const char *argv5[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg5_socket_mem};
 
 	/* invalid (with empty socket) --socket-mem flag */
 	char arg6_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv6[] = {prgname, eal_debug_logs,
+	const char *argv6[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg6_socket_mem};
 
 	/* invalid (null) --socket-mem flag */
-	const char *argv7[] = {prgname, eal_debug_logs,
+	const char *argv7[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, "--socket-mem="};
 
 	/* valid --socket-mem specified together with -m flag */
 	char arg8_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv8[] = {prgname, eal_debug_logs,
+	const char *argv8[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, "-m", DEFAULT_MEM_SIZE,
 			arg8_socket_mem};
 
@@ -1570,12 +1571,12 @@ test_memory_flags(void)
 
 	/* invalid --socket-mem flag (with extra socket) */
 	char invalid_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv9[] = {prgname, eal_debug_logs,
+	const char *argv9[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, invalid_socket_mem};
 
 	/* valid --socket-mem flag */
 	char valid_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv10[] = {prgname, eal_debug_logs,
+	const char *argv10[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, valid_socket_mem};
 
 	if (launch_proc(argv0) != 0) {
-- 
2.51.0

