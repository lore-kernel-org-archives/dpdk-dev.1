Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9747C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F2F042ED9;
	Wed, 16 Sep 2026 14:27:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6F1F542ED9
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:27:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561668; x=1821097668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j69Q4jPqoTMh6vVOOXXKUZkgTWiTLM9LUfr+T8Plbls=;
 b=EvOzgBCeRlvidith9OlPCASK3/rjBizUcWwUz3JHNYlY+mgUBFNeGfSU
 7V4WUx+GXMCZh1aaEHa0UCFvBR6K5qS6GriM9TGt7JnFAnOPDsuzOWWqW
 HNPJ7hzKrcrRzMDgjKOrliF1igQtt+o+VnWz8AaAbyIFYqtpesZ3ixhDs
 HuTUQyG6NGBF9t1ALbUY6jhRckZ2apfzm2+i97a8wi3srF/yXuFLalF4Q
 F5HHFEgr/gMFkCeHQf7/HXPXXx0ZodHoA+jiu8g6XOI1tFriQS3IrqNXT
 zfNX80j7zXrcnRSEV66w6ne4d0RLnjqDOCcBHoDV+tO5TjQ6bJroYejz8 g==;
X-CSE-ConnectionGUID: qGECaimrS0Svt6XBRFfe7w==
X-CSE-MsgGUID: XuoPF4RzS2CXxzFCJtmQuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107305482"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107305482"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:27:48 -0700
X-CSE-ConnectionGUID: 0/fEzUGSQaSMrk5KielANA==
X-CSE-MsgGUID: TypHzAcISOGZ53FoMOa01Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270693923"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2026 05:27:46 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>, Nirint Shah <nirint.shah@intel.com>
Subject: [RFC v3 1/7] regex/hs: add driver skeleton and build integration
Date: Wed, 16 Sep 2026 17:56:58 +0530
Message-ID: <20260916122738.2176589-2-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916122738.2176589-1-prudvi.deti@intel.com>
References: <20260910080136.1790851-1-prudvi.deti@intel.com>
 <20260916122738.2176589-1-prudvi.deti@intel.com>
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

Add a new software regex Poll Mode Driver based on Intel Hyperscan.
This patch provides the minimal vdev skeleton: probe, remove, device
registration, and info_get.

Build is gated by meson dependency check on libhs via pkg-config.
Only supported on 64-bit platforms.

Includes documentation, MAINTAINERS entry, feature matrix, and
release notes.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 .mailmap                               |   1 +
 MAINTAINERS                            |   6 +
 doc/guides/regexdevs/features/hs.ini   |   8 ++
 doc/guides/regexdevs/hs.rst            | 187 +++++++++++++++++++++++++
 doc/guides/regexdevs/index.rst         |   1 +
 doc/guides/rel_notes/release_26_11.rst |  19 +++
 drivers/regex/hs/hs_regex.c            | 187 +++++++++++++++++++++++++
 drivers/regex/hs/hs_regex.h            |  69 +++++++++
 drivers/regex/hs/meson.build           |  19 +++
 drivers/regex/meson.build              |   1 +
 10 files changed, 498 insertions(+)
 create mode 100644 doc/guides/regexdevs/features/hs.ini
 create mode 100644 doc/guides/regexdevs/hs.rst
 create mode 100644 drivers/regex/hs/hs_regex.c
 create mode 100644 drivers/regex/hs/hs_regex.h
 create mode 100644 drivers/regex/hs/meson.build

diff --git a/.mailmap b/.mailmap
index fcb3d1b..8a8a6e4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1336,6 +1336,7 @@ Pravin Pathak <pravin.pathak.dev@gmail.com> <pravin.pathak@intel.com>
 Prince Takkar <ptakkar@marvell.com>
 Priyalee Kushwaha <priyalee.kushwaha@intel.com>
 Priyanka Jain <priyanka.jain@nxp.com>
+Prudvi Deti <prudvi.deti@intel.com>
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
 Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>
 Przemyslaw Czesnowicz <przemyslaw.czesnowicz@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d..e29af50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1433,6 +1433,12 @@ F: drivers/regex/cn9k/
 F: doc/guides/regexdevs/cn9k.rst
 F: doc/guides/regexdevs/features/cn9k.ini
 
