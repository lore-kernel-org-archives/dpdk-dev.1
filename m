Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D17C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:25:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1394F40E22;
	Mon,  9 Jun 2025 12:25:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6D15240E0C
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464746; x=1781000746;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zrVX0PnwXf89gGthN0jmR4vVKidJvs2hu20icQxjvkA=;
 b=klhJuQ5wlMOhZT7VoCn68AYTpJTD6XF580IWY60tUqbTM189TDuYvPOI
 P9WU6mBkQoo/a+yWTrHjYUkXaebxZ4iKaS71EXqCF8D5hTvCMpaHwemqD
 GIyTDCevdZ8qnV1ZNGR6/068ROw1OMelOGJBMJ+fegkZAbZ4cFwP4u/lI
 UJ7J0Nla/KLCN+PjT/BLl4KVOsbRRjj0FPh+bkzyZzFxuhAPSeW8yXXWv
 9LWpD93tCHvZzNq4dP+tEt7iiPK3z8vioRSSwomx2Ov04095HMvX+frkY
 gnxITJjZB4e1wt5SyWgPiAXERUjrGAk2+2Rkksm+gLUWsvJxtgti3r6BC g==;
X-CSE-ConnectionGUID: coo0PDIDQoGnSGSDpuwn1w==
X-CSE-MsgGUID: 8UKMZY6GTge1t953y8TjzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="51448508"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="51448508"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:25:46 -0700
X-CSE-ConnectionGUID: JJZ2vc46TRyJ45FjOBk9bA==
X-CSE-MsgGUID: AB/LArUEQJmyWpOOHAkgQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="146356434"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa006.fm.intel.com with ESMTP; 09 Jun 2025 03:25:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 2/5] net/ixgbe: add VF mailbox op for link status
Date: Mon,  9 Jun 2025 11:25:35 +0100
Message-ID: <a7aeadb986cdadb0d93a3e06d8c25dd44e2f5c7c.1749464704.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464704.git.anatoly.burakov@intel.com>
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

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

E610 adapter no longer uses the VFLINKS register to read PF's link speed
and linkup state. Currently this leads to mismatch between actual link
status and that what VF driver shows to the OS.

Add new mailbox operation to let the VF driver request the PF driver
to provide the actual link data. Update the mailbox api to v1.6.

Incorporate both ways of getting link status within the legacy
ixgbe_check_mac_link_vf() function.

Signed-off-by: Andrzej Wilczynski <andrzejx.wilczynski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/base/ixgbe_mbx.h |   4 +
 drivers/net/intel/ixgbe/base/ixgbe_vf.c  | 126 ++++++++++++++++++-----
 drivers/net/intel/ixgbe/base/ixgbe_vf.h  |   2 +
 3 files changed, 105 insertions(+), 27 deletions(-)

