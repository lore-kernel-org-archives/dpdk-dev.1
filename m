Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B033FC624D3
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 18:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3238F42709;
	Wed,  2 Sep 2026 20:14:01 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id DE9D241153
 for <dev@dpdk.org>; Wed,  2 Sep 2026 20:13:59 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-90e7c71f86eso10718146d6.1
 for <dev@dpdk.org>; Wed, 02 Sep 2026 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1788372839; x=1788977639; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KxHsC/HskgtROegwj309L/D2uN3VBLhIDXOjnMcGVWQ=;
 b=HOny4Ol8C498UrSUqyY5UkrNgqVJlZDILWJzKPvhi1Ku/4qxYWyOCSBGG4GK4RUcd3
 Hs0Uj9eMP5qKV4imJuLy/pfDB67xUFuw7oV+hC9juqoX4hSiKVcIZ+47MuwfIIvFuOYo
 05mVseBhStRSw8CxUHjPDITT09UcohCjX0NV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372839; x=1788977639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KxHsC/HskgtROegwj309L/D2uN3VBLhIDXOjnMcGVWQ=;
 b=ICTLkzhqkb1Mk2A4g+Nqv9VMra6gvmUWG6LKLm92JctFkQesT/xiGzQoKawxfM3Vsq
 5gH48AeaYKXr4XUvWgbcaLOTZWEI8Fcnk8BBVIkLog5n+HVmvPI9LMlCm40Cevj2Q/4D
 jKycbMFBpVaAIlvMawe89sTvghI5dUAQPkT5nDryoc+wPQZlmZ9p2HhTFJiSPPBSOTxM
 kmGIfYBmGrhMaf1x9OF6v+Txtqjpsyb2B/hsZcCLs+ezkT8Bn8iA7NsrZvtTKr4oSjjl
 ECiCutC+JU6twGPywdyE52EE+H+ms07/U9PiKrx4UPl6Bbv8UdlxlnmuL+cE9Cdl60Xz
 7wWQ==
X-Gm-Message-State: AFuF++mFyTydWFNWs9LPd8hB+gaH0CB8P6F9uHE79ByqiGLUHAm73vjy
 Q9nRLQWReygFG9c6B8/S9zZmtImv2ooJvXAvPk5PnwOg51GtFRKjIXhZH7VPQts/Pv5RdkK7765
 pv2gxwJtpsLSjXDhyYk4+pmYp/jSaNergk3oFBTujtRdGiWZwFFD8bNJQuDXpmVTdhEOQgi0j53
 V9326WCmBTmc9EhE/WjJElfXkOMkM=
X-Gm-Gg: AYBFou1VYPpIzRkieL1LsI0kffYv4efIt2RMLPgIiJ1a+rPGkhxoRo3ZIjiDcbXjNfK
 uDsOjXHYlJZunpNnRthDj1S4P9IYN/w7mM/dxvY4CZK47S9EOLSUsXfQcgt1ABXQr1Homg99t/R
 xFchaOxd9F2AnUpYbWDBQKo/L7mgUAT3oPUv6zPMSemxcz8IpJnZqndPb02gvVIMbjV888L1Hpe
 x0Fu6/5Ek4tJDzOA+O6TxwBMbDZW+Kx51/8JKWaIw5xfhDRoyuFBE/MQU4utEya5r6gR3pBJ6he
 Z+hygkuOJM9PMgHf7CKy9ZpOyc6YcsMUx6kGiCMMVfi+rUiodmBg3oBFgjoUb2Zi2FQMmbwB8mv
 3Fvz0OBG3QzHwES0AqvLQAi21vdbNrJjj+Tt3UDaMfaqWmUif2Hl1goJ8dihjrrTlrmxzavVEU1
 8cwDeaMl3ylAdFoedNbot5t+o8zEK8yLhtzsbtDFwdQybs/WDBAoLzCeclRdfzPrj5ww1E1cNrG
 5qx7exObiM=
X-Received: by 2002:ac8:598e:0:b0:530:4fd:fdad with SMTP id
 d75a77b69052e-53036d498afmr72675811cf.39.1788372838619; 
 Wed, 02 Sep 2026 11:13:58 -0700 (PDT)
