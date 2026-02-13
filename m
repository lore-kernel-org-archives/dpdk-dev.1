Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78199EF99D0
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C6E240685;
	Fri, 13 Feb 2026 20:36:07 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 51CB040666
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:36:04 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cb4097794dso109502085a.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1771011364; x=1771616164; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+V6x9h/XnyBciCWOU9n0hOsc29tGHCQJ0kSL/G4R2Y=;
 b=izFbHkHl5inPNNP9oT0gcaMUq6rg+mKTc/MvqJ24A/bW7ZE9+Id1U7QvE7Lkfrht8n
 n/eFCQZaT0JNdzDdb7/X6O2Rcqzan+Yi7VwXhPsyGx+K1LisDOWk9ak27H+zWnKwT+u3
 masPITqxUKVoKxOAd9AwE7H2Uqn/GACLU56j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771011364; x=1771616164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/+V6x9h/XnyBciCWOU9n0hOsc29tGHCQJ0kSL/G4R2Y=;
 b=Sb+4dbtwjS+/VXBC5WN40288mDR+rHzTGQUym5MpRvgJBszMvOSCj6lAG0AeJKgMXd
 sXK8LEjU1kL7To0bu7d3a+8t9poTnQJdNx5RIs16JUexhgx0zy41RJuDV5nsgJW8FIq8
 u25jYMQPg/lJndfJBT3STHjV1HpRlUPc9Fdv5kuYbVj+rqlcMicpP5I/knLUF2T3W90H
 l/Kmcxchvxmk9JfiOsFWn4pr2f2zBCpI+WtitC2y9yNgZBT80erH7hf/8FN32r7b1R9P
 WC6OY1VypY1vlaNs93vjbeMgSBARBeGb3nm0ECIk9VbmCxPjOT5zoAXQjJ6zn8cVaTLN
 eJaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMlxE5+ebnLGLIMsbQtBMxag6xgpDC9cejxFcJ6hpbdGSrOOwYkSX54NWdkshIsEsmr90=@dpdk.org
X-Gm-Message-State: AOJu0YwGeB0ldwfjkeZ9a9Ab45udZFGeI8cqNq2wKL2R6ouG8qJ3OnP3
 WBP+l+8f98zE4n7/00cSHaOwL9oPLuH8xhX7fMXtuqKtMd4kfc4m7G+r2Zqd6mGBL6g=
X-Gm-Gg: AZuq6aLBDJESM4minlm0VldLYGWPMtN8pDE5aIoh8ltnZE93DRHQOzoBGv1P8IrUvlE
 Sl2DHbfGi1paBv+desGyPQcYoJmb/tKYB3cVUT6u+M92cUER3SZU8XN+Un2ISWMfy7+B+1sCsv8
 IXT9s99Ojm+iX41XGf8h6EHy1da9eiUd9bDFJx7lFIzZiG5mN7SeLFi8k3SzCvK+wvPMFUWPC5/
 zf+ETLWAszNEhI2OyDWvRvxhAQWHlTH4bRPSpJ5JJLpE5gIkHKBkUOehDwJUol4GeSZ8E5+ncMv
 HwV+4ibymHwnO8J98Qj33KqyrJJVqlxjyEDFjsTEj3oo9ZpRKNYyKmxV4evq8FwTTd50fGdr8nW
 wZfMKca1ADScTVPQLsNuBw9b9Xaxe5cODsleSNRcYM595ZsBL8oZQg6OyVIGVx3ArnpfHthv/3g
 EW5cMy5hi4BLTR102O5zjP8OqI2CERIBzS6H8cq+ANm0N4QCLPFgiRCd2SHimFZQWO
X-Received: by 2002:a05:620a:19a5:b0:8cb:69c:1c7d with SMTP id
 af79cd13be357-8cb4229aa74mr343833185a.20.1771011363423; 
 Fri, 13 Feb 2026 11:36:03 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb45f13a61sm146726085a.7.2026.02.13.11.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:36:02 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com,
	probb@iol.unh.edu
Cc: dmarx@iol.unh.edu,
	dev@dpdk.org,
	Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v3 5/5] dts: automate VFIO-PCI modprobe in node setup
Date: Fri, 13 Feb 2026 14:35:39 -0500
Message-ID: <20260213193539.103858-6-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260213193539.103858-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
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
index 27a5f48ecf..a761ca11fe 100644
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

