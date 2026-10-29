Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88E606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=qirc1DuL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67750406B6;
	Thu, 29 Oct 2026 19:20:51 +0100 (CET)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTPS id F071640151;
 Thu, 29 Oct 2026 19:20:46 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-45
 (mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:fbcb:0:640:9ab5:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 3311581249;
 Thu, 29 Oct 2026 21:20:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45 with ESMTPSA id
 aKoGkwTghOs0-bZN2N2HS; Thu, 29 Oct 2026 21:20:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793298045; bh=rFFy95ms8IInjeiqUH8ojluhREgb2ehmXqdYU8owJdQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qirc1DuLTtdfe/Qtvf4gLOLSXTiQ4HEgTwHvpVjtbS9D+1MUy5hmwfwTVBTHnqLDZ
 1nDobIlXcIF4v5v90Ol7fg0PWVisMiBwJMAbvqcnDNP+R0IYqMh7wG8I3irdW2kJu4
 WO9Qq9gxLFkfu5kw84cMagUH5pOjGO6h30g5tjSs=
Authentication-Results: mail-nwsmtp-smtp-production-main-45;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: reshma.pattan@intel.com, stephen@networkplumber.org, thomas@monjalon.net,
 stable@dpdk.org
Subject: [PATCH v2 1/2] app/procinfo: fix module EEPROM dump of multiple ports
Date: Thu, 29 Oct 2026 20:20:32 +0200
Message-ID: <20261029182033.1738436-2-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029182033.1738436-1-roma55592@yandex.ru>
References: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
 <20261029182033.1738436-1-roma55592@yandex.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