+Intel Hyperscan
+M: Prudvi Deti <prudvi.deti@intel.com>
+F: drivers/regex/hs/
+F: doc/guides/regexdevs/hs.rst
+F: doc/guides/regexdevs/features/hs.ini
+
 NVIDIA mlx5
 M: Ori Kam <orika@nvidia.com>
 F: drivers/regex/mlx5/
diff --git a/doc/guides/regexdevs/features/hs.ini b/doc/guides/regexdevs/features/hs.ini
new file mode 100644
index 0000000..58cf4a2
--- /dev/null
+++ b/doc/guides/regexdevs/features/hs.ini
@@ -0,0 +1,8 @@
+;
+; Supported features of the 'hs' RegEx driver.
+;
+; Refer to default.ini for the full list of available driver features.
+;
+[Features]
+Run time compilation        = Y
+x86                         = Y
diff --git a/doc/guides/regexdevs/hs.rst b/doc/guides/regexdevs/hs.rst
new file mode 100644
index 0000000..dc22514
--- /dev/null
+++ b/doc/guides/regexdevs/hs.rst
@@ -0,0 +1,187 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2026 Intel Corporation
+
+Hyperscan RegEx PMD
+===================
+
+The Hyperscan RegEx PMD (**librte_regex_hs**) provides a poll mode
+regexdev driver backed by Intel's
+`Hyperscan <https://github.com/intel/hyperscan>`_ regular expression
+library. It is a software-only virtual device (vdev) PMD that
+implements the ``rte_regexdev`` API using Hyperscan block mode scanning.
+
+Features
+--------
+
+- Software-only virtual device (no hardware dependency)
+- Runtime pattern compilation via ``hs_compile_ext_multi()``
+- Serialized database import/export
+- Per-queue-pair scratch space for lock-free parallel scanning
+- Up to 64 queue pairs, each with up to 32768 descriptors
+- Up to 1,000,000 rules per device, with O(1) duplicate rule_id
+  detection backed by ``rte_hash``
+- Although Hyperscan supports 1,000,000 patterns, the current DPDK public API
+  limits match-result rule IDs to 20 bits. Rule IDs above ``0xFFFFF`` cannot
+  be represented without truncation.
+- Per-rule extended match parameters (minimum/maximum start offset)
+- Per-queue-pair statistics via xstats
+
+In the RegEx driver feature matrix, this PMD reports:
+
+- ``Run time compilation``
+- ``x86``
+
+Supported Regex Rule Flags (Hyperscan Mapping)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Standard DPDK flags (advertised via ``info->rule_flags``):
+
+- ``RTE_REGEX_PCRE_RULE_ALLOW_EMPTY_F`` (maps to ``HS_FLAG_ALLOWEMPTY``)
+- ``RTE_REGEX_PCRE_RULE_CASELESS_F``    (maps to ``HS_FLAG_CASELESS``)
+- ``RTE_REGEX_PCRE_RULE_DOTALL_F``      (maps to ``HS_FLAG_DOTALL``)
+- ``RTE_REGEX_PCRE_RULE_MULTILINE_F``   (maps to ``HS_FLAG_MULTILINE``)
+- ``RTE_REGEX_PCRE_RULE_UCP_F``         (maps to ``HS_FLAG_UCP``)
+- ``RTE_REGEX_PCRE_RULE_UTF_F``         (maps to ``HS_FLAG_UTF8``)
+
+PMD-private flags (accepted in ``rule_flags`` but not advertised;
+defined in ``drivers/regex/hs/hs_regex.h``):
+
+- ``HS_REGEX_RULE_SINGLEMATCH_F``  (bit 32, maps to ``HS_FLAG_SINGLEMATCH``)
+- ``HS_REGEX_RULE_PREFILTER_F``    (bit 33, maps to ``HS_FLAG_PREFILTER``)
+- ``HS_REGEX_RULE_SOM_LEFTMOST_F`` (bit 34, maps to ``HS_FLAG_SOM_LEFTMOST``)
+- ``HS_REGEX_RULE_COMBINATION_F``  (bit 35, maps to ``HS_FLAG_COMBINATION``)
+- ``HS_REGEX_RULE_QUIET_F``        (bit 36, maps to ``HS_FLAG_QUIET``)
+
+Unknown flag bits are rejected with an error during ``rule_db_update``.
+
+Extended Match Parameters
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Per-rule minimum and maximum start offset constraints (Hyperscan
+``hs_expr_ext_t``) can be encoded in the upper bits of ``rule_flags``:
+
+- Bits 37-49 (13 bits, mask ``0x1FFF``): maximum start offset,
+  mapped to ``HS_EXT_FLAG_MAX_OFFSET``.
+- Bits 50-63 (14 bits, mask ``0x3FFF``): minimum start offset,
+  mapped to ``HS_EXT_FLAG_MIN_OFFSET``.
+
+A value of 0 leaves the corresponding constraint disabled. These
+constraints are applied via ``hs_compile_ext_multi()`` during
+``rule_db_compile_activate``.
+
+Prerequisites
+-------------
+
+The Hyperscan library must be installed and discoverable via
+``pkg-config``. On Ubuntu/Debian and Fedora/RHEL, install Intel
+Hyperscan 5.4.2 from source:
+
+#. Install the build dependencies:
+
+  On Ubuntu/Debian:
+
+  .. code-block:: console
+
+    sudo apt install build-essential cmake curl libboost-dev pkg-config python3 ragel
+
+  On Fedora/RHEL:
+
+  .. code-block:: console
+
+    sudo dnf install boost-devel cmake curl gcc gcc-c++ make pkgconf-pkg-config python3 ragel
+
+#. Download the Intel Hyperscan 5.4.2 source archive:
+
+  .. code-block:: console
+
+    curl -LO https://github.com/intel/hyperscan/archive/refs/tags/v5.4.2.tar.gz
+
+#. Extract the archive:
+
+  .. code-block:: console
+
+    tar -xzf v5.4.2.tar.gz
+
+#. Build and install Hyperscan:
+
+  .. code-block:: console
+
+    cd hyperscan-5.4.2
+    cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON
+    cmake --build build --parallel
+    sudo cmake --install build
+    sudo ldconfig
+
+  Verify that version 5.4.2 is discoverable:
+
+  .. code-block:: console
+
+    PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig pkg-config --modversion libhs
+
+The PMD is built automatically when ``libhs`` is found by the meson
+build system.  It is only supported on 64-bit platforms.
+
+Device Setup
+------------
+
+The Hyperscan PMD is a virtual device.  Create it with the EAL
+``--vdev`` option::
+
+    dpdk-app --vdev regex_hs -- ...
+
+Or programmatically with ``rte_vdev_init()``::
+
+    rte_vdev_init("regex_hs", NULL);
+
+Device Lifecycle
+~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+    rte_regexdev_configure(dev, &cfg);
+    rte_regexdev_queue_pair_setup(dev, qp_id, &qp_conf);
+    rte_regexdev_rule_db_update(dev, rules, nb_rules);
+    rte_regexdev_rule_db_compile_activate(dev);
+    rte_regexdev_start(dev);
+
+    /* data path */
+    rte_regexdev_enqueue_burst(dev, qp, ops, n);
+    rte_regexdev_dequeue_burst(dev, qp, results, n);
+
+    rte_regexdev_stop(dev);
+    rte_regexdev_close(dev);
+
+Alternatively, a pre-compiled serialized database can be loaded
+during ``rte_regexdev_configure()`` via ``cfg.rule_db`` and
+``cfg.rule_db_len``, or at any time via ``rte_regexdev_rule_db_import()``.
+
+Statistics
+~~~~~~~~~~
+
+Extended statistics are reported per queue pair, with names of the
+form ``qp<N>_enqueued``, ``qp<N>_dequeued``, and ``qp<N>_matches``.
+All counters can be reset in bulk or selectively by stat id via
+``rte_regexdev_xstats_reset()``.
+
+Limitations
+-----------
+
+- ``RTE_REGEX_OPS_REQ_MATCH_HIGH_PRIORITY_F`` is not compatible with this
+  Hyperscan PMD and is not supported. DPDK requires ordering matches by rule
+  ID, start offset, and match length, while Hyperscan without SOM reports only
+  the match end offset.
+- Scanning is synchronous: ``enqueue_burst`` blocks until
+  ``hs_scan()`` completes for each operation.
+- Multi-segment mbufs are linearized (``rte_pktmbuf_linearize()``)
+  before scanning; linearization failure marks the op with
+  ``RTE_REGEX_OPS_RSP_RESOURCE_LIMIT_REACHED_F``.
+- Multi-process mode is not supported.
+- Each queue pair must be used by exactly one lcore
+  (single-producer/single-consumer model).
+
+Debugging Options
+-----------------
+
+Enable PMD debug logging with::
+
+    --log-level='pmd.regex.hs,8'
diff --git a/doc/guides/regexdevs/index.rst b/doc/guides/regexdevs/index.rst
index 4f928f9..bf4ca10 100644
--- a/doc/guides/regexdevs/index.rst
+++ b/doc/guides/regexdevs/index.rst
@@ -13,4 +13,5 @@ which can be used from an application through RegEx API.
 
    features_overview
    cn9k
