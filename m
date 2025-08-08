Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FB3C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 18:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43FAB40611;
	Fri,  8 Aug 2025 20:22:15 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 7820C40270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 20:22:13 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7e814f6fc57so324296885a.1
 for <dev@dpdk.org>; Fri, 08 Aug 2025 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1754677333; x=1755282133; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4sEHRTPyfJ2T2bopvd6AQEY+a1UaBMnsWYDBEV1TzP0=;
 b=SFsxGrsd2A1CCykii1PwMRTP/p13Fk/UdaYHLaEejja5n9Ogq0AgZfhREVfNgNlvFr
 L7EfVIsmphQSZZwEP5MojpkfrsnAJVXQ3LE+GNKpoVt9+C4GeKa1/+fFQ4q2pb2zWpfw
 BfGiziRfjSy1Ek2t41iyEQ1TCiO+oagvgmL/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754677333; x=1755282133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4sEHRTPyfJ2T2bopvd6AQEY+a1UaBMnsWYDBEV1TzP0=;
 b=RnFGCWzaKk4nz31bBRPXQlxRm2ZVH2NaeB03vf2+wc0Z60jDO0vAXUFU8KX8XBXqWb
 +hbXcwM5+jPNdpU4C/w3dLy5XmKxJ3IL/6prHBC7UPl/hF6zmUsoTA1vj7W3gU7twI+F
 jgc9enoEjVT5kGkNhANeRX7BCEy5A/nUpK67sr8BytkxkNTT3BdvVz/M6jMY1ESjWPbN
 rhTwD0lMw5+spAeDKFtjLRuMF3+DXUEdHgwc5u6MsWi/4zsSxrkKIofx4MQyK/hzWeFv
 VAZRhcFPSbUQXucvAw9j6x++ZHXeSQWWwe/Pd0FnIyxIHoJ3zeJWvjUAdUM+mmhC+SDR
 maMA==
X-Gm-Message-State: AOJu0YzmS2LTxSg6rQHo8xjJwrns5urX+PDZ+XmMt8t0LumYnotVKQBh
 PLB40w4wjWEhhF4ZctQQWKDEHWCUvdYEYI/ExaASth8b5uBf5uzrsqOrs5/jjTPP4BjP1CYsgFt
 itz3+
X-Gm-Gg: ASbGncsRiW1GAmOT/SPeMA/1bAC+pIPZR2BlCAOx84oOfJtmGU75q7yGP5ySF3lCzLb
 gP4/inDY43ElA4OLm5E9vwmAcYRHe2SG9waTS9UYDCitk38vd7aWUF+LP7AGhQFoiwWIghU3hWw
 XHeJDZXo8Jyyj1apcygLEAB6RLefcr1Y4IOpezep8A7zU7xpssCnXO/AA6Zax8PMebIGlUxbp4L
 eD04OO7gYJITgZGMP7vhtAxT5X4ixLWsCP0XycOEsw3i7pg7hAG2Vi9NLRX8GW2ZjOE2+teMmRz
 VCRjZUSQEd/7FyFcZzwqUEdnfHMKmeHDUX08Kqm5iT4fYpeeMeWGT5Fb41/7oLmo4i0DGwGvGG/
 XDlVUJpe1nJZ21ag1+T4OBKEMToqgE4j6yA==
X-Google-Smtp-Source: AGHT+IECBeWOD+OsUi/EFGnk9EkksHWlRn1Nhr9BCAUA0gtVkd64v+1brO4yC0BW5x64TKckAbZLug==
X-Received: by 2002:a05:620a:6288:b0:7e8:454:ab63 with SMTP id
 af79cd13be357-7e82d47eff5mr542498085a.17.1754677332484; 
 Fri, 08 Aug 2025 11:22:12 -0700 (PDT)
Received: from d122205.iol.unh.edu ([2606:4100:3880:1220:a136:b4d:e75:44c4])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e812e90ee6sm500685185a.49.2025.08.08.11.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 11:22:11 -0700 (PDT)
From: Andrew Bailey <abailey@iol.unh.edu>
To: luca.vizzarro@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 Andrew Bailey <abailey@iol.unh.edu>
Subject: [PATCH 1/2] dts: introduce abstract class for TG and SUT DPDK runtime
 environments
Date: Fri,  8 Aug 2025 14:21:08 -0400
Message-ID: <20250808182152.356879-1-abailey@iol.unh.edu>
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

