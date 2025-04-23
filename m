Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649CC369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:03:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EC3240BA6;
	Wed, 23 Apr 2025 18:00:40 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 6C93A40A84
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BF509E032D;
 Wed, 23 Apr 2025 20:00:31 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BF509E032D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424032;
 bh=6aOwbhIwjSF5oFyviUraq+XKVSnInBbdDYCsuQer2OA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Pjf6TjoxlmdB6AxJzg+78ar7yyWnlQY5C6yBKX5VyH9kKK3vVNi4eQKAndR5vZxEe
 8XuDUYIcuW3omOPx3V1pza0SZnonsGsYux7LMcA6aCP8BDS08yM1Za/PYmas/drZ6m
 pbvryNe2Va8cQG+8eRjB8RniI9yJUt4+fSqxRsc/Y6qHiOqfnCy8NiQG+O1Hb80s7Z
 n+jHyj6NXIZUj9/YxdEjkwTd8oZRvBup9101wJ2/QhWlycCfmYCwpqG2jSw76BU2Xq
 Tq3bWRqjReYGlWMZYKnSGtPcjcUHQRP0CZWbf2fI1yrKaNGtpoEeePGkRHv6TTilBQ
 sGtHbB2vNrkww==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 24/45] common/sfc_efx/base: decode netport link state on
 probe path
Date: Wed, 23 Apr 2025 19:59:41 +0400
Message-Id: <20250423160002.35706-25-ivan.malov@arknetworks.am>
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

Retrieved properties form the advertised PHY capability mask.
The new code also helps to check support for autonegotiation.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_impl.h | 12 +++++
 drivers/common/sfc_efx/base/efx_np.c   | 67 ++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index 4952f45121..a3e60fd19b 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1899,6 +1899,18 @@ extern		void
 efx_np_detach(
 	__in	efx_nic_t *enp);
 
+typedef struct efx_np_link_state_s {
+	uint32_t		enls_adv_cap_mask;
+	boolean_t		enls_an_supported;
+} efx_np_link_state_t;
+
+LIBEFX_INTERNAL
+extern	__checkReturn	efx_rc_t
+efx_np_link_state(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__out		efx_np_link_state_t *lsp);
+
 #ifdef	__cplusplus
 }
 #endif
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 100cf4d8a7..eac3bb06ee 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -273,6 +273,61 @@ efx_np_get_fixed_port_props(
 fail2:
 	EFSYS_PROBE(fail2);
 
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
+	__checkReturn	efx_rc_t
+efx_np_link_state(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__out		efx_np_link_state_t *lsp)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_LINK_STATE_IN_LEN,
+	    MC_CMD_LINK_STATE_OUT_V3_LEN);
+	efx_mcdi_req_t req;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_LINK_STATE_OUT_V3_LEN;
+	req.emr_in_length = MC_CMD_LINK_STATE_IN_LEN;
+	req.emr_cmd = MC_CMD_LINK_STATE;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	MCDI_IN_SET_DWORD(req, LINK_STATE_IN_PORT_HANDLE, nph);
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail1;
+	}
+
+	if (req.emr_out_length_used < MC_CMD_LINK_STATE_OUT_V3_LEN) {
+		rc = EMSGSIZE;
+		goto fail2;
+	}
+
+	memset(lsp, 0, sizeof (*lsp));
+
+	if (MCDI_OUT_DWORD(req, LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT) !=
+	    MC_CMD_AN_NONE)
+		lsp->enls_an_supported = B_TRUE;
+
+	if (lsp->enls_an_supported != B_FALSE)
+		lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
+
+	efx_np_cap_hw_data_to_sw_mask(
+	    MCDI_OUT2(req, const uint8_t, LINK_STATE_OUT_ADVERTISED_ABILITIES),
+	    &lsp->enls_adv_cap_mask);
+
+	return (0);
+
+fail2:
+	EFSYS_PROBE(fail2);
+
 fail1:
 	EFSYS_PROBE1(fail1, efx_rc_t, rc);
 	return (rc);
@@ -284,6 +339,7 @@ efx_np_attach(
 {
 	efx_nic_cfg_t *encp = &(enp->en_nic_cfg);
 	efx_port_t *epp = &(enp->en_port);
+	efx_np_link_state_t ls;
 	efx_rc_t rc;
 
 	if (efx_np_supported(enp) == B_FALSE)
@@ -315,8 +371,19 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail2;
 
+	rc = efx_np_link_state(enp, epp->ep_np_handle, &ls);
+	if (rc != 0)
+		goto fail3;
+
+	if (ls.enls_an_supported != B_FALSE)
+		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
+
+	epp->ep_adv_cap_mask = ls.enls_adv_cap_mask;
 	return (0);
 
+fail3:
+	EFSYS_PROBE(fail3);
+
 fail2:
 	EFSYS_PROBE(fail2);
 
-- 
2.39.5

