Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6CCCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 15:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E85B40E13;
	Wed, 15 Oct 2025 17:35:15 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id B5C1540DD3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 17:35:14 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-339e71ccf48so9379767a91.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 08:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760542514; x=1761147314; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WQpIZ8pqZhozBtGVI7s7p+k71fZiJinqFTDvz9sOtew=;
 b=fflbBa5k74M0HLWqxDZjG/Fo5GqXiE6YD9fbADgsee1MMQOKKN7KRUFQX93iLk7uh1
 CadzAEl8MNGQgZT/BvruXvYK7m1HkPwW/HfRXoEbViCQodsvv2rAQdakjhpSJU1zK6OC
 vmpKnaaRtg89lb3m7H4s97rFx1Ndq7nKXbVw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760542514; x=1761147314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WQpIZ8pqZhozBtGVI7s7p+k71fZiJinqFTDvz9sOtew=;
 b=OKhz0BvOW+fj5nxd+Gvjt0/YUxme1Tr8Xy7W7dGwFXLEU3kPjB2Q0B61AXotE0uDG9
 J+WU5wZrzr9udJAnOoSuVy1rHC3AI2StS4oczxq4uRtSYwHWLuEm9P3yOKeVYWFwauEp
 g/Nsq6kpybLmDs78rwegv9TCe5i8WCHZ3na1AEC/1yr1zOJl9t+n+bbW7fmOwSYok+SM
 s2Z4aFVRbHijF0QCZEcObRYeT3HmNzLCcZNqpnraRTDHClIfALAQKztadYbGEolWRAZX
 456pLiyavt7x4HJp6DhE2BJ9fg/xHbSqtnQVI1fFs1m5M9gG4Dv7tFEbd4r9GAdWS8rR
 7XyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXcg3xBD3JHOzqdXizepYODbzDAVoEgsiMWnHFgN+8u7lVOSogQKfLYl2cXLVz2iFYBIc=@dpdk.org
X-Gm-Message-State: AOJu0YxZOMNcisF6CHEL0yloFKbtIh22s/7GahcUI550YhUwHLW6e85B
 OgRC/RNQR76Y16fbXN/RNMV+e9ix1BVA/+YYiGhHSDIThT7tiJyKFNrRO282JOsCcfxdivadEuq
 EDxS44NkW9gO2RSmuYApKyIeXc9LlnzXDrcsYRrdhEw==
X-Gm-Gg: ASbGnctzdmFScmZvdrGifEcFyj/wj2pYZ2SvCx+RgsOl+f8oKladGnY2SGG9ZQyA5O/
 dcksDqqe/116ygqmWBh427eyGDLiNOtluYB3wixlZnmIoncidco2A7c5hVlrgdL2flU5fV2Ww6v
 Ay+zTIESLEv/Ib9FEz18sU/yp5IX24nfIwpy67ppEQLK46XS5f4CbGt/52ICEMh+Gq/Ob86avQw
 EDWy81yNxOiWvJN91257Nd02q5xntlg1NJ27Pb2K/gYYGUUjjzpFfcWRpPdXOsPo6Kjxg==
X-Google-Smtp-Source: AGHT+IEEIY7RZ7mXgPcTH/Q04HhLTS+6PKUpjfx24KUzP5CRcEN7NtNukEG+JOs+7p/f6OzAE6yRWMcvYqKit7+TtAM=
X-Received: by 2002:a17:902:ea04:b0:270:ea84:3242 with SMTP id
 d9443c01a7336-29027373b53mr446447175ad.15.1760542513619; Wed, 15 Oct 2025
 08:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250929170606.216623-1-abailey@iol.unh.edu>
 <20250929170606.216623-4-abailey@iol.unh.edu>
In-Reply-To: <20250929170606.216623-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 15 Oct 2025 11:34:29 -0400
X-Gm-Features: AS18NWAuhLM7QMUX7DEOTD5hEjK5P8eox8c4Y_qKvlF-Q45l7dYNpNP3Es_iquE
Message-ID: <CAJvnSUCyDjCiwCS2PaocmC3yXHJchoW68YBE3aCiN34nigxjEQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] dts: update tx_offload test from old dts
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 ivan.malov@arknetworks.am,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Content-Type: multipart/alternative; boundary="00000000000022f4460641343f4b"
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

