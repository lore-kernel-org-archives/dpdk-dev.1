Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F368C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:04:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5BD240E3E;
	Wed, 23 Apr 2025 18:00:52 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 3F38440DD5
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:41 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 93B52E032D;
 Wed, 23 Apr 2025 20:00:40 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 93B52E032D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424041;
 bh=mFfQ+Cp4rRVLQbFE3dWGPTuLUV+K4DrP+I5dDehgOPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AeJ6WLLeAywMq/uAN9ec18CtrWvGxvYmAZ/lNFjmfRyAzU5FIiwi7O3ehxkGl10aD
 UR98yeqAhd/Ec7KXueMYPsbR3iWz+5bkZkx6V5vGZWAIIiERyXLyOL3+40UUHT46Wf
 uzyQYOZAI8wWstuaNSi5Zy60dwjulAv+QxO3d8gwfnY550Rub/Ch0BzFQWnSsVE8Ay
 3VWd8sITJdVtRp5+cKRaBaKKUwb981FgOL1a9canwG+mVSx9z4My+D6gQLqDlrDQ5P
 zcIIfwIpJ8C+dBoTfmSOma0HLyrgSyj9x52dNDV9rSx4cUlpxFEH8XBfCdXd56kiV6
 VKoOGNG9qZGOw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 35/45] common/sfc_efx/base: implement MAC PDU controls for
 Medford4
Date: Wed, 23 Apr 2025 19:59:52 +0400
Message-Id: <20250423160002.35706-36-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

