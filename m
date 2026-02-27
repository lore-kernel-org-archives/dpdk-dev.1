Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338D9FD9E1C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 05:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45F8C402C6;
	Fri, 27 Feb 2026 06:08:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E53B34028E
 for <dev@dpdk.org>; Fri, 27 Feb 2026 06:08:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772168894; x=1803704894;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MN8oh4/61yC+THvYVuNpflqxkCV5f859BoWIIfC7Sto=;
 b=fWV6nT9ozPBFAKCseepKGJbzMMK9HmmLghMuGg6Qaj0+1cyraJITL9ht
 Z5ck4C+BP0P/sjt1x9509GCmX28u41JzvI3O+CNmVsiUinGGMoPXikaWo
 LgC+254wZauLFl8kdIqm0Cck3IrBWVZivO89jQKci79UYo5KHgiTxiKU6
 GXAkVxtOjxKaUikhKM4rcoQheihKpmFTCbCNcXIfwS5IvsTX6OnawcJIv
 WlQmC1GICwhD4oFreJeO2Kk9WncMTrRHarPmoAz8tm6z9HzIYjOfMzrHj
 jTj9Wds26UGChjRau9Eq5VJcDfDDB+WvQ+EJn/J2OTcjqd2NfdgQXt1Qo Q==;
X-CSE-ConnectionGUID: bpuWZPgrRrydjP0u7/lvug==
X-CSE-MsgGUID: dOVcFIFSSkGG5Pr9t6wbVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73313147"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="73313147"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 21:08:11 -0800
X-CSE-ConnectionGUID: j+9WYbf8TrOsSgtFg05ozA==
X-CSE-MsgGUID: JEMJCzVPRyKJKgN6gfnquw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="215915029"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by orviesa006.jf.intel.com with ESMTP; 26 Feb 2026 21:08:10 -0800
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH v3] doc: improve e1000 driver documentation
Date: Fri, 27 Feb 2026 15:26:58 +0000
Message-ID: <20260227152700.16762-1-chaitanyababux.talluri@intel.com>
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

Add an overview of the e1000 driver for Intel 1G devices.

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---
v3:
* Fixed RST structure, single top-level title.
* Used ASCII "PCIe".
* Adjusted commit message to match content.

v2: Addressed review comments.
---
 doc/guides/nics/e1000em.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
index ed4f57e9c6..95ff68cb9b 100644
--- a/doc/guides/nics/e1000em.rst
+++ b/doc/guides/nics/e1000em.rst
@@ -1,9 +1,22 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright(c) 2010-2014 Intel Corporation.
+    Copyright(c) 2010-2026 Intel Corporation.
 
 Driver for VM Emulated Devices
 ==============================
 
+E1000 Poll Mode Driver
+----------------------
+
+DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit ethernet controller families.
+These include:
+
+*   e1000 – Intel 8254x family devices, including QEMU ``e1000`` emulation.
+*   e1000e – Intel PRO/1000 PCIe family.
+
+.. note::
+
+   The ``igb`` and ``igc`` PMDs are built from the same driver binary but are documented in separate sections for clarity.
+
 The DPDK EM poll mode driver supports the following emulated devices:
 
 *   qemu-kvm emulated Intel® 82540EM Gigabit Ethernet Controller (qemu e1000 device)
-- 
2.43.0

