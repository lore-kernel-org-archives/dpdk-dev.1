Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89265C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE41B40E96;
	Tue, 29 Sep 2026 09:08:14 +0200 (CEST)
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net
 [178.154.239.80])
 by mails.dpdk.org (Postfix) with ESMTP id 954914029D
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:08:10 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward500a.mail.yandex.net (postfix) with ESMTPS id 947E4C3756;
 Tue, 29 Sep 2026 10:08:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id a7cWxixi4iE0-sIX0v4F7; 
 Tue, 29 Sep 2026 10:08:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790665689; bh=j9AtRcQ6x7jnPt2eP22Id5fgzDRqswEjSKQ1QTX7wQc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=B6uDJ7gbc4PBDSFhkAPEs8KYyacCPwX8wInu54Zn8TDjrB3sUMCTasLssNNpvcZ97
 mhKUV/wYxLAeXD5MZyxkcCVCqZLrOPKjC3tlCLy52zoVFA3gMGsGWjRQ9Z1Zfi0Apd
 q7zqfp0SPkHXGUy/rmkYWR7Wo6k5YyloXc31FWfg=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 2/6] ethdev: decouple SFF module EEPROM decoders from
 telemetry
Date: Tue, 29 Sep 2026 09:07:30 +0200
Message-ID: <20260929070734.1106134-3-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929070734.1106134-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
 <20260929070734.1106134-1-roma55592@yandex.ru>
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

The SFF-8079, SFF-8472 and SFF-8636 decoders write their results
directly into a telemetry dictionary, so the decoding logic cannot
be reused outside of the telemetry command.

Introduce an internal output descriptor with a per-field callback
and pass it to the decoders instead of the telemetry data.
The telemetry handler becomes one of the callback consumers,
its output is unchanged.

As the field reporting function is no longer telemetry specific,
rename ssf_add_dict_string() to sff_output_field()
and move it with the decoder declarations to sff_common.h.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v3: rename ssf_add_dict_string() to sff_output_field(),
    move generic declarations to sff_common.h

 lib/ethdev/sff_8079.c      | 204 ++++++++++++++++-----------------
 lib/ethdev/sff_8472.c      |  20 ++--
 lib/ethdev/sff_8636.c      | 226 ++++++++++++++++++-------------------
 lib/ethdev/sff_common.c    |  72 ++++++------
 lib/ethdev/sff_common.h    |  37 ++++--
 lib/ethdev/sff_telemetry.c |  68 +++++------
 lib/ethdev/sff_telemetry.h |  14 ---
 7 files changed, 327 insertions(+), 314 deletions(-)

diff --git a/lib/ethdev/sff_8079.c b/lib/ethdev/sff_8079.c
index 91ad25ffcd..9632a26af3 100644
--- a/lib/ethdev/sff_8079.c
+++ b/lib/ethdev/sff_8079.c
@@ -7,12 +7,12 @@
 
 #include "sff_common.h"
 
