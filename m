Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3CDC369D5
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 19:41:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 897954064A;
	Wed, 23 Apr 2025 21:40:54 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id DBD2340395
 for <dev@dpdk.org>; Wed, 23 Apr 2025 21:40:51 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-7c5f619cc01so3204985a.3
 for <dev@dpdk.org>; Wed, 23 Apr 2025 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745437251; x=1746042051; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lGxqHqRxMTCkFVxPrWMTC7DO54mLZKqgwBMG3GDMvE=;
 b=GoQaFqDZOlbt1nn8G9d1yIWujRAMNZB3IwG5DUjzT1FTjY1/ZnakjuVo5ymlSvUlrK
 +cq8u62AnhXF24AZvjfEhpDZYK1BM1hwR6hItSNcYfV7mDeJ0HWOWXQuHjbu/Q6u3po3
 VOLGOYoWxDshOcobFERtCeoIIpZNVoWt5vWeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745437251; x=1746042051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9lGxqHqRxMTCkFVxPrWMTC7DO54mLZKqgwBMG3GDMvE=;
 b=LSGOixfw+VKlnL4fy6DLSh91EoyjxEtjdc0+ezxmWfW/Wq+7HaCSwhyncXCRphISd7
 liHF6lIVmDLzYZLVVvadmHmVXy4IeFpiv7htwugpr53D9mcnauGejkHdTytoDbf4TxwK
 96Af1S2xYHq5MQkRO860273A+5I64atD3F0wbGk3busBNc62OF132CjsZ7IThxatJ54D
 BAyiIU/4brhPKVnZrgJXPm3kHntcSuZJRKwRv7GH3RaSBnr4938nzNjnqDujLcmRyNsv
 yyg3JW6w+tN4Zba4aZkzRORuhCYeK0sJkvg/w2hmwFqnnSxJb3TRIpmsVQkw+Ik/guur
 Ispg==
X-Gm-Message-State: AOJu0YxXHlc/Cwl3w6lP32FJ+xEnRMT8EWMEoTUUJ87RKnl7x14nfKp2
 2IcLrmMPpCosQcGZXGwSXNQLY2Bc3PZhHiYM5rOd1RRQ+dycFO67HxE/AuSiGvo=
X-Gm-Gg: ASbGncu4MO3J8lbzOc2rOaOgiKG/peu7XYi6hK7rJkbVCHIaiBHaoMsjMWe2mCk2ACg
 v8nB6ZHl8voJAEPPlb1D09QpRifZOLwMNDOkHF5vFWQo/Kk8gYm5gCwscHd/u/h80hV6FqWy6Bm
 gfrO/VQrD54LVR/G9cH96CSojiXMT81jVYV/5fNrH8vp8DOiz+TfDBWq0fn6asllyLfDaJmXOfG
 Tt2AN1kPYQhxTiSUYy6xRFkFjM7RSpNElju212KWhdA9M9nimSEAR+/qvz4GjUNdVZmcDOnmU6q
 FY/w3KpxNiQMeJpzy1AIqJYfl5c2suhJ2+QMo/5fpKW4owXn4dku0x1kgwRngVR4UZOxsLtN/mk
 MBRl5sxq2xuOw6kI2
X-Google-Smtp-Source: AGHT+IGXUC5OLo3Y0olJOq1u4Md5G4EC87kEKqCiNDXpY9qHbhC9HhzPFRmZDm42xhrX0HUDWOnTuQ==
X-Received: by 2002:ac8:5dd2:0:b0:472:4c8:64c6 with SMTP id
 d75a77b69052e-47d1c7435e1mr25799131cf.9.1745437250966; 
 Wed, 23 Apr 2025 12:40:50 -0700 (PDT)
