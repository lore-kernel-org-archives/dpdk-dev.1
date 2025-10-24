Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD88DCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 19:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDAB240151;
	Fri, 24 Oct 2025 21:21:40 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 48D5C4014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 21:21:38 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-290dc63fabbso24350815ad.0
 for <dev@dpdk.org>; Fri, 24 Oct 2025 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761333697; x=1761938497; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UjHR5wMe0MbbwM6N/MX5fAfmGVfv03pnAz8fULUWUy0=;
 b=bmChgKOsbUH4cuUqyphhwgURELscqvSv5Y5Kr3OETZptnN1t0vK3IeZDmEicTyGWy+
 7h/3zV/MFo6mAb68/qbQONJe1Nk7UMqwp67yc6Sw9SzudVBWQst01QNNDCWuH2ocEopc
 tgpB7UaXKquXeMj7/O9RYC9cOLF2MyEtSEjqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761333697; x=1761938497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjHR5wMe0MbbwM6N/MX5fAfmGVfv03pnAz8fULUWUy0=;
 b=w4UVdhjdxka0/a0TpCbxGODcOZko8Zv0fFhGvWJh+ArJuXQ35Q7wlhZTmpJuJKlJFu
 YtbLEebGOhKo+URfM/Tdc/8kKAo4Hvi+md3RiAJxLeEGvF/XHvPP9kZ4ylgiEYx2mrUc
 kllG7rPl1pYUJXhKdmDUK1pB+xOS7W0uVdkJHB5iA4kPNE86dYbkPSX57RkjgEKY0/CZ
 yc4b3CGqZsQ7pbPVakFdi9I6Q5Y3HoUkXkZUHskl5P4t0BG09poFSQ4RQvmPrG2L7TnJ
 HuXUir5YtOSy4J0EhXZG3onm+HcFSTN2sbAQYHIx9uGfZ7oFZeD5LvE+FJErsW2ep4mK
 nlKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKjX6Qs9lyj2v4vTu4I3xEkMMyUL7GBaGWSWHFLe/mFlOZypQMEALp/vwz7rX8E+iP6YA=@dpdk.org
X-Gm-Message-State: AOJu0YynGYB84oGOm6mFyCU4h81RtgIlB+MTv3CrgpLTLHpcqjplNrCa
 e0Fa6AwpZXJU+dODw/oY858VM+pPrbAc1hHWritAlTsACzpmpHMdOY+I4aCUrk9aXI39HaFkwaB
 pfXZmnzgjqJ0Z2t0icQOUQcp+DzvgM1fvQ/h8O72oTA==
X-Gm-Gg: ASbGncv9ZGr2hNEpbu6uYMr32458Uu/5dwKxgcOJgSRgZZYcBj+b+Qw8VM+Q0GwT4f/
 H/cR3tOLMVWuJjVCM9qrzhI0pvbEty4pRQFifKyHh1k1rSFcwBgqKl9Y6LVI2WnGDSMOA/jHflf
 uLYdS92p+BQsDFEKbD6/nz8AhyDdT3zBK4ZxCnKPWTgkKXLsoTmsLXEBoV0r8Y788FguMAnK9dn
 SqZApG0EPVzF6hUP/jBT0wVAA6fNc8Vq0v+LF7uPW7UtN9VzI86Dui6fjddkDdzLaacZ0urvyN7
 XqwzbgdS/Q+w6234QA==
X-Google-Smtp-Source: AGHT+IEvB6hJf8N3ch3+p9Z6aJZZzDSSQbHVCPyfjujaRONJ4ufMNMyx5LNaVo8/nYS65DNcW2FyEUPc5/UuRoonnAk=
X-Received: by 2002:a17:903:1a70:b0:290:2a14:2eef with SMTP id
 d9443c01a7336-2946c9299dbmr102664775ad.0.1761333697382; Fri, 24 Oct 2025
 12:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251023123223.56924-1-abailey@iol.unh.edu>
 <20251023123223.56924-2-abailey@iol.unh.edu>
