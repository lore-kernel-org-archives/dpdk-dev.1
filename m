Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDD1CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:47:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A708540616;
	Thu, 25 Jun 2026 17:47:57 +0200 (CEST)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9243A40430
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:47:55 +0200 (CEST)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-91563abd6a9so1778585a.3
 for <dev@dpdk.org>; Thu, 25 Jun 2026 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782402475; x=1783007275; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSN67rq0QzhmNegrYAuLuM9hvmbDntg1PoLh/BGE6fQ=;
 b=BH4iL1l2WGzTVYNhB23Ht/8Uwigw2fIXjGsGRTmuwlnuK5Euzqzxlzj85rQoRvxbMe
 x/0cHbLRftanneQNRab19JXxrZz8Vh9AVQ2KOEH5HklvKfV8bzNFC45JivGWmLc5v3nZ
 xbNXXsOi9dZuYORlDYemPbixbRSS74GD4SNxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782402475; x=1783007275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nSN67rq0QzhmNegrYAuLuM9hvmbDntg1PoLh/BGE6fQ=;
 b=FMvxYOMSUyFSSCrtGKwYHgm2pPmlPSvd2BghPlCyfqn/nWpP5B7sqLkdwkSLptl+ci
 E/z/b0rhWRqFjqt9+vopYuc9TbTvpE0/wv1H34AG1elzGAoJT84/RP9e7n0vS9sf2ipW
 4BiKBHUneUg7EcxOwa5Z4yIlJfpPcW5dt8pV+2tM/JL4XBBRqrrRbeJMs089xQwL3AJ1
 6BDKaFTeazMXaC70LmB/QoCdtzSXOu5+3ZG5KFZboG82IQKk3BelOzFTBv6SOEKk9Pd0
 tRThepmdJYcki3f3CUreUyk/3gtmbslTe7ZQswi5GqbuAFj7wgDljZf563+BMDxwZSn4
 7+3w==
X-Gm-Message-State: AOJu0YwB/zR5fFEtrFTPEeISreYcBsWRsDvwBgOn9iQL8dr249W+TEoT
 lJyBFn9ul6/6QCFYPYZBUjSWbhiVYoSKDwPLwh24XTxJyddXR1PjLxcShvi4Wv9PtOQ=
X-Gm-Gg: AfdE7cm+69ckkUYVyTXdEGSN2DX3g9+Be0d4ZBOLIrbol/Eh1y1mJX3sV83EZU4kpz+
 2FYWueotkLCfqseG9vV1PD8g5zOR/7ZLw7IdYLXnR9rIsnfbLkAHgmnvvyoPsOgupyPMCGYPLlw
 Wzq4LfbSXmyYgwbpkVlJd2rwmFIsp7xL/IyMlNuXlMpJNEQ3n7SgAFGihysQ4OK+FaoA0pxZjlc
 TdSr715eRV0LR+VfvgO2kHwk4vamvveDWrpJUC0+jKNPalLvb6kJKiyNAahA+h39/XulHheg8W0
 YKRbsehi4KEScp/KgmQph1SFvFyv/MT+MyXnh0Qc4SnvHg8NAl8XqwxJHRLEX09v2/VG7ksxfEC
 XhroFlUToecq8vDFUwcdhAOew5QWoBXXMkG8DZCF45bfHKSApe2u62uYWIogtbh5O3f/yGMhjSg
 /FsayUIFZja+tOVaymv3l0IXk7cFTgGe2iqYQmT+i74PaoHMVyjiYTHeKtx5S/vfR5NqrwMEbsY
 MkcHjo4Qwhk7oRclXRreHMEGvZ+g51SiJwXcrgMXB7Sh84kOXDbCRf/te1zY16nww8SADO+lbN1
 lXeHGs8cXYiRqw==
X-Received: by 2002:a05:620a:17ab:b0:922:f2c6:b79a with SMTP id
 af79cd13be357-9293dfc7fe7mr468342585a.48.1782402474731; 
 Thu, 25 Jun 2026 08:47:54 -0700 (PDT)
Received: from d122166.iol.unh.edu ([2606:4100:3880:1220:ff12:f4a1:a541:db45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df82692bddsm183183096d6.43.2026.06.25.08.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:47:54 -0700 (PDT)
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: dev@dpdk.org, abailey@iol.unh.edu, ahassick@iol.unh.edu,
 lylavoie@iol.unh.edu, Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Subject: [PATCH v5] dts: report dut/NIC info during DTS run
Date: Thu, 25 Jun 2026 11:47:12 -0400
Message-ID: <20260625154712.2255474-1-knimoji@iol.unh.edu>
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
index 3a6e97974b..b8836effbe 100644
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
+            lshw_result = self.send_command(
+                f"sudo lshw -c network -businfo | grep '{pci_addr}' | cut -d'@' -f1"
+            )
+            if lshw_result.return_code != 0 and lshw_result.stdout == "":
+                raise ConfigurationError(f"Unable to get bus type for port {pci_addr}.")
+            bus_type = lshw_result.stdout
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