-static void sff_8079_show_identifier(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_identifier(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_identifier(data, 0, d);
 }
 
-static void sff_8079_show_ext_identifier(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_ext_identifier(const uint8_t *data, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -29,15 +29,15 @@ static void sff_8079_show_ext_identifier(const uint8_t *data, struct rte_tel_dat
 		strlcat(val_string, tmp, sizeof(val_string));
 	} else
 		strlcat(val_string, " (unknown)", sizeof(val_string));
-	ssf_add_dict_string(d, "Extended identifier", val_string);
+	sff_output_field(d, "Extended identifier", val_string);
 }
 
-static void sff_8079_show_connector(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_connector(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_connector(data, 2, d);
 }
 
-static void sff_8079_show_transceiver(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_transceiver(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Transceiver type";
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
@@ -45,194 +45,194 @@ static void sff_8079_show_transceiver(const uint8_t *data, struct rte_tel_data *
 	snprintf(val_string, sizeof(val_string),
 		"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x",
 		data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[36]);
-	ssf_add_dict_string(d, "Transceiver codes", val_string);
+	sff_output_field(d, "Transceiver codes", val_string);
 
 	/* 10G Ethernet Compliance Codes */
 	if (data[3] & (1 << 7))
-		ssf_add_dict_string(d, "10G Ethernet transceiver type",
+		sff_output_field(d, "10G Ethernet transceiver type",
 		"10G Ethernet: 10G Base-ER [SFF-8472 rev10.4 onwards]");
 	if (data[3] & (1 << 6))
-		ssf_add_dict_string(d, name, "10G Ethernet: 10G Base-LRM");
+		sff_output_field(d, name, "10G Ethernet: 10G Base-LRM");
 	if (data[3] & (1 << 5))
-		ssf_add_dict_string(d, name, "10G Ethernet: 10G Base-LR");
+		sff_output_field(d, name, "10G Ethernet: 10G Base-LR");
 	if (data[3] & (1 << 4))
-		ssf_add_dict_string(d, name, "10G Ethernet: 10G Base-SR");
+		sff_output_field(d, name, "10G Ethernet: 10G Base-SR");
 
 	/* Infiniband Compliance Codes */
 	if (data[3] & (1 << 3))
-		ssf_add_dict_string(d, name, "Infiniband: 1X SX");
+		sff_output_field(d, name, "Infiniband: 1X SX");
 	if (data[3] & (1 << 2))
-		ssf_add_dict_string(d, name, "Infiniband: 1X LX");
+		sff_output_field(d, name, "Infiniband: 1X LX");
 	if (data[3] & (1 << 1))
-		ssf_add_dict_string(d, name, "Infiniband: 1X Copper Active");
+		sff_output_field(d, name, "Infiniband: 1X Copper Active");
 	if (data[3] & (1 << 0))
-		ssf_add_dict_string(d, name, "Infiniband: 1X Copper Passive");
+		sff_output_field(d, name, "Infiniband: 1X Copper Passive");
 
 	/* ESCON Compliance Codes */
 	if (data[4] & (1 << 7))
-		ssf_add_dict_string(d, name, "ESCON: ESCON MMF, 1310nm LED");
+		sff_output_field(d, name, "ESCON: ESCON MMF, 1310nm LED");
 	if (data[4] & (1 << 6))
-		ssf_add_dict_string(d, name, "ESCON: ESCON SMF, 1310nm Laser");
+		sff_output_field(d, name, "ESCON: ESCON SMF, 1310nm Laser");
 
 	/* SONET Compliance Codes */
 	if (data[4] & (1 << 5))
-		ssf_add_dict_string(d, name, "SONET: OC-192, short reach");
+		sff_output_field(d, name, "SONET: OC-192, short reach");
 	if (data[4] & (1 << 4))
-		ssf_add_dict_string(d, name, "SONET: SONET reach specifier bit 1");
+		sff_output_field(d, name, "SONET: SONET reach specifier bit 1");
 	if (data[4] & (1 << 3))
-		ssf_add_dict_string(d, name, "SONET: SONET reach specifier bit 2");
+		sff_output_field(d, name, "SONET: SONET reach specifier bit 2");
 	if (data[4] & (1 << 2))
-		ssf_add_dict_string(d, name, "SONET: OC-48, long reach");
+		sff_output_field(d, name, "SONET: OC-48, long reach");
 	if (data[4] & (1 << 1))
-		ssf_add_dict_string(d, name, "SONET: OC-48, intermediate reach");
+		sff_output_field(d, name, "SONET: OC-48, intermediate reach");
 	if (data[4] & (1 << 0))
-		ssf_add_dict_string(d, name, "SONET: OC-48, short reach");
+		sff_output_field(d, name, "SONET: OC-48, short reach");
 	if (data[5] & (1 << 6))
-		ssf_add_dict_string(d, name, "SONET: OC-12, single mode, long reach");
+		sff_output_field(d, name, "SONET: OC-12, single mode, long reach");
 	if (data[5] & (1 << 5))
-		ssf_add_dict_string(d, name, "SONET: OC-12, single mode, inter. reach");
+		sff_output_field(d, name, "SONET: OC-12, single mode, inter. reach");
 	if (data[5] & (1 << 4))
-		ssf_add_dict_string(d, name, "SONET: OC-12, short reach");
+		sff_output_field(d, name, "SONET: OC-12, short reach");
 	if (data[5] & (1 << 2))
-		ssf_add_dict_string(d, name, "SONET: OC-3, single mode, long reach");
+		sff_output_field(d, name, "SONET: OC-3, single mode, long reach");
 	if (data[5] & (1 << 1))
-		ssf_add_dict_string(d, name, "SONET: OC-3, single mode, inter. reach");
+		sff_output_field(d, name, "SONET: OC-3, single mode, inter. reach");
 	if (data[5] & (1 << 0))
-		ssf_add_dict_string(d, name, "SONET: OC-3, short reach");
+		sff_output_field(d, name, "SONET: OC-3, short reach");
 
 	/* Ethernet Compliance Codes */
 	if (data[6] & (1 << 7))
-		ssf_add_dict_string(d, name, "Ethernet: BASE-PX");
+		sff_output_field(d, name, "Ethernet: BASE-PX");
 	if (data[6] & (1 << 6))
-		ssf_add_dict_string(d, name, "Ethernet: BASE-BX10");
+		sff_output_field(d, name, "Ethernet: BASE-BX10");
 	if (data[6] & (1 << 5))
-		ssf_add_dict_string(d, name, "Ethernet: 100BASE-FX");
+		sff_output_field(d, name, "Ethernet: 100BASE-FX");
 	if (data[6] & (1 << 4))
-		ssf_add_dict_string(d, name, "Ethernet: 100BASE-LX/LX10");
+		sff_output_field(d, name, "Ethernet: 100BASE-LX/LX10");
 	if (data[6] & (1 << 3))
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-T");
+		sff_output_field(d, name, "Ethernet: 1000BASE-T");
 	if (data[6] & (1 << 2))
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-CX");
+		sff_output_field(d, name, "Ethernet: 1000BASE-CX");
 	if (data[6] & (1 << 1))
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-LX");
+		sff_output_field(d, name, "Ethernet: 1000BASE-LX");
 	if (data[6] & (1 << 0))
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-SX");
+		sff_output_field(d, name, "Ethernet: 1000BASE-SX");
 
 	/* Fibre Channel link length */
 	if (data[7] & (1 << 7))
-		ssf_add_dict_string(d, name, "FC: very long distance (V)");
+		sff_output_field(d, name, "FC: very long distance (V)");
 	if (data[7] & (1 << 6))
-		ssf_add_dict_string(d, name, "FC: short distance (S)");
+		sff_output_field(d, name, "FC: short distance (S)");
 	if (data[7] & (1 << 5))
-		ssf_add_dict_string(d, name, "FC: intermediate distance (I)");
+		sff_output_field(d, name, "FC: intermediate distance (I)");
 	if (data[7] & (1 << 4))
-		ssf_add_dict_string(d, name, "FC: long distance (L)");
+		sff_output_field(d, name, "FC: long distance (L)");
 	if (data[7] & (1 << 3))
-		ssf_add_dict_string(d, name, "FC: medium distance (M)");
+		sff_output_field(d, name, "FC: medium distance (M)");
 
 	/* Fibre Channel transmitter technology */
 	if (data[7] & (1 << 2))
-		ssf_add_dict_string(d, name, "FC: Shortwave laser, linear Rx (SA)");
+		sff_output_field(d, name, "FC: Shortwave laser, linear Rx (SA)");
 	if (data[7] & (1 << 1))
-		ssf_add_dict_string(d, name, "FC: Longwave laser (LC)");
+		sff_output_field(d, name, "FC: Longwave laser (LC)");
 	if (data[7] & (1 << 0))
-		ssf_add_dict_string(d, name, "FC: Electrical inter-enclosure (EL)");
+		sff_output_field(d, name, "FC: Electrical inter-enclosure (EL)");
 	if (data[8] & (1 << 7))
-		ssf_add_dict_string(d, name, "FC: Electrical intra-enclosure (EL)");
+		sff_output_field(d, name, "FC: Electrical intra-enclosure (EL)");
 	if (data[8] & (1 << 6))
-		ssf_add_dict_string(d, name, "FC: Shortwave laser w/o OFC (SN)");
+		sff_output_field(d, name, "FC: Shortwave laser w/o OFC (SN)");
 	if (data[8] & (1 << 5))
-		ssf_add_dict_string(d, name, "FC: Shortwave laser with OFC (SL)");
+		sff_output_field(d, name, "FC: Shortwave laser with OFC (SL)");
 	if (data[8] & (1 << 4))
-		ssf_add_dict_string(d, name, "FC: Longwave laser (LL)");
+		sff_output_field(d, name, "FC: Longwave laser (LL)");
 	if (data[8] & (1 << 3))
-		ssf_add_dict_string(d, name, "Active Cable");
+		sff_output_field(d, name, "Active Cable");
 	if (data[8] & (1 << 2))
-		ssf_add_dict_string(d, name, "Passive Cable");
+		sff_output_field(d, name, "Passive Cable");
 	if (data[8] & (1 << 1))
-		ssf_add_dict_string(d, name, "FC: Copper FC-BaseT");
+		sff_output_field(d, name, "FC: Copper FC-BaseT");
 
 	/* Fibre Channel transmission media */
 	if (data[9] & (1 << 7))
-		ssf_add_dict_string(d, name, "FC: Twin Axial Pair (TW)");
+		sff_output_field(d, name, "FC: Twin Axial Pair (TW)");
 	if (data[9] & (1 << 6))
-		ssf_add_dict_string(d, name, "FC: Twisted Pair (TP)");
+		sff_output_field(d, name, "FC: Twisted Pair (TP)");
 	if (data[9] & (1 << 5))
-		ssf_add_dict_string(d, name, "FC: Miniature Coax (MI)");
+		sff_output_field(d, name, "FC: Miniature Coax (MI)");
 	if (data[9] & (1 << 4))
-		ssf_add_dict_string(d, name, "FC: Video Coax (TV)");
+		sff_output_field(d, name, "FC: Video Coax (TV)");
 	if (data[9] & (1 << 3))
-		ssf_add_dict_string(d, name, "FC: Multimode, 62.5um (M6)");
+		sff_output_field(d, name, "FC: Multimode, 62.5um (M6)");
 	if (data[9] & (1 << 2))
-		ssf_add_dict_string(d, name, "FC: Multimode, 50um (M5)");
+		sff_output_field(d, name, "FC: Multimode, 50um (M5)");
 	if (data[9] & (1 << 0))
-		ssf_add_dict_string(d, name, "FC: Single Mode (SM)");
+		sff_output_field(d, name, "FC: Single Mode (SM)");
 
 	/* Fibre Channel speed */
 	if (data[10] & (1 << 7))
-		ssf_add_dict_string(d, name, "FC: 1200 MBytes/sec");
+		sff_output_field(d, name, "FC: 1200 MBytes/sec");
 	if (data[10] & (1 << 6))
-		ssf_add_dict_string(d, name, "FC: 800 MBytes/sec");
+		sff_output_field(d, name, "FC: 800 MBytes/sec");
 	if (data[10] & (1 << 4))
-		ssf_add_dict_string(d, name, "FC: 400 MBytes/sec");
+		sff_output_field(d, name, "FC: 400 MBytes/sec");
 	if (data[10] & (1 << 2))
-		ssf_add_dict_string(d, name, "FC: 200 MBytes/sec");
+		sff_output_field(d, name, "FC: 200 MBytes/sec");
 	if (data[10] & (1 << 0))
-		ssf_add_dict_string(d, name, "FC: 100 MBytes/sec");
+		sff_output_field(d, name, "FC: 100 MBytes/sec");
 
 	/* Extended Specification Compliance Codes from SFF-8024 */
 	switch (data[36]) {
 	case 0x1:
-		ssf_add_dict_string(d, name,
+		sff_output_field(d, name,
 			"Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)");
 		break;
 	case 0x2:
-		ssf_add_dict_string(d, name, "Extended: 100G Base-SR4 or 25GBase-SR");
+		sff_output_field(d, name, "Extended: 100G Base-SR4 or 25GBase-SR");
 		break;
 	case 0x3:
-		ssf_add_dict_string(d, name, "Extended: 100G Base-LR4 or 25GBase-LR");
+		sff_output_field(d, name, "Extended: 100G Base-LR4 or 25GBase-LR");
 		break;
 	case 0x4:
-		ssf_add_dict_string(d, name, "Extended: 100G Base-ER4 or 25GBase-ER");
+		sff_output_field(d, name, "Extended: 100G Base-ER4 or 25GBase-ER");
 		break;
 	case 0x8:
-		ssf_add_dict_string(d, name,
+		sff_output_field(d, name,
 			"Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)");
 		break;
 	case 0xb:
-		ssf_add_dict_string(d, name, "Extended: 100G Base-CR4 or 25G Base-CR CA-L");
+		sff_output_field(d, name, "Extended: 100G Base-CR4 or 25G Base-CR CA-L");
 		break;
 	case 0xc:
-		ssf_add_dict_string(d, name, "Extended: 25G Base-CR CA-S");
+		sff_output_field(d, name, "Extended: 25G Base-CR CA-S");
 		break;
 	case 0xd:
-		ssf_add_dict_string(d, name, "Extended: 25G Base-CR CA-N");
+		sff_output_field(d, name, "Extended: 25G Base-CR CA-N");
 		break;
 	case 0x16:
-		ssf_add_dict_string(d, name, "Extended: 10Gbase-T with SFI electrical interface");
+		sff_output_field(d, name, "Extended: 10Gbase-T with SFI electrical interface");
 		break;
 	case 0x18:
-		ssf_add_dict_string(d, name,
+		sff_output_field(d, name,
 			"Extended: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)");
 		break;
 	case 0x19:
-		ssf_add_dict_string(d, name,
+		sff_output_field(d, name,
 			"Extended: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)");
 		break;
 	case 0x1c:
-		ssf_add_dict_string(d, name, "Extended: 10Gbase-T Short Reach");
+		sff_output_field(d, name, "Extended: 10Gbase-T Short Reach");
 		break;
 	default:
 		break;
 	}
 }
 
-static void sff_8079_show_encoding(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_encoding(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_encoding(data, 11, RTE_ETH_MODULE_SFF_8472, d);
 }
 
-static void sff_8079_show_rate_identifier(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_rate_identifier(const uint8_t *data, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -259,17 +259,17 @@ static void sff_8079_show_rate_identifier(const uint8_t *data, struct rte_tel_da
 		strlcat(val_string, " (reserved or unknown)", sizeof(val_string));
 		break;
 	}
-	ssf_add_dict_string(d, "Rate identifier", val_string);
+	sff_output_field(d, "Rate identifier", val_string);
 }
 
-static void sff_8079_show_oui(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_oui(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_oui(data, 37, d);
 }
 
 static void
 sff_8079_show_wavelength_or_copper_compliance(const uint8_t *data,
-					      struct rte_tel_data *d)
+					      struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -287,7 +287,7 @@ sff_8079_show_wavelength_or_copper_compliance(const uint8_t *data,
 			break;
 		}
 		strlcat(val_string, " [SFF-8472 rev10.4 only]", sizeof(val_string));
-		ssf_add_dict_string(d, "Passive Cu cmplnce.", val_string);
+		sff_output_field(d, "Passive Cu cmplnce.", val_string);
 	} else if (data[8] & (1 << 3)) {
 		snprintf(val_string, sizeof(val_string), "0x%02x", data[60]);
 		switch (data[60]) {
@@ -305,50 +305,50 @@ sff_8079_show_wavelength_or_copper_compliance(const uint8_t *data,
 			break;
 		}
 		strlcat(val_string, " [SFF-8472 rev10.4 only]", sizeof(val_string));
-		ssf_add_dict_string(d, "Active Cu cmplnce.", val_string);
+		sff_output_field(d, "Active Cu cmplnce.", val_string);
 	} else {
 		snprintf(val_string, sizeof(val_string), "%unm", (data[60] << 8) | data[61]);
-		ssf_add_dict_string(d, "Laser wavelength", val_string);
+		sff_output_field(d, "Laser wavelength", val_string);
 	}
 }
 
-static void sff_8079_show_options(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_options(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Option";
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
 	snprintf(val_string, sizeof(val_string), "0x%02x 0x%02x", data[64], data[65]);
-	ssf_add_dict_string(d, "Option values", val_string);
+	sff_output_field(d, "Option values", val_string);
 
 	if (data[65] & (1 << 1))
-		ssf_add_dict_string(d, name, "RX_LOS implemented");
+		sff_output_field(d, name, "RX_LOS implemented");
 	if (data[65] & (1 << 2))
-		ssf_add_dict_string(d, name, "RX_LOS implemented, inverted");
+		sff_output_field(d, name, "RX_LOS implemented, inverted");
 	if (data[65] & (1 << 3))
-		ssf_add_dict_string(d, name, "TX_FAULT implemented");
+		sff_output_field(d, name, "TX_FAULT implemented");
 	if (data[65] & (1 << 4))
-		ssf_add_dict_string(d, name, "TX_DISABLE implemented");
+		sff_output_field(d, name, "TX_DISABLE implemented");
 	if (data[65] & (1 << 5))
-		ssf_add_dict_string(d, name, "RATE_SELECT implemented");
+		sff_output_field(d, name, "RATE_SELECT implemented");
 	if (data[65] & (1 << 6))
-		ssf_add_dict_string(d, name, "Tunable transmitter technology");
+		sff_output_field(d, name, "Tunable transmitter technology");
 	if (data[65] & (1 << 7))
-		ssf_add_dict_string(d, name, "Receiver decision threshold implemented");
+		sff_output_field(d, name, "Receiver decision threshold implemented");
 	if (data[64] & (1 << 0))
-		ssf_add_dict_string(d, name, "Linear receiver output implemented");
+		sff_output_field(d, name, "Linear receiver output implemented");
 	if (data[64] & (1 << 1))
-		ssf_add_dict_string(d, name, "Power level 2 requirement");
+		sff_output_field(d, name, "Power level 2 requirement");
 	if (data[64] & (1 << 2))
-		ssf_add_dict_string(d, name, "Cooled transceiver implemented");
+		sff_output_field(d, name, "Cooled transceiver implemented");
 	if (data[64] & (1 << 3))
-		ssf_add_dict_string(d, name, "Retimer or CDR implemented");
+		sff_output_field(d, name, "Retimer or CDR implemented");
 	if (data[64] & (1 << 4))
-		ssf_add_dict_string(d, name, "Paging implemented");
+		sff_output_field(d, name, "Paging implemented");
 	if (data[64] & (1 << 5))
-		ssf_add_dict_string(d, name, "Power level 3 requirement");
+		sff_output_field(d, name, "Power level 3 requirement");
 }
 
-void sff_8079_show_all(const uint8_t *data, struct rte_tel_data *d)
+void sff_8079_show_all(const uint8_t *data, struct sff_output *d)
 {
 	sff_8079_show_identifier(data, d);
 	if (((data[0] == 0x02) || (data[0] == 0x03)) && (data[1] == 0x04)) {
@@ -372,7 +372,7 @@ void sff_8079_show_all(const uint8_t *data, struct rte_tel_data *d)
 		sff_8079_show_encoding(data, d);
 
 		snprintf(val_string, sizeof(val_string), "%uMBd", br_nom);
-		ssf_add_dict_string(d, "BR, Nominal", val_string);
+		sff_output_field(d, "BR, Nominal", val_string);
 
 		sff_8079_show_rate_identifier(data, d);
 		sff_show_value_with_unit(data, 14,
@@ -391,9 +391,9 @@ void sff_8079_show_all(const uint8_t *data, struct rte_tel_data *d)
 		sff_8079_show_options(data, d);
 
 		snprintf(val_string, sizeof(val_string), "%u%%", br_max);
-		ssf_add_dict_string(d, "BR margin, max", val_string);
+		sff_output_field(d, "BR margin, max", val_string);
 		snprintf(val_string, sizeof(val_string), "%u%%", br_min);
-		ssf_add_dict_string(d, "BR margin, min", val_string);
+		sff_output_field(d, "BR margin, min", val_string);
 
 		sff_show_ascii(data, 68, 83, "Vendor SN", d);
 		sff_show_ascii(data, 84, 91, "Date code", d);
diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 97f231854c..f58eba9d2d 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -231,7 +231,7 @@ static void sff_8472_parse_eeprom(const uint8_t *data, struct sff_diags *sd)
 		sff_8472_calibration(data, sd);
 }
 
-void sff_8472_show_all(const uint8_t *data, struct rte_tel_data *d)
+void sff_8472_show_all(const uint8_t *data, struct sff_output *d)
 {
 	struct sff_diags sd = {0};
 	const char *rx_power_string = NULL;
@@ -241,16 +241,16 @@ void sff_8472_show_all(const uint8_t *data, struct rte_tel_data *d)
 	sff_8472_parse_eeprom(data, &sd);
 
 	if (!sd.supports_dom) {
-		ssf_add_dict_string(d, "Optical diagnostics support", "No");
+		sff_output_field(d, "Optical diagnostics support", "No");
 		return;
 	}
-	ssf_add_dict_string(d, "Optical diagnostics support", "Yes");
+	sff_output_field(d, "Optical diagnostics support", "Yes");
 
 	SFF_SPRINT_BIAS(val_string, sd.bias_cur[SFF_MCURR]);
-	ssf_add_dict_string(d, "Laser bias current", val_string);
+	sff_output_field(d, "Laser bias current", val_string);
 
 	SFF_SPRINT_xX_PWR(val_string, sd.tx_power[SFF_MCURR]);
-	ssf_add_dict_string(d, "Laser output power", val_string);
+	sff_output_field(d, "Laser output power", val_string);
 
 	if (!sd.rx_power_type)
 		rx_power_string = "Receiver signal OMA";
@@ -258,20 +258,20 @@ void sff_8472_show_all(const uint8_t *data, struct rte_tel_data *d)
 		rx_power_string = "Receiver signal average optical power";
 
 	SFF_SPRINT_xX_PWR(val_string, sd.rx_power[SFF_MCURR]);
-	ssf_add_dict_string(d, rx_power_string, val_string);
+	sff_output_field(d, rx_power_string, val_string);
 
 	SFF_SPRINT_TEMP(val_string, sd.sfp_temp[SFF_MCURR]);
-	ssf_add_dict_string(d, "Module temperature", val_string);
+	sff_output_field(d, "Module temperature", val_string);
 
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_MCURR]);
-	ssf_add_dict_string(d, "Module voltage", val_string);
+	sff_output_field(d, "Module voltage", val_string);
 
-	ssf_add_dict_string(d, "Alarm/warning flags implemented",
+	sff_output_field(d, "Alarm/warning flags implemented",
 			(sd.supports_alarms ? "Yes" : "No"));
 
 	if (sd.supports_alarms) {
 		for (i = 0; sff_8472_aw_flags[i].str; ++i) {
-			ssf_add_dict_string(d, sff_8472_aw_flags[i].str,
+			sff_output_field(d, sff_8472_aw_flags[i].str,
 					data[SFF_A2_BASE + sff_8472_aw_flags[i].offset]
 					& sff_8472_aw_flags[i].value ? "On" : "Off");
 		}
diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index 9dfff41a3b..bbd00cc0ca 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -164,42 +164,42 @@ static struct sff_8636_aw_flags {
 	{ NULL, 0, 0 },
 };
 
-static void sff_8636_show_identifier(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_identifier(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_identifier(data, SFF_8636_ID_OFFSET, d);
 }
 
-static void sff_8636_show_ext_identifier(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_ext_identifier(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Extended identifier description";
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 	snprintf(val_string, sizeof(val_string), "0x%02x", data[SFF_8636_EXT_ID_OFFSET]);
-	ssf_add_dict_string(d, "Extended identifier", val_string);
+	sff_output_field(d, "Extended identifier", val_string);
 
 	switch (data[SFF_8636_EXT_ID_OFFSET] & SFF_8636_EXT_ID_PWR_CLASS_MASK) {
 	case SFF_8636_EXT_ID_PWR_CLASS_1:
-		ssf_add_dict_string(d, name, "1.5W max. Power consumption");
+		sff_output_field(d, name, "1.5W max. Power consumption");
 		break;
 	case SFF_8636_EXT_ID_PWR_CLASS_2:
-		ssf_add_dict_string(d, name, "2.0W max. Power consumption");
+		sff_output_field(d, name, "2.0W max. Power consumption");
 		break;
 	case SFF_8636_EXT_ID_PWR_CLASS_3:
-		ssf_add_dict_string(d, name, "2.5W max. Power consumption");
+		sff_output_field(d, name, "2.5W max. Power consumption");
 		break;
 	case SFF_8636_EXT_ID_PWR_CLASS_4:
-		ssf_add_dict_string(d, name, "3.5W max. Power consumption");
+		sff_output_field(d, name, "3.5W max. Power consumption");
 		break;
 	}
 
 	if (data[SFF_8636_EXT_ID_OFFSET] & SFF_8636_EXT_ID_CDR_TX_MASK)
-		ssf_add_dict_string(d, name, "CDR present in TX");
+		sff_output_field(d, name, "CDR present in TX");
 	else
-		ssf_add_dict_string(d, name, "No CDR in TX");
+		sff_output_field(d, name, "No CDR in TX");
 
 	if (data[SFF_8636_EXT_ID_OFFSET] & SFF_8636_EXT_ID_CDR_RX_MASK)
-		ssf_add_dict_string(d, name, "CDR present in RX");
+		sff_output_field(d, name, "CDR present in RX");
 	else
-		ssf_add_dict_string(d, name, "No CDR in RX");
+		sff_output_field(d, name, "No CDR in RX");
 
 	switch (data[SFF_8636_EXT_ID_OFFSET] & SFF_8636_EXT_ID_EPWR_CLASS_MASK) {
 	case SFF_8636_EXT_ID_PWR_CLASS_LEGACY:
@@ -221,15 +221,15 @@ static void sff_8636_show_ext_identifier(const uint8_t *data, struct rte_tel_dat
 	else
 		strlcat(val_string, "High Power Class (> 3.5 W) not enabled", sizeof(val_string));
 
-	ssf_add_dict_string(d, name, val_string);
+	sff_output_field(d, name, val_string);
 }
 
-static void sff_8636_show_connector(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_connector(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_connector(data, SFF_8636_CTOR_OFFSET, d);
 }
 
-static void sff_8636_show_transceiver(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_transceiver(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Transceiver type";
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
@@ -243,222 +243,222 @@ static void sff_8636_show_transceiver(const uint8_t *data, struct rte_tel_data *
 		data[SFF_8636_FC_TECH_OFFSET],
 		data[SFF_8636_FC_TRANS_MEDIA_OFFSET],
 		data[SFF_8636_FC_SPEED_OFFSET]);
-	ssf_add_dict_string(d, "Transceiver codes", val_string);
+	sff_output_field(d, "Transceiver codes", val_string);
 
 	/* 10G/40G Ethernet Compliance Codes */
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_10G_LRM)
-		ssf_add_dict_string(d, name, "10G Ethernet: 10G Base-LRM");
+		sff_output_field(d, name, "10G Ethernet: 10G Base-LRM");
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_10G_LR)
-		ssf_add_dict_string(d, name, "10G Ethernet: 10G Base-LR");
+		sff_output_field(d, name, "10G Ethernet: 10G Base-LR");
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_10G_SR)
-		ssf_add_dict_string(d, name, "10G Ethernet: 10G Base-SR");
+		sff_output_field(d, name, "10G Ethernet: 10G Base-SR");
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_40G_CR4)
-		ssf_add_dict_string(d, name, "40G Ethernet: 40G Base-CR4");
+		sff_output_field(d, name, "40G Ethernet: 40G Base-CR4");
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_40G_SR4)
-		ssf_add_dict_string(d, name, "40G Ethernet: 40G Base-SR4");
+		sff_output_field(d, name, "40G Ethernet: 40G Base-SR4");
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_40G_LR4)
-		ssf_add_dict_string(d, name, "40G Ethernet: 40G Base-LR4");
+		sff_output_field(d, name, "40G Ethernet: 40G Base-LR4");
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_40G_ACTIVE)
-		ssf_add_dict_string(d, name, "40G Ethernet: 40G Active Cable (XLPPI)");
+		sff_output_field(d, name, "40G Ethernet: 40G Active Cable (XLPPI)");
 
 	/* Extended Specification Compliance Codes from SFF-8024 */
 	if (data[SFF_8636_ETHERNET_COMP_OFFSET] & SFF_8636_ETHERNET_RSRVD) {
 		switch (data[SFF_8636_OPTION_1_OFFSET]) {
 		case SFF_8636_ETHERNET_UNSPECIFIED:
-			ssf_add_dict_string(d, name, "(reserved or unknown)");
+			sff_output_field(d, name, "(reserved or unknown)");
 			break;
 		case SFF_8636_ETHERNET_100G_AOC:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 			"100G Ethernet: 100G AOC or 25GAUI C2M AOC with worst BER of 5x10^(-5)");
 			break;
 		case SFF_8636_ETHERNET_100G_SR4:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 					"100G Ethernet: 100G Base-SR4 or 25GBase-SR");
 			break;
 		case SFF_8636_ETHERNET_100G_LR4:
-			ssf_add_dict_string(d, name, "100G Ethernet: 100G Base-LR4");
+			sff_output_field(d, name, "100G Ethernet: 100G Base-LR4");
 			break;
 		case SFF_8636_ETHERNET_100G_ER4:
-			ssf_add_dict_string(d, name, "100G Ethernet: 100G Base-ER4");
+			sff_output_field(d, name, "100G Ethernet: 100G Base-ER4");
 			break;
 		case SFF_8636_ETHERNET_100G_SR10:
-			ssf_add_dict_string(d, name, "100G Ethernet: 100G Base-SR10");
+			sff_output_field(d, name, "100G Ethernet: 100G Base-SR10");
 			break;
 		case SFF_8636_ETHERNET_100G_CWDM4_FEC:
-			ssf_add_dict_string(d, name, "100G Ethernet: 100G CWDM4 MSA with FEC");
+			sff_output_field(d, name, "100G Ethernet: 100G CWDM4 MSA with FEC");
 			break;
 		case SFF_8636_ETHERNET_100G_PSM4:
-			ssf_add_dict_string(d, name, "100G Ethernet: 100G PSM4 Parallel SMF");
+			sff_output_field(d, name, "100G Ethernet: 100G PSM4 Parallel SMF");
 			break;
 		case SFF_8636_ETHERNET_100G_ACC:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 			"100G Ethernet: 100G ACC or 25GAUI C2M ACC with worst BER of 5x10^(-5)");
 			break;
 		case SFF_8636_ETHERNET_100G_CWDM4_NO_FEC:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 					"100G Ethernet: 100G CWDM4 MSA without FEC");
 			break;
 		case SFF_8636_ETHERNET_100G_RSVD1:
-			ssf_add_dict_string(d, name, "(reserved or unknown)");
+			sff_output_field(d, name, "(reserved or unknown)");
 			break;
 		case SFF_8636_ETHERNET_100G_CR4:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 					"100G Ethernet: 100G Base-CR4 or 25G Base-CR CA-L");
 			break;
 		case SFF_8636_ETHERNET_25G_CR_CA_S:
-			ssf_add_dict_string(d, name, "25G Ethernet: 25G Base-CR CA-S");
+			sff_output_field(d, name, "25G Ethernet: 25G Base-CR CA-S");
 			break;
 		case SFF_8636_ETHERNET_25G_CR_CA_N:
-			ssf_add_dict_string(d, name, "25G Ethernet: 25G Base-CR CA-N");
+			sff_output_field(d, name, "25G Ethernet: 25G Base-CR CA-N");
 			break;
 		case SFF_8636_ETHERNET_40G_ER4:
-			ssf_add_dict_string(d, name, "40G Ethernet: 40G Base-ER4");
+			sff_output_field(d, name, "40G Ethernet: 40G Base-ER4");
 			break;
 		case SFF_8636_ETHERNET_4X10_SR:
-			ssf_add_dict_string(d, name, "4x10G Ethernet: 10G Base-SR");
+			sff_output_field(d, name, "4x10G Ethernet: 10G Base-SR");
 			break;
 		case SFF_8636_ETHERNET_40G_PSM4:
-			ssf_add_dict_string(d, name, "40G Ethernet: 40G PSM4 Parallel SMF");
+			sff_output_field(d, name, "40G Ethernet: 40G PSM4 Parallel SMF");
 			break;
 		case SFF_8636_ETHERNET_G959_P1I1_2D1:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 				"Ethernet: G959.1 profile P1I1-2D1 (10709 MBd, 2km, 1310nm SM)");
 			break;
 		case SFF_8636_ETHERNET_G959_P1S1_2D2:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 				"Ethernet: G959.1 profile P1S1-2D2 (10709 MBd, 40km, 1550nm SM)");
 			break;
 		case SFF_8636_ETHERNET_G959_P1L1_2D2:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 				"Ethernet: G959.1 profile P1L1-2D2 (10709 MBd, 80km, 1550nm SM)");
 			break;
 		case SFF_8636_ETHERNET_10GT_SFI:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 				"10G Ethernet: 10G Base-T with SFI electrical interface");
 			break;
 		case SFF_8636_ETHERNET_100G_CLR4:
-			ssf_add_dict_string(d, name, "100G Ethernet: 100G CLR4");
+			sff_output_field(d, name, "100G Ethernet: 100G CLR4");
 			break;
 		case SFF_8636_ETHERNET_100G_AOC2:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 			"100G Ethernet: 100G AOC or 25GAUI C2M AOC with worst BER of 10^(-12)");
 			break;
 		case SFF_8636_ETHERNET_100G_ACC2:
-			ssf_add_dict_string(d, name,
+			sff_output_field(d, name,
 			"100G Ethernet: 100G ACC or 25GAUI C2M ACC with worst BER of 10^(-12)");
 			break;
 		default:
-			ssf_add_dict_string(d, name, "(reserved or unknown)");
+			sff_output_field(d, name, "(reserved or unknown)");
 			break;
 		}
 	}
 
 	/* SONET Compliance Codes */
 	if (data[SFF_8636_SONET_COMP_OFFSET] & SFF_8636_SONET_40G_OTN)
-		ssf_add_dict_string(d, name, "40G OTN (OTU3B/OTU3C)");
+		sff_output_field(d, name, "40G OTN (OTU3B/OTU3C)");
 	if (data[SFF_8636_SONET_COMP_OFFSET] & SFF_8636_SONET_OC48_LR)
-		ssf_add_dict_string(d, name, "SONET: OC-48, long reach");
+		sff_output_field(d, name, "SONET: OC-48, long reach");
 	if (data[SFF_8636_SONET_COMP_OFFSET] & SFF_8636_SONET_OC48_IR)
-		ssf_add_dict_string(d, name, "SONET: OC-48, intermediate reach");
+		sff_output_field(d, name, "SONET: OC-48, intermediate reach");
 	if (data[SFF_8636_SONET_COMP_OFFSET] & SFF_8636_SONET_OC48_SR)
-		ssf_add_dict_string(d, name, "SONET: OC-48, short reach");
+		sff_output_field(d, name, "SONET: OC-48, short reach");
 
 	/* SAS/SATA Compliance Codes */
 	if (data[SFF_8636_SAS_COMP_OFFSET] & SFF_8636_SAS_6G)
-		ssf_add_dict_string(d, name, "SAS 6.0G");
+		sff_output_field(d, name, "SAS 6.0G");
 	if (data[SFF_8636_SAS_COMP_OFFSET] & SFF_8636_SAS_3G)
-		ssf_add_dict_string(d, name, "SAS 3.0G");
+		sff_output_field(d, name, "SAS 3.0G");
 
 	/* Ethernet Compliance Codes */
 	if (data[SFF_8636_GIGE_COMP_OFFSET] & SFF_8636_GIGE_1000_BASE_T)
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-T");
+		sff_output_field(d, name, "Ethernet: 1000BASE-T");
 	if (data[SFF_8636_GIGE_COMP_OFFSET] & SFF_8636_GIGE_1000_BASE_CX)
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-CX");
+		sff_output_field(d, name, "Ethernet: 1000BASE-CX");
 	if (data[SFF_8636_GIGE_COMP_OFFSET] & SFF_8636_GIGE_1000_BASE_LX)
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-LX");
+		sff_output_field(d, name, "Ethernet: 1000BASE-LX");
 	if (data[SFF_8636_GIGE_COMP_OFFSET] & SFF_8636_GIGE_1000_BASE_SX)
-		ssf_add_dict_string(d, name, "Ethernet: 1000BASE-SX");
+		sff_output_field(d, name, "Ethernet: 1000BASE-SX");
 
 	/* Fibre Channel link length */
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_LEN_VERY_LONG)
-		ssf_add_dict_string(d, name, "FC: very long distance (V)");
+		sff_output_field(d, name, "FC: very long distance (V)");
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_LEN_SHORT)
-		ssf_add_dict_string(d, name, "FC: short distance (S)");
+		sff_output_field(d, name, "FC: short distance (S)");
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_LEN_INT)
-		ssf_add_dict_string(d, name, "FC: intermediate distance (I)");
+		sff_output_field(d, name, "FC: intermediate distance (I)");
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_LEN_LONG)
-		ssf_add_dict_string(d, name, "FC: long distance (L)");
+		sff_output_field(d, name, "FC: long distance (L)");
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_LEN_MED)
-		ssf_add_dict_string(d, name, "FC: medium distance (M)");
+		sff_output_field(d, name, "FC: medium distance (M)");
 
 	/* Fibre Channel transmitter technology */
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_TECH_LONG_LC)
-		ssf_add_dict_string(d, name, "FC: Longwave laser (LC)");
+		sff_output_field(d, name, "FC: Longwave laser (LC)");
 	if (data[SFF_8636_FC_LEN_OFFSET] & SFF_8636_FC_TECH_ELEC_INTER)
-		ssf_add_dict_string(d, name, "FC: Electrical inter-enclosure (EL)");
+		sff_output_field(d, name, "FC: Electrical inter-enclosure (EL)");
 	if (data[SFF_8636_FC_TECH_OFFSET] & SFF_8636_FC_TECH_ELEC_INTRA)
-		ssf_add_dict_string(d, name, "FC: Electrical intra-enclosure (EL)");
+		sff_output_field(d, name, "FC: Electrical intra-enclosure (EL)");
 	if (data[SFF_8636_FC_TECH_OFFSET] & SFF_8636_FC_TECH_SHORT_WO_OFC)
-		ssf_add_dict_string(d, name, "FC: Shortwave laser w/o OFC (SN)");
+		sff_output_field(d, name, "FC: Shortwave laser w/o OFC (SN)");
 	if (data[SFF_8636_FC_TECH_OFFSET] & SFF_8636_FC_TECH_SHORT_W_OFC)
-		ssf_add_dict_string(d, name, "FC: Shortwave laser with OFC (SL)");
+		sff_output_field(d, name, "FC: Shortwave laser with OFC (SL)");
 	if (data[SFF_8636_FC_TECH_OFFSET] & SFF_8636_FC_TECH_LONG_LL)
-		ssf_add_dict_string(d, name, "FC: Longwave laser (LL)");
+		sff_output_field(d, name, "FC: Longwave laser (LL)");
 
 	/* Fibre Channel transmission media */
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_TW)
-		ssf_add_dict_string(d, name, "FC: Twin Axial Pair (TW)");
+		sff_output_field(d, name, "FC: Twin Axial Pair (TW)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_TP)
-		ssf_add_dict_string(d, name, "FC: Twisted Pair (TP)");
+		sff_output_field(d, name, "FC: Twisted Pair (TP)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_MI)
-		ssf_add_dict_string(d, name, "FC: Miniature Coax (MI)");
+		sff_output_field(d, name, "FC: Miniature Coax (MI)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_TV)
-		ssf_add_dict_string(d, name, "FC: Video Coax (TV)");
+		sff_output_field(d, name, "FC: Video Coax (TV)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_M6)
-		ssf_add_dict_string(d, name, "FC: Multimode, 62.5m (M6)");
+		sff_output_field(d, name, "FC: Multimode, 62.5m (M6)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_M5)
-		ssf_add_dict_string(d, name, "FC: Multimode, 50m (M5)");
+		sff_output_field(d, name, "FC: Multimode, 50m (M5)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_OM3)
-		ssf_add_dict_string(d, name, "FC: Multimode, 50um (OM3)");
+		sff_output_field(d, name, "FC: Multimode, 50um (OM3)");
 	if (data[SFF_8636_FC_TRANS_MEDIA_OFFSET] & SFF_8636_FC_TRANS_MEDIA_SM)
-		ssf_add_dict_string(d, name, "FC: Single Mode (SM)");
+		sff_output_field(d, name, "FC: Single Mode (SM)");
 
 	/* Fibre Channel speed */
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_1200_MBPS)
-		ssf_add_dict_string(d, name, "FC: 1200 MBytes/sec");
+		sff_output_field(d, name, "FC: 1200 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_800_MBPS)
-		ssf_add_dict_string(d, name, "FC: 800 MBytes/sec");
+		sff_output_field(d, name, "FC: 800 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_1600_MBPS)
-		ssf_add_dict_string(d, name, "FC: 1600 MBytes/sec");
+		sff_output_field(d, name, "FC: 1600 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_400_MBPS)
-		ssf_add_dict_string(d, name, "FC: 400 MBytes/sec");
+		sff_output_field(d, name, "FC: 400 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_200_MBPS)
-		ssf_add_dict_string(d, name, "FC: 200 MBytes/sec");
+		sff_output_field(d, name, "FC: 200 MBytes/sec");
 	if (data[SFF_8636_FC_SPEED_OFFSET] & SFF_8636_FC_SPEED_100_MBPS)
-		ssf_add_dict_string(d, name, "FC: 100 MBytes/sec");
+		sff_output_field(d, name, "FC: 100 MBytes/sec");
 }
 
-static void sff_8636_show_encoding(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_encoding(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_encoding(data, SFF_8636_ENCODING_OFFSET,
 			       RTE_ETH_MODULE_SFF_8636, d);
 }
 
-static void sff_8636_show_rate_identifier(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_rate_identifier(const uint8_t *data, struct sff_output *d)
 {
 	char val_string[20];
 
 	snprintf(val_string, sizeof(val_string), "0x%02x", data[SFF_8636_EXT_RS_OFFSET]);
-	ssf_add_dict_string(d, "Rate identifier", val_string);
+	sff_output_field(d, "Rate identifier", val_string);
 }
 
-static void sff_8636_show_oui(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_oui(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_oui(data, SFF_8636_VENDOR_OUI_OFFSET, d);
 }
 
 static void sff_8636_show_wavelength_or_copper_compliance(const uint8_t *data,
-							  struct rte_tel_data *d)
+							  struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 	snprintf(val_string, sizeof(val_string), "0x%02x",
@@ -522,69 +522,69 @@ static void sff_8636_show_wavelength_or_copper_compliance(const uint8_t *data,
 			sizeof(val_string));
 		break;
 	}
-	ssf_add_dict_string(d, "Transmitter technology", val_string);
+	sff_output_field(d, "Transmitter technology", val_string);
 
 	if ((data[SFF_8636_DEVICE_TECH_OFFSET] & SFF_8636_TRANS_TECH_MASK)
 			>= SFF_8636_TRANS_COPPER_PAS_UNEQUAL) {
 		snprintf(val_string, sizeof(val_string), "%udb",
 			 data[SFF_8636_WAVELEN_HIGH_BYTE_OFFSET]);
-		ssf_add_dict_string(d, "Attenuation at 2.5GHz", val_string);
+		sff_output_field(d, "Attenuation at 2.5GHz", val_string);
 
 		snprintf(val_string, sizeof(val_string), "%udb",
 			 data[SFF_8636_WAVELEN_HIGH_BYTE_OFFSET]);
-		ssf_add_dict_string(d, "Attenuation at 5.0GHz", val_string);
+		sff_output_field(d, "Attenuation at 5.0GHz", val_string);
 
 		snprintf(val_string, sizeof(val_string), "%udb",
 			 data[SFF_8636_WAVELEN_HIGH_BYTE_OFFSET]);
-		ssf_add_dict_string(d, "Attenuation at 7.0GHz", val_string);
+		sff_output_field(d, "Attenuation at 7.0GHz", val_string);
 
 		snprintf(val_string, sizeof(val_string), "%udb",
 			 data[SFF_8636_WAVELEN_HIGH_BYTE_OFFSET]);
-		ssf_add_dict_string(d, "Attenuation at 12.9GHz", val_string);
+		sff_output_field(d, "Attenuation at 12.9GHz", val_string);
 	} else {
 		snprintf(val_string, sizeof(val_string), "%.3lfnm",
 			(((data[SFF_8636_WAVELEN_HIGH_BYTE_OFFSET] << 8) |
 			data[SFF_8636_WAVELEN_LOW_BYTE_OFFSET])*0.05));
-		ssf_add_dict_string(d, "Laser wavelength", val_string);
+		sff_output_field(d, "Laser wavelength", val_string);
 
 		snprintf(val_string, sizeof(val_string), "%.3lfnm",
 			(((data[SFF_8636_WAVE_TOL_HIGH_BYTE_OFFSET] << 8) |
 			data[SFF_8636_WAVE_TOL_LOW_BYTE_OFFSET])*0.005));
-		ssf_add_dict_string(d, "Laser wavelength tolerance", val_string);
+		sff_output_field(d, "Laser wavelength tolerance", val_string);
 	}
 }
 
-static void sff_8636_show_revision_compliance(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_revision_compliance(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Revision Compliance";
 
 	switch (data[SFF_8636_REV_COMPLIANCE_OFFSET]) {
 	case SFF_8636_REV_UNSPECIFIED:
-		ssf_add_dict_string(d, name, "Revision not specified");
+		sff_output_field(d, name, "Revision not specified");
 		break;
 	case SFF_8636_REV_8436_48:
-		ssf_add_dict_string(d, name, "SFF-8436 Rev 4.8 or earlier");
+		sff_output_field(d, name, "SFF-8436 Rev 4.8 or earlier");
 		break;
 	case SFF_8636_REV_8436_8636:
-		ssf_add_dict_string(d, name, "SFF-8436 Rev 4.8 or earlier");
+		sff_output_field(d, name, "SFF-8436 Rev 4.8 or earlier");
 		break;
 	case SFF_8636_REV_8636_13:
-		ssf_add_dict_string(d, name, "SFF-8636 Rev 1.3 or earlier");
+		sff_output_field(d, name, "SFF-8636 Rev 1.3 or earlier");
 		break;
 	case SFF_8636_REV_8636_14:
-		ssf_add_dict_string(d, name, "SFF-8636 Rev 1.4");
+		sff_output_field(d, name, "SFF-8636 Rev 1.4");
 		break;
 	case SFF_8636_REV_8636_15:
-		ssf_add_dict_string(d, name, "SFF-8636 Rev 1.5");
+		sff_output_field(d, name, "SFF-8636 Rev 1.5");
 		break;
 	case SFF_8636_REV_8636_20:
-		ssf_add_dict_string(d, name, "SFF-8636 Rev 2.0");
+		sff_output_field(d, name, "SFF-8636 Rev 2.0");
 		break;
 	case SFF_8636_REV_8636_27:
-		ssf_add_dict_string(d, name, "SFF-8636 Rev 2.5/2.6/2.7");
+		sff_output_field(d, name, "SFF-8636 Rev 2.5/2.6/2.7");
 		break;
 	default:
-		ssf_add_dict_string(d, name, "Unallocated");
+		sff_output_field(d, name, "Unallocated");
 		break;
 	}
 }
@@ -640,7 +640,7 @@ static void sff_8636_dom_parse(const uint8_t *data, struct sff_diags *sd)
 
 }
 
-static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct rte_tel_data *d)
+static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d)
 {
 	struct sff_diags sd = {0};
 	const char *rx_power_string = NULL;
@@ -671,10 +671,10 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct r
 	sff_8636_dom_parse(data, &sd);
 
 	SFF_SPRINT_TEMP(val_string, sd.sfp_temp[SFF_MCURR]);
-	ssf_add_dict_string(d, "Module temperature", val_string);
+	sff_output_field(d, "Module temperature", val_string);
 
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_MCURR]);
-	ssf_add_dict_string(d, "Module voltage", val_string);
+	sff_output_field(d, "Module voltage", val_string);
 
 	/*
 	 * SFF-8636/8436 spec is not clear whether RX power/ TX bias
@@ -685,21 +685,21 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct r
 	    (sd.sfp_temp[SFF_MCURR] == (int16_t)0xFFFF))
 		return;
 
-	ssf_add_dict_string(d, "Alarm/warning flags implemented",
+	sff_output_field(d, "Alarm/warning flags implemented",
 			(sd.supports_alarms ? "Yes" : "No"));
 
 	for (i = 0; i < SFF_MAX_CHANNEL_NUM; i++) {
 		snprintf(power_string, SFF_MAX_DESC_SIZE, "%s (Channel %d)",
 					"Laser tx bias current", i+1);
 		SFF_SPRINT_BIAS(val_string, sd.scd[i].bias_cur);
-		ssf_add_dict_string(d, power_string, val_string);
+		sff_output_field(d, power_string, val_string);
 	}
 
 	for (i = 0; i < SFF_MAX_CHANNEL_NUM; i++) {
 		snprintf(power_string, SFF_MAX_DESC_SIZE, "%s (Channel %d)",
 					"Transmit avg optical power", i+1);
 		SFF_SPRINT_xX_PWR(val_string, sd.scd[i].tx_power);
-		ssf_add_dict_string(d, power_string, val_string);
+		sff_output_field(d, power_string, val_string);
 	}
 
 	if (!sd.rx_power_type)
@@ -711,12 +711,12 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct r
 		snprintf(power_string, SFF_MAX_DESC_SIZE, "%s(Channel %d)",
 					rx_power_string, i+1);
 		SFF_SPRINT_xX_PWR(val_string, sd.scd[i].rx_power);
-		ssf_add_dict_string(d, power_string, val_string);
+		sff_output_field(d, power_string, val_string);
 	}
 
 	if (sd.supports_alarms) {
 		for (i = 0; sff_8636_aw_flags[i].str; ++i) {
-			ssf_add_dict_string(d, sff_8636_aw_flags[i].str,
+			sff_output_field(d, sff_8636_aw_flags[i].str,
 					data[sff_8636_aw_flags[i].offset]
 					& sff_8636_aw_flags[i].value ? "On" : "Off");
 		}
@@ -725,7 +725,7 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct r
 	}
 
 }
-void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct rte_tel_data *d)
+void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d)
 {
 	sff_8636_show_identifier(data, d);
 	if ((data[SFF_8636_ID_OFFSET] == SFF_8024_ID_QSFP) ||
diff --git a/lib/ethdev/sff_common.c b/lib/ethdev/sff_common.c
index bd425274e3..1b48c0f6ea 100644
--- a/lib/ethdev/sff_common.c
+++ b/lib/ethdev/sff_common.c
@@ -8,6 +8,12 @@
 
 #include "sff_common.h"
 
+void sff_output_field(struct sff_output *d, const char *name_str,
+		      const char *value_str)
+{
+	d->field_cb(name_str, value_str, d->arg);
+}
+
 double sff_convert_mw_to_dbm(double mw)
 {
 	return (10. * log10(mw / 1000.)) + 30.;
@@ -15,17 +21,17 @@ double sff_convert_mw_to_dbm(double mw)
 
 void sff_show_value_with_unit(const uint8_t *data, unsigned int reg,
 			      const char *name, unsigned int mult,
-			      const char *unit, struct rte_tel_data *d)
+			      const char *unit, struct sff_output *d)
 {
 	unsigned int val = data[reg];
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
 	snprintf(val_string, sizeof(val_string), "%u%s", val * mult, unit);
-	ssf_add_dict_string(d, name, val_string);
+	sff_output_field(d, name, val_string);
 }
 
 void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
-		    unsigned int last_reg, const char *name, struct rte_tel_data *d)
+		    unsigned int last_reg, const char *name, struct sff_output *d)
 {
 	unsigned int reg, val;
 	char tmp[3];
@@ -44,19 +50,19 @@ void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
 			strlcat(val_string, "_", sizeof(val_string));
 		}
 	}
-	ssf_add_dict_string(d, name, val_string);
+	sff_output_field(d, name, val_string);
 }
 
-void sff_8024_show_oui(const uint8_t *data, int id_offset, struct rte_tel_data *d)
+void sff_8024_show_oui(const uint8_t *data, int id_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
 	snprintf(val_string, sizeof(val_string), "%02x:%02x:%02x",
 		data[id_offset], data[(id_offset) + 1], data[(id_offset) + 2]);
-	ssf_add_dict_string(d, "Vendor OUI", val_string);
+	sff_output_field(d, "Vendor OUI", val_string);
 }
 
-void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct rte_tel_data *d)
+void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -142,10 +148,10 @@ void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct rte_tel
 		strlcat(val_string, " (reserved or unknown)", sizeof(val_string));
 		break;
 	}
-	ssf_add_dict_string(d, "Identifier", val_string);
+	sff_output_field(d, "Identifier", val_string);
 }
 
-void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct rte_tel_data *d)
+void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -213,11 +219,11 @@ void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct rte_te
 		strlcat(val_string, " (reserved or unknown)", sizeof(val_string));
 		break;
 	}
-	ssf_add_dict_string(d, "Connector", val_string);
+	sff_output_field(d, "Connector", val_string);
 }
 
 void sff_8024_show_encoding(const uint8_t *data, int encoding_offset,
-			    int sff_type, struct rte_tel_data *d)
+			    int sff_type, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -265,55 +271,55 @@ void sff_8024_show_encoding(const uint8_t *data, int encoding_offset,
 		strlcat(val_string, " (reserved or unknown)", sizeof(val_string));
 		break;
 	}
-	ssf_add_dict_string(d, "Encoding", val_string);
+	sff_output_field(d, "Encoding", val_string);
 }
 
-void sff_show_thresholds(struct sff_diags sd, struct rte_tel_data *d)
+void sff_show_thresholds(struct sff_diags sd, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
 	SFF_SPRINT_BIAS(val_string, sd.bias_cur[SFF_HALRM]);
-	ssf_add_dict_string(d, "Laser bias current high alarm threshold", val_string);
+	sff_output_field(d, "Laser bias current high alarm threshold", val_string);
 	SFF_SPRINT_BIAS(val_string, sd.bias_cur[SFF_LALRM]);
-	ssf_add_dict_string(d, "Laser bias current low alarm threshold", val_string);
+	sff_output_field(d, "Laser bias current low alarm threshold", val_string);
 	SFF_SPRINT_BIAS(val_string, sd.bias_cur[SFF_HWARN]);
-	ssf_add_dict_string(d, "Laser bias current high warning threshold", val_string);
+	sff_output_field(d, "Laser bias current high warning threshold", val_string);
 	SFF_SPRINT_BIAS(val_string, sd.bias_cur[SFF_LWARN]);
-	ssf_add_dict_string(d, "Laser bias current low warning threshold", val_string);
+	sff_output_field(d, "Laser bias current low warning threshold", val_string);
 
 	SFF_SPRINT_xX_PWR(val_string, sd.tx_power[SFF_HALRM]);
-	ssf_add_dict_string(d, "Laser output power high alarm threshold", val_string);
+	sff_output_field(d, "Laser output power high alarm threshold", val_string);
 	SFF_SPRINT_xX_PWR(val_string, sd.tx_power[SFF_LALRM]);
-	ssf_add_dict_string(d, "Laser output power low alarm threshold", val_string);
+	sff_output_field(d, "Laser output power low alarm threshold", val_string);
 	SFF_SPRINT_xX_PWR(val_string, sd.tx_power[SFF_HWARN]);
-	ssf_add_dict_string(d, "Laser output power high warning threshold", val_string);
+	sff_output_field(d, "Laser output power high warning threshold", val_string);
 	SFF_SPRINT_xX_PWR(val_string, sd.tx_power[SFF_LWARN]);
-	ssf_add_dict_string(d, "Laser output power low warning threshold", val_string);
+	sff_output_field(d, "Laser output power low warning threshold", val_string);
 
 	SFF_SPRINT_TEMP(val_string, sd.sfp_temp[SFF_HALRM]);
-	ssf_add_dict_string(d, "Module temperature high alarm threshold", val_string);
+	sff_output_field(d, "Module temperature high alarm threshold", val_string);
 	SFF_SPRINT_TEMP(val_string, sd.sfp_temp[SFF_LALRM]);
-	ssf_add_dict_string(d, "Module temperature low alarm threshold", val_string);
+	sff_output_field(d, "Module temperature low alarm threshold", val_string);
 	SFF_SPRINT_TEMP(val_string, sd.sfp_temp[SFF_HWARN]);
-	ssf_add_dict_string(d, "Module temperature high warning threshold", val_string);
+	sff_output_field(d, "Module temperature high warning threshold", val_string);
 	SFF_SPRINT_TEMP(val_string, sd.sfp_temp[SFF_LWARN]);
-	ssf_add_dict_string(d, "Module temperature low warning threshold", val_string);
+	sff_output_field(d, "Module temperature low warning threshold", val_string);
 
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_HALRM]);
-	ssf_add_dict_string(d, "Module voltage high alarm threshold", val_string);
+	sff_output_field(d, "Module voltage high alarm threshold", val_string);
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_LALRM]);
-	ssf_add_dict_string(d, "Module voltage low alarm threshold", val_string);
+	sff_output_field(d, "Module voltage low alarm threshold", val_string);
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_HWARN]);
-	ssf_add_dict_string(d, "Module voltage high warning threshold", val_string);
+	sff_output_field(d, "Module voltage high warning threshold", val_string);
 	SFF_SPRINT_VCC(val_string, sd.sfp_voltage[SFF_LWARN]);
-	ssf_add_dict_string(d, "Module voltage low alarm threshold", val_string);
+	sff_output_field(d, "Module voltage low alarm threshold", val_string);
 
 	SFF_SPRINT_xX_PWR(val_string, sd.rx_power[SFF_HALRM]);
-	ssf_add_dict_string(d, "Laser rx power high alarm threshold", val_string);
+	sff_output_field(d, "Laser rx power high alarm threshold", val_string);
 	SFF_SPRINT_xX_PWR(val_string, sd.rx_power[SFF_LALRM]);
-	ssf_add_dict_string(d, "Laser rx power low alarm threshold", val_string);
+	sff_output_field(d, "Laser rx power low alarm threshold", val_string);
 	SFF_SPRINT_xX_PWR(val_string, sd.rx_power[SFF_HWARN]);
-	ssf_add_dict_string(d, "Laser rx power high warning threshold", val_string);
+	sff_output_field(d, "Laser rx power high warning threshold", val_string);
 	SFF_SPRINT_xX_PWR(val_string, sd.rx_power[SFF_LWARN]);
-	ssf_add_dict_string(d, "Laser rx power low warning threshold", val_string);
+	sff_output_field(d, "Laser rx power low warning threshold", val_string);
 }
diff --git a/lib/ethdev/sff_common.h b/lib/ethdev/sff_common.h
index 2e42cbe8be..06f5a35e8e 100644
--- a/lib/ethdev/sff_common.h
+++ b/lib/ethdev/sff_common.h
@@ -11,7 +11,28 @@
 #include <stdio.h>
 
 #include "rte_ethdev.h"
-#include "sff_telemetry.h"
+
+#define SFF_ITEM_VAL_COMPOSE_SIZE 64
+
+/* Consumer of decoded module EEPROM fields */
+struct sff_output {
+	/* Called once per decoded field, name may repeat */
+	void (*field_cb)(const char *name, const char *value, void *arg);
+	void *arg;
+};
+
+/* Report one decoded field */
+void sff_output_field(struct sff_output *d, const char *name_str,
+		      const char *value_str);
+
+/* SFF-8079 Optics diagnostics */
+void sff_8079_show_all(const uint8_t *data, struct sff_output *d);
+
+/* SFF-8472 Optics diagnostics */
+void sff_8472_show_all(const uint8_t *data, struct sff_output *d);
+
+/* SFF-8636 Optics diagnostics */
+void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d);
 
 #define SFF_8024_ID_OFFSET			0x00
 #define SFF_8024_ID_UNKNOWN			0x00
@@ -158,15 +179,15 @@ struct sff_diags {
 double sff_convert_mw_to_dbm(double mw);
 void sff_show_value_with_unit(const uint8_t *data, unsigned int reg,
 			      const char *name, unsigned int mult,
-			      const char *unit, struct rte_tel_data *d);
+			      const char *unit, struct sff_output *d);
 void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
-		    unsigned int last_reg, const char *name, struct rte_tel_data *d);
-void sff_show_thresholds(struct sff_diags sd, struct rte_tel_data *d);
+		    unsigned int last_reg, const char *name, struct sff_output *d);
+void sff_show_thresholds(struct sff_diags sd, struct sff_output *d);
 
-void sff_8024_show_oui(const uint8_t *data, int id_offset, struct rte_tel_data *d);
-void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct rte_tel_data *d);
-void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct rte_tel_data *d);
+void sff_8024_show_oui(const uint8_t *data, int id_offset, struct sff_output *d);
+void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct sff_output *d);
+void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct sff_output *d);
 void sff_8024_show_encoding(const uint8_t *data, int encoding_offset,
-			    int sff_type, struct rte_tel_data *d);
+			    int sff_type, struct sff_output *d);
 
 #endif /* _SFF_COMMON_H_ */
