Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70247CA1010
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Sep 2025 14:45:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B01C440659;
	Fri,  5 Sep 2025 16:45:28 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 265E6402DB;
 Fri,  5 Sep 2025 16:45:24 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.74.252])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 5DFC1E02EB;
 Fri,  5 Sep 2025 18:45:23 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 5DFC1E02EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1757083523;
 bh=HQ8AMExbH20KL9r3jUHF8Ox0lJMc0sQuo5VkCD8/vH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Rs70LTounr2ONGmWU0+iKjpWQGE1HjDukzdEkrByIPvHW7aXOps1ktvoTVu3HjWna
 E6Yhmf57Ou+exvrCSWLzcU0auUKwi2srHSFYFWXWTAO1xD87B0DEOb+d8k53Mketws
 f8imNaDwQVPJoTQ86a931VJTncuvCAistNNVoLzhL0ppS+rB/FNST1wTAnTkXypLcj
 uEI/J0hskESnTbOL8pPCBEX7awt5qHcXl6VCmcKVIounpGrzINT0ODqWLmZcruTXHw
 WB3AHAYRTW5hlNT6zOvLGol/LWT6nrg1ncRvAc40b1lLksIl6i0O6xOHaoWs0jxx9H
 afdnOgFwYjS1A==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 stable@dpdk.org
Subject: [PATCH 1/4] common/sfc_efx/base: fix autoneg detection with netport
 MCDI
Date: Fri,  5 Sep 2025 18:45:11 +0400
Message-ID: <20250905144514.11698-2-ivan.malov@arknetworks.am>
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

Currently, the code consults both local AN support status, which is stable,
and the dynamic AN status on the link partner, which is flaky. Exclude the
latter, as the client should have the opportunity to re-initiate AN afresh.

Fixes: 2a5cf77e6de8 ("common/sfc_efx/base: provide PHY link get method on Medford4")
Cc: stable@dpdk.org

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index a19c986691..599daa7a60 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -397,8 +397,7 @@ efx_np_link_state(
 	v3_flags = MCDI_OUT_DWORD(req, LINK_STATE_OUT_V3_FLAGS);
 	memset(lsp, 0, sizeof (*lsp));
 
-	if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_AN_ABLE) &&
-	    MCDI_OUT_DWORD(req, LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT) !=
+	if (MCDI_OUT_DWORD(req, LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT) !=
 	    MC_CMD_AN_NONE)
 		lsp->enls_an_supported = B_TRUE;
 
@@ -437,7 +436,7 @@ efx_np_link_state(
 	    MCDI_OUT2(req, const uint8_t, LINK_STATE_OUT_ADVERTISED_ABILITIES),
 	    &lsp->enls_adv_cap_mask);
 
-	if (lsp->enls_an_supported != B_FALSE)
+	if (status_flags & (1U << MC_CMD_LINK_STATUS_FLAGS_AN_ABLE))
 		lsp->enls_lp_cap_mask |= 1U << EFX_PHY_CAP_AN;
 
 	efx_np_cap_hw_data_to_sw_mask(
-- 
2.47.2

