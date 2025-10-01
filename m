Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926EDCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 23:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BFAA40B8F;
	Thu,  2 Oct 2025 01:17:48 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 2D66D40DD3
 for <dev@dpdk.org>; Thu,  2 Oct 2025 01:17:47 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-856222505eeso50822085a.1
 for <dev@dpdk.org>; Wed, 01 Oct 2025 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1759360666; x=1759965466; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6siD98tsO2NHybucS7mDx88q98/Sw0rXaVCq9LtVEDE=;
 b=HG0GMWdZlAc0QeOulLP4PgEvipwJoBTi8139DufPMVOXHxgYmQCssTC/XQaG2aD7G5
 NHI/DXUC8z/ouNYU/UIHs6NS4lZRtP3MAV3uNWqnxfyuu8iJrasYw0Gm54cGkitJ5eVC
 ROMYPB8Zu+SFiJwozO5kqSxyHO5GLn4/sqouo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759360666; x=1759965466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6siD98tsO2NHybucS7mDx88q98/Sw0rXaVCq9LtVEDE=;
 b=sTa8fL3cg1UtuH2O76pfgiUUiEHgPHu/ND2sDxuiNl9m0Aba86m+rMuCrTZDWhvOYL
 /rhkkn0lFF5Zky5ki+EBMGGhP4Jfe/ATCfApg+1xR7UPMx/PZmaDy0UbarA01GbjB+qu
 Oy9wo+8aDq82LtC0NWbM2BmeEtYv0eu5BZiBhyj574n25Ho5oDBuKQ7SO1Qa1K17veBn
 gZBGxQXCJZOzQmMTeXdZIXssm0t6w/cBh6ho4o2SIbDAOtrwecp9FXzY59sRPNwvGGxB
 WLFxaOyEHSdhBKOfdqJy+kg8ys94V3K088jBU1FJ19aALb7C2nsVB0i7W77xDmvfNHfn
 s7LA==
X-Gm-Message-State: AOJu0YxBdBGOJtPBVWV7VXh8siEfj4RioYAD23eXNElCrSN7WZbin+Mo
 6dq1ago+3sAx84uM6lgFSjlimQSUNb/XmYfYMr8kBjDDUixsJ7n8fy0sBw6PcTY6uuM=
X-Gm-Gg: ASbGncv1XRv5jhRoroUTeBphZAw+83hp9e4AOBI6OAexohTJ0iYnoAFN7QZ9fkifrE4
 ZJMPpcpZix32hpOihisfy/aTvdSYpOgQGouwwtOHpdSVAiX3jCp4Yxm2AilJW08HeGIVp12BQUG
 OKMqwmIWXDo4azsZRDxDIE27wQ/zDHelI2WWzyywnKyXK6fONG1XmomH9N4rn+Gx21Z0cH7MyC3
 4lbUZw7mSfezMDF8h50w8PMDT3KBXL1ShJ/PiajVtIkbXCcc3OrWO/mdylxcoc7K7i7siVARVAb
 kvtt+1c5b4Mf4kRvYIVu3Pg5GnyjGKaV3OHkDXVAE+pPYwOytVUFMw3NN6UN26tCfJzHLZNkNAs
 7GaDLaagTVK7+1b+uZ7c5YzCpNYo2r5sh+rMDQ7aEaLvNfLSu
X-Google-Smtp-Source: AGHT+IEHMvBQqhcwcavP3XnK7jCHLVykHQFt9SWT6+VzAypqWnwry2tfUK42awf43pKGP6qyDvv7Dw==
X-Received: by 2002:a05:620a:7085:b0:862:ab87:ce6e with SMTP id
 af79cd13be357-873720c1d64mr766725385a.27.1759360666219; 
 Wed, 01 Oct 2025 16:17:46 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8777aabeac7sm95224285a.64.2025.10.01.16.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 16:17:45 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v4 2/3] dts: add trex traffic generator to dts framework
Date: Wed,  1 Oct 2025 19:16:58 -0400
Message-ID: <20251001231659.2297751-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251001231659.2297751-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20251001231659.2297751-1-probb@iol.unh.edu>
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

From: Nicholas Pratte <npratte@iol.unh.edu>

Implement the TREX traffic generator for use in the DTS framework. The
provided implementation leverages TREX's stateless API automation
library, via use of a Python shell. The DTS context has been modified
to include a performance traffic generator in addition to a functional
traffic generator.

