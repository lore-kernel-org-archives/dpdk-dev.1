Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70943C282CD
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Mar 2025 14:57:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48AFD402D2;
	Mon,  3 Mar 2025 15:57:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id CAD66400D7
 for <dev@dpdk.org>; Mon,  3 Mar 2025 15:57:19 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42101106F;
 Mon,  3 Mar 2025 06:57:33 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.64.81])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 700D93F66E;
 Mon,  3 Mar 2025 06:57:18 -0800 (PST)
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 1/7] dts: add tests package to API docs
Date: Mon,  3 Mar 2025 16:57:03 +0200
Message-ID: <20250303145709.126126-2-Luca.Vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303145709.126126-1-Luca.Vizzarro@arm.com>
References: <20241108134532.130681-1-luca.vizzarro@arm.com>
 <20250303145709.126126-1-Luca.Vizzarro@arm.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

The test suites are not documented in the API as their respective
documentation files are missing.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
 doc/api/dts/index.rst                                 |  1 +
 doc/api/dts/tests.TestSuite_blocklist.rst             |  8 ++++++++
 doc/api/dts/tests.TestSuite_checksum_offload.rst      |  8 ++++++++
 doc/api/dts/tests.TestSuite_dual_vlan.rst             |  8 ++++++++
 doc/api/dts/tests.TestSuite_dynamic_config.rst        |  8 ++++++++
 doc/api/dts/tests.TestSuite_dynamic_queue_conf.rst    |  8 ++++++++
 doc/api/dts/tests.TestSuite_hello_world.rst           |  8 ++++++++
 doc/api/dts/tests.TestSuite_l2fwd.rst                 |  8 ++++++++
 doc/api/dts/tests.TestSuite_mac_filter.rst            |  8 ++++++++
 doc/api/dts/tests.TestSuite_mtu.rst                   |  8 ++++++++
 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst    |  8 ++++++++
 ...ests.TestSuite_port_restart_config_persistency.rst |  8 ++++++++
 doc/api/dts/tests.TestSuite_promisc_support.rst       |  8 ++++++++
 doc/api/dts/tests.TestSuite_queue_start_stop.rst      |  8 ++++++++
 doc/api/dts/tests.TestSuite_smoke_tests.rst           |  8 ++++++++
 doc/api/dts/tests.TestSuite_softnic.rst               |  8 ++++++++
 doc/api/dts/tests.TestSuite_uni_pkt.rst               |  8 ++++++++
 doc/api/dts/tests.TestSuite_vlan.rst                  |  8 ++++++++
 doc/api/dts/tests.rst                                 | 11 +++++++++++
 19 files changed, 148 insertions(+)
 create mode 100644 doc/api/dts/tests.TestSuite_blocklist.rst
 create mode 100644 doc/api/dts/tests.TestSuite_checksum_offload.rst
 create mode 100644 doc/api/dts/tests.TestSuite_dual_vlan.rst
 create mode 100644 doc/api/dts/tests.TestSuite_dynamic_config.rst
 create mode 100644 doc/api/dts/tests.TestSuite_dynamic_queue_conf.rst
 create mode 100644 doc/api/dts/tests.TestSuite_hello_world.rst
 create mode 100644 doc/api/dts/tests.TestSuite_l2fwd.rst
 create mode 100644 doc/api/dts/tests.TestSuite_mac_filter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_mtu.rst
 create mode 100644 doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
 create mode 100644 doc/api/dts/tests.TestSuite_port_restart_config_persistency.rst
 create mode 100644 doc/api/dts/tests.TestSuite_promisc_support.rst
 create mode 100644 doc/api/dts/tests.TestSuite_queue_start_stop.rst
 create mode 100644 doc/api/dts/tests.TestSuite_smoke_tests.rst
 create mode 100644 doc/api/dts/tests.TestSuite_softnic.rst
 create mode 100644 doc/api/dts/tests.TestSuite_uni_pkt.rst
 create mode 100644 doc/api/dts/tests.TestSuite_vlan.rst
 create mode 100644 doc/api/dts/tests.rst

diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index 33b05953d2..a11f395e11 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -14,6 +14,7 @@ Packages
    :includehidden:
    :maxdepth: 1
 
+   tests
    framework.testbed_model
    framework.remote_session
    framework.params
