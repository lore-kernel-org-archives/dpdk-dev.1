Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AFDC9832F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 07:02:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB11740E4D;
	Mon, 28 Sep 2026 09:00:24 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [178.154.239.81])
 by mails.dpdk.org (Postfix) with ESMTP id 82AAA4026D
 for <dev@dpdk.org>; Sun, 27 Sep 2026 13:20:57 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:39a:0:640:15c4:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 377A881060;
 Sun, 27 Sep 2026 14:20:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id kKeTQKZfsSw0-mrRAzpeX; 
 Sun, 27 Sep 2026 14:20:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790508057; bh=6z8prndN2AWiIhnDx5G7j2H+vzXGvQHE3Xbqy7WKKuM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=QnTS7HjYEG7JyVRjMvH/MCOwroD9sr9EJk+exDOFam6+2lq8o+T2u3cXNQuvAqsT1
 asSGGHqT5WyfyL4UFSVT6aToeepX5Oh7yptQ/0H/Q+cIU231l1/9vE8X9HJgU4edEV
 jdzcGdw/4Nrk7lA5GYHncIf23+C/2Cg15VkR0mgg=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 4/4] test: add ethdev module EEPROM decoding tests
Date: Sun, 27 Sep 2026 13:20:41 +0200
Message-ID: <20260927112041.775972-5-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927112041.775972-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:59:13 +0200
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

Add unit tests for rte_eth_module_eeprom_parse().

