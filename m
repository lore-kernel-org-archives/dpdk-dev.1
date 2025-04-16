Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD1FC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 14:05:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06ED6427E0;
	Wed, 16 Apr 2025 16:01:14 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 070F0427AD
 for <dev@dpdk.org>; Wed, 16 Apr 2025 16:01:04 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.65.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id 52262E11C6;
 Wed, 16 Apr 2025 18:01:03 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am 52262E11C6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1744812063;
 bh=nFzOPGzIHNeDpLXtqOwmNmbAdMdG3u5okJR9EEIgziA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q7KfST4oPSQAYoM9puJL+kKcnXXQxbMBUTR7p69FX/vBOHOi01pmMrPYVUr4B6+2v
 P3QZ50O4y/1q7QkqjOoEJLgxfTsMw932e4fvG8ZcjLMxc7puo+fcWiKCJzYQXa9Wa4
 TMhUUaOXL0iG6ef+2vC4O2jirTfWUFEh8c+j4sL4YTAq0hO09Tc0G+v9bcaEPE9cn5
 0mia5hd7O2nawjenUd7IrNoYQhm8KPei9ZrisNYenuW5Lhd6nqdSVHSvbNdzl+XIOw
 r8zWgHMaU1OMiRnZPrRS09U9qU35jFbIJ2IgEG62ZVeVlfDuhn60EXSEFaJeQ8j1Mq
 1aHrrRAyWdSLw==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Denis Pryazhennikov <denis.pryazhennikov@arknetworks.am>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH 40/46] common/sfc_efx/base: add link event processing on new
 boards
Date: Wed, 16 Apr 2025 18:00:10 +0400
Message-Id: <20250416140016.36127-41-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416140016.36127-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
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

Link change events on netport MCDI capable NICs do not carry
any specifics of the new link state. Such need to be queried
separately. Add processing of the events, with an indication
to the client driver telling it to collect the status itself.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 drivers/common/sfc_efx/base/ef10_ev.c | 29 +++++++++++++++++++++++++++
 drivers/common/sfc_efx/base/efx.h     |  6 ++++++
 drivers/common/sfc_efx/base/efx_nic.c |  5 +++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/common/sfc_efx/base/ef10_ev.c b/drivers/common/sfc_efx/base/ef10_ev.c
index 82a2284f2b..a97c1bf43e 100644
--- a/drivers/common/sfc_efx/base/ef10_ev.c
+++ b/drivers/common/sfc_efx/base/ef10_ev.c
@@ -866,6 +866,7 @@ ef10_ev_mcdi(
 	__in_opt	void *arg)
 {
 	efx_nic_t *enp = eep->ee_enp;
+	efx_port_t *epp = &(enp->en_port);
 	unsigned int code;
 	boolean_t should_abort = B_FALSE;
 	boolean_t ev_is_v2 = B_FALSE;
@@ -906,6 +907,34 @@ ef10_ev_mcdi(
 		break;
 #endif /* EFSYS_OPT_MCDI_PROXY_AUTH_SERVER */
 
+	case MCDI_EVENT_CODE_PORT_LINKCHANGE:
+		/*
+		 * These events are generated on netport MCDI capable
+		 * boards. They supersede legacy LINKCHANGE_V2 events.
+		 */
+		if (MCDI_EV_FIELD(eqp, PORT_LINKCHANGE_PORT_HANDLE) ==
+		    epp->ep_np_handle) {
+			efx_link_mode_t mode;
+
+			if (MCDI_EV_FIELD(eqp, PORT_LINKCHANGE_LINK_UP) == 1)
+				mode = EFX_LINK_UNKNOWN;
+			else
+				mode = EFX_LINK_DOWN;
+
+			/*
+			 * The event does not contain full link state details.
+			 *
+			 * Either notify the client driver with a dummy link
+			 * mode value (UNKNOWN), just to say the link is up,
+			 * or, in case the link is not up, pass DOWN value.
+			 *
+			 * The client driver will need to poll for link state
+			 * in order to get full details like speed and duplex.
+			 */
+			should_abort = eecp->eec_link_change(arg, mode);
+		}
+		break;
+
 	case MCDI_EVENT_CODE_LINKCHANGE_V2:
 		if (efx_np_supported(enp) != B_FALSE) {
 			/*
diff --git a/drivers/common/sfc_efx/base/efx.h b/drivers/common/sfc_efx/base/efx.h
index 73dc38f84e..7b43a89551 100644
--- a/drivers/common/sfc_efx/base/efx.h
+++ b/drivers/common/sfc_efx/base/efx.h
@@ -1754,6 +1754,12 @@ typedef struct efx_nic_cfg_s {
 	uint32_t		enc_mac_pdu_min;
 	/* Maximum MAC PDU value to use with efx_mac_pdu_set() */
 	uint32_t		enc_mac_pdu_max;
+	/*
+	 * When true, the link mode value passed from eec_link_change() is
+	 * either UNKNOWN (merely saying the link is up) or DOWN. In order
+	 * to have exact speed/duplex, efx_port_poll() needs to be invoked.
+	 */
+	boolean_t		enc_link_ev_need_poll;
 } efx_nic_cfg_t;
 
 #define	EFX_PCI_VF_INVALID 0xffff
diff --git a/drivers/common/sfc_efx/base/efx_nic.c b/drivers/common/sfc_efx/base/efx_nic.c
index 1c25270792..ab2bb1c160 100644
--- a/drivers/common/sfc_efx/base/efx_nic.c
+++ b/drivers/common/sfc_efx/base/efx_nic.c
@@ -494,6 +494,11 @@ efx_nic_probe(
 	encp->enc_mac_pdu_max = efx_mac_pdu_from_sdu(enp, EFX_MAC_SDU_MAX);
 	encp->enc_mac_pdu_min = EFX_MAC_PDU_MIN;
 
+	if (efx_np_supported(enp) == B_FALSE)
+		encp->enc_link_ev_need_poll = B_FALSE;
+	else
+		encp->enc_link_ev_need_poll = B_TRUE;
+
 	if ((rc = efx_phy_probe(enp)) != 0)
 		goto fail2;
 
-- 
2.39.5

