Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C916C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 13:48:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58053402D1;
	Thu,  9 Jul 2026 15:48:19 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 65A1040268
 for <dev@dpdk.org>; Thu,  9 Jul 2026 15:48:17 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51c08df8513so11060911cf.3
 for <dev@dpdk.org>; Thu, 09 Jul 2026 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783604897; x=1784209697; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TNosaBrsNWw3aNhEXWBJSIkAPxcVUzhDWFfLX+nn8to=;
 b=IMalySw5wbQBczmCeeA9jVn7YUAkiNnI+lYrLvERZtWNh5meW11RSOnDDoAL0hzHiJ
 VXRPoIyR3Gk4V3Fx6OYnhuFOc1NUS1DPyAxuch8Xu6Xak8pYxBs95+OERjDhTJkCOEvn
 v7cqGJGyCAcMS6FAvcq9/vTOwjGO+1aw0OnKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604897; x=1784209697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TNosaBrsNWw3aNhEXWBJSIkAPxcVUzhDWFfLX+nn8to=;
 b=Q9tO6gnuMLGFVsew3m7WRL19AiEutLzRN9I90GZ/YZWW3OYCbGuPFOxukVB4ad1hHw
 OJC/Z95wRr1/8fBXNAeal12gb68gqvRIp+kLcTX5ULfeVWX+fC0VPMNECORRbN+sMbW2
 iGLNaT4y2/4tIkYrz1Awf4F/a6cn2EsVegVPpKJFtxLSrNzgXlcY5+VDqTYFH8hIdQ0+
 0hdk9R9tglEO7a+hTGLFTWAbOMwPwlyJG1eP7NLAaUSTHN+uNDf+8ZMeBclOuZLLC4Ah
 SWPpGJ+zNAq13TSD9durzsmahZXt6UMqbDockUJw20hJKP+kT4vKfx1AeHtiD/mMYLRT
 TYlg==
X-Gm-Message-State: AOJu0YxsJsoAU8PZw5UfiVYuUitzAbOsvjaT/2DToDlesY4lREcheGea
 El1OK+9TfMAdtlJGZC4DQO0I6cXaPPCjHLuFDJtthadRC5D4kTpOTw84rFQP9q27iJjl7mIR+Jw
 1ag40cdY=
X-Gm-Gg: AfdE7cnxFmEc1ckR6mu+RyDL6VdL2dcHLQ55xy4PK5e5ML6P0OAWlazr5PfQaSGlCYA
 qRwSjwgz3eva62ZrJnbSjEKdMvlGg4PMB2NqZjY7lK4B2hbUvJV3aGervfjDD7v2Q6v2Ub1tIkJ
 BnVUzDpC6gKtga19ATQYEJyjoeCIFb44LPmB48I50SWUvTbZwsO6sGd+lmyDFT7xYY6hAtqlJTO
 9f7eBnVTJRQoEtuSEQHhQ2S9O9lc0IhMKnQlCpBmJ0pDkEKSjBRPjyFpGBGIYXnmM7/GokaAKqt
 EZ21/6VUids3we2oPgRcqgqjxNP7WttQNsSd9kjTMOpaGvpg4W2eE2JZ0XTXAi5GAP/Z0NI4di9
 RU3/QeQIEt8X1/+5AW/LBCrtEsI38HNG8h8fhdTPw+bCGZi0aJGdwCu9EEe6ggBkqy9l0tEtojr
 5n+AgOS+dJ2pMjozKxVJyTf/Pt6feXQEB1ghxPFrz+ZecLBcE6Efx0y9DUODdGi6zrh6gZZUpGo
 5KINABAKexPEypFBm6jRMKhEqiYY639sRqvtcBnlWOeO7TrnkK7ITczZqE4jqAkwipmj7CzmWCm
 R+sCIilKyGl/LYOxN0kTw40=
X-Received: by 2002:a05:622a:1b24:b0:51c:811:b36e with SMTP id
 d75a77b69052e-51c8b420cd6mr74255541cf.72.1783604896517; 
 Thu, 09 Jul 2026 06:48:16 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:af2f:903c:2ca9:975f])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d78101sm157211681cf.20.2026.07.09.06.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:48:16 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v6] dts: report dut/NIC info during DTS run
Date: Thu,  9 Jul 2026 09:48:14 -0400
Message-ID: <20260709134814.805721-1-knimoji@iol.unh.edu>
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
v5:
    *Changed variable names for code readability
v6:
    *Fixed command result validity checking logic
---
 dts/framework/test_run.py                    | 10 +++
 dts/framework/testbed_model/linux_session.py | 68 ++++++++++++++++++++
 dts/framework/testbed_model/os_session.py    | 11 ++++
 3 files changed, 89 insertions(+)

diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 94dc6023a7..fea1b52e44 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -98,6 +98,7 @@
         "InternalError" -> "exit":ew
 """
 
+import json
 import random
 from collections import deque
 from collections.abc import Iterable
@@ -347,6 +348,14 @@ def next(self) -> State | None:
         test_run.ctx.dpdk.setup()
         test_run.ctx.topology.setup()
 
+        testrun_nic_info: list[dict[str, str]] = (
+            self.test_run.ctx.sut_node.main_session.get_nic_info()
+        )
+        with open(f"{SETTINGS.output_dir}/dut_info.json", "w") as file:
+            json.dump(testrun_nic_info, file, indent=3)
+
+        self.logger.info(f"DUT NIC info written to: {SETTINGS.output_dir}/dut_info.json")
+
         if test_run.config.use_virtual_functions:
             test_run.ctx.topology.instantiate_vf_ports()
         if test_run.ctx.sut_node.cryptodevs and test_run.config.crypto:
@@ -370,6 +379,7 @@ def next(self) -> State | None:
         test_run.supported_capabilities = get_supported_capabilities(
             test_run.ctx.sut_node, test_run.ctx.topology, test_run.required_capabilities
         )
+
         return TestRunExecution(test_run, self.result)
 
     def on_error(self, ex: BaseException) -> State | None:
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 3a6e97974b..c118f803b6 100644
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

