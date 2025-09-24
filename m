Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F27CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C41940658;
	Wed, 24 Sep 2025 22:53:57 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 86E244064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:53:55 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2445806e03cso3088995ad.1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1758747234; x=1759352034; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SZ6zVahdG+7ZciiH9ans8ZTRMcnRC4eVTJ77FT2l29A=;
 b=OYWFJiBS/k/Iy02qq7n6wfpJXGAVQtPaHKzHPV+uQcixtvO1RlwBNZTA7ZaaT4H+U1
 lGsT8ldKc5dTzsUlRIknDLCWytk/PvXo673FXUrW4/EePSAmij+YnUF+pSTMj9gEniPZ
 ebOqxWZl6/u+Wy6NzR2wUq/iN/UOhp/74EkJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758747234; x=1759352034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZ6zVahdG+7ZciiH9ans8ZTRMcnRC4eVTJ77FT2l29A=;
 b=M21VCk/dZ4gp7kM/Qg4F4FZN+sdOsW7tZ7XgvSYwBiOva4IsdghltXKpc+XLRvvHvY
 jU6qLNdCsAJfx44++ilM8G14GpacL7RlcR7WTbnOku6Yxc/92RI9F/2kHGvir6QAFMI+
 v9fCJqSaguDEOn4opZa/Wl5RBK7tSBRmER57aqrYb0wxjvaIfy1dXEq7OYSYQKdvNa/A
 xth8KCzSOaqN9mDxuoQ2GJJdmbnnay2eqGuuUAHlk1AMxUGNuceW8WrGOijxiq1QZCIS
 Xejrr6FvlQn19BssVdrD5Jf3f35AhtvK6SsDUo807v1mlld95EoOXXFrpbBsCfqk12EA
 6bVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5wvWuAf2DLMwPnJ+RK2XLx2zwpbpAHEjJhivnWG2TF7n9CCkXMzA2wINQhlivby3zqTk=@dpdk.org
X-Gm-Message-State: AOJu0Yw46TStAUgmIFZstKzrgFlyLUDDpw5MnjeiJkQzllnCpMRpHMsO
 B+cZE+CblQ2cMaAjb8xSphzYxcht/IQj/8Rh34fw9KDcZsxEU1wUFjaYWR9hEsFWzpAIFdbUWcX
 BFsfqzzLxd+R9CZ5rZlbRBJcA6se2BXLpnjm7Q2Pxvg==
X-Gm-Gg: ASbGncuhXTwVnyOCoa53Og69L1506drA3JdEToyL2pxrKojW59CXTJxYeSA3WX+P09f
 0RCO+4pf4+g6VD/aa0G9Jy1EIAV/QQZ5kbUET6nIdo/COCSQP0rI+ocZSGhDwoa2vuU7fcnfAkm
 BQlgbH2Rl0TyWCVDb9vpeYxEoCy3GAcU2cyA9XszdUsU983caLHeCvI8xO9UPsb9PTmeDWPU9VP
 oQHOb4YYzln3E+prVHFeuQzLxIpmUE3Xb6ScCCQ
X-Google-Smtp-Source: AGHT+IFi0HOpsHMqR/iq29mEmIWYbAyIkFrDh1g36zxYENU6bppwjM8J5RzDZtHQdo9kX31ECJhVb3q5fnvM+IgG56k=
X-Received: by 2002:a17:902:d507:b0:265:982a:d450 with SMTP id
 d9443c01a7336-27ed4a492e2mr10064725ad.40.1758747234559; Wed, 24 Sep 2025
 13:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250902114327.48185-1-abailey@iol.unh.edu>
 <20250924164725.168773-1-abailey@iol.unh.edu>
 <20250924164725.168773-4-abailey@iol.unh.edu>
