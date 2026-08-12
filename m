Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D611C5B56A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 17:11:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87414427BD;
	Wed, 12 Aug 2026 19:10:45 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 8718F40E6E
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:10:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.70.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id D4CE7E0BA6;
 Wed, 12 Aug 2026 21:10:42 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am D4CE7E0BA6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786554643;
 bh=HP4TeaKKIAhFMnAPzcX/9NXJezNe6iuiMLyTRkzB9Z4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=5/2sDDdokHJUUepZsgYkwnoPMghckXnIoGZN9FnX1XYUk1crZMXLA/iyncFvAMFrm
 kxHfpG9FkRw2/djMDKDf92/jnDAWKJaAvCHvNnIZiFDta9y0h6jGTD/oPdHn777ECq
 xbz9Jqx+OjHZaRLGFpQmaNt/SO8nKqxQtTyUMPaPg6nAi37wGCTqQuhPY117Y692+X
 6ecpLUeCkcoSzMUgxg+XHZf2ZJGNIzQNReYAvAcUUeMTDZmP0eWNX/TXmx311bgmce
 6N3mrGl80HqhgJcL1oD5xgvBVtQYhlYGydx0+dyl1NAEVzGZuNTSU2afh/7wnh4KAr
 kGwNTaCB3lAkQ==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 3/3] common/sfc_efx/base: switch netport stats to use EVB
 port ID
Date: Wed, 12 Aug 2026 21:10:39 +0400
Message-ID: <20260812171039.8538-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812171039.8538-1-ivan.malov@arknetworks.am>
References: <20260811174949.8993-1-ivan.malov@arknetworks.am>
 <20260812171039.8538-1-ivan.malov@arknetworks.am>
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

Support for VADAPTER stats requires passing the EVB port handle.
Use GET_NETPORT_STATISTICS_V2 to do that.

Also for clarity adjust the argument order for efx_np_mac_stats
to match the legacy efx_mcdi_mac_stats.

Signed-off-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
---
 drivers/common/sfc_efx/base/efx_impl.h     |  3 ++-
 drivers/common/sfc_efx/base/efx_mcdi.c     |  2 +-
 drivers/common/sfc_efx/base/efx_np.c       | 15 ++++++++++++---
 drivers/common/sfc_efx/base/medford4_mac.c | 12 +++++++-----
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/common/sfc_efx/base/efx_impl.h b/drivers/common/sfc_efx/base/efx_impl.h
index c91fbbb61b..6dc7ca870d 100644
--- a/drivers/common/sfc_efx/base/efx_impl.h
+++ b/drivers/common/sfc_efx/base/efx_impl.h
@@ -1988,8 +1988,9 @@ extern	__checkReturn	efx_rc_t
 efx_np_mac_stats(
 	__in		efx_nic_t *enp,
 	__in		efx_np_handle_t nph,
-	__in		efx_stats_action_t action,
+	__in		uint32_t vport_id,
 	__in_opt	const efsys_mem_t *esmp,
+	__in		efx_stats_action_t action,
 	__in		uint16_t period_ms);
 #endif /* EFSYS_OPT_MAC_STATS */
 
diff --git a/drivers/common/sfc_efx/base/efx_mcdi.c b/drivers/common/sfc_efx/base/efx_mcdi.c
index 8f14f38cdc..f8306460fa 100644
--- a/drivers/common/sfc_efx/base/efx_mcdi.c
+++ b/drivers/common/sfc_efx/base/efx_mcdi.c
@@ -2250,7 +2250,7 @@ efx_mcdi_mac_stats_clear(
 
 	if (efx_np_supported(enp) != B_FALSE) {
 		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
-			    EFX_STATS_CLEAR, NULL, 0);
+		    enp->en_vport_id, NULL, EFX_STATS_CLEAR, 0);
 	} else {
 		rc = efx_mcdi_mac_stats(enp, enp->en_vport_id, NULL,
 				EFX_STATS_CLEAR, 0);
diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index ca6ae0a9b1..0e1cd35591 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1607,12 +1607,13 @@ efx_np_mac_ctrl(
 efx_np_mac_stats(
 	__in		efx_nic_t *enp,
 	__in		efx_np_handle_t nph,
-	__in		efx_stats_action_t action,
+	__in		uint32_t vport_id,
 	__in_opt	const efsys_mem_t *esmp,
+	__in		efx_stats_action_t action,
 	__in		uint16_t period_ms)
 {
 	EFX_MCDI_DECLARE_BUF(payload,
-	    MC_CMD_GET_NETPORT_STATISTICS_IN_LEN,
+	    MC_CMD_GET_NETPORT_STATISTICS_V2_IN_LEN,
 	    MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN);
 	boolean_t enable = (action == EFX_STATS_ENABLE_NOEVENTS);
 	boolean_t events = (action == EFX_STATS_ENABLE_EVENTS);
@@ -1623,7 +1624,7 @@ efx_np_mac_stats(
 	efx_rc_t rc;
 
 	req.emr_out_length = MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN;
-	req.emr_in_length = MC_CMD_GET_NETPORT_STATISTICS_IN_LEN;
+	req.emr_in_length = MC_CMD_GET_NETPORT_STATISTICS_V2_IN_LEN;
 	req.emr_cmd = MC_CMD_GET_NETPORT_STATISTICS;
 	req.emr_out_buf = payload;
 	req.emr_in_buf = payload;
@@ -1665,6 +1666,14 @@ efx_np_mac_stats(
 		MCDI_IN_SET_DWORD(req, GET_NETPORT_STATISTICS_IN_DMA_LEN, sz);
 	}
 
+	/*
+	 * NOTE: Do not use EVB_PORT_ID_ASSIGNED when disabling periodic stats,
+	 *	 as this may fail (and leave periodic DMA enabled) if the
+	 *	 vadapter has already been deleted.
+	 */
+	MCDI_IN_SET_DWORD(req, GET_NETPORT_STATISTICS_V2_IN_PORT_ID,
+		(disable ? EVB_PORT_ID_NULL : vport_id));
+
 	efx_mcdi_execute(enp, &req);
 
 	if (req.emr_rc != 0) {
diff --git a/drivers/common/sfc_efx/base/medford4_mac.c b/drivers/common/sfc_efx/base/medford4_mac.c
index 8ef84c69c6..b6000cf6b9 100644
--- a/drivers/common/sfc_efx/base/medford4_mac.c
+++ b/drivers/common/sfc_efx/base/medford4_mac.c
@@ -172,8 +172,8 @@ medford4_mac_stats_upload(
 	efx_port_t *epp = &(enp->en_port);
 	efx_rc_t rc;
 
-	rc = efx_np_mac_stats(enp,
-		    epp->ep_np_handle, EFX_STATS_UPLOAD, esmp, 0);
+	rc = efx_np_mac_stats(enp, epp->ep_np_handle, enp->en_vport_id,
+	    esmp, EFX_STATS_UPLOAD, 0);
 	if (rc != 0)
 		goto fail1;
 
@@ -196,13 +196,15 @@ medford4_mac_stats_periodic(
 
 	if (period_ms == 0) {
 		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
-			    EFX_STATS_DISABLE, NULL, 0);
+		    enp->en_vport_id, NULL, EFX_STATS_DISABLE, 0);
 	} else if (events != B_FALSE) {
 		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
-			    EFX_STATS_ENABLE_EVENTS, esmp, period_ms);
+		    enp->en_vport_id, esmp, EFX_STATS_ENABLE_EVENTS,
+		    period_ms);
 	} else {
 		rc = efx_np_mac_stats(enp, epp->ep_np_handle,
-			    EFX_STATS_ENABLE_NOEVENTS, esmp, period_ms);
+		    enp->en_vport_id, esmp, EFX_STATS_ENABLE_NOEVENTS,
+		    period_ms);
 	}
 
 	if (rc != 0)
-- 
2.47.3

