Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D5C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:23:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14B04064C;
	Wed,  2 Jul 2025 18:23:36 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id D3C524028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:23:34 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-7d45f5fde50so272892985a.2
 for <dev@dpdk.org>; Wed, 02 Jul 2025 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751473414; x=1752078214; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A80khuen6WgxiZ4T2B/DI+8PNqdF9VsL7JYhad8byDc=;
 b=aJVOebvhCStHiKmzsmi0tJynVU/d6IRZNGq1j2/Xe1EPwMGCbYZTbmh5gifZJZYaMk
 9xe6goikCwVec+bPbxiM3YhQhQ8srLNLMDSAHFqRS3RZtz8PKJ9T4JtE6XUzTEan8UNo
 a7DSvr+reIKlB4yeV0Uv1ffUu7WZz+BU4NLSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751473414; x=1752078214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A80khuen6WgxiZ4T2B/DI+8PNqdF9VsL7JYhad8byDc=;
 b=Cgm8gkfwJKwzoTA527wvFgnQUTAnVAnJ00IWmOchK156rsxZlkUTnmyE5tgWTGKerp
 DaRO8h4isV3jt8qnlp+Lqv/jniA2GbB1gnfoQfUnZndr446TttwopAL8fEN1JV5gxgz6
 ekBTcBvvqHh+gOvsbTF1VJI0vLpYMN/hSmQqdHFdH6AOiZ+QGEkjnq51i9zYRi5mlX8p
 DH8FuIdTQrmNF9G/Boecv4KzvgZBO/ZOreMeVfAIA6kkQ1ffXJofVYBy0UQzx4r7ubza
 lNodBR8FVEvx/5LJ20hVBZ2qFshL0O4vJ91K/sDn4b9MvX/nBT8U+KdhYWe1FOzAVb0q
 +FTg==
X-Gm-Message-State: AOJu0YwhuvFK8MlS8MYoJwrDqtO0iTXlsW3dEUomuDR8C7tzc+g/9Zwm
 4y9K9IG13V9+6LONqb9Z7zJn/3xaNURkENx6cQWws5EWh60U5VAV0B4+7fS+eYGBcyo=
X-Gm-Gg: ASbGncvD7XKGPdwCxnufrbdfllbEb+jP1qF2c5hWmRJHpzFAWUwUSo6wER83XvpFCQY
 4Hd4Fj7nvyXok4ovm4nxXtlvSOfdtpS52wrP34crNrQhp8kohtuQaDIkOvP+F6LL5CIOX25TiUn
 UpIZ6nYgXD6GYpze8MDCIzgYEN0oBcBhcdjfyaQ43YDIBErMp3adV5rveA1afa/nZZlQrfQvB82
 QjU+CsDvHIlmMhvh4M0aVfG3KIi4wnsC3lgE2jLMEnF7OoS4C8eM9rbhIHk59Az7PyYMRqzY1ZL
 AOOn5ubu7TxyJAk5BPWfNybHgvuquDHtyUrh6fP16ev8Cj91z//4vt8wCFJG5khmJt8jVykReFX
 43q7Xlas=
X-Google-Smtp-Source: AGHT+IFRg8r/o411moZMCzqVEWI1dmJKK71p5Nr/+SmYkNLwRuqLQqHWCPiIlmxl48f709F8e924DQ==
X-Received: by 2002:a05:620a:44d4:b0:7d3:f17d:10c8 with SMTP id
 af79cd13be357-7d5c472c5c9mr474713485a.43.1751473413743; 
 Wed, 02 Jul 2025 09:23:33 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316585dsm966947785a.28.2025.07.02.09.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 09:23:33 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 1/4] dts: add virtual functions to framework
Date: Wed,  2 Jul 2025 12:23:28 -0400
Message-ID: <20250702162331.352313-1-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626152755.197560-3-dmarx@iol.unh.edu>
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
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
 dts/framework/testbed_model/topology.py      | 53 +++++++++++++++++++-
 5 files changed, 154 insertions(+), 3 deletions(-)

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
index fd49a7dc74..ee919e30d9 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -346,6 +346,10 @@ def next(self) -> State | None:
         test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
+
+        if test_run.config.virtual_functions_testrun:
+            test_run.ctx.topology.instantiate_vf_ports()
+
         test_run.ctx.topology.configure_ports("sut", "dpdk")
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
index fb45969136..2bc69d46a9 100644
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
@@ -160,6 +162,53 @@ def _setup_ports(self, node_identifier: NodeIdentifier) -> None:
                     f"for port {port.name} in node {node.name}."
                 )
 
+    def instantiate_vf_ports(self) -> None:
+        """Create, setup, and add virtual functions to the list of ports on the SUT node.
+
+        Raises:
+            InternalError: If virtual function creation fails.
+        """
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
+            if addr_list == []:
+                raise InternalError(f"Failed to create virtual function on port {port.pci}")
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
+        for port in self.pf_ports:
+            ctx.sut_node.main_session.send_command(
+                f"ip link set dev {port.logical_name} up", privileged=True
+            )
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

