Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C5CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 18:14:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 309B6402B0;
	Tue, 23 Jun 2026 20:14:55 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id B3644402A2
 for <dev@dpdk.org>; Tue, 23 Jun 2026 20:14:53 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-922951391d6so8470185a.0
 for <dev@dpdk.org>; Tue, 23 Jun 2026 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782238493; x=1782843293; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCFyQSMZ6n2bkSaxDKGRzPBC4ETg0tXyYyy0LKVgBNU=;
 b=Q+YWNX+ccvUByZkgeFSAAeU1Q2U3SE/+bTrlGwEbwFeTc4PnufNL0NEtbkbBh8j+AL
 j9yi7w6EZBdkdgU/0TWx8twMgMtOdt6l5Ou1VcI3zV6GlRK/IAU5COhcnlHmEXHcl96J
 EA2VmYA7e5e9+749osIU3f0DVHSOWTm04P6CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782238493; x=1782843293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YCFyQSMZ6n2bkSaxDKGRzPBC4ETg0tXyYyy0LKVgBNU=;
 b=C91pA9dNxXk5vbLiVjE4nNcTGC8gQF3cjTly+IWBV+jBCLQy2w/4r8oG697bupHYAo
 8b9mG4oRQ3CCs/lH7uD/VOGtN3SeiAhckaUjweMmorS6molC+eUOfusV4CT4s9p9p/2S
 MTZbYM13AV5OAF8WuBR48iAYKNaa87UfT7BZp3eQYq5hNxPPrHWqz7dSSo4O692BFlLH
 AU/s9x5z/7ej1C17VZVCVr8HV7OQ8q5Wrzdb4LIJ44oP7iHK39MccmFJe5c+T3MeoRhJ
 6CnjGvnZgsGZk4ewjfOvsf51kKcFuEH+7gWzpJQdC9cqs0CsApsERgb0bqSxD5ZVhpvF
 zZiQ==
X-Gm-Message-State: AOJu0YwOgi7CoQ1yih2TDPNXVXjR5sG8L6vdWNeRX7nYOiCGn6CGRB71
 gBmSnDHuJXrKYoDsEMUQqdywsw5xJEvpK3KD6nUPibWr82/4RBysLuMd5eDKbc61FYg=
X-Gm-Gg: AfdE7cnuw6hnXMTszdt5KMLTCwh/V6jHsE9TmNtl8+dMky75wanAkCxPHqwG2zo+sH4
 ACylWF6zSBruV0xU4s0RM8Okwdl5lPesIf260sGF3NPDESBq01hpjjYCs/2U+EmrTxzW11btgUe
 FFV4k/UtMAFjKeOSrgXxUvjaeHMwhMc3RLPCYUzgwkPu6ILeLJfH/eAbM+BEQ6/kOJ0rz0qQbyr
 IXyxEgszcyK9rPIE+kR9BHH4AT7Vgym8CZH5SXT2Zv8NqVWs9U1Qsr776y+bxothf7jXQ61ZXev
 sLV++oTuMW8hXfu1Nj4+aDy/ivBy5ioqS6fYp9wXKv9DD2sIJpzzfFKQE17x/QxGmEoHgzA27os
 8Wqd+azbp3E6DSH59ARF9/Hcl3KpV4SVh7Eyn7ataoy0OyaIrQH7XiPhApvW1FEYtWcMg6Y5tTy
 irbZqJ5xk3GXaajKn8Mw5QGPwdt7bLlNcnU460J3CwkYE6NsBw7TVeX0Msp9eoMMzlE/5zFmZv8
 DKu7Y+yrUX8GyKDtvO61doguOvB/1BPgmYZmV0XAu/qREwDjcsfwjfvzBzFyddWMuLXBtAomnH4
 1qC9CSWW6hbEsQ==
X-Received: by 2002:a05:620a:4729:b0:915:cb40:f76a with SMTP id
 af79cd13be357-9278086b791mr27828985a.39.1782238492747; 
 Tue, 23 Jun 2026 11:14:52 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd39106asm327479185a.7.2026.06.23.11.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:14:52 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v2] dts: report dut/NIC info during DTS run
Date: Tue, 23 Jun 2026 14:14:43 -0400
Message-ID: <20260623181443.1624584-1-knimoji@iol.unh.edu>
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
index 30c89ad70d..5f4b78cf1c 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -197,6 +197,81 @@ def unbind_ports(self, ports: list[Port]):
         if self._lshw_net_info:
             del self._lshw_net_info
 
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
index f2dc9b20a9..a16ba50045 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -581,6 +581,17 @@ def unbind_ports(self, ports: list[Port]) -> None:
             ports: The list of ports to unbind.
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

