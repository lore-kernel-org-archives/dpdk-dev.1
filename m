Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D4CA101F
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Sep 2025 15:21:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A764740659;
	Wed, 10 Sep 2025 17:21:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 0169B402C2
 for <dev@dpdk.org>; Wed, 10 Sep 2025 17:21:10 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2BF316F8;
 Wed, 10 Sep 2025 08:21:01 -0700 (PDT)
Received: from paul-pc.localdomain (unknown [10.57.66.49])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3754C3F694;
 Wed, 10 Sep 2025 08:21:09 -0700 (PDT)
From: Paul Szczepanek <paul.szczepanek@arm.com>
To: dev@dpdk.org
Cc: Paul Szczepanek <paul.szczepanek@arm.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>
Subject: [PATCH v1 1/2] dts: move testpmd into API
Date: Wed, 10 Sep 2025 16:21:02 +0100
Message-Id: <20250910152103.976383-2-paul.szczepanek@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910152103.976383-1-paul.szczepanek@arm.com>
References: <20250910152103.976383-1-paul.szczepanek@arm.com>
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

Testpmd moved into new API directory.
Capabilities converted into vanilla enum and moved to API.
Removed some circular dependencies and incorrect imports.

Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
---
 doc/api/dts/api.capabilities.rst              |    8 +
 doc/api/dts/api.rst                           |   20 +
 doc/api/dts/api.testpmd.config.rst            |    8 +
 doc/api/dts/api.testpmd.rst                   |   15 +
 doc/api/dts/api.testpmd.types.rst             |    8 +
 doc/api/dts/framework.params.rst              |    1 -
 doc/api/dts/framework.params.testpmd.rst      |    8 -
 doc/api/dts/framework.remote_session.rst      |    1 -
 ...framework.remote_session.testpmd_shell.rst |    8 -
 doc/api/dts/index.rst                         |    1 +
 doc/guides/tools/dts.rst                      |    4 +-
 dts/api/__init__.py                           |   14 +
 dts/api/capabilities.py                       |  180 ++
 dts/api/testpmd/__init__.py                   | 1294 ++++++++
 .../testpmd.py => api/testpmd/config.py}      |    9 +-
 dts/api/testpmd/types.py                      | 1406 ++++++++
 dts/framework/config/__init__.py              |    3 +-
 dts/framework/params/eal.py                   |   12 +-
 dts/framework/params/types.py                 |    4 +-
 dts/framework/remote_session/__init__.py      |   43 -
 dts/framework/remote_session/testpmd_shell.py | 2844 -----------------
 dts/framework/testbed_model/capability.py     |  174 +-
 dts/framework/testbed_model/linux_session.py  |    2 +-
 dts/framework/testbed_model/os_session.py     |   13 +-
 dts/framework/testbed_model/topology.py       |   30 +-
 25 files changed, 3123 insertions(+), 2987 deletions(-)
 create mode 100644 doc/api/dts/api.capabilities.rst
 create mode 100644 doc/api/dts/api.rst
 create mode 100644 doc/api/dts/api.testpmd.config.rst
 create mode 100644 doc/api/dts/api.testpmd.rst
 create mode 100644 doc/api/dts/api.testpmd.types.rst
 delete mode 100644 doc/api/dts/framework.params.testpmd.rst
 delete mode 100644 doc/api/dts/framework.remote_session.testpmd_shell.rst
 create mode 100644 dts/api/__init__.py
 create mode 100644 dts/api/capabilities.py
 create mode 100644 dts/api/testpmd/__init__.py
 rename dts/{framework/params/testpmd.py => api/testpmd/config.py} (98%)
 create mode 100644 dts/api/testpmd/types.py
 delete mode 100644 dts/framework/remote_session/testpmd_shell.py

diff --git a/doc/api/dts/api.capabilities.rst b/doc/api/dts/api.capabilities.rst
new file mode 100644
index 0000000000..3fa237a97b
--- /dev/null
+++ b/doc/api/dts/api.capabilities.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+capabilities - SUT Capabilities
+===============================
+
+.. automodule:: api.capabilities
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/api.rst b/doc/api/dts/api.rst
new file mode 100644
index 0000000000..bb84af51b1
--- /dev/null
+++ b/doc/api/dts/api.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+api - DTS API
+=============
+
+.. automodule:: api
+   :members:
+   :show-inheritance:
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   api.testpmd
+
+.. toctree::
+   :hidden:
+   :maxdepth: 1
+
+   api.capabilities
\ No newline at end of file
diff --git a/doc/api/dts/api.testpmd.config.rst b/doc/api/dts/api.testpmd.config.rst
new file mode 100644
index 0000000000..b92b80ac0f
--- /dev/null
+++ b/doc/api/dts/api.testpmd.config.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+config - Testpmd configuration
+==============================
+
+.. automodule:: api.testpmd.config
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/api.testpmd.rst b/doc/api/dts/api.testpmd.rst
new file mode 100644
index 0000000000..2b911c7c95
--- /dev/null
+++ b/doc/api/dts/api.testpmd.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+testpmd - Testpmd Interactive Remote Shell
+==========================================
+
+.. automodule:: api.testpmd
+   :members:
+   :show-inheritance:
+
+.. toctree::
+   :hidden:
+   :maxdepth: 1
+
+   api.testpmd.types
+   api.testpmd.config
\ No newline at end of file
diff --git a/doc/api/dts/api.testpmd.types.rst b/doc/api/dts/api.testpmd.types.rst
new file mode 100644
index 0000000000..8d32b62586
--- /dev/null
+++ b/doc/api/dts/api.testpmd.types.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+types - Testpmd types
+=====================
+
+.. automodule:: api.testpmd.types
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/framework.params.rst b/doc/api/dts/framework.params.rst
index 4e263e2e5c..d8c6af9667 100644
--- a/doc/api/dts/framework.params.rst
+++ b/doc/api/dts/framework.params.rst
@@ -12,5 +12,4 @@ params - Command Line Parameters Modelling
    :maxdepth: 1

    framework.params.eal
-   framework.params.testpmd
    framework.params.types
diff --git a/doc/api/dts/framework.params.testpmd.rst b/doc/api/dts/framework.params.testpmd.rst
deleted file mode 100644
index 19583b01de..0000000000
--- a/doc/api/dts/framework.params.testpmd.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-testpmd - TestPMD Parameters Modelling
-======================================
-
-.. automodule:: framework.params.testpmd
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/framework.remote_session.rst b/doc/api/dts/framework.remote_session.rst
index e4ebd21ab9..eecbb25e1f 100644
--- a/doc/api/dts/framework.remote_session.rst
+++ b/doc/api/dts/framework.remote_session.rst
@@ -17,5 +17,4 @@ remote\_session - Node Connections Package
    framework.remote_session.shell_pool
    framework.remote_session.dpdk
    framework.remote_session.dpdk_shell
-   framework.remote_session.testpmd_shell
    framework.remote_session.python_shell
diff --git a/doc/api/dts/framework.remote_session.testpmd_shell.rst b/doc/api/dts/framework.remote_session.testpmd_shell.rst
deleted file mode 100644
index 81ca23337f..0000000000
--- a/doc/api/dts/framework.remote_session.testpmd_shell.rst
+++ /dev/null
@@ -1,8 +0,0 @@
-.. SPDX-License-Identifier: BSD-3-Clause
-
-testpmd\_shell - Testpmd Interactive Remote Shell
-=================================================
-
-.. automodule:: framework.remote_session.testpmd_shell
-   :members:
-   :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index a11f395e11..c719297c11 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -15,6 +15,7 @@ Packages
    :maxdepth: 1

    tests
+   api
    framework.testbed_model
    framework.remote_session
    framework.params
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 3837b398cf..e7af60b7a6 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -447,8 +447,8 @@ Leveraging the DTS framework in writing testsuites:
    that class in one's testsuite implementation. It is also acceptable to
    import and instantiate classes for various DPDK applications. For instance,
    writing a testsuite for a simple packet forwarding operation would involve
-   importing the DTS TestPmdShell class, instantiating TestPmdShell, calling
-   TestPmdShell's start() method, and then sending traffic via one of the
+   importing the DTS TestPmd class, instantiating TestPmd, calling
+   TestPmd's start() method, and then sending traffic via one of the
    traffic transmitting functions exposed in the Testsuite class.

 Test Case Verification
