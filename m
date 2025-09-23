Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B6CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 12:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC4F402EB;
	Tue, 23 Sep 2025 14:22:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 31634402CB
 for <dev@dpdk.org>; Tue, 23 Sep 2025 14:22:50 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 447A2FEC;
 Tue, 23 Sep 2025 05:22:41 -0700 (PDT)
Received: from [10.57.63.189] (unknown [10.57.63.189])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AF053F694;
 Tue, 23 Sep 2025 05:22:48 -0700 (PDT)
Message-ID: <4bf26f67-3aa6-4e2a-9799-95808300c516@arm.com>
Date: Tue, 23 Sep 2025 13:22:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
Subject: Re: [PATCH v3 2/3] dts: add TX offload capabilities to NIC
 capabilities
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu,
 ivan.malov@arknetworks.am, Jeremy Spewock <jspewock@iol.unh.edu>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250917124243.31567-1-abailey@iol.unh.edu>
 <20250917124243.31567-3-abailey@iol.unh.edu>
Content-Language: en-GB
In-Reply-To: <20250917124243.31567-3-abailey@iol.unh.edu>
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

On Wed, Sep 17, 2025 at 08:42:42AM +0000, Andrew Bailey wrote:
> Currently, there is no support for tracking tx_offload capabilities and
> there is no separation between port capabilities and queue
> capabilities. This is an issue if a test case requires a tx_offload
> capability or if a test case requires that a card supports a capability
> on a queue. This causes test cases with said requirements to not be
> skipped when appropriate. Add tx_offload capabilities and distinguish
> capabilities between ports and queues.
> 
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> Signed-off-by: Jeremy Spewock <jspewock@iol.unh.edu>
> ---
>  dts/framework/parser.py                       |  30 +
>  dts/framework/remote_session/testpmd_shell.py | 660 +++++++++++++++---
>  dts/tests/TestSuite_checksum_offload.py       |  10 +-
>  dts/tests/TestSuite_pmd_buffer_scatter.py     |   4 +-
>  dts/tests/TestSuite_vlan.py                   |   4 +-
>  5 files changed, 599 insertions(+), 109 deletions(-)
> 
> diff --git a/dts/framework/parser.py b/dts/framework/parser.py
> index 7254c75b71..4170cdb1dd 100644
> --- a/dts/framework/parser.py
> +++ b/dts/framework/parser.py
> @@ -116,6 +116,36 @@ def _composite_parser_fn(text: str) -> Any:
>  
>          return ParserFn(TextParser_fn=_composite_parser_fn)
>  
> +    @staticmethod
> +    def find_all(
> +        pattern: str | re.Pattern[str],
> +        flags: re.RegexFlag = re.RegexFlag(0),
> +    ) -> ParserFn:
> +        """Makes a parser function that finds all of the regular expression matches in the text.
> +
> +        If there are no matches found in the text than None will be returned, otherwise a list
> +        containing all matches will be returned. Patterns that contain multiple groups will pack
> +        the matches for each group into a tuple.
> +
> +        Args:
> +            pattern: The regular expression pattern.
> +            flags: The regular expression flags. Ignored if the given pattern is already compiled.
> +
> +        Returns:
> +            A :class:`ParserFn` that can be used as metadata for a dataclass field.
> +        """
> +        if isinstance(pattern, str):
> +            pattern = re.compile(pattern, flags)
> +
> +        def _find_all(text: str) -> list[str] | None:
> +            m = pattern.findall(text)
> +            if len(m) == 0:
> +                return None
> +
> +            return m
> +
> +        return ParserFn(TextParser_fn=_find_all)
> +
>      @staticmethod
>      def find(
>          pattern: str | re.Pattern[str],
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index ecbdd66edd..f2a7307e44 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -22,7 +22,17 @@
>  from enum import Flag, auto
>  from os import environ
>  from pathlib import PurePath
> -from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
> +from typing import (
> +    TYPE_CHECKING,
> +    Any,
> +    ClassVar,
> +    Concatenate,
> +    Literal,
> +    ParamSpec,
> +    Tuple,
> +    TypeAlias,
> +    cast,
> +)
>  
>  from framework.context import get_ctx
>  from framework.remote_session.interactive_shell import only_active
> @@ -43,6 +53,7 @@
>  from framework.settings import SETTINGS
>  from framework.utils import REGEX_FOR_MAC_ADDRESS, StrEnum
>  
> +RxTxLiteralSwitch = Literal["rx", "tx"]
>  P = ParamSpec("P")
>  TestPmdShellMethod = Callable[Concatenate["TestPmdShell", P], Any]
>  
> @@ -1278,7 +1289,110 @@ class TestPmdVerbosePacket(TextParser):
>      )
>  
>  
> -class RxOffloadCapability(Flag):
> +class OffloadCapability(Flag):
> +    """Flags generated from RxOffloadCapabilites and TxOffloadCapabilities classes."""
> +
> +    @classmethod
> +    def from_string(cls, line: str) -> Self:
> +        """Make an instance from a string containing the flag names separated with a space.
> +
> +        Args:
> +            line: The line to parse.
> +
> +        Returns:
> +            A new instance containing all found flags.
> +        """
> +        flag = cls(0)
> +        for flag_name in line.split():
> +            flag |= cls[
> +                f"{getattr(
> +                            cls, f"_{cls.__name__}__PREFIX", 'PREFIX_NOT_FOUND_'
> +                          )
> +                  }{flag_name}"
I'd add `_PREFIX` also a ClassVar in this class... and then you can just
call it as normal:
     flag |= cls[f"{cls._PREFIX}{flag_name}"]
