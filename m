Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A0CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 06:57:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE92E40431;
	Sat, 10 Oct 2026 08:57:04 +0200 (CEST)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [31.44.14.18]) by mails.dpdk.org (Postfix) with ESMTP id BDCC2400EF;
 Sat, 10 Oct 2026 08:57:01 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:3325:0:640:61d:0])
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 540CFC6739;
 Sat, 10 Oct 2026 09:57:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp)
 with ESMTPSA id uuJiaTaiOiE0-rOvE8qHg; 
 Sat, 10 Oct 2026 09:57:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791615420; bh=fb4OyU4O/R7b8vAJAc3w2YCpSrXHxFLzeJKHTZ1FzgE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=dRP5oNNiCRjkZQ+ku0kjWhzdqVOb/5vKc/wjujcn0o8++MLS93rtjqtNLNQpzT2US
 15gLE1orSXJhRqoYMRFWyfdBrcH0L3GnkB1N4OirOw4pxE3qUb6WeJ7vnOXIg8zDWr
 dxpER7PYsPMcto/u8C3edEbTgCHXzPwYfPa0ZPe4=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: reshma.pattan@intel.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH 2/2] app/procinfo: add option to decode module EEPROM
Date: Sat, 10 Oct 2026 08:55:42 +0200
Message-ID: <b9c96ea7c4ba61d6d295a5c344c0c802fa29d313.1791609796.git.roma55592@yandex.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
References: <e6d262613a145c7e850a526b03070bad38c40a92.1791609796.git.roma55592@yandex.ru>
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

The --show-module-eeprom option only prints a hexdump of the
pluggable module EEPROM, which has to be decoded by hand against
the SFF specifications.

Add an optional "decode" value, --show-module-eeprom=decode,
to print the fields decoded by rte_eth_module_eeprom_parse(),
such as the vendor, the transceiver type and the digital
diagnostics, as the testpmd command "show port <port_id>
module_eeprom decode" does. Without the value, the hexdump
is printed as before.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
Tested on a stand with testpmd as the primary process and three
net_null ports, patched locally (not part of the series) so that
port 0 has no module and ports 1-2 return an SFF-8472 image:
before patch 1/2 only port 0 was shown, after it ports 1-2 are
dumped and decoded, and an invalid value is rejected.

 app/proc-info/main.c                   | 35 +++++++++++++++++++++++---
 doc/guides/rel_notes/release_26_11.rst |  3 ++-
 doc/guides/tools/proc_info.rst         |  9 ++++---
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index d918a0a3c8..635e81c5ab 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -117,6 +117,8 @@ static uint32_t enable_shw_fw_version;
 static uint32_t enable_shw_rss_reta;
 /* Enable show module eeprom information. */
 static uint32_t enable_shw_module_eeprom;
+/* Decode module eeprom instead of a hexdump. */
+static uint32_t module_eeprom_decode;
 
 /* Enable dump Rx/Tx descriptor. */
 static uint32_t enable_shw_rx_desc_dump;
@@ -184,7 +186,8 @@ proc_info_usage(const char *prgname)
 		"  --version: to display DPDK version\n"
 		"  --firmware-version: to display ethdev firmware version\n"
 		"  --show-rss-reta: to display ports redirection table\n"
-		"  --show-module-eeprom: to display ports module eeprom information\n"
+		"  --show-module-eeprom[=decode]: to display ports module eeprom information, "
+			"as a hexdump or decoded\n"
 		"  --show-rx-descriptor queue_id:offset:num to display ports Rx descriptor information. "
 			"queue_id: A Rx queue identifier on this port. "
 			"offset: The offset of the descriptor starting from tail. "
@@ -445,7 +448,7 @@ proc_info_parse_args(int argc, char **argv)
 		{"version", 0, NULL, 0},
 		{"firmware-version", 0, NULL, 0},
 		{"show-rss-reta", 0, NULL, 0},
-		{"show-module-eeprom", 0, NULL, 0},
+		{"show-module-eeprom", optional_argument, NULL, 0},
 		{"show-rx-descriptor", required_argument, NULL, 1},
 		{"show-tx-descriptor", required_argument, NULL, 1},
 		{"show-edev-queue-xstats", required_argument, NULL, 0},
@@ -539,8 +542,17 @@ proc_info_parse_args(int argc, char **argv)
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
@@ -1850,6 +1862,13 @@ show_port_rss_reta_info(void)
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
@@ -1891,6 +1910,16 @@ show_module_eeprom_info(void)
 			continue;
 		}
 
+		if (module_eeprom_decode) {
+			ret = rte_eth_module_eeprom_parse(module_info.type,
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0bca0c2c89..51de3a490f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -85,7 +85,8 @@ New Features
   or obtained from any other source with the same layout,
   such as the Linux ethtool ``ETHTOOL_GMODULEEEPROM`` ioctl.
   The testpmd command ``show port (port_id) module_eeprom decode``
-  uses it to display the decoded module EEPROM.
+  and the dpdk-proc-info option ``--show-module-eeprom=decode``
+  use it to display the decoded module EEPROM.
   The SFF-8636 decoder also reports the per-lane loss of signal,
   loss of lock and Tx fault flags.
   The SFF-8472 decoder also reports the Rx loss of signal and Tx fault state.
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

