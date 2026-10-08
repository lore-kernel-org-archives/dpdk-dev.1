Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B1CA600A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:24:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B29F427BD;
	Thu,  8 Oct 2026 10:23:50 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id EBE4F40DFB
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:23:48 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id ACA2689309;
 Thu, 08 Oct 2026 11:23:48 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 93546806F1;
 Thu, 08 Oct 2026 11:23:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id UNJ0VOBd8Cg0-ntA6AdB0; 
 Thu, 08 Oct 2026 11:23:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791447818; bh=b/Zz7YO0ghtq5rMMCcIFUFF1MIKwagOrxD7sYwcfRb0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=po2tMeyymJd0ZMtI4WiSdlHAz31Pa05Zs5/MovQnaJj5fGBVunmGn+o/140jTrUmk
 8hZ+CQnCWFwUNjG9y892dPCqvREb82epLbpCOOxPyykbNPWXoBhds10M0r/eY00X99
 p5hZwiA2ZrXfoxPxQVxt/XgQL882clzPHMR1fT9c=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH 1/4] ethdev: report SFF-8636 lane status flags
Date: Thu,  8 Oct 2026 10:23:23 +0200
Message-ID: <c7404b53edc642a7a1313823f810b255bb0286e3.1791447600.git.roma55592@yandex.ru>
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

The SFF-8636 decoder shows the module identity and the digital
diagnostics, but not the channel status flags, which are usually
the first thing to check when a QSFP link does not come up.

Report the per-lane Rx and Tx loss of signal, Rx and Tx CDR loss
of lock, Tx fault and Tx adaptive equalization fault flags from
bytes 3 to 5 of the lower page, each one only if the module
advertises it in the options of page 00h. A flag is shown as
"None" if no lane is flagged, or as a list per lane otherwise,
following the output of ethtool.

These flags are latched and cleared on read, so they report the
events since the previous read of the module.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 lib/ethdev/sff_8636.c                  | 35 ++++++++++++++++++++++++++
 lib/ethdev/sff_8636.h                  | 12 +++++++++
 lib/ethdev/sff_common.c                | 25 ++++++++++++++++++
 lib/ethdev/sff_common.h                |  2 ++
 5 files changed, 76 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d25dc72edf..08c554cedb 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -84,6 +84,8 @@ New Features
   It can decode data read with ``rte_eth_dev_get_module_eeprom()``
   or obtained from any other source with the same layout,
   such as the Linux ethtool ``ETHTOOL_GMODULEEEPROM`` ioctl.
+  The SFF-8636 decoder also reports the per-lane loss of signal,
+  loss of lock and Tx fault flags.
 
 * **Updated AF_XDP driver.**
 
diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index 40e5404caf..8fc48e1798 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -452,6 +452,40 @@ static void sff_8636_show_rate_identifier(const uint8_t *data, struct sff_output
 	sff_output_field(d, "Rate identifier", val_string);
 }
 
+/*
+ * Channel status flags are latched and cleared when read by the host,
+ * so they report the events since the previous read of the module.
+ * Each flag is reported only if the module advertises it.
+ */
+static void sff_8636_show_signals(const uint8_t *data, struct sff_output *d)
+{
+	uint8_t los = data[SFF_8636_LOS_AW_OFFSET];
+	uint8_t fault = data[SFF_8636_FAULT_AW_OFFSET];
+	uint8_t lol = data[SFF_8636_LOL_AW_OFFSET];
+
+	/* There is no Rx LOS implemented bit, use the Tx one for both */
+	if (data[SFF_8636_OPTION_4_OFFSET] & SFF_8636_O4_TX_LOS) {
+		sff_show_lane_status("Rx loss of signal", SFF_MAX_CHANNEL_NUM,
+				     SFF_8636_LANES_LOW(los), d);
+		sff_show_lane_status("Tx loss of signal", SFF_MAX_CHANNEL_NUM,
+				     SFF_8636_LANES_HIGH(los), d);
+	}
+
+	if (data[SFF_8636_OPTION_3_OFFSET] & SFF_8636_O3_RX_LOL)
+		sff_show_lane_status("Rx loss of lock", SFF_MAX_CHANNEL_NUM,
+				     SFF_8636_LANES_LOW(lol), d);
+	if (data[SFF_8636_OPTION_3_OFFSET] & SFF_8636_O3_TX_LOL)
+		sff_show_lane_status("Tx loss of lock", SFF_MAX_CHANNEL_NUM,
+				     SFF_8636_LANES_HIGH(lol), d);
+
+	if (data[SFF_8636_OPTION_4_OFFSET] & SFF_8636_O4_TX_FAULT)
+		sff_show_lane_status("Tx fault", SFF_MAX_CHANNEL_NUM,
+				     SFF_8636_LANES_LOW(fault), d);
+	if (data[SFF_8636_OPTION_2_OFFSET] & SFF_8636_O2_TX_EQ_AUTO)
+		sff_show_lane_status("Tx adaptive eq fault", SFF_MAX_CHANNEL_NUM,
+				     SFF_8636_LANES_HIGH(fault), d);
+}
+
 static void sff_8636_show_oui(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_oui(data, SFF_8636_VENDOR_OUI_OFFSET, d);
@@ -761,6 +795,7 @@ void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_outp
 		sff_show_ascii(data, SFF_8636_DATE_YEAR_OFFSET,
 			     SFF_8636_DATE_VENDOR_LOT_OFFSET + 1, "Date code", d);
 		sff_8636_show_revision_compliance(data, d);
+		sff_8636_show_signals(data, d);
 		sff_8636_show_dom(data, eeprom_len, d);
 	}
 }
