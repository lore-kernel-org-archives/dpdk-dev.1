Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D8ACA6007
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 08:02:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F032D4027B;
	Thu,  8 Oct 2026 10:02:25 +0200 (CEST)
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net
 [51.250.60.160]) by mails.dpdk.org (Postfix) with ESMTP id 6721240274
 for <dev@dpdk.org>; Thu,  8 Oct 2026 10:02:24 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:31a0:0:640:75ad:0])
 by forward100d.mail.yandex.net (postfix) with ESMTPS id 7DB49C7CE4;
 Thu, 08 Oct 2026 11:02:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id B2JMeDAge4Y0-TF0Dt2Pv; 
 Thu, 08 Oct 2026 11:02:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791446543; bh=pJhDPGPrZJQz5kYl0CHFyIsCtbjxTVAHiAEMPEKE5EA=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=lvGwp7LT8y8obJh2CFeDB9Bs7gTPBN23Gw45fjZZ+FTCxGKfyhke2otnLlJHg+/kM
 G568WKdQM9WZ4cqI00Hw3SqEfTbwO2HFV6P9HmjRzI0+UOMzl3T7irGjUNLOrCkM/c
 DxvjEGGxJejGOJYgpVv2pSNxknzD1Xm2LMSak72U=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: aman.deep.singh@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: [PATCH] app/testpmd: add command to decode module EEPROM
Date: Thu,  8 Oct 2026 10:02:03 +0200
Message-ID: <20261008080203.144487-1-roma55592@yandex.ru>
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

The "show port <port_id> module_eeprom" command only prints
a hexdump of the pluggable module EEPROM, which has to be
decoded by hand against the SFF specifications.

Add the "show port <port_id> module_eeprom decode" command
to print the fields decoded by rte_eth_module_eeprom_parse(),
such as the vendor, the transceiver type and the digital
diagnostics, in the same form as "ethtool -m".

The EEPROM read is moved to a helper shared by both commands.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
This adds the testpmd hook for rte_eth_module_eeprom_parse(),
which is in dpdk-next-net for 26.11. The patch is based on
next-net/for-main.

Tested with net_null returning a synthetic SFF-8472 image
(not part of the patch), built with gcc and with clang
ASan/UBSan, no reports:

testpmd> show port 0 module_eeprom decode
Port 0 module EEPROM (type 0x2, 512 bytes):
	Identifier                                : 0x03 (SFP)
	...
	Vendor name                               : TESTVENDOR
	...
	Laser bias current                        : 8.000 mA
	Laser output power                        : 0.5000 mW / -3.01 dBm
	Receiver signal average optical power     : 0.4000 mW / -3.98 dBm
	Module temperature                        : 37.50 degrees C / 99.50 degrees F
	Module voltage                            : 3.3000 V

 app/test-pmd/cmdline.c                      | 48 ++++++++++++++
 app/test-pmd/config.c                       | 72 ++++++++++++++++-----
 app/test-pmd/testpmd.h                      |  1 +
 doc/guides/rel_notes/release_26_11.rst      |  2 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 +++
 5 files changed, 115 insertions(+), 16 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index d52a0eff42..51078a2a73 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -172,6 +172,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"show port port_id (module_eeprom|eeprom)\n"
 			"    Display the module EEPROM or EEPROM information for port_id.\n\n"
 
+			"show port (port_id) module_eeprom decode\n"
+			"    Display the decoded module EEPROM of port_id.\n\n"
+
 			"set port (port_id) eeprom (accept_risk) magic (magic_num)"
 			" value (value) offset (offset)\n"
 			"    Set the device eeprom for certain port.\nNote:\n"
@@ -7826,6 +7829,50 @@ static cmdline_parse_inst_t cmd_showeeprom = {
 	},
 };
 
