Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6ECA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 19:37:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDAA44042C;
	Tue,  2 Sep 2025 21:37:41 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id B3953402E4
 for <dev@dpdk.org>; Tue,  2 Sep 2025 21:37:38 +0200 (CEST)
Received: from debian (unknown [78.109.66.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id DD7BCE0E15;
 Tue,  2 Sep 2025 23:37:36 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am DD7BCE0E15
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1756841857;
 bh=WM0oAWReMeF+fXtg94Hj/mXtCPijMBA3IQKLoo+UJic=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=g4KRKfXhU9Xe/y2gGJRUiz1X8OaCEBpOgmaOXQMZ5Gsx/R/BxfiCHqowbAqdXM1CE
 6/IXZrS9GltL1D873ZiiAgPMM14Rzx02R4MfFeD89FtyrvtY4Lfcf5248bjGL6W1I6
 MXIffb1xssKsX/QFX0HabK/3LCd2BLc3MpAHM/+cSR5Atilo5yHhZyJjB4payRdh+2
 x8O6rL85+E4vhzUICKqXgRb0PdU1PB0Hh1+zwxQoGPEeA1iMktIZXlWwwHCn8BcgsG
 QmOuZba8Cg4RHULMHz4pvh/8/m6o7EMDyyKwtA0CdPo7aU2dJFXq5PgwLzN+xsitM1
 1mkZJZp3H1/5g==
Date: Tue, 2 Sep 2025 23:37:28 +0400 (+04)
From: Ivan Malov <ivan.malov@arknetworks.am>
To: Andrew Bailey <abailey@iol.unh.edu>
cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v1 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
In-Reply-To: <20250902142725.56736-2-abailey@iol.unh.edu>
Message-ID: <3505d755-ddbc-d6f5-ff47-0ea2216c8993@arknetworks.am>
References: <20250902142725.56736-1-abailey@iol.unh.edu>
 <20250902142725.56736-2-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Hi Andrew,

On Tue, 2 Sep 2025, Andrew Bailey wrote:

> Currently, there is no way in the testpmd shell class to set the mbuf
> fast free offload configuration for RX or TX ports. This prohibits any

To me, this reads like some ports can be Rx-only while others can be Tx-only,
which is a little bit confusing. Also, let's double check that it makes to talk
about the 'mbuf fast free offload' in the context of an Rx queue; -- it was my
impression that this offload is only applicable to Tx queues, as they are meant
to 'reap' mbufs associated with 'done' Tx descriptors. Am I missing something?

> test suites to be written utilizing this offload configuration. Additionally,
> the NIC capabilities for the TX offload are not gathered. This prevents future
> test suites from being skipped if they do not support a TX offload capability.
> Introduce methods that support calls to testpmd in order to allow the
> configuration of mbuf fast free and to gather TX offload capabilities.

This added ability to collect Tx offload capability info is good.

One more point to consider: this handles 'mbuf_fast_free' on per-queue level,
but if it is valid on port-global level, too, may be one can also cover that.

>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
> dts/framework/remote_session/testpmd_shell.py | 137 +++++++++++++++++-
> 1 file changed, 136 insertions(+), 1 deletion(-)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
> index 786714d1c5..91642efec5 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -19,7 +19,7 @@
> import time
> from collections.abc import Callable, MutableSet
> from dataclasses import dataclass, field
> -from enum import Flag, auto
> +from enum import Enum, Flag, auto
> from os import environ
> from pathlib import PurePath
> from typing import TYPE_CHECKING, Any, ClassVar, Concatenate, Literal, ParamSpec, Tuple, TypeAlias
> @@ -344,6 +344,13 @@ def make_parser(cls) -> ParserFn:
>         )
>
>
> +class RxTxArgFlag(Enum):
> +    """Enum representing receiving or transmitting ports."""
> +
> +    TX = "tx"
> +    RX = "rx"
> +
> +
> class DeviceCapabilitiesFlag(Flag):
>     """Flag representing the device capabilities."""
>
> @@ -2787,6 +2794,134 @@ def get_capabilities_physical_function(
>         else:
>             unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
>
> +    @requires_started_ports
> +    def get_rxtx_offload_config(
> +        self,
> +        rxtx: RxTxArgFlag,
> +        verify: bool,
> +        port_id: int = 0,
> +        num_queues: int = 0,
> +    ) -> dict[int | str, str]:
> +        """Get the RX or TX offload configuration of the queues from the given port.
> +
> +        Args:
> +            rxtx: Whether to get the RX or TX configuration of the given queues.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
> +                verify that the offload configuration was retrieved successfully on all queues.
> +            num_queues: The number of queues to get the offload configuration for.
> +            port_id: The port ID that contains the desired queues.
> +
> +        Returns:
> +            A dict containing port info at key 'port' and queue info keyed by the appropriate queue
> +                id.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queue offload configurations could not be
> +                retrieved.
> +
> +        """
> +        returnDict: dict[int | str, str] = {}
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
> +                )
> +        # Actual output data starts on the thrid line
> +        tempList: list[str] = config_output.splitlines()[3::]
> +        returnDict["port"] = tempList[0]
> +        for i in range(0, num_queues):
> +            returnDict[i] = tempList[i + 1]
> +        return returnDict
> +
> +    @requires_stopped_ports
> +    def set_port_rxtx_mbuf_fast_free(
> +        self, rxtx: RxTxArgFlag, on: bool, verify: bool, port_id: int = 0
> +    ) -> None:
> +        """Sets the mbuf_fast_free configuration for the RX or TX offload for a given port.
> +
> +        Args:
> +            rxtx: Whether to set the mbuf_fast_free on the RX or TX port.
> +            on: If :data:'True' mbuf_fast_free will be enabled, disable it otherwise.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
> +                verify that the mbuf_fast_free was set successfully.
> +            port_id: The port number to enable or disable mbuf_fast_free on.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully
> +        """
> +        mbuf_output = self.send_command(
> +            f"port config {port_id} {rxtx.value}_offload mbuf_fast_free {"on" if on else "off"}"
> +        )
> +
> +        if "error" in mbuf_output and verify:
> +            raise InteractiveCommandExecutionError(
> +                f"""Unable to set mbuf_fast_free config on port {port_id}:\n{mbuf_output}"""
> +            )
> +
> +    @requires_stopped_ports
> +    def set_queue_rxtx_mbuf_fast_free(
> +        self,
> +        rxtx: RxTxArgFlag,

So this is questionable. Please see below.

> +        on: bool,
> +        verify: bool,
> +        port_id: int = 0,
> +        queue_id: int = 0,
> +    ) -> None:
> +        """Sets RX or TX mbuf_fast_free configuration of the specified queue on a given port.
> +
> +        Args:
> +            rxtx: Whether to set mbuf_fast_free for the RX or TX offload configuration on the
> +                given queues.
> +            on: If :data:'True' the mbuf_fast_free configuration will be enabled, otherwise
> +                disabled.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
> +                verify that mbuf_fast_free was set successfully on all ports.
> +            queue_id: The queue to disable mbuf_fast_free on.
> +            port_id: The ID of the port containing the queues.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queues could not be set successfully.
> +        """
> +        toggle = "on" if on else "off"
> +        output = self.send_command(
> +            f"port {port_id} {rxtx.value}q {queue_id} {rxtx.value}_offload mbuf_fast_free {toggle}"

For me, on a slightly dated DPDK build, setting this on an Rx queue fails:

testpmd> port 0 rxq 0 rx_offload mbuf_fast_free off
Bad arguments

An equivalent Tx command works, albeit unsupported in my specific circumstances.

testpmd> port 0 txq 0 tx_offload mbuf_fast_free off
Error: port 0 doesn't support per queue offload: mbuf_fast_free.

> +        )
> +        if verify:
> +            if "Error" in output:
> +                self._logger.debug(f"Set queue offload config error\n{output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
> +                )
> +
> +    def set_all_queues_rxtx_mbuf_fast_free(
> +        self,
> +        rxtx: RxTxArgFlag,
> +        on: bool,
> +        verify: bool,
> +        port_id=0,
> +        num_queues: int = 0,
> +    ) -> None:
> +        """Sets mbuf_fast_free configuration for the RX or TX offload of all queues on a given port.
> +
> +        Args:
> +            rxtx: Whether to set mbuf_fast_free for the RX or TX offload configuration on the
> +                given queues.
> +            on: If :data:'True' the mbuf fast_free_configuration will be enabled, otherwise
> +                disabled.
> +            verify: If :data:'True' the output of the command will be scanned in an attempt to
> +                verify that mbuf_fast_free was set successfully on all ports.
> +            port_id: The ID of the port containing the queues.
> +            num_queues: The queue to disable mbuf_fast_free on.

While I'm not well-versed in DTS style in general and cannot push to choose
some specific naming, I'd say, to me, 'queue_ids' would read less ambiguous.

Thank you.

> +        """
> +        for i in range(0, num_queues):
> +            self.set_queue_rxtx_mbuf_fast_free(rxtx, on, verify, port_id=port_id, queue_id=i)
> +
>
> class NicCapability(NoAliasEnum):
>     """A mapping between capability names and the associated :class:`TestPmdShell` methods.
> --
> 2.50.1
>
>