diff --git a/lib/ethdev/sff_8636.h b/lib/ethdev/sff_8636.h
index cf11a2c247..d2a923a7c0 100644
--- a/lib/ethdev/sff_8636.h
+++ b/lib/ethdev/sff_8636.h
@@ -55,6 +55,12 @@
 #define	SFF_8636_TX2_FAULT_AW	RTE_BIT32(1)
 #define	SFF_8636_TX1_FAULT_AW	RTE_BIT32(0)
 
+#define	SFF_8636_LOL_AW_OFFSET	0x05
+
+/* Lanes 1-4 of the channel status flags are in bits 0-3 or 4-7 */
+#define	SFF_8636_LANES_LOW(val)		((val) & 0xf)
+#define	SFF_8636_LANES_HIGH(val)	(((val) >> 4) & 0xf)
+
 /* Module Monitor Interrupt Flags - 6-8 */
 #define	SFF_8636_TEMP_AW_OFFSET	0x06
 #define	SFF_8636_TEMP_HALARM_STATUS		RTE_BIT32(7)
@@ -488,9 +494,15 @@
 #define	SFF_8636_ETHERNET_100G_ACC2		0x19
 
 #define	SFF_8636_OPTION_2_OFFSET	0xC1
+/* Tx input equalizers auto-adaptive */
+#define	SFF_8636_O2_TX_EQ_AUTO		RTE_BIT32(3)
 /* Rx output amplitude */
 #define	SFF_8636_O2_RX_OUTPUT_AMP	RTE_BIT32(0)
 #define	SFF_8636_OPTION_3_OFFSET	0xC2
+/* Tx CDR Loss of Lock flag implemented */
+#define	SFF_8636_O3_TX_LOL		RTE_BIT32(5)
+/* Rx CDR Loss of Lock flag implemented */
+#define	SFF_8636_O3_RX_LOL		RTE_BIT32(4)
 /* Rx Squelch Disable */
 #define	SFF_8636_O3_RX_SQL_DSBL	RTE_BIT32(3)
 /* Rx Output Disable capable */
diff --git a/lib/ethdev/sff_common.c b/lib/ethdev/sff_common.c
index a36bf83026..0fc498edb0 100644
--- a/lib/ethdev/sff_common.c
+++ b/lib/ethdev/sff_common.c
@@ -84,6 +84,31 @@ void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
 	sff_output_field(d, name, val_string);
 }
 
+/*
+ * Report a per-lane status bitmap, lane 1 in bit 0:
+ * "None" if no lane is flagged, otherwise "[ Yes, No, ... ]".
+ */
+void sff_show_lane_status(const char *name, unsigned int lane_cnt,
+			  unsigned int value, struct sff_output *d)
+{
+	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
+	unsigned int lane;
+
+	if (value == 0) {
+		sff_output_field(d, name, "None");
+		return;
+	}
+
+	strlcpy(val_string, "[", sizeof(val_string));
+	for (lane = 0; lane < lane_cnt; lane++) {
+		strlcat(val_string, (value & RTE_BIT32(lane)) ? " Yes" : " No",
+			sizeof(val_string));
+		strlcat(val_string, lane + 1 < lane_cnt ? "," : " ]",
+			sizeof(val_string));
+	}
+	sff_output_field(d, name, val_string);
+}
+
 void sff_8024_show_oui(const uint8_t *data, int id_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
diff --git a/lib/ethdev/sff_common.h b/lib/ethdev/sff_common.h
index d346e1b378..9041f8ed17 100644
--- a/lib/ethdev/sff_common.h
+++ b/lib/ethdev/sff_common.h
@@ -191,6 +191,8 @@ void sff_show_value_with_unit(const uint8_t *data, unsigned int reg,
 void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
 		    unsigned int last_reg, const char *name, struct sff_output *d);
 void sff_show_thresholds(struct sff_diags sd, struct sff_output *d);
+void sff_show_lane_status(const char *name, unsigned int lane_cnt,
+			  unsigned int value, struct sff_output *d);
 
 void sff_8024_show_oui(const uint8_t *data, int id_offset, struct sff_output *d);
 void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct sff_output *d);
-- 
2.47.3

