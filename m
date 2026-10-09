Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF39ACA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 19:34:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBD8840274;
	Fri,  9 Oct 2026 21:34:42 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 72D7E4026A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 21:34:41 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2224:0:640:a699:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 455498A46D;
 Fri, 09 Oct 2026 22:34:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id VYV8GXad4Sw0-eTSBFLMZ; 
 Fri, 09 Oct 2026 22:34:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791574480; bh=B7BicqT8rIODDSAYBoQKbYmzGg7qqcelVS16g99/ENU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=keWPpWMZck8BPLnMPtfugKxzE/VpgQFYb0kdGkN4Up1QTq3+RSQ8qKZQ/1FHnXjhR
 EZeNL0BAsIoyR2pSpkuBh3AjI71IAv7g1NwdjY+24LHC9hVwER9xW23EJuc+hHJbay
 IX3OYHZI3qNPGXJryWB/oq5yCUTt5EMjWNMtKHnQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: stephen@networkplumber.org
Subject: [PATCH 2/2] test: check newer SFF compliance codes
Date: Fri,  9 Oct 2026 21:34:27 +0200
Message-ID: <b388a9625bafdfc95adbf1b9812c89c1fd910829.1791574390.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
References: <835d139c746faff456f14755b7af7395b713bd70.1791574390.git.roma55592@yandex.ru>
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

Check the SFF-8472 Fibre Channel 1600, 3200 MBytes/s and 64GFC
codes, with 64GFC reported only when byte 10 refers to byte 62,
and the SFF-8636 SAS 24.0G, 12.0G and Fibre Channel 3200 MBytes/s
codes.

Add a helper to look for a value of a field reported more than
once, such as "Transceiver type".

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/test_ethdev_module_eeprom.c | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_ethdev_module_eeprom.c
index 25307678a1..01eefa7d65 100644
--- a/app/test/test_ethdev_module_eeprom.c
+++ b/app/test/test_ethdev_module_eeprom.c
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <stdalign.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 
@@ -67,6 +68,27 @@ parse(uint32_t type, const uint8_t *data, uint32_t length)
 #define CHECK_NO_FIELD(name) \
 	TEST_ASSERT_NULL(find_field(name), "Unexpected field \"%s\"", name)
 
+/* A field name may be reported more than once, e.g. "Transceiver type" */
+static bool
+has_field_value(const char *name, const char *value)
+{
+	unsigned int i;
+
+	for (i = 0; i < fields.count; i++)
+		if (strcmp(fields.field[i].name, name) == 0 &&
+		    strcmp(fields.field[i].value, value) == 0)
+			return true;
+	return false;
+}
+
+#define CHECK_FIELD_VALUE(name, value) \
+	TEST_ASSERT(has_field_value(name, value), \
+		"Field \"%s\" with value \"%s\" not found", name, value)
+
+#define CHECK_NO_FIELD_VALUE(name, value) \
+	TEST_ASSERT(!has_field_value(name, value), \
+		"Unexpected field \"%s\" with value \"%s\"", name, value)
+
 static void
 put_u16(uint8_t *data, unsigned int offset, uint16_t value)
 {
@@ -243,6 +265,44 @@ test_module_eeprom_qsfp_8636_thresholds(void)
 	return TEST_SUCCESS;
 }
 
+static int
+test_module_eeprom_sfp_compliance(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+
+	fill_sfp(data);
+	data[10] = 0x28;	/* FC speed: 1600 and 3200 MBytes/s */
+	data[62] = 0x01;	/* 64GFC, without the byte 10 bit 1 pointer */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data");
+	CHECK_FIELD_VALUE("Transceiver type", "FC: 1600 MBytes/sec");
+	CHECK_FIELD_VALUE("Transceiver type", "FC: 3200 MBytes/sec");
+	CHECK_NO_FIELD_VALUE("Transceiver type", "FC: 64GFC");
+
+	data[10] |= 0x02;	/* see byte 62, Fibre Channel Speed 2 */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data with Fibre Channel Speed 2");
+	CHECK_FIELD_VALUE("Transceiver type", "FC: 64GFC");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_qsfp_compliance(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+
+	fill_qsfp(data);
+	data[133] = 0xc0;	/* SAS 24.0G and 12.0G */
+	data[138] = 0x08;	/* FC speed: 3200 MBytes/s */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+		"Failed to parse SFF-8636 data");
+	CHECK_FIELD_VALUE("Transceiver type", "SAS 24.0G");
+	CHECK_FIELD_VALUE("Transceiver type", "SAS 12.0G");
+	CHECK_FIELD_VALUE("Transceiver type", "FC: 3200 MBytes/sec");
+	CHECK_NO_FIELD_VALUE("Transceiver type", "SAS 6.0G");
+	return TEST_SUCCESS;
+}
+
 /* SFF-8472 status bits and their implemented bits */
 #define SFP_ENH_OPTIONS		93
 #define SFP_A2_STATUS		110
@@ -567,6 +627,8 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_sfp_8472_cal_saturate_min),
 		TEST_CASE(test_module_eeprom_sfp_8472_cal_round),
 		TEST_CASE(test_module_eeprom_sfp_8472_status),
+		TEST_CASE(test_module_eeprom_sfp_compliance),
+		TEST_CASE(test_module_eeprom_qsfp_compliance),
 		TEST_CASE(test_module_eeprom_qsfp_8636),
 		TEST_CASE(test_module_eeprom_qsfp_8636_thresholds),
 		TEST_CASE(test_module_eeprom_qsfp_8636_signals_not_implemented),
-- 
2.47.3

