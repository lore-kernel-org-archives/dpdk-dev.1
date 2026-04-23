Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBA1FDEE45
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Apr 2026 19:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 760A5406B8;
	Thu, 23 Apr 2026 21:04:38 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5A0DC40669
 for <dev@dpdk.org>; Thu, 23 Apr 2026 21:04:34 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-506a747448dso51494781cf.0
 for <dev@dpdk.org>; Thu, 23 Apr 2026 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1776971074; x=1777575874; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwCpRj95noqLPrMq1G7aWs0UZXIjrpNqb74iKX2EuQE=;
 b=PcoJHH9+glN9kA9hr+QsXoEfOaZ/z+LFXRIpOFKXNzn6DrtwaucoQIvaE5xrW8QfKL
 7mBe/AyjClpone4tzK6RQh6DVK5m5zhLZZJUfzBZnx9YsvipK/g5l1RRr84ZLu7P6NzK
 t9bviigu5H1XpwWZPH5hVMs0u4oQzStkkg5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971074; x=1777575874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FwCpRj95noqLPrMq1G7aWs0UZXIjrpNqb74iKX2EuQE=;
 b=KImoT8aejVKZy/6KX8yfIWjc0P7IIqLAz5Xh4SNOMmgpz7tq60Np+oJeiC9l9ZvwBG
 qxPmTa+hBqv7oP1r0WsCsWTJ6kR6MOknnDK+X6fPsdpLGWnQ5Ah1Kd4HT4nug5UFxDJf
 oPzBG3zUJZe5+LalABhEbgXb+uOtdzhLr8kT6yrW+u879L5jbdpnhjE/v8++mMsnfwf5
 iF9Ob96U5LMp8hpX3OKuSdZOuvTnSL7+dm+/pMhNs03lkM7jlooYcs6RcNKWqdWoLqhg
 pAl7X/7QEdH53qOTY+lT+u7DqQbijuQmGRrFPoWNPCq+XnbSgANz3WJey1qIFVsDe4iU
 Ptgg==
X-Gm-Message-State: AOJu0Yxh6SafczSuXkd+50ocCXPhGEGTCPNP3V2KRAlZxAnwD6FpMY81
 6FAwe9n2yows4Kf8dHdJG/9lR/o5g0EryiAubsPPn9SNQKS4bAUdGKIRHa4k3u+JUAA=
X-Gm-Gg: AeBDieszXBnD1PoPvNvU3G/JHwB/wmlUzq1WGI8RmkCctgbHIOGugddFUWe3qqHzPhO
 fdEET6jHuMyEwNW+xHNBqQdtwE9AvAlms8Gkfqh9yvPlV0bwWZvEXVbxIqR5h8sO1piFCfNXUXF
 kEldkh8F5ydXRuvvGw2zlUHsz8w4Urt84VCm7dp3n754eyIKkvc4X69rorzJKLSaVopsMv3nzP+
 1nG7Wtj6SExjNvLBB7ZUhrrhy/3vHz/I2pvdkrVuZ4y7kA0L2v8P6w3LzWdIBI5z0P0s9pHUBjv
 mDn0nvOHeoN9ceBPy4VoeDQc2fXSzvn0E909YePlnGG4PKYDqGD286NDT3RYt2Ctejar87Gh1Xk
 f92NDUJQ2cQ/waw/brUCFGoCg50sMmCgExg2m6iqunrIwjNnHmxhgq3Xg56sJzmVFLUuyv0D9GF
 9I/sGunHNaj+UkO6SEd9byy4yFG9RAIWbw1s8Yo4SRwmRP5nI41Sfqz6rOLg4q7CVAuziSVHYz
X-Received: by 2002:a05:622a:98e:b0:50d:ec19:6d11 with SMTP id
 d75a77b69052e-50e36c7779emr437012501cf.43.1776971073141; 
 Thu, 23 Apr 2026 12:04:33 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fc9715610sm34624441cf.10.2026.04.23.12.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:04:32 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v2 7/7] dts: separate Linux session into interface and logic
Date: Thu, 23 Apr 2026 15:04:22 -0400
Message-ID: <20260423190424.41619-8-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423190424.41619-1-dmarx@iol.unh.edu>
References: <20260423170331.33193-1-dmarx@iol.unh.edu>
 <20260423190424.41619-1-dmarx@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

