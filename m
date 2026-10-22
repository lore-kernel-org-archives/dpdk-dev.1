Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9B606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=hE+fB8xw
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4167140264;
	Thu, 22 Oct 2026 20:39:23 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50]) by mails.dpdk.org (Postfix) with ESMTP id A28524003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 20:39:21 +0200 (CEST)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-843b6f8e2c7so58578a34.1
 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792694361; cv=none;
 d=google.com; s=arc-20260327;
 b=XPmqpzPDvGBeRrFGhynVoUPO2SsQ4scYHTY6fhfNBplA2IEiMdJmnulvrhO5yhxAtR
 KwqZdP/vhRs/Js1r9izDJEY+GyVvw3/sztLeMA0UlvsZneOz3MZOQBj7iWFzERXvM5mu
 ip0wLVd7Jj1pEludW5TC2G7movbAwzcATNv92nGsxHOX55NB64uo9tUhuzbQeSPUuFOU
 CAioYpii2Gicb9Lr/6ZSP1+etqOUXSpP4XS8/+rM5JQM9LC1JXAtnBRKI73LHzsZVOCt
 kBw7LtygbGhXSZhbJndh1hLknTQCLltqe3+xcGfxev0YO3JDLZ9n0q51LyNJqObiCs0R
 LW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oMkoG9Y0w2J/jiq1w/DWKe2lHh9DwdgkF4HMbpyFd6s=;
 fh=GK+KLbQjrrGkapJp/Fu1bxG5+qxg2M7R08gQJmt36BI=;
 b=fWdZ5qW6S7hRiuDgoHddHTOjWiy6zco/Zpp/tXkM0Pa5S2wb7/A8jqNDnpKOAh30Gc
 ZEuGibg1Y1gOyMUHs2aKLuSwxL+OH0VMsGAKyVn400yWmP8oeTycfORum+PKW2179FI6
 /HI6cl4c4+zb+3ppzztTz+vKCvdzBrI1lS5vOdWIzGKkMHng2LJ4H/yI5bAZrS1FuiXe
 ZnL/LdNSt9B7Hw6NzVf8pvZmV7XARC5JCoLDwWVjNWRyPuYArtlH0Wb7ixaKb1UQW+tk
 4i+BfAVSqLt7vFVjlVlzfYEcX/v7kXQVNa2vWUXrPtPsGk2YX/C7980YlN5JuqSjINl2
 4qKA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792694361; x=1793299161; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oMkoG9Y0w2J/jiq1w/DWKe2lHh9DwdgkF4HMbpyFd6s=;
 b=hE+fB8xwtd7l7FiWQkWAYMfezdJevZ5akJLMddW4XZQBW5P/mrhQo7p8HyKgYZdvld
 DMkJBlt5FfLoQ5k1b/mMmskqrVg1cfw52gBVdZM66bgApGNds4md0gdmrwV5HipuKjCe
 Ors9xkOx8IWoskig/wNTAYpWDD3b0Mt5L58lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792694361; x=1793299161;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oMkoG9Y0w2J/jiq1w/DWKe2lHh9DwdgkF4HMbpyFd6s=;
 b=zn6jPp6wI9qY+FGjpWHtFSI4mYUVrlWbrCxbhKbC1XP1NB3SOzukA0+JBJVDaw3yiQ
 8O53dbq/ASEwRIhlkqtGLaCEmws2gdiFk26lMo/Lq8QYrcpyXokb/3utzjP/+znFB6fJ
 vk6Eb9+33wDQddfXXe+58cJj7zt8hb9Uh8/lpmrY4B9I6/QAUnNOeqj7bVDRTDdZ+Hg7
 dvMJyC45i5q8kwrMV3xpj75LdRBID2hktS2KjbzRa0cJhdoBd8DMRsK2JGq2T9MLKNVq
 ixpaMMAeQHIEOw/LCetxUqqJGE8zdjMRmnDgqqJ5qKt+fIuA27C9QooDpApshTK+CciE
 xEDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBysO+OHoEycTpAsqYSrGvVKwga4idLBFbhh6mtjfaVgnYAGAbLTg0/Tx60wxH38zzNUpYQ=@dpdk.org
X-Gm-Message-State: AFq9FYInWWx2L2v45ZcMSkKywHLhbZTjxo3XSXRu2beqoeJzqe41Pm9h
 NA5VTjn4RXVje7JKGAF//FFG0obB7rfd9eOi9jpc7VrcSPOUCoBLkcXWZOiP4JC+Q7mYfjBUfw1
 PKx0HJoO7AYlgDl1R1CV3WvQ1tbzMP6pHVoLewUt5TA==
X-Gm-Gg: AYBFou27xdoI+lbaH+IIapxnZtOO7TDrvdR0tMUetRiNJDfpHX1bz7KlbSn0DYE6XOX
 7CjBPlOQQi5i7TyitQT+BtdLnFOwO3oeYhHTGQqyu1dC+MNv9jb00/Ocqxbw/TdQITOlHFx9q/M
 GTB8Wq4W+l2JUKSF8jRImYMi1F6pZE5cotoXh9foBgZc1/0oX7r906f+LuczOZz7dPWruwS3WPy
 0voyLg5836SMbB0i2OcdyiY79mmUXAyEhusdsF+ez4xMLfmuaU/WUjGFkl2UdThn0pukG1ZNBqY
 l7Z7tmvXF4BLMsaembxE7JJuf0nX4HHBIGnC8B1yqKYxDrWHwhnP/bWVb6J3WSRRyy+IXSuCELM
 X4LZZgtGgNkMJIJCEllc3k6p9fhmtaaVXIWWGlxIZUXpzz1RLQELDN58IfKJNQ0VKVUqplvEqTY
 yxZ7MUkzZCn7LyyrLg/H2wJMdCsyNZmkLmdmoAsxdHU6xBQb/FpkOX6H/hy9BZLacocBD3J/fJ8
 jqZK1ZUP4CQin9su/MAQEjfB/AU
X-Received: by 2002:a05:6808:6c8c:b0:4f9:bc36:fc5d with SMTP id
 5614622812f47-5535ca37366mr3802860b6e.35.1792694360723; Thu, 22 Oct 2026
 11:39:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
In-Reply-To: <20260811185509.1650102-1-knimoji@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Thu, 22 Oct 2026 14:38:44 -0400
X-Gm-Features: AclHuK_bsMOSDoGfwY1_lW_LCzB140H22xgOvCmxYwiKFmLD0r4IU201N6XI9Rw
Message-ID: <CAKYPG+yLganFe1QLnjhZ0vRH00WyJXt8y=ezqpa1tizh3o_=NQ@mail.gmail.com>
Subject: Re: [RFC PATCH] dts: resolve trex driver binding issue
To: luca.vizzarro@arm.com, patrickrobb1997@gmail.com, dev@dpdk.org
Cc: dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000008fe290065e722e29"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008fe290065e722e29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-mellanox-Performance

On Tue, Aug 11, 2026 at 2:55=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol=
.unh.edu>
wrote:

> Previously, users were unable to run both functional and performance
> test suites in a single DTS run due to driver binding conflicts.
> This patch separates traffic generator setup by test suite, in
> order to allow running functional and performance test suites in
> the same DTS run.
>
> Signed-off-by: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
> ---
>  dts/framework/test_result.py                  |  1 +
>  dts/framework/test_run.py                     | 29 +++++++++++---
>  dts/framework/test_suite.py                   | 40 +++++++++++++++++++
>  dts/framework/testbed_model/linux_session.py  |  6 ++-
>  dts/tests/TestSuite_blocklist.py              |  3 +-
>  dts/tests/TestSuite_buffer_scatter.py         |  3 +-
>  dts/tests/TestSuite_checksum_offload.py       |  3 +-
>  dts/tests/TestSuite_cryptodev_latency.py      |  3 +-
>  dts/tests/TestSuite_cryptodev_throughput.py   |  3 +-
>  dts/tests/TestSuite_dual_vlan.py              |  3 +-
>  dts/tests/TestSuite_dynamic_config.py         |  3 +-
>  dts/tests/TestSuite_dynamic_queue_conf.py     |  3 +-
>  dts/tests/TestSuite_flow_offload.py           |  3 +-
>  dts/tests/TestSuite_hello_world.py            |  3 +-
>  dts/tests/TestSuite_l2fwd.py                  |  3 +-
>  dts/tests/TestSuite_mac_filter.py             |  3 +-
>  dts/tests/TestSuite_mtu.py                    |  3 +-
>  dts/tests/TestSuite_packet_capture.py         |  3 +-
>  dts/tests/TestSuite_port_control.py           |  3 +-
>  ...stSuite_port_restart_config_persistency.py |  3 +-
>  dts/tests/TestSuite_port_stats.py             |  3 +-
>  dts/tests/TestSuite_promisc_support.py        |  3 +-
>  dts/tests/TestSuite_qinq.py                   |  3 +-
>  dts/tests/TestSuite_queue_toggle.py           |  3 +-
>  dts/tests/TestSuite_rss.py                    |  3 +-
>  dts/tests/TestSuite_rx_split.py               |  3 +-
>  dts/tests/TestSuite_rx_tx_offload.py          |  3 +-
>  .../TestSuite_single_core_forward_perf.py     |  3 +-
>  dts/tests/TestSuite_smoke_tests.py            |  3 +-
>  dts/tests/TestSuite_softnic.py                |  3 +-
>  dts/tests/TestSuite_speed_capabilities.py     |  3 +-
>  dts/tests/TestSuite_unified_packet.py         |  3 +-
>  dts/tests/TestSuite_virtio_forward.py         |  3 +-
>  dts/tests/TestSuite_vlan.py                   |  3 +-
>  34 files changed, 128 insertions(+), 38 deletions(-)
>
> diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py
> index 21faa55dc1..13ed8f671c 100644
> --- a/dts/framework/test_result.py
> +++ b/dts/framework/test_result.py
> @@ -117,6 +117,7 @@ class ResultNode(BaseModel):
>      label: str
>      children: list[Union["ResultNode", ResultLeaf]] =3D
> Field(default_factory=3Dlist)
>      parent: Union["ResultNode", None] =3D None
> +    ports: list[dict[str, str]] | None =3D None
>
>      def add_child(self, label: str) -> "ResultNode":
>          """Creates and append a child node to the model.
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index c20a0fa885..b23930b953 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -115,7 +115,7 @@
>  from framework.remote_session.dpdk import DPDKBuildEnvironment,
> DPDKRuntimeEnvironment
>  from framework.settings import SETTINGS
>  from framework.test_result import Result, ResultNode, TestRunResult
> -from framework.test_suite import BaseConfig, TestCase, TestCaseType,
> TestSuite
> +from framework.test_suite import BaseConfig, TestCase, TestCaseType,
> TestSuite, TestSuiteType
>  from framework.testbed_model.capability import (
>      Capability,
>      get_supported_capabilities,
> @@ -375,11 +375,6 @@ def next(self) -> State | None:
>              ctx.topology.bind_cryptodevs("dpdk")
>
>          ctx.topology.configure_ports("sut", "dpdk")
> -        if ctx.func_tg and ctx.topology.type is not LinkTopology.NO_LINK=
:
> -            ctx.func_tg.setup(ctx.topology)
> -        if ctx.perf_tg and ctx.topology.type is not LinkTopology.NO_LINK=
:
> -            ctx.perf_tg.setup(ctx.topology)
> -
>          self.result.ports =3D [
>              port.to_dict() for port in ctx.topology.sut_ports +
> ctx.topology.tg_ports
>          ]
> @@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):
>      """Test suite setup."""
>
>      logger_name: ClassVar[str] =3D "test_suite_setup"
> +    test_run: TestRun
>
>      def before(self) -> None:
>          """Hook before the state is processed."""
>          super().before()
>          self.logger.set_custom_log_file(self.test_suite.name)
>
> +        ctx =3D self.test_run.ctx
> +        testsuite_type =3D self.test_suite.testsuite_type
> +        if (
> +            ctx.topology.type is not LinkTopology.NO_LINK
> +            and testsuite_type is not TestSuiteType.CRYPTO
> +        ):
> +            if testsuite_type =3D=3D TestSuiteType.FUNC:
> +                required_tg, other_tg =3D ctx.func_tg, ctx.perf_tg
> +            else:
> +                required_tg, other_tg =3D ctx.perf_tg, ctx.func_tg
> +
> +            if other_tg and other_tg.is_setup:
> +                other_tg.teardown()
> +
> +                if testsuite_type =3D=3D TestSuiteType.FUNC and ctx.tg_n=
ode:
> +                    for port in ctx.topology.tg_ports:
> +
> ctx.tg_node.main_session.bind_ports_to_driver([port], port.config.os_driv=
er)
> +
> +            if required_tg and not required_tg.is_setup:
> +                required_tg.setup(ctx.topology)
> +
>      @property
>      def description(self) -> str:
>          """State description."""
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index 69ce26040a..554fe3a475 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -45,6 +45,17 @@ class BaseConfig(FrozenModel):
>      """Base for a custom test suite configuration."""
>
>
> +class TestSuiteType(Enum):
> +    """Enum to specify test suite type."""
> +
> +    FUNC =3D auto()
> +    PERF =3D auto()
> +    CRYPTO =3D auto()
> +
> +
> +TestSuiteClassType =3D TypeVar("TestSuiteClassType",
> bound=3Dtype["TestSuite"])
> +
> +
>  class TestSuite(TestProtocol):
>      """The base class with building blocks needed by most test cases.
>
> @@ -85,6 +96,30 @@ class TestSuite(TestProtocol):
>      _sut_ip_address_egress: Union[IPv4Interface, IPv6Interface]
>      _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
>      _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
> +    testsuite_type: ClassVar[TestSuiteType]
> +
> +    @classmethod
> +    def make_decorator(
> +        cls, testsuite_type: TestSuiteType
> +    ) -> Callable[[TestSuiteClassType], TestSuiteClassType]:
> +        """Creates a decorator for test suites.
> +
> +        The decorator casts the decorated function as :class:`TestSuite`=
,
> +        sets it as `testsuite_type` and initializes a variable to
> +        determine the type of test suite.
> +
> +        Args:
> +            testsuite_type: A functional, performance, or cryptodev test
> suite.
> +
> +        Returns:
> +            The decorator of a functional, performance, or cryptodev tes=
t
> suite.
> +        """
> +
> +        def _decorator(testsuite_cls: TestSuiteClassType) ->
> TestSuiteClassType:
> +            testsuite_cls.testsuite_type =3D testsuite_type
> +            return testsuite_cls
> +
> +        return _decorator
>
>      def __init__(self, config: BaseConfig) -> None:
>          """Initialize the test suite testbed information and basic
> configuration.
> @@ -270,6 +305,11 @@ def _adjust_addresses(self, packets: list[Packet],
> expected: bool =3D False) -> li
>          return ret_packets
>
>
> +#: Test suite type decorators
> +func_suite: Callable[[Any], type["TestSuite"]] =3D
> TestSuite.make_decorator(TestSuiteType.FUNC)
> +perf_suite: Callable[[Any], type["TestSuite"]] =3D
> TestSuite.make_decorator(TestSuiteType.PERF)
> +crypto_suite: Callable[[Any], type["TestSuite"]] =3D
> TestSuite.make_decorator(TestSuiteType.CRYPTO)
> +
>  #: The generic type for a method of an instance of TestSuite
>  TestSuiteMethodType =3D TypeVar("TestSuiteMethodType",
> bound=3DCallable[[TestSuite], None])
>
> diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> index c118f803b6..861b09e413 100644
> --- a/dts/framework/testbed_model/linux_session.py
> +++ b/dts/framework/testbed_model/linux_session.py
> @@ -278,7 +278,8 @@ def bind_ports_to_driver(self, ports: list[Port],
> driver_name: str) -> None:
>              verify=3DTrue,
>          )
>
> -        del self._lshw_net_info
> +        if self._lshw_net_info:
> +            del self._lshw_net_info
>
>      def bring_up_link(self, ports: Iterable[Port]) -> None:
>          """Overrides :meth:`~.os_session.OSSession.bring_up_link`."""
> @@ -287,7 +288,8 @@ def bring_up_link(self, ports: Iterable[Port]) -> Non=
e:
>                  f"ip link set dev {port.logical_name} up",
> privileged=3DTrue, verify=3DTrue
>              )
>
> -        del self._lshw_net_info
> +        if self._lshw_net_info:
> +            del self._lshw_net_info
>
>      def set_interface_link_up(self, name: str) -> None:
>          """Overrides
> :meth:`~.os_session.OSSession.set_interface_link_up`."""
> diff --git a/dts/tests/TestSuite_blocklist.py
> b/dts/tests/TestSuite_blocklist.py
> index c57231de22..46c5ff57cb 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -12,10 +12,11 @@
>  )
>  from api.test import verify
>  from api.testpmd import TestPmd
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>  from framework.testbed_model.port import Port
>
>
> +@func_suite
>  class TestBlocklist(TestSuite):
>      """DPDK device blocklisting test suite."""
>
> diff --git a/dts/tests/TestSuite_buffer_scatter.py
> b/dts/tests/TestSuite_buffer_scatter.py
> index 539082f2e4..b9064e8022 100644
> --- a/dts/tests/TestSuite_buffer_scatter.py
> +++ b/dts/tests/TestSuite_buffer_scatter.py
> @@ -30,11 +30,12 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)
> +@func_suite
>  class TestBufferScatter(TestSuite):
>      """DPDK PMD packet scattering test suite.
>
> diff --git a/dts/tests/TestSuite_checksum_offload.py
> b/dts/tests/TestSuite_checksum_offload.py
> index 90ca798e56..2a9d4ef631 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -28,12 +28,13 @@
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
> +@func_suite
>  class TestChecksumOffload(TestSuite):
>      """Checksum offload test suite.
>
> diff --git a/dts/tests/TestSuite_cryptodev_latency.py
> b/dts/tests/TestSuite_cryptodev_latency.py
> index 4e7d814faa..e63c43a12b 100644
> --- a/dts/tests/TestSuite_cryptodev_latency.py
> +++ b/dts/tests/TestSuite_cryptodev_latency.py
> @@ -31,7 +31,7 @@
>  )
>  from api.test import skip, verify
>  from framework.context import get_ctx
> -from framework.test_suite import BaseConfig, TestSuite, crypto_test
> +from framework.test_suite import BaseConfig, TestSuite, crypto_suite,
> crypto_test
>  from framework.testbed_model.virtual_device import VirtualDevice
>
>  config_list: list[dict[str, int | float | str]] =3D [
> @@ -73,6 +73,7 @@ class Config(BaseConfig):
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
> +@crypto_suite
>  class TestCryptodevLatency(TestSuite):
>      """DPDK Crypto Device Testing Suite."""
>
> diff --git a/dts/tests/TestSuite_cryptodev_throughput.py
> b/dts/tests/TestSuite_cryptodev_throughput.py
> index 2fc0d8779a..93727d90d4 100644
> --- a/dts/tests/TestSuite_cryptodev_throughput.py
> +++ b/dts/tests/TestSuite_cryptodev_throughput.py
> @@ -32,7 +32,7 @@
>  from api.test import verify
>  from framework.context import get_ctx
>  from framework.exception import SkippedTestException
> -from framework.test_suite import BaseConfig, TestSuite, crypto_test
> +from framework.test_suite import BaseConfig, TestSuite, crypto_suite,
> crypto_test
>  from framework.testbed_model.virtual_device import VirtualDevice
>
>  config_list: list[dict[str, int | float | str]] =3D [
> @@ -75,6 +75,7 @@ class Config(BaseConfig):
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
> +@crypto_suite
>  class TestCryptodevThroughput(TestSuite):
>      """DPDK Crypto Device Testing Suite."""
>
> diff --git a/dts/tests/TestSuite_dual_vlan.py
> b/dts/tests/TestSuite_dual_vlan.py
> index 1b77dd2b47..8676a65c80 100644
> --- a/dts/tests/TestSuite_dual_vlan.py
> +++ b/dts/tests/TestSuite_dual_vlan.py
> @@ -23,9 +23,10 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
> +@func_suite
>  class TestDualVlan(TestSuite):
>      """DPDK Dual VLAN test suite.
>
> diff --git a/dts/tests/TestSuite_dynamic_config.py
> b/dts/tests/TestSuite_dynamic_config.py
> index 7204ec4f73..94554a735e 100644
> --- a/dts/tests/TestSuite_dynamic_config.py
> +++ b/dts/tests/TestSuite_dynamic_config.py
> @@ -29,11 +29,12 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestDynamicConfig(TestSuite):
>      """Dynamic config suite.
>
> diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py
> b/dts/tests/TestSuite_dynamic_queue_conf.py
> index 5ac85bee7d..c92edc7306 100644
> --- a/dts/tests/TestSuite_dynamic_queue_conf.py
> +++ b/dts/tests/TestSuite_dynamic_queue_conf.py
> @@ -40,7 +40,7 @@
>  from api.testpmd import TestPmd
>  from api.testpmd.config import PortTopology, SimpleForwardingModes
>  from framework.exception import InteractiveCommandExecutionError
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  def setup_and_teardown_test(
> @@ -121,6 +121,7 @@ def _wrap(self: "TestDynamicQueueConf", is_rx_testing=
:
> bool) -> None:
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestDynamicQueueConf(TestSuite):
>      """DPDK dynamic queue configuration test suite.
>
> diff --git a/dts/tests/TestSuite_flow_offload.py
> b/dts/tests/TestSuite_flow_offload.py
> index be11d09875..d955eb7d7d 100644
> --- a/dts/tests/TestSuite_flow_offload.py
> +++ b/dts/tests/TestSuite_flow_offload.py
> @@ -30,7 +30,7 @@
>      SkippedTestException,
>      TestCaseVerifyError,
>  )
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @dataclass
> @@ -402,6 +402,7 @@ def generate(
>
>
>  @requires_nic_capability(NicCapability.FLOW_CTRL)
> +@func_suite
>  class TestFlowOffload(TestSuite):
>      """Flow offload test suite.
>
> diff --git a/dts/tests/TestSuite_hello_world.py
> b/dts/tests/TestSuite_hello_world.py
> index bf1a93c782..0beb144644 100644
> --- a/dts/tests/TestSuite_hello_world.py
> +++ b/dts/tests/TestSuite_hello_world.py
> @@ -10,7 +10,7 @@
>
>  from api.test import log
>  from api.testpmd import TestPmd
> -from framework.test_suite import BaseConfig, TestSuite, func_test
> +from framework.test_suite import BaseConfig, TestSuite, func_suite,
> func_test
>
>
>  class Config(BaseConfig):
> @@ -20,6 +20,7 @@ class Config(BaseConfig):
>      msg: str =3D "Hello World!"
>
>
> +@func_suite
>  class TestHelloWorld(TestSuite):
>      """Hello World test suite. One test case, which starts and stops a
> testpmd session."""
>
> diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py
> index 596b892730..3f9f1dd12d 100644
> --- a/dts/tests/TestSuite_l2fwd.py
> +++ b/dts/tests/TestSuite_l2fwd.py
> @@ -21,13 +21,14 @@
>  from api.testpmd import TestPmd
>  from api.testpmd.config import EthPeer, SimpleForwardingModes
>  from framework.context import filter_cores
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>  from framework.testbed_model.cpu import LogicalCoreCount
>  from framework.utils import generate_random_packets
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestL2fwd(TestSuite):
>      """L2 forwarding test suite."""
>
> diff --git a/dts/tests/TestSuite_mac_filter.py
> b/dts/tests/TestSuite_mac_filter.py
> index a7e24b37d5..def0b97856 100644
> --- a/dts/tests/TestSuite_mac_filter.py
> +++ b/dts/tests/TestSuite_mac_filter.py
> @@ -27,10 +27,11 @@
>  from api.test import fail, verify
>  from api.testpmd import TestPmd
>  from framework.exception import InteractiveCommandExecutionError
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestMacFilter(TestSuite):
>      """Mac address allowlist filtering test suite.
>
> diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
> index 8355495d33..06de6c9c1a 100644
> --- a/dts/tests/TestSuite_mtu.py
> +++ b/dts/tests/TestSuite_mtu.py
> @@ -24,7 +24,7 @@
>  from api.packet import send_packet_and_capture
>  from api.test import verify
>  from api.testpmd import TestPmd
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>  STANDARD_FRAME =3D 1518  # --max-pkt-len will subtract l2 information at=
 a
> minimum of 18 bytes.
>  JUMBO_FRAME =3D 9018
> @@ -37,6 +37,7 @@
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestMtu(TestSuite):
>      """DPDK PMD jumbo frames and MTU update test suite.
>
> diff --git a/dts/tests/TestSuite_packet_capture.py
> b/dts/tests/TestSuite_packet_capture.py
> index 4bd15e2401..f26b03f46f 100644
> --- a/dts/tests/TestSuite_packet_capture.py
> +++ b/dts/tests/TestSuite_packet_capture.py
> @@ -40,7 +40,7 @@
>  from framework.params import Params
>  from framework.remote_session.blocking_app import BlockingApp
>  from framework.remote_session.dpdk_shell import compute_eal_params
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>  from framework.testbed_model.cpu import LogicalCoreList
>  from
> framework.testbed_model.traffic_generator.capturing_traffic_generator
> import (
>      PacketFilteringConfig,
> @@ -67,6 +67,7 @@ class DumpcapParams(Params):
>
>
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestPacketCapture(TestSuite):
>      """Packet Capture TestSuite.
>
> diff --git a/dts/tests/TestSuite_port_control.py
> b/dts/tests/TestSuite_port_control.py
> index b51fdc2959..858ab3af8b 100644
> --- a/dts/tests/TestSuite_port_control.py
> +++ b/dts/tests/TestSuite_port_control.py
> @@ -20,10 +20,11 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestPortControl(TestSuite):
>      """DPDK Port Control Testing Suite."""
>
> diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py
> b/dts/tests/TestSuite_port_restart_config_persistency.py
> index 4ea22b6d70..646e80651b 100644
> --- a/dts/tests/TestSuite_port_restart_config_persistency.py
> +++ b/dts/tests/TestSuite_port_restart_config_persistency.py
> @@ -16,13 +16,14 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.types import TestPmdPortFlowCtrl
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>  ALTERNATIVE_MTU: int =3D 800
>  STANDARD_MTU: int =3D 1500
>  ALTERNATIVE_MAC_ADDRESS: str =3D "42:A6:B7:9E:B4:81"
>
>
> +@func_suite
>  class TestPortRestartConfigPersistency(TestSuite):
>      """Port config persistency test suite."""
>
> diff --git a/dts/tests/TestSuite_port_stats.py
> b/dts/tests/TestSuite_port_stats.py
> index 3dc045f847..a737c17fb0 100644
> --- a/dts/tests/TestSuite_port_stats.py
> +++ b/dts/tests/TestSuite_port_stats.py
> @@ -28,11 +28,12 @@
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestPortStats(TestSuite):
>      """DPDK Port statistics testing suite.
>
> diff --git a/dts/tests/TestSuite_promisc_support.py
> b/dts/tests/TestSuite_promisc_support.py
> index a0c65dc662..1907e779f8 100644
> --- a/dts/tests/TestSuite_promisc_support.py
> +++ b/dts/tests/TestSuite_promisc_support.py
> @@ -22,10 +22,11 @@
>  )
>  from api.test import verify
>  from api.testpmd import TestPmd
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestPromiscSupport(TestSuite):
>      """Promiscuous mode support test suite."""
>
> diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
> index 505d71dbc8..8fa4db2ab6 100644
> --- a/dts/tests/TestSuite_qinq.py
> +++ b/dts/tests/TestSuite_qinq.py
> @@ -19,9 +19,10 @@
>  from api.packet import send_packet_and_capture
>  from api.test import log, verify
>  from api.testpmd import TestPmd
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
> +@func_suite
>  class TestQinq(TestSuite):
>      """QinQ test suite.
>
> diff --git a/dts/tests/TestSuite_queue_toggle.py
> b/dts/tests/TestSuite_queue_toggle.py
> index e4edc89123..97e80965d8 100644
> --- a/dts/tests/TestSuite_queue_toggle.py
> +++ b/dts/tests/TestSuite_queue_toggle.py
> @@ -26,12 +26,13 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_link_topology(LinkTopology.TWO_LINKS)
>  @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
>  @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
> +@func_suite
>  class TestQueueToggle(TestSuite):
>      """DPDK Queue start/stop test suite.
>
> diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
> index 2747c8a36c..062b2d8891 100644
> --- a/dts/tests/TestSuite_rss.py
> +++ b/dts/tests/TestSuite_rss.py
> @@ -30,7 +30,7 @@
>      TestPmdVerbosePacket,
>  )
>  from framework.exception import InteractiveCommandExecutionError
> -from framework.test_suite import BaseConfig, TestSuite, func_test
> +from framework.test_suite import BaseConfig, TestSuite, func_suite,
> func_test
>  from framework.utils import StrEnum
>
>
> @@ -55,6 +55,7 @@ class HashAlgorithm(StrEnum):
>
>  @requires_link_topology(LinkTopology.ONE_LINK)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)
> +@func_suite
>  class TestRss(TestSuite):
>      """RSS test suite."""
>
> diff --git a/dts/tests/TestSuite_rx_split.py
> b/dts/tests/TestSuite_rx_split.py
> index 5117a569e2..8b9cf38095 100644
> --- a/dts/tests/TestSuite_rx_split.py
> +++ b/dts/tests/TestSuite_rx_split.py
> @@ -24,7 +24,7 @@
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
>  from framework.exception import InteractiveCommandExecutionError
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>  PAYLOAD =3D bytes(range(256))
>  ETHER_HDR_LEN =3D len(Ether(dst=3D"00:00:00:00:00:00"))
> @@ -35,6 +35,7 @@
>
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT)
>  @requires_nic_capability(NicCapability.SELECTIVE_RX)
> +@func_suite
>  class TestRxSplit(TestSuite):
>      """Rx split test suite.
>
> diff --git a/dts/tests/TestSuite_rx_tx_offload.py
> b/dts/tests/TestSuite_rx_tx_offload.py
> index b0da627d3c..4a4607c685 100644
> --- a/dts/tests/TestSuite_rx_tx_offload.py
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -18,10 +18,11 @@
>      OffloadConfiguration,
>      RxTxLiteralSwitch,
>  )
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_link_topology(LinkTopology.ONE_LINK)
> +@func_suite
>  class TestRxTxOffload(TestSuite):
>      """RX/TX offload test suite."""
>
> diff --git a/dts/tests/TestSuite_single_core_forward_perf.py
> b/dts/tests/TestSuite_single_core_forward_perf.py
> index 57aecdf7a4..f30a5322a0 100644
> --- a/dts/tests/TestSuite_single_core_forward_perf.py
> +++ b/dts/tests/TestSuite_single_core_forward_perf.py
> @@ -25,7 +25,7 @@
>  from api.testpmd import TestPmd
>  from api.testpmd.config import RXRingParams, TXRingParams
>  from framework.params.types import TestPmdParamsDict
> -from framework.test_suite import BaseConfig, TestSuite, perf_test
> +from framework.test_suite import BaseConfig, TestSuite, perf_suite,
> perf_test
>
>
>  class Config(BaseConfig):
> @@ -42,6 +42,7 @@ class Config(BaseConfig):
>      delta_tolerance: float =3D 0.05
>
>
> +@perf_suite
>  @requires_link_topology(LinkTopology.TWO_LINKS)
>  class TestSingleCoreForwardPerf(TestSuite):
>      """Single core forwarding performance test suite."""
> diff --git a/dts/tests/TestSuite_smoke_tests.py
> b/dts/tests/TestSuite_smoke_tests.py
> index 271ad4301c..368614e7ed 100644
> --- a/dts/tests/TestSuite_smoke_tests.py
> +++ b/dts/tests/TestSuite_smoke_tests.py
> @@ -22,12 +22,13 @@
>  from api.testpmd import TestPmd
>  from framework.config.node import PortConfig
>  from framework.settings import SETTINGS
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>  from framework.testbed_model.linux_session import LinuxSession
>  from framework.utils import REGEX_FOR_PCI_ADDRESS
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
> +@func_suite
>  class TestSmokeTests(TestSuite):
>      """DPDK and infrastructure smoke test suite.
>
> diff --git a/dts/tests/TestSuite_softnic.py
> b/dts/tests/TestSuite_softnic.py
> index fa91f7ee2f..07da406a2d 100644
> --- a/dts/tests/TestSuite_softnic.py
> +++ b/dts/tests/TestSuite_softnic.py
> @@ -20,13 +20,14 @@
>  )
>  from api.testpmd import TestPmd
>  from api.testpmd.config import EthPeer
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>  from framework.testbed_model.virtual_device import VirtualDevice
>  from framework.utils import generate_random_packets
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestSoftnic(TestSuite):
>      """Softnic test suite."""
>
> diff --git a/dts/tests/TestSuite_speed_capabilities.py
> b/dts/tests/TestSuite_speed_capabilities.py
> index 9cbd6f1ef7..5fbe1fe5c3 100644
> --- a/dts/tests/TestSuite_speed_capabilities.py
> +++ b/dts/tests/TestSuite_speed_capabilities.py
> @@ -14,7 +14,7 @@
>  )
>  from api.test import verify
>  from api.testpmd import TestPmd
> -from framework.test_suite import BaseConfig, TestSuite, func_test
> +from framework.test_suite import BaseConfig, TestSuite, func_suite,
> func_test
>
>
>  class Config(BaseConfig):
> @@ -39,6 +39,7 @@ class Config(BaseConfig):
>
>
>  @requires_link_topology(LinkTopology.ONE_LINK)
> +@func_suite
>  class TestSpeedCapabilities(TestSuite):
>      """Speed capabilities test suite."""
>
> diff --git a/dts/tests/TestSuite_unified_packet.py
> b/dts/tests/TestSuite_unified_packet.py
> index fcc7f7fbbb..05f52d5690 100644
> --- a/dts/tests/TestSuite_unified_packet.py
> +++ b/dts/tests/TestSuite_unified_packet.py
> @@ -28,9 +28,10 @@
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
> +@func_suite
>  class TestUnifiedPacket(TestSuite):
>      """DPDK Unified packet test suite.
>
> diff --git a/dts/tests/TestSuite_virtio_forward.py
> b/dts/tests/TestSuite_virtio_forward.py
> index 6efaa4e156..c2a4a4612e 100644
> --- a/dts/tests/TestSuite_virtio_forward.py
> +++ b/dts/tests/TestSuite_virtio_forward.py
> @@ -14,12 +14,13 @@
>  from api.test import log, verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import PortTopology, SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>  from framework.testbed_model.capability import requires
>  from framework.testbed_model.linux_session import LinuxSession
>  from framework.testbed_model.virtual_device import VirtualDevice
>
>
> +@func_suite
>  class TestVirtioForward(TestSuite):
>      """Virtio forwarding test suite."""
>
> diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
> index 898673fc86..14011da087 100644
> --- a/dts/tests/TestSuite_vlan.py
> +++ b/dts/tests/TestSuite_vlan.py
> @@ -25,10 +25,11 @@
>  from api.test import verify
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
> -from framework.test_suite import TestSuite, func_test
> +from framework.test_suite import TestSuite, func_suite, func_test
>
>
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
> +@func_suite
>  class TestVlan(TestSuite):
>      """DPDK VLAN test suite.
>
> --
> 2.55.0
>
>

--0000000000008fe290065e722e29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request: iol-mellanox-Performance</div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Aug 11, 2026 at 2:55=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a =
href=3D"mailto:knimoji@iol.unh.edu">knimoji@iol.unh.edu</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Previously, users we=
re unable to run both functional and performance<br>
test suites in a single DTS run due to driver binding conflicts.<br>
This patch separates traffic generator setup by test suite, in<br>
order to allow running functional and performance test suites in<br>
the same DTS run.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/test_result.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 +++++++++++---<br>
=C2=A0dts/framework/test_suite.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 40 +++++++++++++++++++<br>
=C2=A0dts/framework/testbed_model/linux_session.py=C2=A0 |=C2=A0 6 ++-<br>
=C2=A0dts/tests/TestSuite_blocklist.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_buffer_scatter.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_checksum_offload.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_cryptodev_latency.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
3 +-<br>
=C2=A0dts/tests/TestSuite_cryptodev_throughput.py=C2=A0 =C2=A0|=C2=A0 3 +-<=
br>
=C2=A0dts/tests/TestSuite_dual_vlan.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_dynamic_config.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_dynamic_queue_conf.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0dts/tests/TestSuite_flow_offload.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_hello_world.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_l2fwd.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_mac_filter.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_mtu.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_packet_capture.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_port_control.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 3 +-<br>
=C2=A0...stSuite_port_restart_config_persistency.py |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_port_stats.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_promisc_support.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_qinq.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_queue_toggle.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_rss.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_rx_split.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_rx_tx_offload.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 +-<br>
=C2=A0.../TestSuite_single_core_forward_perf.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0dts/tests/TestSuite_smoke_tests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_softnic.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_speed_capabilities.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
3 +-<br>
=C2=A0dts/tests/TestSuite_unified_packet.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_virtio_forward.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +-<br>
=C2=A0dts/tests/TestSuite_vlan.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
=C2=A034 files changed, 128 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/dts/framework/test_result.py b/dts/framework/test_result.py<br=
>
index 21faa55dc1..13ed8f671c 100644<br>
--- a/dts/framework/test_result.py<br>
+++ b/dts/framework/test_result.py<br>
@@ -117,6 +117,7 @@ class ResultNode(BaseModel):<br>
=C2=A0 =C2=A0 =C2=A0label: str<br>
=C2=A0 =C2=A0 =C2=A0children: list[Union[&quot;ResultNode&quot;, ResultLeaf=
]] =3D Field(default_factory=3Dlist)<br>
=C2=A0 =C2=A0 =C2=A0parent: Union[&quot;ResultNode&quot;, None] =3D None<br=
>
+=C2=A0 =C2=A0 ports: list[dict[str, str]] | None =3D None<br>
<br>
=C2=A0 =C2=A0 =C2=A0def add_child(self, label: str) -&gt; &quot;ResultNode&=
quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Creates and append a ch=
ild node to the model.<br>
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index c20a0fa885..b23930b953 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -115,7 +115,7 @@<br>
=C2=A0from framework.remote_session.dpdk import DPDKBuildEnvironment, DPDKR=
untimeEnvironment<br>
=C2=A0from framework.settings import SETTINGS<br>
=C2=A0from framework.test_result import Result, ResultNode, TestRunResult<b=
r>
-from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestS=
uite<br>
+from framework.test_suite import BaseConfig, TestCase, TestCaseType, TestS=
uite, TestSuiteType<br>
=C2=A0from framework.testbed_model.capability import (<br>
=C2=A0 =C2=A0 =C2=A0Capability,<br>
=C2=A0 =C2=A0 =C2=A0get_supported_capabilities,<br>
@@ -375,11 +375,6 @@ def next(self) -&gt; State | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx.topology.bind_cryptodev=
s(&quot;dpdk&quot;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx.topology.configure_ports(&quot;sut&qu=
ot;, &quot;dpdk&quot;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.func_tg and ctx.topology.type is not Li=
nkTopology.NO_LINK:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.func_tg.setup(ctx.topology)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ctx.perf_tg and ctx.topology.type is not Li=
nkTopology.NO_LINK:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.perf_tg.setup(ctx.topology)<=
br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.result.ports =3D [<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port.to_dict() for port in =
ctx.topology.sut_ports + ctx.topology.tg_ports<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
@@ -506,12 +501,34 @@ class TestSuiteSetup(TestSuiteState):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Test suite setup.&quot;&quot;&quot;<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0logger_name: ClassVar[str] =3D &quot;test_suite_setup&q=
uot;<br>
+=C2=A0 =C2=A0 test_run: TestRun<br>
<br>
=C2=A0 =C2=A0 =C2=A0def before(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Hook before the state i=
s processed.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().before()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger.set_custom_log_file(<a href=
=3D"http://self.test_suite.name" rel=3D"noreferrer" target=3D"_blank">self.=
test_suite.name</a>)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D self.test_run.ctx<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testsuite_type =3D self.test_suite.testsuite_t=
ype<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.topology.type is not LinkTop=
ology.NO_LINK<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and testsuite_type is not TestSu=
iteType.CRYPTO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testsuite_type =3D=3D TestSui=
teType.FUNC:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg, other=
_tg =3D ctx.func_tg, ctx.perf_tg<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg, other=
_tg =3D ctx.perf_tg, ctx.func_tg<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if other_tg and other_tg.is_setu=
p:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 other_tg.teardown(=
)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if testsuite_type =
=3D=3D TestSuiteType.FUNC and ctx.tg_node:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
port in ctx.topology.tg_ports:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ctx.tg_node.main_session.bind_ports_to_driver([port], port.confi=
g.os_driver)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if required_tg and not required_=
tg.is_setup:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg.setup(=
ctx.topology)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def description(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;State description.&quot=
;&quot;&quot;<br>
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py<br>
index 69ce26040a..554fe3a475 100644<br>
--- a/dts/framework/test_suite.py<br>
+++ b/dts/framework/test_suite.py<br>
@@ -45,6 +45,17 @@ class BaseConfig(FrozenModel):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Base for a custom test suite configur=
ation.&quot;&quot;&quot;<br>
<br>
<br>
+class TestSuiteType(Enum):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Enum to specify test suite type.&quot;&quo=
t;&quot;<br>
+<br>
+=C2=A0 =C2=A0 FUNC =3D auto()<br>
+=C2=A0 =C2=A0 PERF =3D auto()<br>
+=C2=A0 =C2=A0 CRYPTO =3D auto()<br>
+<br>
+<br>
+TestSuiteClassType =3D TypeVar(&quot;TestSuiteClassType&quot;, bound=3Dtyp=
e[&quot;TestSuite&quot;])<br>
+<br>
+<br>
=C2=A0class TestSuite(TestProtocol):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;The base class with building blocks n=
eeded by most test cases.<br>
<br>
@@ -85,6 +96,30 @@ class TestSuite(TestProtocol):<br>
=C2=A0 =C2=A0 =C2=A0_sut_ip_address_egress: Union[IPv4Interface, IPv6Interf=
ace]<br>
=C2=A0 =C2=A0 =C2=A0_tg_ip_address_ingress: Union[IPv4Interface, IPv6Interf=
ace]<br>
=C2=A0 =C2=A0 =C2=A0_tg_ip_address_egress: Union[IPv4Interface, IPv6Interfa=
ce]<br>
+=C2=A0 =C2=A0 testsuite_type: ClassVar[TestSuiteType]<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_decorator(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cls, testsuite_type: TestSuiteType<br>
+=C2=A0 =C2=A0 ) -&gt; Callable[[TestSuiteClassType], TestSuiteClassType]:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Creates a decorator for test=
 suites.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The decorator casts the decorated function as =
:class:`TestSuite`,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sets it as `testsuite_type` and initializes a =
variable to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 determine the type of test suite.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testsuite_type: A functional, pe=
rformance, or cryptodev test suite.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The decorator of a functional, p=
erformance, or cryptodev test suite.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _decorator(testsuite_cls: TestSuiteClassTy=
pe) -&gt; TestSuiteClassType:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testsuite_cls.testsuite_type =3D=
 testsuite_type<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return testsuite_cls<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return _decorator<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, config: BaseConfig) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the test sui=
te testbed information and basic configuration.<br>
@@ -270,6 +305,11 @@ def _adjust_addresses(self, packets: list[Packet], exp=
ected: bool =3D False) -&gt; li<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret_packets<br>
<br>
<br>
+#: Test suite type decorators<br>
+func_suite: Callable[[Any], type[&quot;TestSuite&quot;]] =3D TestSuite.mak=
e_decorator(TestSuiteType.FUNC)<br>
+perf_suite: Callable[[Any], type[&quot;TestSuite&quot;]] =3D TestSuite.mak=
e_decorator(TestSuiteType.PERF)<br>
+crypto_suite: Callable[[Any], type[&quot;TestSuite&quot;]] =3D TestSuite.m=
ake_decorator(TestSuiteType.CRYPTO)<br>
+<br>
=C2=A0#: The generic type for a method of an instance of TestSuite<br>
=C2=A0TestSuiteMethodType =3D TypeVar(&quot;TestSuiteMethodType&quot;, boun=
d=3DCallable[[TestSuite], None])<br>
<br>
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/t=
estbed_model/linux_session.py<br>
index c118f803b6..861b09e413 100644<br>
--- a/dts/framework/testbed_model/linux_session.py<br>
+++ b/dts/framework/testbed_model/linux_session.py<br>
@@ -278,7 +278,8 @@ def bind_ports_to_driver(self, ports: list[Port], drive=
r_name: str) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verify=3DTrue,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 del self._lshw_net_info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._lshw_net_info:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 del self._lshw_net_info<br>
<br>
=C2=A0 =C2=A0 =C2=A0def bring_up_link(self, ports: Iterable[Port]) -&gt; No=
ne:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~.os_s=
ession.OSSession.bring_up_link`.&quot;&quot;&quot;<br>
@@ -287,7 +288,8 @@ def bring_up_link(self, ports: Iterable[Port]) -&gt; No=
ne:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f&quot;ip lin=
k set dev {port.logical_name} up&quot;, privileged=3DTrue, verify=3DTrue<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 del self._lshw_net_info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._lshw_net_info:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 del self._lshw_net_info<br>
<br>
=C2=A0 =C2=A0 =C2=A0def set_interface_link_up(self, name: str) -&gt; None:<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Overrides :meth:`~.os_s=
ession.OSSession.set_interface_link_up`.&quot;&quot;&quot;<br>
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blockli=
st.py<br>
index c57231de22..46c5ff57cb 100644<br>
--- a/dts/tests/TestSuite_blocklist.py<br>
+++ b/dts/tests/TestSuite_blocklist.py<br>
@@ -12,10 +12,11 @@<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from framework.testbed_model.port import Port<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestBlocklist(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK device blocklisting test suite.&=
quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_buffer_scatter.py b/dts/tests/TestSuite_bu=
ffer_scatter.py<br>
index 539082f2e4..b9064e8022 100644<br>
--- a/dts/tests/TestSuite_buffer_scatter.py<br>
+++ b/dts/tests/TestSuite_buffer_scatter.py<br>
@@ -30,11 +30,12 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_SCATTER)<br>
+@func_suite<br>
=C2=A0class TestBufferScatter(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK PMD packet scattering test suite=
.<br>
<br>
diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuite_=
checksum_offload.py<br>
index 90ca798e56..2a9d4ef631 100644<br>
--- a/dts/tests/TestSuite_checksum_offload.py<br>
+++ b/dts/tests/TestSuite_checksum_offload.py<br>
@@ -28,12 +28,13 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFl=
ag<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)<br=
>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)<br>
+@func_suite<br>
=C2=A0class TestChecksumOffload(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Checksum offload test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_cryptodev_latency.py b/dts/tests/TestSuite=
_cryptodev_latency.py<br>
index 4e7d814faa..e63c43a12b 100644<br>
--- a/dts/tests/TestSuite_cryptodev_latency.py<br>
+++ b/dts/tests/TestSuite_cryptodev_latency.py<br>
@@ -31,7 +31,7 @@<br>
=C2=A0)<br>
=C2=A0from api.test import skip, verify<br>
=C2=A0from framework.context import get_ctx<br>
-from framework.test_suite import BaseConfig, TestSuite, crypto_test<br>
+from framework.test_suite import BaseConfig, TestSuite, crypto_suite, cryp=
to_test<br>
=C2=A0from framework.testbed_model.virtual_device import VirtualDevice<br>
<br>
=C2=A0config_list: list[dict[str, int | float | str]] =3D [<br>
@@ -73,6 +73,7 @@ class Config(BaseConfig):<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.NO_LINK)<br>
+@crypto_suite<br>
=C2=A0class TestCryptodevLatency(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Crypto Device Testing Suite.&quo=
t;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_cryptodev_throughput.py b/dts/tests/TestSu=
ite_cryptodev_throughput.py<br>
index 2fc0d8779a..93727d90d4 100644<br>
--- a/dts/tests/TestSuite_cryptodev_throughput.py<br>
+++ b/dts/tests/TestSuite_cryptodev_throughput.py<br>
@@ -32,7 +32,7 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from framework.context import get_ctx<br>
=C2=A0from framework.exception import SkippedTestException<br>
-from framework.test_suite import BaseConfig, TestSuite, crypto_test<br>
+from framework.test_suite import BaseConfig, TestSuite, crypto_suite, cryp=
to_test<br>
=C2=A0from framework.testbed_model.virtual_device import VirtualDevice<br>
<br>
=C2=A0config_list: list[dict[str, int | float | str]] =3D [<br>
@@ -75,6 +75,7 @@ class Config(BaseConfig):<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.NO_LINK)<br>
+@crypto_suite<br>
=C2=A0class TestCryptodevThroughput(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Crypto Device Testing Suite.&quo=
t;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_dual_vlan.py b/dts/tests/TestSuite_dual_vl=
an.py<br>
index 1b77dd2b47..8676a65c80 100644<br>
--- a/dts/tests/TestSuite_dual_vlan.py<br>
+++ b/dts/tests/TestSuite_dual_vlan.py<br>
@@ -23,9 +23,10 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestDualVlan(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Dual VLAN test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dy=
namic_config.py<br>
index 7204ec4f73..94554a735e 100644<br>
--- a/dts/tests/TestSuite_dynamic_config.py<br>
+++ b/dts/tests/TestSuite_dynamic_config.py<br>
@@ -29,11 +29,12 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+@func_suite<br>
=C2=A0class TestDynamicConfig(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Dynamic config suite.<br>
<br>
diff --git a/dts/tests/TestSuite_dynamic_queue_conf.py b/dts/tests/TestSuit=
e_dynamic_queue_conf.py<br>
index 5ac85bee7d..c92edc7306 100644<br>
--- a/dts/tests/TestSuite_dynamic_queue_conf.py<br>
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py<br>
@@ -40,7 +40,7 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import PortTopology, SimpleForwardingModes<br=
>
=C2=A0from framework.exception import InteractiveCommandExecutionError<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0def setup_and_teardown_test(<br>
@@ -121,6 +121,7 @@ def _wrap(self: &quot;TestDynamicQueueConf&quot;, is_rx=
_testing: bool) -&gt; None:<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestDynamicQueueConf(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK dynamic queue configuration test=
 suite.<br>
<br>
diff --git a/dts/tests/TestSuite_flow_offload.py b/dts/tests/TestSuite_flow=
_offload.py<br>
index be11d09875..d955eb7d7d 100644<br>
--- a/dts/tests/TestSuite_flow_offload.py<br>
+++ b/dts/tests/TestSuite_flow_offload.py<br>
@@ -30,7 +30,7 @@<br>
=C2=A0 =C2=A0 =C2=A0SkippedTestException,<br>
=C2=A0 =C2=A0 =C2=A0TestCaseVerifyError,<br>
=C2=A0)<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@dataclass<br>
@@ -402,6 +402,7 @@ def generate(<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.FLOW_CTRL)<br>
+@func_suite<br>
=C2=A0class TestFlowOffload(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Flow offload test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_hello_world.py b/dts/tests/TestSuite_hello=
_world.py<br>
index bf1a93c782..0beb144644 100644<br>
--- a/dts/tests/TestSuite_hello_world.py<br>
+++ b/dts/tests/TestSuite_hello_world.py<br>
@@ -10,7 +10,7 @@<br>
<br>
=C2=A0from api.test import log<br>
=C2=A0from api.testpmd import TestPmd<br>
-from framework.test_suite import BaseConfig, TestSuite, func_test<br>
+from framework.test_suite import BaseConfig, TestSuite, func_suite, func_t=
est<br>
<br>
<br>
=C2=A0class Config(BaseConfig):<br>
@@ -20,6 +20,7 @@ class Config(BaseConfig):<br>
=C2=A0 =C2=A0 =C2=A0msg: str =3D &quot;Hello World!&quot;<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestHelloWorld(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Hello World test suite. One test case=
, which starts and stops a testpmd session.&quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_l2fwd.py b/dts/tests/TestSuite_l2fwd.py<br=
>
index 596b892730..3f9f1dd12d 100644<br>
--- a/dts/tests/TestSuite_l2fwd.py<br>
+++ b/dts/tests/TestSuite_l2fwd.py<br>
@@ -21,13 +21,14 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import EthPeer, SimpleForwardingModes<br>
=C2=A0from framework.context import filter_cores<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from framework.testbed_model.cpu import LogicalCoreCount<br>
=C2=A0from framework.utils import generate_random_packets<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+@func_suite<br>
=C2=A0class TestL2fwd(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;L2 forwarding test suite.&quot;&quot;=
&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_mac_filter.py b/dts/tests/TestSuite_mac_fi=
lter.py<br>
index a7e24b37d5..def0b97856 100644<br>
--- a/dts/tests/TestSuite_mac_filter.py<br>
+++ b/dts/tests/TestSuite_mac_filter.py<br>
@@ -27,10 +27,11 @@<br>
=C2=A0from api.test import fail, verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from framework.exception import InteractiveCommandExecutionError<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestMacFilter(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Mac address allowlist filtering test =
suite.<br>
<br>
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py<br>
index 8355495d33..06de6c9c1a 100644<br>
--- a/dts/tests/TestSuite_mtu.py<br>
+++ b/dts/tests/TestSuite_mtu.py<br>
@@ -24,7 +24,7 @@<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
=C2=A0STANDARD_FRAME =3D 1518=C2=A0 # --max-pkt-len will subtract l2 inform=
ation at a minimum of 18 bytes.<br>
=C2=A0JUMBO_FRAME =3D 9018<br>
@@ -37,6 +37,7 @@<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestMtu(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK PMD jumbo frames and MTU update =
test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_packet_capture.py b/dts/tests/TestSuite_pa=
cket_capture.py<br>
index 4bd15e2401..f26b03f46f 100644<br>
--- a/dts/tests/TestSuite_packet_capture.py<br>
+++ b/dts/tests/TestSuite_packet_capture.py<br>
@@ -40,7 +40,7 @@<br>
=C2=A0from framework.params import Params<br>
=C2=A0from framework.remote_session.blocking_app import BlockingApp<br>
=C2=A0from framework.remote_session.dpdk_shell import compute_eal_params<br=
>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from framework.testbed_model.cpu import LogicalCoreList<br>
=C2=A0from framework.testbed_model.traffic_generator.capturing_traffic_gene=
rator import (<br>
=C2=A0 =C2=A0 =C2=A0PacketFilteringConfig,<br>
@@ -67,6 +67,7 @@ class DumpcapParams(Params):<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+@func_suite<br>
=C2=A0class TestPacketCapture(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Packet Capture TestSuite.<br>
<br>
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port=
_control.py<br>
index b51fdc2959..858ab3af8b 100644<br>
--- a/dts/tests/TestSuite_port_control.py<br>
+++ b/dts/tests/TestSuite_port_control.py<br>
@@ -20,10 +20,11 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestPortControl(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Port Control Testing Suite.&quot=
;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py b/dts/t=
ests/TestSuite_port_restart_config_persistency.py<br>
index 4ea22b6d70..646e80651b 100644<br>
--- a/dts/tests/TestSuite_port_restart_config_persistency.py<br>
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py<br>
@@ -16,13 +16,14 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.types import TestPmdPortFlowCtrl<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
=C2=A0ALTERNATIVE_MTU: int =3D 800<br>
=C2=A0STANDARD_MTU: int =3D 1500<br>
=C2=A0ALTERNATIVE_MAC_ADDRESS: str =3D &quot;42:A6:B7:9E:B4:81&quot;<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestPortRestartConfigPersistency(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Port config persistency test suite.&q=
uot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_port_stats.py b/dts/tests/TestSuite_port_s=
tats.py<br>
index 3dc045f847..a737c17fb0 100644<br>
--- a/dts/tests/TestSuite_port_stats.py<br>
+++ b/dts/tests/TestSuite_port_stats.py<br>
@@ -28,11 +28,12 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import RtePTypes, TestPmdVerbosePacket<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+@func_suite<br>
=C2=A0class TestPortStats(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Port statistics testing suite.<b=
r>
<br>
diff --git a/dts/tests/TestSuite_promisc_support.py b/dts/tests/TestSuite_p=
romisc_support.py<br>
index a0c65dc662..1907e779f8 100644<br>
--- a/dts/tests/TestSuite_promisc_support.py<br>
+++ b/dts/tests/TestSuite_promisc_support.py<br>
@@ -22,10 +22,11 @@<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestPromiscSupport(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Promiscuous mode support test suite.&=
quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py<br>
index 505d71dbc8..8fa4db2ab6 100644<br>
--- a/dts/tests/TestSuite_qinq.py<br>
+++ b/dts/tests/TestSuite_qinq.py<br>
@@ -19,9 +19,10 @@<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import log, verify<br>
=C2=A0from api.testpmd import TestPmd<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestQinq(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;QinQ test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_queue_toggle.py b/dts/tests/TestSuite_queu=
e_toggle.py<br>
index e4edc89123..97e80965d8 100644<br>
--- a/dts/tests/TestSuite_queue_toggle.py<br>
+++ b/dts/tests/TestSuite_queue_toggle.py<br>
@@ -26,12 +26,13 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
=C2=A0@requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)<br>
=C2=A0@requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)<br>
+@func_suite<br>
=C2=A0class TestQueueToggle(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Queue start/stop test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py<br>
index 2747c8a36c..062b2d8891 100644<br>
--- a/dts/tests/TestSuite_rss.py<br>
+++ b/dts/tests/TestSuite_rss.py<br>
@@ -30,7 +30,7 @@<br>
=C2=A0 =C2=A0 =C2=A0TestPmdVerbosePacket,<br>
=C2=A0)<br>
=C2=A0from framework.exception import InteractiveCommandExecutionError<br>
-from framework.test_suite import BaseConfig, TestSuite, func_test<br>
+from framework.test_suite import BaseConfig, TestSuite, func_suite, func_t=
est<br>
=C2=A0from framework.utils import StrEnum<br>
<br>
<br>
@@ -55,6 +55,7 @@ class HashAlgorithm(StrEnum):<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.ONE_LINK)<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_RSS_HASH)<br>
+@func_suite<br>
=C2=A0class TestRss(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;RSS test suite.&quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_rx_split.py b/dts/tests/TestSuite_rx_split=
.py<br>
index 5117a569e2..8b9cf38095 100644<br>
--- a/dts/tests/TestSuite_rx_split.py<br>
+++ b/dts/tests/TestSuite_rx_split.py<br>
@@ -24,7 +24,7 @@<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import RxOffloadCapability, TxOffloadCapabilit=
y<br>
=C2=A0from framework.exception import InteractiveCommandExecutionError<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
=C2=A0PAYLOAD =3D bytes(range(256))<br>
=C2=A0ETHER_HDR_LEN =3D len(Ether(dst=3D&quot;00:00:00:00:00:00&quot;))<br>
@@ -35,6 +35,7 @@<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_BUFFER_SPLIT)<=
br>
=C2=A0@requires_nic_capability(NicCapability.SELECTIVE_RX)<br>
+@func_suite<br>
=C2=A0class TestRxSplit(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Rx split test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_=
tx_offload.py<br>
index b0da627d3c..4a4607c685 100644<br>
--- a/dts/tests/TestSuite_rx_tx_offload.py<br>
+++ b/dts/tests/TestSuite_rx_tx_offload.py<br>
@@ -18,10 +18,11 @@<br>
=C2=A0 =C2=A0 =C2=A0OffloadConfiguration,<br>
=C2=A0 =C2=A0 =C2=A0RxTxLiteralSwitch,<br>
=C2=A0)<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.ONE_LINK)<br>
+@func_suite<br>
=C2=A0class TestRxTxOffload(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;RX/TX offload test suite.&quot;&quot;=
&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_single_core_forward_perf.py b/dts/tests/Te=
stSuite_single_core_forward_perf.py<br>
index 57aecdf7a4..f30a5322a0 100644<br>
--- a/dts/tests/TestSuite_single_core_forward_perf.py<br>
+++ b/dts/tests/TestSuite_single_core_forward_perf.py<br>
@@ -25,7 +25,7 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import RXRingParams, TXRingParams<br>
=C2=A0from framework.params.types import TestPmdParamsDict<br>
-from framework.test_suite import BaseConfig, TestSuite, perf_test<br>
+from framework.test_suite import BaseConfig, TestSuite, perf_suite, perf_t=
est<br>
<br>
<br>
=C2=A0class Config(BaseConfig):<br>
@@ -42,6 +42,7 @@ class Config(BaseConfig):<br>
=C2=A0 =C2=A0 =C2=A0delta_tolerance: float =3D 0.05<br>
<br>
<br>
+@perf_suite<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
=C2=A0class TestSingleCoreForwardPerf(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Single core forwarding performance te=
st suite.&quot;&quot;&quot;<br>
diff --git a/dts/tests/TestSuite_smoke_tests.py b/dts/tests/TestSuite_smoke=
_tests.py<br>
index 271ad4301c..368614e7ed 100644<br>
--- a/dts/tests/TestSuite_smoke_tests.py<br>
+++ b/dts/tests/TestSuite_smoke_tests.py<br>
@@ -22,12 +22,13 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from framework.config.node import PortConfig<br>
=C2=A0from framework.settings import SETTINGS<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from framework.testbed_model.linux_session import LinuxSession<br>
=C2=A0from framework.utils import REGEX_FOR_PCI_ADDRESS<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.NO_LINK)<br>
+@func_suite<br>
=C2=A0class TestSmokeTests(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK and infrastructure smoke test su=
ite.<br>
<br>
diff --git a/dts/tests/TestSuite_softnic.py b/dts/tests/TestSuite_softnic.p=
y<br>
index fa91f7ee2f..07da406a2d 100644<br>
--- a/dts/tests/TestSuite_softnic.py<br>
+++ b/dts/tests/TestSuite_softnic.py<br>
@@ -20,13 +20,14 @@<br>
=C2=A0)<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import EthPeer<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from framework.testbed_model.virtual_device import VirtualDevice<br>
=C2=A0from framework.utils import generate_random_packets<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+@func_suite<br>
=C2=A0class TestSoftnic(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Softnic test suite.&quot;&quot;&quot;=
<br>
<br>
diff --git a/dts/tests/TestSuite_speed_capabilities.py b/dts/tests/TestSuit=
e_speed_capabilities.py<br>
index 9cbd6f1ef7..5fbe1fe5c3 100644<br>
--- a/dts/tests/TestSuite_speed_capabilities.py<br>
+++ b/dts/tests/TestSuite_speed_capabilities.py<br>
@@ -14,7 +14,7 @@<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
-from framework.test_suite import BaseConfig, TestSuite, func_test<br>
+from framework.test_suite import BaseConfig, TestSuite, func_suite, func_t=
est<br>
<br>
<br>
=C2=A0class Config(BaseConfig):<br>
@@ -39,6 +39,7 @@ class Config(BaseConfig):<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.ONE_LINK)<br>
+@func_suite<br>
=C2=A0class TestSpeedCapabilities(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Speed capabilities test suite.&quot;&=
quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_unified_packet.py b/dts/tests/TestSuite_un=
ified_packet.py<br>
index fcc7f7fbbb..05f52d5690 100644<br>
--- a/dts/tests/TestSuite_unified_packet.py<br>
+++ b/dts/tests/TestSuite_unified_packet.py<br>
@@ -28,9 +28,10 @@<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import RtePTypes, TestPmdVerbosePacket<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestUnifiedPacket(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Unified packet test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_vi=
rtio_forward.py<br>
index 6efaa4e156..c2a4a4612e 100644<br>
--- a/dts/tests/TestSuite_virtio_forward.py<br>
+++ b/dts/tests/TestSuite_virtio_forward.py<br>
@@ -14,12 +14,13 @@<br>
=C2=A0from api.test import log, verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import PortTopology, SimpleForwardingModes<br=
>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from framework.testbed_model.capability import requires<br>
=C2=A0from framework.testbed_model.linux_session import LinuxSession<br>
=C2=A0from framework.testbed_model.virtual_device import VirtualDevice<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestVirtioForward(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Virtio forwarding test suite.&quot;&q=
uot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py<br>
index 898673fc86..14011da087 100644<br>
--- a/dts/tests/TestSuite_vlan.py<br>
+++ b/dts/tests/TestSuite_vlan.py<br>
@@ -25,10 +25,11 @@<br>
=C2=A0from api.test import verify<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
-from framework.test_suite import TestSuite, func_test<br>
+from framework.test_suite import TestSuite, func_suite, func_test<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)<b=
r>
+@func_suite<br>
=C2=A0class TestVlan(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK VLAN test suite.<br>
<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div>

--0000000000008fe290065e722e29--
