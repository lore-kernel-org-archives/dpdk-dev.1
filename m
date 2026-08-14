Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF94C5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55AAE40DCF;
	Fri, 14 Aug 2026 14:56:16 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id BC22640685
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:56:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.78.39])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 0BA56E0F0C;
 Fri, 14 Aug 2026 16:56:11 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 0BA56E0F0C
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1786712172;
 bh=22I/NPKNYlcjv+B2X63wfJQfhi5A83DhhSRW9ZIrRLE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=laSKj8zrRpdLtRuS7dOJFmn2N0v9KnPJKHdZBmcwUE59PgPUh9kgeX6kolJtFEM0m
 rhMgHzYLHg2YJUrcuSLiLoD525ha27rGoTppv+jB+RNnwe/BD3Jr8nJSMj5IAvxDyt
 IpA+H2F3/FegIBGvU1kXW8nfmUmDoBZJHCcRJnopdNHWI8B0uItCIatxOUU2/7U17O
 RcLQDcm/wKFGbfs0dY5jF0+WNWSkGY8xJFiNY0SpDuU1IuSiLC7CNzFImLBSh+Ujfd
 +HuTMszW1GAvSJQ1xHpCo1Y8zwQ4BOtg0BJ16gXvmVzo+MOa37mPku+Wh3R55DMDQ0
 S9acmDVxjiwaA==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andy Moreton <andy.moreton@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>,
 Roman Zhukov <Roman.Zhukov@arknetworks.am>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 3/3] common/sfc_efx/base: switch netport stats to use EVB
 port ID
Date: Fri, 14 Aug 2026 16:56:08 +0400
Message-ID: <20260814125608.13358-4-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260814125608.13358-1-ivan.malov@arknetworks.am>
References: <20260811174821.8930-1-ivan.malov@arknetworks.am>
 <20260814125608.13358-1-ivan.malov@arknetworks.am>
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

GET_NETPORT_STATISTICS_V2 is guaranteed present in all firmware
builds that advertise netport support, as already assumed by
efx_np_mac_ctrl() with MAC_CTRL_IN_V2.

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
index 7e809ce5f3..32eb228162 100644
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
index 56617c3a46..f8b7e50695 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -1614,12 +1614,13 @@ efx_np_mac_ctrl(
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
@@ -1630,7 +1631,7 @@ efx_np_mac_stats(
 	efx_rc_t rc;
 
 	req.emr_out_length = MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN;
-	req.emr_in_length = MC_CMD_GET_NETPORT_STATISTICS_IN_LEN;
+	req.emr_in_length = MC_CMD_GET_NETPORT_STATISTICS_V2_IN_LEN;
 	req.emr_cmd = MC_CMD_GET_NETPORT_STATISTICS;
 	req.emr_out_buf = payload;
 	req.emr_in_buf = payload;
@@ -1672,6 +1673,14 @@ efx_np_mac_stats(
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

