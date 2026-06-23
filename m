Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCEFCDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 18:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C69402A2;
	Tue, 23 Jun 2026 20:49:15 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id EC2654029D
 for <dev@dpdk.org>; Tue, 23 Jun 2026 20:49:13 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-920fbdffa31so7134385a.3
 for <dev@dpdk.org>; Tue, 23 Jun 2026 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782240547; x=1782845347; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Dz0zM0yBFY/F1N4YJLlBI/vwTaZ6QDyLlCUnIlJ7lY=;
 b=L4fS0pBw2oBL9Lu58mdBrTOhnqzZFSyxU2pm4V/j2Lui+Mt7tVHWMJRYejElPNV3vu
 ZGEtDNF2AKM/h33C32f4RUVgVZ8NlVjOaRHz1MHHsRMgCshnNYdLIYP+Z6eLbGs/WbjP
 MTl0sdP5XwibV3AT2gnHTfbn5DgdSvbYJGXfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782240547; x=1782845347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Dz0zM0yBFY/F1N4YJLlBI/vwTaZ6QDyLlCUnIlJ7lY=;
 b=BfVLfQZPYxIQ0bx/PdIJUEs2HsNsllQMYoB0ARw/PA7cvu37JUVzTn3L5sG3Yk1mV5
 ILATgk47TEM0E6xog05lEAMLX4TE2vc5akwqaabIeTEuTs6ZBLJXXx4pHI0nrxon7fAK
 3Nv9WZGTedB4E1/PIoK42/toCVs8G0ET7xEZf/KIpO9AtY+BdhiDqzkoahcsLWTsjKm0
 6LaywaeHNU9rzQeh3qyuaqrWLlPw33CCGY4Mlg7ClKiUgr5f9R6f4QoXRT2pyEysU1DU
 /BrOpkrFXB285leS+AA17ID9B3Gx58AsaCtInfs1v5IQcxGRq5eQQbyXjW/pHcsqSESE
 C/Kg==
X-Gm-Message-State: AOJu0YyaxJ2B48K7RRThvllqtLX84ADFLIoM0yeQi1OQIkFx66JQ58qf
 RDb91Mk4tqLmftMyF0sO1VKF6dUJOgX2U15EwOlv+E11ziGWVm3Nczjl2AiZRqp5oO0=
X-Gm-Gg: AfdE7ck/4S0gQMggCxOjK575raJjjBDvh0n24eDVUVU7p6VRL5cXdHXW6HXLHnHYWRG
 T/8zUn+v8i56R2u3drCdCyK9Sv0JgMNOLsZfosa4PdD82/N2EIgPNad941NAbVDX03S/8qCXdFQ
 UD9Y8cDEJB0gipcakH3d3ROub52t74dYAURbdLomFgq3JbYvxlYTkKO88/cDcCrPB/urFval3oJ
 BHirIYXWW53kYdF3rgrxInsL+jIJYeWUxtqCwpoNP9uYdp7QnPzjNu2S0BxvLsm9sN2hwfl0LgG
 UcifaR3Rf4eLvrqZlv2mnvadrM/as3iWgfhVYJN0zELLeSGFg/A5L3p57n82qnGn8MgKUO+aoed
 hP56dGqlgMwbh0IM7SHakbREoP/T2fwDsy8XWN3OFpJ5ks62y9FBSMdNyMF/9BOKYfjDAAfdjLX
 KLExgyCGeOqkz8pMZhZXr8+O9jct/dZ0MS4zgsVORQoXQk9Wq6WVTOxu5lBivJyj2Z4i+g/YN07
 HtUq4AVfWC+DJbjl0FkT7veheldxm4QIOo+QUHl33x2A4+/ibWoHtKGLWqywRa6Zz7RPfO7wCj+
 UrQ5DFag64cl3w==
X-Received: by 2002:a05:620a:2545:b0:915:d443:e6db with SMTP id
 af79cd13be357-92644cf5954mr705821085a.20.1782240547402; 
 Tue, 23 Jun 2026 11:49:07 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92600b83658sm344401785a.43.2026.06.23.11.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 11:49:07 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v3] dts: report dut/NIC info during DTS run
Date: Tue, 23 Jun 2026 14:49:02 -0400
Message-ID: <20260623184902.1657251-1-knimoji@iol.unh.edu>
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
---
 dts/framework/test_run.py                    | 10 +++
 dts/framework/testbed_model/linux_session.py | 64 ++++++++++++++++++++
 dts/framework/testbed_model/os_session.py    | 11 ++++
 3 files changed, 85 insertions(+)

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
index 30c89ad70d..67eba33ce8 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -197,6 +197,70 @@ def unbind_ports(self, ports: list[Port]):
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
+                "hardware version": nic_port.get("version") or "Unknown",
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

