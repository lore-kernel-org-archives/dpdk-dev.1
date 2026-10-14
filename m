Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87216CC6B24
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 07:13:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 435E54064C;
	Wed, 14 Oct 2026 09:13:34 +0200 (CEST)
Received: from forward504d.mail.yandex.net (forward504d.mail.yandex.net
 [31.44.14.20]) by mails.dpdk.org (Postfix) with ESMTP id E089E40272
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:13:31 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:5a3:0:640:5b8e:0])
 by forward504d.mail.yandex.net (postfix) with ESMTPS id 76295108253;
 Wed, 14 Oct 2026 10:13:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id uCORNqZtq0U0-dPCPFSrt; 
 Wed, 14 Oct 2026 10:13:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791962009; bh=QIHph0187OrWajR4UvWD4MKBrkvifE9Lc3heQmavmos=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=s+ROHKsFtqddqIjB/0NZzahJcPUG9ccgxEwVsPcYVJUULJY29SXKqjSlMBJUXjHkb
 48yfCGQdMOm9zB6IvDCBCATi8nSkEn+gQ0gGHvq4fgSRzKVMp0TlkmZ0qvFhJsv3My
 J53iyVjMm6jANDAr28pnt6u6l77Dr3dSV974KS8k=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [RFC 2/2] test/transceiver: move module EEPROM decoding tests
Date: Wed, 14 Oct 2026 09:12:45 +0200
Message-ID: <20261014071245.2323258-3-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014071245.2323258-1-roma55592@yandex.ru>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
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

Move the module EEPROM decoding tests to the transceiver library,
use rte_transceiver_decode() and the RTE_TRANSCEIVER_SFF_* types,
and rename the test from ethdev_module_eeprom_autotest
to transceiver_autotest.

