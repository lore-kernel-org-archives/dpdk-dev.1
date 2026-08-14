Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D3DC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76D4D4028D;
	Fri, 14 Aug 2026 14:56:30 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 5804B4028D
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id A1747E0F0C;
 Fri, 14 Aug 2026 16:56:27 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am A1747E0F0C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712188;
 bh=KgSTyT44YwDfBju4DILg8ypKcpzW0bqu4GmhKmxcKfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=3fYLyUIKt3uZZjmudw5+CNDXdAvNe8+nOcvzfk1gtE3nsWCUyZ7eMgK1QvbyFGzgr
 4rRufeWOM9KfQtJpeB7Ou+KcnuiG9GA+yN4QY6wMknzcFBpz/pxT3Zf9amXYZcw1y0
 lgv1fusnxbQ9MUvjVoNfpf4c0iROG1i9O+hEjSk7efcFheJj6aWsDX0uTeeiLRbmoW
 pBrSwrv2e0HfToshdlxkSkeYQ83zKeqF3VbghkvckCzfNWdITtaxL5dicTz91R8QBG
 /mFu1us8+AG+pGj/0EPrdugHd8iDsgq8CVCa0aOERGKtObNqEoHtikf36ZVU8twIo+
 2KXqp3hnNK6uA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 2/6] common/sfc_efx/base: indicate dummy netport properties
 on VF
Date: Fri, 14 Aug 2026 16:56:20 +0400
Message-ID: <20260814125624.13372-3-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125624.13372-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125624.13372-1-ivan.malov@arknetworks.am>
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
index f8b7e50695..aea8a039fc 100644
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
@@ -1058,10 +1063,6 @@ efx_np_attach(
 	if (rc != 0)
 		goto fail1;
 
-	/*
-	 * FIXME: This may need revisiting for VFs, which
-	 * don't necessarily have access to these details.
-	 */
 	rc = efx_np_get_fixed_port_props(enp, epp->ep_np_handle,
 		    epp->ep_np_cap_data_raw, &epp->ep_phy_cap_mask,
 		    &epp->ep_np_loopback_cap_mask);
@@ -1079,6 +1080,23 @@ efx_np_attach(
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

