Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D0C55197
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:57:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85BB5402D8;
	Fri, 20 Feb 2026 11:57:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0134F4027B
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771585029; x=1803121029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tExvDrBddYPqCedNn+/n91a182mrcfNiQ4EXCyBp/jY=;
 b=OpmrBwI2OEHGNn4410+GlNCNBT3GBRFo0uqW3IJAE7x4fJdJsA0Dfb02
 K+NQ2S7lef2k90FLKED7QJAks60gmDks4V4qWRQ9GTCAvOtUxVY84SAtz
 iYaS0dbXYAlSHTkFUgUv1y6YWExiB9vg4XvUcJ7ufvHqrumSn7vyvNc7K
 hI+Bi7sKJVGKZMimiwE+apslPNUJbS2Su7UMPlsV7D6jYiQ3fO+E9U7bl
 MTrdtEE418p9qeverZd8o52SfmmdkLimreyJHAMUWZJr868pCQu5ntU33
 co3J4tUOQ6Bk2FnQpGm9oaS5zIKeqUtY5393I/Rrmd+0nAgMkGMcXf6EN Q==;
X-CSE-ConnectionGUID: XYA6ZOr/TQun/kNQYxPGCw==
X-CSE-MsgGUID: sEiVGeQcQqe46/ytZFNBdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76540309"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="76540309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:57:08 -0800
X-CSE-ConnectionGUID: dz9Fp65mQo6USJuqnKA8Vg==
X-CSE-MsgGUID: DVAqkuDcQke1+LvYEnRGkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="243300486"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by fmviesa001.fm.intel.com with ESMTP; 20 Feb 2026 02:57:06 -0800
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH v3] doc: improve e1000 driver documentation
Date: Fri, 20 Feb 2026 21:15:13 +0000
Message-ID: <20260220211514.2616852-1-chaitanyababux.talluri@intel.com>
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

v3: Resolved apply patch failure.

Signed-off-by: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
---
 doc/guides/nics/e1000em.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/guides/nics/e1000em.rst b/doc/guides/nics/e1000em.rst
index ed4f57e9c6..c0fc4fe685 100644
--- a/doc/guides/nics/e1000em.rst
+++ b/doc/guides/nics/e1000em.rst
@@ -1,6 +1,22 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2010-2014 Intel Corporation.
 
+E1000 Poll Mode Driver
+======================
+
+Overview
+--------
+
+DPDK provides several poll mode drivers (PMDs) supporting Intel 1 Gigabit ethernet controller families.
+These include:
+
+*   e1000 – Intel 8254x family devices, including QEMU ``e1000`` emulation.
+*   e1000e – Intel PRO/1000 PCI‑Express family (82563/6/7, 82571/2/3/4/7/8/9, 82583 and I217/I218/I219-based adapters).
+
+.. note::
+
+   The ``igb`` and ``igc`` PMDs are built from the same driver binary but are documented in separate sections for clarity.
+
 Driver for VM Emulated Devices
 ==============================
 
-- 
2.43.0

