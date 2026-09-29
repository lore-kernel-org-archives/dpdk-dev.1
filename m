Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6568DCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 17:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB780402A2;
	Tue, 29 Sep 2026 19:22:52 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [37.230.175.128])
 by mails.dpdk.org (Postfix) with ESMTP id 1D74E4026E;
 Tue, 29 Sep 2026 19:22:51 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4021:0:640:30fc:0])
 by forward500b.mail.yandex.net (postfix) with ESMTPS id 7062BC0123;
 Tue, 29 Sep 2026 20:22:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id CMmjX34iT4Y0-Rq5GVjVn; 
 Tue, 29 Sep 2026 20:22:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790702570; bh=E591UiPInY6QQajUUFvGUHIIdP7kUjNl+enCivC8cqI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aQgng3r6uK6M+oZCgATzzEWw10AV/9aWLbdQp+z+n5at2HacDPd/ueO+IInzTXA/Z
 tGwlxmShnlLq7sw6Ktn2MNKtR47hs8MiKx+DhSN1iw4FbYnsyJ+hu4YQQSikKRbQY6
 iqRF2uLqtBds0zUM90Y9+NYNOFvrrJRM5emdzFNw=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH 1/2] ethdev: fix SFF-8472 external Rx power calibration
Date: Tue, 29 Sep 2026 19:22:09 +0200
Message-ID: <20260929172210.1212967-2-roma55592@yandex.ru>
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

With external calibration, SFF-8472 defines the received power
as a fourth order polynomial of the raw reading x:

  RX_PWR(4) * x^4 + RX_PWR(3) * x^3 + RX_PWR(2) * x^2 +
  RX_PWR(1) * x + RX_PWR(0)

The decoder computed RX_PWR(0) + x * (RX_PWR(1) + RX_PWR(2) + RX_PWR(3))
and ignored RX_PWR(4), so the reported power was wrong for modules
using the higher order coefficients.

Evaluate the polynomial in double precision and clamp the result
to the 16-bit range of the stored value, as converting an out of range
floating point value to an integer is undefined behavior.

Fixes: 0caf7f376b08 ("ethdev: support SFF-8472 module telemetry")
Cc: stable@dpdk.org

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 lib/ethdev/sff_8472.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/lib/ethdev/sff_8472.c b/lib/ethdev/sff_8472.c
index cdb6ef1f7e..3c73a829a8 100644
--- a/lib/ethdev/sff_8472.c
+++ b/lib/ethdev/sff_8472.c
@@ -189,7 +189,8 @@ static float befloattoh(const uint8_t *source)
 static void sff_8472_calibration(const uint8_t *data, struct sff_diags *sd)
 {
 	unsigned long i;
-	uint16_t rx_reading;
+	double rx_reading;
+	double rx_power;
 
 	/* Calibration should occur for all values (threshold and current) */
 	for (i = 0; i < RTE_DIM(sd->bias_cur); ++i) {
@@ -207,16 +208,24 @@ static void sff_8472_calibration(const uint8_t *data, struct sff_diags *sd)
 		sd->sfp_temp[i]    += A2_OFFSET_TO_OFF(SFF_A2_CAL_T_OFF);
 
 		/*
-		 * Apply calibration formula 2 (Rx Power only)
+		 * Apply calibration formula 2 (Rx Power only):
+		 * RX_PWR(4) * x^4 + RX_PWR(3) * x^3 + RX_PWR(2) * x^2 +
+		 * RX_PWR(1) * x + RX_PWR(0)
 		 */
 		rx_reading = sd->rx_power[i];
-		sd->rx_power[i]    = A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR0);
-		sd->rx_power[i]    += rx_reading *
-			A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR1);
-		sd->rx_power[i]    += rx_reading *
-			A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR2);
-		sd->rx_power[i]    += rx_reading *
-			A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR3);
+		rx_power = A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR4);
+		rx_power = rx_power * rx_reading + A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR3);
+		rx_power = rx_power * rx_reading + A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR2);
+		rx_power = rx_power * rx_reading + A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR1);
+		rx_power = rx_power * rx_reading + A2_OFFSET_TO_RXPWRx(SFF_A2_CAL_RXPWR0);
+
+		/* the result is stored in 0.1 uW units, out of range is not representable */
+		if (!(rx_power > 0))
+			sd->rx_power[i] = 0;
+		else if (rx_power >= UINT16_MAX)
+			sd->rx_power[i] = UINT16_MAX;
+		else
+			sd->rx_power[i] = rx_power;
 	}
 }
 
-- 
2.47.3