In addition, the DTS testrun state machine has been modified such that
traffic generators are brought up and down as needed, and so that only
one traffic generator application is running on the TG system at a time.
During the testcase setup stage, the testcase type (perf or func) will
be checked and the correct traffic generator brought up. For instance,
if a functional TG is running from a previous test and we start a
performance test, then the functional TG is stopped and the performance
TG started. This is an attempt to strike a balance between the concept
of having the scapy asyncsniffer always on to save on execution time,
with the competing need to bring up performance traffic generators as
needed.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 doc/guides/tools/dts.rst                      |  35 ++-
 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   6 +-
 .../tests_config.example.yaml                 |   0
 dts/framework/config/test_run.py              |  22 +-
 dts/framework/context.py                      |   5 +-
 dts/framework/remote_session/blocking_app.py  |   4 +-
 .../remote_session/interactive_shell.py       |   2 +-
 dts/framework/settings.py                     |  12 +-
 dts/framework/test_run.py                     |  54 +++-
 dts/framework/test_suite.py                   |   7 +-
 .../traffic_generator/__init__.py             |  13 +-
 .../performance_traffic_generator.py          |   1 +
 .../testbed_model/traffic_generator/scapy.py  |   1 +
 .../traffic_generator/traffic_generator.py    |  22 ++
 .../testbed_model/traffic_generator/trex.py   | 258 ++++++++++++++++++
 16 files changed, 412 insertions(+), 30 deletions(-)
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (88%)
 rename dts/{ => configurations}/tests_config.example.yaml (100%)
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index e7af60b7a6..7f2d4cf481 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -210,7 +210,8 @@ These need to be set up on a Traffic Generator Node:
 #. **Traffic generator dependencies**
 
    The traffic generator running on the traffic generator node must be installed beforehand.
-   For Scapy traffic generator, only a few Python libraries need to be installed:
+
+   For Scapy traffic generator (functional tests), only a few Python libraries need to be installed:
 
    .. code-block:: console
 
@@ -218,6 +219,32 @@ These need to be set up on a Traffic Generator Node:
       sudo pip install --upgrade pip
       sudo pip install scapy==2.5.0
 
+   For TREX traffic generator (performance tests), TREX must be downloaded and a TREX config produced for each TG NIC. For example:
+
+   .. code-block:: console
+
+      wget https://trex-tgn.cisco.com/trex/release/v3.03.tar.gz
+      tar -xf v3.03.tar.gz
+      cd v3.03
+      sudo ./dpdk_setup_ports.py -i
+
+   Within the dpdk_setup_ports.py utility, follow these instructions:
+     - Select MAC based config
+     - Select interfaces 0 and 1 on your TG NIC
+     - Do not change assumed dest to DUT MAC (just leave the default loopback)
+     - Print preview of the config
+     - Check for device address correctness
+     - Check for socket and CPU correctness (CPU/socket NUMA node should match NIC NUMA node)
+     - Write the file to a path on your system
+
+   Then, presuming you are using the test_run.example.yaml as a template for your test_run config:
+     - Uncomment the performance_traffic_generator section, making DTS use a performance TG
+     - Update the remote_path and config fields to the remote path of your TREX directory and the path to your new TREX config file
+     - Update the "perf" field to enable performance testing
+
+   After these steps, you should be ready to run performance tests with TREX.
+
+
 #. **Hardware dependencies**
 
    The traffic generators, like DPDK, need a proper driver and firmware.
@@ -525,7 +552,7 @@ And they both have two network ports which are physically connected to each othe
 ``dts/test_run.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/test_run.example.yaml
+.. literalinclude:: ../../../dts/configurations/test_run.example.yaml
    :language: yaml
    :start-at: # Define
 
@@ -535,7 +562,7 @@ And they both have two network ports which are physically connected to each othe
 ``dts/nodes.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/nodes.example.yaml
+.. literalinclude:: ../../../dts/configurations/nodes.example.yaml
    :language: yaml
    :start-at: # Define
 
@@ -551,6 +578,6 @@ to demonstrate custom test suite configuration:
 ``dts/tests_config.example.yaml``
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/tests_config.example.yaml
+.. literalinclude:: ../../../dts/configurations/tests_config.example.yaml
    :language: yaml
    :start-at: # Define
