Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F16CEB3624
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 18:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E66740E36;
	Mon,  2 Mar 2026 19:55:02 +0100 (CET)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by mails.dpdk.org (Postfix) with ESMTP id 93C3040E1F
 for <dev@dpdk.org>; Mon,  2 Mar 2026 19:55:00 +0100 (CET)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-506a1b23c05so57707621cf.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772477700; x=1773082500; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnLkYKYCTYBtiPu2NjPylWVki9D+RNgcQljO+wSkoFo=;
 b=al0U6s4ZohHo91YiwgNTk8c9k2cvJbkpmCU378ue9Ww9kJbd+WySQbHxfkzR36F4z2
 N1DM2XA7c9N7rw1HgyURQikCKxkWN18Zo8L45L9ep+eQKCQsE7PT3jGK3cNXzv79xOFK
 6FznxrHdJju1NSSL1h9SNT3wyQiFu5iF+Ftaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772477700; x=1773082500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lnLkYKYCTYBtiPu2NjPylWVki9D+RNgcQljO+wSkoFo=;
 b=GN1PlZaJy/WxU4KhKPj6bxibgnHugkZ3sYZTgd/PZSmnUP3wFPje0RqV3mfsIBO1nF
 pF3w8xid/VDh5y0Z40Y9/sZKWYl81HUibzAis2ChmTMjw4FDh62rapGmaGXXb1AEcTpj
 ByCCuLBgCIO3UpHmHrpt5zvcwcb0kyz++PC0rCVffGxzxHZSlfgY+t/GARM3bOBDTmJn
 AaVFHIQ8RRYC6vXS3dWsReYL/j8pesvisAWq3tscF1aKsFUYkLqxX6wGNs7IWSoqC+D4
 qmsb951E32eM1+nha+U65zWuo8IhqK47nlCOKSkcAxw47UchCMjgPAvIV4rEBWREPQZK
 vAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWfGR4zEmRRGvRhaaB9HS7T5U0FUY4TEKZWLA6UpZwESIDQiO8AcyuxS5R0kXJpXPdv1A=@dpdk.org
X-Gm-Message-State: AOJu0YxKn80xVI0ATgJTHAUrjkQrrWvYBWsYaLabscyeptgZ/GhyGowj
 CqY7btM6AI/ook/6xyK2mwaSk35Vvk/ztZVQ+/GXKjPUbdpAZWIRuNayRNyrB487/b4=
X-Gm-Gg: ATEYQzwzWpPfBKsRihl1TabZxHKVMTKiKxtn5t3A02iZfLbp1ufxiMk/rCCVVkSMj10
 Ofw5XOJL2cD5vGsmKVd5RBDkEJcmZ4ouMpDWdGrbJO0siBjj7r5TrTurzWxkmQDD3rnwn1ZsKd5
 r0fEHGiSJgHqPV7wMwpoYCPCCRTM05nNtLRPP0QXKCf+qJTrZti0KHk0M8Enq3qmD16nbT+W2LL
 GzHf8O8nh67WLxinlm+sttmaZDK/uOhWcrKddTNzSN5kxtAY52AdrqWF3rO9mt58FbljIGhecq8
 21+MS6084BtNdEpiuVlfOTKZBfhKTfoAc2WNbrD4y30SdPFiKwsZzow5iOOPKuks1bn4TBEusam
 mwIUdlcJIYMYzH+2Gf0Ntl084qs5U5A5XkHTG0Bcrtj/Cw40kkp6FPG/tZUynsa5IxrdJcO3k1C
 1av6hYjIaBqaTtZU4EX51T5uSJF2tebaNarsnDjQFBuPINKLw9jY+FssVlGeKT8Vto
X-Received: by 2002:ac8:7dc7:0:b0:506:9d3e:67e3 with SMTP id
 d75a77b69052e-50752923a15mr168456531cf.70.1772477699672; 
 Mon, 02 Mar 2026 10:54:59 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899eed12615sm46719586d6.8.2026.03.02.10.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:54:58 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org, gakhil@marvell.com,
 kai.ji@intel.com, dharmikjayesh@arm.com, david.marchand@redhat.com,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v4 2/5] dts: automate VFIO-PCI modprobe in node setup
Date: Mon,  2 Mar 2026 13:54:35 -0500
Message-ID: <20260302185438.122584-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302185438.122584-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260302185438.122584-1-abailey@iol.unh.edu>
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
index 711d4d97c3..2f4aef1460 100644
--- a/dts/framework/testbed_model/linux_session.py
+++ b/dts/framework/testbed_model/linux_session.py
@@ -223,6 +223,30 @@ def devbind_script_path(self) -> PurePath:
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
     def create_vfs(self, pf_port: Port) -> None:
         """Overrides :meth:`~.os_session.OSSession.create_vfs`.
 
diff --git a/dts/framework/testbed_model/os_session.py b/dts/framework/testbed_model/os_session.py
index b94c3e527b..f3064feeaa 100644
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
     def create_vfs(self, pf_port: Port) -> None:
         """Creates virtual functions for `pf_port`.
-- 
2.50.1