In-Reply-To: <20250924164725.168773-4-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 24 Sep 2025 16:53:32 -0400
X-Gm-Features: AS18NWB4jKNFsgpOUE1_sxxA1pCIdwcbIAvwUeoqUesMiyw96L7Sh_J30GI7s3A
Message-ID: <CAJvnSUDPpfr_AqQM5wtf2WSG5j6v6auXbHYx3DHyiZ12C51gSg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dts: update tx_offload test from old dts
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 ivan.malov@arknetworks.am
Content-Type: multipart/alternative; boundary="0000000000002a7625063f9240a3"
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

--0000000000002a7625063f9240a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 12:47=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu=
> wrote:

> Currently, the RX/TX offload test in old DTS expects the TX ports to be
> initially configured to use mbuf fast free. This is no longer the case
> and must be updated to assume mbuf fast free is not initially utilized
> by capable NICs. Add updated test suite to test mbuf fast free
> configuration.
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>
> ---
>  doc/api/dts/tests.TestSuite_rx_tx_offload.rst |   8 ++
>  dts/tests/TestSuite_rx_tx_offload.py          | 128 ++++++++++++++++++
>  2 files changed, 136 insertions(+)
>  create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst
>  create mode 100644 dts/tests/TestSuite_rx_tx_offload.py
>
> diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
> b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
> new file mode 100644
> index 0000000000..225267a45f
> --- /dev/null
> +++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: BSD-3-Clause
> +
> +rx_tx_offload Test Suite
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>

Did you try to build the docs after adding this file? I might be wrong but
I think the syntax might be flawed. If you don't remember the docs build
process is:

meson setup build
ninja -C build doc


> +
> +.. automodule:: tests.TestSuite_rx_tx_offload
> +   :members:
> +   :show-inheritance:
> \ No newline at end of file
> diff --git a/dts/tests/TestSuite_rx_tx_offload.py
> b/dts/tests/TestSuite_rx_tx_offload.py
> new file mode 100644
> index 0000000000..6ae98068e4
> --- /dev/null
> +++ b/dts/tests/TestSuite_rx_tx_offload.py
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 University of New Hampshire
> +
> +"""RX TX offload test suite.
> +
> +Test the testpmd feature of configuring RX and TX offloads.
> +"""
> +
> +from framework.remote_session.testpmd_shell import (
> +    OffloadConfiguration,
> +    RxTxLiteralSwitch,
> +    TestPmdShell,
> +)
>

your branch needs to be rebased off of dpdk-next-dts/for-main. We have
merged Paul's DTS API patch, which means your imports are no longer valid
and will need to be updated.


> +from framework.test_suite import TestSuite, func_test
> +from framework.testbed_model.capability import NicCapability, requires
> +
> +
> +class TestRxTxOffload(TestSuite):
> +    """RX/TX offload test suite."""
> +
> +    def _check_config(
> +        self,
> +        testpmd: TestPmdShell,
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
> +        self, testpmd: TestPmdShell, on: bool, port_id: int, num_queues:
> int, /, verify: bool =3D True
> +    ) -> None:
> +        for i in range(num_queues):
> +            testpmd.set_queue_mbuf_fast_free(on, port_id, i, verify)
> +
> +    @requires(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE)
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
> +        with TestPmdShell() as testpmd:
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
> +                self._check_config(
> +                    testpmd, "TX_OFFLOAD_MBUF_FAST_FREE", "tx", port_id,
> verify=3Dverify
> +                ),
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
> +    @requires(NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE)
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
> +        with TestPmdShell() as testpmd:
> +            verify =3D True
> +            port_id =3D 0
> +            num_queues =3D 4
> +            queue_off: list[str | None] | None =3D [None] * num_queues
> +            queue_on: list[str | None] | None =3D
> ["TX_OFFLOAD_MBUF_FAST_FREE"] * num_queues
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
Let's look at the testcases themselves together tomorrow or Friday. Thanks
Andrew.

--0000000000002a7625063f9240a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 24,=
 2025 at 12:47=E2=80=AFPM Andrew Bailey &lt;<a href=3D"mailto:abailey@iol.u=
