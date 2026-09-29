Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418ECA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 07:08:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A60B640EE7;
	Tue, 29 Sep 2026 09:08:17 +0200 (CEST)
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net
 [178.154.239.82])
 by mails.dpdk.org (Postfix) with ESMTP id 4267940A84
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:08:12 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
 by forward502a.mail.yandex.net (postfix) with ESMTPS id 06F3A84800;
 Tue, 29 Sep 2026 10:08:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp)
 with ESMTPSA id a7cWxixi4iE0-FEiBIxsH; 
 Tue, 29 Sep 2026 10:08:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790665691; bh=tAMaiSdgsxf2DLUV9XQCLkz4zum52A/oW9oMCHMBtOM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=SM80lk5HNBiAMNEGMzaQUMYSAecF8jtA6XJEVneuC6QF70XoXF24wGgSWVnG8SteX
 0Kbv7XjoHvVp8y5SKoW28OOxOBmsIG+E1xGYTchcACjof4D+iojCBy7b4zQetB28kl
 HriV1gHgJk/QubkMZss27g5L6qHtV9k7xgplfT00=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Roman Khromenok <roma55592@yandex.ru>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 5/6] ethdev: add API to decode module EEPROM
Date: Tue, 29 Sep 2026 09:07:33 +0200
Message-ID: <20260929070734.1106134-6-roma55592@yandex.ru>
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

The SFF module EEPROM decoders are available only through
the telemetry command, which reads the EEPROM of a DPDK port
and returns the result as a telemetry dictionary.
An application cannot use them for its own output,
nor for EEPROM data obtained from other sources,
for example ports managed by the Linux kernel.

Add an experimental function which decodes a module EEPROM buffer
of the given type and reports each decoded field through
a user callback. The field names and value formats are the ones
of the telemetry output; they are documented as intended for display.
The function does not access any device and can be used
without EAL initialization.

Signed-off-by: Roman Khromenok <roma55592@yandex.ru>
---
v3: document display-only names, SFF-8636 length rule,
    ethtool ioctls vs netlink, "pluggable module"

 doc/guides/prog_guide/ethdev/ethdev.rst | 50 ++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst  |  8 ++++
 lib/ethdev/rte_ethdev.c                 | 21 +++++++++
 lib/ethdev/rte_ethdev.h                 | 57 +++++++++++++++++++++++++
 lib/ethdev/sff_common.h                 |  2 +-
 5 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/ethdev/ethdev.rst b/doc/guides/prog_guide/ethdev/ethdev.rst
index 6521fe14a5..ff2ab69b0f 100644
--- a/doc/guides/prog_guide/ethdev/ethdev.rst
+++ b/doc/guides/prog_guide/ethdev/ethdev.rst
@@ -802,3 +802,53 @@ three events are available:
    The application should close the port.
 
 Query the error handling mode supported by the PMD using ``rte_eth_dev_info_get()``.
+
+
+Pluggable Module EEPROM
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Pluggable transceiver modules (SFP, QSFP) store their identification
+and diagnostic data in an EEPROM with a layout defined by the SFF specifications.
+Use ``rte_eth_dev_get_module_info()`` to get the module type and the EEPROM size,
+then ``rte_eth_dev_get_module_eeprom()`` to read the raw EEPROM data.
+
+The raw data can be decoded with ``rte_eth_module_eeprom_parse()``.
+It supports the SFF-8079, SFF-8472, SFF-8436 and SFF-8636 layouts,
+and reports each decoded field, such as the vendor name, the serial number
+or the measured optical power, through an application callback
+as a pair of human readable strings.
+The field names and value formats are intended for display
+and may change in future releases:
+
+.. code-block:: c
+
+   static void
+   print_field(const char *name, const char *value, void *arg)
+   {
+       RTE_SET_USED(arg);
+       printf("%s: %s\n", name, value);
+   }
+
+   struct rte_eth_dev_module_info info;
+   struct rte_dev_eeprom_info eeprom = {0};
+
+   if (rte_eth_dev_get_module_info(port_id, &info) == 0) {
+       eeprom.data = malloc(info.eeprom_len);
+       eeprom.length = info.eeprom_len;
+       if (eeprom.data != NULL &&
+               rte_eth_dev_get_module_eeprom(port_id, &eeprom) == 0)
+           rte_eth_module_eeprom_parse(info.type, eeprom.data, eeprom.length,
+                   print_field, NULL);
+       free(eeprom.data);
+   }
+
+The decoding function does not access the device,
+so it can also decode EEPROM data obtained from other sources.
+For ports managed by the Linux kernel, the ethtool ioctls
+``ETHTOOL_GMODULEINFO`` and ``ETHTOOL_GMODULEEEPROM``
+return the same module types and data layout.
+The ethtool netlink request ``ETHTOOL_MSG_MODULE_EEPROM_GET``
+is page addressed and does not report the module type,
+so its data has to be assembled into this layout first.
+The same decoding is available through the telemetry command
+``/ethdev/module_eeprom``.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..d87f1e0362 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,14 @@ New Features
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
 
