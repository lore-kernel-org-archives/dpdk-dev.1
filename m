Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39310C0219B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 18:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 878B142EE2;
	Fri,  7 Feb 2025 19:25:40 +0100 (CET)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54]) by mails.dpdk.org (Postfix) with ESMTP id 8FA1542ED5
 for <dev@dpdk.org>; Fri,  7 Feb 2025 19:25:38 +0100 (CET)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-53e384d00f4so353922e87.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 10:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1738952738; x=1739557538; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/PV5WGU0UDo4iowsRAF1l/GtOZz5BNH5Dwhn0brMyTY=;
 b=TmpVhGDap5vfRxAkr/0PI4q3sDNNZpFj3VUN0JP5vvJTmsnIGgaVAfrrhTk6e2nBOF
 ulG/DSkR/f2xx3iVOU/rqMBAJOQb4qxItwEwvz65AHjGGRzNrRkr64e4qlxgsMGuOflo
 JeLa55m5EBJOQ7QY6/0kd0A++QcmJJtBznV60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738952738; x=1739557538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PV5WGU0UDo4iowsRAF1l/GtOZz5BNH5Dwhn0brMyTY=;
 b=vcinxu8FVJmEqMuEYAl1UJYAzjcONMzME70Xe+ImP+kp/ZMdXY4jyr7MYBYWuUEUP2
 1IUBgq2kfL/603cakenOHw4aLzymFQ6l07RTjLFNlj62l5DN6Ykhg5o6dJLANalT0afs
 Zglkm721+4+anZ7alkds0H5PJA53GdPKS99YDrcxp4xpc28bXiM3z8FMAEYqRiGPg6b4
 evtbyDDtgRPx2m+yhFmv9uyDHldFGMCtyMl6H/3Y5G/w39B+qgWyq5zyxTU61hbFbWbf
 IkGtJDhKuvNb/MNKOG4j16m9CGtpyj4oxZr5xgP5TSntRTLQc0w6CmllXBdE75o8D6QR
 8h4A==
X-Gm-Message-State: AOJu0Yzt0TqqJayyn8NPdO7w9WXionMOCSKgugx365I/QkXa+q/Y2b3G
 gaIT/bx6aiwSTPuVgmR9sb9t+7bo3UFQ3xHM2Kg1Lpxtg+Q1P8VS3os2fpD0zXWN4udbUq+sXKT
 +0s61Vfj5N7iCOpWCChEY4boQSpmRcFSD2cCkrvb2xDZLrQgx7pw=
X-Gm-Gg: ASbGncu9f1zSV+9ZdMoTMLY8DRFmaQI6DgnzUflJQSNamrXJ7GV76jWF0emgzlY/0aH
 SMNCS17fGBspZTUdpl22sk8wCwRLl+SRuIUzitHdJoroTCZp4IrIozTy0BHEeEuKl6gsy4CTpNc
 s=
X-Google-Smtp-Source: AGHT+IFX5mNjRU2+a5+Jmn/Zqwg9VgupjXEXRlWBm4gQMASEPvP+iUA5Y/Ay5ZFaXmL7kmmEmKP5DfNZdo45d+DTGqE=
X-Received: by 2002:a05:651c:b1f:b0:300:43e5:51a with SMTP id
 38308e7fff4ca-307e561e754mr5063061fa.0.1738952737572; Fri, 07 Feb 2025
 10:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-2-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-2-luca.vizzarro@arm.com>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Fri, 7 Feb 2025 13:25:26 -0500
X-Gm-Features: AWEUYZmpxL_io8KZ8eOEvlYjBwAD0Q_Rk0Ns29tlukPAZwGPCp4JkeXz1AWLD5w
Message-ID: <CAKXZ7egutoK9hCeV_gkjmFPJ8qn7we3_rJ3-LfUOvzrmdbpGfw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] dts: add port topology configuration
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Luca, nice work! See comments below.

