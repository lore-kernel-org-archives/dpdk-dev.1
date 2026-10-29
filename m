Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E18606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=aQBGtfSe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E61C540151;
	Thu, 29 Oct 2026 19:15:32 +0100 (CET)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTPS id C0F2340664
 for <dev@dpdk.org>; Thu, 29 Oct 2026 19:15:29 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-63
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 2479781734;
 Thu, 29 Oct 2026 21:15:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 EFo9OWThdqM0-PCwbcGfk; Thu, 29 Oct 2026 21:15:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793297728; bh=VfzVrpwTyDdyghuCP4PvdkNWvcqNqNBRFHUQtoD1iYA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=aQBGtfSesi+FgAWILWIgkhPSZEXJ+7KgIx7+dpUTW1kHNyqTKUPZjnazez2bjWCGy
 PuWhu1NNhd2iJeTKuHdKrVNX+St+Aul6/WE5rPNHZFst199p6leWPH0/Q9A6n2Vcgj
 hm4zJUsFuFnssyAAB9vNVTCh5POr9ZhN6ljhy+pw=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org, aman.deep.singh@intel.com
Subject: [PATCH 4/4] ethdev: remove module EEPROM decoding wrapper
Date: Thu, 29 Oct 2026 20:15:11 +0200
Message-ID: <20261029181511.1736967-5-roma55592@yandex.ru>
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

rte_eth_module_eeprom_parse() was added in 26.11 as an experimental
API and is now only a wrapper of rte_transceiver_decode().
Remove it, as discussed on the mailing list, so that applications
use the transceiver library directly.

The build time check of the module type values moves to the telemetry
command, which is the remaining ethdev user of the library.
The transceiver tests no longer depend on ethdev.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 app/test/meson.build                      |  2 +-
 app/test/test_transceiver.c               | 26 ----------
 doc/guides/prog_guide/ethdev/ethdev.rst   | 39 +--------------
 doc/guides/prog_guide/transceiver_lib.rst |  3 ++
 lib/ethdev/rte_ethdev.c                   | 24 ---------
 lib/ethdev/rte_ethdev.h                   | 60 -----------------------
 lib/ethdev/sff_telemetry.c                |  6 +++
 7 files changed, 11 insertions(+), 149 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index c2b6bb532f..7974ae7a98 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -213,7 +213,7 @@ source_file_deps = {
     'test_trace.c': [],
     'test_trace_perf.c': [],
     'test_trace_register.c': [],
-    'test_transceiver.c': ['transceiver', 'ethdev'],
+    'test_transceiver.c': ['transceiver'],
     'test_vdev.c': ['kvargs', 'bus_vdev', 'net_null'],
     'test_version.c': [],
 }
diff --git a/app/test/test_transceiver.c b/app/test/test_transceiver.c
index b37126ed08..b7ec2b95e8 100644
--- a/app/test/test_transceiver.c
+++ b/app/test/test_transceiver.c
@@ -9,7 +9,6 @@
 #include <string.h>
 
 #include <rte_common.h>
-#include <rte_ethdev.h>
 #include <rte_transceiver.h>
 #include <rte_string_fns.h>
 
@@ -636,30 +635,6 @@ test_module_eeprom_invalid(void)
 	return TEST_SUCCESS;
 }
 
