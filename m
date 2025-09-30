Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E4CCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 11:21:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5BCC540B8C;
	Tue, 30 Sep 2025 13:21:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 4499240674
 for <dev@dpdk.org>; Tue, 30 Sep 2025 13:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759231286; x=1790767286;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P9KnQlvlqJMY2dhiaKvwrVRUnhcsrt/mVY2EhV4I4n4=;
 b=DugIQTySTszf6VWenYi1Kt/14K2a1WVm/2OUKLe70zeEne1+DrrO6ifS
 i/7tlKsbBsADotMBTCfgzMjstIEr/6mUWUQPqjB8oAFNXJmqYyJSopcWg
 W8FRpwHEVeBUS0sYINTpVHnrqn/IrSeuJAv+CTziL6/at7ll79y+VKP2D
 vFosdwlzZUQriVTsNbSFc2lTSagYb8BmRTh/qawoJXX1SJwmf2WwLTxPh
 2q4s6TYy/JTQISUv/qOGswt/e0gBs99eBunUj9UWiKlJ92opnDOr+Cxq5
 iil+HwDlGNb+aPxTHVpIbbPli/ewVa7UpgxD7Ey8AkSVkrNcx0m7AtOI0 A==;
X-CSE-ConnectionGUID: +275t0YARDi/IodH+uViEA==
X-CSE-MsgGUID: 4gDIeYsdQomG3+BVb+sUPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="86927965"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="86927965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2025 04:21:25 -0700
X-CSE-ConnectionGUID: a85TJuTKRPm9Ey50rwL5jQ==
X-CSE-MsgGUID: RvM+QDsEQ4+aH2xq8YEzDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; d="scan'208";a="179265273"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2025 04:21:25 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: vladimir.medvedkin@intel.com
Subject: [PATCH v1 4/4] net/ice/base: add support for asymmetric PFC
Date: Tue, 30 Sep 2025 12:21:17 +0100
Message-ID: <f0d9415149867e2153ac4fce3a208bd4b0b57ef2.1759231103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759231103.git.anatoly.burakov@intel.com>
References: 
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

From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Current implementation only supports symmetric PFC configuration. Add
two more bitmasks to ice_dcb_pfc_cfg to support asymmetric PFC.

Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_dcb.c  | 105 ++++++++++++++++++++++----
 drivers/net/intel/ice/base/ice_dcb.h  |  16 +++-
 drivers/net/intel/ice/base/ice_type.h |   2 +
 3 files changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_dcb.c b/drivers/net/intel/ice/base/ice_dcb.c
index e97f35b4cf..607af03525 100644
--- a/drivers/net/intel/ice/base/ice_dcb.c
+++ b/drivers/net/intel/ice/base/ice_dcb.c
@@ -1129,11 +1129,13 @@ ice_add_ieee_ets_common_tlv(u8 *buf, struct ice_dcb_ets_cfg *ets_cfg)
  * ice_add_ieee_ets_tlv - Prepare ETS TLV in IEEE format
  * @tlv: Fill the ETS config data in IEEE format
  * @dcbcfg: Local store which holds the DCB Config
+ * @pfc_asym_mode: PFC symmetry mode
  *
  * Prepare IEEE 802.1Qaz ETS CFG TLV
  */
 static void
-ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
+ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	struct ice_dcb_ets_cfg *etscfg;
 	u8 *buf = tlv->tlvinfo;
@@ -1145,8 +1147,22 @@ ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
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
@@ -1162,6 +1178,9 @@ ice_add_ieee_ets_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 	maxtcwilling |= etscfg->maxtcs & ICE_IEEE_ETS_MAXTC_M;
 	buf[0] = maxtcwilling;
 
+	if (pfc_asym_mode == ICE_SET_PFC_TX)
+		etscfg = &dcbcfg->etsrec;
+
 	/* Begin adding at Priority Assignment Table (offset 1 in buf) */
 	ice_add_ieee_ets_common_tlv(&buf[1], etscfg);
 }