diff --git a/dts/api/__init__.py b/dts/api/__init__.py
new file mode 100644
index 0000000000..26b773bfbb
--- /dev/null
+++ b/dts/api/__init__.py
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Arm Limited
+
+"""DTS API.
+
+This package exposes public API modules for test writers.
+
+All modules in this package are considered stable. Do not use framework
+internal modules in your tests. Any missing functionality should be added
+to the public API.
+
+Private methods and members are prefixed with an underscore and should not be
+used outside of the framework.
+"""
diff --git a/dts/api/capabilities.py b/dts/api/capabilities.py
new file mode 100644
index 0000000000..1a79413f6f
--- /dev/null
+++ b/dts/api/capabilities.py
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 PANTHEON.tech s.r.o.
+# Copyright(c) 2025 Arm Limited
+
+"""Testbed capabilities.
+
+This module provides a protocol that defines the common attributes of test cases and suites
+and support for test environment capabilities.
+
+Many test cases are testing features not available on all hardware.
+On the other hand, some test cases or suites may not need the most complex topology available.
+
+The module allows developers to mark test cases or suites to require certain hardware capabilities
+or a particular topology.
+
+There are differences between hardware and topology capabilities:
+
+    * Hardware capabilities are assumed to not be required when not specified.
+    * However, some topology is always available, so each test case or suite is assigned
+      a default topology if no topology is specified in the decorator.
+
+Examples:
+    .. code:: python
+
+        from framework.test_suite import TestSuite, func_test
+        from framework.testbed_model.capability import LinkTopology, requires_link_topology
+        # The whole test suite (each test case within) doesn't require any links.
+        @requires_link_topology(LinkTopology.NO_LINK)
+        @func_test
+        class TestHelloWorld(TestSuite):
+            def hello_world_single_core(self):
+            ...
+
+    .. code:: python
+
+        from framework.test_suite import TestSuite, func_test
+        from framework.testbed_model.capability import NicCapability, requires_nic_capability
+        class TestPmdBufferScatter(TestSuite):
+            # only the test case requires the SCATTERED_RX_ENABLED capability
+            # other test cases may not require it
+            @requires_nic_capability(NicCapability.SCATTERED_RX_ENABLED)
+            @func_test
+            def test_scatter_mbuf_2048(self):
+"""
+
+from enum import IntEnum, auto
+from typing import TYPE_CHECKING, Callable
+
+if TYPE_CHECKING:
+    from framework.test_suite import TestProtocol
+
+
+class LinkTopology(IntEnum):
+    """Supported topology types."""
+
+    #: A topology with no Traffic Generator.
+    NO_LINK = 0
+    #: A topology with one physical link between the SUT node and the TG node.
+    ONE_LINK = auto()
+    #: A topology with two physical links between the Sut node and the TG node.
+    TWO_LINKS = auto()
+
+    @classmethod
+    def default(cls) -> "LinkTopology":
+        """The default topology required by test cases if not specified otherwise."""
+        return cls.TWO_LINKS
+
+
+class NicCapability(IntEnum):
+    """DPDK NIC capabilities.
+
+    The capabilities are used to mark test cases or suites that require a specific
+    DPDK NIC capability to run. The capabilities are used by the test framework to
+    determine whether a test case or suite can be run on the current testbed.
+    """
+
+    #: Scattered packets Rx enabled.
+    SCATTERED_RX_ENABLED = 0
+    #: Device supports VLAN stripping.
+    RX_OFFLOAD_VLAN_STRIP = auto()
+    #: Device supports L3 checksum offload.
+    RX_OFFLOAD_IPV4_CKSUM = auto()
+    #: Device supports L4 checksum offload.
+    RX_OFFLOAD_UDP_CKSUM = auto()
+    #: Device supports L4 checksum offload.
+    RX_OFFLOAD_TCP_CKSUM = auto()
+    #: Device supports Large Receive Offload.
+    RX_OFFLOAD_TCP_LRO = auto()
+    #: Device supports QinQ (queue in queue) offload.
+    RX_OFFLOAD_QINQ_STRIP = auto()
+    #: Device supports inner packet L3 checksum.
+    RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    #: Device supports MACsec.
+    RX_OFFLOAD_MACSEC_STRIP = auto()
+    #: Device supports filtering of a VLAN Tag identifier.
+    RX_OFFLOAD_VLAN_FILTER = auto()
+    #: Device supports VLAN offload.
+    RX_OFFLOAD_VLAN_EXTEND = auto()
+    #: Device supports receiving segmented mbufs.
+    RX_OFFLOAD_SCATTER = auto()
+    #: Device supports Timestamp.
+    RX_OFFLOAD_TIMESTAMP = auto()
+    #: Device supports crypto processing while packet is received in NIC.
+    RX_OFFLOAD_SECURITY = auto()
+    #: Device supports CRC stripping.
+    RX_OFFLOAD_KEEP_CRC = auto()
+    #: Device supports L4 checksum offload.
+    RX_OFFLOAD_SCTP_CKSUM = auto()
+    #: Device supports inner packet L4 checksum.
+    RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    #: Device supports RSS hashing.
+    RX_OFFLOAD_RSS_HASH = auto()
+    #: Device supports scatter Rx packets to segmented mbufs.
+    RX_OFFLOAD_BUFFER_SPLIT = auto()
+    #: Device supports all checksum capabilities.
+    RX_OFFLOAD_CHECKSUM = auto()
+    #: Device supports all VLAN capabilities.
+    RX_OFFLOAD_VLAN = auto()
+    #: Device supports Rx queue setup after device started.
+    RUNTIME_RX_QUEUE_SETUP = auto()
+    #: Device supports Tx queue setup after device started.
+    RUNTIME_TX_QUEUE_SETUP = auto()
+    #: Device supports shared Rx queue among ports within Rx domain and switch domain.
+    RXQ_SHARE = auto()
+    #: Device supports keeping flow rules across restart.
+    FLOW_RULE_KEEP = auto()
+    #: Device supports keeping shared flow objects across restart.
+    FLOW_SHARED_OBJECT_KEEP = auto()
+    #: Device supports multicast address filtering.
+    MCAST_FILTERING = auto()
+    #: Device supports flow ctrl.
+    FLOW_CTRL = auto()
+    #: Device is running on a physical function.
+    PHYSICAL_FUNCTION = auto()
+
+
+def requires_link_topology(
+    link_topology: LinkTopology,
+) -> Callable[[type["TestProtocol"]], type["TestProtocol"]]:
+    """Decorator to set required topology type for a test case or test suite.
+
+    Args:
+        link_topology: The topology type the test suite or case requires.
+
+    Returns:
+        The decorated test case or test suite.
+    """
+    from framework.testbed_model.capability import TopologyCapability
+
+    def add_required_topology(
+        test_case_or_suite: type["TestProtocol"],
+    ) -> type["TestProtocol"]:
+        topology_capability = TopologyCapability.get_unique(link_topology)
+        topology_capability.set_required(test_case_or_suite)
+        return test_case_or_suite
+
+    return add_required_topology
+
+
+def requires_nic_capability(
+    nic_capability: NicCapability,
+) -> Callable[[type["TestProtocol"]], type["TestProtocol"]]:
+    """Decorator to add a single required NIC capability to a test case or test suite.
+
+    Args:
+        nic_capability: The NIC capability that is required by the test case or test suite.
+
+    Returns:
+        The decorated test case or test suite.
+    """
+    from framework.testbed_model.capability import DecoratedNicCapability
+
+    def add_required_capability(
+        test_case_or_suite: type["TestProtocol"],
+    ) -> type["TestProtocol"]:
+        decorated = DecoratedNicCapability.get_unique(nic_capability)
+        decorated.add_to_required(test_case_or_suite)
+        return test_case_or_suite
+
+    return add_required_capability
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
new file mode 100644
index 0000000000..a060ab5639
--- /dev/null
+++ b/dts/api/testpmd/__init__.py
@@ -0,0 +1,1294 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2023 University of New Hampshire
+# Copyright(c) 2023 PANTHEON.tech s.r.o.
+# Copyright(c) 2024 Arm Limited
+
+"""Testpmd interactive shell.
+
+Typical usage example in a TestSuite::
+
+    testpmd = TestPmd(self.sut_node)
+    devices = testpmd.get_devices()
+    for device in devices:
+        print(device)
+    testpmd.close()
+"""
+
+import functools
+import re
+import time
+from collections.abc import MutableSet
+from enum import Flag
+from pathlib import PurePath
+from typing import (
+    Any,
+    Callable,
+    ClassVar,
+    Concatenate,
+    ParamSpec,
+    Tuple,
+)
+
+from typing_extensions import Unpack
+
+from api.capabilities import LinkTopology, NicCapability
+from api.testpmd.config import PortTopology, SimpleForwardingModes, TestPmdParams
+from api.testpmd.types import (
+    ChecksumOffloadOptions,
+    DeviceCapabilitiesFlag,
+    FlowRule,
+    RxOffloadCapabilities,
+    RxOffloadCapability,
+    TestPmdDevice,
+    TestPmdPort,
+    TestPmdPortFlowCtrl,
+    TestPmdPortStats,
+    TestPmdQueueInfo,
+    TestPmdRxqInfo,
+    TestPmdVerbosePacket,
+    VLANOffloadFlag,
+)
+from framework.context import get_ctx
+from framework.exception import InteractiveCommandExecutionError, InternalError
+from framework.params.types import TestPmdParamsDict
+from framework.remote_session.dpdk_shell import DPDKShell
+from framework.remote_session.interactive_shell import only_active
+from framework.settings import SETTINGS
+
+P = ParamSpec("P")
+TestPmdMethod = Callable[Concatenate["TestPmd", P], Any]
+
+
+def _requires_stopped_ports(func: TestPmdMethod) -> TestPmdMethod:
+    """Decorator for :class:`TestPmd` commands methods that require stopped ports.
+
+    If the decorated method is called while the ports are started, then these are stopped before
+    continuing.
+
+    Args:
+        func: The :class:`TestPmd` method to decorate.
+    """
+
+    @functools.wraps(func)
+    def _wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs) -> Any:
+        if self.ports_started:
+            self._logger.debug("Ports need to be stopped to continue.")
+            self.stop_all_ports()
+
+        return func(self, *args, **kwargs)
+
+    return _wrapper
+
+
+def _requires_started_ports(func: TestPmdMethod) -> TestPmdMethod:
+    """Decorator for :class:`TestPmd` commands methods that require started ports.
+
+    If the decorated method is called while the ports are stopped, then these are started before
+    continuing.
+
+    Args:
+        func: The :class:`TestPmd` method to decorate.
+    """
+
+    @functools.wraps(func)
+    def _wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs) -> Any:
+        if not self.ports_started:
+            self._logger.debug("Ports need to be started to continue.")
+            self.start_all_ports()
+
+        return func(self, *args, **kwargs)
+
+    return _wrapper
+
+
+def _add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdMethod], TestPmdMethod]:
+    """Configure MTU to `mtu` on all ports, run the decorated function, then revert.
+
+    Args:
+        mtu: The MTU to configure all ports on.
+
+    Returns:
+        The method decorated with setting and reverting MTU.
+    """
+
+    def decorator(func: TestPmdMethod) -> TestPmdMethod:
+        @functools.wraps(func)
+        def wrapper(self: "TestPmd", *args: P.args, **kwargs: P.kwargs) -> Any:
+            original_mtu = self.ports[0].mtu
+            self.set_port_mtu_all(mtu=mtu, verify=False)
+            retval = func(self, *args, **kwargs)
+            self.set_port_mtu_all(original_mtu if original_mtu else 1500, verify=False)
+            return retval
+
+        return wrapper
+
+    return decorator
+
+
+class TestPmd(DPDKShell):
+    """Testpmd interactive shell.
+
+    The testpmd shell users should never use
+    the :meth:`~.interactive_shell.InteractiveShell.send_command` method directly, but rather
+    call specialized methods. If there isn't one that satisfies a need, it should be added.
+
+    Attributes:
+        ports_started: Indicates whether the ports are started.
+    """
+
+    _app_params: TestPmdParams
+    _ports: list[TestPmdPort] | None
+
+    #: The testpmd's prompt.
+    _default_prompt: ClassVar[str] = "testpmd>"
+
+    #: This forces the prompt to appear after sending a command.
+    _command_extra_chars: ClassVar[str] = "\n"
+
+    ports_started: bool
+
+    def __init__(
+        self,
+        name: str | None = None,
+        privileged: bool = True,
+        **app_params: Unpack[TestPmdParamsDict],
+    ) -> None:
+        """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes app_params to kwargs."""
+        if "port_topology" not in app_params and get_ctx().topology.type is LinkTopology.ONE_LINK:
+            app_params["port_topology"] = PortTopology.loop
+        super().__init__(name, privileged, app_params=TestPmdParams(**app_params))
+        self.ports_started = not self._app_params.disable_device_start
+        self._ports = None
+
+    @property
+    def path(self) -> PurePath:
+        """The path to the testpmd executable."""
+        return PurePath("app/dpdk-testpmd")
+
+    @property
+    def ports(self) -> list[TestPmdPort]:
+        """The ports of the instance.
+
+        This caches the ports returned by :meth:`show_port_info_all`.
+        To force an update of port information, execute :meth:`show_port_info_all` or
+        :meth:`show_port_info`.
+
+        Returns: The list of known testpmd ports.
+        """
+        if self._ports is None:
+            return self.show_port_info_all()
+        return self._ports
+
+    @_requires_started_ports
+    def start(self, verify: bool = True) -> None:
+        """Start packet forwarding with the current configuration.
+
+        Args:
+            verify: If :data:`True` , a second start command will be sent in an attempt to verify
+                packet forwarding started as expected.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
+                start or ports fail to come up.
+        """
+        self.send_command("start")
+        if verify:
+            # If forwarding was already started, sending "start" again should tell us
+            start_cmd_output = self.send_command("start")
+            if "Packet forwarding already started" not in start_cmd_output:
+                self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
+                raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
+
+    def stop(self, verify: bool = True) -> str:
+        """Stop packet forwarding.
+
+        Args:
+            verify: If :data:`True` , the output of the stop command is scanned to verify that
+                forwarding was stopped successfully or not started. If neither is found, it is
+                considered an error.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command to stop
+                forwarding results in an error.
+
+        Returns:
+            Output gathered from the stop command and all other preceding logs in the buffer. This
+            output is most often used to view forwarding statistics that are displayed when this
+            command is sent as well as any verbose packet information that hasn't been consumed
+            prior to calling this method.
+        """
+        stop_cmd_output = self.send_command("stop")
+        if verify:
+            if (
+                "Done." not in stop_cmd_output
+                and "Packet forwarding not started" not in stop_cmd_output
+            ):
+                self._logger.debug(f"Failed to stop packet forwarding: \n{stop_cmd_output}")
+                raise InteractiveCommandExecutionError("Testpmd failed to stop packet forwarding.")
+        return stop_cmd_output
+
+    def get_devices(self) -> list[TestPmdDevice]:
+        """Get a list of device names that are known to testpmd.
+
+        Uses the device info listed in testpmd and then parses the output.
+
+        Returns:
+            A list of devices.
+        """
+        dev_info: str = self.send_command("show device info all")
+        dev_list: list[TestPmdDevice] = []
+        for line in dev_info.split("\n"):
+            if "device name:" in line.lower():
+                dev_list.append(TestPmdDevice(line))
+        return dev_list
+
+    def wait_link_status_up(self, port_id: int, timeout=SETTINGS.timeout) -> bool:
+        """Wait until the link status on the given port is "up".
+
+        Arguments:
+            port_id: Port to check the link status on.
+            timeout: Time to wait for the link to come up. The default value for this
+                argument may be modified using the :option:`--timeout` command-line argument
+                or the :envvar:`DTS_TIMEOUT` environment variable.
+
+        Returns:
+            Whether the link came up in time or not.
+        """
+        time_to_stop = time.time() + timeout
+        port_info: str = ""
+        while time.time() < time_to_stop:
+            port_info = self.send_command(f"show port info {port_id}")
+            if "Link status: up" in port_info:
+                break
+            time.sleep(0.5)
+        else:
+            self._logger.error(f"The link for port {port_id} did not come up in the given timeout.")
+        return "Link status: up" in port_info
+
+    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool = True) -> None:
+        """Set packet forwarding mode.
+
+        Args:
+            mode: The forwarding mode to use.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that the forwarding mode was set to `mode` properly.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the forwarding mode
+                fails to update.
+        """
+        set_fwd_output = self.send_command(f"set fwd {mode.value}")
+        if verify:
+            if f"Set {mode.value} packet forwarding mode" not in set_fwd_output:
+                self._logger.debug(f"Failed to set fwd mode to {mode.value}:\n{set_fwd_output}")
+                raise InteractiveCommandExecutionError(
+                    f"Test pmd failed to set fwd mode to {mode.value}"
+                )
+
+    def stop_all_ports(self, verify: bool = True) -> None:
+        """Stops all the ports.
+
+        Args:
+            verify: If :data:`True`, the output of the command will be checked for a successful
+                execution.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the ports were not
+                stopped successfully.
+        """
+        self._logger.debug("Stopping all the ports...")
+        output = self.send_command("port stop all")
+        if verify and not output.strip().endswith("Done"):
+            raise InteractiveCommandExecutionError("Ports were not stopped successfully.")
+
+        self.ports_started = False
+
+    def start_all_ports(self, verify: bool = True) -> None:
+        """Starts all the ports.
+
+        Args:
+            verify: If :data:`True`, the output of the command will be checked for a successful
+                execution.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the ports were not
+                started successfully.
+        """
+        self._logger.debug("Starting all the ports...")
+        output = self.send_command("port start all")
+        if verify and not output.strip().endswith("Done"):
+            raise InteractiveCommandExecutionError("Ports were not started successfully.")
+
+        self.ports_started = True
+
+    @_requires_stopped_ports
+    def set_ports_queues(self, number_of: int) -> None:
+        """Sets the number of queues per port.
+
+        Args:
+            number_of: The number of RX/TX queues to create per port.
+
+        Raises:
+            InternalError: If `number_of` is invalid.
+        """
+        if number_of < 1:
+            raise InternalError("The number of queues must be positive and non-zero.")
+
+        self.send_command(f"port config all rxq {number_of}")
+        self.send_command(f"port config all txq {number_of}")
+
+    @_requires_stopped_ports
+    def close_all_ports(self, verify: bool = True) -> None:
+        """Close all ports.
+
+        Args:
+            verify: If :data:`True` the output of the close command will be scanned in an attempt
+                to verify that all ports were stopped successfully. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and at lease one port
+                failed to close.
+        """
+        port_close_output = self.send_command("port close all")
+        if verify:
+            num_ports = len(self.ports)
+            if not all(f"Port {p_id} is closed" in port_close_output for p_id in range(num_ports)):
+                raise InteractiveCommandExecutionError("Ports were not closed successfully.")
+
+    def show_port_info_all(self) -> list[TestPmdPort]:
+        """Returns the information of all the ports.
+
+        Returns:
+            list[TestPmdPort]: A list containing all the ports information as `TestPmdPort`.
+        """
+        output = self.send_command("show port info all")
+
+        # Sample output of the "all" command looks like:
+        #
+        # <start>
+        #
+        #   ********************* Infos for port 0 *********************
+        #   Key: value
+        #
+        #   ********************* Infos for port 1 *********************
+        #   Key: value
+        # <end>
+        #
+        # Takes advantage of the double new line in between ports as end delimiter. But we need to
+        # artificially add a new line at the end to pick up the last port. Because commands are
+        # executed on a pseudo-terminal created by paramiko on the remote node, lines end with CRLF.
+        # Therefore we also need to take the carriage return into account.
+        iter = re.finditer(r"\*{21}.*?[\r\n]{4}", output + "\r\n", re.S)
+        self._ports = [TestPmdPort.parse(block.group(0)) for block in iter]
+        return self._ports
+
+    def show_port_info(self, port_id: int) -> TestPmdPort:
+        """Returns the given port information.
+
+        Args:
+            port_id: The port ID to gather information for.
+
+        Raises:
+            InteractiveCommandExecutionError: If `port_id` is invalid.
+
+        Returns:
+            TestPmdPort: An instance of `TestPmdPort` containing the given port's information.
+        """
+        output = self.send_command(f"show port info {port_id}", skip_first_line=True)
+        if output.startswith("Invalid port"):
+            raise InteractiveCommandExecutionError("invalid port given")
+
+        port = TestPmdPort.parse(output)
+        self._update_port(port)
+        return port
+
+    def _update_port(self, port: TestPmdPort) -> None:
+        if self._ports:
+            self._ports = [
+                existing_port if port.id != existing_port.id else port
+                for existing_port in self._ports
+            ]
+
+    def set_mac_addr(self, port_id: int, mac_address: str, add: bool, verify: bool = True) -> None:
+        """Add or remove a mac address on a given port's Allowlist.
+
+        Args:
+            port_id: The port ID the mac address is set on.
+            mac_address: The mac address to be added to or removed from the specified port.
+            add: If :data:`True`, add the specified mac address. If :data:`False`, remove specified
+                mac address.
+            verify: If :data:'True', assert that the 'mac_addr' operation was successful. If
+                :data:'False', run the command and skip this assertion.
+
+        Raises:
+            InteractiveCommandExecutionError: If the set mac address operation fails.
+        """
+        mac_cmd = "add" if add else "remove"
+        output = self.send_command(f"mac_addr {mac_cmd} {port_id} {mac_address}")
+        if "Bad arguments" in output:
+            self._logger.debug("Invalid argument provided to mac_addr")
+            raise InteractiveCommandExecutionError("Invalid argument provided")
+
+        if verify:
+            if "mac_addr_cmd error:" in output:
+                self._logger.debug(f"Failed to {mac_cmd} {mac_address} on port {port_id}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to {mac_cmd} {mac_address} on port {port_id} \n{output}"
+                )
+
+    def set_multicast_mac_addr(
+        self, port_id: int, multi_addr: str, add: bool, verify: bool = True
+    ) -> None:
+        """Add or remove multicast mac address to a specified port's allow list.
+
+        Args:
+            port_id: The port ID the multicast address is set on.
+            multi_addr: The multicast address to be added or removed from the filter.
+            add: If :data:'True', add the specified multicast address to the port filter.
+                If :data:'False', remove the specified multicast address from the port filter.
+            verify: If :data:'True', assert that the 'mcast_addr' operations was successful.
+                If :data:'False', execute the 'mcast_addr' operation and skip the assertion.
+
+        Raises:
+            InteractiveCommandExecutionError: If either the 'add' or 'remove' operations fails.
+        """
+        mcast_cmd = "add" if add else "remove"
+        output = self.send_command(f"mcast_addr {mcast_cmd} {port_id} {multi_addr}")
+        if "Bad arguments" in output:
+            self._logger.debug("Invalid arguments provided to mcast_addr")
+            raise InteractiveCommandExecutionError("Invalid argument provided")
+
+        if verify:
+            if (
+                "Invalid multicast_addr" in output
+                or f"multicast address {'already' if add else 'not'} filtered by port" in output
+            ):
+                self._logger.debug(f"Failed to {mcast_cmd} {multi_addr} on port {port_id}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to {mcast_cmd} {multi_addr} on port {port_id} \n{output}"
+                )
+
+    def show_port_stats_all(self) -> Tuple[list[TestPmdPortStats], str]:
+        """Returns the statistics of all the ports.
+
+        Returns:
+            Tuple[str, list[TestPmdPortStats]]: A tuple where the first element is the stats of all
+            ports as `TestPmdPortStats` and second is the raw testpmd output that was collected
+            from the sent command.
+        """
+        output = self.send_command("show port stats all")
+
+        # Sample output of the "all" command looks like:
+        #
+        #   ########### NIC statistics for port 0 ###########
+        #   values...
+        #   #################################################
+        #
+        #   ########### NIC statistics for port 1 ###########
+        #   values...
+        #   #################################################
+        #
+        iter = re.finditer(r"(^  #*.+#*$[^#]+)^  #*\r$", output, re.MULTILINE)
+        return ([TestPmdPortStats.parse(block.group(1)) for block in iter], output)
+
+    def show_port_stats(self, port_id: int) -> TestPmdPortStats:
+        """Returns the given port statistics.
+
+        Args:
+            port_id: The port ID to gather information for.
+
+        Raises:
+            InteractiveCommandExecutionError: If `port_id` is invalid.
+
+        Returns:
+            TestPmdPortStats: An instance of `TestPmdPortStats` containing the given port's stats.
+        """
+        output = self.send_command(f"show port stats {port_id}", skip_first_line=True)
+        if output.startswith("Invalid port"):
+            raise InteractiveCommandExecutionError("invalid port given")
+
+        return TestPmdPortStats.parse(output)
+
+    def set_multicast_all(self, on: bool, verify: bool = True) -> None:
+        """Turns multicast mode on/off for the specified port.
+
+        Args:
+            on: If :data:`True`, turns multicast mode on, otherwise turns off.
+            verify: If :data:`True` an additional command will be sent to verify
+                that multicast mode is properly set. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and multicast
+                mode is not properly set.
+        """
+        multicast_cmd_output = self.send_command(f"set allmulti all {'on' if on else 'off'}")
+        if verify:
+            port_stats = self.show_port_info_all()
+            if on ^ all(stats.is_allmulticast_mode_enabled for stats in port_stats):
+                self._logger.debug(
+                    f"Failed to set multicast mode on all ports.: \n{multicast_cmd_output}"
+                )
+                raise InteractiveCommandExecutionError(
+                    "Testpmd failed to set multicast mode on all ports."
+                )
+
+    @_requires_stopped_ports
+    def csum_set_hw(
+        self, layers: ChecksumOffloadOptions, port_id: int, verify: bool = True
+    ) -> None:
+        """Enables hardware checksum offloading on the specified layer.
+
+        Args:
+            layers: The layer/layers that checksum offloading should be enabled on.
+            port_id: The port number to enable checksum offloading on, should be within 0-32.
+            verify: If :data:`True` the output of the command will be scanned in an attempt to
+                verify that checksum offloading was enabled on the port.
+
+        Raises:
+            InteractiveCommandExecutionError: If checksum offload is not enabled successfully.
+        """
+        for name, offload in ChecksumOffloadOptions.__members__.items():
+            if offload in layers:
+                name = name.replace("_", "-")
+                csum_output = self.send_command(f"csum set {name} hw {port_id}")
+                if verify:
+                    if (
+                        "Bad arguments" in csum_output
+                        or f"Please stop port {port_id} first" in csum_output
+                        or f"checksum offload is not supported by port {port_id}" in csum_output
+                    ):
+                        self._logger.debug(f"Csum set hw error:\n{csum_output}")
+                        raise InteractiveCommandExecutionError(
+                            f"Failed to set csum hw {name} mode on port {port_id}"
+                        )
+                success = False
+                if f"{name} checksum offload is hw" in csum_output.lower():
+                    success = True
+                if not success and verify:
+                    self._logger.debug(
+                        f"Failed to set csum hw mode on port {port_id}:\n{csum_output}"
+                    )
+                    raise InteractiveCommandExecutionError(
+                        f"""Failed to set csum hw mode on port
+                                                           {port_id}:\n{csum_output}"""
+                    )
+
+    def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
+        """Creates a flow rule in the testpmd session.
+
+        This command is implicitly verified as needed to return the created flow rule id.
+
+        Args:
+            flow_rule: :class:`FlowRule` object used for creating testpmd flow rule.
+            port_id: Integer representing the port to use.
+
+        Raises:
+            InteractiveCommandExecutionError: If flow rule is invalid.
+
+        Returns:
+            Id of created flow rule.
+        """
+        flow_output = self.send_command(f"flow create {port_id} {flow_rule}")
+        match = re.search(r"#(\d+)", flow_output)
+        if match is not None:
+            match_str = match.group(1)
+            flow_id = int(match_str)
+            return flow_id
+        else:
+            self._logger.debug(f"Failed to create flow rule:\n{flow_output}")
+            raise InteractiveCommandExecutionError(f"Failed to create flow rule:\n{flow_output}")
+
+    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
+        """Validates a flow rule in the testpmd session.
+
+        Args:
+            flow_rule: :class:`FlowRule` object used for validating testpmd flow rule.
+            port_id: Integer representing the port to use.
+
+        Returns:
+            Boolean representing whether rule is valid or not.
+        """
+        flow_output = self.send_command(f"flow validate {port_id} {flow_rule}")
+        if "Flow rule validated" in flow_output:
+            return True
+        return False
+
+    def flow_delete(self, flow_id: int, port_id: int, verify: bool = True) -> None:
+        """Deletes the specified flow rule from the testpmd session.
+
+        Args:
+            flow_id: ID of the flow to remove.
+            port_id: Integer representing the port to use.
+            verify: If :data:`True`, the output of the command is scanned
+                to ensure the flow rule was deleted successfully.
+
+        Raises:
+            InteractiveCommandExecutionError: If flow rule is invalid.
+        """
+        flow_output = self.send_command(f"flow destroy {port_id} rule {flow_id}")
+        if verify:
+            if "destroyed" not in flow_output:
+                self._logger.debug(f"Failed to delete flow rule:\n{flow_output}")
+                raise InteractiveCommandExecutionError(
+                    f"Failed to delete flow rule:\n{flow_output}"
+                )
+
+    @_requires_started_ports
+    @_requires_stopped_ports
+    def set_port_mtu(self, port_id: int, mtu: int, verify: bool = True) -> None:
+        """Change the MTU of a port using testpmd.
+
+        Some PMDs require that the port be stopped before changing the MTU, and it does no harm to
+        stop the port before configuring in cases where it isn't required, so ports are stopped
+        prior to changing their MTU. On the other hand, some PMDs require that the port had already
+        been started once since testpmd startup. Therefore, ports are also started before stopping
+        them to ensure this has happened.
+
+        Args:
+            port_id: ID of the port to adjust the MTU on.
+            mtu: Desired value for the MTU to be set to.
+            verify: If `verify` is :data:`True` then the output will be scanned in an attempt to
+                verify that the mtu was properly set on the port. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the MTU was not
+                properly updated on the port matching `port_id`.
+        """
+        set_mtu_output = self.send_command(f"port config mtu {port_id} {mtu}")
+        if verify and (f"MTU: {mtu}" not in self.send_command(f"show port info {port_id}")):
+            self._logger.debug(
+                f"Failed to set mtu to {mtu} on port {port_id}. Output was:\n{set_mtu_output}"
+            )
+            raise InteractiveCommandExecutionError(
+                f"Test pmd failed to update mtu of port {port_id} to {mtu}"
+            )
+
+    def set_port_mtu_all(self, mtu: int, verify: bool = True) -> None:
+        """Change the MTU of all ports using testpmd.
+
+        Runs :meth:`set_port_mtu` for every port that testpmd is aware of.
+
+        Args:
+            mtu: Desired value for the MTU to be set to.
+            verify: Whether to verify that setting the MTU on each port was successful or not.
+                Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the MTU was not
+                properly updated on at least one port.
+        """
+        for port in self.ports:
+            self.set_port_mtu(port.id, mtu, verify)
+
+    @staticmethod
+    def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket]:
+        """Extract the verbose information present in given testpmd output.
+
+        This method extracts sections of verbose output that begin with the line
+        "port X/queue Y: sent/received Z packets" and end with the ol_flags of a packet.
+
+        Args:
+            output: Testpmd output that contains verbose information
+
+        Returns:
+            List of parsed packet information gathered from verbose information in `output`.
+        """
+        out: list[TestPmdVerbosePacket] = []
+        prev_header: str = ""
+        iter = re.finditer(
+            r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+ packets)?)\s*"
+            r"(?P<PACKET>src=[\w\s=:-]+?ol_flags: [\w ]+)",
+            output,
+        )
+        for match in iter:
+            if match.group("HEADER"):
+                prev_header = match.group("HEADER")
+            out.append(TestPmdVerbosePacket.parse(f"{prev_header}\n{match.group('PACKET')}"))
+        return out
+
+    @_requires_stopped_ports
+    def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
+        """Set vlan filter on.
+
+        Args:
+            port: The port number to enable VLAN filter on.
+            enable: Enable the filter on `port` if :data:`True`, otherwise disable it.
+            verify: If :data:`True`, the output of the command and show port info
+                is scanned to verify that vlan filtering was set successfully.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the filter
+                fails to update.
+        """
+        filter_cmd_output = self.send_command(f"vlan set filter {'on' if enable else 'off'} {port}")
+        if verify:
+            vlan_settings = self.show_port_info(port_id=port).vlan_offload
+            if enable ^ (vlan_settings is not None and VLANOffloadFlag.FILTER in vlan_settings):
+                self._logger.debug(
+                    f"""Failed to {"enable" if enable else "disable"}
+                                   filter on port {port}: \n{filter_cmd_output}"""
+                )
+                raise InteractiveCommandExecutionError(
+                    f"""Failed to {"enable" if enable else "disable"}
+                    filter on port {port}"""
+                )
+
+    def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
+        """Set port's MAC address.
+
+        Args:
+            port: The number of the requested port.
+            mac_address: The MAC address to set.
+            verify: If :data:`True`, the output of the command is scanned to verify that
+                the mac address is set in the specified port.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command
+                fails to execute.
+        """
+        output = self.send_command(f"mac_addr set {port} {mac_address}", skip_first_line=True)
+        if verify:
+            if output.strip():
+                self._logger.debug(
+                    f"Testpmd failed to set MAC address {mac_address} on port {port}."
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to set MAC address {mac_address} on port {port}."
+                )
+
+    def set_flow_control(
+        self, port: int, flow_ctrl: TestPmdPortFlowCtrl, verify: bool = True
+    ) -> None:
+        """Set the given `port`'s flow control.
+
+        Args:
+            port: The number of the requested port.
+            flow_ctrl: The requested flow control parameters.
+            verify: If :data:`True`, the output of the command is scanned to verify that
+                the flow control in the specified port is set.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command
+                fails to execute.
+        """
+        output = self.send_command(f"set flow_ctrl {flow_ctrl} {port}", skip_first_line=True)
+        if verify:
+            if output.strip():
+                self._logger.debug(f"Testpmd failed to set the {flow_ctrl} in port {port}.")
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to set the {flow_ctrl} in port {port}."
+                )
+
+    def show_port_flow_info(self, port: int) -> TestPmdPortFlowCtrl | None:
+        """Show port info flow.
+
+        Args:
+            port: The number of the requested port.
+
+        Returns:
+            The current port flow control parameters if supported, otherwise :data:`None`.
+        """
+        output = self.send_command(f"show port {port} flow_ctrl")
+        if "Flow control infos" in output:
+            return TestPmdPortFlowCtrl.parse(output)
+        return None
+
+    @_requires_stopped_ports
+    def rx_vlan(self, vlan: int, port: int, add: bool, verify: bool = True) -> None:
+        """Add specified vlan tag to the filter list on a port. Requires vlan filter to be on.
+
+        Args:
+            vlan: The vlan tag to add, should be within 1-1005.
+            port: The port number to add the tag on.
+            add: Adds the tag if :data:`True`, otherwise removes the tag.
+            verify: If :data:`True`, the output of the command is scanned to verify that
+                the vlan tag was added to the filter list on the specified port.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the tag
+                is not added.
+        """
+        rx_cmd_output = self.send_command(f"rx_vlan {'add' if add else 'rm'} {vlan} {port}")
+        if verify:
+            if (
+                "VLAN-filtering disabled" in rx_cmd_output
+                or "Invalid vlan_id" in rx_cmd_output
+                or "Bad arguments" in rx_cmd_output
+            ):
+                self._logger.debug(
+                    f"""Failed to {"add" if add else "remove"} tag {vlan}
+                    port {port}: \n{rx_cmd_output}"""
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to {'add' if add else 'remove'} tag {vlan} on port {port}."
+                )
+
+    @_requires_stopped_ports
+    def set_vlan_strip(self, port: int, enable: bool, verify: bool = True) -> None:
+        """Enable or disable vlan stripping on the specified port.
+
+        Args:
+            port: The port number to use.
+            enable: If :data:`True`, will turn vlan stripping on, otherwise will turn off.
+            verify: If :data:`True`, the output of the command and show port info
+                is scanned to verify that vlan stripping was enabled on the specified port.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and stripping
+                fails to update.
+        """
+        strip_cmd_output = self.send_command(f"vlan set strip {'on' if enable else 'off'} {port}")
+        if verify:
+            vlan_settings = self.show_port_info(port_id=port).vlan_offload
+            if enable ^ (vlan_settings is not None and VLANOffloadFlag.STRIP in vlan_settings):
+                self._logger.debug(
+                    f"""Failed to set strip {"on" if enable else "off"}
+                    port {port}: \n{strip_cmd_output}"""
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to set strip {'on' if enable else 'off'} port {port}."
+                )
+
+    @_requires_stopped_ports
+    def tx_vlan_set(
+        self, port: int, enable: bool, vlan: int | None = None, verify: bool = True
+    ) -> None:
+        """Set hardware insertion of vlan tags in packets sent on a port.
+
+        Args:
+            port: The port number to use.
+            enable: Sets vlan tag insertion if :data:`True`, and resets if :data:`False`.
+            vlan: The vlan tag to insert if enable is :data:`True`.
+            verify: If :data:`True`, the output of the command is scanned to verify that
+                vlan insertion was enabled on the specified port.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the insertion
+                tag is not set.
+        """
+        if enable:
+            tx_vlan_cmd_output = self.send_command(f"tx_vlan set {port} {vlan}")
+            if verify:
+                if (
+                    "Please stop port" in tx_vlan_cmd_output
+                    or "Invalid vlan_id" in tx_vlan_cmd_output
+                    or "Invalid port" in tx_vlan_cmd_output
+                ):
+                    self._logger.debug(
+                        f"Failed to set vlan tag {vlan} on port {port}:\n{tx_vlan_cmd_output}"
+                    )
+                    raise InteractiveCommandExecutionError(
+                        f"Testpmd failed to set vlan insertion tag {vlan} on port {port}."
+                    )
+        else:
+            tx_vlan_cmd_output = self.send_command(f"tx_vlan reset {port}")
+            if verify:
+                if "Please stop port" in tx_vlan_cmd_output or "Invalid port" in tx_vlan_cmd_output:
+                    self._logger.debug(
+                        f"Failed to reset vlan insertion on port {port}: \n{tx_vlan_cmd_output}"
+                    )
+                    raise InteractiveCommandExecutionError(
+                        f"Testpmd failed to reset vlan insertion on port {port}."
+                    )
+
+    def set_promisc(self, port: int, enable: bool, verify: bool = True) -> None:
+        """Enable or disable promiscuous mode for the specified port.
+
+        Args:
+            port: Port number to use.
+            enable: If :data:`True`, turn promiscuous mode on, otherwise turn off.
+            verify: If :data:`True` an additional command will be sent to verify that
+                promiscuous mode is properly set. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and promiscuous mode
+                is not correctly set.
+        """
+        promisc_cmd_output = self.send_command(f"set promisc {port} {'on' if enable else 'off'}")
+        if verify:
+            stats = self.show_port_info(port_id=port)
+            if enable ^ stats.is_promiscuous_mode_enabled:
+                self._logger.debug(
+                    f"Failed to set promiscuous mode on port {port}: \n{promisc_cmd_output}"
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to set promiscuous mode on port {port}."
+                )
+
+    def set_verbose(self, level: int, verify: bool = True) -> None:
+        """Set debug verbosity level.
+
+        Args:
+            level: 0 - silent except for error
+                1 - fully verbose except for Tx packets
+                2 - fully verbose except for Rx packets
+                >2 - fully verbose
+            verify: If :data:`True` the command output will be scanned to verify that verbose level
+                is properly set. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and verbose level
+            is not correctly set.
+        """
+        verbose_cmd_output = self.send_command(f"set verbose {level}")
+        if verify:
+            if "Change verbose level" not in verbose_cmd_output:
+                self._logger.debug(
+                    f"Failed to set verbose level to {level}: \n{verbose_cmd_output}"
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Testpmd failed to set verbose level to {level}."
+                )
+
+    def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify: bool = True) -> None:
+        """Add or remove vxlan id to/from filter list.
+
+        Args:
+            vxlan_id: VXLAN ID to add to port filter list.
+            port_id: ID of the port to modify VXLAN filter of.
+            enable: If :data:`True`, adds specified VXLAN ID, otherwise removes it.
+            verify: If :data:`True`, the output of the command is checked to verify
+                the VXLAN ID was successfully added/removed from the port.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and VXLAN ID
+                is not successfully added or removed.
+        """
+        action = "add" if enable else "rm"
+        vxlan_output = self.send_command(f"rx_vxlan_port {action} {vxlan_id} {port_id}")
+        if verify:
+            if "udp tunneling add error" in vxlan_output:
+                self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output}")
+                raise InteractiveCommandExecutionError(f"Failed to set VXLAN:\n{vxlan_output}")
+
+    def clear_port_stats(self, port_id: int, verify: bool = True) -> None:
+        """Clear statistics of a given port.
+
+        Args:
+            port_id: ID of the port to clear the statistics on.
+            verify: If :data:`True` the output of the command will be scanned to verify that it was
+                successful, otherwise failures will be ignored. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and testpmd fails to
+                clear the statistics of the given port.
+        """
+        clear_output = self.send_command(f"clear port stats {port_id}")
+        if verify and f"NIC statistics for port {port_id} cleared" not in clear_output:
+            raise InteractiveCommandExecutionError(
+                f"Test pmd failed to set clear forwarding stats on port {port_id}"
+            )
+
+    def clear_port_stats_all(self, verify: bool = True) -> None:
+        """Clear the statistics of all ports that testpmd is aware of.
+
+        Args:
+            verify: If :data:`True` the output of the command will be scanned to verify that all
+                ports had their statistics cleared, otherwise failures will be ignored. Defaults to
+                :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and testpmd fails to
+                clear the statistics of any of its ports.
+        """
+        clear_output = self.send_command("clear port stats all")
+        if verify:
+            if type(self._app_params.port_numa_config) is list:
+                for port_id in range(len(self._app_params.port_numa_config)):
+                    if f"NIC statistics for port {port_id} cleared" not in clear_output:
+                        raise InteractiveCommandExecutionError(
+                            f"Test pmd failed to set clear forwarding stats on port {port_id}"
+                        )
+
+    @only_active
+    def close(self) -> None:
+        """Overrides :meth:`~.interactive_shell.close`."""
+        self.stop()
+        self.send_command("quit", "Bye...")
+        return super().close()
+
+    """
+    ====== Capability retrieval methods ======
+    """
+
+    def get_capabilities_rx_offload(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get all rx offload capabilities and divide them into supported and unsupported.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self._logger.debug("Getting rx offload capabilities.")
+        command = f"show port {self.ports[0].id} rx_offload capabilities"
+        rx_offload_capabilities_out = self.send_command(command)
+        rx_offload_capabilities = RxOffloadCapabilities.parse(rx_offload_capabilities_out)
+        self._update_capabilities_from_flag(
+            supported_capabilities,
+            unsupported_capabilities,
+            RxOffloadCapability,
+            rx_offload_capabilities.per_port | rx_offload_capabilities.per_queue,
+        )
+
+    def get_port_queue_info(
+        self, port_id: int, queue_id: int, is_rx_queue: bool
+    ) -> TestPmdQueueInfo:
+        """Returns the current state of the specified queue."""
+        command = f"show {'rxq' if is_rx_queue else 'txq'} info {port_id} {queue_id}"
+        queue_info = TestPmdQueueInfo.parse(self.send_command(command))
+        return queue_info
+
+    def setup_port_queue(self, port_id: int, queue_id: int, is_rx_queue: bool) -> None:
+        """Setup a given queue on a port.
+
+        This functionality cannot be verified because the setup action only takes effect when the
+        queue is started.
+
+        Args:
+            port_id: ID of the port where the queue resides.
+            queue_id: ID of the queue to setup.
+            is_rx_queue: Type of queue to setup. If :data:`True` an RX queue will be setup,
+                otherwise a TX queue will be setup.
+        """
+        self.send_command(f"port {port_id} {'rxq' if is_rx_queue else 'txq'} {queue_id} setup")
+
+    def stop_port_queue(
+        self, port_id: int, queue_id: int, is_rx_queue: bool, verify: bool = True
+    ) -> None:
+        """Stops a given queue on a port.
+
+        Args:
+            port_id: ID of the port that the queue belongs to.
+            queue_id: ID of the queue to stop.
+            is_rx_queue: Type of queue to stop. If :data:`True` an RX queue will be stopped,
+                otherwise a TX queue will be stopped.
+            verify: If :data:`True` an additional command will be sent to verify the queue stopped.
+                Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the queue fails to
+                stop.
+        """
+        port_type = "rxq" if is_rx_queue else "txq"
+        stop_cmd_output = self.send_command(f"port {port_id} {port_type} {queue_id} stop")
+        if verify:
+            queue_started = self.get_port_queue_info(
+                port_id, queue_id, is_rx_queue
+            ).is_queue_started
+            if queue_started:
+                self._logger.debug(
+                    f"Failed to stop {port_type} {queue_id} on port {port_id}:\n{stop_cmd_output}"
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Test pmd failed to stop {port_type} {queue_id} on port {port_id}"
+                )
+
+    def start_port_queue(
+        self, port_id: int, queue_id: int, is_rx_queue: bool, verify: bool = True
+    ) -> None:
+        """Starts a given queue on a port.
+
+        First sets up the port queue, then starts it.
+
+        Args:
+            port_id: ID of the port that the queue belongs to.
+            queue_id: ID of the queue to start.
+            is_rx_queue: Type of queue to start. If :data:`True` an RX queue will be started,
+                otherwise a TX queue will be started.
+            verify: if :data:`True` an additional command will be sent to verify that the queue was
+                started. Defaults to :data:`True`.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and the queue fails to
+                start.
+        """
+        port_type = "rxq" if is_rx_queue else "txq"
+        self.setup_port_queue(port_id, queue_id, is_rx_queue)
+        start_cmd_output = self.send_command(f"port {port_id} {port_type} {queue_id} start")
+        if verify:
+            queue_started = self.get_port_queue_info(
+                port_id, queue_id, is_rx_queue
+            ).is_queue_started
+            if not queue_started:
+                self._logger.debug(
+                    f"Failed to start {port_type} {queue_id} on port {port_id}:\n{start_cmd_output}"
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Test pmd failed to start {port_type} {queue_id} on port {port_id}"
+                )
+
+    def get_queue_ring_size(self, port_id: int, queue_id: int, is_rx_queue: bool) -> int:
+        """Returns the current size of the ring on the specified queue."""
+        command = f"show {'rxq' if is_rx_queue else 'txq'} info {port_id} {queue_id}"
+        queue_info = TestPmdQueueInfo.parse(self.send_command(command))
+        return queue_info.ring_size
+
+    def set_queue_ring_size(
+        self,
+        port_id: int,
+        queue_id: int,
+        size: int,
+        is_rx_queue: bool,
+        verify: bool = True,
+    ) -> None:
+        """Update the ring size of an Rx/Tx queue on a given port.
+
+        Queue is setup after setting the ring size so that the queue info reflects this change and
+        it can be verified.
+
+        Args:
+            port_id: The port that the queue resides on.
+            queue_id: The ID of the queue on the port.
+            size: The size to update the ring size to.
+            is_rx_queue: Whether to modify an RX or TX queue. If :data:`True` an RX queue will be
+                updated, otherwise a TX queue will be updated.
+            verify: If :data:`True` an additional command will be sent to check the ring size of
+                the queue in an attempt to validate that the size was changes properly.
+
+        Raises:
+            InteractiveCommandExecutionError: If `verify` is :data:`True` and there is a failure
+                when updating ring size.
+        """
+        queue_type = "rxq" if is_rx_queue else "txq"
+        self.send_command(f"port config {port_id} {queue_type} {queue_id} ring_size {size}")
+        self.setup_port_queue(port_id, queue_id, is_rx_queue)
+        if verify:
+            curr_ring_size = self.get_queue_ring_size(port_id, queue_id, is_rx_queue)
+            if curr_ring_size != size:
+                self._logger.debug(
+                    f"Failed up update ring size of queue {queue_id} on port {port_id}. Current"
+                    f" ring size is {curr_ring_size}."
+                )
+                raise InteractiveCommandExecutionError(
+                    f"Failed to update ring size of queue {queue_id} on port {port_id}"
+                )
+
+    @_requires_stopped_ports
+    def set_queue_deferred_start(
+        self, port_id: int, queue_id: int, is_rx_queue: bool, on: bool
+    ) -> None:
+        """Set the deferred start attribute of the specified queue on/off.
+
+        Args:
+            port_id: The port that the queue resides on.
+            queue_id: The ID of the queue on the port.
+            is_rx_queue: Whether to modify an RX or TX queue. If :data:`True` an RX queue will be
+                updated, otherwise a TX queue will be updated.
+            on: Whether to set deferred start mode on or off. If :data:`True` deferred start will
+                be turned on, otherwise it will be turned off.
+        """
+        queue_type = "rxq" if is_rx_queue else "txq"
+        action = "on" if on else "off"
+        self.send_command(f"port {port_id} {queue_type} {queue_id} deferred_start {action}")
+
+    def _update_capabilities_from_flag(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+        flag_class: type[Flag],
+        supported_flags: Flag,
+    ) -> None:
+        """Divide all flags from `flag_class` into supported and unsupported."""
+        for flag in flag_class:
+            if flag in supported_flags:
+                supported_capabilities.add(NicCapability[str(flag.name)])
+            else:
+                unsupported_capabilities.add(NicCapability[str(flag.name)])
+
+    @_requires_started_ports
+    def get_capabilities_rxq_info(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get all rxq capabilities and divide them into supported and unsupported.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self._logger.debug("Getting rxq capabilities.")
+        command = f"show rxq info {self.ports[0].id} 0"
+        rxq_info = TestPmdRxqInfo.parse(self.send_command(command))
+        if rxq_info.scattered_packets:
+            supported_capabilities.add(NicCapability.SCATTERED_RX_ENABLED)
+        else:
+            unsupported_capabilities.add(NicCapability.SCATTERED_RX_ENABLED)
+
+    def get_capabilities_show_port_info(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get all capabilities from show port info and divide them into supported and unsupported.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self._update_capabilities_from_flag(
+            supported_capabilities,
+            unsupported_capabilities,
+            DeviceCapabilitiesFlag,
+            self.ports[0].device_capabilities,
+        )
+
+    def get_capabilities_mcast_filtering(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get multicast filtering capability from mcast_addr add and check for testpmd error code.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self._logger.debug("Getting mcast filter capabilities.")
+        command = f"mcast_addr add {self.ports[0].id} 01:00:5E:00:00:00"
+        output = self.send_command(command)
+        if "diag=-95" in output:
+            unsupported_capabilities.add(NicCapability.MCAST_FILTERING)
+        else:
+            supported_capabilities.add(NicCapability.MCAST_FILTERING)
+            command = str.replace(command, "add", "remove", 1)
+            self.send_command(command)
+
+    def get_capabilities_flow_ctrl(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Get flow control capability and check for testpmd failure.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        self._logger.debug("Getting flow ctrl capabilities.")
+        command = f"show port {self.ports[0].id} flow_ctrl"
+        output = self.send_command(command)
+        if "Flow control infos" in output:
+            supported_capabilities.add(NicCapability.FLOW_CTRL)
+        else:
+            unsupported_capabilities.add(NicCapability.FLOW_CTRL)
+
+    def get_capabilities_physical_function(
+        self,
+        supported_capabilities: MutableSet["NicCapability"],
+        unsupported_capabilities: MutableSet["NicCapability"],
+    ) -> None:
+        """Store capability representing a physical function test run.
+
+        Args:
+            supported_capabilities: Supported capabilities will be added to this set.
+            unsupported_capabilities: Unsupported capabilities will be added to this set.
+        """
+        ctx = get_ctx()
+        if ctx.topology.vf_ports == []:
+            supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
+        else:
+            unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
diff --git a/dts/framework/params/testpmd.py b/dts/api/testpmd/config.py
similarity index 98%
rename from dts/framework/params/testpmd.py
rename to dts/api/testpmd/config.py
index 1913bd0fa2..e71a3e1ef0 100644
--- a/dts/framework/params/testpmd.py
+++ b/dts/api/testpmd/config.py
@@ -1,7 +1,12 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 Arm Limited

-"""Module containing all the TestPmd-related parameter classes."""
+"""Module containing all classes needed to configure :class:`TestPmd`.
+
+This module defines the :class:`TestPmdParams` class which is used to configure the
+TestPmd shell. It also includes various data classes and enums that are used
+to represent different configurations and settings.
+"""

 from dataclasses import dataclass, field
 from enum import EnumMeta, Flag, auto, unique
@@ -146,7 +151,7 @@ class RSSSetting(EnumMeta):


 class SimpleForwardingModes(StrEnum):
-    r"""The supported packet forwarding modes for :class:`~TestPmdShell`\s."""
+    r"""The supported packet forwarding modes for :class:`~TestPmd`\s."""

     #:
     io = auto()
diff --git a/dts/api/testpmd/types.py b/dts/api/testpmd/types.py
new file mode 100644
index 0000000000..d1ebf6f2d1
--- /dev/null
+++ b/dts/api/testpmd/types.py
@@ -0,0 +1,1406 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2023 University of New Hampshire
+# Copyright(c) 2023 PANTHEON.tech s.r.o.
+# Copyright(c) 2024 Arm Limited
+
+"""TestPmd types module.
+
+Exposes types used in the TestPmd API.
+"""
+
+import re
+from dataclasses import dataclass, field
+from enum import Flag, auto
+from typing import Literal
+
+from typing_extensions import Self
+
+from framework.parser import ParserFn, TextParser
+from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
+
+
+class TestPmdDevice:
+    """The data of a device that testpmd can recognize.
+
+    Attributes:
+        pci_address: The PCI address of the device.
+    """
+
+    pci_address: str
+
+    def __init__(self, pci_address_line: str) -> None:
+        """Initialize the device from the testpmd output line string.
+
+        Args:
+            pci_address_line: A line of testpmd output that contains a device.
+        """
+        self.pci_address = pci_address_line.strip().split(": ")[1].strip()
+
+    def __str__(self) -> str:
+        """The PCI address captures what the device is."""
+        return self.pci_address
+
+
+class VLANOffloadFlag(Flag):
+    """Flag representing the VLAN offload settings of a NIC port."""
+
+    #:
+    STRIP = auto()
+    #:
+    FILTER = auto()
+    #:
+    EXTEND = auto()
+    #:
+    QINQ_STRIP = auto()
+
+    @classmethod
+    def from_str_dict(cls, d) -> Self:
+        """Makes an instance from a dict containing the flag member names with an "on" value.
+
+        Args:
+            d: A dictionary containing the flag members as keys and any string value.
+
+        Returns:
+            A new instance of the flag.
+        """
+        flag = cls(0)
+        for name in cls.__members__:
+            if d.get(name) == "on":
+                flag |= cls[name]
+        return flag
+
+    @classmethod
+    def make_parser(cls) -> ParserFn:
+        """Makes a parser function.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        return TextParser.wrap(
+            TextParser.find(
+                r"VLAN offload:\s+"
+                r"strip (?P<STRIP>on|off), "
+                r"filter (?P<FILTER>on|off), "
+                r"extend (?P<EXTEND>on|off), "
+                r"qinq strip (?P<QINQ_STRIP>on|off)",
+                re.MULTILINE,
+                named=True,
+            ),
+            cls.from_str_dict,
+        )
+
+
+class ChecksumOffloadOptions(Flag):
+    """Flag representing checksum hardware offload layer options."""
+
+    #:
+    ip = auto()
+    #:
+    udp = auto()
+    #:
+    tcp = auto()
+    #:
+    sctp = auto()
+    #:
+    outer_ip = auto()
+    #:
+    outer_udp = auto()
+
+
+class RSSOffloadTypesFlag(Flag):
+    """Flag representing the RSS offload flow types supported by the NIC port."""
+
+    #:
+    ipv4 = auto()
+    #:
+    ipv4_frag = auto()
+    #:
+    ipv4_tcp = auto()
+    #:
+    ipv4_udp = auto()
+    #:
+    ipv4_sctp = auto()
+    #:
+    ipv4_other = auto()
+    #:
+    ipv6 = auto()
+    #:
+    ipv6_frag = auto()
+    #:
+    ipv6_tcp = auto()
+    #:
+    ipv6_udp = auto()
+    #:
+    ipv6_sctp = auto()
+    #:
+    ipv6_other = auto()
+    #:
+    l2_payload = auto()
+    #:
+    ipv6_ex = auto()
+    #:
+    ipv6_tcp_ex = auto()
+    #:
+    ipv6_udp_ex = auto()
+    #:
+    port = auto()
+    #:
+    vxlan = auto()
+    #:
+    geneve = auto()
+    #:
+    nvgre = auto()
+    #:
+    user_defined_22 = auto()
+    #:
+    gtpu = auto()
+    #:
+    eth = auto()
+    #:
+    s_vlan = auto()
+    #:
+    c_vlan = auto()
+    #:
+    esp = auto()
+    #:
+    ah = auto()
+    #:
+    l2tpv3 = auto()
+    #:
+    pfcp = auto()
+    #:
+    pppoe = auto()
+    #:
+    ecpri = auto()
+    #:
+    mpls = auto()
+    #:
+    ipv4_chksum = auto()
+    #:
+    l4_chksum = auto()
+    #:
+    l2tpv2 = auto()
+    #:
+    ipv6_flow_label = auto()
+    #:
+    user_defined_38 = auto()
+    #:
+    user_defined_39 = auto()
+    #:
+    user_defined_40 = auto()
+    #:
+    user_defined_41 = auto()
+    #:
+    user_defined_42 = auto()
+    #:
+    user_defined_43 = auto()
+    #:
+    user_defined_44 = auto()
+    #:
+    user_defined_45 = auto()
+    #:
+    user_defined_46 = auto()
+    #:
+    user_defined_47 = auto()
+    #:
+    user_defined_48 = auto()
+    #:
+    user_defined_49 = auto()
+    #:
+    user_defined_50 = auto()
+    #:
+    user_defined_51 = auto()
+    #:
+    l3_pre96 = auto()
+    #:
+    l3_pre64 = auto()
+    #:
+    l3_pre56 = auto()
+    #:
+    l3_pre48 = auto()
+    #:
+    l3_pre40 = auto()
+    #:
+    l3_pre32 = auto()
+    #:
+    l2_dst_only = auto()
+    #:
+    l2_src_only = auto()
+    #:
+    l4_dst_only = auto()
+    #:
+    l4_src_only = auto()
+    #:
+    l3_dst_only = auto()
+    #:
+    l3_src_only = auto()
+
+    #:
+    ip = ipv4 | ipv4_frag | ipv4_other | ipv6 | ipv6_frag | ipv6_other | ipv6_ex
+    #:
+    udp = ipv4_udp | ipv6_udp | ipv6_udp_ex
+    #:
+    tcp = ipv4_tcp | ipv6_tcp | ipv6_tcp_ex
+    #:
+    sctp = ipv4_sctp | ipv6_sctp
+    #:
+    tunnel = vxlan | geneve | nvgre
+    #:
+    vlan = s_vlan | c_vlan
+    #:
+    all = (
+        eth
+        | vlan
+        | ip
+        | tcp
+        | udp
+        | sctp
+        | l2_payload
+        | l2tpv3
+        | esp
+        | ah
+        | pfcp
+        | gtpu
+        | ecpri
+        | mpls
+        | l2tpv2
+    )
+
+    @classmethod
+    def from_list_string(cls, names: str) -> Self:
+        """Makes a flag from a whitespace-separated list of names.
+
+        Args:
+            names: a whitespace-separated list containing the members of this flag.
+
+        Returns:
+            An instance of this flag.
+        """
+        flag = cls(0)
+        for name in names.split():
+            flag |= cls.from_str(name)
+        return flag
+
+    @classmethod
+    def from_str(cls, name: str) -> Self:
+        """Makes a flag matching the supplied name.
+
+        Args:
+            name: a valid member of this flag in text
+        Returns:
+            An instance of this flag.
+        """
+        member_name = name.strip().replace("-", "_")
+        return cls[member_name]
+
+    @classmethod
+    def make_parser(cls) -> ParserFn:
+        """Makes a parser function.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        return TextParser.wrap(
+            TextParser.find(r"Supported RSS offload flow types:((?:\r?\n?  \S+)+)", re.MULTILINE),
+            RSSOffloadTypesFlag.from_list_string,
+        )
+
+
+class DeviceCapabilitiesFlag(Flag):
+    """Flag representing the device capabilities."""
+
+    #: Device supports Rx queue setup after device started.
+    RUNTIME_RX_QUEUE_SETUP = auto()
+    #: Device supports Tx queue setup after device started.
+    RUNTIME_TX_QUEUE_SETUP = auto()
+    #: Device supports shared Rx queue among ports within Rx domain and switch domain.
+    RXQ_SHARE = auto()
+    #: Device supports keeping flow rules across restart.
+    FLOW_RULE_KEEP = auto()
+    #: Device supports keeping shared flow objects across restart.
+    FLOW_SHARED_OBJECT_KEEP = auto()
+
+    @classmethod
+    def make_parser(cls) -> ParserFn:
+        """Makes a parser function.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        return TextParser.wrap(
+            TextParser.find_int(r"Device capabilities: (0x[A-Fa-f\d]+)"),
+            cls,
+        )
+
+
+class DeviceErrorHandlingMode(StrEnum):
+    """Enum representing the device error handling mode."""
+
+    #:
+    none = auto()
+    #:
+    passive = auto()
+    #:
+    proactive = auto()
+    #:
+    unknown = auto()
+
+    @classmethod
+    def make_parser(cls) -> ParserFn:
+        """Makes a parser function.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this enum from text.
+        """
+        return TextParser.wrap(TextParser.find(r"Device error handling mode: (\w+)"), cls)
+
+
+class RxQueueState(StrEnum):
+    """RX queue states.
+
+    References:
+        DPDK lib: ``lib/ethdev/rte_ethdev.h``
+        testpmd display function: ``app/test-pmd/config.c:get_queue_state_name()``
+    """
+
+    #:
+    stopped = auto()
+    #:
+    started = auto()
+    #:
+    hairpin = auto()
+    #:
+    unknown = auto()
+
+    @classmethod
+    def make_parser(cls) -> ParserFn:
+        """Makes a parser function.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this enum from text.
+        """
+        return TextParser.wrap(TextParser.find(r"Rx queue state: ([^\r\n]+)"), cls)
+
+
+@dataclass
+class TestPmdQueueInfo(TextParser):
+    """Dataclass representation of the common parts of the testpmd `show rxq/txq info` commands."""
+
+    #:
+    prefetch_threshold: int = field(metadata=TextParser.find_int(r"prefetch threshold: (\d+)"))
+    #:
+    host_threshold: int = field(metadata=TextParser.find_int(r"host threshold: (\d+)"))
+    #:
+    writeback_threshold: int = field(metadata=TextParser.find_int(r"writeback threshold: (\d+)"))
+    #:
+    free_threshold: int = field(metadata=TextParser.find_int(r"free threshold: (\d+)"))
+    #:
+    deferred_start: bool = field(metadata=TextParser.find("deferred start: on"))
+    #: The number of RXD/TXDs is just the ring size of the queue.
+    ring_size: int = field(metadata=TextParser.find_int(r"Number of (?:RXDs|TXDs): (\d+)"))
+    #:
+    is_queue_started: bool = field(metadata=TextParser.find("queue state: started"))
+    #:
+    burst_mode: str | None = field(
+        default=None, metadata=TextParser.find(r"Burst mode: ([^\r\n]+)")
+    )
+
+
+@dataclass
+class TestPmdTxqInfo(TestPmdQueueInfo):
+    """Representation of testpmd's ``show txq info <port_id> <queue_id>`` command.
+
+    References:
+        testpmd command function: ``app/test-pmd/cmdline.c:cmd_showqueue()``
+        testpmd display function: ``app/test-pmd/config.c:rx_queue_infos_display()``
+    """
+
+    #: Ring size threshold
+    rs_threshold: int | None = field(
+        default=None, metadata=TextParser.find_int(r"TX RS threshold: (\d+)\b")
+    )
+
+
+@dataclass
+class TestPmdRxqInfo(TestPmdQueueInfo):
+    """Representation of testpmd's ``show rxq info <port_id> <queue_id>`` command.
+
+    References:
+        testpmd command function: ``app/test-pmd/cmdline.c:cmd_showqueue()``
+        testpmd display function: ``app/test-pmd/config.c:rx_queue_infos_display()``
+    """
+
+    #: Mempool used by that queue
+    mempool: str | None = field(default=None, metadata=TextParser.find(r"Mempool: ([^\r\n]+)"))
+    #: Drop packets if no descriptors are available
+    drop_packets: bool | None = field(
+        default=None, metadata=TextParser.find(r"RX drop packets: on")
+    )
+    #: Scattered packets Rx enabled
+    scattered_packets: bool | None = field(
+        default=None, metadata=TextParser.find(r"RX scattered packets: on")
+    )
+    #: The state of the queue
+    queue_state: str | None = field(default=None, metadata=RxQueueState.make_parser())
+
+
+@dataclass
+class TestPmdPort(TextParser):
+    """Dataclass representing the result of testpmd's ``show port info`` command."""
+
+    @staticmethod
+    def _make_device_private_info_parser() -> ParserFn:
+        """Device private information parser.
+
+        Ensures that we are not parsing invalid device private info output.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a parser
+                function that parses the device private info from the TestPmd port info output.
+        """
+
+        def _validate(info: str) -> str | None:
+            info = info.strip()
+            if (
+                info == "none"
+                or info.startswith("Invalid file")
+                or info.startswith("Failed to dump")
+            ):
+                return None
+            return info
+
+        return TextParser.wrap(TextParser.find(r"Device private info:\s+([\s\S]+)"), _validate)
+
+    #:
+    id: int = field(metadata=TextParser.find_int(r"Infos for port (\d+)\b"))
+    #:
+    device_name: str = field(metadata=TextParser.find(r"Device name: ([^\r\n]+)"))
+    #:
+    driver_name: str = field(metadata=TextParser.find(r"Driver name: ([^\r\n]+)"))
+    #:
+    socket_id: int = field(metadata=TextParser.find_int(r"Connect to socket: (\d+)"))
+    #:
+    is_link_up: bool = field(metadata=TextParser.find("Link status: up"))
+    #:
+    link_speed: str = field(metadata=TextParser.find(r"Link speed: ([^\r\n]+)"))
+    #:
+    is_link_full_duplex: bool = field(metadata=TextParser.find("Link duplex: full-duplex"))
+    #:
+    is_link_autonegotiated: bool = field(metadata=TextParser.find("Autoneg status: On"))
+    #:
+    is_promiscuous_mode_enabled: bool = field(metadata=TextParser.find("Promiscuous mode: enabled"))
+    #:
+    is_allmulticast_mode_enabled: bool = field(
+        metadata=TextParser.find("Allmulticast mode: enabled")
+    )
+    #: Maximum number of MAC addresses
+    max_mac_addresses_num: int = field(
+        metadata=TextParser.find_int(r"Maximum number of MAC addresses: (\d+)")
+    )
+    #: Maximum configurable length of RX packet
+    max_hash_mac_addresses_num: int = field(
+        metadata=TextParser.find_int(r"Maximum number of MAC addresses of hash filtering: (\d+)")
+    )
+    #: Minimum size of RX buffer
+    min_rx_bufsize: int = field(metadata=TextParser.find_int(r"Minimum size of RX buffer: (\d+)"))
+    #: Maximum configurable length of RX packet
+    max_rx_packet_length: int = field(
+        metadata=TextParser.find_int(r"Maximum configurable length of RX packet: (\d+)")
+    )
+    #: Maximum configurable size of LRO aggregated packet
+    max_lro_packet_size: int = field(
+        metadata=TextParser.find_int(r"Maximum configurable size of LRO aggregated packet: (\d+)")
+    )
+
+    #: Current number of RX queues
+    rx_queues_num: int = field(metadata=TextParser.find_int(r"Current number of RX queues: (\d+)"))
+    #: Max possible RX queues
+    max_rx_queues_num: int = field(metadata=TextParser.find_int(r"Max possible RX queues: (\d+)"))
+    #: Max possible number of RXDs per queue
+    max_queue_rxd_num: int = field(
+        metadata=TextParser.find_int(r"Max possible number of RXDs per queue: (\d+)")
+    )
+    #: Min possible number of RXDs per queue
+    min_queue_rxd_num: int = field(
+        metadata=TextParser.find_int(r"Min possible number of RXDs per queue: (\d+)")
+    )
+    #: RXDs number alignment
+    rxd_alignment_num: int = field(metadata=TextParser.find_int(r"RXDs number alignment: (\d+)"))
+
+    #: Current number of TX queues
+    tx_queues_num: int = field(metadata=TextParser.find_int(r"Current number of TX queues: (\d+)"))
+    #: Max possible TX queues
+    max_tx_queues_num: int = field(metadata=TextParser.find_int(r"Max possible TX queues: (\d+)"))
+    #: Max possible number of TXDs per queue
+    max_queue_txd_num: int = field(
+        metadata=TextParser.find_int(r"Max possible number of TXDs per queue: (\d+)")
+    )
+    #: Min possible number of TXDs per queue
+    min_queue_txd_num: int = field(
+        metadata=TextParser.find_int(r"Min possible number of TXDs per queue: (\d+)")
+    )
+    #: TXDs number alignment
+    txd_alignment_num: int = field(metadata=TextParser.find_int(r"TXDs number alignment: (\d+)"))
+    #: Max segment number per packet
+    max_packet_segment_num: int = field(
+        metadata=TextParser.find_int(r"Max segment number per packet: (\d+)")
+    )
+    #: Max segment number per MTU/TSO
+    max_mtu_segment_num: int = field(
+        metadata=TextParser.find_int(r"Max segment number per MTU\/TSO: (\d+)")
+    )
+
+    #:
+    device_capabilities: DeviceCapabilitiesFlag = field(
+        metadata=DeviceCapabilitiesFlag.make_parser(),
+    )
+    #:
+    device_error_handling_mode: DeviceErrorHandlingMode | None = field(
+        default=None, metadata=DeviceErrorHandlingMode.make_parser()
+    )
+    #:
+    device_private_info: str | None = field(
+        default=None,
+        metadata=_make_device_private_info_parser(),
+    )
+
+    #:
+    hash_key_size: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Hash key size in bytes: (\d+)")
+    )
+    #:
+    redirection_table_size: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Redirection table size: (\d+)")
+    )
+    #:
+    supported_rss_offload_flow_types: RSSOffloadTypesFlag = field(
+        default=RSSOffloadTypesFlag(0), metadata=RSSOffloadTypesFlag.make_parser()
+    )
+
+    #:
+    mac_address: str | None = field(
+        default=None, metadata=TextParser.find(r"MAC address: ([A-Fa-f0-9:]+)")
+    )
+    #:
+    fw_version: str | None = field(
+        default=None, metadata=TextParser.find(r"Firmware-version: ([^\r\n]+)")
+    )
+    #:
+    dev_args: str | None = field(default=None, metadata=TextParser.find(r"Devargs: ([^\r\n]+)"))
+    #: Socket id of the memory allocation
+    mem_alloc_socket_id: int | None = field(
+        default=None,
+        metadata=TextParser.find_int(r"memory allocation on the socket: (\d+)"),
+    )
+    #:
+    mtu: int | None = field(default=None, metadata=TextParser.find_int(r"MTU: (\d+)"))
+
+    #:
+    vlan_offload: VLANOffloadFlag | None = field(
+        default=None,
+        metadata=VLANOffloadFlag.make_parser(),
+    )
+
+    #: Maximum size of RX buffer
+    max_rx_bufsize: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Maximum size of RX buffer: (\d+)")
+    )
+    #: Maximum number of VFs
+    max_vfs_num: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Maximum number of VFs: (\d+)")
+    )
+    #: Maximum number of VMDq pools
+    max_vmdq_pools_num: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Maximum number of VMDq pools: (\d+)")
+    )
+
+    #:
+    switch_name: str | None = field(
+        default=None, metadata=TextParser.find(r"Switch name: ([\r\n]+)")
+    )
+    #:
+    switch_domain_id: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Switch domain Id: (\d+)")
+    )
+    #:
+    switch_port_id: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Switch Port Id: (\d+)")
+    )
+    #:
+    switch_rx_domain: int | None = field(
+        default=None, metadata=TextParser.find_int(r"Switch Rx domain: (\d+)")
+    )
+
+
+@dataclass
+class TestPmdPortStats(TextParser):
+    """Port statistics."""
+
+    #:
+    port_id: int = field(metadata=TextParser.find_int(r"NIC statistics for port (\d+)"))
+
+    #:
+    rx_packets: int = field(metadata=TextParser.find_int(r"RX-packets:\s+(\d+)"))
+    #:
+    rx_missed: int = field(metadata=TextParser.find_int(r"RX-missed:\s+(\d+)"))
+    #:
+    rx_bytes: int = field(metadata=TextParser.find_int(r"RX-bytes:\s+(\d+)"))
+    #:
+    rx_errors: int = field(metadata=TextParser.find_int(r"RX-errors:\s+(\d+)"))
+    #:
+    rx_nombuf: int = field(metadata=TextParser.find_int(r"RX-nombuf:\s+(\d+)"))
+
+    #:
+    tx_packets: int = field(metadata=TextParser.find_int(r"TX-packets:\s+(\d+)"))
+    #:
+    tx_errors: int = field(metadata=TextParser.find_int(r"TX-errors:\s+(\d+)"))
+    #:
+    tx_bytes: int = field(metadata=TextParser.find_int(r"TX-bytes:\s+(\d+)"))
+
+    #:
+    rx_pps: int = field(metadata=TextParser.find_int(r"Rx-pps:\s+(\d+)"))
+    #:
+    rx_bps: int = field(metadata=TextParser.find_int(r"Rx-bps:\s+(\d+)"))
+
+    #:
+    tx_pps: int = field(metadata=TextParser.find_int(r"Tx-pps:\s+(\d+)"))
+    #:
+    tx_bps: int = field(metadata=TextParser.find_int(r"Tx-bps:\s+(\d+)"))
+
+
+@dataclass(kw_only=True)
+class FlowRule:
+    """Class representation of flow rule parameters.
+
+    This class represents the parameters of any flow rule as per the
+    following pattern:
+
+    [group {group_id}] [priority {level}] [ingress] [egress]
+    [user_id {user_id}] pattern {item} [/ {item} [...]] / end
+    actions {action} [/ {action} [...]] / end
+    """
+
+    #:
+    group_id: int | None = None
+    #:
+    priority_level: int | None = None
+    #:
+    direction: Literal["ingress", "egress"]
+    #:
+    user_id: int | None = None
+    #:
+    pattern: list[str]
+    #:
+    actions: list[str]
+
+    def __str__(self) -> str:
+        """Returns the string representation of this instance."""
+        ret = ""
+        pattern = " / ".join(self.pattern)
+        action = " / ".join(self.actions)
+        if self.group_id is not None:
+            ret += f"group {self.group_id} "
+        if self.priority_level is not None:
+            ret += f"priority {self.priority_level} "
+        ret += f"{self.direction} "
+        if self.user_id is not None:
+            ret += f"user_id {self.user_id} "
+        ret += f"pattern {pattern} / end "
+        ret += f"actions {action} / end"
+        return ret
+
+
+class PacketOffloadFlag(Flag):
+    """Flag representing the Packet Offload Features Flags in DPDK.
+
+    Values in this class are taken from the definitions in the RTE MBUF core library in DPDK
+    located in ``lib/mbuf/rte_mbuf_core.h``. It is expected that flag values in this class will
+    match the values they are set to in said DPDK library with one exception; all values must be
+    unique. For example, the definitions for unknown checksum flags in ``rte_mbuf_core.h`` are all
+    set to :data:`0`, but it is valuable to distinguish between them in this framework. For this
+    reason flags that are not unique in the DPDK library are set either to values within the
+    RTE_MBUF_F_FIRST_FREE-RTE_MBUF_F_LAST_FREE range for Rx or shifted 61+ bits for Tx.
+
+    References:
+        DPDK lib: ``lib/mbuf/rte_mbuf_core.h``
+    """
+
+    # RX flags
+
+    #: The RX packet is a 802.1q VLAN packet, and the tci has been saved in mbuf->vlan_tci. If the
+    #: flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN header has been stripped from
+    #: mbuf data, else it is still present.
+    RTE_MBUF_F_RX_VLAN = auto()
+
+    #: RX packet with RSS hash result.
+    RTE_MBUF_F_RX_RSS_HASH = auto()
+
+    #: RX packet with FDIR match indicate.
+    RTE_MBUF_F_RX_FDIR = auto()
+
+    #: This flag is set when the outermost IP header checksum is detected as wrong by the hardware.
+    RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD = 1 << 5
+
+    #: A vlan has been stripped by the hardware and its tci is saved in mbuf->vlan_tci. This can
+    #: only happen if vlan stripping is enabled in the RX configuration of the PMD. When
+    #: RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also be set.
+    RTE_MBUF_F_RX_VLAN_STRIPPED = auto()
+
+    #: No information about the RX IP checksum. Value is 0 in the DPDK library.
+    RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN = 1 << 23
+    #: The IP checksum in the packet is wrong.
+    RTE_MBUF_F_RX_IP_CKSUM_BAD = 1 << 4
+    #: The IP checksum in the packet is valid.
+    RTE_MBUF_F_RX_IP_CKSUM_GOOD = 1 << 7
+    #: The IP checksum is not correct in the packet data, but the integrity of the IP header is
+    #: verified. Value is RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD in the DPDK
+    #: library.
+    RTE_MBUF_F_RX_IP_CKSUM_NONE = 1 << 24
+
+    #: No information about the RX L4 checksum. Value is 0 in the DPDK library.
+    RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN = 1 << 25
+    #: The L4 checksum in the packet is wrong.
+    RTE_MBUF_F_RX_L4_CKSUM_BAD = 1 << 3
+    #: The L4 checksum in the packet is valid.
+    RTE_MBUF_F_RX_L4_CKSUM_GOOD = 1 << 8
+    #: The L4 checksum is not correct in the packet data, but the integrity of the L4 data is
+    #: verified. Value is RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD in the DPDK
+    #: library.
+    RTE_MBUF_F_RX_L4_CKSUM_NONE = 1 << 26
+
+    #: RX IEEE1588 L2 Ethernet PT Packet.
+    RTE_MBUF_F_RX_IEEE1588_PTP = 1 << 9
+    #: RX IEEE1588 L2/L4 timestamped packet.
+    RTE_MBUF_F_RX_IEEE1588_TMST = 1 << 10
+
+    #: FD id reported if FDIR match.
+    RTE_MBUF_F_RX_FDIR_ID = 1 << 13
+    #: Flexible bytes reported if FDIR match.
+    RTE_MBUF_F_RX_FDIR_FLX = 1 << 14
+
+    #: If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are set, the 2 VLANs
+    #: have been stripped by the hardware. If RTE_MBUF_F_RX_QINQ_STRIPPED is set and
+    #: RTE_MBUF_F_RX_VLAN_STRIPPED is unset, only the outer VLAN is removed from packet data.
+    RTE_MBUF_F_RX_QINQ_STRIPPED = auto()
+
+    #: When packets are coalesced by a hardware or virtual driver, this flag can be set in the RX
+    #: mbuf, meaning that the m->tso_segsz field is valid and is set to the segment size of
+    #: original packets.
+    RTE_MBUF_F_RX_LRO = auto()
+
+    #: Indicate that security offload processing was applied on the RX packet.
+    RTE_MBUF_F_RX_SEC_OFFLOAD = 1 << 18
+    #: Indicate that security offload processing failed on the RX packet.
+    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED = auto()
+
+    #: The RX packet is a double VLAN. If this flag is set, RTE_MBUF_F_RX_VLAN must also be set. If
+    #: the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs headers have been stripped
+    #: from mbuf data, else they are still present.
+    RTE_MBUF_F_RX_QINQ = auto()
+
+    #: No info about the outer RX L4 checksum. Value is 0 in the DPDK library.
+    RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN = 1 << 27
+    #: The outer L4 checksum in the packet is wrong
+    RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD = 1 << 21
+    #: The outer L4 checksum in the packet is valid
+    RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD = 1 << 22
+    #: Invalid outer L4 checksum state. Value is
+    #: RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD in the DPDK library.
+    RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID = 1 << 28
+
+    # TX flags
+
+    #: Outer UDP checksum offload flag. This flag is used for enabling outer UDP checksum in PMD.
+    #: To use outer UDP checksum, the user either needs to enable the following in mbuf:
+    #:
+    #:  a) Fill outer_l2_len and outer_l3_len in mbuf.
+    #:  b) Set the RTE_MBUF_F_TX_OUTER_UDP_CKSUM flag.
+    #:  c) Set the RTE_MBUF_F_TX_OUTER_IPV4 or RTE_MBUF_F_TX_OUTER_IPV6 flag.
+    #:
+    #: Or configure RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM offload flag.
+    RTE_MBUF_F_TX_OUTER_UDP_CKSUM = 1 << 41
+
+    #: UDP Fragmentation Offload flag. This flag is used for enabling UDP fragmentation in SW or in
+    #: HW.
+    RTE_MBUF_F_TX_UDP_SEG = auto()
+
+    #: Request security offload processing on the TX packet. To use Tx security offload, the user
+    #: needs to fill l2_len in mbuf indicating L2 header size and where L3 header starts.
+    #: Similarly, l3_len should also be filled along with ol_flags reflecting current L3 type.
+    RTE_MBUF_F_TX_SEC_OFFLOAD = auto()
+
+    #: Offload the MACsec. This flag must be set by the application to enable this offload feature
+    #: for a packet to be transmitted.
+    RTE_MBUF_F_TX_MACSEC = auto()
+
+    # Bits 45:48 are used for the tunnel type in ``lib/mbuf/rte_mbuf_core.h``, but some are modified
+    # in this Flag to maintain uniqueness. The tunnel type must be specified for TSO or checksum on
+    # the inner part of tunnel packets. These flags can be used with RTE_MBUF_F_TX_TCP_SEG for TSO,
+    # or RTE_MBUF_F_TX_xxx_CKSUM. The mbuf fields for inner and outer header lengths are required:
+    # outer_l2_len, outer_l3_len, l2_len, l3_len, l4_len and tso_segsz for TSO.
+
+    #:
+    RTE_MBUF_F_TX_TUNNEL_VXLAN = 1 << 45
+    #:
+    RTE_MBUF_F_TX_TUNNEL_GRE = 1 << 46
+    #: Value is 3 << 45 in the DPDK library.
+    RTE_MBUF_F_TX_TUNNEL_IPIP = 1 << 61
+    #:
+    RTE_MBUF_F_TX_TUNNEL_GENEVE = 1 << 47
+    #: TX packet with MPLS-in-UDP RFC 7510 header. Value is 5 << 45 in the DPDK library.
+    RTE_MBUF_F_TX_TUNNEL_MPLSINUDP = 1 << 62
+    #: Value is 6 << 45 in the DPDK library.
+    RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE = 1 << 63
+    #: Value is 7 << 45 in the DPDK library.
+    RTE_MBUF_F_TX_TUNNEL_GTP = 1 << 64
+    #:
+    RTE_MBUF_F_TX_TUNNEL_ESP = 1 << 48
+    #: Generic IP encapsulated tunnel type, used for TSO and checksum offload. This can be used for
+    #: tunnels which are not standards or listed above. It is preferred to use specific tunnel
+    #: flags like RTE_MBUF_F_TX_TUNNEL_GRE or RTE_MBUF_F_TX_TUNNEL_IPIP if possible. The ethdev
+    #: must be configured with RTE_ETH_TX_OFFLOAD_IP_TNL_TSO.  Outer and inner checksums are done
+    #: according to the existing flags like RTE_MBUF_F_TX_xxx_CKSUM. Specific tunnel headers that
+    #: contain payload length, sequence id or checksum are not expected to be updated. Value is
+    #: 0xD << 45 in the DPDK library.
+    RTE_MBUF_F_TX_TUNNEL_IP = 1 << 65
+    #: Generic UDP encapsulated tunnel type, used for TSO and checksum offload. UDP tunnel type
+    #: implies outer IP layer. It can be used for tunnels which are not standards or listed above.
+    #: It is preferred to use specific tunnel flags like RTE_MBUF_F_TX_TUNNEL_VXLAN if possible.
+    #: The ethdev must be configured with RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO. Outer and inner checksums
+    #: are done according to the existing flags like RTE_MBUF_F_TX_xxx_CKSUM. Specific tunnel
+    #: headers that contain payload length, sequence id or checksum are not expected to be updated.
+    #: value is 0xE << 45 in the DPDK library.
+    RTE_MBUF_F_TX_TUNNEL_UDP = 1 << 66
+
+    #: Double VLAN insertion (QinQ) request to driver, driver may offload the insertion based on
+    #: device capability. Mbuf 'vlan_tci' & 'vlan_tci_outer' must be valid when this flag is set.
+    RTE_MBUF_F_TX_QINQ = 1 << 49
+
+    #: TCP segmentation offload. To enable this offload feature for a packet to be transmitted on
+    #: hardware supporting TSO:
+    #:
+    #:  - set the RTE_MBUF_F_TX_TCP_SEG flag in mbuf->ol_flags (this flag implies
+    #:      RTE_MBUF_F_TX_TCP_CKSUM)
+    #:  - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
+    #:      * if it's IPv4, set the RTE_MBUF_F_TX_IP_CKSUM flag
+    #:  - fill the mbuf offload information: l2_len, l3_len, l4_len, tso_segsz
+    RTE_MBUF_F_TX_TCP_SEG = auto()
+
+    #: TX IEEE1588 packet to timestamp.
+    RTE_MBUF_F_TX_IEEE1588_TMST = auto()
+
+    # Bits 52+53 used for L4 packet type with checksum enabled in ``lib/mbuf/rte_mbuf_core.h`` but
+    # some values must be modified in this framework to maintain uniqueness. To use hardware
+    # L4 checksum offload, the user needs to:
+    #
+    # - fill l2_len and l3_len in mbuf
+    # - set the flags RTE_MBUF_F_TX_TCP_CKSUM, RTE_MBUF_F_TX_SCTP_CKSUM or
+    #   RTE_MBUF_F_TX_UDP_CKSUM
+    # - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
+
+    #: Disable L4 cksum of TX pkt. Value is 0 in the DPDK library.
+    RTE_MBUF_F_TX_L4_NO_CKSUM = 1 << 67
+    #: TCP cksum of TX pkt. Computed by NIC.
+    RTE_MBUF_F_TX_TCP_CKSUM = 1 << 52
+    #: SCTP cksum of TX pkt. Computed by NIC.
+    RTE_MBUF_F_TX_SCTP_CKSUM = 1 << 53
+    #: UDP cksum of TX pkt. Computed by NIC. Value is 3 << 52 in the DPDK library.
+    RTE_MBUF_F_TX_UDP_CKSUM = 1 << 68
+
+    #: Offload the IP checksum in the hardware. The flag RTE_MBUF_F_TX_IPV4 should also be set by
+    #: the application, although a PMD will only check RTE_MBUF_F_TX_IP_CKSUM.
+    RTE_MBUF_F_TX_IP_CKSUM = 1 << 54
+
+    #: Packet is IPv4. This flag must be set when using any offload feature (TSO, L3 or L4
+    #: checksum) to tell the NIC that the packet is an IPv4 packet. If the packet is a tunneled
+    #: packet, this flag is related to the inner headers.
+    RTE_MBUF_F_TX_IPV4 = auto()
+    #: Packet is IPv6. This flag must be set when using an offload feature (TSO or L4 checksum) to
+    #: tell the NIC that the packet is an IPv6 packet. If the packet is a tunneled packet, this
+    #: flag is related to the inner headers.
+    RTE_MBUF_F_TX_IPV6 = auto()
+    #: VLAN tag insertion request to driver, driver may offload the insertion based on the device
+    #: capability. mbuf 'vlan_tci' field must be valid when this flag is set.
+    RTE_MBUF_F_TX_VLAN = auto()
+
+    #: Offload the IP checksum of an external header in the hardware. The flag
+    #: RTE_MBUF_F_TX_OUTER_IPV4 should also be set by the application, although a PMD will only
+    #: check RTE_MBUF_F_TX_OUTER_IP_CKSUM.
+    RTE_MBUF_F_TX_OUTER_IP_CKSUM = auto()
+    #: Packet outer header is IPv4. This flag must be set when using any outer offload feature (L3
+    #: or L4 checksum) to tell the NIC that the outer header of the tunneled packet is an IPv4
+    #: packet.
+    RTE_MBUF_F_TX_OUTER_IPV4 = auto()
+    #: Packet outer header is IPv6. This flag must be set when using any outer offload feature (L4
+    #: checksum) to tell the NIC that the outer header of the tunneled packet is an IPv6 packet.
+    RTE_MBUF_F_TX_OUTER_IPV6 = auto()
+
+    @classmethod
+    def from_list_string(cls, names: str) -> Self:
+        """Makes a flag from a whitespace-separated list of names.
+
+        Args:
+            names: a whitespace-separated list containing the members of this flag.
+
+        Returns:
+            An instance of this flag.
+        """
+        flag = cls(0)
+        for name in names.split():
+            flag |= cls.from_str(name)
+        return flag
+
+    @classmethod
+    def from_str(cls, name: str) -> Self:
+        """Makes a flag matching the supplied name.
+
+        Args:
+            name: a valid member of this flag in text
+        Returns:
+            An instance of this flag.
+        """
+        member_name = name.strip().replace("-", "_")
+        return cls[member_name]
+
+    @classmethod
+    def make_parser(cls) -> ParserFn:
+        """Makes a parser function.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        return TextParser.wrap(
+            TextParser.find(r"ol_flags: ([^\n]+)"),
+            cls.from_list_string,
+        )
+
+
+class RtePTypes(Flag):
+    """Flag representing possible packet types in DPDK verbose output.
+
+    Values in this class are derived from definitions in the RTE MBUF ptype library in DPDK located
+    in ``lib/mbuf/rte_mbuf_ptype.h``. Specifically, the names of values in this class should match
+    the possible return options from the functions ``rte_get_ptype_*_name`` in ``rte_mbuf_ptype.c``.
+
+    References:
+        DPDK lib: ``lib/mbuf/rte_mbuf_ptype.h``
+        DPDK ptype name formatting functions: ``lib/mbuf/rte_mbuf_ptype.c:rte_get_ptype_*_name()``
+    """
+
+    # L2
+    #: Ethernet packet type. This is used for outer packet for tunneling cases.
+    L2_ETHER = auto()
+    #: Ethernet packet type for time sync.
+    L2_ETHER_TIMESYNC = auto()
+    #: ARP (Address Resolution Protocol) packet type.
+    L2_ETHER_ARP = auto()
+    #: LLDP (Link Layer Discovery Protocol) packet type.
+    L2_ETHER_LLDP = auto()
+    #: NSH (Network Service Header) packet type.
+    L2_ETHER_NSH = auto()
+    #: VLAN packet type.
+    L2_ETHER_VLAN = auto()
+    #: QinQ packet type.
+    L2_ETHER_QINQ = auto()
+    #: PPPOE packet type.
+    L2_ETHER_PPPOE = auto()
+    #: FCoE packet type..
+    L2_ETHER_FCOE = auto()
+    #: MPLS packet type.
+    L2_ETHER_MPLS = auto()
+    #: No L2 packet information.
+    L2_UNKNOWN = auto()
+
+    # L3
+    #: IP (Internet Protocol) version 4 packet type. This is used for outer packet for tunneling
+    #: cases, and does not contain any header option.
+    L3_IPV4 = auto()
+    #: IP (Internet Protocol) version 4 packet type. This is used for outer packet for tunneling
+    #: cases, and contains header options.
+    L3_IPV4_EXT = auto()
+    #: IP (Internet Protocol) version 6 packet type. This is used for outer packet for tunneling
+    #: cases, and does not contain any extension header.
+    L3_IPV6 = auto()
+    #: IP (Internet Protocol) version 4 packet type. This is used for outer packet for tunneling
+    #: cases, and may or maynot contain header options.
+    L3_IPV4_EXT_UNKNOWN = auto()
+    #: IP (Internet Protocol) version 6 packet type. This is used for outer packet for tunneling
+    #: cases, and contains extension headers.
+    L3_IPV6_EXT = auto()
+    #: IP (Internet Protocol) version 6 packet type. This is used for outer packet for tunneling
+    #: cases, and may or maynot contain extension headers.
+    L3_IPV6_EXT_UNKNOWN = auto()
+    #: No L3 packet information.
+    L3_UNKNOWN = auto()
+
+    # L4
+    #: TCP (Transmission Control Protocol) packet type. This is used for outer packet for tunneling
+    #: cases.
+    L4_TCP = auto()
+    #: UDP (User Datagram Protocol) packet type. This is used for outer packet for tunneling cases.
+    L4_UDP = auto()
+    #: Fragmented IP (Internet Protocol) packet type. This is used for outer packet for tunneling
+    #: cases and refers to those packets of any IP types which can be recognized as fragmented. A
+    #: fragmented packet cannot be recognized as any other L4 types (RTE_PTYPE_L4_TCP,
+    #: RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP, RTE_PTYPE_L4_NONFRAG).
+    L4_FRAG = auto()
+    #: SCTP (Stream Control Transmission Protocol) packet type. This is used for outer packet for
+    #: tunneling cases.
+    L4_SCTP = auto()
+    #: ICMP (Internet Control Message Protocol) packet type. This is used for outer packet for
+    #: tunneling cases.
+    L4_ICMP = auto()
+    #: Non-fragmented IP (Internet Protocol) packet type. This is used for outer packet for
+    #: tunneling cases and refers to those packets of any IP types, that cannot be recognized as
+    #: any of the above L4 types (RTE_PTYPE_L4_TCP, RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_FRAG,
+    #: RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP).
+    L4_NONFRAG = auto()
+    #: IGMP (Internet Group Management Protocol) packet type.
+    L4_IGMP = auto()
+    #: No L4 packet information.
+    L4_UNKNOWN = auto()
+
+    # Tunnel
+    #: IP (Internet Protocol) in IP (Internet Protocol) tunneling packet type.
+    TUNNEL_IP = auto()
+    #: GRE (Generic Routing Encapsulation) tunneling packet type.
+    TUNNEL_GRE = auto()
+    #: VXLAN (Virtual eXtensible Local Area Network) tunneling packet type.
+    TUNNEL_VXLAN = auto()
+    #: NVGRE (Network Virtualization using Generic Routing Encapsulation) tunneling packet type.
+    TUNNEL_NVGRE = auto()
+    #: GENEVE (Generic Network Virtualization Encapsulation) tunneling packet type.
+    TUNNEL_GENEVE = auto()
+    #: Tunneling packet type of Teredo, VXLAN (Virtual eXtensible Local Area Network) or GRE
+    #: (Generic Routing Encapsulation) could be recognized as this packet type, if they can not be
+    #: recognized independently as of hardware capability.
+    TUNNEL_GRENAT = auto()
+    #: GTP-C (GPRS Tunnelling Protocol) control tunneling packet type.
+    TUNNEL_GTPC = auto()
+    #: GTP-U (GPRS Tunnelling Protocol) user data tunneling packet type.
+    TUNNEL_GTPU = auto()
+    #: ESP (IP Encapsulating Security Payload) tunneling packet type.
+    TUNNEL_ESP = auto()
+    #: L2TP (Layer 2 Tunneling Protocol) tunneling packet type.
+    TUNNEL_L2TP = auto()
+    #: VXLAN-GPE (VXLAN Generic Protocol Extension) tunneling packet type.
+    TUNNEL_VXLAN_GPE = auto()
+    #: MPLS-in-UDP tunneling packet type (RFC 7510).
+    TUNNEL_MPLS_IN_UDP = auto()
+    #: MPLS-in-GRE tunneling packet type (RFC 4023).
+    TUNNEL_MPLS_IN_GRE = auto()
+    #: No tunnel information found on the packet.
+    TUNNEL_UNKNOWN = auto()
+
+    # Inner L2
+    #: Ethernet packet type. This is used for inner packet type only.
+    INNER_L2_ETHER = auto()
+    #: Ethernet packet type with VLAN (Virtual Local Area Network) tag.
+    INNER_L2_ETHER_VLAN = auto()
+    #: QinQ packet type.
+    INNER_L2_ETHER_QINQ = auto()
+    #: No inner L2 information found on the packet.
+    INNER_L2_UNKNOWN = auto()
+
+    # Inner L3
+    #: IP (Internet Protocol) version 4 packet type. This is used for inner packet only, and does
+    #: not contain any header option.
+    INNER_L3_IPV4 = auto()
+    #: IP (Internet Protocol) version 4 packet type. This is used for inner packet only, and
+    #: contains header options.
+    INNER_L3_IPV4_EXT = auto()
+    #: IP (Internet Protocol) version 6 packet type. This is used for inner packet only, and does
+    #: not contain any extension header.
+    INNER_L3_IPV6 = auto()
+    #: IP (Internet Protocol) version 4 packet type. This is used for inner packet only, and may or
+    #: may not contain header options.
+    INNER_L3_IPV4_EXT_UNKNOWN = auto()
+    #: IP (Internet Protocol) version 6 packet type. This is used for inner packet only, and
+    #: contains extension headers.
+    INNER_L3_IPV6_EXT = auto()
+    #: IP (Internet Protocol) version 6 packet type. This is used for inner packet only, and may or
+    #: may not contain extension headers.
+    INNER_L3_IPV6_EXT_UNKNOWN = auto()
+    #: No inner L3 information found on the packet.
+    INNER_L3_UNKNOWN = auto()
+
+    # Inner L4
+    #: TCP (Transmission Control Protocol) packet type. This is used for inner packet only.
+    INNER_L4_TCP = auto()
+    #: UDP (User Datagram Protocol) packet type. This is used for inner packet only.
+    INNER_L4_UDP = auto()
+    #: Fragmented IP (Internet Protocol) packet type. This is used for inner packet only, and may
+    #: or maynot have a layer 4 packet.
+    INNER_L4_FRAG = auto()
+    #: SCTP (Stream Control Transmission Protocol) packet type. This is used for inner packet only.
+    INNER_L4_SCTP = auto()
+    #: ICMP (Internet Control Message Protocol) packet type. This is used for inner packet only.
+    INNER_L4_ICMP = auto()
+    #: Non-fragmented IP (Internet Protocol) packet type. It is used for inner packet only, and may
+    #: or may not have other unknown layer 4 packet types.
+    INNER_L4_NONFRAG = auto()
+    #: No inner L4 information found on the packet.
+    INNER_L4_UNKNOWN = auto()
+
+    @classmethod
+    def from_list_string(cls, names: str) -> Self:
+        """Makes a flag from a whitespace-separated list of names.
+
+        Args:
+            names: a whitespace-separated list containing the members of this flag.
+
+        Returns:
+            An instance of this flag.
+        """
+        flag = cls(0)
+        for name in names.split():
+            flag |= cls.from_str(name)
+        return flag
+
+    @classmethod
+    def from_str(cls, name: str) -> Self:
+        """Makes a flag matching the supplied name.
+
+        Args:
+            name: a valid member of this flag in text
+        Returns:
+            An instance of this flag.
+        """
+        member_name = name.strip().replace("-", "_")
+        return cls[member_name]
+
+    @classmethod
+    def make_parser(cls, hw: bool) -> ParserFn:
+        """Makes a parser function.
+
+        Args:
+            hw: Whether to make a parser for hardware ptypes or software ptypes. If :data:`True`,
+                hardware ptypes will be collected, otherwise software pytpes will.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        return TextParser.wrap(
+            TextParser.find(f"{'hw' if hw else 'sw'} ptype: ([^-]+)"),
+            cls.from_list_string,
+        )
+
+
+@dataclass
+class TestPmdVerbosePacket(TextParser):
+    """Packet information provided by verbose output in Testpmd.
+
+    This dataclass expects that packet information be prepended with the starting line of packet
+    bursts. Specifically, the line that reads "port X/queue Y: sent/received Z packets".
+    """
+
+    #: ID of the port that handled the packet.
+    port_id: int = field(metadata=TextParser.find_int(r"port (\d+)/queue \d+"))
+    #: ID of the queue that handled the packet.
+    queue_id: int = field(metadata=TextParser.find_int(r"port \d+/queue (\d+)"))
+    #: Whether the packet was received or sent by the queue/port.
+    was_received: bool = field(metadata=TextParser.find(r"received \d+ packets"))
+    #:
+    src_mac: str = field(metadata=TextParser.find(f"src=({REGEX_FOR_MAC_ADDRESS})"))
+    #:
+    dst_mac: str = field(metadata=TextParser.find(f"dst=({REGEX_FOR_MAC_ADDRESS})"))
+    #: Memory pool the packet was handled on.
+    pool: str = field(metadata=TextParser.find(r"pool=(\S+)"))
+    #: Packet type in hex.
+    p_type: int = field(metadata=TextParser.find_int(r"type=(0x[a-fA-F\d]+)"))
+    #:
+    length: int = field(metadata=TextParser.find_int(r"length=(\d+)"))
+    #: Number of segments in the packet.
+    nb_segs: int = field(metadata=TextParser.find_int(r"nb_segs=(\d+)"))
+    #: Hardware packet type.
+    hw_ptype: RtePTypes = field(metadata=RtePTypes.make_parser(hw=True))
+    #: Software packet type.
+    sw_ptype: RtePTypes = field(metadata=RtePTypes.make_parser(hw=False))
+    #:
+    l2_len: int = field(metadata=TextParser.find_int(r"l2_len=(\d+)"))
+    #:
+    ol_flags: PacketOffloadFlag = field(metadata=PacketOffloadFlag.make_parser())
+    #: RSS hash of the packet in hex.
+    rss_hash: int | None = field(
+        default=None, metadata=TextParser.find_int(r"RSS hash=(0x[a-fA-F\d]+)")
+    )
+    #: RSS queue that handled the packet in hex.
+    rss_queue: int | None = field(
+        default=None, metadata=TextParser.find_int(r"RSS queue=(0x[a-fA-F\d]+)")
+    )
+    #:
+    l3_len: int | None = field(default=None, metadata=TextParser.find_int(r"l3_len=(\d+)"))
+    #:
+    l4_len: int | None = field(default=None, metadata=TextParser.find_int(r"l4_len=(\d+)"))
+    #:
+    l4_dport: int | None = field(
+        default=None,
+        metadata=TextParser.find_int(r"Destination (?:TCP|UDP) port=(\d+)"),
+    )
+
+
+class RxOffloadCapability(Flag):
+    """Rx offload capabilities of a device.
+
+    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
+    They're prefixed with ``RTE_ETH_RX_OFFLOAD`` in ``lib/ethdev/rte_ethdev.h``
+    instead of ``RX_OFFLOAD``, which is what testpmd changes the prefix to.
+    The values are not contiguous, so the correspondence is preserved
+    by specifying concrete values interspersed between auto() values.
+
+    The ``RX_OFFLOAD`` prefix has been preserved so that the same flag names can be used
+    in :class:`NicCapability`. The prefix is needed in :class:`NicCapability` since there's
+    no other qualifier which would sufficiently distinguish it from other capabilities.
+
+    References:
+        DPDK lib: ``lib/ethdev/rte_ethdev.h``
+        testpmd display function: ``app/test-pmd/cmdline.c:print_rx_offloads()``
+    """
+
+    #:
+    RX_OFFLOAD_VLAN_STRIP = auto()
+    #: Device supports L3 checksum offload.
+    RX_OFFLOAD_IPV4_CKSUM = auto()
+    #: Device supports L4 checksum offload.
+    RX_OFFLOAD_UDP_CKSUM = auto()
+    #: Device supports L4 checksum offload.
+    RX_OFFLOAD_TCP_CKSUM = auto()
+    #: Device supports Large Receive Offload.
+    RX_OFFLOAD_TCP_LRO = auto()
+    #: Device supports QinQ (queue in queue) offload.
+    RX_OFFLOAD_QINQ_STRIP = auto()
+    #: Device supports inner packet L3 checksum.
+    RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
+    #: Device supports MACsec.
+    RX_OFFLOAD_MACSEC_STRIP = auto()
+    #: Device supports filtering of a VLAN Tag identifier.
+    RX_OFFLOAD_VLAN_FILTER = 1 << 9
+    #: Device supports VLAN offload.
+    RX_OFFLOAD_VLAN_EXTEND = auto()
+    #: Device supports receiving segmented mbufs.
+    RX_OFFLOAD_SCATTER = 1 << 13
+    #: Device supports Timestamp.
+    RX_OFFLOAD_TIMESTAMP = auto()
+    #: Device supports crypto processing while packet is received in NIC.
+    RX_OFFLOAD_SECURITY = auto()
+    #: Device supports CRC stripping.
+    RX_OFFLOAD_KEEP_CRC = auto()
+    #: Device supports L4 checksum offload.
+    RX_OFFLOAD_SCTP_CKSUM = auto()
+    #: Device supports inner packet L4 checksum.
+    RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
+    #: Device supports RSS hashing.
+    RX_OFFLOAD_RSS_HASH = auto()
+    #: Device supports
+    RX_OFFLOAD_BUFFER_SPLIT = auto()
+    #: Device supports all checksum capabilities.
+    RX_OFFLOAD_CHECKSUM = RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_UDP_CKSUM | RX_OFFLOAD_TCP_CKSUM
+    #: Device supports all VLAN capabilities.
+    RX_OFFLOAD_VLAN = (
+        RX_OFFLOAD_VLAN_STRIP
+        | RX_OFFLOAD_VLAN_FILTER
+        | RX_OFFLOAD_VLAN_EXTEND
+        | RX_OFFLOAD_QINQ_STRIP
+    )
+
+    @classmethod
+    def from_string(cls, line: str) -> Self:
+        """Make an instance from a string containing the flag names separated with a space.
+
+        Args:
+            line: The line to parse.
+
+        Returns:
+            A new instance containing all found flags.
+        """
+        flag = cls(0)
+        for flag_name in line.split():
+            flag |= cls[f"RX_OFFLOAD_{flag_name}"]
+        return flag
+
+    @classmethod
+    def make_parser(cls, per_port: bool) -> ParserFn:
+        """Make a parser function.
+
+        Args:
+            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
+                will return capabilities per queue.
+
+        Returns:
+            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
+                parser function that makes an instance of this flag from text.
+        """
+        granularity = "Port" if per_port else "Queue"
+        return TextParser.wrap(
+            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
+            cls.from_string,
+        )
+
+
+@dataclass
+class RxOffloadCapabilities(TextParser):
+    """The result of testpmd's ``show port <port_id> rx_offload capabilities`` command.
+
+    References:
+        testpmd command function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
+        testpmd display function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
+    """
+
+    #:
+    port_id: int = field(
+        metadata=TextParser.find_int(r"Rx Offloading Capabilities of port (\d+) :")
+    )
+    #: Per-queue Rx offload capabilities.
+    per_queue: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(False))
+    #: Capabilities other than per-queue Rx offload capabilities.
+    per_port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
+
+
+@dataclass
+class TestPmdPortFlowCtrl(TextParser):
+    """Class representing a port's flow control parameters.
+
+    The parameters can also be parsed from the output of ``show port <port_id> flow_ctrl``.
+    """
+
+    #: Enable Reactive Extensions.
+    rx: bool = field(default=False, metadata=TextParser.find(r"Rx pause: on"))
+    #: Enable Transmit.
+    tx: bool = field(default=False, metadata=TextParser.find(r"Tx pause: on"))
+    #: High threshold value to trigger XOFF.
+    high_water: int = field(
+        default=0, metadata=TextParser.find_int(r"High waterline: (0x[a-fA-F\d]+)")
+    )
+    #: Low threshold value to trigger XON.
+    low_water: int = field(
+        default=0, metadata=TextParser.find_int(r"Low waterline: (0x[a-fA-F\d]+)")
+    )
+    #: Pause quota in the Pause frame.
+    pause_time: int = field(default=0, metadata=TextParser.find_int(r"Pause time: (0x[a-fA-F\d]+)"))
+    #: Send XON frame.
+    send_xon: bool = field(default=False, metadata=TextParser.find(r"Tx pause: on"))
+    #: Enable receiving MAC control frames.
+    mac_ctrl_frame_fwd: bool = field(default=False, metadata=TextParser.find(r"Tx pause: on"))
+    #: Change the auto-negotiation parameter.
+    autoneg: bool = field(default=False, metadata=TextParser.find(r"Autoneg: on"))
+
+    def __str__(self) -> str:
+        """Returns the string representation of this instance."""
+        ret = (
+            f"rx {'on' if self.rx else 'off'} "
+            f"tx {'on' if self.tx else 'off'} "
+            f"{self.high_water} "
+            f"{self.low_water} "
+            f"{self.pause_time} "
+            f"{1 if self.send_xon else 0} "
+            f"mac_ctrl_frame_fwd {'on' if self.mac_ctrl_frame_fwd else 'off'} "
+            f"autoneg {'on' if self.autoneg else 'off'}"
+        )
+        return ret
diff --git a/dts/framework/config/__init__.py b/dts/framework/config/__init__.py
index 1ec744d1d4..d2f0138e4a 100644
--- a/dts/framework/config/__init__.py
+++ b/dts/framework/config/__init__.py
@@ -28,7 +28,6 @@
       and makes it thread safe should we ever want to move in that direction.
 """

-import os
 from pathlib import Path
 from typing import TYPE_CHECKING, Annotated, Any, Literal, TypeVar, cast

@@ -43,7 +42,7 @@
 from .test_run import TestRunConfiguration, create_test_suites_config_model

 # Import only if type checking or building docs, to prevent circular imports.
-if TYPE_CHECKING or os.environ.get("DTS_DOC_BUILD"):
+if TYPE_CHECKING:
     from framework.test_suite import BaseConfig

 NodesConfig = Annotated[list[NodeConfiguration], Field(min_length=1)]
diff --git a/dts/framework/params/eal.py b/dts/framework/params/eal.py
index b90ff33dcf..e84a20f02f 100644
--- a/dts/framework/params/eal.py
+++ b/dts/framework/params/eal.py
@@ -4,15 +4,17 @@
 """Module representing the DPDK EAL-related parameters."""

 from dataclasses import dataclass, field
-from typing import Literal
+from typing import TYPE_CHECKING, Literal

 from framework.params import Params, Switch
 from framework.testbed_model.cpu import LogicalCoreList
-from framework.testbed_model.port import Port
 from framework.testbed_model.virtual_device import VirtualDevice

+if TYPE_CHECKING:
+    from framework.testbed_model.port import Port

-def _port_to_pci(port: Port) -> str:
+
+def _port_to_pci(port: "Port") -> str:
     return port.pci


@@ -42,11 +44,11 @@ class EalParams(Params):
     vdevs: list[VirtualDevice] | None = field(
         default=None, metadata=Params.multiple() | Params.long("vdev")
     )
-    allowed_ports: list[Port] | None = field(
+    allowed_ports: list["Port"] | None = field(
         default=None,
         metadata=Params.convert_value(_port_to_pci) | Params.multiple() | Params.short("a"),
     )
-    blocked_ports: list[Port] | None = field(
+    blocked_ports: list["Port"] | None = field(
         default=None,
         metadata=Params.convert_value(_port_to_pci) | Params.multiple() | Params.short("b"),
     )
diff --git a/dts/framework/params/types.py b/dts/framework/params/types.py
index 87d11502e8..5bc4bd37d9 100644
--- a/dts/framework/params/types.py
+++ b/dts/framework/params/types.py
@@ -15,8 +15,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
 from pathlib import PurePath
 from typing import TypedDict

-from framework.params import Switch, YesNoSwitch
-from framework.params.testpmd import (
+from api.testpmd.config import (
     AnonMempoolAllocationMode,
     EthPeer,
     Event,
@@ -37,6 +36,7 @@ def create_testpmd(**kwargs: Unpack[TestPmdParamsDict]):
     TXRingParams,
     TxUDPPortPair,
 )
+from framework.params import Switch, YesNoSwitch
 from framework.testbed_model.cpu import LogicalCoreList
 from framework.testbed_model.port import Port
 from framework.testbed_model.virtual_device import VirtualDevice
diff --git a/dts/framework/remote_session/__init__.py b/dts/framework/remote_session/__init__.py
index 2c0922acd2..394c88b25e 100644
--- a/dts/framework/remote_session/__init__.py
+++ b/dts/framework/remote_session/__init__.py
@@ -11,46 +11,3 @@
 The interactive sessions open an interactive shell which is continuously open,
 allowing it to send and receive data within that particular shell.
 """
