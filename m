Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D30CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 16:37:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B52314027C;
	Thu,  7 May 2026 18:37:46 +0200 (CEST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id BBDA34026A
 for <dev@dpdk.org>; Thu,  7 May 2026 18:37:44 +0200 (CEST)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-899a5db525cso6969426d6.3
 for <dev@dpdk.org>; Thu, 07 May 2026 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778171863; x=1778776663; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3CWHwHZZI0Ocpf7ofys89reZTyQbqMDx/WocC8GAmj8=;
 b=CCXZCcm/qvknXxxWVd4zMz9br9bSmKdtbsTY1vZmuJqa0K1fX5V+LcejIkYxFFl3gq
 PavCXw50iZTJtWq75+FOqkqZ5W4c6tHqbOjD95pcrjs+3naD2Tl3rrDiJyibb5qKOUua
 CXbSIz0m1EoZ0SOagk2xKSxJv6W6Yx5qTaS2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778171863; x=1778776663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CWHwHZZI0Ocpf7ofys89reZTyQbqMDx/WocC8GAmj8=;
 b=EKRA1DbmiQhgsaVueLYUnXyzolbcpK9L9vtDJhFz4CbpHgQVPowrIhRYY7Ds8Kn84z
 9sJ44F68z/4j4QFdezbt5dv8IQ2HycXWEgtMVwKW+eTrv84JJvCg7XmhFNix/N8D2yXc
 BnVA/KngTHiYTBWzsaQsUqg0U38L/X+NeWvXJfr1+yLB6nbuHK2X+RE0pQxxEuS7cIw9
 j98OmMFNEANX8T9wX/mNN1xcI2Fx8gRN5qHFzOofnAqfTpHuf79ta7garibmFnHI/wwh
 ZyulympB8ibwsqysXgTx2Bf6JuLUJf8jbrio87GnBcbDjP0ttQaSRu58hmrauLydsi9v
 naqA==
X-Gm-Message-State: AOJu0YxsZcfojw1RCn07p1wDe9bxYVSkqEjgVDLGbhMxtf90+CWGQ/ay
 7QX5BfuFnyLT5STFLbBbE79BrITK9uiay8404f0fRsDYgbGbuG1xfdZ6yBN7CYHPzWY8VcOx0xK
 0n1KwX8/aPXn2mo4EHEF8nU0Sofay1ufKBcPd+rKqfUWKm+UnnRY2Duvg/F59O+Uuo1x/FjPpQw
 CG39zGJjZCpZIYwS2tE6sqUUAYbNE=
X-Gm-Gg: AeBDietHYbjoNS7/zqsph1QcfipchWhuKxSSSFxWqqhNzV7UE3mluemuX0rBCELpDjp
 iCJCKAR4c9pWLpNlE9LBjDEuFEH+Y1doXca9kW8wz8yQNt+F1D6PAG5kIQXUkRImwChvoJVEmMh
 73jiRA6NoqdGOQs4FDR0ezzGed4VPB47Z7ojIGjTz/kZoKZDZ++ER1XD15FCtsp/EZqyA1e6jbc
 Tsuhb0vrJbqAUbB8MTsuB7o13Cd2bMXeK6pH8M2rE22svZBHuaFdx8FItFsDJUYPIBNfWeqspsS
 U/XLT6BmElKZ5SLf9MZO7Mv6LBNw+OilSMM5aZmL4GBDcG0sPxpRN0AKtcNyBk0IGaZrSelMo8e
 JiA0CSFIOiXvPWzWRjUv0A6lME3skybXmPJyZipMpu4VmJmYGDiF1amFMsJ03VYE+2BvMBICzzv
 rf4Ypwx9CShP2qbYWlM63BTXUsjASk8Uu5UkQeS/QakFpzG9xu8XrzyVD4yCmmTpjuetS19r/Hz
 r8=
X-Received: by 2002:ad4:5d63:0:b0:8ac:a87b:c81c with SMTP id
 6a1803df08f44-8bc46013e12mr135062406d6.44.1778171863146; 
 Thu, 07 May 2026 09:37:43 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b538b1dbd2sm235728466d6.6.2026.05.07.09.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:37:42 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: dev@dpdk.org,
	luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, ahassick@iol.unh.edu, knimoji@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1] dts: clean cryptodev environment after a test run
Date: Thu,  7 May 2026 12:36:58 -0400
Message-ID: <20260507163659.40739-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
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

Prior to this patch, the virtual functions created by DTS for crypto
devices were not properly cleanedu up. This could lead to a system to be
left in a bad state after running the cryptodev throughput test suite.
This patch properly cleans up the environment after cryptodev testing.

Bugzilla ID: 1923
Fixes: 8ee2df9da125 ("dts: add cryptodev package")

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 28 +++++++++++++++++++-
 dts/framework/testbed_model/os_session.py    |  8 ++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..a5bb34b4e8 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -181,6 +181,21 @@ def get_port_info(self, pci_address: str) -> PortInfo:
 
         return PortInfo(mac_address, logical_name, driver, is_link_up)
 
+    def unbind_ports(self, ports):
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
+        del self._lshw_net_info
+
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
 
@@ -289,7 +304,18 @@ def create_vfs(self, pf_port: Port) -> None:
             self.refresh_lshw()
 
     def delete_crypto_vfs(self, pf_port: Port) -> None:
-        """Overrides :meth:`~.os_session.OSSession.delete_crypto_vfs`."""
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
         self.send_command(
             f"echo 1 | sudo tee /sys/bus/pci/devices/{pf_port.pci}/remove".replace(":", "\\:"),
             privileged=True,
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 2c267afed1..f2dc9b20a9 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -573,6 +573,14 @@ def get_port_info(self, pci_address: str) -> PortInfo:
             ConfigurationError: If the port could not be found.
         """
 
+    @abstractmethod
+    def unbind_ports(self, ports: list[Port]) -> None:
+        """Unbind `ports` from any driver.
+
+        Args:
+            ports: The list of ports to unbind.
+        """
+
     @abstractmethod
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Bind `ports` to the given `driver_name`.
-- 
2.50.1

