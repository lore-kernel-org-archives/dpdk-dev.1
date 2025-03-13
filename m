Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB31C282EC
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 03:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A290740E3F;
	Thu, 13 Mar 2025 04:40:15 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41]) by mails.dpdk.org (Postfix) with ESMTP id 15FAB40B94
 for <dev@dpdk.org>; Thu, 13 Mar 2025 04:40:14 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-6e91d323346so6488776d6.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741837213; x=1742442013; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA0rtYm4CJeF7n83Y9DqrwxHeoYfqyEofMLDVlBNbm0=;
 b=iCUi5PHeosYC0a2b3qR6H8JJ0fdvhaLD1CkJ97orz922NFK/ZM0xlEcoeBdhb6B16H
 BSCXaDYD09xN8itKkmOIpYdupWCHR/QSWVi2nkYsmZzhN2dfgjL02UeF9tzMwQmPmYDL
 wCphfX0vxvWoLkG7jugeRE8uvKx2bDL5LXKcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837213; x=1742442013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA0rtYm4CJeF7n83Y9DqrwxHeoYfqyEofMLDVlBNbm0=;
 b=TAy3VT6CzhfUxW8PFA67XAj2RMBQ0yzrD+xsHzUkRflgUkxOnWlR6fi09IoTRA2Ia6
 v2QRLFRrcrdzndTV1sp97OZ343KsmsI8Hp4APAIadYAlDrCbOv10CGVnBEFWvH7EgCIQ
 VpMy4otxII/qol66SVTnX5NbMyYCnL+bw7udHgXrVdT7UcnDFOpXAPx4rEMjp4kvqSv+
 V9Nwztpe97Ei/XYE8tKEiVhV0+U+AooKyXiSdjWo1tTcJ5FnABwK6/4KXo0iBl+abHif
 rXvP4IsqXxZctA8CJ8wJ+Ic/4aDQaf27dU3JYOHZ59QR2NdiBAGokRsqoBaGmnwn3B8n
 f4Yw==
X-Gm-Message-State: AOJu0YxMOTMX3xh8NCP18fUWTvntWqTcz+bRHsBfBxEiZ/7tZ6q86Tn2
 clCbU5TmfORFs36DYwELWurOTJCPHKiyuMeU/RtC2hpsw/NnzdOzEvafEub2S34=
X-Gm-Gg: ASbGnctOFdsirMLATYXbrn666JQ3zAqU8VWUmjnh5lPOKPYJbsTTXzuIUVKV7Qu9Z+C
 AqrNVs2+VB2UTIopL3jfPbx1uO9N1yJbOxE3gvWvxbhIOcf6RUTS9gFs48YFfZo3QVNbNiZlKvw
 iMAsxVDwmnMHkvT7pkqtsEom0RL8w/7wf4bsRDqqEhlpytjBYbtW4adLrtzQ19RWQ4f3yELrqNO
 +rZRKJswv/5F0oQ2RxRM9+0mPpPeV25PB0mUqsQRm1tUNjtJMSAL6mSWsN1GOBd1TSIxVMbMpno
 Na2/Pke5D0LkbDHH/sauXL8zOMmIDCu4HEZGTufuNYaZ0OP6rNaG0zPAuaniOibu9k/gB95nAtY
 =
X-Google-Smtp-Source: AGHT+IFmeq/WKDdRdst1/O1d1Aqlk/i1iMdS2oxKPvDmnbgQ8SdVxQXxJOzBE8fXSyOiZSJbEhK03g==
X-Received: by 2002:a05:6214:501b:b0:6e2:3761:71b0 with SMTP id
 6a1803df08f44-6eaddee6cfcmr18887836d6.5.1741837213309; 
 Wed, 12 Mar 2025 20:40:13 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade257112sm4119716d6.61.2025.03.12.20.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:40:12 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, Luca.Vizzarro@arm.com, npratte@iol.unh.edu,
 dmarx@iol.unh.edu, Patrick Robb <probb@iol.unh.edu>,
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: [PATCH v5 2/2] dts: add VF configuration and workflow
Date: Wed, 12 Mar 2025 23:36:11 -0400
Message-ID: <20250313033611.1896695-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313033611.1896695-1-probb@iol.unh.edu>
References: <20240821191557.18744-1-jspewock@iol.unh.edu>
 <20250313033611.1896695-1-probb@iol.unh.edu>
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

This patch adds an additional test run config option for
selecting physical functions or virtual functions for the
testrun. If virtual function is selected, it adds a workflow
for creating the virtual functions during test run setup.

Bugzilla ID: 1500

Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/config/test_run.py     |  2 ++
 dts/framework/remote_session/dpdk.py | 11 +++++++++--
 dts/framework/test_run.py            |  7 ++++++-
 dts/framework/testbed_model/node.py  |  5 +++++
 dts/framework/testbed_model/port.py  | 16 ++++++++++++++++
 dts/test_run.example.yaml            |  1 +
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 06fe28143c..2298960f48 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -464,6 +464,8 @@ class TestRunConfiguration(FrozenModel):
     perf: bool
     #: Whether to run functional tests.
     func: bool
