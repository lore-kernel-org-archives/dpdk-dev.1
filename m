Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53425C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 05:27:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 880FE4069F;
	Wed,  2 Jul 2025 07:27:56 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 103F14065C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 07:27:55 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7d3f192a64eso589576785a.2
 for <dev@dpdk.org>; Tue, 01 Jul 2025 22:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751434074; x=1752038874; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jO+mi1whOjzbeMaUxzcQ7kVsrbdQSNOy3YYXKVZOzuI=;
 b=BdDvMcT2fnjnV7/9pAacW2oWfXFbCzWxYL5T6tMAS0Eng1/HaNX8KxvZja1r83avxJ
 CJ87rDnaHOn5QScGPXUSC0JAasn++QldjdkWB10y+D0dhY/uW90JoBRFVWh3Rb0jTUIM
 2EYUVjr4HPEgxf685tbmSkTHZYpVvqheozOME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751434074; x=1752038874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jO+mi1whOjzbeMaUxzcQ7kVsrbdQSNOy3YYXKVZOzuI=;
 b=usQzTrhUkvxv6xXs+UiVoDpWq6BGxnCW5D0dW4lTgXf9NlyFJry9USXTLwywxuARoZ
 VnV8WcQcGnpsH5abwV5x34VcET/bQoaHQsioM1VztComqsWT5LEdOZYDUpHEvv9cSGyU
 phTin5GkWT1ySSkH9aUceiqLweKluJyVLahwos8bhIWXdCzBVukZtC/n5l9k8lsj6V0h
 D1cqLO0cEvBBcILsqrCvRhQQnYo0bD2YOga5yu39o/Q273+Qr7Q44QMpte+i6hjU8+uS
 cSkUbbR5LosiqEH/OUF/JFdGS3MCYPqqmHUTzaQreWDQjPhWZVudoiLiMYkBM/bTPM0P
 /euA==
X-Gm-Message-State: AOJu0YyKlE+kk089qJABEWVgodNaPfVi8HqlJXBe0Fz/WJ3OKqFekgVW
 KCHHKtPl8N216IUfQB6YT8M4xun6GpLSM8fn1/J0MUkBJxpnZfZeP4tzOlrxf054NuE=
X-Gm-Gg: ASbGncuXK7UpVsSnCqfzkfhw0mwUPaFPle4eQsaExApdN3ttbIyuHLpDj4BhpB+nR9c
 YfsnVb7e+PzCYRURWaO6nu9oK+5TMp4f4TD8xBJ4QcAapcd83lHD0TVO2Q5+jA8UW+ksr5cu5rG
 6Kv4tTJ1pvbbicTAk3ZhMR8GxPf6w1i9YF82gXSh3spxDHGpzvQv4FqV9Xh+tfWqLBi97C3cFSP
 GJVN28jGTDoWDxHzLKYmwMXr3zXYaiYr05liojOaL87yXrSdy5zMwYjuoUrWdIlts41s06NUw98
 hndWjxfVeVNc/U2VdTDAEUz0WXTGzL7oql+1emY8lvCmJqlwD8PedpSkTXNiYaFS
X-Google-Smtp-Source: AGHT+IHA3V5p272UfHT7kukKEL25G3LEQinw1VuJNeWj4Skupd42O4Flu/1j3PMB4klXBSttoFLwsw==
X-Received: by 2002:a05:6214:2385:b0:6fa:bb44:fddf with SMTP id
 6a1803df08f44-702b1a6b1d7mr20266306d6.16.1751434074284; 
 Tue, 01 Jul 2025 22:27:54 -0700 (PDT)
