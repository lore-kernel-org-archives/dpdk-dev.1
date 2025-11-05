Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF45CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 22:37:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3961540E0B;
	Wed,  5 Nov 2025 23:37:44 +0100 (CET)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id C901C40E13
 for <dev@dpdk.org>; Wed,  5 Nov 2025 23:37:42 +0100 (CET)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4e896e91368so4181911cf.0
 for <dev@dpdk.org>; Wed, 05 Nov 2025 14:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762382262; x=1762987062; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLNNY8l/zXWe+5eh0kQyQ5JfhNpTvzleu105IKSB3Sw=;
 b=Ick5WuUgBk6h9uFbnUoAXD+boTi+yuc6yZQbgfbEa1M0RpJWkfgDzi/C8gJufsBf+/
 ITwoPDsRPO9TKIri+C8tTUh5JBxPRBWyP9CZ8Pk8PSnyDjJWAPr9TxUTW+d0rEMwDEKE
 i5+FAtkqWVuGNLldbD3sQl003qZFZVNhDHpJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762382262; x=1762987062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wLNNY8l/zXWe+5eh0kQyQ5JfhNpTvzleu105IKSB3Sw=;
 b=rtw5hG3xshno42m1b6fKcDHyO9TOaVOiPp3MtZ5suGwswRH6GYrIoeGaQgEZNyCgix
 hObaOC4Dym5DgiUTtISRXNyrBIQe/2sBqRK5cCIOWCU6fxqW+HT+pq1rN1BAdr0IgMwL
 gVOmlo6pIt1nnh770f3F6xYb8IdiDe6eSq+3aJuND/QrRKVn4FDb7pQn10CBSk6fJKKC
 FmSnlaMx/X/zFYxfJGqsqVj73es3Qb75sIWW2f6+PzwC06AMXyXwrwwCCZKu7gw89iRH
 TTrDIZ53y+yHjhcL+RkpTpxDSC1FsHrVTq97v33JkTLHs4B7eWOppn0cfJ1LCK5HBcHt
 j9vw==
X-Gm-Message-State: AOJu0YzXIQqRCQ9LjsKN4iTdDgGhP2JKIMbDGU5G/PMZn9UWSyDaRMjI
 s2jkxWOQlobcnbDTakHHsiMKdw3Yv1srlTAZh68rhjt8/eTFqpZjbxXy/0qzAQq6vVU=
X-Gm-Gg: ASbGncv0XTBIC+UyKi6vxrMBHEK/odsYQdGyY8CumdLbwys4ZdbX7xT+eRPJ3eLqauQ
 /GQnzYPleQboJRfn7MJtppFVXRK5HNuqfsFW6GE1BKTdLlOc544AlXRBUPALTj5X/PR7jPWGa2W
 6QvoGmnohQ7uraIU4mCJm7Wl3GvWG8NLv4RercZAYerDT9xadhWiKv5uf/wC7HGaQUKxT69GiAf
 99lFESQh3YA8S+nq7IHp/3cpRqMSQlchO0Vjk0bO9KrIx25NoHyUQEjgnhkCiELXY1dM9xBlVQU
 HxvawIu1pI+JI5rJeQQrwdRh4dpt2kBpz7kgDI1l64Q1BIR4fLOoewNQq3a+1QHee74YeUNlumL
 440Ynp5t0BtY/TWGQTa4IDTk5cEhVj/0Abs7uYEVfM9AGp8hRZfyp6k6rSbvlARlOVSZ0Ghkv5O
 6v
X-Google-Smtp-Source: AGHT+IHdR1Y61vcTfhwZ0wMDVxrSinaBpNcfkurr2Giv99gXERSoCLj1yeQmaHS28/1B8KO99qm7Zw==
X-Received: by 2002:a05:622a:228d:b0:4d1:2fe4:1ba9 with SMTP id
 d75a77b69052e-4ed72609878mr69486991cf.43.1762382261755; 
 Wed, 05 Nov 2025 14:37:41 -0800 (PST)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1210::219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ed813da43asm4883981cf.27.2025.11.05.14.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 14:37:40 -0800 (PST)