Received: from d121029.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530331d9cbcsm24660101cf.16.2026.09.02.11.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 11:13:57 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 6/8] dts: move testbed model from framework to API
Date: Wed,  2 Sep 2026 14:13:30 -0400
Message-ID: <20260902181333.461556-7-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902181333.461556-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260902181333.461556-1-abailey@iol.unh.edu>
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

Multiple test suites import modules from testbed model
in the framework. Move this directory to the API.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 ...y.rst => api.testbed_model.capability.rst} |  2 +-
 ...el.port.rst => api.testbed_model.port.rst} |  2 +-
 ...t => api.testbed_model.virtual_device.rst} |  2 +-
 doc/api/dts/framework.testbed_model.rst       | 11 ++++--
 dts/api/capabilities.py                       |  8 ++---
 dts/api/context.py                            |  2 +-
 .../testbed_model/capability.py               |  6 ++--
 dts/api/testbed_model/cpu.py                  | 36 +++++++++++++++++++
 dts/{framework => api}/testbed_model/port.py  |  2 +-
 .../capturing_traffic_generator.py            |  2 +-
 .../traffic_generator/traffic_generator.py    |  2 +-
 .../testbed_model/virtual_device.py           |  0
 dts/framework/context.py                      |  2 +-
 dts/framework/params/eal.py                   |  6 ++--
 dts/framework/params/types.py                 |  6 ++--
 dts/framework/remote_session/dpdk.py          |  2 +-
 dts/framework/remote_session/dpdk_shell.py    |  2 +-
 dts/framework/test_run.py                     | 10 +++---
 dts/framework/test_suite.py                   |  2 +-
 dts/framework/testbed_model/linux_session.py  |  3 +-
 dts/framework/testbed_model/node.py           |  2 +-
 dts/framework/testbed_model/os_session.py     |  2 +-
 dts/framework/testbed_model/topology.py       |  3 +-
 .../testbed_model/traffic_generator/scapy.py  |  2 +-
 dts/tests/TestSuite_blocklist.py              |  2 +-
 dts/tests/TestSuite_cryptodev_latency.py      |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py   |  2 +-
 dts/tests/TestSuite_l2fwd.py                  |  2 +-
 dts/tests/TestSuite_packet_capture.py         |  2 +-
 dts/tests/TestSuite_softnic.py                |  2 +-
 dts/tests/TestSuite_virtio_forward.py         |  2 +-
 31 files changed, 85 insertions(+), 46 deletions(-)
 rename doc/api/dts/{framework.testbed_model.capability.rst => api.testbed_model.capability.rst} (74%)
 rename doc/api/dts/{framework.testbed_model.port.rst => api.testbed_model.port.rst} (77%)
 rename doc/api/dts/{framework.testbed_model.virtual_device.rst => api.testbed_model.virtual_device.rst} (72%)
 rename dts/{framework => api}/testbed_model/capability.py (99%)
 create mode 100644 dts/api/testbed_model/cpu.py
 rename dts/{framework => api}/testbed_model/port.py (98%)
 rename dts/{framework => api}/testbed_model/virtual_device.py (100%)

diff --git a/doc/api/dts/framework.testbed_model.capability.rst b/doc/api/dts/api.testbed_model.capability.rst
similarity index 74%
rename from doc/api/dts/framework.testbed_model.capability.rst
rename to doc/api/dts/api.testbed_model.capability.rst
index fab91cad83..88e396dddb 100644
--- a/doc/api/dts/framework.testbed_model.capability.rst
+++ b/doc/api/dts/api.testbed_model.capability.rst
@@ -3,6 +3,6 @@
 capability - Testbed Capabilities
 =================================
 
-.. automodule:: framework.testbed_model.capability
+.. automodule:: api.testbed_model.capability
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.port.rst b/doc/api/dts/api.testbed_model.port.rst
similarity index 77%
rename from doc/api/dts/framework.testbed_model.port.rst
rename to doc/api/dts/api.testbed_model.port.rst
index fdb7ca8a1d..d64501aef0 100644
--- a/doc/api/dts/framework.testbed_model.port.rst
+++ b/doc/api/dts/api.testbed_model.port.rst
@@ -3,7 +3,7 @@
 port - NIC Port Representation
 ==============================
 