+   hs
    mlx5
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc862..617d6ea 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -56,6 +56,25 @@ New Features
      =======================================================
 
 
+* **Added Hyperscan regex PMD.**
+
+  Added a new software regex PMD (``regex_hs``) based on Intel
+  Hyperscan library. The PMD is a virtual device created with
+  ``--vdev=regex_hs`` and implements the ``rte_regexdev`` API using
+  Hyperscan block mode scanning. Key capabilities include:
+
+  - Runtime pattern compilation via ``hs_compile_ext_multi()`` and
+    serialized database import/export
+  - Up to 64 queue pairs with per-queue-pair Hyperscan scratch space
+    for lock-free parallel scanning across multiple lcores
+  - Per-queue-pair extended statistics (enqueued, dequeued, matches)
+  - Support for standard DPDK PCRE rule flags and PMD-private
+    Hyperscan compile flags (singlematch, prefilter, SOM-leftmost,
+    combination, quiet)
+  - Per-rule extended match parameters (minimum/maximum start offset)
+  - Device lifecycle with start, stop, close, and device dump
+
+
 Removed Items
 -------------
 
diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
new file mode 100644
index 0000000..081e4b3
--- /dev/null
+++ b/drivers/regex/hs/hs_regex.c
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ *
+ * Intel Hyperscan PMD for DPDK rte_regexdev
+ *
+ * This Poll Mode Driver wraps Intel Hyperscan behind the standard DPDK
+ * regex device API (rte_regexdev). Applications use the enqueue/dequeue
+ * burst interface with Hyperscan as the matching engine.
+ *
+ * Key design:
+ *   - Synchronous scan in enqueue (hs_scan blocks until done)
+ *   - Per-queue-pair scratch space for lock-free parallel scanning
+ *   - HS_MODE_BLOCK: each buffer scanned independently
+ *   - Runtime compilation via hs_compile_ext_multi()
+ *   - Serialized database import/export via hs_deserialize_database()
+ */
+
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <rte_common.h>
+#include <rte_malloc.h>
+#include <rte_log.h>
+#include <rte_errno.h>
+#include <bus_vdev_driver.h>
+#include <rte_regexdev.h>
+#include <rte_regexdev_core.h>
+#include <rte_regexdev_driver.h>
+#include <rte_mbuf.h>
+
+#include <hs/hs.h>
+
+#include "hs_regex.h"
+
+RTE_LOG_REGISTER_DEFAULT(hs_regex_logtype, NOTICE);
+#define RTE_LOGTYPE_HS_REGEX hs_regex_logtype
+
+#define HS_LOG(level, ...) \
+	RTE_LOG_LINE(level, HS_REGEX, __VA_ARGS__)
+
+/* Device Info */
+static int
+hs_regex_info_get(struct rte_regexdev *dev __rte_unused,
+		  struct rte_regexdev_info *info)
+{
+	info->driver_name = HS_REGEX_DRIVER_NAME;
+	info->dev = NULL;
+	info->max_matches = UINT16_MAX;
+	info->max_queue_pairs = HS_REGEX_MAX_QUEUE_PAIRS;
+	info->max_payload_size = UINT16_MAX;
+	info->max_rules_per_group = HS_REGEX_MAX_RULES;
+	info->max_groups = HS_REGEX_MAX_GROUPS;
+	info->regexdev_capa = RTE_REGEXDEV_CAPA_RUNTIME_COMPILATION_F;
+	info->rule_flags = RTE_REGEX_PCRE_RULE_CASELESS_F |
+			   RTE_REGEX_PCRE_RULE_DOTALL_F |
+			   RTE_REGEX_PCRE_RULE_MULTILINE_F |
+			   RTE_REGEX_PCRE_RULE_UTF_F;
+
+	return 0;
+}
+
+/* Fast path stubs replaced by real implementations in later patches. */
+
+static uint16_t
+hs_regex_enqueue_burst(struct rte_regexdev *dev __rte_unused,
+		       uint16_t qp_id __rte_unused,
+		       struct rte_regex_ops **ops __rte_unused,
+		       uint16_t nb_ops __rte_unused)
+{
+	return 0;
+}
+
+static uint16_t
+hs_regex_dequeue_burst(struct rte_regexdev *dev __rte_unused,
+		       uint16_t qp_id __rte_unused,
+		       struct rte_regex_ops **ops __rte_unused,
+		       uint16_t nb_ops __rte_unused)
+{
+	return 0;
+}
+
+static const struct rte_regexdev_ops hs_regexdev_ops = {
+	.dev_info_get = hs_regex_info_get,
+};
+
+/* Device Lifecycle */
+
+int
+hs_regex_dev_create(const char *name, struct rte_device *device)
+{
+	struct hs_regex_priv *priv;
+	struct rte_regexdev *dev;
+
+	if (name == NULL || device == NULL)
+		return -EINVAL;
+
+	HS_LOG(INFO, "Creating Hyperscan regex device: %s", name);
+
+	priv = rte_zmalloc("hs_regex_priv", sizeof(*priv),
+			   RTE_CACHE_LINE_SIZE);
+	if (!priv) {
+		HS_LOG(ERR, "Failed to allocate private data");
+		return -ENOMEM;
+	}
+
+	dev = rte_regexdev_register(name);
+	if (!dev) {
+		HS_LOG(ERR, "Failed to register regex device %s", name);
+		rte_free(priv);
+		return -EINVAL;
+	}
+
+	dev->dev_ops = &hs_regexdev_ops;
+	dev->enqueue = hs_regex_enqueue_burst;
+	dev->dequeue = hs_regex_dequeue_burst;
+	dev->device = device;
+	dev->data->dev_private = priv;
+	dev->state = RTE_REGEXDEV_READY;
+
+	HS_LOG(INFO, "Hyperscan regex PMD created (dev_id=%u, hs=%s)",
+	       dev->data->dev_id, hs_version());
+	return dev->data->dev_id;
+}
+
+void
+hs_regex_dev_destroy(const char *name)
+{
+	struct rte_regexdev *dev;
+	struct hs_regex_priv *priv;
+
+	if (name == NULL)
+		return;
+
+	dev = rte_regexdev_get_device_by_name(name);
+	if (!dev)
+		return;
+
+	priv = dev->data->dev_private;
+	if (priv) {
+		rte_free(priv);
+		dev->data->dev_private = NULL;
+	}
+
+	rte_regexdev_unregister(dev);
+	HS_LOG(INFO, "Hyperscan regex PMD destroyed: %s", name);
+}
+
+static int
+hs_regex_probe(struct rte_vdev_device *vdev)
+{
+	const char *name;
+	int ret;
+
+	name = rte_vdev_device_name(vdev);
+	if (name == NULL)
+		return -EINVAL;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		HS_LOG(ERR, "Multi-process not supported for %s", name);
+		return -EINVAL;
+	}
+
+	ret = hs_regex_dev_create(name, &vdev->device);
+	return ret < 0 ? ret : 0;
+}
+
+static int
+hs_regex_remove(struct rte_vdev_device *vdev)
+{
+	const char *name;
+
+	name = rte_vdev_device_name(vdev);
+	if (name == NULL)
+		return -EINVAL;
+
+	hs_regex_dev_destroy(name);
+	return 0;
+}
+
+static struct rte_vdev_driver hs_regex_pmd_drv = {
+	.probe = hs_regex_probe,
+	.remove = hs_regex_remove,
+};
+
+RTE_PMD_REGISTER_VDEV(regex_hs, hs_regex_pmd_drv);
+RTE_PMD_REGISTER_PARAM_STRING(regex_hs, "");
diff --git a/drivers/regex/hs/hs_regex.h b/drivers/regex/hs/hs_regex.h
new file mode 100644
index 0000000..be4c2e9
--- /dev/null
+++ b/drivers/regex/hs/hs_regex.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef HS_REGEX_H
+#define HS_REGEX_H
+
+#include <rte_regexdev.h>
+#include <hs/hs.h>
+
+#define HS_REGEX_DRIVER_NAME "regex_hs"
+#define HS_REGEX_INITIAL_RULES_CAP 64
+#define HS_REGEX_MAX_QUEUE_PAIRS 64
+#define HS_REGEX_MAX_GROUPS 64
+#define HS_REGEX_MAX_RULES 1000000
+#define HS_REGEX_DEFAULT_NB_DESC 1024
+#define HS_REGEX_MAX_NB_DESC 32768
+
+/* Device lifecycle state machine. */
+enum hs_regex_dev_state {
+	HS_REGEX_DEV_CREATED = 0,
+	HS_REGEX_DEV_CONFIGURED,
+	HS_REGEX_DEV_STARTED,
+	HS_REGEX_DEV_STOPPED,
+};
+
+/* Per-rule entry stored before compilation */
+struct hs_regex_rule {
+	char *pattern;
+	uint32_t rule_id;
+	uint16_t group_id;
+	uint64_t rule_flags;
+};
+
+/* Queue pair */
+struct hs_regex_qp {
+	struct rte_regex_ops **ops;
+	uint16_t nb_desc;
+	uint16_t head;
+	uint16_t tail;
+	uint16_t count;
+	hs_scratch_t *scratch;
+	uint64_t qp_enqueued;
+	uint64_t qp_dequeued;
+	uint64_t qp_matches;
+};
+
+/* Per-device private data */
+struct hs_regex_priv {
+	struct hs_regex_rule *rules;
+	uint32_t nb_rules;
+	uint32_t rules_cap;
+
+	hs_database_t *db;
+	int db_compiled;
+
+	struct hs_regex_qp *qps;
+	uint16_t nb_queue_pairs;
+
+	uint16_t max_matches;
+	uint16_t nb_groups;
+
+	enum hs_regex_dev_state dev_state;
+};
+
+int hs_regex_dev_create(const char *name, struct rte_device *device);
+void hs_regex_dev_destroy(const char *name);
+
+#endif /* HS_REGEX_H */
diff --git a/drivers/regex/hs/meson.build b/drivers/regex/hs/meson.build
new file mode 100644
index 0000000..5c855f4
--- /dev/null
+++ b/drivers/regex/hs/meson.build
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Intel Corporation
+
+if not dpdk_conf.get('RTE_ARCH_64')
+    build = false
+    reason = 'only supported on 64-bit platforms'
+    subdir_done()
+endif
+
+hs_dep = dependency('libhs', required: false)
+if not hs_dep.found()
+    build = false
+    reason = 'missing dependency, "libhs"'
+    subdir_done()
+endif
+
+sources = files('hs_regex.c')
+deps += ['bus_vdev', 'hash']
+ext_deps += hs_dep
diff --git a/drivers/regex/meson.build b/drivers/regex/meson.build
index ff2a8fe..d5a378b 100644
--- a/drivers/regex/meson.build
+++ b/drivers/regex/meson.build
@@ -2,6 +2,7 @@
 # Copyright 2020 Mellanox Technologies, Ltd
 
 drivers = [
+        'hs',
         'mlx5',
         'cn9k',
 ]
-- 
2.43.0