In-Reply-To: <20251023123223.56924-2-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 24 Oct 2025 15:20:43 -0400
X-Gm-Features: AS18NWA1YJyDWY4LPk1Qa4gATWSFENVLqWz2CVZGO1UM-MkZ9rc5iwCemF_Lce4
Message-ID: <CAJvnSUB4++TYCnbsN47Z=yEJr0AaZ_T0pzqRuKcy-ky1DZuW7A@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] dts: allow mbuf fast free to be set with testpmd
 shell
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000005d1b970641ec7546"
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

--0000000000005d1b970641ec7546
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think there was an issue with your rebase. You are now adding in the
testsuite in your 1/3 when it should be added in the 3/3. Let me know if
you need help untangling this.

On Thu, Oct 23, 2025 at 8:32=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Currently, there is no way in the testpmd shell class to set the mbuf
> fast free offload configuration for queues or ports. This prohibits any
> test suites to be written utilizing this offload configuration.
> Introduce methods that support calls to testpmd in order to allow
> the configuration of mbuf fast free.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  dts/api/testpmd/__init__.py          |  60 +++++++++++++
>  dts/tests/TestSuite_rx_tx_offload.py | 129 +++++++++++++++++++++++++++
>  2 files changed, 189 insertions(+)
>  create mode 100644 dts/tests/TestSuite_rx_tx_offload.py
>
> diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py
> index a060ab5639..9e9cbaf495 100644
> --- a/dts/api/testpmd/__init__.py
> +++ b/dts/api/testpmd/__init__.py
> @@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(
>              supported_capabilities.add(NicCapability.PHYSICAL_FUNCTION)
>          else:
>              unsupported_capabilities.add(NicCapability.PHYSICAL_FUNCTION=
)
> +
> +    @_requires_stopped_ports
> +    def set_port_mbuf_fast_free(
> +        self,
> +        port_id: int,
> +        on: bool,
> +        /,
> +        verify: bool =3D True,
> +    ) -> None:
> +        """Sets the mbuf_fast_free configuration for the Tx offload of a
> given port.
> +
> +        Args:
> +            port_id: The ID of the port to configure mbuf_fast_free on.
> +            on: If :data:`True` mbuf_fast_free will be enabled, disable
> it otherwise.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that the mbuf_fast_free was set successfully.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If mbuf_fast_free could no=
t
> be set successfully.
> +        """
> +        mbuf_output =3D self.send_command(
> +            f"port config {port_id} tx_offload mbuf_fast_free {"on" if o=
n
> else "off"}"
> +        )
> +
> +        if verify and "Error" in mbuf_output:
> +            raise InteractiveCommandExecutionError(
> +                f"Unable to set mbuf_fast_free config on port
> {port_id}:\n{mbuf_output}"
> +            )
> +
> +    @_requires_stopped_ports
> +    def set_queue_mbuf_fast_free(
> +        self,
> +        port_id: int,
> +        on: bool,
> +        /,
> +        queue_id: int =3D 0,
> +        verify: bool =3D True,
> +    ) -> None:
> +        """Sets the Tx mbuf_fast_free configuration of the specified
> queue on a given port.
> +
> +        Args:
> +            port_id: The ID of the port containing the queues.
> +            on: If :data:`True` the mbuf_fast_free configuration will be
> enabled, otherwise
> +                disabled.
> +            queue_id: The ID of the queue to configure mbuf_fast_free on=
.
> +            verify: If :data:`True` the output of the command will be
> scanned in an attempt to
> +                verify that mbuf_fast_free was set successfully on all
> ports.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If all queues could not be
> set successfully.
> +        """
> +        toggle =3D "on" if on else "off"
> +        output =3D self.send_command(
> +            f"port {port_id} txq {queue_id} tx_offload mbuf_fast_free
> {toggle}"
> +        )
> +        if verify and "Error" in output:
> +            self._logger.debug(f"Set queue offload config
> error\n{output}")
> +            raise InteractiveCommandExecutionError(
> +                f"Failed to get offload config on port {port_id}, queue
> {queue_id}:\n{output}"
> +            )
> diff --git a/dts/tests/TestSuite_rx_tx_offload.py
> b/dts/tests/TestSuite_rx_tx_offload.py
> new file mode 100644
> index 0000000000..16e1b8cf93
> --- /dev/null
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RX TX offload test suite.
> +
> +Test the testpmd feature of configuring RX and TX offloads.
> +"""
> +
> +from api.capabilities import NicCapability, requires_nic_capability
> +from api.test import verify
> +from api.testpmd import TestPmd
> +from api.testpmd.types import (
> +    OffloadConfiguration,
> +    RxTxLiteralSwitch,
> +)
> +from framework.test_suite import TestSuite, func_test
> +
> +
> +class TestRxTxOffload(TestSuite):
> +    """RX/TX offload test suite."""
> +
> +    def _check_config(
> +        self,
> +        testpmd: TestPmd,
> +        port_id: int,
> +        port_offload: str | None,
> +        rxtx: RxTxLiteralSwitch,
> +        /,
> +        queue_offload: list[str | None] | None =3D None,
> +        verify: bool =3D True,
> +    ) -> bool:
> +        config: OffloadConfiguration =3D
> testpmd.get_offload_config(port_id, rxtx, verify)
> +        if config.port.name !=3D port_offload:
> +            return False
> +
> +        if queue_offload:
> +            for i, q in enumerate(config.queues):
> +                if q.name !=3D queue_offload[i]:
> +                    return False
> +        return True
> +
> +    def _set_all_queues_mbuf_fast_free(
> +        self, testpmd: TestPmd, port_id: int, on: bool, num_queues: int,
> /, verify: bool =3D True
> +    ) -> None:
> +        for i in range(num_queues):
> +            testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
> +
> +    @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FRE=
E)
> +    @func_test
> +    def test_mbuf_fast_free_configuration_per_port(self) -> None:
> +        """Ensure mbuf_fast_free can be configured with testpmd per port=
.
> +
> +        Steps:
> +            * Start up testpmd shell.
> +            * Toggle mbuf_fast_free off per port.
> +            * Toggle mbuf_fast_free on per port.
> +
> +        Verify:
> +            * Mbuf_fast_free starts enabled.
> +            * Mbuf_fast_free can be configured off per port.
> +            * Mbuf_fast_free can be configured on per port.
> +        """
> +        with TestPmd() as testpmd:
> +            to_verify =3D True
> +            port_id =3D 0
> +            testpmd.start_all_ports()
> +
> +            # Ensure MBUF_FAST_FREE is enabled by default and verify
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", verify=3Dto_verify),
> +                "MBUF_FAST_FREE disabled on port start.",
> +            )
> +            # disable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(port_id, False, to_verify)
> +            verify(
> +                self._check_config(testpmd, port_id, None, "tx",
> verify=3Dto_verify),
> +                "Failed to enable MBUF_FAST_FREE on port.",
> +            )
> +            # Enable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(port_id, True, to_verify)
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", verify=3Dto_verify),
> +                "Failed to disable MBUF_FAST_FREE on port.",
> +            )
> +
> +
> @requires_nic_capability(NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE)
> +    @func_test
> +    def test_mbuf_fast_free_configuration_per_queue(self) -> None:
> +        """Ensure mbuf_fast_free can be configured with testpmd.
> +
> +        Steps:
> +            * Start up testpmd shell.
> +            * Toggle mbuf_fast_free off per queue.
> +            * Toggle mbuf_fast_free on per queue.
> +
> +        Verify:
> +            * Mbuf_fast_free starts disabled.
> +            * Mbuf_fast_free can be configured off per queue.
> +            * Mbuf_fast_free can be configured on per queue.
> +        """
> +        with TestPmd() as testpmd:
> +            to_verify =3D True
> +            port_id =3D 0
> +            num_queues =3D 4
> +            queue_off: list[str | None] | None =3D [None] * num_queues
> +            queue_on: list[str | None] | None =3D ["MBUF_FAST_FREE"] *
> num_queues
> +
> +            testpmd.set_ports_queues(num_queues)
> +            testpmd.start_all_ports()
> +
> +            # Ensure mbuf_fast_free is enabled by default on port and
> queues
> +            verify(
> +                self._check_config(
> +                    testpmd, port_id, "MBUF_FAST_FREE", "tx", queue_on,
> verify=3Dto_verify
> +                ),
> +                "MBUF_FAST_FREE disabled on queue start.",
> +            )
> +            # Disable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False,
> num_queues, to_verify)
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", queue_off, to_verify),
> +                "Failed to disable MBUF_FAST_FREE on all queues.",
> +            )
> +            # Disable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True,
> num_queues, to_verify)
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", queue_on, to_verify),
> +                "Failed to enable MBUF_FAST_FREE on all queues.",
> +            )
> --
> 2.50.1
>
>

--0000000000005d1b970641ec7546
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think there was an issue with your rebase. You are now a=
dding in the testsuite in your 1/3 when it should be added in the 3/3. Let =
me know if you need help untangling this.</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 23, 2025 at 8:32=E2=80=
=AFAM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" target=3D"_b=
lank">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Currently, there is no way in the testpmd shell cl=
ass to set the mbuf<br>
fast free offload configuration for queues or ports. This prohibits any<br>
test suites to be written utilizing this offload configuration.<br>
Introduce methods that support calls to testpmd in order to allow<br>
the configuration of mbuf fast free.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 60 +++++++++++++<br>
=C2=A0dts/tests/TestSuite_rx_tx_offload.py | 129 ++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 189 insertions(+)<br>
=C2=A0create mode 100644 dts/tests/TestSuite_rx_tx_offload.py<br>
<br>
diff --git a/dts/api/testpmd/__init__.py b/dts/api/testpmd/__init__.py<br>
index a060ab5639..9e9cbaf495 100644<br>
--- a/dts/api/testpmd/__init__.py<br>
+++ b/dts/api/testpmd/__init__.py<br>
@@ -1292,3 +1292,63 @@ def get_capabilities_physical_function(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_capabilities.add(=
NicCapability.PHYSICAL_FUNCTION)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported_capabilities.ad=
d(NicCapability.PHYSICAL_FUNCTION)<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_port_mbuf_fast_free(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 on: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the mbuf_fast_free conf=
iguration for the Tx offload of a given port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The ID of the port to c=
onfigure mbuf_fast_free on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: If :data:`True` mbuf_fast_fr=
ee will be enabled, disable it otherwise.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that the mb=
uf_fast_free was set successfully.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If mbuf_fast_free could not be set successfully.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mbuf_output =3D self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port config {port_id} tx_=
offload mbuf_fast_free {&quot;on&quot; if on else &quot;off&quot;}&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and &quot;Error&quot; in mbuf_output=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Unable to s=
et mbuf_fast_free config on port {port_id}:\n{mbuf_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @_requires_stopped_ports<br>
+=C2=A0 =C2=A0 def set_queue_mbuf_fast_free(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 on: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: int =3D 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the Tx mbuf_fast_free c=
onfiguration of the specified queue on a given port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The ID of the port cont=
aining the queues.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 on: If :data:`True` the mbuf_fas=
t_free configuration will be enabled, otherwise<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disabled.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The ID of the queue to=
 configure mbuf_fast_free on.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True` the outp=
ut of the command will be scanned in an attempt to<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify that mbuf_f=
ast_free was set successfully on all ports.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If all queues could not be set successfully.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 toggle =3D &quot;on&quot; if on else &quot;off=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port {port_id} txq {queue=
_id} tx_offload mbuf_fast_free {toggle}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify and &quot;Error&quot; in output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug(f&quot;Set qu=
eue offload config error\n{output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;Failed to g=
et offload config on port {port_id}, queue {queue_id}:\n{output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_=
tx_offload.py<br>
new file mode 100644<br>
index 0000000000..16e1b8cf93<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_rx_tx_offload.py<br>
@@ -0,0 +1,129 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;RX TX offload test suite.<br>
+<br>
+Test the testpmd feature of configuring RX and TX offloads.<br>
+&quot;&quot;&quot;<br>
+<br>
+from api.capabilities import NicCapability, requires_nic_capability<br>
+from api.test import verify<br>
+from api.testpmd import TestPmd<br>
+from api.testpmd.types import (<br>
+=C2=A0 =C2=A0 OffloadConfiguration,<br>
+=C2=A0 =C2=A0 RxTxLiteralSwitch,<br>
+)<br>
+from framework.test_suite import TestSuite, func_test<br>
+<br>
+<br>
+class TestRxTxOffload(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;RX/TX offload test suite.&quot;&quot;&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 def _check_config(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_offload: str | None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxtx: RxTxLiteralSwitch,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_offload: list[str | None] | None =3D Non=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config: OffloadConfiguration =3D testpmd.get_o=
ffload_config(port_id, rxtx, verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://config.port.name" rel=3D"=
noreferrer" target=3D"_blank">config.port.name</a> !=3D port_offload:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if queue_offload:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i, q in enumerate(config.que=
ues):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http=
://q.name" rel=3D"noreferrer" target=3D"_blank">q.name</a> !=3D queue_offlo=
ad[i]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def _set_all_queues_mbuf_fast_free(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, testpmd: TestPmd, port_id: int, on: bool=
, num_queues: int, /, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(num_queues):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_queue_mbuf_fast_free=
(on, port_id, i, verify)<br>
+<br>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.PORT_TX_OFFLOAD_MBUF_=
FAST_FREE)<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_mbuf_fast_free_configuration_per_port(self) -&gt; N=
one:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Ensure mbuf_fast_free can be=
 configured with testpmd per port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start up testpmd shell.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free off per =
port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free on per p=
ort.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free starts enabled.=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed off per port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed on per port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_verify =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start_all_ports()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure MBUF_FAST_FREE is enabl=
ed by default and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, verify=3Dto_=
verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;MBUF_FAST_FR=
EE disabled on port start.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # disable MBUF_FAST_FREE per por=
t and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_port_mbuf_fast_free(=
port_id, False, to_verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, None, &quot;tx&quot;, verify=3Dto_verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to en=
able MBUF_FAST_FREE on port.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable MBUF_FAST_FREE per port=
 and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_port_mbuf_fast_free(=
port_id, True, to_verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, verify=3Dto_=
verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to di=
sable MBUF_FAST_FREE on port.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @requires_nic_capability(NicCapability.QUEUE_TX_OFFLOAD_MBUF=
_FAST_FREE)<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_mbuf_fast_free_configuration_per_queue(self) -&gt; =
None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Ensure mbuf_fast_free can be=
 configured with testpmd.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start up testpmd shell.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free off per =
queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free on per q=
ueue.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free starts disabled=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed off per queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed on per queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_verify =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_queues =3D 4<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_off: list[str | None] | No=
ne =3D [None] * num_queues<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_on: list[str | None] | Non=
e =3D [&quot;MBUF_FAST_FREE&quot;] * num_queues<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_ports_queues(num_que=
ues)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start_all_ports()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure mbuf_fast_free is enabl=
ed by default on port and queues<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
pmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, queue_on, verify=
=3Dto_verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;MBUF_FAST_FR=
EE disabled on queue start.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable mbuf_fast_free per que=
ue and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_all_queues_mbuf_fast_f=
ree(testpmd, port_id, False, num_queues, to_verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, queue_off, t=
o_verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to di=
sable MBUF_FAST_FREE on all queues.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable mbuf_fast_free per que=
ue and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_all_queues_mbuf_fast_f=
ree(testpmd, port_id, True, num_queues, to_verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, queue_on, to=
_verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to en=
able MBUF_FAST_FREE on all queues.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--0000000000005d1b970641ec7546--
