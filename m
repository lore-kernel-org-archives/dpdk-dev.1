Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02844606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Wjkh07Cd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D76140A6C;
	Thu, 29 Oct 2026 19:15:32 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTPS id AC0A140151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 19:15:28 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-63
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 3E94E80E86;
 Thu, 29 Oct 2026 21:15:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 EFo9OWThdqM0-qEopfodx; Thu, 29 Oct 2026 21:15:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793297728; bh=LnCXtLx2f5fIdvMPJuPu6oe0oB58nSvZ/PcwONCrQO0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Wjkh07CdZUZLH/Lpve++B+VeIGLQiDAayuaERJknDQ7c/IsAyjNJ40kuClaejp3/E
 yCQ/sVvRTVOhJHtVGVoWDzTrB0wogTlX4/DE9vXw5pCOO/y/nJf4J6XFI7jTrrEmhS
 W3BIllhBWDVnhFZIxIsPlYCDYnyQo6OZP4+9cAcM=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org, aman.deep.singh@intel.com
Subject: [PATCH 3/4] app/testpmd: decode module EEPROM with transceiver library
Date: Thu, 29 Oct 2026 20:15:10 +0200
Message-ID: <20261029181511.1736967-4-roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029181511.1736967-1-roma55592@yandex.ru>
References: <20261014071245.2323258-1-roma55592@yandex.ru>
 <20261029181511.1736967-1-roma55592@yandex.ru>
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

Call rte_transceiver_decode() directly instead of the ethdev
wrapper rte_eth_module_eeprom_parse(), which is going to be removed.
The module type reported by ethdev has the same values as the
transceiver library ones.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test-pmd/config.c    | 3 ++-
 app/test-pmd/meson.build | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index ec348cf854..559c823a65 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -55,6 +55,7 @@
 #include <rte_gro.h>
 #endif
 #include <rte_hexdump.h>
+#include <rte_transceiver.h>
 
 #include "testpmd.h"
 #include "cmdline_mtr.h"
@@ -1244,7 +1245,7 @@ port_module_eeprom_decode_display(portid_t port_id)
 
 	printf("Port %u module EEPROM (type 0x%x, %u bytes):\n",
 		port_id, minfo.type, einfo.length);
-	ret = rte_eth_module_eeprom_parse(minfo.type, einfo.data, einfo.length,
+	ret = rte_transceiver_decode(minfo.type, einfo.data, einfo.length,
 			port_module_eeprom_field_print, NULL);
 	if (ret == -ENOTSUP)
 		fprintf(stderr, "Unsupported module type: 0x%x\n", minfo.type);
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index 83163a5406..3b726164c2 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -34,7 +34,7 @@ if dpdk_conf.has('RTE_HAS_JANSSON')
     ext_deps += jansson_dep
 endif
 
-deps += ['ethdev', 'cmdline', 'pci']
+deps += ['ethdev', 'cmdline', 'pci', 'transceiver']
 if dpdk_conf.has('RTE_CRYPTO_SCHEDULER')
     deps += 'crypto_scheduler'
 endif
-- 
2.47.3

