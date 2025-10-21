Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB43CCD1AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 13:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC9A140656;
	Tue, 21 Oct 2025 15:50:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6CB8240652
 for <dev@dpdk.org>; Tue, 21 Oct 2025 15:50:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC3BF1063;
 Tue, 21 Oct 2025 06:50:03 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F1563F63F;
 Tue, 21 Oct 2025 06:50:10 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:50:06 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu, 
 Jeremy Spewock <jspewock@iol.unh.edu>
Subject: Re: [PATCH v7 2/3] dts: add TX offload capabilities to NIC
 capabilities
Message-ID: <176105387954.86677.10857377570363226324.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251016132421.12176-1-abailey@iol.unh.edu>
 <20251016132421.12176-3-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016132421.12176-3-abailey@iol.unh.edu>
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

looks good, would just make it consistent where the port_id comes first
again in the arguments list.

On Thu, Oct 16, 2025 at 09:24:20AM +0000, Andrew Bailey wrote:
> @@ -1352,3 +1407,41 @@ def set_queue_mbuf_fast_free(
>              raise InteractiveCommandExecutionError(
>                  f"Failed to get offload config on port {port_id}, queue {queue_id}:\n{output}"
>              )
> +
> +    @_requires_started_ports
> +    def get_offload_config(
> +        self,
> +        rxtx: RxTxLiteralSwitch,
> +        port_id: int,
swap here.
> +        /,
> +        verify: bool = True,
> +    ) -> RxOffloadConfiguration | TxOffloadConfiguration:
> +        """Get the Rx or Tx offload configuration of the queues from the given port.
> +
> +        Args:
> +            rxtx: Whether to get the Rx or Tx configuration of the given queues.
> +            port_id: The port ID that contains the desired queues.
swap here.
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
