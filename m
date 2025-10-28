Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30452CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 22:34:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85B75402EE;
	Tue, 28 Oct 2025 23:34:18 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 770194028D
 for <dev@dpdk.org>; Tue, 28 Oct 2025 23:34:17 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-26d0fbe238bso47107215ad.3
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761690856; x=1762295656; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A0dCC/9J7tsQMLa5yIpilUQW2NEY3ws9rgp06m+MEAY=;
 b=gjjNJpclrsWuKEtzii/UgD7N3iNIVDWznuVYc8i8716h5CBNu6xdnxHRM5O50zNn6W
 3Vfd+b6aUanVT5lMRbBbhx0WWqMeLShKoklFu7qDsOilRGdeTMfljkQZdxvjovu953eX
 qQiJxs6wZpDbm1II8UPHagf9ED8LCwTIYqZGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761690856; x=1762295656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A0dCC/9J7tsQMLa5yIpilUQW2NEY3ws9rgp06m+MEAY=;
 b=ZPDhqHGMEGiyDXbhxgX+DFvxG/BIy/beqGnvyqG05nUNYE/CCdYwHvjPCCUBLIEoGl
 uhc1jTITInFBf2wMLRR7NAvsd+jR81Xx9wMpO903wC1/tJM9esRajaGcKsfIq8yTr+0T
 5Dr+IOuadzxQXmpmMBifR8O1zJsf0p0ghNIhDKxr8OsMKG7PaCYoZ84+duEW3uS83PvT
 0lrisffzQPDGVRGr6KWZQtFYcF81DWFxT5Nf8kJMhyVHEUMfY3W8a4znWaiy0qFwH6qK
 5nrylqPrfck31sXG66vBv5JjjDhqhHN5b8Ay+PsvN13mVSn2WU9Uk/gMWEGqPy2os+qp
 3srQ==
X-Gm-Message-State: AOJu0YxdPRjv6ez3eEeC2czmNbik9FV32ZHccOCwRpFgCCYWwPioLY6r
 cUzkxA/K2QAU33tlHI+p61mfm73JCvSWk/uo/QrD0Iu0IEM1+fSa16fRnP3ch1fxmZ54KY9LKvY
 +9/mY6KBP3OEzTLc+ZvYA0EGN60n9talpmex/VTYxhg==
X-Gm-Gg: ASbGncsoh0wK65tLBytBjUTevXdOUcNg0lSETZyC7v2GAdDhxeWgNoke2zm5nc0GkPj
 WM7sAr/ju2hgaCvRSAqEYwqW+hb1Nnhah4vS94cXoT/MFyX8DjHlYBkUJkLHQJ/V3DrI7GFvPR/
 Ekf1VnFfbpKwv/10G/oXdq5mnpswJUds1ebJJZiaxcaEB6+f3VXR2KWkd3qRiUACXXllgYf/G1J
 jWB3+kN/z3Q3bt1E1KuKaeF0wW6p9QPMTC5PNhpNU6J5Y4+y4wx0oOPwTibzY1Yck4O9lc4Z0un
 b6eYENvhqo1aHdQSxw==
X-Google-Smtp-Source: AGHT+IEsypHOLm+6/XMVe4vaxE3XY8HYf7SAl6QAWJOTPcaU0DNHvHuaJ4P1dQAZ+6vWWOIfo6EhXByIHF7Sv/mrYDo=
X-Received: by 2002:a17:903:ac6:b0:290:b53b:745b with SMTP id
 d9443c01a7336-294deedabdfmr9382995ad.39.1761690856507; Tue, 28 Oct 2025
 15:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20251028122240.112773-1-abailey@iol.unh.edu>
 <20251028122240.112773-4-abailey@iol.unh.edu>
