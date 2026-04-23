Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01260FDEE2B
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 17:03:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1088E40648;
	Thu, 23 Apr 2026 19:03:41 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id C1D2F40272
 for <dev@dpdk.org>; Thu, 23 Apr 2026 19:03:37 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8ef2118b478so297762985a.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776963817; x=1777568617; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mK5yKc4kJ87Ds+UQnuO3vWlfQjb280x64jKl6NIO7PA=;
 b=cwOH8Z4x29xvZD+H6n3Ge+PhnUbX3hVbZTeR/q3JEq1j7uNSYQsNYTe9b11gN4KZ12
 THn7K2nyfklyY2E9CQLltOJuZ/Ph/zi2DAtA7KhilIEJGz1FjcFNI+QWO+wybIdYYkcM
 CyMGtOcBpjRSeDhI7rR9wTXKEu9vm6VSAl4vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963817; x=1777568617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mK5yKc4kJ87Ds+UQnuO3vWlfQjb280x64jKl6NIO7PA=;
 b=BUO9EfnZ+O4QS/aAtudcV6D+YR+jslXKQ5QALC9WWjj1lhwdoT2dK9RSrALQSbfCT5
 OkWZ60Wd9BymBLsxswP8r5qYQyQxmcuGT4+iDUA29eTbwCpRzbh4D1qguHFCAWd8W48s
 mx6157so4/vnsAfFIX1EXUu2qhKBadGLi7jxyno8ASZg3deNeWLB5NobiYwJr9Rr41sl
 LC5sxKzJ++ZTgpAGVkCAeD+RYcBQdp05/uUTIgQBcE+dC1KBwc+w45QuIquRvvMy7imH
 VOm1qSdqSSU7rd8mIREPhlLvqQRlgLCHBKErHikCqqp+pbiu1vvbbneNCqY/cofFRhF8
 +MeQ==
X-Gm-Message-State: AOJu0YwNqPCdfJWcyKMwnyWt7rVfn3LSTohiqvv4Qh4SgcVuwBa+4n7z
 W2km3Bc32E0XcSYo3YGzflABbnK/pz8X0keVxoTq6T6HzUGPqxrnVsVZaEODxkeaJTry11G2CC2
 MOEqd
X-Gm-Gg: AeBDieuxwidpyIngVYafUJPoJsyNFQHcpp6+Ec7H4OP2W4hCiq8LFNlwRBi9f+30Byn
 T/hsSd73KR11mfINl7535tgMSD7ESi9ZzM+5BBy6fBBdcNdyXvWH77hVwtbm147cChQs/NRNJnr
 99zBGsDGFIXHnTx+6RYb0954VBJ+SYW5kEqqdIswjCwLefuUj3opwgxVp5Yje0J0Ovx6RVSIAXg
 EWOwgqW94tnmxI295L7vq38VcNkCIcEmzocR0/ViAtezZJDnpDujEigw6ljfTLSR8VJj5DR2izy
 jeDAxMpKEgQfoFRpPBh77fBG2pf1vBtRBCwjo8KPoWTp1zVXWSrYog8kJc8FQ45ANyeGeuxJhcQ
 Djg0W86wpTRmNAqeEQFI/j7Nnkpj0sJOAjdIVmsEo7hmF1MB7ChV3vX43T0xjeI+9bZCzpcUHuS
 0RV9xaUUPz7wmEa/FM4JIuF7Sv0FMJ9O5MofIETIUZ0rGG9tAGaXJe7Z71oIOaYixVRmkNq/o8
X-Received: by 2002:a05:620a:4489:b0:8cb:5176:f00 with SMTP id
 af79cd13be357-8e7920821b9mr3949096685a.45.1776963816713; 
 Thu, 23 Apr 2026 10:03:36 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d8edb734sm1869831585a.29.2026.04.23.10.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 10:03:36 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1 2/8] dts: move testbed model from framework to API
