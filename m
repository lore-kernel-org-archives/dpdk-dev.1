Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB2CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 16:37:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6043A402AB;
	Tue,  2 Jun 2026 18:37:12 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id DE3E1402A9
 for <dev@dpdk.org>; Tue,  2 Jun 2026 18:37:10 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-516d634956fso133217921cf.2
 for <dev@dpdk.org>; Tue, 02 Jun 2026 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1780418230; x=1781023030; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=APhy5vQGTr483OYKY2sLT56qq+XidqydFyGN5294w2w=;
 b=dH39QSoJwkigLKxwYaFRIanzoUh6kJAn1VKRnohBTKkwHsd80GqlKtdWGfjCH5BCPK
 /+wG9f78Z7ea5IwgHpkPeMvLc/7sGxh7QrzIKe1PhH5efW7smeMjg9mOJr5gQfMUnWnT
 ZZxJBPulpJFwwjp8bESN0Vqu7brbnhoqjnvaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780418230; x=1781023030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=APhy5vQGTr483OYKY2sLT56qq+XidqydFyGN5294w2w=;
 b=pGqLwJ/YyaAMkhAlda32QJNF6TZAhewMfPDvRQdkA5Z+efhbrfYarPITRy9IilH6T2
 RrTykyckGtOrVwAGyYo1OWzbmnBNJSFTF0jUcOF1OHgznsVo9bGmMnK9k17couc75ff3
 znrLWWlFydQ54NuLUXsSp7Ovrn9sQ4miJavPQj3r5ejZ9VeY13TDNQ8IxTU0yA5JEj55
 akajeGPbU9tq9C86QhlL++pfcoMQ2kMWq/XtiXnQhktK+ihdp/bqzZyOIp82KH+Hx8vM
 XrEfAghJ41XvbTBzzjoxiSWsl07JvSsrKV93CW2zF1bIU8JzTJSsbIlqFgWq0k+sM/27
 pzOw==
X-Gm-Message-State: AOJu0Yy1bdFO+RbqT1E/39NP94AjkXJucQBP0EOnsCbeRmARcUmva4bk
 RMUKeQ408tX1OTmWrc1c4JczlswbaqQliSxWxhm/66fIzCdUsNprL31Ps4iEiB+ZKo0=
X-Gm-Gg: Acq92OHSiov9+BTCbPIZtKNc9J2nyxakz6Dumgf1LIao2NvwDGaLsMyKWDQovWtwqWo
 GpHchrO+MpWJZoACaGKb677CHbKIDusiKrgeZ1dwQWHdSFZM/Pz9FoVDlHLu6hg3uSj8BKWB4nj
 PiyU0b5omR1APmDhkbgYXETskvKy0yPbiEc7KCgkbsfQhrTWRkDDqUoYv9LPyUPu1RRugaOB8lX
 LUyBNMqlIlSy5+ch0ZxtAQyPGQaXynBKVsPOU2RS88mahagSffblWX7Ix+0FPZNB+gJu5aK8cyC
 YW94hoReOyHhLs9goMsfJhV5z+utQfdwxjP52zm/EdE3J3ckCqln5OLCaUIkLJlJ1Y3eOUBlIk3
 SQ9Z/sSu9QUJo3UfVb5aEujsFpKK3+zW/KjfOb4iz47EcLpVIowUvXskfXZcMoEmWXJqhEk/h/u
 cDdlkCglzVihlCS1zE2PebKU8uOnbzwpV//tqe6rv+Yy2sA6tv1NYfKtwiV62owSH+4hjsl/KKr
 J0KDyeZEZ/R3Rm4zMBnjikMFEbNC50Ke5ndIWdVERAxzqH9XDHTncl+lm4ay+E=
X-Received: by 2002:a05:622a:2505:b0:50d:9b4a:e6f with SMTP id
 d75a77b69052e-5173a5e8040mr237484641cf.1.1780418230064; 
 Tue, 02 Jun 2026 09:37:10 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1257::1006])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775e25c5dsm2533651cf.30.2026.06.02.09.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 09:37:09 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.edu, lylavoie@iol.unh.edu,
 Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v1] dts: report dut/NIC info during DTS run
Date: Tue,  2 Jun 2026 12:36:47 -0400
Message-ID: <20260602163647.101815-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
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

