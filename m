Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBA606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=CqWDo+Fu
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 366B1406BB;
	Thu, 29 Oct 2026 19:20:52 +0100 (CET)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTPS id 5D863406B6
 for <dev@dpdk.org>; Thu, 29 Oct 2026 19:20:48 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-45
 (mail-nwsmtp-smtp-production-main-45.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:fbcb:0:640:9ab5:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 973DC8077B;
 Thu, 29 Oct 2026 21:20:47 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-45 with ESMTPSA id
 aKoGkwTghOs0-uoj9mlRH; Thu, 29 Oct 2026 21:20:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793298047; bh=0GFzKzELe27+h3C819B7/pLMaj0IVHA/x1dy6/VZSW8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=CqWDo+FuiqWvm4uwDbF70SiSDm7C/Uos8F3oJBCGX8JkaEnwSxlM1s6Eo8AnLar5n
 jhydJ5tzDcSNSxWT3uHnDM8Sm9sW3dVBHlFWUyCgS2F+t+fLJ0Hgq57P1LdmPfJNSw
 jWYVQ2OKn5BBoluB64dgLO93nKGPsJjmm+OSWVOc=
Authentication-Results: mail-nwsmtp-smtp-production-main-45;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: reshma.pattan@intel.com, stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 2/2] app/procinfo: add option to decode module EEPROM
Date: Thu, 29 Oct 2026 20:20:33 +0200
Message-ID: <20261029182033.1738436-3-roma55592@yandex.ru>
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

The --show-module-eeprom option only prints a hexdump of the
pluggable module EEPROM, which has to be decoded by hand against
the SFF specifications.

Add an optional "decode" value, --show-module-eeprom=decode,
to print the fields decoded by the transceiver library,
such as the vendor, the transceiver type and the digital
diagnostics, as the testpmd command "show port <port_id>
module_eeprom decode" does. Without the value, the hexdump
is printed as before.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/proc-info/main.c           | 36 +++++++++++++++++++++++++++++++---
 app/proc-info/meson.build      |  2 +-
 doc/guides/tools/proc_info.rst |  9 ++++++---
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index d918a0a3c8..da4c3afb3d 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -39,6 +39,7 @@
 #include <rte_cryptodev.h>
 #include <rte_tm.h>
 #include <rte_hexdump.h>
+#include <rte_transceiver.h>
 #include <rte_version.h>
 #include <rte_eventdev.h>
 
@@ -117,6 +118,8 @@ static uint32_t enable_shw_fw_version;
 static uint32_t enable_shw_rss_reta;
 /* Enable show module eeprom information. */
 static uint32_t enable_shw_module_eeprom;
+/* Decode module eeprom instead of a hexdump. */
+static uint32_t module_eeprom_decode;
 
 /* Enable dump Rx/Tx descriptor. */
 static uint32_t enable_shw_rx_desc_dump;
@@ -184,7 +187,8 @@ proc_info_usage(const char *prgname)
 		"  --version: to display DPDK version\n"
 		"  --firmware-version: to display ethdev firmware version\n"
 		"  --show-rss-reta: to display ports redirection table\n"
-		"  --show-module-eeprom: to display ports module eeprom information\n"
+		"  --show-module-eeprom[=decode]: to display ports module eeprom information, "
+			"as a hexdump or decoded\n"
 		"  --show-rx-descriptor queue_id:offset:num to display ports Rx descriptor information. "
 			"queue_id: A Rx queue identifier on this port. "
 			"offset: The offset of the descriptor starting from tail. "
@@ -445,7 +449,7 @@ proc_info_parse_args(int argc, char **argv)
 		{"version", 0, NULL, 0},
 		{"firmware-version", 0, NULL, 0},
 		{"show-rss-reta", 0, NULL, 0},
-		{"show-module-eeprom", 0, NULL, 0},
+		{"show-module-eeprom", optional_argument, NULL, 0},
 		{"show-rx-descriptor", required_argument, NULL, 1},
 		{"show-tx-descriptor", required_argument, NULL, 1},
 		{"show-edev-queue-xstats", required_argument, NULL, 0},
