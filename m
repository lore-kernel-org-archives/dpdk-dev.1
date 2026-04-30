Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29ECCCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 21:10:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 822DF406BA;
	Thu, 30 Apr 2026 23:09:31 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 46E6740395
 for <dev@dpdk.org>; Thu, 30 Apr 2026 23:09:27 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8eb5ad01402so147520685a.2
 for <dev@dpdk.org>; Thu, 30 Apr 2026 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1777583366; x=1778188166; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZikQA14ALPpFzTIoeqav1Ckn3oXPdtmEQQgDrlrfLZM=;
 b=W6JSX9UYYxeJB2nFPceeLSdIIWvBT5r7U18+d2zzHQ81gAdtLepWGunjPsWPGWadzt
 cON4h4hrkyTsClHB9zJx5yPQ/lWQrKbZUFLbWPl7bqe8OHmJ/wzUjZGXxWn7sjCz971r
 252++NG1qZrmJcbfQIUiM+o3tDOZxtca9B5v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583366; x=1778188166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZikQA14ALPpFzTIoeqav1Ckn3oXPdtmEQQgDrlrfLZM=;
 b=JT/zjetF3eoNTI23hbSxAzkhLS9YZAMlLRihUdPxz0sF0GT/uwr/TLQ7s85wuB+roV
 FbljyPG8lsCdAaQ1DaTby213mbyahMtV5U1yvkuqLfTN2I1jcX+WOsQvfenGsw/kOxMN
 FDmjGWpdsPPxj+caLdKKVQPkfZQZXRu4oZSaxjRADxZsuM0BcBx/Mjtey5IJrphuD0pV
 gw7snFXHgA8MSy1Ss3e4aWAplaWFzFFJYtA4VqSFx59Z5j/k1Tw3DKxTarprJDRbfoD4
 SSGT8mk49ROon4FIC0Rgkm1p14cezJvyDL7CDVYPKYCwvyxzBG2tgWzWNvpxbnZuRidz
 C75A==
X-Gm-Message-State: AOJu0YzqFyywbQ9ePx+AnbN/mF0DUbC2/rpFvHH2IUOcpeaP6mKmeI3p
 5QgHpiI4JE1BSFxld83Ci4dTJjmlxgnJg5hoO6ct+OyrLYDnop4Sbmpu9HR5b6nTdxM=
X-Gm-Gg: AeBDieuzqy9wg7407lphZZ7W2aKLbDdizowY4ZSi9TT8YtoqmdOMNUhGZuKhXoq1PPs
 nK7cweHjyjqLi2EjZV4hur4nAiitQF4s4oidgWRJkltmJWmHzIXD+n9raNkQS2Dw0R98BTLAf8Q
 6C7lPjq6TY9944JWBr1oE282vWLQ3dj11dx325ff8yEp/eJXuFaK2ZTQFQdb5V3zMxRiuiYAQN5
 9Duql5K80nEkf3JsPPvq+X+QQeTn+U9YxS3NgROf2KZVOlTYHe3AP5nchFo2OGVDEJBufSMtXBs
 BKOl4G59li7XdZUkPSRYDdCvvTlHmFEXF+/dXmY4d+YPOVDLWhfIdP+z5hvER7giGP3kFMSDIGQ
 WY8H+YRkJ5L1CU+l3lcWWpiNaBo46k31vfcFptt1qTyIh13OD1jNG8edt3nt3Tar8AHbAbszCTT
 DqP+9VH96h5RlX1/yC3yamabj1BMrrWGa5WWFHcghExno8urFIAr4L8cc9eALn05tJdvwzcWhE
X-Received: by 2002:a05:620a:414d:b0:8cd:871c:909d with SMTP id
 af79cd13be357-8fa896157efmr754320685a.53.1777583366289; 
 Thu, 30 Apr 2026 14:09:26 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbf3f2141fsm15434385a.41.2026.04.30.14.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 14:09:25 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: patrickrobb1997@gmail.com, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v4 7/7] dts: separate Linux session into interface and logic
Date: Thu, 30 Apr 2026 17:09:17 -0400
Message-ID: <20260430210917.25186-8-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260430210917.25186-1-dmarx@iol.unh.edu>
References: <20260424170139.20592-1-dmarx@iol.unh.edu>
 <20260430210917.25186-1-dmarx@iol.unh.edu>
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

