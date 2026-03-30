Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABA1FF493A
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 03:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76BD040269;
	Mon, 30 Mar 2026 05:58:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3EA77400D6
 for <dev@dpdk.org>; Mon, 30 Mar 2026 05:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774843109; x=1806379109;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QnLdSLVXJug+oiYxJslg3omBJZDU7c0/kBC9aiGU4n4=;
 b=XyiJfnurbntEZ5IRNAbvkHl/ElGopttLFH17Psn/kzQr8v3L+VYaWz8q
 klk6glK8g3SoIydVOq3ZbRsrBf0uCaz8jVazCtTQJlpFIjd09uQNx6oPU
 +3yBIt+z2tbvyWZbdkJhYJRBP5X/mnkpALWubzHLAxPyZmsb2I9MDRpke
 eYTq2BxePtZgXUey62pqUqJg7g+AsHnonDfUxBc+eGi/XUNYDbBH95Q7Y
 eKW46v1aO9cBXW3/MvWv37hyAikHvpw20T6c6Ets7lVKWByMPLiXxHTia
 Fg0Cbt9C6+Gy7g9CZOn9wCx7IUp0JqA9JHwklrrwmWnusqJijXS7AjpJs Q==;
X-CSE-ConnectionGUID: S4UNlOP8Qk+8mLb0CMP5iA==
X-CSE-MsgGUID: WaqEWYmPQKe0oHMvWyowpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86520312"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="86520312"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 20:58:28 -0700
X-CSE-ConnectionGUID: cEN1QQxNST+0XV9/bDoodw==
X-CSE-MsgGUID: 3gpwMSmKQdGCGZwN1CD9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="230400688"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa004.jf.intel.com with ESMTP; 29 Mar 2026 20:58:27 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/ice: fix FDIR session ID offset for L-bit L2TPv2 types
Date: Mon, 30 Mar 2026 09:23:19 +0530
Message-ID: <20260330035319.2569981-1-shaiq.wani@intel.com>
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

L2TPv2 types with the Length bit set have a 2-byte Length field before
Tunnel ID, placing session_id at UDP payload offset 14, not 12. The
driver always used offset 12, causing FDIR to match on wrong bytes.

Wire up ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID which was defined but
never used, and select it based on the L-bit in flags_version.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c  | 13 +++++++++++--
 drivers/net/intel/ice/ice_generic_flow.h |  3 +++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 3522d77123..bb41f91168 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -110,7 +110,8 @@
 	ICE_INSET_NAT_T_ESP_SPI)
 
 #define ICE_FDIR_INSET_L2TPV2 (\
-	ICE_INSET_SMAC | ICE_INSET_DMAC | ICE_INSET_L2TPV2OIP_SESSION_ID)
+	ICE_INSET_SMAC | ICE_INSET_DMAC | ICE_INSET_L2TPV2OIP_SESSION_ID | \
+	ICE_INSET_L2TPV2OIP_LEN_SESSION_ID)
 
 #define ICE_FDIR_INSET_L2TPV2_PPP_IPV4 (\
 	ICE_INSET_TUN_IPV4_SRC | ICE_INSET_TUN_IPV4_DST)
@@ -1001,6 +1002,7 @@ ice_fdir_input_set_parse(uint64_t inset, enum ice_flow_field *field)
 		{ICE_INSET_ESP_SPI, ICE_FLOW_FIELD_IDX_ESP_SPI},
 		{ICE_INSET_NAT_T_ESP_SPI, ICE_FLOW_FIELD_IDX_NAT_T_ESP_SPI},
 		{ICE_INSET_L2TPV2OIP_SESSION_ID, ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID},
+		{ICE_INSET_L2TPV2OIP_LEN_SESSION_ID, ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID},
 	};
 
 	for (i = 0, j = 0; i < RTE_DIM(ice_inset_map); i++) {
@@ -2598,7 +2600,14 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			     l2tpv2_mask->hdr.type1.session_id == UINT16_MAX) ||
 			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S_O &&
 			     l2tpv2_mask->hdr.type0.session_id == UINT16_MAX)) {
-				input_set_o |= ICE_INSET_L2TPV2OIP_SESSION_ID;
+				if (flags_version == RTE_L2TPV2_MSG_TYPE_CONTROL ||
+				    flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L ||
+				    flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S ||
+				    flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_O ||
+				    flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S_O)
+					input_set_o |= ICE_INSET_L2TPV2OIP_LEN_SESSION_ID;
+				else
+					input_set_o |= ICE_INSET_L2TPV2OIP_SESSION_ID;
 			}
 
 			tunnel_type = ICE_FDIR_TUNNEL_TYPE_L2TPV2;
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index 1b5514d5df..c0eed84610 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -66,6 +66,7 @@
 #define ICE_IP_PK_ID			BIT_ULL(40)
 #define ICE_IP_FRAG_OFS			BIT_ULL(39)
 #define ICE_L2TPV2OIP_SESSION_ID	BIT_ULL(38)
+#define ICE_L2TPV2OIP_LEN_SESSION_ID	BIT_ULL(37)
 
 /* input set */
 
@@ -135,6 +136,8 @@
 	(ICE_PROT_NAT_T_ESP | ICE_ESP_SPI)
 #define ICE_INSET_L2TPV2OIP_SESSION_ID \
 	(ICE_PROT_L2TPV2OIP | ICE_L2TPV2OIP_SESSION_ID)
+#define ICE_INSET_L2TPV2OIP_LEN_SESSION_ID \
+	(ICE_PROT_L2TPV2OIP | ICE_L2TPV2OIP_LEN_SESSION_ID)
 #define ICE_INSET_TUN_IPV4_SRC \
 	(ICE_PROT_IPV4_INNER | ICE_IP_SRC)
 #define ICE_INSET_TUN_IPV4_DST \
-- 
2.43.0

