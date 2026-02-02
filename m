Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D9DE7314E
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 09:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB73840A80;
	Mon,  2 Feb 2026 10:44:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 679C94027D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 10:44:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770025442; x=1801561442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pe6TDrpJOf68A7Ww/P7pIkPevZiPrQD3AUtR5KUGZ0g=;
 b=Ih9q3wCEUFZekl3Hl+X3QYJlM9mJabEoa3QX9tpxc5rBDvUFHHZYg550
 4OEuY9BTsqPzYqFRQ5MbhYsxVX760JTSsK+oWFXm6MVykO2hJM6J21KHn
 W7M9TL8bR7DnqSprhlC3A4r2pRVK3fHfSfwhLfxK/eUDqx+3JuOClRpLu
 LgIs3Azb4FSmUBwBO+ngDp4JRKFotenfsQq4Cf5t9q5yiH9yr71pH9zza
 5kj+CO2h8pn17cavssBWLIlssLBDFnG/OpoCCAubRiYBz7VenyzGOt5t7
 d8uHqqunUc4Z9+Jat870a/CPw58pueobDmBCPYrrAOVJc6nyQyaHNVR3u Q==;
X-CSE-ConnectionGUID: EGnUAjUeTX6y16Bi3PA0bg==
X-CSE-MsgGUID: VZ0oEyyDQOeu0OxTpO3NlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="81917708"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; d="scan'208";a="81917708"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 01:44:02 -0800
X-CSE-ConnectionGUID: V5SRxeV6QKCUHDDV9YO9fQ==
X-CSE-MsgGUID: +ZaBHw4sRF2FWr2smf8XNg==
X-ExtLoop1: 1
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa003.fm.intel.com with ESMTP; 02 Feb 2026 01:44:01 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Jiale Song <songx.jiale@intel.com>
Subject: [PATCH 2/6] net/ice: add L2TPv2 tunnel type definition
Date: Mon,  2 Feb 2026 15:12:40 +0530
Message-Id: <20260202094244.447966-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202094244.447966-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
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

Add ICE_FDIR_TUNNEL_TYPE_L2TPV2 to the tunnel type enum and
extend ice_fdir_fltr_pattern structure to include L2TPv2 data and
mask fields.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Jiale Song <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 72ed65f13b..a37ed9db71 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -362,6 +362,7 @@ enum ice_fdir_tunnel_type {
 	ICE_FDIR_TUNNEL_TYPE_VXLAN,
 	ICE_FDIR_TUNNEL_TYPE_GTPU,
 	ICE_FDIR_TUNNEL_TYPE_GTPU_EH,
+	ICE_FDIR_TUNNEL_TYPE_L2TPV2,
 };
 
 struct rte_flow;
@@ -398,6 +399,9 @@ struct ice_fdir_fltr_pattern {
 	struct ice_fdir_udp_gtp gtpu_data;
 	struct ice_fdir_udp_gtp gtpu_mask;
 
+	struct ice_fdir_l2tpv2 l2tpv2_data;
+	struct ice_fdir_l2tpv2 l2tpv2_mask;
+
 	struct ice_fdir_extra ext_data;
 	struct ice_fdir_extra ext_mask;
 
-- 
2.34.1