-
-from framework.config.node import NodeConfiguration
-from framework.logger import DTSLogger
-
-from .interactive_remote_session import InteractiveRemoteSession
-from .remote_session import RemoteSession
-
-
-def create_remote_session(
-    node_config: NodeConfiguration, name: str, logger: DTSLogger
-) -> RemoteSession:
-    """Factory for non-interactive remote sessions.
-
-    The function returns an SSH session, but will be extended if support
-    for other protocols is added.
-
-    Args:
-        node_config: The test run configuration of the node to connect to.
-        name: The name of the session.
-        logger: The logger instance this session will use.
-
-    Returns:
-        The SSH remote session.
-    """
-    return RemoteSession(node_config, name, logger)
-
-
-def create_interactive_session(
-    node_config: NodeConfiguration, logger: DTSLogger
-) -> InteractiveRemoteSession:
-    """Factory for interactive remote sessions.
-
-    The function returns an interactive SSH session, but will be extended if support
-    for other protocols is added.
-
-    Args:
-        node_config: The test run configuration of the node to connect to.
-        logger: The logger instance this session will use.
-
-    Returns:
-        The interactive SSH remote session.
-    """
-    return InteractiveRemoteSession(node_config, logger)
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
deleted file mode 100644
index 1df3d5f792..0000000000
--- a/dts/framework/remote_session/testpmd_shell.py
+++ /dev/null
@@ -1,2844 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2023 University of New Hampshire
-# Copyright(c) 2023 PANTHEON.tech s.r.o.
-# Copyright(c) 2024 Arm Limited
-
-"""Testpmd interactive shell.
-
-Typical usage example in a TestSuite::
-
-    testpmd_shell = TestPmdShell(self.sut_node)
-    devices = testpmd_shell.get_devices()
-    for device in devices:
-        print(device)
-    testpmd_shell.close()
-"""
-
-import functools
-import re
-import time
-from collections.abc import Callable, MutableSet
-from dataclasses import dataclass, field
-from enum import Flag, auto
-from os import environ
-from pathlib import PurePath
-from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
-
-from framework.context import get_ctx
-from framework.remote_session.interactive_shell import only_active
-from framework.testbed_model.topology import TopologyType
-
-if TYPE_CHECKING or environ.get("DTS_DOC_BUILD"):
-    from enum import Enum as NoAliasEnum
-else:
-    from aenum import NoAliasEnum
-
-from typing_extensions import Self, Unpack
-
-from framework.exception import InteractiveCommandExecutionError, InternalError
-from framework.params.testpmd import PortTopology, SimpleForwardingModes, TestPmdParams
-from framework.params.types import TestPmdParamsDict
-from framework.parser import ParserFn, TextParser
-from framework.remote_session.dpdk_shell import DPDKShell
-from framework.settings import SETTINGS
-from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
-
-P = ParamSpec("P")
-TestPmdShellMethod = Callable[Concatenate["TestPmdShell", P], Any]
-
-TestPmdShellCapabilityMethod: TypeAlias = Callable[
-    ["TestPmdShell", MutableSet["NicCapability"], MutableSet["NicCapability"]], None
-]
-
-TestPmdShellDecorator: TypeAlias = Callable[[TestPmdShellMethod], TestPmdShellMethod]
-
-TestPmdShellNicCapability = tuple[TestPmdShellCapabilityMethod, TestPmdShellDecorator | None]
-
-
-class TestPmdDevice:
-    """The data of a device that testpmd can recognize.
-
-    Attributes:
-        pci_address: The PCI address of the device.
-    """
-
-    pci_address: str
-
-    def __init__(self, pci_address_line: str) -> None:
-        """Initialize the device from the testpmd output line string.
-
-        Args:
-            pci_address_line: A line of testpmd output that contains a device.
-        """
-        self.pci_address = pci_address_line.strip().split(": ")[1].strip()
-
-    def __str__(self) -> str:
-        """The PCI address captures what the device is."""
-        return self.pci_address
-
-
-class VLANOffloadFlag(Flag):
-    """Flag representing the VLAN offload settings of a NIC port."""
-
-    #:
-    STRIP = auto()
-    #:
-    FILTER = auto()
-    #:
-    EXTEND = auto()
-    #:
-    QINQ_STRIP = auto()
-
-    @classmethod
-    def from_str_dict(cls, d: dict[str, str]) -> Self:
-        """Makes an instance from a dict containing the flag member names with an "on" value.
-
-        Args:
-            d: A dictionary containing the flag members as keys and any string value.
-
-        Returns:
-            A new instance of the flag.
-        """
-        flag = cls(0)
-        for name in cls.__members__:
-            if d.get(name) == "on":
-                flag |= cls[name]
-        return flag
-
-    @classmethod
-    def make_parser(cls) -> ParserFn:
-        """Makes a parser function.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        return TextParser.wrap(
-            TextParser.find(
-                r"VLAN offload:\s+"
-                r"strip (?P<STRIP>on|off), "
-                r"filter (?P<FILTER>on|off), "
-                r"extend (?P<EXTEND>on|off), "
-                r"qinq strip (?P<QINQ_STRIP>on|off)",
-                re.MULTILINE,
-                named=True,
-            ),
-            cls.from_str_dict,
-        )
-
-
-class ChecksumOffloadOptions(Flag):
-    """Flag representing checksum hardware offload layer options."""
-
-    #:
-    ip = auto()
-    #:
-    udp = auto()
-    #:
-    tcp = auto()
-    #:
-    sctp = auto()
-    #:
-    outer_ip = auto()
-    #:
-    outer_udp = auto()
-
-
-class RSSOffloadTypesFlag(Flag):
-    """Flag representing the RSS offload flow types supported by the NIC port."""
-
-    #:
-    ipv4 = auto()
-    #:
-    ipv4_frag = auto()
-    #:
-    ipv4_tcp = auto()
-    #:
-    ipv4_udp = auto()
-    #:
-    ipv4_sctp = auto()
-    #:
-    ipv4_other = auto()
-    #:
-    ipv6 = auto()
-    #:
-    ipv6_frag = auto()
-    #:
-    ipv6_tcp = auto()
-    #:
-    ipv6_udp = auto()
-    #:
-    ipv6_sctp = auto()
-    #:
-    ipv6_other = auto()
-    #:
-    l2_payload = auto()
-    #:
-    ipv6_ex = auto()
-    #:
-    ipv6_tcp_ex = auto()
-    #:
-    ipv6_udp_ex = auto()
-    #:
-    port = auto()
-    #:
-    vxlan = auto()
-    #:
-    geneve = auto()
-    #:
-    nvgre = auto()
-    #:
-    user_defined_22 = auto()
-    #:
-    gtpu = auto()
-    #:
-    eth = auto()
-    #:
-    s_vlan = auto()
-    #:
-    c_vlan = auto()
-    #:
-    esp = auto()
-    #:
-    ah = auto()
-    #:
-    l2tpv3 = auto()
-    #:
-    pfcp = auto()
-    #:
-    pppoe = auto()
-    #:
-    ecpri = auto()
-    #:
-    mpls = auto()
-    #:
-    ipv4_chksum = auto()
-    #:
-    l4_chksum = auto()
-    #:
-    l2tpv2 = auto()
-    #:
-    ipv6_flow_label = auto()
-    #:
-    user_defined_38 = auto()
-    #:
-    user_defined_39 = auto()
-    #:
-    user_defined_40 = auto()
-    #:
-    user_defined_41 = auto()
-    #:
-    user_defined_42 = auto()
-    #:
-    user_defined_43 = auto()
-    #:
-    user_defined_44 = auto()
-    #:
-    user_defined_45 = auto()
-    #:
-    user_defined_46 = auto()
-    #:
-    user_defined_47 = auto()
-    #:
-    user_defined_48 = auto()
-    #:
-    user_defined_49 = auto()
-    #:
-    user_defined_50 = auto()
-    #:
-    user_defined_51 = auto()
-    #:
-    l3_pre96 = auto()
-    #:
-    l3_pre64 = auto()
-    #:
-    l3_pre56 = auto()
-    #:
-    l3_pre48 = auto()
-    #:
-    l3_pre40 = auto()
-    #:
-    l3_pre32 = auto()
-    #:
-    l2_dst_only = auto()
-    #:
-    l2_src_only = auto()
-    #:
-    l4_dst_only = auto()
-    #:
-    l4_src_only = auto()
-    #:
-    l3_dst_only = auto()
-    #:
-    l3_src_only = auto()
-
-    #:
-    ip = ipv4 | ipv4_frag | ipv4_other | ipv6 | ipv6_frag | ipv6_other | ipv6_ex
-    #:
-    udp = ipv4_udp | ipv6_udp | ipv6_udp_ex
-    #:
-    tcp = ipv4_tcp | ipv6_tcp | ipv6_tcp_ex
-    #:
-    sctp = ipv4_sctp | ipv6_sctp
-    #:
-    tunnel = vxlan | geneve | nvgre
-    #:
-    vlan = s_vlan | c_vlan
-    #:
-    all = (
-        eth
-        | vlan
-        | ip
-        | tcp
-        | udp
-        | sctp
-        | l2_payload
-        | l2tpv3
-        | esp
-        | ah
-        | pfcp
-        | gtpu
-        | ecpri
-        | mpls
-        | l2tpv2
-    )
-
-    @classmethod
-    def from_list_string(cls, names: str) -> Self:
-        """Makes a flag from a whitespace-separated list of names.
-
-        Args:
-            names: a whitespace-separated list containing the members of this flag.
-
-        Returns:
-            An instance of this flag.
-        """
-        flag = cls(0)
-        for name in names.split():
-            flag |= cls.from_str(name)
-        return flag
-
-    @classmethod
-    def from_str(cls, name: str) -> Self:
-        """Makes a flag matching the supplied name.
-
-        Args:
-            name: a valid member of this flag in text
-        Returns:
-            An instance of this flag.
-        """
-        member_name = name.strip().replace("-", "_")
-        return cls[member_name]
-
-    @classmethod
-    def make_parser(cls) -> ParserFn:
-        """Makes a parser function.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        return TextParser.wrap(
-            TextParser.find(r"Supported RSS offload flow types:((?:\r?\n?  \S+)+)", re.MULTILINE),
-            RSSOffloadTypesFlag.from_list_string,
-        )
-
-
-class DeviceCapabilitiesFlag(Flag):
-    """Flag representing the device capabilities."""
-
-    #: Device supports Rx queue setup after device started.
-    RUNTIME_RX_QUEUE_SETUP = auto()
-    #: Device supports Tx queue setup after device started.
-    RUNTIME_TX_QUEUE_SETUP = auto()
-    #: Device supports shared Rx queue among ports within Rx domain and switch domain.
-    RXQ_SHARE = auto()
-    #: Device supports keeping flow rules across restart.
-    FLOW_RULE_KEEP = auto()
-    #: Device supports keeping shared flow objects across restart.
-    FLOW_SHARED_OBJECT_KEEP = auto()
-
-    @classmethod
-    def make_parser(cls) -> ParserFn:
-        """Makes a parser function.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        return TextParser.wrap(
-            TextParser.find_int(r"Device capabilities: (0x[A-Fa-f\d]+)"),
-            cls,
-        )
-
-
-class DeviceErrorHandlingMode(StrEnum):
-    """Enum representing the device error handling mode."""
-
-    #:
-    none = auto()
-    #:
-    passive = auto()
-    #:
-    proactive = auto()
-    #:
-    unknown = auto()
-
-    @classmethod
-    def make_parser(cls) -> ParserFn:
-        """Makes a parser function.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this enum from text.
-        """
-        return TextParser.wrap(TextParser.find(r"Device error handling mode: (\w+)"), cls)
-
-
-def make_device_private_info_parser() -> ParserFn:
-    """Device private information parser.
-
-    Ensures that we are not parsing invalid device private info output.
-
-    Returns:
-        ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a parser
-            function that parses the device private info from the TestPmd port info output.
-    """
-
-    def _validate(info: str) -> str | None:
-        info = info.strip()
-        if info == "none" or info.startswith("Invalid file") or info.startswith("Failed to dump"):
-            return None
-        return info
-
-    return TextParser.wrap(TextParser.find(r"Device private info:\s+([\s\S]+)"), _validate)
-
-
-class RxQueueState(StrEnum):
-    """RX queue states.
-
-    References:
-        DPDK lib: ``lib/ethdev/rte_ethdev.h``
-        testpmd display function: ``app/test-pmd/config.c:get_queue_state_name()``
-    """
-
-    #:
-    stopped = auto()
-    #:
-    started = auto()
-    #:
-    hairpin = auto()
-    #:
-    unknown = auto()
-
-    @classmethod
-    def make_parser(cls) -> ParserFn:
-        """Makes a parser function.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this enum from text.
-        """
-        return TextParser.wrap(TextParser.find(r"Rx queue state: ([^\r\n]+)"), cls)
-
-
-@dataclass
-class TestPmdQueueInfo(TextParser):
-    """Dataclass representation of the common parts of the testpmd `show rxq/txq info` commands."""
-
-    #:
-    prefetch_threshold: int = field(metadata=TextParser.find_int(r"prefetch threshold: (\d+)"))
-    #:
-    host_threshold: int = field(metadata=TextParser.find_int(r"host threshold: (\d+)"))
-    #:
-    writeback_threshold: int = field(metadata=TextParser.find_int(r"writeback threshold: (\d+)"))
-    #:
-    free_threshold: int = field(metadata=TextParser.find_int(r"free threshold: (\d+)"))
-    #:
-    deferred_start: bool = field(metadata=TextParser.find("deferred start: on"))
-    #: The number of RXD/TXDs is just the ring size of the queue.
-    ring_size: int = field(metadata=TextParser.find_int(r"Number of (?:RXDs|TXDs): (\d+)"))
-    #:
-    is_queue_started: bool = field(metadata=TextParser.find("queue state: started"))
-    #:
-    burst_mode: str | None = field(
-        default=None, metadata=TextParser.find(r"Burst mode: ([^\r\n]+)")
-    )
-
-
-@dataclass
-class TestPmdTxqInfo(TestPmdQueueInfo):
-    """Representation of testpmd's ``show txq info <port_id> <queue_id>`` command.
-
-    References:
-        testpmd command function: ``app/test-pmd/cmdline.c:cmd_showqueue()``
-        testpmd display function: ``app/test-pmd/config.c:rx_queue_infos_display()``
-    """
-
-    #: Ring size threshold
-    rs_threshold: int | None = field(
-        default=None, metadata=TextParser.find_int(r"TX RS threshold: (\d+)\b")
-    )
-
-
-@dataclass
-class TestPmdRxqInfo(TestPmdQueueInfo):
-    """Representation of testpmd's ``show rxq info <port_id> <queue_id>`` command.
-
-    References:
-        testpmd command function: ``app/test-pmd/cmdline.c:cmd_showqueue()``
-        testpmd display function: ``app/test-pmd/config.c:rx_queue_infos_display()``
-    """
-
-    #: Mempool used by that queue
-    mempool: str | None = field(default=None, metadata=TextParser.find(r"Mempool: ([^\r\n]+)"))
-    #: Drop packets if no descriptors are available
-    drop_packets: bool | None = field(
-        default=None, metadata=TextParser.find(r"RX drop packets: on")
-    )
-    #: Scattered packets Rx enabled
-    scattered_packets: bool | None = field(
-        default=None, metadata=TextParser.find(r"RX scattered packets: on")
-    )
-    #: The state of the queue
-    queue_state: str | None = field(default=None, metadata=RxQueueState.make_parser())
-
-
-@dataclass
-class TestPmdPort(TextParser):
-    """Dataclass representing the result of testpmd's ``show port info`` command."""
-
-    #:
-    id: int = field(metadata=TextParser.find_int(r"Infos for port (\d+)\b"))
-    #:
-    device_name: str = field(metadata=TextParser.find(r"Device name: ([^\r\n]+)"))
-    #:
-    driver_name: str = field(metadata=TextParser.find(r"Driver name: ([^\r\n]+)"))
-    #:
-    socket_id: int = field(metadata=TextParser.find_int(r"Connect to socket: (\d+)"))
-    #:
-    is_link_up: bool = field(metadata=TextParser.find("Link status: up"))
-    #:
-    link_speed: str = field(metadata=TextParser.find(r"Link speed: ([^\r\n]+)"))
-    #:
-    is_link_full_duplex: bool = field(metadata=TextParser.find("Link duplex: full-duplex"))
-    #:
-    is_link_autonegotiated: bool = field(metadata=TextParser.find("Autoneg status: On"))
-    #:
-    is_promiscuous_mode_enabled: bool = field(metadata=TextParser.find("Promiscuous mode: enabled"))
-    #:
-    is_allmulticast_mode_enabled: bool = field(
-        metadata=TextParser.find("Allmulticast mode: enabled")
-    )
-    #: Maximum number of MAC addresses
-    max_mac_addresses_num: int = field(
-        metadata=TextParser.find_int(r"Maximum number of MAC addresses: (\d+)")
-    )
-    #: Maximum configurable length of RX packet
-    max_hash_mac_addresses_num: int = field(
-        metadata=TextParser.find_int(r"Maximum number of MAC addresses of hash filtering: (\d+)")
-    )
-    #: Minimum size of RX buffer
-    min_rx_bufsize: int = field(metadata=TextParser.find_int(r"Minimum size of RX buffer: (\d+)"))
-    #: Maximum configurable length of RX packet
-    max_rx_packet_length: int = field(
-        metadata=TextParser.find_int(r"Maximum configurable length of RX packet: (\d+)")
-    )
-    #: Maximum configurable size of LRO aggregated packet
-    max_lro_packet_size: int = field(
-        metadata=TextParser.find_int(r"Maximum configurable size of LRO aggregated packet: (\d+)")
-    )
-
-    #: Current number of RX queues
-    rx_queues_num: int = field(metadata=TextParser.find_int(r"Current number of RX queues: (\d+)"))
-    #: Max possible RX queues
-    max_rx_queues_num: int = field(metadata=TextParser.find_int(r"Max possible RX queues: (\d+)"))
-    #: Max possible number of RXDs per queue
-    max_queue_rxd_num: int = field(
-        metadata=TextParser.find_int(r"Max possible number of RXDs per queue: (\d+)")
-    )
-    #: Min possible number of RXDs per queue
-    min_queue_rxd_num: int = field(
-        metadata=TextParser.find_int(r"Min possible number of RXDs per queue: (\d+)")
-    )
-    #: RXDs number alignment
-    rxd_alignment_num: int = field(metadata=TextParser.find_int(r"RXDs number alignment: (\d+)"))
-
-    #: Current number of TX queues
-    tx_queues_num: int = field(metadata=TextParser.find_int(r"Current number of TX queues: (\d+)"))
-    #: Max possible TX queues
-    max_tx_queues_num: int = field(metadata=TextParser.find_int(r"Max possible TX queues: (\d+)"))
-    #: Max possible number of TXDs per queue
-    max_queue_txd_num: int = field(
-        metadata=TextParser.find_int(r"Max possible number of TXDs per queue: (\d+)")
-    )
-    #: Min possible number of TXDs per queue
-    min_queue_txd_num: int = field(
-        metadata=TextParser.find_int(r"Min possible number of TXDs per queue: (\d+)")
-    )
-    #: TXDs number alignment
-    txd_alignment_num: int = field(metadata=TextParser.find_int(r"TXDs number alignment: (\d+)"))
-    #: Max segment number per packet
-    max_packet_segment_num: int = field(
-        metadata=TextParser.find_int(r"Max segment number per packet: (\d+)")
-    )
-    #: Max segment number per MTU/TSO
-    max_mtu_segment_num: int = field(
-        metadata=TextParser.find_int(r"Max segment number per MTU\/TSO: (\d+)")
-    )
-
-    #:
-    device_capabilities: DeviceCapabilitiesFlag = field(
-        metadata=DeviceCapabilitiesFlag.make_parser(),
-    )
-    #:
-    device_error_handling_mode: DeviceErrorHandlingMode | None = field(
-        default=None, metadata=DeviceErrorHandlingMode.make_parser()
-    )
-    #:
-    device_private_info: str | None = field(
-        default=None,
-        metadata=make_device_private_info_parser(),
-    )
-
-    #:
-    hash_key_size: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Hash key size in bytes: (\d+)")
-    )
-    #:
-    redirection_table_size: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Redirection table size: (\d+)")
-    )
-    #:
-    supported_rss_offload_flow_types: RSSOffloadTypesFlag = field(
-        default=RSSOffloadTypesFlag(0), metadata=RSSOffloadTypesFlag.make_parser()
-    )
-
-    #:
-    mac_address: str | None = field(
-        default=None, metadata=TextParser.find(r"MAC address: ([A-Fa-f0-9:]+)")
-    )
-    #:
-    fw_version: str | None = field(
-        default=None, metadata=TextParser.find(r"Firmware-version: ([^\r\n]+)")
-    )
-    #:
-    dev_args: str | None = field(default=None, metadata=TextParser.find(r"Devargs: ([^\r\n]+)"))
-    #: Socket id of the memory allocation
-    mem_alloc_socket_id: int | None = field(
-        default=None,
-        metadata=TextParser.find_int(r"memory allocation on the socket: (\d+)"),
-    )
-    #:
-    mtu: int | None = field(default=None, metadata=TextParser.find_int(r"MTU: (\d+)"))
-
-    #:
-    vlan_offload: VLANOffloadFlag | None = field(
-        default=None,
-        metadata=VLANOffloadFlag.make_parser(),
-    )
-
-    #: Maximum size of RX buffer
-    max_rx_bufsize: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Maximum size of RX buffer: (\d+)")
-    )
-    #: Maximum number of VFs
-    max_vfs_num: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Maximum number of VFs: (\d+)")
-    )
-    #: Maximum number of VMDq pools
-    max_vmdq_pools_num: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Maximum number of VMDq pools: (\d+)")
-    )
-
-    #:
-    switch_name: str | None = field(
-        default=None, metadata=TextParser.find(r"Switch name: ([\r\n]+)")
-    )
-    #:
-    switch_domain_id: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Switch domain Id: (\d+)")
-    )
-    #:
-    switch_port_id: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Switch Port Id: (\d+)")
-    )
-    #:
-    switch_rx_domain: int | None = field(
-        default=None, metadata=TextParser.find_int(r"Switch Rx domain: (\d+)")
-    )
-
-
-@dataclass
-class TestPmdPortStats(TextParser):
-    """Port statistics."""
-
-    #:
-    port_id: int = field(metadata=TextParser.find_int(r"NIC statistics for port (\d+)"))
-
-    #:
-    rx_packets: int = field(metadata=TextParser.find_int(r"RX-packets:\s+(\d+)"))
-    #:
-    rx_missed: int = field(metadata=TextParser.find_int(r"RX-missed:\s+(\d+)"))
-    #:
-    rx_bytes: int = field(metadata=TextParser.find_int(r"RX-bytes:\s+(\d+)"))
-    #:
-    rx_errors: int = field(metadata=TextParser.find_int(r"RX-errors:\s+(\d+)"))
-    #:
-    rx_nombuf: int = field(metadata=TextParser.find_int(r"RX-nombuf:\s+(\d+)"))
-
-    #:
-    tx_packets: int = field(metadata=TextParser.find_int(r"TX-packets:\s+(\d+)"))
-    #:
-    tx_errors: int = field(metadata=TextParser.find_int(r"TX-errors:\s+(\d+)"))
-    #:
-    tx_bytes: int = field(metadata=TextParser.find_int(r"TX-bytes:\s+(\d+)"))
-
-    #:
-    rx_pps: int = field(metadata=TextParser.find_int(r"Rx-pps:\s+(\d+)"))
-    #:
-    rx_bps: int = field(metadata=TextParser.find_int(r"Rx-bps:\s+(\d+)"))
-
-    #:
-    tx_pps: int = field(metadata=TextParser.find_int(r"Tx-pps:\s+(\d+)"))
-    #:
-    tx_bps: int = field(metadata=TextParser.find_int(r"Tx-bps:\s+(\d+)"))
-
-
-@dataclass(kw_only=True)
-class FlowRule:
-    """Class representation of flow rule parameters.
-
-    This class represents the parameters of any flow rule as per the
-    following pattern:
-
-    [group {group_id}] [priority {level}] [ingress] [egress]
-    [user_id {user_id}] pattern {item} [/ {item} [...]] / end
-    actions {action} [/ {action} [...]] / end
-    """
-
-    #:
-    group_id: int | None = None
-    #:
-    priority_level: int | None = None
-    #:
-    direction: Literal["ingress", "egress"]
-    #:
-    user_id: int | None = None
-    #:
-    pattern: list[str]
-    #:
-    actions: list[str]
-
-    def __str__(self) -> str:
-        """Returns the string representation of this instance."""
-        ret = ""
-        pattern = " / ".join(self.pattern)
-        action = " / ".join(self.actions)
-        if self.group_id is not None:
-            ret += f"group {self.group_id} "
-        if self.priority_level is not None:
-            ret += f"priority {self.priority_level} "
-        ret += f"{self.direction} "
-        if self.user_id is not None:
-            ret += f"user_id {self.user_id} "
-        ret += f"pattern {pattern} / end "
-        ret += f"actions {action} / end"
-        return ret
-
-
-class PacketOffloadFlag(Flag):
-    """Flag representing the Packet Offload Features Flags in DPDK.
-
-    Values in this class are taken from the definitions in the RTE MBUF core library in DPDK
-    located in ``lib/mbuf/rte_mbuf_core.h``. It is expected that flag values in this class will
-    match the values they are set to in said DPDK library with one exception; all values must be
-    unique. For example, the definitions for unknown checksum flags in ``rte_mbuf_core.h`` are all
-    set to :data:`0`, but it is valuable to distinguish between them in this framework. For this
-    reason flags that are not unique in the DPDK library are set either to values within the
-    RTE_MBUF_F_FIRST_FREE-RTE_MBUF_F_LAST_FREE range for Rx or shifted 61+ bits for Tx.
-
-    References:
-        DPDK lib: ``lib/mbuf/rte_mbuf_core.h``
-    """
-
-    # RX flags
-
-    #: The RX packet is a 802.1q VLAN packet, and the tci has been saved in mbuf->vlan_tci. If the
-    #: flag RTE_MBUF_F_RX_VLAN_STRIPPED is also present, the VLAN header has been stripped from
-    #: mbuf data, else it is still present.
-    RTE_MBUF_F_RX_VLAN = auto()
-
-    #: RX packet with RSS hash result.
-    RTE_MBUF_F_RX_RSS_HASH = auto()
-
-    #: RX packet with FDIR match indicate.
-    RTE_MBUF_F_RX_FDIR = auto()
-
-    #: This flag is set when the outermost IP header checksum is detected as wrong by the hardware.
-    RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD = 1 << 5
-
-    #: A vlan has been stripped by the hardware and its tci is saved in mbuf->vlan_tci. This can
-    #: only happen if vlan stripping is enabled in the RX configuration of the PMD. When
-    #: RTE_MBUF_F_RX_VLAN_STRIPPED is set, RTE_MBUF_F_RX_VLAN must also be set.
-    RTE_MBUF_F_RX_VLAN_STRIPPED = auto()
-
-    #: No information about the RX IP checksum. Value is 0 in the DPDK library.
-    RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN = 1 << 23
-    #: The IP checksum in the packet is wrong.
-    RTE_MBUF_F_RX_IP_CKSUM_BAD = 1 << 4
-    #: The IP checksum in the packet is valid.
-    RTE_MBUF_F_RX_IP_CKSUM_GOOD = 1 << 7
-    #: The IP checksum is not correct in the packet data, but the integrity of the IP header is
-    #: verified. Value is RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD in the DPDK
-    #: library.
-    RTE_MBUF_F_RX_IP_CKSUM_NONE = 1 << 24
-
-    #: No information about the RX L4 checksum. Value is 0 in the DPDK library.
-    RTE_MBUF_F_RX_L4_CKSUM_UNKNOWN = 1 << 25
-    #: The L4 checksum in the packet is wrong.
-    RTE_MBUF_F_RX_L4_CKSUM_BAD = 1 << 3
-    #: The L4 checksum in the packet is valid.
-    RTE_MBUF_F_RX_L4_CKSUM_GOOD = 1 << 8
-    #: The L4 checksum is not correct in the packet data, but the integrity of the L4 data is
-    #: verified. Value is RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD in the DPDK
-    #: library.
-    RTE_MBUF_F_RX_L4_CKSUM_NONE = 1 << 26
-
-    #: RX IEEE1588 L2 Ethernet PT Packet.
-    RTE_MBUF_F_RX_IEEE1588_PTP = 1 << 9
-    #: RX IEEE1588 L2/L4 timestamped packet.
-    RTE_MBUF_F_RX_IEEE1588_TMST = 1 << 10
-
-    #: FD id reported if FDIR match.
-    RTE_MBUF_F_RX_FDIR_ID = 1 << 13
-    #: Flexible bytes reported if FDIR match.
-    RTE_MBUF_F_RX_FDIR_FLX = 1 << 14
-
-    #: If both RTE_MBUF_F_RX_QINQ_STRIPPED and RTE_MBUF_F_RX_VLAN_STRIPPED are set, the 2 VLANs
-    #: have been stripped by the hardware. If RTE_MBUF_F_RX_QINQ_STRIPPED is set and
-    #: RTE_MBUF_F_RX_VLAN_STRIPPED is unset, only the outer VLAN is removed from packet data.
-    RTE_MBUF_F_RX_QINQ_STRIPPED = auto()
-
-    #: When packets are coalesced by a hardware or virtual driver, this flag can be set in the RX
-    #: mbuf, meaning that the m->tso_segsz field is valid and is set to the segment size of
-    #: original packets.
-    RTE_MBUF_F_RX_LRO = auto()
-
-    #: Indicate that security offload processing was applied on the RX packet.
-    RTE_MBUF_F_RX_SEC_OFFLOAD = 1 << 18
-    #: Indicate that security offload processing failed on the RX packet.
-    RTE_MBUF_F_RX_SEC_OFFLOAD_FAILED = auto()
-
-    #: The RX packet is a double VLAN. If this flag is set, RTE_MBUF_F_RX_VLAN must also be set. If
-    #: the flag RTE_MBUF_F_RX_QINQ_STRIPPED is also present, both VLANs headers have been stripped
-    #: from mbuf data, else they are still present.
-    RTE_MBUF_F_RX_QINQ = auto()
-
-    #: No info about the outer RX L4 checksum. Value is 0 in the DPDK library.
-    RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN = 1 << 27
-    #: The outer L4 checksum in the packet is wrong
-    RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD = 1 << 21
-    #: The outer L4 checksum in the packet is valid
-    RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD = 1 << 22
-    #: Invalid outer L4 checksum state. Value is
-    #: RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD | RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD in the DPDK library.
-    RTE_MBUF_F_RX_OUTER_L4_CKSUM_INVALID = 1 << 28
-
-    # TX flags
-
-    #: Outer UDP checksum offload flag. This flag is used for enabling outer UDP checksum in PMD.
-    #: To use outer UDP checksum, the user either needs to enable the following in mbuf:
-    #:
-    #:  a) Fill outer_l2_len and outer_l3_len in mbuf.
-    #:  b) Set the RTE_MBUF_F_TX_OUTER_UDP_CKSUM flag.
-    #:  c) Set the RTE_MBUF_F_TX_OUTER_IPV4 or RTE_MBUF_F_TX_OUTER_IPV6 flag.
-    #:
-    #: Or configure RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM offload flag.
-    RTE_MBUF_F_TX_OUTER_UDP_CKSUM = 1 << 41
-
-    #: UDP Fragmentation Offload flag. This flag is used for enabling UDP fragmentation in SW or in
-    #: HW.
-    RTE_MBUF_F_TX_UDP_SEG = auto()
-
-    #: Request security offload processing on the TX packet. To use Tx security offload, the user
-    #: needs to fill l2_len in mbuf indicating L2 header size and where L3 header starts.
-    #: Similarly, l3_len should also be filled along with ol_flags reflecting current L3 type.
-    RTE_MBUF_F_TX_SEC_OFFLOAD = auto()
-
-    #: Offload the MACsec. This flag must be set by the application to enable this offload feature
-    #: for a packet to be transmitted.
-    RTE_MBUF_F_TX_MACSEC = auto()
-
-    # Bits 45:48 are used for the tunnel type in ``lib/mbuf/rte_mbuf_core.h``, but some are modified
-    # in this Flag to maintain uniqueness. The tunnel type must be specified for TSO or checksum on
-    # the inner part of tunnel packets. These flags can be used with RTE_MBUF_F_TX_TCP_SEG for TSO,
-    # or RTE_MBUF_F_TX_xxx_CKSUM. The mbuf fields for inner and outer header lengths are required:
-    # outer_l2_len, outer_l3_len, l2_len, l3_len, l4_len and tso_segsz for TSO.
-
-    #:
-    RTE_MBUF_F_TX_TUNNEL_VXLAN = 1 << 45
-    #:
-    RTE_MBUF_F_TX_TUNNEL_GRE = 1 << 46
-    #: Value is 3 << 45 in the DPDK library.
-    RTE_MBUF_F_TX_TUNNEL_IPIP = 1 << 61
-    #:
-    RTE_MBUF_F_TX_TUNNEL_GENEVE = 1 << 47
-    #: TX packet with MPLS-in-UDP RFC 7510 header. Value is 5 << 45 in the DPDK library.
-    RTE_MBUF_F_TX_TUNNEL_MPLSINUDP = 1 << 62
-    #: Value is 6 << 45 in the DPDK library.
-    RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE = 1 << 63
-    #: Value is 7 << 45 in the DPDK library.
-    RTE_MBUF_F_TX_TUNNEL_GTP = 1 << 64
-    #:
-    RTE_MBUF_F_TX_TUNNEL_ESP = 1 << 48
-    #: Generic IP encapsulated tunnel type, used for TSO and checksum offload. This can be used for
-    #: tunnels which are not standards or listed above. It is preferred to use specific tunnel
-    #: flags like RTE_MBUF_F_TX_TUNNEL_GRE or RTE_MBUF_F_TX_TUNNEL_IPIP if possible. The ethdev
-    #: must be configured with RTE_ETH_TX_OFFLOAD_IP_TNL_TSO.  Outer and inner checksums are done
-    #: according to the existing flags like RTE_MBUF_F_TX_xxx_CKSUM. Specific tunnel headers that
-    #: contain payload length, sequence id or checksum are not expected to be updated. Value is
-    #: 0xD << 45 in the DPDK library.
-    RTE_MBUF_F_TX_TUNNEL_IP = 1 << 65
-    #: Generic UDP encapsulated tunnel type, used for TSO and checksum offload. UDP tunnel type
-    #: implies outer IP layer. It can be used for tunnels which are not standards or listed above.
-    #: It is preferred to use specific tunnel flags like RTE_MBUF_F_TX_TUNNEL_VXLAN if possible.
-    #: The ethdev must be configured with RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO. Outer and inner checksums
-    #: are done according to the existing flags like RTE_MBUF_F_TX_xxx_CKSUM. Specific tunnel
-    #: headers that contain payload length, sequence id or checksum are not expected to be updated.
-    #: value is 0xE << 45 in the DPDK library.
-    RTE_MBUF_F_TX_TUNNEL_UDP = 1 << 66
-
-    #: Double VLAN insertion (QinQ) request to driver, driver may offload the insertion based on
-    #: device capability. Mbuf 'vlan_tci' & 'vlan_tci_outer' must be valid when this flag is set.
-    RTE_MBUF_F_TX_QINQ = 1 << 49
-
-    #: TCP segmentation offload. To enable this offload feature for a packet to be transmitted on
-    #: hardware supporting TSO:
-    #:
-    #:  - set the RTE_MBUF_F_TX_TCP_SEG flag in mbuf->ol_flags (this flag implies
-    #:      RTE_MBUF_F_TX_TCP_CKSUM)
-    #:  - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
-    #:      * if it's IPv4, set the RTE_MBUF_F_TX_IP_CKSUM flag
-    #:  - fill the mbuf offload information: l2_len, l3_len, l4_len, tso_segsz
-    RTE_MBUF_F_TX_TCP_SEG = auto()
-
-    #: TX IEEE1588 packet to timestamp.
-    RTE_MBUF_F_TX_IEEE1588_TMST = auto()
-
-    # Bits 52+53 used for L4 packet type with checksum enabled in ``lib/mbuf/rte_mbuf_core.h`` but
-    # some values must be modified in this framework to maintain uniqueness. To use hardware
-    # L4 checksum offload, the user needs to:
-    #
-    # - fill l2_len and l3_len in mbuf
-    # - set the flags RTE_MBUF_F_TX_TCP_CKSUM, RTE_MBUF_F_TX_SCTP_CKSUM or
-    #   RTE_MBUF_F_TX_UDP_CKSUM
-    # - set the flag RTE_MBUF_F_TX_IPV4 or RTE_MBUF_F_TX_IPV6
-
-    #: Disable L4 cksum of TX pkt. Value is 0 in the DPDK library.
-    RTE_MBUF_F_TX_L4_NO_CKSUM = 1 << 67
-    #: TCP cksum of TX pkt. Computed by NIC.
-    RTE_MBUF_F_TX_TCP_CKSUM = 1 << 52
-    #: SCTP cksum of TX pkt. Computed by NIC.
-    RTE_MBUF_F_TX_SCTP_CKSUM = 1 << 53
-    #: UDP cksum of TX pkt. Computed by NIC. Value is 3 << 52 in the DPDK library.
-    RTE_MBUF_F_TX_UDP_CKSUM = 1 << 68
-
-    #: Offload the IP checksum in the hardware. The flag RTE_MBUF_F_TX_IPV4 should also be set by
-    #: the application, although a PMD will only check RTE_MBUF_F_TX_IP_CKSUM.
-    RTE_MBUF_F_TX_IP_CKSUM = 1 << 54
-
-    #: Packet is IPv4. This flag must be set when using any offload feature (TSO, L3 or L4
-    #: checksum) to tell the NIC that the packet is an IPv4 packet. If the packet is a tunneled
-    #: packet, this flag is related to the inner headers.
-    RTE_MBUF_F_TX_IPV4 = auto()
-    #: Packet is IPv6. This flag must be set when using an offload feature (TSO or L4 checksum) to
-    #: tell the NIC that the packet is an IPv6 packet. If the packet is a tunneled packet, this
-    #: flag is related to the inner headers.
-    RTE_MBUF_F_TX_IPV6 = auto()
-    #: VLAN tag insertion request to driver, driver may offload the insertion based on the device
-    #: capability. mbuf 'vlan_tci' field must be valid when this flag is set.
-    RTE_MBUF_F_TX_VLAN = auto()
-
-    #: Offload the IP checksum of an external header in the hardware. The flag
-    #: RTE_MBUF_F_TX_OUTER_IPV4 should also be set by the application, although a PMD will only
-    #: check RTE_MBUF_F_TX_OUTER_IP_CKSUM.
-    RTE_MBUF_F_TX_OUTER_IP_CKSUM = auto()
-    #: Packet outer header is IPv4. This flag must be set when using any outer offload feature (L3
-    #: or L4 checksum) to tell the NIC that the outer header of the tunneled packet is an IPv4
-    #: packet.
-    RTE_MBUF_F_TX_OUTER_IPV4 = auto()
-    #: Packet outer header is IPv6. This flag must be set when using any outer offload feature (L4
-    #: checksum) to tell the NIC that the outer header of the tunneled packet is an IPv6 packet.
-    RTE_MBUF_F_TX_OUTER_IPV6 = auto()
-
-    @classmethod
-    def from_list_string(cls, names: str) -> Self:
-        """Makes a flag from a whitespace-separated list of names.
-
-        Args:
-            names: a whitespace-separated list containing the members of this flag.
-
-        Returns:
-            An instance of this flag.
-        """
-        flag = cls(0)
-        for name in names.split():
-            flag |= cls.from_str(name)
-        return flag
-
-    @classmethod
-    def from_str(cls, name: str) -> Self:
-        """Makes a flag matching the supplied name.
-
-        Args:
-            name: a valid member of this flag in text
-        Returns:
-            An instance of this flag.
-        """
-        member_name = name.strip().replace("-", "_")
-        return cls[member_name]
-
-    @classmethod
-    def make_parser(cls) -> ParserFn:
-        """Makes a parser function.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        return TextParser.wrap(
-            TextParser.find(r"ol_flags: ([^\n]+)"),
-            cls.from_list_string,
-        )
-
-
-class RtePTypes(Flag):
-    """Flag representing possible packet types in DPDK verbose output.
-
-    Values in this class are derived from definitions in the RTE MBUF ptype library in DPDK located
-    in ``lib/mbuf/rte_mbuf_ptype.h``. Specifically, the names of values in this class should match
-    the possible return options from the functions ``rte_get_ptype_*_name`` in ``rte_mbuf_ptype.c``.
-
-    References:
-        DPDK lib: ``lib/mbuf/rte_mbuf_ptype.h``
-        DPDK ptype name formatting functions: ``lib/mbuf/rte_mbuf_ptype.c:rte_get_ptype_*_name()``
-    """
-
-    # L2
-    #: Ethernet packet type. This is used for outer packet for tunneling cases.
-    L2_ETHER = auto()
-    #: Ethernet packet type for time sync.
-    L2_ETHER_TIMESYNC = auto()
-    #: ARP (Address Resolution Protocol) packet type.
-    L2_ETHER_ARP = auto()
-    #: LLDP (Link Layer Discovery Protocol) packet type.
-    L2_ETHER_LLDP = auto()
-    #: NSH (Network Service Header) packet type.
-    L2_ETHER_NSH = auto()
-    #: VLAN packet type.
-    L2_ETHER_VLAN = auto()
-    #: QinQ packet type.
-    L2_ETHER_QINQ = auto()
-    #: PPPOE packet type.
-    L2_ETHER_PPPOE = auto()
-    #: FCoE packet type..
-    L2_ETHER_FCOE = auto()
-    #: MPLS packet type.
-    L2_ETHER_MPLS = auto()
-    #: No L2 packet information.
-    L2_UNKNOWN = auto()
-
-    # L3
-    #: IP (Internet Protocol) version 4 packet type. This is used for outer packet for tunneling
-    #: cases, and does not contain any header option.
-    L3_IPV4 = auto()
-    #: IP (Internet Protocol) version 4 packet type. This is used for outer packet for tunneling
-    #: cases, and contains header options.
-    L3_IPV4_EXT = auto()
-    #: IP (Internet Protocol) version 6 packet type. This is used for outer packet for tunneling
-    #: cases, and does not contain any extension header.
-    L3_IPV6 = auto()
-    #: IP (Internet Protocol) version 4 packet type. This is used for outer packet for tunneling
-    #: cases, and may or maynot contain header options.
-    L3_IPV4_EXT_UNKNOWN = auto()
-    #: IP (Internet Protocol) version 6 packet type. This is used for outer packet for tunneling
-    #: cases, and contains extension headers.
-    L3_IPV6_EXT = auto()
-    #: IP (Internet Protocol) version 6 packet type. This is used for outer packet for tunneling
-    #: cases, and may or maynot contain extension headers.
-    L3_IPV6_EXT_UNKNOWN = auto()
-    #: No L3 packet information.
-    L3_UNKNOWN = auto()
-
-    # L4
-    #: TCP (Transmission Control Protocol) packet type. This is used for outer packet for tunneling
-    #: cases.
-    L4_TCP = auto()
-    #: UDP (User Datagram Protocol) packet type. This is used for outer packet for tunneling cases.
-    L4_UDP = auto()
-    #: Fragmented IP (Internet Protocol) packet type. This is used for outer packet for tunneling
-    #: cases and refers to those packets of any IP types which can be recognized as fragmented. A
-    #: fragmented packet cannot be recognized as any other L4 types (RTE_PTYPE_L4_TCP,
-    #: RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP, RTE_PTYPE_L4_NONFRAG).
-    L4_FRAG = auto()
-    #: SCTP (Stream Control Transmission Protocol) packet type. This is used for outer packet for
-    #: tunneling cases.
-    L4_SCTP = auto()
-    #: ICMP (Internet Control Message Protocol) packet type. This is used for outer packet for
-    #: tunneling cases.
-    L4_ICMP = auto()
-    #: Non-fragmented IP (Internet Protocol) packet type. This is used for outer packet for
-    #: tunneling cases and refers to those packets of any IP types, that cannot be recognized as
-    #: any of the above L4 types (RTE_PTYPE_L4_TCP, RTE_PTYPE_L4_UDP, RTE_PTYPE_L4_FRAG,
-    #: RTE_PTYPE_L4_SCTP, RTE_PTYPE_L4_ICMP).
-    L4_NONFRAG = auto()
-    #: IGMP (Internet Group Management Protocol) packet type.
-    L4_IGMP = auto()
-    #: No L4 packet information.
-    L4_UNKNOWN = auto()
-
-    # Tunnel
-    #: IP (Internet Protocol) in IP (Internet Protocol) tunneling packet type.
-    TUNNEL_IP = auto()
-    #: GRE (Generic Routing Encapsulation) tunneling packet type.
-    TUNNEL_GRE = auto()
-    #: VXLAN (Virtual eXtensible Local Area Network) tunneling packet type.
-    TUNNEL_VXLAN = auto()
-    #: NVGRE (Network Virtualization using Generic Routing Encapsulation) tunneling packet type.
-    TUNNEL_NVGRE = auto()
-    #: GENEVE (Generic Network Virtualization Encapsulation) tunneling packet type.
-    TUNNEL_GENEVE = auto()
-    #: Tunneling packet type of Teredo, VXLAN (Virtual eXtensible Local Area Network) or GRE
-    #: (Generic Routing Encapsulation) could be recognized as this packet type, if they can not be
-    #: recognized independently as of hardware capability.
-    TUNNEL_GRENAT = auto()
-    #: GTP-C (GPRS Tunnelling Protocol) control tunneling packet type.
-    TUNNEL_GTPC = auto()
-    #: GTP-U (GPRS Tunnelling Protocol) user data tunneling packet type.
-    TUNNEL_GTPU = auto()
-    #: ESP (IP Encapsulating Security Payload) tunneling packet type.
-    TUNNEL_ESP = auto()
-    #: L2TP (Layer 2 Tunneling Protocol) tunneling packet type.
-    TUNNEL_L2TP = auto()
-    #: VXLAN-GPE (VXLAN Generic Protocol Extension) tunneling packet type.
-    TUNNEL_VXLAN_GPE = auto()
-    #: MPLS-in-UDP tunneling packet type (RFC 7510).
-    TUNNEL_MPLS_IN_UDP = auto()
-    #: MPLS-in-GRE tunneling packet type (RFC 4023).
-    TUNNEL_MPLS_IN_GRE = auto()
-    #: No tunnel information found on the packet.
-    TUNNEL_UNKNOWN = auto()
-
-    # Inner L2
-    #: Ethernet packet type. This is used for inner packet type only.
-    INNER_L2_ETHER = auto()
-    #: Ethernet packet type with VLAN (Virtual Local Area Network) tag.
-    INNER_L2_ETHER_VLAN = auto()
-    #: QinQ packet type.
-    INNER_L2_ETHER_QINQ = auto()
-    #: No inner L2 information found on the packet.
-    INNER_L2_UNKNOWN = auto()
-
-    # Inner L3
-    #: IP (Internet Protocol) version 4 packet type. This is used for inner packet only, and does
-    #: not contain any header option.
-    INNER_L3_IPV4 = auto()
-    #: IP (Internet Protocol) version 4 packet type. This is used for inner packet only, and
-    #: contains header options.
-    INNER_L3_IPV4_EXT = auto()
-    #: IP (Internet Protocol) version 6 packet type. This is used for inner packet only, and does
-    #: not contain any extension header.
-    INNER_L3_IPV6 = auto()
-    #: IP (Internet Protocol) version 4 packet type. This is used for inner packet only, and may or
-    #: may not contain header options.
-    INNER_L3_IPV4_EXT_UNKNOWN = auto()
-    #: IP (Internet Protocol) version 6 packet type. This is used for inner packet only, and
-    #: contains extension headers.
-    INNER_L3_IPV6_EXT = auto()
-    #: IP (Internet Protocol) version 6 packet type. This is used for inner packet only, and may or
-    #: may not contain extension headers.
-    INNER_L3_IPV6_EXT_UNKNOWN = auto()
-    #: No inner L3 information found on the packet.
-    INNER_L3_UNKNOWN = auto()
-
-    # Inner L4
-    #: TCP (Transmission Control Protocol) packet type. This is used for inner packet only.
-    INNER_L4_TCP = auto()
-    #: UDP (User Datagram Protocol) packet type. This is used for inner packet only.
-    INNER_L4_UDP = auto()
-    #: Fragmented IP (Internet Protocol) packet type. This is used for inner packet only, and may
-    #: or maynot have a layer 4 packet.
-    INNER_L4_FRAG = auto()
-    #: SCTP (Stream Control Transmission Protocol) packet type. This is used for inner packet only.
-    INNER_L4_SCTP = auto()
-    #: ICMP (Internet Control Message Protocol) packet type. This is used for inner packet only.
-    INNER_L4_ICMP = auto()
-    #: Non-fragmented IP (Internet Protocol) packet type. It is used for inner packet only, and may
-    #: or may not have other unknown layer 4 packet types.
-    INNER_L4_NONFRAG = auto()
-    #: No inner L4 information found on the packet.
-    INNER_L4_UNKNOWN = auto()
-
-    @classmethod
-    def from_list_string(cls, names: str) -> Self:
-        """Makes a flag from a whitespace-separated list of names.
-
-        Args:
-            names: a whitespace-separated list containing the members of this flag.
-
-        Returns:
-            An instance of this flag.
-        """
-        flag = cls(0)
-        for name in names.split():
-            flag |= cls.from_str(name)
-        return flag
-
-    @classmethod
-    def from_str(cls, name: str) -> Self:
-        """Makes a flag matching the supplied name.
-
-        Args:
-            name: a valid member of this flag in text
-        Returns:
-            An instance of this flag.
-        """
-        member_name = name.strip().replace("-", "_")
-        return cls[member_name]
-
-    @classmethod
-    def make_parser(cls, hw: bool) -> ParserFn:
-        """Makes a parser function.
-
-        Args:
-            hw: Whether to make a parser for hardware ptypes or software ptypes. If :data:`True`,
-                hardware ptypes will be collected, otherwise software pytpes will.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        return TextParser.wrap(
-            TextParser.find(f"{'hw' if hw else 'sw'} ptype: ([^-]+)"),
-            cls.from_list_string,
-        )
-
-
-@dataclass
-class TestPmdVerbosePacket(TextParser):
-    """Packet information provided by verbose output in Testpmd.
-
-    This dataclass expects that packet information be prepended with the starting line of packet
-    bursts. Specifically, the line that reads "port X/queue Y: sent/received Z packets".
-    """
-
-    #: ID of the port that handled the packet.
-    port_id: int = field(metadata=TextParser.find_int(r"port (\d+)/queue \d+"))
-    #: ID of the queue that handled the packet.
-    queue_id: int = field(metadata=TextParser.find_int(r"port \d+/queue (\d+)"))
-    #: Whether the packet was received or sent by the queue/port.
-    was_received: bool = field(metadata=TextParser.find(r"received \d+ packets"))
-    #:
-    src_mac: str = field(metadata=TextParser.find(f"src=({REGEX_FOR_MAC_ADDRESS})"))
-    #:
-    dst_mac: str = field(metadata=TextParser.find(f"dst=({REGEX_FOR_MAC_ADDRESS})"))
-    #: Memory pool the packet was handled on.
-    pool: str = field(metadata=TextParser.find(r"pool=(\S+)"))
-    #: Packet type in hex.
-    p_type: int = field(metadata=TextParser.find_int(r"type=(0x[a-fA-F\d]+)"))
-    #:
-    length: int = field(metadata=TextParser.find_int(r"length=(\d+)"))
-    #: Number of segments in the packet.
-    nb_segs: int = field(metadata=TextParser.find_int(r"nb_segs=(\d+)"))
-    #: Hardware packet type.
-    hw_ptype: RtePTypes = field(metadata=RtePTypes.make_parser(hw=True))
-    #: Software packet type.
-    sw_ptype: RtePTypes = field(metadata=RtePTypes.make_parser(hw=False))
-    #:
-    l2_len: int = field(metadata=TextParser.find_int(r"l2_len=(\d+)"))
-    #:
-    ol_flags: PacketOffloadFlag = field(metadata=PacketOffloadFlag.make_parser())
-    #: RSS hash of the packet in hex.
-    rss_hash: int | None = field(
-        default=None, metadata=TextParser.find_int(r"RSS hash=(0x[a-fA-F\d]+)")
-    )
-    #: RSS queue that handled the packet in hex.
-    rss_queue: int | None = field(
-        default=None, metadata=TextParser.find_int(r"RSS queue=(0x[a-fA-F\d]+)")
-    )
-    #:
-    l3_len: int | None = field(default=None, metadata=TextParser.find_int(r"l3_len=(\d+)"))
-    #:
-    l4_len: int | None = field(default=None, metadata=TextParser.find_int(r"l4_len=(\d+)"))
-    #:
-    l4_dport: int | None = field(
-        default=None,
-        metadata=TextParser.find_int(r"Destination (?:TCP|UDP) port=(\d+)"),
-    )
-
-
-class RxOffloadCapability(Flag):
-    """Rx offload capabilities of a device.
-
-    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
-    They're prefixed with ``RTE_ETH_RX_OFFLOAD`` in ``lib/ethdev/rte_ethdev.h``
-    instead of ``RX_OFFLOAD``, which is what testpmd changes the prefix to.
-    The values are not contiguous, so the correspondence is preserved
-    by specifying concrete values interspersed between auto() values.
-
-    The ``RX_OFFLOAD`` prefix has been preserved so that the same flag names can be used
-    in :class:`NicCapability`. The prefix is needed in :class:`NicCapability` since there's
-    no other qualifier which would sufficiently distinguish it from other capabilities.
-
-    References:
-        DPDK lib: ``lib/ethdev/rte_ethdev.h``
-        testpmd display function: ``app/test-pmd/cmdline.c:print_rx_offloads()``
-    """
-
-    #:
-    RX_OFFLOAD_VLAN_STRIP = auto()
-    #: Device supports L3 checksum offload.
-    RX_OFFLOAD_IPV4_CKSUM = auto()
-    #: Device supports L4 checksum offload.
-    RX_OFFLOAD_UDP_CKSUM = auto()
-    #: Device supports L4 checksum offload.
-    RX_OFFLOAD_TCP_CKSUM = auto()
-    #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO = auto()
-    #: Device supports QinQ (queue in queue) offload.
-    RX_OFFLOAD_QINQ_STRIP = auto()
-    #: Device supports inner packet L3 checksum.
-    RX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
-    #: Device supports MACsec.
-    RX_OFFLOAD_MACSEC_STRIP = auto()
-    #: Device supports filtering of a VLAN Tag identifier.
-    RX_OFFLOAD_VLAN_FILTER = 1 << 9
-    #: Device supports VLAN offload.
-    RX_OFFLOAD_VLAN_EXTEND = auto()
-    #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER = 1 << 13
-    #: Device supports Timestamp.
-    RX_OFFLOAD_TIMESTAMP = auto()
-    #: Device supports crypto processing while packet is received in NIC.
-    RX_OFFLOAD_SECURITY = auto()
-    #: Device supports CRC stripping.
-    RX_OFFLOAD_KEEP_CRC = auto()
-    #: Device supports L4 checksum offload.
-    RX_OFFLOAD_SCTP_CKSUM = auto()
-    #: Device supports inner packet L4 checksum.
-    RX_OFFLOAD_OUTER_UDP_CKSUM = auto()
-    #: Device supports RSS hashing.
-    RX_OFFLOAD_RSS_HASH = auto()
-    #: Device supports
-    RX_OFFLOAD_BUFFER_SPLIT = auto()
-    #: Device supports all checksum capabilities.
-    RX_OFFLOAD_CHECKSUM = RX_OFFLOAD_IPV4_CKSUM | RX_OFFLOAD_UDP_CKSUM | RX_OFFLOAD_TCP_CKSUM
-    #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN = (
-        RX_OFFLOAD_VLAN_STRIP
-        | RX_OFFLOAD_VLAN_FILTER
-        | RX_OFFLOAD_VLAN_EXTEND
-        | RX_OFFLOAD_QINQ_STRIP
-    )
-
-    @classmethod
-    def from_string(cls, line: str) -> Self:
-        """Make an instance from a string containing the flag names separated with a space.
-
-        Args:
-            line: The line to parse.
-
-        Returns:
-            A new instance containing all found flags.
-        """
-        flag = cls(0)
-        for flag_name in line.split():
-            flag |= cls[f"RX_OFFLOAD_{flag_name}"]
-        return flag
-
-    @classmethod
-    def make_parser(cls, per_port: bool) -> ParserFn:
-        """Make a parser function.
-
-        Args:
-            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
-                will return capabilities per queue.
-
-        Returns:
-            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
-                parser function that makes an instance of this flag from text.
-        """
-        granularity = "Port" if per_port else "Queue"
-        return TextParser.wrap(
-            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
-            cls.from_string,
-        )
-
-
-@dataclass
-class RxOffloadCapabilities(TextParser):
-    """The result of testpmd's ``show port <port_id> rx_offload capabilities`` command.
-
-    References:
-        testpmd command function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
-        testpmd display function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
-    """
-
-    #:
-    port_id: int = field(
-        metadata=TextParser.find_int(r"Rx Offloading Capabilities of port (\d+) :")
-    )
-    #: Per-queue Rx offload capabilities.
-    per_queue: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(False))
-    #: Capabilities other than per-queue Rx offload capabilities.
-    per_port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
-
-
-@dataclass
-class TestPmdPortFlowCtrl(TextParser):
-    """Class representing a port's flow control parameters.
-
-    The parameters can also be parsed from the output of ``show port <port_id> flow_ctrl``.
-    """
-
-    #: Enable Reactive Extensions.
-    rx: bool = field(default=False, metadata=TextParser.find(r"Rx pause: on"))
-    #: Enable Transmit.
-    tx: bool = field(default=False, metadata=TextParser.find(r"Tx pause: on"))
-    #: High threshold value to trigger XOFF.
-    high_water: int = field(
-        default=0, metadata=TextParser.find_int(r"High waterline: (0x[a-fA-F\d]+)")
-    )
-    #: Low threshold value to trigger XON.
-    low_water: int = field(
-        default=0, metadata=TextParser.find_int(r"Low waterline: (0x[a-fA-F\d]+)")
-    )
-    #: Pause quota in the Pause frame.
-    pause_time: int = field(default=0, metadata=TextParser.find_int(r"Pause time: (0x[a-fA-F\d]+)"))
-    #: Send XON frame.
-    send_xon: bool = field(default=False, metadata=TextParser.find(r"Tx pause: on"))
-    #: Enable receiving MAC control frames.
-    mac_ctrl_frame_fwd: bool = field(default=False, metadata=TextParser.find(r"Tx pause: on"))
-    #: Change the auto-negotiation parameter.
-    autoneg: bool = field(default=False, metadata=TextParser.find(r"Autoneg: on"))
-
-    def __str__(self) -> str:
-        """Returns the string representation of this instance."""
-        ret = (
-            f"rx {'on' if self.rx else 'off'} "
-            f"tx {'on' if self.tx else 'off'} "
-            f"{self.high_water} "
-            f"{self.low_water} "
-            f"{self.pause_time} "
-            f"{1 if self.send_xon else 0} "
-            f"mac_ctrl_frame_fwd {'on' if self.mac_ctrl_frame_fwd else 'off'} "
-            f"autoneg {'on' if self.autoneg else 'off'}"
-        )
-        return ret
-
-
-def requires_stopped_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
-    """Decorator for :class:`TestPmdShell` commands methods that require stopped ports.
-
-    If the decorated method is called while the ports are started, then these are stopped before
-    continuing.
-
-    Args:
-        func: The :class:`TestPmdShell` method to decorate.
-    """
-
-    @functools.wraps(func)
-    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
-        if self.ports_started:
-            self._logger.debug("Ports need to be stopped to continue.")
-            self.stop_all_ports()
-
-        return func(self, *args, **kwargs)
-
-    return _wrapper
-
-
-def requires_started_ports(func: TestPmdShellMethod) -> TestPmdShellMethod:
-    """Decorator for :class:`TestPmdShell` commands methods that require started ports.
-
-    If the decorated method is called while the ports are stopped, then these are started before
-    continuing.
-
-    Args:
-        func: The :class:`TestPmdShell` method to decorate.
-    """
-
-    @functools.wraps(func)
-    def _wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
-        if not self.ports_started:
-            self._logger.debug("Ports need to be started to continue.")
-            self.start_all_ports()
-
-        return func(self, *args, **kwargs)
-
-    return _wrapper
-
-
-def add_remove_mtu(mtu: int = 1500) -> Callable[[TestPmdShellMethod], TestPmdShellMethod]:
-    """Configure MTU to `mtu` on all ports, run the decorated function, then revert.
-
-    Args:
-        mtu: The MTU to configure all ports on.
-
-    Returns:
-        The method decorated with setting and reverting MTU.
-    """
-
-    def decorator(func: TestPmdShellMethod) -> TestPmdShellMethod:
-        @functools.wraps(func)
-        def wrapper(self: "TestPmdShell", *args: P.args, **kwargs: P.kwargs) -> Any:
-            original_mtu = self.ports[0].mtu
-            self.set_port_mtu_all(mtu=mtu, verify=False)
-            retval = func(self, *args, **kwargs)
-            self.set_port_mtu_all(original_mtu if original_mtu else 1500, verify=False)
-            return retval
-
-        return wrapper
-
-    return decorator
-
-
-class TestPmdShell(DPDKShell):
-    """Testpmd interactive shell.
-
-    The testpmd shell users should never use
-    the :meth:`~.interactive_shell.InteractiveShell.send_command` method directly, but rather
-    call specialized methods. If there isn't one that satisfies a need, it should be added.
-
-    Attributes:
-        ports_started: Indicates whether the ports are started.
-    """
-
-    _app_params: TestPmdParams
-    _ports: list[TestPmdPort] | None
-
-    #: The testpmd's prompt.
-    _default_prompt: ClassVar[str] = "testpmd>"
-
-    #: This forces the prompt to appear after sending a command.
-    _command_extra_chars: ClassVar[str] = "\n"
-
-    ports_started: bool
-
-    def __init__(
-        self,
-        name: str | None = None,
-        privileged: bool = True,
-        **app_params: Unpack[TestPmdParamsDict],
-    ) -> None:
-        """Overrides :meth:`~.dpdk_shell.DPDKShell.__init__`. Changes app_params to kwargs."""
-        if "port_topology" not in app_params and get_ctx().topology.type is TopologyType.one_link:
-            app_params["port_topology"] = PortTopology.loop
-        super().__init__(name, privileged, app_params=TestPmdParams(**app_params))
-        self.ports_started = not self._app_params.disable_device_start
-        self._ports = None
-
-    @property
-    def path(self) -> PurePath:
-        """The path to the testpmd executable."""
-        return PurePath("app/dpdk-testpmd")
-
-    @property
-    def ports(self) -> list[TestPmdPort]:
-        """The ports of the instance.
-
-        This caches the ports returned by :meth:`show_port_info_all`.
-        To force an update of port information, execute :meth:`show_port_info_all` or
-        :meth:`show_port_info`.
-
-        Returns: The list of known testpmd ports.
-        """
-        if self._ports is None:
-            return self.show_port_info_all()
-        return self._ports
-
-    @requires_started_ports
-    def start(self, verify: bool = True) -> None:
-        """Start packet forwarding with the current configuration.
-
-        Args:
-            verify: If :data:`True` , a second start command will be sent in an attempt to verify
-                packet forwarding started as expected.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and forwarding fails to
-                start or ports fail to come up.
-        """
-        self.send_command("start")
-        if verify:
-            # If forwarding was already started, sending "start" again should tell us
-            start_cmd_output = self.send_command("start")
-            if "Packet forwarding already started" not in start_cmd_output:
-                self._logger.debug(f"Failed to start packet forwarding: \n{start_cmd_output}")
-                raise InteractiveCommandExecutionError("Testpmd failed to start packet forwarding.")
-
-    def stop(self, verify: bool = True) -> str:
-        """Stop packet forwarding.
-
-        Args:
-            verify: If :data:`True` , the output of the stop command is scanned to verify that
-                forwarding was stopped successfully or not started. If neither is found, it is
-                considered an error.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command to stop
-                forwarding results in an error.
-
-        Returns:
-            Output gathered from the stop command and all other preceding logs in the buffer. This
-            output is most often used to view forwarding statistics that are displayed when this
-            command is sent as well as any verbose packet information that hasn't been consumed
-            prior to calling this method.
-        """
-        stop_cmd_output = self.send_command("stop")
-        if verify:
-            if (
-                "Done." not in stop_cmd_output
-                and "Packet forwarding not started" not in stop_cmd_output
-            ):
-                self._logger.debug(f"Failed to stop packet forwarding: \n{stop_cmd_output}")
-                raise InteractiveCommandExecutionError("Testpmd failed to stop packet forwarding.")
-        return stop_cmd_output
-
-    def get_devices(self) -> list[TestPmdDevice]:
-        """Get a list of device names that are known to testpmd.
-
-        Uses the device info listed in testpmd and then parses the output.
-
-        Returns:
-            A list of devices.
-        """
-        dev_info: str = self.send_command("show device info all")
-        dev_list: list[TestPmdDevice] = []
-        for line in dev_info.split("\n"):
-            if "device name:" in line.lower():
-                dev_list.append(TestPmdDevice(line))
-        return dev_list
-
-    def wait_link_status_up(self, port_id: int, timeout=SETTINGS.timeout) -> bool:
-        """Wait until the link status on the given port is "up".
-
-        Arguments:
-            port_id: Port to check the link status on.
-            timeout: Time to wait for the link to come up. The default value for this
-                argument may be modified using the :option:`--timeout` command-line argument
-                or the :envvar:`DTS_TIMEOUT` environment variable.
-
-        Returns:
-            Whether the link came up in time or not.
-        """
-        time_to_stop = time.time() + timeout
-        port_info: str = ""
-        while time.time() < time_to_stop:
-            port_info = self.send_command(f"show port info {port_id}")
-            if "Link status: up" in port_info:
-                break
-            time.sleep(0.5)
-        else:
-            self._logger.error(f"The link for port {port_id} did not come up in the given timeout.")
-        return "Link status: up" in port_info
-
-    def set_forward_mode(self, mode: SimpleForwardingModes, verify: bool = True) -> None:
-        """Set packet forwarding mode.
-
-        Args:
-            mode: The forwarding mode to use.
-            verify: If :data:`True` the output of the command will be scanned in an attempt to
-                verify that the forwarding mode was set to `mode` properly.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the forwarding mode
-                fails to update.
-        """
-        set_fwd_output = self.send_command(f"set fwd {mode.value}")
-        if verify:
-            if f"Set {mode.value} packet forwarding mode" not in set_fwd_output:
-                self._logger.debug(f"Failed to set fwd mode to {mode.value}:\n{set_fwd_output}")
-                raise InteractiveCommandExecutionError(
-                    f"Test pmd failed to set fwd mode to {mode.value}"
-                )
-
-    def stop_all_ports(self, verify: bool = True) -> None:
-        """Stops all the ports.
-
-        Args:
-            verify: If :data:`True`, the output of the command will be checked for a successful
-                execution.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the ports were not
-                stopped successfully.
-        """
-        self._logger.debug("Stopping all the ports...")
-        output = self.send_command("port stop all")
-        if verify and not output.strip().endswith("Done"):
-            raise InteractiveCommandExecutionError("Ports were not stopped successfully.")
-
-        self.ports_started = False
-
-    def start_all_ports(self, verify: bool = True) -> None:
-        """Starts all the ports.
-
-        Args:
-            verify: If :data:`True`, the output of the command will be checked for a successful
-                execution.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the ports were not
-                started successfully.
-        """
-        self._logger.debug("Starting all the ports...")
-        output = self.send_command("port start all")
-        if verify and not output.strip().endswith("Done"):
-            raise InteractiveCommandExecutionError("Ports were not started successfully.")
-
-        self.ports_started = True
-
-    @requires_stopped_ports
-    def set_ports_queues(self, number_of: int) -> None:
-        """Sets the number of queues per port.
-
-        Args:
-            number_of: The number of RX/TX queues to create per port.
-
-        Raises:
-            InternalError: If `number_of` is invalid.
-        """
-        if number_of < 1:
-            raise InternalError("The number of queues must be positive and non-zero.")
-
-        self.send_command(f"port config all rxq {number_of}")
-        self.send_command(f"port config all txq {number_of}")
-
-    @requires_stopped_ports
-    def close_all_ports(self, verify: bool = True) -> None:
-        """Close all ports.
-
-        Args:
-            verify: If :data:`True` the output of the close command will be scanned in an attempt
-                to verify that all ports were stopped successfully. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and at lease one port
-                failed to close.
-        """
-        port_close_output = self.send_command("port close all")
-        if verify:
-            num_ports = len(self.ports)
-            if not all(f"Port {p_id} is closed" in port_close_output for p_id in range(num_ports)):
-                raise InteractiveCommandExecutionError("Ports were not closed successfully.")
-
-    def show_port_info_all(self) -> list[TestPmdPort]:
-        """Returns the information of all the ports.
-
-        Returns:
-            list[TestPmdPort]: A list containing all the ports information as `TestPmdPort`.
-        """
-        output = self.send_command("show port info all")
-
-        # Sample output of the "all" command looks like:
-        #
-        # <start>
-        #
-        #   ********************* Infos for port 0 *********************
-        #   Key: value
-        #
-        #   ********************* Infos for port 1 *********************
-        #   Key: value
-        # <end>
-        #
-        # Takes advantage of the double new line in between ports as end delimiter. But we need to
-        # artificially add a new line at the end to pick up the last port. Because commands are
-        # executed on a pseudo-terminal created by paramiko on the remote node, lines end with CRLF.
-        # Therefore we also need to take the carriage return into account.
-        iter = re.finditer(r"\*{21}.*?[\r\n]{4}", output + "\r\n", re.S)
-        self._ports = [TestPmdPort.parse(block.group(0)) for block in iter]
-        return self._ports
-
-    def show_port_info(self, port_id: int) -> TestPmdPort:
-        """Returns the given port information.
-
-        Args:
-            port_id: The port ID to gather information for.
-
-        Raises:
-            InteractiveCommandExecutionError: If `port_id` is invalid.
-
-        Returns:
-            TestPmdPort: An instance of `TestPmdPort` containing the given port's information.
-        """
-        output = self.send_command(f"show port info {port_id}", skip_first_line=True)
-        if output.startswith("Invalid port"):
-            raise InteractiveCommandExecutionError("invalid port given")
-
-        port = TestPmdPort.parse(output)
-        self._update_port(port)
-        return port
-
-    def _update_port(self, port: TestPmdPort) -> None:
-        if self._ports:
-            self._ports = [
-                existing_port if port.id != existing_port.id else port
-                for existing_port in self._ports
-            ]
-
-    def set_mac_addr(self, port_id: int, mac_address: str, add: bool, verify: bool = True) -> None:
-        """Add or remove a mac address on a given port's Allowlist.
-
-        Args:
-            port_id: The port ID the mac address is set on.
-            mac_address: The mac address to be added to or removed from the specified port.
-            add: If :data:`True`, add the specified mac address. If :data:`False`, remove specified
-                mac address.
-            verify: If :data:'True', assert that the 'mac_addr' operation was successful. If
-                :data:'False', run the command and skip this assertion.
-
-        Raises:
-            InteractiveCommandExecutionError: If the set mac address operation fails.
-        """
-        mac_cmd = "add" if add else "remove"
-        output = self.send_command(f"mac_addr {mac_cmd} {port_id} {mac_address}")
-        if "Bad arguments" in output:
-            self._logger.debug("Invalid argument provided to mac_addr")
-            raise InteractiveCommandExecutionError("Invalid argument provided")
-
-        if verify:
-            if "mac_addr_cmd error:" in output:
-                self._logger.debug(f"Failed to {mac_cmd} {mac_address} on port {port_id}")
-                raise InteractiveCommandExecutionError(
-                    f"Failed to {mac_cmd} {mac_address} on port {port_id} \n{output}"
-                )
-
-    def set_multicast_mac_addr(
-        self, port_id: int, multi_addr: str, add: bool, verify: bool = True
-    ) -> None:
-        """Add or remove multicast mac address to a specified port's allow list.
-
-        Args:
-            port_id: The port ID the multicast address is set on.
-            multi_addr: The multicast address to be added or removed from the filter.
-            add: If :data:'True', add the specified multicast address to the port filter.
-                If :data:'False', remove the specified multicast address from the port filter.
-            verify: If :data:'True', assert that the 'mcast_addr' operations was successful.
-                If :data:'False', execute the 'mcast_addr' operation and skip the assertion.
-
-        Raises:
-            InteractiveCommandExecutionError: If either the 'add' or 'remove' operations fails.
-        """
-        mcast_cmd = "add" if add else "remove"
-        output = self.send_command(f"mcast_addr {mcast_cmd} {port_id} {multi_addr}")
-        if "Bad arguments" in output:
-            self._logger.debug("Invalid arguments provided to mcast_addr")
-            raise InteractiveCommandExecutionError("Invalid argument provided")
-
-        if verify:
-            if (
-                "Invalid multicast_addr" in output
-                or f"multicast address {'already' if add else 'not'} filtered by port" in output
-            ):
-                self._logger.debug(f"Failed to {mcast_cmd} {multi_addr} on port {port_id}")
-                raise InteractiveCommandExecutionError(
-                    f"Failed to {mcast_cmd} {multi_addr} on port {port_id} \n{output}"
-                )
-
-    def show_port_stats_all(self) -> Tuple[list[TestPmdPortStats], str]:
-        """Returns the statistics of all the ports.
-
-        Returns:
-            Tuple[str, list[TestPmdPortStats]]: A tuple where the first element is the stats of all
-            ports as `TestPmdPortStats` and second is the raw testpmd output that was collected
-            from the sent command.
-        """
-        output = self.send_command("show port stats all")
-
-        # Sample output of the "all" command looks like:
-        #
-        #   ########### NIC statistics for port 0 ###########
-        #   values...
-        #   #################################################
-        #
-        #   ########### NIC statistics for port 1 ###########
-        #   values...
-        #   #################################################
-        #
-        iter = re.finditer(r"(^  #*.+#*$[^#]+)^  #*\r$", output, re.MULTILINE)
-        return ([TestPmdPortStats.parse(block.group(1)) for block in iter], output)
-
-    def show_port_stats(self, port_id: int) -> TestPmdPortStats:
-        """Returns the given port statistics.
-
-        Args:
-            port_id: The port ID to gather information for.
-
-        Raises:
-            InteractiveCommandExecutionError: If `port_id` is invalid.
-
-        Returns:
-            TestPmdPortStats: An instance of `TestPmdPortStats` containing the given port's stats.
-        """
-        output = self.send_command(f"show port stats {port_id}", skip_first_line=True)
-        if output.startswith("Invalid port"):
-            raise InteractiveCommandExecutionError("invalid port given")
-
-        return TestPmdPortStats.parse(output)
-
-    def set_multicast_all(self, on: bool, verify: bool = True) -> None:
-        """Turns multicast mode on/off for the specified port.
-
-        Args:
-            on: If :data:`True`, turns multicast mode on, otherwise turns off.
-            verify: If :data:`True` an additional command will be sent to verify
-                that multicast mode is properly set. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and multicast
-                mode is not properly set.
-        """
-        multicast_cmd_output = self.send_command(f"set allmulti all {'on' if on else 'off'}")
-        if verify:
-            port_stats = self.show_port_info_all()
-            if on ^ all(stats.is_allmulticast_mode_enabled for stats in port_stats):
-                self._logger.debug(
-                    f"Failed to set multicast mode on all ports.: \n{multicast_cmd_output}"
-                )
-                raise InteractiveCommandExecutionError(
-                    "Testpmd failed to set multicast mode on all ports."
-                )
-
-    @requires_stopped_ports
-    def csum_set_hw(
-        self, layers: ChecksumOffloadOptions, port_id: int, verify: bool = True
-    ) -> None:
-        """Enables hardware checksum offloading on the specified layer.
-
-        Args:
-            layers: The layer/layers that checksum offloading should be enabled on.
-            port_id: The port number to enable checksum offloading on, should be within 0-32.
-            verify: If :data:`True` the output of the command will be scanned in an attempt to
-                verify that checksum offloading was enabled on the port.
-
-        Raises:
-            InteractiveCommandExecutionError: If checksum offload is not enabled successfully.
-        """
-        for name, offload in ChecksumOffloadOptions.__members__.items():
-            if offload in layers:
-                name = name.replace("_", "-")
-                csum_output = self.send_command(f"csum set {name} hw {port_id}")
-                if verify:
-                    if (
-                        "Bad arguments" in csum_output
-                        or f"Please stop port {port_id} first" in csum_output
-                        or f"checksum offload is not supported by port {port_id}" in csum_output
-                    ):
-                        self._logger.debug(f"Csum set hw error:\n{csum_output}")
-                        raise InteractiveCommandExecutionError(
-                            f"Failed to set csum hw {name} mode on port {port_id}"
-                        )
-                success = False
-                if f"{name} checksum offload is hw" in csum_output.lower():
-                    success = True
-                if not success and verify:
-                    self._logger.debug(
-                        f"Failed to set csum hw mode on port {port_id}:\n{csum_output}"
-                    )
-                    raise InteractiveCommandExecutionError(
-                        f"""Failed to set csum hw mode on port
-                                                           {port_id}:\n{csum_output}"""
-                    )
-
-    def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
-        """Creates a flow rule in the testpmd session.
-
-        This command is implicitly verified as needed to return the created flow rule id.
-
-        Args:
-            flow_rule: :class:`FlowRule` object used for creating testpmd flow rule.
-            port_id: Integer representing the port to use.
-
-        Raises:
-            InteractiveCommandExecutionError: If flow rule is invalid.
-
-        Returns:
-            Id of created flow rule.
-        """
-        flow_output = self.send_command(f"flow create {port_id} {flow_rule}")
-        match = re.search(r"#(\d+)", flow_output)
-        if match is not None:
-            match_str = match.group(1)
-            flow_id = int(match_str)
-            return flow_id
-        else:
-            self._logger.debug(f"Failed to create flow rule:\n{flow_output}")
-            raise InteractiveCommandExecutionError(f"Failed to create flow rule:\n{flow_output}")
-
-    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
-        """Validates a flow rule in the testpmd session.
-
-        Args:
-            flow_rule: :class:`FlowRule` object used for validating testpmd flow rule.
-            port_id: Integer representing the port to use.
-
-        Returns:
-            Boolean representing whether rule is valid or not.
-        """
-        flow_output = self.send_command(f"flow validate {port_id} {flow_rule}")
-        if "Flow rule validated" in flow_output:
-            return True
-        return False
-
-    def flow_delete(self, flow_id: int, port_id: int, verify: bool = True) -> None:
-        """Deletes the specified flow rule from the testpmd session.
-
-        Args:
-            flow_id: ID of the flow to remove.
-            port_id: Integer representing the port to use.
-            verify: If :data:`True`, the output of the command is scanned
-                to ensure the flow rule was deleted successfully.
-
-        Raises:
-            InteractiveCommandExecutionError: If flow rule is invalid.
-        """
-        flow_output = self.send_command(f"flow destroy {port_id} rule {flow_id}")
-        if verify:
-            if "destroyed" not in flow_output:
-                self._logger.debug(f"Failed to delete flow rule:\n{flow_output}")
-                raise InteractiveCommandExecutionError(
-                    f"Failed to delete flow rule:\n{flow_output}"
-                )
-
-    @requires_started_ports
-    @requires_stopped_ports
-    def set_port_mtu(self, port_id: int, mtu: int, verify: bool = True) -> None:
-        """Change the MTU of a port using testpmd.
-
-        Some PMDs require that the port be stopped before changing the MTU, and it does no harm to
-        stop the port before configuring in cases where it isn't required, so ports are stopped
-        prior to changing their MTU. On the other hand, some PMDs require that the port had already
-        been started once since testpmd startup. Therefore, ports are also started before stopping
-        them to ensure this has happened.
-
-        Args:
-            port_id: ID of the port to adjust the MTU on.
-            mtu: Desired value for the MTU to be set to.
-            verify: If `verify` is :data:`True` then the output will be scanned in an attempt to
-                verify that the mtu was properly set on the port. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the MTU was not
-                properly updated on the port matching `port_id`.
-        """
-        set_mtu_output = self.send_command(f"port config mtu {port_id} {mtu}")
-        if verify and (f"MTU: {mtu}" not in self.send_command(f"show port info {port_id}")):
-            self._logger.debug(
-                f"Failed to set mtu to {mtu} on port {port_id}. Output was:\n{set_mtu_output}"
-            )
-            raise InteractiveCommandExecutionError(
-                f"Test pmd failed to update mtu of port {port_id} to {mtu}"
-            )
-
-    def set_port_mtu_all(self, mtu: int, verify: bool = True) -> None:
-        """Change the MTU of all ports using testpmd.
-
-        Runs :meth:`set_port_mtu` for every port that testpmd is aware of.
-
-        Args:
-            mtu: Desired value for the MTU to be set to.
-            verify: Whether to verify that setting the MTU on each port was successful or not.
-                Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the MTU was not
-                properly updated on at least one port.
-        """
-        for port in self.ports:
-            self.set_port_mtu(port.id, mtu, verify)
-
-    @staticmethod
-    def extract_verbose_output(output: str) -> list[TestPmdVerbosePacket]:
-        """Extract the verbose information present in given testpmd output.
-
-        This method extracts sections of verbose output that begin with the line
-        "port X/queue Y: sent/received Z packets" and end with the ol_flags of a packet.
-
-        Args:
-            output: Testpmd output that contains verbose information
-
-        Returns:
-            List of parsed packet information gathered from verbose information in `output`.
-        """
-        out: list[TestPmdVerbosePacket] = []
-        prev_header: str = ""
-        iter = re.finditer(
-            r"(?P<HEADER>(?:port \d+/queue \d+: (?:received|sent) \d+ packets)?)\s*"
-            r"(?P<PACKET>src=[\w\s=:-]+?ol_flags: [\w ]+)",
-            output,
-        )
-        for match in iter:
-            if match.group("HEADER"):
-                prev_header = match.group("HEADER")
-            out.append(TestPmdVerbosePacket.parse(f"{prev_header}\n{match.group('PACKET')}"))
-        return out
-
-    @requires_stopped_ports
-    def set_vlan_filter(self, port: int, enable: bool, verify: bool = True) -> None:
-        """Set vlan filter on.
-
-        Args:
-            port: The port number to enable VLAN filter on.
-            enable: Enable the filter on `port` if :data:`True`, otherwise disable it.
-            verify: If :data:`True`, the output of the command and show port info
-                is scanned to verify that vlan filtering was set successfully.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the filter
-                fails to update.
-        """
-        filter_cmd_output = self.send_command(f"vlan set filter {'on' if enable else 'off'} {port}")
-        if verify:
-            vlan_settings = self.show_port_info(port_id=port).vlan_offload
-            if enable ^ (vlan_settings is not None and VLANOffloadFlag.FILTER in vlan_settings):
-                self._logger.debug(
-                    f"""Failed to {"enable" if enable else "disable"}
-                                   filter on port {port}: \n{filter_cmd_output}"""
-                )
-                raise InteractiveCommandExecutionError(
-                    f"""Failed to {"enable" if enable else "disable"}
-                    filter on port {port}"""
-                )
-
-    def set_mac_address(self, port: int, mac_address: str, verify: bool = True) -> None:
-        """Set port's MAC address.
-
-        Args:
-            port: The number of the requested port.
-            mac_address: The MAC address to set.
-            verify: If :data:`True`, the output of the command is scanned to verify that
-                the mac address is set in the specified port.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command
-                fails to execute.
-        """
-        output = self.send_command(f"mac_addr set {port} {mac_address}", skip_first_line=True)
-        if verify:
-            if output.strip():
-                self._logger.debug(
-                    f"Testpmd failed to set MAC address {mac_address} on port {port}."
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Testpmd failed to set MAC address {mac_address} on port {port}."
-                )
-
-    def set_flow_control(
-        self, port: int, flow_ctrl: TestPmdPortFlowCtrl, verify: bool = True
-    ) -> None:
-        """Set the given `port`'s flow control.
-
-        Args:
-            port: The number of the requested port.
-            flow_ctrl: The requested flow control parameters.
-            verify: If :data:`True`, the output of the command is scanned to verify that
-                the flow control in the specified port is set.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the command
-                fails to execute.
-        """
-        output = self.send_command(f"set flow_ctrl {flow_ctrl} {port}", skip_first_line=True)
-        if verify:
-            if output.strip():
-                self._logger.debug(f"Testpmd failed to set the {flow_ctrl} in port {port}.")
-                raise InteractiveCommandExecutionError(
-                    f"Testpmd failed to set the {flow_ctrl} in port {port}."
-                )
-
-    def show_port_flow_info(self, port: int) -> TestPmdPortFlowCtrl | None:
-        """Show port info flow.
-
-        Args:
-            port: The number of the requested port.
-
-        Returns:
-            The current port flow control parameters if supported, otherwise :data:`None`.
-        """
-        output = self.send_command(f"show port {port} flow_ctrl")
-        if "Flow control infos" in output:
-            return TestPmdPortFlowCtrl.parse(output)
-        return None
-
-    @requires_stopped_ports
-    def rx_vlan(self, vlan: int, port: int, add: bool, verify: bool = True) -> None:
-        """Add specified vlan tag to the filter list on a port. Requires vlan filter to be on.
-
-        Args:
-            vlan: The vlan tag to add, should be within 1-1005.
-            port: The port number to add the tag on.
-            add: Adds the tag if :data:`True`, otherwise removes the tag.
-            verify: If :data:`True`, the output of the command is scanned to verify that
-                the vlan tag was added to the filter list on the specified port.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the tag
-                is not added.
-        """
-        rx_cmd_output = self.send_command(f"rx_vlan {'add' if add else 'rm'} {vlan} {port}")
-        if verify:
-            if (
-                "VLAN-filtering disabled" in rx_cmd_output
-                or "Invalid vlan_id" in rx_cmd_output
-                or "Bad arguments" in rx_cmd_output
-            ):
-                self._logger.debug(
-                    f"""Failed to {"add" if add else "remove"} tag {vlan}
-                    port {port}: \n{rx_cmd_output}"""
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Testpmd failed to {'add' if add else 'remove'} tag {vlan} on port {port}."
-                )
-
-    @requires_stopped_ports
-    def set_vlan_strip(self, port: int, enable: bool, verify: bool = True) -> None:
-        """Enable or disable vlan stripping on the specified port.
-
-        Args:
-            port: The port number to use.
-            enable: If :data:`True`, will turn vlan stripping on, otherwise will turn off.
-            verify: If :data:`True`, the output of the command and show port info
-                is scanned to verify that vlan stripping was enabled on the specified port.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and stripping
-                fails to update.
-        """
-        strip_cmd_output = self.send_command(f"vlan set strip {'on' if enable else 'off'} {port}")
-        if verify:
-            vlan_settings = self.show_port_info(port_id=port).vlan_offload
-            if enable ^ (vlan_settings is not None and VLANOffloadFlag.STRIP in vlan_settings):
-                self._logger.debug(
-                    f"""Failed to set strip {"on" if enable else "off"}
-                    port {port}: \n{strip_cmd_output}"""
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Testpmd failed to set strip {'on' if enable else 'off'} port {port}."
-                )
-
-    @requires_stopped_ports
-    def tx_vlan_set(
-        self, port: int, enable: bool, vlan: int | None = None, verify: bool = True
-    ) -> None:
-        """Set hardware insertion of vlan tags in packets sent on a port.
-
-        Args:
-            port: The port number to use.
-            enable: Sets vlan tag insertion if :data:`True`, and resets if :data:`False`.
-            vlan: The vlan tag to insert if enable is :data:`True`.
-            verify: If :data:`True`, the output of the command is scanned to verify that
-                vlan insertion was enabled on the specified port.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the insertion
-                tag is not set.
-        """
-        if enable:
-            tx_vlan_cmd_output = self.send_command(f"tx_vlan set {port} {vlan}")
-            if verify:
-                if (
-                    "Please stop port" in tx_vlan_cmd_output
-                    or "Invalid vlan_id" in tx_vlan_cmd_output
-                    or "Invalid port" in tx_vlan_cmd_output
-                ):
-                    self._logger.debug(
-                        f"Failed to set vlan tag {vlan} on port {port}:\n{tx_vlan_cmd_output}"
-                    )
-                    raise InteractiveCommandExecutionError(
-                        f"Testpmd failed to set vlan insertion tag {vlan} on port {port}."
-                    )
-        else:
-            tx_vlan_cmd_output = self.send_command(f"tx_vlan reset {port}")
-            if verify:
-                if "Please stop port" in tx_vlan_cmd_output or "Invalid port" in tx_vlan_cmd_output:
-                    self._logger.debug(
-                        f"Failed to reset vlan insertion on port {port}: \n{tx_vlan_cmd_output}"
-                    )
-                    raise InteractiveCommandExecutionError(
-                        f"Testpmd failed to reset vlan insertion on port {port}."
-                    )
-
-    def set_promisc(self, port: int, enable: bool, verify: bool = True) -> None:
-        """Enable or disable promiscuous mode for the specified port.
-
-        Args:
-            port: Port number to use.
-            enable: If :data:`True`, turn promiscuous mode on, otherwise turn off.
-            verify: If :data:`True` an additional command will be sent to verify that
-                promiscuous mode is properly set. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and promiscuous mode
-                is not correctly set.
-        """
-        promisc_cmd_output = self.send_command(f"set promisc {port} {'on' if enable else 'off'}")
-        if verify:
-            stats = self.show_port_info(port_id=port)
-            if enable ^ stats.is_promiscuous_mode_enabled:
-                self._logger.debug(
-                    f"Failed to set promiscuous mode on port {port}: \n{promisc_cmd_output}"
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Testpmd failed to set promiscuous mode on port {port}."
-                )
-
-    def set_verbose(self, level: int, verify: bool = True) -> None:
-        """Set debug verbosity level.
-
-        Args:
-            level: 0 - silent except for error
-                1 - fully verbose except for Tx packets
-                2 - fully verbose except for Rx packets
-                >2 - fully verbose
-            verify: If :data:`True` the command output will be scanned to verify that verbose level
-                is properly set. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and verbose level
-            is not correctly set.
-        """
-        verbose_cmd_output = self.send_command(f"set verbose {level}")
-        if verify:
-            if "Change verbose level" not in verbose_cmd_output:
-                self._logger.debug(
-                    f"Failed to set verbose level to {level}: \n{verbose_cmd_output}"
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Testpmd failed to set verbose level to {level}."
-                )
-
-    def rx_vxlan(self, vxlan_id: int, port_id: int, enable: bool, verify: bool = True) -> None:
-        """Add or remove vxlan id to/from filter list.
-
-        Args:
-            vxlan_id: VXLAN ID to add to port filter list.
-            port_id: ID of the port to modify VXLAN filter of.
-            enable: If :data:`True`, adds specified VXLAN ID, otherwise removes it.
-            verify: If :data:`True`, the output of the command is checked to verify
-                the VXLAN ID was successfully added/removed from the port.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and VXLAN ID
-                is not successfully added or removed.
-        """
-        action = "add" if enable else "rm"
-        vxlan_output = self.send_command(f"rx_vxlan_port {action} {vxlan_id} {port_id}")
-        if verify:
-            if "udp tunneling add error" in vxlan_output:
-                self._logger.debug(f"Failed to set VXLAN:\n{vxlan_output}")
-                raise InteractiveCommandExecutionError(f"Failed to set VXLAN:\n{vxlan_output}")
-
-    def clear_port_stats(self, port_id: int, verify: bool = True) -> None:
-        """Clear statistics of a given port.
-
-        Args:
-            port_id: ID of the port to clear the statistics on.
-            verify: If :data:`True` the output of the command will be scanned to verify that it was
-                successful, otherwise failures will be ignored. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and testpmd fails to
-                clear the statistics of the given port.
-        """
-        clear_output = self.send_command(f"clear port stats {port_id}")
-        if verify and f"NIC statistics for port {port_id} cleared" not in clear_output:
-            raise InteractiveCommandExecutionError(
-                f"Test pmd failed to set clear forwarding stats on port {port_id}"
-            )
-
-    def clear_port_stats_all(self, verify: bool = True) -> None:
-        """Clear the statistics of all ports that testpmd is aware of.
-
-        Args:
-            verify: If :data:`True` the output of the command will be scanned to verify that all
-                ports had their statistics cleared, otherwise failures will be ignored. Defaults to
-                :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and testpmd fails to
-                clear the statistics of any of its ports.
-        """
-        clear_output = self.send_command("clear port stats all")
-        if verify:
-            if type(self._app_params.port_numa_config) is list:
-                for port_id in range(len(self._app_params.port_numa_config)):
-                    if f"NIC statistics for port {port_id} cleared" not in clear_output:
-                        raise InteractiveCommandExecutionError(
-                            f"Test pmd failed to set clear forwarding stats on port {port_id}"
-                        )
-
-    @only_active
-    def close(self) -> None:
-        """Overrides :meth:`~.interactive_shell.close`."""
-        self.stop()
-        self.send_command("quit", "Bye...")
-        return super().close()
-
-    """
-    ====== Capability retrieval methods ======
-    """
-
-    def get_capabilities_rx_offload(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Get all rx offload capabilities and divide them into supported and unsupported.
-
-        Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        self._logger.debug("Getting rx offload capabilities.")
-        command = f"show port {self.ports[0].id} rx_offload capabilities"
-        rx_offload_capabilities_out = self.send_command(command)
-        rx_offload_capabilities = RxOffloadCapabilities.parse(rx_offload_capabilities_out)
-        self._update_capabilities_from_flag(
-            supported_capabilities,
-            unsupported_capabilities,
-            RxOffloadCapability,
-            rx_offload_capabilities.per_port | rx_offload_capabilities.per_queue,
-        )
-
-    def get_port_queue_info(
-        self, port_id: int, queue_id: int, is_rx_queue: bool
-    ) -> TestPmdQueueInfo:
-        """Returns the current state of the specified queue."""
-        command = f"show {'rxq' if is_rx_queue else 'txq'} info {port_id} {queue_id}"
-        queue_info = TestPmdQueueInfo.parse(self.send_command(command))
-        return queue_info
-
-    def setup_port_queue(self, port_id: int, queue_id: int, is_rx_queue: bool) -> None:
-        """Setup a given queue on a port.
-
-        This functionality cannot be verified because the setup action only takes effect when the
-        queue is started.
-
-        Args:
-            port_id: ID of the port where the queue resides.
-            queue_id: ID of the queue to setup.
-            is_rx_queue: Type of queue to setup. If :data:`True` an RX queue will be setup,
-                otherwise a TX queue will be setup.
-        """
-        self.send_command(f"port {port_id} {'rxq' if is_rx_queue else 'txq'} {queue_id} setup")
-
-    def stop_port_queue(
-        self, port_id: int, queue_id: int, is_rx_queue: bool, verify: bool = True
-    ) -> None:
-        """Stops a given queue on a port.
-
-        Args:
-            port_id: ID of the port that the queue belongs to.
-            queue_id: ID of the queue to stop.
-            is_rx_queue: Type of queue to stop. If :data:`True` an RX queue will be stopped,
-                otherwise a TX queue will be stopped.
-            verify: If :data:`True` an additional command will be sent to verify the queue stopped.
-                Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the queue fails to
-                stop.
-        """
-        port_type = "rxq" if is_rx_queue else "txq"
-        stop_cmd_output = self.send_command(f"port {port_id} {port_type} {queue_id} stop")
-        if verify:
-            queue_started = self.get_port_queue_info(
-                port_id, queue_id, is_rx_queue
-            ).is_queue_started
-            if queue_started:
-                self._logger.debug(
-                    f"Failed to stop {port_type} {queue_id} on port {port_id}:\n{stop_cmd_output}"
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Test pmd failed to stop {port_type} {queue_id} on port {port_id}"
-                )
-
-    def start_port_queue(
-        self, port_id: int, queue_id: int, is_rx_queue: bool, verify: bool = True
-    ) -> None:
-        """Starts a given queue on a port.
-
-        First sets up the port queue, then starts it.
-
-        Args:
-            port_id: ID of the port that the queue belongs to.
-            queue_id: ID of the queue to start.
-            is_rx_queue: Type of queue to start. If :data:`True` an RX queue will be started,
-                otherwise a TX queue will be started.
-            verify: if :data:`True` an additional command will be sent to verify that the queue was
-                started. Defaults to :data:`True`.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and the queue fails to
-                start.
-        """
-        port_type = "rxq" if is_rx_queue else "txq"
-        self.setup_port_queue(port_id, queue_id, is_rx_queue)
-        start_cmd_output = self.send_command(f"port {port_id} {port_type} {queue_id} start")
-        if verify:
-            queue_started = self.get_port_queue_info(
-                port_id, queue_id, is_rx_queue
-            ).is_queue_started
-            if not queue_started:
-                self._logger.debug(
-                    f"Failed to start {port_type} {queue_id} on port {port_id}:\n{start_cmd_output}"
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Test pmd failed to start {port_type} {queue_id} on port {port_id}"
-                )
-
-    def get_queue_ring_size(self, port_id: int, queue_id: int, is_rx_queue: bool) -> int:
-        """Returns the current size of the ring on the specified queue."""
-        command = f"show {'rxq' if is_rx_queue else 'txq'} info {port_id} {queue_id}"
-        queue_info = TestPmdQueueInfo.parse(self.send_command(command))
-        return queue_info.ring_size
-
-    def set_queue_ring_size(
-        self,
-        port_id: int,
-        queue_id: int,
-        size: int,
-        is_rx_queue: bool,
-        verify: bool = True,
-    ) -> None:
-        """Update the ring size of an Rx/Tx queue on a given port.
-
-        Queue is setup after setting the ring size so that the queue info reflects this change and
-        it can be verified.
-
-        Args:
-            port_id: The port that the queue resides on.
-            queue_id: The ID of the queue on the port.
-            size: The size to update the ring size to.
-            is_rx_queue: Whether to modify an RX or TX queue. If :data:`True` an RX queue will be
-                updated, otherwise a TX queue will be updated.
-            verify: If :data:`True` an additional command will be sent to check the ring size of
-                the queue in an attempt to validate that the size was changes properly.
-
-        Raises:
-            InteractiveCommandExecutionError: If `verify` is :data:`True` and there is a failure
-                when updating ring size.
-        """
-        queue_type = "rxq" if is_rx_queue else "txq"
-        self.send_command(f"port config {port_id} {queue_type} {queue_id} ring_size {size}")
-        self.setup_port_queue(port_id, queue_id, is_rx_queue)
-        if verify:
-            curr_ring_size = self.get_queue_ring_size(port_id, queue_id, is_rx_queue)
-            if curr_ring_size != size:
-                self._logger.debug(
-                    f"Failed up update ring size of queue {queue_id} on port {port_id}. Current"
-                    f" ring size is {curr_ring_size}."
-                )
-                raise InteractiveCommandExecutionError(
-                    f"Failed to update ring size of queue {queue_id} on port {port_id}"
-                )
-
-    @requires_stopped_ports
-    def set_queue_deferred_start(
-        self, port_id: int, queue_id: int, is_rx_queue: bool, on: bool
-    ) -> None:
-        """Set the deferred start attribute of the specified queue on/off.
-
-        Args:
-            port_id: The port that the queue resides on.
-            queue_id: The ID of the queue on the port.
-            is_rx_queue: Whether to modify an RX or TX queue. If :data:`True` an RX queue will be
-                updated, otherwise a TX queue will be updated.
-            on: Whether to set deferred start mode on or off. If :data:`True` deferred start will
-                be turned on, otherwise it will be turned off.
-        """
-        queue_type = "rxq" if is_rx_queue else "txq"
-        action = "on" if on else "off"
-        self.send_command(f"port {port_id} {queue_type} {queue_id} deferred_start {action}")
-
-    def _update_capabilities_from_flag(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-        flag_class: type[Flag],
-        supported_flags: Flag,
-    ) -> None:
-        """Divide all flags from `flag_class` into supported and unsupported."""
-        for flag in flag_class:
-            if flag in supported_flags:
-                supported_capabilities.add(NicCapability[str(flag.name)])
-            else:
-                unsupported_capabilities.add(NicCapability[str(flag.name)])
-
-    @requires_started_ports
-    def get_capabilities_rxq_info(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Get all rxq capabilities and divide them into supported and unsupported.
-
-        Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        self._logger.debug("Getting rxq capabilities.")
-        command = f"show rxq info {self.ports[0].id} 0"
-        rxq_info = TestPmdRxqInfo.parse(self.send_command(command))
-        if rxq_info.scattered_packets:
-            supported_capabilities.add(NicCapability.SCATTERED_RX_ENABLED)
-        else:
-            unsupported_capabilities.add(NicCapability.SCATTERED_RX_ENABLED)
-
-    def get_capabilities_show_port_info(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Get all capabilities from show port info and divide them into supported and unsupported.
-
-        Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        self._update_capabilities_from_flag(
-            supported_capabilities,
-            unsupported_capabilities,
-            DeviceCapabilitiesFlag,
-            self.ports[0].device_capabilities,
-        )
-
-    def get_capabilities_mcast_filtering(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Get multicast filtering capability from mcast_addr add and check for testpmd error code.
-
-        Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        self._logger.debug("Getting mcast filter capabilities.")
-        command = f"mcast_addr add {self.ports[0].id} 01:00:5E:00:00:00"
-        output = self.send_command(command)
-        if "diag=-95" in output:
-            unsupported_capabilities.add(NicCapability.MCAST_FILTERING)
-        else:
-            supported_capabilities.add(NicCapability.MCAST_FILTERING)
-            command = str.replace(command, "add", "remove", 1)
-            self.send_command(command)
-
-    def get_capabilities_flow_ctrl(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Get flow control capability and check for testpmd failure.
-
-        Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        self._logger.debug("Getting flow ctrl capabilities.")
-        command = f"show port {self.ports[0].id} flow_ctrl"
-        output = self.send_command(command)
-        if "Flow control infos" in output:
-            supported_capabilities.add(NicCapability.FLOW_CTRL)
-        else:
-            unsupported_capabilities.add(NicCapability.FLOW_CTRL)
-
-    def get_capabilities_physical_function(
-        self,
-        supported_capabilities: MutableSet["NicCapability"],
-        unsupported_capabilities: MutableSet["NicCapability"],
-    ) -> None:
-        """Store capability representing a physical function test run.
-
-        Args:
-            supported_capabilities: Supported capabilities will be added to this set.
-            unsupported_capabilities: Unsupported capabilities will be added to this set.
-        """
-        ctx = get_ctx()
-        if ctx.topology.vf_ports == []:
-            supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
-        else:
-            unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
-
-
-class NicCapability(NoAliasEnum):
-    """A mapping between capability names and the associated :class:`TestPmdShell` methods.
-
-    The :class:`TestPmdShell` capability checking method executes the command that checks
-    whether the capability is supported.
-    A decorator may optionally be added to the method that will add and remove configuration
-    that's necessary to retrieve the capability support status.
-    The Enum members may be assigned the method itself or a tuple of
-    (capability_checking_method, decorator_function).
-
-    The signature of each :class:`TestPmdShell` capability checking method must be::
-
-        fn(self, supported_capabilities: MutableSet, unsupported_capabilities: MutableSet) -> None
-
-    The capability checking method must get whether a capability is supported or not
-    from a testpmd command. If multiple capabilities can be obtained from a testpmd command,
-    each should be obtained in the method. These capabilities should then
-    be added to `supported_capabilities` or `unsupported_capabilities` based on their support.
-
-    The two dictionaries are shared across all capability discovery function calls in a given
-    test run so that we don't call the same function multiple times. For example, when we find
-    :attr:`SCATTERED_RX_ENABLED` in :meth:`TestPmdShell.get_capabilities_rxq_info`,
-    we don't go looking for it again if a different test case also needs it.
-    """
-
-    #: Scattered packets Rx enabled
-    SCATTERED_RX_ENABLED: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rxq_info,
-        add_remove_mtu(9000),
-    )
-    #:
-    RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports L3 checksum offload.
-    RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports L4 checksum offload.
-    RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports L4 checksum offload.
-    RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports Large Receive Offload.
-    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
-    #: Device supports QinQ (queue in queue) offload.
-    RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports inner packet L3 checksum.
-    RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports MACsec.
-    RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports filtering of a VLAN Tag identifier.
-    RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports VLAN offload.
-    RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports receiving segmented mbufs.
-    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
-    #: Device supports Timestamp.
-    RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports crypto processing while packet is received in NIC.
-    RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports CRC stripping.
-    RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports L4 checksum offload.
-    RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports inner packet L4 checksum.
-    RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports RSS hashing.
-    RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports scatter Rx packets to segmented mbufs.
-    RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports all checksum capabilities.
-    RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_rx_offload,
-        None,
-    )
-    #: Device supports all VLAN capabilities.
-    RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
-    #: Device supports Rx queue setup after device started.
-    RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_show_port_info,
-        None,
-    )
-    #: Device supports Tx queue setup after device started.
-    RUNTIME_TX_QUEUE_SETUP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_show_port_info,
-        None,
-    )
-    #: Device supports shared Rx queue among ports within Rx domain and switch domain.
-    RXQ_SHARE: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_show_port_info, None)
-    #: Device supports keeping flow rules across restart.
-    FLOW_RULE_KEEP: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_show_port_info, None)
-    #: Device supports keeping shared flow objects across restart.
-    FLOW_SHARED_OBJECT_KEEP: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_show_port_info,
-        None,
-    )
-    #: Device supports multicast address filtering.
-    MCAST_FILTERING: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_mcast_filtering,
-        None,
-    )
-    #: Device supports flow ctrl.
-    FLOW_CTRL: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_flow_ctrl, None)
-    #: Device is running on a physical function.
-    PHYSICAL_FUNCTION: TestPmdShellNicCapability = (
-        TestPmdShell.get_capabilities_physical_function,
-        None,
-    )
-
-    def __call__(
-        self,
-        testpmd_shell: TestPmdShell,
-        supported_capabilities: MutableSet[Self],
-        unsupported_capabilities: MutableSet[Self],
-    ) -> None:
-        """Execute the associated capability retrieval function.
-
-        Args:
-            testpmd_shell: :class:`TestPmdShell` object to which the function will be bound to.
-            supported_capabilities: The dictionary storing the supported capabilities
-                of a given test run.
-            unsupported_capabilities: The dictionary storing the unsupported capabilities
-                of a given test run.
-        """
-        self.value(testpmd_shell, supported_capabilities, unsupported_capabilities)
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index 87be7e6b93..f67cff94dc 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -26,9 +26,9 @@
     .. code:: python

         from framework.test_suite import TestSuite, func_test
