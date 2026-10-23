Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA44606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RImOOX1a
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 732BA40276;
	Fri, 23 Oct 2026 19:38:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7E03740268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 19:38:31 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 693BB19F6;
 Fri, 23 Oct 2026 10:38:27 -0700 (PDT)
Received: from [192.168.100.239] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A81F73F7B4;
 Fri, 23 Oct 2026 10:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792777110; bh=Nbl2wc+LfDHL9IQmuyHBxR9cBNVu1K60yfP+ewyOOjY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RImOOX1aThzd8zKvydF4lst5AO8oYVsQFb+Cr3DiMqRe5AwP8kv5NkSQoxLHW6sxU
 petaZmCs84okQVUuJFMRAjj9GAwI/2L+T1J5JkiH/kLzA/h+LlepWQQtqBYKFMxy+L
 936Xr6PgDIZ02OC+97Yd87kDrmzbFeoTmvGFbbf0=
Message-ID: <7d00f6a1-5909-48d6-906b-e078eeb9a1c3@arm.com>
Date: Fri, 23 Oct 2026 18:38:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dts: resolve trex driver binding issue
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu,
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
 <8811b276-3f46-484a-bffa-33accfe740b1@arm.com>
 <CAKYPG+wJOvzq0mUQ+R5MNuydaj_ROwHHgOqyF6K4nP_ewkO5_Q@mail.gmail.com>
 <b324fbdb-a6d0-4515-a499-7e76692feeb3@arm.com>
 <CAKYPG+xMM3jT_ME0qYtPctP6zc8kYXC88FMJeW12GidH12iD5g@mail.gmail.com>
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAKYPG+xMM3jT_ME0qYtPctP6zc8kYXC88FMJeW12GidH12iD5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/2026 18:29, Koushik Bhargav Nimoji wrote:
> 
> 
> On Thu, Oct 22, 2026 at 9:51 AM Luca Vizzarro <Luca.Vizzarro@arm.com 
> <mailto:Luca.Vizzarro@arm.com>> wrote:
> 
>     On 20/10/2026 17:06, Koushik Bhargav Nimoji wrote:
>      > On Fri, Oct 16, 2026 at 12:28 PM Luca Vizzarro
>     <Luca.Vizzarro@arm.com <mailto:Luca.Vizzarro@arm.com>
>      > <mailto:Luca.Vizzarro@arm.com <mailto:Luca.Vizzarro@arm.com>>> wrote:
>      >
>      >      > +        if (
>      >      > +            ctx.topology.type is not LinkTopology.NO_LINK
>      >      > +            and testsuite_type is not TestSuiteType.CRYPTO
>      >      > +        ):
>      >      > +            if testsuite_type == TestSuiteType.FUNC:
>      >      > +                required_tg, other_tg = ctx.func_tg,
>     ctx.perf_tg
>      >      > +            else:
>      >      > +                required_tg, other_tg = ctx.perf_tg,
>     ctx.func_tg
>      >      > +
>      >      > +            if other_tg and other_tg.is_setup:
>      >      > +                other_tg.teardown()
>      >      > +
>      >      > +                if testsuite_type == TestSuiteType.FUNC and
>      >     ctx.tg_node:
>      >      > +                    for port in ctx.topology.tg_ports:
>      >      > +
>      >     ctx.tg_node.main_session.bind_ports_to_driver([port],
>      >     port.config.os_driver)
>      >
>      >     I am a bit confused why this happens here. The driver to be
>     bound to
>      >     should be governed by the TG that uses such ports. Could be
>     os_driver,
>      >     could be dpdk_driver, regardless of Scapy and TRex.
>      >
>      > This section exists because of how scapy and TRex handle port driver
>      > bindings. TRex automatically binds ports to the required driver when
>      > setup, but scapy requires it to be done manually. That's why if
>     the next
>      > test suite to be tested is a functional test suite, the TG ports are
>      > rebound to the os_driver manually here.
> 
>     So I think the original intention here was that TRex would
>     exceptionally
>     change the driver as the normal behaviour was that the TG was not going
>     to be subject to driver binding. Therefore what would make sense is for
>     the TG to control driver binding accordingly. So if Scapy is setup that
>     it would be up to Scapy to "bind to kernel drivers" if needed. What do
>     you think?
> 
> 
> I think you're definitely right here, it should be up to the TG to take 
> care of port bindings instead of doing it manually. Scapy currently does 
> take care of that, but there's an issue with DTS's internal state being 
> out of date after rebinding to the kernel driver. As a workaround for 
> this, I have added a teardown method to trex.py that rebinds ports to 
> the kernel driver before scapy is set up. I will send out a version 
> shortly that reflects these changes, thanks for bringing this up.

So I think the problem with the state is because you are not using 
Topology which is the ports manager/owner. Even if `main_session` is 
public, it's an internal API which use should be limited to some. If you 
look at the setup of Scapy:

     def setup(self, topology: Topology) -> None:
         super().setup(topology)
         topology.configure_ports("tg", "kernel")

What I expect to see in the Trex class is:

     def setup(self, topology: Topology) -> None:
         super().setup(topology)
         topology.configure_ports("tg", "dpdk")

If this doesn't work as intended, then there is a bug that needs resolving.

Luca
