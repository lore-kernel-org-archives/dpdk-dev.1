Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CC6C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 20:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A789A40EA5;
	Tue, 17 Jun 2025 22:14:02 +0200 (CEST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3F8CA40E44
 for <dev@dpdk.org>; Tue, 17 Jun 2025 22:14:01 +0200 (CEST)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4a44e94f0b0so74764531cf.1
 for <dev@dpdk.org>; Tue, 17 Jun 2025 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750191240; x=1750796040; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tRCubSKgATxu/SQhrGMMDjZKzpl/idy+bKrGODqsQ40=;
 b=GXo+Hrgf6ltJRN5HXh2hyLL0pVGvPU57YyYMAxIOYykcxF7u7n/sC7eeQkb45PaEvw
 dFmrO/K5JDeBZfibs3Jcwd1YbzRgbI9QgcUbHsW+wRvY1ZNxsPy650Pyi5XAVNhzhmew
 iFg2o+EHfBPe9+A8xqURDb5bv8AEWCDc3p6go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750191240; x=1750796040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tRCubSKgATxu/SQhrGMMDjZKzpl/idy+bKrGODqsQ40=;
 b=wPNbq5InvKovMC/qOgtYnZYzbWDWrKPKmX8Azg8FivHsYv/vL7malCJOfsxBdCJDdE
 iGlMIyv33Ydwlt0wBN/36hgWL90s2fDAkCkcRjTARXQP4Oim+XXWnMj9ZFEnqAxk3Mqh
 WycpAIHNwe1pjOxot8yrpahVp9TB5S5ze7JQoh8/UX6d/oV9WaBziYw9JvKXiAondhsN
 qnm3qXTDRJ37NuTKco8ONXpMZbbG2t7VC2ZT3mUJDwVXUOkMgtZN19IbJRaS/GSxMLig
 0svpeJdseaTskI7tJ/Nyn4AYwsZOaXASqt8AJAjXuLuqfP+HNwd4vv+d216825be6ENJ
 SuGg==
X-Gm-Message-State: AOJu0YzzfJ3C9nUJ2kq12jVuD97HBfveVX7Tq+Jz11lP6ODpC/bvhuzF
 aZGb/NrYKXFXLk1P+HKHwaUtbEIx93vRlLFtzGrplw4LFI/qhursMDIyGiS0VMPBI9I=
X-Gm-Gg: ASbGncvERXkvm1UNzhuRjJ2YfJg7lDtky91O77m40ySHgf+ainrY9e4/u1pLLlh9bOo
 tjxDD4uTgRDp1tvnHvg948dZSAOP3SKYixrlsMRGYUIHdEFGcZLDmUa1MHhakWRULzqn+bbfxzZ
 Kol5ipFlDt+k6EnrbkqtUS8tXlB29qDdDXTpI6BzMR84wQLKR1uDoIeoJni86KMD4Xq/M2LqGAR
 oS4ZyeYf4IqSiNot12k+OtLjiRkWdXuu7gp+iZafImLZCA8rbfb9aznBz3hW18mDImalLEQdsNW
 DsMT7cOnAbuCLB92suIihJfqs2MTYL8P5UcDqgBa3D8cSKfM3sN1Mo8KEOTGIF4KN9Qrk8FQlc0
 57JdeR2I=
X-Google-Smtp-Source: AGHT+IEmlcm+X+Jn/2p3n4b4y8zNPbw330ndFTXwdqjMUItJKV64T2tbRYiMuNFEDDTy85TlmHLQqg==
X-Received: by 2002:ac8:7f11:0:b0:4a4:2c75:aa5a with SMTP id
 d75a77b69052e-4a73c5fff34mr252898811cf.30.1750191240393; 
 Tue, 17 Jun 2025 13:14:00 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a2e94fesm65168291cf.24.2025.06.17.13.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 13:14:00 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v1] dts: add virtual functions to framework
Date: Tue, 17 Jun 2025 16:13:58 -0400
Message-ID: <20250617201358.708638-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
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