--00000000000022f4460641343f4b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Based on a vote from DPDK tech board today, mbuf_fast_free will remain
enabled by default for 25.11. That means this testsuite needs to be
reversed, i.e. check that mbuf_fast_free is enabled by default, then
attempt to disable and check it's disabled, then attempt to enable and
check that it's enabled.

Otherwise, the series looks good. If you can submit a new version based on
my comment above, we can merge to next-dts.

On Mon, Sep 29, 2025 at 1:06=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:

> Currently, the RX/TX offload test in old DTS expects the TX ports to be
> initially configured to use mbuf fast free. This is no longer the case
> and must be updated to assume mbuf fast free is not initially utilized
> by capable NICs. Add updated test suite to test mbuf fast free
> configuration.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 ++
>  dts/tests/TestSuite_rx_tx_offload.py          | 126 ++++++++++++++++++
>  2 files changed, 134 insertions(+)
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
> index 0000000000..19a8e507f2
> --- /dev/null
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RX TX offload test suite.
> +
> +Test the testpmd feature of configuring RX and TX offloads.
> +"""
> +
> +from api.capabilities import NicCapability, requires_nic_capability
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
> +        port_offload: str | None,
> +        rxtx: RxTxLiteralSwitch,
> +        port_id: int,
> +        /,
> +        queue_offload: list[str | None] | None =3D None,
> +        verify: bool =3D True,
> +    ) -> bool:
> +        config: OffloadConfiguration =3D testpmd.get_offload_config(rxtx=
,
> port_id, verify)
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
> +        self, testpmd: TestPmd, on: bool, port_id: int, num_queues: int,
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
> +            * Toggle mbuf_fast_free on per port.
> +            * Toggle mbuf_fast_free off per port.
> +
> +        Verify:
> +            * Mbuf_fast_free starts disabled.
> +            * Mbuf_fast_free can be configured on per port.
> +            * Mbuf_fast_free can be configured off per port.
> +        """
> +        with TestPmd() as testpmd:
> +            verify =3D True
> +            port_id =3D 0
> +            testpmd.start_all_ports()
> +
> +            # Ensure MBUF_FAST_FREE is disabled by default and verify
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id,
> verify=3Dverify),
> +                "MBUF_FAST_FREE enabled on port start.",
> +            )
> +            # Enable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(True, port_id, verify)
> +            self.verify(
> +                self._check_config(testpmd, "MBUF_FAST_FREE", "tx",
> port_id, verify=3Dverify),
> +                "Failed to enable MBUF_FAST_FREE on port.",
> +            )
> +            # Disable MBUF_FAST_FREE per port and verify
> +            testpmd.set_port_mbuf_fast_free(False, port_id, verify)
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id,
> verify=3Dverify),
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
> +            * Toggle mbuf_fast_free on per queue.
> +            * Toggle mbuf_fast_free off per queue.
> +
> +        Verify:
> +            * Mbuf_fast_free starts disabled.
> +            * Mbuf_fast_free can be configured on per queue.
> +            * Mbuf_fast_free can be configured off per queue.
> +        """
> +        with TestPmd() as testpmd:
> +            verify =3D True
> +            port_id =3D 0
> +            num_queues =3D 4
> +            queue_off: list[str | None] | None =3D [None] * num_queues
> +            queue_on: list[str | None] | None =3D ["MBUF_FAST_FREE"] *
> num_queues
> +
> +            testpmd.set_ports_queues(num_queues)
> +            testpmd.start_all_ports()
> +
> +            # Ensure mbuf_fast_free is disabled by default on port and
> queues
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id,
> queue_off, verify=3Dverify),
> +                "MBUF_FAST_FREE enabled on queue start.",
> +            )
> +            # Enable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, True, port_id,
> num_queues, verify)
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id,
> queue_on, verify),
> +                "Failed to enable MBUF_FAST_FREE on all queues.",
> +            )
> +            # Disable mbuf_fast_free per queue and verify
> +            self._set_all_queues_mbuf_fast_free(testpmd, False, port_id,
> num_queues, verify)
> +            self.verify(
> +                self._check_config(testpmd, None, "tx", port_id,
> queue_off, verify),
> +                "Failed to disable MBUF_FAST_FREE on all queues.",
> +            )
> --
> 2.50.1
>
>

--00000000000022f4460641343f4b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Based on a vote from DPDK tech board today, mbuf_fast_free=
 will remain enabled by default for 25.11. That means this testsuite needs =
to be reversed, i.e. check that mbuf_fast_free is enabled by default, then =
attempt to disable and check it&#39;s disabled, then attempt to enable=C2=
=A0and check that it&#39;s enabled.<div><br></div><div>Otherwise, the serie=
s looks good. If you can submit a new version based on my comment above, we=
 can merge to next-dts.</div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 29, 2025 at =
1:06=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu">ab=
ailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Currently, the RX/TX offload test in old DTS expects the T=
X ports to be<br>
initially configured to use mbuf fast free. This is no longer the case<br>
and must be updated to assume mbuf fast free is not initially utilized<br>
by capable NICs. Add updated test suite to test mbuf fast free<br>
configuration.<br>
<br>
Signed-off-by: Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.unh.edu" tar=
get=3D"_blank">abailey@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/tests.TestSuite_rx_tx_offload.rst |=C2=A0 =C2=A08 ++<br>
=C2=A0dts/tests/TestSuite_rx_tx_offload.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 126 ++++++++++++++++++<br>
=C2=A02 files changed, 134 insertions(+)<br>
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
index 0000000000..19a8e507f2<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_rx_tx_offload.py<br>
@@ -0,0 +1,126 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;RX TX offload test suite.<br>
+<br>
+Test the testpmd feature of configuring RX and TX offloads.<br>
+&quot;&quot;&quot;<br>
+<br>
+from api.capabilities import NicCapability, requires_nic_capability<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_offload: str | None,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxtx: RxTxLiteralSwitch,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_offload: list[str | None] | None =3D Non=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; bool:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config: OffloadConfiguration =3D testpmd.get_o=
ffload_config(rxtx, port_id, verify)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, testpmd: TestPmd, on: bool, port_id: int=
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free on per p=
ort.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free off per =
port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free starts disabled=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed on per port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed off per port.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.start_all_ports()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure MBUF_FAST_FREE is disab=
led by default and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, None, &quot;tx&quot;, port_id, verify=3Dverify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;MBUF_FAST_FR=
EE enabled on port start.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable MBUF_FAST_FREE per port=
 and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_port_mbuf_fast_free(=
True, port_id, verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, &quot;MBUF_FAST_FREE&quot;, &quot;tx&quot;, port_id, verify=3Dver=
ify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to en=
able MBUF_FAST_FREE on port.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable MBUF_FAST_FREE per por=
t and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_port_mbuf_fast_free(=
False, port_id, verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, None, &quot;tx&quot;, port_id, verify=3Dverify),<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free on per q=
ueue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Toggle mbuf_fast_free off per =
queue.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free starts disabled=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed on per queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Mbuf_fast_free can be configur=
ed off per queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmd() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify =3D True<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Ensure mbuf_fast_free is disab=
led by default on port and queues<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, None, &quot;tx&quot;, port_id, queue_off, verify=3Dverify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;MBUF_FAST_FR=
EE enabled on queue start.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Enable mbuf_fast_free per queu=
e and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_all_queues_mbuf_fast_f=
ree(testpmd, True, port_id, num_queues, verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, None, &quot;tx&quot;, port_id, queue_on, verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to en=
able MBUF_FAST_FREE on all queues.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Disable mbuf_fast_free per que=
ue and verify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._set_all_queues_mbuf_fast_f=
ree(testpmd, False, port_id, num_queues, verify)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._check_config=
(testpmd, None, &quot;tx&quot;, port_id, queue_off, verify),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Failed to di=
sable MBUF_FAST_FREE on all queues.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div>

--00000000000022f4460641343f4b--
