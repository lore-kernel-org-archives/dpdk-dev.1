Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89569CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 13:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB7E402EE;
	Tue, 21 Oct 2025 15:29:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 9DCA9400D5
 for <dev@dpdk.org>; Tue, 21 Oct 2025 15:28:58 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 302DB1063;
 Tue, 21 Oct 2025 06:28:50 -0700 (PDT)
Received: from arm.com (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B7843F63F;
 Tue, 21 Oct 2025 06:28:56 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:28:51 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v7 1/3] dts: allow mbuf_fast_free to be set with testpmd
 shell
Message-ID: <176105316351.86099.5081796528192485598.luca.vizzarro@arm.com>
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251016132421.12176-1-abailey@iol.unh.edu>
 <20251016132421.12176-2-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016132421.12176-2-abailey@iol.unh.edu>
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

Apologies for not spotting this before. Everything else is fine just as
before but:

On Thu, Oct 16, 2025 at 09:24:19AM +0000, Andrew Bailey wrote:
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index a060ab5639..39696ddde2 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(
>              supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
>          else:
>              unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
> +
> +    @_requires_stopped_ports
> +    def set_port_mbuf_fast_free(
> +        self,
> +        on: bool,
> +        port_id: int,

Out of consistency with the actual testpmd call and with all the other
methods, the port_id should come first. The arguments generally reflect
the other in which they are called in testpmd to make it "easier" for
someone who is familiar with it to pick up.

> +        /,
> +        verify: bool = True,
> +    ) -> None:
> +        """Sets the mbuf_fast_free configuration for the Tx offload of a given port.
> +
> +        Args:
> +            on: If :data:`True` mbuf_fast_free will be enabled, disable it otherwise.
> +            port_id: The ID of the port to configure mbuf_fast_free on.

Don't forget to swap it here as well.

> +            verify: If :data:`True` the output of the command will be scanned in an attempt to
> +                verify that the mbuf_fast_free was set successfully.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If mbuf_fast_free could not be set successfully.
> +        """
<snip>
> +
> +    @_requires_stopped_ports
> +    def set_queue_mbuf_fast_free(
> +        self,
> +        on: bool,
> +        port_id: int,

same here.

> +        /,
> +        queue_id: int = 0,
> +        verify: bool = True,
> +    ) -> None:

and the docstring here too.

Best,
Luca