Date: Thu, 23 Apr 2026 13:03:14 -0400
Message-ID: <20260423170331.33193-3-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423170331.33193-1-dmarx@iol.unh.edu>
References: <20240925192013.17446-1-jspewock@iol.unh.edu>
 <20260423170331.33193-1-dmarx@iol.unh.edu>
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

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/api/artifact.py                              |  2 +-
 dts/api/capabilities.py                          |  8 ++++----
 dts/api/packet.py                                | 14 +++++++-------
 dts/api/test_suite.py                            |  4 ++--
 dts/{framework => api}/testbed_model/__init__.py |  0
 .../testbed_model/capability.py                  | 12 ++++++------
 dts/{framework => api}/testbed_model/cpu.py      |  4 ++--
 .../testbed_model/linux_session.py               |  6 +++---
 dts/{framework => api}/testbed_model/node.py     |  2 +-
 .../testbed_model/os_session.py                  |  8 ++++----
 dts/{framework => api}/testbed_model/port.py     |  2 +-
 .../testbed_model/posix_session.py               |  6 +++---
 dts/{framework => api}/testbed_model/topology.py |  6 +++---
 .../testbed_model/traffic_generator/__init__.py  |  4 ++--
 .../capturing_traffic_generator.py               |  4 ++--
 .../performance_traffic_generator.py             |  0
 .../testbed_model/traffic_generator/scapy.py     | 14 +++++++-------
 .../traffic_generator/traffic_generator.py       |  8 ++++----
 .../testbed_model/traffic_generator/trex.py      | 16 ++++++++--------
 .../testbed_model/virtual_device.py              |  0
 dts/framework/config/node.py                     | 16 ++++++++--------
 dts/framework/config/test_run.py                 |  2 +-
 dts/framework/context.py                         | 10 +++++-----
 dts/framework/params/eal.py                      |  6 +++---
 dts/framework/params/types.py                    |  6 +++---
 dts/framework/remote_session/blocking_app.py     |  2 +-
 dts/framework/remote_session/dpdk.py             |  8 ++++----
 dts/framework/remote_session/dpdk_shell.py       |  2 +-
 .../remote_session/interactive_shell.py          |  2 +-
 dts/framework/runner.py                          |  2 +-
 dts/framework/test_result.py                     |  2 +-
 dts/framework/test_run.py                        | 16 ++++++++--------
 dts/tests/TestSuite_blocklist.py                 |  2 +-
 dts/tests/TestSuite_cryptodev_throughput.py      |  2 +-
 dts/tests/TestSuite_l2fwd.py                     |  2 +-
 dts/tests/TestSuite_packet_capture.py            |  8 ++++----
 dts/tests/TestSuite_smoke_tests.py               |  2 +-
 dts/tests/TestSuite_softnic.py                   |  2 +-
 dts/tests/TestSuite_virtio_fwd.py                |  6 +++---
 39 files changed, 109 insertions(+), 109 deletions(-)
 rename dts/{framework => api}/testbed_model/__init__.py (100%)
 rename dts/{framework => api}/testbed_model/capability.py (98%)
 rename dts/{framework => api}/testbed_model/cpu.py (99%)
 rename dts/{framework => api}/testbed_model/linux_session.py (99%)
 rename dts/{framework => api}/testbed_model/node.py (99%)
 rename dts/{framework => api}/testbed_model/os_session.py (99%)
 rename dts/{framework => api}/testbed_model/port.py (98%)
 rename dts/{framework => api}/testbed_model/posix_session.py (99%)
 rename dts/{framework => api}/testbed_model/topology.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/__init__.py (95%)
 rename dts/{framework => api}/testbed_model/traffic_generator/capturing_traffic_generator.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/performance_traffic_generator.py (100%)
 rename dts/{framework => api}/testbed_model/traffic_generator/scapy.py (98%)
 rename dts/{framework => api}/testbed_model/traffic_generator/traffic_generator.py (91%)
 rename dts/{framework => api}/testbed_model/traffic_generator/trex.py (96%)
 rename dts/{framework => api}/testbed_model/virtual_device.py (100%)

diff --git a/dts/api/artifact.py b/dts/api/artifact.py
index 24a2b05063..025c87bbfa 100644
--- a/dts/api/artifact.py
+++ b/dts/api/artifact.py
@@ -47,10 +47,10 @@
 from paramiko import SFTPClient, SFTPFile
 from typing_extensions import Buffer
 
+from api.testbed_model.node import Node, NodeIdentifier, get_node
 from framework.exception import InternalError
 from framework.logger import DTSLogger, get_dts_logger
 from framework.settings import SETTINGS
