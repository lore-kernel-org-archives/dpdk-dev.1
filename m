Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFDECA600A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E821140E3A;
	Thu,  8 Oct 2026 10:23:41 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 5E30B40A6E
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:23:40 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 7A7AB89DB3;
 Thu, 08 Oct 2026 11:23:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 6491480619;
 Thu, 08 Oct 2026 11:23:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id UNJ0VOBd8Cg0-oITXF2U2; 
 Thu, 08 Oct 2026 11:23:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791447818; bh=ekXFcx5q8ixXCPUrEQmlhuZX+nMR7JoNKcDaiyTlghM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LrQcENkJSwvs/V4h4D87ZDgOimvkamraafJICtzLlc3jYBjUTEbUUHX8pAX3U0r4P
 cbZFcCD1K/5UmQewe7JmEbN/rwWyMlABAetKHHq8QzMKZpjGY/pjMBCbMtD5iF52BN
 Zl8JxuRNJqF2VaV9o9+7B16WzP7tJdyxd6pImSOA=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH 2/4] test: check SFF-8636 lane status flags
Date: Thu,  8 Oct 2026 10:23:24 +0200
Message-ID: <a94989770761f2e9d9d22d297e81405f429e0b09.1791447600.git.roma55592@yandex.ru>
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

Check that the SFF-8636 lane status flags are not reported
if the module does not advertise them, are reported as "None"
if no lane is flagged, and that each lane is mapped to the
right bit of the flag bytes.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/test_ethdev_module_eeprom.c | 77 ++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_ethdev_module_eeprom.c
index 1956fdd440..135ff5e5e3 100644
--- a/app/test/test_ethdev_module_eeprom.c
+++ b/app/test/test_ethdev_module_eeprom.c
@@ -243,6 +243,81 @@ test_module_eeprom_qsfp_8636_thresholds(void)
 	return TEST_SUCCESS;
 }
 
+/* SFF-8636 lower page channel status flags and their implemented bits */
+#define QSFP_LOS_FLAGS		3
+#define QSFP_FAULT_FLAGS	4
+#define QSFP_LOL_FLAGS		5
+#define QSFP_OPTIONS_2		193
+#define QSFP_OPTIONS_3		194
+#define QSFP_OPTIONS_4		195
+
+static void
+fill_qsfp_signals(uint8_t *data)
+{
+	fill_qsfp(data);
+	data[QSFP_OPTIONS_2] = 0x08;	/* Tx adaptive equalizers */
+	data[QSFP_OPTIONS_3] = 0x30;	/* Tx and Rx CDR loss of lock */
+	data[QSFP_OPTIONS_4] = 0x0a;	/* Tx fault and Tx loss of signal */
+}
+
+static int
+test_module_eeprom_qsfp_8636_signals_not_implemented(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+
+	/* flags are raised but the module does not advertise them */
+	fill_qsfp(data);
+	data[QSFP_LOS_FLAGS] = 0xff;
+	data[QSFP_FAULT_FLAGS] = 0xff;
+	data[QSFP_LOL_FLAGS] = 0xff;
+
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+		"Failed to parse SFF-8636 data");
+	CHECK_NO_FIELD("Rx loss of signal");
+	CHECK_NO_FIELD("Tx loss of signal");
+	CHECK_NO_FIELD("Rx loss of lock");
+	CHECK_NO_FIELD("Tx loss of lock");
+	CHECK_NO_FIELD("Tx fault");
+	CHECK_NO_FIELD("Tx adaptive eq fault");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_qsfp_8636_signals(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8636_LEN];
+
+	fill_qsfp_signals(data);
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+		"Failed to parse SFF-8636 data without flags");
+	CHECK_FIELD("Rx loss of signal", "None");
+	CHECK_FIELD("Tx loss of signal", "None");
+	CHECK_FIELD("Rx loss of lock", "None");
+	CHECK_FIELD("Tx loss of lock", "None");
+	CHECK_FIELD("Tx fault", "None");
+	CHECK_FIELD("Tx adaptive eq fault", "None");
+
+	/* lane 1 is in the lowest bit of each half of the flag byte */
+	data[QSFP_LOS_FLAGS] = 0x21;	/* Rx lane 1, Tx lane 2 */
+	data[QSFP_FAULT_FLAGS] = 0x84;	/* Tx fault lane 3, Tx adaptive eq lane 4 */
+	data[QSFP_LOL_FLAGS] = 0x18;	/* Rx lane 4, Tx lane 1 */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+		"Failed to parse SFF-8636 data with flags");
+	CHECK_FIELD("Rx loss of signal", "[ Yes, No, No, No ]");
+	CHECK_FIELD("Tx loss of signal", "[ No, Yes, No, No ]");
+	CHECK_FIELD("Rx loss of lock", "[ No, No, No, Yes ]");
+	CHECK_FIELD("Tx loss of lock", "[ Yes, No, No, No ]");
+	CHECK_FIELD("Tx fault", "[ No, No, Yes, No ]");
+	CHECK_FIELD("Tx adaptive eq fault", "[ No, No, No, Yes ]");
+
+	data[QSFP_LOS_FLAGS] = 0x0f;	/* Rx on all lanes, no Tx */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8636, data, sizeof(data)),
+		"Failed to parse SFF-8636 data with Rx LOS on all lanes");
+	CHECK_FIELD("Rx loss of signal", "[ Yes, Yes, Yes, Yes ]");
+	CHECK_FIELD("Tx loss of signal", "None");
+	return TEST_SUCCESS;
+}
+
 static int
 test_module_eeprom_sfp_8472_ext_cal_unaligned(void)
 {
@@ -453,6 +528,8 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_sfp_8472_cal_round),
 		TEST_CASE(test_module_eeprom_qsfp_8636),
 		TEST_CASE(test_module_eeprom_qsfp_8636_thresholds),
+		TEST_CASE(test_module_eeprom_qsfp_8636_signals_not_implemented),
+		TEST_CASE(test_module_eeprom_qsfp_8636_signals),
 		TEST_CASE(test_module_eeprom_invalid),
 		TEST_CASES_END()
 	}
-- 
2.47.3