diff --git a/dts/nodes.example.yaml b/dts/configurations/nodes.example.yaml
similarity index 100%
rename from dts/nodes.example.yaml
rename to dts/configurations/nodes.example.yaml
diff --git a/dts/test_run.example.yaml b/dts/configurations/test_run.example.yaml
similarity index 88%
rename from dts/test_run.example.yaml
rename to dts/configurations/test_run.example.yaml
index c90de9d68d..c8035fccf0 100644
--- a/dts/test_run.example.yaml
+++ b/dts/configurations/test_run.example.yaml
@@ -23,8 +23,12 @@ dpdk:
     # in a subdirectory of DPDK tree root directory. Otherwise, will be using the `build_options`
     # to build the DPDK from source. Either `precompiled_build_dir` or `build_options` can be
     # defined, but not both.
-traffic_generator:
+func_traffic_generator:
   type: SCAPY
+# perf_traffic_generator:
+#   type: TREX
+#   remote_path: "/opt/trex/v3.03" # The remote path of the traffic generator application.
+#   config: "/opt/trex_config/trex_config.yaml" # Additional configuration files. (Leave blank if not required)
 perf: false # disable performance testing
 func: true # enable functional testing
 use_virtual_functions: false # use virtual functions (VFs) instead of physical functions
diff --git a/dts/tests_config.example.yaml b/dts/configurations/tests_config.example.yaml
similarity index 100%
rename from dts/tests_config.example.yaml
rename to dts/configurations/tests_config.example.yaml
diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 71b3755d6e..68db862cea 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -16,7 +16,7 @@
 from enum import Enum, auto, unique
 from functools import cached_property
 from pathlib import Path, PurePath
