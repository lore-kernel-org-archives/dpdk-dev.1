Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677F2C5DF66
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Aug 2026 06:21:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E433640664;
	Sun, 16 Aug 2026 08:20:54 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 562C740431
 for <dev@dpdk.org>; Sun, 16 Aug 2026 08:20:52 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.77.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 2EB13E0C36;
 Sun, 16 Aug 2026 10:20:51 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 2EB13E0C36
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786861252;
 bh=F69EOo8kHCJMPE9Ik08jN8OyuNaacMc0En021wC6gVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=7FZ/TorkXAmaPkvDCG3bVn3XP7cOHgDH8ixFGRPFlEg7UaI8z8zx3JL1hez/0w3e1
 73PAKHl/J1EfK1YSwM3h+qoTrnRt7NekURfHE3wzGM2j8bDWaBrB1GirziaSI2zOvB
 jaxMDLJ+Ldm2ScuXCsV1kP69KbrOncGjvhRfmSDAIIace4zL/RXo1XUPS6GyOILXiA
 ALWIRJgzj+T8ufwp/z30Ct0qn4u2wnFqXtKBBM9dgl1l6QHo9M1EqZis+G6zvIuuIM
 Ndg8Vpp72kdSRXU6LY2Z/a+5pX4GQs7u6UUQjAanU67uXt6Bz97EYX7f1pt4uSzVwD
 cSsgCCpRDn+wA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 2/6] common/sfc_efx/base: indicate dummy netport properties
 on VF
Date: Sun, 16 Aug 2026 10:20:36 +0400
Message-ID: <20260816062040.15562-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260816062040.15562-1-ivan.malov@arknetworks.am>
References: <20260811175025.9019-1-ivan.malov@arknetworks.am>
 <20260816062040.15562-1-ivan.malov@arknetworks.am>
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
 drivers/common/sfc_efx/base/efx_np.c | 41 +++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index f8b7e50695..bf0e639704 100644
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
@@ -247,6 +248,22 @@ efx_np_get_fixed_port_props(
 	efx_mcdi_req_t req;
 	efx_rc_t rc;
 
+	/* VFs do not allow access to the fixed port data. */
+	if (EFX_PCI_FUNCTION_IS_VF(encp)) {
+		if (sup_cap_rawp != NULL)
+			memset(sup_cap_rawp, 0, MC_CMD_ETH_AN_FIELDS_LEN);
+
+		if (sup_cap_maskp != NULL)
+			*sup_cap_maskp = 0;
+
+		if (loopback_cap_maskp != NULL) {
+			memset(loopback_cap_maskp, 0,
+			    sizeof (*loopback_cap_maskp));
+		}
+
+		return (0);
+	}
+
 	req.emr_out_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN;
 	req.emr_in_length = MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN;
 	req.emr_cmd = MC_CMD_GET_FIXED_PORT_PROPERTIES;
@@ -1058,10 +1075,6 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail1;
 
-	/*
-	 * FIXME: This may need revisiting for VFs, which
-	 * don't necessarily have access to these details.
-	 */
 	rc = efx_np_get_fixed_port_props(enp, epp->ep_np_handle,
 		    epp->ep_np_cap_data_raw, &epp->ep_phy_cap_mask,
 		    &epp->ep_np_loopback_cap_mask);
@@ -1079,6 +1092,26 @@ efx_np_attach(
 		epp->ep_phy_cap_mask |= 1U << EFX_PHY_CAP_AN;
 	}
 
+	/*
+	 * On VFs, 'efx_np_get_fixed_port_props' does not report any link
+	 * speeds; indicate the auto-negotiation ability and construct
+	 * the mask of theoretically supported link speed abilities.
+	 *
+	 * Also, indicate two flow control abilities that the VF cannot
+	 * manage, but that can be safely assumed to be available.
+	 */
+	if (EFX_PCI_FUNCTION_IS_VF(encp)) {
+		unsigned int i;
+
+		epp->ep_phy_cap_mask = 1U << EFX_PHY_CAP_AN |
+		    1U << EFX_PHY_CAP_PAUSE | 1U << EFX_PHY_CAP_ASYM;
+
+		for (i = 0; i < EFX_ARRAY_SIZE(efx_np_cap_map_tech); ++i) {
+			epp->ep_phy_cap_mask |=
+			    1U << efx_np_cap_map_tech[i].encm_sw;
+		}
+	}
+
 #if EFSYS_OPT_LOOPBACK
 	efx_np_assign_loopback_props(enp);
 #endif /* EFSYS_OPT_LOOPBACK */
-- 
2.47.3

