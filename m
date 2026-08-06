Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B2C5AC7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8393940616;
	Thu,  6 Aug 2026 19:51:33 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6CBB8406B6
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:51:32 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-934a3d14924so252019985a.2
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1786038692; x=1786643492; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AlNMln2EzHPuHyWMiA5SMf9OaWGvfIDz+kdlV6Z8PYM=;
 b=jtyEfI9OJBCpdBOzyCB1dcRuOjuI5xQzunzjWNbvVHAKZ1xM8T0iKrjEu/XTp39Ca9
 ySfwc2UQSCoKeFZzB2yHXKTexYQf7In0rqQKvYiI7CD+iAigpc5u5qXs+eULEdvsuvzn
 M6P2KQeLz3Q7i7qOeIWi+MhcuTOPdKWLt8VDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786038692; x=1786643492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AlNMln2EzHPuHyWMiA5SMf9OaWGvfIDz+kdlV6Z8PYM=;
 b=KlCK0Rs8E6Jse/pacK/MR9YxSkkB/ZvqVXmpVg6fNcAok4F9aGSqfWo+nzqSD5BLKq
 xEqYeKw4imKmwSWg9yxB+0evYoKw/1C5/55YYpFEhnmoxQw4k17ehwUpvlXiGE1ECIeI
 0Ht8h+IP4LoOwVrSWZLfwbLsutl3R2oVo5MVgb8dPH/4T4Ga3DnvPDdZq5h3hWdDAOd7
 cqjQ05mDN7fVQteEZZ1/7jEeSDhKvlTM4r63by8NxqhJGSOwY2J6BpU2cjMYKz6JlQju
 sQzvFCJVyL2WFrsAtQjBQyt+lU1MIrqrs8TPzXMUdKWPshHxK0mwKFItk8P7UB6em9iG
 Lh+g==
X-Gm-Message-State: AOJu0YyFr+2nttxfNZt9AAfgY92UadXMPcp79sbJa4SA5t7MScnHcyOM
 UzfLEjVil1XC0mD79mPfDHeMoimrovZx/g/N6OEkkiVh/CSIbnp/j3TQgQBdJ4LSUHtXExo2mHG
 VGqu+Cl05fwMJbievAktFQ2GmJpIi1FeBRocnrxWFp+OCNzyBoEp0D75IC/wj0M1/SkA2D6zhNo
 DLSO0TbTMlw1xQaAVjftfzgQKJYMU=
X-Gm-Gg: AR+sD13TlKb2EnPlH3w8yhR5Xzbq5tEvavx5674AUMx1qVN6ZYalllj5Sl7M8JMCubY
 8uLchPIR7DTCO7QPmbS/RARn3SW0Ps5djdWxZblLRI70TSyaYeYYcPJd0wzy7xbcFGKsdaxqgfY
 Xf96XVyHfT+CuQIdFXcilEbqQsUYBA73RKUwZxU+NmzZSEVH6c4HXcZjG7kHv+nMSXmn42+eyuO
 QRO8eOLrF4JyTOFWaLgvth/pPYM2wpHoTn1eFiHoGegdnE3pnxD2wc4aR140+Lc9DeiB8oMq1UQ
 /zqwAUVYa8/N/28KAePrlvkQg9KKsdO3vKXMzStcBsBlw3xlr4y5aQvrWi4+n1YqaX+tl0gtHms
 lXvk8H3etNQvKEhf1UWWoQ0FKg+8R2Dly3vSlNPkuXxtWfAaZyS5EJhGAlt6Z25af2+7yOZwn11
 jZlihxYf+tm+8VUHJHWl1co1kvQhnzfD8rTubFqV9dHSXrKz/J9/S5RQnh5q4Yf/qiXMjHwJOaE
 7FNINQDLgVvaRREA2cwm9E8qhmIKFSWh2+dOFWU
X-Received: by 2002:a05:620a:c4b:b0:934:a12b:1d41 with SMTP id
 af79cd13be357-936665d1632mr319307985a.33.1786038691293; 
 Thu, 06 Aug 2026 10:51:31 -0700 (PDT)