diff --git a/lib/ethdev/sff_telemetry.c b/lib/ethdev/sff_telemetry.c
index b3f239d967..06a8122367 100644
--- a/lib/ethdev/sff_telemetry.c
+++ b/lib/ethdev/sff_telemetry.c
@@ -8,12 +8,42 @@
 
 #include "rte_ethdev.h"
 #include <rte_common.h>
+#include "sff_common.h"
 #include "sff_telemetry.h"
 #include <telemetry_data.h>
 
+static void
+sff_tel_add_field(const char *name_str, const char *value_str, void *arg)
+{
+	struct rte_tel_data *d = arg;
+	struct tel_dict_entry *e = &d->data.dict[d->data_len];
+
+	if (d->type != TEL_DICT)
+		return;
+	if (d->data_len >= RTE_TEL_MAX_DICT_ENTRIES) {
+		RTE_ETHDEV_LOG_LINE(ERR, "data_len has exceeded the maximum number of inserts");
+		return;
+	}
+
+	e->type = RTE_TEL_STRING_VAL;
+	/* append different values for same keys */
+	if (d->data_len > 0) {
+		struct tel_dict_entry *previous = &d->data.dict[d->data_len - 1];
+		if (strcmp(previous->name, name_str) == 0) {
+			strlcat(previous->value.sval, "; ", RTE_TEL_MAX_STRING_LEN);
+			strlcat(previous->value.sval, value_str, RTE_TEL_MAX_STRING_LEN);
+			return;
+		}
+	}
+	strlcpy(e->value.sval, value_str, RTE_TEL_MAX_STRING_LEN);
+	strlcpy(e->name, name_str, RTE_TEL_MAX_STRING_LEN);
+	d->data_len++;
+}
+
 static void
 sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 {
+	struct sff_output out = { .field_cb = sff_tel_add_field, .arg = d };
 	struct rte_eth_dev_module_info minfo;
 	struct rte_dev_eeprom_info einfo;
 	int ret;
@@ -73,15 +103,15 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 	switch (minfo.type) {
 	/* parsing module EEPROM data base on different module type */
 	case RTE_ETH_MODULE_SFF_8079:
-		sff_8079_show_all(einfo.data, d);
+		sff_8079_show_all(einfo.data, &out);
 		break;
 	case RTE_ETH_MODULE_SFF_8472:
-		sff_8079_show_all(einfo.data, d);
-		sff_8472_show_all(einfo.data, d);
+		sff_8079_show_all(einfo.data, &out);
+		sff_8472_show_all(einfo.data, &out);
 		break;
 	case RTE_ETH_MODULE_SFF_8436:
 	case RTE_ETH_MODULE_SFF_8636:
-		sff_8636_show_all(einfo.data, einfo.length, d);
+		sff_8636_show_all(einfo.data, einfo.length, &out);
 		break;
 	default:
 		RTE_ETHDEV_LOG_LINE(NOTICE, "Unsupported module type: %u", minfo.type);
@@ -91,36 +121,6 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 	free(einfo.data);
 }
 
-void
-ssf_add_dict_string(struct rte_tel_data *d, const char *name_str, const char *value_str)
-{
-	struct tel_dict_entry *e = &d->data.dict[d->data_len];
-
-	if (d->type != TEL_DICT)
-		return;
-	if (d->data_len >= RTE_TEL_MAX_DICT_ENTRIES) {
-		RTE_ETHDEV_LOG_LINE(ERR, "data_len has exceeded the maximum number of inserts");
-		return;
-	}
-
-	e->type = RTE_TEL_STRING_VAL;
-	/* append different values for same keys */
-	if (d->data_len > 0) {
-		struct tel_dict_entry *previous = &d->data.dict[d->data_len - 1];
-		if (strcmp(previous->name, name_str) == 0) {
-			strlcat(previous->value.sval, "; ", RTE_TEL_MAX_STRING_LEN);
-			strlcat(previous->value.sval, value_str, RTE_TEL_MAX_STRING_LEN);
-			goto end;
-		}
-	}
-	strlcpy(e->value.sval, value_str, RTE_TEL_MAX_STRING_LEN);
-	strlcpy(e->name, name_str, RTE_TEL_MAX_STRING_LEN);
-	d->data_len++;
-
-end:
-	return;
-}
-
 int
 eth_dev_handle_port_module_eeprom(const char *cmd __rte_unused, const char *params,
 				  struct rte_tel_data *d)
diff --git a/lib/ethdev/sff_telemetry.h b/lib/ethdev/sff_telemetry.h
index 81c1fb0ffb..8c10a88cf6 100644
--- a/lib/ethdev/sff_telemetry.h
+++ b/lib/ethdev/sff_telemetry.h
@@ -7,22 +7,8 @@
 
 #include <rte_telemetry.h>
 
-#define SFF_ITEM_VAL_COMPOSE_SIZE 64
-
-/* SFF-8079 Optics diagnostics */
-void sff_8079_show_all(const uint8_t *data, struct rte_tel_data *d);
-
-/* SFF-8472 Optics diagnostics */
-void sff_8472_show_all(const uint8_t *data, struct rte_tel_data *d);
-
-/* SFF-8636 Optics diagnostics */
-void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct rte_tel_data *d);
-
 int eth_dev_handle_port_module_eeprom(const char *cmd __rte_unused,
 				      const char *params,
 				      struct rte_tel_data *d);
 
-void ssf_add_dict_string(struct rte_tel_data *d, const char *name_str,
-			 const char *value_str);
-
 #endif /* _ETHDEV_SFF_TELEMETRY_H_ */
-- 
2.47.3

