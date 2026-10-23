Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A85606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=aUWWWXCz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D82C402B0;
	Sat, 24 Oct 2026 00:57:02 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3FD664021F
 for <dev@dpdk.org>; Sat, 24 Oct 2026 00:57:00 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-53639b8903bso16321501cf.0
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792796219; cv=none;
 d=google.com; s=arc-20260327;
 b=enRJ4S9qOrbCosZ9HgRVzl748WVuogadKivP+9mLbkQXwL/EoPK6tVl3GI2dJs4abr
 AdoVqA6gRA/RX2cRu/KHKlNQtCJlR+o4qWQubPQM9hrTi7gMEo5/xX8Ut0/TN0C2Mu0h
 Gob3Ms263m2GDHyQFWxR4fbhaC27xqIxFPo6B8lBqSCFvps1OiRl6dTt2lKSjj+YvCEr
 zfGwnj9JF9vynx25yT6QP2gSBxanGA81Sxvaf9UpyyzsadaNOIHHrl/vG2+ZTY0DjfJU
 V3wm7czy5V2IHI+avg8WbxEgOR07swW4VLdQM4TMBA1RK9MX3NMgabnqiPotns32tDUP
 MM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h/c0LY3BccCRZpJxoyjjuc2FQw34tnh8dWyAuTej3+g=;
 fh=EmSO+mASZJEB//NBChCw3BP04Ji/8HfIQSEuMxOsXfQ=;
 b=J5FHQHM3RVNbN7AWqxiVu7FWh+XE8klOMpFeh8BRzWHt0FxSSpgT/oiLLh7b7sufIC
 CH2IU/qD0ol67/xg0W9WE4YnChPAp5NXxFfbZe0c0wDHxhObFP9QnEUlVdLrUc6K8g9j
 2ygopwHrwKJlVzp1c1w3KVfzalu8pM+QC68oRIWtGPagvSVjVhjPUBwSnq2u66b44lLH
 e9CZz2jdncuMDCk1hqE+Ika2775VpR7TDaTu6x+qpuFBndgMSzeCLHiSdMyCAiNDCz2/
 S1noUAQTKY0yomYnXGTwja3tJoRtSzg7rR7vSLjyzrkU6YE93mvyZ+tbzw7UqEpaZipl
 TscQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792796219; x=1793401019; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h/c0LY3BccCRZpJxoyjjuc2FQw34tnh8dWyAuTej3+g=;
 b=aUWWWXCzVsBMuakx7HHR7v/11EH8rKdCGUnmQy542B7vYWdHymOzc8XXLj6CRauTjg
 MiW7+88peS5+BIud2UMA2039SAdVSI/bx3TO2WWea7b/BQsJpsMVEeugJbRDcFVZlnni
 srS55T+/BVj24BM1V+qaPXW65v7HtXZbS1Fd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792796219; x=1793401019;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h/c0LY3BccCRZpJxoyjjuc2FQw34tnh8dWyAuTej3+g=;
 b=YC7jfy6d/kbqvtAuUDHR7aUBCCrnYhgb/JfqvutNEht3663mTzt/VGBm0iGrkai4c0
 v7iNRlL/5EJ2qFjoB11VwE0o7US24NgYeLwWHxee60sW84MUZGHSa2vj9kFU8OGyaYoM
 A1J9c18cxkEpp1fcg29g+e8krOnXlQBzx9vPaXUnMrabIJRH74WUr/UE+x3qqqClEJ3m
 nYtCsw0LSVutZy7zfLh0UVjK/henKjY2p/LsZF4YxEmdxoUpQbCSkXZ2oUEy1FI/o4VV
 iekUje+62+x4oXTJf48+pxlef+G4Zj/WB2nmn7XKtD5ax43rOGU4miR3PiwGzwyjWzEu
 Gjow==
X-Gm-Message-State: AFq9FYLJ2om4HJLEliNtAlT4Fh0vmQSZJWB1bHFOoo3jfjJDWgC2Hn6r
 pSgWbPFOJ0ZbAzZH2TLfIbgUi8UcvVRM70dojT04szfdFxFGKdjVZZ3qO3XFn4vuauuvYS8DfjF
 v1s5PO4v2ULlXVIXdMTlponloBE+OvNaKk1hKmTiV8w==
X-Gm-Gg: AYBFou3/k9stnW6m1gy8U/XEBZY/L11HD3dFGd33Zd5fvgsYdnvAg+8eIe4XS3wJNVJ
 KncaiLsEH80bdWOZFoWSb1uNBY8FcaJQZBB1bDxtw3KUw5QCVKF5uhPKNkX/C7PX6+Yr/qZFN+/
 aDejKNG4nk8mce/TGTQ1JzzWwIFYkXTxPE6QHTzJWS8/8bfwhynS4Nrj4NbUB3WHGPnBTVZkObQ
 Em9n2zyweuJBKMaEtMWBY0nnbYhYrwxQpWBg/q4YFVAyE0wQAVrdQMZXEf/TlaKiPd0StWxjiSl
 fRmCvzAef3WrVXrKJKAK+WssNLUDnC8vRT282mZenLR29GGm7ks7w8NdkdCeNe5kISfhBiTL0RE
 IjDNQmAiadwblrNU21TnUfiU+vg19EhBcQ6k9HBYvO/Dc1fLLv1Ea3szHoZecpNPstDhAWObYxr
 nczLurw+kjWPUL3LmLbubNvtGL6CZsiMCmH6YN2eIeO99758Vz15M2vVqKyPGR88zRIwE=
X-Received: by 2002:a05:622a:4e86:b0:535:1b18:211 with SMTP id
 d75a77b69052e-5383ba9da68mr3964981cf.19.1792796219332; Fri, 23 Oct 2026
 15:56:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260811185509.1650102-1-knimoji@iol.unh.edu>
 <20261023210415.28323-1-knimoji@iol.unh.edu>
In-Reply-To: <20261023210415.28323-1-knimoji@iol.unh.edu>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Fri, 23 Oct 2026 18:56:23 -0400
X-Gm-Features: AclHuK9vYcCjA8KNlr9A_r-ideDWZgBB_Ssj2K5fqC57JG_6A6rLB6ZRFJTKcs4
Message-ID: <CAKYPG+zGiXfbb5TzwwSQfErXcHhvDyk-zyza4YBCMP45LzFEmQ@mail.gmail.com>
Subject: Re: [PATCH v3] dts: resolve trex driver binding issue
To: luca.vizzarro@arm.com, patrickrobb1997@gmail.com
Cc: dev@dpdk.org, dladd@iol.unh.edu, abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000ceed42065e89e56c"
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

