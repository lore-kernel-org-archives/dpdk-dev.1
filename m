Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547E2C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:11:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E159A427D0;
	Wed, 12 Aug 2026 19:11:10 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 71A2F427AF
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:11:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id BC7E5E07BF;
 Wed, 12 Aug 2026 21:11:07 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am BC7E5E07BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554668;
 bh=uoEwo4Z7eOrwvth73dLzoemYOweP6IHLOBre1lVwp6s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JeAAy3Q0C7FO2uVD6mCq0+KMRqy5MCnSCNjJn6DvY2Yr5LbfLjmxmvDqYXuDdl2If
 aU0uFOxoRorh775rn618UQvPm81OVQMZZRENAjPHfhuQJM9iG9QrH9QEAwCqeyOw3f
 bhSA8uwYgZjBOdemmTT4+T1vkbG27zgxP/tSsHY4S3noxqziJ8i8hY0LWnMWoJgmYZ
 zf1rgGOC+hnFrGXHOQFKdQ6BVUfCHnyNbT/vxkkmFHbswvdanXf5jMgB7gButzeeBO
 WPRZJ76H35djm9sq852Y59rPFSkUvFp8ZIdVBRkIuxTMKKqUXI21HXm6YgMxp3eEWx
 KJ6CyZizMnjYg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 4/6] common/sfc_efx/base: deny tuning FCS and flow control
 to VFs
Date: Wed, 12 Aug 2026 21:11:01 +0400
Message-ID: <20260812171103.8553-5-ivan.malov@arknetworks.am>
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

Medford4 VFs can configure MAC settings via the netport MCDI,
but controlling FCS stripping and setting flow control mode
are off limits. Express all this in code to allow the DPDK
driver to start and forbid changes to FCS and flow control.

For what it's worth, changing MTU is allowed on VFs, but
the value must be less than or equal to the PF's MTU.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 41 +++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 90a5944b85..9dbad2e9d1 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1551,6 +1551,7 @@ efx_np_mac_ctrl(
 	__in		efx_np_handle_t nph,
 	__in		const efx_np_mac_ctrl_t *mc)
 {
+	const efx_nic_cfg_t *encp = &enp->en_nic_cfg;
 	EFX_MCDI_DECLARE_BUF(payload,
 	    MC_CMD_MAC_CTRL_IN_LEN,
 	    MC_CMD_MAC_CTRL_OUT_LEN);
@@ -1574,9 +1575,19 @@ efx_np_mac_ctrl(
 	if (mc->enmc_set_pdu_only != B_FALSE)
 		goto skip_full_reconfigure;
 
-	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS;
-	if (mc->enmc_include_fcs != B_FALSE)
-		flags |= 1U << MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS;
+	/* Only PFs can control FCS stripping. */
+	if (EFX_PCI_FUNCTION_IS_PF(encp)) {
+		cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS;
+		if (mc->enmc_include_fcs != B_FALSE)
+			flags |= 1U << MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS;
+	} else if (mc->enmc_include_fcs != B_FALSE) {
+		/*
+		 * Assume that FCS stripping being enabled is the driver's
+		 * default expectation and deny disabling it to VFs.
+		 */
+		rc = ENOTSUP;
+		goto fail1;
+	}
 
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FLAGS, flags);
 
@@ -1598,12 +1609,22 @@ efx_np_mac_ctrl(
 			break;
 		default:
 			rc = EINVAL;
-			goto fail1;
+			goto fail2;
 		}
 	}
 
-	cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
-	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
+	/* Only PFs can change flow control settings. */
+	if (EFX_PCI_FUNCTION_IS_PF(encp)) {
+		cfg |= 1U << MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL;
+		MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_FCNTL, fcntl);
+	} else if (fcntl != MC_CMD_FCNTL_AUTO) {
+		/*
+		 * Assume that flow control auto-negotiation is the driver's
+		 * default expectation and deny any attempts to override it.
+		 */
+		rc = ENOTSUP;
+		goto fail3;
+	}
 
 skip_full_reconfigure:
 	MCDI_IN_SET_DWORD(req, MAC_CTRL_IN_V2_CONTROL_FLAGS, cfg);
@@ -1612,11 +1633,17 @@ efx_np_mac_ctrl(
 
 	if (req.emr_rc != 0) {
 		rc = req.emr_rc;
-		goto fail2;
+		goto fail4;
 	}
 
 	return (0);
 
+fail4:
+	EFSYS_PROBE(fail4);
+
+fail3:
+	EFSYS_PROBE(fail3);
+
 fail2:
 	EFSYS_PROBE(fail2);
 
-- 
2.47.3