From: Patrick Robb <probb@iol.unh.edu>
To: Luca.Vizzarro@arm.com
Cc: dev@dpdk.org, Paul.Szczepanek@arm.com, dmarx@iol.unh.edu,
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v6 2/3] dts: add trex traffic generator to dts framework
Date: Wed,  5 Nov 2025 17:36:27 -0500
Message-ID: <20251105223628.1659390-3-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251105223628.1659390-1-probb@iol.unh.edu>
References: <20251023013049.1368129-1-probb@iol.unh.edu>
 <20251105223628.1659390-1-probb@iol.unh.edu>
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
needed. There is also an added boolean toggle for adding new shells
to the current shell pool or omitting them from the shell pool in order
to facilitate this new TG initialization approach.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Andrew Bailey <abailey@iol.unh.edu>
---
 doc/guides/tools/dts.rst                      |  55 +++-
 dts/api/packet.py                             |   6 +-
 dts/{ => configurations}/nodes.example.yaml   |   0
 .../test_run.example.yaml                     |   6 +-
 .../tests_config.example.yaml                 |   0
 dts/framework/config/test_run.py              |  22 +-
 dts/framework/context.py                      |   5 +-
 dts/framework/remote_session/blocking_app.py  |  12 +-
 .../remote_session/interactive_shell.py       |   8 +-
 dts/framework/settings.py                     |  12 +-
 dts/framework/test_run.py                     |  52 +++-
 .../traffic_generator/__init__.py             |  13 +-
 .../testbed_model/traffic_generator/scapy.py  |  14 +-
 .../traffic_generator/traffic_generator.py    |  22 ++
 .../testbed_model/traffic_generator/trex.py   | 259 ++++++++++++++++++
 15 files changed, 440 insertions(+), 46 deletions(-)
 rename dts/{ => configurations}/nodes.example.yaml (100%)
 rename dts/{ => configurations}/test_run.example.yaml (88%)
 rename dts/{ => configurations}/tests_config.example.yaml (100%)
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py

diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
index 25c08c6a00..73d89eb1f6 100644
--- a/doc/guides/tools/dts.rst
+++ b/doc/guides/tools/dts.rst
@@ -209,7 +209,8 @@ These need to be set up on a Traffic Generator Node:
 #. **Traffic generator dependencies**
 
    The traffic generator running on the traffic generator node must be installed beforehand.
-   For Scapy traffic generator, only a few Python libraries need to be installed:
+
+   For Scapy traffic generator (functional tests), only a few Python libraries need to be installed:
 
    .. code-block:: console
 
@@ -217,6 +218,32 @@ These need to be set up on a Traffic Generator Node:
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
@@ -249,9 +276,9 @@ DTS configuration is split into nodes and a test run,
 and must respect the model definitions
 as documented in the DTS API docs under the ``config`` page.
 The root of the configuration is represented by the ``Configuration`` model.
-By default, DTS will try to use the ``dts/test_run.example.yaml``
+By default, DTS will try to use the ``dts/configurations/test_run.example.yaml``
 :ref:`config file <test_run_configuration_example>`,
-and ``dts/nodes.example.yaml``
+and ``dts/configurations/nodes.example.yaml``
 :ref:`config file <nodes_configuration_example>`
 which are templates that illustrate what can be configured in DTS.
 
@@ -278,9 +305,9 @@ DTS is run with ``main.py`` located in the ``dts`` directory using the ``poetry
    options:
      -h, --help            show this help message and exit
      --test-run-config-file FILE_PATH
-                           [DTS_TEST_RUN_CFG_FILE] The configuration file that describes the test cases and DPDK build options. (default: test-run.conf.yaml)
+                           [DTS_TEST_RUN_CFG_FILE] The configuration file that describes the test cases and DPDK build options. (default: configurations/test_run.yaml)
      --nodes-config-file FILE_PATH
-                           [DTS_NODES_CFG_FILE] The configuration file that describes the SUT and TG nodes. (default: nodes.conf.yaml)
+                           [DTS_NODES_CFG_FILE] The configuration file that describes the SUT and TG nodes. (default: configurations/nodes.yaml)
      --tests-config-file FILE_PATH
                            [DTS_TESTS_CFG_FILE] Configuration file used to override variable values inside specific test suites. (default: None)
      --output-dir DIR_PATH, --output DIR_PATH
