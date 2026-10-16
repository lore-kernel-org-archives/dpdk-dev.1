Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C60CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 16:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 301A3402E7;
	Fri, 16 Oct 2026 18:28:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id E7CE94026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 18:28:07 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D620E1477;
 Fri, 16 Oct 2026 09:28:03 -0700 (PDT)
Received: from [10.57.14.7] (unknown [10.57.14.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F1653F7B4;
 Fri, 16 Oct 2026 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792168087; bh=+EIRDRWfqljbN8UdsYeMdQ7bSvP/PeIbUFzlMjX5qfs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kOUp9X38MCFYx1544ugtlxbPD/VBla+yGl2AWcYCdxHWKL7C4tHYho1t/8qOf3/Ia
 XBN3EaDlqeJpQQAbP3jaiWE3ahLCRIUL2+oxDpBZS7hc89SPqVC9pNynom1BIHmsGx
 J9oT7dAyoocwcP4NG3g3rH4RjrSBSSy8zcm7nlCQ=
Message-ID: <8811b276-3f46-484a-bffa-33accfe740b1@arm.com>
Date: Fri, 16 Oct 2026 17:28:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dts: resolve trex driver binding issue
Content-Language: en-GB
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>, patrickrobb1997@gmail.com,
 dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <20260811185509.1650102-1-knimoji@iol.unh.edu>
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

Hi Koushik,

Apologies for the long wait. To start off, could you please address the 
AI Code Review as it raised a few concerns:

http://mails.dpdk.org/archives/test-report/2026-August/1029040.html

The patch will also require rebasing.

On 11/08/2026 19:55, Koushik Bhargav Nimoji wrote:
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index 21faa55dc1..13ed8f671c 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -117,6 +117,7 @@ class ResultNode(BaseModel):
>       label: str
>       children: list[Union["ResultNode", ResultLeaf]] = Field(default_factory=list)
>       parent: Union["ResultNode", None] = None
> +    ports: list[dict[str, str]] | None = None

This attribute lacks the appropriate documentation. Also unless I missed 
something, I am not sure how this belongs to this patch. Can you please 
clarify?

>   
>       def add_child(self, label: str) -> "ResultNode":
>           """Creates and append a child node to the model.
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index c20a0fa885..b23930b953 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -115,7 +115,7 @@
>   from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKRuntimeEnvironment
>   from framework.settings import SETTINGS
>   from framework.test_result import Result, ResultNode, TestRunResult
> -from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
> +from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite, TestSuiteType
>   from framework.testbed_model.capability import (
>       Capability,
>       get_supported_capabilities,
> @@ -375,11 +375,6 @@ def next(self) -> State | None:
>               ctx.topology.bind_cryptodevs("dpdk")
>   
>           ctx.topology.configure_ports("sut", "dpdk")
> -        if ctx.func_tg and ctx.topology.type is not LinkTopology.NO_LINK:
> -            ctx.func_tg.setup(ctx.topology)
> -        if ctx.perf_tg and ctx.topology.type is not LinkTopology.NO_LINK:
> -            ctx.perf_tg.setup(ctx.topology)
> -
>           self.result.ports = [
>               port.to_dict() for port in ctx.topology.sut_ports + ctx.topology.tg_ports
>           ]
> @@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):
>       """Test suite setup."""
>   
>       logger_name: ClassVar[str] = "test_suite_setup"
> +    test_run: TestRun

Unsure why this is necessary, given it's already inherited by 
TestSuiteState.

>   
>       def before(self) -> None:
>           """Hook before the state is processed."""
>           super().before()
>           self.logger.set_custom_log_file(self.test_suite.name)
>   
> +        ctx = self.test_run.ctx
> +        testsuite_type = self.test_suite.testsuite_type

nit: stick to the snake case, so test_suite_type

> +        if (
> +            ctx.topology.type is not LinkTopology.NO_LINK
> +            and testsuite_type is not TestSuiteType.CRYPTO
> +        ):
> +            if testsuite_type == TestSuiteType.FUNC:
> +                required_tg, other_tg = ctx.func_tg, ctx.perf_tg
> +            else:
> +                required_tg, other_tg = ctx.perf_tg, ctx.func_tg
> +
> +            if other_tg and other_tg.is_setup:
> +                other_tg.teardown()
> +
> +                if testsuite_type == TestSuiteType.FUNC and ctx.tg_node:
> +                    for port in ctx.topology.tg_ports:
> +                        ctx.tg_node.main_session.bind_ports_to_driver([port], port.config.os_driver)

I am a bit confused why this happens here. The driver to be bound to 
should be governed by the TG that uses such ports. Could be os_driver, 
could be dpdk_driver, regardless of Scapy and TRex.

> +
> +            if required_tg and not required_tg.is_setup:
> +                required_tg.setup(ctx.topology)
> +
>       @property
>       def description(self) -> str:
>           """State description."""
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index 69ce26040a..554fe3a475 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -45,6 +45,17 @@ class BaseConfig(FrozenModel):
>       """Base for a custom test suite configuration."""
>   
>   
> +class TestSuiteType(Enum):
> +    """Enum to specify test suite type."""
> +
> +    FUNC = auto()
> +    PERF = auto()
> +    CRYPTO = auto()
> +
> +
> +TestSuiteClassType = TypeVar("TestSuiteClassType", bound=type["TestSuite"])
> +
> +
>   class TestSuite(TestProtocol):
>       """The base class with building blocks needed by most test cases.
>   
> @@ -85,6 +96,30 @@ class TestSuite(TestProtocol):
>       _sut_ip_address_egress: Union[IPv4Interface, IPv6Interface]
>       _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
>       _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
> +    testsuite_type: ClassVar[TestSuiteType]
nit: snake_case
> +
> +    @classmethod
> +    def make_decorator(
> +        cls, testsuite_type: TestSuiteType
nit: snake_case
> +    ) -> Callable[[TestSuiteClassType], TestSuiteClassType]:
> +        """Creates a decorator for test suites.
> +
> +        The decorator casts the decorated function as :class:`TestSuite`,
> +        sets it as `testsuite_type` and initializes a variable to
> +        determine the type of test suite.
> +
> +        Args:
> +            testsuite_type: A functional, performance, or cryptodev test suite.
nit: snake_case
> +
> +        Returns:
> +            The decorator of a functional, performance, or cryptodev test suite.
> +        """
> +
> +        def _decorator(testsuite_cls: TestSuiteClassType) -> TestSuiteClassType:
> +            testsuite_cls.testsuite_type = testsuite_type
> +            return testsuite_cls
nit: snake_case
> +
> +        return _decorator

So the above function doesn't really use cls, making it a @static_method 
instead of a @class_method. Given static_method is discouraged, it 
ultimately means that this method should rather be a module-level 
function. But I do understand that we'd also prefer to have consistency 
and this is already done for TestCase. So I am ok with either.

>   
>       def __init__(self, config: BaseConfig) -> None:
>           """Initialize the test suite testbed information and basic configuration.
> @@ -270,6 +305,11 @@ def _adjust_addresses(self, packets: list[Packet], expected: bool = False) -> li
>           return ret_packets
>   
>   
> +#: Test suite type decorators
> +func_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.FUNC)
> +perf_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.PERF)
> +crypto_suite: Callable[[Any], type["TestSuite"]] = TestSuite.make_decorator(TestSuiteType.CRYPTO)
> +
>   #: The generic type for a method of an instance of TestSuite
>   TestSuiteMethodType = TypeVar("TestSuiteMethodType", bound=Callable[[TestSuite], None])
>   
Many thanks,
Luca