-.. automodule:: framework.testbed_model.port
+.. automodule:: api.testbed_model.port
    :members:
    :show-inheritance:
    :noindex:
diff --git a/doc/api/dts/framework.testbed_model.virtual_device.rst b/doc/api/dts/api.testbed_model.virtual_device.rst
similarity index 72%
rename from doc/api/dts/framework.testbed_model.virtual_device.rst
rename to doc/api/dts/api.testbed_model.virtual_device.rst
index a6b0420e75..97adc895f6 100644
--- a/doc/api/dts/framework.testbed_model.virtual_device.rst
+++ b/doc/api/dts/api.testbed_model.virtual_device.rst
@@ -3,6 +3,6 @@
 virtual\_device - Virtual Devices
 =================================
 
-.. automodule:: framework.testbed_model.virtual_device
+.. automodule:: api.testbed_model.virtual_device
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.testbed_model.rst b/doc/api/dts/framework.testbed_model.rst
index f6fb410133..2c905d735e 100644
--- a/doc/api/dts/framework.testbed_model.rst
+++ b/doc/api/dts/framework.testbed_model.rst
@@ -7,6 +7,11 @@ testbed\_model - Testbed Modelling Package
    :members:
    :show-inheritance:
 
+.. automodule:: api.testbed_model
+   :members:
+   :noindex:
+   :show-inheritance:
+
 .. toctree::
    :hidden:
    :maxdepth: 1
@@ -15,8 +20,8 @@ testbed\_model - Testbed Modelling Package
    framework.testbed_model.linux_session
    framework.testbed_model.posix_session
    framework.testbed_model.node
-   framework.testbed_model.capability
+   api.testbed_model.capability
    framework.testbed_model.cpu
-   framework.testbed_model.port
+   api.testbed_model.port
    framework.testbed_model.topology
