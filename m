Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94E606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Oct 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=njHhOGd1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42AD14025A;
	Thu, 29 Oct 2026 19:15:29 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTPS id 6484540151
 for <dev@dpdk.org>; Thu, 29 Oct 2026 19:15:27 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-63
 (mail-nwsmtp-smtp-production-main-63.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:49a1:0:640:3edd:0])
 by forward501d.mail.yandex.net (postfix) with ESMTPS id 3ADB880BC9;
 Thu, 29 Oct 2026 21:15:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 EFo9OWThdqM0-glj42unp; Thu, 29 Oct 2026 21:15:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793297725; bh=uC2NsEMIXALwKrYN61UM6GXirPqE3aamvnn4SvXQhxI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=njHhOGd1M51OQnraOpGFQMeePi8UJibgQfSLi5OTqV6+amPlggKa2CuRSOml9iGJZ
 zFUwR59Hl/3Gv+UrUSiL4ZPoGCttI3UthS2P6lVjp49/Ow6UHVJ0VRf8E1Q0EeabLL
 f+peijzQMQMtokXBvEnTOLNib20CQn3k16aJ1WMo=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: thomas@monjalon.net, andrew.rybchenko@oktetlabs.ru,
 stephen@networkplumber.org, aman.deep.singh@intel.com
Subject: [PATCH 1/4] transceiver: introduce module EEPROM decoding library
Date: Thu, 29 Oct 2026 20:15:08 +0200
Message-ID: <20261029181511.1736967-2-roma55592@yandex.ru>
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
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SFF module EEPROM decoders in ethdev do not depend on any device
or driver: drivers only return the raw EEPROM bytes, and the decoding
follows the SFF specifications. The same decoding is also needed for
ports which are not ethdev ports, for example kernel ports read with
the ethtool ioctls.

Move the SFF-8079, SFF-8472 and SFF-8636 decoders to a new transceiver
library with its own rte_transceiver_decode() API, which depends only
on EAL headers. ethdev depends on it, as it does on the net and meter
libraries: the telemetry command and rte_eth_module_eeprom_parse()
call the library. The ethdev wrapper is kept for now, so that its
users can be moved to the library in the next patches.

The module type values are the same as the RTE_ETH_MODULE_SFF_* ones,
which is checked at build time in ethdev.