Separate Linux session into an interface for the API,
and a logical module in the framework.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 ...st => api.testbed_model.linux_session.rst} |   2 +-
 doc/api/dts/framework.linux_session.rst       |   8 +
 doc/api/dts/index.rst                         |   1 +
 dts/api/testbed_model/linux_session.py        | 366 +----------------
 dts/api/testbed_model/node.py                 |  11 +-
 dts/api/testbed_model/os_session.py           |  16 +
 dts/framework/linux_session.py                | 375 ++++++++++++++++++
 7 files changed, 424 insertions(+), 355 deletions(-)
 rename doc/api/dts/{framework.testbed_model.linux_session.rst => api.testbed_model.linux_session.rst} (74%)
 create mode 100644 doc/api/dts/framework.linux_session.rst
 create mode 100644 dts/framework/linux_session.py

diff --git a/doc/api/dts/framework.testbed_model.linux_session.rst b/doc/api/dts/api.testbed_model.linux_session.rst
similarity index 74%
rename from doc/api/dts/framework.testbed_model.linux_session.rst
rename to doc/api/dts/api.testbed_model.linux_session.rst
index 7567816199..cfe79d8bca 100644
--- a/doc/api/dts/framework.testbed_model.linux_session.rst
+++ b/doc/api/dts/api.testbed_model.linux_session.rst
@@ -3,6 +3,6 @@
 linux\_session - Linux Remote Session
 =====================================
 
-.. automodule:: framework.testbed_model.linux_session
+.. automodule:: api.testbed_model.linux_session
    :members:
    :show-inheritance:
diff --git a/doc/api/dts/framework.linux_session.rst b/doc/api/dts/framework.linux_session.rst
new file mode 100644
index 0000000000..5cb2d04db1
--- /dev/null
+++ b/doc/api/dts/framework.linux_session.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+linux\_session - Linux Remote Session
+=====================================
+
+.. automodule:: framework.linux_session
+   :members:
+   :show-inheritance:
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index e89e782ac0..0dbc18b75c 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -37,6 +37,7 @@ Modules
    framework.parser
    api.utils
    api.exception
+   framework.linux_session
 
 
 Indices and tables
diff --git a/dts/api/testbed_model/linux_session.py b/dts/api/testbed_model/linux_session.py
index 7307b2abe2..da3da4461c 100644
--- a/dts/api/testbed_model/linux_session.py
+++ b/dts/api/testbed_model/linux_session.py
@@ -2,366 +2,26 @@
 # Copyright(c) 2023 PANTHEON.tech s.r.o.
 # Copyright(c) 2023 University of New Hampshire
 
-"""Linux OS translator.
+"""Linux OS session interface.
 
-Translate OS-unaware calls into Linux calls/utilities. Most of Linux distributions are mostly
-compliant with POSIX standards, so this module only implements the parts that aren't.
-This intermediate module implements the common parts of mostly POSIX compliant distributions.
+Extends the base :class:`~.os_session.OSSession` with methods specific to Linux nodes.
+The concrete implementation containing all backend logic lives in the framework package.
 """
 
-import json
-import re
-from collections.abc import Iterable
-from functools import cached_property
-from pathlib import PurePath
-from typing import TypedDict
+from abc import ABC, abstractmethod
 
-from typing_extensions import NotRequired
 
-from api.exception import (
-    ConfigurationError,
-    InternalError,
-    RemoteCommandExecutionError,
-)
-from api.testbed_model.port import PortInfo
-from api.utils import expand_range
+class LinuxSession(ABC):
+    """Abstract interface for Linux-specific OS session operations.
 
-from .cpu import LogicalCore
-from .port import Port
-from .posix_session import PosixSession
-
-
-class LshwConfigurationOutput(TypedDict):
-    """The relevant parts of ``lshw``'s ``configuration`` section."""
-
-    #:
-    driver: str
-    #:
-    link: str
-
-
-class LshwOutput(TypedDict):
-    """A model of the relevant information from ``lshw``'s json output.
-
-    Example:
-        ::
-
-            {
-            ...
-            "businfo" : "pci@0000:08:00.0",
-            "logicalname" : "enp8s0",
-            "version" : "00",
-            "serial" : "52:54:00:59:e1:ac",
-            ...
-            "configuration" : {
-              ...
-              "link" : "yes",
-              ...
-            },
-            ...
+    API consumers should type-hint against this class when they need access
+    to Linux-only capabilities beyond the base :class:`~.os_session.OSSession` contract.
     """
 