-/* rte_eth_module_eeprom_parse() is kept as a wrapper of the library */
-static int
-test_module_eeprom_ethdev_wrapper(void)
-{
-	uint8_t data[RTE_ETH_MODULE_SFF_8472_LEN];
-	int ret;
-
-	fill_sfp(data);
-	memset(&fields, 0, sizeof(fields));
-	TEST_ASSERT_SUCCESS(rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8472, data,
-		sizeof(data), collect_field, &fields),
-		"Failed to parse SFF-8472 data with the ethdev API");
-	TEST_ASSERT_SUCCESS(check_sfp_identity(), "Wrong SFF-8472 base information");
-	CHECK_FIELD("Laser bias current", "39.580 mA");
-
-	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8472, NULL,
-		sizeof(data), collect_field, &fields);
-	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL data: expected %d, got %d", -EINVAL, ret);
-	ret = rte_eth_module_eeprom_parse(RTE_ETH_MODULE_SFF_8472, data,
-		sizeof(data), NULL, NULL);
-	TEST_ASSERT_EQUAL(ret, -EINVAL, "NULL callback: expected %d, got %d", -EINVAL, ret);
-	return TEST_SUCCESS;
-}
-
 static struct unit_test_suite module_eeprom_testsuite = {
 	.suite_name = "transceiver module EEPROM decoding",
 	.setup = NULL,
@@ -681,7 +656,6 @@ static struct unit_test_suite module_eeprom_testsuite = {
 		TEST_CASE(test_module_eeprom_qsfp_8636_signals_not_implemented),
 		TEST_CASE(test_module_eeprom_qsfp_8636_signals),
 		TEST_CASE(test_module_eeprom_invalid),
-		TEST_CASE(test_module_eeprom_ethdev_wrapper),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index ff2ab69b0f..cad7d3e7f4 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -812,43 +812,6 @@ and diagnostic data in an EEPROM with a layout defined by the SFF specifications
 Use ``rte_eth_dev_get_module_info()`` to get the module type and the EEPROM size,
 then ``rte_eth_dev_get_module_eeprom()`` to read the raw EEPROM data.
 
-The raw data can be decoded with ``rte_eth_module_eeprom_parse()``.
-It supports the SFF-8079, SFF-8472, SFF-8436 and SFF-8636 layouts,
-and reports each decoded field, such as the vendor name, the serial number
-or the measured optical power, through an application callback
-as a pair of human readable strings.
-The field names and value formats are intended for display
-and may change in future releases:
-
-.. code-block:: c
-
-   static void
-   print_field(const char *name, const char *value, void *arg)
-   {
-       RTE_SET_USED(arg);
-       printf("%s: %s\n", name, value);
-   }
-
-   struct rte_eth_dev_module_info info;
-   struct rte_dev_eeprom_info eeprom = {0};
-
-   if (rte_eth_dev_get_module_info(port_id, &info) == 0) {
-       eeprom.data = malloc(info.eeprom_len);
-       eeprom.length = info.eeprom_len;
-       if (eeprom.data != NULL &&
-               rte_eth_dev_get_module_eeprom(port_id, &eeprom) == 0)
-           rte_eth_module_eeprom_parse(info.type, eeprom.data, eeprom.length,
-                   print_field, NULL);
-       free(eeprom.data);
-   }
-
-The decoding function does not access the device,
-so it can also decode EEPROM data obtained from other sources.
-For ports managed by the Linux kernel, the ethtool ioctls
-``ETHTOOL_GMODULEINFO`` and ``ETHTOOL_GMODULEEEPROM``
-return the same module types and data layout.
-The ethtool netlink request ``ETHTOOL_MSG_MODULE_EEPROM_GET``
-is page addressed and does not report the module type,
-so its data has to be assembled into this layout first.
+The raw data can be decoded with the :doc:`../transceiver_lib`.
 The same decoding is available through the telemetry command
 ``/ethdev/module_eeprom``.
diff --git a/doc/guides/prog_guide/transceiver_lib.rst b/doc/guides/prog_guide/transceiver_lib.rst
index 45bcf4302c..f146a0deef 100644
--- a/doc/guides/prog_guide/transceiver_lib.rst
+++ b/doc/guides/prog_guide/transceiver_lib.rst
@@ -19,6 +19,9 @@ ethdev ports
 Kernel ports
    The Linux ethtool ioctls ``ETHTOOL_GMODULEINFO`` and ``ETHTOOL_GMODULEEEPROM``
    give the same module types and EEPROM layout.
+   The ethtool netlink request ``ETHTOOL_MSG_MODULE_EEPROM_GET``
+   is page addressed and does not report the module type,
+   so its data has to be assembled into this layout first.
 
 
 Supported Specifications
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index e0b6361663..a5259504d9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -33,7 +33,6 @@
 #include "ethdev_profile.h"
 #include "ethdev_private.h"
 #include "ethdev_trace.h"
-#include <rte_transceiver.h>
 
 #define ETH_XSTATS_ITER_NUM	0x100
 
@@ -6998,29 +6997,6 @@ rte_eth_dev_get_module_eeprom(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_module_eeprom_parse, 26.11)
-int
-rte_eth_module_eeprom_parse(uint32_t type, const uint8_t *data, uint32_t length,
-		rte_eth_module_eeprom_field_cb cb, void *arg)
-{
-	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8079 != RTE_TRANSCEIVER_SFF_8079);
-	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8472 != RTE_TRANSCEIVER_SFF_8472);
-	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8636 != RTE_TRANSCEIVER_SFF_8636);
-	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8436 != RTE_TRANSCEIVER_SFF_8436);
-
-	if (data == NULL) {
-		RTE_ETHDEV_LOG_LINE(ERR, "Cannot parse module EEPROM from NULL data");
-		return -EINVAL;
-	}
-
-	if (cb == NULL) {
-		RTE_ETHDEV_LOG_LINE(ERR, "Cannot parse module EEPROM with NULL callback");
-		return -EINVAL;
-	}
-
-	return rte_transceiver_decode(type, data, length, cb, arg);
-}
-
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_dcb_info)
 int
 rte_eth_dev_get_dcb_info(uint16_t port_id,
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 64aeb676b8..ae43420cf6 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5233,66 +5233,6 @@ int
 rte_eth_dev_get_module_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	__rte_warn_unused_result;
 
-/**
- * Callback invoked by rte_eth_module_eeprom_parse() for each decoded field.
- *
- * @param name
- *   Field name, for example "Vendor name" or "Laser bias current".
- *   The same name may be reported more than once,
- *   for example when a module complies with several transceiver types.
- * @param value
- *   Field value as a human readable string, including the unit if any.
- * @param arg
- *   The opaque argument passed to rte_eth_module_eeprom_parse().
- *
- * @note The field names and the value formats are intended for display.
- *   They follow the ethtool output and may change in future releases,
- *   so they should not be parsed or matched by applications.
- */
-typedef void (*rte_eth_module_eeprom_field_cb)(const char *name,
-		const char *value, void *arg);
-
-/**
- * @warning
- * @b EXPERIMENTAL: this API may change without prior notice.
- *
- * Decode pluggable module EEPROM data according to the SFF specifications.
- *
- * This is a wrapper of rte_transceiver_decode()
- * for the RTE_ETH_MODULE_SFF_* module types.
- *
- * The data may come from rte_eth_dev_get_module_eeprom()
- * or from any other source using the same layout,
- * for example the Linux ethtool ioctls ETHTOOL_GMODULEINFO
- * and ETHTOOL_GMODULEEEPROM.
- * The function does not access any device
- * and can be called without EAL initialization.
- *
- * @param type
- *   Module type, one of RTE_ETH_MODULE_SFF_*,
- *   as reported by rte_eth_dev_get_module_info().
- * @param data
- *   Module EEPROM data starting at offset 0.
- * @param length
- *   Length of the data in bytes.
- *   SFF-8472 diagnostics are decoded only if at least
- *   RTE_ETH_MODULE_SFF_8472_LEN bytes are provided.
- *   SFF-8436 and SFF-8636 thresholds and alarm flags are decoded
- *   only if at least RTE_ETH_MODULE_SFF_8636_MAX_LEN bytes are provided.
- * @param cb
- *   Callback invoked for each decoded field.
- * @param arg
- *   Opaque argument passed to the callback.
- * @return
- *   - (0) if successful.
- *   - (-EINVAL) if bad parameter or data is too short for the module type.
- *   - (-ENOTSUP) if the module type is not supported.
- */
-__rte_experimental
-int
-rte_eth_module_eeprom_parse(uint32_t type, const uint8_t *data, uint32_t length,
-		rte_eth_module_eeprom_field_cb cb, void *arg);
-
 /**
  * Set the list of multicast addresses to filter on an Ethernet device.
  *
diff --git a/lib/ethdev/sff_telemetry.c b/lib/ethdev/sff_telemetry.c
index 758e1dc7f2..bc5c0eea9e 100644
--- a/lib/ethdev/sff_telemetry.c
+++ b/lib/ethdev/sff_telemetry.c
@@ -48,6 +48,12 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 	struct rte_dev_eeprom_info einfo;
 	int ret;
 
+	/* The module type is passed as is to the transceiver library. */
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8079 != RTE_TRANSCEIVER_SFF_8079);
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8472 != RTE_TRANSCEIVER_SFF_8472);
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8636 != RTE_TRANSCEIVER_SFF_8636);
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8436 != RTE_TRANSCEIVER_SFF_8436);
+
 	if (d == NULL) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Dict invalid");
 		return;
-- 
2.47.3

