Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6EC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 21:08:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 837814026E;
	Fri, 31 Jan 2025 22:08:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 2FDA3400EF
 for <dev@dpdk.org>; Fri, 31 Jan 2025 22:08:46 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48C3497;
 Fri, 31 Jan 2025 13:09:10 -0800 (PST)
Received: from [10.57.75.129] (unknown [10.57.75.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18B803F63F;
 Fri, 31 Jan 2025 13:08:43 -0800 (PST)
Message-ID: <32f36fbd-7cc0-4ef6-94a7-54b8b392f205@arm.com>
Date: Fri, 31 Jan 2025 21:08:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dts: rework run-time MTU adjustment test case
Content-Language: en-GB
To: Nicholas Pratte <npratte@iol.unh.edu>, yoan.picchi@foss.arm.com,
 thomas@monjalon.net, probb@iol.unh.edu, Honnappa.Nagarahalli@arm.com,
 stephen@networkplumber.org, paul.szczepanek@arm.com, dmarx@iol.unh.edu,
 thomas.wilks@arm.com, ian.stokes@intel.com
Cc: dev@dpdk.org
References: <20250131193803.168498-1-npratte@iol.unh.edu>
 <20250131193803.168498-3-npratte@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20250131193803.168498-3-npratte@iol.unh.edu>
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

Looks good. Just some very small comments on polishing.

Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>

On 31/01/2025 19:38, Nicholas Pratte wrote:
> Forwarding restarts in the run-time MTU adjustment test case have been
> explicitly added, given that the 'requires_forwarding_restart' decorator
> from a previous patch was removed.
> 
> Signed-off-by: Nicholas Pratte <npratte@iol.unh.edu>
> ---
>   dts/tests/TestSuite_mtu.py | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
> index 3c96a36fc9..d1d48c2c13 100644
> --- a/dts/tests/TestSuite_mtu.py
> +++ b/dts/tests/TestSuite_mtu.py
> @@ -164,20 +164,26 @@ def test_runtime_mtu_updating_and_forwarding(self) -> None:
>               # Configure the new MTU.
>   
>               # Start packet capturing.
> -            testpmd.start()
>   

I guess all of the lines above are no longer needed here.

>               testpmd.set_port_mtu_all(1500, verify=True)
> +            testpmd.start()
>               self.assess_mtu_boundary(testpmd, 1500)
>   
> +            testpmd.stop()
>               testpmd.set_port_mtu_all(2400, verify=True)
> +            testpmd.start()
>               self.assess_mtu_boundary(testpmd, 1500)
>               self.assess_mtu_boundary(testpmd, 2400)
>   
> +            testpmd.stop()
>               testpmd.set_port_mtu_all(4800, verify=True)
> +            testpmd.start()
>               self.assess_mtu_boundary(testpmd, 1500)
>               self.assess_mtu_boundary(testpmd, 4800)
>   
> +            testpmd.stop()
>               testpmd.set_port_mtu_all(9000, verify=True)
> +            testpmd.start()
>               self.assess_mtu_boundary(testpmd, 1500)
>               self.assess_mtu_boundary(testpmd, 9000)
>   

The start and stop could be grouped by forwarding sections:

   set_mtu()

   start()
   assess()
   assess()
   stop()

   set_mtu()
   ...
