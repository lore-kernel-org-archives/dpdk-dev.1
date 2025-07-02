Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B321BC83F04
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 16:32:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C18874064C;
	Wed,  2 Jul 2025 18:32:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DF2F04028E
 for <dev@dpdk.org>; Wed,  2 Jul 2025 18:32:20 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60FB522C7;
 Wed,  2 Jul 2025 09:32:05 -0700 (PDT)
Received: from [10.1.35.68] (JR4XG4HTQC-2.cambridge.arm.com [10.1.35.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0B9E3F66E;
 Wed,  2 Jul 2025 09:32:18 -0700 (PDT)
Message-ID: <a3ef254f-ff13-40af-b4a2-5e91b7912a63@arm.com>
Date: Wed, 2 Jul 2025 17:32:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dts: add trex traffic generator to dts framework
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>, Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, thomas.wilks@arm.com,
 Nicholas Pratte <npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
 <20250702052154.381690-4-probb@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250702052154.381690-4-probb@iol.unh.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 02/07/2025 06:21, Patrick Robb wrote:
>   class TrafficGeneratorConfig(FrozenModel):
> @@ -404,6 +406,8 @@ class TrafficGeneratorConfig(FrozenModel):
>       #: The traffic generator type the child class is required to define to be distinguished among
>       #: others.
>       type: TrafficGeneratorType
> +    remote_path: PurePath
> +    config: PurePath

What's the reason behind these? And why are we making these mandatory 
for all of the traffic generator configurations? Given Scapy hasn't 
needed them so far, I reckon these shouldn't be here.

>       #: The DPDK configuration used to test.
>       dpdk: DPDKConfiguration
> -    #: The traffic generator configuration used to test.
> -    traffic_generator: TrafficGeneratorConfigTypes
> +    #: The traffic generator configuration used for functional tests.
> +    func_traffic_generator: TrafficGeneratorConfig
> +    #: The traffic generator configuration used for performance tests.
> +    perf_traffic_generator: TrafficGeneratorConfig

This is starting to look like it should be optional and not mandatory. 
Should have a choice not to supply a perf traffic generator, same for a 
functional one. If I care only about perf tests, I shouldn't be needing 
to supply functional ones.

> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 10a5e1a6b8..ea8ca41414 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -204,10 +204,18 @@ def __init__(
>   
>           dpdk_build_env = DPDKBuildEnvironment(config.dpdk.build, sut_node)
>           dpdk_runtime_env = DPDKRuntimeEnvironment(config.dpdk, sut_node, dpdk_build_env)
> -        traffic_generator = create_traffic_generator(config.traffic_generator, tg_node)
> +        if config.func:
> +            traffic_generator = create_traffic_generator(config.func_traffic_generator, tg_node)
> +        if config.perf:
> +            traffic_generator = create_traffic_generator(config.perf_traffic_generator, tg_node)

This is insinuating we can only have a functional or a performance 
traffic generator, which does not respect the expectations of the 
configuration. Moreover, func and perf are not mutually exclusive, if we 
have both set to True this looks like it will wreak havoc. Looks like a 
bug to me.

> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index e5fbadd1a1..75d7a6eb6c 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -254,11 +254,11 @@ def send_packets_and_capture(
>               A list of received packets.
>           """
>           assert isinstance(
> -            self._ctx.tg, CapturingTrafficGenerator
> +            self._ctx.func_tg, CapturingTrafficGenerator

I am evermore confused, I don't see any func_tg in Context.

> diff --git a/dts/framework/testbed_model/traffic_generator/__init__.py b/dts/framework/testbed_model/traffic_generator/__init__.py
> index 2a259a6e6c..53125995cd 100644
> @@ -37,8 +47,10 @@ def create_traffic_generator(
>       Raises:
>           ConfigurationError: If an unknown traffic generator has been setup.
>       """
> -    match traffic_generator_config:
> -        case ScapyTrafficGeneratorConfig():
> +    match traffic_generator_config.type:
> +        case TrafficGeneratorType.SCAPY:
>               return ScapyTrafficGenerator(node, traffic_generator_config, privileged=True)
> +        case TrafficGeneratorType.TREX:
> +            return TrexTrafficGenerator(node, traffic_generator_config, privileged=True)
>           case _:
>               raise ConfigurationError(f"Unknown traffic generator: {traffic_generator_config.type}")

This change defeats the entire purpose of the match case. This was 
originally doing two things:
- matching traffic generator by their own config class
- casting the config class (this is not happening anymore)
The traffic generator classes should be able to access their own 
configurations directly, this is basically breaking the whole purpose of 
mypy.

> diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/framework/testbed_model/traffic_generator/trex.py
> new file mode 100644
> index 0000000000..1ba7d6bbbd
> --- /dev/null
> +++ b/dts/framework/testbed_model/traffic_generator/trex.py
> @@ -0,0 +1,258 @@
> +"""Implementation for TREX performance traffic generator."""

Missing SPDX License Identifier and copyrights. For such a big file, I'd 
have expected a description for the implementation and how to configure 
TRex in DTS.


> +class TrexStatelessTXModes(Flag):
> +    """Flags indicating TREX instance's current transmission mode."""
> +
> +    CONTINUOUS = auto()
> +    SINGLE_BURST = auto()
> +    MULTI_BURST = auto()

Missing docstrings.

> +class TrexTrafficGenerator(PerformanceTrafficGenerator):
> +    """TREX traffic generator.
> +
> +    This implementation leverages the stateless API library provided in the TREX installation.
> +
> +    Attributes:
> +        stl_client_name: The name of the stateless client used in the stateless API.
> +        packet_stream_name: The name of the stateless packet stream used in the stateless API.
> +    """
> +
> +    _os_session: OSSession
> +    _server_remote_session: Any

Why are we resorting to Any?

> +
> +    _tg_config: TrafficGeneratorConfig
> +    _node_config: NodeConfiguration
> +
> +    _shell: PythonShell
> +    _python_indentation: ClassVar[str] = " " * 4
> +
> +    stl_client_name: ClassVar[str] = "client"
> +    packet_stream_name: ClassVar[str] = "stream"
> +
> +    _streaming_mode: TrexStatelessTXModes = TrexStatelessTXModes.CONTINUOUS
> +
> +    tg_cores: int = 10

This is not documented in the docstring.

> +
> +    def __init__(self, tg_node: Node, config: TrafficGeneratorConfig, **kwargs) -> None:
> +        """Initialize the TREX server.
> +
> +        Initializes needed OS sessions for the creation of the TREX server process.
> +
> +        Attributes:
> +            tg_node: TG node the TREX instance is operating on.
> +            config: Traffic generator config provided for TREX instance.
> +        """

I think the above is meant to be Args.

> +        super().__init__(tg_node=tg_node, config=config, **kwargs)
> +        self._tg_node_config = tg_node.config
> +        self._tg_config = config
> +
> +        self._os_session = create_session(self._tg_node.config, "TREX", self._logger)
> +        self._server_remote_session = self._os_session.remote_session
> +
> +        self._shell = PythonShell(self._tg_node, "TREX-client", privileged=True)
> +
> +    def setup(self, topology: Topology):
> +        """Initialize and start a TREX server process."""
> +        super().setup(get_ctx().topology)

Why are we calling topology from get_ctx() if we are accepting it from 
the arguments?

> +        # Start TREX server process.
> +        try:
> +            self._logger.info("Starting TREX server process: sending 20 second sleep.")
> +            server_command = [
> +                f"cd {self._tg_config.remote_path};",
> +                self._os_session._get_privileged_command(
> +                    f"screen -d -m ./t-rex-64 --cfg {self._tg_config.config} -c {self.tg_cores} -i"
> +                ),
> +            ]
> +            privileged_command = " ".join(server_command)
> +            self._logger.info(f"Sending: '{privileged_command}")
> +            self._server_remote_session.session.run(privileged_command)
> +            time.sleep(20)

Looks kind of hacky and slow, is there no way to determine if the 
process is ready? Would something like the BlockingDPDKApp class work 
here? (Of course in a generic way, like the patches I am about to send)

> +
> +        except SSHTimeoutError as e:
> +            self._logger.exception("Failed to start TREX server process.", e)
> +
> +        # Start Python shell.
> +        self._shell.start_application()
> +        self._shell.send_command("import os")
> +        self._shell.send_command(
> +            f"os.chdir('{self._tg_config.remote_path}/automation/trex_control_plane/interactive')"
> +        )

I would properly join the path first use PurePath.

> +
> +        # Import stateless API components.
> +        imports = [
> +            "import trex",
> +            "import trex.stl",
> +            "import trex.stl.trex_stl_client",
> +            "import trex.stl.trex_stl_streams",
> +            "import trex.stl.trex_stl_packet_builder_scapy",
> +            "from scapy.layers.l2 import Ether",
> +            "from scapy.layers.inet import IP",
> +            "from scapy.packet import Raw",
> +        ]
> +        self._shell.send_command("\n".join(imports))
> +
> +        stateless_client = [
> +            f"{self.stl_client_name} = trex.stl.trex_stl_client.STLClient(",
> +            f"username='{self._tg_node_config.user}',",
> +            "server='127.0.0.1',",
> +            ")",
> +        ]
> +
> +        self._shell.send_command(f"\n{self._python_indentation}".join(stateless_client))
> +        self._shell.send_command(f"{self.stl_client_name}.connect()")
> +
> +    def teardown(self) -> None:
> +        """Teardown the TREX server and stateless implementation.
> +
> +        close the TREX server process, and stop the Python shell.
Missed capitalisation.
> +
> +        Attributes:
> +            ports: Associated ports used by the TREX instance.
> +        """

What attributes?

> +        super().teardown()
> +        self._os_session.send_command("pkill t-rex-64", privileged=True)
> +        self.close()
> +
> +    def calculate_traffic_and_stats(
> +        self, packet: Packet, send_mpps: int, duration: float
> +    ) -> PerformanceTrafficStats:
> +        """Calculate the traffic statistics, using provided TG output.
> +
> +        Takes in the statistics output provided by the stateless API implementation, and collects
> +        them into a performance statistics data structure.
> +
> +        Attributes:
> +            packet: The packet being used for the performance test.
> +            send_mpps: the MPPS send rate.
> +            duration: The duration of the test.
> +        """

Args, not Attributes.

> +        # Convert to a dictionary.
> +        stats_output = eval(self._generate_traffic(packet, send_mpps, duration))

I am not really pleased with the idea of injecting arbitrary code, this 
screams security issue. Is there no better way to handle this? We want 
to parse and validate output, not just evaluate it blindly. Could we get 
this as JSON and let a Pydantic model naturally parse it and validate it 
safely?

> +
> +        global_output = stats_output.get("global", "ERROR - DATA NOT FOUND")
> +
> +        self._logger.info(f"The global stats for the current set of params are: {global_output}")
> +
> +        return PerformanceTrafficStats(
> +            frame_size=len(packet),
> +            tx_pps=global_output.get("tx_pps", "ERROR - tx_pps NOT FOUND"),
> +            tx_cps=global_output.get("tx_cps", "ERROR - tx_cps NOT FOUND"),
> +            tx_bps=global_output.get("tx_bps", "ERROR - tx_bps NOT FOUND"),
> +            rx_pps=global_output.get("rx_pps", "ERROR - rx_pps NOT FOUND"),
> +            rx_bps=global_output.get("rx_bps", "ERROR - rx_bps NOT FOUND"),
> +        )

Otherwise, PerformanceTrafficStats could just re-use the TextParser 
class for this purpose as well.

> +
> +    def _generate_traffic(self, packet: Packet, send_mpps: int, duration: float) -> str:
> +        """Generate traffic using provided packet.
> +
> +        Uses the provided packet to generate traffic for the provided duration.
> +
> +        Attributes:
> +            packet: The packet being used for the performance test.
> +            send_mpps: MPPS send rate.
> +            duration: The duration of the test being performed.

Args, not Attributes.

> +
> +        Returns:
> +            a string output of statistics provided by the traffic generator.
Missed capitalisation.
> +        """
> +        self._create_packet_stream(packet)
> +        self._setup_trex_client()
> +
> +        stats = self._send_traffic_and_get_stats(send_mpps, duration)
> +
> +        return stats
> +
> +    def _setup_trex_client(self) -> None:
> +        """Create trex client and connect to the server process."""
> +        # Prepare TREX client for next performance test.
> +        procedure = [
> +            f"{self.stl_client_name}.connect()",
> +            f"{self.stl_client_name}.reset(ports = [0, 1])",
> +            f"{self.stl_client_name}.clear_stats()",
> +            f"{self.stl_client_name}.add_streams({self.packet_stream_name}, ports=[0, 1])",
> +        ]
> +
> +        for command in procedure:
> +            self._shell.send_command(command)
> +
> +    def _create_packet_stream(self, packet: Packet) -> None:
> +        """Create TREX packet stream with the given packet.
> +
> +        Attributes:
> +            packet: The packet being used for the performance test.
> +
empty line
> +        """
> +        streaming_mode = ""
> +        if self._streaming_mode == TrexStatelessTXModes.CONTINUOUS:
> +            streaming_mode = "STLTXCont"
> +        elif self._streaming_mode == TrexStatelessTXModes.SINGLE_BURST:
> +            streaming_mode = "STLTXSingleBurst"
> +        elif self._streaming_mode == TrexStatelessTXModes.MULTI_BURST:
> +            streaming_mode = "STLTXMultiBurst"

TrexStatelessTXModes could just be a StrEnum with these as values.

> +
> +        # Create the tx packet on the TG shell
> +        self._shell.send_command(f"packet={packet.command()}")
> +
> +        packet_stream = [
> +            f"{self.packet_stream_name} = trex.stl.trex_stl_streams.STLStream(",
> +            f"name='Test_{len(packet)}_bytes',",
> +            "packet=trex.stl.trex_stl_packet_builder_scapy.STLPktBuilder(pkt=packet),",
> +            f"mode=trex.stl.trex_stl_streams.{streaming_mode}(percentage=100),",
> +            ")",
> +        ]
> +        self._shell.send_command("\n".join(packet_stream))
> +
> +    def _send_traffic_and_get_stats(self, send_mpps: float, duration: float) -> str:
> +        """Send traffic and get TG Rx stats.
> +
> +        Sends traffic from the TREX client's ports for the given duration.
> +        When the traffic sending duration has passed, collect the aggregate
> +        statistics and return TREX's global stats as a string.
> +
> +        Attributes:
> +            send_mpps: The millions of packets per second for TREX to send from each port.
> +            duration: The traffic generation duration.
Args, not Attributes.
> +        """
> +        mpps_send_rate = f"{send_mpps}mpps"
> +
> +        self._shell.send_command(f"""{self.stl_client_name}.start(ports=[0, 1],
> +        mult = '{mpps_send_rate}',
> +        duration = {duration})""")
bad formatting.
> +
> +        time.sleep(duration)
> +
> +        stats = self._shell.send_command(
> +            f"{self.stl_client_name}.get_stats(ports=[0, 1])", skip_first_line=True
> +        )
> +
> +        self._shell.send_command(f"{self.stl_client_name}.stop(ports=[0, 1])")
> +
> +        return stats
> +
> +    def close(self) -> None:
> +        """Overrides :meth:`.traffic_generator.TrafficGenerator.close`.
> +
> +        Stops the traffic generator and sniffer shells.
> +        """
> +        self._shell.close()

