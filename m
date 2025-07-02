Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81315C77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 15:31:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A7BA4028E;
	Wed,  2 Jul 2025 17:31:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id DF2DD40285
 for <dev@dpdk.org>; Wed,  2 Jul 2025 17:31:32 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489AC3024;
 Wed,  2 Jul 2025 08:31:17 -0700 (PDT)
Received: from [10.1.35.68] (JR4XG4HTQC-2.cambridge.arm.com [10.1.35.68])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEE123F6A8;
 Wed,  2 Jul 2025 08:31:30 -0700 (PDT)
Message-ID: <f7b7e8c3-1033-4fe8-8e05-1992fc6f271b@arm.com>
Date: Wed, 2 Jul 2025 16:31:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dts: rework traffic generator inheritance structure
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>, Paul.Szczepanek@arm.com
Cc: dev@dpdk.org, dmarx@iol.unh.edu, nprattedev@gmail.com,
 mmahajan@iol.unh.edu, abailey@iol.unh.edu, thomas.wilks@arm.com,
 Nicholas Pratte <npratte@iol.unh.edu>
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250702052154.381690-1-probb@iol.unh.edu>
 <20250702052154.381690-2-probb@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250702052154.381690-2-probb@iol.unh.edu>
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

On 02/07/2025 06:21, Patrick Robb wrote:
> +++ b/dts/framework/testbed_model/traffic_generator/performance_traffic_generator.py
> @@ -0,0 +1,63 @@
> <snip>
> +
> +@dataclass(slots=True)
> +class PerformanceTrafficStats(ABC):

Why is this inheriting ABC? I don't see why a dataclass would be 
abstract given it's even missing abstract methods.

> <snip>
> +class PerformanceTrafficGenerator(TrafficGenerator):
> +    """An abstract base class for all performance-oriented traffic generators.
> +
> +    Provides an intermediary interface for performance-based traffic generator.
> +    """
> +
> +    @abstractmethod
> +    def calculate_traffic_and_stats(
> +        self,
> +        packet: Packet,
> +        send_mpps: int,
> +        duration: float,
> +    ) -> PerformanceTrafficStats:
> +        """Send packet traffic and acquire associated statistics.
> +
> +        Args:
> +        packet: The packet to send.
> +        send_mpps: The millions packets per second send rate.
> +        duration: Performance test duration (in seconds).

bad indentation for args.

> diff --git a/dts/framework/testbed_model/traffic_generator/scapy.py b/dts/framework/testbed_model/traffic_generator/scapy.py
> index e21ba4ed96..602b93d473 100644
> --- a/dts/framework/testbed_model/traffic_generator/scapy.py
> +++ b/dts/framework/testbed_model/traffic_generator/scapy.py
> @@ -26,7 +26,7 @@
>   from scapy.packet import Packet
>   
>   from framework.config.node import OS
> -from framework.config.test_run import ScapyTrafficGeneratorConfig
> +from framework.config.test_run import TrafficGeneratorConfig

Making the Scapy class use a more generic config class looks like 
breaking behaviour. Why is this happening?

> @@ -332,6 +332,10 @@ def setup(self, topology: Topology):
>           self._shell.send_command("from scapy.all import *")
>           self._shell.send_command("from scapy.contrib.lldp import *")
>   
> +    def teardown(self):
> +        """Overrides :meth:`.traffic_generator.TrafficGenerator.teardown`."""
> +        pass

nit: `pass` is not needed here, because the docstring already completes 
the method as noop.

> <snip>
> diff --git a/dts/framework/testbed_model/traffic_generator/traffic_generator.py b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> index 8f53b07daf..ea3075989d 100644
> --- a/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> +++ b/dts/framework/testbed_model/traffic_generator/traffic_generator.py
> @@ -10,14 +10,10 @@
> <snip>
>   
>   class TrafficGenerator(ABC):
> @@ -54,46 +50,6 @@ def setup(self, topology: Topology):
>   
>       def teardown(self):
>           """Teardown the traffic generator."""
> -        self.close()

how come are we removing the default close behaviour? I don't see it 
being replaced appropriately.

> <snip>
> -    @property
> -    def is_capturing(self) -> bool:
> -        """This traffic generator can't capture traffic."""
> -        return False
Why is the above property being removed?
>   
>       @abstractmethod
>       def close(self) -> None:

