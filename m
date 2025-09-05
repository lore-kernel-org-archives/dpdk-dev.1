Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C517CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 14:45:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E13174066F;
	Fri,  5 Sep 2025 16:45:30 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 41ACC402E5
 for <dev@dpdk.org>; Fri,  5 Sep 2025 16:45:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.74.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 9DBD8E0FB0;
 Fri,  5 Sep 2025 18:45:25 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 9DBD8E0FB0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1757083526;
 bh=5if4vU7uZsnLF9lxC+l/pWCryqYsMBGCJ9yzE+OBFgs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=akM3bfND/sJlFX3C/hgAB1m+UjjQuVa7o5leW4ttTogVsQzdjgxCbZM2xiEFDo8gk
 s0P33THKWBrMIuXSoDkD7jrnGsXbiS5sRsv0bNCS9kZDKRMdaOhDYKDopkdbxQhzOV
 Wq8PvIjG60EZptI8TDziCsPqaFFqTTMJTtPhKULOOmODry7bQmW6/OvoC/x3vUGXVe
 z0ohMuZRq+M9qrP10DntLZZFuWJlbp0H/rFO+pWnBf7KhxmkUOVQs1P1YE1L9pFNlD
 4EN0LZ+rfxzrPMT4AT4vR6y07z2n9UiO1Ga9ES2r3MG4HsJUuFAE1Uixtov2+4oD9t
 q/BMbhnvptF3A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 4/4] common/sfc_efx/base: use saved netport FEC choice by
 default
Date: Fri,  5 Sep 2025 18:45:14 +0400
Message-ID: <20250905144514.11698-5-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905144514.11698-1-ivan.malov@arknetworks.am>
References: <20250905144514.11698-1-ivan.malov@arknetworks.am>
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

When the client driver starts the port, it invokes 'efx_port_init' API. At
this stage, libefx has no way of knowing whether the driver will prefer to
keep the existing link or revise, say, FEC mode. So if the current link is
up, it is better to leave it alone. This way, if the driver does not tweak
FEC mode with 'efx_phy_adv_cap_set' later on, the link will likely stay up.