-from typing import Annotated, Any, Literal, NamedTuple
+from typing import Annotated, Any, Literal, NamedTuple, Optional
 
 from pydantic import (
     BaseModel,
@@ -396,6 +396,8 @@ class TrafficGeneratorType(str, Enum):
 
     #:
     SCAPY = "SCAPY"
+    #:
+    TREX = "TREX"
 
 
 class TrafficGeneratorConfig(FrozenModel):
@@ -412,8 +414,18 @@ class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
     type: Literal[TrafficGeneratorType.SCAPY]
 
 
+class TrexTrafficGeneratorConfig(TrafficGeneratorConfig):
+    """TREX traffic generator specific configuration."""
+
+    type: Literal[TrafficGeneratorType.TREX]
+    remote_path: PurePath
+    config: PurePath
+
+
 #: A union type discriminating traffic generators by the `type` field.
-TrafficGeneratorConfigTypes = Annotated[ScapyTrafficGeneratorConfig, Field(discriminator="type")]
+TrafficGeneratorConfigTypes = Annotated[
+    TrexTrafficGeneratorConfig, ScapyTrafficGeneratorConfig, Field(discriminator="type")
+]
 
 #: Comma-separated list of logical cores to use. An empty string or ```any``` means use all lcores.
 LogicalCores = Annotated[
@@ -461,8 +473,10 @@ class TestRunConfiguration(FrozenModel):
 
     #: The DPDK configuration used to test.
     dpdk: DPDKConfiguration
-    #: The traffic generator configuration used to test.
-    traffic_generator: TrafficGeneratorConfigTypes
+    #: The traffic generator configuration used for functional tests.
+    func_traffic_generator: Optional[ScapyTrafficGeneratorConfig] = None
+    #: The traffic generator configuration used for performance tests.
+    perf_traffic_generator: Optional[TrexTrafficGeneratorConfig] = None
     #: Whether to run performance tests.
     perf: bool
     #: Whether to run functional tests.
diff --git a/dts/framework/context.py b/dts/framework/context.py
index ae319d949f..8f1021dc96 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -6,7 +6,7 @@
 import functools
 from collections.abc import Callable
 from dataclasses import MISSING, dataclass, field, fields
-from typing import TYPE_CHECKING, Any, ParamSpec, Union
+from typing import TYPE_CHECKING, Any, Optional, ParamSpec, Union
 
 from framework.exception import InternalError
 from framework.remote_session.shell_pool import ShellPool
@@ -76,7 +76,8 @@ class Context:
     topology: Topology
     dpdk_build: "DPDKBuildEnvironment"
     dpdk: "DPDKRuntimeEnvironment"
-    tg: "TrafficGenerator"
+    func_tg: Optional["TrafficGenerator"]
+    perf_tg: Optional["TrafficGenerator"]
     local: LocalContext = field(default_factory=LocalContext)
     shell_pool: ShellPool = field(default_factory=ShellPool)
 
diff --git a/dts/framework/remote_session/blocking_app.py b/dts/framework/remote_session/blocking_app.py
index 8de536c259..b38ad1c15a 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -48,7 +48,7 @@ class BlockingApp(InteractiveShell, Generic[P]):
     def __init__(
         self,
         node: Node,
-        path: PurePath,
+        path: str | PurePath,
         name: str | None = None,
         privileged: bool = False,
         app_params: P | str = "",
@@ -73,7 +73,7 @@ def __init__(
         super().__init__(node, name, privileged, app_params)
 
     @property
-    def path(self) -> PurePath:
+    def path(self) -> str | PurePath:
         """The path of the DPDK app relative to the DPDK build folder."""
         return self._path
 
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index ce93247051..34803f4f7f 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -259,7 +259,7 @@ def close(self) -> None:
 
     @property
     @abstractmethod
-    def path(self) -> PurePath:
+    def path(self) -> str | PurePath:
         """Path to the shell executable."""
 
     def _make_real_path(self) -> PurePath:
diff --git a/dts/framework/settings.py b/dts/framework/settings.py
index 84b627a06a..b08373b7ea 100644
--- a/dts/framework/settings.py
+++ b/dts/framework/settings.py
@@ -130,11 +130,17 @@ class Settings:
     """
 
     #:
-    test_run_config_path: Path = Path(__file__).parent.parent.joinpath("test_run.yaml")
+    test_run_config_path: Path = Path(__file__).parent.parent.joinpath(
+        "configurations/test_run.yaml"
+    )
     #:
-    nodes_config_path: Path = Path(__file__).parent.parent.joinpath("nodes.yaml")
+    nodes_config_path: Path = Path(__file__).parent.parent.joinpath("configurations/nodes.yaml")
     #:
-    tests_config_path: Path | None = None
+    tests_config_path: Path | None = (
+        Path(__file__).parent.parent.joinpath("configurations/tests_config.yaml")
+        if os.path.exists("configurations/tests_config.yaml")
+        else None
+    )
     #:
     output_dir: str = "output"
     #:
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 9cf04c0b06..e1450d13cf 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -113,7 +113,7 @@
 from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
 from framework.settings import SETTINGS
 from framework.test_result import Result, ResultNode, TestRunResult
-from framework.test_suite import BaseConfig, TestCase, TestSuite
+from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
 from framework.testbed_model.capability import (
     Capability,
     get_supported_capabilities,
@@ -199,10 +199,26 @@ def __init__(
 
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
-        traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
+
+        func_traffic_generator = (
+            create_traffic_generator(config.func_traffic_generator, tg_node)
+            if config.func
+            else None
+        )
+        perf_traffic_generator = (
+            create_traffic_generator(config.perf_traffic_generator, tg_node)
+            if config.perf
+            else None
+        )
 
         self.ctx = Context(
-            sut_node, tg_node, topology, dpdk_build_env, dpdk_runtime_env, traffic_generator
+            sut_node,
+            tg_node,
+            topology,
+            dpdk_build_env,
+            dpdk_runtime_env,
+            func_traffic_generator,
+            perf_traffic_generator,
         )
         self.result = result
         self.selected_tests = list(self.config.filter_tests(tests_config))
@@ -335,7 +351,10 @@ def next(self) -> State | None:
             test_run.ctx.topology.instantiate_vf_ports()
 
         test_run.ctx.topology.configure_ports("sut", "dpdk")
-        test_run.ctx.tg.setup(test_run.ctx.topology)
+        if test_run.ctx.func_tg:
+            test_run.ctx.func_tg.setup(test_run.ctx.topology)
+        if test_run.ctx.perf_tg:
+            test_run.ctx.perf_tg.setup(test_run.ctx.topology)
 
         self.result.ports = [
             port.to_dict()
@@ -425,7 +444,10 @@ def next(self) -> State | None:
             self.test_run.ctx.topology.delete_vf_ports()
 
         self.test_run.ctx.shell_pool.terminate_current_pool()
-        self.test_run.ctx.tg.teardown()
+        if self.test_run.ctx.func_tg and self.test_run.ctx.func_tg.is_setup:
+            self.test_run.ctx.func_tg.teardown()
+        if self.test_run.ctx.perf_tg and self.test_run.ctx.perf_tg.is_setup:
+            self.test_run.ctx.perf_tg.teardown()
         self.test_run.ctx.topology.teardown()
         self.test_run.ctx.dpdk.teardown()
         self.test_run.ctx.tg_node.teardown()
@@ -555,7 +577,6 @@ def next(self) -> State | None:
         """Next state."""
         self.test_suite.tear_down_suite()
         self.test_run.ctx.dpdk.kill_cleanup_dpdk_apps()
-        self.test_run.ctx.shell_pool.terminate_current_pool()
         self.result.mark_step_as("teardown", Result.PASS)
         return TestRunExecution(self.test_run, self.test_run.result)
 
@@ -611,6 +632,26 @@ def next(self) -> State | None:
         )
         self.test_run.ctx.topology.configure_ports("sut", sut_ports_drivers)
 
+        if (
+            self.test_run.ctx.perf_tg
+            and self.test_run.ctx.perf_tg.is_setup
+            and self.test_case.test_type is TestCaseType.FUNCTIONAL
+        ):
+            self.test_run.ctx.perf_tg.teardown()
+            self.test_run.ctx.topology.configure_ports("tg", "kernel")
+            if self.test_run.ctx.func_tg and not self.test_run.ctx.func_tg.is_setup:
+                self.test_run.ctx.func_tg.setup(self.test_run.ctx.topology)
+
+        if (
+            self.test_run.ctx.func_tg
+            and self.test_run.ctx.func_tg.is_setup
+            and self.test_case.test_type is TestCaseType.PERFORMANCE
+        ):
+            self.test_run.ctx.func_tg.teardown()
+            self.test_run.ctx.topology.configure_ports("tg", "dpdk")
+            if self.test_run.ctx.perf_tg and not self.test_run.ctx.perf_tg.is_setup:
+                self.test_run.ctx.perf_tg.setup(self.test_run.ctx.topology)
+
         self.test_suite.set_up_test_case()
         self.result.mark_step_as("setup", Result.PASS)
         return TestCaseExecution(
@@ -699,7 +740,6 @@ def description(self) -> str:
     def next(self) -> State | None:
         """Next state."""
         self.test_suite.tear_down_test_case()
-        self.test_run.ctx.shell_pool.terminate_current_pool()
         self.result.mark_step_as("teardown", Result.PASS)
         assert self.result.parent is not None
         return TestSuiteExecution(
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index 5ee5a039d7..c720106112 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -257,11 +257,11 @@ def send_packets_and_capture(
             A list of received packets.
         """
         assert isinstance(
-            self._ctx.tg, CapturingTrafficGenerator
+            self._ctx.func_tg, CapturingTrafficGenerator
         ), "Cannot capture with a non-capturing traffic generator"
         # TODO: implement @requires for types of traffic generator
         packets = self._adjust_addresses(packets)
-        return self._ctx.tg.send_packets_and_capture(
+        return self._ctx.func_tg.send_packets_and_capture(
             packets,
             self._ctx.topology.tg_port_egress,
             self._ctx.topology.tg_port_ingress,
@@ -279,7 +279,8 @@ def send_packets(
             packets: Packets to send.
         """
         packets = self._adjust_addresses(packets)
-        self._ctx.tg.send_packets(packets, self._ctx.topology.tg_port_egress)
+        if self._ctx.func_tg is not None:
+            self._ctx.func_tg.send_packets(packets, self._ctx.topology.tg_port_egress)
 
     def get_expected_packets(
         self,
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/framework/testbed_model/traffic_generator/__init__.py
index 2a259a6e6c..fca251f534 100644
--- a/dts/framework/testbed_model/traffic_generator/__init__.py
+++ b/dts/framework/testbed_model/traffic_generator/__init__.py
@@ -14,17 +14,22 @@
 and a capturing traffic generator is required.
 """
 
-from framework.config.test_run import ScapyTrafficGeneratorConfig, TrafficGeneratorConfig
+from framework.config.test_run import (
+    ScapyTrafficGeneratorConfig,
+    TrafficGeneratorConfig,
+    TrexTrafficGeneratorConfig,
+)
 from framework.exception import ConfigurationError
 from framework.testbed_model.node import Node
 
-from .capturing_traffic_generator import CapturingTrafficGenerator
 from .scapy import ScapyTrafficGenerator
+from .traffic_generator import TrafficGenerator
+from .trex import TrexTrafficGenerator
 
 
 def create_traffic_generator(
     traffic_generator_config: TrafficGeneratorConfig, node: Node
-) -> CapturingTrafficGenerator:
+) -> TrafficGenerator:
     """The factory function for creating traffic generator objects from the test run configuration.
 
     Args:
@@ -40,5 +45,7 @@ def create_traffic_generator(
     match traffic_generator_config:
         case ScapyTrafficGeneratorConfig():
             return ScapyTrafficGenerator(node, traffic_generator_config, privileged=True)
+        case TrexTrafficGeneratorConfig():
+            return TrexTrafficGenerator(node, traffic_generator_config)
         case _:
             raise ConfigurationError(f"Unknown traffic generator: {traffic_generator_config.type}")
diff --git a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
index 6b23faa1a5..f35aad64fc 100644
--- a/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
@@ -59,5 +59,6 @@ def calculate_traffic_and_stats(
 
     def setup(self, topology: Topology) -> None:
         """Overrides :meth:`.traffic_generator.TrafficGenerator.setup`."""
+        super().setup(topology)
         for port in self._tg_node.ports:
             self._tg_node.main_session.configure_port_mtu(2000, port)
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index a31807e8e4..58453cd7e0 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -320,6 +320,7 @@ def setup(self, topology: Topology) -> None:
 
         Binds the TG node ports to the kernel drivers and starts up the async sniffer.
         """
+        super().setup(topology)
         topology.configure_ports("tg", "kernel")
 
         self._sniffer = ScapyAsyncSniffer(
diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
index e5f246df7a..cdda5a7c08 100644
--- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
+++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
@@ -11,9 +11,12 @@
 from abc import ABC, abstractmethod
 from typing import Any
 
+from scapy.packet import Packet
+
 from framework.config.test_run import TrafficGeneratorConfig
 from framework.logger import DTSLogger, get_dts_logger
 from framework.testbed_model.node import Node
+from framework.testbed_model.port import Port
 from framework.testbed_model.topology import Topology
 
 
@@ -30,6 +33,7 @@ class TrafficGenerator(ABC):
     _config: TrafficGeneratorConfig
     _tg_node: Node
     _logger: DTSLogger
+    _is_setup: bool
 
     def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs: Any) -> None:
         """Initialize the traffic generator.
@@ -45,12 +49,25 @@ def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs: Any)
         self._config = config
         self._tg_node = tg_node
         self._logger = get_dts_logger(f"{self._tg_node.name} {self._config.type}")
+        self._is_setup = False
+
+    def send_packets(self, packets: list[Packet], port: Port) -> None:
+        """Send `packets` and block until they are fully sent.
+
+        Send `packets` on `port`, then wait until `packets` are fully sent.
+
+        Args:
+            packets: The packets to send.
+            port: The egress port on the TG node.
+        """
 
     def setup(self, topology: Topology) -> None:
         """Setup the traffic generator."""
+        self._is_setup = True
 
     def teardown(self) -> None:
         """Teardown the traffic generator."""
+        self._is_setup = False
         self.close()
 
     @property
@@ -61,3 +78,8 @@ def is_capturing(self) -> bool:
     @abstractmethod
     def close(self) -> None:
         """Free all resources used by the traffic generator."""
+
+    @property
+    def is_setup(self) -> bool:
+        """Indicates whether the traffic generator application is currently running."""
+        return self._is_setup
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
new file mode 100644
index 0000000000..08147cdde2
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -0,0 +1,258 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 University of New Hampshire
+
+"""Implementation for TREX performance traffic generator."""
+
+import ast
+import time
+from dataclasses import dataclass, field
+from enum import auto
+from typing import ClassVar
+
+from scapy.packet import Packet
+
+from framework.config.node import OS, NodeConfiguration
+from framework.config.test_run import TrexTrafficGeneratorConfig
+from framework.parser import TextParser
+from framework.remote_session.blocking_app import BlockingApp
+from framework.remote_session.python_shell import PythonShell
+from framework.testbed_model.node import Node, create_session
+from framework.testbed_model.os_session import OSSession
+from framework.testbed_model.topology import Topology
+from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
+from framework.utils import StrEnum
+
+
+@dataclass(slots=True)
+class TrexPerformanceTrafficStats(PerformanceTrafficStats, TextParser):
+    """Data structure to store performance statistics for a given test run.
+
+    This class overrides the initialization of :class:`PerformanceTrafficStats`
+    in order to set the attribute values using the TREX stats output.
+
+    Attributes:
+        tx_pps: Recorded tx packets per second
+        tx_bps: Recorded tx bytes per second
+        rx_pps: Recorded rx packets per second
+        rx_bps: Recorded rx bytes per second
+        frame_size: The total length of the frame
+    """
+
+    tx_pps: int = field(metadata=TextParser.find_int(r"total.*'tx_pps': (\d+)"))
+    tx_bps: int = field(metadata=TextParser.find_int(r"total.*'tx_bps': (\d+)"))
+    rx_pps: int = field(metadata=TextParser.find_int(r"total.*'rx_pps': (\d+)"))
+    rx_bps: int = field(metadata=TextParser.find_int(r"total.*'rx_bps': (\d+)"))
+
+
+class TrexStatelessTXModes(StrEnum):
+    """Flags indicating TREX instance's current transmission mode."""
+
+    #: Transmit continuously
+    STLTXCont = auto()
+    #: Transmit in a single burst
+    STLTXSingleBurst = auto()
+    #: Transmit in multiple bursts
+    STLTXMultiBurst = auto()
+
+
+class TrexTrafficGenerator(PerformanceTrafficGenerator):
+    """TREX traffic generator.
+
+    This implementation leverages the stateless API library provided in the TREX installation.
+
+    Attributes:
+        stl_client_name: The name of the stateless client used in the stateless API.
+        packet_stream_name: The name of the stateless packet stream used in the stateless API.
+    """
+
+    _os_session: OSSession
+
+    _tg_config: TrexTrafficGeneratorConfig
+    _node_config: NodeConfiguration
+
+    _shell: PythonShell
+    _python_indentation: ClassVar[str] = " " * 4
+
+    stl_client_name: ClassVar[str] = "client"
+    packet_stream_name: ClassVar[str] = "stream"
+
+    _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.STLTXCont
+
+    _tg_cores: int = 10
+
+    _trex_app: BlockingApp
+
+    def __init__(self, tg_node: Node, config: TrexTrafficGeneratorConfig) -> None:
+        """Initialize the TREX server.
+
+        Initializes needed OS sessions for the creation of the TREX server process.
+
+        Args:
+            tg_node: TG node the TREX instance is operating on.
+            config: Traffic generator config provided for TREX instance.
+        """
+        assert (
+            tg_node.config.os == OS.linux
+        ), "Linux is the only supported OS for trex traffic generation"
+
+        super().__init__(tg_node=tg_node, config=config)
+        self._tg_node_config = tg_node.config
+        self._tg_config = config
+
+        self._os_session = create_session(self._tg_node.config, "TREX", self._logger)
+
+    def setup(self, topology: Topology):
+        """Initialize and start a TREX server process."""
+        super().setup(topology)
+
+        self._shell = PythonShell(self._tg_node, "TREX-client", privileged=True)
+
+        # Start TREX server process.
+        trex_app_path = f"cd {self._tg_config.remote_path} && ./t-rex-64"
+        self._trex_app = BlockingApp(
+            node=self._tg_node,
+            path=trex_app_path,
+            name="trex-tg",
+            privileged=True,
+            app_params=f"--cfg {self._tg_config.config} -c {self._tg_cores} -i",
+        )
+        self._trex_app.wait_until_ready("-Per port stats table")
+
+        self._shell.start_application()
+        self._shell.send_command("import os")
+        self._shell.send_command(
+            f"os.chdir('{self._tg_config.remote_path}/automation/trex_control_plane/interactive')"
+        )
+
+        # Import stateless API components.
+        imports = [
+            "import trex",
+            "import trex.stl",
+            "import trex.stl.trex_stl_client",
+            "import trex.stl.trex_stl_streams",
+            "import trex.stl.trex_stl_packet_builder_scapy",
+            "from scapy.layers.l2 import Ether",
+            "from scapy.layers.inet import IP",
+            "from scapy.packet import Raw",
+        ]
+        self._shell.send_command("\n".join(imports))
+
+        stateless_client = [
+            f"{self.stl_client_name} = trex.stl.trex_stl_client.STLClient(",
+            f"username='{self._tg_node_config.user}',",
+            "server='127.0.0.1',",
+            ")",
+        ]
+
+        self._shell.send_command(f"\n{self._python_indentation}".join(stateless_client))
+        self._shell.send_command(f"{self.stl_client_name}.connect()")
+
+    def calculate_traffic_and_stats(
+        self,
+        packet: Packet,
+        duration: float,
+        send_mpps: int | None = None,
+    ) -> PerformanceTrafficStats:
+        """Send packet traffic and acquire associated statistics.
+
+        Overrides
+        :meth:`~.traffic_generator.PerformanceTrafficGenerator.calculate_traffic_and_stats`.
+        """
+        trex_stats_output = ast.literal_eval(self._generate_traffic(packet, duration, send_mpps))
+        stats = TrexPerformanceTrafficStats.parse(str(trex_stats_output))
+        stats.frame_size = len(packet)
+        return stats
+
+    def _generate_traffic(
+        self, packet: Packet, duration: float, send_mpps: int | None = None
+    ) -> str:
+        """Generate traffic using provided packet.
+
+        Uses the provided packet to generate traffic for the provided duration.
+
+        Args:
+            packet: The packet being used for the performance test.
+            duration: The duration of the test being performed.
+            send_mpps: MPPS send rate.
+
+        Returns:
+            A string output of statistics provided by the traffic generator.
+        """
+        self._create_packet_stream(packet)
+        self._setup_trex_client()
+
+        stats = self._send_traffic_and_get_stats(duration, send_mpps)
+
+        return stats
+
+    def _setup_trex_client(self) -> None:
+        """Create trex client and connect to the server process."""
+        # Prepare TREX client for next performance test.
+        procedure = [
+            f"{self.stl_client_name}.connect()",
+            f"{self.stl_client_name}.reset(ports = [0, 1])",
+            f"{self.stl_client_name}.clear_stats()",
+            f"{self.stl_client_name}.add_streams({self.packet_stream_name}, ports=[0, 1])",
+        ]
+
+        for command in procedure:
+            self._shell.send_command(command)
+
+    def _create_packet_stream(self, packet: Packet) -> None:
+        """Create TREX packet stream with the given packet.
+
+        Args:
+            packet: The packet being used for the performance test.
+        """
+        # Create the tx packet on the TG shell
+        self._shell.send_command(f"packet={packet.command()}")
+
+        packet_stream = [
+            f"{self.packet_stream_name} = trex.stl.trex_stl_streams.STLStream(",
+            f"name='Test_{len(packet)}_bytes',",
+            "packet=trex.stl.trex_stl_packet_builder_scapy.STLPktBuilder(pkt=packet),",
+            f"mode=trex.stl.trex_stl_streams.{self._streaming_mode}(percentage=100),",
+            ")",
+        ]
+        self._shell.send_command("\n".join(packet_stream))
+
+    def _send_traffic_and_get_stats(self, duration: float, send_mpps: float | None = None) -> str:
+        """Send traffic and get TG Rx stats.
+
+        Sends traffic from the TREX client's ports for the given duration.
+        When the traffic sending duration has passed, collect the aggregate
+        statistics and return TREX's global stats as a string.
+
+        Args:
+            duration: The traffic generation duration.
+            send_mpps: The millions of packets per second for TREX to send from each port.
+        """
+        if send_mpps:
+            self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                mult = '{send_mpps}mpps',
+                duration = {duration})""")
+        else:
+            self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+                mult = '100%',
+                duration = {duration})""")
+
+        time.sleep(duration)
+
+        stats = self._shell.send_command(
+            f"{self.stl_client_name}.get_stats(ports=[0, 1])", skip_first_line=True
+        )
+
+        self._shell.send_command(f"{self.stl_client_name}.stop(ports=[0, 1])")
+
+        return stats
+
+    def close(self) -> None:
+        """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
+
+        Stops the traffic generator and sniffer shells.
+        """
+        self._trex_app.close()
+        self._shell.close()
-- 
2.49.0

