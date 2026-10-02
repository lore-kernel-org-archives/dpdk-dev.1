Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEB0CA5FDD
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 12:53:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3349242E60;
	Fri,  2 Oct 2026 14:53:05 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 6BAA74026C;
 Fri,  2 Oct 2026 14:53:03 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id D6EB8877AF;
 Fri, 02 Oct 2026 15:53:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id fqkvm6Ydb8c0-yQ3DGSLm; 
 Fri, 02 Oct 2026 15:53:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790945582; bh=FBV3ZcC3ybebWrHZu8jJjTT5nvk13ak2vqS16I9iYyU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dGhtwogJ0Y0vLL9iUVlbAWCtcyAtU0yiThIbCij41YWzix/MhMI1w1Jlkf3hGaFnS
 ioelJms29GPY00SJBjGHFFcsEkp2M2w3L6PHQoPAViHGu0dlQ8wAKqpu/A5lSYugSg
 UymDvKAPcNSbv+e7VNGt9LvLHXab6YQUhNl/bWgc=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 1/3] ethdev: fix SFF-8472 calibration overflow
Date: Fri,  2 Oct 2026 14:52:35 +0200
Message-ID: <45fecd4b48c5f0934851c638802d9fbfd6e7181f.1790935333.git.roma55592@yandex.ru>
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

With external calibration, SFF-8472 computes temperature, voltage,
TX bias and TX power as slope * x + offset, where the slope goes up
to 255.996 and the offset is a signed 16-bit integer.

The decoder multiplied the 16-bit fields in place by the slope and
then added the offset. A result out of the field range is undefined
behavior for the float to integer conversion, and an integer sum
below zero wraps around: a bias reading of 100 with an offset of
-1000 was reported as 129.272 mA.

Compute the formula in double precision and saturate the result
to the range of the field, as already done for the RX power.

Fixes: 0caf7f376b08 ("ethdev: support SFF-8472 module telemetry")
Cc: stable@dpdk.org

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 lib/ethdev/sff_8472.c | 51 ++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index 3c73a829a8..8cd41161e3 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -186,6 +186,25 @@ static float befloattoh(const uint8_t *source)
 	return converter.dst;
 }
 
+/* Calibrated values are stored in 16-bit fields, saturate the out of range ones */
+static uint16_t sff_8472_cal_to_u16(double value)
+{
+	if (!(value > 0))
+		return 0;
+	if (value >= UINT16_MAX)
+		return UINT16_MAX;
+	return value;
+}
+
+static int16_t sff_8472_cal_to_s16(double value)
+{
+	if (value <= INT16_MIN)
+		return INT16_MIN;
+	if (value >= INT16_MAX)
+		return INT16_MAX;
+	return value;
+}
+
 static void sff_8472_calibration(const uint8_t *data, struct sff_diags *sd)
 {
 	unsigned long i;
@@ -195,17 +214,21 @@ static void sff_8472_calibration(const uint8_t *data, struct sff_diags *sd)
 	/* Calibration should occur for all values (threshold and current) */
 	for (i = 0; i < RTE_DIM(sd->bias_cur); ++i) {
 		/*
-		 * Apply calibration formula 1 (Temp., Voltage, Bias, Tx Power)
+		 * Apply calibration formula 1 (Temp., Voltage, Bias, Tx Power):
+		 * slope * x + offset
 		 */
-		sd->bias_cur[i]    *= A2_OFFSET_TO_SLP(SFF_A2_CAL_TXI_SLP);
-		sd->tx_power[i]    *= A2_OFFSET_TO_SLP(SFF_A2_CAL_TXPWR_SLP);
-		sd->sfp_voltage[i] *= A2_OFFSET_TO_SLP(SFF_A2_CAL_V_SLP);
-		sd->sfp_temp[i]    *= A2_OFFSET_TO_SLP(SFF_A2_CAL_T_SLP);
-
-		sd->bias_cur[i]    += A2_OFFSET_TO_OFF(SFF_A2_CAL_TXI_OFF);
-		sd->tx_power[i]    += A2_OFFSET_TO_OFF(SFF_A2_CAL_TXPWR_OFF);
-		sd->sfp_voltage[i] += A2_OFFSET_TO_OFF(SFF_A2_CAL_V_OFF);
-		sd->sfp_temp[i]    += A2_OFFSET_TO_OFF(SFF_A2_CAL_T_OFF);
+		sd->bias_cur[i] = sff_8472_cal_to_u16(sd->bias_cur[i] *
+			A2_OFFSET_TO_SLP(SFF_A2_CAL_TXI_SLP) +
+			A2_OFFSET_TO_OFF(SFF_A2_CAL_TXI_OFF));
+		sd->tx_power[i] = sff_8472_cal_to_u16(sd->tx_power[i] *
+			A2_OFFSET_TO_SLP(SFF_A2_CAL_TXPWR_SLP) +
+			A2_OFFSET_TO_OFF(SFF_A2_CAL_TXPWR_OFF));
+		sd->sfp_voltage[i] = sff_8472_cal_to_u16(sd->sfp_voltage[i] *
+			A2_OFFSET_TO_SLP(SFF_A2_CAL_V_SLP) +
+			A2_OFFSET_TO_OFF(SFF_A2_CAL_V_OFF));
+		sd->sfp_temp[i] = sff_8472_cal_to_s16(sd->sfp_temp[i] *
+			A2_OFFSET_TO_SLP(SFF_A2_CAL_T_SLP) +
+			A2_OFFSET_TO_OFF(SFF_A2_CAL_T_OFF));
 
 		/*
 		 * Apply calibration formula 2 (Rx Power only):
@@ -219,13 +242,7 @@ static void sff_8472_calibration(const uint8_t *data, struct sff_diags *sd)
 		rx_power = rx_power * rx_reading + A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR1);
 		rx_power = rx_power * rx_reading + A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR0);
 
-		/* the result is stored in 0.1 uW units, out of range is not representable */
-		if (!(rx_power > 0))
-			sd->rx_power[i] = 0;
-		else if (rx_power >= UINT16_MAX)
-			sd->rx_power[i] = UINT16_MAX;
-		else
-			sd->rx_power[i] = rx_power;
+		sd->rx_power[i] = sff_8472_cal_to_u16(rx_power);
 	}
 }
 
-- 
2.47.3

