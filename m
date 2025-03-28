Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2220C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 11:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 587BB40661;
	Fri, 28 Mar 2025 12:16:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0E26A40653
 for <dev@dpdk.org>; Fri, 28 Mar 2025 12:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743160593; x=1774696593;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IfeKqJhhW7BJRZdZ0WRdGEBedqcVYRWIFZ5eeHEL8vA=;
 b=g1CAxKmG7IRKYx3qoOZfYw2qOqWzxmGjz/gXK1u17HcSrSIScBxOa5xW
 X8lSQ+gnmyhMN8W2kVbQhrZK2ysmqbugF07Qu6UpSv8PMwgDsjdnbzudv
 0Yi7ylSZAvmkPq+3pORPyMNe9AokRGFCbqQ7EojFqhEEYxK9PJA3GnfgV
 h3gPwgJpChns8U9SH32+QjkY0n4tVLDp/vvjId+/d6NDUxCgDxmHnsBQJ
 wgeOxWmBmDEgiyFO1OEwhGx0I+y2Gr24iCiodM4UP6xj7xs2S3rCHYLFn
 55vcIIJ1/RdeDHPIQ/LS6BV1pSUkLPe5mBC2VqjCF5mUXPzCNUSr8b6/s A==;
X-CSE-ConnectionGUID: LcCjAi2vTGCI64wbjIAdgg==
X-CSE-MsgGUID: +WBzcKvRQ6C8c6B5ZZm+rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44435463"
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="44435463"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2025 04:16:32 -0700
X-CSE-ConnectionGUID: zzPenC1aSPy79VYYIG3FRQ==
X-CSE-MsgGUID: Z9N9cXwmRDCVevZS+LV+zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,283,1736841600"; d="scan'208";a="125423286"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa006.jf.intel.com with ESMTP; 28 Mar 2025 04:16:30 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: David Marchand <david.marchand@redhat.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 2/9] net/iavf/base: remove unused meson.build file
Date: Fri, 28 Mar 2025 11:16:14 +0000
Message-ID: <20250328111621.2665257-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328111621.2665257-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250328111621.2665257-1-bruce.richardson@intel.com>
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

The meson.build file in the base folder was never used, as the base
files were just included in the main sources list for iavf.

Fixes: f1fdc9ddba5e ("drivers: move iavf common folder to iavf net")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/base/meson.build | 10 ----------
 1 file changed, 10 deletions(-)
 delete mode 100644 drivers/net/intel/iavf/base/meson.build

diff --git a/drivers/net/intel/iavf/base/meson.build b/drivers/net/intel/iavf/base/meson.build
deleted file mode 100644
index 273e88e921..0000000000
--- a/drivers/net/intel/iavf/base/meson.build
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2019-2021 Intel Corporation
-
-sources = files('iavf_adminq.c', 'iavf_common.c', 'iavf_impl.c')
-
-if cc.has_argument('-Wno-pointer-to-int-cast')
-        cflags += '-Wno-pointer-to-int-cast'
-endif
-
-require_iova_in_mbuf = false
-- 
2.45.2