This patch gathers NIC info during a DTS run and writes it to an output
json file. This allows the json file to be used when reporting results
on the DTS results dashboard.

Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
---
 dts/framework/test_run.py                    | 10 +++
 dts/framework/testbed_model/linux_session.py | 75 ++++++++++++++++++++
 dts/framework/testbed_model/os_session.py    | 11 +++
 3 files changed, 96 insertions(+)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..eebea280d7 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -98,6 +98,7 @@
         "InternalError" -> "exit":ew
 """
 
+import json
 import random
 from collections import deque
 from collections.abc import Iterable
@@ -370,6 +371,15 @@ def next(self) -> State | None:
         test_run.supported_capabilities = get_supported_capabilities(
             test_run.ctx.sut_node, test_run.ctx.topology, test_run.required_capabilities
         )
+
+        used_nic_info: list[dict[str, object]] = (
+            self.test_run.ctx.sut_node.main_session.get_nic_info()
+        )
+        with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
+            json.dump(used_nic_info, file, indent=3)
+            file.close()
+        self.logger.info(f"DUT NIC info written to: {SETTINGS.output_dir}/dut_info.json")
+
         return TestRunExecution(test_run, self.result)
 
     def on_error(self, ex: BaseException) -> State | None:
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..2269fe60ae 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -181,6 +181,81 @@ def get_port_info(self, pci_address: str) -> PortInfo:
 
         return PortInfo(mac_address, logical_name, driver, is_link_up)
 
+    def get_nic_info(self) -> list[dict[str, object]]:
+        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
+
+        Raises:
+            ConfigurationError: If the NIC info could not be found.
+        """
+        port_data = {
+            port.get("businfo"): port for port in self._lshw_net_info if port.get("businfo")
+        }
+
+        all_nic_info = []
+        for port in self._config.ports:
+            pci_addr = port.pci
+
+            command_result = self.send_command(
+                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cut -d'@' -f1"
+            )
+            bus_type = (
+                command_result.stdout
+                if command_result.return_code == 0 and command_result.stdout
+                else None
+            )
+            if bus_type is None:
+                raise ConfigurationError(f"Unable to get bus type for port {pci_addr}.")
+            bus_info = f"{bus_type}@{pci_addr}"
+
+            nic_port: LshwOutput | None = port_data.get(bus_info)
+            if nic_port is None:
+                raise ConfigurationError(f"Port {pci_addr} could not be found on the node.")
+
+            config: LshwConfigurationOutput | None = nic_port.get("configuration")
+            if config is None:
+                raise ConfigurationError(
+                    f"Configuration info for port {pci_addr} could not be found on the node."
+                )
+
+            command_result = self.send_command(
+                f"sudo lspci -vv -s {pci_addr} | grep 'Engineering changes'"
+            )
+            hardware_version = (
+                command_result.stdout.split(":")[-1].strip()
+                if command_result.return_code == 0 and command_result.stdout
+                else None
+            )
+            if hardware_version is None:
+                self._logger.error(f"Unable to get hardware version for NIC: {pci_addr}")
+
+            nic_name = nic_port.get("logicalname")
+            nic_speed = None
+            if nic_name is not None:
+                command_result = self.send_command(
+                    f"ethtool {nic_name} | grep 'Speed:' | awk '{{print $2}}'"
+                )
+                nic_speed = (
+                    command_result.stdout
+                    if command_result.return_code == 0 and command_result.stdout
+                    else None
+                )
+            if nic_speed is None:
+                self._logger.error(f"Unable to get speed for NIC: {pci_addr}")
+
+            dut_json = {
+                "make": nic_port.get("vendor"),
+                "model": nic_port.get("product"),
+                "hardware version": hardware_version or "Unknown",
+                "firmware version": config.get("firmware"),
+                "deviceBusType": bus_type,
+                "deviceId": nic_port.get("serial"),
+                "pmd": config.get("driver"),
+                "speed": nic_speed or "Unknown",
+            }
+            all_nic_info.append(dut_json)
+
+        return all_nic_info
+
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
 
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 2c267afed1..4d5ba0e7f6 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -573,6 +573,17 @@ def get_port_info(self, pci_address: str) -> PortInfo:
             ConfigurationError: If the port could not be found.
         """
 
+    @abstractmethod
+    def get_nic_info(self) -> list[dict[str, object]]:
+        """Get NIC information.
+
+        Returns:
+            NIC info as a list of dictionaries.
+
+        Raises:
+            ConfigurationError: If the NIC info could not be found.
+        """
+
     @abstractmethod
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Bind `ports` to the given `driver_name`.
-- 
2.54.0