-from framework.testbed_model.node import Node, NodeIdentifier, get_node
 
 TextMode: TypeAlias = (
     Literal["r", "r+", "w", "w+", "a", "a+", "x", "x+"]
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
index 8569cacbd2..a4d6b2b424 100644
--- a/dts/api/capabilities.py
+++ b/dts/api/capabilities.py
@@ -23,7 +23,7 @@
     .. code:: python
 
         from api.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import LinkTopology, requires_link_topology
+        from api.testbed_model.capability import LinkTopology, requires_link_topology
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
@@ -34,7 +34,7 @@ def hello_world_single_core(self):
     .. code:: python
 
         from api.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import NicCapability, requires_nic_capability
+        from api.testbed_model.capability import NicCapability, requires_nic_capability
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
@@ -235,7 +235,7 @@ def requires_link_topology(
     Returns:
         The decorated test case or test suite.
     """
-    from framework.testbed_model.capability import TopologyCapability
+    from api.testbed_model.capability import TopologyCapability
 
     def add_required_topology(
         test_case_or_suite: type["TestProtocol"],
@@ -258,7 +258,7 @@ def requires_nic_capability(
     Returns:
         The decorated test case or test suite.
     """
-    from framework.testbed_model.capability import DecoratedNicCapability
+    from api.testbed_model.capability import DecoratedNicCapability
 
     def add_required_capability(
         test_case_or_suite: type["TestProtocol"],
diff --git a/dts/api/packet.py b/dts/api/packet.py
index fc2be931fe..d30d455485 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -28,14 +28,14 @@
 from scapy.packet import Packet, Padding, raw
 
 from api.test import fail, log_debug
-from framework.context import get_ctx
-from framework.exception import InternalError
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
-from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+from api.testbed_model.traffic_generator.performance_traffic_generator import (
     PerformanceTrafficStats,
 )
+from framework.context import get_ctx
+from framework.exception import InternalError
 from framework.utils import get_packet_summaries
 
 
@@ -82,10 +82,10 @@ def send_packets_and_capture(
     Returns:
         A list of received packets.
     """
-    from framework.context import get_ctx
-    from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+    from api.testbed_model.traffic_generator.capturing_traffic_generator import (
         CapturingTrafficGenerator,
     )
+    from framework.context import get_ctx
 
     assert isinstance(
         get_ctx().func_tg, CapturingTrafficGenerator
@@ -340,7 +340,7 @@ def assess_performance_by_packet(
     Returns:
         Performance statistics of the generated test.
     """
-    from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    from api.testbed_model.traffic_generator.performance_traffic_generator import (
         PerformanceTrafficGenerator,
     )
 
diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
index f107b1cd2c..ebb07a9cae 100644
--- a/dts/api/test_suite.py
+++ b/dts/api/test_suite.py
@@ -29,11 +29,11 @@
 from scapy.packet import Packet
 from typing_extensions import Self
 
+from api.testbed_model.capability import TestProtocol
+from api.testbed_model.topology import Topology
 from framework.config.common import FrozenModel
 from framework.exception import ConfigurationError, InternalError
 from framework.logger import DTSLogger, get_dts_logger
-from framework.testbed_model.capability import TestProtocol
-from framework.testbed_model.topology import Topology
 from framework.utils import to_pascal_case
 
 if TYPE_CHECKING:
diff --git a/dts/framework/testbed_model/__init__.py b/dts/api/testbed_model/__init__.py
similarity index 100%
rename from dts/framework/testbed_model/__init__.py
rename to dts/api/testbed_model/__init__.py
diff --git a/dts/framework/testbed_model/capability.py b/dts/api/testbed_model/capability.py
similarity index 98%
rename from dts/framework/testbed_model/capability.py
rename to dts/api/testbed_model/capability.py
index 39f6f3c0df..95583261d8 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/api/testbed_model/capability.py
@@ -26,7 +26,7 @@
     .. code:: python
 
         from api.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import LinkTopology, requires
+        from api.testbed_model.capability import LinkTopology, requires
         # The whole test suite (each test case within) doesn't require any links.
         @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
@@ -37,7 +37,7 @@ def hello_world_single_core(self):
     .. code:: python
 
         from api.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import NicCapability, requires
+        from api.testbed_model.capability import NicCapability, requires
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
@@ -64,11 +64,11 @@ def test_scatter_mbuf_2048(self):
 from typing_extensions import Self
 
 from api.capabilities import LinkTopology, NicCapability
-from framework.exception import ConfigurationError, InternalError, SkippedTestException
+from api.exception import ConfigurationError, InternalError, SkippedTestException
+from api.testbed_model.node import Node
+from api.testbed_model.port import DriverKind
+from api.testbed_model.topology import Topology
 from framework.logger import get_dts_logger
-from framework.testbed_model.node import Node
-from framework.testbed_model.port import DriverKind
-from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
     from api.test_suite import TestCase
diff --git a/dts/framework/testbed_model/cpu.py b/dts/api/testbed_model/cpu.py
similarity index 99%
rename from dts/framework/testbed_model/cpu.py
rename to dts/api/testbed_model/cpu.py
index 6e2ecca080..ee754f5844 100644
--- a/dts/framework/testbed_model/cpu.py
+++ b/dts/api/testbed_model/cpu.py
@@ -24,12 +24,12 @@
 from dataclasses import dataclass
 from enum import auto, unique
 
-from framework.utils import StrEnum, expand_range
+from api.utils import StrEnum, expand_range
 
 
 @unique
 class Architecture(StrEnum):
-    r"""The supported architectures of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The supported architectures of :class:`~api.testbed_model.node.Node`\s."""
 
     #:
     i686 = auto()
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/api/testbed_model/linux_session.py
similarity index 99%
rename from dts/framework/testbed_model/linux_session.py
rename to dts/api/testbed_model/linux_session.py
index ee943462c2..7307b2abe2 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/api/testbed_model/linux_session.py
@@ -18,13 +18,13 @@
 
 from typing_extensions import NotRequired
 
-from framework.exception import (
+from api.exception import (
     ConfigurationError,
     InternalError,
     RemoteCommandExecutionError,
 )
-from framework.testbed_model.port import PortInfo
-from framework.utils import expand_range
+from api.testbed_model.port import PortInfo
+from api.utils import expand_range
 
 from .cpu import LogicalCore
 from .port import Port
diff --git a/dts/framework/testbed_model/node.py b/dts/api/testbed_model/node.py
similarity index 99%
rename from dts/framework/testbed_model/node.py
rename to dts/api/testbed_model/node.py
index 67a96ef4e5..4f42bf6aeb 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/api/testbed_model/node.py
@@ -17,11 +17,11 @@
 from pathlib import PurePath
 from typing import Literal, TypeAlias
 
+from api.exception import ConfigurationError, InternalError
 from framework.config.node import (
     OS,
     NodeConfiguration,
 )
-from framework.exception import ConfigurationError, InternalError
 from framework.logger import DTSLogger, get_dts_logger
 
 from .cpu import Architecture, LogicalCore
diff --git a/dts/framework/testbed_model/os_session.py b/dts/api/testbed_model/os_session.py
similarity index 99%
rename from dts/framework/testbed_model/os_session.py
rename to dts/api/testbed_model/os_session.py
index 2c267afed1..b1e0538ac9 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/api/testbed_model/os_session.py
@@ -29,12 +29,12 @@
 from enum import Flag, auto
 from pathlib import Path, PurePath, PurePosixPath
 
+from api.utils import MesonArgs, TarCompressionFormat
 from framework.config.node import NodeConfiguration
 from framework.logger import DTSLogger
 from framework.remote_session.interactive_remote_session import InteractiveRemoteSession
 from framework.remote_session.remote_session import CommandResult, RemoteSession
 from framework.settings import SETTINGS
-from framework.utils import MesonArgs, TarCompressionFormat
 
 from .cpu import Architecture, LogicalCore
 from .port import Port, PortInfo
@@ -73,11 +73,11 @@ class OSSessionInfo:
 
     Attributes:
         os_name: The name of the running operating system of
-            the :class:`~framework.testbed_model.node.Node`.
+            the :class:`~api.testbed_model.node.Node`.
         os_version: The version of the running operating system of
-            the :class:`~framework.testbed_model.node.Node`.
+            the :class:`~api.testbed_model.node.Node`.
         kernel_version: The kernel version of the running operating system of
-            the :class:`~framework.testbed_model.node.Node`.
+            the :class:`~api.testbed_model.node.Node`.
     """
 
     os_name: str
diff --git a/dts/framework/testbed_model/port.py b/dts/api/testbed_model/port.py
similarity index 98%
rename from dts/framework/testbed_model/port.py
rename to dts/api/testbed_model/port.py
index d81bc4cda0..aea3e59c25 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/api/testbed_model/port.py
@@ -12,8 +12,8 @@
 from functools import cached_property
 from typing import TYPE_CHECKING, Any, Final, Literal, NamedTuple
 
+from api.exception import InternalError
 from framework.config.node import PortConfig
-from framework.exception import InternalError
 
 if TYPE_CHECKING:
     from .node import Node
diff --git a/dts/framework/testbed_model/posix_session.py b/dts/api/testbed_model/posix_session.py
similarity index 99%
rename from dts/framework/testbed_model/posix_session.py
rename to dts/api/testbed_model/posix_session.py
index dec952685a..61c634dad1 100644
--- a/dts/framework/testbed_model/posix_session.py
+++ b/dts/api/testbed_model/posix_session.py
@@ -16,15 +16,15 @@
 from collections.abc import Iterable
 from pathlib import Path, PurePath, PurePosixPath
 
-from framework.exception import DPDKBuildError, RemoteCommandExecutionError
-from framework.settings import SETTINGS
-from framework.utils import (
+from api.exception import DPDKBuildError, RemoteCommandExecutionError
+from api.utils import (
     MesonArgs,
     TarCompressionFormat,
     convert_to_list_of_string,
     create_tarball,
     extract_tarball,
 )
+from framework.settings import SETTINGS
 
 from .cpu import Architecture
 from .os_session import FilePermissions, OSSession, OSSessionInfo
diff --git a/dts/framework/testbed_model/topology.py b/dts/api/testbed_model/topology.py
similarity index 98%
rename from dts/framework/testbed_model/topology.py
rename to dts/api/testbed_model/topology.py
index 34862c4d2e..5b8fe03836 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/api/testbed_model/topology.py
@@ -18,9 +18,9 @@
 from typing_extensions import Self
 
 from api.capabilities import LinkTopology
-from framework.exception import ConfigurationError, InternalError
-from framework.testbed_model.linux_session import LinuxSession
-from framework.testbed_model.node import Node, NodeIdentifier
+from api.exception import ConfigurationError, InternalError
+from api.testbed_model.linux_session import LinuxSession
+from api.testbed_model.node import Node, NodeIdentifier
 
 from .port import DriverKind, Port, PortConfig
 
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/api/testbed_model/traffic_generator/__init__.py
similarity index 95%
rename from dts/framework/testbed_model/traffic_generator/__init__.py
rename to dts/api/testbed_model/traffic_generator/__init__.py
index fca251f534..11fa25448a 100644
--- a/dts/framework/testbed_model/traffic_generator/__init__.py
+++ b/dts/api/testbed_model/traffic_generator/__init__.py
@@ -14,13 +14,13 @@
 and a capturing traffic generator is required.
 """
 
+from api.exception import ConfigurationError
+from api.testbed_model.node import Node
 from framework.config.test_run import (
     ScapyTrafficGeneratorConfig,
     TrafficGeneratorConfig,
     TrexTrafficGeneratorConfig,
 )
-from framework.exception import ConfigurationError
-from framework.testbed_model.node import Node
 
 from .scapy import ScapyTrafficGenerator
 from .traffic_generator import TrafficGenerator
diff --git a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
similarity index 98%
rename from dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
index 7655751d7e..db274e5e82 100644
--- a/dts/framework/testbed_model/traffic_generator/capturing_traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/capturing_traffic_generator.py
@@ -17,8 +17,8 @@
 from scapy.packet import Packet
 
 from api.artifact import Artifact
-from framework.testbed_model.port import Port
-from framework.utils import get_packet_summaries
+from api.testbed_model.port import Port
+from api.utils import get_packet_summaries
 
 from .traffic_generator import TrafficGenerator
 
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py b/dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
similarity index 100%
rename from dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/performance_traffic_generator.py
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/api/testbed_model/traffic_generator/scapy.py
similarity index 98%
rename from dts/framework/testbed_model/traffic_generator/scapy.py
rename to dts/api/testbed_model/traffic_generator/scapy.py
index c6e9006205..215c57f93d 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/api/testbed_model/traffic_generator/scapy.py
@@ -25,16 +25,16 @@
 from scapy.layers.l2 import Ether
 from scapy.packet import Packet
 
+from api.exception import InteractiveSSHSessionDeadError, InternalError
+from api.testbed_model.node import Node
+from api.testbed_model.port import Port
+from api.testbed_model.topology import Topology
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
 from framework.config.node import OS
 from framework.config.test_run import ScapyTrafficGeneratorConfig
-from framework.exception import InteractiveSSHSessionDeadError, InternalError
 from framework.remote_session.python_shell import PythonShell
-from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
-from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
 
 from .capturing_traffic_generator import CapturingTrafficGenerator
 
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/api/testbed_model/traffic_generator/traffic_generator.py
similarity index 91%
rename from dts/framework/testbed_model/traffic_generator/traffic_generator.py
rename to dts/api/testbed_model/traffic_generator/traffic_generator.py
index cdda5a7c08..5fd68e5144 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/api/testbed_model/traffic_generator/traffic_generator.py
@@ -13,11 +13,11 @@
 
 from scapy.packet import Packet
 
+from api.testbed_model.node import Node
+from api.testbed_model.port import Port
+from api.testbed_model.topology import Topology
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
-from framework.testbed_model.node import Node
-from framework.testbed_model.port import Port
-from framework.testbed_model.topology import Topology
 
 
 class TrafficGenerator(ABC):
@@ -25,7 +25,7 @@ class TrafficGenerator(ABC):
 
     Exposes the common public methods of all traffic generators and defines private methods
     that must implement the traffic generation logic in subclasses. This class also extends from
-    :class:`framework.utils.MultiInheritanceBaseClass` to allow subclasses the ability to inherit
+    :class:`api.utils.MultiInheritanceBaseClass` to allow subclasses the ability to inherit
     from multiple classes to fulfil the traffic generating functionality without breaking
     single inheritance.
     """
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/api/testbed_model/traffic_generator/trex.py
similarity index 96%
rename from dts/framework/testbed_model/traffic_generator/trex.py
rename to dts/api/testbed_model/traffic_generator/trex.py
index 22cd20dea9..d97ed934c9 100644
--- a/dts/framework/testbed_model/traffic_generator/trex.py
+++ b/dts/api/testbed_model/traffic_generator/trex.py
@@ -11,19 +11,19 @@
 
 from scapy.packet import Packet
 
+from api.testbed_model.node import Node, create_session
+from api.testbed_model.os_session import OSSession
+from api.testbed_model.topology import Topology
+from api.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
+from api.utils import StrEnum
 from framework.config.node import OS, NodeConfiguration
 from framework.config.test_run import TrexTrafficGeneratorConfig
 from framework.parser import TextParser
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.python_shell import PythonShell
-from framework.testbed_model.node import Node, create_session
-from framework.testbed_model.os_session import OSSession
-from framework.testbed_model.topology import Topology
-from framework.testbed_model.traffic_generator.performance_traffic_generator import (
-    PerformanceTrafficGenerator,
-    PerformanceTrafficStats,
-)
-from framework.utils import StrEnum
 
 
 @dataclass(slots=True)
diff --git a/dts/framework/testbed_model/virtual_device.py b/dts/api/testbed_model/virtual_device.py
similarity index 100%
rename from dts/framework/testbed_model/virtual_device.py
rename to dts/api/testbed_model/virtual_device.py
diff --git a/dts/framework/config/node.py b/dts/framework/config/node.py
index 792290f11f..63062a31b5 100644
--- a/dts/framework/config/node.py
+++ b/dts/framework/config/node.py
@@ -21,7 +21,7 @@
 
 @unique
 class OS(StrEnum):
-    r"""The supported operating systems of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The supported operating systems of :class:`~api.testbed_model.node.Node`\s."""
 
     #:
     linux = auto()
@@ -32,7 +32,7 @@ class OS(StrEnum):
 
 
 class HugepageConfiguration(FrozenModel):
-    r"""The hugepage configuration of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The hugepage configuration of :class:`~api.testbed_model.node.Node`\s."""
 
     #: The number of hugepages to allocate.
     number_of: int
@@ -41,7 +41,7 @@ class HugepageConfiguration(FrozenModel):
 
 
 class PortConfig(FrozenModel):
-    r"""The port configuration of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The port configuration of :class:`~api.testbed_model.node.Node`\s."""
 
     #: An identifier for the port. May contain letters, digits, underscores, hyphens and spaces.
     name: str = Field(pattern=REGEX_FOR_IDENTIFIER)
@@ -54,17 +54,17 @@ class PortConfig(FrozenModel):
 
 
 class NodeConfiguration(FrozenModel):
-    r"""The configuration of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The configuration of :class:`~api.testbed_model.node.Node`\s."""
 
-    #: The name of the :class:`~framework.testbed_model.node.Node`.
+    #: The name of the :class:`~api.testbed_model.node.Node`.
     name: str = Field(pattern=REGEX_FOR_IDENTIFIER)
-    #: The hostname of the :class:`~framework.testbed_model.node.Node`. Can also be an IP address.
+    #: The hostname of the :class:`~api.testbed_model.node.Node`. Can also be an IP address.
     hostname: str
-    #: The name of the user used to connect to the :class:`~framework.testbed_model.node.Node`.
+    #: The name of the user used to connect to the :class:`~api.testbed_model.node.Node`.
     user: str
     #: The password of the user. The use of passwords is heavily discouraged, please use SSH keys.
     password: str | None = None
-    #: The operating system of the :class:`~framework.testbed_model.node.Node`.
+    #: The operating system of the :class:`~api.testbed_model.node.Node`.
     os: OS
     #: An optional hugepage configuration.
     hugepages: HugepageConfiguration | None = Field(None, alias="hugepages_2mb")
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 75737418a8..2c16a712eb 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -38,7 +38,7 @@
 
 @unique
 class Compiler(StrEnum):
-    r"""The supported compilers of :class:`~framework.testbed_model.node.Node`\s."""
+    r"""The supported compilers of :class:`~api.testbed_model.node.Node`\s."""
 
     #:
     gcc = auto()
diff --git a/dts/framework/context.py b/dts/framework/context.py
index 86745ab56b..618eb3dda7 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -8,18 +8,18 @@
 from dataclasses import MISSING, dataclass, field, fields
 from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union
 
+from api.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
+from api.testbed_model.node import Node
+from api.testbed_model.topology import Topology
 from framework.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
 from framework.settings import SETTINGS
-from framework.testbed_model.cpu import LogicalCoreCount, LogicalCoreList
-from framework.testbed_model.node import Node
-from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
     from api.test_suite import TestCase, TestSuite
+    from api.testbed_model.capability import TestProtocol
+    from api.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
-    from framework.testbed_model.capability import TestProtocol
-    from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
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
index 3c7650474c..f2fa69f8b8 100644
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
@@ -54,9 +57,6 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TxUDPPortPair,
 )
 from framework.params import Switch, YesNoSwitch
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.port import Port
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 class EalParamsDict(TypedDict, total=False):
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
index c3b02dcc62..4181c20e43 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -30,12 +30,12 @@
 
 from typing_extensions import Self
 
+from api.testbed_model.node import Node
 from framework.context import get_ctx
 from framework.params import Params
 from framework.params.eal import EalParams
 from framework.remote_session.dpdk_shell import compute_eal_params
 from framework.remote_session.interactive_shell import InteractiveShell
-from framework.testbed_model.node import Node
 
 P = TypeVar("P", bound=Params)
 
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index c3575cfcaf..c955f4def2 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -13,6 +13,10 @@
 from pathlib import Path, PurePath
 from typing import ClassVar, Final
 
+from api.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
+from api.testbed_model.node import Node
+from api.testbed_model.os_session import OSSession
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.config.test_run import (
     DPDKBuildConfiguration,
     DPDKBuildOptionsConfiguration,
@@ -29,10 +33,6 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
-from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
-from framework.testbed_model.node import Node
-from framework.testbed_model.os_session import OSSession
-from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import MesonArgs, TarCompressionFormat
 
 
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 269c2cada4..ac89ec0459 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -10,13 +10,13 @@
 from abc import ABC, abstractmethod
 from pathlib import PurePath
 
+from api.testbed_model.cpu import LogicalCoreList
 from framework.context import get_ctx
 from framework.params.eal import EalParams
 from framework.remote_session.interactive_shell import (
     InteractiveShell,
     only_active,
 )
-from framework.testbed_model.cpu import LogicalCoreList
 
 
 def compute_eal_params(
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index a65cbce209..23d05fbdff 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -29,6 +29,7 @@
 from paramiko import Channel, channel
 from typing_extensions import Self
 
+from api.testbed_model.node import Node
 from framework.context import get_ctx
 from framework.exception import (
     InteractiveCommandExecutionError,
@@ -38,7 +39,6 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.params import Params
 from framework.settings import SETTINGS
-from framework.testbed_model.node import Node
 
 P = ParamSpec("P")
 T = TypeVar("T", bound="InteractiveShell")
diff --git a/dts/framework/runner.py b/dts/framework/runner.py
index 6ea4749ff4..0e245a515b 100644
--- a/dts/framework/runner.py
+++ b/dts/framework/runner.py
@@ -12,10 +12,10 @@
 import sys
 import textwrap
 
+from api.testbed_model.node import Node
 from framework.config.common import ValidationContext
 from framework.exception import ConfigurationError
 from framework.test_run import TestRun
-from framework.testbed_model.node import Node
 
 from .config import Configuration, load_config
 from .logger import DTSLogger, get_dts_logger
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
index 21faa55dc1..e2efff8681 100644
--- a/dts/framework/test_result.py
+++ b/dts/framework/test_result.py
@@ -35,9 +35,9 @@
 )
 from typing_extensions import OrderedDict
 
+from api.testbed_model.os_session import OSSessionInfo
 from framework.remote_session.dpdk import DPDKBuildInfo
 from framework.settings import SETTINGS
-from framework.testbed_model.os_session import OSSessionInfo
 
 from .exception import DTSError, ErrorSeverity, InternalError
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 037ae6c9fb..14c04d1ce0 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -107,6 +107,14 @@
 from typing import ClassVar, Protocol, Union
 
 from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
+from api.testbed_model.capability import (
+    Capability,
+    get_supported_capabilities,
+    test_if_supported,
+)
+from api.testbed_model.node import Node
+from api.testbed_model.topology import PortLink, Topology
+from api.testbed_model.traffic_generator import create_traffic_generator
 from framework.config.test_run import TestRunConfiguration
 from framework.context import Context, init_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
@@ -114,14 +122,6 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
-from framework.testbed_model.capability import (
-    Capability,
-    get_supported_capabilities,
-    test_if_supported,
-)
-from framework.testbed_model.node import Node
-from framework.testbed_model.topology import PortLink, Topology
-from framework.testbed_model.traffic_generator import create_traffic_generator
 
 TestScenario = tuple[type[TestSuite], BaseConfig, deque[type[TestCase]]]
 
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
index 05bfe951fd..31e69c0de9 100644
--- a/dts/tests/TestSuite_blocklist.py
+++ b/dts/tests/TestSuite_blocklist.py
@@ -12,8 +12,8 @@
 )
 from api.test import verify
 from api.test_suite import TestSuite, func_test
+from api.testbed_model.port import Port
 from api.testpmd import TestPmd
-from framework.testbed_model.port import Port
 
 
 class TestBlocklist(TestSuite):
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSuite_cryptodev_throughput.py
index 3f046ad87e..83ce94d4df 100644
--- a/dts/tests/TestSuite_cryptodev_throughput.py
+++ b/dts/tests/TestSuite_cryptodev_throughput.py
@@ -31,9 +31,9 @@
 )
 from api.test import verify
 from api.test_suite import BaseConfig, TestSuite, crypto_test
+from api.testbed_model.virtual_device import VirtualDevice
 from framework.context import get_ctx
 from framework.exception import SkippedTestException
-from framework.testbed_model.virtual_device import VirtualDevice
 
 config_list: list[dict[str, int | float | str]] = [
     {"buff_size": 64, "Gbps": 1.00},
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
index 44fee58775..63f771d594 100644
--- a/dts/tests/TestSuite_l2fwd.py
+++ b/dts/tests/TestSuite_l2fwd.py
@@ -19,10 +19,10 @@
     send_packets_and_capture,
 )
 from api.test_suite import TestSuite, func_test
+from api.testbed_model.cpu import LogicalCoreCount
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer, SimpleForwardingModes
 from framework.context import filter_cores
-from framework.testbed_model.cpu import LogicalCoreCount
 from framework.utils import generate_random_packets
 
 
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_packet_capture.py
index d37796954d..fd5cef5268 100644
--- a/dts/tests/TestSuite_packet_capture.py
+++ b/dts/tests/TestSuite_packet_capture.py
@@ -37,14 +37,14 @@
 )
 from api.test import verify
 from api.test_suite import TestSuite, func_test
+from api.testbed_model.cpu import LogicalCoreList
+from api.testbed_model.traffic_generator.capturing_traffic_generator import (
+    PacketFilteringConfig,
+)
 from api.testpmd import TestPmd
 from framework.params import Params
 from framework.remote_session.blocking_app import BlockingApp
 from framework.remote_session.dpdk_shell import compute_eal_params
-from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
-    PacketFilteringConfig,
-)
 
 
 @dataclass(kw_only=True)
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 38ed2234cd..157dec7585 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -20,10 +20,10 @@
 )
 from api.test import verify
 from api.test_suite import TestSuite, func_test
+from api.testbed_model.linux_session import LinuxSession
 from api.testpmd import TestPmd
 from framework.config.node import PortConfig
 from framework.settings import SETTINGS
-from framework.testbed_model.linux_session import LinuxSession
 from framework.utils import REGEX_FOR_PCI_ADDRESS
 
 
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.py
index 263a915745..0696933053 100644
--- a/dts/tests/TestSuite_softnic.py
+++ b/dts/tests/TestSuite_softnic.py
@@ -19,9 +19,9 @@
     send_packets_and_capture,
 )
 from api.test_suite import TestSuite, func_test
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import EthPeer
-from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import generate_random_packets
 
 
diff --git a/dts/tests/TestSuite_virtio_fwd.py b/dts/tests/TestSuite_virtio_fwd.py
index fd1fc476cc..2c10478df3 100644
--- a/dts/tests/TestSuite_virtio_fwd.py
+++ b/dts/tests/TestSuite_virtio_fwd.py
@@ -13,11 +13,11 @@
 from api.packet import send_packets_and_capture
 from api.test import log, verify
 from api.test_suite import TestSuite, func_test
+from api.testbed_model.capability import requires
+from api.testbed_model.linux_session import LinuxSession
+from api.testbed_model.virtual_device import VirtualDevice
 from api.testpmd import TestPmd
 from api.testpmd.config import PortTopology, SimpleForwardingModes
-from framework.testbed_model.capability import requires
-from framework.testbed_model.linux_session import LinuxSession
-from framework.testbed_model.virtual_device import VirtualDevice
 
 
 class TestVirtioFwd(TestSuite):
-- 
2.52.0