+    #: Whether to run the testing with virtual functions instead of physical functions
+    virtual_functions_testrun: bool
     #: Whether to skip smoke tests.
     skip_smoke_tests: bool = False
     #: The names of test suites and/or test cases to execute.
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 8d9f3b8948..b0445caded 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -415,12 +415,19 @@ def __init__(
         self._ports_bound_to_dpdk = False
         self._kill_session = None
 
-    def setup(self, ports: Iterable[Port]):
+    def setup(self, ports: Iterable[Port], vf_ports: bool):
         """Set up the DPDK runtime on the target node."""
         if self.build:
             self.build.setup()
         self._prepare_devbind_script()
-        self.bind_ports_to_driver(ports)
+
+        if not vf_ports:
+            # for PF test, bind PFs to the DPDK driver
+            self.bind_ports_to_driver(ports)
+        else:
+            # for VF test, leave PFs bound to kernel driver. Bind each PF's VFs to the DPDK driver
+            for port in ports:
+                self.bind_ports_to_driver(port.virtual_functions)
 
     def teardown(self, ports: Iterable[Port]) -> None:
         """Reset DPDK variables and bind port driver to the OS driver."""
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index f9cfe5e908..9fe30113c2 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -202,6 +202,9 @@ def __init__(
             for link in self.config.port_topology
         )
 
+        if self.config.virtual_functions_testrun:
+            sut_node.set_vfs()
+
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
         traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
@@ -344,7 +347,9 @@ def next(self) -> State | None:
 
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
-        test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
+        test_run.ctx.dpdk.setup(
+            test_run.ctx.topology.sut_ports, test_run.config.virtual_functions_testrun
+        )
         test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
index e6737cd173..ac4f44550b 100644
--- a/dts/framework/testbed_model/node.py
+++ b/dts/framework/testbed_model/node.py
@@ -185,6 +185,11 @@ def close(self) -> None:
         for session in self._other_sessions:
             session.close()
 
+    def set_vfs(self):
+        """Iterate through node ports and create VFs."""
+        for port in self.ports:
+            port.set_vfs()
+
 
 def create_session(node_config: NodeConfiguration, name: str, logger: DTSLogger) -> OSSession:
     """Factory for OS-aware sessions.
diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
index f638120eeb..e47ee7948e 100644
--- a/dts/framework/testbed_model/port.py
+++ b/dts/framework/testbed_model/port.py
@@ -26,6 +26,7 @@ class Port:
         mac_address: The MAC address of the port.
         logical_name: The logical name of the port.
         bound_for_dpdk: :data:`True` if the port is bound to the driver for DPDK.
+        virtual_functions: The list of virtual functions on the port.
     """
 
     node: Final["Node"]
@@ -33,6 +34,7 @@ class Port:
     mac_address: Final[str]
     logical_name: Final[str]
     bound_for_dpdk: bool
+    virtual_functions: list["Port"]
 
     def __init__(self, node: "Node", config: PortConfig):
         """Initialize the port from `node` and `config`.
@@ -45,6 +47,7 @@ def __init__(self, node: "Node", config: PortConfig):
         self.config = config
         self.logical_name, self.mac_address = node.main_session.get_port_info(config.pci)
         self.bound_for_dpdk = False
+        self.virtual_functions = []
 
     @property
     def name(self) -> str:
@@ -64,6 +67,19 @@ def configure_mtu(self, mtu: int):
         """
         return self.node.main_session.configure_port_mtu(mtu, self)
 
+    def set_vfs(self):
+        """Create virtual functions for the port."""
+        self.node.main_session.create_vfs(self)
+        addr_list = self.node.main_session.get_pci_addr_of_vfs(self)
+        for addr in addr_list:
+            vf_port_config = PortConfig(
+                name=f"{self.name}-vf-{addr}",
+                pci=addr,
+                os_driver_for_dpdk=self.config.os_driver_for_dpdk,
+                os_driver=self.config.os_driver,
+            )
+            self.virtual_functions.append(Port(self.node, vf_port_config))
+
     def to_dict(self) -> dict[str, Any]:
         """Convert to a dictionary."""
         return {
diff --git a/dts/test_run.example.yaml b/dts/test_run.example.yaml
index 330a31bb18..16d15dc568 100644
--- a/dts/test_run.example.yaml
+++ b/dts/test_run.example.yaml
@@ -27,6 +27,7 @@ traffic_generator:
   type: SCAPY
 perf: false # disable performance testing
 func: true # enable functional testing
+virtual_functions_testrun: false # testsuites are run from physical functions if set to false, and virtual functions if set to true
 skip_smoke_tests: false # optional
 # by removing the `test_suites` field, this test run will run every test suite available
 test_suites: # the following test suites will be run in their entirety
-- 
2.48.1