-   framework.testbed_model.virtual_device
+   api.testbed_model.virtual_device
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index b0c1d81d36..8ed832a588 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -23,7 +23,7 @@
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import LinkTopology, requires_link_topology
+        from api.testbed_model.capability import LinkTopology, requires_link_topology
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
@@ -34,7 +34,7 @@ def hello_world_single_core(self):
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import NicCapability, requires_nic_capability
+        from api.testbed_model.capability import NicCapability, requires_nic_capability
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
@@ -237,7 +237,7 @@ def requires_link_topology(
     Returns:
         The decorated test case or test suite.
     """
-    from framework.testbed_model.capability import TopologyCapability
+    from api.testbed_model.capability import TopologyCapability
 
     def add_required_topology(
         test_case_or_suite: type["TestProtocol"],
@@ -260,7 +260,7 @@ def requires_nic_capability(
     Returns:
         The decorated test case or test suite.
     """
-    from framework.testbed_model.capability import DecoratedNicCapability
+    from api.testbed_model.capability import DecoratedNicCapability
 
     def add_required_capability(
         test_case_or_suite: type["TestProtocol"],
diff --git a/dts/api/context.py b/dts/api/context.py
index a3cee7f17a..e4988b42a4 100644
--- a/dts/api/context.py
+++ b/dts/api/context.py
@@ -5,11 +5,11 @@
 
 from collections.abc import Callable
 
+from api.testbed_model.capability import TestProtocol
 from framework.context import Context
 from framework.context import filter_cores as _filter_cores
 from framework.context import get_ctx as _get_ctx
 from framework.context import init_ctx as _init_ctx
-from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
 
 
diff --git a/dts/framework/testbed_model/capability.py b/dts/api/testbed_model/capability.py
similarity index 99%
rename from dts/framework/testbed_model/capability.py
rename to dts/api/testbed_model/capability.py
index 00b40a3b1e..06ffda673f 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/api/testbed_model/capability.py
@@ -26,7 +26,7 @@
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import LinkTopology, requires
+        from api.testbed_model.capability import LinkTopology, requires
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
@@ -37,7 +37,7 @@ def hello_world_single_core(self):
     .. code:: python
 
         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import NicCapability, requires
+        from api.testbed_model.capability import NicCapability, requires
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
@@ -65,9 +65,9 @@ def test_scatter_mbuf_2048(self):
 
 from api.capabilities import LinkTopology, NicCapability
 from api.exception import ConfigurationError, InternalError, SkippedTestException
+from api.testbed_model.port import DriverKind
 from framework.logger import get_dts_logger
 from framework.testbed_model.node import Node
-from framework.testbed_model.port import DriverKind
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
diff --git a/dts/api/testbed_model/cpu.py b/dts/api/testbed_model/cpu.py
new file mode 100644
index 0000000000..cfe7a396b0
--- /dev/null
+++ b/dts/api/testbed_model/cpu.py
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2023 PANTHEON.tech s.r.o.
+# Copyright(c) 2025 Arm Limited
+
+"""CPU core representation and filtering.
+
+This module provides a unified representation of logical CPU cores along
+with filtering capabilities.
+
+When symmetric multiprocessing (SMP or multithreading) is enabled on a server,
+the physical CPU cores are split into logical CPU cores with different IDs.
+
+:class:`LogicalCoreCountFilter` filters by the number of logical cores. It's possible to specify
+the socket from which to filter the number of logical cores. It's also possible to not use all
+logical CPU cores from each physical core (e.g. only the first logical core of each physical core).
+
+:class:`LogicalCoreListFilter` filters by logical core IDs. This mostly checks that
+the logical cores are actually present on the server.
+"""
+
+from framework.testbed_model.cpu import LogicalCoreCount as LocgicalCoreCountBase
+from framework.testbed_model.cpu import LogicalCoreList as LogicalCoreListBase
+
+
+class LogicalCoreList(LogicalCoreListBase):
+    r"""A unified way to store :class:`LogicalCore`\s.
+
+    Create a unified format used across the framework and allow the user to use
+    either a :class:`str` representation (using ``str(instance)`` or directly in f-strings)
+    or a :class:`list` representation (by accessing the `lcore_list` property,
+    which stores logical core IDs).
+    """
+
+
+class LogicalCoreCount(LocgicalCoreCountBase):
+    """Define the number of logical cores per physical cores per sockets."""
diff --git a/dts/framework/testbed_model/port.py b/dts/api/testbed_model/port.py
similarity index 98%
rename from dts/framework/testbed_model/port.py
rename to dts/api/testbed_model/port.py
index aea3e59c25..ebae7e9bb5 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/api/testbed_model/port.py
@@ -16,7 +16,7 @@
 from framework.config.node import PortConfig
 
 if TYPE_CHECKING:
-    from .node import Node
+    from framework.testbed_model.node import Node
 
 DriverKind = Literal["kernel", "dpdk"]
 """The driver kind."""
diff --git a/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
index dbe0e72c0f..13a13abaad 100644
--- a/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -17,9 +17,9 @@
 from scapy.packet import Packet
 
 from api.artifact import Artifact
+from api.testbed_model.port import Port
 from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 from api.utils import get_packet_summaries
-from framework.testbed_model.port import Port
 
 
 def _get_default_capture_name() -> str:
diff --git a/dts/api/testbed_model/traffic_generator/traffic_generator.py b/dts/api/testbed_model/traffic_generator/traffic_generator.py
index fedce77fdf..bb5ba02f6e 100644
--- a/dts/api/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/traffic_generator.py
@@ -13,10 +13,10 @@
 
 from scapy.packet import Packet
 
+from api.testbed_model.port import Port
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
 from framework.testbed_model.topology import Topology
 
 
diff --git a/dts/framework/testbed_model/virtual_device.py b/dts/api/testbed_model/virtual_device.py
similarity index 100%
rename from dts/framework/testbed_model/virtual_device.py
rename to dts/api/testbed_model/virtual_device.py
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 6ebe4e0249..7ec8ac4857 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -16,10 +16,10 @@
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
+    from api.testbed_model.capability import TestProtocol
     from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
     from framework.test_suite import TestCase, TestSuite
-    from framework.testbed_model.capability import TestProtocol
 
 P = ParamSpec("P")
 
diff --git a/dts/framework/params/eal.py b/dts/framework/params/eal.py
index e84a20f02f..86bfd3fcc6 100644
--- a/dts/framework/params/eal.py
+++ b/dts/framework/params/eal.py
@@ -6,12 +6,12 @@
 from dataclasses import dataclass, field
 from typing import TYPE_CHECKING, Literal
 
+from api.testbed_model.cpu import LogicalCoreList
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.params import Params, Switch
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.virtual_device import VirtualDevice
 
 if TYPE_CHECKING:
-    from framework.testbed_model.port import Port
+    from api.testbed_model.port import Port
 
 
 def _port_to_pci(port: "Port") -> str:
diff --git a/dts/framework/params/types.py b/dts/framework/params/types.py
index a9f3749083..f9a51963a2 100644
--- a/dts/framework/params/types.py
+++ b/dts/framework/params/types.py
@@ -32,6 +32,9 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TestType,
     TLSVersion,
 )
+from api.testbed_model.cpu import LogicalCoreList
+from api.testbed_model.port import Port
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd.config import (
     AnonMempoolAllocationMode,
     EthPeer,
@@ -55,9 +58,6 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
 )
 from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
 from framework.params import Switch, YesNoSwitch
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.port import Port
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 class EalParamsDict(TypedDict, total=False):
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 2d8bc7844e..999cfcc056 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -16,6 +16,7 @@
 from api.capabilities import LinkTopology
 from api.context import get_ctx
 from api.exception import ConfigurationError, RemoteFileNotFoundError
+from api.testbed_model.virtual_device import VirtualDevice
 from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.test_run import (
     DPDKBuildConfiguration,
@@ -35,7 +36,6 @@
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 @dataclass(slots=True, frozen=True)
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index a8f169787c..b807f9bdae 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -11,12 +11,12 @@
 from pathlib import PurePath
 
 from api.context import get_ctx
+from api.testbed_model.cpu import LogicalCoreList
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
     only_active,
 )
-from framework.testbed_model.cpu import LogicalCoreList
 
 
 def compute_eal_params(
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 8b9ae4a49a..63f1145fe3 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -110,17 +110,17 @@
 from api.capabilities import LinkTopology
 from api.context import Context, init_ctx
 from api.exception import InternalError, SkippedTestException, TestCaseVerifyError
+from api.testbed_model.capability import (
+    Capability,
+    get_supported_capabilities,
+    test_if_supported,
+)
 from framework.config.test_run import TestRunConfiguration
 from framework.logger import DTSLogger, get_dts_logger
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
 from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
-from framework.testbed_model.capability import (
-    Capability,
-    get_supported_capabilities,
-    test_if_supported,
-)
 from framework.testbed_model.node import Node
 from framework.testbed_model.topology import PortLink, Topology
 from framework.testbed_model.traffic_generator import create_traffic_generator
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 6066f7a77a..ac30d57ac9 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -30,9 +30,9 @@
 from typing_extensions import Self
 
 from api.exception import ConfigurationError, InternalError
+from api.testbed_model.capability import TestProtocol
 from api.utils import to_pascal_case
 from framework.config.common import FrozenModel
-from framework.testbed_model.capability import TestProtocol
 from framework.testbed_model.topology import Topology
 
 from .logger import DTSLogger, get_dts_logger
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 13dce6455d..8cc0d09d01 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -24,11 +24,10 @@
     RemoteCommandExecutionError,
 )
 from api.testbed_model.linux_session import LinuxSession as LinuxSessionBase
+from api.testbed_model.port import Port, PortInfo
 from api.utils import expand_range
-from framework.testbed_model.port import PortInfo
 
 from .cpu import LogicalCore
-from .port import Port
 from .posix_session import PosixSession
 
 
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 40dd7f0666..115d5955d3 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -18,6 +18,7 @@
 from typing import Literal, TypeAlias
 
 from api.exception import ConfigurationError, InternalError
+from api.testbed_model.port import Port
 from framework.config.node import (
     OS,
     NodeConfiguration,
@@ -27,7 +28,6 @@
 from .cpu import Architecture, LogicalCore
 from .linux_session import LinuxSession
 from .os_session import OSSession, OSSessionInfo
-from .port import Port
 
 
 class Node:
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 85a3e36bf4..3f588acd44 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -29,6 +29,7 @@
 from enum import Flag, auto
 from pathlib import Path, PurePath, PurePosixPath
 
+from api.testbed_model.port import Port, PortInfo
 from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.node import NodeConfiguration
 from framework.logger import DTSLogger
@@ -37,7 +38,6 @@
 from framework.settings import SETTINGS
 
 from .cpu import Architecture, LogicalCore
-from .port import Port, PortInfo
 
 
 class FilePermissions(Flag):
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 6b8c5edee5..25bcba4c12 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -19,11 +19,10 @@
 
 from api.capabilities import LinkTopology
 from api.exception import ConfigurationError, InternalError
+from api.testbed_model.port import DriverKind, Port, PortConfig
 from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node, NodeIdentifier
 
-from .port import DriverKind, Port, PortConfig
-
 
 class PortLink(NamedTuple):
     """The physical, cabled connection between the ports."""
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index 0bd1eb39bb..f220629e35 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -26,6 +26,7 @@
 from scapy.packet import Packet
 
 from api.exception import InteractiveSSHSessionDeadError, InternalError
+from api.testbed_model.port import Port
 from api.testbed_model.traffic_generator.capturing_traffic_generator import (
     CapturingTrafficGenerator,
     PacketFilteringConfig,
@@ -34,7 +35,6 @@
 from framework.config.test_run import ScapyTrafficGeneratorConfig
 from framework.remote_session.python_shell import PythonShell
 from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
 from framework.testbed_model.topology import Topology
 
 
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index c57231de22..97e03b8fb7 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -11,9 +11,9 @@
     requires_link_topology,
 )
 from api.test import verify
+from api.testbed_model.port import Port
 from api.testpmd import TestPmd
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.port import Port
 
 
 class TestBlocklist(TestSuite):
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite_cryptodev_latency.py
index ed6423eb26..981c483a14 100644
--- a/dts/tests/TestSuite_cryptodev_latency.py
+++ b/dts/tests/TestSuite_cryptodev_latency.py
@@ -31,8 +31,8 @@
     CryptodevResults,
 )
 from api.test import skip, verify
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
-from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "avg_cycles": 99_999.00, "avg_time_us": 9999.0},
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index d69714e1fa..b861c52bae 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -31,8 +31,8 @@
     CryptodevResults,
 )
 from api.test import skip, verify
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.test_suite import BaseConfig, TestSuite, crypto_test
-from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 574842e2e4..5650366c36 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -19,11 +19,11 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.testbed_model.cpu import LogicalCoreCount
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from api.utils import generate_random_packets
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.cpu import LogicalCoreCount
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index dc71991a91..041c0333ab 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -36,13 +36,13 @@
     send_packets_and_capture,
 )
 from api.test import verify
+from api.testbed_model.cpu import LogicalCoreList
 from api.testbed_model.traffic_generator.capturing_traffic_generator import PacketFilteringConfig
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.cpu import LogicalCoreList
 
 
 @dataclass(kw_only=True)
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index c57a12c932..91a6d4eb9f 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -18,11 +18,11 @@
     match_all_packets,
     send_packets_and_capture,
 )
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
 from api.utils import generate_random_packets
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_virtio_forward.py
index fe1257800e..ef6c2d407c 100644
--- a/dts/tests/TestSuite_virtio_forward.py
+++ b/dts/tests/TestSuite_virtio_forward.py
@@ -13,10 +13,10 @@
 from api.packet import send_packets_and_capture
 from api.test import log, verify
 from api.testbed_model.linux_session import LinuxSession
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
 from framework.test_suite import TestSuite, func_test
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 class TestVirtioForward(TestSuite):
-- 
2.55.0