+struct cmd_showeeprom_decode_result {
+	cmdline_fixed_string_t show;
+	cmdline_fixed_string_t port;
+	uint16_t portnum;
+	cmdline_fixed_string_t module_eeprom;
+	cmdline_fixed_string_t decode;
+};
+
+static void cmd_showeeprom_decode_parsed(void *parsed_result,
+		__rte_unused struct cmdline *cl,
+		__rte_unused void *data)
+{
+	struct cmd_showeeprom_decode_result *res = parsed_result;
+
+	port_module_eeprom_decode_display(res->portnum);
+}
+
+static cmdline_parse_token_string_t cmd_showeeprom_decode_show =
+	TOKEN_STRING_INITIALIZER(struct cmd_showeeprom_decode_result, show, "show");
+static cmdline_parse_token_string_t cmd_showeeprom_decode_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_showeeprom_decode_result, port, "port");
+static cmdline_parse_token_num_t cmd_showeeprom_decode_portnum =
+	TOKEN_NUM_INITIALIZER(struct cmd_showeeprom_decode_result, portnum,
+			RTE_UINT16);
+static cmdline_parse_token_string_t cmd_showeeprom_decode_module_eeprom =
+	TOKEN_STRING_INITIALIZER(struct cmd_showeeprom_decode_result, module_eeprom,
+			"module_eeprom");
+static cmdline_parse_token_string_t cmd_showeeprom_decode_decode =
+	TOKEN_STRING_INITIALIZER(struct cmd_showeeprom_decode_result, decode, "decode");
+
+static cmdline_parse_inst_t cmd_showeeprom_decode = {
+	.f = cmd_showeeprom_decode_parsed,
+	.data = NULL,
+	.help_str = "show port <port_id> module_eeprom decode",
+	.tokens = {
+		(void *)&cmd_showeeprom_decode_show,
+		(void *)&cmd_showeeprom_decode_port,
+		(void *)&cmd_showeeprom_decode_portnum,
+		(void *)&cmd_showeeprom_decode_module_eeprom,
+		(void *)&cmd_showeeprom_decode_decode,
+		NULL,
+	},
+};
+
 /* *** SET PORT EEPROM *** */
 struct cmd_seteeprom_result {
 	cmdline_fixed_string_t set;
@@ -14219,6 +14266,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_showport,
 	&cmd_showqueue,
 	&cmd_showeeprom,
+	&cmd_showeeprom_decode,
 	&cmd_seteeprom,
 	&cmd_showportall,
 	&cmd_representor_info,
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 9d1fa2f4d1..ec348cf854 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1145,20 +1145,18 @@ port_eeprom_set(portid_t port_id,
 		fprintf(stderr, "Unable to set EEPROM: %s\n", rte_strerror(-ret));
 }
 
-void
-port_module_eeprom_display(portid_t port_id)
+static int
+port_module_eeprom_read(portid_t port_id, struct rte_eth_dev_module_info *minfo,
+		struct rte_dev_eeprom_info *einfo)
 {
-	struct rte_eth_dev_module_info minfo;
-	struct rte_dev_eeprom_info einfo;
 	int ret;
 
 	if (port_id_is_invalid(port_id, ENABLED_WARN)) {
 		print_valid_ports();
-		return;
+		return -EINVAL;
 	}
 
-
-	ret = rte_eth_dev_get_module_info(port_id, &minfo);
+	ret = rte_eth_dev_get_module_info(port_id, minfo);
 	if (ret != 0) {
 		switch (ret) {
 		case -ENODEV:
@@ -1175,20 +1173,20 @@ port_module_eeprom_display(portid_t port_id)
 				ret);
 			break;
 		}
-		return;
+		return ret;
 	}
 
-	einfo.offset = 0;
-	einfo.length = minfo.eeprom_len;
-	einfo.data = calloc(1, minfo.eeprom_len);
-	if (!einfo.data) {
+	einfo->offset = 0;
+	einfo->length = minfo->eeprom_len;
+	einfo->data = calloc(1, minfo->eeprom_len);
+	if (!einfo->data) {
 		fprintf(stderr,
 			"Allocation of port %u eeprom data failed\n",
 			port_id);
-		return;
+		return -ENOMEM;
 	}
 
-	ret = rte_eth_dev_get_module_eeprom(port_id, &einfo);
+	ret = rte_eth_dev_get_module_eeprom(port_id, einfo);
 	if (ret != 0) {
 		switch (ret) {
 		case -ENODEV:
@@ -1205,15 +1203,57 @@ port_module_eeprom_display(portid_t port_id)
 				ret);
 			break;
 		}
-		free(einfo.data);
-		return;
+		free(einfo->data);
+		einfo->data = NULL;
+		return ret;
 	}
 
+	return 0;
+}
+
+void
+port_module_eeprom_display(portid_t port_id)
+{
+	struct rte_eth_dev_module_info minfo;
+	struct rte_dev_eeprom_info einfo;
+
+	if (port_module_eeprom_read(port_id, &minfo, &einfo) != 0)
+		return;
+
 	rte_hexdump(stdout, "hexdump", einfo.data, einfo.length);
 	printf("Finish -- Port: %d MODULE EEPROM length: %d bytes\n", port_id, einfo.length);
 	free(einfo.data);
 }
 