Keep one test for rte_eth_module_eeprom_parse(), which is now
a wrapper of the library, with the RTE_ETH_MODULE_SFF_* types.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 MAINTAINERS                                   |   1 +
 app/test/meson.build                          |   2 +-
 ...dev_module_eeprom.c => test_transceiver.c} | 138 +++++++++++-------
 3 files changed, 84 insertions(+), 57 deletions(-)
 rename app/test/{test_ethdev_module_eeprom.c => test_transceiver.c} (82%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3150a4e794..0dd9c943b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -451,6 +451,7 @@ Transceiver module EEPROM
 M: Roman Khromenok <roma55592@yandex.ru>
 T: git://dpdk.org/next/dpdk-next-net
 F: lib/transceiver/
+F: app/test/test_transceiver.c
 F: doc/guides/prog_guide/transceiver_lib.rst
 
 Flow API
diff --git a/app/test/meson.build b/app/test/meson.build
index 9805cf5bee..c2b6bb532f 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -78,7 +78,6 @@ source_file_deps = {
     'test_errno.c': [],
     'test_ethdev_api.c': ['ethdev'],
     'test_ethdev_link.c': ['ethdev'],
-    'test_ethdev_module_eeprom.c': ['ethdev'],
     'test_event_crypto_adapter.c': ['cryptodev', 'eventdev', 'bus_vdev'],
     'test_event_dma_adapter.c': ['dmadev', 'eventdev', 'bus_vdev'],
     'test_event_eth_rx_adapter.c': ['ethdev', 'eventdev', 'bus_vdev'],
@@ -214,6 +213,7 @@ source_file_deps = {
     'test_trace.c': [],
     'test_trace_perf.c': [],
     'test_trace_register.c': [],
+    'test_transceiver.c': ['transceiver', 'ethdev'],
     'test_vdev.c': ['kvargs', 'bus_vdev', 'net_null'],
     'test_version.c': [],
 }
diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_transceiver.c
similarity index 82%
rename from app/test/test_ethdev_module_eeprom.c
rename to app/test/test_transceiver.c
index 5f7e5db403..80e128b287 100644
--- a/app/test/test_ethdev_module_eeprom.c
+++ b/app/test/test_transceiver.c
@@ -10,6 +10,7 @@
 
 #include <rte_common.h>
 #include <rte_ethdev.h>
+#include <rte_transceiver.h>
 #include <rte_string_fns.h>
 
 #include "test.h"
@@ -55,7 +56,7 @@ static int
 parse(uint32_t type, const uint8_t *data, uint32_t length)
 {
 	memset(&fields, 0, sizeof(fields));
-	return rte_eth_module_eeprom_parse(type, data, length, collect_field, &fields);
+	return rte_transceiver_decode(type, data, length, collect_field, &fields);
 }
 
 #define CHECK_FIELD(name, expected) do { \
@@ -100,9 +101,9 @@ put_u16(uint8_t *data, unsigned int offset, uint16_t value)
 static void
 fill_sfp(uint8_t *data)
 {
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
-	memset(data, 0, RTE_ETH_MODULE_SFF_8472_LEN);
+	memset(data, 0, RTE_TRANSCEIVER_SFF_8472_LEN);
 	data[0] = 0x03;		/* identifier: SFP */
 	data[1] = 0x04;		/* extended identifier */
 	data[2] = 0x07;		/* connector: LC */
@@ -131,7 +132,7 @@ fill_sfp(uint8_t *data)
 static void
 fill_qsfp(uint8_t *data)
 {
-	memset(data, 0, RTE_ETH_MODULE_SFF_8636_LEN);
+	memset(data, 0, RTE_TRANSCEIVER_SFF_8636_LEN);
 	data[0] = 0x11;		/* identifier: QSFP28 */
 	put_u16(data, 22, 0x3040);	/* temperature: 48.25 C */
 	put_u16(data, 26, 32638);	/* voltage: 3.2638 V */
@@ -169,10 +170,10 @@ check_sfp_identity(void)
 static int
 test_module_eeprom_sfp_8079(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
 
 	fill_sfp(data);
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8079, data, RTE_ETH_MODULE_SFF_8079_LEN),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8079, data, RTE_TRANSCEIVER_SFF_8079_LEN),
 		"Failed to parse SFF-8079 data");
 	TEST_ASSERT_SUCCESS(check_sfp_identity(), "Wrong SFF-8079 base information");
 	CHECK_NO_FIELD("Optical diagnostics support");
@@ -182,10 +183,10 @@ test_module_eeprom_sfp_8079(void)
 static int
 test_module_eeprom_sfp_8472(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
 
 	fill_sfp(data);
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse SFF-8472 data");
 	TEST_ASSERT_SUCCESS(check_sfp_identity(), "Wrong SFF-8472 base information");
 	CHECK_FIELD("Optical diagnostics support", "Yes");
@@ -200,16 +201,16 @@ test_module_eeprom_sfp_8472(void)
 static int
 test_module_eeprom_sfp_8472_short(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
 	const uint32_t lengths[] = {
-		RTE_ETH_MODULE_SFF_8079_LEN,
-		RTE_ETH_MODULE_SFF_8472_LEN - 1,
+		RTE_TRANSCEIVER_SFF_8079_LEN,
+		RTE_TRANSCEIVER_SFF_8472_LEN - 1,
 	};
 	unsigned int i;
 
 	fill_sfp(data);
 	for (i = 0; i < RTE_DIM(lengths); i++) {
-		TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, lengths[i]),
+		TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, lengths[i]),
 			"Failed to parse SFF-8472 data of %u bytes", lengths[i]);
 		TEST_ASSERT_SUCCESS(check_sfp_identity(),
 			"Wrong SFF-8472 base information from %u bytes", lengths[i]);
@@ -223,10 +224,10 @@ test_module_eeprom_sfp_8472_short(void)
 static int
 test_module_eeprom_qsfp_8636(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8636_LEN];
 
 	fill_qsfp(data);
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8636, data, sizeof(data)),
 		"Failed to parse SFF-8636 data");
 	CHECK_FIELD("Identifier", "0x11 (QSFP28)");
 	CHECK_FIELD("Connector", "0x07 (LC)");
@@ -249,14 +250,14 @@ test_module_eeprom_qsfp_8636(void)
 static int
 test_module_eeprom_qsfp_8636_thresholds(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8636_MAX_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8636_MAX_LEN];
 
 	memset(data, 0, sizeof(data));
 	/* paging is supported (flat memory bit is clear), page 03h is at 0x200 */
 	fill_qsfp(data);
 	put_u16(data, 0x200, 0x5000);	/* temperature high alarm: 80 C */
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8636, data, sizeof(data)),
 		"Failed to parse SFF-8636 data with page 03h");
 	CHECK_FIELD("Vendor name", "FINISAR CORP.");
 	CHECK_FIELD("Alarm/warning flags implemented", "Yes");