DPDK runtime environment has logic in methods for two modes of use, one
for TG environments and one for SUT environments. TG nodes utilizing
these methods only require a single class attribute that DPDK runtime
environment holds. TG nodes using these methods do not require the
overhead of a new DPDK runtime evironment.

Lift shared methods into a new abstract class and split the existing
runtime class into SUT and TG specific runtime classes.

Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
---
 dts/framework/context.py             |   4 +-
 dts/framework/remote_session/dpdk.py | 151 ++++++++++++++++++---------
 dts/framework/test_run.py            |   9 +-
 3 files changed, 110 insertions(+), 54 deletions(-)

diff --git a/dts/framework/context.py b/dts/framework/context.py
index 4360bc8699..086f07e0e9 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -15,7 +15,7 @@
 from framework.testbed_model.topology import Topology
 
 if TYPE_CHECKING:
-    from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
+    from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKSUTRuntimeEnvironment
     from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
@@ -68,7 +68,7 @@ class Context:
     tg_node: Node
     topology: Topology
     dpdk_build: "DPDKBuildEnvironment"
-    dpdk: "DPDKRuntimeEnvironment"
+    dpdk: "DPDKSUTRuntimeEnvironment"
     tg: "TrafficGenerator"
     local: LocalContext = field(default_factory=LocalContext)
     shell_pool: ShellPool = field(default_factory=ShellPool)
diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
index 606d6e22fe..8e45da4bd5 100644
--- a/dts/framework/remote_session/dpdk.py
+++ b/dts/framework/remote_session/dpdk.py
@@ -7,6 +7,7 @@
 
 import os
 import time
+from abc import ABC, abstractmethod
 from collections.abc import Iterable
 from dataclasses import dataclass
 from functools import cached_property
@@ -302,14 +303,83 @@ def get_dpdk_build_info(self) -> DPDKBuildInfo:
         return DPDKBuildInfo(dpdk_version=self.dpdk_version, compiler_version=self.compiler_version)
 
 
-class DPDKRuntimeEnvironment:
-    """Class handling a DPDK runtime environment."""
+class DPDKRuntimeEnvironment(ABC):
+    """Shared methods between TG and SUT runtimes."""
 
-    config: Final[DPDKRuntimeConfiguration]
-    build: Final[DPDKBuildEnvironment | None]
     _node: Final[Node]
+
+    def __init__(self, node: Node):
+        """DPDK runtime environment constructor.
+
+        Args:
+            node: The target node to manage a DPDK environment.
+        """
+        self._node = node
+
+    @abstractmethod
+    def _prepare_devbind_script(self):
+        """Prepare the devbind script.
+
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+
+        Raises:
+            InternalError: If dpdk-devbind.py could not be found.
+        """
+
+    @abstractmethod
+    def setup(self) -> None:
+        """Set up the DPDK runtime on the target node."""
+
+
+class DPDKTGRuntimeEnvironment(DPDKRuntimeEnvironment):
+    """Class handling a DPDK runtime environment for a TG."""
+
+    def __init__(self, node: Node):
+        """DPDK TG environment constructor.
+
+        Args:
+            node: The target node to manage a DPDK environment.
+        """
+        super().__init__(node)
+
+    def setup(self) -> None:
+        """Set up the DPDK runtime on the target node."""
+        self._prepare_devbind_script()
+
+    def _prepare_devbind_script(self) -> None:
+        """Prepare the devbind script.
+
+        Copy the script build from the local repository.
+
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+
+        Raises:
+            InternalError: If dpdk-devbind.py could not be found.
+        """
+        if not isinstance(self._node.main_session, LinuxSession):
+            return
+
+        local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
+        if not local_script_path.exists():
+            raise InternalError("Could not find dpdk-devbind.py locally.")
+
+        devbind_script_path = self._node.main_session.join_remote_path(
+            self._node.tmp_dir, local_script_path.name
+        )
+
+        self._node.main_session.copy_to(local_script_path, devbind_script_path)
+        self._node.main_session.devbind_script_path = devbind_script_path
+
+
+class DPDKSUTRuntimeEnvironment(DPDKRuntimeEnvironment):
+    """Class handling a DPDK runtime environment for a SUT."""
+
+    config: Final[DPDKRuntimeConfiguration]
     _logger: Final[DTSLogger]
 
+    build: Final[DPDKBuildEnvironment]
     timestamp: Final[str]
     _virtual_devices: list[VirtualDevice]
     _lcores: list[LogicalCore]