-        from framework.testbed_model.capability import TopologyType, requires
+        from framework.testbed_model.capability import LinkTopology, requires
         # The whole test suite (each test case within) doesn't require any links.
-        @requires(topology_type=TopologyType.no_link)
+        @requires_link_topology(LinkTopology.NO_LINK)
         @func_test
         class TestHelloWorld(TestSuite):
             def hello_world_single_core(self):
@@ -41,7 +41,7 @@ def hello_world_single_core(self):
         class TestPmdBufferScatter(TestSuite):
             # only the test case requires the SCATTERED_RX_ENABLED capability
             # other test cases may not require it
-            @requires(NicCapability.SCATTERED_RX_ENABLED)
+            @requires_nic_capability(NicCapability.SCATTERED_RX_ENABLED)
             @func_test
             def test_scatter_mbuf_2048(self):
 """
@@ -50,27 +50,38 @@ def test_scatter_mbuf_2048(self):
 from abc import ABC, abstractmethod
 from collections.abc import MutableSet
 from dataclasses import dataclass
-from typing import TYPE_CHECKING, Any, Callable, ClassVar, Protocol
+from typing import (
+    TYPE_CHECKING,
+    Any,
+    Callable,
+    ClassVar,
+    Concatenate,
+    ParamSpec,
+    Protocol,
+    TypeAlias,
+)

 from typing_extensions import Self

+from api.capabilities import LinkTopology, NicCapability
 from framework.exception import ConfigurationError, InternalError, SkippedTestException
 from framework.logger import get_dts_logger
-from framework.remote_session.testpmd_shell import (
-    NicCapability,
-    TestPmdShell,
-    TestPmdShellCapabilityMethod,
-    TestPmdShellDecorator,
-    TestPmdShellMethod,
-)
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import DriverKind
-
-from .topology import Topology, TopologyType
+from framework.testbed_model.topology import Topology

 if TYPE_CHECKING:
+    from api.testpmd import TestPmd
     from framework.test_suite import TestCase

+P = ParamSpec("P")
+TestPmdMethod = Callable[Concatenate["TestPmd", P], Any]
+TestPmdCapabilityMethod: TypeAlias = Callable[
+    ["TestPmd", MutableSet["NicCapability"], MutableSet["NicCapability"]], None
+]
+TestPmdDecorator: TypeAlias = Callable[[TestPmdMethod], TestPmdMethod]
+TestPmdNicCapability = tuple[TestPmdCapabilityMethod, TestPmdDecorator | None]
+

 class Capability(ABC):
     """The base class for various capabilities.
