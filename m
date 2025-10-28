Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F1ACCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 22:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00F644028D;
	Tue, 28 Oct 2025 23:16:05 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6526440262
 for <dev@dpdk.org>; Tue, 28 Oct 2025 23:16:03 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 71B5E201C94E; Tue, 28 Oct 2025 15:16:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71B5E201C94E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1761689762;
 bh=/kDQ05Pyp06vy3F2/LoyEQDEkY54Jx01XXud5YA1vZs=;
 h=From:To:Cc:Subject:Date:From;
 b=flTvk64C+fVA5Ox+W2GK85b6wDbgmsgk3e92DA4piHPIthbxYr9LakeNEaaht5eCE
 WWXutJv9jymgG8xz4fOgbcqVhUx2s7wCPxqKPZLr4hrr+rxU52KpaNgcKODLZHYFEc
 JiC2P8xw/kIWEMRY5Qi6mTjxsJ+0UUY+iEpcU3F4=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: thomas.monjalon@6wind.com
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] dpdk-web: update Windows roadmap
Date: Tue, 28 Oct 2025 15:15:53 -0700
Message-Id: <1761689753-23181-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

Summary of changes:

- Removed completed tasks from roadmap
- Updated status section to reflect parity between Clang and
MSVC. Also included in that section a list with all the
libraries that now get compiled on Windows.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 content/roadmap/windows.md | 106 ++++---------------------------------
 1 file changed, 10 insertions(+), 96 deletions(-)

diff --git a/content/roadmap/windows.md b/content/roadmap/windows.md
index 2c2d15a..7abaf45 100644
--- a/content/roadmap/windows.md
+++ b/content/roadmap/windows.md
@@ -13,10 +13,16 @@ or with PCAP virtual devices.
 It requires yet unsigned kernel-mode drivers to run (except mlx5).
 Only network PMDs are currently enabled.
 
-The focus is getting more of the DPDK code to compile with MSVC.
-The goal is to get parity between clang and MSVC,
-so that all code that currently compiles with clang on Windows
-can also be compiled with MSVC.
+Many of the DPDK libraries are available on Windows. These include
+log, kvargs, argparse, telemetry, eal, ptr_compress, ring, rcu,
+mempool, mbuf, net, meter, ethdev, pci, cmdline, metrics,
+hash, timer, bbdev, bitratestats, cfgfile, cryptodev, dmadev, gpudev,
+gro, gso, ip_frag, latencystats, lpm, pcapng, regexdev, mldev,
+rib, reorder, security, stack and fib.
+
+With DPDK 25.11 parity was reached between Clang and MSVC. All source
+code which previously could only be compiled on Windows using Clang
+can now also be compiled with MSVC.
 
 All development happens in the upstream:
 
@@ -39,98 +45,6 @@ This list is obviously neither complete nor guaranteed.
 {{% /notice %}}
 
 
-#### Bringing support for Microsoft Visual Studio on Windows
-
-Starting with release 23.11, integration began to formally support
-the Microsoft Visual Studio toolset.
-Patches were introduced to incrementally phase in full support
-of the core DPDK libraries, the DPDK unit tests and drivers.
-
-Continuing that effort, the following is a work plan targeting the 25.03 release.
-The plan is subject to change depending on delays and discussions
-from the review process.
-Contributions toward this plan from the community are welcome.
-
-##### Eliminate VLAs
-
-MSVC does not support Variable Length Arrays (VLAs). Therefore there is a need
-to replace VLAs with standard C arrays or alloca(). alloca() is available for
-all toolchain/platform combinations officially supported by DPDK.
-
-The series [Remove use of VLAs for Windows](https://patches.dpdk.org/project/dpdk/list/?series=34007)
-removes the use of VLAs from code built for Windows for all three toolchains.
-Since this is a large series touching many files, it's a pre-requisite for
-many subsequent changes.
-
-##### Structure Packing
-
-MSVC struct packing is not compatible with GCC. A discussion about possible
-solutions was held and as a result the series
-[Fix packing of structs when building with MSVC](https://patches.dpdk.org/project/dpdk/list/?series=34043)
-was submitted for review.
-
-This series provides a macro (__rte_packed_begin) that can be used to push
-existing pack value and sets packing to 1-byte. The existing __rte_packed
-macro is replaced with __rte_packed_end and restores the pack value prior
-to the push.
-
-Like the VLA-related change, this series is also large and is a pre-requisite
-for many subsequent changes.
-
-##### MSVC CI Pipeline
-
-The DPDK CI pipeline is fundamental to making progress with porting work for
-the MSVC toolset as it avoids regressions from being introduced. The CI
-pipeline is in place and is being relied on as work progresses. It
-automatically starts compiling additional code as it gets enabled by the
-patches that get completed.
-
-As additional libraries and tests are ported, the pipeline will also allow
-execution of the DPDK unit tests.
-
-##### MSVC Library Porting
-
-Several libraries are already compiling with MSVC: log, kvargs, telemetry,
-eal, ptr_compress, ring, meter, pci, timer and cfgfile.
-
-These are some of the libraries that will be ported for 25.03: rcu, mbuf,
-lpm, dmadev, mldev, stack and fib.
-
-Porting new libraries might be broken down into multiple-patch series to
-address & decouple different issues separately.
-
-It's important to note that some libraries (EAL is a great example) are
-pre-requisite for porting other libraries, drivers and unit tests. As
-mentioned above, the VLA and structure packing changes are pre-requisites
-as well.
-
-##### Unit Test Library Porting
-
-In addition to EAL there are several libraries required for the basic
-DPDK unit test harness.
-Multiple series will be submitted to port the appropriate libraries
-to allow the harness to be invoked.
-
-##### Unit Test Enablement
-
-Fundamental unit tests will be ported to MSVC.
-For tests that depend only on EAL this is not expected to require code change
-but is just re-enabling compilation of the tests allowing them to be built and run.
-
-##### MSVC CI Pipeline Test Enablement
-
-With initial DPDK unit tests building & passing the CI pipeline will be
-updated to run the unit tests.
-
-##### Driver Porting
-
-Candidate drivers will be selected from the set currently built with clang.
-Multiple series will be submitted (probably per-driver) with changes to port to MSVC.
-
-Nearing the 25.03 release timeframe the plan will be reviewed to
-understand and schedule porting work beyond the 25.03 release.
-
-
 #### Kernel Mode Drivers
 
 Concurrent work is in progress by Microsoft to provide functionality
-- 
2.34.1