diff --git a/drivers/net/intel/ixgbe/base/ixgbe_mbx.h b/drivers/net/intel/ixgbe/base/ixgbe_mbx.h
index 434f7c6a69..e3b4338fb1 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_mbx.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_mbx.h
@@ -101,6 +101,7 @@ enum ixgbe_pfvf_api_rev {
 	/* API 1.4 is being used in the upstream for IPsec */
 	ixgbe_mbox_api_14,	/* API version 1.4, linux/freebsd VF driver */
 	ixgbe_mbox_api_15,	/* API version 1.5, linux/freebsd VF driver */
+	ixgbe_mbox_api_16,	/* API version 1.6, linux/freebsd VF driver */
 	/* This value should always be last */
 	ixgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -125,6 +126,9 @@ enum ixgbe_pfvf_api_rev {
 #define IXGBE_VF_UPDATE_XCAST_MODE	0x0c
 #define IXGBE_VF_GET_LINK_STATE 0x10 /* get vf link state */
 
+/* mailbox API, version 1.6 VF requests */
+#define IXGBE_VF_GET_PF_LINK_STATE 0x11 /* get status of the link on PF */
+
 /* mode choices for IXGBE_VF_UPDATE_XCAST_MODE */
 enum ixgbevf_xcast_modes {
 	IXGBEVF_XCAST_MODE_NONE = 0,
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_vf.c b/drivers/net/intel/ixgbe/base/ixgbe_vf.c
index 37556a9300..46a62bb851 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_vf.c
+++ b/drivers/net/intel/ixgbe/base/ixgbe_vf.c
@@ -409,6 +409,7 @@ s32 ixgbevf_update_xcast_mode(struct ixgbe_hw *hw, int xcast_mode)
 		/* Fall through */
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return IXGBE_ERR_FEATURE_NOT_SUPPORTED;
@@ -455,6 +456,47 @@ s32 ixgbe_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
 	return ret_val;
 }
 
+/**
+ * ixgbevf_get_pf_link_state - Get PF's link status
+ * @hw: pointer to the HW structure
+ * @speed - link speed
+ * @link_up - indicate if link is up/down
+ *
+ * Ask PF to provide link_up state and speed of the link.
+ *
+ * Return: IXGBE_ERR_MBX in the  case of mailbox error,
+ * IXGBE_ERR_FEATURE_NOT_SUPPORTED if the op is not supported or 0 on success.
+ */
+int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			      bool *link_up)
+{
+	u32 msgbuf[3] = {};
+	int err;
+
+	switch (hw->api_version) {
+	case ixgbe_mbox_api_16:
+		break;
+	default:
+		return IXGBE_ERR_FEATURE_NOT_SUPPORTED;
+	}
+
+	msgbuf[0] = IXGBE_VF_GET_PF_LINK_STATE;
+
+	err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 6);
+	if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
+		err = IXGBE_ERR_MBX;
+		*speed = IXGBE_LINK_SPEED_UNKNOWN;
+		/* No need to set @link_up to false as it will be done in
+		 * ixgbe_check_mac_link_vf().
+		 */
+	} else {
+		*speed = msgbuf[1];
+		*link_up = msgbuf[2];
+	}
+
+	return err;
+}
+
 /**
  * ixgbe_set_vfta_vf - Set/Unset vlan filter table address
  * @hw: pointer to the HW structure
@@ -569,36 +611,25 @@ s32 ixgbe_setup_mac_link_vf(struct ixgbe_hw *hw, ixgbe_link_speed speed,
 }
 
 /**
- * ixgbe_check_mac_link_vf - Get link/speed status
- * @hw: pointer to hardware structure
- * @speed: pointer to link speed
- * @link_up: true is link is up, false otherwise
- * @autoneg_wait_to_complete: true when waiting for completion is needed
+ * ixgbe_read_vflinks - Read VFLINKS register
+ * @hw: pointer to the HW structure
+ * @speed - link speed
+ * @link_up - indicate if link is up/down
  *
- * Reads the links register to determine if link is up and the current speed
- **/
-s32 ixgbe_check_mac_link_vf(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
-			    bool *link_up, bool autoneg_wait_to_complete)
+ * Get linkup status and link speed from the VFLINKS register.
+ */
+static void ixgbe_read_vflinks(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			       bool *link_up)
 {
-	struct ixgbe_mbx_info *mbx = &hw->mbx;
 	struct ixgbe_mac_info *mac = &hw->mac;
-	s32 ret_val = IXGBE_SUCCESS;
-	u32 in_msg = 0;
 	u32 links_reg;
 
-	UNREFERENCED_1PARAMETER(autoneg_wait_to_complete);
-
-	/* If we were hit with a reset drop the link */
-	if (!mbx->ops[0].check_for_rst(hw, 0) || !mbx->timeout)
-		mac->get_link_status = true;
-
-	if (!mac->get_link_status)
-		goto out;
-
 	/* if link status is down no point in checking to see if pf is up */
 	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
-	if (!(links_reg & IXGBE_LINKS_UP))
-		goto out;
+	if (!(links_reg & IXGBE_LINKS_UP)) {
+		*link_up = false;
+		return;
+	}
 
 	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
 	 * before the link status is correct
@@ -610,10 +641,14 @@ s32 ixgbe_check_mac_link_vf(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 			usec_delay(100);
 			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
 
-			if (!(links_reg & IXGBE_LINKS_UP))
-				goto out;
+			if (!(links_reg & IXGBE_LINKS_UP)) {
+				*link_up = false;
+				return;
+			}
 		}
 	}
