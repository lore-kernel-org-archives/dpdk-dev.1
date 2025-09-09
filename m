Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF33DCAC583
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Sep 2025 15:39:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1341D40281;
	Tue,  9 Sep 2025 17:39:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 23FCB4026D
 for <dev@dpdk.org>; Tue,  9 Sep 2025 17:39:32 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 360FC1424;
 Tue,  9 Sep 2025 08:39:23 -0700 (PDT)
Received: from arm.com (unknown [10.1.194.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1B5D3F694;
 Tue,  9 Sep 2025 08:39:30 -0700 (PDT)
Date: Tue, 9 Sep 2025 16:39:27 +0100
From: Luca Vizzarro <luca.vizzarro@arm.com>
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
Subject: Re: [PATCH v4] dts: enable port binding on the TG
Message-ID: <175743154178.70332.7929887934663928079.luca.vizzarro@arm.com>
References: <20250808182152.356879-2-abailey@iol.unh.edu>
 <20250908173618.202075-1-abailey@iol.unh.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908173618.202075-1-abailey@iol.unh.edu>
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

thank you for this, just some minor comments.

On Mon, Sep 08, 2025 at 01:36:18PM +0000, Andrew Bailey wrote:
> diff --git a/dts/framework/testbed_model/port.py b/dts/framework/testbed_model/port.py
> index fc58e2b993..8f9b5c3931 100644
> --- a/dts/framework/testbed_model/port.py
> +++ b/dts/framework/testbed_model/port.py
> @@ -126,7 +126,8 @@ def original_driver(self) -> str | None:
>      @property
>      def bound_for_dpdk(self) -> bool:
>          """Is the port bound to the driver for DPDK?"""
> -        return self.current_driver == self.config.os_driver_for_dpdk
> +        dpdk_driver = self.config.os_driver_for_dpdk
> +        return self.current_driver == dpdk_driver

unnecessary change, this can stay as it was to avoid change noise. (we
don't want to pollute the versioning as it makes it harder to navigate)

> 
>      def configure_mtu(self, mtu: int):
>          """Configure the port's MTU value.
> diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
> index 899ea0ad3a..370bcc3c03 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -232,7 +235,14 @@ def configure_ports(
> 
>          self._bind_ports_to_drivers(node, ports, drivers)
> 
> -        ports_to_bring_up = [p for p in ports if not (p.bound_for_dpdk or p.is_link_up)]
> +        ports_to_bring_up = [
> +            p
> +            for p in ports
> +            if not (
> +                (p.bound_for_dpdk and p.config.os_driver_for_dpdk != p.config.os_driver)
> +                or p.is_link_up
> +            )
> +        ]

This is fine, it's just not particularly readable. I'd say to either add
some comments to make the logic clearer, or just make the logic clearer
(feel free to implement a `bound_for_kernel` if it can aid you).

Best,
Luca