<snip>
>
>
> +class LinkPortIdentifier(NamedTuple):
> +    """A tuple linking test run node type to port name."""
> +
> +    node_type: Literal["sut", "tg"]
> +    port_name: str
> +
> +
> +class PortLinkConfig(FrozenModel):
> +    """A link between the ports of the nodes.
> +
> +    Can be represented as a string with the following notation:
> +
> +    .. code::
> +
> +        sut.PORT_0 <-> tg.PORT_0  # explicit node nomination
> +        PORT_0 <-> PORT_0         # implicit node nomination. Left is SUT, right is TG.

There are some additional comments below that relate to this piece of
documentation here. If a user is looking at this, maybe it would make
more sense for them to read something like "sut.{string name}" to
better indicate the flexibility they have in naming ports. It might be
possible that someone could get confused when they are reading these
exception messages as they are thrown.

> +    """
> +
> +    #: The port at the left side of the link.
> +    left: LinkPortIdentifier
> +    #: The port at the right side of the link.
> +    right: LinkPortIdentifier
> +
> +    @cached_property
> +    def sut_port(self) -> str:
> +        """Port name of the SUT node.
> +
> +        Raises:
> +            InternalError: If a misconfiguration has been allowed to happen.
> +        """
> +        if self.left.node_type == "sut":
> +            return self.left.port_name
> +        if self.right.node_type == "sut":
> +            return self.right.port_name
> +
> +        raise InternalError("Unreachable state reached.")
> +
> +    @cached_property
> +    def tg_port(self) -> str:
> +        """Port name of the TG node.
> +
> +        Raises:
> +            InternalError: If a misconfiguration has been allowed to happen.
> +        """
> +        if self.left.node_type == "tg":
> +            return self.left.port_name
> +        if self.right.node_type == "tg":
> +            return self.right.port_name
> +
> +        raise InternalError("Unreachable state reached.")
> +
> +    @model_validator(mode="before")
> +    @classmethod
> +    def convert_from_string(cls, data: Any) -> Any:
> +        """Convert the string representation of the model into a valid mapping."""
> +        if isinstance(data, str):
> +            m = re.match(REGEX_FOR_PORT_LINK, data, re.I)
> +            assert m is not None, (
> +                "The provided link is malformed. Please use the following "
> +                "notation: sut.PORT_0 <-> tg.PORT_0"

Per the comment above, this is the exception message I am referring
to. If the example test_run.conf is going to have the default port
names be "Port 0" and "Port 1," just to be more consistent, it might
make more sense to remove the underscored from the exception message.
I could personally see myself making a silly error in misunderstanding
this small inconsistency as I quickly fix my configuration files; it's
happened many times before :D

> +            )
> +
> +            left = (m.group(1) or "sut").lower(), m.group(2)
> +            right = (m.group(3) or "tg").lower(), m.group(4)
> +
> +            return {"left": left, "right": right}
> +        return data
> +
> +    @model_validator(mode="after")
> +    def verify_distinct_nodes(self) -> Self:
> +        """Verify that each side of the link has distinct nodes."""
> +        assert (
> +            self.left.node_type != self.right.node_type
> +        ), "Linking ports of the same node is unsupported."
> +        return self
> +
> +
>  class TestRunConfiguration(FrozenModel):
>      """The configuration of a test run.
>
> @@ -298,6 +377,8 @@ class TestRunConfiguration(FrozenModel):
>      vdevs: list[str] = Field(default_factory=list)
>      #: The seed to use for pseudo-random generation.
>      random_seed: int | None = None
> +    #: The port links between the specified nodes to use.
> +    port_topology: list[PortLinkConfig] = Field(max_length=2)
>
>      fields_from_settings = model_validator(mode="before")(
>          load_fields_from_settings("test_suites", "random_seed")
> diff --git a/dts/framework/runner.py b/dts/framework/runner.py
> index 9f9789cf49..60a885d8e6 100644
> --- a/dts/framework/runner.py
> +++ b/dts/framework/runner.py
> @@ -54,7 +54,7 @@
>      TestSuiteWithCases,
>  )
>  from .test_suite import TestCase, TestSuite
> -from .testbed_model.topology import Topology
> +from .testbed_model.topology import PortLink, Topology
>
>
>  class DTSRunner:
> @@ -331,7 +331,13 @@ def _run_test_run(
>              test_run_result.update_setup(Result.FAIL, e)
>
>          else:
> -            self._run_test_suites(sut_node, tg_node, test_run_result, test_suites_with_cases)
> +            topology = Topology(
> +                PortLink(sut_node.ports_by_name[link.sut_port], tg_node.ports_by_name[link.tg_port])
> +                for link in test_run_config.port_topology
> +            )
> +            self._run_test_suites(
> +                sut_node, tg_node, topology, test_run_result, test_suites_with_cases
> +            )
>
>          finally:
>              try:
> @@ -361,6 +367,7 @@ def _run_test_suites(
>          self,
>          sut_node: SutNode,
>          tg_node: TGNode,
> +        topology: Topology,
>          test_run_result: TestRunResult,
>          test_suites_with_cases: Iterable[TestSuiteWithCases],
>      ) -> None:
> @@ -380,11 +387,11 @@ def _run_test_suites(
>          Args:
>              sut_node: The test run's SUT node.
>              tg_node: The test run's TG node.
> +            topology: The test run's port topology.
>              test_run_result: The test run's result.
>              test_suites_with_cases: The test suites with test cases to run.
>          """
>          end_dpdk_build = False
> -        topology = Topology(sut_node.ports, tg_node.ports)
>          supported_capabilities = self._get_supported_capabilities(
>              sut_node, topology, test_suites_with_cases
>          )
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index bffbc52505..1acb526b64 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -28,8 +28,9 @@
>  from dataclasses import asdict, dataclass, field
>  from enum import Enum, auto
>  from pathlib import Path
> -from typing import Any, Callable, TypedDict
> +from typing import Any, Callable, TypedDict, cast
>
> +from framework.config.node import PortConfig
>  from framework.testbed_model.capability import Capability
>
>  from .config.test_run import TestRunConfiguration, TestSuiteConfig
> @@ -601,10 +602,14 @@ def to_dict(self) -> TestRunResultDict:
>              compiler_version = self.dpdk_build_info.compiler_version
>              dpdk_version = self.dpdk_build_info.dpdk_version
>
> +        ports = [asdict(port) for port in self.ports]
> +        for port in ports:
> +            port["config"] = cast(PortConfig, port["config"]).model_dump()
> +
>          return {
>              "compiler_version": compiler_version,
>              "dpdk_version": dpdk_version,
> -            "ports": [asdict(port) for port in self.ports],
> +            "ports": ports,
>              "test_suites": [child.to_dict() for child in self.child_results],
>              "summary": results | self.generate_pass_rate_dict(results),
>          }
> diff --git a/dts/framework/testbed_model/capability.py b/dts/framework/testbed_model/capability.py
> index 6a7a1f5b6c..7b06ecd715 100644
> --- a/dts/framework/testbed_model/capability.py
> +++ b/dts/framework/testbed_model/capability.py

