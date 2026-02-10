Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C4EB2700
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1505A402B0;
	Tue, 10 Feb 2026 20:47:45 +0100 (CET)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174])
 by mails.dpdk.org (Postfix) with ESMTP id EDDC7400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:47:43 +0100 (CET)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5663601fe8bso4556743e0c.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770752863; x=1771357663; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPhkXiYkH0ZR7qK8zWqr/2EgNMawwlLSpIr5fMHqDTY=;
 b=CBRPsH289mE05D9HBhfSQdFkIxMtbTPbAK59N4un3SgMtn3XBS8Nqxll1/XCI4n8tH
 zRqr25wpvnUjgFZEBm4TqzMpK1vfrKSYkHM1Pk/dtFqdtBZr60Y8UwbafvwAu/p/UjBU
 tR0SJg+OkL0YsxJ7il4qFY6YrDWljPNya2mQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770752863; x=1771357663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPhkXiYkH0ZR7qK8zWqr/2EgNMawwlLSpIr5fMHqDTY=;
 b=wLSlOb1tk+sXus3H+AO8mJbqPRvgxHS0n8D4EPqTaqb1juTzoMAfpCOyFbHFp/Tue/
 KnMb2oNTY7pU1xmVWzu73fVxC08fs7YBjK53xnCNdyQl/oXL7S4V60aJNLpw3i1AgVHb
 bY1xVHvjgURHH33OKtYzlCn+WL055qNn2Jt9VoQ2XkeF75E7LJv9Bj0BK3eAkttME0zV
 OmeVdvvgyDMhcIeuUY6LsP38oShqJiiTON/k9OhwQbC3JTjJ2DVskgJr8dlSO8JhUqhL
 vz2T2UGzWfItoqeWNvOfLSlL2JqH2Dt0BIYW+kb592ynOMUSrO3+bPadnHbMXKQuBzHs
 iQUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrBYaVF6ljLgCV0kBIqg0ACR/TkWKTW6XrofBRRdTCw7AtUCZ5aIjN4xLJjcrrDYkIs4o=@dpdk.org
X-Gm-Message-State: AOJu0Yy5QUD8QvjCL0urpMiXv8B/ZzMwZ9l5qV9/g39i1FqL0v9ADVtb
 q7lnoNlxE8tYKytCaGJoz/Ntabmowlqsx/L7P8RIIOgtQ7qWOkRPM2M0aF6O22IsF19GziZ30QY
 e+YWc
X-Gm-Gg: AZuq6aIA9FJp7SGo1kzX4OnYmhgHQtvVcWCkgvheTXTAd2tCuYq1MZLfV4h42pKBouC
 c8fOtCIN5PtTAV2sLMu8jjjE7a9tmaYlqIHhhTH+kgFapv/c+um2JFZOYKmtwrDFEAo0/jiZnZM
 GShpHeoR+VjUcJ/uUUxOlVF2N8/NuXcbGKhsWiLMwhMI1fsfZPzyNbqiBx8hyodKOwyFGvHRrTN
 D2CC7bGwtf9J8CByRAhRSygJjFgZtE1D2bk6jtJBQPPLU1tNvRbZ2WWYrUR9/la7y000G7xdbT2
 kkpfTK6JTN6eNoMf1qtFaImsRRhWKHoMGUa4HPe+DFcnwE330G77H/K3JSMe7RiziZQmv0gqBKr
 mRW8YxzOk1O6nD3u7OSdNBVC7DR5eMc98YKi309ro7EV1ZoQbKnfDYjxALlHb5bvGispRNb+6dI
 ZxhJtiFpLJNeNvZXum+3zpaZioR3t0F+Bx0NMbp9IRO/ldNUBZNk0CdJiTMTiT0nCe
X-Received: by 2002:a05:620a:29d5:b0:8c6:ff02:d825 with SMTP id
 af79cd13be357-8cb1f6ebe6cmr404234885a.48.1770746814783; 
 Tue, 10 Feb 2026 10:06:54 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf77f2868sm1079300385a.3.2026.02.10.10.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:06:53 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 5/5] dts: automate VFIO-PCI modprobe in node setup
Date: Tue, 10 Feb 2026 13:06:45 -0500
Message-ID: <20260210180645.65880-6-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210180645.65880-1-abailey@iol.unh.edu>
References: <20260122214424.322422-1-abailey@iol.unh.edu>
 <20260210180645.65880-1-abailey@iol.unh.edu>
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
 dts/framework/testbed_model/os_session.py    |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/testbed_model/linux_session.py
index a9eb8b693d..c41155e23b 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -224,6 +224,30 @@ def devbind_script_path(self) -> PurePath:
         """
         raise InternalError("Accessed devbind script path before setup.")
 
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
+            self.send_command("modprobe vfio-pci")
+        self.refresh_lshw()
+
     def create_crypto_vfs(self, pf_port: list[Port]) -> None:
         """Overrides :meth:`~os_session.OSSession.create_crypto_vfs`.
 
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

