Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8F9CA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:53:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8011842E99;
	Fri,  2 Oct 2026 14:53:07 +0200 (CEST)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTP id 20BF942E15
 for <dev@dpdk.org>; Fri,  2 Oct 2026 14:53:05 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 707B783E69;
 Fri, 02 Oct 2026 15:53:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id fqkvm6Ydb8c0-CU9BPlr6; 
 Fri, 02 Oct 2026 15:53:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790945584; bh=Gzo+V5tFBsi0PfsNi8eTqKf0qIC7fIzQKYQ7OS33j9U=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=XRLZ9GIL5IS2hwz6DuouegzNz6fokaZmysFV+6/penzKaXLAgCB6kJndv2Q3iMQpP
 XlSSKudPxulV5x2xuHi1X6Vuvj9lYPtkJ49HfYo6PXSS6jEhEc5EM7n5h33qQvjMhh
 9Uzb/b80K2NjQvfPXYnaCLznRiBlKkD3DnwSdCFU=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 3/3] test: check SFF-8472 calibration saturation and rounding
Date: Fri,  2 Oct 2026 14:52:37 +0200
Message-ID: <9272d950a8f2294482b6a26c362c297a3bbab094.1790935333.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790935333.git.roma55592@yandex.ru>
References: <cover.1790935333.git.roma55592@yandex.ru>
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

Check that externally calibrated SFF-8472 values out of the range
of their 16-bit fields saturate at both ends, for formula 1
(temperature, voltage, TX bias and TX power) and for the RX power
polynomial, and that calibrated values are rounded to the nearest.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/test_ethdev_module_eeprom.c | 96 ++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_ethdev_module_eeprom.c
index b07a18aa06..1956fdd440 100644
--- a/app/test/test_ethdev_module_eeprom.c
+++ b/app/test/test_ethdev_module_eeprom.c
@@ -305,6 +305,99 @@ test_module_eeprom_sfp_8472_rx_power_polynomial(void)
 	return TEST_SUCCESS;
 }
 
+/* SFF-8472 module externally calibrated with unit slopes and zero offsets */
+static void
+fill_sfp_ext_cal(uint8_t *data)
+{
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	fill_sfp(data);
+	/* diagnostics implemented, externally calibrated, average RX power */
+	data[92] = 0x58;
+	a2[76] = 1;	/* TX bias slope */
+	a2[80] = 1;	/* TX power slope */
+	a2[84] = 1;	/* temperature slope */
+	a2[88] = 1;	/* voltage slope */
+	put_be_float(a2, 68, 0x3f800000);	/* RX_PWR(1) = 1.0 */
+}
+
+static int
+test_module_eeprom_sfp_8472_cal_saturate_max(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	fill_sfp_ext_cal(data);
+	/* results above the 16-bit range must saturate */
+	put_u16(a2, 100, 65535);	/* raw TX bias */
+	put_u16(a2, 76, 0xffff);	/* TX bias slope = 255.996 */
+	put_u16(a2, 102, 60000);	/* raw TX power */
+	put_u16(a2, 82, 10000);		/* TX power offset */
+	put_u16(a2, 96, 0x7f00);	/* raw temperature: 127 C */
+	put_u16(a2, 84, 0x0200);	/* temperature slope = 2.0 */
+	put_u16(a2, 98, 60000);		/* raw voltage */
+	put_u16(a2, 90, 10000);		/* voltage offset */
+	put_u16(a2, 104, 65535);	/* raw RX power */
+	put_be_float(a2, 56, 0x3f800000);	/* RX_PWR(4) = 1.0 */
+
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse externally calibrated SFF-8472 data");
+	CHECK_FIELD("Laser bias current", "131.070 mA");
+	CHECK_FIELD("Laser output power", "6.5535 mW / 8.16 dBm");
+	CHECK_FIELD("Module temperature", "128.00 degrees C / 262.39 degrees F");
+	CHECK_FIELD("Module voltage", "6.5535 V");
+	CHECK_FIELD("Receiver signal average optical power", "6.5535 mW / 8.16 dBm");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_sfp_8472_cal_saturate_min(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	fill_sfp_ext_cal(data);
+	/* results below the 16-bit range must saturate */
+	put_u16(a2, 100, 100);		/* raw TX bias */
+	put_u16(a2, 78, -1000);		/* TX bias offset */
+	put_u16(a2, 102, 100);		/* raw TX power */
+	put_u16(a2, 82, -1000);		/* TX power offset */
+	put_u16(a2, 96, 0x8100);	/* raw temperature: -127 C */
+	put_u16(a2, 84, 0x0200);	/* temperature slope = 2.0 */
+	put_u16(a2, 98, 100);		/* raw voltage */
+	put_u16(a2, 90, -1000);		/* voltage offset */
+	put_be_float(a2, 68, 0xbf800000);	/* RX_PWR(1) = -1.0 */
+
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse externally calibrated SFF-8472 data");
+	CHECK_FIELD("Laser bias current", "0.000 mA");
+	CHECK_FIELD("Laser output power", "0.0000 mW / -inf dBm");
+	CHECK_FIELD("Module temperature", "-128.00 degrees C / -198.40 degrees F");
+	CHECK_FIELD("Module voltage", "0.0000 V");
+	CHECK_FIELD("Receiver signal average optical power", "0.0000 mW / -inf dBm");
+	return TEST_SUCCESS;
+}
+
+static int
+test_module_eeprom_sfp_8472_cal_round(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	fill_sfp_ext_cal(data);
+	/* calibrated values must be rounded to the nearest, not truncated */
+	put_u16(a2, 100, 3);		/* raw TX bias */
+	put_u16(a2, 76, 0x0180);	/* TX bias slope = 1.5 */
+	put_u16(a2, 104, 1000);		/* raw RX power */
+	put_be_float(a2, 68, 0x3f333333);	/* RX_PWR(1) = 0.7, stored as 0.69999999 */
+
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse externally calibrated SFF-8472 data");
+	CHECK_FIELD("Laser bias current", "0.010 mA");
+	CHECK_FIELD("Receiver signal average optical power", "0.0700 mW / -11.55 dBm");
+	return TEST_SUCCESS;
+}
+
 static int
 test_module_eeprom_invalid(void)
 {
@@ -355,6 +448,9 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_sfp_8472_short),
 		TEST_CASE(test_module_eeprom_sfp_8472_ext_cal_unaligned),
 		TEST_CASE(test_module_eeprom_sfp_8472_rx_power_polynomial),
+		TEST_CASE(test_module_eeprom_sfp_8472_cal_saturate_max),
+		TEST_CASE(test_module_eeprom_sfp_8472_cal_saturate_min),
+		TEST_CASE(test_module_eeprom_sfp_8472_cal_round),
 		TEST_CASE(test_module_eeprom_qsfp_8636),
 		TEST_CASE(test_module_eeprom_qsfp_8636_thresholds),
 		TEST_CASE(test_module_eeprom_invalid),
-- 
2.47.3

