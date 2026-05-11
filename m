Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0D0CD37B2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 May 2026 15:32:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A3B27402D9;
	Mon, 11 May 2026 17:32:00 +0200 (CEST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by mails.dpdk.org (Postfix) with ESMTP id C7190402D5
 for <dev@dpdk.org>; Mon, 11 May 2026 17:31:58 +0200 (CEST)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7b4ee3a88e1so44111377b3.1
 for <dev@dpdk.org>; Mon, 11 May 2026 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1778513518; x=1779118318; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pNUHRA6vB24VgizS0NY/Kz5Gm1rXBM4LzwwlKNXzcg=;
 b=MO0Ol/P+qYW34YlGgdPtqgtqr58/Fz9uc0E3WxLt8UwrCb9RscqiIeVqi2TJIs/HyK
 ht7qvfUQn0V1G6HQrtmDu8jW+qBCt0yEnmmAKLqJIMgSYZIBXOKutzErOGvUZiJ6WGRa
 uVnpt8My444STQ4MF7g2Y5kdvR6o5XqLp5PJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513518; x=1779118318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pNUHRA6vB24VgizS0NY/Kz5Gm1rXBM4LzwwlKNXzcg=;
 b=d25oAnrNJ9JT8awhEigpzvIa71xZSR3y9ddWB8PoU75LiO+kirnkUproAijpZhlnpD
 PWaqHXx+K6ZHBWHB0UEsUH1k0BuFlF8Wy9AA7uuSmgM922ukH8rR2P1uMwOgp68z432G
 zu/alAHnXuhZ3hs9O7GQjlbPmoMQDfAGO+x6CzdaTe154Km6zWNDJezqennJwubQG+c/
 GAbS7qDF1V6t0JNUQvKjpwFXsdavtMNtIORx1XFG9Figiha2eQgeL3WbpukoxHS75qkt
 6EE2P4Bz/0hIkHpEv9ARhkJD89hSZzA65pAbUyCEaB4k3qTb6fRR5Vqg7sFbTekGNLzV
 R78Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QcgcwB16h3PvZYJ2kV9FKZbwqaPFJz5r19I1LKpLbYhfKthp7esOlaTRn27epFMKkBaA=@dpdk.org
X-Gm-Message-State: AOJu0Yw1Id7o6YKiJqxEsGodtUOnT2N+5wz0GTe29SKkaBIap+aptzzz
 wgnOVTLVDLZbuw5Nar/o5knEmVH0HpkF5PimBpmxPiZBwOLvRgmmc/EfzLyDJVeKBFk=
X-Gm-Gg: Acq92OFMChoDyUDYl22p3e9V2iuMUUi3CpefmjrPzDyaMND32ysgVB0DLZneeAIkwyV
 uTUUsFklXtuju5w88+ImXTA1oWzkZB9yyXjU0N9UFUI6w1VHn1agJWy76fhvniD+DvEpdZ53yrY
 BqZ4DHkrXv97TcjFySBV2FZlX+ebI0ws/r7ptIfP0wMbtRNI0hI9Sp2NxuxQtWhhuHXnRlGg2AX
 BYaRkNZRfIQMd9MaLemjD9NULOA4c2lLeHj0/F33QTHg5Tysvu+3yhM9G9g5xmOfMEZQCttvScV
 D4gBqyMPqIi+FnNFIqS2XHydfAvo9CURxv4KPJA6h1J3StlHDFt/IeiJDXJz186SPl8lX/Ss9eu
 wAhgFYTddxE1fuO0pqPc0jQHmk7VRsL8lEVa0zIOHrTnf8brfIwOjbmTv1fMgKfivezqVT5XGLr
 Ag7Q30g8InO/bg15RfplBLB2QjtnsgeX2+Pvehck9vXMr8SudmVlJxY+IVf03OI36i
X-Received: by 2002:a05:690c:d96:b0:7b3:a5ae:4214 with SMTP id
 00721157ae682-7bdf5eb538amr252346757b3.24.1778513517728; 
 Mon, 11 May 2026 08:31:57 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7e4d4sm96743916d6.26.2026.05.11.08.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:31:57 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	patrickrobb1997@gmail.com
Cc: lylavoie@iol.unh.edu, knimoji@iol.unh.edu, ahassick@iol.unh.edu,
 dev@dpdk.org, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2] dts: clean cryptodev environment after a test run
Date: Mon, 11 May 2026 11:31:52 -0400
Message-ID: <20260511153152.74700-1-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260507163659.40739-1-abailey@iol.unh.edu>
References: <20260507163659.40739-1-abailey@iol.unh.edu>
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
 dts/framework/testbed_model/linux_session.py | 29 +++++++++++++++++++-
 dts/framework/testbed_model/os_session.py    |  8 ++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index ee943462c2..6e40552d21 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -181,6 +181,22 @@ def get_port_info(self, pci_address: str) -> PortInfo:
 
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
+        if self._lshw_net_info:
+            del self._lshw_net_info
+
     def bind_ports_to_driver(self, ports: list[Port], driver_name: str) -> None:
         """Overrides :meth:`~.os_session.OSSession.bind_ports_to_driver`.
 
@@ -289,7 +305,18 @@ def create_vfs(self, pf_port: Port) -> None:
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