Save the last FEC choice (select 'AUTO' on attach) and apply it by default.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_impl.h     |  6 ++++
 drivers/common/sfc_efx/base/efx_np.c       | 42 ++++++++++++++++++----
 drivers/common/sfc_efx/base/efx_phy.c      |  4 +++
 drivers/common/sfc_efx/base/efx_port.c     |  1 +
 drivers/common/sfc_efx/base/medford4_phy.c |  1 +
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 69268546d2..c91fbbb61b 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -398,6 +398,10 @@ typedef struct efx_port_s {
 	efx_np_stat_t		ep_np_mac_stat_lut[EFX_MAC_NSTATS];
 	/* Client-requested lane count for the physical link. */
 	efx_phy_lane_count_t	ep_np_lane_count_req;
+	/* If 'B_TRUE', the client has not invoked 'efx_phy_adv_cap_set' yet. */
+	boolean_t		ep_np_keep_prev_fec_ctrl;
+	/* It's 'AUTO' on driver attach. Updated on each 'LINK_CTRL' call. */
+	uint8_t			ep_np_prev_fec_ctrl;
 } efx_port_t;
 
 typedef struct efx_mon_ops_s {
@@ -1957,6 +1961,8 @@ efx_np_link_ctrl(
 	__in		efx_link_mode_t loopback_link_mode,
 	__in		efx_loopback_type_t loopback_mode,
 	__in		efx_phy_lane_count_t lane_count,
+	__in		boolean_t keep_prev_fec_ctrl,
+	__inout		uint8_t *prev_fec_ctrlp,
 	__in		uint32_t cap_mask_sw,
 	__in		boolean_t fcntl_an);
 
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 54305ee61e..327981f0db 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1026,6 +1026,12 @@ efx_np_attach(
 	/* For faster link up, use autoneg. flow control by default. */
 	epp->ep_fcntl_autoneg = B_TRUE;
 
+	/*
+	 * We have no way of knowing which 'FEC_MODE' choice the previous
+	 * client driver passed via 'LINK_CTRL'. Assume 'AUTO' by default.
+	 */
+	epp->ep_np_prev_fec_ctrl = MC_CMD_FEC_AUTO;
+
 	/* Subscribe to link change events. */
 	rc = efx_np_set_event_mask(enp, epp->ep_np_handle, B_TRUE);
 	if (rc != 0)
@@ -1277,6 +1283,8 @@ efx_np_link_ctrl(
 	__in		efx_link_mode_t loopback_link_mode,
 	__in		efx_loopback_type_t loopback_mode,
 	__in		efx_phy_lane_count_t lane_count,
+	__in		boolean_t keep_prev_fec_ctrl,
+	__inout		uint8_t *prev_fec_ctrlp,
 	__in		uint32_t cap_mask_sw,
 	__in		boolean_t fcntl_an)
 {
@@ -1380,13 +1388,34 @@ efx_np_link_ctrl(
 	 *
 	 * No requested FEC bits in the original mask gives supported=TRUE.
 	 */
-	EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
-	    ETH_AN_FIELDS_FEC_REQ, cap_data_raw, cap_mask_sw,
-	    NULL, NULL, &supported, &cap_enum_hw);
+	if (keep_prev_fec_ctrl == B_FALSE) {
+		/*
+		 * Enforce what the user has asked for. If the mask has got
+		 * no 'FEC_REQUESTED' bits, use 'NONE' or 'AUTO' from above.
+		 */
+		EFX_NP_CAP_SW_MASK_TO_HW_ENUM(efx_np_cap_map_fec_req,
+		    ETH_AN_FIELDS_FEC_REQ, cap_data_raw, cap_mask_sw,
+		    NULL, NULL, &supported, &cap_enum_hw);
 
-	if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0 && supported == B_FALSE) {
-		rc = ENOTSUP;
-		goto fail5;
+		if ((cap_mask_sw & EFX_PHY_CAP_FEC_MASK) != 0
+		    && supported == B_FALSE) {
+			rc = ENOTSUP;
+			goto fail5;
+		}
+	} else {
+		/*
+		 * At this stage, the FEC mask does not draw any input from
+		 * the client driver. If the active link was autonegotiated,
+		 * it might contain 'FEC_REQUESTED' bits translated earlier
+		 * from 'ADVERTISED_ABILITIES_FEC_REQ' of 'LINK_STATE' MCDI.
+		 * If the link is fixed, it does not have any of these bits.
+		 *
+		 * Either way, translating it into a fixed enum will result
+		 * in a fixed FEC choice. If that does not match the choice
+		 * of the previous user, a lengthy link renegotiation might
+		 * follow. Pass previous choice to avoid long link-up times.
+		 */
+		cap_enum_hw = *prev_fec_ctrlp;
 	}
 
 	EFSYS_ASSERT(cap_enum_hw <= UINT8_MAX);
@@ -1404,6 +1433,7 @@ efx_np_link_ctrl(
 		goto fail6;
 	}
 
+	*prev_fec_ctrlp = fec;
 	return (0);
 
 fail6:
diff --git a/drivers/common/sfc_efx/base/efx_phy.c b/drivers/common/sfc_efx/base/efx_phy.c
index 1f99c72e62..1f1552ce1f 100644
--- a/drivers/common/sfc_efx/base/efx_phy.c
+++ b/drivers/common/sfc_efx/base/efx_phy.c
@@ -251,6 +251,7 @@ efx_phy_adv_cap_set(
 {
 	efx_port_t *epp = &(enp->en_port);
 	const efx_phy_ops_t *epop = epp->ep_epop;
+	boolean_t old_np_keep_prev_fec_ctrl;
 	uint32_t old_mask;
 	efx_rc_t rc;
 
@@ -271,6 +272,8 @@ efx_phy_adv_cap_set(
 	if (epp->ep_adv_cap_mask == mask)
 		goto done;
 
+	old_np_keep_prev_fec_ctrl = epp->ep_np_keep_prev_fec_ctrl;
+	epp->ep_np_keep_prev_fec_ctrl = B_FALSE;
 	old_mask = epp->ep_adv_cap_mask;
 	epp->ep_adv_cap_mask = mask;
 
@@ -283,6 +286,7 @@ efx_phy_adv_cap_set(
 fail3:
 	EFSYS_PROBE(fail3);
 
+	epp->ep_np_keep_prev_fec_ctrl = old_np_keep_prev_fec_ctrl;
 	epp->ep_adv_cap_mask = old_mask;
 	/* Reconfigure for robustness */
 	if (epop->epo_reconfigure(enp) != 0) {
diff --git a/drivers/common/sfc_efx/base/efx_port.c b/drivers/common/sfc_efx/base/efx_port.c
index 7e514e92dd..5ae5e144bd 100644
--- a/drivers/common/sfc_efx/base/efx_port.c
+++ b/drivers/common/sfc_efx/base/efx_port.c
@@ -27,6 +27,7 @@ efx_port_init(
 	enp->en_mod_flags |= EFX_MOD_PORT;
 
 	epp->ep_np_lane_count_req = EFX_PHY_LANE_COUNT_DEFAULT;
+	epp->ep_np_keep_prev_fec_ctrl = B_TRUE;
 	epp->ep_mac_type = EFX_MAC_INVALID;
 	epp->ep_link_mode = EFX_LINK_UNKNOWN;
 	epp->ep_mac_drain = B_TRUE;
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index 9ba6dfbc10..ef7e4e5bac 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -117,6 +117,7 @@ medford4_phy_reconfigure(
 
 	rc = efx_np_link_ctrl(enp, epp->ep_np_handle, epp->ep_np_cap_data_raw,
 		    loopback_link_mode, loopback, epp->ep_np_lane_count_req,
+		    epp->ep_np_keep_prev_fec_ctrl, &epp->ep_np_prev_fec_ctrl,
 		    epp->ep_adv_cap_mask, epp->ep_fcntl_autoneg);
 	if (rc != 0)
 		goto fail2;
-- 
2.47.2