+	/* We have link at this point */
+	*link_up = true;
 
 	switch (links_reg & IXGBE_LINKS_SPEED_82599) {
 	case IXGBE_LINKS_SPEED_10G_82599:
@@ -628,8 +663,7 @@ s32 ixgbe_check_mac_link_vf(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 		break;
 	case IXGBE_LINKS_SPEED_100_82599:
 		*speed = IXGBE_LINK_SPEED_100_FULL;
-		if (hw->mac.type == ixgbe_mac_X550_vf ||
-		    hw->mac.type == ixgbe_mac_E610_vf) {
+		if (hw->mac.type == ixgbe_mac_X550_vf) {
 			if (links_reg & IXGBE_LINKS_SPEED_NON_STD)
 				*speed = IXGBE_LINK_SPEED_5GB_FULL;
 		}
@@ -643,6 +677,43 @@ s32 ixgbe_check_mac_link_vf(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
 	default:
 		*speed = IXGBE_LINK_SPEED_UNKNOWN;
 	}
+}
+
+/**
+ * ixgbe_check_mac_link_vf - Get link/speed status
+ * @hw: pointer to hardware structure
+ * @speed: pointer to link speed
+ * @link_up: true is link is up, false otherwise
+ * @autoneg_wait_to_complete: true when waiting for completion is needed
+ *
+ * Reads the links register to determine if link is up and the current speed
+ */
+s32 ixgbe_check_mac_link_vf(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			    bool *link_up, bool autoneg_wait_to_complete)
+{
+	struct ixgbe_mbx_info *mbx = &hw->mbx;
+	struct ixgbe_mac_info *mac = &hw->mac;
+	s32 ret_val = IXGBE_SUCCESS;
+	u32 in_msg = 0;
+
+	UNREFERENCED_1PARAMETER(autoneg_wait_to_complete);
+
+	/* If we were hit with a reset drop the link */
+	if (!mbx->ops[0].check_for_rst(hw, 0) || !mbx->timeout)
+		mac->get_link_status = true;
+
+	if (!mac->get_link_status)
+		goto out;
+
+	if (hw->mac.type != ixgbe_mac_E610_vf) {
+		ixgbe_read_vflinks(hw, speed, link_up);
+		if (*link_up == false)
+			goto out;
+	} else {
+		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
+		if (ret_val)
+			goto out;
+	}
 
 	/* if the read failed it could just be a mailbox collision, best wait
 	 * until we are called again and don't report an error
@@ -742,6 +813,7 @@ int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 	case ixgbe_mbox_api_12:
 	case ixgbe_mbox_api_13:
 	case ixgbe_mbox_api_15:
+	case ixgbe_mbox_api_16:
 		break;
 	default:
 		return 0;
diff --git a/drivers/net/intel/ixgbe/base/ixgbe_vf.h b/drivers/net/intel/ixgbe/base/ixgbe_vf.h
index bd10865d57..ca532fae07 100644
--- a/drivers/net/intel/ixgbe/base/ixgbe_vf.h
+++ b/drivers/net/intel/ixgbe/base/ixgbe_vf.h
@@ -113,5 +113,7 @@ s32 ixgbevf_rlpml_set_vf(struct ixgbe_hw *hw, u16 max_size);
 int ixgbevf_negotiate_api_version(struct ixgbe_hw *hw, int api);
 int ixgbevf_get_queues(struct ixgbe_hw *hw, unsigned int *num_tcs,
 		       unsigned int *default_tc);
+int ixgbevf_get_pf_link_state(struct ixgbe_hw *hw, ixgbe_link_speed *speed,
+			      bool *link_up);
 
 #endif /* __IXGBE_VF_H__ */
-- 
2.47.1