In-Reply-To: <20251028122240.112773-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 28 Oct 2025 18:33:18 -0400
X-Gm-Features: AWmQ_bkzvRPmvMMwOwnJsZzX-HpWE4rvxtWsRA_bheJ38cG2Fp_WrKi1X5_hEr8
Message-ID: <CAJvnSUC32dbaNLSR62ykP01J5=r0ns-D2Rr3V5i-L_U8YOJH+A@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] dts: add Rx Tx offload test suite
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dev@dpdk.org, luca.vizzarro@arm.com, dmarx@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000b4db6b06423f9dc6"
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

--000000000000b4db6b06423f9dc6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied to next-dts with a commit reword, thanks.

On Tue, Oct 28, 2025 at 8:22=E2=80=AFAM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Add mbuf_fast_free portion of rxtx offload testsuite from legacy dts
> to next dts. The testsuite expects mbuf fast free to be enabled by
> default and verifies configuration of this Tx offload capability.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 ++
>  dts/tests/TestSuite_rx_tx_offload.py          | 134 ++++++++++++++++++
>  2 files changed, 142 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
>  create mode 100644 dts/tests/TestSuite_rx_tx_offload.py
>
> diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
> b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
> new file mode 100644
> index 0000000000..27834a74da
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +rx_tx_offload Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. automodule:: tests.TestSuite_rx_tx_offload
> +   :members:
> +   :show-inheritance:
> diff --git a/dts/tests/TestSuite_rx_tx_offload.py
> b/dts/tests/TestSuite_rx_tx_offload.py
> new file mode 100644
> index 0000000000..b0da627d3c
> --- /dev/null
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RX TX offload test suite.
> +
> +Test the testpmd feature of configuring RX and TX offloads.
> +"""
> +
> +from api.capabilities import (
> +    LinkTopology,
> +    NicCapability,
> +    requires_link_topology,
> +    requires_nic_capability,
> +)
> +from api.test import verify
> +from api.testpmd import TestPmd
> +from api.testpmd.types import (
> +    OffloadConfiguration,
> +    RxTxLiteralSwitch,
> +)
> +from framework.test_suite import TestSuite, func_test
> +
> +
> +@requires_link_topology(LinkTopology.ONE_LINK)
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
> +    ) -> bool:
> +        config: OffloadConfiguration =3D
> testpmd.get_offload_config(port_id, rxtx)
> +        if config.port_config.name !=3D port_offload:
> +            return False
> +
> +        if queue_offload:
> +            for i, q in enumerate(config.queue_configs):
> +                if q.name !=3D queue_offload[i]:
> +                    return False
> +        return True
> +
> +    def _set_all_queues_mbuf_fast_free(
> +        self,
> +        testpmd: TestPmd,
> +        port_id: int,
> +        on: bool,
> +        num_queues: int,
> +    ) -> None:
> +        for i in range(num_queues):
> +            testpmd.set_queue_mbuf_fast_free(port_id, on, i)
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
> +            port_id =3D 0
> +            testpmd.start_all_ports()
> +
> +            # Ensure MBUF_FAST_FREE is enabled by default and verify
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx"),
> +                "MBUF_FAST_FREE disabled on port start.",
> +            )
> +            # disable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(port_id, False)
> +            verify(
> +                self._check_config(testpmd, port_id, None, "tx"),
> +                "Failed to enable MBUF_FAST_FREE on port.",
> +            )
> +            # Enable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(port_id, True)
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx"),
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
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", queue_on),
> +                "MBUF_FAST_FREE disabled on queue start.",
> +            )
> +            # Disable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, port_id, False,
> num_queues)
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", queue_off),
> +                "Failed to disable MBUF_FAST_FREE on all queues.",
> +            )
> +            # Disable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, port_id, True,
> num_queues)
> +            verify(
> +                self._check_config(testpmd, port_id, "MBUF_FAST_FREE",
> "tx", queue_on),
> +                "Failed to enable MBUF_FAST_FREE on all queues.",
> +            )
> --
> 2.50.1
>
>

--000000000000b4db6b06423f9dc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Applied to next-dts with a commit reword, thanks.</div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Tue, Oct 28, 2025 at 8:22=E2=80=AFAM Andrew Bailey &lt;<a h=
ref=3D"mailto:abailey@iol.unh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">Add mbuf_fast_free po=
rtion of rxtx offload testsuite from legacy dts<br>
to next dts. The testsuite expects mbuf fast free to be enabled by<br>
default and verifies configuration of this Tx offload capability.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/tests.TestSuite_rx_tx_offload.rst |=C2=A0 =C2=A08 ++<br>
=C2=A0dts/tests/TestSuite_rx_tx_offload.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 134 ++++++++++++++++++<br>
=C2=A02 files changed, 142 insertions(+)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_rx_tx_offload.py<br>
<br>
diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst b/doc/api/dts/te=
sts.TestSuite_rx_tx_offload.rst<br>
new file mode 100644<br>
index 0000000000..27834a74da<br>
--- /dev/null<br>
+++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+rx_tx_offload Test Suite<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r>
+<br>
+.. automodule:: tests.TestSuite_rx_tx_offload<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_=
tx_offload.py<br>
new file mode 100644<br>
index 0000000000..b0da627d3c<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_rx_tx_offload.py<br>
@@ -0,0 +1,134 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;RX TX offload test suite.<br>
+<br>
+Test the testpmd feature of configuring RX and TX offloads.<br>
+&quot;&quot;&quot;<br>
+<br>
+from api.capabilities import (<br>
+=C2=A0 =C2=A0 LinkTopology,<br>
+=C2=A0 =C2=A0 NicCapability,<br>
+=C2=A0 =C2=A0 requires_link_topology,<br>
+=C2=A0 =C2=A0 requires_nic_capability,<br>
+)<br>
+from api.test import verify<br>
+from api.testpmd import TestPmd<br>
+from api.testpmd.types import (<br>
+=C2=A0 =C2=A0 OffloadConfiguration,<br>
+=C2=A0 =C2=A0 RxTxLiteralSwitch,<br>
+)<br>
+from framework.test_suite import TestSuite, func_test<br>
+<br>
+<br>
+@requires_link_topology(LinkTopology.ONE_LINK)<br>
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
+=C2=A0 =C2=A0 ) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config: OffloadConfiguration =3D testpmd.get_o=
ffload_config(port_id, rxtx)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://config.port_config.name" =
rel=3D"noreferrer" target=3D"_blank">config.port_config.name</a> !=3D port_=
offload:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if queue_offload:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i, q in enumerate(config.que=
ue_configs):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http=
://q.name" rel=3D"noreferrer" target=3D"_blank">q.name</a> !=3D queue_offlo=
ad[i]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def _set_all_queues_mbuf_fast_free(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 on: bool,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_queues: int,<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(num_queues):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_queue_mbuf_fast_free=
(port_id, on, i)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start_all_ports()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure MBUF_FAST_FREE is enabl=
ed by default and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;MBUF_FAST_FR=
EE disabled on port start.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # disable MBUF_FAST_FREE per por=
t and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_port_mbuf_fast_free(=
port_id, False)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, None, &quot;tx&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to en=
able MBUF_FAST_FREE on port.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable MBUF_FAST_FREE per port=
 and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_port_mbuf_fast_free(=
port_id, True)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;),<br>
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
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, queue_on),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;MBUF_FAST_FR=
EE disabled on queue start.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable mbuf_fast_free per que=
ue and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_all_queues_mbuf_fast_f=
ree(testpmd, port_id, False, num_queues)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, queue_off),<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to di=
sable MBUF_FAST_FREE on all queues.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable mbuf_fast_free per que=
ue and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_all_queues_mbuf_fast_f=
ree(testpmd, port_id, True, num_queues)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, port_id, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, queue_on),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to en=
able MBUF_FAST_FREE on all queues.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--000000000000b4db6b06423f9dc6--
