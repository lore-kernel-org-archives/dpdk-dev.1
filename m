Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02740C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E04D9427A1;
	Wed, 12 Aug 2026 19:11:08 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id E447842793
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:11:06 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 39CA7E0AD0;
 Wed, 12 Aug 2026 21:11:06 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 39CA7E0AD0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554666;
 bh=nX4xj1PkAhwBFBvYmS2Y233cnfnAK5jWmPH8UGuzl+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ce/1SE+0R/jgtQpi2b12sFf0otkcK7n+Qzq4seMx7hflha5sIbZRjAsOXI0noCVNl
 8rCHXxtLs6BES3YfqALVrIC4a2/TFCUW/+VTEFf5BWe7uJfR/w1Dd0hhfbyE5BET/8
 MkBaug7VRCIviJieE7ylf9PN/JfYVn8IY6M9tuezg37le3LQAyXsAaDZOzJttA0nD6
 Dw0RTO47UN3G3SIHf1F8B/YSaXeSyfgf1O4FCXMpNzZbNvi0Sbg13+id+0tqAHr9z+
 BjQkW9jvznj9BabVbYkpgIZtlg/9LV2jpqPSYqPdLHHOQp91JIWJz/DEJTrUyg8aKn
 YtUe9+g4xSruw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 2/6] common/sfc_efx/base: indicate dummy netport properties
 on VF
Date: Wed, 12 Aug 2026 21:10:59 +0400
Message-ID: <20260812171103.8553-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812171103.8553-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260812171103.8553-1-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_np.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 0e1cd35591..7a30567fe0 100644
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
@@ -247,6 +248,10 @@ efx_np_get_fixed_port_props(
 	efx_mcdi_req_t req;
 	efx_rc_t rc;
 
+	/* VFs do not allow access to the fixed port data. */
+	if (EFX_PCI_FUNCTION_IS_VF(encp))
+		return (0);
+
 	req.emr_out_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN;
 	req.emr_in_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN;
 	req.emr_cmd = MC_CMD_GET_FIXED_PORT_PROPERTIES;
@@ -1050,10 +1055,6 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail1;
 
-	/*
-	 * FIXME: This may need revisiting for VFs, which
-	 * don't necessarily have access to these details.
-	 */
 	rc = efx_np_get_fixed_port_props(enp, epp->ep_np_handle,
 		    epp->ep_np_cap_data_raw, &epp->ep_phy_cap_mask,
 		    &epp->ep_np_loopback_cap_mask);
@@ -1071,6 +1072,23 @@ efx_np_attach(
 		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
 	}
 
+	/*
+	 * On VFs, 'efx_np_get_fixed_port_props' does not report any link
+	 * speeds; however, 'efx_np_link_state' should provide clues as
+	 * to which link speed is de facto active on the VF. Use this
+	 * clue to provide accurate information to the application.
+	 *
+	 * Also, indicate three basic capabilities that the VF cannot
+	 * manage, but that can be safely assumed to be available.
+	 */
+	if (EFX_PCI_FUNCTION_IS_VF(encp)) {
+		epp->ep_phy_cap_mask = epp->ep_adv_cap_mask;
+
+		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_PAUSE;
+		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_ASYM;
+		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
+	}
+
 #if EFSYS_OPT_LOOPBACK
 	efx_np_assign_loopback_props(enp);
 #endif /* EFSYS_OPT_LOOPBACK */
-- 
2.47.3

