Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6209C3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 16:05:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA37D40667;
	Wed, 26 Mar 2025 17:05:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B6DE540651
 for <dev@dpdk.org>; Wed, 26 Mar 2025 17:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743005148; x=1774541148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IfeKqJhhW7BJRZdZ0WRdGEBedqcVYRWIFZ5eeHEL8vA=;
 b=gbIvl35Qr2lA5h5B2J61kYuuOiJG+V0juzqs8AplYTLEWDn0WjL/AtFW
 x5Xuip6XXAtWFho64LtX8wVP2y+b5kvLKf3/x1ywnEKXkeHm2SNa8fw3P
 Spj+fhgWNr8bdUJ/6n61te8xvmNZAyu2Up2i3+lRLQdnY66x8sKtstNJq
 VEYpoaSrOoZIDqtzF0qklYHpuA1/zGfsistz3WCLvpzCnSxh+2cnyli/s
 75drXweETGe0zZGAWZgZgQxeb0DutDEcsl1NofJMJNGrW/Kcu1+oiDH/a
 ETdvW9mxjkOwKmsRvaiHyu/8u5MjqdeG5RnTiCVwCHXYH5UF3v6yOpoeO A==;
X-CSE-ConnectionGUID: UQO0VatSSwKYmzOJlrPO/g==
X-CSE-MsgGUID: ThRx60eoQKmyEO2pb0uuSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54954971"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="54954971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2025 09:05:47 -0700
X-CSE-ConnectionGUID: 7vXN/qDQQCSQc9I8Ypc4LA==
X-CSE-MsgGUID: WCbiGYzwQ+Kh1+4MrCld0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; d="scan'208";a="125280728"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa010.fm.intel.com with ESMTP; 26 Mar 2025 09:05:46 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ian Stokes <ian.stokes@intel.com>
Subject: [PATCH v2 2/8] net/iavf/base: remove unused meson.build file
Date: Wed, 26 Mar 2025 16:05:32 +0000
Message-ID: <20250326160539.1316499-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250326160539.1316499-1-bruce.richardson@intel.com>
References: <20250326155230.1315056-1-bruce.richardson@intel.com>
 <20250326160539.1316499-1-bruce.richardson@intel.com>
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

