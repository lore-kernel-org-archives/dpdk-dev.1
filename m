Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F072D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA79E406B6;
	Mon,  1 Dec 2025 12:45:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1F5CF40613
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589516; x=1796125516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BD9AYqJbD6ejB2VFYDXZDZ1fK6gKDRMFlgPS5s7ytoM=;
 b=K9xn0h56H5wUUxrD/GSFrZsJFLo0WP4SaGkmmc8rHoXCQr1ivMggg5/z
 QNaOrCok62SvKs986mv0CHz7oCYkzUM3OtZfCIsjJzgcqUM8WpJ7GcXhg
 soYRIm97eH87OIpUA5n/kUFYkOCFPHobKcjyGUnGsAnk5pwf56csAiRKK
 M9OcRHvcjkZZmJErfsECHdBl65YWTvSvlsM8PC/VqtTBkunROMJFdPOk6
 EyDx2WWKwVWVUgu6SCphK98o3lDi9q4d8zWYW1GAFlW58OnvJ5enGXmGr
 sntDA4zYsWhwp3acm3EfrCo6Wrkni+X8IT0CVrlRAkB/SnmFckJy5qj4P w==;
X-CSE-ConnectionGUID: 1p+FrL5kRj6JtyoNK7o0gQ==
X-CSE-MsgGUID: OfRDTIl5QqGWMe8t2xqZ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991731"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991731"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:16 -0800
X-CSE-ConnectionGUID: pJbj9tklSjW72H+rmsXw8A==
X-CSE-MsgGUID: qdaekjLpQb+S9iwcOb3Rww==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 12/31] net/intel: rename function param to avoid shadow
 warnings
Date: Mon,  1 Dec 2025 11:44:29 +0000
Message-ID: <20251201114448.1441377-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

The rx_free_thresh parameter was conflicting with a global value in
testpmd when certain driver-specific files were included in the testpmd
build. Rename the parameter to just "free_thresh" - the "rx" is
unnecessary since the function itself is for Rx queues.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/common/rx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index ea7fb98b47..463d1eb834 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -228,11 +228,11 @@ ci_rxq_mbuf_initializer(uint16_t port_id)
  * Individual drivers may have other further tests beyond this.
  */
 static inline bool
-ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh)
+ci_rxq_vec_capable(uint16_t nb_desc, uint16_t free_thresh)
 {
 	if (!rte_is_power_of_2(nb_desc) ||
-			rx_free_thresh < CI_RX_MAX_BURST ||
-			(nb_desc % rx_free_thresh) != 0)
+			free_thresh < CI_RX_MAX_BURST ||
+			(nb_desc % free_thresh) != 0)
 		return false;
 
 	return true;
-- 
2.51.0