Add virtual functions to DTS framework, along with
a field for specifying VF test runs in the config file.

Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/config/test_run.py             |  2 +
 dts/framework/test_run.py                    |  7 +++
 dts/framework/testbed_model/linux_session.py | 53 +++++++++++++++++++-
 dts/framework/testbed_model/os_session.py    | 42 ++++++++++++++++
 dts/framework/testbed_model/topology.py      | 42 +++++++++++++++-
 5 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index b6e4099eeb..eefa32c3cb 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -467,6 +467,8 @@ class TestRunConfiguration(FrozenModel):
     perf: bool
     #: Whether to run functional tests.
     func: bool
+    #: Whether to run the testing with virtual functions instead of physical functions
+    virtual_functions_testrun: bool
     #: Whether to skip smoke tests.
     skip_smoke_tests: bool = False
     #: The names of test suites and/or test cases to execute.
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 60a9ec8148..5163881aef 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -346,6 +346,10 @@ def next(self) -> State | None:
         test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
+
+        if self.test_run.config.virtual_functions_testrun:
+            self.test_run.ctx.topology.instantiate_vf_ports()
+
         self.test_run.ctx.topology.configure_ports("sut", "dpdk")
         test_run.ctx.tg.setup(test_run.ctx.topology)
 
@@ -432,6 +436,9 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
+        if self.test_run.config.virtual_functions_testrun:
+            self.test_run.ctx.topology.delete_vf_ports()
+
         self.test_run.ctx.shell_pool.terminate_current_pool()
         self.test_run.ctx.tg.teardown()
         self.test_run.ctx.topology.teardown()
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index e01c2dd712..604245d855 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -17,7 +17,11 @@
 
 from typing_extensions import NotRequired
 
-from framework.exception import ConfigurationError, InternalError, RemoteCommandExecutionError
+from framework.exception import (
+    ConfigurationError,
+    InternalError,
+    RemoteCommandExecutionError,
+)
 from framework.testbed_model.os_session import PortInfo
 from framework.utils import expand_range
 
