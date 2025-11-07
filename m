Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6EFCCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41AEA40E0A;
	Fri,  7 Nov 2025 16:51:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 97B9F40B9C
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530676; x=1794066676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0bw+q9bGeOZOrvoSVwOEz3enBI8+2KSyF/gtOThlvpE=;
 b=RKROt8wio1aJYvDmYNfqmr/HC/tWuOfX1G4F04Kd2roxYS67AtL3zSoV
 E/tvjUwusQphXZ+pFrNP/vS2quOx5S3rNOV1Q6SYrx5SM1B9uPMHwukZ0
 j15vQn89ML2QYrbSHnEy5C0pYWMskNR0BFq8rdLNDHz/+xEtLxzu3OHRu
 Z1mpfdQTfvkhOmGKjvcOZGDmLG6azFdiwK9wf/z167cUubk+pEDOW7Sbu
 /fzbcXK+BX50JeUycyAHVYcy2YHUky/OvTO2WdaJ/ljqaImjq4gnymRw+
 IS99CGSgbd6+oKElqZkcIjCyQ2WMs7csYT8e8MXAo+ikjOxruNpqKKC1T Q==;
X-CSE-ConnectionGUID: Y8beItuMTuyxpqRWjtEKmQ==
X-CSE-MsgGUID: 5RYaOEztRvW0CfpxziOirA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151846"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151846"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:15 -0800
X-CSE-ConnectionGUID: LzU9YexLRY6IqlDCkSj2rA==
X-CSE-MsgGUID: seiYQUwQR/O+3Q5aCh853g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321688"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH v2 13/33] net/intel: rename function param to avoid shadow
 warnings
Date: Fri,  7 Nov 2025 15:50:09 +0000
Message-ID: <20251107155034.436809-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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
---
 drivers/net/intel/common/rx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 5012e4fced..80b62ce3d5 100644
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
2.48.1