Received: from patrick-laptop.iol.unh.edu ([2606:4100:3880:1257::10e7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d45c0fe6dfsm469274185a.58.2025.07.01.22.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 22:27:53 -0700 (PDT)
From: Patrick Robb <probb@iol.unh.edu>
To: Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, Luca.Vizzarro@arm.com,
 thomas.wilks@arm.com, Nicholas Pratte <npratte@iol.unh.edu>,
 Patrick Robb <probb@iol.unh.edu>
Subject: [PATCH v3 4/5] dts: add trex traffic generator to dts framework
Date: Wed,  2 Jul 2025 01:21:53 -0400
Message-ID: <20250702052154.381690-4-probb@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702052154.381690-1-probb@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
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
library, via use of a Python shell. As such, limitation to specific TREX
versions may be needed. The DTS context has been modified to include
a performance traffic generator in addition to a functional traffic
generator.

Bugzilla ID: 1697
Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
Signed-off-by: Patrick Robb <probb@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
---
 dts/framework/config/test_run.py              |  20 +-
 dts/framework/context.py                      |   2 +-
 dts/framework/test_run.py                     |  12 +-
 dts/framework/test_suite.py                   |   6 +-
 .../traffic_generator/__init__.py             |  22 +-
 .../testbed_model/traffic_generator/trex.py   | 258 ++++++++++++++++++
 6 files changed, 306 insertions(+), 14 deletions(-)
 create mode 100644 dts/framework/testbed_model/traffic_generator/trex.py

diff --git a/dts/framework/config/test_run.py b/dts/framework/config/test_run.py
index b6e4099eeb..3e09005338 100644
--- a/dts/framework/config/test_run.py
+++ b/dts/framework/config/test_run.py
@@ -396,6 +396,8 @@ class TrafficGeneratorType(str, Enum):
 
     #:
     SCAPY = "SCAPY"
+    #:
+    TREX = "TREX"
 
 
 class TrafficGeneratorConfig(FrozenModel):
@@ -404,6 +406,8 @@ class TrafficGeneratorConfig(FrozenModel):
     #: The traffic generator type the child class is required to define to be distinguished among
     #: others.
     type: TrafficGeneratorType
+    remote_path: PurePath
+    config: PurePath
 
 
 class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
@@ -412,8 +416,16 @@ class ScapyTrafficGeneratorConfig(TrafficGeneratorConfig):
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
@@ -461,8 +473,10 @@ class TestRunConfiguration(FrozenModel):
 
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
index 4360bc8699..8caac935a5 100644
--- a/dts/framework/context.py
+++ b/dts/framework/context.py
@@ -16,7 +16,7 @@
 
 if TYPE_CHECKING:
     from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
-    from framework.testbed_model.traffic_generator.traffic_generator import TrafficGenerator
+    from framework.testbed_model.traffic_generator import TrafficGenerator
 
 P = ParamSpec("P")
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 10a5e1a6b8..ea8ca41414 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -204,10 +204,18 @@ def __init__(
 
         dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
         dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
-        traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
+        if config.func:
+            traffic_generator = create_traffic_generator(config.func_traffic_generator, tg_node)
+        if config.perf:
+            traffic_generator = create_traffic_generator(config.perf_traffic_generator, tg_node)
 
         self.ctx = Context(
-            sut_node, tg_node, topology, dpdk_build_env, dpdk_runtime_env, traffic_generator
+            sut_node,
+            tg_node,
+            topology,
+            dpdk_build_env,
+            dpdk_runtime_env,
+            traffic_generator,
         )
         self.result = result
         self.selected_tests = list(self.config.filter_tests(tests_config))
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e5fbadd1a1..75d7a6eb6c 100644
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
index 0000000000..1ba7d6bbbd
--- /dev/null
+++ b/dts/framework/testbed_model/traffic_generator/trex.py
@@ -0,0 +1,258 @@
+"""Implementation for TREX performance traffic generator."""
+
+import time
+from enum import Flag, auto
+from typing import Any, ClassVar
+
+from scapy.packet import Packet
+
+from framework.config.node import NodeConfiguration
+from framework.config.test_run import TrafficGeneratorConfig
+from framework.context import get_ctx
+from framework.exception import SSHTimeoutError
+from framework.remote_session.python_shell import PythonShell
+from framework.testbed_model.node import Node, create_session
+from framework.testbed_model.os_session import OSSession
+from framework.testbed_model.topology import Topology
+from framework.testbed_model.traffic_generator.performance_traffic_generator import (
+    PerformanceTrafficGenerator,
+    PerformanceTrafficStats,
+)
+
+
+class TrexStatelessTXModes(Flag):
+    """Flags indicating TREX instance's current transmission mode."""
+
+    CONTINUOUS = auto()
+    SINGLE_BURST = auto()
+    MULTI_BURST = auto()
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
+    _server_remote_session: Any
+
+    _tg_config: TrafficGeneratorConfig
+    _node_config: NodeConfiguration
+
+    _shell: PythonShell
+    _python_indentation: ClassVar[str] = " " * 4
+
+    stl_client_name: ClassVar[str] = "client"
+    packet_stream_name: ClassVar[str] = "stream"
+
+    _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.CONTINUOUS
+
+    tg_cores: int = 10
+
+    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs) -> None:
+        """Initialize the TREX server.
+
+        Initializes needed OS sessions for the creation of the TREX server process.
+
+        Attributes:
+            tg_node: TG node the TREX instance is operating on.
+            config: Traffic generator config provided for TREX instance.
+        """
+        super().__init__(tg_node=tg_node, config=config, **kwargs)
+        self._tg_node_config = tg_node.config
+        self._tg_config = config
+
+        self._os_session = create_session(self._tg_node.config, "TREX", self._logger)
+        self._server_remote_session = self._os_session.remote_session
+
+        self._shell = PythonShell(self._tg_node, "TREX-client", privileged=True)
+
+    def setup(self, topology: Topology):
+        """Initialize and start a TREX server process."""
+        super().setup(get_ctx().topology)
+        # Start TREX server process.
+        try:
+            self._logger.info("Starting TREX server process: sending 20 second sleep.")
+            server_command = [
+                f"cd {self._tg_config.remote_path};",
+                self._os_session._get_privileged_command(
+                    f"screen -d -m ./t-rex-64 --cfg {self._tg_config.config} -c {self.tg_cores} -i"
+                ),
+            ]
+            privileged_command = " ".join(server_command)
+            self._logger.info(f"Sending: '{privileged_command}")
+            self._server_remote_session.session.run(privileged_command)
+            time.sleep(20)
+
+        except SSHTimeoutError as e:
+            self._logger.exception("Failed to start TREX server process.", e)
+
+        # Start Python shell.
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
+    def teardown(self) -> None:
+        """Teardown the TREX server and stateless implementation.
+
+        close the TREX server process, and stop the Python shell.
+
+        Attributes:
+            ports: Associated ports used by the TREX instance.
+        """
+        super().teardown()
+        self._os_session.send_command("pkill t-rex-64", privileged=True)
+        self.close()
+
+    def calculate_traffic_and_stats(
+        self, packet: Packet, send_mpps: int, duration: float
+    ) -> PerformanceTrafficStats:
+        """Calculate the traffic statistics, using provided TG output.
+
+        Takes in the statistics output provided by the stateless API implementation, and collects
+        them into a performance statistics data structure.
+
+        Attributes:
+            packet: The packet being used for the performance test.
+            send_mpps: the MPPS send rate.
+            duration: The duration of the test.
+        """
+        # Convert to a dictionary.
+        stats_output = eval(self._generate_traffic(packet, send_mpps, duration))
+
+        global_output = stats_output.get("global", "ERROR - DATA NOT FOUND")
+
+        self._logger.info(f"The global stats for the current set of params are: {global_output}")
+
+        return PerformanceTrafficStats(
+            frame_size=len(packet),
+            tx_pps=global_output.get("tx_pps", "ERROR - tx_pps NOT FOUND"),
+            tx_cps=global_output.get("tx_cps", "ERROR - tx_cps NOT FOUND"),
+            tx_bps=global_output.get("tx_bps", "ERROR - tx_bps NOT FOUND"),
+            rx_pps=global_output.get("rx_pps", "ERROR - rx_pps NOT FOUND"),
+            rx_bps=global_output.get("rx_bps", "ERROR - rx_bps NOT FOUND"),
+        )
+
+    def _generate_traffic(self, packet: Packet, send_mpps: int, duration: float) -> str:
+        """Generate traffic using provided packet.
+
+        Uses the provided packet to generate traffic for the provided duration.
+
+        Attributes:
+            packet: The packet being used for the performance test.
+            send_mpps: MPPS send rate.
+            duration: The duration of the test being performed.
+
+        Returns:
+            a string output of statistics provided by the traffic generator.
+        """
+        self._create_packet_stream(packet)
+        self._setup_trex_client()
+
+        stats = self._send_traffic_and_get_stats(send_mpps, duration)
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
+        Attributes:
+            packet: The packet being used for the performance test.
+
+        """
+        streaming_mode = ""
+        if self._streaming_mode == TrexStatelessTXModes.CONTINUOUS:
+            streaming_mode = "STLTXCont"
+        elif self._streaming_mode == TrexStatelessTXModes.SINGLE_BURST:
+            streaming_mode = "STLTXSingleBurst"
+        elif self._streaming_mode == TrexStatelessTXModes.MULTI_BURST:
+            streaming_mode = "STLTXMultiBurst"
+
+        # Create the tx packet on the TG shell
+        self._shell.send_command(f"packet={packet.command()}")
+
+        packet_stream = [
+            f"{self.packet_stream_name} = trex.stl.trex_stl_streams.STLStream(",
+            f"name='Test_{len(packet)}_bytes',",
+            "packet=trex.stl.trex_stl_packet_builder_scapy.STLPktBuilder(pkt=packet),",
+            f"mode=trex.stl.trex_stl_streams.{streaming_mode}(percentage=100),",
+            ")",
+        ]
+        self._shell.send_command("\n".join(packet_stream))
+
+    def _send_traffic_and_get_stats(self, send_mpps: float, duration: float) -> str:
+        """Send traffic and get TG Rx stats.
+
+        Sends traffic from the TREX client's ports for the given duration.
+        When the traffic sending duration has passed, collect the aggregate
+        statistics and return TREX's global stats as a string.
+
+        Attributes:
+            send_mpps: The millions of packets per second for TREX to send from each port.
+            duration: The traffic generation duration.
+        """
+        mpps_send_rate = f"{send_mpps}mpps"
+
+        self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
+        mult = '{mpps_send_rate}',
+        duration = {duration})""")
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
+        self._shell.close()
-- 
2.49.0