Add the library to the programmer's guide and to the API
documentation, and add myself as its maintainer.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
 MAINTAINERS                               |   6 ++
 doc/api/doxy-api-index.md                 |   1 +
 doc/api/doxy-api.conf.in                  |   1 +
 doc/guides/prog_guide/index.rst           |   1 +
 doc/guides/prog_guide/transceiver_lib.rst |  83 ++++++++++++++++++
 lib/ethdev/meson.build                    |   6 +-
 lib/ethdev/rte_ethdev.c                   |   9 +-
 lib/ethdev/rte_ethdev.h                   |   3 +
 lib/ethdev/sff_telemetry.c                |   7 +-
 lib/meson.build                           |   2 +
 lib/transceiver/meson.build               |  11 +++
 lib/transceiver/rte_transceiver.c         |  24 +++++
 lib/transceiver/rte_transceiver.h         | 102 ++++++++++++++++++++++
 lib/{ethdev => transceiver}/sff_8079.c    |   2 +-
 lib/{ethdev => transceiver}/sff_8472.c    |   0
 lib/{ethdev => transceiver}/sff_8636.c    |   4 +-
 lib/{ethdev => transceiver}/sff_8636.h    |   0
 lib/{ethdev => transceiver}/sff_common.c  |  28 +++---
 lib/{ethdev => transceiver}/sff_common.h  |  10 ++-
 19 files changed, 269 insertions(+), 31 deletions(-)
 create mode 100644 doc/guides/prog_guide/transceiver_lib.rst
 create mode 100644 lib/transceiver/meson.build
 create mode 100644 lib/transceiver/rte_transceiver.c
 create mode 100644 lib/transceiver/rte_transceiver.h
 rename lib/{ethdev => transceiver}/sff_8079.c (99%)
 rename lib/{ethdev => transceiver}/sff_8472.c (100%)
 rename lib/{ethdev => transceiver}/sff_8636.c (99%)
 rename lib/{ethdev => transceiver}/sff_8636.h (100%)
 rename lib/{ethdev => transceiver}/sff_common.c (95%)
 rename lib/{ethdev => transceiver}/sff_common.h (96%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc86b35b29..a647b2479a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,12 @@ F: app/test/test_ethdev*
 F: devtools/test-null.sh
 F: doc/guides/prog_guide/ethdev/switch_representation.rst
 
+Transceiver module EEPROM
+M: Roman Khromenok <roma55592@yandex.ru>
+T: git://dpdk.org/next/dpdk-next-net
+F: lib/transceiver/
+F: doc/guides/prog_guide/transceiver_lib.rst
+
 Flow API
 M: Ori Kam <orika@nvidia.com>
 T: git://dpdk.org/next/dpdk-next-net
diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 62390f7be3..45c3558205 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -15,6 +15,7 @@ The public API headers are grouped by topics:
   [rte_flow](@ref rte_flow.h),
   [rte_tm](@ref rte_tm.h),
   [rte_mtr](@ref rte_mtr.h),
+  [transceiver](@ref rte_transceiver.h),
   [bbdev](@ref rte_bbdev.h),
   [cryptodev](@ref rte_cryptodev.h),
   [security](@ref rte_security.h),
diff --git a/doc/api/doxy-api.conf.in b/doc/api/doxy-api.conf.in
index 94096ee710..ca40a85172 100644
--- a/doc/api/doxy-api.conf.in
+++ b/doc/api/doxy-api.conf.in
@@ -86,6 +86,7 @@ INPUT                   = @TOPDIR@/doc/api/doxy-api-index.md \
                           @TOPDIR@/lib/table \
                           @TOPDIR@/lib/telemetry \
                           @TOPDIR@/lib/timer \
+                          @TOPDIR@/lib/transceiver \
                           @TOPDIR@/lib/vhost
 INPUT                   += @API_EXAMPLES@
 FILE_PATTERNS           = rte_*.h \
diff --git a/doc/guides/prog_guide/index.rst b/doc/guides/prog_guide/index.rst
index b9c0d59728..6023f483fa 100644
--- a/doc/guides/prog_guide/index.rst
+++ b/doc/guides/prog_guide/index.rst
@@ -76,6 +76,7 @@ Device Libraries
     devargs
     device_hotplug
     ethdev/index
+    transceiver_lib
     link_bonding_poll_mode_drv_lib
     vhost_lib
     cryptodev_lib
diff --git a/doc/guides/prog_guide/transceiver_lib.rst b/doc/guides/prog_guide/transceiver_lib.rst
new file mode 100644
index 0000000000..45bcf4302c
--- /dev/null
+++ b/doc/guides/prog_guide/transceiver_lib.rst
@@ -0,0 +1,83 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Roman Khromenok
+
+Transceiver Library
+===================
+
+The transceiver library decodes the EEPROM of pluggable transceiver modules
+(SFP, QSFP) according to the SFF specifications,
+for example the vendor, the transceiver type and the digital diagnostics.
+
+The decoding does not depend on any device or driver,
+and the library does not need EAL to be initialized.
+The EEPROM data may come from different sources:
+
+ethdev ports
+   ``rte_eth_dev_get_module_info()`` gives the module type and EEPROM length,
+   and ``rte_eth_dev_get_module_eeprom()`` reads the EEPROM.
+
+Kernel ports
+   The Linux ethtool ioctls ``ETHTOOL_GMODULEINFO`` and ``ETHTOOL_GMODULEEEPROM``
+   give the same module types and EEPROM layout.
+
+
+Supported Specifications
+------------------------
+
+The module type is one of the ``RTE_TRANSCEIVER_SFF_*`` values,
+which are the same as the ``RTE_ETH_MODULE_SFF_*`` values of ethdev.
+
+``RTE_TRANSCEIVER_SFF_8079``
+   SFP identification, page A0h (256 bytes).
+
+``RTE_TRANSCEIVER_SFF_8472``
+   SFP identification and digital diagnostics, pages A0h and A2h (512 bytes).
+   With external calibration, the calibrated values are reported.
+   The Rx loss of signal and Tx fault state are reported
+   if the module advertises them.
+
+``RTE_TRANSCEIVER_SFF_8436`` and ``RTE_TRANSCEIVER_SFF_8636``
+   QSFP+ and QSFP28 identification, diagnostics and per-lane status flags,
+   lower page and page 00h (256 bytes).
+   The thresholds and the alarm and warning flags are reported
+   if page 03h is also provided (640 bytes).
+   The channel status flags are latched and cleared on read by the module,
+   so they report the events since the previous read of the module.
+
+
+Usage
+-----
+
+``rte_transceiver_decode()`` calls a callback for each decoded field,
+with the field name and the value as human readable strings.
+The same name may be reported more than once,
+for example when a module complies with several transceiver types.
+
+The names and value formats follow the output of ethtool and are intended for display,
+so applications should not parse them.
+
+.. code-block:: c
+
+   static void
+   print_field(const char *name, const char *value, void *arg)
+   {
+           RTE_SET_USED(arg);
+           printf("%-41s : %s\n", name, value);
+   }
+
+   struct rte_eth_dev_module_info info;
+   struct rte_dev_eeprom_info eeprom = { 0 };
+   uint8_t data[RTE_TRANSCEIVER_SFF_8636_MAX_LEN];
+
+   if (rte_eth_dev_get_module_info(port_id, &info) == 0 &&
+           info.eeprom_len <= sizeof(data)) {
+           eeprom.length = info.eeprom_len;
+           eeprom.data = data;
+           if (rte_eth_dev_get_module_eeprom(port_id, &eeprom) == 0)
+                   rte_transceiver_decode(info.type, data, eeprom.length,
+                                   print_field, NULL);
+   }
+
+The decoded module EEPROM of an ethdev port is also available
+with the telemetry command ``/ethdev/module_eeprom``
+and the testpmd command ``show port (port_id) module_eeprom decode``.
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index 069bb7ec79..cf82df6028 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -15,10 +15,6 @@ sources = files(
         'rte_mtr.c',
         'rte_tm.c',
         'sff_telemetry.c',
-        'sff_common.c',
-        'sff_8079.c',
-        'sff_8472.c',
-        'sff_8636.c',
 )
 
 headers = files(
@@ -55,7 +51,7 @@ if is_linux
     )
 endif
 
-deps += ['net', 'kvargs', 'meter', 'telemetry']
+deps += ['net', 'kvargs', 'meter', 'telemetry', 'transceiver']
 
 if is_freebsd
     annotate_locks = false
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f843e8808a..e0b6361663 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -33,7 +33,7 @@
 #include "ethdev_profile.h"
 #include "ethdev_private.h"
 #include "ethdev_trace.h"
-#include "sff_common.h"
+#include <rte_transceiver.h>
 
 #define ETH_XSTATS_ITER_NUM	0x100
 
@@ -7003,7 +7003,10 @@ int
 rte_eth_module_eeprom_parse(uint32_t type, const uint8_t *data, uint32_t length,
 		rte_eth_module_eeprom_field_cb cb, void *arg)
 {
-	struct sff_output out = { .field_cb = cb, .arg = arg };
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8079 != RTE_TRANSCEIVER_SFF_8079);
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8472 != RTE_TRANSCEIVER_SFF_8472);
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8636 != RTE_TRANSCEIVER_SFF_8636);
+	RTE_BUILD_BUG_ON(RTE_ETH_MODULE_SFF_8436 != RTE_TRANSCEIVER_SFF_8436);
 
 	if (data == NULL) {
 		RTE_ETHDEV_LOG_LINE(ERR, "Cannot parse module EEPROM from NULL data");
@@ -7015,7 +7018,7 @@ rte_eth_module_eeprom_parse(uint32_t type, const uint8_t *data, uint32_t length,
 		return -EINVAL;
 	}
 
-	return sff_decode_module_eeprom(type, data, length, &out);
+	return rte_transceiver_decode(type, data, length, cb, arg);
 }
 
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_dcb_info)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 1924483689..64aeb676b8 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5258,6 +5258,9 @@ typedef void (*rte_eth_module_eeprom_field_cb)(const char *name,
  *
  * Decode pluggable module EEPROM data according to the SFF specifications.
  *
+ * This is a wrapper of rte_transceiver_decode()
+ * for the RTE_ETH_MODULE_SFF_* module types.
+ *
  * The data may come from rte_eth_dev_get_module_eeprom()
  * or from any other source using the same layout,
  * for example the Linux ethtool ioctls ETHTOOL_GMODULEINFO
diff --git a/lib/ethdev/sff_telemetry.c b/lib/ethdev/sff_telemetry.c
index 46533a9fc5..758e1dc7f2 100644
--- a/lib/ethdev/sff_telemetry.c
+++ b/lib/ethdev/sff_telemetry.c
@@ -8,7 +8,8 @@
 
 #include "rte_ethdev.h"
 #include <rte_common.h>
-#include "sff_common.h"
+#include <rte_string_fns.h>
+#include <rte_transceiver.h>
 #include "sff_telemetry.h"
 #include <telemetry_data.h>
 
@@ -43,7 +44,6 @@ sff_tel_add_field(const char *name_str, const char *value_str, void *arg)
 static void
 sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 {
-	struct sff_output out = { .field_cb = sff_tel_add_field, .arg = d };
 	struct rte_eth_dev_module_info minfo;
 	struct rte_dev_eeprom_info einfo;
 	int ret;
@@ -100,7 +100,8 @@ sff_port_module_eeprom_parse(uint16_t port_id, struct rte_tel_data *d)
 		return;
 	}
 
-	ret = sff_decode_module_eeprom(minfo.type, einfo.data, einfo.length, &out);
+	ret = rte_transceiver_decode(minfo.type, einfo.data, einfo.length,
+				     sff_tel_add_field, d);
 	if (ret == -ENOTSUP)
 		RTE_ETHDEV_LOG_LINE(NOTICE, "Unsupported module type: %u", minfo.type);
 	else if (ret != 0)
diff --git a/lib/meson.build b/lib/meson.build
index 458951054c..f64b994c46 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -22,6 +22,7 @@ libraries = [
         'mbuf',
         'net',
         'meter',
+        'transceiver',
         'ethdev',
         'pci', # core
         'cmdline',
@@ -85,6 +86,7 @@ always_enable = [
         'rcu',
         'ring',
         'telemetry',
+        'transceiver',
 ]
 
 enable_deprecated_libs = []
diff --git a/lib/transceiver/meson.build b/lib/transceiver/meson.build
new file mode 100644
index 0000000000..2559eae692
--- /dev/null
+++ b/lib/transceiver/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Roman Khromenok
+
+sources = files(
+        'rte_transceiver.c',
+        'sff_common.c',
+        'sff_8079.c',
+        'sff_8472.c',
+        'sff_8636.c',
+)
+headers = files('rte_transceiver.h')
diff --git a/lib/transceiver/rte_transceiver.c b/lib/transceiver/rte_transceiver.c
new file mode 100644
index 0000000000..9a85bb5a8e
--- /dev/null
+++ b/lib/transceiver/rte_transceiver.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Roman Khromenok
+ */
+
+#include <errno.h>
+#include <stddef.h>
+
+#include <eal_export.h>
+
+#include "rte_transceiver.h"
+#include "sff_common.h"
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_transceiver_decode, 27.03)
+int
+rte_transceiver_decode(uint32_t type, const uint8_t *data, uint32_t length,
+		rte_transceiver_field_cb cb, void *arg)
+{
+	struct sff_output out = { .field_cb = cb, .arg = arg };
+
+	if (data == NULL || cb == NULL)
+		return -EINVAL;
+
+	return sff_decode_module_eeprom(type, data, length, &out);
+}
diff --git a/lib/transceiver/rte_transceiver.h b/lib/transceiver/rte_transceiver.h
new file mode 100644
index 0000000000..cc112f3913
--- /dev/null
+++ b/lib/transceiver/rte_transceiver.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Roman Khromenok
+ */
+
+#ifndef RTE_TRANSCEIVER_H
+#define RTE_TRANSCEIVER_H
+
+/**
+ * @file
+ *
+ * Pluggable transceiver module EEPROM decoding.
+ *
+ * Decode the EEPROM of pluggable transceiver modules (SFP, QSFP)
+ * according to the SFF specifications.
+ * The decoding does not depend on any device or driver:
+ * the EEPROM data may be read with rte_eth_dev_get_module_eeprom()
+ * or from any other source using the same layout,
+ * for example the Linux ethtool ioctls ETHTOOL_GMODULEINFO
+ * and ETHTOOL_GMODULEEEPROM.
+ */
+
+#include <stdint.h>
+
+#include <rte_compat.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Module EEPROM layouts.
+ * The values are the same as the RTE_ETH_MODULE_SFF_* values
+ * reported by rte_eth_dev_get_module_info().
+ */
+#define RTE_TRANSCEIVER_SFF_8079		0x1 /**< SFF-8079 (SFP), page A0h */
+#define RTE_TRANSCEIVER_SFF_8079_LEN		256 /**< SFF-8079 EEPROM length */
+#define RTE_TRANSCEIVER_SFF_8472		0x2 /**< SFF-8472 (SFP), pages A0h and A2h */
+#define RTE_TRANSCEIVER_SFF_8472_LEN		512 /**< SFF-8472 EEPROM length */
+#define RTE_TRANSCEIVER_SFF_8636		0x3 /**< SFF-8636 (QSFP28) */
+#define RTE_TRANSCEIVER_SFF_8636_LEN		256 /**< SFF-8636 lower and page 00h length */
+#define RTE_TRANSCEIVER_SFF_8636_MAX_LEN	640 /**< SFF-8636 length with page 03h */
+#define RTE_TRANSCEIVER_SFF_8436		0x4 /**< SFF-8436 (QSFP+) */
+#define RTE_TRANSCEIVER_SFF_8436_LEN		256 /**< SFF-8436 lower and page 00h length */
+#define RTE_TRANSCEIVER_SFF_8436_MAX_LEN	640 /**< SFF-8436 length with page 03h */
+
+/**
+ * Callback invoked by rte_transceiver_decode() for each decoded field.
+ *
+ * @param name
+ *   Field name, for example "Vendor name" or "Laser bias current".
+ *   The same name may be reported more than once,
+ *   for example when a module complies with several transceiver types.
+ * @param value
+ *   Field value as a human readable string, including the unit if any.
+ * @param arg
+ *   The opaque argument passed to rte_transceiver_decode().
+ *
+ * @note The field names and the value formats are intended for display.
+ *   They follow the ethtool output and may change in future releases,
+ *   so they should not be parsed or matched by applications.
+ */
+typedef void (*rte_transceiver_field_cb)(const char *name, const char *value,
+		void *arg);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Decode pluggable module EEPROM data according to the SFF specifications.
+ *
+ * The function does not access any device
+ * and can be called without EAL initialization.
+ *
+ * @param type
+ *   Module EEPROM layout, one of RTE_TRANSCEIVER_SFF_*.
+ * @param data
+ *   Module EEPROM data starting at offset 0.
+ * @param length
+ *   Length of the data in bytes.
+ *   SFF-8472 diagnostics are decoded only if at least
+ *   RTE_TRANSCEIVER_SFF_8472_LEN bytes are provided.
+ *   SFF-8436 and SFF-8636 thresholds and alarm flags are decoded
+ *   only if at least RTE_TRANSCEIVER_SFF_8636_MAX_LEN bytes are provided.
+ * @param cb
+ *   Callback invoked for each decoded field.
+ * @param arg
+ *   Opaque argument passed to the callback.
+ * @return
+ *   - (0) if successful.
+ *   - (-EINVAL) if bad parameter or data is too short for the module type.
+ *   - (-ENOTSUP) if the module type is not supported.
+ */
+__rte_experimental
+int
+rte_transceiver_decode(uint32_t type, const uint8_t *data, uint32_t length,
+		rte_transceiver_field_cb cb, void *arg);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_TRANSCEIVER_H */
diff --git a/lib/ethdev/sff_8079.c b/lib/transceiver/sff_8079.c
similarity index 99%
rename from lib/ethdev/sff_8079.c
rename to lib/transceiver/sff_8079.c
index c8db5c0975..916486e9a9 100644
--- a/lib/ethdev/sff_8079.c
+++ b/lib/transceiver/sff_8079.c
@@ -236,7 +236,7 @@ static void sff_8079_show_transceiver(const uint8_t *data, struct sff_output *d)
 
 static void sff_8079_show_encoding(const uint8_t *data, struct sff_output *d)
 {
-	sff_8024_show_encoding(data, 11, RTE_ETH_MODULE_SFF_8472, d);
+	sff_8024_show_encoding(data, 11, RTE_TRANSCEIVER_SFF_8472, d);
 }
 
 static void sff_8079_show_rate_identifier(const uint8_t *data, struct sff_output *d)
diff --git a/lib/ethdev/sff_8472.c b/lib/transceiver/sff_8472.c
similarity index 100%
rename from lib/ethdev/sff_8472.c
rename to lib/transceiver/sff_8472.c
diff --git a/lib/ethdev/sff_8636.c b/lib/transceiver/sff_8636.c
similarity index 99%
rename from lib/ethdev/sff_8636.c
rename to lib/transceiver/sff_8636.c
index 5e77f1b855..3f583f1c5b 100644
--- a/lib/ethdev/sff_8636.c
+++ b/lib/transceiver/sff_8636.c
@@ -447,7 +447,7 @@ static void sff_8636_show_transceiver(const uint8_t *data, struct sff_output *d)
 static void sff_8636_show_encoding(const uint8_t *data, struct sff_output *d)
 {
 	sff_8024_show_encoding(data, SFF_8636_ENCODING_OFFSET,
-			       RTE_ETH_MODULE_SFF_8636, d);
+			       RTE_TRANSCEIVER_SFF_8636, d);
 }
 
 static void sff_8636_show_rate_identifier(const uint8_t *data, struct sff_output *d)
