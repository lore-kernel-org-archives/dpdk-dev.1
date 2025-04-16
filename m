Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF870C369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95196427D3;
	Wed, 16 Apr 2025 16:01:09 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EA4B34279F
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 3DCE4E11BF;
 Wed, 16 Apr 2025 18:01:00 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 3DCE4E11BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812060;
 bh=3Ie4qIMmpEK+wSgJcBMum77GS++6jT7m/IV8enssNJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TcUn8DYT6G11SIlTEn6c8XsSyYN6C1jlZVPWQGF3Xd/+qCyam1YFfyY5yCYwuO86j
 7T2KbZNw4LRjLFB5Bi6g4E3mQUpOmpt5cOAtIiOFInuBtIuBes3t6edv2+0XqxkUNF
 AKa1WYPiF10bcG6gHUgsovKNhIU+a/3p2xI0BRFlM9bNRnww4ESVsez8ghjYH2vCL+
 BGd/eTUgcRt9pJ8zMJjkMjxtJixOd0jXF+t1z7hd6BJn3b+aPWvHvMQqaE1XIZ/uIR
 nCLqpLnQZNZvktzp/Q5XJadhbiGztNNI8xWwKST+L4QpJrVFgHeUQJKalBxq/41CQN
 9uhR6crdyoKbg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 36/46] common/sfc_efx/base: implement MAC PDU controls for
 Medford4
Date: Wed, 16 Apr 2025 18:00:06 +0400
Message-Id: <20250416140016.36127-37-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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
index f002cb838e..8712d7c5ef 100644
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
index df836f09a6..88e13f0df9 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -816,6 +816,7 @@ efx_np_attach(
 	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
 	efx_port_t *epp = &(enp->en_port);
 	efx_np_link_state_t ls;
+	efx_np_mac_state_t ms;
 	efx_rc_t rc;
 
 	if (efx_np_supported(enp) == B_FALSE)
@@ -867,8 +868,16 @@ efx_np_attach(
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
@@ -930,6 +939,7 @@ efx_np_mac_state(
 	if (MCDI_OUT_DWORD(req, MAC_STATE_OUT_MAC_FAULT_FLAGS) == 0)
 		msp->enms_up = B_TRUE;
 
+	msp->enms_pdu = MCDI_OUT_DWORD(req, MAC_STATE_OUT_MAX_FRAME_LEN);
 	msp->enms_fcntl = MCDI_OUT_DWORD(req, MAC_STATE_OUT_FCNTL);
 	return (0);
 
@@ -1242,6 +1252,12 @@ efx_np_mac_ctrl(
 
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
@@ -1273,6 +1289,7 @@ efx_np_mac_ctrl(
 	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
 
+skip_full_reconfigure:
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_V2_CONTROL_FLAGS, cfg);
 
 	efx_mcdi_execute(enp, &req);
diff --git a/drivers/common/sfc_efx/base/medford4_impl.h b/drivers/common/sfc_efx/base/medford4_impl.h
index cc45431a81..b9be5e4e82 100644
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
index bc55604017..1390752e1e 100644
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