Separate Linux session into an interface for the API,
and a logical module in the framework.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/api/dts/framework.linux_session.rst |   8 +
 doc/api/dts/index.rst                   |   1 +
 dts/api/testbed_model/linux_session.py  | 372 ++----------------------
 dts/api/testbed_model/node.py           |   8 +-
 dts/framework/linux_session.py          | 366 +++++++++++++++++++++++
 5 files changed, 403 insertions(+), 352 deletions(-)
 create mode 100644 doc/api/dts/framework.linux_session.rst
 create mode 100644 dts/framework/linux_session.py

diff --git a/doc/api/dts/framework.linux_session.rst b/doc/api/dts/framework.linux_session.rst
new file mode 100644
index 0000000000..9de2e1484d
--- /dev/null
+++ b/doc/api/dts/framework.linux_session.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+framework.linux\_session
+========================
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
index 7307b2abe2..5bcbf1ce97 100644
--- a/dts/api/testbed_model/linux_session.py
+++ b/dts/api/testbed_model/linux_session.py
@@ -1,367 +1,41 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2023 PANTHEON.tech s.r.o.
 # Copyright(c) 2023 University of New Hampshire
+"""Linux OS session interface.
 
-"""Linux OS translator.
-
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
+from abc import ABC, abstractmethod
 from pathlib import PurePath
-from typing import TypedDict
-
-from typing_extensions import NotRequired
-
-from api.exception import (
-    ConfigurationError,
-    InternalError,
-    RemoteCommandExecutionError,
-)
-from api.testbed_model.port import PortInfo
-from api.utils import expand_range
-
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
-    """
-
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
 
-        logical_name = port.get("logicalname", "")
-        mac_address = port.get("serial", "")
+class LinuxSession(ABC):
+    """Abstract interface for Linux-specific OS session operations."""
 
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
+    @property
+    @abstractmethod
     def devbind_script_path(self) -> PurePath:
-        """The path to the dpdk-devbind.py script on the node.
-
-        Needs to be manually assigned first in order to be used.
+        """The path to the devbind script."""
 
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
+    @devbind_script_path.setter
+    @abstractmethod
+    def devbind_script_path(self, value: PurePath) -> None:
+        """Set the devbind script path after environment setup."""
 
-    def create_crypto_vfs(self, pf_port: list[Port]) -> None:
-        """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
+    @abstractmethod
+    def set_interface_link_up(self, name: str) -> None:
+        """Set the link status of an interface to up.
 
-        Raises:
-            InternalError: If there are existing VFs which have to be deleted.
+        Args:
+            name: The name of the interface.
         """
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
 
-    def create_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
+    @abstractmethod
+    def delete_interface(self, name: str) -> None:
+        """Delete a virtual interface.
 
-        Raises:
-            InternalError: If there are existing VFs which have to be deleted.
+        Args:
+            name: The name of the interface to delete.
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
index 40dd7f0666..51abbd098b 100644
--- a/dts/api/testbed_model/node.py
+++ b/dts/api/testbed_model/node.py
@@ -15,17 +15,19 @@
 
 from functools import cached_property
 from pathlib import PurePath
-from typing import Literal, TypeAlias
+from typing import TYPE_CHECKING, Literal, TypeAlias
 
 from api.exception import ConfigurationError, InternalError
 from framework.config.node import (
     OS,
     NodeConfiguration,
 )
+
+if TYPE_CHECKING:
+    from framework.linux_session import LinuxSession
 from framework.logger import DTSLogger, get_dts_logger
 
 from .cpu import Architecture, LogicalCore
-from .linux_session import LinuxSession
 from .os_session import OSSession, OSSessionInfo
 from .port import Port
 
