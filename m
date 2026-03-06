Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9284FCB622
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 16:40:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DA9942707;
	Fri,  6 Mar 2026 17:40:36 +0100 (CET)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 5C1D441156
 for <dev@dpdk.org>; Fri,  6 Mar 2026 17:40:34 +0100 (CET)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8cb420fbb5dso568991485a.3
 for <dev@dpdk.org>; Fri, 06 Mar 2026 08:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772815234; x=1773420034; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnLkYKYCTYBtiPu2NjPylWVki9D+RNgcQljO+wSkoFo=;
 b=Blb7q1An52hi1eBBI3t61nkiMv6cSG0tb2tQpHfNLpYk3EoRc4iE5GSzaK5vT0Jcvi
 hPZHdy5xUS++WapMdiVpCLAqQidpSPP4J9eGMlwMay39IeXXAKYSDnew67Tvfs+Ckxl9
 17LIBYY5veRZosUZug1YLHONaL69/DwSeFOoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772815234; x=1773420034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lnLkYKYCTYBtiPu2NjPylWVki9D+RNgcQljO+wSkoFo=;
 b=SjesxapynpyIsUjM37k8x53nQu3VVgc1Sl3AFsr9hnF8wQDP3uAcLgfVoI1tPCPoKz
 LRyIzTaWzKkDEj52pPWTHvnyUknjg/jvqosOdpue3tBY2NTElmYPnClwYN5aeoR/O5RH
 TgrrzY+jY+49M08bxC//9a9f8silpkLhox4Eb0zuMTU43r49pSYwZVX2Bt/AOJlNqlCY
 56Y9wl0xYcVqqMSVRONh8VOPnJln9yxszaCrLgooe29dWKBrqogty3wneJ6IUpNGQp9Y
 f7astYYwOXrrymE0NW1RGjiqBtyYxVH2Q5QIypkv9EYh+1jrjeeY/MKCEPu1wNEYABhH
 glmg==
X-Gm-Message-State: AOJu0YxULcve6P8y6YkYpIDRuqEYe7Pe9STiz6vTbgqEowp8RFg2IWlt
 m3GAvRaG2iPZik4RYfJhMJHF0902n7wuc67UoSRe7atkoyjvXDzr4HpEkR9LEhPg5yI=
X-Gm-Gg: ATEYQzz37r/FjEqpvqn/QW9fHztmK05FE1VBb5wP3M7maiXvBGaeEtFNjoLhjAsAI+M
 u8mU7LB/gNHuoP4QCExZHGRbP/WQbPtkgra6Exs/AfRFqU86tjhwdgLL9PvrJR7OtwEqgvmzq/E
 pB6J/BxQDmAcCH5UCc8vWhNnBTrehbsxO+dS2DZDRNsghngIxxkeihKleuNng/EfrvZfPBXtlQ3
 WeF/L0iwlJzs2m15BRLkkNCxGg4c0tQTXTiLk6qz8R8dR/GBUo0Wh0T3g7f+UrLZxfYUCXeye1h
 Y13zBQ5ilSM9H3AK4ZxDafcUoSR1BqYFaj8F8S/5EsSo60hrfu/JSF2LDpi0aVKzxJJZlaggmpU
 5JJCCz41MIzkvGB6wf35hlF6yMnqlKn2vRbnGmfGZrPhhtuX1mNPvWr1IlKZzkP2nw9d+FUUMY2
 YyylKFpXFL1yIWK+zeah37xmsifdW2GQET/MvacF5cOVfCy4CtnLixMqpoz6mA3AGF
X-Received: by 2002:a05:620a:2a0e:b0:8cb:3fb3:7bee with SMTP id
 af79cd13be357-8cd6d427f7fmr339768685a.51.1772815233584; 
 Fri, 06 Mar 2026 08:40:33 -0800 (PST)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:4f6d:e2af:7f5f:4df])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f566fd5sm144608185a.43.2026.03.06.08.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:40:32 -0800 (PST)
From: Andrew Bailey <abailey@iol.unh.edu>
To: probb@iol.unh.edu
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu, kai.ji@intel.com,
 dharmikjayesh.thakkar@arm.com, david.marchand@redhat.com,
 gakhil@marvell.com, Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH v5 2/5] dts: automate VFIO-PCI modprobe in node setup
Date: Fri,  6 Mar 2026 11:40:24 -0500
Message-ID: <20260306164027.171723-3-abailey@iol.unh.edu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306164027.171723-1-abailey@iol.unh.edu>
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260306164027.171723-1-abailey@iol.unh.edu>
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