Leverage new netport MCDI to implement support for such APIs.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_impl.h      |  4 ++
 drivers/common/sfc_efx/base/efx_mac.c       |  4 +-
 drivers/common/sfc_efx/base/efx_np.c        | 17 ++++++++
 drivers/common/sfc_efx/base/medford4_impl.h | 11 ++++++
 drivers/common/sfc_efx/base/medford4_mac.c  | 44 +++++++++++++++++++++
 5 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 7dbad601ff..43964ccdba 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1934,6 +1934,7 @@ efx_np_link_state(
 
 typedef struct efx_np_mac_state_s {
 	uint32_t	enms_fcntl;
+	uint32_t	enms_pdu;
 	boolean_t	enms_up;
 } efx_np_mac_state_t;
 
@@ -1956,9 +1957,12 @@ efx_np_link_ctrl(
 	__in		boolean_t fcntl_an);
 
 typedef struct efx_np_mac_ctrl_s {
+	boolean_t	enmc_set_pdu_only;
+
 	boolean_t	enmc_fcntl_autoneg;
 	boolean_t	enmc_include_fcs;
 	uint32_t	enmc_fcntl;
+	uint32_t	enmc_pdu;
 } efx_np_mac_ctrl_t;
 
 LIBEFX_INTERNAL
diff --git a/drivers/common/sfc_efx/base/efx_mac.c b/drivers/common/sfc_efx/base/efx_mac.c
index 92585517c0..9a0cf64fd9 100644
--- a/drivers/common/sfc_efx/base/efx_mac.c
+++ b/drivers/common/sfc_efx/base/efx_mac.c
@@ -94,8 +94,8 @@ static const efx_mac_ops_t	__efx_mac_medford4_ops = {
 	medford4_mac_poll,			/* emo_poll */
 	medford4_mac_up,			/* emo_up */
 	ef10_mac_addr_set,			/* emo_addr_set */
-	ef10_mac_pdu_set,			/* emo_pdu_set */
-	ef10_mac_pdu_get,			/* emo_pdu_get */
+	medford4_mac_pdu_set,			/* emo_pdu_set */
+	medford4_mac_pdu_get,			/* emo_pdu_get */
 	medford4_mac_reconfigure,		/* emo_reconfigure */
 	ef10_mac_multicast_list_set,		/* emo_multicast_list_set */
 	ef10_mac_filter_default_rxq_set,	/* emo_filter_default_rxq_set */
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index d54174332e..2e2043b520 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -801,6 +801,7 @@ efx_np_attach(
 	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
 	efx_port_t *epp = &(enp->en_port);
 	efx_np_link_state_t ls;
+	efx_np_mac_state_t ms;
 	efx_rc_t rc;
 
 	if (efx_np_supported(enp) == B_FALSE)
@@ -852,8 +853,16 @@ efx_np_attach(
 		goto fail4;
 #endif /* EFSYS_OPT_MAC_STATS */
 
+	rc = efx_np_mac_state(enp, epp->ep_np_handle, &ms);
+	if (rc != 0)
+		goto fail5;
+
+	epp->ep_mac_pdu = ms.enms_pdu;
 	return (0);
 
+fail5:
+	EFSYS_PROBE(fail5);
+
 #if EFSYS_OPT_MAC_STATS
 fail4:
 	EFSYS_PROBE(fail4);
@@ -915,6 +924,7 @@ efx_np_mac_state(
 	if (MCDI_OUT_DWORD(req, MAC_STATE_OUT_MAC_FAULT_FLAGS) == 0)
 		msp->enms_up = B_TRUE;
 
+	msp->enms_pdu = MCDI_OUT_DWORD(req, MAC_STATE_OUT_MAX_FRAME_LEN);
 	msp->enms_fcntl = MCDI_OUT_DWORD(req, MAC_STATE_OUT_FCNTL);
 	return (0);
 
@@ -1210,6 +1220,12 @@ efx_np_mac_ctrl(
 
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_PORT_HANDLE, nph);
 
+	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_MAX_FRAME_LEN, mc->enmc_pdu);
+	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_MAX_FRAME_LEN;
+
+	if (mc->enmc_set_pdu_only != B_FALSE)
+		goto skip_full_reconfigure;
+
 	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS;
 	if (mc->enmc_include_fcs != B_FALSE)
 		flags |= 1U << MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS;
@@ -1241,6 +1257,7 @@ efx_np_mac_ctrl(
 	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
 
+skip_full_reconfigure:
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_V2_CONTROL_FLAGS, cfg);
 
 	efx_mcdi_execute(enp, &req);
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index 94d076db95..e861b3e7de 100644
--- a/drivers/common/sfc_efx/base/medford4_impl.h
+++ b/drivers/common/sfc_efx/base/medford4_impl.h
@@ -51,6 +51,17 @@ medford4_mac_up(
 	__in		efx_nic_t *enp,
 	__out		boolean_t *mac_upp);
 
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_mac_pdu_set(
+	__in		efx_nic_t *enp);
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+medford4_mac_pdu_get(
+	__in		efx_nic_t *enp,
+	__out		size_t *pdup);
+
 LIBEFX_INTERNAL
 extern	__checkReturn		efx_rc_t
 medford4_mac_reconfigure(
diff --git a/drivers/common/sfc_efx/base/medford4_mac.c b/drivers/common/sfc_efx/base/medford4_mac.c
index 3e2493e824..8ef84c69c6 100644
--- a/drivers/common/sfc_efx/base/medford4_mac.c
+++ b/drivers/common/sfc_efx/base/medford4_mac.c
@@ -47,6 +47,49 @@ medford4_mac_up(
 	*mac_upp = els.els_mac_up;
 	return (0);
 
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn	efx_rc_t
+medford4_mac_pdu_set(
+	__in		efx_nic_t *enp)
+{
+	efx_port_t *epp = &(enp->en_port);
+	efx_np_mac_ctrl_t mc = {0};
+	efx_rc_t rc;
+
+	mc.enmc_set_pdu_only = B_TRUE;
+	mc.enmc_pdu = epp->ep_mac_pdu;
+
+	rc = efx_np_mac_ctrl(enp, epp->ep_np_handle, &mc);
+	if (rc != 0)
+		goto fail1;
+
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn	efx_rc_t
+medford4_mac_pdu_get(
+	__in		efx_nic_t *enp,
+	__out		size_t *pdup)
+{
+	efx_port_t *epp = &(enp->en_port);
+	efx_np_mac_state_t ms;
+	efx_rc_t rc;
+
+	rc = efx_np_mac_state(enp, epp->ep_np_handle, &ms);
+	if (rc != 0)
+		goto fail1;
+
+	*pdup = ms.enms_pdu;
+	return (0);
+
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
@@ -63,6 +106,7 @@ medford4_mac_reconfigure(
 	mc.enmc_fcntl_autoneg = epp->ep_fcntl_autoneg;
 	mc.enmc_include_fcs = epp->ep_include_fcs;
 	mc.enmc_fcntl = epp->ep_fcntl;
+	mc.enmc_pdu = epp->ep_mac_pdu;
 
 	rc = efx_np_mac_ctrl(enp, epp->ep_np_handle, &mc);
 	if (rc != 0)
-- 
2.39.5