@@ -150,10 +161,21 @@ def get_supported_capabilities(cls, node: Node, topology: "Topology") -> set[Sel
     def __hash__(self) -> int:
         """The subclasses must be hashable so that they can be stored in sets."""

+    def is_comparable_with(self, other: Any) -> bool:
+        """Check if the other object is of the same type for comparison.
+
+        Args:
+            other: The object to compare with.
+
+        Returns:
+            True if the other object is of the same type, False otherwise.
+        """
+        return isinstance(other, type(self))
+

 @dataclass
 class DecoratedNicCapability(Capability):
-    """A wrapper around :class:`~framework.remote_session.testpmd_shell.NicCapability`.
+    """A wrapper around :class:`~api.testpmd.NicCapability`.

     New instances should be created with the :meth:`create_unique` class method to ensure
     there are no duplicate instances.
@@ -166,10 +188,84 @@ class DecoratedNicCapability(Capability):
     """

     nic_capability: NicCapability
-    capability_fn: TestPmdShellCapabilityMethod
-    capability_decorator: TestPmdShellDecorator | None
+    capability_fn: TestPmdCapabilityMethod
+    capability_decorator: TestPmdDecorator | None
     _unique_capabilities: ClassVar[dict[NicCapability, Self]] = {}

+    @classmethod
+    def _get_nic_capability_check(cls) -> list[TestPmdNicCapability]:
+        """A mapping between capability names and the associated :class:`TestPmd` methods.
+
+        The :class:`TestPmd` capability checking method executes the command that checks
+        whether the capability is supported.
+        A decorator may optionally be added to the method that will add and remove configuration
+        that's necessary to retrieve the capability support status.
+        The Enum members may be assigned the method itself or a tuple of
+        (capability_checking_method, decorator_function).
+
+        The signature of each :class:`TestPmd` capability checking method must be::
+
+            fn(self, supported_capabilities: MutableSet, unsupported_capabilities: MutableSet)
+
+        The capability checking method must get whether a capability is supported or not
+        from a testpmd command. If multiple capabilities can be obtained from a testpmd command,
+        each should be obtained in the method. These capabilities should then
+        be added to `supported_capabilities` or `unsupported_capabilities` based on their support.
+
+        The two dictionaries are shared across all capability discovery function calls in a given
+        test run so that we don't call the same function multiple times. For example, when we find
+        :attr:`SCATTERED_RX_ENABLED` in :meth:`TestPmd.get_capabilities_rxq_info`,
+        we don't go looking for it again if a different test case also needs it.
+        """
+        from api.testpmd import TestPmd, _add_remove_mtu
+
+        # In order to guard against creating new NicCapability enum members without adding
+        # the evaluation code below we use a case statement that will trigger the linter
+        # enforcing that all cases are handled.
+        def mapping(cap: NicCapability) -> TestPmdNicCapability:
+            match cap:
+                case NicCapability.SCATTERED_RX_ENABLED:
+                    return (TestPmd.get_capabilities_rxq_info, _add_remove_mtu(9000))
+                case (
+                    NicCapability.RX_OFFLOAD_VLAN_STRIP
+                    | NicCapability.RX_OFFLOAD_IPV4_CKSUM
+                    | NicCapability.RX_OFFLOAD_UDP_CKSUM
+                    | NicCapability.RX_OFFLOAD_TCP_CKSUM
+                    | NicCapability.RX_OFFLOAD_TCP_LRO
+                    | NicCapability.RX_OFFLOAD_QINQ_STRIP
+                    | NicCapability.RX_OFFLOAD_OUTER_IPV4_CKSUM
+                    | NicCapability.RX_OFFLOAD_MACSEC_STRIP
+                    | NicCapability.RX_OFFLOAD_VLAN_FILTER
+                    | NicCapability.RX_OFFLOAD_VLAN_EXTEND
+                    | NicCapability.RX_OFFLOAD_SCATTER
+                    | NicCapability.RX_OFFLOAD_TIMESTAMP
+                    | NicCapability.RX_OFFLOAD_SECURITY
+                    | NicCapability.RX_OFFLOAD_KEEP_CRC
+                    | NicCapability.RX_OFFLOAD_SCTP_CKSUM
+                    | NicCapability.RX_OFFLOAD_OUTER_UDP_CKSUM
+                    | NicCapability.RX_OFFLOAD_RSS_HASH
+                    | NicCapability.RX_OFFLOAD_BUFFER_SPLIT
+                    | NicCapability.RX_OFFLOAD_CHECKSUM
+                    | NicCapability.RX_OFFLOAD_VLAN
+                ):
+                    return (TestPmd.get_capabilities_rx_offload, None)
+                case (
+                    NicCapability.RUNTIME_RX_QUEUE_SETUP
+                    | NicCapability.RUNTIME_TX_QUEUE_SETUP
+                    | NicCapability.RXQ_SHARE
+                    | NicCapability.FLOW_RULE_KEEP
+                    | NicCapability.FLOW_SHARED_OBJECT_KEEP
+                ):
+                    return (TestPmd.get_capabilities_show_port_info, None)
+                case NicCapability.MCAST_FILTERING:
+                    return (TestPmd.get_capabilities_mcast_filtering, None)
+                case NicCapability.FLOW_CTRL:
+                    return (TestPmd.get_capabilities_flow_ctrl, None)
+                case NicCapability.PHYSICAL_FUNCTION:
+                    return (TestPmd.get_capabilities_physical_function, None)
+
+        return [mapping(cap) for cap in NicCapability]
+
     @classmethod
     def get_unique(cls, nic_capability: NicCapability) -> Self:
         """Get the capability uniquely identified by `nic_capability`.
@@ -188,7 +284,7 @@ def get_unique(cls, nic_capability: NicCapability) -> Self:
         Returns:
             The capability uniquely identified by `nic_capability`.
         """
-        capability_fn, decorator_fn = nic_capability.value
+        capability_fn, decorator_fn = cls._get_nic_capability_check()[nic_capability.value]

         if nic_capability not in cls._unique_capabilities:
             cls._unique_capabilities[nic_capability] = cls(
@@ -207,9 +303,11 @@ def get_supported_capabilities(
         Each capability is first checked whether it's supported/unsupported
         before executing its `capability_fn` so that each capability is retrieved only once.
         """
+        from api.testpmd import TestPmd
+
         supported_conditional_capabilities: set["DecoratedNicCapability"] = set()
         logger = get_dts_logger(f"{node.name}.{cls.__name__}")
-        if topology.type is topology.type.no_link:
+        if topology.type is topology.type.NO_LINK:
             logger.debug(
                 "No links available in the current topology, not getting NIC capabilities."
             )
@@ -219,7 +317,7 @@ def get_supported_capabilities(
         )
         if cls.capabilities_to_check:
             capabilities_to_check_map = cls._get_decorated_capabilities_map()
-            with TestPmdShell() as testpmd_shell:
+            with TestPmd() as testpmd:
                 for (
                     conditional_capability_fn,
                     capabilities,
@@ -231,7 +329,7 @@ def get_supported_capabilities(
                     )
                     if conditional_capability_fn:
                         capability_fn = conditional_capability_fn(capability_fn)
-                    capability_fn(testpmd_shell)
+                    capability_fn(testpmd)
                     for capability in capabilities:
                         if capability.nic_capability in supported_capabilities:
                             supported_conditional_capabilities.add(capability)
@@ -242,8 +340,8 @@ def get_supported_capabilities(
     @classmethod
     def _get_decorated_capabilities_map(
         cls,
-    ) -> dict[TestPmdShellDecorator | None, set["DecoratedNicCapability"]]:
-        capabilities_map: dict[TestPmdShellDecorator | None, set["DecoratedNicCapability"]] = {}
+    ) -> dict[TestPmdDecorator | None, set["DecoratedNicCapability"]]:
+        capabilities_map: dict[TestPmdDecorator | None, set["DecoratedNicCapability"]] = {}
         for capability in cls.capabilities_to_check:
             if capability.capability_decorator not in capabilities_map:
                 capabilities_map[capability.capability_decorator] = set()
@@ -257,12 +355,12 @@ def _reduce_capabilities(
         capabilities: set["DecoratedNicCapability"],
         supported_capabilities: MutableSet,
         unsupported_capabilities: MutableSet,
-    ) -> TestPmdShellMethod:
-        def reduced_fn(testpmd_shell: TestPmdShell) -> None:
+    ) -> TestPmdMethod:
+        def reduced_fn(testpmd: "TestPmd") -> None:
             for capability in capabilities:
                 if capability not in supported_capabilities | unsupported_capabilities:
                     capability.capability_fn(
-                        testpmd_shell, supported_capabilities, unsupported_capabilities
+                        testpmd, supported_capabilities, unsupported_capabilities
                     )

         return reduced_fn
@@ -278,11 +376,11 @@ def __repr__(self) -> str:

 @dataclass
 class TopologyCapability(Capability):
-    """A wrapper around :class:`~.topology.TopologyType`.
+    """A wrapper around :class:`~.topology.LinkTopology`.

     Each test case must be assigned a topology. It could be done explicitly;
-    the implicit default is given by :meth:`~.topology.TopologyType.default`, which this class
-    returns :attr:`~.topology.TopologyType.two_links`.
+    the implicit default is given by :meth:`~.topology.LinkTopology.default`, which this class
+    returns :attr:`~.topology.LinkTopology.TWO_LINKS`.

     Test case topology may be set by setting the topology for the whole suite.
     The priority in which topology is set is as follows:
@@ -301,7 +399,7 @@ class TopologyCapability(Capability):
         topology_type: The topology type that defines each instance.
     """

-    topology_type: TopologyType
+    topology_type: LinkTopology

     _unique_capabilities: ClassVar[dict[str, Self]] = {}

@@ -310,7 +408,7 @@ def _preprocess_required(self, test_case_or_suite: type["TestProtocol"]) -> None
         test_case_or_suite.topology_type = self

     @classmethod
-    def get_unique(cls, topology_type: TopologyType) -> Self:
+    def get_unique(cls, topology_type: LinkTopology) -> Self:
         """Get the capability uniquely identified by `topology_type`.

         This is a factory method that implements a quasi-enum pattern.
@@ -338,7 +436,7 @@ def get_supported_capabilities(
         """Overrides :meth:`~Capability.get_supported_capabilities`."""
         supported_capabilities = set()
         topology_capability = cls.get_unique(topology.type)
-        for topology_type in TopologyType:
+        for topology_type in LinkTopology:
             candidate_topology_type = cls.get_unique(topology_type)
             if candidate_topology_type <= topology_capability:
                 supported_capabilities.add(candidate_topology_type)
@@ -351,17 +449,17 @@ def set_required(self, test_case_or_suite: type["TestProtocol"]) -> None:
         This means we have to modify test case topologies when processing the test suite topologies.
         At that point, the test case topologies have been set by the :func:`requires` decorator.
         The test suite topology only affects the test case topologies
-        if not :attr:`~.topology.TopologyType.default`.
+        if not :attr:`~.topology.LinkTopology.default`.

         Raises:
             ConfigurationError: If the topology type requested by the test case is more complex than
                 the test suite's.
         """
         if inspect.isclass(test_case_or_suite):
-            if self.topology_type is not TopologyType.default():
+            if self.topology_type is not LinkTopology.default():
                 self.add_to_required(test_case_or_suite)
                 for test_case in test_case_or_suite.get_test_cases():
-                    if test_case.topology_type.topology_type is TopologyType.default():
+                    if test_case.topology_type.topology_type is LinkTopology.default():
                         # test case topology has not been set, use the one set by the test suite
                         self.add_to_required(test_case)
                     elif test_case.topology_type > test_case_or_suite.topology_type:
@@ -383,6 +481,8 @@ def __eq__(self, other: Any) -> bool:
         Returns:
             :data:`True` if the topology types are the same.
         """
+        if not self.is_comparable_with(other):
+            return False
         return self.topology_type == other.topology_type

     def __lt__(self, other: Any) -> bool:
@@ -394,6 +494,8 @@ def __lt__(self, other: Any) -> bool:
         Returns:
             :data:`True` if the instance's topology type is less complex than the compared object's.
         """
+        if not self.is_comparable_with(other):
+            return False
         return self.topology_type < other.topology_type

     def __gt__(self, other: Any) -> bool:
@@ -440,7 +542,7 @@ class TestProtocol(Protocol):
     #: The reason for skipping the test case or suite.
     skip_reason: ClassVar[str] = ""
     #: The topology type of the test case or suite.
-    topology_type: ClassVar[TopologyCapability] = TopologyCapability(TopologyType.default())
+    topology_type: ClassVar[TopologyCapability] = TopologyCapability(LinkTopology.default())
     #: The capabilities the test case or suite requires in order to be executed.
     required_capabilities: ClassVar[set[Capability]] = set()
     #: The SUT ports topology configuration of the test case or suite.
@@ -481,7 +583,7 @@ def _decorator(func: type[TestProtocol]) -> type[TestProtocol]:

 def requires(
     *nic_capabilities: NicCapability,
-    topology_type: TopologyType = TopologyType.default(),
+    topology_type: LinkTopology = LinkTopology.default(),
 ) -> Callable[[type[TestProtocol]], type[TestProtocol]]:
     """A decorator that adds the required capabilities to a test case or test suite.

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 604245d855..1f11c3e740 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -22,7 +22,7 @@
     InternalError,
     RemoteCommandExecutionError,
 )
-from framework.testbed_model.os_session import PortInfo
+from framework.testbed_model.port import PortInfo
 from framework.utils import expand_range

 from .cpu import LogicalCore
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index b182c3bde4..b41bb42205 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -31,13 +31,8 @@

 from framework.config.node import NodeConfiguration
 from framework.logger import DTSLogger
-from framework.remote_session import (
-    InteractiveRemoteSession,
-    RemoteSession,
-    create_interactive_session,
-    create_remote_session,
-)
-from framework.remote_session.remote_session import CommandResult
+from framework.remote_session.interactive_remote_session import InteractiveRemoteSession
+from framework.remote_session.remote_session import CommandResult, RemoteSession
 from framework.settings import SETTINGS
 from framework.utils import MesonArgs, TarCompressionFormat

@@ -129,8 +124,8 @@ def __init__(
         self._config = node_config
         self.name = name
         self._logger = logger
-        self.remote_session = create_remote_session(node_config, name, logger)
-        self.interactive_session = create_interactive_session(node_config, logger)
+        self.remote_session = RemoteSession(node_config, name, logger)
+        self.interactive_session = InteractiveRemoteSession(node_config, logger)

     def is_alive(self) -> bool:
         """Check whether the underlying remote session is still responding."""
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index 9fc056b330..957c30a5b3 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -11,33 +11,17 @@
 from collections import defaultdict
 from collections.abc import Iterator
 from dataclasses import dataclass
-from enum import Enum
 from typing import NamedTuple

 from typing_extensions import Self

+from api.capabilities import LinkTopology
 from framework.exception import ConfigurationError, InternalError
 from framework.testbed_model.node import Node, NodeIdentifier

 from .port import DriverKind, Port, PortConfig


-class TopologyType(int, Enum):
-    """Supported topology types."""
-
-    #: A topology with no Traffic Generator.
-    no_link = 0
-    #: A topology with one physical link between the SUT node and the TG node.
-    one_link = 1
-    #: A topology with two physical links between the Sut node and the TG node.
-    two_links = 2
-
-    @classmethod
-    def default(cls) -> "TopologyType":
-        """The default topology required by test cases if not specified otherwise."""
-        return cls.two_links
-
-
 class PortLink(NamedTuple):
     """The physical, cabled connection between the ports."""

@@ -67,7 +51,7 @@ class Topology:
         tg_ports: The TG ports.
     """

-    type: TopologyType
+    type: LinkTopology
     sut_ports: list[Port]
     tg_ports: list[Port]
     pf_ports: list[Port]
@@ -83,15 +67,15 @@ def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
         Raises:
             ConfigurationError: If an unsupported link topology is supplied.
         """
-        type = TopologyType.no_link
+        type = LinkTopology.NO_LINK

         if port_link := next(port_links, None):
-            type = TopologyType.one_link
+            type = LinkTopology.ONE_LINK
             sut_ports = [port_link.sut_port]
             tg_ports = [port_link.tg_port]

             if port_link := next(port_links, None):
-                type = TopologyType.two_links
+                type = LinkTopology.TWO_LINKS
                 sut_ports.append(port_link.sut_port)
                 tg_ports.append(port_link.tg_port)

@@ -264,9 +248,9 @@ def sut_port_ingress(self) -> Port:
     @property
     def sut_port_egress(self) -> Port:
         """The egress port of the SUT node."""
-        return self.sut_ports[1 if self.type is TopologyType.two_links else 0]
+        return self.sut_ports[1 if self.type is LinkTopology.TWO_LINKS else 0]

     @property
     def tg_port_ingress(self) -> Port:
         """The ingress port of the TG node."""
-        return self.tg_ports[1 if self.type is TopologyType.two_links else 0]
+        return self.tg_ports[1 if self.type is LinkTopology.TWO_LINKS else 0]
--
2.39.5

