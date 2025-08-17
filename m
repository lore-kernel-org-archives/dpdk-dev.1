Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6A9CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 Aug 2025 13:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAAA2402E8;
	Sun, 17 Aug 2025 15:02:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 7907C4003C
 for <dev@dpdk.org>; Sun, 17 Aug 2025 15:02:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755435721; x=1786971721;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5ANKKcDrfKfSVIM4j1yoJY52+8k2sp874Di4kKHGdAk=;
 b=kJh3h1cyAnlkktxosC7eOQqiWjFEsdELpdvMdbADG/mHswH8CZLUhxpx
 qcgGyOo7x35PKTLFqIfyLKInO+5tuPD+8z9BU4c6RDymgV3fpmoVrXddf
 7HFkdnQuj3rqamT0wQVOkpNiVuSsin4nzOrQzFUH0tpla0T3D9d5pS+gz
 eY9AwfY3a6FypML4IiZcMOx+URqonqyY0mXet/fCbG5pkWSCk0De75Klg
 EcVOjwn53cyo3fPduPZJy1TT3hKTx377LfahzSKRkWxHl7MhxuAJJkBeF
 BZE/OjN1NVG+sCpr3W5dd44/uGN954FWvHxG9qxc9gyyrmwfYmZ3nK3en w==;
X-CSE-ConnectionGUID: pwY104pWTH+SdI3aARJcag==
X-CSE-MsgGUID: DmDQbRnxQsC6Pod98OjfWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57756060"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="57756060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2025 06:02:00 -0700
X-CSE-ConnectionGUID: b1GsNt1XSvyyqBj1ORvt5w==
X-CSE-MsgGUID: VoAbrOk7QUKqlaxvEyuu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="171581459"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 17 Aug 2025 06:01:58 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v4 3/6] net/ice/base: add support for asymmetric PFC
Date: Sun, 17 Aug 2025 13:01:49 +0000
Message-ID: <20250817130152.682972-4-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
References: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
 <20250817130152.682972-1-vladimir.medvedkin@intel.com>
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

Current implementation supports only symmetric PFC configuration.
In this patch two bitmasks for asymmetric PFC were added to the
struct ice_dcb_pfc_cfg.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_dcb.c  | 96 ++++++++++++++++++++++-----
 drivers/net/intel/ice/base/ice_dcb.h  | 16 ++++-
 drivers/net/intel/ice/base/ice_type.h |  2 +
 3 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_dcb.c b/drivers/net/intel/ice/base/ice_dcb.c
index e97f35b4cf..5b75236156 100644
--- a/drivers/net/intel/ice/base/ice_dcb.c
+++ b/drivers/net/intel/ice/base/ice_dcb.c
@@ -1133,7 +1133,8 @@ ice_add_ieee_ets_common_tlv(u8 *buf, struct ice_dcb_ets_cfg *ets_cfg)
  * Prepare IEEE 802.1Qaz ETS CFG TLV
  */
 static void
-ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
+ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	struct ice_dcb_ets_cfg *etscfg;
 	u8 *buf = tlv->tlvinfo;
@@ -1145,8 +1146,22 @@ ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 		   ICE_IEEE_ETS_TLV_LEN);
 	tlv->typelen = HTONS(typelen);
 
-	ouisubtype = ((ICE_IEEE_8021QAZ_OUI << ICE_LLDP_TLV_OUI_S) |
+	switch (pfc_asym_mode) {
+	case (ICE_SET_PFC_SYM):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI << ICE_LLDP_TLV_OUI_S) |
 		      ICE_IEEE_SUBTYPE_ETS_CFG);