+static void
+port_module_eeprom_field_print(const char *name, const char *value,
+		__rte_unused void *arg)
+{
+	printf("\t%-41s : %s\n", name, value);
+}
+
+void
+port_module_eeprom_decode_display(portid_t port_id)
+{
+	struct rte_eth_dev_module_info minfo;
+	struct rte_dev_eeprom_info einfo;
+	int ret;
+
+	if (port_module_eeprom_read(port_id, &minfo, &einfo) != 0)
+		return;
+
+	printf("Port %u module EEPROM (type 0x%x, %u bytes):\n",
+		port_id, minfo.type, einfo.length);
+	ret = rte_eth_module_eeprom_parse(minfo.type, einfo.data, einfo.length,
+			port_module_eeprom_field_print, NULL);
+	if (ret == -ENOTSUP)
+		fprintf(stderr, "Unsupported module type: 0x%x\n", minfo.type);
+	else if (ret != 0)
+		fprintf(stderr, "Unable to decode module EEPROM: %s\n",
+			rte_strerror(-ret));
+	free(einfo.data);
+}
+
 int
 port_id_is_invalid(portid_t port_id, enum print_warning warning)
 {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index d23950ab9d..2ca4aaf086 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -990,6 +990,7 @@ void port_eeprom_display(portid_t port_id);
 void port_eeprom_set(portid_t port_id, uint32_t magic, uint32_t offset,
 		     uint32_t length, uint8_t *value);
 void port_module_eeprom_display(portid_t port_id);
+void port_module_eeprom_decode_display(portid_t port_id);
 void port_summary_header_display(void);
 void rx_queue_infos_display(portid_t port_idi, uint16_t queue_id);
 void tx_queue_infos_display(portid_t port_idi, uint16_t queue_id);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index d25dc72edf..d0c896634b 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -84,6 +84,8 @@ New Features
   It can decode data read with ``rte_eth_dev_get_module_eeprom()``
   or obtained from any other source with the same layout,
   such as the Linux ethtool ``ETHTOOL_GMODULEEEPROM`` ioctl.
+  The testpmd command ``show port (port_id) module_eeprom decode``
+  uses it to display the decoded module EEPROM.
 
 * **Updated AF_XDP driver.**
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 30cac0ad8c..a967bbef76 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -222,6 +222,14 @@ Display the EEPROM information of a port::
 
    testpmd> show port (port_id) (module_eeprom|eeprom)
 
+show port module_eeprom decode
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Display the module EEPROM of a port decoded according to the SFF specifications,
+for example the vendor, the transceiver type and the digital diagnostics::
+
+   testpmd> show port (port_id) module_eeprom decode
+
 set eeprom
 ~~~~~~~~~~
 
-- 
2.47.3