@@ -332,32 +333,32 @@ test_module_eeprom_qsfp_compliance(void)
 static int
 test_module_eeprom_sfp_8472_status(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
 	/* state is raised but the module does not advertise it */
 	fill_sfp(data);
 	a2[SFP_A2_STATUS] = 0x06;
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse SFF-8472 data");
 	CHECK_NO_FIELD("Rx loss of signal");
 	CHECK_NO_FIELD("Tx fault");
 
 	data[SFP_ENH_OPTIONS] |= 0x30;	/* soft Tx fault and Rx LOS monitoring */
 	a2[SFP_A2_STATUS] = 0;
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse SFF-8472 data without status bits");
 	CHECK_FIELD("Rx loss of signal", "None");
 	CHECK_FIELD("Tx fault", "None");
 
 	a2[SFP_A2_STATUS] = 0x02;	/* Rx LOS */
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse SFF-8472 data with Rx LOS");
 	CHECK_FIELD("Rx loss of signal", "[ Yes ]");
 	CHECK_FIELD("Tx fault", "None");
 
 	a2[SFP_A2_STATUS] = 0x04;	/* Tx fault */
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse SFF-8472 data with Tx fault");
 	CHECK_FIELD("Rx loss of signal", "None");
 	CHECK_FIELD("Tx fault", "[ Yes ]");
@@ -384,7 +385,7 @@ fill_qsfp_signals(uint8_t *data)
 static int
 test_module_eeprom_qsfp_8636_signals_not_implemented(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8636_LEN];
 
 	/* flags are raised but the module does not advertise them */
 	fill_qsfp(data);
@@ -392,7 +393,7 @@ test_module_eeprom_qsfp_8636_signals_not_implemented(void)
 	data[QSFP_FAULT_FLAGS] = 0xff;
 	data[QSFP_LOL_FLAGS] = 0xff;
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8636, data, sizeof(data)),
 		"Failed to parse SFF-8636 data");
 	/* Rx LOS has no implemented bit and is always reported */
 	CHECK_FIELD("Rx loss of signal", "[ Yes, Yes, Yes, Yes ]");
@@ -407,10 +408,10 @@ test_module_eeprom_qsfp_8636_signals_not_implemented(void)
 static int
 test_module_eeprom_qsfp_8636_signals(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+	uint8_t data[RTE_TRANSCEIVER_SFF_8636_LEN];
 
 	fill_qsfp_signals(data);
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8636, data, sizeof(data)),
 		"Failed to parse SFF-8636 data without flags");
 	CHECK_FIELD("Rx loss of signal", "None");
 	CHECK_FIELD("Tx loss of signal", "None");
@@ -423,7 +424,7 @@ test_module_eeprom_qsfp_8636_signals(void)
 	data[QSFP_LOS_FLAGS] = 0x21;	/* Rx lane 1, Tx lane 2 */
 	data[QSFP_FAULT_FLAGS] = 0x84;	/* Tx fault lane 3, Tx adaptive eq lane 4 */
 	data[QSFP_LOL_FLAGS] = 0x18;	/* Rx lane 4, Tx lane 1 */
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8636, data, sizeof(data)),
 		"Failed to parse SFF-8636 data with flags");
 	CHECK_FIELD("Rx loss of signal", "[ Yes, No, No, No ]");
 	CHECK_FIELD("Tx loss of signal", "[ No, Yes, No, No ]");
@@ -433,7 +434,7 @@ test_module_eeprom_qsfp_8636_signals(void)
 	CHECK_FIELD("Tx adaptive eq fault", "[ No, No, No, Yes ]");
 
 	data[QSFP_LOS_FLAGS] = 0x0f;	/* Rx on all lanes, no Tx */
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8636, data, sizeof(data)),
 		"Failed to parse SFF-8636 data with Rx LOS on all lanes");
 	CHECK_FIELD("Rx loss of signal", "[ Yes, Yes, Yes, Yes ]");
 	CHECK_FIELD("Tx loss of signal", "None");