Received: from syn-2603-7083-bff0-a0d0-0000-0000-0000-1a64.res6.spectrum.com
 ([2606:4100:3880:1257::1039]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93657688090sm317311285a.27.2026.08.06.10.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:51:30 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: knimoji@iol.unh.edu, lylavoie@iol.unh.edu, dladd@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>, Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v6 7/7] dts: separate Linux session into interface and logic
Date: Thu,  6 Aug 2026 13:50:24 -0400
Message-ID: <20260806175024.13655-8-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806175024.13655-1-abailey@iol.unh.edu>
References: <20260806135346.568766-1-abailey@iol.unh.edu>
 <20260806175024.13655-1-abailey@iol.unh.edu>
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
Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/api/dts/framework.linux_session.rst |   9 +
 doc/api/dts/index.rst                   |   1 +
 dts/api/testbed_model/linux_session.py  | 453 +----------------------
 dts/api/testbed_model/node.py           |   2 +-
 dts/framework/linux_session.py          | 460 ++++++++++++++++++++++++
 5 files changed, 489 insertions(+), 436 deletions(-)
 create mode 100644 doc/api/dts/framework.linux_session.rst
 create mode 100644 dts/framework/linux_session.py

diff --git a/doc/api/dts/framework.linux_session.rst b/doc/api/dts/framework.linux_session.rst
new file mode 100644
index 0000000000..95a4fca977
--- /dev/null
+++ b/doc/api/dts/framework.linux_session.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+
+framework.linux\_session
+========================
+
+.. automodule:: framework.linux_session
+   :members:
+   :show-inheritance:
+
diff --git a/doc/api/dts/index.rst b/doc/api/dts/index.rst
index e89e782ac0..14d12eb038 100644
--- a/doc/api/dts/index.rst
+++ b/doc/api/dts/index.rst
@@ -35,6 +35,7 @@ Modules
    api.context
    framework.logger
    framework.parser
+   framework.linux_session
    api.utils
    api.exception