You might want to look at the docstring for 'TopologyCapability' as,
given your changes to 'Topology Type', the following might need to be
reworded:

"Each test case must be assigned a topology. It could be done explicitly;
the implicit default is :attr:`~.topology.TopologyType.default`, which
this class defines
as equal to :attr:`~.topology.TopologyType.two_links`."

'default' is no longer technically an attribute.

> @@ -362,10 +362,10 @@ def set_required(self, test_case_or_suite: type["TestProtocol"]) -> None:
>                  the test suite's.
>          """
>          if inspect.isclass(test_case_or_suite):
> -            if self.topology_type is not TopologyType.default:
> +            if self.topology_type is not TopologyType.default():
>                  self.add_to_required(test_case_or_suite)
>                  for test_case in test_case_or_suite.get_test_cases():
> -                    if test_case.topology_type.topology_type is TopologyType.default:
> +                    if test_case.topology_type.topology_type is TopologyType.default():
>                          # test case topology has not been set, use the one set by the test suite
>                          self.add_to_required(test_case)
>                      elif test_case.topology_type > test_case_or_suite.topology_type:
> @@ -428,14 +428,8 @@ def __hash__(self):
>          return self.topology_type.__hash__()
>
>      def __str__(self):
> -        """Easy to read string of class and name of :attr:`topology_type`.
> -
> -        Converts :attr:`TopologyType.default` to the actual value.
> -        """
> -        name = self.topology_type.name
> -        if self.topology_type is TopologyType.default:
> -            name = TopologyType.get_from_value(self.topology_type.value).name
> -        return f"{type(self.topology_type).__name__}.{name}"
> +        """Easy to read string of class and name of :attr:`topology_type`."""
> +        return f"{type(self.topology_type).__name__}.{self.topology_type.name}"
>
>      def __repr__(self):
>          """Easy to read string of class and name of :attr:`topology_type`."""
> @@ -450,7 +444,7 @@ class TestProtocol(Protocol):
>      #: The reason for skipping the test case or suite.
>      skip_reason: ClassVar[str] = ""
>      #: The topology type of the test case or suite.
> -    topology_type: ClassVar[TopologyCapability] = TopologyCapability(TopologyType.default)
> +    topology_type: ClassVar[TopologyCapability] = TopologyCapability(TopologyType.default())
>      #: The capabilities the test case or suite requires in order to be executed.
>      required_capabilities: ClassVar[set[Capability]] = set()
>
> @@ -466,7 +460,7 @@ def get_test_cases(cls) -> list[type["TestCase"]]:
>
>  def requires(
>      *nic_capabilities: NicCapability,
> -    topology_type: TopologyType = TopologyType.default,
> +    topology_type: TopologyType = TopologyType.default(),
>  ) -> Callable[[type[TestProtocol]], type[TestProtocol]]:
>      """A decorator that adds the required capabilities to a test case or test suite.
>
> diff --git a/dts/framework/testbed_model/node.py b/dts/framework/testbed_model/node.py
> index e53a321499..0acd746073 100644
> --- a/dts/framework/testbed_model/node.py
> +++ b/dts/framework/testbed_model/node.py
> @@ -14,6 +14,7 @@
>  """
>
>  from abc import ABC
> +from functools import cached_property
>
>  from framework.config.node import (
>      OS,
> @@ -86,6 +87,11 @@ def _init_ports(self) -> None:
>          self.ports = [Port(self.name, port_config) for port_config in self.config.ports]
>          self.main_session.update_ports(self.ports)
>
> +    @cached_property
> +    def ports_by_name(self) -> dict[str, Port]:
> +        """Ports mapped by the name assigned at configuration."""
> +        return {port.name: port for port in self.ports}
> +
>      def set_up_test_run(
>          self,
>          test_run_config: TestRunConfiguration,
> diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
> index 7177da3371..8014d4a100 100644
> --- a/dts/framework/testbed_model/port.py
> +++ b/dts/framework/testbed_model/port.py
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2022 University of New Hampshire
>  # Copyright(c) 2023 PANTHEON.tech s.r.o.
> +# Copyright(c) 2025 Arm Limited
>
>  """NIC port model.
>
> @@ -13,19 +14,6 @@
>  from framework.config.node import PortConfig
>
>
> -@dataclass(slots=True, frozen=True)
> -class PortIdentifier:
> -    """The port identifier.
> -
> -    Attributes:
> -        node: The node where the port resides.
> -        pci: The PCI address of the port on `node`.
> -    """
> -
> -    node: str
> -    pci: str
> -
> -
>  @dataclass(slots=True)
>  class Port:
>      """Physical port on a node.
> @@ -36,20 +24,13 @@ class Port:
>      and for DPDK (`os_driver_for_dpdk`). For some devices, they are the same, e.g.: ``mlx5_core``.
>
>      Attributes:
> -        identifier: The PCI address of the port on a node.
> -        os_driver: The operating system driver name when the operating system controls the port,
> -            e.g.: ``i40e``.
> -        os_driver_for_dpdk: The operating system driver name for use with DPDK, e.g.: ``vfio-pci``.
> -        peer: The identifier of a port this port is connected with.
> -            The `peer` is on a different node.
> +        config: The port's configuration.
>          mac_address: The MAC address of the port.
>          logical_name: The logical name of the port. Must be discovered.
>      """
>
> -    identifier: PortIdentifier
> -    os_driver: str
> -    os_driver_for_dpdk: str
> -    peer: PortIdentifier
> +    _node: str
> +    config: PortConfig
>      mac_address: str = ""
>      logical_name: str = ""
>
> @@ -60,33 +41,20 @@ def __init__(self, node_name: str, config: PortConfig):
>              node_name: The name of the port's node.
>              config: The test run configuration of the port.
>          """
> -        self.identifier = PortIdentifier(
> -            node=node_name,
> -            pci=config.pci,
> -        )
> -        self.os_driver = config.os_driver
> -        self.os_driver_for_dpdk = config.os_driver_for_dpdk
> -        self.peer = PortIdentifier(node=config.peer_node, pci=config.peer_pci)
> +        self._node = node_name
> +        self.config = config
>
>      @property
>      def node(self) -> str:
>          """The node where the port resides."""
> -        return self.identifier.node
> +        return self._node
> +
> +    @property
> +    def name(self) -> str:
> +        """The name of the port."""
> +        return self.config.name
>
>      @property
>      def pci(self) -> str:
>          """The PCI address of the port."""
> -        return self.identifier.pci
> -
> -
> -@dataclass(slots=True, frozen=True)
> -class PortLink:
> -    """The physical, cabled connection between the ports.
> -
> -    Attributes:
> -        sut_port: The port on the SUT node connected to `tg_port`.
> -        tg_port: The port on the TG node connected to `sut_port`.
> -    """
> -
> -    sut_port: Port
> -    tg_port: Port
> +        return self.config.pci
> diff --git a/dts/framework/testbed_model/sut_node.py b/dts/framework/testbed_model/sut_node.py
> index 483733cede..440b5a059b 100644
> --- a/dts/framework/testbed_model/sut_node.py
> +++ b/dts/framework/testbed_model/sut_node.py
> @@ -515,7 +515,7 @@ def bind_ports_to_driver(self, for_dpdk: bool = True) -> None:
>              return
>
>          for port in self.ports:
> -            driver = port.os_driver_for_dpdk if for_dpdk else port.os_driver
> +            driver = port.config.os_driver_for_dpdk if for_dpdk else port.config.os_driver
>              self.main_session.send_command(
>                  f"{self.path_to_devbind_script} -b {driver} --force {port.pci}",
>                  privileged=True,
> diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
> index caee9b22ea..814c3f3fe4 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: BSD-3-Clause
>  # Copyright(c) 2024 PANTHEON.tech s.r.o.
> +# Copyright(c) 2025 Arm Limited
>
>  """Testbed topology representation.
>
> @@ -7,14 +8,9 @@
>  The link information then implies what type of topology is available.
>  """
>
> -from dataclasses import dataclass
> -from os import environ
> -from typing import TYPE_CHECKING, Iterable
> -
> -if TYPE_CHECKING or environ.get("DTS_DOC_BUILD"):
> -    from enum import Enum as NoAliasEnum
> -else:
> -    from aenum import NoAliasEnum
> +from collections.abc import Iterator
> +from enum import Enum
> +from typing import NamedTuple
>
>  from framework.config.node import PortConfig
>  from framework.exception import ConfigurationError
> @@ -22,7 +18,7 @@
>  from .port import Port
>
>
> -class TopologyType(int, NoAliasEnum):
> +class TopologyType(int, Enum):
>      """Supported topology types."""
>
>      #: A topology with no Traffic Generator.
> @@ -31,34 +27,20 @@ class TopologyType(int, NoAliasEnum):
>      one_link = 1
>      #: A topology with two physical links between the Sut node and the TG node.
>      two_links = 2
> -    #: The default topology required by test cases if not specified otherwise.
> -    default = 2
>
>      @classmethod
> -    def get_from_value(cls, value: int) -> "TopologyType":
> -        r"""Get the corresponding instance from value.
> +    def default(cls) -> "TopologyType":
> +        """The default topology required by test cases if not specified otherwise."""
> +        return cls.two_links
>
> -        :class:`~enum.Enum`\s that don't allow aliases don't know which instance should be returned
> -        as there could be multiple valid instances. Except for the :attr:`default` value,
> -        :class:`TopologyType` is a regular :class:`~enum.Enum`.
> -        When getting an instance from value, we're not interested in the default,
> -        since we already know the value, allowing us to remove the ambiguity.
>
> -        Args:
> -            value: The value of the requested enum.
> +class PortLink(NamedTuple):
> +    """The physical, cabled connection between the ports."""
>
> -        Raises:
> -            ConfigurationError: If an unsupported link topology is supplied.
> -        """
> -        match value:
> -            case 0:
> -                return TopologyType.no_link
> -            case 1:
> -                return TopologyType.one_link
> -            case 2:
> -                return TopologyType.two_links
> -            case _:
> -                raise ConfigurationError("More than two links in a topology are not supported.")
> +    #: The port on the SUT node connected to `tg_port`.
> +    sut_port: Port
> +    #: The port on the TG node connected to `sut_port`.
> +    tg_port: Port
>
>
>  class Topology:
> @@ -89,55 +71,43 @@ class Topology:
>      sut_port_egress: Port
>      tg_port_ingress: Port
>
> -    def __init__(self, sut_ports: Iterable[Port], tg_ports: Iterable[Port]):
> -        """Create the topology from `sut_ports` and `tg_ports`.
> +    def __init__(self, port_links: Iterator[PortLink]):
> +        """Create the topology from `port_links`.
>
>          Args:
> -            sut_ports: The SUT node's ports.
> -            tg_ports: The TG node's ports.
> +            port_links: The test run's required port links.
> +
> +        Raises:
> +            ConfigurationError: If an unsupported link topology is supplied.
>          """
> -        port_links = []
> -        for sut_port in sut_ports:
> -            for tg_port in tg_ports:
> -                if (sut_port.identifier, sut_port.peer) == (
> -                    tg_port.peer,
> -                    tg_port.identifier,
> -                ):
> -                    port_links.append(PortLink(sut_port=sut_port, tg_port=tg_port))
> -
> -        self.type = TopologyType.get_from_value(len(port_links))
>          dummy_port = Port(
>              "",
>              PortConfig(
> +                name="dummy",
>                  pci="0000:00:00.0",
>                  os_driver_for_dpdk="",
>                  os_driver="",
> -                peer_node="",
> -                peer_pci="0000:00:00.0",
>              ),
>          )
> +
> +        self.type = TopologyType.no_link
>          self.tg_port_egress = dummy_port
>          self.sut_port_ingress = dummy_port
>          self.sut_port_egress = dummy_port
>          self.tg_port_ingress = dummy_port
> -        if self.type > TopologyType.no_link:
> -            self.tg_port_egress = port_links[0].tg_port
> -            self.sut_port_ingress = port_links[0].sut_port
> +
> +        if port_link := next(port_links, None):
> +            self.type = TopologyType.one_link
> +            self.tg_port_egress = port_link.tg_port
> +            self.sut_port_ingress = port_link.sut_port
>              self.sut_port_egress = self.sut_port_ingress
>              self.tg_port_ingress = self.tg_port_egress
> -        if self.type > TopologyType.one_link:
> -            self.sut_port_egress = port_links[1].sut_port
> -            self.tg_port_ingress = port_links[1].tg_port
>
> +            if port_link := next(port_links, None):
> +                self.type = TopologyType.two_links
> +                self.sut_port_egress = port_link.sut_port
> +                self.tg_port_ingress = port_link.tg_port
>
> -@dataclass(slots=True, frozen=True)
> -class PortLink:
> -    """The physical, cabled connection between the ports.
> -
> -    Attributes:
> -        sut_port: The port on the SUT node connected to `tg_port`.
> -        tg_port: The port on the TG node connected to `sut_port`.
> -    """
> -
> -    sut_port: Port
> -    tg_port: Port
> +                if next(port_links, None) is not None:
> +                    msg = "More than two links in a topology are not supported."
> +                    raise ConfigurationError(msg)
> diff --git a/dts/framework/utils.py b/dts/framework/utils.py
> index 66f37a8813..d6f4c11d58 100644
> --- a/dts/framework/utils.py
> +++ b/dts/framework/utils.py
> @@ -32,7 +32,13 @@
>  _REGEX_FOR_COLON_OR_HYPHEN_SEP_MAC: str = r"(?:[\da-fA-F]{2}[:-]){5}[\da-fA-F]{2}"
>  _REGEX_FOR_DOT_SEP_MAC: str = r"(?:[\da-fA-F]{4}.){2}[\da-fA-F]{4}"
>  REGEX_FOR_MAC_ADDRESS: str = rf"{_REGEX_FOR_COLON_OR_HYPHEN_SEP_MAC}|{_REGEX_FOR_DOT_SEP_MAC}"
> -REGEX_FOR_BASE64_ENCODING: str = "[-a-zA-Z0-9+\\/]*={0,3}"
> +REGEX_FOR_BASE64_ENCODING: str = r"[-a-zA-Z0-9+\\/]*={0,3}"
> +REGEX_FOR_IDENTIFIER: str = r"\w+(?:[\w -]*\w+)?"
> +REGEX_FOR_PORT_LINK: str = (
> +    rf"(?:(sut|tg)\.)?({REGEX_FOR_IDENTIFIER})"  # left side
> +    r"\s+<->\s+"
> +    rf"(?:(sut|tg)\.)?({REGEX_FOR_IDENTIFIER})"  # right side
> +)
>
>
>  def expand_range(range_str: str) -> list[int]:
> diff --git a/dts/nodes.example.yaml b/dts/nodes.example.yaml
> index 454d97ab5d..6140dd9b7e 100644
> --- a/dts/nodes.example.yaml
> +++ b/dts/nodes.example.yaml
> @@ -9,18 +9,14 @@
>    user: dtsuser
>    os: linux
>    ports:
> -    # sets up the physical link between "SUT 1"@0000:00:08.0 and "TG 1"@0000:00:08.0
> -    - pci: "0000:00:08.0"
> +    - name: Port 0
> +      pci: "0000:00:08.0"
>        os_driver_for_dpdk: vfio-pci # OS driver that DPDK will use
>        os_driver: i40e              # OS driver to bind when the tests are not running
> -      peer_node: "TG 1"
> -      peer_pci: "0000:00:08.0"
> -    # sets up the physical link between "SUT 1"@0000:00:08.1 and "TG 1"@0000:00:08.1
> -    - pci: "0000:00:08.1"
> +    - name: Port 1
> +      pci: "0000:00:08.1"
>        os_driver_for_dpdk: vfio-pci
>        os_driver: i40e
> -      peer_node: "TG 1"
> -      peer_pci: "0000:00:08.1"
>    hugepages_2mb: # optional; if removed, will use system hugepage configuration
>        number_of: 256
>        force_first_numa: false
> @@ -34,18 +30,14 @@
>    user: dtsuser
>    os: linux
>    ports:
> -    # sets up the physical link between "TG 1"@0000:00:08.0 and "SUT 1"@0000:00:08.0
> -    - pci: "0000:00:08.0"
> +    - name: Port 0
> +      pci: "0000:00:08.0"
>        os_driver_for_dpdk: rdma
>        os_driver: rdma
> -      peer_node: "SUT 1"
> -      peer_pci: "0000:00:08.0"
> -    # sets up the physical link between "SUT 1"@0000:00:08.0 and "TG 1"@0000:00:08.0
> -    - pci: "0000:00:08.1"
> +    - name: Port 1
> +      pci: "0000:00:08.1"
>        os_driver_for_dpdk: rdma
>        os_driver: rdma
> -      peer_node: "SUT 1"
> -      peer_pci: "0000:00:08.1"
>    hugepages_2mb: # optional; if removed, will use system hugepage configuration
>        number_of: 256
>        force_first_numa: false
> diff --git a/dts/test_runs.example.yaml b/dts/test_runs.example.yaml
> index 5cc167ebe1..821d6918d0 100644
> --- a/dts/test_runs.example.yaml
> +++ b/dts/test_runs.example.yaml
> @@ -32,3 +32,6 @@
>    system_under_test_node: "SUT 1"
>    # Traffic generator node to use for this execution environment
>    traffic_generator_node: "TG 1"
> +  port_topology:
> +    - sut.Port 0 <-> tg.Port 0  # explicit link
> +    - Port 1 <-> Port 1         # implicit link, left side is always SUT, right side is always TG.

This suggestions might be a bit strange, but perhaps you would want to
add underscores for 'Port 0' and 'Port 1', given that some of the
framework documentation you wrote in 'LinkPortIdentifier' uses
underscores. Not sure how relevant that is, but maybe it would
mitigate confusion if either the 'sut_port' or 'tg_port' cached
properties throw an exception to the user.

> --
> 2.43.0
>
