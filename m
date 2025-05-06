Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F10C3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E2940269;
	Tue,  6 May 2025 15:18:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5854840150
 for <dev@dpdk.org>; Tue,  6 May 2025 15:18:26 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC5F51007;
 Tue,  6 May 2025 06:18:15 -0700 (PDT)
Received: from localhost.localdomain (JR4XG4HTQC.cambridge.arm.com
 [10.1.25.44])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC4263F5A1;
 Tue,  6 May 2025 06:18:24 -0700 (PDT)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH] dts: improve port handling
Date: Tue,  6 May 2025 14:16:05 +0100
Message-ID: <20250506131657.1576152-1-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
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

Improve the way ports are handled by taking a lazy approach. Provide an
interface to select the drivers by using the "dpdk" and "kernel"
keywords. Centralise the handling of ports in Topology. Bind only driver
to ports as needed, avoiding redundant bindings. Improve resilience by
not relying on the pre-bound driver prior to a DTS run, and always rely
on the configured kernel driver. Finally provide a new decorator to
allow test suites or cases to choose which ports from the configured
topology to dedicate to DPDK.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
---
Hi there,

sending some more framework improvements.

Luca
---
 dts/framework/remote_session/dpdk.py          |  49 ++------
 dts/framework/remote_session/dpdk_shell.py    |   2 +-
 dts/framework/test_run.py                     |  18 ++-
 dts/framework/test_suite.py                   |   1 +
 dts/framework/testbed_model/capability.py     |  28 ++++-
 dts/framework/testbed_model/linux_session.py  |  53 ++++++--
 dts/framework/testbed_model/os_session.py     |  15 ++-
 dts/framework/testbed_model/port.py           |  90 +++++++++++--
 dts/framework/testbed_model/topology.py       | 118 +++++++++++++++++-
 .../testbed_model/traffic_generator/scapy.py  |  14 ++-
 .../traffic_generator/traffic_generator.py    |   6 +-
 dts/tests/TestSuite_smoke_tests.py            |   8 +-
 12 files changed, 321 insertions(+), 81 deletions(-)

diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 401e3a7277..804f4b1eee 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -29,9 +29,9 @@
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
 from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
+from framework.testbed_model.linux_session import LinuxSession
 from framework.testbed_model.node import Node
 from framework.testbed_model.os_session import OSSession
-from framework.testbed_model.port import Port
 from framework.testbed_model.virtual_device import VirtualDevice
 from framework.utils import MesonArgs, TarCompressionFormat
 
