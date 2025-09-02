Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D364BCA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 16:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83CA24042C;
	Tue,  2 Sep 2025 18:52:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 77C6F402E6
 for <dev@dpdk.org>; Tue,  2 Sep 2025 18:52:47 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D96226BE;
 Tue,  2 Sep 2025 09:52:38 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6CDB3F694;
 Tue,  2 Sep 2025 09:52:45 -0700 (PDT)
Date: Tue, 2 Sep 2025 17:52:33 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v3] dts: enable port binding on the TG
Message-ID: <175683053809.93271.2049800112988455963.luca.vizzarro@arm.com>
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250828123758.20451-1-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828123758.20451-1-abailey@iol.unh.edu>
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

Thank you for clarifying. It makes more sense now.

On Thu, Aug 28, 2025 at 08:37:58AM +0000, Andrew Bailey wrote:
> diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
> index fc58e2b993..e9ad145f97 100644
> --- a/dts/framework/testbed_model/port.py
> +++ b/dts/framework/testbed_model/port.py
> @@ -126,7 +126,12 @@ def original_driver(self) -> str | None:
>      @property
>      def bound_for_dpdk(self) -> bool:
>          """Is the port bound to the driver for DPDK?"""
> -        return self.current_driver == self.config.os_driver_for_dpdk
> +        dpdk_driver = self.config.os_driver_for_dpdk
> +
> +        if "TG" in self.node.name:
> +            return self.current_driver == dpdk_driver and dpdk_driver != self.config.os_driver

The `node.name` is an arbitrary name that is chosen by the user.
Unfortunately this is not a reliable approach.

Another issue is that this logic doesn't really make a lot of sense in
the context of this property. I'd much rather have a `bound_for_kernel`
property, and then fix the checks appropriately where these are called.

From my understanding of the commit body this is due to the condition in
the list comprehension in ports_to_bring_up not covering this corner
case. If this is right, then this condition should be updated
accordingly.

> +
> +        return self.current_driver == dpdk_driver
>  
>      def configure_mtu(self, mtu: int):
>          """Configure the port's MTU value.
> diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
> index 899ea0ad3a..b35a519719 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -250,6 +253,41 @@ def _bind_ports_to_drivers(
> <snip>
> +        ctx = get_ctx()
> +        prepare_node(ctx.tg_node)
> +        prepare_node(ctx.sut_node)
> +        # ctx.tg_node.main_session.bring_up_link(self.sut_ports)

Like Patrick said, this should be removed.
