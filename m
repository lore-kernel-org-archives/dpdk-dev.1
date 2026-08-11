Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43425C5B56A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1C9B427BB;
	Tue, 11 Aug 2026 19:49:20 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id EFFE14278E;
 Tue, 11 Aug 2026 19:49:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 34934E0EC6;
 Tue, 11 Aug 2026 21:49:17 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 34934E0EC6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470557;
 bh=02F/amhGFNd1QVNgM8aAbOhkYLDU9M8dGK89Szd7K38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yfdKMSOwFUfnbeM+6D2Hzja5PlMvaZs7IH+TXBVBn54ylcbchGfN2dKzjlyYww0ck
 DqqMWMYaC4/23cv0A4Do/TEiRWVeJco35pNRZWGz/KqBHC31AhEqo6HDDXWMC6Q+xv
 5mgFEw2u43XslxkZfowy9nFsoQJaLzod7qWt5rRgX0G3kIa/e9JIedxVfMfRvTcxYL
 YIe2BsMWCDMy1rBeUf4Z3tvhIsw0G6J7nWLVmqi3MWeCCaPTLhQ1ldiHj7g8O1I8jS
 rsHZUlhHmEGbfcuNizeR67tIC0lHFBrSpORX2GMq62eNpBYoCfIWHmi/WNa6JMm12A
 LYLp21qL/CnQg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 3/3] common/sfc_efx/base: fix reading advertised autoneg
 ability
Date: Tue, 11 Aug 2026 21:49:13 +0400
Message-ID: <20260811174913.8961-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174913.8961-1-ivan.malov@arknetworks.am>
References: <20260811174913.8961-1-ivan.malov@arknetworks.am>
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

The issue is that when the user disables auto-negotiation by removing
the capability bit from the 'advertised mask' (set method) and then
reads the resulting capabilities, which involves querying MCDI, the
bit reappears in the mask irrespective of the user's intent.

Fix this by remembering the user's intent before any link-state queries.

Fixes: 2a5cf77e6de8 ("common/sfc_efx/base: provide PHY link get method on Medford4")
Fixes: 06f569de6c06 ("common/sfc_efx/base: decode netport link state on probe path")
Cc: stable@dpdk.org

Suggested-by: Andy Moreton <andy.moreton@amd.com>
Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c       | 11 +++++------
 drivers/common/sfc_efx/base/medford4_phy.c |  6 +++++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 4ba3c7d260..a8396535bf 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -436,9 +436,6 @@ efx_np_link_state(
 	    MCDI_OUT2(req, const uint8_t, LINK_STATE_OUT_ADVERTISED_ABILITIES),
 	    &lsp->enls_adv_cap_mask);
 
-	if (lsp->enls_an_supported != B_FALSE)
-		lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
-
 	efx_np_cap_hw_data_to_sw_mask(
 	    MCDI_OUT2(req, const uint8_t,
 		    LINK_STATE_OUT_LINK_PARTNER_ABILITIES),
@@ -1020,11 +1017,13 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail3;
 
-	if (ls.enls_an_supported != B_FALSE)
-		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
-
 	epp->ep_adv_cap_mask = ls.enls_adv_cap_mask;
 
+	if (ls.enls_an_supported != B_FALSE) {
+		epp->ep_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
+		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
+	}
+
 #if EFSYS_OPT_LOOPBACK
 	efx_np_assign_loopback_props(enp);
 #endif /* EFSYS_OPT_LOOPBACK */
diff --git a/drivers/common/sfc_efx/base/medford4_phy.c b/drivers/common/sfc_efx/base/medford4_phy.c
index 7b456c9b8a..4d2a954d4f 100644
--- a/drivers/common/sfc_efx/base/medford4_phy.c
+++ b/drivers/common/sfc_efx/base/medford4_phy.c
@@ -32,15 +32,19 @@ medford4_phy_get_link(
 	__out		ef10_link_state_t *elsp)
 {
 	efx_np_handle_t nph = enp->en_port.ep_np_handle;
+	const efx_port_t *port = &enp->en_port;
 	efx_np_link_state_t ls;
 	efx_np_mac_state_t ms;
+	uint32_t preserve_an;
 	efx_rc_t rc;
 
+	preserve_an = port->ep_adv_cap_mask & (1U << EFX_PHY_CAP_AN);
+
 	rc = efx_np_link_state(enp, nph, &ls);
 	if (rc != 0)
 		goto fail1;
 
-	elsp->epls.epls_adv_cap_mask = ls.enls_adv_cap_mask;
+	elsp->epls.epls_adv_cap_mask = ls.enls_adv_cap_mask | preserve_an;
 	elsp->epls.epls_lp_cap_mask = ls.enls_lp_cap_mask;
 	elsp->epls.epls_lane_count = ls.enls_lane_count;
 	elsp->els_loopback = ls.enls_loopback;
-- 
2.47.3