@@ -695,7 +695,7 @@ static void sff_8636_show_dom(const uint8_t *data, uint32_t eeprom_len, struct s
 	 * If pagging support exists, then supports_alarms is marked as 1
 	 */
 
-	if (eeprom_len >= RTE_ETH_MODULE_SFF_8636_MAX_LEN) {
+	if (eeprom_len >= RTE_TRANSCEIVER_SFF_8636_MAX_LEN) {
 		if (!(data[SFF_8636_STATUS_2_OFFSET] &
 					SFF_8636_STATUS_PAGE_3_PRESENT)) {
 			sd.supports_alarms = 1;
diff --git a/lib/ethdev/sff_8636.h b/lib/transceiver/sff_8636.h
similarity index 100%
rename from lib/ethdev/sff_8636.h
rename to lib/transceiver/sff_8636.h
diff --git a/lib/ethdev/sff_common.c b/lib/transceiver/sff_common.c
similarity index 95%
rename from lib/ethdev/sff_common.c
rename to lib/transceiver/sff_common.c
index 0fc498edb0..321fe63e05 100644
--- a/lib/ethdev/sff_common.c
+++ b/lib/transceiver/sff_common.c
@@ -19,22 +19,22 @@ int sff_decode_module_eeprom(uint32_t type, const uint8_t *data, uint32_t length
 			     struct sff_output *d)
 {
 	switch (type) {
-	case RTE_ETH_MODULE_SFF_8079:
-		if (length < RTE_ETH_MODULE_SFF_8079_LEN)
+	case RTE_TRANSCEIVER_SFF_8079:
+		if (length < RTE_TRANSCEIVER_SFF_8079_LEN)
 			return -EINVAL;
 		sff_8079_show_all(data, d);
 		break;
-	case RTE_ETH_MODULE_SFF_8472:
-		if (length < RTE_ETH_MODULE_SFF_8079_LEN)
+	case RTE_TRANSCEIVER_SFF_8472:
+		if (length < RTE_TRANSCEIVER_SFF_8079_LEN)
 			return -EINVAL;
 		sff_8079_show_all(data, d);
 		/* diagnostics are in the second page (A2h) */
-		if (length >= RTE_ETH_MODULE_SFF_8472_LEN)
+		if (length >= RTE_TRANSCEIVER_SFF_8472_LEN)
 			sff_8472_show_all(data, d);
 		break;
-	case RTE_ETH_MODULE_SFF_8436:
-	case RTE_ETH_MODULE_SFF_8636:
-		if (length < RTE_ETH_MODULE_SFF_8636_LEN)
+	case RTE_TRANSCEIVER_SFF_8436:
+	case RTE_TRANSCEIVER_SFF_8636:
+		if (length < RTE_TRANSCEIVER_SFF_8636_LEN)
 			return -EINVAL;
 		sff_8636_show_all(data, length, d);
 		break;
@@ -299,21 +299,21 @@ void sff_8024_show_encoding(const uint8_t *data, int encoding_offset,
 		strlcat(val_string, " (NRZ)", sizeof(val_string));
 		break;
 	case SFF_8024_ENCODING_4h:
-		if (sff_type == RTE_ETH_MODULE_SFF_8472)
+		if (sff_type == RTE_TRANSCEIVER_SFF_8472)
 			strlcat(val_string, " (Manchester)", sizeof(val_string));
-		else if (sff_type == RTE_ETH_MODULE_SFF_8636)
+		else if (sff_type == RTE_TRANSCEIVER_SFF_8636)
 			strlcat(val_string, " (SONET Scrambled)", sizeof(val_string));
 		break;
 	case SFF_8024_ENCODING_5h:
-		if (sff_type == RTE_ETH_MODULE_SFF_8472)
+		if (sff_type == RTE_TRANSCEIVER_SFF_8472)
 			strlcat(val_string, " (SONET Scrambled)", sizeof(val_string));
-		else if (sff_type == RTE_ETH_MODULE_SFF_8636)
+		else if (sff_type == RTE_TRANSCEIVER_SFF_8636)
 			strlcat(val_string, " (64B/66B)", sizeof(val_string));
 		break;
 	case SFF_8024_ENCODING_6h:
-		if (sff_type == RTE_ETH_MODULE_SFF_8472)
+		if (sff_type == RTE_TRANSCEIVER_SFF_8472)
 			strlcat(val_string, " (64B/66B)", sizeof(val_string));
-		else if (sff_type == RTE_ETH_MODULE_SFF_8636)
+		else if (sff_type == RTE_TRANSCEIVER_SFF_8636)
 			strlcat(val_string, " (Manchester)", sizeof(val_string));
 		break;
 	case SFF_8024_ENCODING_256B:
diff --git a/lib/ethdev/sff_common.h b/lib/transceiver/sff_common.h
similarity index 96%
rename from lib/ethdev/sff_common.h
rename to lib/transceiver/sff_common.h
index 9041f8ed17..015c59d261 100644
--- a/lib/ethdev/sff_common.h
+++ b/lib/transceiver/sff_common.h
@@ -10,14 +10,18 @@
 
 #include <stdio.h>
 
-#include "rte_ethdev.h"
+#include <rte_bitops.h>
+#include <rte_common.h>
+#include <rte_string_fns.h>
+
+#include "rte_transceiver.h"
 
 #define SFF_ITEM_VAL_COMPOSE_SIZE 64
 
 /* Consumer of decoded module EEPROM fields */
 struct sff_output {
 	/* Called once per decoded field, name may repeat */
-	rte_eth_module_eeprom_field_cb field_cb;
+	rte_transceiver_field_cb field_cb;
 	void *arg;
 };
 
@@ -35,7 +39,7 @@ void sff_8472_show_all(const uint8_t *data, struct sff_output *d);
 void sff_8636_show_all(const uint8_t *data, uint32_t eeprom_len, struct sff_output *d);
 
 /*
- * Decode module EEPROM of the given type (RTE_ETH_MODULE_SFF_*).
+ * Decode module EEPROM of the given type (RTE_TRANSCEIVER_SFF_*).
  * Returns 0 on success, -EINVAL if the data is too short for the type,
  * -ENOTSUP if the type is unknown.
  */
-- 
2.47.3

