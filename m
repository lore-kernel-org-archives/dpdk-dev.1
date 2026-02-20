Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519EC531E4
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:12:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92A024027B;
	Fri, 20 Feb 2026 05:12:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3E96840276
 for <dev@dpdk.org>; Fri, 20 Feb 2026 05:12:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771560739; x=1803096739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oHm9nvbq429wQCbEyhgNfgTX/BMjXJBi/y0MQt0SEEo=;
 b=UKS0woLzKUvWpp/tJ4/21mIi/WbN2BeonblFhiuNCnkm/TRxPbgxb5v+
 1AqxxrOnX5fk8P0HKZ+NBQ3w+CCAnGG0qnE9BiiMuBN9Uak6vVijPSIbB
 TDZd5C9eG7jFMMtXjiViWNnowicfM2f5Yy+zBqXo7hxYg5Cew/2YzK5jO
 7Nr5xBUr2MRHpGjr+6xAZW+I9B3WOlQR+j6J0v096K55sp+8AWf/U8eqm
 nfr9m9FAXFYfAWm3ykq7ueJ0MoXZF/jJVUEeFsVgMRPllyDlHj/gQp4DA
 tdI/berrbY7+gA5QijR7svmkHvnGtTZmtYEPbbg7oVXm73qAxkgvb4qj4 w==;
X-CSE-ConnectionGUID: C3TTR8nwQECB8iHp2iipeQ==
X-CSE-MsgGUID: 1/RYrNalRQOtEeCm3gJq9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="71679993"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="71679993"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 20:12:18 -0800
X-CSE-ConnectionGUID: 7uIMkyWLT3eCBVkJgx5Y4w==
X-CSE-MsgGUID: kBfFdqtDTr+Gm409V55plQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="213853297"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by orviesa006.jf.intel.com with ESMTP; 19 Feb 2026 20:12:16 -0800
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH v2] doc: improve e1000 driver documentation
Date: Fri, 20 Feb 2026 14:30:21 +0000
Message-ID: <20260220143023.2337552-1-chaitanyababux.talluri@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
References: <20260216195533.2030568-1-chaitanyababux.talluri@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Update e1000 driver docs to cover all Intel 1G devices,
including emulated e1000 and real hardware.

v2: Addressed review comments.

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---
 doc/guides/nics/e1000em.rst | 47 +++++++------------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
index b2e09cd673..c0fc4fe685 100644
--- a/doc/guides/nics/e1000em.rst
+++ b/doc/guides/nics/e1000em.rst
@@ -1,52 +1,21 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
-Intel 1G Network Drivers (e1000, igb, igc)
-==========================================
+E1000 Poll Mode Driver
+======================
 
 Overview
 --------
 
-DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit
-Ethernet controller families. These include:
+DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit ethernet controller families.
+These include:
 
-*   e1000 – Intel 8254x family devices, including QEMU e1000 emulation.
-*   e1000e – Intel PRO/1000 PCI‑Express family (82563/6/7, 82571/2/3/4/7/8/9,
-             82583 and I217/I218/I219-based adapters).
+*   e1000 – Intel 8254x family devices, including QEMU ``e1000`` emulation.
+*   e1000e – Intel PRO/1000 PCI‑Express family (82563/6/7, 82571/2/3/4/7/8/9, 82583 and I217/I218/I219-based adapters).
 
-These drivers follow similar design principles and capabilities and are grouped
-here for clarity.
+.. note::
 
-Supported Hardware
-------------------
-
-E1000 Devices
-~~~~~~~~~~~~~
-
-The e1000 Linux base driver supports the Intel® PRO/1000 PCI and PCI‑X
-family of Gigabit Ethernet controllers. Supported devices include:
-
-*   Intel 82540, 82541, 82545, 82546
-*   QEMU ``e1000`` emulated NIC
-
-E1000e Devices
-~~~~~~~~~~~~~~
-
-The e1000e Linux base driver supports the Intel PRO/1000 PCI‑Express family
-including:
-
-*   82563/82566/82567 series
-*   82571/82572/82573/82574/82577/82578/82579 series
-*   82583-based adapters
-*   I217, I218 and I219 Gigabit Network Connections
-
-Driver Notes
-~~~~~~~~~~~~
-
-*   e1000 – supports PCI/PCI‑X Gigabit adapters.
-*   e1000e – supports PCI‑Express Gigabit adapters.
-
-Both drivers are widely used across physical and virtualized environments.
+   The ``igb`` and ``igc`` PMDs are built from the same driver binary but are documented in separate sections for clarity.
 
 Driver for VM Emulated Devices
 ==============================
-- 
2.43.0

