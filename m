Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12560CCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 04:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2DDD402A3;
	Tue,  7 Oct 2025 06:05:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 09F2C4027F
 for <dev@dpdk.org>; Tue,  7 Oct 2025 06:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759809907; x=1791345907;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=B67biDaPZloZ1rHML3Yy5VwUS5/LkUTaVPDOE5IOwXs=;
 b=nb2MtHtLgmCoSlh140dH9rV0L0tHle/5pP8WPpa0aYl1ZmBZZtrfaaOY
 zDkZAn+LbRW5qNslOVTldKCH87VTINH3qz85bA/PgZGSikZqH/kuyeGnC
 fs+XE/GGlQ2t3GTj2KiMZt9PObC12/RPcH1fxX/x1mJWErGAtCk20WTmu
 wgCitZsuHS/4DTyjujy43kqmxYPe/3K0vpD7SVBaO5y/0odJRQA3YEDhF
 YbrSGPwaAFuWGq5hYviU4kPEs7M4v9nGw77WD9g4WwlJ+K/PGv+P23olE
 WDLIemQhcjT0KJCqclxnaiEgvFNKr2MCHB/gz+zNGSggPXZhju5z/dTP6 g==;
X-CSE-ConnectionGUID: VrYCMZhmSXOWMp/O3uHDyw==
X-CSE-MsgGUID: mp4u2WeoTMm0scFpey8EiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="62154015"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="62154015"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:05:05 -0700
X-CSE-ConnectionGUID: UxlsrjL5Tg+4C6JA/Wv6Sw==
X-CSE-MsgGUID: X5rtsVKLRAaHRwcdHu1H/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="180841406"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa010.fm.intel.com with ESMTP; 06 Oct 2025 21:05:04 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/idpf: correct the enum constant name typo
Date: Tue,  7 Oct 2025 09:34:36 +0530
Message-Id: <20251007040436.2924355-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

Correct the typo in the idpf_rx_func_type enum by renaming
IDPF_RX_SINGLQ_AVX512 to IDPF_RX_SINGLEQ_AVX512 for consistency
and improved readability.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/idpf/idpf_common_device.h | 2 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_device.h b/drivers/net/intel/idpf/idpf_common_device.h
index 3b95d519c6..09d59dd0c1 100644
--- a/drivers/net/intel/idpf/idpf_common_device.h
+++ b/drivers/net/intel/idpf/idpf_common_device.h
@@ -50,7 +50,7 @@ enum idpf_rx_func_type {
 	IDPF_RX_SINGLEQ_SCATTERED,
 	IDPF_RX_SINGLEQ_AVX2,
 	IDPF_RX_AVX512,
-	IDPF_RX_SINGLQ_AVX512,
+	IDPF_RX_SINGLEQ_AVX512,
 	IDPF_RX_MAX
 };
 
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index a2b8c372d6..5a1c1561e5 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -1663,7 +1663,7 @@ const struct ci_rx_path_info idpf_rx_path_infos[] = {
 		.features = {
 			.rx_offloads = IDPF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_512}},
-	[IDPF_RX_SINGLQ_AVX512] = {
+	[IDPF_RX_SINGLEQ_AVX512] = {
 		.pkt_burst = idpf_dp_singleq_recv_pkts_avx512,
 		.info = "Single AVX512 Vector",
 		.features = {
-- 
2.34.1

