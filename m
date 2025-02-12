Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43089C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:46:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70AD542DD9;
	Wed, 12 Feb 2025 17:46:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 656CE42DD0
 for <dev@dpdk.org>; Wed, 12 Feb 2025 17:46:10 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0B3312FC;
 Wed, 12 Feb 2025 08:46:30 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.11.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9EAD3F5A1;
 Wed, 12 Feb 2025 08:46:08 -0800 (PST)
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: dev@dpdk.org
Cc: Nicholas Pratte <npratte@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v2 4/7] dts: improve Port model
Date: Wed, 12 Feb 2025 16:45:57 +0000
Message-ID: <20250212164600.23759-5-luca.vizzarro@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212164600.23759-1-luca.vizzarro@arm.com>
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250212164600.23759-1-luca.vizzarro@arm.com>
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

Make Port models standalone, so that they can be directly manipulated by
the test suites as needed. Moreover, let them handle themselves and
retrieve the logical name and mac address in autonomy.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 47 +++++++++-------
 dts/framework/testbed_model/node.py          | 25 ++++-----
 dts/framework/testbed_model/os_session.py    | 16 +++---
 dts/framework/testbed_model/port.py          | 57 ++++++++++++--------
 dts/framework/testbed_model/sut_node.py      | 48 +++++++++--------
 dts/framework/testbed_model/tg_node.py       | 24 +++++++--
 6 files changed, 127 insertions(+), 90 deletions(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 99c29b9b1e..7c2b110c99 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -10,6 +10,8 @@
 """
 
 import json
+from collections.abc import Iterable
+from functools import cached_property
 from typing import TypedDict
 
 from typing_extensions import NotRequired
@@ -149,31 +151,40 @@ def _configure_huge_pages(self, number_of: int, size: int, force_first_numa: boo
 
         self.send_command(f"echo {number_of} | tee {hugepage_config_path}", privileged=True)
 
-    def update_ports(self, ports: list[Port]) -> None:
-        """Overrides :meth:`~.os_session.OSSession.update_ports`."""
-        self._logger.debug("Gathering port info.")
-        for port in ports:
-            assert port.node == self.name, "Attempted to gather port info on the wrong node"
+    def get_port_info(self, pci_address: str) -> tuple[str, str]:
+        """Overrides :meth:`~.os_session.OSSession.get_port_info`.
 
-        port_info_list = self._get_lshw_info()
-        for port in ports:
-            for port_info in port_info_list:
-                if f"pci@{port.pci}" == port_info.get("businfo"):
-                    self._update_port_attr(port, port_info.get("logicalname"), "logical_name")
-                    self._update_port_attr(port, port_info.get("serial"), "mac_address")
-                    port_info_list.remove(port_info)
-                    break
-            else:
-                self._logger.warning(f"No port at pci address {port.pci} found.")
-
-    def bring_up_link(self, ports: list[Port]) -> None:
+        Raises:
+            ConfigurationError: If the port could not be found.
+        """
+        self._logger.debug(f"Gathering info for port {pci_address}.")
+
+        bus_info = f"pci@{pci_address}"
+        port = next(port for port in self._lshw_net_info if port.get("businfo") == bus_info)
+        if port is None:
+            raise ConfigurationError(f"Port {pci_address} could not be found on the node.")
+
+        logical_name = port.get("logicalname") or ""
+        if not logical_name:
+            self._logger.warning(f"Port {pci_address} does not have a valid logical name.")
+            # raise ConfigurationError(f"Port {pci_address} does not have a valid logical name.")
+
+        mac_address = port.get("serial") or ""
+        if not mac_address:
+            self._logger.warning(f"Port {pci_address} does not have a valid mac address.")
+            # raise ConfigurationError(f"Port {pci_address} does not have a valid mac address.")
+
+        return logical_name, mac_address
+
+    def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
         for port in ports:
             self.send_command(
                 f"ip link set dev {port.logical_name} up", privileged=True, verify=True
             )
 
-    def _get_lshw_info(self) -> list[LshwOutput]:
+    @cached_property
+    def _lshw_net_info(self) -> list[LshwOutput]:
         output = self.send_command("lshw -quiet -json -C network", verify=True)
         return json.loads(output.stdout)
 
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index 0acd746073..1a4c825ed2 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -14,16 +14,14 @@
 """
 
 from abc import ABC
+from collections.abc import Iterable
 from functools import cached_property
 
 from framework.config.node import (
     OS,
     NodeConfiguration,
 )
-from framework.config.test_run import (
-    DPDKBuildConfiguration,
-    TestRunConfiguration,
-)
+from framework.config.test_run import TestRunConfiguration
 from framework.exception import ConfigurationError
 from framework.logger import DTSLogger, get_dts_logger
 
@@ -81,22 +79,14 @@ def __init__(self, node_config: NodeConfiguration):
         self._logger.info(f"Connected to node: {self.name}")
         self._get_remote_cpus()
         self._other_sessions = []
-        self._init_ports()
-
-    def _init_ports(self) -> None:
-        self.ports = [Port(self.name, port_config) for port_config in self.config.ports]
-        self.main_session.update_ports(self.ports)
+        self.ports = [Port(self, port_config) for port_config in self.config.ports]
 
     @cached_property
     def ports_by_name(self) -> dict[str, Port]:
         """Ports mapped by the name assigned at configuration."""
         return {port.name: port for port in self.ports}
 
-    def set_up_test_run(
-        self,
-        test_run_config: TestRunConfiguration,
-        dpdk_build_config: DPDKBuildConfiguration,
-    ) -> None:
+    def set_up_test_run(self, test_run_config: TestRunConfiguration, ports: Iterable[Port]) -> None:
         """Test run setup steps.
 
         Configure hugepages on all DTS node types. Additional steps can be added by
@@ -105,15 +95,18 @@ def set_up_test_run(
         Args:
             test_run_config: A test run configuration according to which
                 the setup steps will be taken.
-            dpdk_build_config: The build configuration of DPDK.
+            ports: The ports to set up for the test run.
         """
         self._setup_hugepages()
 
-    def tear_down_test_run(self) -> None:
+    def tear_down_test_run(self, ports: Iterable[Port]) -> None:
         """Test run teardown steps.
 
         There are currently no common execution teardown steps common to all DTS node types.
         Additional steps can be added by extending the method in subclasses with the use of super().
+
+        Args:
+            ports: The ports to tear down for the test run.
         """
 
     def create_session(self, name: str) -> OSSession:
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index f3789fcf75..3c7b2a4f47 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -516,20 +516,18 @@ def get_arch_info(self) -> str:
         """
 
     @abstractmethod
-    def update_ports(self, ports: list[Port]) -> None:
-        """Get additional information about ports from the operating system and update them.
+    def get_port_info(self, pci_address: str) -> tuple[str, str]:
+        """Get port information.
 
-        The additional information is:
-
-            * Logical name (e.g. ``enp7s0``) if applicable,
-            * Mac address.
+        Returns:
+            A tuple containing the logical name and MAC address respectively.
 
-        Args:
-            ports: The ports to update.
+        Raises:
+            ConfigurationError: If the port could not be found.
         """
 
     @abstractmethod
-    def bring_up_link(self, ports: list[Port]) -> None:
+    def bring_up_link(self, ports: Iterable[Port]) -> None:
         """Send operating system specific command for bringing up link on node interfaces.
 
         Args:
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index 8014d4a100..f638120eeb 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -9,45 +9,42 @@
 drivers and address.
 """
 
-from dataclasses import dataclass
+from typing import TYPE_CHECKING, Any, Final
 
 from framework.config.node import PortConfig
 
+if TYPE_CHECKING:
+    from .node import Node
+
 
-@dataclass(slots=True)
 class Port:
     """Physical port on a node.
 
-    The ports are identified by the node they're on and their PCI addresses. The port on the other
-    side of the connection is also captured here.
-    Each port is serviced by a driver, which may be different for the operating system (`os_driver`)
-    and for DPDK (`os_driver_for_dpdk`). For some devices, they are the same, e.g.: ``mlx5_core``.
-
     Attributes:
+        node: The port's node.
         config: The port's configuration.
         mac_address: The MAC address of the port.
-        logical_name: The logical name of the port. Must be discovered.
+        logical_name: The logical name of the port.
+        bound_for_dpdk: :data:`True` if the port is bound to the driver for DPDK.
     """
 
-    _node: str
-    config: PortConfig
-    mac_address: str = ""
-    logical_name: str = ""
+    node: Final["Node"]
+    config: Final[PortConfig]
+    mac_address: Final[str]
+    logical_name: Final[str]
+    bound_for_dpdk: bool
 
-    def __init__(self, node_name: str, config: PortConfig):
-        """Initialize the port from `node_name` and `config`.
+    def __init__(self, node: "Node", config: PortConfig):
+        """Initialize the port from `node` and `config`.
 
         Args:
-            node_name: The name of the port's node.
+            node: The port's node.
             config: The test run configuration of the port.
         """
-        self._node = node_name
+        self.node = node
         self.config = config
-
-    @property
-    def node(self) -> str:
-        """The node where the port resides."""
-        return self._node
+        self.logical_name, self.mac_address = node.main_session.get_port_info(config.pci)
+        self.bound_for_dpdk = False
 
     @property
     def name(self) -> str:
@@ -58,3 +55,21 @@ def name(self) -> str:
     def pci(self) -> str:
         """The PCI address of the port."""
         return self.config.pci
+
+    def configure_mtu(self, mtu: int):
+        """Configure the port's MTU value.
+
+        Args:
+            mtu: Desired MTU value.
+        """
+        return self.node.main_session.configure_port_mtu(mtu, self)
+
+    def to_dict(self) -> dict[str, Any]:
+        """Convert to a dictionary."""
+        return {
+            "node_name": self.node.name,
+            "name": self.name,
+            "pci": self.pci,
+            "mac_address": self.mac_address,
+            "logical_name": self.logical_name,
+        }
diff --git a/dts/framework/testbed_model/sut_node.py b/dts/framework/testbed_model/sut_node.py
index 440b5a059b..9007d89b1c 100644
--- a/dts/framework/testbed_model/sut_node.py
+++ b/dts/framework/testbed_model/sut_node.py
@@ -13,6 +13,7 @@
 
 import os
 import time
+from collections.abc import Iterable
 from dataclasses import dataclass
 from pathlib import Path, PurePath
 
@@ -33,6 +34,7 @@
 from framework.exception import ConfigurationError, RemoteFileNotFoundError
 from framework.params.eal import EalParams
 from framework.remote_session.remote_session import CommandResult
+from framework.testbed_model.port import Port
 from framework.utils import MesonArgs, TarCompressionFormat
 
 from .cpu import LogicalCore, LogicalCoreList
@@ -86,7 +88,6 @@ class SutNode(Node):
     _node_info: OSSessionInfo | None
     _compiler_version: str | None
     _path_to_devbind_script: PurePath | None
-    _ports_bound_to_dpdk: bool
 
     def __init__(self, node_config: SutNodeConfiguration):
         """Extend the constructor with SUT node specifics.
@@ -196,11 +197,7 @@ def get_dpdk_build_info(self) -> DPDKBuildInfo:
         """
         return DPDKBuildInfo(dpdk_version=self.dpdk_version, compiler_version=self.compiler_version)
 
-    def set_up_test_run(
-        self,
-        test_run_config: TestRunConfiguration,
-        dpdk_build_config: DPDKBuildConfiguration,
-    ) -> None:
+    def set_up_test_run(self, test_run_config: TestRunConfiguration, ports: Iterable[Port]) -> None:
         """Extend the test run setup with vdev config and DPDK build set up.
 
         This method extends the setup process by configuring virtual devices and preparing the DPDK
@@ -209,22 +206,25 @@ def set_up_test_run(
         Args:
             test_run_config: A test run configuration according to which
                 the setup steps will be taken.
-            dpdk_build_config: The build configuration of DPDK.
+            ports: The ports to set up for the test run.
         """
-        super().set_up_test_run(test_run_config, dpdk_build_config)
+        super().set_up_test_run(test_run_config, ports)
         for vdev in test_run_config.vdevs:
             self.virtual_devices.append(VirtualDevice(vdev))
-        self._set_up_dpdk(dpdk_build_config)
+        self._set_up_dpdk(test_run_config.dpdk_config, ports)
+
+    def tear_down_test_run(self, ports: Iterable[Port]) -> None:
+        """Extend the test run teardown with virtual device teardown and DPDK teardown.
 
-    def tear_down_test_run(self) -> None:
-        """Extend the test run teardown with virtual device teardown and DPDK teardown."""
-        super().tear_down_test_run()
+        Args:
+            ports: The ports to tear down for the test run.
+        """
+        super().tear_down_test_run(ports)
         self.virtual_devices = []
-        self._tear_down_dpdk()
+        self._tear_down_dpdk(ports)
 
     def _set_up_dpdk(
-        self,
-        dpdk_build_config: DPDKBuildConfiguration,
+        self, dpdk_build_config: DPDKBuildConfiguration, ports: Iterable[Port]
     ) -> None:
         """Set up DPDK the SUT node and bind ports.
 
@@ -234,6 +234,7 @@ def _set_up_dpdk(
 
         Args:
             dpdk_build_config: A DPDK build configuration to test.
+            ports: The ports to use for DPDK.
         """
         match dpdk_build_config.dpdk_location:
             case RemoteDPDKTreeLocation(dpdk_tree=dpdk_tree):
@@ -254,16 +255,16 @@ def _set_up_dpdk(
                 self._configure_dpdk_build(build_options)
                 self._build_dpdk()
 
-        self.bind_ports_to_driver()
+        self.bind_ports_to_driver(ports)
 
-    def _tear_down_dpdk(self) -> None:
+    def _tear_down_dpdk(self, ports: Iterable[Port]) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
         self._env_vars = {}
         self.__remote_dpdk_tree_path = None
         self._remote_dpdk_build_dir = None
         self._dpdk_version = None
         self.compiler_version = None
-        self.bind_ports_to_driver(for_dpdk=False)
+        self.bind_ports_to_driver(ports, for_dpdk=False)
 
     def _set_remote_dpdk_tree_path(self, dpdk_tree: PurePath):
         """Set the path to the remote DPDK source tree based on the provided DPDK location.
@@ -504,21 +505,22 @@ def run_dpdk_app(
             f"{app_path} {eal_params}", timeout, privileged=True, verify=True
         )
 
-    def bind_ports_to_driver(self, for_dpdk: bool = True) -> None:
+    def bind_ports_to_driver(self, ports: Iterable[Port], for_dpdk: bool = True) -> None:
         """Bind all ports on the SUT to a driver.
 
         Args:
+            ports: The ports to act on.
             for_dpdk: If :data:`True`, binds ports to os_driver_for_dpdk.
                 If :data:`False`, binds to os_driver.
         """
-        if self._ports_bound_to_dpdk == for_dpdk:
-            return
+        for port in ports:
+            if port.bound_for_dpdk == for_dpdk:
+                continue
 
-        for port in self.ports:
             driver = port.config.os_driver_for_dpdk if for_dpdk else port.config.os_driver
             self.main_session.send_command(
                 f"{self.path_to_devbind_script} -b {driver} --force {port.pci}",
                 privileged=True,
                 verify=True,
             )
-        self._ports_bound_to_dpdk = for_dpdk
+            port.bound_for_dpdk = for_dpdk
diff --git a/dts/framework/testbed_model/tg_node.py b/dts/framework/testbed_model/tg_node.py
index 8ab9ccb438..595836a664 100644
--- a/dts/framework/testbed_model/tg_node.py
+++ b/dts/framework/testbed_model/tg_node.py
@@ -9,9 +9,12 @@
 A TG node is where the TG runs.
 """
 
+from collections.abc import Iterable
+
 from scapy.packet import Packet
 
 from framework.config.node import TGNodeConfiguration
+from framework.config.test_run import TestRunConfiguration
 from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
     PacketFilteringConfig,
 )
@@ -51,9 +54,24 @@ def __init__(self, node_config: TGNodeConfiguration):
         self.traffic_generator = create_traffic_generator(self, node_config.traffic_generator)
         self._logger.info(f"Created node: {self.name}")
 
-    def _init_ports(self) -> None:
-        super()._init_ports()
-        self.main_session.bring_up_link(self.ports)
+    def set_up_test_run(self, test_run_config: TestRunConfiguration, ports: Iterable[Port]) -> None:
+        """Extend the test run setup with the setup of the traffic generator.
+
+        Args:
+            test_run_config: A test run configuration according to which
+                the setup steps will be taken.
+            ports: The ports to set up for the test run.
+        """
+        super().set_up_test_run(test_run_config, ports)
+        self.main_session.bring_up_link(ports)
+
+    def tear_down_test_run(self, ports: Iterable[Port]) -> None:
+        """Extend the test run teardown with the teardown of the traffic generator.
+
+        Args:
+            ports: The ports to tear down for the test run.
+        """
+        super().tear_down_test_run(ports)
 
     def send_packets_and_capture(
         self,
-- 
2.43.0