-    #:
-    businfo: str
-    #:
-    logicalname: NotRequired[str]
-    #:
-    serial: NotRequired[str]
-    #:
-    configuration: LshwConfigurationOutput
-
-
-class LinuxSession(PosixSession):
-    """The implementation of non-Posix compliant parts of Linux."""
-
-    @staticmethod
-    def _get_privileged_command(command: str) -> str:
-        command = command.replace(r"'", r"\'")
-        return f"sudo -- sh -c '{command}'"
-
-    def get_remote_cpus(self) -> list[LogicalCore]:
-        """Overrides :meth:`~.os_session.OSSession.get_remote_cpus`."""
-        cpu_info = self.send_command("lscpu -p=CPU,CORE,SOCKET,NODE|grep -v \\#").stdout
-        lcores = []
-        for cpu_line in cpu_info.splitlines():
-            lcore, core, socket, node = map(int, cpu_line.split(","))
-            lcores.append(LogicalCore(lcore, core, socket, node))
-        return lcores
-
-    def get_dpdk_file_prefix(self, dpdk_prefix: str) -> str:
-        """Overrides :meth:`~.os_session.OSSession.get_dpdk_file_prefix`."""
-        return dpdk_prefix
-
-    def setup_hugepages(self, number_of: int, hugepage_size: int, force_first_numa: bool) -> None:
-        """Overrides :meth:`~.os_session.OSSession.setup_hugepages`.
-
-        Raises:
-            ConfigurationError: If the given `hugepage_size` is not supported by the OS.
-        """
-        self._logger.info("Getting Hugepage information.")
-        if (
-            f"hugepages-{hugepage_size}kB"
-            not in self.send_command("ls /sys/kernel/mm/hugepages").stdout
-        ):
-            raise ConfigurationError("hugepage size not supported by operating system")
-        hugepages_total = self._get_hugepages_total(hugepage_size)
-        self._numa_nodes = self._get_numa_nodes()
-
-        if force_first_numa or hugepages_total < number_of:
-            # when forcing numa, we need to clear existing hugepages regardless
-            # of size, so they can be moved to the first numa node
-            self._configure_huge_pages(number_of, hugepage_size, force_first_numa)
-        else:
-            self._logger.info("Hugepages already configured.")
-        self._mount_huge_pages()
-
-    def _get_hugepages_total(self, hugepage_size: int) -> int:
-        hugepages_total = self.send_command(
-            f"cat /sys/kernel/mm/hugepages/hugepages-{hugepage_size}kB/nr_hugepages"
-        ).stdout
-        return int(hugepages_total)
-
-    def _get_numa_nodes(self) -> list[int]:
-        try:
-            numa_count = self.send_command(
-                "cat /sys/devices/system/node/online", verify=True
-            ).stdout
-            numa_range = expand_range(numa_count)
-        except RemoteCommandExecutionError:
-            # the file doesn't exist, meaning the node doesn't support numa
-            numa_range = []
-        return numa_range
-
-    def _mount_huge_pages(self) -> None:
-        self._logger.info("Re-mounting Hugepages.")
-        hugapge_fs_cmd = "awk '/hugetlbfs/ { print $2 }' /proc/mounts"
-        self.send_command(f"umount $({hugapge_fs_cmd})", privileged=True)
-        result = self.send_command(hugapge_fs_cmd)
-        if result.stdout == "":
-            remote_mount_path = "/mnt/huge"
-            self.send_command(f"mkdir -p {remote_mount_path}", privileged=True)
-            self.send_command(f"mount -t hugetlbfs nodev {remote_mount_path}", privileged=True)
-
-    def _supports_numa(self) -> bool:
-        # the system supports numa if self._numa_nodes is non-empty and there are more
-        # than one numa node (in the latter case it may actually support numa, but
-        # there's no reason to do any numa specific configuration)
-        return len(self._numa_nodes) > 1
-
-    def _configure_huge_pages(self, number_of: int, size: int, force_first_numa: bool) -> None:
-        self._logger.info("Configuring Hugepages.")
-        hugepage_config_path = f"/sys/kernel/mm/hugepages/hugepages-{size}kB/nr_hugepages"
-        if force_first_numa and self._supports_numa():
-            # clear non-numa hugepages
-            self.send_command(f"echo 0 | tee {hugepage_config_path}", privileged=True)
-            hugepage_config_path = (
-                f"/sys/devices/system/node/node{self._numa_nodes[0]}/hugepages"
-                f"/hugepages-{size}kB/nr_hugepages"
-            )
-
-        self.send_command(f"echo {number_of} | tee {hugepage_config_path}", privileged=True)
-
-    def get_port_info(self, pci_address: str) -> PortInfo:
-        """Overrides :meth:`~.os_session.OSSession.get_port_info`.
-
-        Raises:
-            ConfigurationError: If the port could not be found.
-        """
-        bus_info = f"pci@{pci_address}"
-        port = next(port for port in self._lshw_net_info if port.get("businfo") == bus_info)
-        if port is None:
-            raise ConfigurationError(f"Port {pci_address} could not be found on the node.")
-
-        logical_name = port.get("logicalname", "")
-        mac_address = port.get("serial", "")
-
-        configuration = port.get("configuration", {})
-        driver = configuration.get("driver", "")
-        is_link_up = configuration.get("link", "down") == "up"
-
-        return PortInfo(mac_address, logical_name, driver, is_link_up)
-
-    def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
-        """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
-
-        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
-        """
-        ports_pci_addrs = " ".join(port.pci for port in ports)
-
-        self.send_command(
-            f"{self.devbind_script_path} -b {driver_name} --force {ports_pci_addrs}",
-            privileged=True,
-            verify=True,
-        )
-
-        del self._lshw_net_info
-
-    def bring_up_link(self, ports: Iterable[Port]) -> None:
-        """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
-        for port in ports:
-            self.send_command(
-                f"ip link set dev {port.logical_name} up", privileged=True, verify=True
-            )
-
-        del self._lshw_net_info
-
-    def set_interface_link_up(self, name: str) -> None:
-        """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
-        self.send_command(f"ip link set dev {name} up", privileged=True, verify=True)
-
-    def delete_interface(self, name: str) -> None:
-        """Overrides :meth:`~.os_session.OSSession.delete_interface`."""
-        self.send_command(f"ip link delete {name}", privileged=True)
-
-    @cached_property
-    def devbind_script_path(self) -> PurePath:
-        """The path to the dpdk-devbind.py script on the node.
-
-        Needs to be manually assigned first in order to be used.
-
-        Raises:
-            InternalError: If accessed before environment setup.
-        """
-        raise InternalError("Accessed devbind script path before setup.")
-
-    def load_vfio(self, pf_port: Port) -> None:
-        """Overrides :meth:`~os_session.OSSession,load_vfio`."""
-        cmd_result = self.send_command(f"lspci -nn -s {pf_port.pci}")
-        device = re.search(r":([0-9a-fA-F]{4})\]", cmd_result.stdout)
-        if device and device.group(1) in ["37c8", "0435", "19e2"]:
-            self.send_command(
-                "modprobe -r vfio_iommu_type1; modprobe -r vfio_pci",
-                privileged=True,
-            )
-            self.send_command(
-                "modprobe -r vfio_virqfd; modprobe -r vfio",
-                privileged=True,
-            )
-            self.send_command(
-                "modprobe vfio-pci disable_denylist=1 enable_sriov=1", privileged=True
-            )
-            self.send_command(
-                "echo 1 | tee /sys/module/vfio/parameters/enable_unsafe_noiommu_mode",
-                privileged=True,
-            )
-        else:
-            self.send_command("modprobe vfio-pci")
-        self.refresh_lshw()
-
-    def create_crypto_vfs(self, pf_port: list[Port]) -> None:
-        """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
-
-        Raises:
-            InternalError: If there are existing VFs which have to be deleted.
-        """
-        for port in pf_port:
-            self.delete_crypto_vfs(port)
-        for port in pf_port:
-            sys_bus_path = f"/sys/bus/pci/devices/{port.pci}".replace(":", "\\:")
-            curr_num_vfs = int(
-                self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
-            )
-            if 0 < curr_num_vfs:
-                raise InternalError("There are existing VFs on the port which must be deleted.")
-            num_vfs = int(
-                self.send_command(f"cat {sys_bus_path}/sriov_totalvfs", privileged=True).stdout
-            )
-            self.send_command(
-                f"echo {num_vfs} | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True
-            )
-
-        self.refresh_lshw()
-
-    def create_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
+    @abstractmethod
+    def configure_ipv4_forwarding(self, enable: bool) -> None:
+        """Enable or disable IPv4 forwarding on the node.
 
-        Raises:
-            InternalError: If there are existing VFs which have to be deleted.
+        Args:
+            enable: True to enable forwarding, False to disable.
         """