@@ -444,9 +445,9 @@ static int
 test_module_eeprom_sfp_8472_ext_cal_unaligned(void)
 {
 	/* the SFF-8472 calibration floats must be readable from any address */
-	uint8_t alignas(8) buf[RTE_ETH_MODULE_SFF_8472_LEN + 1];
+	uint8_t alignas(8) buf[RTE_TRANSCEIVER_SFF_8472_LEN + 1];
 	uint8_t *data = buf + 1;
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 	const uint8_t two[4] = { 0x40, 0x00, 0x00, 0x00 };	/* 2.0f big endian */
 
 	fill_sfp(data);
@@ -459,7 +460,7 @@ test_module_eeprom_sfp_8472_ext_cal_unaligned(void)
 	a2[88] = 1;	/* voltage slope */
 	memcpy(&a2[68], two, sizeof(two));
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, RTE_ETH_MODULE_SFF_8472_LEN),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, RTE_TRANSCEIVER_SFF_8472_LEN),
 		"Failed to parse externally calibrated SFF-8472 data");
 	CHECK_FIELD("Laser bias current", "39.580 mA");
 	CHECK_FIELD("Receiver signal average optical power", "1.3448 mW / 1.29 dBm");
@@ -478,8 +479,8 @@ put_be_float(uint8_t *data, unsigned int offset, uint32_t bits)
 static int
 test_module_eeprom_sfp_8472_rx_power_polynomial(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
 	fill_sfp(data);
 	/* diagnostics implemented, externally calibrated, average RX power */
@@ -496,7 +497,7 @@ test_module_eeprom_sfp_8472_rx_power_polynomial(void)
 	put_be_float(a2, 68, 0x3f800000);	/* RX_PWR(1) = 1.0 */
 	put_be_float(a2, 72, 0);		/* RX_PWR(0) = 0 */
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse externally calibrated SFF-8472 data");
 	CHECK_FIELD("Receiver signal average optical power", "0.1560 mW / -8.07 dBm");
 	return TEST_SUCCESS;
@@ -506,7 +507,7 @@ test_module_eeprom_sfp_8472_rx_power_polynomial(void)
 static void
 fill_sfp_ext_cal(uint8_t *data)
 {
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
 	fill_sfp(data);
 	/* diagnostics implemented, externally calibrated, average RX power */
@@ -521,8 +522,8 @@ fill_sfp_ext_cal(uint8_t *data)
 static int
 test_module_eeprom_sfp_8472_cal_saturate_max(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
 	fill_sfp_ext_cal(data);
 	/* results above the 16-bit range must saturate */
@@ -537,7 +538,7 @@ test_module_eeprom_sfp_8472_cal_saturate_max(void)
 	put_u16(a2, 104, 65535);	/* raw RX power */
 	put_be_float(a2, 56, 0x3f800000);	/* RX_PWR(4) = 1.0 */
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse externally calibrated SFF-8472 data");
 	CHECK_FIELD("Laser bias current", "131.070 mA");
 	CHECK_FIELD("Laser output power", "6.5535 mW / 8.16 dBm");
@@ -550,8 +551,8 @@ test_module_eeprom_sfp_8472_cal_saturate_max(void)
 static int
 test_module_eeprom_sfp_8472_cal_saturate_min(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
 	fill_sfp_ext_cal(data);
 	/* results below the 16-bit range must saturate */
@@ -565,7 +566,7 @@ test_module_eeprom_sfp_8472_cal_saturate_min(void)
 	put_u16(a2, 90, -1000);		/* voltage offset */
 	put_be_float(a2, 68, 0xbf800000);	/* RX_PWR(1) = -1.0 */
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse externally calibrated SFF-8472 data");
 	CHECK_FIELD("Laser bias current", "0.000 mA");
 	CHECK_FIELD("Laser output power", "0.0000 mW / -inf dBm");
@@ -578,8 +579,8 @@ test_module_eeprom_sfp_8472_cal_saturate_min(void)
 static int
 test_module_eeprom_sfp_8472_cal_round(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
-	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+	uint8_t data[RTE_TRANSCEIVER_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_TRANSCEIVER_SFF_8079_LEN;
 
 	fill_sfp_ext_cal(data);
 	/* calibrated values must be rounded to the nearest, not truncated */
@@ -588,7 +589,7 @@ test_module_eeprom_sfp_8472_cal_round(void)
 	put_u16(a2, 104, 1000);		/* raw RX power */
 	put_be_float(a2, 68, 0x3f333333);	/* RX_PWR(1) = 0.7, stored as 0.69999999 */
 
-	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+	TEST_ASSERT_SUCCESS(parse(RTE_TRANSCEIVER_SFF_8472, data, sizeof(data)),
 		"Failed to parse externally calibrated SFF-8472 data");
 	CHECK_FIELD("Laser bias current", "0.010 mA");
 	CHECK_FIELD("Receiver signal average optical power", "0.0700 mW / -11.55 dBm");
@@ -598,12 +599,12 @@ test_module_eeprom_sfp_8472_cal_round(void)
 static int
 test_module_eeprom_invalid(void)
 {
-	uint8_t data[RTE_ETH_MODULE_SFF_8636_MAX_LEN] = {0};
+	uint8_t data[RTE_TRANSCEIVER_SFF_8636_MAX_LEN] = {0};
 	const uint32_t types[] = {
-		RTE_ETH_MODULE_SFF_8079,
-		RTE_ETH_MODULE_SFF_8472,
-		RTE_ETH_MODULE_SFF_8436,
-		RTE_ETH_MODULE_SFF_8636,
+		RTE_TRANSCEIVER_SFF_8079,
+		RTE_TRANSCEIVER_SFF_8472,
+		RTE_TRANSCEIVER_SFF_8436,
+		RTE_TRANSCEIVER_SFF_8636,
 	};
 	unsigned int i;
 	int ret;
@@ -620,23 +621,47 @@ test_module_eeprom_invalid(void)
 
 	ret = parse(0, data, sizeof(data));
 	TEST_ASSERT_EQUAL(ret, -ENOTSUP, "Type 0: expected %d, got %d", -ENOTSUP, ret);
-	ret = parse(RTE_ETH_MODULE_SFF_8436 + 1, data, sizeof(data));
+	ret = parse(RTE_TRANSCEIVER_SFF_8436 + 1, data, sizeof(data));
 	TEST_ASSERT_EQUAL(ret, -ENOTSUP, "Unknown type: expected %d, got %d", -ENOTSUP, ret);
 	TEST_ASSERT_EQUAL(fields.count, 0, "Unknown type: callback called %u times",
 		fields.count);
 
-	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8079, NULL,
-		RTE_ETH_MODULE_SFF_8079_LEN, collect_field, &fields);
+	ret = rte_transceiver_decode(RTE_TRANSCEIVER_SFF_8079, NULL,
+		RTE_TRANSCEIVER_SFF_8079_LEN, collect_field, &fields);
 	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL data: expected %d, got %d", -EINVAL, ret);
-	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8079, data,
-		RTE_ETH_MODULE_SFF_8079_LEN, NULL, NULL);
+	ret = rte_transceiver_decode(RTE_TRANSCEIVER_SFF_8079, data,
+		RTE_TRANSCEIVER_SFF_8079_LEN, NULL, NULL);
 	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL callback: expected %d, got %d", -EINVAL, ret);
 
 	return TEST_SUCCESS;
 }
 
+/* rte_eth_module_eeprom_parse() is kept as a wrapper of the library */
+static int
+test_module_eeprom_ethdev_wrapper(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	int ret;
+
+	fill_sfp(data);
+	memset(&fields, 0, sizeof(fields));
+	TEST_ASSERT_SUCCESS(rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8472, data,
+		sizeof(data), collect_field, &fields),
+		"Failed to parse SFF-8472 data with the ethdev API");
+	TEST_ASSERT_SUCCESS(check_sfp_identity(), "Wrong SFF-8472 base information");
+	CHECK_FIELD("Laser bias current", "39.580 mA");
+
+	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8472, NULL,
+		sizeof(data), collect_field, &fields);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL data: expected %d, got %d", -EINVAL, ret);
+	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8472, data,
+		sizeof(data), NULL, NULL);
+	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL callback: expected %d, got %d", -EINVAL, ret);
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite module_eeprom_testsuite = {
-	.suite_name = "ethdev module EEPROM decoding",
+	.suite_name = "transceiver module EEPROM decoding",
 	.setup = NULL,
 	.teardown = NULL,
 	.unit_test_cases = {
@@ -656,6 +681,7 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_qsfp_8636_signals_not_implemented),
 		TEST_CASE(test_module_eeprom_qsfp_8636_signals),
 		TEST_CASE(test_module_eeprom_invalid),
+		TEST_CASE(test_module_eeprom_ethdev_wrapper),
 		TEST_CASES_END()
 	}
 };
@@ -666,4 +692,4 @@ test_module_eeprom(void)
 	return unit_test_suite_runner(&module_eeprom_testsuite);
 }
 
-REGISTER_FAST_TEST(ethdev_module_eeprom_autotest, NOHUGE_OK, ASAN_OK, test_module_eeprom);
+REGISTER_FAST_TEST(transceiver_autotest, NOHUGE_OK, ASAN_OK, test_module_eeprom);
-- 
2.47.3

