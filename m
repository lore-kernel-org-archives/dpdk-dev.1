Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F5CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 15:16:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9548C427A7;
	Thu,  4 Sep 2025 17:16:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id AD3CE4275D
 for <dev@dpdk.org>; Thu,  4 Sep 2025 17:16:04 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C171596;
 Thu,  4 Sep 2025 08:15:55 -0700 (PDT)
Received: from arm.com (unknown [10.57.57.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAFEB3F6A8;
 Thu,  4 Sep 2025 08:16:02 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:15:58 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, ivan.malov@arknetworks.am, 
 probb@iol.unh.edu
Subject: Re: [PATCH v2 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
Message-ID: <175699757148.86363.18113785073209751856.luca.vizzarro@arm.com>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250903180414.83001-1-abailey@iol.unh.edu>
 <20250903180414.83001-2-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903180414.83001-2-abailey@iol.unh.edu>
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

On Wed, Sep 03, 2025 at 02:04:12PM +0000, Andrew Bailey wrote:
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index ad8cb273dc..4d9caceb37 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -19,7 +19,7 @@
>  import time
>  from collections.abc import Callable, MutableSet
>  from dataclasses import dataclass, field
> -from enum import Flag, auto
> +from enum import Enum, Flag, auto
>  from os import environ
>  from pathlib import PurePath
>  from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
> @@ -344,6 +344,13 @@ def make_parser(cls) -> ParserFn:
>          )
>  
>  
> +class RxTxArgFlag(Enum):

this could be StrEnum given the values used. Moreover, is it a
flag? Looks like a regular enum to me.

> +    """Enum representing receiving or transmitting ports."""
> +
> +    TX = "tx"
> +    RX = "rx"
> +
> +
>  class DeviceCapabilitiesFlag(Flag):
>      """Flag representing the device capabilities."""
>  
> @@ -2672,6 +2679,125 @@ def get_capabilities_physical_function(
>          else:
>              unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
>  
> +    @requires_started_ports
> +    def get_rxtx_offload_config(
if we are considering rxtx as two words, they should be split by _
> +        self,
> +        rxtx: RxTxArgFlag,
as above. If the whole purpose of the Enum is just a switch for the
argument, you can consider using a Literal instead, it'll be easier to
write from a user perspective as well:

  RxTxLiteralSwitch = Literal["rx", "tx"]
  ...
  get_rx_tx_offload_config("rx")

This also makes me question whether we need rx_tx at all in the name of
the method.

> +        verify: bool,
We've made verify an optional argument across the board, should be the
same here.
> +        port_id: int = 0,
I would also *not* make port_id optional. For the sake of readability
when using, you can split rx_tx from port_id using a /. This will
determine the end of positional arguments, therefore making anything
after mandatory keyword arguments.
> +        num_queues: int = 0,
> +    ) -> dict[int | str, str]:
This return type looks like it needs a dedicated data structure.
> +        """Get the Rx or Tx offload configuration of the queues from the given port.
> +
> +        Args:
> +            rxtx: Whether to get the Rx or Tx configuration of the given queues.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
Any RST directives need backticks:

  :data:`True`

> +                verify that the offload configuration was retrieved successfully on all queues.
> +            port_id: The port ID that contains the desired queues.
> +            num_queues: The number of queues to get the offload configuration for.
> +
> +        Returns:
> +            A dict containing port info at key 'port' and queue info keyed by the appropriate queue
> +                id.
Keys cannot be enforced by mypy with a generic dict. Consider using a
NamedDict or a dataclass appropriately.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queue offload configurations could not be
> +                retrieved.
> +
extra empty line shouldn't be here.
> +        """
> +        returnDict: dict[int | str, str] = {}
snake_case notation is used for variables.
> +
> +        config_output = self.send_command(f"show port {port_id} {rxtx.value}_offload configuration")
> +        if verify:
> +            if (
> +                f"Rx Offloading Configuration of port {port_id}" not in config_output
> +                and f"Tx Offloading Configuration of port {port_id}" not in config_output
> +            ):
> +                self._logger.debug(f"Get port offload config error\n{config_output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"""Failed to get offload config on port {port_id}:\n{config_output}"""
No need to use multi-line quotes for a single line.
> +                )
> +        # Actual output data starts on the third line
> +        tempList: list[str] = config_output.splitlines()[3::]
> +        returnDict["port"] = tempList[0]
> +        for i in range(0, num_queues):
> +            returnDict[i] = tempList[i + 1]
Looks like an occasion to use a TextParser for the return data structure.
> +        return returnDict
> +
> +    @requires_stopped_ports
> +    def set_port_mbuf_fast_free(self, on: bool, verify: bool, port_id: int = 0) -> None:
Similar situation for port_id and verify as above.
> +        """Sets the mbuf_fast_free configuration for the Tx offload for a given port.
> +
> +        Args:
> +            on: If :data:'True' mbuf_fast_free will be enabled, disable it otherwise.
backticks instead of single quotes
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
backticks instead of single quotes
> +                verify that the mbuf_fast_free was set successfully.
> +            port_id: The port number to enable or disable mbuf_fast_free on.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully
missed full stop at the end.
> +        """
> +        mbuf_output = self.send_command(
> +            f"port config {port_id} tx_offload mbuf_fast_free {"on" if on else "off"}"
> +        )
> +
> +        if "error" in mbuf_output and verify:
This is not really that important but you may always want to check for
the boolean first as that will spare doing a text search if set to
False. Writing it like this is generally better:

    if verify and "error" in mbuf_output:

> +            raise InteractiveCommandExecutionError(
> +                f"""Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"""
multi-line quotes in single line string.
> +            )
> +
> +    @requires_stopped_ports
> +    def set_queue_mbuf_fast_free(
> +        self,
> +        on: bool,
> +        verify: bool,
> +        port_id: int = 0,
> +        queue_id: int = 0,
> +    ) -> None:
same discussion for verify, port_id and queue_id.
> +        """Sets the Tx mbuf_fast_free configuration of the specified queue on a given port.
> +
> +        Args:
> +            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
backticks instead of single quotes
> +                disabled.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
backticks instead of single quotes
> +                verify that mbuf_fast_free was set successfully on all ports.
> +            port_id: The ID of the port containing the queues.
> +            queue_id: The queue to disable mbuf_fast_free on.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queues could not be set successfully.
> +        """
> +        toggle = "on" if on else "off"
> +        output = self.send_command(
> +            f"port {port_id} txq {queue_id} tx_offload mbuf_fast_free {toggle}"
> +        )
> +        if verify:
> +            if "Error" in output:
the two conditions could be merged together, and it will read easier
requiring one level less of indentation.
> +                self._logger.debug(f"Set queue offload config error\n{output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
> +                )
> +
> +    def set_all_queues_mbuf_fast_free(
> +        self,
> +        on: bool,
> +        verify: bool,
> +        port_id=0,
> +        num_queues: int = 0,
> +    ) -> None:
same discussion for the args.
> +        """Sets mbuf_fast_free configuration for the Tx offload of all queues on a given port.
> +
> +        Args:
> +            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
backticks instead of single quotes
> +                disabled.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
backticks instead of single quotes
> +                verify that mbuf_fast_free was set successfully on all ports.
> +            port_id: The ID of the port containing the queues.
> +            num_queues: The amount of queues to disable mbuf_fast_free on.
> +        """
> +        for i in range(0, num_queues):
> +            self.set_queue_mbuf_fast_free(on, verify, port_id=port_id, queue_id=i)
So far we have been mostly replicating the testpmd functionality. I am
wondering if this is actually needed to be implemented on the
TestPmdShell side.
> +
>  
>  class NicCapability(NoAliasEnum):
>      """A mapping between capability names and the associated :class:`TestPmdShell` methods.
> -- 
> 2.50.1
> 
