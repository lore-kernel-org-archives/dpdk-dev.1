Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64746D6CFA6
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D013E406BA;
	Thu, 22 Jan 2026 22:44:39 +0100 (CET)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4111940695
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:44:36 +0100 (CET)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-8c5265d06c3so269131885a.1
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769118275; x=1769723075; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DclisgetR1a5FwhKARBfadU0nspDOL4DiQumKorV0+4=;
 b=EDzmgNIpxWWFPrbMx7yQ8swhdQ2zfJ9v6TiZv3tyfO/vsoRfpke63pnq2FAhX9RfOS
 1u2YgBcEjMg/Uyw6+JvQbKGDi65TQGAGEmfqWtulJeahQ5kjC9JSWIaEsCVNLvnWuwPG
 n6qfZ8SCDSfBDFfu+goJI62t8biZiS1CtHo4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769118275; x=1769723075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DclisgetR1a5FwhKARBfadU0nspDOL4DiQumKorV0+4=;
 b=jBZ9nHZjbouK2m2ujDn8gegROk8JZFZjQrMGbh5sMxmhNDk2C5YCocAwLP/xQEOLvy
 yz5wcOEDysAkvsNKc3LtaqTQ7Z9tQW8KWbAIC98HcoHM0INE0oQEja1U/Un/bsJl+lZE
 TAIzyIrUxCaneVciR6fYQY5Fzd1CBBeKo7ixgo3dEYtTjk0+jRxQyti3nc1+A0jVYYGf
 /jaG/Mpq3GQybY507V5XOHO/+YX/mLf+vjZxgkeq3X6nMnOzDmuMq/RHfQSLLic2Wffk
 LZMnJ7QS0MbFTBtAMx71XNUIFWHmxo3XJFYoxz7XR3Yvx3SkVICo/TF9oNUH8G/3EzzQ
 BUYg==
X-Gm-Message-State: AOJu0YzAC3wgKvMSn4sVzwDAfvllutmXwzd0tmTGJEBE1XAGxeRPhHOF
 7GHdgkPXS9mlMB6iWHdcxUKZ8f3RjgcSzN0Wg+8A40A6VHM1HZ0Kk9MBWfE1SECKLeA=
X-Gm-Gg: AZuq6aJIhSez5j05dhf2W3zRDO72cgpph+2VXTX63vjj2n65OOcsJd6bfeFuWxhwaLd
 Ggx5yG6rPFj59a5GdAqzhYhG4Fe3oDLDA1CW64YstzuWpW0AjAYUxfl6OlDLL3TJnTRQR6XIowN
 NmPE9TzvdAhs/4kiE/ODfq3ocOdeBZYdHVHragJdRSeUUegR3YwAgqTYXZymqU1lb50bDiQw+C5
 68e0ij2KNwsNFzvLAggdUYWrCJC0JETzocK3IEDci5kOnu4UP9cImk7D2Xoh583GfGszOyfbyGl
 pp7d1eTCZ/pDlZue8PcvVQQZNZfR+HpPgaXp4yhL4l7EeVR2cSc6FRjWrAaVjdxEmz7NYex6G8m
 BgA1ljAu0AVNKXcRxGBjQTdLXb/mHcbgE8EirQ63kQidlLTWR5MotzjxuocEpLkOMVbxz7q+KBL
 UDEHe+xnwH/8viZry6wLlZocHSA5fnyKtkkWoSkh2PkwwdfdwOmpV7
X-Received: by 2002:a05:620a:46a8:b0:89f:cc73:386 with SMTP id
 af79cd13be357-8c6e2e26e66mr114410485a.13.1769118275536; 
 Thu, 22 Jan 2026 13:44:35 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e3870c48sm28720785a.51.2026.01.22.13.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 13:44:34 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dmarx@iol.unh.edu
Cc: dev@dpdk.org,
	gakhil@marvell.com,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v1 5/5] dts: automate VFIO-PCI modprobe in node setup
Date: Thu, 22 Jan 2026 16:44:24 -0500
Message-ID: <20260122214424.322422-6-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122214424.322422-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
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

Currently, users must modprobe VFIO-PCI before running DTS when using a
non-mellanox NIC. This patch automates the process on test run start up.
In addition, if the SUT is expected to use a subset of a few QAT devices,
VFIO-PCI must be loaded in a separate manner. This patch adds this
distinction.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/testbed_model/linux_session.py | 24 ++++++++++++++++++++
 dts/framework/testbed_model/node.py          |  4 ++++
 dts/framework/testbed_model/os_session.py    |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index 8d678c5b5d..1bc8bd54b9 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -224,6 +224,30 @@ def devbind_script_path(self) -> PurePath:
         """
         raise InternalError("Accessed devbind script path before setup.")
 
+    def load_vfio(self, pf_port: Port) -> None:
+        """Overrides :meth:'~os_session.OSSession,load_vfio`."""
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
     def create_crypto_vfs(self, pf_port: list[Port]) -> None:
         """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
 
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index a4c1f8f22c..2f8d40e8f3 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -86,6 +86,10 @@ def __init__(self, node_config: NodeConfiguration) -> None:
         self.cryptodevs = [
             Port(self, cryptodev_config) for cryptodev_config in self.config.cryptodevs
         ]
+        if self.cryptodevs:
+            self.main_session.load_vfio(self.cryptodevs[0])
+        elif self.ports and self.ports[0].config.os_driver_for_dpdk == "vfio-pci":
+            self.main_session.load_vfio(self.ports[0])
         self._logger.info(f"Created node: {self.name}")
 
     def setup(self) -> None:
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index 2eeeea6967..4a4fc1f34a 100644
--- a/dts/framework/testbed_model/os_session.py
+++ b/dts/framework/testbed_model/os_session.py
@@ -615,6 +615,10 @@ def configure_port_mtu(self, mtu: int, port: Port) -> None:
             port: Port to set `mtu` on.
         """
 
+    @abstractmethod
+    def load_vfio(self, pf_port: Port) -> None:
+        """Load the vfio module according to the device type of the given port."""
+
     @abstractmethod
     def create_crypto_vfs(self, pf_ports: list[Port]) -> None:
         """Creatues virtual functions for each port in 'pf_ports'.
-- 
2.50.1

