Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A6C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:49:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65B31427BA;
	Tue, 11 Aug 2026 19:48:41 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 9658A4275A;
 Tue, 11 Aug 2026 19:48:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id D3867E0CCB;
 Tue, 11 Aug 2026 21:48:34 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am D3867E0CCB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470515;
 bh=UhT1SV9jhgIHnSfgNwNrCJyS+/7A+SpkgQJSYmkvgNo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJG4eMcJ4D60SJ+XF9FoaFYBQ8RA8p7y3kri/v6AGCjHibtGzoMvHieeAbZG11u54
 e6iTMKJIX9pdvlqBBjFOavlckdB4kHodBDuYRY+wFfPKKy9rlnKQNqsVJW3kp16aKF
 OCq+r44/uxpT/Zyde4UYILBMU+BFOhA75gxE/3YUwAAU1ogEWQz2vIxrE3XVvRmNYI
 JHuq4NaCm0dKo+HMca/KWVVmS9Fo30AAeSmcbZaYzxnoWwsErJdBsv9/68tZIyiu/M
 NsiiD74iS8UzF1RPy3kU3iuq9aREUMMQ1gazjjHG9rCPMJ/uYH8tqyvlATeV6Tf7vy
 j/i8Jmg4pzjhQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 07/14] common/sfc_efx/base: fix annotations in HW-SW mask
 converter
Date: Tue, 11 Aug 2026 21:48:14 +0400
Message-ID: <20260811174821.8930-8-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811174821.8930-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
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

From: Andy Moreton <andy.moreton@amd.com>

Code analysis reports that efx_np_cap_mask_hw_to_sw does not always write
to sw_cap_maskp. Fix the annotation to show it is valid on input, and
initialise the mask in efx_np_cap_hw_data_to_sw_mask.

Fixes: a90549f527eb ("common/sfc_efx/base: get netport fixed capabilities on probe")
Cc: stable@dpdk.org

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_np.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 5044eabdd3..baee83e58e 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -190,7 +190,7 @@ efx_np_cap_mask_hw_to_sw(
 	__in				unsigned int hw_sw_map_nentries,
 	__in_bcount(hw_cap_data_nbytes)	const uint8_t *hw_cap_data,
 	__in				size_t hw_cap_data_nbytes,
-	__out				uint32_t *sw_cap_maskp)
+	__inout				uint32_t *sw_cap_maskp)
 {
 	FOREACH_SUP_CAP(hw_sw_map, hw_sw_map_nentries,
 	    hw_cap_data, hw_cap_data_nbytes) {
@@ -216,6 +216,8 @@ efx_np_cap_hw_data_to_sw_mask(
 	__in			const uint8_t *hw_data,
 	__out			uint32_t *sw_maskp)
 {
+	*sw_maskp = 0;
+
 	EFX_NP_CAP_MASK_HW_TO_SW(efx_np_cap_map_tech, ETH_AN_FIELDS_TECH_MASK,
 	    hw_data, sw_maskp);
 
@@ -429,21 +431,21 @@ efx_np_link_state(
 	_NOTE(ARGUNUSED(lbp))
 #endif /* EFSYS_OPT_LOOPBACK */
 
-	if (lsp->enls_an_supported != B_FALSE)
-		lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
-
 	efx_np_cap_hw_data_to_sw_mask(
 	    MCDI_OUT2(req, const uint8_t, LINK_STATE_OUT_ADVERTISED_ABILITIES),
 	    &lsp->enls_adv_cap_mask);
 
-	if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_AN_ABLE))
-		lsp->enls_lp_cap_mask |= 1U << EFX_PHY_CAP_AN;
+	if (lsp->enls_an_supported != B_FALSE)
+		lsp->enls_adv_cap_mask |= 1U << EFX_PHY_CAP_AN;
 
 	efx_np_cap_hw_data_to_sw_mask(
 	    MCDI_OUT2(req, const uint8_t,
 		    LINK_STATE_OUT_LINK_PARTNER_ABILITIES),
 	    &lsp->enls_lp_cap_mask);
 
+	if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_AN_ABLE))
+		lsp->enls_lp_cap_mask |= 1U << EFX_PHY_CAP_AN;
+
 	tech = MCDI_OUT_WORD(req, LINK_STATE_OUT_LINK_TECHNOLOGY);
 
 	if (tech < EFX_ARRAY_SIZE(efx_np_tech_to_lane_count))
-- 
2.47.3