@@ -1201,11 +1220,13 @@ ice_add_ieee_etsrec_tlv(struct ice_lldp_org_tlv *tlv,
  * ice_add_ieee_pfc_tlv - Prepare PFC TLV in IEEE format
  * @tlv: Fill PFC TLV in IEEE format
  * @dcbcfg: Local store which holds the PFC CFG data
+ * @pfc_asym_mode: PFC symmetry mode
  *
  * Prepare IEEE 802.1Qaz PFC CFG TLV
  */
 static void
-ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
+ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	u8 *buf = tlv->tlvinfo;
 	u32 ouisubtype;
@@ -1215,8 +1236,22 @@ ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
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
@@ -1233,18 +1268,24 @@ ice_add_ieee_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
 
 	buf[0] |= dcbcfg->pfc.pfccap & 0xF;
 	buf[1] = dcbcfg->pfc.pfcena;
+	if (pfc_asym_mode == ICE_SET_PFC_RX)
+		buf[1] |= dcbcfg->pfc.pfcena_asym_rx;
+	if (pfc_asym_mode == ICE_SET_PFC_TX)
+		buf[1] |= dcbcfg->pfc.pfcena_asym_tx;
 }
 
 /**
  * ice_add_ieee_app_pri_tlv -  Prepare APP TLV in IEEE format
  * @tlv: Fill APP TLV in IEEE format
  * @dcbcfg: Local store which holds the APP CFG data
+ * @pfc_asym_mode: PFC symmetry mode
  *
  * Prepare IEEE 802.1Qaz APP CFG TLV
  */
 static void
 ice_add_ieee_app_pri_tlv(struct ice_lldp_org_tlv *tlv,
-			 struct ice_dcbx_cfg *dcbcfg)
+			 struct ice_dcbx_cfg *dcbcfg,
+			enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	u16 typelen, len, offset = 0;
 	u8 priority, selector, i = 0;
@@ -1254,8 +1295,23 @@ ice_add_ieee_app_pri_tlv(struct ice_lldp_org_tlv *tlv,
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
@@ -1424,26 +1480,27 @@ ice_add_dscp_pfc_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg)
  * @tlv: Fill TLV data in IEEE format
  * @dcbcfg: Local store which holds the DCB Config
  * @tlvid: Type of IEEE TLV
+ * @pfc_asym_mode: PFC symmetry mode
  *
  * Add tlv information
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
@@ -1474,10 +1531,12 @@ ice_add_dcb_tlv(struct ice_lldp_org_tlv *tlv, struct ice_dcbx_cfg *dcbcfg,
  * @lldpmib: pointer to the HW struct
  * @miblen: length of LLDP MIB
  * @dcbcfg: Local store which holds the DCB Config
+ * @pfc_asym_mode: PFC mode with respect to PAUSE frames direction
  *
  * Convert the DCB configuration to MIB format
  */
-void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg)
+void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg,
+	enum ice_dcb_pfc_asym_mode pfc_asym_mode)
 {
 	u16 len, offset = 0, tlvid = ICE_TLV_ID_START;
 	struct ice_lldp_org_tlv *tlv;
@@ -1485,7 +1544,12 @@ void ice_dcb_cfg_to_lldp(u8 *lldpmib, u16 *miblen, struct ice_dcbx_cfg *dcbcfg)
 
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
@@ -1532,9 +1596,20 @@ int ice_set_dcb_cfg(struct ice_port_info *pi)
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
+		if (ret) {
+			ice_free(hw, lldpmib);
+			return ret;
+		}
+
+		ice_dcb_cfg_to_lldp(lldpmib, &miblen, dcbcfg, ICE_SET_PFC_TX);
+		ret = ice_aq_set_lldp_mib(hw, mib_type, (void *)lldpmib, miblen, NULL);
+	}
 
 	ice_free(hw, lldpmib);
 
diff --git a/drivers/net/intel/ice/base/ice_dcb.h b/drivers/net/intel/ice/base/ice_dcb.h
index c2c48ae8bb..fdefe54011 100644
--- a/drivers/net/intel/ice/base/ice_dcb.h
+++ b/drivers/net/intel/ice/base/ice_dcb.h
@@ -21,10 +21,17 @@
 #define ICE_TLV_TYPE_ORG		127
 
 #define ICE_IEEE_8021QAZ_OUI		0x0080C2
+#define ICE_IEEE_8021QAZ_OUI_ASYM	0xFFFFFFUL
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
index b2e1bfeca1..4b05a800af 100644
--- a/drivers/net/intel/ice/base/ice_type.h
+++ b/drivers/net/intel/ice/base/ice_type.h
@@ -1196,6 +1196,8 @@ struct ice_dcb_pfc_cfg {
 	u8 mbc;
 	u8 pfccap;
 	u8 pfcena;
+	u8 pfcena_asym_rx;
+	u8 pfcena_asym_tx;
 };
 
 /* CEE or IEEE 802.1Qaz Application Priority data */
-- 
2.47.3

