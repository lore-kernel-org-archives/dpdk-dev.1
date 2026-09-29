Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED741CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE0D240EDC;
	Tue, 29 Sep 2026 09:08:15 +0200 (CEST)
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [178.154.239.82])
 by mails.dpdk.org (Postfix) with ESMTP id ECE584042C
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:08:10 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward502a.mail.yandex.net (postfix) with ESMTPS id 768C3848E3;
 Tue, 29 Sep 2026 10:08:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id a7cWxixi4iE0-1yxHxVoS; 
 Tue, 29 Sep 2026 10:08:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790665690; bh=b1N4cAXQ87nsx99m5cJm7+YV1G26gJlnplNkHKi7UwA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=eK+VvumyxCiSXz1VDH6frseXAEIH3HHM4LVZYtQHLzY3ALVizdK/9h4V4mhwtFMja
 uB477h08ZefTzlfjsiJFAxphvSjJJVWujGUxl39pWBSw8XxMbgGBes6aK+qMc6+8+t
 wdmtEWnv8gF2Jd1+rJGBUQLmbFGYTyT6dUyfypWI=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 3/6] ethdev: check module EEPROM length before decoding
Date: Tue, 29 Sep 2026 09:07:31 +0200
Message-ID: <20260929070734.1106134-4-roma55592@yandex.ru>
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

The SFF-8079 and SFF-8472 decoders do not receive the buffer length
and assume it is large enough for the module type.
This holds for the telemetry command, which allocates the length
reported by the driver, but not for other callers.

Move the type dispatch into a common internal function which checks
the minimal length for each type before decoding:
- SFF-8079 and SFF-8436/8636 require at least 256 bytes,
- SFF-8472 requires 256 bytes for the base information,
  and the diagnostics (page A2h) are decoded only if 512 bytes
  are available.

Also decode the SFF-8636 thresholds and alarm flags when the data
is longer than 640 bytes, not only when it is exactly 640 bytes.

This is a preparation for exposing the decoders to applications.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v3: SFF-8636 fix moved to patch 1, decode thresholds for length >= 640

 lib/ethdev/sff_8636.c      |  2 +-
 lib/ethdev/sff_common.c    | 31 +++++++++++++++++++++++++++++++
 lib/ethdev/sff_common.h    |  8 ++++++++
 lib/ethdev/sff_telemetry.c | 21 +++++----------------
 4 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/lib/ethdev/sff_8636.c b/lib/ethdev/sff_8636.c
index bbd00cc0ca..40e5404caf 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/ethdev/sff_8636.c
@@ -656,7 +656,7 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct s
 	 * If pagging support exists, then supports_alarms is marked as 1
 	 */
 
-	if (eeprom_len == RTE_ETH_MODULE_SFF_8636_MAX_LEN) {
+	if (eeprom_len >= RTE_ETH_MODULE_SFF_8636_MAX_LEN) {
 		if (!(data[SFF_8636_STATUS_2_OFFSET] &
 					SFF_8636_STATUS_PAGE_3_PRESENT)) {
 			sd.supports_alarms = 1;
diff --git a/lib/ethdev/sff_common.c b/lib/ethdev/sff_common.c
index 1b48c0f6ea..a36bf83026 100644
--- a/lib/ethdev/sff_common.c
+++ b/lib/ethdev/sff_common.c
@@ -4,6 +4,7 @@
  * common utilities for SFF-8436/8636 and SFF-8472/8079
  */
 
+#include <errno.h>
 #include <math.h>
 
 #include "sff_common.h"
@@ -14,6 +15,36 @@ void sff_output_field(struct sff_output *d, const char *name_str,
 	d->field_cb(name_str, value_str, d->arg);
 }
 
+int sff_decode_module_eeprom(uint32_t type, const uint8_t *data, uint32_t length,
+			     struct sff_output *d)
+{
+	switch (type) {
+	case RTE_ETH_MODULE_SFF_8079:
+		if (length < RTE_ETH_MODULE_SFF_8079_LEN)
+			return -EINVAL;
+		sff_8079_show_all(data, d);
+		break;
+	case RTE_ETH_MODULE_SFF_8472:
+		if (length < RTE_ETH_MODULE_SFF_8079_LEN)
+			return -EINVAL;
+		sff_8079_show_all(data, d);
+		/* diagnostics are in the second page (A2h) */
+		if (length >= RTE_ETH_MODULE_SFF_8472_LEN)
+			sff_8472_show_all(data, d);
+		break;
+	case RTE_ETH_MODULE_SFF_8436:
+	case RTE_ETH_MODULE_SFF_8636:
+		if (length < RTE_ETH_MODULE_SFF_8636_LEN)
+			return -EINVAL;
+		sff_8636_show_all(data, length, d);
+		break;
+	default:
+		return -ENOTSUP;
+	}
+
+	return 0;
+}
+
 double sff_convert_mw_to_dbm(double mw)
 {
 	return (10. * log10(mw / 1000.)) + 30.;
diff --git a/lib/ethdev/sff_common.h b/lib/ethdev/sff_common.h
index 06f5a35e8e..6435f4d6f5 100644
--- a/lib/ethdev/sff_common.h
+++ b/lib/ethdev/sff_common.h
@@ -34,6 +34,14 @@ void sff_8472_show_all(const uint8_t *data, struct sff_output *d);
 /* SFF-8636 Optics diagnostics */
 void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d);
 
+/*
+ * Decode module EEPROM of the given type (RTE_ETH_MODULE_SFF_*).
+ * Returns 0 on success, -EINVAL if the data is too short for the type,
+ * -ENOTSUP if the type is unknown.
+ */
+int sff_decode_module_eeprom(uint32_t type, const uint8_t *data, uint32_t length,
+			     struct sff_output *d);
+
 #define SFF_8024_ID_OFFSET			0x00
 #define SFF_8024_ID_UNKNOWN			0x00
 #define SFF_8024_ID_GBIC			0x01
diff --git a/lib/ethdev/sff_telemetry.c b/lib/ethdev/sff_telemetry.c
index 06a8122367..46533a9fc5 100644
--- a/lib/ethdev/sff_telemetry.c
+++ b/lib/ethdev/sff_telemetry.c
@@ -100,23 +100,12 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 		return;
 	}
 
-	switch (minfo.type) {
-	/* parsing module EEPROM data base on different module type */
-	case RTE_ETH_MODULE_SFF_8079:
-		sff_8079_show_all(einfo.data, &out);
-		break;
-	case RTE_ETH_MODULE_SFF_8472:
-		sff_8079_show_all(einfo.data, &out);
-		sff_8472_show_all(einfo.data, &out);
-		break;
-	case RTE_ETH_MODULE_SFF_8436:
-	case RTE_ETH_MODULE_SFF_8636:
-		sff_8636_show_all(einfo.data, einfo.length, &out);
-		break;
-	default:
+	ret = sff_decode_module_eeprom(minfo.type, einfo.data, einfo.length, &out);
+	if (ret == -ENOTSUP)
 		RTE_ETHDEV_LOG_LINE(NOTICE, "Unsupported module type: %u", minfo.type);
-		break;
-	}
+	else if (ret != 0)
+		RTE_ETHDEV_LOG_LINE(ERR, "Port %u module EEPROM is too short: %u bytes",
+			port_id, einfo.length);
 
 	free(einfo.data);
 }
-- 
2.47.3