The child classes should override it just fine.
> +            ]
> +        return flag
> +
> +    @classmethod
> +    def from_list(cls, lines: list[str]) -> list[Self]:
> +        """Gather capabilities from a list of strings.
> +
> +        Args:
> +            lines: The list of capabilities to make flags from.
> +        """
> +        return [cls.from_string(line) for line in lines]
> +
> +    @classmethod
> +    def make_parser(cls, per_port: bool, /, find_multiple: bool = False) -> ParserFn:
> +        """Make a parser function.
> +
> +        Args:
> +            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
> +                will return capabilities per queue.
> +            find_multiple: If :data:`True`, will use :func:`TextParser.find_all` to find all
> +                matches for the regex query and return a list of instances based on those matches.
> +                If :data:`False`, will return a single instance of the flag based off a single
> +                match.
> +
> +        Returns:
> +            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
> +                parser function that makes an instance of this flag from text.
> +        """
> +        granularity = "Port" if per_port else "Queue"
I guess `per_port` could just become a literal switch for clarity.
And do like:

   queue_or_port: Literal["queue", "port"]
   granularity = queue_or_port.capitalize()

> +        parser_func: Callable[..., ParserFn] = (
> +            TextParser.find_all if find_multiple else TextParser.find
> +        )
> +        instance_func: Callable[..., list[OffloadCapability]] | Callable[..., OffloadCapability] = (
> +            cls.from_list if find_multiple else cls.from_string
> +        )
> +        return TextParser.wrap(
> +            parser_func(rf"{granularity}[\s\[\]\d]+:(.*)$", re.MULTILINE),
> +            instance_func,
would putting `cls.from_list if find_multiple ...` in line here work? I
think it may be less confusing for mypy and probably better to avoid
false cases to just split this in an if instead.

regex = rf"{queue_or_port.capitalize()}..."
if find_multiple:
   return TextParser.wrap(TextParser.find_all(regex, re.M),
     cls.from_list)
else:
   ...

Could get away with this in only 5 lines and better overall clarity.
> +        )
> +
> +
> +class TxOffloadCapability(OffloadCapability):
> +    """TX offload capabilities of a device.
> +
> +    The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> +    They're prefixed with ``RTE_ETH_TX_OFFLOAD`` in ``lib/ethdev/rte_ethdev.h``
> +    instead of ``TX_OFFLOAD``, which is what testpmd changes the prefix to.
> +
> +    The ``TX_OFFLOAD`` prefix has been preserved so that the same flag names can be used
> +    in :class:`NicCapability`. The prefix is needed in :class:`NicCapability` since there's
> +    no other qualifier which would sufficiently distinguish it from other capabilities.
> +
> +    References:
> +        DPDK lib: ``lib/ethdev/rte_ethdev.h``
> +        testpmd display function: ``app/test-pmd/cmdline.c:print_rx_offloads()``
> +    """
> +
> +    __PREFIX: ClassVar[str] = "TX_OFFLOAD_"
> +
> +    TX_OFFLOAD_VLAN_INSERT = auto()
> +    TX_OFFLOAD_IPV4_CKSUM = auto()
> +    TX_OFFLOAD_UDP_CKSUM = auto()
> +    TX_OFFLOAD_TCP_CKSUM = auto()
> +    TX_OFFLOAD_SCTP_CKSUM = auto()
> +    TX_OFFLOAD_TCP_TSO = auto()
> +    TX_OFFLOAD_UDP_TSO = auto()
> +    TX_OFFLOAD_OUTER_IPV4_CKSUM = auto()
> +    TX_OFFLOAD_QINQ_INSERT = auto()
> +    TX_OFFLOAD_VXLAN_TNL_TSO = auto()
> +    TX_OFFLOAD_GRE_TNL_TSO = auto()
> +    TX_OFFLOAD_IPIP_TNL_TSO = auto()
> +    TX_OFFLOAD_GENEVE_TNL_TSO = auto()
> +    TX_OFFLOAD_MACSEC_INSERT = auto()
> +    TX_OFFLOAD_MT_LOCKFREE = auto()
> +    TX_OFFLOAD_MULTI_SEGS = auto()
> +    TX_OFFLOAD_MBUF_FAST_FREE = auto()
> +    TX_OFFLOAD_SECURITY = auto()
> +    TX_OFFLOAD_UDP_TNL_TSO = auto()
> +    TX_OFFLOAD_IP_TNL_TSO = auto()
> +    TX_OFFLOAD_OUTER_UDP_CKSUM = auto()
> +    TX_OFFLOAD_SEND_ON_TIMESTAMP = auto()
> +
> +
> +class RxOffloadCapability(OffloadCapability):
>      """Rx offload capabilities of a device.
>  
>      The flags are taken from ``lib/ethdev/rte_ethdev.h``.
> @@ -1296,6 +1410,8 @@ class RxOffloadCapability(Flag):
>          testpmd display function: ``app/test-pmd/cmdline.c:print_rx_offloads()``
>      """
>  
> +    __PREFIX: ClassVar[str] = "RX_OFFLOAD_"
> +
>      #:
>      RX_OFFLOAD_VLAN_STRIP = auto()
>      #: Device supports L3 checksum offload.
> @@ -1342,57 +1458,68 @@ class RxOffloadCapability(Flag):
>          | RX_OFFLOAD_QINQ_STRIP
>      )
>  
> -    @classmethod
> -    def from_string(cls, line: str) -> Self:
> -        """Make an instance from a string containing the flag names separated with a space.
>  
> -        Args:
> -            line: The line to parse.
> +@dataclass
> +class OffloadCapabilities(TextParser):
> +    """The result of testpmd's ``show port <port_id> tx_offload capabilities`` command.
>  
> -        Returns:
> -            A new instance containing all found flags.
> -        """
> -        flag = cls(0)
> -        for flag_name in line.split():
> -            flag |= cls[f"RX_OFFLOAD_{flag_name}"]
> -        return flag
> +    References:
> +        testpmd command function: ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa()``
> +        testpmd display function: ``app/test-pmd/cmdline.c:cmd_tx_offload_get_capa_parsed()``
> +    """
>  
> -    @classmethod
> -    def make_parser(cls, per_port: bool) -> ParserFn:
> -        """Make a parser function.
> +    port_id: int = field(metadata=TextParser.find_int(r"Offloading Capabilities of port (\d+) :"))
> +    #: Per-queue Rx offload capabilities.
> +    per_queue: RxOffloadCapability | TxOffloadCapability
> +    #: Capabilities other than per-queue Rx offload capabilities.
> +    per_port: RxOffloadCapability | TxOffloadCapability
>  
> -        Args:
> -            per_port: If :data:`True`, will return capabilities per port. If :data:`False`,
> -                will return capabilities per queue.
>  
> -        Returns:
> -            ParserFn: A dictionary for the `dataclasses.field` metadata argument containing a
> -                parser function that makes an instance of this flag from text.
> -        """
> -        granularity = "Port" if per_port else "Queue"
> -        return TextParser.wrap(
> -            TextParser.find(rf"Per {granularity}\s+:(.*)$", re.MULTILINE),
> -            cls.from_string,
> -        )
> +@dataclass
> +class RxOffloadCapabilities(OffloadCapabilities):
> +    """Extends :class:`OffloadCapabilities` with Rx specific functionality."""
> +
> +    per_queue: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(False))
> +    per_port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
>  
>  
>  @dataclass
> -class RxOffloadCapabilities(TextParser):
> -    """The result of testpmd's ``show port <port_id> rx_offload capabilities`` command.
> +class TxOffloadCapabilities(OffloadCapabilities):
> +    """Extends :class:`OffloadCapabilities` with Tx specific functionality."""
>  
> -    References:
> -        testpmd command function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa()``
> -        testpmd display function: ``app/test-pmd/cmdline.c:cmd_rx_offload_get_capa_parsed()``
> -    """
> +    per_queue: TxOffloadCapability = field(metadata=TxOffloadCapability.make_parser(False))
> +    per_port: TxOffloadCapability = field(metadata=TxOffloadCapability.make_parser(True))
>  
> -    #:
> -    port_id: int = field(
> -        metadata=TextParser.find_int(r"Rx Offloading Capabilities of port (\d+) :")
> +
> +@dataclass
> +class OffloadConfiguration(TextParser):
> +    """The result of testpmd's ``show port <port_id> rx/tx_offload configuration`` command."""
> +
> +    port_id: int = field(metadata=TextParser.find_int(r"Offloading Configuration of port (\d+) :"))
> +    #: Queue offload configurations.
> +    queues: list[RxOffloadCapability] | list[TxOffloadCapability]
> +    #: Port offload configuration.
> +    port: RxOffloadCapability | TxOffloadCapability
Couldn't these just be OffloadCapability?
> +
> +
> +@dataclass
> +class RxOffloadConfiguration(OffloadConfiguration):
> +    """Extends :class:`OffloadingConfiguration` with Rx specific functionality."""
> +
> +    queues: list[RxOffloadCapability] = field(
> +        metadata=RxOffloadCapability.make_parser(False, find_multiple=True)
>      )
> -    #: Per-queue Rx offload capabilities.
> -    per_queue: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(False))
> -    #: Capabilities other than per-queue Rx offload capabilities.
> -    per_port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
> +    port: RxOffloadCapability = field(metadata=RxOffloadCapability.make_parser(True))
> +
> +
> +@dataclass
> +class TxOffloadConfiguration(OffloadConfiguration):
> +    """Extends :class:`OffloadingConfiguration` with Tx specific functionality."""
> +
> +    queues: list[TxOffloadCapability] = field(
> +        metadata=TxOffloadCapability.make_parser(False, find_multiple=True)
> +    )
> +    port: TxOffloadCapability = field(metadata=TxOffloadCapability.make_parser(True))
>  
>  
>  @dataclass
> @@ -2390,27 +2517,56 @@ def close(self) -> None:
>      ====== Capability retrieval methods ======
>      """
>  
> -    def get_capabilities_rx_offload(
> -        self,
> -        supported_capabilities: MutableSet["NicCapability"],
> -        unsupported_capabilities: MutableSet["NicCapability"],
> -    ) -> None:
> -        """Get all rx offload capabilities and divide them into supported and unsupported.
> +    @staticmethod
> +    def get_offload_capabilities_func(
> +        rxtx: RxTxLiteralSwitch,
> +    ) -> Callable[["TestPmdShell", MutableSet["NicCapability"], MutableSet["NicCapability"]], None]:
> +        """High-order function that returns a method for gathering Rx/Tx offload capabilities.
>  
>          Args:
> -            supported_capabilities: Supported capabilities will be added to this set.
> -            unsupported_capabilities: Unsupported capabilities will be added to this set.
> -        """
> -        self._logger.debug("Getting rx offload capabilities.")
> -        command = f"show port {self.ports[0].id} rx_offload capabilities"
> -        rx_offload_capabilities_out = self.send_command(command)
> -        rx_offload_capabilities = RxOffloadCapabilities.parse(rx_offload_capabilities_out)
> -        self._update_capabilities_from_flag(
> -            supported_capabilities,
> -            unsupported_capabilities,
> -            RxOffloadCapability,
> -            rx_offload_capabilities.per_port | rx_offload_capabilities.per_queue,
> -        )
> +            rxtx: whether to gather the rx or tx capabilities in the returned method.
> +
> +        Returns:
> +            A method for gathering Rx/Tx offload capabilities that meets the required structure.
> +        """
> +
> +        def get_capabilities(
> +            self: "TestPmdShell",
> +            supported_capabilities: MutableSet["NicCapability"],
> +            unsupported_capabilities: MutableSet["NicCapability"],
> +        ) -> None:
> +            """Get all rx/tx offload capabilities and divide them into supported and unsupported.
> +
> +            Args:
> +                self: The shell instance to get the capabilities from.
> +                supported_capabilities: Supported capabilities will be added to this set.
> +                unsupported_capabilities: Unsupported capabilities will be added to this set.
> +            """
> +            self._logger.debug(f"Getting {rxtx} offload capabilities.")
> +            command = f"show port {self.ports[0].id} {rxtx}_offload capabilities"
> +            offload_capabilities_out = self.send_command(command)
> +
> +            capabilities = TxOffloadCapabilities if rxtx == "tx" else RxOffloadCapabilities
> +            offload_capabilities = capabilities.parse(offload_capabilities_out)
> +            per_port = cast(OffloadCapability, offload_capabilities.per_port)
> +            per_queue = cast(OffloadCapability, offload_capabilities.per_queue)
> +
> +            self._update_capabilities_from_flag(
> +                supported_capabilities,
> +                unsupported_capabilities,
> +                TxOffloadCapability if rxtx == "tx" else RxOffloadCapability,
> +                per_port | per_queue,
> +                prefix="PORT_",
> +            )
> +            self._update_capabilities_from_flag(
> +                supported_capabilities,
> +                unsupported_capabilities,
> +                TxOffloadCapability if rxtx == "tx" else RxOffloadCapability,
> +                per_queue,
> +                prefix="QUEUE_",
> +            )
> +
> +        return get_capabilities
>  
>      def get_port_queue_info(
>          self, port_id: int, queue_id: int, is_rx_queue: bool
> @@ -2569,13 +2725,52 @@ def _update_capabilities_from_flag(
>          unsupported_capabilities: MutableSet["NicCapability"],
>          flag_class: type[Flag],
>          supported_flags: Flag,
> +        prefix: str = "",
>      ) -> None:
>          """Divide all flags from `flag_class` into supported and unsupported."""
>          for flag in flag_class:
>              if flag in supported_flags:
> -                supported_capabilities.add(NicCapability[str(flag.name)])
> +                supported_capabilities.add(NicCapability[f"{prefix}{flag.name}"])
>              else:
> -                unsupported_capabilities.add(NicCapability[str(flag.name)])
> +                unsupported_capabilities.add(NicCapability[f"{prefix}{flag.name}"])
> +
> +    @requires_started_ports
> +    def get_offload_config(
> +        self,
> +        rxtx: RxTxLiteralSwitch,
> +        port_id: int,
> +        /,
> +        verify: bool = True,
> +    ) -> RxOffloadConfiguration | TxOffloadConfiguration:
> +        """Get the Rx or Tx offload configuration of the queues from the given port.
> +
> +        Args:
> +            rxtx: Whether to get the Rx or Tx configuration of the given queues.
> +            port_id: The port ID that contains the desired queues.
> +            verify: If :data:`True` the output of the command will be scanned in an attempt to
> +                verify that the offload configuration was retrieved successfully on all queues.
> +
> +        Returns:
> +            An offload configuration containing the capabilities of the port and queues.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queue offload configurations could not be
> +                retrieved.
> +        """
> +        config_output = self.send_command(f"show port {port_id} {rxtx}_offload configuration")
> +        if verify:
> +            if (
> +                f"Rx Offloading Configuration of port {port_id}" not in config_output
> +                and f"Tx Offloading Configuration of port {port_id}" not in config_output
> +            ):
> +                self._logger.debug(f"Get port offload config error\n{config_output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to get offload config on port {port_id}:\n{config_output}"
> +                )
> +        if rxtx == "rx":
> +            return RxOffloadConfiguration.parse(config_output)
> +        else:
> +            return TxOffloadConfiguration.parse(config_output)
>  
>      @requires_started_ports
>      def get_capabilities_rxq_info(
> @@ -2758,102 +2953,367 @@ class NicCapability(NoAliasEnum):
>      we don't go looking for it again if a different test case also needs it.
>      """
>  
> +    PORT_TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_VLAN_INSERT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_TCP_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_UDP_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_QINQ_INSERT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_VXLAN_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_GRE_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_IPIP_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_GENEVE_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_MACSEC_INSERT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_MT_LOCKFREE: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_MULTI_SEGS: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_MBUF_FAST_FREE: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_UDP_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_IP_TNL_TSO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    PORT_TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
> +    QUEUE_TX_OFFLOAD_SEND_ON_TIMESTAMP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("tx"),
> +        None,
> +    )
>      #: Scattered packets Rx enabled
>      SCATTERED_RX_ENABLED: TestPmdShellNicCapability = (
>          TestPmdShell.get_capabilities_rxq_info,
>          add_remove_mtu(9000),
>      )
>      #:
> -    RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_VLAN_STRIP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports L3 checksum offload.
> -    RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_TCP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports Large Receive Offload.
> -    RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
> +    PORT_RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_TCP_LRO: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
>      #: Device supports QinQ (queue in queue) offload.
> -    RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_QINQ_STRIP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports inner packet L3 checksum.
> -    RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_OUTER_IPV4_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports MACsec.
> -    RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_MACSEC_STRIP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports filtering of a VLAN Tag identifier.
> -    RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_VLAN_FILTER: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports VLAN offload.
> -    RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_VLAN_EXTEND: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports receiving segmented mbufs.
> -    RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
> +    PORT_RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_SCATTER: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
>      #: Device supports Timestamp.
> -    RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_TIMESTAMP: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports crypto processing while packet is received in NIC.
> -    RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_SECURITY: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports CRC stripping.
> -    RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_KEEP_CRC: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports L4 checksum offload.
> -    RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_SCTP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports inner packet L4 checksum.
> -    RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_OUTER_UDP_CKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports RSS hashing.
> -    RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_RSS_HASH: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports scatter Rx packets to segmented mbufs.
> -    RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_BUFFER_SPLIT: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports all checksum capabilities.
> -    RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
> -        TestPmdShell.get_capabilities_rx_offload,
> +    PORT_RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_CHECKSUM: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
>          None,
>      )
>      #: Device supports all VLAN capabilities.
> -    RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (TestPmdShell.get_capabilities_rx_offload, None)
> +    PORT_RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
> +    QUEUE_RX_OFFLOAD_VLAN: TestPmdShellNicCapability = (
> +        TestPmdShell.get_offload_capabilities_func("rx"),
> +        None,
> +    )
>      #: Device supports Rx queue setup after device started.
>      RUNTIME_RX_QUEUE_SETUP: TestPmdShellNicCapability = (
>          TestPmdShell.get_capabilities_show_port_info,
> diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_checksum_offload.py
> index ff916a4bb7..8e06c6b65f 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -30,9 +30,9 @@
>  
>  
>  @requires(topology_type=TopologyType.two_links)
> -@requires(NicCapability.RX_OFFLOAD_IPV4_CKSUM)
> -@requires(NicCapability.RX_OFFLOAD_UDP_CKSUM)
> -@requires(NicCapability.RX_OFFLOAD_TCP_CKSUM)
> +@requires(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
> +@requires(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
> +@requires(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
>  class TestChecksumOffload(TestSuite):
>      """Checksum offload test suite.
>  
> @@ -285,7 +285,7 @@ def validate_rx_checksum(self) -> None:
>                      packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
>                  )
>  
> -    @requires(NicCapability.RX_OFFLOAD_VLAN)
> +    @requires(NicCapability.PORT_RX_OFFLOAD_VLAN)
>      @func_test
>      def vlan_checksum(self) -> None:
>          """Test VLAN Rx checksum hardware offload and verify packet reception.
> @@ -342,7 +342,7 @@ def vlan_checksum(self) -> None:
>                      packet=packet_list[i], good_L4=False, good_IP=True, testpmd=testpmd, id=dport_id
>                  )
>  
> -    @requires(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
> +    @requires(NicCapability.PORT_RX_OFFLOAD_SCTP_CKSUM)
>      @func_test
>      def validate_sctp_checksum(self) -> None:
>          """Test SCTP Rx checksum hardware offload and verify packet reception.
> diff --git a/dts/tests/TestSuite_pmd_buffer_scatter.py b/dts/tests/TestSuite_pmd_buffer_scatter.py
> index 802777a697..54627157b5 100644
> --- a/dts/tests/TestSuite_pmd_buffer_scatter.py
> +++ b/dts/tests/TestSuite_pmd_buffer_scatter.py
> @@ -29,7 +29,7 @@
>  
>  
>  @requires(NicCapability.PHYSICAL_FUNCTION)
> -@requires(NicCapability.RX_OFFLOAD_SCATTER)
> +@requires(NicCapability.PORT_RX_OFFLOAD_SCATTER)
>  class TestPmdBufferScatter(TestSuite):
>      """DPDK PMD packet scattering test suite.
>  
> @@ -135,7 +135,7 @@ def scatter_mbuf_2048(self) -> None:
>          """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048."""
>          self.pmd_scatter(mb_size=2048)
>  
> -    @requires(NicCapability.RX_OFFLOAD_SCATTER)
> +    @requires(NicCapability.PORT_RX_OFFLOAD_SCATTER)
>      @func_test
>      def scatter_mbuf_2048_with_offload(self) -> None:
>          """Run the :meth:`pmd_scatter` test with `mb_size` set to 2048 and rx_scatter offload."""
> diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
> index ed36a2950d..906ceb0072 100644
> --- a/dts/tests/TestSuite_vlan.py
> +++ b/dts/tests/TestSuite_vlan.py
> @@ -20,7 +20,7 @@
>  from framework.testbed_model.capability import NicCapability, TopologyType, requires
>  
>  
> -@requires(NicCapability.RX_OFFLOAD_VLAN_FILTER)
> +@requires(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
>  @requires(topology_type=TopologyType.two_links)
>  class TestVlan(TestSuite):
>      """DPDK VLAN test suite.
> @@ -129,7 +129,7 @@ def vlan_receipt_no_stripping(self) -> None:
>              testpmd.start()
>              self.send_vlan_packet_and_verify(True, strip=False, vlan_id=1)
>  
> -    @requires(NicCapability.RX_OFFLOAD_VLAN_STRIP)
> +    @requires(NicCapability.PORT_RX_OFFLOAD_VLAN_STRIP)
>      @func_test
>      def vlan_receipt_stripping(self) -> None:
>          """Ensure VLAN packet received with no tag when receipts and header stripping are enabled.
> -- 
> 2.50.1
> 
