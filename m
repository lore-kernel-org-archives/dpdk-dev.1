Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786DC87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D32240649;
	Mon, 11 Aug 2025 12:47:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 335C6400D5
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:47:37 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D17E152B;
 Mon, 11 Aug 2025 03:47:28 -0700 (PDT)
Received: from [192.168.50.107] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 862873F738; Mon, 11 Aug 2025 03:47:35 -0700 (PDT)
Message-ID: <1ace1f11-b54d-46ba-8193-66fd86eb3a96@arm.com>
Date: Mon, 11 Aug 2025 11:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dts: rewrite two link topology requirements
Content-Language: en-GB
To: Dean Marx <dmarx@iol.unh.edu>, probb@iol.unh.edu,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com,
 paul.szczepanek@arm.com
Cc: dev@dpdk.org
References: <20250723135021.218084-1-dmarx@iol.unh.edu>
 <20250807140730.292639-1-dmarx@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250807140730.292639-1-dmarx@iol.unh.edu>
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

On 07/08/2025 15:07, Dean Marx wrote:
> diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blocklist.py
> index ce7da1cc8f..c75be247b5 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -12,7 +12,7 @@
>   from framework.testbed_model.port import Port
>   
>   
> -@requires(topology_type=TopologyType.two_links)
> +@requires(topology_type=TopologyType.one_link)
>   class TestBlocklist(TestSuite):
>       """DPDK device blocklisting test suite."""
>   
> @@ -51,6 +51,7 @@ def one_port_blocklisted(self):
>           """
>           self.verify_blocklisted_ports(self.topology.sut_ports[:1])
>   
> +    @requires(topology_type=TopologyType.two_links)
I am guessing by the logic of this then one_port_blocklisted could also 
use it.>       @func_test
>       def all_but_one_port_blocklisted(self):
>           """Run testpmd with all but one blocklisted port.
Would it make more sense to swap the order of the commits? This is 
because adding an explicit @requires for one_link becomes redundant. I'd 
probably change the default and then allow all the test suites that are 
happy with one link to just remove the two link requirement.