diff --git a/dts/api/testbed_model/linux_session.py b/dts/api/testbed_model/linux_session.py
index 399968efd4..a0b61b67df 100644
--- a/dts/api/testbed_model/linux_session.py
+++ b/dts/api/testbed_model/linux_session.py
@@ -9,454 +9,37 @@
 This intermediate module implements the common parts of mostly POSIX compliant distributions.
 """

-import json
-import re
-from collections.abc import Iterable
-from functools import cached_property
+from abc import abstractmethod
 from pathlib import PurePath
-from typing import TypedDict

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
 from .posix_session import PosixSession


-class LshwConfigurationOutput(TypedDict):
-    """The relevant parts of ``lshw``'s ``configuration`` section."""
-
-    #:
-    driver: str
-    #:
-    link: str
-    #:
-    firmware: str
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
-    vendor: NotRequired[str]
-    #:
-    product: NotRequired[str]
-    #:
-    version: NotRequired[str]
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
 class LinuxSession(PosixSession):
     """The implementation of non-Posix compliant parts of Linux."""

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
-        port = next((port for port in self._lshw_net_info if port.get("businfo") == bus_info), None)
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
-    def unbind_ports(self, ports: list[Port]):
-        """Overrides :meth:`~.os_session.OSSession.unbind_ports`.
-
-        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
-        """
-        ports_pci_addrs = " ".join(port.pci for port in ports)
-
-        self.send_command(
-            f"{self.devbind_script_path} -u --force {ports_pci_addrs}",
-            privileged=True,
-            verify=True,
-        )
-
-        if self._lshw_net_info:
-            del self._lshw_net_info
-
-    def get_nic_info(self) -> list[dict[str, str]]:
-        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
-
-        Raises:
-            ConfigurationError: If the NIC info could not be found.
-        """
-        port_to_data = {
-            port.get("businfo"): port for port in self._lshw_net_info if port.get("businfo")
-        }
-
-        all_nic_info: list[dict[str, str]] = []
-        for port in self._config.ports:
-            pci_addr = port.pci
-
-            lshw_result = self.send_command(
-                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cut -d'@' -f1"
-            )
-            if lshw_result.return_code != 0 or lshw_result.stdout == "":
-                raise ConfigurationError(f"Unable to get bus type for port {pci_addr}.")
-            bus_type = lshw_result.stdout
-
-            bus_info = f"{bus_type}@{pci_addr}"
-            nic_port: LshwOutput | None = port_to_data[bus_info]
-            if nic_port is None:
-                raise ConfigurationError(f"Port {pci_addr} could not be found on the node.")
-
-            config: LshwConfigurationOutput | None = nic_port["configuration"]
-            if config is None:
-                raise ConfigurationError(
-                    f"Configuration info for port {pci_addr} could not be found on the node."
-                )
-
-            if "logicalname" not in nic_port:
-                raise ConfigurationError(
-                    f"Logical name for port {pci_addr} could not be found on the node."
-                )
-
-            ethtool_result = self.send_command(
-                f"ethtool {nic_port['logicalname']} | grep 'Speed:' | awk '{{print $2}}'"
-            )
-            if ethtool_result.return_code == 0 and ethtool_result.stdout:
-                nic_speed = ethtool_result.stdout
-            else:
-                self._logger.error(f"Unable to get speed for NIC: {pci_addr}")
-                nic_speed = None
-
-            dut_json = {
-                "make": nic_port["vendor"] if "vendor" in nic_port else "Unknown",
-                "model": nic_port["product"] if "product" in nic_port else "Unknown",
-                "hardware version": nic_port["version"] if "version" in nic_port else "Unknown",
-                "firmware version": config["firmware"] if "firmware" in config else "Unknown",
-                "deviceBusType": bus_type,
-                "deviceId": nic_port["serial"] if "serial" in nic_port else "Unknown",
-                "pmd": config["driver"] if "driver" in config else "Unknown",
-                "speed": nic_speed or "Unknown",
-            }
-            all_nic_info.append(dut_json)
-
-        return all_nic_info
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
+    @abstractmethod
     def set_interface_link_up(self, name: str) -> None:
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
-            self.send_command("modprobe vfio-pci", privileged=True)
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
+        """Set the link status of an interface to up.

-    def create_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.create_vfs`.
-
-        Raises:
-            InternalError: If there are existing VFs which have to be deleted.
+        Args:
+            name: The name of the interface.
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

-    def delete_crypto_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`.
+    @abstractmethod
+    def delete_interface(self, name: str) -> None:
+        """Delete a virtual interface.

-        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        Args:
+            name: the name of the interface to delete.
         """
-        if vfs := self.get_pci_addr_of_crypto_vfs(pf_port):
-            vf_pci_addrs = " ".join(vf for vf in vfs)
-            self.send_command(
-                f"{self.devbind_script_path} -u --force {vf_pci_addrs}",
-                privileged=True,
-                verify=True,
-            )
-        self.unbind_ports([pf_port])
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
+    @property
+    @abstractmethod
+    def devbind_script_path(self) -> PurePath:
+        """The path to the dpdk-devbind.py script on the node."""

-    def configure_ipv4_forwarding(self, enable: bool) -> None:
-        """Overrides :meth:`~.os_session.OSSession.configure_ipv4_forwarding`."""
-        state = 1 if enable else 0
-        self.send_command(f"sysctl -w net.ipv4.ip_forward={state}", privileged=True)
+    @devbind_script_path.setter
+    @abstractmethod
+    def devbind_script_path(self, value: PurePath):
+        """Set the devbind script path after environment setup."""
diff --git a/dts/api/testbed_model/node.py b/dts/api/testbed_model/node.py
index 40dd7f0666..ae9886e531 100644
--- a/dts/api/testbed_model/node.py
+++ b/dts/api/testbed_model/node.py
@@ -22,10 +22,10 @@
     OS,
     NodeConfiguration,
 )
+from framework.linux_session import LinuxSession
 from framework.logger import DTSLogger, get_dts_logger

 from .cpu import Architecture, LogicalCore