+		break;
+	case(ICE_SET_PFC_RX):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI_ASYM << ICE_LLDP_TLV_OUI_S) |
+		      ICE_IEEE_SUBTYPE_ETS_CFG_RX);
+		break;
+	case(ICE_SET_PFC_TX):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI_ASYM << ICE_LLDP_TLV_OUI_S) |
+		      ICE_IEEE_SUBTYPE_ETS_CFG_TX);
+		break;
+	default:
+		return;
+	}
 	tlv->ouisubtype = HTONL(ouisubtype);
 
 	/* First Octet post subtype
@@ -1162,6 +1177,9 @@ ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 	maxtcwilling |= etscfg->maxtcs & ICE_IEEE_ETS_MAXTC_M;
 	buf[0] = maxtcwilling;
 
+	if (pfc_asym_mode == ICE_SET_PFC_TX)
+		etscfg = &dcbcfg->etsrec;
+
 	/* Begin adding at Priority Assignment Table (offset 1 in buf) */
 	ice_add_ieee_ets_common_tlv(&buf[1], etscfg);
 }
@@ -1205,7 +1223,8 @@ ice_add_ieee_etsrec_tlv(struct ice_lldp_org_tlv *tlv,
  * Prepare IEEE 802.1Qaz PFC CFG TLV
  */
 static void
-ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
+ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	u8 *buf = tlv->tlvinfo;
 	u32 ouisubtype;
@@ -1215,8 +1234,22 @@ ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 		   ICE_IEEE_PFC_TLV_LEN);
 	tlv->typelen = HTONS(typelen);
 
-	ouisubtype = ((ICE_IEEE_8021QAZ_OUI << ICE_LLDP_TLV_OUI_S) |
+	switch (pfc_asym_mode) {
+	case (ICE_SET_PFC_SYM):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI << ICE_LLDP_TLV_OUI_S) |
 		      ICE_IEEE_SUBTYPE_PFC_CFG);
+		break;
+	case(ICE_SET_PFC_RX):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI_ASYM << ICE_LLDP_TLV_OUI_S) |
+		      ICE_IEEE_SUBTYPE_PFC_CFG_RX);
+		break;
+	case(ICE_SET_PFC_TX):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI_ASYM << ICE_LLDP_TLV_OUI_S) |
+		      ICE_IEEE_SUBTYPE_PFC_CFG_TX);
+		break;
+	default:
+		return;
+	}
 	tlv->ouisubtype = HTONL(ouisubtype);
 
 	/* ----------------------------------------
@@ -1233,6 +1266,10 @@ ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 
 	buf[0] |= dcbcfg->pfc.pfccap & 0xF;
 	buf[1] = dcbcfg->pfc.pfcena;
+	if (pfc_asym_mode == ICE_SET_PFC_RX)
+		buf[1] |= dcbcfg->pfc.pfcena_asym_rx;
+	if (pfc_asym_mode == ICE_SET_PFC_TX)
+		buf[1] |= dcbcfg->pfc.pfcena_asym_tx;
 }
 
 /**
@@ -1244,7 +1281,8 @@ ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
  */
 static void
 ice_add_ieee_app_pri_tlv(struct ice_lldp_org_tlv *tlv,
-			 struct ice_dcbx_cfg *dcbcfg)
+			 struct ice_dcbx_cfg *dcbcfg,
+			 enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	u16 typelen, len, offset = 0;
 	u8 priority, selector, i = 0;
@@ -1254,8 +1292,23 @@ ice_add_ieee_app_pri_tlv(struct ice_lldp_org_tlv *tlv,
 	/* No APP TLVs then just return */
 	if (dcbcfg->numapps == 0)
 		return;
-	ouisubtype = ((ICE_IEEE_8021QAZ_OUI << ICE_LLDP_TLV_OUI_S) |
+
+	switch (pfc_asym_mode) {
+	case (ICE_SET_PFC_SYM):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI << ICE_LLDP_TLV_OUI_S) |
 		      ICE_IEEE_SUBTYPE_APP_PRI);
+		break;
+	case(ICE_SET_PFC_RX):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI_ASYM << ICE_LLDP_TLV_OUI_S) |
+		      ICE_IEEE_SUBTYPE_APP_PRI_RX);
+		break;
+	case(ICE_SET_PFC_TX):
+		ouisubtype = ((ICE_IEEE_8021QAZ_OUI_ASYM << ICE_LLDP_TLV_OUI_S) |
+		      ICE_IEEE_SUBTYPE_APP_PRI_TX);
+		break;
+	default:
+		return;
+	}
 	tlv->ouisubtype = HTONL(ouisubtype);
 
 	/* Move offset to App Priority Table */
