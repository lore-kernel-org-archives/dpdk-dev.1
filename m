Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A065C36000
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Mar 2025 17:37:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59CEC40E11;
	Fri, 21 Mar 2025 18:37:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2512E40276
 for <dev@dpdk.org>; Fri, 21 Mar 2025 18:37:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742578632; x=1774114632;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xQ3Nv6Iluf8/QeMaBicQh6ytUOfPvOmp47bA3QmY20s=;
 b=KrBky2EleMeJ/BGK2WLB4kQghGAhCNP50hCW/CCS3PqRGTnSBcnfVLfJ
 LDMZsoB7VA7bJoPrkpOUzu2p+/1iottMEDYAbaOlWA+6btPA4jB1Pgmdk
 +1Ny12OkIqW6eRiouZCG0CpN41GSe2VfFJTaOUwYZiu7o1N7ExVbkCx/0
 U9mAHIVhjLQzVLl2+tCdGhxTHFwPgrd7a7z8R70J93Ai0JfBtrdIXuu34
 77x1b7lSexiZQV378tzwxHWrJNwFrxX1FgO+3TkfIZHf1r1Crz68h+Gpo
 IKI5A59ZNtnn46QzZtofYa4+JDN2DJMk/n2OPan+4tMdKJtq7JykwdTUY Q==;
X-CSE-ConnectionGUID: zFVFict+S6qoN7oOX4U6YA==
X-CSE-MsgGUID: ZopL78W4Tfu3CJe03CKY/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54847714"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; d="scan'208";a="54847714"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 10:37:11 -0700
X-CSE-ConnectionGUID: 1YUi2s8TR0SQ0sc/6JxgyA==
X-CSE-MsgGUID: SiJibFm8Q9mhkqnIsFR9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; d="scan'208";a="123634339"
Received: from unknown (HELO silpixa00401176.ir.intel.com) ([10.243.23.51])
 by fmviesa008.fm.intel.com with ESMTP; 21 Mar 2025 10:34:39 -0700
From: John McNamara <john.mcnamara@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net,
	John McNamara <john.mcnamara@intel.com>
Subject: [PATCH v1] doc: update release notes for 25.03
Date: Fri, 21 Mar 2025 17:34:30 +0000
Message-ID: <20250321173435.1335993-1-john.mcnamara@intel.com>
X-Mailer: git-send-email 2.43.0
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

Fix grammar, spelling and formatting of DPDK 25.03 release notes

Signed-off-by: John McNamara <john.mcnamara@intel.com>
---
 doc/guides/rel_notes/release_25_03.rst | 32 +++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index caadd05d00..14fcb9fef6 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -57,13 +57,13 @@ New Features
 
 * **Added Staged-Ordered-Ring (SORING) API to the ring library.**
 
-  New API was added to the ring library to provide a SW abstraction
+  Added new API to the ring library to provide a software abstraction
   for ordered queues with multiple processing stages.
-  It is based on conventional DPDK rte_ring, re-uses many of its concepts,
-  and even substantial part of its code.
-  It can be viewed as an extension of rte_ring functionality.
+  It is based on the conventional DPDK ``rte_ring`` and re-uses many of its concepts,
+  including substantial part of its code.
+  It can be viewed as an extension of ``rte_ring`` functionality.
 
-* **Hardened of more allocation functions.**
+* **Hardened more allocation functions.**
 
   Added allocation attributes to functions that allocate data:
 
@@ -89,12 +89,12 @@ New Features
 
   This can catch some obvious bugs at compile time (with GCC 11.0 or later).
   For example, calling ``free`` on a pointer that was allocated with one
-  of those functions (and vice versa); freeing the same pointer twice
+  of those functions (and vice versa), freeing the same pointer twice
   in the same routine or freeing an object that was not created by allocation.
 
 * **Updated af_packet net driver.**
 
-  * Added ability to option to configure receive packet fanout mode.
+  * Added ability to configure receive packet fanout mode.
   * Added statistics for failed buffer allocation and missed packets.
 
 * **Updated Amazon ENA (Elastic Network Adapter) net driver.**
@@ -129,7 +129,7 @@ New Features
 * **Updated NVIDIA mlx5 driver.**
 
   * Added support for NVIDIA ConnectX-8 adapters.
-  * Optimized port probing in large scale.
+  * Optimized large scale port probing.
     This feature enhances the efficiency of probing VF/SFs on a large scale
     by significantly reducing the probing time.
 
@@ -157,15 +157,15 @@ New Features
 
   Added network driver for the Yunsilicon metaScale serials NICs.
 
-* **Updated vhost library.**
+* **Updated vhost library for RSA crypto.**
 
   Updated vhost library to support RSA crypto operations.
 
-* **Updated virtio crypto driver.**
+* **Updated virtio crypto driver for RSA crypto.**
 
   * Added support for RSA crypto operations.
 
-* **Updated IPsec_MB crypto driver.**
+* **Updated IPsec_MB crypto driver for SM4 GCM .**
 
   * Added support for the SM4 GCM algorithm.
 
@@ -179,8 +179,8 @@ New Features
 * **Added atomic tests to the eventdev test application.**
 
   Added two atomic tests: ``atomic_queue`` and ``atomic_atq``.
-  They work in the same way as the corresponding ordered tests
-  but exclusively use atomic queues.
+  These work in the same way as the corresponding ordered tests
+  but use atomic queues exclusively.
   Atomicity is verified using spinlocks.
 
 
@@ -233,12 +233,12 @@ API Changes
   cpfl, e1000, fm10k, i40e, iavf, ice, idpf, ipn3ke and ixgbe,
   have been moved from ``drivers/net`` to a new ``drivers/net/intel`` directory.
   The resulting build output, including the driver filenames, is the same,
-  but to enable/disable these drivers via Meson option requires use of the new paths.
+  but to enable/disable these drivers via Meson option requires the use of the new paths.
   For example, ``-Denable_drivers=/net/i40e`` becomes ``-Denable_drivers=/net/intel/i40e``.
 
-* build: The Intel IGC networking driver was merged with e1000 driver
+* build: The Intel IGC networking driver was merged with the e1000 driver
   and is no longer provided as a separate driver.
-  The resulting build output will not have the ``librte_net_igc.*`` driver files any more,
+  The resulting build output will no longer have the ``librte_net_igc.*`` driver files,
   but the ``librte_net_e1000.*`` driver files will provide support
   for all of the devices and features of the old driver.
   In addition, to enable/disable the driver via Meson option,
-- 
2.43.0