-        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
-        curr_num_vfs = int(
-            self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
-        )
-        if 0 < curr_num_vfs:
-            raise InternalError("There are existing VFs on the port which must be deleted.")
-        if curr_num_vfs == 0:
-            self.send_command(f"echo 1 | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True)
-            self.refresh_lshw()
-
-    def delete_crypto_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`."""
-        self.send_command(
-            f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remove".replace(":", "\\:"),
-            privileged=True,
-        )
-        self.send_command("echo 1 | sudo tee /sys/bus/pci/rescan", privileged=True)
-
-    def delete_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.delete_vfs`."""
-        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
-        curr_num_vfs = int(
-            self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
-        )
-        if curr_num_vfs == 0:
-            self._logger.debug(f"No VFs found on port {pf_port.pci}, skipping deletion")
-        else:
-            self.send_command(f"echo 0 | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True)
-
-    def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
-        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_crypto_vfs`."""
-        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
-        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
-        if curr_num_vfs > 0:
-            pci_addrs = self.send_command(
-                f"readlink {sys_bus_path}/virtfn*",
-                privileged=True,
-            )
-            return [pci.replace("../", "") for pci in pci_addrs.stdout.splitlines()]
-        return []
-
-    def get_pci_addr_of_vfs(self, pf_port: Port) -> list[str]:
-        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_vfs`."""
-        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
-        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
-        if curr_num_vfs > 0:
-            pci_addrs = self.send_command(
-                'awk -F "PCI_SLOT_NAME=" "/PCI_SLOT_NAME=/ {print \\$2}" '
-                + f"{sys_bus_path}/virtfn*/uevent",
-                privileged=True,
-            )
-            return pci_addrs.stdout.splitlines()
-        else:
-            return []
-
-    @cached_property
-    def _lshw_net_info(self) -> list[LshwOutput]:
-        output = self.send_command("lshw -quiet -json -C network", verify=True)
-        return json.loads(output.stdout)
-
-    def refresh_lshw(self) -> None:
-        """Force refresh of cached lshw network info."""
-        if "_lshw_net_info" in self.__dict__:
-            del self.__dict__["_lshw_net_info"]
-        _ = self._lshw_net_info
-
-    def _update_port_attr(self, port: Port, attr_value: str | None, attr_name: str) -> None:
-        if attr_value:
-            setattr(port, attr_name, attr_value)
-            self._logger.debug(f"Found '{attr_name}' of port {port.pci}: '{attr_value}'.")
-        else:
-            self._logger.warning(
-                f"Attempted to get '{attr_name}' of port {port.pci}, but it doesn't exist."
-            )
-
-    def configure_port_mtu(self, mtu: int, port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.configure_port_mtu`."""
-        self.send_command(
-            f"ip link set dev {port.logical_name} mtu {mtu}",
-            privileged=True,
-            verify=True,
-        )
-
-    def configure_ipv4_forwarding(self, enable: bool) -> None:
-        """Overrides :meth:`~.os_session.OSSession.configure_ipv4_forwarding`."""
-        state = 1 if enable else 0
-        self.send_command(f"sysctl -w net.ipv4.ip_forward={state}", privileged=True)
diff --git a/dts/api/testbed_model/node.py b/dts/api/testbed_model/node.py
index 40dd7f0666..3cab51855d 100644
--- a/dts/api/testbed_model/node.py
+++ b/dts/api/testbed_model/node.py
@@ -25,7 +25,6 @@
 from framework.logger import DTSLogger, get_dts_logger
 
 from .cpu import Architecture, LogicalCore
-from .linux_session import LinuxSession
 from .os_session import OSSession, OSSessionInfo
 from .port import Port
 
@@ -201,16 +200,26 @@ def close(self) -> None:
 def create_session(node_config: NodeConfiguration, name: str, logger: DTSLogger) -> OSSession:
     """Factory for OS-aware sessions.
 
+    Creates a concrete :class:`~.os_session.OSSession` implementation appropriate for the
+    operating system specified in `node_config`. The concrete session classes live in the
+    framework package and are imported lazily to avoid circular dependencies between the
+    API and framework layers.
+
     Args:
         node_config: The test run configuration of the node to connect to.
         name: The name of the session.
         logger: The logger instance this session will use.
 
+    Returns:
+        An OS-aware session connected to the node.
+
     Raises:
         ConfigurationError: If the node's OS is unsupported.
     """
     match node_config.os:
         case OS.linux:
+            from framework.linux_session import LinuxSession
+
             return LinuxSession(node_config, name, logger)
         case _:
             raise ConfigurationError(f"Unsupported OS {node_config.os}")
diff --git a/dts/api/testbed_model/os_session.py b/dts/api/testbed_model/os_session.py
index b1e0538ac9..618a5bc45c 100644
--- a/dts/api/testbed_model/os_session.py
+++ b/dts/api/testbed_model/os_session.py
@@ -166,6 +166,22 @@ def close(self) -> None:
         """Close the underlying remote session."""
         self.remote_session.close()
 
+    @property
+    @abstractmethod
+    def devbind_script_path(self) -> PurePath:
+        """The path to the dpdk-devbind.py script on the node.
+
+        Must be set up during environment initialization before access.
+
+        Raises:
+            InternalError: If accessed before environment setup.
+        """
+
+    @devbind_script_path.setter
+    @abstractmethod
+    def devbind_script_path(self, value: PurePath) -> None:
+        """Set the devbind script path after environment setup."""
+
     @staticmethod
     @abstractmethod
     def _get_privileged_command(command: str) -> str:
diff --git a/dts/framework/linux_session.py b/dts/framework/linux_session.py
new file mode 100644
index 0000000000..54c6370d53
--- /dev/null
+++ b/dts/framework/linux_session.py
@@ -0,0 +1,375 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2023 PANTHEON.tech s.r.o.
+# Copyright(c) 2023 University of New Hampshire
+
+"""Linux OS session implementation.
+
+Translates OS-unaware calls into Linux-specific commands and utilities.
+Implements the :class:`~api.linux_session.LinuxSession` contract for Linux distributions,
+building on :class:`~.posix_session.PosixSession` for POSIX-compliant operations.
+"""
+
+import json
+import re
+from collections.abc import Iterable
+from pathlib import PurePath
+from typing import TypedDict
+
+from typing_extensions import NotRequired
+
+from api.exception import (
+    ConfigurationError,
+    InternalError,
+    RemoteCommandExecutionError,
+)
+from api.testbed_model.cpu import LogicalCore
+from api.testbed_model.linux_session import LinuxSession as LinuxSessionBase
+from api.testbed_model.port import Port, PortInfo
+from api.testbed_model.posix_session import PosixSession
+from api.utils import expand_range
+
+
+class LshwConfigurationOutput(TypedDict):
+    """The relevant parts of ``lshw``'s ``configuration`` section."""
+
+    #:
+    driver: str
+    #:
+    link: str
+
+
+class LshwOutput(TypedDict):
+    """A model of the relevant information from ``lshw``'s json output.
+
+    Example:
+        ::
+
+            {
+            ...
+            "businfo" : "pci@0000:08:00.0",
+            "logicalname" : "enp8s0",
+            "version" : "00",
+            "serial" : "52:54:00:59:e1:ac",
+            ...
+            "configuration" : {
+              ...
+              "link" : "yes",
+              ...
+            },
+            ...
+    """
+
+    #:
+    businfo: str
+    #:
+    logicalname: NotRequired[str]
+    #:
+    serial: NotRequired[str]
+    #:
+    configuration: LshwConfigurationOutput
+
+
+class LinuxSession(PosixSession, LinuxSessionBase):
+    """Linux-specific implementation of the OS session interface.
+
+    Inherits POSIX-compliant operations from
+    :class:`~.posix_session.PosixSession` and implements the
+    :class:`~api.linux_session.LinuxSession` contract. All backend logic —
+    ``lshw`` caching, hugepage sysfs interaction, VFIO module loading,
+    SR-IOV management — lives here in the framework.
+    """
+
+    _devbind_script_path: PurePath | None
+
+    def __init__(self, *args, **kwargs) -> None:
+        """Overrides :meth:`~.os_session.OSSession.__init__`."""
+        self._devbind_script_path = None
+        super().__init__(*args, **kwargs)
+
+    @staticmethod
+    def _get_privileged_command(command: str) -> str:
+        command = command.replace(r"'", r"\'")
+        return f"sudo -- sh -c '{command}'"
+
+    def get_remote_cpus(self) -> list[LogicalCore]:
+        """Overrides :meth:`~.os_session.OSSession.get_remote_cpus`."""
+        cpu_info = self.send_command("lscpu -p=CPU,CORE,SOCKET,NODE|grep -v \\#").stdout
+        lcores = []
+        for cpu_line in cpu_info.splitlines():
+            lcore, core, socket, node = map(int, cpu_line.split(","))
+            lcores.append(LogicalCore(lcore, core, socket, node))
+        return lcores
+
+    def get_dpdk_file_prefix(self, dpdk_prefix: str) -> str:
+        """Overrides :meth:`~.os_session.OSSession.get_dpdk_file_prefix`."""
+        return dpdk_prefix
+
+    @property
+    def devbind_script_path(self) -> PurePath:
+        """Overrides :attr:`~.os_session.OSSession.devbind_script_path`.
+
+        Raises:
+            InternalError: If accessed before environment setup.
+        """
+        if self._devbind_script_path is None:
+            raise InternalError("Accessed devbind script path before setup.")
+        return self._devbind_script_path
+
+    @devbind_script_path.setter
+    def devbind_script_path(self, value: PurePath) -> None:
+        """Set the devbind script path after environment setup."""
+        self._devbind_script_path = value
+
+    def setup_hugepages(self, number_of: int, hugepage_size: int, force_first_numa: bool) -> None:
+        """Overrides :meth:`~.os_session.OSSession.setup_hugepages`.
+
+        Raises:
+            ConfigurationError: If the given `hugepage_size` is not supported by the OS.
+        """
+        self._logger.info("Getting Hugepage information.")
+        if (
+            f"hugepages-{hugepage_size}kB"
+            not in self.send_command("ls /sys/kernel/mm/hugepages").stdout
+        ):
+            raise ConfigurationError("hugepage size not supported by operating system")
+        hugepages_total = self._get_hugepages_total(hugepage_size)
+        self._numa_nodes = self._get_numa_nodes()
+
+        if force_first_numa or hugepages_total < number_of:
+            self._configure_huge_pages(number_of, hugepage_size, force_first_numa)
+        else:
+            self._logger.info("Hugepages already configured.")
+        self._mount_huge_pages()
+
+    def _get_hugepages_total(self, hugepage_size: int) -> int:
+        hugepages_total = self.send_command(
+            f"cat /sys/kernel/mm/hugepages/hugepages-{hugepage_size}kB/nr_hugepages"
+        ).stdout
+        return int(hugepages_total)
+
+    def _get_numa_nodes(self) -> list[int]:
+        try:
+            numa_count = self.send_command(
+                "cat /sys/devices/system/node/online", verify=True
+            ).stdout
+            numa_range = expand_range(numa_count)
+        except RemoteCommandExecutionError:
+            numa_range = []
+        return numa_range
+
+    def _mount_huge_pages(self) -> None:
+        self._logger.info("Re-mounting Hugepages.")
+        hugapge_fs_cmd = "awk '/hugetlbfs/ { print $2 }' /proc/mounts"
+        self.send_command(f"umount $({hugapge_fs_cmd})", privileged=True)
+        result = self.send_command(hugapge_fs_cmd)
+        if result.stdout == "":
+            remote_mount_path = "/mnt/huge"
+            self.send_command(f"mkdir -p {remote_mount_path}", privileged=True)
+            self.send_command(f"mount -t hugetlbfs nodev {remote_mount_path}", privileged=True)
+
+    def _supports_numa(self) -> bool:
+        return len(self._numa_nodes) > 1
+
+    def _configure_huge_pages(self, number_of: int, size: int, force_first_numa: bool) -> None:
+        self._logger.info("Configuring Hugepages.")
+        hugepage_config_path = f"/sys/kernel/mm/hugepages/hugepages-{size}kB/nr_hugepages"
+        if force_first_numa and self._supports_numa():
+            self.send_command(f"echo 0 | tee {hugepage_config_path}", privileged=True)
+            hugepage_config_path = (
+                f"/sys/devices/system/node/node{self._numa_nodes[0]}/hugepages"
+                f"/hugepages-{size}kB/nr_hugepages"
+            )
+        self.send_command(f"echo {number_of} | tee {hugepage_config_path}", privileged=True)
+
+    def get_port_info(self, pci_address: str) -> PortInfo:
+        """Overrides :meth:`~.os_session.OSSession.get_port_info`.
+
+        Raises:
+            ConfigurationError: If the port could not be found.
+        """
+        bus_info = f"pci@{pci_address}"
+        port = next(port for port in self._lshw_net_info if port.get("businfo") == bus_info)
+        if port is None:
+            raise ConfigurationError(f"Port {pci_address} could not be found on the node.")
+
+        logical_name = port.get("logicalname", "")
+        mac_address = port.get("serial", "")
+
+        configuration = port.get("configuration", {})
+        driver = configuration.get("driver", "")
+        is_link_up = configuration.get("link", "down") == "up"
+
+        return PortInfo(mac_address, logical_name, driver, is_link_up)
+
+    @property
+    def _lshw_net_info(self) -> list[LshwOutput]:
+        """Cached lshw network info, fetched on first access."""
+        if not hasattr(self, "_lshw_net_cache"):
+            output = self.send_command("lshw -quiet -json -C network", verify=True)
+            self._lshw_net_cache: list[LshwOutput] = json.loads(output.stdout)
+        return self._lshw_net_cache
+
+    def _refresh_lshw(self) -> None:
+        """Force refresh of cached lshw network info.
+
+        Called internally after operations that change port/driver state.
+        """
+        if hasattr(self, "_lshw_net_cache"):
+            del self._lshw_net_cache
+        _ = self._lshw_net_info
+
+    def _update_port_attr(self, port: Port, attr_value: str | None, attr_name: str) -> None:
+        if attr_value:
+            setattr(port, attr_name, attr_value)
+            self._logger.debug(f"Found '{attr_name}' of port {port.pci}: '{attr_value}'.")
+        else:
+            self._logger.warning(
+                f"Attempted to get '{attr_name}' of port {port.pci}, but it doesn't exist."
+            )
+
+    def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`."""
+        ports_pci_addrs = " ".join(port.pci for port in ports)
+        self.send_command(
+            f"{self.devbind_script_path} -b {driver_name} --force {ports_pci_addrs}",
+            privileged=True,
+            verify=True,
+        )
+        self._refresh_lshw()
+
+    def bring_up_link(self, ports: Iterable[Port]) -> None:
+        """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
+        for port in ports:
+            self.send_command(
+                f"ip link set dev {port.logical_name} up", privileged=True, verify=True
+            )
+        self._refresh_lshw()
+
+    def set_interface_link_up(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
+        self.send_command(f"ip link set dev {name} up", privileged=True, verify=True)
+
+    def delete_interface(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_interface`."""
+        self.send_command(f"ip link delete {name}", privileged=True)
+
+    def load_vfio(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.load_vfio`."""
+        cmd_result = self.send_command(f"lspci -nn -s {pf_port.pci}")
+        device = re.search(r":([0-9a-fA-F]{4})\]", cmd_result.stdout)
+        if device and device.group(1) in ["37c8", "0435", "19e2"]:
+            self.send_command(
+                "modprobe -r vfio_iommu_type1; modprobe -r vfio_pci",
+                privileged=True,
+            )
+            self.send_command(
+                "modprobe -r vfio_virqfd; modprobe -r vfio",
+                privileged=True,
+            )
+            self.send_command(
+                "modprobe vfio-pci disable_denylist=1 enable_sriov=1", privileged=True
+            )
+            self.send_command(
+                "echo 1 | tee /sys/module/vfio/parameters/enable_unsafe_noiommu_mode",
+                privileged=True,
+            )
+        else:
+            self.send_command("modprobe vfio-pci")
+        self._refresh_lshw()
+
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
+            self._refresh_lshw()
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
+    def create_crypto_vfs(self, pf_port: list[Port]) -> None:
+        """Overrides :meth:`~.os_session.OSSession.create_crypto_vfs`.
+
+        Raises:
+            InternalError: If there are existing VFs which have to be deleted.
+        """
+        for port in pf_port:
+            self.delete_crypto_vfs(port)
+        for port in pf_port:
+            sys_bus_path = f"/sys/bus/pci/devices/{port.pci}".replace(":", "\\:")
+            curr_num_vfs = int(
+                self.send_command(f"cat {sys_bus_path}/sriov_numvfs", privileged=True).stdout
+            )
+            if 0 < curr_num_vfs:
+                raise InternalError("There are existing VFs on the port which must be deleted.")
+            num_vfs = int(
+                self.send_command(f"cat {sys_bus_path}/sriov_totalvfs", privileged=True).stdout
+            )
+            self.send_command(
+                f"echo {num_vfs} | sudo tee {sys_bus_path}/sriov_numvfs", privileged=True
+            )
+        self._refresh_lshw()
+
+    def delete_crypto_vfs(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`."""
+        self.send_command(
+            f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remove".replace(":", "\\:"),
+            privileged=True,
+        )
+        self.send_command("echo 1 | sudo tee /sys/bus/pci/rescan", privileged=True)
+
+    def get_pci_addr_of_crypto_vfs(self, pf_port: Port) -> list[str]:
+        """Overrides :meth:`~.os_session.OSSession.get_pci_addr_of_crypto_vfs`."""
+        sys_bus_path = f"/sys/bus/pci/devices/{pf_port.pci}".replace(":", "\\:")
+        curr_num_vfs = int(self.send_command(f"cat {sys_bus_path}/sriov_numvfs").stdout)
+        if curr_num_vfs > 0:
+            pci_addrs = self.send_command(
+                f"readlink {sys_bus_path}/virtfn*",
+                privileged=True,
+            )
+            return [pci.replace("../", "") for pci in pci_addrs.stdout.splitlines()]
+        return []
+
+    def configure_port_mtu(self, mtu: int, port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.configure_port_mtu`."""
+        self.send_command(
+            f"ip link set dev {port.logical_name} mtu {mtu}",
+            privileged=True,
+            verify=True,
+        )
+
+    def configure_ipv4_forwarding(self, enable: bool) -> None:
+        """Implements :meth:`~api.linux_session.LinuxSession.configure_ipv4_forwarding`."""
+        state = 1 if enable else 0
+        self.send_command(f"sysctl -w net.ipv4.ip_forward={state}", privileged=True)
-- 
2.52.0