--000000000000ceed42065e89e56c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Recheck-request: iol-unit-arm64-testing

On Fri, Oct 23, 2026 at 5:04=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol=
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
> v2:
>      *Added TRex TG teardown to re-bind ports
>       to kernel driver
> v3:
>      *Added topology-based port binding upon
>       TRex setup to preserve internal port
>       config state, removed all manual bindings
> ---
>  dts/api/test_suite.py                         | 40 +++++++++++++++++++
>  dts/framework/test_run.py                     | 24 ++++++++---
>  dts/framework/testbed_model/linux_session.py  |  6 ++-
>  .../testbed_model/traffic_generator/trex.py   |  1 +
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
>  34 files changed, 123 insertions(+), 38 deletions(-)
>
> diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py
> index c30d447135..11027344d0 100644
> --- a/dts/api/test_suite.py
> +++ b/dts/api/test_suite.py
> @@ -44,6 +44,17 @@ class BaseConfig(FrozenModel):
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
> @@ -84,6 +95,30 @@ class TestSuite(TestProtocol):
>      _sut_ip_address_egress: Union[IPv4Interface, IPv6Interface]
>      _tg_ip_address_ingress: Union[IPv4Interface, IPv6Interface]
>      _tg_ip_address_egress: Union[IPv4Interface, IPv6Interface]
> +    test_suite_type: ClassVar[TestSuiteType]
> +
> +    @classmethod
> +    def make_decorator(
> +        cls, test_suite_type: TestSuiteType
> +    ) -> Callable[[TestSuiteClassType], TestSuiteClassType]:
> +        """Creates a decorator for test suites.
> +
> +        The decorator casts the decorated function as :class:`TestSuite`=
,
> +        sets it as `testsuite_type` and initializes a variable to
> +        determine the type of test suite.
> +
> +        Args:
> +            test_suite_type: A functional, performance, or cryptodev tes=
t
> suite.
> +
> +        Returns:
> +            The decorator of a functional, performance, or cryptodev tes=
t
> suite.
> +        """
> +
> +        def _decorator(test_suite_cls: TestSuiteClassType) ->
> TestSuiteClassType:
> +            test_suite_cls.test_suite_type =3D test_suite_type
> +            return test_suite_cls
> +
> +        return _decorator
>
>      def __init__(self, config: BaseConfig) -> None:
>          """Initialize the test suite testbed information and basic
> configuration.
> @@ -269,6 +304,11 @@ def _adjust_addresses(self, packets: list[Packet],
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
> diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
> index 210ff25af7..3890606512 100644
> --- a/dts/framework/test_run.py
> +++ b/dts/framework/test_run.py
> @@ -110,7 +110,7 @@
>  from api.capabilities import LinkTopology
>  from api.context import Context, init_ctx
>  from api.exception import InternalError, SkippedTestException,
> TestCaseVerifyError
> -from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite
> +from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite=
,
> TestSuiteType
>  from api.testbed_model.capability import (
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
> @@ -512,6 +507,23 @@ def before(self) -> None:
>          super().before()
>          self.logger.set_custom_log_file(self.test_suite.name)
>
> +        ctx =3D self.test_run.ctx
> +        test_suite_type =3D self.test_suite.test_suite_type
> +        if (
> +            ctx.topology.type is not LinkTopology.NO_LINK
> +            and test_suite_type is not TestSuiteType.CRYPTO
> +        ):
> +            if test_suite_type =3D=3D TestSuiteType.FUNC:
> +                required_tg, other_tg =3D ctx.func_tg, ctx.perf_tg
> +            else:
> +                required_tg, other_tg =3D ctx.perf_tg, ctx.func_tg
> +
> +            if other_tg and other_tg.is_setup:
> +                other_tg.teardown()
> +
> +            if required_tg and not required_tg.is_setup:
> +                required_tg.setup(ctx.topology)
> +
>      @property
>      def description(self) -> str:
>          """State description."""
> diff --git a/dts/framework/testbed_model/linux_session.py
> b/dts/framework/testbed_model/linux_session.py
> index 8cc0d09d01..fe3f1a8fc3 100644
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
> diff --git a/dts/framework/testbed_model/traffic_generator/trex.py
> b/dts/framework/testbed_model/traffic_generator/trex.py
> index 7ce1d40d79..055c22e121 100644
> --- a/dts/framework/testbed_model/traffic_generator/trex.py
> +++ b/dts/framework/testbed_model/traffic_generator/trex.py
> @@ -110,6 +110,7 @@ def __init__(self, tg_node: Node, config:
> TrexTrafficGeneratorConfig) -> None:
>      def setup(self, topology: Topology):
>          """Initialize and start a TRex server process."""
>          super().setup(topology)
> +        topology.configure_ports("tg", "dpdk")
>          self._topology =3D topology
>
>          self._shell =3D PythonShell(self._tg_node, "TRex-client",
> privileged=3DTrue)
> diff --git a/dts/tests/TestSuite_blocklist.py
> b/dts/tests/TestSuite_blocklist.py
> index 31e69c0de9..e32f31b383 100644
> --- a/dts/tests/TestSuite_blocklist.py
> +++ b/dts/tests/TestSuite_blocklist.py
> @@ -11,11 +11,12 @@
>      requires_link_topology,
>  )
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testbed_model.port import Port
>  from api.testpmd import TestPmd
>
>
> +@func_suite
>  class TestBlocklist(TestSuite):
>      """DPDK device blocklisting test suite."""
>
> diff --git a/dts/tests/TestSuite_buffer_scatter.py
> b/dts/tests/TestSuite_buffer_scatter.py
> index cd1a52ad5e..adc8e41700 100644
> --- a/dts/tests/TestSuite_buffer_scatter.py
> +++ b/dts/tests/TestSuite_buffer_scatter.py
> @@ -28,13 +28,14 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
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
> index a2ea13991b..8c16706f1b 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -25,7 +25,7 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFlag
> @@ -34,6 +34,7 @@
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_IPV4_CKSUM)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_UDP_CKSUM)
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_TCP_CKSUM)
> +@func_suite
>  class TestChecksumOffload(TestSuite):
>      """Checksum offload test suite.
>
> diff --git a/dts/tests/TestSuite_cryptodev_latency.py
> b/dts/tests/TestSuite_cryptodev_latency.py
> index 444a5b282c..bf3b9b5761 100644
> --- a/dts/tests/TestSuite_cryptodev_latency.py
> +++ b/dts/tests/TestSuite_cryptodev_latency.py
> @@ -31,7 +31,7 @@
>      CryptodevResults,
>  )
>  from api.test import skip, verify
> -from api.test_suite import BaseConfig, TestSuite, crypto_test
> +from api.test_suite import BaseConfig, TestSuite, crypto_suite,
> crypto_test
>  from api.testbed_model.virtual_device import VirtualDevice
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
> index 59f64f2cd7..7a364a1dc4 100644
> --- a/dts/tests/TestSuite_cryptodev_throughput.py
> +++ b/dts/tests/TestSuite_cryptodev_throughput.py
> @@ -31,7 +31,7 @@
>      CryptodevResults,
>  )
>  from api.test import skip, verify
> -from api.test_suite import BaseConfig, TestSuite, crypto_test
> +from api.test_suite import BaseConfig, TestSuite, crypto_suite,
> crypto_test
>  from api.testbed_model.virtual_device import VirtualDevice
>
>  config_list: list[dict[str, int | float | str]] =3D [
> @@ -74,6 +74,7 @@ class Config(BaseConfig):
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
> +@crypto_suite
>  class TestCryptodevThroughput(TestSuite):
>      """DPDK Crypto Device Testing Suite."""
>
> diff --git a/dts/tests/TestSuite_dual_vlan.py
> b/dts/tests/TestSuite_dual_vlan.py
> index f3347a6d52..6038899c5c 100644
> --- a/dts/tests/TestSuite_dual_vlan.py
> +++ b/dts/tests/TestSuite_dual_vlan.py
> @@ -21,11 +21,12 @@
>  from api.capabilities import LinkTopology, requires_link_topology
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>
>
> +@func_suite
>  class TestDualVlan(TestSuite):
>      """DPDK Dual VLAN test suite.
>
> diff --git a/dts/tests/TestSuite_dynamic_config.py
> b/dts/tests/TestSuite_dynamic_config.py
> index b9e2c30da1..e071e63a6d 100644
> --- a/dts/tests/TestSuite_dynamic_config.py
> +++ b/dts/tests/TestSuite_dynamic_config.py
> @@ -27,13 +27,14 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
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
> index 24584c7d60..bc11d1ce1f 100644
> --- a/dts/tests/TestSuite_dynamic_queue_conf.py
> +++ b/dts/tests/TestSuite_dynamic_queue_conf.py
> @@ -38,7 +38,7 @@
>  from api.exception import InteractiveCommandExecutionError
>  from api.packet import send_packets
>  from api.test import fail, verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import PortTopology, SimpleForwardingModes
>
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
> index 09384b1983..624ff93b17 100644
> --- a/dts/tests/TestSuite_flow_offload.py
> +++ b/dts/tests/TestSuite_flow_offload.py
> @@ -28,7 +28,7 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import fail, log, verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.types import FlowRule
>
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
> index cd62eb8f3e..9bc555aa08 100644
> --- a/dts/tests/TestSuite_hello_world.py
> +++ b/dts/tests/TestSuite_hello_world.py
> @@ -9,7 +9,7 @@
>  """
>
>  from api.test import log
> -from api.test_suite import BaseConfig, TestSuite, func_test
> +from api.test_suite import BaseConfig, TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>
>
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
> index f237821a04..b987efbebf 100644
> --- a/dts/tests/TestSuite_l2fwd.py
> +++ b/dts/tests/TestSuite_l2fwd.py
> @@ -19,7 +19,7 @@
>      match_all_packets,
>      send_packets_and_capture,
>  )
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testbed_model.cpu import LogicalCoreCount
>  from api.testpmd import TestPmd
>  from api.testpmd.config import EthPeer, SimpleForwardingModes
> @@ -28,6 +28,7 @@
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestL2fwd(TestSuite):
>      """L2 forwarding test suite."""
>
> diff --git a/dts/tests/TestSuite_mac_filter.py
> b/dts/tests/TestSuite_mac_filter.py
> index eb1413f336..f244203593 100644
> --- a/dts/tests/TestSuite_mac_filter.py
> +++ b/dts/tests/TestSuite_mac_filter.py
> @@ -26,11 +26,12 @@
>  from api.exception import InteractiveCommandExecutionError
>  from api.packet import send_packet_and_capture
>  from api.test import fail, verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestMacFilter(TestSuite):
>      """Mac address allowlist filtering test suite.
>
> diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py
> index c264db299e..f834be1818 100644
> --- a/dts/tests/TestSuite_mtu.py
> +++ b/dts/tests/TestSuite_mtu.py
> @@ -23,7 +23,7 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>
>  STANDARD_FRAME =3D 1518  # --max-pkt-len will subtract l2 information at=
 a
> minimum of 18 bytes.
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
> index 07bfabb30b..f319d99ede 100644
> --- a/dts/tests/TestSuite_packet_capture.py
> +++ b/dts/tests/TestSuite_packet_capture.py
> @@ -37,7 +37,7 @@
>  )
>  from api.params import Params
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testbed_model.cpu import LogicalCoreList
>  from api.testbed_model.traffic_generator.capturing_traffic_generator
> import PacketFilteringConfig
>  from api.testpmd import TestPmd
> @@ -65,6 +65,7 @@ class DumpcapParams(Params):
>
>
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestPacketCapture(TestSuite):
>      """Packet Capture TestSuite.
>
> diff --git a/dts/tests/TestSuite_port_control.py
> b/dts/tests/TestSuite_port_control.py
> index c2f2de3493..2aa613bc25 100644
> --- a/dts/tests/TestSuite_port_control.py
> +++ b/dts/tests/TestSuite_port_control.py
> @@ -18,12 +18,13 @@
>  )
>  from api.packet import send_packets_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestPortControl(TestSuite):
>      """DPDK Port Control Testing Suite."""
>
> diff --git a/dts/tests/TestSuite_port_restart_config_persistency.py
> b/dts/tests/TestSuite_port_restart_config_persistency.py
> index 88df35d33c..626baa2097 100644
> --- a/dts/tests/TestSuite_port_restart_config_persistency.py
> +++ b/dts/tests/TestSuite_port_restart_config_persistency.py
> @@ -14,7 +14,7 @@
>      requires_nic_capability,
>  )
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.types import TestPmdPortFlowCtrl
>
> @@ -23,6 +23,7 @@
>  ALTERNATIVE_MAC_ADDRESS: str =3D "42:A6:B7:9E:B4:81"
>
>
> +@func_suite
>  class TestPortRestartConfigPersistency(TestSuite):
>      """Port config persistency test suite."""
>
> diff --git a/dts/tests/TestSuite_port_stats.py
> b/dts/tests/TestSuite_port_stats.py
> index 0328c6718c..e2980d8d61 100644
> --- a/dts/tests/TestSuite_port_stats.py
> +++ b/dts/tests/TestSuite_port_stats.py
> @@ -25,7 +25,7 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
> @@ -33,6 +33,7 @@
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestPortStats(TestSuite):
>      """DPDK Port statistics testing suite.
>
> diff --git a/dts/tests/TestSuite_promisc_support.py
> b/dts/tests/TestSuite_promisc_support.py
> index c59c8c6078..adbdf77631 100644
> --- a/dts/tests/TestSuite_promisc_support.py
> +++ b/dts/tests/TestSuite_promisc_support.py
> @@ -21,11 +21,12 @@
>      send_packets_and_capture,
>  )
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
> +@func_suite
>  class TestPromiscSupport(TestSuite):
>      """Promiscuous mode support test suite."""
>
> diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py
> index 5dde37d4db..67884a113c 100644
> --- a/dts/tests/TestSuite_qinq.py
> +++ b/dts/tests/TestSuite_qinq.py
> @@ -18,10 +18,11 @@
>  from api.capabilities import NicCapability, requires_nic_capability
>  from api.packet import send_packet_and_capture
>  from api.test import log, verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>
>
> +@func_suite
>  class TestQinq(TestSuite):
>      """QinQ test suite.
>
> diff --git a/dts/tests/TestSuite_queue_toggle.py
> b/dts/tests/TestSuite_queue_toggle.py
> index a9ea356b22..0ad362d233 100644
> --- a/dts/tests/TestSuite_queue_toggle.py
> +++ b/dts/tests/TestSuite_queue_toggle.py
> @@ -24,7 +24,7 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>
> @@ -32,6 +32,7 @@
>  @requires_link_topology(LinkTopology.TWO_LINKS)
>  @requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)
>  @requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)
> +@func_suite
>  class TestQueueToggle(TestSuite):
>      """DPDK Queue start/stop test suite.
>
> diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py
> index b538e93af9..289c69d225 100644
> --- a/dts/tests/TestSuite_rss.py
> +++ b/dts/tests/TestSuite_rss.py
> @@ -23,7 +23,7 @@
>  from api.exception import InteractiveCommandExecutionError
>  from api.packet import send_packets_and_capture
>  from api.test import verify
> -from api.test_suite import BaseConfig, TestSuite, func_test
> +from api.test_suite import BaseConfig, TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import (
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
> index 3b3e4cd620..eac377e93e 100644
> --- a/dts/tests/TestSuite_rx_split.py
> +++ b/dts/tests/TestSuite_rx_split.py
> @@ -21,7 +21,7 @@
>  from api.exception import InteractiveCommandExecutionError
>  from api.packet import adjust_addresses, send_packet_and_capture
>  from api.test import fail, verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import RxOffloadCapability, TxOffloadCapability
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
> index c8d24baaae..cbf9a249b4 100644
> --- a/dts/tests/TestSuite_rx_tx_offload.py
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -13,7 +13,7 @@
>      requires_nic_capability,
>  )
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.types import (
>      OffloadConfiguration,
> @@ -22,6 +22,7 @@
>
>
>  @requires_link_topology(LinkTopology.ONE_LINK)
> +@func_suite
>  class TestRxTxOffload(TestSuite):
>      """RX/TX offload test suite."""
>
> diff --git a/dts/tests/TestSuite_single_core_forward_perf.py
> b/dts/tests/TestSuite_single_core_forward_perf.py
> index 4b22c5d091..c96411cf18 100644
> --- a/dts/tests/TestSuite_single_core_forward_perf.py
> +++ b/dts/tests/TestSuite_single_core_forward_perf.py
> @@ -23,7 +23,7 @@
>  from api.packet import assess_performance_by_packet
>  from api.params.types import TestPmdParamsDict
>  from api.test import verify, write_performance_json
> -from api.test_suite import BaseConfig, TestSuite, perf_test
> +from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import RXRingParams, TXRingParams
>
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
> index b3eb325fc0..993620641c 100644
> --- a/dts/tests/TestSuite_smoke_tests.py
> +++ b/dts/tests/TestSuite_smoke_tests.py
> @@ -19,7 +19,7 @@
>      requires_link_topology,
>  )
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testbed_model.linux_session import LinuxSession
>  from api.testpmd import TestPmd
>  from api.utils import REGEX_FOR_PCI_ADDRESS
> @@ -28,6 +28,7 @@
>
>
>  @requires_link_topology(LinkTopology.NO_LINK)
> +@func_suite
>  class TestSmokeTests(TestSuite):
>      """DPDK and infrastructure smoke test suite.
>
> diff --git a/dts/tests/TestSuite_softnic.py
> b/dts/tests/TestSuite_softnic.py
> index 05a6d3aa18..f601130d56 100644
> --- a/dts/tests/TestSuite_softnic.py
> +++ b/dts/tests/TestSuite_softnic.py
> @@ -18,7 +18,7 @@
>      match_all_packets,
>      send_packets_and_capture,
>  )
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testbed_model.virtual_device import VirtualDevice
>  from api.testpmd import TestPmd
>  from api.testpmd.config import EthPeer
> @@ -27,6 +27,7 @@
>
>  @requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)
>  @requires_link_topology(LinkTopology.TWO_LINKS)
> +@func_suite
>  class TestSoftnic(TestSuite):
>      """Softnic test suite."""
>
> diff --git a/dts/tests/TestSuite_speed_capabilities.py
> b/dts/tests/TestSuite_speed_capabilities.py
> index c9b0f74feb..56c0d0a51a 100644
> --- a/dts/tests/TestSuite_speed_capabilities.py
> +++ b/dts/tests/TestSuite_speed_capabilities.py
> @@ -13,7 +13,7 @@
>      requires_link_topology,
>  )
>  from api.test import verify
> -from api.test_suite import BaseConfig, TestSuite, func_test
> +from api.test_suite import BaseConfig, TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>
>
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
> index bf3654f0d7..006f124d19 100644
> --- a/dts/tests/TestSuite_unified_packet.py
> +++ b/dts/tests/TestSuite_unified_packet.py
> @@ -25,12 +25,13 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>  from api.testpmd.types import RtePTypes, TestPmdVerbosePacket
>
>
> +@func_suite
>  class TestUnifiedPacket(TestSuite):
>      """DPDK Unified packet test suite.
>
> diff --git a/dts/tests/TestSuite_virtio_forward.py
> b/dts/tests/TestSuite_virtio_forward.py
> index a52c1a4402..52889a844b 100644
> --- a/dts/tests/TestSuite_virtio_forward.py
> +++ b/dts/tests/TestSuite_virtio_forward.py
> @@ -12,13 +12,14 @@
>  from api.capabilities import LinkTopology, requires_link_topology
>  from api.packet import send_packets_and_capture
>  from api.test import log, verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testbed_model.linux_session import LinuxSession
>  from api.testbed_model.virtual_device import VirtualDevice
>  from api.testpmd import TestPmd
>  from api.testpmd.config import PortTopology, SimpleForwardingModes
>
>
> +@func_suite
>  class TestVirtioForward(TestSuite):
>      """Virtio forwarding test suite."""
>
> diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py
> index 975e87b128..edd93e3487 100644
> --- a/dts/tests/TestSuite_vlan.py
> +++ b/dts/tests/TestSuite_vlan.py
> @@ -23,12 +23,13 @@
>  )
>  from api.packet import send_packet_and_capture
>  from api.test import verify
> -from api.test_suite import TestSuite, func_test
> +from api.test_suite import TestSuite, func_suite, func_test
>  from api.testpmd import TestPmd
>  from api.testpmd.config import SimpleForwardingModes
>
>
>  @requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)
> +@func_suite
>  class TestVlan(TestSuite):
>      """DPDK VLAN test suite.
>
> --
> 2.56.0
>
>

