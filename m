Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3521C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:50:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195B0415D7;
	Tue, 11 Aug 2026 19:50:30 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 0162E427B2
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:50:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 49136E0CCB;
 Tue, 11 Aug 2026 21:50:28 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 49136E0CCB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786470628;
 bh=09T41HGuzdDr2HmDpqg3gu3zUv7dulXX6TM+P4GHcfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=wk8RwNlL87fa/wpwv9cYMNpAS11/NbQ2P0PRyKVFx1YDjXSJUbcuD+NhajdzC7czl
 EliV2O7lNviWMvlDtEhOoLnlN+oEJoP/oPnZZs9mm3lFcnI7IsQ6XeGtE7RN3YHoJd
 qcgxO2y7j6u2QTzDS5H/xMsqRAwg7K4cnPiYllY3fjYkt1iQYlqFW1TQ4BHnR7GPYb
 cd0dEYR/EV/9Te1kMfrMkppe9cqxRGs2TLbo4JkO4H9XQBQsa5B3brah3yFrr4PG60
 giqgId8V5xwcnI/qY4IfHRGdwIq07p5p6I1CVw1TbkhR5aqjmlsMP4YrG1uri5j8H0
 8rhDnm4fws0aA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 2/6] common/sfc_efx/base: indicate dummy netport properties on
 VF
Date: Tue, 11 Aug 2026 21:50:21 +0400
Message-ID: <20260811175025.9019-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811175025.9019-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
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

Starting with MCFW version 1.4.0.8, Medford4 adapters support the use
of the netport MCDI for port configuration by a VF; however, the MCDI
which retrieves fixed port properties is not permitted for use by VFs.

Fill in dummy values sufficient for the DPDK driver to start on a VF.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 5f5ec86647..e05e2cb487 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -240,6 +240,7 @@ efx_np_get_fixed_port_props(
 	__out_opt		uint32_t *sup_cap_maskp,
 	__out_opt		efx_qword_t *loopback_cap_maskp)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN,
 	    MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN);
@@ -247,6 +248,28 @@ efx_np_get_fixed_port_props(
 	efx_mcdi_req_t req;
 	efx_rc_t rc;
 
+	/* VFs do not allow access to the fixed port data. */
+	if (EFX_PCI_FUNCTION_IS_VF(encp)) {
+		if (sup_cap_maskp != NULL) {
+			/*
+			 * Indicate a dummy link speed mode, as the
+			 * DPDK driver expects to see at least one.
+			 */
+			*sup_cap_maskp = 1U << EFX_PHY_CAP_1000FDX;
+
+			/*
+			 * Indicate three basic capabilities that
+			 * a VF cannot manage, but that can be
+			 * safely assumed to be available.
+			 */
+			*sup_cap_maskp |= 1U << EFX_PHY_CAP_PAUSE;
+			*sup_cap_maskp |= 1U << EFX_PHY_CAP_ASYM;
+			*sup_cap_maskp |= 1U << EFX_PHY_CAP_AN;
+		}
+
+		return (0);
+	}
+
 	req.emr_out_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN;
 	req.emr_in_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN;
 	req.emr_cmd = MC_CMD_GET_FIXED_PORT_PROPERTIES;
@@ -1048,10 +1071,6 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail1;
 
-	/*
-	 * FIXME: This may need revisiting for VFs, which
-	 * don't necessarily have access to these details.
-	 */
 	rc = efx_np_get_fixed_port_props(enp, epp->ep_np_handle,
 		    epp->ep_np_cap_data_raw, &epp->ep_phy_cap_mask,
 		    &epp->ep_np_loopback_cap_mask);
-- 
2.47.3