@@ -539,8 +543,17 @@ proc_info_parse_args(int argc, char **argv)
 					"show-rss-reta", MAX_LONG_OPT_SZ))
 				enable_shw_rss_reta = 1;
 			else if (!strncmp(long_option[option_index].name,
-					"show-module-eeprom", MAX_LONG_OPT_SZ))
+					"show-module-eeprom", MAX_LONG_OPT_SZ)) {
 				enable_shw_module_eeprom = 1;
+				if (optarg != NULL) {
+					if (strcmp(optarg, "decode") != 0) {
+						fprintf(stderr, "Invalid show-module-eeprom value: %s\n",
+							optarg);
+						return -1;
+					}
+					module_eeprom_decode = 1;
+				}
+			}
 			else if (!strncmp(long_option[option_index].name,
 					"edev-dump-xstats", MAX_LONG_OPT_SZ)) {
 				int ret = parse_eventdev_dump_xstats_params(optarg);
@@ -1850,6 +1863,13 @@ show_port_rss_reta_info(void)
 	}
 }
 
+static void
+module_eeprom_field_print(const char *name, const char *value,
+		__rte_unused void *arg)
+{
+	printf("\t%-41s : %s\n", name, value);
+}
+
 static void
 show_module_eeprom_info(void)
 {
@@ -1891,6 +1911,16 @@ show_module_eeprom_info(void)
 			continue;
 		}
 
+		if (module_eeprom_decode) {
+			ret = rte_transceiver_decode(module_info.type,
+					eeprom_info.data, eeprom_info.length,
+					module_eeprom_field_print, NULL);
+			if (ret != 0)
+				fprintf(stderr, "Port %u module EEPROM decode error: %s\n",
+					i, strerror(-ret));
+			continue;
+		}
+
 		rte_hexdump(stdout, "hexdump", eeprom_info.data,
 			    eeprom_info.length);
 		printf("Finish -- Port: %u MODULE EEPROM length: %d bytes\n",
diff --git a/app/proc-info/meson.build b/app/proc-info/meson.build
index 316253cd5d..ee33615dfc 100644
--- a/app/proc-info/meson.build
+++ b/app/proc-info/meson.build
@@ -8,7 +8,7 @@ if is_windows
 endif
 
 sources = files('main.c')
-deps += ['ethdev', 'security', 'eventdev']
+deps += ['ethdev', 'security', 'eventdev', 'transceiver']
 if dpdk_conf.has('RTE_LIB_METRICS')
     deps += 'metrics'
 endif
diff --git a/doc/guides/tools/proc_info.rst b/doc/guides/tools/proc_info.rst
index 0a54f20f8c..36f8000408 100644
--- a/doc/guides/tools/proc_info.rst
+++ b/doc/guides/tools/proc_info.rst
@@ -21,7 +21,7 @@ The application has a number of command line options:
    --stats-reset | --xstats-reset] [ --show-port | --show-tm | --show-crypto |
    --show-ring[=name] | --show-mempool[=name] | --iter-mempool=name |
    --show-port-private | --version | --firmware-version | --show-rss-reta |
-   --show-module-eeprom | --show-rx-descriptor queue_id:offset:num |
+   --show-module-eeprom[=decode] | --show-rx-descriptor queue_id:offset:num |
    --show-tx-descriptor queue_id:offset:num | --show-edev-queue-xstats=queue_num:evdev_id |
    --show-edev-port-xstats=port_num :evdev_id | --edev-dump-xstats=evdev_id |
    --edev-reset-xstats=evdev_id | --show-edev-device-xstats=evdev_id]
@@ -87,8 +87,11 @@ The firmware-version parameter displays ethdev firmware version.
 **--show-rss-reta**
 The show-rss-reta parameter displays ports rss redirection table.
 
-**--show-module-eeprom**
-The show-module-eeprom parameter displays ports module eeprom information.
+**--show-module-eeprom[=decode]**
+The show-module-eeprom parameter displays ports module eeprom information
+as a hexdump. With the decode value, the module eeprom is decoded
+according to the SFF specifications, for example the vendor,
+the transceiver type and the digital diagnostics.
 
 **--show-rx-descriptor queue_id:offset:num**
 The show-rx-descriptor parameter displays ports Rx descriptor information
-- 
2.47.3