@@ -1429,21 +1482,21 @@ ice_add_dscp_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
  */
 static void
 ice_add_dcb_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
-		u16 tlvid)
+		u16 tlvid, enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	if (dcbcfg->pfc_mode == ICE_QOS_MODE_VLAN) {
 		switch (tlvid) {
 		case ICE_IEEE_TLV_ID_ETS_CFG:
-			ice_add_ieee_ets_tlv(tlv, dcbcfg);
+			ice_add_ieee_ets_tlv(tlv, dcbcfg, pfc_asym_mode);
 			break;
 		case ICE_IEEE_TLV_ID_ETS_REC:
 			ice_add_ieee_etsrec_tlv(tlv, dcbcfg);
 			break;
 		case ICE_IEEE_TLV_ID_PFC_CFG:
-			ice_add_ieee_pfc_tlv(tlv, dcbcfg);
+			ice_add_ieee_pfc_tlv(tlv, dcbcfg, pfc_asym_mode);
 			break;
 		case ICE_IEEE_TLV_ID_APP_PRI:
-			ice_add_ieee_app_pri_tlv(tlv, dcbcfg);
+			ice_add_ieee_app_pri_tlv(tlv, dcbcfg, pfc_asym_mode);
 			break;
 		default:
 			break;
@@ -1474,10 +1527,12 @@ ice_add_dcb_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
  * @lldpmib: pointer to the HW struct
  * @miblen: length of LLDP MIB
  * @dcbcfg: Local store which holds the DCB Config
+ * @pfc_mode: PFC mode with respect to PAUSE frames direction
  *
  * Convert the DCB configuration to MIB format
  */
-void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg)
+void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	u16 len, offset = 0, tlvid = ICE_TLV_ID_START;
 	struct ice_lldp_org_tlv *tlv;
@@ -1485,7 +1540,12 @@ void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg)
 
 	tlv = (struct ice_lldp_org_tlv *)lldpmib;
 	while (1) {
-		ice_add_dcb_tlv(tlv, dcbcfg, tlvid++);
+		/* Asymmetric configuration does not require ETS rec TLV */
+		if (tlvid == ICE_IEEE_TLV_ID_ETS_REC && pfc_asym_mode != ICE_SET_PFC_SYM) {
+			tlvid++;
+			continue;
+		}
+		ice_add_dcb_tlv(tlv, dcbcfg, tlvid++, pfc_asym_mode);
 		typelen = NTOHS(tlv->typelen);
 		len = (typelen & ICE_LLDP_TLV_LEN_M) >> ICE_LLDP_TLV_LEN_S;
 		if (len)
@@ -1532,9 +1592,15 @@ int ice_set_dcb_cfg(struct ice_port_info *pi)
 	if (dcbcfg->app_mode == ICE_DCBX_APPS_NON_WILLING)
 		mib_type |= SET_LOCAL_MIB_TYPE_CEE_NON_WILLING;
 
-	ice_dcb_cfg_to_lldp(lldpmib, &miblen, dcbcfg);
-	ret = ice_aq_set_lldp_mib(hw, mib_type, (void *)lldpmib, miblen,
-				  NULL);
+	if ((dcbcfg->pfc.pfcena_asym_rx ^ dcbcfg->pfc.pfcena_asym_tx) == 0) {
+		ice_dcb_cfg_to_lldp(lldpmib, &miblen, dcbcfg, ICE_SET_PFC_SYM);
+		ret = ice_aq_set_lldp_mib(hw, mib_type, (void *)lldpmib, miblen, NULL);
+	} else {
+		ice_dcb_cfg_to_lldp(lldpmib, &miblen, dcbcfg, ICE_SET_PFC_RX);
+		ret = ice_aq_set_lldp_mib(hw, mib_type, (void *)lldpmib, miblen, NULL);
+		ice_dcb_cfg_to_lldp(lldpmib, &miblen, dcbcfg, ICE_SET_PFC_TX);
+		ret = ice_aq_set_lldp_mib(hw, mib_type, (void *)lldpmib, miblen, NULL);
+	}
 
 	ice_free(hw, lldpmib);
 
diff --git a/drivers/net/intel/ice/base/ice_dcb.h b/drivers/net/intel/ice/base/ice_dcb.h
index c2c48ae8bb..3d3ad4b650 100644
--- a/drivers/net/intel/ice/base/ice_dcb.h
+++ b/drivers/net/intel/ice/base/ice_dcb.h
@@ -21,10 +21,17 @@
 #define ICE_TLV_TYPE_ORG		127
 
 #define ICE_IEEE_8021QAZ_OUI		0x0080C2
+#define ICE_IEEE_8021QAZ_OUI_ASYM	0xffffff
 #define ICE_IEEE_SUBTYPE_ETS_CFG	9
+#define ICE_IEEE_SUBTYPE_ETS_CFG_RX	0x89
+#define ICE_IEEE_SUBTYPE_ETS_CFG_TX	0x99
 #define ICE_IEEE_SUBTYPE_ETS_REC	10
 #define ICE_IEEE_SUBTYPE_PFC_CFG	11
+#define ICE_IEEE_SUBTYPE_PFC_CFG_RX	0x8B
+#define ICE_IEEE_SUBTYPE_PFC_CFG_TX	0x9B
 #define ICE_IEEE_SUBTYPE_APP_PRI	12
+#define ICE_IEEE_SUBTYPE_APP_PRI_RX	0x8C
+#define ICE_IEEE_SUBTYPE_APP_PRI_TX	0x9C
 
 #define ICE_CEE_DCBX_OUI		0x001B21
 #define ICE_CEE_DCBX_TYPE		2
@@ -188,6 +195,12 @@ struct ice_dcbx_variables {
 	u32 deftsaassignment;
 };
 
+enum ice_dcb_pfc_asym_mode {
+	ICE_SET_PFC_SYM = 0,
+	ICE_SET_PFC_RX,
+	ICE_SET_PFC_TX
+};
+
 int
 ice_aq_get_lldp_mib(struct ice_hw *hw, u8 bridge_type, u8 mib_type, void *buf,
 		    u16 buf_size, u16 *local_len, u16 *remote_len,
@@ -208,7 +221,8 @@ int ice_set_dcb_cfg(struct ice_port_info *pi);
 void ice_get_dcb_cfg_from_mib_change(struct ice_port_info *pi,
 				     struct ice_rq_event_info *event);
 int ice_init_dcb(struct ice_hw *hw, bool enable_mib_change);
-void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg);
+void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode);
 int
 ice_query_port_ets(struct ice_port_info *pi,
 		   struct ice_aqc_port_ets_elem *buf, u16 buf_size,
diff --git a/drivers/net/intel/ice/base/ice_type.h b/drivers/net/intel/ice/base/ice_type.h
index ae3b944d6e..e4b3efc157 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -1183,6 +1183,8 @@ struct ice_dcb_pfc_cfg {
 	u8 mbc;
 	u8 pfccap;
 	u8 pfcena;
+	u8 pfcena_asym_rx;
+	u8 pfcena_asym_tx;
 };
 
 /* CEE or IEEE 802.1Qaz Application Priority data */
-- 
2.43.0

