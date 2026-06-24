Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510ECDE000
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 21:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7423C40279;
	Wed, 24 Jun 2026 23:33:46 +0200 (CEST)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43]) by mails.dpdk.org (Postfix) with ESMTP id CB5DC4025E
 for <dev@dpdk.org>; Wed, 24 Jun 2026 23:33:45 +0200 (CEST)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8de88d06509so3154136d6.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 14:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782336825; x=1782941625; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WqsR+SCWuhfUPxo70rBbp11zVfDK4aWZX0fxAsUpww=;
 b=hl6VmTTWkdH+HLcJp4Jg7ef/CrkswOfuaB0+aPO/0N9k/cLlaYzrdYwpEMtYUDRDOd
 tMMg61iLDN5UTTkN1PCEV6VFMl00nn5ZCSCIPJck0QeeZR6NfJmOXD05Li8zovqcmxJL
 63pX1DynhXjsdIwkrBIp4+temKDgIzwMpThmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782336825; x=1782941625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6WqsR+SCWuhfUPxo70rBbp11zVfDK4aWZX0fxAsUpww=;
 b=bnMNp0PL0OCzKr6dGD9MIXf6omXWA5pby831okEDoLrkcnunfJLoVwOPWXllvA7zhC
 wqLBGKLR6BGrmsUlFmi2P6cr4bKFp7kaoS/+i0Hych95D53kMy2q+cFiZH0zsk53XySt
 mxjQk+OUxeRICuVQkgZVHVQdz2mee9i9Qz5dWeQQfcWCQUXUOUVTbdZ6pF6rgn6UymIh
 AtaaM0T9NbQnS1SL2XwUFWNth2WyPPoMI8Kszk8z3m5ktdOGowYEBm1noSOsFSunSL69
 EN9TNiUxGfstBAQx24m/xETvw6bCvZQtB8sfXpgL40sa2KOORVFjrAyE62WmXi3izZnq
 z9WQ==
X-Gm-Message-State: AOJu0Yys1Z8L2JSEJv/LFe/GZpIz1hCtYNYSwMdt+9sBYPXEaB1B3Wvi
 6+JBSs3SjesH7UGfpCH5QO2z2DGnOjhlRG94CkJ35YWqV+RDrahyOK9wJ/SX1FayCtk=
X-Gm-Gg: AfdE7clAiRmN4MRb2BrbOI4Hf4M1qyS1lwA7r9ebHj+Mx9KKgxY2FHtfyjx6TCcfDB7
 CbHzUp32r/IWudww8IkhvbLLjt0KDJsmysn50wIs97PCzxRZ0HL4ttFtEbd1nlVtJqyHVi6hAh8
 Cm+9n1BOVzSJI45qBxS2a3aCLC3cpbqAZOwUwgIL9GQnKIYfH8CEwR0ECPC9O5osKwGOVl4omeq
 HwjtmwOtwHUAZq4RPRkmi7InnFlGnDfBstEM3vy+9VpSSCZMsblS4+NQo3TbrgMrE5C+kbxWFTk
 DW77L6j0YseK7XTb8zIiFmyUqX8Bm5x4XwG4lIOUYkyWAc7Ucd+RzFY8n3ImHqUNkX7jT1wltNN
 wJWluP+KB9n6pKp5YLJCVDaigb03/YSDHb1IAxtudK5MRyUvWIbvkQZ/aCquamfuNvx0tfGShRY
 0u+Cqm1z5VUSYzfJvXrSE8OhPgpUgKhgkRt0fT2GSOzjtlI39VHGqeRiIKgJpKmDZDAKEITLIbN
 75Rwj5Qlp0b8KWqzIijM5XlMalwzzhEkJPxnj+oNXAFxppnlbsB4+TOaBNUkIDU09EYWEJ/WcOU
 rnJ3QWiDhJnSEw==
X-Received: by 2002:a05:6214:410a:b0:89c:8353:1fa0 with SMTP id
 6a1803df08f44-8e3b44478dfmr158931336d6.4.1782336824866; 
 Wed, 24 Jun 2026 14:33:44 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cde9ecsm165494326d6.24.2026.06.24.14.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 14:33:44 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v4] dts: report dut/NIC info during DTS run