@@ -211,11 +215,58 @@ def devbind_script_path(self) -> PurePath:
         """
         raise InternalError("Accessed devbind script path before setup.")
 
+    def create_vfs(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
+
+        Raises:
+            InternalError: If there are existing VFs which have to be deleted.
+        """
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(
+            self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
+        )
+        if 0 < curr_num_vfs:
+            raise InternalError("There are existing VFs on the port which must be deleted.")
+        if curr_num_vfs == 0:
+            self.send_command(f"echo 1 | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True)
+            self.refresh_lshw()
+
+    def delete_vfs(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_vfs`."""
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(
+            self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
+        )
+        if curr_num_vfs == 0:
+            self._logger.debug(f"No VFs found on port {pf_port.pci}, skipping deletion")
+        else:
+            self.send_command(f"echo 0 | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True)
+
+    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
+        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_vfs`."""
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
+        if curr_num_vfs > 0:
+            pci_addrs = self.send_command(
+                'awk -F "PCI_SLOT_NAME=" "/PCI_SLOT_NAME=/ {print \\$2}" '
+                + f"{sys_bus_path}/virtfn*/uevent",
+                privileged=True,
+            )
+            return pci_addrs.stdout.splitlines()
+        else:
+            return []
+
     @cached_property
     def _lshw_net_info(self) -> list[LshwOutput]:
         output = self.send_command("lshw -quiet -json -C network", verify=True)
         return json.loads(output.stdout)
 
+    def refresh_lshw(self) -> None:
+        """Force refresh of cached lshw network info."""
+        if "_lshw_net_info" in self.__dict__:
+            del self.__dict__["_lshw_net_info"]
+        _ = self._lshw_net_info
+
     def _update_port_attr(self, port: Port, attr_value: str | None, attr_name: str) -> None:
         if attr_value:
             setattr(port, attr_name, attr_value)
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index d7a09a0d5d..b6e03aa83d 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -603,3 +603,45 @@ def configure_port_mtu(self, mtu: int, port: Port) -> None:
             mtu: Desired MTU value.
             port: Port to set `mtu` on.
         """
+
+    @abstractmethod
+    def create_vfs(self, pf_port: Port) -> None:
+        """Creates virtual functions for `pf_port`.
+
+        Checks how many virtual functions (VFs) `pf_port` supports, and creates that
+        number of VFs on the port.
+
+        Args:
+            pf_port: The port to create virtual functions on.
+
+        Raises:
+            InternalError: If the number of VFs is greater than 0 but less than the
+            maximum for `pf_port`.
+        """
+
+    @abstractmethod
+    def delete_vfs(self, pf_port: Port) -> None:
+        """Deletes virtual functions for `pf_port`.
+
+        Checks how many virtual functions (VFs) `pf_port` supports, and deletes that
+        number of VFs on the port.
+
+        Args:
+            pf_port: The port to delete virtual functions on.
+
+        Raises:
+            InternalError: If the number of VFs is greater than 0 but less than the
+            maximum for `pf_port`.
+        """
+
+    @abstractmethod
+    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
+        """Find the PCI addresses of all virtual functions (VFs) on the port `pf_port`.
+
+        Args:
+            pf_port: The port to find the VFs on.
+
+        Returns:
+            A list containing all of the PCI addresses of the VFs on the port. If the port has no
+            VFs then the list will be empty.
+        """
diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
index fb45969136..ef4f97dbda 100644
--- a/dts/framework/testbed_model/topology.py
+++ b/dts/framework/testbed_model/topology.py
@@ -19,7 +19,7 @@
 from framework.exception import ConfigurationError, InternalError
 from framework.testbed_model.node import Node
 
-from .port import DriverKind, Port
+from .port import DriverKind, Port, PortConfig
 
 
 class TopologyType(int, Enum):
@@ -74,6 +74,8 @@ class Topology:
     type: TopologyType
     sut_ports: list[Port]
     tg_ports: list[Port]
+    pf_ports: list[Port]
+    vf_ports: list[Port]
 
     @classmethod
     def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
@@ -101,7 +103,7 @@ def from_port_links(cls, port_links: Iterator[PortLink]) -> Self:
                     msg = "More than two links in a topology are not supported."
                     raise ConfigurationError(msg)
 
-        return cls(type, sut_ports, tg_ports)
+        return cls(type, sut_ports, tg_ports, [], [])
 
     def node_and_ports_from_id(self, node_identifier: NodeIdentifier) -> tuple[Node, list[Port]]:
         """Retrieve node and its ports for the current topology.
@@ -160,6 +162,42 @@ def _setup_ports(self, node_identifier: NodeIdentifier) -> None:
                     f"for port {port.name} in node {node.name}."
                 )
 
+    def instantiate_vf_ports(self) -> None:
+        """Create, setup, and add virtual functions to the list of ports on the SUT node."""
+        from framework.context import get_ctx
+
+        ctx = get_ctx()
+
+        for port in self.sut_ports:
+            self.pf_ports.append(port)
+
+        for port in self.pf_ports:
+            ctx.sut_node.main_session.create_vfs(port)
+            addr_list = ctx.sut_node.main_session.get_pci_addr_of_vfs(port)
+            for addr in addr_list:
+                vf_config = PortConfig(
+                    name=f"{port.name}-vf-{addr}",
+                    pci=addr,
+                    os_driver_for_dpdk=port.config.os_driver_for_dpdk,
+                    os_driver=port.config.os_driver,
+                )
+                self.vf_ports.append(Port(node=port.node, config=vf_config))
+            ctx.sut_node.main_session.send_command(f"ip link set {port.logical_name} vf 0 trust on")
+
+        self.sut_ports.clear()
+        self.sut_ports.extend(self.vf_ports)
+
+    def delete_vf_ports(self) -> None:
+        """Delete virtual functions from the SUT node during test run teardown."""
+        from framework.context import get_ctx
+
+        ctx = get_ctx()
+
+        for port in self.pf_ports:
+            ctx.sut_node.main_session.delete_vfs(port)
+        self.sut_ports.clear()
+        self.sut_ports.extend(self.pf_ports)
+
     def configure_ports(
         self, node_identifier: NodeIdentifier, drivers: DriverKind | tuple[DriverKind, ...]
     ) -> None:
-- 
2.49.0

