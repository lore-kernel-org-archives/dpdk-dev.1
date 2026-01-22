Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B924AD3EE60
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 13:01:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AF514027A;
	Thu, 22 Jan 2026 14:01:19 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id BF9264021F
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:01:17 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 039F51476;
 Thu, 22 Jan 2026 05:01:10 -0800 (PST)
Received: from [10.57.94.77] (unknown [10.57.94.77])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFAC83F632;
 Thu, 22 Jan 2026 05:01:15 -0800 (PST)
Message-ID: <9f292ee0-1b20-4d10-8fb6-1efc277de97b@arm.com>
Date: Thu, 22 Jan 2026 13:01:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dts: automate VFIO-PCI modprobe
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>, probb@iol.unh.edu
Cc: dev@dpdk.org, dmarx@iol.unh.edu
References: <20251121210650.328804-1-abailey@iol.unh.edu>
 <20251126141650.367633-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20251126141650.367633-1-abailey@iol.unh.edu>
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

Hi Andrew,

this is a good shout. But be mindful of the implementation.

On 26/11/2025 14:16, Andrew Bailey wrote:
> Currently, users must modprobe vfio-pci before running DTS when using a
> non-mellanox NIC. This patch automates the process on test run start up.
> 
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>   dts/framework/test_run.py | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index ff0a12c9ce..9d7b6271c7 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -106,6 +106,7 @@
>   from types import MethodType
>   from typing import ClassVar, Protocol, Union
>   
> +from api.capabilities import LinkTopology
>   from framework.config.test_run import TestRunConfiguration
>   from framework.context import Context, init_ctx
>   from framework.exception import InternalError, SkippedTestException, TestCaseVerifyError
> @@ -347,6 +348,13 @@ def next(self) -> State | None:
>           test_run.ctx.dpdk.setup()
>           test_run.ctx.topology.setup()
>   
> +        if (
> +            test_run.ctx.topology.type != LinkTopology.NO_LINK
> +            and test_run.ctx.sut_node.ports[0].config.os_driver_for_dpdk == "vfio-pci"
> +        ):
> +            test_run.ctx.sut_node.main_session.send_command("modprobe vfio")
> +            test_run.ctx.sut_node.main_session.send_command("modprobe vfio-pci")
> +
>           if test_run.config.use_virtual_functions:
>               test_run.ctx.topology.instantiate_vf_ports()
>   

Loading vfio-pci is perfectly fine in my opinion, but like Patrick 
already mentioned, this part of the framework should be OS-agnostic, 
therefore you should place the logic accordingly in Node (load_drivers) 
and LinuxSession for the actual command.

Since this is part of the Node setup, it should be part of Node.setup 
and not in test_run.py

Best,
Luca
