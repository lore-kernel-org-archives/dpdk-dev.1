Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810CB109C03E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 16:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2177402CE;
	Wed, 25 Mar 2026 17:40:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id DAAFF4028E;
 Wed, 25 Mar 2026 17:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774456805; x=1805992805;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6D0fNMvuFgHfNeC7mP2y29aTcSP9HXYopxZPeJjUHLU=;
 b=BNMESZU+nAqGzT6MAhuj7r0Le4uDeywIzq8GXEWd72ev82r1dew1Pr9U
 WhuYJfle+BkF9Lxz8VqpSZGbFjC0X7VjKGHIlFl6cn+AnS9uUZhk4zL7o
 AA0WFJjPjyO2PkrawUUQGlNI7kThjFk+VW7zghgTV1lxEC0ExfzyHM7LG
 QZpHikPJ3h1+ghXtNyLhJbKcNKkgEySNVjbWWIpn2nplXBW4Hua8ruwXa
 UmOR+fwPAIkkYKMurmuqVQNJtQ/u/mL8dnMCNvwa/O7ZYp5ItAYxL15ID
 MFbJ67ymny5hS/QW+706nSeH19d0ACts9Jv+9uSbKWJH8p+fpmKRPTOhN Q==;
X-CSE-ConnectionGUID: hFI7HdrmS7aG3zG4ZJ5Wyw==
X-CSE-MsgGUID: 3T43JKdyQV2pdupe4RgX6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75386997"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="75386997"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2026 09:40:03 -0700
X-CSE-ConnectionGUID: BQ0CdONYSqepGz64BYQxKg==
X-CSE-MsgGUID: Q9xchKhSSFqfWO94aTMovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; d="scan'208";a="218151759"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa009.fm.intel.com with ESMTP; 25 Mar 2026 09:40:01 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix RSS LUT access for global LUT VSI
Date: Wed, 25 Mar 2026 16:39:58 +0000
Message-ID: <20260325163959.3968209-1-vladimir.medvedkin@intel.com>
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

When global RSS LUT is enabled, get/set RSS LUT still uses PF LUT
parameters in AQ commands, with lut_type set to PF and global_lut_id 0.
As a result, the operation may target the wrong LUT.

Use global LUT parameters when global LUT is allocated for the VSI,
and keep PF LUT parameters otherwise.

Fixes: 193a11ffd3e6 ("net/ice: adjust RSS LUT settings")
Cc: stable@dpdk.org

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 8286816f06..0f2e7aee14 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -5479,9 +5479,10 @@ ice_get_rss_lut(struct ice_vsi *vsi, uint8_t *lut, uint16_t lut_size)
 	if (pf->flags & ICE_FLAG_RSS_AQ_CAPABLE) {
 		lut_params.vsi_handle = vsi->idx;
 		lut_params.lut_size = lut_size;
-		lut_params.lut_type = ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF;
+		lut_params.lut_type = (vsi->global_lut_allocated) ?
+			ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_GLOBAL : ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF;
 		lut_params.lut = lut;
-		lut_params.global_lut_id = 0;
+		lut_params.global_lut_id = (vsi->global_lut_allocated) ? vsi->global_lut_id : 0;
 		ret = ice_aq_get_rss_lut(hw, &lut_params);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to get RSS lookup table");
@@ -5515,9 +5516,10 @@ ice_set_rss_lut(struct ice_vsi *vsi, uint8_t *lut, uint16_t lut_size)
 	if (pf->flags & ICE_FLAG_RSS_AQ_CAPABLE) {
 		lut_params.vsi_handle = vsi->idx;
 		lut_params.lut_size = lut_size;
-		lut_params.lut_type = ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF;
+		lut_params.lut_type = (vsi->global_lut_allocated) ?
+			ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_GLOBAL : ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_PF;
 		lut_params.lut = lut;
-		lut_params.global_lut_id = 0;
+		lut_params.global_lut_id = (vsi->global_lut_allocated) ? vsi->global_lut_id : 0;
 		ret = ice_aq_set_rss_lut(hw, &lut_params);
 		if (ret) {
 			PMD_DRV_LOG(ERR, "Failed to set RSS lookup table");
-- 
2.43.0

