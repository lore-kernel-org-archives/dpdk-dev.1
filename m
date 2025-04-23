Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC4C369D1
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:05:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61D8440B90;
	Wed, 23 Apr 2025 18:00:59 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B571740671
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:45 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 0B1F4E032D;
 Wed, 23 Apr 2025 20:00:44 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 0B1F4E032D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424045;
 bh=04LidmxOmqggSw0Z5dgcu326soQL4pZ8oEOk7/cd4aE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bIQ9n4MuSLCGeWGomNAc2aRey4yp/K/dau9k930G379ROM0bzvuTncr1U56Bs7Xjy
 e97n4usz+GcllbTspaDxWEdhcE8eecFVgyn0n8fw0uBAjvv9dThVmMxyAOIQ8XJ04I
 rj0HPDOzua2sjzq45LJ/RgI0QFV9zPFWiktfRHQyPvx4q7a67UNhwIjnckoxGfLQ4J
 V7Bv3Shuztlnteq6q70NhItQx6fF8JJLy8g5NK8ahBvyTmih8DM6p9ZnbgQzBXl3tA
 nBYKqL2C95YJtokiQWSA4U5tuXri43jgsIUD2+vaS4tLsmAVGMLCfEueo4AXdAjDwo
 uYjo0Cau+qeag==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 41/45] common/sfc_efx/base: subscribe to netport link
 change events
Date: Wed, 23 Apr 2025 19:59:58 +0400
Message-Id: <20250423160002.35706-42-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

Subscribe to the new link events on netport MCDI attach path.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/efx_np.c | 56 ++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/common/sfc_efx/base/efx_np.c b/drivers/common/sfc_efx/base/efx_np.c
index 2e2043b520..3cefdda0e9 100644
--- a/drivers/common/sfc_efx/base/efx_np.c
+++ b/drivers/common/sfc_efx/base/efx_np.c
@@ -794,6 +794,48 @@ efx_np_stats_assign(
 }
 #endif /* EFSYS_OPT_MAC_STATS */
 
+static	__checkReturn	efx_rc_t
+efx_np_set_event_mask(
+	__in		efx_nic_t *enp,
+	__in		efx_np_handle_t nph,
+	__in		boolean_t want_linkchange_events)
+{
+	EFX_MCDI_DECLARE_BUF(payload,
+	    MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN,
+	    MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN);
+	efx_mcdi_req_t req;
+	efx_dword_t dword;
+	efx_rc_t rc;
+
+	req.emr_out_length = MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN;
+	req.emr_in_length = MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN;
+	req.emr_cmd = MC_CMD_SET_NETPORT_EVENTS_MASK;
+	req.emr_out_buf = payload;
+	req.emr_in_buf = payload;
+
+	EFX_ZERO_DWORD(dword);
+
+	if (want_linkchange_events != B_FALSE)
+		EFX_SET_DWORD_BIT(dword, EVENT_MASK_PORT_LINKCHANGE);
+
+	MCDI_IN_SET_DWORD(req, SET_NETPORT_EVENTS_MASK_IN_PORT_HANDLE, nph);
+	MCDI_IN_SET_DWORD(req, SET_NETPORT_EVENTS_MASK_IN_EVENT_MASK,
+	    dword.ed_u32[0]);
+
+	efx_mcdi_execute(enp, &req);
+
+	if (req.emr_rc != 0) {
+		rc = req.emr_rc;
+		goto fail1;
+	}
+
+	return (0);
+
+fail1:
+	EFSYS_PROBE1(fail1, efx_rc_t, rc);
+	return (rc);
+}
+
 	__checkReturn	efx_rc_t
 efx_np_attach(
 	__in		efx_nic_t *enp)
@@ -858,8 +900,17 @@ efx_np_attach(
 		goto fail5;
 
 	epp->ep_mac_pdu = ms.enms_pdu;
+
+	/* Subscribe to link change events. */
+	rc = efx_np_set_event_mask(enp, epp->ep_np_handle, B_TRUE);
+	if (rc != 0)
+		goto fail6;
+
 	return (0);
 
+fail6:
+	EFSYS_PROBE(fail6);
+
 fail5:
 	EFSYS_PROBE(fail5);
 
@@ -883,8 +934,13 @@ efx_np_attach(
 efx_np_detach(
 	__in	efx_nic_t *enp)
 {
+	efx_port_t *epp = &(enp->en_port);
+
 	if (efx_np_supported(enp) == B_FALSE)
 		return;
+
+	/* Unsubscribe from link change events. */
+	(void) efx_np_set_event_mask(enp, epp->ep_np_handle, B_FALSE);
 }
 
 	__checkReturn	efx_rc_t
-- 
2.39.5

