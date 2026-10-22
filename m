Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D73606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=f5arq3Mg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FB1D40264;
	Thu, 22 Oct 2026 15:51:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7684C4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 15:51:02 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 693771692;
 Thu, 22 Oct 2026 06:50:58 -0700 (PDT)
Received: from [10.57.13.253] (unknown [10.57.13.253])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2783F673;
 Thu, 22 Oct 2026 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792677061; bh=Fxk8yp+CweorN2v65MZ9BKqK26q4XcFfkbwAf/sy29M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=f5arq3MgRc74qGvxUG1ulKAvV8l+Pr3jp4jAEFZgNyDJGTIytPhpFHnTR37T76TH6
 P80HcBdTVRclFUz9Nsynuf8Cztuwwm77IAt5Tv+GP+agm0q8EP3uhCeeC5zFaZ1A8t
 +XQArz2xwm+PIDuYR2sWklaFMvGLsDZs4VKGlVNI=
Message-ID: <b324fbdb-a6d0-4515-a499-7e76692feeb3@arm.com>
Date: Thu, 22 Oct 2026 14:50:58 +0100
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
Content-Language: en-GB
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAKYPG+wJOvzq0mUQ+R5MNuydaj_ROwHHgOqyF6K4nP_ewkO5_Q@mail.gmail.com>
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/2026 17:06, Koushik Bhargav Nimoji wrote:
> On Fri, Oct 16, 2026 at 12:28 PM Luca Vizzarro <Luca.Vizzarro@arm.com 
> <mailto:Luca.Vizzarro@arm.com>> wrote:
> 
>     Hi Koushik,
> 
>     Apologies for the long wait. To start off, could you please address the
>     AI Code Review as it raised a few concerns:
> 
>     http://mails.dpdk.org/archives/test-report/2026-August/1029040.html
>     <http://mails.dpdk.org/archives/test-report/2026-August/1029040.html>
> 
> 
> In terms of the 'del self._lshw_net_Info' section, i added the 'if 
> self._lshw_net_Info' to check if the attribute exists before deleting, 
> as it's done in other sections of the file
> For the error checking and TG resource teardown, this is already handled 
> by DTS.

Ack.

>      > diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
>      > index c20a0fa885..b23930b953 100644
>      > --- a/dts/framework/test_run.py
>      > +++ b/dts/framework/test_run.py
>      > @@ -115,7 +115,7 @@
>      >   from framework.remote_session.dpdk import DPDKBuildEnvironment,
>     DPDKRuntimeEnvironment
>      >   from framework.settings import SETTINGS
>      >   from framework.test_result import Result, ResultNode, TestRunResult
>      > -from framework.test_suite import BaseConfig, TestCase,
>     TestCaseType, TestSuite
>      > +from framework.test_suite import BaseConfig, TestCase,
>     TestCaseType, TestSuite, TestSuiteType
>      >   from framework.testbed_model.capability import (
>      >       Capability,
>      >       get_supported_capabilities,
>      > @@ -375,11 +375,6 @@ def next(self) -> State | None:
>      >               ctx.topology.bind_cryptodevs("dpdk")
>      >
>      >           ctx.topology.configure_ports("sut", "dpdk")
>      > -        if ctx.func_tg and ctx.topology.type is not
>     LinkTopology.NO_LINK:
>      > -            ctx.func_tg.setup(ctx.topology)
>      > -        if ctx.perf_tg and ctx.topology.type is not
>     LinkTopology.NO_LINK:
>      > -            ctx.perf_tg.setup(ctx.topology)
>      > -
>      >           self.result.ports = [
>      >               port.to_dict() for port in ctx.topology.sut_ports +
>     ctx.topology.tg_ports
>      >           ]
>      > @@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):
>      >       """Test suite setup."""
>      >
>      >       logger_name: ClassVar[str] = "test_suite_setup"
>      > +    test_run: TestRun
> 
>     Unsure why this is necessary, given it's already inherited by
>     TestSuiteState.
> 
> 
> I kept it this way as it is the same style as TestRunSetup. TestRunSetup 
> inherits from State, which has a 'test_run: TestRun' attribute, but also 
> has its own test_run attribute. I will have it inherit test_run in my 
> upcoming version. as that's a better approach.

Oh odd, definitely my oversight! Looks like there was no original 
intention to have test_run in State, but then I guess I changed it 
without removing the duplications. You made a good point, thank you for 
clarifying!

> 
>      > +        if (
>      > +            ctx.topology.type is not LinkTopology.NO_LINK
>      > +            and testsuite_type is not TestSuiteType.CRYPTO
>      > +        ):
>      > +            if testsuite_type == TestSuiteType.FUNC:
>      > +                required_tg, other_tg = ctx.func_tg, ctx.perf_tg
>      > +            else:
>      > +                required_tg, other_tg = ctx.perf_tg, ctx.func_tg
>      > +
>      > +            if other_tg and other_tg.is_setup:
>      > +                other_tg.teardown()
>      > +
>      > +                if testsuite_type == TestSuiteType.FUNC and
>     ctx.tg_node:
>      > +                    for port in ctx.topology.tg_ports:
>      > +                       
>     ctx.tg_node.main_session.bind_ports_to_driver([port],
>     port.config.os_driver)
> 
>     I am a bit confused why this happens here. The driver to be bound to
>     should be governed by the TG that uses such ports. Could be os_driver,
>     could be dpdk_driver, regardless of Scapy and TRex.
> 
> This section exists because of how scapy and TRex handle port driver 
> bindings. TRex automatically binds ports to the required driver when 
> setup, but scapy requires it to be done manually. That's why if the next 
> test suite to be tested is a functional test suite, the TG ports are 
> rebound to the os_driver manually here.

So I think the original intention here was that TRex would exceptionally 
change the driver as the normal behaviour was that the TG was not going 
to be subject to driver binding. Therefore what would make sense is for 
the TG to control driver binding accordingly. So if Scapy is setup that 
it would be up to Scapy to "bind to kernel drivers" if needed. What do 
you think?
