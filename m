Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A31CA0EE6
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 08:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC28240273;
	Fri, 15 Aug 2025 10:50:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 88C5C4026C
 for <dev@dpdk.org>; Fri, 15 Aug 2025 10:50:36 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A62E81063;
 Fri, 15 Aug 2025 01:50:27 -0700 (PDT)
Received: from [192.168.50.107] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 3E8343F738; Fri, 15 Aug 2025 01:50:35 -0700 (PDT)
Message-ID: <992dc4bd-a55a-4f48-9be2-5e6d3385e1cd@arm.com>
Date: Fri, 15 Aug 2025 09:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dts: enable port binding on the TG
Content-Language: en-GB
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, dmarx@iol.unh.edu, probb@iol.unh.edu
References: <20250814203846.407334-1-abailey@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250814203846.407334-1-abailey@iol.unh.edu>
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

thank you for the very quick turnaround! I've just noticed that this is 
not precisely what I had in mind, but in fairness this approach is 
perfectly good.

On 14/08/2025 21:38, Andrew Bailey wrote:
> Currently, driver binding for all nodes relies on a devbind_script_path
> attribute in the node main sessions. This attribute is being set on the
> SUT node, but not the TG node. Consequently, if the TG node ports are
> not bound to the correct driver before DTS execution, the TG ports will
> fail to bind and DTS will error.
> 
> relocate prepare devbind script method to topology class to be used by both
> TG and SUT nodes.
nit: missed capitalisation.>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> 
> done
> ---
>   .mailmap                                |  1 +
>   dts/framework/remote_session/dpdk.py    | 36 +----------------------
>   dts/framework/testbed_model/topology.py | 39 +++++++++++++++++++++++++
>   3 files changed, 41 insertions(+), 35 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 34a99f93a1..df06862d8b 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -104,6 +104,7 @@ Andre Muezerie <andremue@linux.microsoft.com> <andremue@microsoft.com>
>   Andrea Arcangeli <aarcange@redhat.com>
>   Andrea Grandi <andrea.grandi@intel.com>
>   Andre Richter <andre.o.richter@gmail.com>
> +Andrew Bailey <abailey@iol.unh.edu>
>   Andrew Boyer <andrew.boyer@amd.com> <aboyer@pensando.io>
>   Andrew Harvey <agh@cisco.com>
>   Andrew Jackson <ajackson@solarflare.com>
> diff --git a/dts/framework/remote_session/dpdk.py b/dts/framework/remote_session/dpdk.py
> index 606d6e22fe..d1ab3ae50d 100644
> --- a/dts/framework/remote_session/dpdk.py
> +++ b/dts/framework/remote_session/dpdk.py
> @@ -24,12 +24,11 @@
>       RemoteDPDKTarballLocation,
>       RemoteDPDKTreeLocation,
>   )
> -from framework.exception import ConfigurationError, InternalError, RemoteFileNotFoundError
> +from framework.exception import ConfigurationError, RemoteFileNotFoundError
>   from framework.logger import DTSLogger, get_dts_logger
>   from framework.params.eal import EalParams
>   from framework.remote_session.remote_session import CommandResult
>   from framework.testbed_model.cpu import LogicalCore, LogicalCoreCount, LogicalCoreList, lcore_filter
> -from framework.testbed_model.linux_session import LinuxSession
>   from framework.testbed_model.node import Node
>   from framework.testbed_model.os_session import OSSession
>   from framework.testbed_model.virtual_device import VirtualDevice
> @@ -358,7 +357,6 @@ def setup(self):
>           """Set up the DPDK runtime on the target node."""
>           if self.build:
>               self.build.setup()
> -        self._prepare_devbind_script()
>   
>       def teardown(self) -> None:
>           """Reset DPDK variables and bind port driver to the OS driver."""
> @@ -385,38 +383,6 @@ def run_dpdk_app(
>               f"{app_path} {eal_params}", timeout, privileged=True, verify=True
>           )
>   
> -    def _prepare_devbind_script(self) -> None:
> -        """Prepare the devbind script.
> -
> -        If the environment has a build associated with it, then use the script within that build's
> -        tree. Otherwise, copy the script from the local repository.
> -
> -        This script is only available for Linux, if the detected session is not Linux then do
> -        nothing.
> -
> -        Raises:
> -            InternalError: If dpdk-devbind.py could not be found.
> -        """
> -        if not isinstance(self._node.main_session, LinuxSession):
> -            return
> -
> -        if self.build:
> -            devbind_script_path = self._node.main_session.join_remote_path(
> -                self.build.remote_dpdk_tree_path, "usertools", "dpdk-devbind.py"
> -            )
> -        else:
> -            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
> -            if not local_script_path.exists():
> -                raise InternalError("Could not find dpdk-devbind.py locally.")
> -
> -            devbind_script_path = self._node.main_session.join_remote_path(
> -                self._node.tmp_dir, local_script_path.name
> -            )
> -
> -            self._node.main_session.copy_to(local_script_path, devbind_script_path)
> -
> -        self._node.main_session.devbind_script_path = devbind_script_path
> -
>       def filter_lcores(
>           self,
>           filter_specifier: LogicalCoreCount | LogicalCoreList,
> diff --git a/dts/framework/testbed_model/topology.py b/dts/framework/testbed_model/topology.py
> index 899ea0ad3a..db96aaf170 100644
> --- a/dts/framework/testbed_model/topology.py
> +++ b/dts/framework/testbed_model/topology.py
> @@ -12,11 +12,13 @@
>   from collections.abc import Iterator
>   from dataclasses import dataclass
>   from enum import Enum
> +from pathlib import Path
>   from typing import Literal, NamedTuple
>   
>   from typing_extensions import Self
>   
>   from framework.exception import ConfigurationError, InternalError
> +from framework.testbed_model.linux_session import LinuxSession
>   from framework.testbed_model.node import Node
>   
>   from .port import DriverKind, Port, PortConfig
> @@ -128,6 +130,7 @@ def setup(self) -> None:
>   
>           Binds all the ports to the right kernel driver to retrieve MAC addresses and logical names.
>           """
> +        self._prepare_devbind_script()
>           self._setup_ports("sut")
>           self._setup_ports("tg")
>   
> @@ -250,6 +253,42 @@ def _bind_ports_to_drivers(
>           for driver_name, ports in driver_to_ports.items():
>               node.main_session.bind_ports_to_driver(ports, driver_name)
>   
> +    def _prepare_devbind_script(self) -> None:
> +        """Prepare the devbind script.
> +
> +        If the environment has a build associated with it, then use the script within that build's
> +        tree. Otherwise, copy the script from the local repository.
This is no longer true as you are now only copying the script.> +
> +        This script is only available for Linux, if the detected session is not Linux then do
> +        nothing.
> +
> +        Raises:
> +            InternalError: If dpdk-devbind.py could not be found.
> +        """
> +        from framework.context import get_ctx
> +
> +        ctx = get_ctx()
> +        tg = ctx.tg_node
> +        sut = ctx.sut_node
Since we are only calling these once there is no need in placing them in 
their own variables, see below.> +
> +        def prepare_node(node: Node) -> None:
> +            if not isinstance(node.main_session, LinuxSession):
> +                return
> +
> +            local_script_path = Path("..", "usertools", "dpdk-devbind.py").resolve()
> +            if not local_script_path.exists():
> +                raise InternalError("Could not find dpdk-devbind.py locally.")I guess local_script_path can go outside the inner function. Similarly 
we can store the result of `not local_script_path.exists()` in a 
variable in the outer function, but keep the check here as we only want 
to check if session is LinuxSession of course.> +
> +            devbind_script_path = node.main_session.join_remote_path(
> +                node.tmp_dir, local_script_path.name
> +            )
> +
> +            node.main_session.copy_to(local_script_path, devbind_script_path)
> +            node.main_session.devbind_script_path = devbind_script_path
> +
> +        prepare_node(tg)
> +        prepare_node(sut)
can just do:

   prepare_node(ctx.tg_node)
   ...

and spare 2 redundant lines.> +
>       @property
>       def sut_dpdk_ports(self) -> list[Port]:
>           """The DPDK ports for the SUT node."""
Thank you!
Best,
Luca
