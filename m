Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B4C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E24340E2D;
	Thu, 27 Mar 2025 15:52:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B21F440E1D
 for <dev@dpdk.org>; Thu, 27 Mar 2025 15:52:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743087136; x=1774623136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IfeKqJhhW7BJRZdZ0WRdGEBedqcVYRWIFZ5eeHEL8vA=;
 b=Eng6fVfHW0iqj7FKRbltVtn+IVECwjaVinOs/wg5YgcobffOvigoQPCf
 FpWa1CYacV95xTDtNxT56myiX0UUG0QpLnmcGQOVuiunvPFy3aNXWMvrC
 z8iY27BUnCfXhSPpAdUT5SIYsUoxWaBgaSBjGnNedaQEBXQyD1fXrU5P2
 yCfcMJfnVoDkMKSTFOoQpYC/3sfyL7GXPEsmR/btuycAotmlmzkEh8Gqt
 OeVxCJygFKIZ918rC8Aw6AelGw5VLp9NSSlmrhdfhEHIwMMtnGYRqaVSc
 G8U/aATTxTbKYe/Auxs0s2K8h71rrR6I0XEV5ym37+2wwTdc+mYbf+G4K w==;
X-CSE-ConnectionGUID: zCifnLcWQOKyPuGrhQyToQ==
X-CSE-MsgGUID: sOE+2dpzRqaeaSFoUf51sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="48207064"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="48207064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:52:16 -0700
X-CSE-ConnectionGUID: u+HGmQRqR/GhnpU7oOCh9w==
X-CSE-MsgGUID: 1PE1mZOKTgytB2ycMgv/TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="162400009"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa001.jf.intel.com with ESMTP; 27 Mar 2025 07:52:14 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v3 2/9] net/iavf/base: remove unused meson.build file
Date: Thu, 27 Mar 2025 14:51:54 +0000
Message-ID: <20250327145202.2220153-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327145202.2220153-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250327145202.2220153-1-bruce.richardson@intel.com>
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