@@ -549,20 +576,20 @@ And they both have two network ports which are physically connected to each othe
 
 .. _test_run_configuration_example:
 
-``dts/test_run.example.yaml``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+``dts/configurations/test_run.example.yaml``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/test_run.example.yaml
+.. literalinclude:: ../../../dts/configurations/test_run.example.yaml
    :language: yaml
    :start-at: # Define
 
 .. _nodes_configuration_example:
 
 
-``dts/nodes.example.yaml``
-~~~~~~~~~~~~~~~~~~~~~~~~~~
+``dts/configurations/nodes.example.yaml``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/nodes.example.yaml
+.. literalinclude:: ../../../dts/configurations/nodes.example.yaml
    :language: yaml
    :start-at: # Define
 
@@ -575,9 +602,9 @@ to demonstrate custom test suite configuration:
 
 .. _tests_config_example:
 
-``dts/tests_config.example.yaml``
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+``dts/configurations/tests_config.example.yaml``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. literalinclude:: ../../../dts/tests_config.example.yaml
+.. literalinclude:: ../../../dts/configurations/tests_config.example.yaml
    :language: yaml
    :start-at: # Define
diff --git a/dts/api/packet.py b/dts/api/packet.py
index b6759d4ce0..ac7f64dd17 100644
--- a/dts/api/packet.py
+++ b/dts/api/packet.py
@@ -85,9 +85,9 @@ def send_packets_and_capture(
     )
 
     assert isinstance(
-        get_ctx().tg, CapturingTrafficGenerator
+        get_ctx().func_tg, CapturingTrafficGenerator
     ), "Cannot capture with a non-capturing traffic generator"
