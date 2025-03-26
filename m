Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A658C3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 15:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0ADFC40653;
	Wed, 26 Mar 2025 16:52:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 0205C402A9
 for <dev@dpdk.org>; Wed, 26 Mar 2025 16:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743004359; x=1774540359;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IfeKqJhhW7BJRZdZ0WRdGEBedqcVYRWIFZ5eeHEL8vA=;
 b=DUEM0qZLaKup78HLEbhNW5Z+kofLpfkOSLhnSQCS18/N5sLJEH8ZFJds
 ryXA1kISwd8Bk4B/QYHLz2sYz9NnDDE2X6VB8rOoEjztR4LONw5QzpA38
 SDZJCQ9Ht1XM96T8YWOv00Lj66Om/MRvB7BvYMICx9qBn0CsWh6P2vspR
 izG+iwyUoigW7ARMoY/Ta86m+82VcgSMVrblAxKqj+BEpsvWCK+yrwPUn
 j1ijgPW1BVIV1jawM1le5TBoYFtUOx2F2nYNe9Nk2pGpAxuADarGZ1PkW
 ca5YIo/Zx88qHH8Yc29tC12GPQawZbbKI6/ZZ7DT3SBT1ZWjAbu4JerP9 Q==;
X-CSE-ConnectionGUID: BB59LcTOSi+azpX9MgPlPw==
X-CSE-MsgGUID: 1m5QKfN5TPWG/s0NaosiTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44188319"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="44188319"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 08:52:38 -0700
X-CSE-ConnectionGUID: KjD8nvZRRYaTmtxV7U7Idw==
X-CSE-MsgGUID: 3cKuAKRtRCSeEMu8FyiBXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="124550888"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa009.jf.intel.com with ESMTP; 26 Mar 2025 08:52:37 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH 1/7] net/iavf/base: remove unused meson.build file
Date: Wed, 26 Mar 2025 15:52:23 +0000
Message-ID: <20250326155230.1315056-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326155230.1315056-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
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

