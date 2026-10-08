Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8324CA600A
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:23:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB5ED427A9;
	Thu,  8 Oct 2026 10:23:43 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 4DA5F40E3A
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:23:41 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 1D05D88C35;
 Thu, 08 Oct 2026 11:23:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c22:d15:0:640:87c2:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 07515805F5;
 Thu, 08 Oct 2026 11:23:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id UNJ0VOBd8Cg0-x5pZnIED; 
 Thu, 08 Oct 2026 11:23:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791447820; bh=gQOvYq7JHebfLRrpipsl31adV9axoDsUvJ3bJOW0g9g=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qZs0kvr1/vdVzde9qGwg83TmDehaH/ij51Bm9hi8vPEIGfAIVU8mkxKoTVy1kGqfR
 no2AQeXOgmnP91KBW4/zRzrpiGi04QsrkINOU70GJg4uzUK9zKv8/XwIefBhcirla5
 2LjxIqwGrzmWDGheEPHTXYYaVjR4s3L3o2CWoRtQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org
Subject: [PATCH 4/4] test: check SFF-8472 Rx LOS and Tx fault state
Date: Thu,  8 Oct 2026 10:23:26 +0200
Message-ID: <a8411611db1fad3a3607a8924edfc67d0023ce8d.1791447600.git.roma55592@yandex.ru>
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

Check that the SFF-8472 Rx loss of signal and Tx fault state
are not reported if the module does not advertise them,
and that each one is mapped to the right bit of the status byte.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/test_ethdev_module_eeprom.c | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_ethdev_module_eeprom.c
index 135ff5e5e3..1b2f43c4c2 100644
--- a/app/test/test_ethdev_module_eeprom.c
+++ b/app/test/test_ethdev_module_eeprom.c
@@ -243,6 +243,45 @@ test_module_eeprom_qsfp_8636_thresholds(void)
 	return TEST_SUCCESS;
 }
 
+/* SFF-8472 status bits and their implemented bits */
+#define SFP_ENH_OPTIONS		93
+#define SFP_A2_STATUS		110
+
+static int
+test_module_eeprom_sfp_8472_status(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	/* state is raised but the module does not advertise it */
+	fill_sfp(data);
+	a2[SFP_A2_STATUS] = 0x06;
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data");
+	CHECK_NO_FIELD("Rx loss of signal");
+	CHECK_NO_FIELD("Tx fault");
+
+	data[SFP_ENH_OPTIONS] = 0x30;	/* soft Tx fault and Rx LOS monitoring */
+	a2[SFP_A2_STATUS] = 0;
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data without status bits");
+	CHECK_FIELD("Rx loss of signal", "No");
+	CHECK_FIELD("Tx fault", "No");
+
+	a2[SFP_A2_STATUS] = 0x02;	/* Rx LOS */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data with Rx LOS");
+	CHECK_FIELD("Rx loss of signal", "Yes");
+	CHECK_FIELD("Tx fault", "No");
+
+	a2[SFP_A2_STATUS] = 0x04;	/* Tx fault */
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse SFF-8472 data with Tx fault");
+	CHECK_FIELD("Rx loss of signal", "No");
+	CHECK_FIELD("Tx fault", "Yes");
+	return TEST_SUCCESS;
+}
+
 /* SFF-8636 lower page channel status flags and their implemented bits */
 #define QSFP_LOS_FLAGS		3
 #define QSFP_FAULT_FLAGS	4
@@ -526,6 +565,7 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_sfp_8472_cal_saturate_max),
 		TEST_CASE(test_module_eeprom_sfp_8472_cal_saturate_min),
 		TEST_CASE(test_module_eeprom_sfp_8472_cal_round),
+		TEST_CASE(test_module_eeprom_sfp_8472_status),
 		TEST_CASE(test_module_eeprom_qsfp_8636),
 		TEST_CASE(test_module_eeprom_qsfp_8636_thresholds),
 		TEST_CASE(test_module_eeprom_qsfp_8636_signals_not_implemented),
-- 
2.47.3

