Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F36FD9E34
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 06:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BE3E402C6;
	Fri, 27 Feb 2026 07:03:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 290E64028E
 for <dev@dpdk.org>; Fri, 27 Feb 2026 07:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772172194; x=1803708194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=U/W7UUhxF/1TpRYUt+JJhz/gXb6kGCgRzQ1a5vsgBqM=;
 b=ka0K1PZweSZBrMbFnQmu3CkOR84iG2yxP1Yn1zu7sM/e04IaZtoyqHpL
 n6GN/PZld7ACBDGwaleXFrGrHj5CWxWvJuluKI8tuOI/ERwsftUqsU4xm
 8q/pSS16PjSy99LQeV5SQJXJF6O4oGdlJUDULZxipJmkbVlYzjk0CvWqo
 8BkuwSWN2a2+QWNK0cPm5N3S13X3IWfWL6gqKUTmpVSkLncTtWmDpXbEd
 hDUWU55lcz0xIIAG3VLwdhSQh5YDAo7iMHCHg2gi7E6tl/QBP4KSLTtuM
 7SgxWr7Hr2rikzwlMGXxkS8xMZ7k2TmVQsoA2NGuOCvM5Stytb4m7W8dK Q==;
X-CSE-ConnectionGUID: RHAZhzrrTEa0pv7toimsSA==
X-CSE-MsgGUID: GZeGwf1oSEyOh61uA6hbDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="60825848"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="60825848"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 22:03:13 -0800
X-CSE-ConnectionGUID: Ub9FR5NUR5iMmiD8D8AdKA==
X-CSE-MsgGUID: YkGh7UhvRUq5AfDcOlQm5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="216705740"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by orviesa009.jf.intel.com with ESMTP; 26 Feb 2026 22:03:12 -0800
From: Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 shaiq.wani@intel.com,
 Talluri Chaitanyababu <chaitanyababux.talluri@intel.com>
Subject: [PATCH v4] doc: improve e1000 driver documentation
Date: Fri, 27 Feb 2026 16:21:59 +0000
Message-ID: <20260227162200.23972-1-chaitanyababux.talluri@intel.com>
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
v4:
* Fixed RST structure, single top-level title.
* Used ASCII "PCIe".
* Adjusted commit message to match content.

v3: Resolved apply patch failure.

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

