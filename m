Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D7C9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8554340A73;
	Mon, 28 Sep 2026 10:48:04 +0200 (CEST)
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net
 [178.154.239.146])
 by mails.dpdk.org (Postfix) with ESMTP id DBBF640A6E
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:48:03 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:1199:0:640:2d84:0])
 by forward502b.mail.yandex.net (postfix) with ESMTPS id 2416183667;
 Mon, 28 Sep 2026 11:48:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id klcb2Uifv8c0-JsIpQkCh; 
 Mon, 28 Sep 2026 11:48:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790585282; bh=A09PuKkv8sPtCkPaiwBRXzaFzLxq4EZKURFGqNdwYKw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Y5gGsBT/kt2Uba1xFa19uoSqqqPTPcD/guUg1H7+jfwif5zreah5+VYNwdwdaS7Cp
 LvhWdZhP3kGUDnaWO/5NqsiuhRd80QLMDlaH4Y36l84dY+Ceab0gYilnugdmKLbvuD
 Hm/gpLWaoaGDljTRuhd5MGppRTHOLnUl3kZwtsAc=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v2 1/4] ethdev: decouple SFF module EEPROM decoders from
 telemetry
Date: Mon, 28 Sep 2026 10:47:26 +0200
Message-ID: <20260928084729.973192-2-roma55592@yandex.ru>
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

The SFF-8079, SFF-8472 and SFF-8636 decoders write their results
directly into a telemetry dictionary, so the decoding logic cannot
be reused outside of the telemetry command.

Introduce an internal output descriptor with a per-field callback
and pass it to the decoders instead of the telemetry data.
The telemetry handler becomes one of the callback consumers,
its output is unchanged.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 .mailmap                   |  1 +
 lib/ethdev/sff_8079.c      | 20 ++++++------
 lib/ethdev/sff_8472.c      |  2 +-
 lib/ethdev/sff_8636.c      | 22 ++++++-------
 lib/ethdev/sff_common.c    | 14 ++++----
 lib/ethdev/sff_common.h    | 14 ++++----
 lib/ethdev/sff_telemetry.c | 65 ++++++++++++++++++++------------------
 lib/ethdev/sff_telemetry.h | 15 ++++++---
 8 files changed, 83 insertions(+), 70 deletions(-)

diff --git a/.mailmap b/.mailmap
index 57f7a9f87a..45d4e92fbd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1445,6 +1445,7 @@ Romain Delhomel <romain.delhomel@6wind.com>
 Roman Dementiev <roman.dementiev@intel.com>
 Roman Fridlyand <roman.fridlyand@intel.com>
 Roman Kapl <rka@sysgo.com>
+Roman Khromenok <roma55592@yandex.ru>
 Roman Korynkevych <romanx.korynkevych@intel.com>
 Roman Storozhenko <roman.storozhenko@intel.com>
 Roman Zhukov <roman.zhukov@arknetworks.am> <roman.zhukov@oktetlabs.ru>
diff --git a/lib/ethdev/sff_8079.c b/lib/ethdev/sff_8079.c
index 91ad25ffcd..a41a1d057d 100644
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
 