The tests decode SFF-8079, SFF-8472 and SFF-8636 EEPROM images
built in the test, check the identification and diagnostic fields,
and check that the SFF-8472 diagnostics are skipped when page A2h
is not complete.
Invalid parameters, too short data and unknown module types
must be rejected without invoking the callback.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/meson.build                 |   1 +
 app/test/test_ethdev_module_eeprom.c | 285 +++++++++++++++++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 app/test/test_ethdev_module_eeprom.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 9dcdb069e8..c6a808d63d 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -74,6 +74,7 @@ source_file_deps = {
     'test_errno.c': [],
     'test_ethdev_api.c': ['ethdev'],
     'test_ethdev_link.c': ['ethdev'],
+    'test_ethdev_module_eeprom.c': ['ethdev'],
     'test_event_crypto_adapter.c': ['cryptodev', 'eventdev', 'bus_vdev'],
     'test_event_dma_adapter.c': ['dmadev', 'eventdev', 'bus_vdev'],
     'test_event_eth_rx_adapter.c': ['ethdev', 'eventdev', 'bus_vdev'],
diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_ethdev_module_eeprom.c
new file mode 100644
index 0000000000..8a09b870da
--- /dev/null
+++ b/app/test/test_ethdev_module_eeprom.c
@@ -0,0 +1,285 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Roman Khromenok
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_ethdev.h>
+#include <rte_string_fns.h>
+
+#include "test.h"
+
+#define MAX_FIELDS 128
+#define MAX_NAME_LEN 64
+#define MAX_VALUE_LEN 128
+
+struct decoded_fields {
+	unsigned int count;
+	struct {
+		char name[MAX_NAME_LEN];
+		char value[MAX_VALUE_LEN];
+	} field[MAX_FIELDS];
+};
+
+static struct decoded_fields fields;
+
+static void
+collect_field(const char *name, const char *value, void *arg)
+{
+	struct decoded_fields *f = arg;
+
+	if (f->count >= MAX_FIELDS)
+		return;
+	strlcpy(f->field[f->count].name, name, MAX_NAME_LEN);
+	strlcpy(f->field[f->count].value, value, MAX_VALUE_LEN);
+	f->count++;
+}
+
+static const char *
+find_field(const char *name)
+{
+	unsigned int i;
+
+	for (i = 0; i < fields.count; i++)
+		if (strcmp(fields.field[i].name, name) == 0)
+			return fields.field[i].value;
+	return NULL;
+}
+
+static int
+parse(uint32_t type, const uint8_t *data, uint32_t length)
+{
+	memset(&fields, 0, sizeof(fields));
+	return rte_eth_module_eeprom_parse(type, data, length, collect_field, &fields);
+}
+
+#define CHECK_FIELD(name, expected) do { \
+	const char *value = find_field(name); \
+	TEST_ASSERT_NOT_NULL(value, "Field \"%s\" not found", name); \
+	TEST_ASSERT(strcmp(value, expected) == 0, \
+		"Field \"%s\": expected \"%s\", got \"%s\"", name, expected, value); \
+} while (0)
+
+#define CHECK_NO_FIELD(name) \
+	TEST_ASSERT_NULL(find_field(name), "Unexpected field \"%s\"", name)
+
+static void
+put_u16(uint8_t *data, unsigned int offset, uint16_t value)
+{
+	data[offset] = value >> 8;
+	data[offset + 1] = value & 0xff;
+}
+
+/* SFP+ 10GBASE-LR module, SFF-8472 layout: page A0h then page A2h */
+static void
+fill_sfp(uint8_t *data)
+{
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	memset(data, 0, RTE_ETH_MODULE_SFF_8472_LEN);
+	data[0] = 0x03;		/* identifier: SFP */
+	data[1] = 0x04;		/* extended identifier */
+	data[2] = 0x07;		/* connector: LC */
+	data[3] = 0x20;		/* 10G Base-LR */
+	data[11] = 0x06;	/* encoding: 64B/66B */
+	data[12] = 103;		/* nominal bit rate, units of 100 MBd */
+	memcpy(&data[20], "STARRY          ", 16);
+	data[37] = 0x00;
+	data[38] = 0x1b;
+	data[39] = 0x21;
+	memcpy(&data[40], "SFP-10G-LR-20   ", 16);
+	memcpy(&data[56], "A   ", 4);
+	memcpy(&data[68], "2024082600001   ", 16);
+	memcpy(&data[84], "240902  ", 8);
+	/* diagnostics implemented, internally calibrated, average RX power */
+	data[92] = 0x68;
+
+	put_u16(a2, 96, 0x2940);	/* temperature: 41.25 C */
+	put_u16(a2, 98, 33205);		/* voltage: 3.3205 V */
+	put_u16(a2, 100, 19790);	/* TX bias: 39.580 mA */
+	put_u16(a2, 102, 7754);		/* TX power: 0.7754 mW */
+	put_u16(a2, 104, 6724);		/* RX power: 0.6724 mW */
+}
+
+/* QSFP28 module, SFF-8636 layout: lower page then upper page 00h */
+static void
+fill_qsfp(uint8_t *data)
+{
+	memset(data, 0, RTE_ETH_MODULE_SFF_8636_LEN);
+	data[0] = 0x11;		/* identifier: QSFP28 */
+	put_u16(data, 22, 0x3040);	/* temperature: 48.25 C */
+	put_u16(data, 26, 32638);	/* voltage: 3.2638 V */
+	put_u16(data, 34, 1);		/* channel 1 RX power: 0.0001 mW */
+	put_u16(data, 42, 21525);	/* channel 1 TX bias: 43.050 mA */
+	put_u16(data, 50, 12763);	/* channel 1 TX power: 1.2763 mW */
+
+	data[128] = 0x11;	/* identifier: QSFP28 */
+	data[130] = 0x07;	/* connector: LC */
+	memcpy(&data[148], "FINISAR CORP.   ", 16);
+	data[165] = 0x00;
+	data[166] = 0x90;
+	data[167] = 0x65;
+	memcpy(&data[168], "FTLC1157RGPL6-FB", 16);
+	memcpy(&data[184], "A0", 2);
+	memcpy(&data[196], "X24A15P         ", 16);
+	memcpy(&data[212], "190826  ", 8);
+	data[220] = 0x08;	/* average RX power */
+}
+
+static int
+check_sfp_identity(void)
+{
+	CHECK_FIELD("Identifier", "0x03 (SFP)");
+	CHECK_FIELD("Connector", "0x07 (LC)");
+	CHECK_FIELD("Vendor name", "STARRY");
+	CHECK_FIELD("Vendor OUI", "00:1b:21");
+	CHECK_FIELD("Vendor PN", "SFP-10G-LR-20");
+	CHECK_FIELD("Vendor rev", "A");
+	CHECK_FIELD("Vendor SN", "2024082600001");
+	CHECK_FIELD("Date code", "240902");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_sfp_8079(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+
+	fill_sfp(data);
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8079, data, RTE_ETH_MODULE_SFF_8079_LEN),
+		"Failed to parse SFF-8079 data");
+	TEST_ASSERT_SUCCESS(check_sfp_identity(), "Wrong SFF-8079 base information");
+	CHECK_NO_FIELD("Optical diagnostics support");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_sfp_8472(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+
+	fill_sfp(data);
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data");
+	TEST_ASSERT_SUCCESS(check_sfp_identity(), "Wrong SFF-8472 base information");
+	CHECK_FIELD("Optical diagnostics support", "Yes");
+	CHECK_FIELD("Laser bias current", "39.580 mA");
+	CHECK_FIELD("Laser output power", "0.7754 mW / -1.10 dBm");
+	CHECK_FIELD("Receiver signal average optical power", "0.6724 mW / -1.72 dBm");
+	CHECK_FIELD("Module temperature", "41.25 degrees C / 106.25 degrees F");
+	CHECK_FIELD("Module voltage", "3.3205 V");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_sfp_8472_short(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	const uint32_t lengths[] = {
+		RTE_ETH_MODULE_SFF_8079_LEN,
+		RTE_ETH_MODULE_SFF_8472_LEN - 1,
+	};
+	unsigned int i;
+
+	fill_sfp(data);
+	for (i = 0; i < RTE_DIM(lengths); i++) {
+		TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, lengths[i]),
+			"Failed to parse SFF-8472 data of %u bytes", lengths[i]);
+		TEST_ASSERT_SUCCESS(check_sfp_identity(),
+			"Wrong SFF-8472 base information from %u bytes", lengths[i]);
+		/* page A2h is not complete, diagnostics must be skipped */
+		CHECK_NO_FIELD("Optical diagnostics support");
+		CHECK_NO_FIELD("Laser bias current");
+	}
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_qsfp_8636(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+
+	fill_qsfp(data);
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+		"Failed to parse SFF-8636 data");
+	CHECK_FIELD("Identifier", "0x11 (QSFP28)");
+	CHECK_FIELD("Connector", "0x07 (LC)");
+	CHECK_FIELD("Vendor name", "FINISAR CORP.");
+	CHECK_FIELD("Vendor OUI", "00:90:65");
+	CHECK_FIELD("Vendor PN", "FTLC1157RGPL6-FB");
+	CHECK_FIELD("Vendor rev", "A0");
+	CHECK_FIELD("Vendor SN", "X24A15P");
+	CHECK_FIELD("Module temperature", "48.25 degrees C / 118.85 degrees F");
+	CHECK_FIELD("Module voltage", "3.2638 V");
+	/* page 03h is not provided */
+	CHECK_FIELD("Alarm/warning flags implemented", "No");
+	CHECK_FIELD("Laser tx bias current (Channel 1)", "43.050 mA");
+	CHECK_FIELD("Transmit avg optical power (Channel 1)", "1.2763 mW / 1.06 dBm");
+	CHECK_FIELD("Rcvr signal avg optical power(Channel 1)", "0.0001 mW / -40.00 dBm");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_invalid(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8636_MAX_LEN] = {0};
+	const uint32_t types[] = {
+		RTE_ETH_MODULE_SFF_8079,
+		RTE_ETH_MODULE_SFF_8472,
+		RTE_ETH_MODULE_SFF_8436,
+		RTE_ETH_MODULE_SFF_8636,
+	};
+	unsigned int i;
+	int ret;
+
+	/* all supported types require at least one full page */
+	for (i = 0; i < RTE_DIM(types); i++) {
+		ret = parse(types[i], data, 255);
+		TEST_ASSERT_EQUAL(ret, -EINVAL,
+			"Type %u with 255 bytes: expected %d, got %d", types[i], -EINVAL, ret);
+		TEST_ASSERT_EQUAL(fields.count, 0,
+			"Type %u with 255 bytes: callback called %u times",
+			types[i], fields.count);
+	}
+
+	ret = parse(0, data, sizeof(data));
+	TEST_ASSERT_EQUAL(ret, -ENOTSUP, "Type 0: expected %d, got %d", -ENOTSUP, ret);
+	ret = parse(RTE_ETH_MODULE_SFF_8436 + 1, data, sizeof(data));
+	TEST_ASSERT_EQUAL(ret, -ENOTSUP, "Unknown type: expected %d, got %d", -ENOTSUP, ret);
+	TEST_ASSERT_EQUAL(fields.count, 0, "Unknown type: callback called %u times",
+		fields.count);
+
+	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8079, NULL,
+		RTE_ETH_MODULE_SFF_8079_LEN, collect_field, &fields);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL data: expected %d, got %d", -EINVAL, ret);
+	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8079, data,
+		RTE_ETH_MODULE_SFF_8079_LEN, NULL, NULL);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL callback: expected %d, got %d", -EINVAL, ret);
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite module_eeprom_testsuite = {
+	.suite_name = "ethdev module EEPROM decoding",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_module_eeprom_sfp_8079),
+		TEST_CASE(test_module_eeprom_sfp_8472),
+		TEST_CASE(test_module_eeprom_sfp_8472_short),
+		TEST_CASE(test_module_eeprom_qsfp_8636),
+		TEST_CASE(test_module_eeprom_invalid),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_module_eeprom(void)
+{
+	return unit_test_suite_runner(&module_eeprom_testsuite);
+}
+
+REGISTER_FAST_TEST(ethdev_module_eeprom, NOHUGE_OK, ASAN_OK, test_module_eeprom);
-- 
2.47.3

