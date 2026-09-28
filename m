Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3048C9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:48:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CFD840A82;
	Mon, 28 Sep 2026 10:48:05 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [178.154.239.144])
 by mails.dpdk.org (Postfix) with ESMTP id 09BF240A73
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:48:04 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:1199:0:640:2d84:0])
 by forward500b.mail.yandex.net (postfix) with ESMTPS id C8485C2840;
 Mon, 28 Sep 2026 11:48:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id klcb2Uifv8c0-ZqqI2qTq; 
 Mon, 28 Sep 2026 11:48:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790585283; bh=zDbpb//uhKkWPiaieIvzm5zJXRmgsAG0F58fYy2Twhc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lR1N7AbmZL91x/VoHsr+XOMotm5hF4C2qaGwshCtF7txa5tkfGVENAE8+Uqj0lsr6
 77kE1aMvjlEkTVPpaBEpPgSOTgymL2FDZKfYzoPSzphfncy4SjyotXT9Cqk60ZwzPf
 tqAb1xCm8OXJrXakcOORoscFx05cAy2k36l+N3L8=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 2/4] ethdev: check module EEPROM length before decoding
Date: Mon, 28 Sep 2026 10:47:27 +0200
Message-ID: <20260928084729.973192-3-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928084729.973192-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
 <20260928084729.973192-1-roma55592@yandex.ru>
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

The SFF decoders assume the buffer is large enough for the module
type: SFF-8079 and SFF-8472 do not receive the length at all,
and SFF-8636 reads the alarm and warning thresholds from page 03h
even when only 256 bytes are available.
If a driver reports a length shorter than the type requires,
the decoders read past the end of the buffer.

Move the type dispatch into a common internal function which checks
the minimal length for each type before decoding:
- SFF-8079 and SFF-8436/8636 require at least 256 bytes,
- SFF-8472 requires 256 bytes for the base information,
  and the diagnostics (page A2h) are decoded only if 512 bytes
  are available.
In the SFF-8636 decoder, read the thresholds only if page 03h
is available, as it is already done when printing them.

This is a preparation for exposing the decoders to applications,
which may pass buffers of arbitrary length.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v2: do not read SFF-8636 thresholds when page 03h is not available

 lib/ethdev/sff_8636.c      | 52 ++++++++++++++++++++------------------
 lib/ethdev/sff_telemetry.c | 37 +++++++++++++++++++++------
 lib/ethdev/sff_telemetry.h |  8 ++++++
 3 files changed, 64 insertions(+), 33 deletions(-)

diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index 17058d4bfd..ac55c8e0b6 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -600,34 +600,36 @@ static void sff_8636_dom_parse(const uint8_t *data, struct sff_diags *sd)
 {
 	int i = 0;
 
-	/* Monitoring Thresholds for Alarms and Warnings */
 	sd->sfp_voltage[SFF_MCURR] = SFF_OFFSET_TO_U16(SFF_8636_VCC_CURR);
-	sd->sfp_voltage[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HALRM);
-	sd->sfp_voltage[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LALRM);
-	sd->sfp_voltage[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HWARN);
-	sd->sfp_voltage[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LWARN);
-
 	sd->sfp_temp[SFF_MCURR] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_CURR);
-	sd->sfp_temp[SFF_HALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HALRM);
-	sd->sfp_temp[SFF_LALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LALRM);
-	sd->sfp_temp[SFF_HWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HWARN);
-	sd->sfp_temp[SFF_LWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LWARN);
-
-	sd->bias_cur[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HALRM);
-	sd->bias_cur[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LALRM);
-	sd->bias_cur[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HWARN);
-	sd->bias_cur[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LWARN);
-
-	sd->tx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HALRM);
-	sd->tx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LALRM);
-	sd->tx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HWARN);
-	sd->tx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LWARN);
-
-	sd->rx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HALRM);
-	sd->rx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LALRM);
-	sd->rx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HWARN);
-	sd->rx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LWARN);
 
