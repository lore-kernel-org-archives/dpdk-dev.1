Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA88ECA6011
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 18:03:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77B2B427D8;
	Thu,  8 Oct 2026 20:03:07 +0200 (CEST)
Received: from forward504d.mail.yandex.net (unknown [31.44.14.20])
 by mails.dpdk.org (Postfix) with ESMTP id 0CB7E40284
 for <dev@dpdk.org>; Thu,  8 Oct 2026 20:03:05 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4c85:0:640:11f5:0])
 by forward504d.mail.yandex.net (postfix) with ESMTPS id 2A875108266;
 Thu, 08 Oct 2026 21:03:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id n2ThKgHdI8c0-3z2TAla6; 
 Thu, 08 Oct 2026 21:03:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791482583; bh=MwhJdxaVxpmFHXnrdinPtliafWuj1c0fxcMTORctGXQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LB3AdQYQQsfwV620fAkQTTEXgpWHIWe692qeHlFul91rI3e7GeTatkcrs6jcY+t4L
 hKFJD29qqHrzYM2d8sQKN81bf/fEkoJICOSz+2BfROaDiSP+cudE0ijaFP0pcFxG9c
 azSQYiDLZnl6jnl/dew56AuY22nO3xI808WcuH3o=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH v2 3/4] ethdev: report SFF-8472 Rx LOS and Tx fault state
Date: Thu,  8 Oct 2026 20:02:37 +0200
Message-ID: <02b81fb3b425b26d6f824260330cba4ad3a1db3f.1791482259.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791482259.git.roma55592@yandex.ru>
References: <cover.1791447600.git.roma55592@yandex.ru>
 <cover.1791482259.git.roma55592@yandex.ru>
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

The SFF-8472 decoder shows the digital diagnostics of SFP modules,
but not whether the module detects a loss of the received signal
or a transmitter fault.

Report the Rx_LOS and TX_FAULT state from the status byte 110
of page A2h, each one only if the module advertises the soft
monitoring of it in the enhanced options of page A0h.
They use the same field names and format as the SFF-8636 lane
status flags, with a single lane: "None" or "[ Yes ]".

Unlike the SFF-8636 channel status flags, these bits reflect
the current state of the pins and are not latched.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 lib/ethdev/sff_8472.c                  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c3f8ccdccf..6ca8efd98f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -88,6 +88,7 @@ New Features
   uses it to display the decoded module EEPROM.
   The SFF-8636 decoder also reports the per-lane loss of signal,
   loss of lock and Tx fault flags.
+  The SFF-8472 decoder also reports the Rx loss of signal and Tx fault state.
 
 * **Updated AF_XDP driver.**
 
diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 88d1f4a0a5..ae37fee0fd 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -25,6 +25,8 @@
 #define SFF_A0_DOM_PWRT                   RTE_BIT32(3)
 
 #define SFF_A0_OPTIONS_AW                 RTE_BIT32(7)
+#define SFF_A0_OPTIONS_SOFT_TX_FAULT      RTE_BIT32(5)
+#define SFF_A0_OPTIONS_SOFT_RX_LOS        RTE_BIT32(4)
 
 /*
  * This is the offset at which the A2 page is in the EEPROM
@@ -63,6 +65,10 @@
 #define SFF_A2_RX_PWR_HWARN               36
 #define SFF_A2_RX_PWR_LWARN               38
 
+#define SFF_A2_STATUS                     110
+#define SFF_A2_STATUS_TX_FAULT            RTE_BIT32(2)
+#define SFF_A2_STATUS_RX_LOS              RTE_BIT32(1)
+
 #define SFF_A2_ALRM_FLG                   112
 #define SFF_A2_WARN_FLG                   116
 
@@ -272,6 +278,7 @@ void sff_8472_show_all(const uint8_t *data, struct sff_output *d)
 	struct sff_diags sd = {0};
 	const char *rx_power_string = NULL;
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
+	uint8_t status;
 	int i;
 
 	sff_8472_parse_eeprom(data, &sd);
@@ -302,6 +309,18 @@ void sff_8472_show_all(const uint8_t *data, struct sff_output *d)
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_MCURR]);
 	sff_output_field(d, "Module voltage", val_string);
 
+	/*
+	 * Real-time state of the pins, unlike the latched SFF-8636 flags,
+	 * reported in the same single lane format.
+	 */
+	status = data[SFF_A2_BASE + SFF_A2_STATUS];
+	if (data[SFF_A0_OPTIONS] & SFF_A0_OPTIONS_SOFT_RX_LOS)
+		sff_show_lane_status("Rx loss of signal", 1,
+				     !!(status & SFF_A2_STATUS_RX_LOS), d);
+	if (data[SFF_A0_OPTIONS] & SFF_A0_OPTIONS_SOFT_TX_FAULT)
+		sff_show_lane_status("Tx fault", 1,
+				     !!(status & SFF_A2_STATUS_TX_FAULT), d);
+
 	sff_output_field(d, "Alarm/warning flags implemented",
 			(sd.supports_alarms ? "Yes" : "No"));
 
-- 
2.47.3