+* **Added module EEPROM decoding API to ethdev.**
+
+  Added the experimental ``rte_eth_module_eeprom_parse()`` function
+  to decode pluggable module EEPROM data according to the SFF specifications.
+  It can decode data read with ``rte_eth_dev_get_module_eeprom()``
+  or obtained from any other source with the same layout,
+  such as the Linux ethtool ``ETHTOOL_GMODULEEEPROM`` ioctl.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 7c57a9bb8f..af26e30d46 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -35,6 +35,7 @@
 #include "ethdev_profile.h"
 #include "ethdev_private.h"
 #include "ethdev_trace.h"
+#include "sff_common.h"
 #include "sff_telemetry.h"
 
 #define ETH_XSTATS_ITER_NUM	0x100
@@ -7000,6 +7001,26 @@ rte_eth_dev_get_module_eeprom(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_module_eeprom_parse, 26.11)
+int
+rte_eth_module_eeprom_parse(uint32_t type, const uint8_t *data, uint32_t length,
+		rte_eth_module_eeprom_field_cb cb, void *arg)
+{
+	struct sff_output out = { .field_cb = cb, .arg = arg };
+
+	if (data == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot parse module EEPROM from NULL data");
+		return -EINVAL;
+	}
+
+	if (cb == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot parse module EEPROM with NULL callback");
+		return -EINVAL;
+	}
+
+	return sff_decode_module_eeprom(type, data, length, &out);
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_get_dcb_info)
 int
 rte_eth_dev_get_dcb_info(uint16_t port_id,
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ae43420cf6..1924483689 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -5233,6 +5233,63 @@ int
 rte_eth_dev_get_module_eeprom(uint16_t port_id, struct rte_dev_eeprom_info *info)
 	__rte_warn_unused_result;
 
+/**
+ * Callback invoked by rte_eth_module_eeprom_parse() for each decoded field.
+ *
+ * @param name
+ *   Field name, for example "Vendor name" or "Laser bias current".
+ *   The same name may be reported more than once,
+ *   for example when a module complies with several transceiver types.
+ * @param value
+ *   Field value as a human readable string, including the unit if any.
+ * @param arg
+ *   The opaque argument passed to rte_eth_module_eeprom_parse().
+ *
+ * @note The field names and the value formats are intended for display.
+ *   They follow the ethtool output and may change in future releases,
+ *   so they should not be parsed or matched by applications.
+ */
+typedef void (*rte_eth_module_eeprom_field_cb)(const char *name,
+		const char *value, void *arg);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Decode pluggable module EEPROM data according to the SFF specifications.
+ *
+ * The data may come from rte_eth_dev_get_module_eeprom()
+ * or from any other source using the same layout,
+ * for example the Linux ethtool ioctls ETHTOOL_GMODULEINFO
+ * and ETHTOOL_GMODULEEEPROM.
+ * The function does not access any device
+ * and can be called without EAL initialization.
+ *
+ * @param type
+ *   Module type, one of RTE_ETH_MODULE_SFF_*,
+ *   as reported by rte_eth_dev_get_module_info().
+ * @param data
+ *   Module EEPROM data starting at offset 0.
+ * @param length
+ *   Length of the data in bytes.
+ *   SFF-8472 diagnostics are decoded only if at least
+ *   RTE_ETH_MODULE_SFF_8472_LEN bytes are provided.
+ *   SFF-8436 and SFF-8636 thresholds and alarm flags are decoded
+ *   only if at least RTE_ETH_MODULE_SFF_8636_MAX_LEN bytes are provided.
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
+rte_eth_module_eeprom_parse(uint32_t type, const uint8_t *data, uint32_t length,
+		rte_eth_module_eeprom_field_cb cb, void *arg);
+
 /**
  * Set the list of multicast addresses to filter on an Ethernet device.
  *
diff --git a/lib/ethdev/sff_common.h b/lib/ethdev/sff_common.h
index 6435f4d6f5..d346e1b378 100644
--- a/lib/ethdev/sff_common.h
+++ b/lib/ethdev/sff_common.h
@@ -17,7 +17,7 @@
 /* Consumer of decoded module EEPROM fields */
 struct sff_output {
 	/* Called once per decoded field, name may repeat */
-	void (*field_cb)(const char *name, const char *value, void *arg);
+	rte_eth_module_eeprom_field_cb field_cb;
 	void *arg;
 };
 
-- 
2.47.3