Date: Wed, 24 Jun 2026 17:33:07 -0400
Message-ID: <20260624213307.2095056-1-knimoji@iol.unh.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602163647.101815-1-knimoji@iol.unh.edu>
References: <20260602163647.101815-1-knimoji@iol.unh.edu>
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
v2:
    *Resolved merge conflicts
v3:
    *Fixed an issue with retrieving
     the NIC's hardware version   
v4:
    *Moved nic info gathering step before the nics get
     binded to their respective drivers 
    *Condensed some areas of code in order to make them
     more readable
    *Removed redundant None checks and added some where
     required
    *Fixed LshwOutput class to better reflect the lshw
     command output
---
 dts/framework/test_run.py                    |  8 +++
 dts/framework/testbed_model/linux_session.py | 68 ++++++++++++++++++++
 dts/framework/testbed_model/os_session.py    | 11 ++++
 3 files changed, 87 insertions(+)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..c92fe90f2e 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -98,6 +98,7 @@
         "InternalError" -> "exit":ew
 """
 
+import json
 import random
 from collections import deque
 from collections.abc import Iterable
@@ -347,6 +348,12 @@ def next(self) -> State | None:
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
 
+        used_nic_info: list[dict[str, str]] = self.test_run.ctx.sut_node.main_session.get_nic_info()
+        with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
+            json.dump(used_nic_info, file, indent=3)
+
+        self.logger.info(f"DUT NIC info written to: {SETTINGS.output_dir}/dut_info.json")
+
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
         if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
@@ -370,6 +377,7 @@ def next(self) -> State | None:
         test_run.supported_capabilities = get_supported_capabilities(
             test_run.ctx.sut_node, test_run.ctx.topology, test_run.required_capabilities
         )
+
         return TestRunExecution(test_run, self.result)
 
     def on_error(self, ex: BaseException) -> State | None:
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 3a6e97974b..9e9146c372 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -38,6 +38,8 @@ class LshwConfigurationOutput(TypedDict):
     driver: str
     #:
     link: str
+    #:
+    firmware: str
 
 
 class LshwOutput(TypedDict):
@@ -61,6 +63,12 @@ class LshwOutput(TypedDict):
             ...
     """
 
+    #:
+    vendor: NotRequired[str]
+    #:
+    product: NotRequired[str]
+    #:
+    version: NotRequired[str]
     #:
     businfo: str
     #:
@@ -197,6 +205,66 @@ def unbind_ports(self, ports: list[Port]):
         if self._lshw_net_info:
             del self._lshw_net_info
 
+    def get_nic_info(self) -> list[dict[str, str]]:
+        """Overrides :meth`~.os_session.OSSession.get_nic_info`.
+
+        Raises:
+            ConfigurationError: If the NIC info could not be found.
+        """
+        port_data = {
+            port.get("businfo"): port for port in self._lshw_net_info if port.get("businfo")
+        }
+
+        all_nic_info: list[dict[str, str]] = []
+        for port in self._config.ports:
+            pci_addr = port.pci
+
+            command_result = self.send_command(
+                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cut -d'@' -f1"
+            )
+            if command_result.return_code != 0 and command_result.stdout == "":
+                raise ConfigurationError(f"Unable to get bus type for port {pci_addr}.")
+            bus_type = command_result.stdout
+
+            bus_info = f"{bus_type}@{pci_addr}"
+            nic_port: LshwOutput | None = port_data[bus_info]
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
+            command_result = self.send_command(
+                f"ethtool {nic_port['logicalname']} | grep 'Speed:' | awk '{{print $2}}'"
+            )
+            if command_result.return_code == 0 and command_result.stdout:
+                nic_speed = command_result.stdout
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
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
 
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index f2dc9b20a9..f88427a53d 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -581,6 +581,17 @@ def unbind_ports(self, ports: list[Port]) -> None:
             ports: The list of ports to unbind.
         """
 
+    @abstractmethod
+    def get_nic_info(self) -> list[dict[str, str]]:
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