@@ -322,18 +392,18 @@ def __init__(
         self,
         config: DPDKRuntimeConfiguration,
         node: Node,
-        build_env: DPDKBuildEnvironment | None = None,
+        build_env: DPDKBuildEnvironment,
     ):
-        """DPDK environment constructor.
+        """DPDK SUT environment constructor.
 
         Args:
             config: The configuration of DPDK.
             node: The target node to manage a DPDK environment.
-            build_env: The DPDK build environment, if any.
+            build_env: The DPDK build environment.
         """
-        self.config = config
+        super().__init__(node)
         self.build = build_env
-        self._node = node
+        self.config = config
         self._logger = get_dts_logger()
 
         self.timestamp = f"{str(os.getpid())}_{time.strftime('%Y%m%d%H%M%S', time.localtime())}"
@@ -354,17 +424,11 @@ def __init__(
         self._ports_bound_to_dpdk = False
         self._kill_session = None
 
-    def setup(self):
+    def setup(self) -> None:
         """Set up the DPDK runtime on the target node."""
-        if self.build:
-            self.build.setup()
+        self.build.setup()
         self._prepare_devbind_script()
 
-    def teardown(self) -> None:
-        """Reset DPDK variables and bind port driver to the OS driver."""
-        if self.build:
-            self.build.teardown()
-
     def run_dpdk_app(
         self, app_path: PurePath, eal_params: EalParams, timeout: float = 30
     ) -> CommandResult:
@@ -385,38 +449,6 @@ def run_dpdk_app(
             f"{app_path} {eal_params}", timeout, privileged=True, verify=True
         )
 
-    def _prepare_devbind_script(self) -> None:
-        """Prepare the devbind script.
-
-        If the environment has a build associated with it, then use the script within that build's
-        tree. Otherwise, copy the script from the local repository.
-
-        This script is only available for Linux, if the detected session is not Linux then do
-        nothing.
-
-        Raises:
-            InternalError: If dpdk-devbind.py could not be found.
-        """
-        if not isinstance(self._node.main_session, LinuxSession):
-            return
-
-        if self.build:
-            devbind_script_path = self._node.main_session.join_remote_path(
-                self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
-            )
-        else:
-            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
-            if not local_script_path.exists():
-                raise InternalError("Could not find dpdk-devbind.py locally.")
-
-            devbind_script_path = self._node.main_session.join_remote_path(
-                self._node.tmp_dir, local_script_path.name
-            )
-
-            self._node.main_session.copy_to(local_script_path, devbind_script_path)
-
-        self._node.main_session.devbind_script_path = devbind_script_path
-
     def filter_lcores(
         self,
         filter_specifier: LogicalCoreCount | LogicalCoreList,
@@ -459,3 +491,24 @@ def kill_cleanup_dpdk_apps(self) -> None:
     def get_virtual_devices(self) -> Iterable[VirtualDevice]:
         """The available DPDK virtual devices."""
         return (v for v in self._virtual_devices)
+
+    def _prepare_devbind_script(self) -> None:
+        """Prepare the devbind script.
+
+        Use the script within the associated build's tree.
+
+        This script is only available for Linux, if the detected session is not Linux then do
+        nothing.
+        """
+        if not isinstance(self._node.main_session, LinuxSession):
+            return
+
+        devbind_script_path = self._node.main_session.join_remote_path(
+            self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
+        )
+
+        self._node.main_session.devbind_script_path = devbind_script_path
+
+    def teardown(self) -> None:
+        """Reset DPDK variables and bind port driver to the OS driver."""
+        self.build.teardown()
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 4355aeeb4b..274dceebfd 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -111,7 +111,10 @@
 from framework.context import Context, init_ctx
 from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
 from framework.logger import DTSLogger, get_dts_logger
-from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
+from framework.remote_session.dpdk import (
+    DPDKBuildEnvironment,
+    DPDKSUTRuntimeEnvironment,
+)
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
 from framework.test_suite import BaseConfig, TestCase, TestSuite
@@ -199,11 +202,11 @@ def __init__(
         )
 
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
-        dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
+        dpdk_sut_runtime_env = DPDKSUTRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
         traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
 
         self.ctx = Context(
-            sut_node, tg_node, topology, dpdk_build_env, dpdk_runtime_env, traffic_generator
+            sut_node, tg_node, topology, dpdk_build_env, dpdk_sut_runtime_env, traffic_generator
         )
         self.result = result
         self.selected_tests = list(self.config.filter_tests(tests_config))
-- 
2.50.1