nh.edu">abailey@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Currently, the RX/TX offload test in old DTS exp=
ects the TX ports to be<br>
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
=A0 | 128 ++++++++++++++++++<br>
=C2=A02 files changed, 136 insertions(+)<br>
=C2=A0create mode 100644 doc/api/dts/tests.TestSuite_rx_tx_offload.rst<br>
=C2=A0create mode 100644 dts/tests/TestSuite_rx_tx_offload.py<br>
<br>
diff --git a/doc/api/dts/tests.TestSuite_rx_tx_offload.rst b/doc/api/dts/te=
sts.TestSuite_rx_tx_offload.rst<br>
new file mode 100644<br>
index 0000000000..225267a45f<br>
--- /dev/null<br>
+++ b/doc/api/dts/tests.TestSuite_rx_tx_offload.rst<br>
@@ -0,0 +1,8 @@<br>
+.. SPDX-License-Identifier: BSD-3-Clause<br>
+<br>
+rx_tx_offload Test Suite<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br></blockquote><div><br></div><div>Did you try to build the docs after=
 adding this file? I might be wrong but I think the syntax might be flawed.=
 If you don&#39;t remember the docs build process is:</div><div><br></div><=
div>meson setup build</div><div>ninja -C build doc</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+.. automodule:: tests.TestSuite_rx_tx_offload<br>
+=C2=A0 =C2=A0:members:<br>
+=C2=A0 =C2=A0:show-inheritance:<br>
\ No newline at end of file<br>
diff --git a/dts/tests/TestSuite_rx_tx_offload.py b/dts/tests/TestSuite_rx_=
tx_offload.py<br>
new file mode 100644<br>
index 0000000000..6ae98068e4<br>
--- /dev/null<br>
+++ b/dts/tests/TestSuite_rx_tx_offload.py<br>
@@ -0,0 +1,128 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 University of New Hampshire<br>
+<br>
+&quot;&quot;&quot;RX TX offload test suite.<br>
+<br>
+Test the testpmd feature of configuring RX and TX offloads.<br>
+&quot;&quot;&quot;<br>
+<br>
+from framework.remote_session.testpmd_shell import (<br>
+=C2=A0 =C2=A0 OffloadConfiguration,<br>
+=C2=A0 =C2=A0 RxTxLiteralSwitch,<br>
+=C2=A0 =C2=A0 TestPmdShell,<br>
+)<br></blockquote><div><br></div><div>your branch needs to be rebased off =
of dpdk-next-dts/for-main. We have merged Paul&#39;s DTS API patch, which m=
eans your imports are no longer valid and will need to be updated.</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+from framework.test_suite import TestSuite, func_test<br>
+from framework.testbed_model.capability import NicCapability, requires<br>
+<br>
+<br>
+class TestRxTxOffload(TestSuite):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;RX/TX offload test suite.&quot;&quot;&quot=
;<br>
+<br>
+=C2=A0 =C2=A0 def _check_config(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmdShell,<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, testpmd: TestPmdShell, on: bool, port_id=
: int, num_queues: int, /, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(num_queues):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.set_queue_mbuf_fast_free=
(on, port_id, i, verify)<br>
+<br>
+=C2=A0 =C2=A0 @requires(NicCapability.PORT_TX_OFFLOAD_MBUF_FAST_FREE)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
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
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test=
pmd, &quot;TX_OFFLOAD_MBUF_FAST_FREE&quot;, &quot;tx&quot;, port_id, verify=
=3Dverify<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ),<br>
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
+=C2=A0 =C2=A0 @requires(NicCapability.QUEUE_TX_OFFLOAD_MBUF_FAST_FREE)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_queues =3D 4<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_off: list[str | None] | No=
ne =3D [None] * num_queues<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_on: list[str | None] | Non=
e =3D [&quot;TX_OFFLOAD_MBUF_FAST_FREE&quot;] * num_queues<br>
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
<br></blockquote><div><br></div><div>Let&#39;s look at the testcases themse=
lves together tomorrow=C2=A0or Friday. Thanks Andrew.</div><div>=C2=A0</div=
></div></div>

--0000000000002a7625063f9240a3--
