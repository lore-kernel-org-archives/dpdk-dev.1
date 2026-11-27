Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD9606A31E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=Rs0wD4oM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1007140671;
	Fri, 27 Nov 2026 21:31:10 +0100 (CET)
Received: from forward501e.mail.yandex.net (forward501e.mail.yandex.net
 [93.77.172.86]) by mails.dpdk.org (Postfix) with ESMTPS id 2574C40615
 for <dev@dpdk.org>; Fri, 27 Nov 2026 21:31:08 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-53
 (mail-nwsmtp-smtp-production-main-53.yp-c.yandex.net)
 by forward501e.mail.yandex.net (postfix) with ESMTPS id 80625C00CC;
 Fri, 27 Nov 2026 23:31:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-53 with ESMTPSA id
 sUqcKleZaiE0-BceWLub2; Fri, 27 Nov 2026 23:31:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1795811467; bh=bf9A1Np8KAA/ajVCEkBzn4xO/pIgxTakUGde2HxflG4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Rs0wD4oMNcs62xQqsH7iRxodhDSVlndkcnJIRsroCh1OAZoVKeqT8npOP81hVrZ3g
 ub3qvpCJpUSjToEuG1NwTXSnBiL1Ns5kGSegvwMiRL08dYLLgZ/isDCNdU/cSIhc43
 ZtaqONTeDaArR8qz9djCvDsRwguAXnOjwbvCv5t0=
Authentication-Results: mail-nwsmtp-smtp-production-main-53;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 3/4] app/testpmd: decode module EEPROM with transceiver
 library
Date: Fri, 27 Nov 2026 22:30:52 +0200
Message-ID: <1d099f5e05b3c31e1374902e40607daad0ee8bdf.1795810230.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795810230.git.roma55592@yandex.ru>
References: <20261029181511.1736967-1-roma55592@yandex.ru>
 <cover.1795810230.git.roma55592@yandex.ru>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
index 8986d6998f..a2810c81bd 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -55,6 +55,7 @@
 #include <rte_gro.h>
 #endif
 #include <rte_hexdump.h>
+#include <rte_transceiver.h>
 
 #include "testpmd.h"
 #include "cmdline_mtr.h"
@@ -1249,7 +1250,7 @@ port_module_eeprom_decode_display(portid_t port_id)
 
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