@@ -415,16 +415,14 @@ def __init__(
         self._ports_bound_to_dpdk = False
         self._kill_session = None
 
-    def setup(self, ports: Iterable[Port]):
+    def setup(self):
         """Set up the DPDK runtime on the target node."""
         if self.build:
             self.build.setup()
         self._prepare_devbind_script()
-        self.bind_ports_to_driver(ports)
 
-    def teardown(self, ports: Iterable[Port]) -> None:
+    def teardown(self) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
-        self.bind_ports_to_driver(ports, for_dpdk=False)
         if self.build:
             self.build.teardown()
 
@@ -448,37 +446,23 @@ def run_dpdk_app(
             f"{app_path} {eal_params}", timeout, privileged=True, verify=True
         )
 
-    def bind_ports_to_driver(self, ports: Iterable[Port], for_dpdk: bool = True) -> None:
-        """Bind all ports on the SUT to a driver.
-
-        Args:
-            ports: The ports to act on.
-            for_dpdk: If :data:`True`, binds ports to os_driver_for_dpdk.
-                If :data:`False`, binds to os_driver.
-        """
-        for port in ports:
-            if port.bound_for_dpdk == for_dpdk:
-                continue
-
-            driver = port.config.os_driver_for_dpdk if for_dpdk else port.config.os_driver
-            self._node.main_session.send_command(
-                f"{self.devbind_script_path} -b {driver} --force {port.pci}",
-                privileged=True,
-                verify=True,
-            )
-            port.bound_for_dpdk = for_dpdk
-
     def _prepare_devbind_script(self) -> None:
         """Prepare the devbind script.
 
         If the environment has a build associated with it, then use the script within that build's
         tree. Otherwise, copy the script from the local repository.
 
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+
         Raises:
             InternalError: If dpdk-devbind.py could not be found.
         """
+        if not isinstance(self._node.main_session, LinuxSession):
+            return
+
         if self.build:
-            self.devbind_script_path = self._node.main_session.join_remote_path(
+            devbind_script_path = self._node.main_session.join_remote_path(
                 self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
             )
         else:
@@ -486,20 +470,13 @@ def _prepare_devbind_script(self) -> None:
             if not local_script_path.exists():
                 raise InternalError("Could not find dpdk-devbind.py locally.")
 
-            self.devbind_script_path = self._node.main_session.join_remote_path(
+            devbind_script_path = self._node.main_session.join_remote_path(
                 self._node.tmp_dir, local_script_path.name
             )
 
-            self._node.main_session.copy_to(local_script_path, self.devbind_script_path)
-
-    @cached_property
-    def devbind_script_path(self) -> PurePath:
-        """The path to the dpdk-devbind.py script on the node.
+            self._node.main_session.copy_to(local_script_path, devbind_script_path)
 
-        Raises:
-            InternalError: If accessed before environment setup.
-        """
-        raise InternalError("Accessed devbind script path before setup.")
+        self._node.main_session.devbind_script_path = devbind_script_path
 
     def filter_lcores(
         self,
diff --git a/dts/framework/remote_session/dpdk_shell.py b/dts/framework/remote_session/dpdk_shell.py
index 2d4f91052d..d4aa02f39b 100644
--- a/dts/framework/remote_session/dpdk_shell.py
+++ b/dts/framework/remote_session/dpdk_shell.py
@@ -46,7 +46,7 @@ def compute_eal_params(
     params.prefix = prefix
 
     if params.allowed_ports is None:
-        params.allowed_ports = ctx.topology.sut_ports
+        params.allowed_ports = ctx.topology.sut_dpdk_ports
 
     return params
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 0fdc57ea9c..cff0085317 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -344,8 +344,9 @@ def next(self) -> State | None:
 
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
-        test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
-        test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports, test_run.ctx.topology.tg_port_ingress)
+        test_run.ctx.topology.setup()
+        test_run.ctx.dpdk.setup()
+        test_run.ctx.tg.setup(test_run.ctx.topology)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
         self.result.sut_info = test_run.ctx.sut_node.node_info
@@ -431,8 +432,9 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Next state."""
         self.test_run.ctx.shell_pool.terminate_current_pool()
-        self.test_run.ctx.tg.teardown(self.test_run.ctx.topology.tg_ports)
-        self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_ports)
+        self.test_run.ctx.tg.teardown()
+        self.test_run.ctx.dpdk.teardown()
+        self.test_run.ctx.topology.teardown()
         self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
         self.result.update_teardown(Result.PASS)
@@ -475,6 +477,9 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Next state."""
         self.test_run.ctx.shell_pool.start_new_pool()
+        sut_ports_drivers = self.test_suite.sut_ports_drivers or "dpdk"
+        self.test_run.ctx.topology.configure_ports("sut", sut_ports_drivers)
+
         self.test_suite.set_up_suite()
         self.result.update_setup(Result.PASS)
         return TestSuiteExecution(self.test_run, self.test_suite, self.result)
@@ -598,6 +603,11 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Next state."""
         self.test_run.ctx.shell_pool.start_new_pool()
+        sut_ports_drivers = (
+            self.test_case.sut_ports_drivers or self.test_suite.sut_ports_drivers or "dpdk"
+        )
+        self.test_run.ctx.topology.configure_ports("sut", sut_ports_drivers)
+
         self.test_suite.set_up_test_case()
         self.result.update_setup(Result.PASS)
         return TestCaseExecution(
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e07c327b77..e5fbadd1a1 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -598,6 +598,7 @@ def _decorator(func: TestSuiteMethodType) -> type[TestCase]:
             test_case.topology_type = cls.topology_type
             test_case.topology_type.add_to_required(test_case)
             test_case.test_type = test_case_type
+            test_case.sut_ports_drivers = cls.sut_ports_drivers
             return test_case
 
         return _decorator
diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
index ea0e647a47..f895b22bb3 100644
--- a/dts/framework/testbed_model/capability.py
+++ b/dts/framework/testbed_model/capability.py
@@ -54,7 +54,7 @@ def test_scatter_mbuf_2048(self):
 
 from typing_extensions import Self
 
-from framework.exception import ConfigurationError, SkippedTestException
+from framework.exception import ConfigurationError, InternalError, SkippedTestException
 from framework.logger import get_dts_logger
 from framework.remote_session.testpmd_shell import (
     NicCapability,
@@ -64,6 +64,7 @@ def test_scatter_mbuf_2048(self):
     TestPmdShellMethod,
 )
 from framework.testbed_model.node import Node
+from framework.testbed_model.port import DriverKind
 
 from .topology import Topology, TopologyType
 
@@ -442,6 +443,8 @@ class TestProtocol(Protocol):
     topology_type: ClassVar[TopologyCapability] = TopologyCapability(TopologyType.default())
     #: The capabilities the test case or suite requires in order to be executed.
     required_capabilities: ClassVar[set[Capability]] = set()
+    #: The SUT ports topology configuration of the test case or suite.
+    sut_ports_drivers: ClassVar[DriverKind | tuple[DriverKind, ...] | None] = None
 
     @classmethod
     def get_test_cases(cls) -> list[type["TestCase"]]:
@@ -453,6 +456,29 @@ def get_test_cases(cls) -> list[type["TestCase"]]:
         raise NotImplementedError()
 
 
+def configure_ports(
+    *drivers: DriverKind, all_for: DriverKind | None = None
+) -> Callable[[type[TestProtocol]], type[TestProtocol]]:
+    """Decorator for test suite and test cases to configure ports drivers.
+
+    Configure all the SUT ports for the specified driver kind with `all_for`. Otherwise, specify
+    the port's respective driver kind in the positional argument. The amount of ports specified must
+    adhere to the requested topology.
+
+    Raises:
+        InternalError: If both positional arguments and `all_for` are set.
+    """
+    if len(drivers) and all_for is not None:
+        msg = "Cannot set both positional arguments and `all_for` to configure ports drivers."
+        raise InternalError(msg)
+
+    def _decorator(func: type[TestProtocol]) -> type[TestProtocol]:
+        func.sut_ports_drivers = all_for or drivers
+        return func
+
+    return _decorator
+
+
 def requires(
     *nic_capabilities: NicCapability,
     topology_type: TopologyType = TopologyType.default(),
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 6c6a4b608d..e01c2dd712 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -12,11 +12,13 @@
 import json
 from collections.abc import Iterable
 from functools import cached_property
+from pathlib import PurePath
 from typing import TypedDict
 
 from typing_extensions import NotRequired
 
-from framework.exception import ConfigurationError, RemoteCommandExecutionError
+from framework.exception import ConfigurationError, InternalError, RemoteCommandExecutionError
+from framework.testbed_model.os_session import PortInfo
 from framework.utils import expand_range
 
 from .cpu import LogicalCore
@@ -27,6 +29,8 @@
 class LshwConfigurationOutput(TypedDict):
     """The relevant parts of ``lshw``'s ``configuration`` section."""
 
+    #:
+    driver: str
     #:
     link: str
 
@@ -152,30 +156,40 @@ def _configure_huge_pages(self, number_of: int, size: int, force_first_numa: boo
 
         self.send_command(f"echo {number_of} | tee {hugepage_config_path}", privileged=True)
 
-    def get_port_info(self, pci_address: str) -> tuple[str, str]:
+    def get_port_info(self, pci_address: str) -> PortInfo:
         """Overrides :meth:`~.os_session.OSSession.get_port_info`.
 
         Raises:
             ConfigurationError: If the port could not be found.
         """
-        self._logger.debug(f"Gathering info for port {pci_address}.")
-
         bus_info = f"pci@{pci_address}"
         port = next(port for port in self._lshw_net_info if port.get("businfo") == bus_info)
         if port is None:
             raise ConfigurationError(f"Port {pci_address} could not be found on the node.")
 
-        logical_name = port.get("logicalname") or ""
-        if not logical_name:
-            self._logger.warning(f"Port {pci_address} does not have a valid logical name.")
-            # raise ConfigurationError(f"Port {pci_address} does not have a valid logical name.")
+        logical_name = port.get("logicalname", "")
+        mac_address = port.get("serial", "")
+
+        configuration = port.get("configuration", {})
+        driver = configuration.get("driver", "")
+        is_link_up = configuration.get("link", "down") == "up"
+
+        return PortInfo(mac_address, logical_name, driver, is_link_up)
+
+    def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
 
-        mac_address = port.get("serial") or ""
-        if not mac_address:
-            self._logger.warning(f"Port {pci_address} does not have a valid mac address.")
-            # raise ConfigurationError(f"Port {pci_address} does not have a valid mac address.")
+        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        """
+        ports_pci_addrs = " ".join(port.pci for port in ports)
+
+        self.send_command(
+            f"{self.devbind_script_path} -b {driver_name} --force {ports_pci_addrs}",
+            privileged=True,
+            verify=True,
+        )
 
-        return logical_name, mac_address
+        del self._lshw_net_info
 
     def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
@@ -184,6 +198,19 @@ def bring_up_link(self, ports: Iterable[Port]) -> None:
                 f"ip link set dev {port.logical_name} up", privileged=True, verify=True
             )
 
+        del self._lshw_net_info
+
+    @cached_property
+    def devbind_script_path(self) -> PurePath:
+        """The path to the dpdk-devbind.py script on the node.
+
+        Needs to be manually assigned first in order to be used.
+
+        Raises:
+            InternalError: If accessed before environment setup.
+        """
+        raise InternalError("Accessed devbind script path before setup.")
+
     @cached_property
     def _lshw_net_info(self) -> list[LshwOutput]:
         output = self.send_command("lshw -quiet -json -C network", verify=True)
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 354c607357..a245d5b60e 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -41,7 +41,7 @@
 from framework.utils import MesonArgs, TarCompressionFormat
 
 from .cpu import Architecture, LogicalCore
-from .port import Port
+from .port import Port, PortInfo
 
 
 @dataclass(slots=True, frozen=True)
@@ -528,16 +528,25 @@ def get_arch_info(self) -> str:
         """
 
     @abstractmethod
-    def get_port_info(self, pci_address: str) -> tuple[str, str]:
+    def get_port_info(self, pci_address: str) -> PortInfo:
         """Get port information.
 
         Returns:
-            A tuple containing the logical name and MAC address respectively.
+            An instance of :class:`PortInfo`.
 
         Raises:
             ConfigurationError: If the port could not be found.
         """
 
+    @abstractmethod
+    def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
+        """Bind `ports` to the given `driver_name`.
+
+        Args:
+            ports: The list of the ports to bind to the driver.
+            driver_name: The name of the driver to bind the ports to.
+        """
+
     @abstractmethod
     def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Send operating system specific command for bringing up link on node interfaces.
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index f638120eeb..fc58e2b993 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -9,13 +9,33 @@
 drivers and address.
 """
 
-from typing import TYPE_CHECKING, Any, Final
+from functools import cached_property
+from typing import TYPE_CHECKING, Any, Final, Literal, NamedTuple
 
 from framework.config.node import PortConfig
+from framework.exception import InternalError
 
 if TYPE_CHECKING:
     from .node import Node
 
+DriverKind = Literal["kernel", "dpdk"]
+"""The driver kind."""
+
+
+class PortInfo(NamedTuple):
+    """Port information.
+
+    Attributes:
+        mac_address: The MAC address of the port.
+        logical_name: The logical name of the port.
+        driver: The name of the port's driver.
+    """
+
+    mac_address: str
+    logical_name: str
+    driver: str
+    is_link_up: bool
+
 
 class Port:
     """Physical port on a node.
@@ -23,16 +43,11 @@ class Port:
     Attributes:
         node: The port's node.
         config: The port's configuration.
-        mac_address: The MAC address of the port.
-        logical_name: The logical name of the port.
-        bound_for_dpdk: :data:`True` if the port is bound to the driver for DPDK.
     """
 
     node: Final["Node"]
     config: Final[PortConfig]
-    mac_address: Final[str]
-    logical_name: Final[str]
-    bound_for_dpdk: bool
+    _original_driver: str | None
 
     def __init__(self, node: "Node", config: PortConfig):
         """Initialize the port from `node` and `config`.
@@ -43,8 +58,22 @@ def __init__(self, node: "Node", config: PortConfig):
         """
         self.node = node
         self.config = config
-        self.logical_name, self.mac_address = node.main_session.get_port_info(config.pci)
-        self.bound_for_dpdk = False
+        self._original_driver = None
+
+    def driver_by_kind(self, kind: DriverKind) -> str:
+        """Retrieve the driver name by kind.
+
+        Raises:
+            InternalError: If the given `kind` is invalid.
+        """
+        match kind:
+            case "dpdk":
+                return self.config.os_driver_for_dpdk
+            case "kernel":
+                return self.config.os_driver
+            case _:
+                msg = f"Invalid driver kind `{kind}` given."
+                raise InternalError(msg)
 
     @property
     def name(self) -> str:
@@ -56,6 +85,49 @@ def pci(self) -> str:
         """The PCI address of the port."""
         return self.config.pci
 
+    @property
+    def info(self) -> PortInfo:
+        """The port's current system information.
+
+        When this is accessed for the first time, the port's original driver is stored.
+        """
+        info = self.node.main_session.get_port_info(self.pci)
+
+        if self._original_driver is None:
+            self._original_driver = info.driver
+
+        return info
+
+    @cached_property
+    def mac_address(self) -> str:
+        """The MAC address of the port."""
+        return self.info.mac_address
+
+    @cached_property
+    def logical_name(self) -> str:
+        """The logical name of the port."""
+        return self.info.logical_name
+
+    @property
+    def is_link_up(self) -> bool:
+        """Is the port link up?"""
+        return self.info.is_link_up
+
+    @property
+    def current_driver(self) -> str:
+        """The current driver of the port."""
+        return self.info.driver
+
+    @property
+    def original_driver(self) -> str | None:
+        """The original driver of the port prior to DTS startup."""
+        return self._original_driver
+
+    @property
+    def bound_for_dpdk(self) -> bool:
+        """Is the port bound to the driver for DPDK?"""
+        return self.current_driver == self.config.os_driver_for_dpdk
+
     def configure_mtu(self, mtu: int):
         """Configure the port's MTU value.
 
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index cf5c2c28ba..fb45969136 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -8,16 +8,18 @@
 The link information then implies what type of topology is available.
 """
 
+from collections import defaultdict
 from collections.abc import Iterator
 from dataclasses import dataclass
 from enum import Enum
-from typing import NamedTuple
+from typing import Literal, NamedTuple
 
 from typing_extensions import Self
 
-from framework.exception import ConfigurationError
+from framework.exception import ConfigurationError, InternalError
+from framework.testbed_model.node import Node
 
-from .port import Port
+from .port import DriverKind, Port
 
 
 class TopologyType(int, Enum):
@@ -45,6 +47,10 @@ class PortLink(NamedTuple):
     tg_port: Port
 
 
+NodeIdentifier = Literal["sut", "tg"]
+"""The node identifier."""
+
+
 @dataclass(frozen=True)
 class Topology:
     """Testbed topology.
@@ -97,6 +103,112 @@ def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
 
         return cls(type, sut_ports, tg_ports)
 
+    def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node, list[Port]]:
+        """Retrieve node and its ports for the current topology.
+
+        Raises:
+            InternalError: If the given `node_identifier` is invalid.
+        """
+        from framework.context import get_ctx
+
+        ctx = get_ctx()
+        match node_identifier:
+            case "sut":
+                return ctx.sut_node, self.sut_ports
+            case "tg":
+                return ctx.tg_node, self.tg_ports
+            case _:
+                msg = f"Invalid node `{node_identifier}` given."
+                raise InternalError(msg)
+
+    def setup(self) -> None:
+        """Setup topology ports.
+
+        Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
+        """
+        self._setup_ports("sut")
+        self._setup_ports("tg")
+
+    def teardown(self) -> None:
+        """Teardown topology ports.
+
+        Restores all the ports to their original drivers before the test run.
+        """
+        self._restore_ports_original_drivers("sut")
+        self._restore_ports_original_drivers("tg")
+
+    def _restore_ports_original_drivers(self, node_identifier: NodeIdentifier) -> None:
+        node, ports = self.node_and_ports_from_id(node_identifier)
+        driver_to_ports: dict[str, list[Port]] = defaultdict(list)
+
+        for port in ports:
+            if port.original_driver is not None and port.original_driver != port.current_driver:
+                driver_to_ports[port.original_driver].append(port)
+
+        for driver_name, ports in driver_to_ports.items():
+            node.main_session.bind_ports_to_driver(ports, driver_name)
+
+    def _setup_ports(self, node_identifier: NodeIdentifier) -> None:
+        node, ports = self.node_and_ports_from_id(node_identifier)
+
+        self._bind_ports_to_drivers(node, ports, "kernel")
+
+        for port in ports:
+            if not (port.mac_address and port.logical_name):
+                raise ConfigurationError(
+                    "Could not gather a valid MAC address and/or logical name "
+                    f"for port {port.name} in node {node.name}."
+                )
+
+    def configure_ports(
+        self, node_identifier: NodeIdentifier, drivers: DriverKind | tuple[DriverKind, ...]
+    ) -> None:
+        """Configure the ports for the requested node as specified in `drivers`.
+
+        Compares the current topology driver setup with the requested one and binds drivers only if
+        needed. Moreover, it brings up the ports when using their kernel drivers.
+
+        Args:
+            node_identifier: The identifier of the node to gather the ports from.
+            drivers: The driver kind(s) to bind. If a tuple is provided, each element corresponds to
+                the driver for the respective port by index. Otherwise, if a driver kind is
+                specified directly, this is applied to all the ports in the node.
+
+        Raises:
+            InternalError: If the number of given driver kinds is greater than the number of
+                available topology ports.
+        """
+        node, ports = self.node_and_ports_from_id(node_identifier)
+
+        if isinstance(drivers, tuple) and len(drivers) > len(ports):
+            msg = "Too many ports have been specified."
+            raise InternalError(msg)
+
+        self._bind_ports_to_drivers(node, ports, drivers)
+
+        ports_to_bring_up = [p for p in ports if not (p.bound_for_dpdk or p.is_link_up)]
+        if ports_to_bring_up:
+            node.main_session.bring_up_link(ports_to_bring_up)
+
+    def _bind_ports_to_drivers(
+        self, node: Node, ports: list[Port], drivers: DriverKind | tuple[DriverKind, ...]
+    ) -> None:
+        driver_to_ports: dict[str, list[Port]] = defaultdict(list)
+
+        for port_id, port in enumerate(ports):
+            driver_kind = drivers[port_id] if isinstance(drivers, tuple) else drivers
+            desired_driver = port.driver_by_kind(driver_kind)
+            if port.current_driver != desired_driver:
+                driver_to_ports[desired_driver].append(port)
+
+        for driver_name, ports in driver_to_ports.items():
+            node.main_session.bind_ports_to_driver(ports, driver_name)
+
+    @property
+    def sut_dpdk_ports(self) -> list[Port]:
+        """The DPDK ports for the SUT node."""
+        return [port for port in self.sut_ports if port.bound_for_dpdk]
+
     @property
     def tg_port_egress(self) -> Port:
         """The egress port of the TG node."""
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index aed0b76108..0d89098d0a 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -13,7 +13,7 @@
 implement the methods for handling packets by sending commands into the interactive shell.
 """
 
-from collections.abc import Callable, Iterable
+from collections.abc import Callable
 from queue import Empty, SimpleQueue
 from threading import Event, Thread
 from typing import ClassVar
@@ -31,6 +31,7 @@
 from framework.remote_session.python_shell import PythonShell
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
+from framework.testbed_model.topology import Topology
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
@@ -314,15 +315,16 @@ def __init__(self, tg_node: Node, config: ScapyTrafficGeneratorConfig, **kwargs)
 
         super().__init__(tg_node=tg_node, config=config, **kwargs)
 
-    def setup(self, ports: Iterable[Port], rx_port: Port):
+    def setup(self, topology: Topology):
         """Extends :meth:`.traffic_generator.TrafficGenerator.setup`.
 
-        Brings up the port links and starts up the async sniffer.
+        Binds the TG node ports to the kernel drivers and starts up the async sniffer.
         """
-        super().setup(ports, rx_port)
-        self._tg_node.main_session.bring_up_link(ports)
+        topology.configure_ports("tg", "kernel")
 
-        self._sniffer = ScapyAsyncSniffer(self._tg_node, rx_port, self._sniffer_name)
+        self._sniffer = ScapyAsyncSniffer(
+            self._tg_node, topology.tg_port_ingress, self._sniffer_name
+        )
         self._sniffer.start_application()
 
         self._shell = PythonShell(self._tg_node, "scapy", privileged=True)
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index 6b9705d025..8f53b07daf 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -9,7 +9,6 @@
 """
 
 from abc import ABC, abstractmethod
-from typing import Iterable
 
 from scapy.packet import Packet
 
@@ -17,6 +16,7 @@
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
 from framework.testbed_model.port import Port
+from framework.testbed_model.topology import Topology
 from framework.utils import get_packet_summaries
 
 
@@ -49,10 +49,10 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs):
         self._tg_node = tg_node
         self._logger = get_dts_logger(f"{self._tg_node.name} {self._config.type}")
 
-    def setup(self, ports: Iterable[Port], rx_port: Port):
+    def setup(self, topology: Topology):
         """Setup the traffic generator."""
 
-    def teardown(self, ports: Iterable[Port]):
+    def teardown(self):
         """Teardown the traffic generator."""
         self.close()
 
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke_tests.py
index 72901e59d5..5602b316c0 100644
--- a/dts/tests/TestSuite_smoke_tests.py
+++ b/dts/tests/TestSuite_smoke_tests.py
@@ -19,6 +19,7 @@
 from framework.settings import SETTINGS
 from framework.test_suite import TestSuite, func_test
 from framework.testbed_model.capability import TopologyType, requires
+from framework.testbed_model.linux_session import LinuxSession
 from framework.utils import REGEX_FOR_PCI_ADDRESS
 
 
@@ -117,13 +118,16 @@ def test_device_bound_to_driver(self) -> None:
         """Device driver in OS.
 
         Test that the devices configured in the test run configuration are bound to
-        the proper driver.
+        the proper driver. This test case runs on Linux only.
 
         Test:
             List all devices with the ``dpdk-devbind.py`` script and verify that
             the configured devices are bound to the proper driver.
         """
-        path_to_devbind = self._ctx.dpdk.devbind_script_path
+        if not isinstance(self._ctx.sut_node.main_session, LinuxSession):
+            return
+
+        path_to_devbind = self._ctx.sut_node.main_session.devbind_script_path
 
         all_nics_in_dpdk_devbind = self.sut_node.main_session.send_command(
             f"{path_to_devbind} --status | awk '/{REGEX_FOR_PCI_ADDRESS}/'",
-- 
2.43.0

