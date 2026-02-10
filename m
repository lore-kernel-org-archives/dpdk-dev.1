Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82AEB2705
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 19:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EB2540E36;
	Tue, 10 Feb 2026 20:35:22 +0100 (CET)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com
 [209.85.219.46]) by mails.dpdk.org (Postfix) with ESMTP id 5C38A40E09
 for <dev@dpdk.org>; Tue, 10 Feb 2026 20:35:19 +0100 (CET)
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8946e0884afso83820086d6.1
 for <dev@dpdk.org>; Tue, 10 Feb 2026 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770752119; x=1771356919; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPhkXiYkH0ZR7qK8zWqr/2EgNMawwlLSpIr5fMHqDTY=;
 b=AvZBFKcUqo/rIOOaKiCfsh0NU6tAQxqAHpyIPxxri7inMD/uLSQp+c3m8IJe7r7c8k
 +JBJlyDyW6rqnon89+3wHYV/TDY4djRYx/EnYT5aHUFdT0HWbeYehCbG0f/OFEf0PdN9
 xofpUlzy/9Ftfgd8Em7BQUQ2sJVfh2J0oS1Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770752119; x=1771356919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPhkXiYkH0ZR7qK8zWqr/2EgNMawwlLSpIr5fMHqDTY=;
 b=lFJuchIHps7PcX5N3v2rs6kTy9i3hr/CtDpT1CDiQhMdZFUjhnXc/joASvaC9YU7ve
 +db0C7GTjb5wBvNuDml8Npp/oEnpjWkcrG8+jzk8WFqMJNVDV8xoUhYYvIH1r309v0aM
 ijRBmY+0ddhl06REB1bNM/NIqTDkB/HyCRdj4H7/au9y8UHBkJduy2/J5Y8AP+1M0bfE
 Saz+UGkllO5XyZF4fsG2BG7GoGjw+J/d6mBXyDb4KorXWqZuUK755hTZI5OKhaF5VU2M
 MARiN7MBLc+jSyg/OaumgjvdNucKplZJoC2yaj3w14NzBXpj6mhBbZ3G3knCLtPa9RJS
 QCWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiYC2dZX7IzLRbHmCtV7F0bEEsV4y9waqBRUFlwJv7fcZbNy1F5V44Icb6Q/Ym74lnGqg=@dpdk.org
X-Gm-Message-State: AOJu0YxxbDooGj+0AmG8fyMkmoJvh3vzDP9Y3UZLVwqRJxJwK16tTn01
 9zcpsd2jEyoBKQ6Z653OtFEI+oielLPJjfQKvFq2n0Dq4AVep1UO/jcCKGs5Cs3xAOg=
X-Gm-Gg: AZuq6aLSY+eJB6zCzfN0d7JW60/wP2Hyf/4LK8ncQztQYruuBFRkLY07tbMqCB+AQ0M
 /dkwykLRwJjlBqmlck+3qg66Vu9OZovQ77zbHmhHFqnbjDb0wJSvOq7v30kPcHfpGwkEVRBEOVv
 JoZs+ScaZWNQO53L3h8doYTQHDp84xH4i+rJcraxO0Dq0LWwtfGqxYloP6cnTF635AEhmyVbRO2
 Jti0eq42wkaBCK+siNoNWqyoFuT10wmc/15pt3jIBZjABvIJFpvxXsYisqIXTjtFAcT+x7bqfJs
 PI2BYDiTFMx1wqsa1WszG5JiuXsHiTeOVH6D9ZSvHB8oUu+0ZP3OJ4d9xBK0Bsf8ID36ZVr/zFG
 YRW2Pzh1GurMlRSba0lW/o1yKCPSrb8vt0F2nQ5lzRtMd/KtnAN3mtYdIb8v1CW3xeixq/L5s8D
 1nV/BWLJzt5xE0etSpqTLlWAurTsnYjrsFgRpD43m6lyT3mUvHFmybj+tFAdXLpyy/
X-Received: by 2002:a05:6214:40b:b0:894:7852:9bd3 with SMTP id
 6a1803df08f44-8971aee3844mr2395296d6.42.1770752118696; 
 Tue, 10 Feb 2026 11:35:18 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953bf3b6b2sm107455356d6.6.2026.02.10.11.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 11:35:17 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu,
	dev@dpdk.org
Cc: dmarx@iol.unh.edu,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v2 5/5] dts: automate VFIO-PCI modprobe in node setup
Date: Tue, 10 Feb 2026 14:34:48 -0500
Message-ID: <20260210193448.69423-6-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210193448.69423-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
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