@@ -211,7 +213,7 @@ def create_session(node_config: NodeConfiguration, name: str, logger: DTSLogger)
     """
     match node_config.os:
         case OS.linux:
-            return LinuxSession(node_config, name, logger)
+            return "LinuxSession"(node_config, name, logger)
         case _:
             raise ConfigurationError(f"Unsupported OS {node_config.os}")
 
diff --git a/dts/framework/linux_session.py b/dts/framework/linux_session.py
new file mode 100644
index 0000000000..e5320b7fc4
--- /dev/null
+++ b/dts/framework/linux_session.py
@@ -0,0 +1,366 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2023 PANTHEON.tech s.r.o.
+# Copyright(c) 2023 University of New Hampshire
+
+"""Linux OS translator.
+
+Translate OS-unaware calls into Linux calls/utilities. Most of Linux distributions are mostly
+compliant with POSIX standards, so this module only implements the parts that aren't.
+This intermediate module implements the common parts of mostly POSIX compliant distributions.
+"""
+
+import json
+import re
+from collections.abc import Iterable
+from functools import cached_property
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
+    """The implementation of non-Posix compliant parts of Linux."""
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
+            # when forcing numa, we need to clear existing hugepages regardless
+            # of size, so they can be moved to the first numa node
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
+            # the file doesn't exist, meaning the node doesn't support numa
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
+        # the system supports numa if self._numa_nodes is non-empty and there are more
+        # than one numa node (in the latter case it may actually support numa, but
+        # there's no reason to do any numa specific configuration)
+        return len(self._numa_nodes) > 1
+
+    def _configure_huge_pages(self, number_of: int, size: int, force_first_numa: bool) -> None:
+        self._logger.info("Configuring Hugepages.")
+        hugepage_config_path = f"/sys/kernel/mm/hugepages/hugepages-{size}kB/nr_hugepages"
+        if force_first_numa and self._supports_numa():
+            # clear non-numa hugepages
+            self.send_command(f"echo 0 | tee {hugepage_config_path}", privileged=True)
+            hugepage_config_path = (
+                f"/sys/devices/system/node/node{self._numa_nodes[0]}/hugepages"
+                f"/hugepages-{size}kB/nr_hugepages"
+            )
+
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
+    def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
+
+        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        """
+        ports_pci_addrs = " ".join(port.pci for port in ports)
+
+        self.send_command(
+            f"{self.devbind_script_path} -b {driver_name} --force {ports_pci_addrs}",
+            privileged=True,
+            verify=True,
+        )
+
+        del self._lshw_net_info
+
+    def bring_up_link(self, ports: Iterable[Port]) -> None:
+        """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
+        for port in ports:
+            self.send_command(
+                f"ip link set dev {port.logical_name} up", privileged=True, verify=True
+            )
+
+        del self._lshw_net_info
+
+    def set_interface_link_up(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.set_interface_link_up`."""
+        self.send_command(f"ip link set dev {name} up", privileged=True, verify=True)
+
+    def delete_interface(self, name: str) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_interface`."""
+        self.send_command(f"ip link delete {name}", privileged=True)
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
+    def load_vfio(self, pf_port: Port) -> None:
+        """Overrides :meth:`~os_session.OSSession,load_vfio`."""
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
+        self.refresh_lshw()
+
+    def create_crypto_vfs(self, pf_port: list[Port]) -> None:
+        """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
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
+
+        self.refresh_lshw()
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
+            self.refresh_lshw()
+
+    def delete_crypto_vfs(self, pf_port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`."""
+        self.send_command(
+            f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remove".replace(":", "\\:"),
+            privileged=True,
+        )
+        self.send_command("echo 1 | sudo tee /sys/bus/pci/rescan", privileged=True)
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
+    @cached_property
+    def _lshw_net_info(self) -> list[LshwOutput]:
+        output = self.send_command("lshw -quiet -json -C network", verify=True)
+        return json.loads(output.stdout)
+
+    def refresh_lshw(self) -> None:
+        """Force refresh of cached lshw network info."""
+        if "_lshw_net_info" in self.__dict__:
+            del self.__dict__["_lshw_net_info"]
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
+    def configure_port_mtu(self, mtu: int, port: Port) -> None:
+        """Overrides :meth:`~.os_session.OSSession.configure_port_mtu`."""
+        self.send_command(
+            f"ip link set dev {port.logical_name} mtu {mtu}",
+            privileged=True,
+            verify=True,
+        )
+
+    def configure_ipv4_forwarding(self, enable: bool) -> None:
+        """Overrides :meth:`~.os_session.OSSession.configure_ipv4_forwarding`."""
+        state = 1 if enable else 0
+        self.send_command(f"sysctl -w net.ipv4.ip_forward={state}", privileged=True)
-- 
2.52.0