--000000000000ceed42065e89e56c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Recheck-request:=C2=A0<span style=3D"color:rgb(51,51,51);f=
ont-family:&quot;Helvetica Neue&quot;,Helvetica,Arial,sans-serif;font-size:=
14px">iol-unit-arm64-testing</span></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 20=
26 at 5:04=E2=80=AFPM Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@=
iol.unh.edu">knimoji@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Previously, users were unable to run both =
functional and performance<br>
test suites in a single DTS run due to driver binding conflicts.<br>
This patch separates traffic generator setup by test suite, in<br>
order to allow running functional and performance test suites in<br>
the same DTS run.<br>
<br>
Signed-off-by: Koushik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh=
.edu" target=3D"_blank">knimoji@iol.unh.edu</a>&gt;<br>
---<br>
v2:<br>
=C2=A0 =C2=A0 =C2=A0*Added TRex TG teardown to re-bind ports<br>
=C2=A0 =C2=A0 =C2=A0 to kernel driver<br>
v3:<br>
=C2=A0 =C2=A0 =C2=A0*Added topology-based port binding upon<br>
=C2=A0 =C2=A0 =C2=A0 TRex setup to preserve internal port<br>
=C2=A0 =C2=A0 =C2=A0 config state, removed all manual bindings<br>
---<br>
=C2=A0dts/api/test_suite.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 40 +++++++++++++++++++<br>
=C2=A0dts/framework/test_run.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 ++++++++---<br>
=C2=A0dts/framework/testbed_model/linux_session.py=C2=A0 |=C2=A0 6 ++-<br>
=C2=A0.../testbed_model/traffic_generator/trex.py=C2=A0 =C2=A0|=C2=A0 1 +<b=
r>
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
=C2=A034 files changed, 123 insertions(+), 38 deletions(-)<br>
<br>
diff --git a/dts/api/test_suite.py b/dts/api/test_suite.py<br>
index c30d447135..11027344d0 100644<br>
--- a/dts/api/test_suite.py<br>
+++ b/dts/api/test_suite.py<br>
@@ -44,6 +44,17 @@ class BaseConfig(FrozenModel):<br>
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
@@ -84,6 +95,30 @@ class TestSuite(TestProtocol):<br>
=C2=A0 =C2=A0 =C2=A0_sut_ip_address_egress: Union[IPv4Interface, IPv6Interf=
ace]<br>
=C2=A0 =C2=A0 =C2=A0_tg_ip_address_ingress: Union[IPv4Interface, IPv6Interf=
ace]<br>
=C2=A0 =C2=A0 =C2=A0_tg_ip_address_egress: Union[IPv4Interface, IPv6Interfa=
ce]<br>
+=C2=A0 =C2=A0 test_suite_type: ClassVar[TestSuiteType]<br>
+<br>
+=C2=A0 =C2=A0 @classmethod<br>
+=C2=A0 =C2=A0 def make_decorator(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cls, test_suite_type: TestSuiteType<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite_type: A functional, p=
erformance, or cryptodev test suite.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The decorator of a functional, p=
erformance, or cryptodev test suite.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 def _decorator(test_suite_cls: TestSuiteClassT=
ype) -&gt; TestSuiteClassType:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite_cls.test_suite_type =
=3D test_suite_type<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return test_suite_cls<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return _decorator<br>
<br>
=C2=A0 =C2=A0 =C2=A0def __init__(self, config: BaseConfig) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize the test sui=
te testbed information and basic configuration.<br>
@@ -269,6 +304,11 @@ def _adjust_addresses(self, packets: list[Packet], exp=
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
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py<br>
index 210ff25af7..3890606512 100644<br>
--- a/dts/framework/test_run.py<br>
+++ b/dts/framework/test_run.py<br>
@@ -110,7 +110,7 @@<br>
=C2=A0from api.capabilities import LinkTopology<br>
=C2=A0from api.context import Context, init_ctx<br>
=C2=A0from api.exception import InternalError, SkippedTestException, TestCa=
seVerifyError<br>
-from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite<b=
r>
+from api.test_suite import BaseConfig, TestCase, TestCaseType, TestSuite, =
TestSuiteType<br>
=C2=A0from api.testbed_model.capability import (<br>
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
@@ -512,6 +507,23 @@ def before(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().before()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logger.set_custom_log_file(<a href=
=3D"http://self.test_suite.name" rel=3D"noreferrer" target=3D"_blank">self.=
test_suite.name</a>)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx =3D self.test_run.ctx<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite_type =3D self.test_suite.test_suite=
_type<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx.topology.type is not LinkTop=
ology.NO_LINK<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 and test_suite_type is not TestS=
uiteType.CRYPTO<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test_suite_type =3D=3D TestSu=
iteType.FUNC:<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if required_tg and not required_=
tg.is_setup:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required_tg.setup(=
ctx.topology)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def description(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;State description.&quot=
;&quot;&quot;<br>
diff --git a/dts/framework/testbed_model/linux_session.py b/dts/framework/t=
estbed_model/linux_session.py<br>
index 8cc0d09d01..fe3f1a8fc3 100644<br>
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
diff --git a/dts/framework/testbed_model/traffic_generator/trex.py b/dts/fr=
amework/testbed_model/traffic_generator/trex.py<br>
index 7ce1d40d79..055c22e121 100644<br>
--- a/dts/framework/testbed_model/traffic_generator/trex.py<br>
+++ b/dts/framework/testbed_model/traffic_generator/trex.py<br>
@@ -110,6 +110,7 @@ def __init__(self, tg_node: Node, config: TrexTrafficGe=
neratorConfig) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0def setup(self, topology: Topology):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Initialize and start a =
TRex server process.&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().setup(topology)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 topology.configure_ports(&quot;tg&quot;, &quot=
;dpdk&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._topology =3D topology<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._shell =3D PythonShell(self._tg_node=
, &quot;TRex-client&quot;, privileged=3DTrue)<br>
diff --git a/dts/tests/TestSuite_blocklist.py b/dts/tests/TestSuite_blockli=
st.py<br>
index 31e69c0de9..e32f31b383 100644<br>
--- a/dts/tests/TestSuite_blocklist.py<br>
+++ b/dts/tests/TestSuite_blocklist.py<br>
@@ -11,11 +11,12 @@<br>
=C2=A0 =C2=A0 =C2=A0requires_link_topology,<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testbed_model.port import Port<br>
=C2=A0from api.testpmd import TestPmd<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestBlocklist(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK device blocklisting test suite.&=
quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_buffer_scatter.py b/dts/tests/TestSuite_bu=
ffer_scatter.py<br>
index cd1a52ad5e..adc8e41700 100644<br>
--- a/dts/tests/TestSuite_buffer_scatter.py<br>
+++ b/dts/tests/TestSuite_buffer_scatter.py<br>
@@ -28,13 +28,14 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
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
index a2ea13991b..8c16706f1b 100644<br>
--- a/dts/tests/TestSuite_checksum_offload.py<br>
+++ b/dts/tests/TestSuite_checksum_offload.py<br>
@@ -25,7 +25,7 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import ChecksumOffloadOptions, PacketOffloadFl=
ag<br>
@@ -34,6 +34,7 @@<br>
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
index 444a5b282c..bf3b9b5761 100644<br>
--- a/dts/tests/TestSuite_cryptodev_latency.py<br>
+++ b/dts/tests/TestSuite_cryptodev_latency.py<br>
@@ -31,7 +31,7 @@<br>
=C2=A0 =C2=A0 =C2=A0CryptodevResults,<br>
=C2=A0)<br>
=C2=A0from api.test import skip, verify<br>
-from api.test_suite import BaseConfig, TestSuite, crypto_test<br>
+from api.test_suite import BaseConfig, TestSuite, crypto_suite, crypto_tes=
t<br>
=C2=A0from api.testbed_model.virtual_device import VirtualDevice<br>
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
index 59f64f2cd7..7a364a1dc4 100644<br>
--- a/dts/tests/TestSuite_cryptodev_throughput.py<br>
+++ b/dts/tests/TestSuite_cryptodev_throughput.py<br>
@@ -31,7 +31,7 @@<br>
=C2=A0 =C2=A0 =C2=A0CryptodevResults,<br>
=C2=A0)<br>
=C2=A0from api.test import skip, verify<br>
-from api.test_suite import BaseConfig, TestSuite, crypto_test<br>
+from api.test_suite import BaseConfig, TestSuite, crypto_suite, crypto_tes=
t<br>
=C2=A0from api.testbed_model.virtual_device import VirtualDevice<br>
<br>
=C2=A0config_list: list[dict[str, int | float | str]] =3D [<br>
@@ -74,6 +74,7 @@ class Config(BaseConfig):<br>
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
index f3347a6d52..6038899c5c 100644<br>
--- a/dts/tests/TestSuite_dual_vlan.py<br>
+++ b/dts/tests/TestSuite_dual_vlan.py<br>
@@ -21,11 +21,12 @@<br>
=C2=A0from api.capabilities import LinkTopology, requires_link_topology<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestDualVlan(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Dual VLAN test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_dynamic_config.py b/dts/tests/TestSuite_dy=
namic_config.py<br>
index b9e2c30da1..e071e63a6d 100644<br>
--- a/dts/tests/TestSuite_dynamic_config.py<br>
+++ b/dts/tests/TestSuite_dynamic_config.py<br>
@@ -27,13 +27,14 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
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
index 24584c7d60..bc11d1ce1f 100644<br>
--- a/dts/tests/TestSuite_dynamic_queue_conf.py<br>
+++ b/dts/tests/TestSuite_dynamic_queue_conf.py<br>
@@ -38,7 +38,7 @@<br>
=C2=A0from api.exception import InteractiveCommandExecutionError<br>
=C2=A0from api.packet import send_packets<br>
=C2=A0from api.test import fail, verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import PortTopology, SimpleForwardingModes<br=
>
<br>
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
index 09384b1983..624ff93b17 100644<br>
--- a/dts/tests/TestSuite_flow_offload.py<br>
+++ b/dts/tests/TestSuite_flow_offload.py<br>
@@ -28,7 +28,7 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import fail, log, verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.types import FlowRule<br>
<br>
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
index cd62eb8f3e..9bc555aa08 100644<br>
--- a/dts/tests/TestSuite_hello_world.py<br>
+++ b/dts/tests/TestSuite_hello_world.py<br>
@@ -9,7 +9,7 @@<br>
=C2=A0&quot;&quot;&quot;<br>
<br>
=C2=A0from api.test import log<br>
-from api.test_suite import BaseConfig, TestSuite, func_test<br>
+from api.test_suite import BaseConfig, TestSuite, func_suite, func_test<br=
>
=C2=A0from api.testpmd import TestPmd<br>
<br>
<br>
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
index f237821a04..b987efbebf 100644<br>
--- a/dts/tests/TestSuite_l2fwd.py<br>
+++ b/dts/tests/TestSuite_l2fwd.py<br>
@@ -19,7 +19,7 @@<br>
=C2=A0 =C2=A0 =C2=A0match_all_packets,<br>
=C2=A0 =C2=A0 =C2=A0send_packets_and_capture,<br>
=C2=A0)<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testbed_model.cpu import LogicalCoreCount<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import EthPeer, SimpleForwardingModes<br>
@@ -28,6 +28,7 @@<br>
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
index eb1413f336..f244203593 100644<br>
--- a/dts/tests/TestSuite_mac_filter.py<br>
+++ b/dts/tests/TestSuite_mac_filter.py<br>
@@ -26,11 +26,12 @@<br>
=C2=A0from api.exception import InteractiveCommandExecutionError<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import fail, verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestMacFilter(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Mac address allowlist filtering test =
suite.<br>
<br>
diff --git a/dts/tests/TestSuite_mtu.py b/dts/tests/TestSuite_mtu.py<br>
index c264db299e..f834be1818 100644<br>
--- a/dts/tests/TestSuite_mtu.py<br>
+++ b/dts/tests/TestSuite_mtu.py<br>
@@ -23,7 +23,7 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
<br>
=C2=A0STANDARD_FRAME =3D 1518=C2=A0 # --max-pkt-len will subtract l2 inform=
ation at a minimum of 18 bytes.<br>
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
index 07bfabb30b..f319d99ede 100644<br>
--- a/dts/tests/TestSuite_packet_capture.py<br>
+++ b/dts/tests/TestSuite_packet_capture.py<br>
@@ -37,7 +37,7 @@<br>
=C2=A0)<br>
=C2=A0from api.params import Params<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testbed_model.cpu import LogicalCoreList<br>
=C2=A0from api.testbed_model.traffic_generator.capturing_traffic_generator =
import PacketFilteringConfig<br>
=C2=A0from api.testpmd import TestPmd<br>
@@ -65,6 +65,7 @@ class DumpcapParams(Params):<br>
<br>
<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
+@func_suite<br>
=C2=A0class TestPacketCapture(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Packet Capture TestSuite.<br>
<br>
diff --git a/dts/tests/TestSuite_port_control.py b/dts/tests/TestSuite_port=
_control.py<br>
index c2f2de3493..2aa613bc25 100644<br>
--- a/dts/tests/TestSuite_port_control.py<br>
+++ b/dts/tests/TestSuite_port_control.py<br>
@@ -18,12 +18,13 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packets_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
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
index 88df35d33c..626baa2097 100644<br>
--- a/dts/tests/TestSuite_port_restart_config_persistency.py<br>
+++ b/dts/tests/TestSuite_port_restart_config_persistency.py<br>
@@ -14,7 +14,7 @@<br>
=C2=A0 =C2=A0 =C2=A0requires_nic_capability,<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.types import TestPmdPortFlowCtrl<br>
<br>
@@ -23,6 +23,7 @@<br>
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
index 0328c6718c..e2980d8d61 100644<br>
--- a/dts/tests/TestSuite_port_stats.py<br>
+++ b/dts/tests/TestSuite_port_stats.py<br>
@@ -25,7 +25,7 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import RtePTypes, TestPmdVerbosePacket<br>
@@ -33,6 +33,7 @@<br>
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
index c59c8c6078..adbdf77631 100644<br>
--- a/dts/tests/TestSuite_promisc_support.py<br>
+++ b/dts/tests/TestSuite_promisc_support.py<br>
@@ -21,11 +21,12 @@<br>
=C2=A0 =C2=A0 =C2=A0send_packets_and_capture,<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PHYSICAL_FUNCTION)<br>
+@func_suite<br>
=C2=A0class TestPromiscSupport(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Promiscuous mode support test suite.&=
quot;&quot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_qinq.py b/dts/tests/TestSuite_qinq.py<br>
index 5dde37d4db..67884a113c 100644<br>
--- a/dts/tests/TestSuite_qinq.py<br>
+++ b/dts/tests/TestSuite_qinq.py<br>
@@ -18,10 +18,11 @@<br>
=C2=A0from api.capabilities import NicCapability, requires_nic_capability<b=
r>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import log, verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestQinq(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;QinQ test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_queue_toggle.py b/dts/tests/TestSuite_queu=
e_toggle.py<br>
index a9ea356b22..0ad362d233 100644<br>
--- a/dts/tests/TestSuite_queue_toggle.py<br>
+++ b/dts/tests/TestSuite_queue_toggle.py<br>
@@ -24,7 +24,7 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
<br>
@@ -32,6 +32,7 @@<br>
=C2=A0@requires_link_topology(LinkTopology.TWO_LINKS)<br>
=C2=A0@requires_nic_capability(NicCapability.RUNTIME_RX_QUEUE_SETUP)<br>
=C2=A0@requires_nic_capability(NicCapability.RUNTIME_TX_QUEUE_SETUP)<br>
+@func_suite<br>
=C2=A0class TestQueueToggle(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Queue start/stop test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_rss.py b/dts/tests/TestSuite_rss.py<br>
index b538e93af9..289c69d225 100644<br>
--- a/dts/tests/TestSuite_rss.py<br>
+++ b/dts/tests/TestSuite_rss.py<br>
@@ -23,7 +23,7 @@<br>
=C2=A0from api.exception import InteractiveCommandExecutionError<br>
=C2=A0from api.packet import send_packets_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import BaseConfig, TestSuite, func_test<br>
+from api.test_suite import BaseConfig, TestSuite, func_suite, func_test<br=
>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import (<br>
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
index 3b3e4cd620..eac377e93e 100644<br>
--- a/dts/tests/TestSuite_rx_split.py<br>
+++ b/dts/tests/TestSuite_rx_split.py<br>
@@ -21,7 +21,7 @@<br>
=C2=A0from api.exception import InteractiveCommandExecutionError<br>
=C2=A0from api.packet import adjust_addresses, send_packet_and_capture<br>
=C2=A0from api.test import fail, verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import RxOffloadCapability, TxOffloadCapabilit=
y<br>
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
index c8d24baaae..cbf9a249b4 100644<br>
--- a/dts/tests/TestSuite_rx_tx_offload.py<br>
+++ b/dts/tests/TestSuite_rx_tx_offload.py<br>
@@ -13,7 +13,7 @@<br>
=C2=A0 =C2=A0 =C2=A0requires_nic_capability,<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.types import (<br>
=C2=A0 =C2=A0 =C2=A0OffloadConfiguration,<br>
@@ -22,6 +22,7 @@<br>
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
index 4b22c5d091..c96411cf18 100644<br>
--- a/dts/tests/TestSuite_single_core_forward_perf.py<br>
+++ b/dts/tests/TestSuite_single_core_forward_perf.py<br>
@@ -23,7 +23,7 @@<br>
=C2=A0from api.packet import assess_performance_by_packet<br>
=C2=A0from api.params.types import TestPmdParamsDict<br>
=C2=A0from api.test import verify, write_performance_json<br>
-from api.test_suite import BaseConfig, TestSuite, perf_test<br>
+from api.test_suite import BaseConfig, TestSuite, perf_suite, perf_test<br=
>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import RXRingParams, TXRingParams<br>
<br>
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
index b3eb325fc0..993620641c 100644<br>
--- a/dts/tests/TestSuite_smoke_tests.py<br>
+++ b/dts/tests/TestSuite_smoke_tests.py<br>
@@ -19,7 +19,7 @@<br>
=C2=A0 =C2=A0 =C2=A0requires_link_topology,<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testbed_model.linux_session import LinuxSession<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.utils import REGEX_FOR_PCI_ADDRESS<br>
@@ -28,6 +28,7 @@<br>
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
index 05a6d3aa18..f601130d56 100644<br>
--- a/dts/tests/TestSuite_softnic.py<br>
+++ b/dts/tests/TestSuite_softnic.py<br>
@@ -18,7 +18,7 @@<br>
=C2=A0 =C2=A0 =C2=A0match_all_packets,<br>
=C2=A0 =C2=A0 =C2=A0send_packets_and_capture,<br>
=C2=A0)<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testbed_model.virtual_device import VirtualDevice<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import EthPeer<br>
@@ -27,6 +27,7 @@<br>
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
index c9b0f74feb..56c0d0a51a 100644<br>
--- a/dts/tests/TestSuite_speed_capabilities.py<br>
+++ b/dts/tests/TestSuite_speed_capabilities.py<br>
@@ -13,7 +13,7 @@<br>
=C2=A0 =C2=A0 =C2=A0requires_link_topology,<br>
=C2=A0)<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import BaseConfig, TestSuite, func_test<br>
+from api.test_suite import BaseConfig, TestSuite, func_suite, func_test<br=
>
=C2=A0from api.testpmd import TestPmd<br>
<br>
<br>
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
index bf3654f0d7..006f124d19 100644<br>
--- a/dts/tests/TestSuite_unified_packet.py<br>
+++ b/dts/tests/TestSuite_unified_packet.py<br>
@@ -25,12 +25,13 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
=C2=A0from api.testpmd.types import RtePTypes, TestPmdVerbosePacket<br>
<br>
<br>
+@func_suite<br>
=C2=A0class TestUnifiedPacket(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK Unified packet test suite.<br>
<br>
diff --git a/dts/tests/TestSuite_virtio_forward.py b/dts/tests/TestSuite_vi=
rtio_forward.py<br>
index a52c1a4402..52889a844b 100644<br>
--- a/dts/tests/TestSuite_virtio_forward.py<br>
+++ b/dts/tests/TestSuite_virtio_forward.py<br>
@@ -12,13 +12,14 @@<br>
=C2=A0from api.capabilities import LinkTopology, requires_link_topology<br>
=C2=A0from api.packet import send_packets_and_capture<br>
=C2=A0from api.test import log, verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testbed_model.linux_session import LinuxSession<br>
=C2=A0from api.testbed_model.virtual_device import VirtualDevice<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import PortTopology, SimpleForwardingModes<br=
>
<br>
<br>
+@func_suite<br>
=C2=A0class TestVirtioForward(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Virtio forwarding test suite.&quot;&q=
uot;&quot;<br>
<br>
diff --git a/dts/tests/TestSuite_vlan.py b/dts/tests/TestSuite_vlan.py<br>
index 975e87b128..edd93e3487 100644<br>
--- a/dts/tests/TestSuite_vlan.py<br>
+++ b/dts/tests/TestSuite_vlan.py<br>
@@ -23,12 +23,13 @@<br>
=C2=A0)<br>
=C2=A0from api.packet import send_packet_and_capture<br>
=C2=A0from api.test import verify<br>
-from api.test_suite import TestSuite, func_test<br>
+from api.test_suite import TestSuite, func_suite, func_test<br>
=C2=A0from api.testpmd import TestPmd<br>
=C2=A0from api.testpmd.config import SimpleForwardingModes<br>
<br>
<br>
=C2=A0@requires_nic_capability(NicCapability.PORT_RX_OFFLOAD_VLAN_FILTER)<b=
r>
+@func_suite<br>
=C2=A0class TestVlan(TestSuite):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;DPDK VLAN test suite.<br>
<br>
-- <br>
2.56.0<br>
<br>
</blockquote></div>

--000000000000ceed42065e89e56c--
