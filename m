Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A7CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 06:57:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE2504026D;
	Sat, 10 Oct 2026 08:57:02 +0200 (CEST)
Received: from forward104a.mail.yandex.net (forward104a.mail.yandex.net
 [51.250.124.100])
 by mails.dpdk.org (Postfix) with ESMTP id 4FEB7400EF;
 Sat, 10 Oct 2026 08:57:01 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3325:0:640:61d:0])
 by forward104a.mail.yandex.net (postfix) with ESMTPS id 955DF100004;
 Sat, 10 Oct 2026 09:57:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id uuJiaTaiOiE0-jNNYZsjk; 
 Sat, 10 Oct 2026 09:57:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791615420; bh=rFFy95ms8IInjeiqUH8ojluhREgb2ehmXqdYU8owJdQ=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Ijfx0NZlWtt2wFZe9/7DKM4/t9sV2QP2GnybFeKd6e9sEqXyV92NMeJDfMkNmHTJG
 L+LYL+jJnHoYaQIChEL7b2Yf2m7iLi3ltSLv4nL2DtxyRVsdc0ihWRCrgyVz/S5FbG
 D0eHfAvMk1LCnpqUHxqdVPjgwzKRNF38AG0ZdMoQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: reshma.pattan@intel.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH 1/2] app/procinfo: fix module EEPROM dump of multiple ports
Date: Sat, 10 Oct 2026 08:55:41 +0200
Message-ID: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
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

The --show-module-eeprom option stopped at the first port whose
module EEPROM could not be read, so a port without a module, or
a driver without the operation, hid the modules of all the next
ports. Report the error and go on with the next port, with the
port number in the message since several ports can now fail.

The EEPROM was also read into a fixed size buffer with the length
reported by the driver, without checking it. Skip the port if the
length does not fit the buffer.

Fixes: 0084463ea004 ("app/procinfo: dump module EEPROM info")
Cc: stable@dpdk.org

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/proc-info/main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 9c22fb8f01..d918a0a3c8 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -1869,9 +1869,15 @@ show_module_eeprom_info(void)
 
 		ret = rte_eth_dev_get_module_info(i, &module_info);
 		if (ret != 0) {
-			fprintf(stderr, "Module EEPROM information read error: %s\n",
-				strerror(-ret));
-			return;
+			fprintf(stderr, "Port %u module EEPROM information read error: %s\n",
+				i, strerror(-ret));
+			continue;
+		}
+
+		if (module_info.eeprom_len > sizeof(bytes_eeprom)) {
+			fprintf(stderr, "Port %u module EEPROM too long: %u bytes\n",
+				i, module_info.eeprom_len);
+			continue;
 		}
 
 		eeprom_info.offset = 0;
@@ -1880,9 +1886,9 @@ show_module_eeprom_info(void)
 
 		ret = rte_eth_dev_get_module_eeprom(i, &eeprom_info);
 		if (ret != 0) {
-			fprintf(stderr, "Module EEPROM read error: %s\n",
-				strerror(-ret));
-			return;
+			fprintf(stderr, "Port %u module EEPROM read error: %s\n",
+				i, strerror(-ret));
+			continue;
 		}
 
 		rte_hexdump(stdout, "hexdump", eeprom_info.data,
-- 
2.47.3

