Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A526CA600A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:23:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D825B41156;
	Thu,  8 Oct 2026 10:23:42 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 2DF1640DFB
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:23:41 +0200 (CEST)
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d500])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 76C9A870F0;
 Thu, 08 Oct 2026 11:23:40 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward500a.mail.yandex.net (postfix) with ESMTPS id 5F78AC009B;
 Thu, 08 Oct 2026 11:23:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id UNJ0VOBd8Cg0-Yq5QDDvR; 
 Thu, 08 Oct 2026 11:23:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791447820; bh=ieVo/PncTYXIz+K4SdZK1kw+ju1/6IUXvNbq2GvGuTo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lY/CTQOVhd3jWvTA70LLCEm9j9KIRZaYST3jVwYArvXxsLNEVhjCINHCO81HF8kSo
 EsfwyvQda+nCETq/aLA+Ac2bL/KevGN8ElDOqqrGczUh+f3OnmHZhkH3oFXaCWS2w8
 +8xgphUl9WF3mXrFR8JUVPnPPO9y/QeyTarbaK4Q=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH 3/4] ethdev: report SFF-8472 Rx LOS and Tx fault state
Date: Thu,  8 Oct 2026 10:23:25 +0200
Message-ID: <9979a85789f604ff5e02a3a0a49943d7e49c0f3c.1791447600.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791447600.git.roma55592@yandex.ru>
References: <cover.1791447600.git.roma55592@yandex.ru>
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

Unlike the SFF-8636 channel status flags, these bits reflect
the current state of the pins and are not latched.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 lib/ethdev/sff_8472.c                  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 08c554cedb..601233d6ac 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -86,6 +86,7 @@ New Features
   such as the Linux ethtool ``ETHTOOL_GMODULEEEPROM`` ioctl.
   The SFF-8636 decoder also reports the per-lane loss of signal,
   loss of lock and Tx fault flags.
+  The SFF-8472 decoder reports the Rx loss of signal and Tx fault state.
 
 * **Updated AF_XDP driver.**
 
diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 88d1f4a0a5..f9fd668731 100644
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
 
@@ -302,6 +308,16 @@ void sff_8472_show_all(const uint8_t *data, struct sff_output *d)
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_MCURR]);
 	sff_output_field(d, "Module voltage", val_string);
 
+	/* Real-time state of the pins, unlike the latched SFF-8636 flags */
+	if (data[SFF_A0_OPTIONS] & SFF_A0_OPTIONS_SOFT_RX_LOS)
+		sff_output_field(d, "Rx loss of signal",
+				 data[SFF_A2_BASE + SFF_A2_STATUS] & SFF_A2_STATUS_RX_LOS ?
+				 "Yes" : "No");
+	if (data[SFF_A0_OPTIONS] & SFF_A0_OPTIONS_SOFT_TX_FAULT)
+		sff_output_field(d, "Tx fault",
+				 data[SFF_A2_BASE + SFF_A2_STATUS] & SFF_A2_STATUS_TX_FAULT ?
+				 "Yes" : "No");
+
 	sff_output_field(d, "Alarm/warning flags implemented",
 			(sd.supports_alarms ? "Yes" : "No"));
 
-- 
2.47.3