-    tg: CapturingTrafficGenerator = cast(CapturingTrafficGenerator, get_ctx().tg)
+    tg: CapturingTrafficGenerator = cast(CapturingTrafficGenerator, get_ctx().func_tg)
     # TODO: implement @requires for types of traffic generator
     packets = adjust_addresses(packets)
     return tg.send_packets_and_capture(
@@ -108,7 +108,7 @@ def send_packets(
         packets: Packets to send.
     """
     packets = adjust_addresses(packets)
-    get_ctx().tg.send_packets(packets, get_ctx().topology.tg_port_egress)
+    get_ctx().func_tg.send_packets(packets, get_ctx().topology.tg_port_egress)
 
 
 def get_expected_packets(
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
index 8de536c259..c3b02dcc62 100644
--- a/dts/framework/remote_session/blocking_app.py
+++ b/dts/framework/remote_session/blocking_app.py
@@ -48,20 +48,23 @@ class BlockingApp(InteractiveShell, Generic[P]):
     def __init__(
         self,
         node: Node,
-        path: PurePath,
+        path: str | PurePath,
         name: str | None = None,
         privileged: bool = False,
         app_params: P | str = "",
+        add_to_shell_pool: bool = True,
     ) -> None:
         """Constructor.
 
         Args:
             node: The node to run the app on.
-            path: Path to the application on the node.
+            path: Path to the application on the node.s
             name: Name to identify this application.
             privileged: Run as privileged user.
             app_params: The application parameters. Can be of any type inheriting :class:`Params` or
                 a plain string.
+            add_to_shell_pool: If :data:`True`, the blocking app's shell will be added to the
+                shell pool.
         """
         if isinstance(app_params, str):
             params = Params()
@@ -69,11 +72,12 @@ def __init__(
             app_params = cast(P, params)
 
         self._path = path
+        self._add_to_shell_pool = add_to_shell_pool
 
         super().__init__(node, name, privileged, app_params)
 
     @property
-    def path(self) -> PurePath:
+    def path(self) -> str | PurePath:
         """The path of the DPDK app relative to the DPDK build folder."""
         return self._path
 
@@ -86,7 +90,7 @@ def wait_until_ready(self, end_token: str) -> Self:
         Returns:
             Itself.
         """
-        self.start_application(end_token)
+        self.start_application(end_token, self._add_to_shell_pool)
         return self
 
     def close(self) -> None:
diff --git a/dts/framework/remote_session/interactive_shell.py b/dts/framework/remote_session/interactive_shell.py
index ce93247051..a65cbce209 100644
--- a/dts/framework/remote_session/interactive_shell.py
+++ b/dts/framework/remote_session/interactive_shell.py
@@ -140,7 +140,7 @@ def _make_start_command(self) -> str:
             start_command = self._node.main_session._get_privileged_command(start_command)
         return start_command
 
-    def start_application(self, prompt: str | None = None) -> None:
+    def start_application(self, prompt: str | None = None, add_to_shell_pool: bool = True) -> None:
         """Starts a new interactive application based on the path to the app.
 
         This method is often overridden by subclasses as their process for starting may look
@@ -151,6 +151,7 @@ def start_application(self, prompt: str | None = None) -> None:
         Args:
             prompt: When starting up the application, expect this string at the end of stdout when
                 the application is ready. If :data:`None`, the class' default prompt will be used.
+            add_to_shell_pool: If :data:`True`, the shell will be registered to the shell pool.
 
         Raises:
             InteractiveCommandExecutionError: If the application fails to start within the allotted
@@ -174,7 +175,8 @@ def start_application(self, prompt: str | None = None) -> None:
             self.is_alive = False  # update state on failure to start
             raise InteractiveCommandExecutionError("Failed to start application.")
         self._ssh_channel.settimeout(self._timeout)
-        get_ctx().shell_pool.register_shell(self)
+        if add_to_shell_pool:
+            get_ctx().shell_pool.register_shell(self)
 
     def send_command(
         self, command: str, prompt: str | None = None, skip_first_line: bool = False
@@ -259,7 +261,7 @@ def close(self) -> None:
 
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
index 9cf04c0b06..ff0a12c9ce 100644
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
+            if config.func and config.func_traffic_generator
+            else None
+        )
+        perf_traffic_generator = (
+            create_traffic_generator(config.perf_traffic_generator, tg_node)
+            if config.perf and config.perf_traffic_generator
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
@@ -611,6 +633,26 @@ def next(self) -> State | None:
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
diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
index a31807e8e4..9e15a31c00 100644
--- a/dts/framework/testbed_model/traffic_generator/scapy.py
+++ b/dts/framework/testbed_model/traffic_generator/scapy.py
@@ -170,12 +170,17 @@ def stop_capturing_and_collect(
         finally:
             self.stop_capturing()
 
-    def start_application(self, prompt: str | None = None) -> None:
+    def start_application(self, prompt: str | None = None, add_to_shell_pool: bool = True) -> None:
         """Overrides :meth:`framework.remote_session.interactive_shell.start_application`.
 
         Prepares the Python shell for scapy and starts the sniffing in a new thread.
+
+        Args:
+            prompt: When starting up the application, expect this string at the end of stdout when
+                the application is ready. If :data:`None`, the class' default prompt will be used.
+            add_to_shell_pool: If :data:`True`, the shell will be registered to the shell pool.
         """
-        super().start_application(prompt)
+        super().start_application(prompt, add_to_shell_pool)
         self.send_command("from scapy.all import *")
         self._sniffer.start()
         self._is_sniffing.wait()
@@ -320,15 +325,16 @@ def setup(self, topology: Topology) -> None:
 
         Binds the TG node ports to the kernel drivers and starts up the async sniffer.
         """
+        super().setup(topology)
         topology.configure_ports("tg", "kernel")
 
         self._sniffer = ScapyAsyncSniffer(
             self._tg_node, topology.tg_port_ingress, self._sniffer_name
         )
-        self._sniffer.start_application()
+        self._sniffer.start_application(add_to_shell_pool=False)
 
         self._shell = PythonShell(self._tg_node, "scapy", privileged=True)
-        self._shell.start_application()
+        self._shell.start_application(add_to_shell_pool=False)
         self._shell.send_command("from scapy.all import *")
         self._shell.send_command("from scapy.contrib.lldp import *")
 
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
index 0000000000..6ae6d1f181
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -0,0 +1,259 @@
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
+        tx_pps: Recorded tx packets per second.
+        tx_bps: Recorded tx bytes per second.
+        rx_pps: Recorded rx packets per second.
+        rx_bps: Recorded rx bytes per second.
+        frame_size: The total length of the frame.
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
+            add_to_shell_pool=False,
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