+	/* Monitoring Thresholds for Alarms and Warnings are in page 03h */
+	if (sd->supports_alarms) {
+		sd->sfp_voltage[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HALRM);
+		sd->sfp_voltage[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LALRM);
+		sd->sfp_voltage[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HWARN);
+		sd->sfp_voltage[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LWARN);
+
+		sd->sfp_temp[SFF_HALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HALRM);
+		sd->sfp_temp[SFF_LALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LALRM);
+		sd->sfp_temp[SFF_HWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HWARN);
+		sd->sfp_temp[SFF_LWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LWARN);
+
+		sd->bias_cur[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HALRM);
+		sd->bias_cur[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LALRM);
+		sd->bias_cur[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HWARN);
+		sd->bias_cur[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LWARN);
+
+		sd->tx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HALRM);
+		sd->tx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LALRM);
+		sd->tx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HWARN);
+		sd->tx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LWARN);
+
+		sd->rx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HALRM);
+		sd->rx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LALRM);
+		sd->rx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HWARN);
+		sd->rx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LWARN);
+	}
 
 	/* Channel Specific Data */
 	for (i = 0; i < SFF_MAX_CHANNEL_NUM; i++) {
diff --git a/lib/ethdev/sff_telemetry.c b/lib/ethdev/sff_telemetry.c
index 8c8e95affe..72d55322b6 100644
--- a/lib/ethdev/sff_telemetry.c
+++ b/lib/ethdev/sff_telemetry.c
@@ -99,25 +99,46 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 		return;
 	}
 
-	switch (minfo.type) {
+	ret = sff_decode_module_eeprom(minfo.type, einfo.data, einfo.length, &out);
+	if (ret == -ENOTSUP)
+		RTE_ETHDEV_LOG_LINE(NOTICE, "Unsupported module type: %u", minfo.type);
+	else if (ret != 0)
+		RTE_ETHDEV_LOG_LINE(ERR, "Port %u module EEPROM is too short: %u bytes",
+			port_id, einfo.length);
+
+	free(einfo.data);
+}
+
+int
+sff_decode_module_eeprom(uint32_t type, const uint8_t *data, uint32_t length,
+			 struct sff_output *d)
+{
+	switch (type) {
 	/* parsing module EEPROM data base on different module type */
 	case RTE_ETH_MODULE_SFF_8079:
-		sff_8079_show_all(einfo.data, &out);
+		if (length < RTE_ETH_MODULE_SFF_8079_LEN)
+			return -EINVAL;
+		sff_8079_show_all(data, d);
 		break;
 	case RTE_ETH_MODULE_SFF_8472:
-		sff_8079_show_all(einfo.data, &out);
-		sff_8472_show_all(einfo.data, &out);
+		if (length < RTE_ETH_MODULE_SFF_8079_LEN)
+			return -EINVAL;
+		sff_8079_show_all(data, d);
+		/* diagnostics are in the second page (A2h) */
+		if (length >= RTE_ETH_MODULE_SFF_8472_LEN)
+			sff_8472_show_all(data, d);
 		break;
 	case RTE_ETH_MODULE_SFF_8436:
 	case RTE_ETH_MODULE_SFF_8636:
-		sff_8636_show_all(einfo.data, einfo.length, &out);
+		if (length < RTE_ETH_MODULE_SFF_8636_LEN)
+			return -EINVAL;
+		sff_8636_show_all(data, length, d);
 		break;
 	default:
-		RTE_ETHDEV_LOG_LINE(NOTICE, "Unsupported module type: %u", minfo.type);
-		break;
+		return -ENOTSUP;
 	}
 
-	free(einfo.data);
+	return 0;
 }
 
 void
diff --git a/lib/ethdev/sff_telemetry.h b/lib/ethdev/sff_telemetry.h
index 2a6d79a9c1..1d2c8fd444 100644
--- a/lib/ethdev/sff_telemetry.h
+++ b/lib/ethdev/sff_telemetry.h
@@ -25,6 +25,14 @@ void sff_8472_show_all(const uint8_t *data, struct sff_output *d);
 /* SFF-8636 Optics diagnostics */
 void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d);
 
+/*
+ * Decode module EEPROM of the given type (RTE_ETH_MODULE_SFF_*).
+ * Returns 0 on success, -EINVAL if the data is too short for the type,
+ * -ENOTSUP if the type is unknown.
+ */
+int sff_decode_module_eeprom(uint32_t type, const uint8_t *data, uint32_t length,
+			     struct sff_output *d);
+
 int eth_dev_handle_port_module_eeprom(const char *cmd __rte_unused,
 				      const char *params,
 				      struct rte_tel_data *d);
-- 
2.47.3