Received: from localhost.unh.edu ([2606:4100:3880:1271:e2f8:4ec3:8bf3:864c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ae9cf9f7dsm71635691cf.74.2025.04.23.12.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:40:50 -0700 (PDT)
From: Nicholas Pratte <npratte@iol.unh.edu>
To: ian.stokes@intel.com, yoan.picchi@foss.arm.com, probb@iol.unh.edu,
 paul.szczepanek@arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net,
 luca.vizzarro@arm.com, thomas.wilks@arm.com, dmarx@iol.unh.edu,
 stephen@networkplumber.org
Cc: dev@dpdk.org,
	Nicholas Pratte <npratte@iol.unh.edu>
Subject: [RFC Patch v1 4/5] dts: add trex traffic generator to dts framework
Date: Wed, 23 Apr 2025 15:40:10 -0400
Message-ID: <20250423194011.1447679-5-npratte@iol.unh.edu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250423194011.1447679-1-npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
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

Implement the TREX traffic generator for use in the DTS framework. The
provided implementation leverages TREX's stateless API automation
library, via use of a Python shell. As such, version control of TREX may
be needed. The DTS context has been modified to include a performance
traffic generator in addition to a functional traffic generator.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
---
 dts/framework/config/test_run.py              |  20 +-
 dts/framework/context.py                      |  11 +-
 dts/framework/test_run.py                     |  28 +-
 dts/framework/test_suite.py                   |   6 +-
 .../traffic_generator/__init__.py             |  22 +-
 .../testbed_model/traffic_generator/trex.py   | 287 ++++++++++++++++++
 6 files changed, 356 insertions(+), 18 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index 06fe28143c..5cdd391b49 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -393,6 +393,8 @@ class TrafficGeneratorType(str, Enum):
 
     #:
     SCAPY = "SCAPY"
+    #:
+    TREX = "TREX"
 
 
 class TrafficGeneratorConfig(FrozenModel):
@@ -401,6 +403,8 @@ class TrafficGeneratorConfig(FrozenModel):
     #: The traffic generator type the child class is required to define to be distinguished among
     #: others.
     type: TrafficGeneratorType
+    remote_path: PurePath
+    config: PurePath
 
 
 class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
@@ -409,8 +413,16 @@ class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
     type: Literal[TrafficGeneratorType.SCAPY]
 
 
+class TrexTrafficGeneratorConfig(TrafficGeneratorConfig):
+    """TREX traffic generator specific configuration."""
+
+    type: Literal[TrafficGeneratorType.TREX]
+
+
 #: A union type discriminating traffic generators by the `type` field.
-TrafficGeneratorConfigTypes = Annotated[ScapyTrafficGeneratorConfig, Field(discriminator="type")]
+TrafficGeneratorConfigTypes = Annotated[
+    TrexTrafficGeneratorConfig, ScapyTrafficGeneratorConfig, Field(discriminator="type")
+]
 
 #: Comma-separated list of logical cores to use. An empty string or ```any``` means use all lcores.
 LogicalCores = Annotated[
@@ -458,8 +470,10 @@ class TestRunConfiguration(FrozenModel):
 
     #: The DPDK configuration used to test.
     dpdk: DPDKConfiguration
-    #: The traffic generator configuration used to test.
-    traffic_generator: TrafficGeneratorConfigTypes
+    #: The traffic generator configuration used for functional tests.
+    func_traffic_generator: TrafficGeneratorConfig
+    #: The traffic generator configuration used for performance tests.
+    perf_traffic_generator: TrafficGeneratorConfig
     #: Whether to run performance tests.
     perf: bool
     #: Whether to run functional tests.
diff --git a/dts/framework/context.py b/dts/framework/context.py
index ddd7ed4d36..0a83e2b269 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -15,7 +15,12 @@
 
 if TYPE_CHECKING:
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
-    from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
+    from framework.testbed_model.traffic_generator.capturing_traffic_generator import (
+        CapturingTrafficGenerator,
+    )
+    from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+        PerformanceTrafficGenerator,
+    )
 
 P = ParamSpec("P")
 
@@ -68,7 +73,9 @@ class Context:
     topology: Topology
     dpdk_build: "DPDKBuildEnvironment"
     dpdk: "DPDKRuntimeEnvironment"
-    tg: "TrafficGenerator"
+    tg_dpdk: "DPDKRuntimeEnvironment" | None
+    func_tg: "CapturingTrafficGenerator"
+    perf_tg: "PerformanceTrafficGenerator"
     local: LocalContext = field(default_factory=LocalContext)
 
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index f9cfe5e908..81dc553b00 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -107,7 +107,7 @@
 from types import MethodType
 from typing import ClassVar, Protocol, Union
 
-from framework.config.test_run import TestRunConfiguration
+from framework.config.test_run import TestRunConfiguration, TrafficGeneratorType
 from framework.context import Context, init_ctx
 from framework.exception import (
     InternalError,
@@ -204,10 +204,25 @@ def __init__(
 
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
-        traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
+        # There is definitely a better way to do this.
+        tg_dpdk_runtime_env = None
+        if (
+            config.perf_traffic_generator.type == TrafficGeneratorType.TREX
+            or config.func_traffic_generator.type == TrafficGeneratorType.TREX
+        ):
+            tg_dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, tg_node, None)
+        func_traffic_generator = create_traffic_generator(config.func_traffic_generator, tg_node)
+        perf_traffic_generator = create_traffic_generator(config.perf_traffic_generator, tg_node)
 
         self.ctx = Context(
-            sut_node, tg_node, topology, dpdk_build_env, dpdk_runtime_env, traffic_generator
+            sut_node,
+            tg_node,
+            topology,
+            dpdk_build_env,
+            dpdk_runtime_env,
+            tg_dpdk_runtime_env,
+            func_traffic_generator,
+            perf_traffic_generator,
         )
         self.result = result
         self.selected_tests = list(self.config.filter_tests(tests_config))
@@ -345,7 +360,9 @@ def next(self) -> State | None:
         test_run.ctx.sut_node.setup()
         test_run.ctx.tg_node.setup()
         test_run.ctx.dpdk.setup(test_run.ctx.topology.sut_ports)
-        test_run.ctx.tg.setup(test_run.ctx.topology.tg_ports)
+        test_run.ctx.tg_dpdk.setup(test_run.ctx.topology.tg_ports)
+        test_run.ctx.func_tg.setup(test_run.ctx.topology.tg_ports)
+        test_run.ctx.perf_tg.setup(test_run.ctx.topology.tg_ports)
 
         self.result.ports = test_run.ctx.topology.sut_ports + test_run.ctx.topology.tg_ports
         self.result.sut_info = test_run.ctx.sut_node.node_info
@@ -430,7 +447,8 @@ def description(self) -> str:
 
     def next(self) -> State | None:
         """Next state."""
-        self.test_run.ctx.tg.teardown(self.test_run.ctx.topology.tg_ports)
+        self.test_run.ctx.func_tg.teardown(self.test_run.ctx.topology.tg_ports)
+        self.test_run.ctx.perf_tg.teardown(self.test_run.ctx.topology.tg_ports)
         self.test_run.ctx.dpdk.teardown(self.test_run.ctx.topology.sut_ports)
         self.test_run.ctx.tg_node.teardown()
         self.test_run.ctx.sut_node.teardown()
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e07c327b77..507df508cb 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -254,11 +254,11 @@ def send_packets_and_capture(
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
@@ -276,7 +276,7 @@ def send_packets(
             packets: Packets to send.
         """
         packets = self._adjust_addresses(packets)
-        self._ctx.tg.send_packets(packets, self._ctx.topology.tg_port_egress)
+        self._ctx.func_tg.send_packets(packets, self._ctx.topology.tg_port_egress)
 
     def get_expected_packets(
         self,
diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/framework/testbed_model/traffic_generator/__init__.py
index 2a259a6e6c..53125995cd 100644
--- a/dts/framework/testbed_model/traffic_generator/__init__.py
+++ b/dts/framework/testbed_model/traffic_generator/__init__.py
@@ -14,17 +14,27 @@
 and a capturing traffic generator is required.
 """
 
-from framework.config.test_run import ScapyTrafficGeneratorConfig, TrafficGeneratorConfig
+from framework.config.test_run import (
+    ScapyTrafficGeneratorConfig as ScapyTrafficGeneratorConfig,
+)
+from framework.config.test_run import (
+    TrafficGeneratorConfig,
+    TrafficGeneratorType,
+)
+from framework.config.test_run import (
+    TrexTrafficGeneratorConfig as TrexTrafficGeneratorConfig,
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
@@ -37,8 +47,10 @@ def create_traffic_generator(
     Raises:
         ConfigurationError: If an unknown traffic generator has been setup.
     """
-    match traffic_generator_config:
-        case ScapyTrafficGeneratorConfig():
+    match traffic_generator_config.type:
+        case TrafficGeneratorType.SCAPY:
             return ScapyTrafficGenerator(node, traffic_generator_config, privileged=True)
+        case TrafficGeneratorType.TREX:
+            return TrexTrafficGenerator(node, traffic_generator_config, privileged=True)
         case _:
             raise ConfigurationError(f"Unknown traffic generator: {traffic_generator_config.type}")
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
new file mode 100644
index 0000000000..0053174ede
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -0,0 +1,287 @@
+"""Implementation for TREX performance traffic generator."""
+
+import time
+from dataclasses import dataclass
+from enum import Flag, auto
+from typing import Callable, ClassVar
+
+from invoke.runners import Promise
+from scapy.packet import Packet
+
+from framework.config.node import NodeConfiguration
+from framework.config.test_run import TrafficGeneratorConfig
+from framework.exception import SSHTimeoutError
+from framework.remote_session.python_shell import PythonShell
+from framework.remote_session.ssh_session import SSHSession
+from framework.testbed_model.linux_session import LinuxSession
+from framework.testbed_model.node import Node, create_session
+from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
+
+
+@dataclass
+class TrexPerPortStats:
+    """Performance statistics on a per port basis.
+
+    Attributes:
+        opackets: Number of packets sent.
+        obytes: Number of egress bytes sent.
+        tx_bps: Maximum bits per second transmitted.
+        tx_pps: Number of transmitted packets sent.
+    """
+
+    opackets: float
+    obytes: float
+    tx_bps: float
+    tx_pps: float
+
+
+@dataclass
+class TrexPerformanceStats(PerformanceTrafficStats):
+    """Data structure to store performance statistics for a given test run.
+
+    Attributes:
+        packet: The packet that was sent in the test run.
+        frame_size: The total length of the frame. (L2 downward)
+        tx_expected_bps: The expected bits per second on a given NIC.
+        tx_expected_cps: ...
+        tx_expected_pps: The expected packets per second of a given NIC.
+        tx_pps: The recorded maximum packets per second of the tested NIC.
+        tx_cps: The recorded maximum cps of the tested NIC
+        tx_bps: The recorded maximum bits per second of the tested NIC.
+        obytes: Total bytes output during test run.
+        port_stats: A list of :class:`TrexPerPortStats` provided by TREX.
+    """
+
+    packet: Packet
+    frame_size: int
+
+    tx_expected_bps: float
+    tx_expected_cps: float
+    tx_expected_pps: float
+
+    tx_pps: float
+    tx_cps: float
+    tx_bps: float
+
+    obytes: float
+
+    port_stats: list[TrexPerPortStats] | None
+
+
+class TrexStatelessTXModes(Flag):
+    """Flags indicating TREX instance's current trasmission mode."""
+
+    CONTINUOUS = auto()
+    SINGLE_BURST = auto()
+    MULTI_BURST = auto()
+
+
+class TrexTrafficGenerator(PythonShell, PerformanceTrafficGenerator):
+    """TREX traffic generator.
+
+    This implementation leverages the stateless API library provided in the TREX installation.
+
+    Attributes:
+        stl_client_name: The name of the stateless client used in the stateless API.
+        packet_stream_name: The name of the stateless packet stream used in the stateless API.
+        timeout_duration: Internal timeout for connection to the TREX server.
+    """
+
+    _os_session: LinuxSession
+    _server_remote_session: SSHSession
+    _trex_server_process: Promise
+
+    _tg_config: TrafficGeneratorConfig
+    _node_config: NodeConfiguration
+
+    _python_indentation: ClassVar[str] = " " * 4
+
+    stl_client_name: ClassVar[str] = "client"
+    packet_stream_name: ClassVar[str] = "stream"
+
+    _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.CONTINUOUS
+
+    timeout_duration: int
+
+    def __init__(
+        self, tg_node: Node, config: TrafficGeneratorConfig, timeout_duration: int = 5, **kwargs
+    ) -> None:
+        """Initialize the TREX server.
+
+        Initializes needed OS sessions for the creation of the TREX server process.
+
+        Attributes:
+            tg_node: TG node the TREX instance is operating on.
+            config: Traffic generator config provided for TREX instance.
+            timeout_duration: Internal timeout for connection to the TREX server.
+        """
+        super().__init__(node=tg_node, config=config, tg_node=tg_node, **kwargs)
+        self._node_config = tg_node.config
+        self._tg_config = config
+        self.timeout_duration = timeout_duration
+
+        # Create TREX server session.
+        self._tg_node._other_sessions.append(
+            create_session(self._tg_node.config, "TREX Server.", self._logger)
+        )
+        self._os_session = self._tg_node._other_sessions[0]
+        self._server_remote_session = self._os_session.remote_session
+
+    def setup(self, ports):
+        """Initialize and start a TREX server process.
+
+        Binds TG ports to vfio-pci and starts the trex process.
+
+        Attributes:
+            ports: Related ports utilized in TG instance.
+        """
+        super().setup(ports)
+        # Start TREX server process.
+        try:
+            self._logger.info("Starting TREX server process: sending 45 second sleep.")
+            privileged_command = self._os_session._get_privileged_command(
+                f"""
+                    cd /opt/v3.03/; {self._tg_config.remote_path}/t-rex-64
+                     --cfg {self._tg_config.config} -i
+                """
+            )
+            self._server_remote_session = self._server_remote_session._send_async_command(
+                privileged_command, timeout=None, env=None
+            )
+            time.sleep(45)
+        except SSHTimeoutError as e:
+            self._logger.exception("Failed to start TREX server process.", e)
+
+        # Start Python shell.
+        self.start_application()
+        self.send_command("import os")
+        # Parent directory: /opt/v3.03/automation/trex_control_plane/interactive
+        self.send_command(
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
+        self.send_command("\n".join(imports))
+
+        stateless_client = [
+            f"{self.stl_client_name} = trex.stl.trex_stl_client.STLClient(",
+            f"username='{self._node_config.user}',",
+            "server='127.0.0.1',",
+            f"sync_timeout={self.timeout_duration}",
+            ")",
+        ]
+        self.send_command(f"\n{self._python_indentation}".join(stateless_client))
+        self.send_command(f"{self.stl_client_name}.connect()")
+
+    def teardown(self, ports):
+        """Teardown the TREX server and stateless implementation.
+
+        close the TREX server process, and stop the Python shell.
+
+        Attributes:
+            ports: Associated ports used by the TREX instance.
+        """
+        super().teardown(ports)
+        self.send_command(f"{self.stl_client_name}.disconnect()")
+        self.close()
+        self._trex_server_process.join()
+
+    def _calculate_traffic_stats(
+        self, packet: Packet, duration: float, callback: Callable[[Packet, float], str]
+    ) -> PerformanceTrafficStats:
+        """Calculate the traffic statistics, using provided TG output.
+
+        Takes in the statistics output provided by the stateless API implementation, and collects
+        them into a performance statistics data structure.
+
+        Attributes:
+            packet: The packet being used for the performance test.
+            duration: The duration of the test.
+            callback: The callback function used to generate the traffic.
+        """
+        # Convert to a dictionary.
+        stats_output = eval(callback(packet, duration))
+        return TrexPerformanceStats(
+            len(packet),
+            packet,
+            stats_output.get("tx_expected_bps", "ERROR - DATA NOT FOUND"),
+            stats_output.get("tx_expected_cps", "ERROR - DATA NOT FOUND"),
+            stats_output.get("tx_expected_pps", "ERROR - DATA NOT FOUND"),
+            stats_output.get("tx_pps", "ERROR - DATA NOT FOUND"),
+            stats_output.get("tx_cps", "ERROR - DATA NOT FOUND"),
+            stats_output.get("tx_bps", "ERROR - DATA NOT FOUND"),
+            stats_output.get("obytes", "ERROR - DATA NOT FOUND"),
+            None,
+        )
+
+    def set_streaming_mode(self, streaming_mode: TrexStatelessTXModes) -> None:
+        """Set the streaming mode of the TREX instance."""
+        # Streaming modes are mutually exclusive.
+        self._streaming_mode = self._streaming_mode & streaming_mode
+
+    def _generate_traffic(self, packet: Packet, duration: float) -> str:
+        """Generate traffic using provided packet.
+
+        Uses the provided packet to generate traffic for the provided duration.
+
+        Attributes:
+            packet: The packet being used for the performance test.
+            duration: The duration of the test being performed.
+
+        Returns:
+            a string output of statistics provided by the traffic generator.
+        """
+        """Implementation for :method:`generate_traffic_and_stats`."""
+        streaming_mode = ""
+        if self._streaming_mode == TrexStatelessTXModes.CONTINUOUS:
+            streaming_mode = "STLTXCont"
+        elif self._streaming_mode == TrexStatelessTXModes.SINGLE_BURST:
+            streaming_mode = "STLTXSingleBurst"
+        elif self._streaming_mode == TrexStatelessTXModes.MULTI_BURST:
+            streaming_mode = "STLTXMultiBurst"
+
+        packet_stream = [
+            f"{self.packet_stream_name} = trex.stl.trex_stl_streams.STLStream(",
+            f"name='Test_{len(packet)}_bytes',",
+            f"packet=trex.stl.trex_stl_packet_builder_scapy.STLPktBuilder(pkt={packet.command()}),",
+            f"mode=trex.stl.trex_stl_streams.{streaming_mode}(),",
+            ")",
+        ]
+        self.send_command("\n".join(packet_stream))
+
+        # Prepare TREX console for next performance test.
+        procedure = [
+            f"{self.stl_client_name}.connect()",
+            f"{self.stl_client_name}.reset(ports = [0, 1])",
+            f"{self.stl_client_name}.add_streams({self.packet_stream_name}, ports=[0, 1])",
+            f"{self.stl_client_name}.clear_stats()",
+            ")",
+        ]
+        self.send_command("\n".join(procedure))
+
+        start_test = [
+            f"{self.stl_client_name}.start(ports=[0, 1], duration={duration})",
+            f"{self.stl_client_name}.wait_on_traffic(ports=[0, 1])",
+        ]
+        self.send_command("\n".join(start_test))
+        import time
+
+        time.sleep(duration + 1)
+
+        # Gather statistics output for parsing.
+        return self.send_command(
+            f"{self.stl_client_name}.get_stats(ports=[0, 1])", skip_first_line=True
+        )
-- 
2.47.1