@@ -32,12 +32,12 @@ static void sff_8079_show_ext_identifier(const uint8_t *data, struct rte_tel_dat
 	ssf_add_dict_string(d, "Extended identifier", val_string);
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
@@ -227,12 +227,12 @@ static void sff_8079_show_transceiver(const uint8_t *data, struct rte_tel_data *
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
 
@@ -262,14 +262,14 @@ static void sff_8079_show_rate_identifier(const uint8_t *data, struct rte_tel_da
 	ssf_add_dict_string(d, "Rate identifier", val_string);
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
 
@@ -312,7 +312,7 @@ sff_8079_show_wavelength_or_copper_compliance(const uint8_t *data,
 	}
 }
 
-static void sff_8079_show_options(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8079_show_options(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Option";
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
@@ -348,7 +348,7 @@ static void sff_8079_show_options(const uint8_t *data, struct rte_tel_data *d)
 		ssf_add_dict_string(d, name, "Power level 3 requirement");
 }
 
-void sff_8079_show_all(const uint8_t *data, struct rte_tel_data *d)
+void sff_8079_show_all(const uint8_t *data, struct sff_output *d)
 {
 	sff_8079_show_identifier(data, d);
 	if (((data[0] == 0x02) || (data[0] == 0x03)) && (data[1] == 0x04)) {
diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 97f231854c..2d02e71fca 100644
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
diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index 6b65f47efe..17058d4bfd 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -164,12 +164,12 @@ static struct sff_8636_aw_flags {
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
@@ -224,12 +224,12 @@ static void sff_8636_show_ext_identifier(const uint8_t *data, struct rte_tel_dat
 	ssf_add_dict_string(d, name, val_string);
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
@@ -438,13 +438,13 @@ static void sff_8636_show_transceiver(const uint8_t *data, struct rte_tel_data *
 		ssf_add_dict_string(d, name, "FC: 100 MBytes/sec");
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
 
@@ -452,13 +452,13 @@ static void sff_8636_show_rate_identifier(const uint8_t *data, struct rte_tel_da
 	ssf_add_dict_string(d, "Rate identifier", val_string);
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
@@ -554,7 +554,7 @@ static void sff_8636_show_wavelength_or_copper_compliance(const uint8_t *data,
 	}
 }
 
-static void sff_8636_show_revision_compliance(const uint8_t *data, struct rte_tel_data *d)
+static void sff_8636_show_revision_compliance(const uint8_t *data, struct sff_output *d)
 {
 	static const char *name = "Revision Compliance";
 
@@ -638,7 +638,7 @@ static void sff_8636_dom_parse(const uint8_t *data, struct sff_diags *sd)
 
 }
 
-static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct rte_tel_data *d)
+static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d)
 {
 	struct sff_diags sd = {0};
 	const char *rx_power_string = NULL;
@@ -723,7 +723,7 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct r
 	}
 
 }
-void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct rte_tel_data *d)
+void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d)
 {
 	sff_8636_show_identifier(data, d);
 	if ((data[SFF_8636_ID_OFFSET] == SFF_8024_ID_QSFP) ||
diff --git a/lib/ethdev/sff_common.c b/lib/ethdev/sff_common.c
index bd425274e3..c80e841fd4 100644
--- a/lib/ethdev/sff_common.c
+++ b/lib/ethdev/sff_common.c
@@ -15,7 +15,7 @@ double sff_convert_mw_to_dbm(double mw)
 
 void sff_show_value_with_unit(const uint8_t *data, unsigned int reg,
 			      const char *name, unsigned int mult,
-			      const char *unit, struct rte_tel_data *d)
+			      const char *unit, struct sff_output *d)
 {
 	unsigned int val = data[reg];
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
@@ -25,7 +25,7 @@ void sff_show_value_with_unit(const uint8_t *data, unsigned int reg,
 }
 
 void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
-		    unsigned int last_reg, const char *name, struct rte_tel_data *d)
+		    unsigned int last_reg, const char *name, struct sff_output *d)
 {
 	unsigned int reg, val;
 	char tmp[3];
@@ -47,7 +47,7 @@ void sff_show_ascii(const uint8_t *data, unsigned int first_reg,
 	ssf_add_dict_string(d, name, val_string);
 }
 
-void sff_8024_show_oui(const uint8_t *data, int id_offset, struct rte_tel_data *d)
+void sff_8024_show_oui(const uint8_t *data, int id_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -56,7 +56,7 @@ void sff_8024_show_oui(const uint8_t *data, int id_offset, struct rte_tel_data *
 	ssf_add_dict_string(d, "Vendor OUI", val_string);
 }
 
-void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct rte_tel_data *d)
+void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -145,7 +145,7 @@ void sff_8024_show_identifier(const uint8_t *data, int id_offset, struct rte_tel
 	ssf_add_dict_string(d, "Identifier", val_string);
 }
 
-void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct rte_tel_data *d)
+void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -217,7 +217,7 @@ void sff_8024_show_connector(const uint8_t *data, int ctor_offset, struct rte_te
 }
 
 void sff_8024_show_encoding(const uint8_t *data, int encoding_offset,
-			    int sff_type, struct rte_tel_data *d)
+			    int sff_type, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
@@ -268,7 +268,7 @@ void sff_8024_show_encoding(const uint8_t *data, int encoding_offset,
 	ssf_add_dict_string(d, "Encoding", val_string);
 }
 
-void sff_show_thresholds(struct sff_diags sd, struct rte_tel_data *d)
+void sff_show_thresholds(struct sff_diags sd, struct sff_output *d)
 {
 	char val_string[SFF_ITEM_VAL_COMPOSE_SIZE];
 
diff --git a/lib/ethdev/sff_common.h b/lib/ethdev/sff_common.h
index 2e42cbe8be..6a742e9d7b 100644
--- a/lib/ethdev/sff_common.h
+++ b/lib/ethdev/sff_common.h
@@ -158,15 +158,15 @@ struct sff_diags {
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
index b3f239d967..8c8e95affe 100644
--- a/lib/ethdev/sff_telemetry.c
+++ b/lib/ethdev/sff_telemetry.c
@@ -11,9 +11,38 @@
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
@@ -73,15 +102,15 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
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
@@ -92,33 +121,9 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 }
 
 void
-ssf_add_dict_string(struct rte_tel_data *d, const char *name_str, const char *value_str)
+ssf_add_dict_string(struct sff_output *d, const char *name_str, const char *value_str)
 {
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
+	d->field_cb(name_str, value_str, d->arg);
 }
 
 int
diff --git a/lib/ethdev/sff_telemetry.h b/lib/ethdev/sff_telemetry.h
index 81c1fb0ffb..2a6d79a9c1 100644
--- a/lib/ethdev/sff_telemetry.h
+++ b/lib/ethdev/sff_telemetry.h
@@ -9,20 +9,27 @@
 
 #define SFF_ITEM_VAL_COMPOSE_SIZE 64
 
+/* Consumer of decoded module EEPROM fields */
+struct sff_output {
+	/* Called once per decoded field, name may repeat */
+	void (*field_cb)(const char *name, const char *value, void *arg);
+	void *arg;
+};
+
 /* SFF-8079 Optics diagnostics */
-void sff_8079_show_all(const uint8_t *data, struct rte_tel_data *d);
+void sff_8079_show_all(const uint8_t *data, struct sff_output *d);
 
 /* SFF-8472 Optics diagnostics */
-void sff_8472_show_all(const uint8_t *data, struct rte_tel_data *d);
+void sff_8472_show_all(const uint8_t *data, struct sff_output *d);
 
 /* SFF-8636 Optics diagnostics */
-void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct rte_tel_data *d);
+void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d);
 
 int eth_dev_handle_port_module_eeprom(const char *cmd __rte_unused,
 				      const char *params,
 				      struct rte_tel_data *d);
 
-void ssf_add_dict_string(struct rte_tel_data *d, const char *name_str,
+void ssf_add_dict_string(struct sff_output *d, const char *name_str,
 			 const char *value_str);
 
 #endif /* _ETHDEV_SFF_TELEMETRY_H_ */
-- 
2.47.3

