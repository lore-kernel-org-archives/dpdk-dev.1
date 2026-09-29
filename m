Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67B1CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 17:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A45F642E52;
	Tue, 29 Sep 2026 19:22:56 +0200 (CEST)
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net
 [37.230.175.129])
 by mails.dpdk.org (Postfix) with ESMTP id AC3BE402D2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 19:22:52 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4021:0:640:30fc:0])
 by forward501b.mail.yandex.net (postfix) with ESMTPS id 5948580872;
 Tue, 29 Sep 2026 20:22:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id CMmjX34iT4Y0-ie0VEaCl; 
 Tue, 29 Sep 2026 20:22:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790702571; bh=/9GfHD3GnN2D+vwxB7cqRg6B4i5d4SQZTjafcnEouBw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Vp12MOmlJVg3/IS51y4YJB2Y+Nv1g7BDc4yahiYJUEPuKSUI32R/jbX/pR3r4afpA
 W9HZRbFhXFWnERG369Lpdycai3IrRaI+S9rFOS6xcYfIDwsTlw+lIfEsyp18BZkvpT
 ZpnLg6jjNNXr2WGRMssy9uTa34JhRR0fX4nfEouU=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 2/2] test: check SFF-8472 external Rx power calibration
Date: Tue, 29 Sep 2026 19:22:10 +0200
Message-ID: <20260929172210.1212967-3-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929172210.1212967-1-roma55592@yandex.ru>
References: <20260929172210.1212967-1-roma55592@yandex.ru>
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

Add a test case with all the SFF-8472 Rx power calibration
coefficients set, so that the whole fourth order polynomial
is checked, including RX_PWR(4).

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/test_ethdev_module_eeprom.c | 37 ++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/app/test/test_ethdev_module_eeprom.c b/app/test/test_ethdev_module_eeprom.c
index d76bdc0060..b07a18aa06 100644
--- a/app/test/test_ethdev_module_eeprom.c
+++ b/app/test/test_ethdev_module_eeprom.c
@@ -269,6 +269,42 @@ test_module_eeprom_sfp_8472_ext_cal_unaligned(void)
 	return TEST_SUCCESS;
 }
 
+static void
+put_be_float(uint8_t *data, unsigned int offset, uint32_t bits)
+{
+	data[offset] = bits >> 24;
+	data[offset + 1] = (bits >> 16) & 0xff;
+	data[offset + 2] = (bits >> 8) & 0xff;
+	data[offset + 3] = bits & 0xff;
+}
+
+static int
+test_module_eeprom_sfp_8472_rx_power_polynomial(void)
+{
+	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
+	uint8_t *a2 = data + RTE_ETH_MODULE_SFF_8079_LEN;
+
+	fill_sfp(data);
+	/* diagnostics implemented, externally calibrated, average RX power */
+	data[92] = 0x58;
+	a2[76] = 1;	/* TX bias slope */
+	a2[80] = 1;	/* TX power slope */
+	a2[84] = 1;	/* temperature slope */
+	a2[88] = 1;	/* voltage slope */
+	put_u16(a2, 104, 10);	/* raw RX power x = 10 */
+	/* 0.125 x^4 + 0.25 x^3 + 0.5 x^2 + x = 1250 + 250 + 50 + 10 = 1560 */
+	put_be_float(a2, 56, 0x3e000000);	/* RX_PWR(4) = 0.125 */
+	put_be_float(a2, 60, 0x3e800000);	/* RX_PWR(3) = 0.25 */
+	put_be_float(a2, 64, 0x3f000000);	/* RX_PWR(2) = 0.5 */
+	put_be_float(a2, 68, 0x3f800000);	/* RX_PWR(1) = 1.0 */
+	put_be_float(a2, 72, 0);		/* RX_PWR(0) = 0 */
+
+	TEST_ASSERT_SUCCESS(parse(RTE_ETH_MODULE_SFF_8472, data, sizeof(data)),
+		"Failed to parse externally calibrated SFF-8472 data");
+	CHECK_FIELD("Receiver signal average optical power", "0.1560 mW / -8.07 dBm");
+	return TEST_SUCCESS;
+}
+
 static int
 test_module_eeprom_invalid(void)
 {
@@ -318,6 +354,7 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_sfp_8472),
 		TEST_CASE(test_module_eeprom_sfp_8472_short),
 		TEST_CASE(test_module_eeprom_sfp_8472_ext_cal_unaligned),
+		TEST_CASE(test_module_eeprom_sfp_8472_rx_power_polynomial),
 		TEST_CASE(test_module_eeprom_qsfp_8636),
 		TEST_CASE(test_module_eeprom_qsfp_8636_thresholds),
 		TEST_CASE(test_module_eeprom_invalid),
-- 
2.47.3