-from .linux_session import LinuxSession
 from .os_session import OSSession, OSSessionInfo
 from .port import Port

diff --git a/dts/framework/linux_session.py b/dts/framework/linux_session.py
new file mode 100644
index 0000000000..2828f52965
--- /dev/null
+++ b/dts/framework/linux_session.py
@@ -0,0 +1,460 @@
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
+    #:
+    firmware: str
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
+    vendor: NotRequired[str]
+    #:
+    product: NotRequired[str]
+    #:
+    version: NotRequired[str]
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
+class LinuxSession(PosixSession):
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
+        port = next((port for port in self._lshw_net_info if port.get("businfo") == bus_info), None)
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
+    def unbind_ports(self, ports: list[Port]):
+        """Overrides :meth:`~.os_session.OSSession.unbind_ports`.
+
+        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        """
+        ports_pci_addrs = " ".join(port.pci for port in ports)
+
+        self.send_command(
+            f"{self.devbind_script_path} -u --force {ports_pci_addrs}",
+            privileged=True,
+            verify=True,
+        )
+
+        if self._lshw_net_info:
+            del self._lshw_net_info
+
+    def get_nic_info(self) -> list[dict[str, str]]:
+        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
+
+        Raises:
+            ConfigurationError: If the NIC info could not be found.
+        """
+        port_to_data = {
+            port.get("businfo"): port for port in self._lshw_net_info if port.get("businfo")
+        }
+
+        all_nic_info: list[dict[str, str]] = []
+        for port in self._config.ports:
+            pci_addr = port.pci
+
+            lshw_result = self.send_command(
+                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cut -d'@' -f1"
+            )
+            if lshw_result.return_code != 0 or lshw_result.stdout == "":
+                raise ConfigurationError(f"Unable to get bus type for port {pci_addr}.")
+            bus_type = lshw_result.stdout
+
+            bus_info = f"{bus_type}@{pci_addr}"
+            nic_port: LshwOutput | None = port_to_data[bus_info]
+            if nic_port is None:
+                raise ConfigurationError(f"Port {pci_addr} could not be found on the node.")
+
+            config: LshwConfigurationOutput | None = nic_port["configuration"]
+            if config is None:
+                raise ConfigurationError(
+                    f"Configuration info for port {pci_addr} could not be found on the node."
+                )
+
+            if "logicalname" not in nic_port:
+                raise ConfigurationError(
+                    f"Logical name for port {pci_addr} could not be found on the node."
+                )
+
+            ethtool_result = self.send_command(
+                f"ethtool {nic_port['logicalname']} | grep 'Speed:' | awk '{{print $2}}'"
+            )
+            if ethtool_result.return_code == 0 and ethtool_result.stdout:
+                nic_speed = ethtool_result.stdout
+            else:
+                self._logger.error(f"Unable to get speed for NIC: {pci_addr}")
+                nic_speed = None
+
+            dut_json = {
+                "make": nic_port["vendor"] if "vendor" in nic_port else "Unknown",
+                "model": nic_port["product"] if "product" in nic_port else "Unknown",
+                "hardware version": nic_port["version"] if "version" in nic_port else "Unknown",
+                "firmware version": config["firmware"] if "firmware" in config else "Unknown",
+                "deviceBusType": bus_type,
+                "deviceId": nic_port["serial"] if "serial" in nic_port else "Unknown",
+                "pmd": config["driver"] if "driver" in config else "Unknown",
+                "speed": nic_speed or "Unknown",
+            }
+            all_nic_info.append(dut_json)
+
+        return all_nic_info
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
+            self.send_command("modprobe vfio-pci", privileged=True)
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
+        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`.
+
+        The :attr:`~.devbind_script_path` property must be setup in order to call this method.
+        """
+        if vfs := self.get_pci_addr_of_crypto_vfs(pf_port):
+            vf_pci_addrs = " ".join(vf for vf in vfs)
+            self.send_command(
+                f"{self.devbind_script_path} -u --force {vf_pci_addrs}",
+                privileged=True,
+                verify=True,
+            )
+        self.unbind_ports([pf_port])
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
2.55.0