diff --git a/doc/api/dts/tests.TestSuite_blocklist.rst b/doc/api/dts/tests.TestSuite_blocklist.rst
new file mode 100644
index 0000000000..8d032786a0
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_blocklist.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+blocklist Test Suite
+====================
+
+.. automodule:: tests.TestSuite_blocklist
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_checksum_offload.rst b/doc/api/dts/tests.TestSuite_checksum_offload.rst
new file mode 100644
index 0000000000..8eea87f2e9
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_checksum_offload.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+checksum_offload Test Suite
+===========================
+
+.. automodule:: tests.TestSuite_checksum_offload
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_dual_vlan.rst b/doc/api/dts/tests.TestSuite_dual_vlan.rst
new file mode 100644
index 0000000000..22d8c7195f
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_dual_vlan.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+dual_vlan Test Suite
+====================
+
+.. automodule:: tests.TestSuite_dual_vlan
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_dynamic_config.rst b/doc/api/dts/tests.TestSuite_dynamic_config.rst
new file mode 100644
index 0000000000..268ef499b6
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_dynamic_config.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+dynamic_config Test Suite
+=========================
+
+.. automodule:: tests.TestSuite_dynamic_config
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_dynamic_queue_conf.rst b/doc/api/dts/tests.TestSuite_dynamic_queue_conf.rst
new file mode 100644
index 0000000000..c142b9dc40
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_dynamic_queue_conf.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+dynamic_queue_conf Test Suite
+=============================
+
+.. automodule:: tests.TestSuite_dynamic_queue_conf
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_hello_world.rst b/doc/api/dts/tests.TestSuite_hello_world.rst
new file mode 100644
index 0000000000..10db998987
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_hello_world.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+hello_world Test Suite
+======================
+
+.. automodule:: tests.TestSuite_hello_world
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_l2fwd.rst b/doc/api/dts/tests.TestSuite_l2fwd.rst
new file mode 100644
index 0000000000..5a0ca312e9
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_l2fwd.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+l2fwd Test Suite
+================
+
+.. automodule:: tests.TestSuite_l2fwd
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_mac_filter.rst b/doc/api/dts/tests.TestSuite_mac_filter.rst
new file mode 100644
index 0000000000..a65aaeac0b
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_mac_filter.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+mac_filter Test Suite
+=====================
+
+.. automodule:: tests.TestSuite_mac_filter
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_mtu.rst b/doc/api/dts/tests.TestSuite_mtu.rst
new file mode 100644
index 0000000000..6e8cb808da
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_mtu.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+mtu Test Suite
+==============
+
+.. automodule:: tests.TestSuite_mtu
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst b/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
new file mode 100644
index 0000000000..cdf30fd879
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_pmd_buffer_scatter.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+pmd_buffer_scatter Test Suite
+=============================
+
+.. automodule:: tests.TestSuite_pmd_buffer_scatter
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_port_restart_config_persistency.rst b/doc/api/dts/tests.TestSuite_port_restart_config_persistency.rst
new file mode 100644
index 0000000000..2db4754a01
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_port_restart_config_persistency.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+port_restart_config_persistency Test Suite
+==========================================
+
+.. automodule:: tests.TestSuite_port_restart_config_persistency
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_promisc_support.rst b/doc/api/dts/tests.TestSuite_promisc_support.rst
new file mode 100644
index 0000000000..496ee01f2f
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_promisc_support.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+promisc_support Test Suite
+==========================
+
+.. automodule:: tests.TestSuite_promisc_support
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_queue_start_stop.rst b/doc/api/dts/tests.TestSuite_queue_start_stop.rst
new file mode 100644
index 0000000000..87121676fb
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_queue_start_stop.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+queue_start_stop Test Suite
+===========================
+
+.. automodule:: tests.TestSuite_queue_start_stop
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_smoke_tests.rst b/doc/api/dts/tests.TestSuite_smoke_tests.rst
new file mode 100644
index 0000000000..8c78c3025a
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_smoke_tests.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+smoke_tests Test Suite
+======================
+
+.. automodule:: tests.TestSuite_smoke_tests
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_softnic.rst b/doc/api/dts/tests.TestSuite_softnic.rst
new file mode 100644
index 0000000000..a091f265ea
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_softnic.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+softnic Test Suite
+==================
+
+.. automodule:: tests.TestSuite_softnic
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_uni_pkt.rst b/doc/api/dts/tests.TestSuite_uni_pkt.rst
new file mode 100644
index 0000000000..95c5a5a28b
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_uni_pkt.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+uni_pkt Test Suite
+==================
+
+.. automodule:: tests.TestSuite_uni_pkt
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.TestSuite_vlan.rst b/doc/api/dts/tests.TestSuite_vlan.rst
new file mode 100644
index 0000000000..dfbe6196fd
--- /dev/null
+++ b/doc/api/dts/tests.TestSuite_vlan.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+vlan Test Suite
+===============
+
+.. automodule:: tests.TestSuite_vlan
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/tests.rst b/doc/api/dts/tests.rst
new file mode 100644
index 0000000000..fdfa6c1f8d
--- /dev/null
+++ b/doc/api/dts/tests.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+Test Suites
+===========
+
+.. toctree::
+   :glob:
+   :hidden:
+   :maxdepth: 1
+
+   tests.*
-- 
2.43.0

