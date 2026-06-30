Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2398FC43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 10:01:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3311F4025E;
	Tue, 30 Jun 2026 12:01:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 87CE44021E
 for <dev@dpdk.org>; Tue, 30 Jun 2026 12:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782813670; x=1814349670;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QHHhPNg3G/uMwEG6l6w5uTahv01Y9kIActwpSErl5Vw=;
 b=AF6zx+09irkBUpRFl4httxkM6XI5+ANhdmu7tAb8FnprhLiLz7RCE3KK
 UQN5RP0a44YMtb6MveirLER2NzrtzSpRMsIQ51NBwBsnjAaRO4UG8khRt
 BEnQ1lTcqQ6w+NnuRUDBrHMZ5LAp1KWmQoNNwikY3BNGtfqTflWF2dixm
 3BhYHxP1gZXO2HxI7CczmjV2+eM7E5KL2lgO/yztnm92qwJi4wnCcJHIM
 ppCGyoouGGhcRApN/kYG2GMVrMyWHWbbwL8RGlgT0SJwOHkg1RgoVK0ak
 CXSg71d18R6YcacVQ44dynq2h6v95dgzmAMH5ZTOPgTjVkxQKtGIjUaxG Q==;
X-CSE-ConnectionGUID: MhnEmTV8TYurhfikEXeTwg==
X-CSE-MsgGUID: A88Xn5W+RaaBY1pKOzWEKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94174849"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="94174849"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2026 03:01:09 -0700
X-CSE-ConnectionGUID: XX6oB93xTqehOABFC7RCHg==
X-CSE-MsgGUID: 9URYkeVHTLejSBd0BEzrbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="276500099"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa001.fm.intel.com with ESMTP; 30 Jun 2026 03:01:08 -0700
From: Emma Finn <emma.finn@intel.com>
To: Kai Ji <kai.ji@intel.com>,
	Emma Finn <emma.finn@intel.com>
Cc: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [v1] crypto/qat: fix IPsec MB header include for ARM
Date: Tue, 30 Jun 2026 10:01:04 +0000
Message-ID: <20260630100105.2330637-1-emma.finn@intel.com>
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

Update the header file to always include the platform-specific
IPsec MB header.

Fixes: 03c475d609eb ("crypto/qat: require IPsec MB for HMAC precomputes")

Reported-by: Thomas Monjalon <thomas@monjalon.net>
Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 drivers/crypto/qat/qat_sym_session.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qat/qat_sym_session.h b/drivers/crypto/qat/qat_sym_session.h
index 0c7b9cc6cf..b18673a1f7 100644
--- a/drivers/crypto/qat/qat_sym_session.h
+++ b/drivers/crypto/qat/qat_sym_session.h
@@ -14,11 +14,11 @@
 #include "icp_qat_fw.h"
 #include "icp_qat_fw_la.h"
 
-#ifndef RTE_QAT_OPENSSL
-#ifndef RTE_ARCH_ARM
+#ifdef RTE_ARCH_ARM
+#include <ipsec-mb.h>
+#else
 #include <intel-ipsec-mb.h>
 #endif
-#endif
 
 /*
  * Key Modifier (KM) value used in KASUMI algorithm in F9 mode to XOR
-- 
2.43.0

