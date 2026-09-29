Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC737CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB3B409FA;
	Tue, 29 Sep 2026 09:08:11 +0200 (CEST)
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net
 [178.154.239.81])
 by mails.dpdk.org (Postfix) with ESMTP id 9F72C40276;
 Tue, 29 Sep 2026 09:08:08 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward501a.mail.yandex.net (postfix) with ESMTPS id 5197F8205D;
 Tue, 29 Sep 2026 10:08:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id a7cWxixi4iE0-uYClgQYp; 
 Tue, 29 Sep 2026 10:08:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790665688; bh=dxJ/9WDtSNGLM8yBYV8YXNgoYe9HFIdQqqvz0JRObpQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=r1zFve55GgCPVEj+5ZyssDOyDVpIfDEqvrHEECpg8EhPTAUkX8A76GtqhWfxjU3cB
 Q1fTdTpfs5zXs3WigAfj5l2M8G5cxELAywrZ54wJ4NFsV77orVzdvMI/AnBdnb16Se
 /faQ+akqn5WYUDGC8vxpjY0DOcIUFLLIvkl2xBFk=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: [PATCH v3 1/6] ethdev: fix out-of-bounds read of SFF-8636 thresholds
Date: Tue, 29 Sep 2026 09:07:29 +0200
Message-ID: <20260929070734.1106134-2-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929070734.1106134-1-roma55592@yandex.ru>
References: <20260927112041.775972-1-roma55592@yandex.ru>
 <20260929070734.1106134-1-roma55592@yandex.ru>
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

The SFF-8636 decoder reads the alarm and warning thresholds
from page 03h (offsets 0x200 to 0x247) unconditionally,
but they are printed only if the EEPROM data is 640 bytes long.

The telemetry command /ethdev/module_eeprom allocates exactly
the length reported by the driver, and several drivers report
256 bytes for QSFP modules, for example i40e for SFF-8436
and bnxt for flat memory QSFP28.
On such ports, the command reads past the end of the heap buffer.

Read the thresholds only when they are going to be printed.

Fixes: c42754fd581a ("ethdev: support SFF-8636 module telemetry")
Cc: stable@dpdk.org

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v3: new patch, split from the length checks to be backported

 .mailmap              |  1 +
 lib/ethdev/sff_8636.c | 52 ++++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

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
diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index 6b65f47efe..9dfff41a3b 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -600,34 +600,36 @@ static void sff_8636_dom_parse(const uint8_t *data, struct sff_diags *sd)
 {
 	int i = 0;
 
-	/* Monitoring Thresholds for Alarms and Warnings */
 	sd->sfp_voltage[SFF_MCURR] = SFF_OFFSET_TO_U16(SFF_8636_VCC_CURR);
-	sd->sfp_voltage[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HALRM);
-	sd->sfp_voltage[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LALRM);
-	sd->sfp_voltage[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HWARN);
-	sd->sfp_voltage[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LWARN);
-
 	sd->sfp_temp[SFF_MCURR] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_CURR);
-	sd->sfp_temp[SFF_HALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HALRM);
-	sd->sfp_temp[SFF_LALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LALRM);
-	sd->sfp_temp[SFF_HWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HWARN);
-	sd->sfp_temp[SFF_LWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LWARN);
-
-	sd->bias_cur[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HALRM);
-	sd->bias_cur[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LALRM);
-	sd->bias_cur[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HWARN);
-	sd->bias_cur[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LWARN);
-
-	sd->tx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HALRM);
-	sd->tx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LALRM);
-	sd->tx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HWARN);
-	sd->tx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LWARN);
-
-	sd->rx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HALRM);
-	sd->rx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LALRM);
-	sd->rx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HWARN);
-	sd->rx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LWARN);
 
+	/* Monitoring Thresholds for Alarms and Warnings are in page 03h */
+	if (sd->supports_alarms) {
+		sd->sfp_voltage[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HALRM);
+		sd->sfp_voltage[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LALRM);
+		sd->sfp_voltage[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_HWARN);
+		sd->sfp_voltage[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_VCC_LWARN);
+
+		sd->sfp_temp[SFF_HALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HALRM);
+		sd->sfp_temp[SFF_LALRM] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LALRM);
+		sd->sfp_temp[SFF_HWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_HWARN);
+		sd->sfp_temp[SFF_LWARN] = SFF_8636_OFFSET_TO_TEMP(SFF_8636_TEMP_LWARN);
+
+		sd->bias_cur[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HALRM);
+		sd->bias_cur[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LALRM);
+		sd->bias_cur[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_HWARN);
+		sd->bias_cur[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_BIAS_LWARN);
+
+		sd->tx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HALRM);
+		sd->tx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LALRM);
+		sd->tx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_HWARN);
+		sd->tx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_TX_PWR_LWARN);
+
+		sd->rx_power[SFF_HALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HALRM);
+		sd->rx_power[SFF_LALRM] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LALRM);
+		sd->rx_power[SFF_HWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_HWARN);
+		sd->rx_power[SFF_LWARN] = SFF_OFFSET_TO_U16(SFF_8636_RX_PWR_LWARN);
+	}
 
 	/* Channel Specific Data */
 	for (i = 0; i < SFF_MAX_CHANNEL_NUM; i++) {
-- 
2.47.3

