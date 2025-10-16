Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE0DCCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:37:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA15540A71;
	Thu, 16 Oct 2025 13:37:27 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id E152840269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:37:25 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b5507d3ccd8so498949a12.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760614645; x=1761219445; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d0Fhmb2IAXPSK/TH55ht2s52dprlkQipHDVYsmyIOLs=;
 b=U4+3OVO+rviVFhq4WFMp5wNbwVOdWKGf7+NxYo8sXw0XOl7AtpEVnMjPEH94irpeFH
 fOngG4nYLzMt+wNPf8JMVzil5WsRbhWrGfGvnc0pAJkKfjrbhyCPtOIz3wvtNHlSEmPu
 ogKTw6bszA24O2JUj0tKyHL7L+qvNgZkR1nrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760614645; x=1761219445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d0Fhmb2IAXPSK/TH55ht2s52dprlkQipHDVYsmyIOLs=;
 b=FxgSkzmCd8GFRxKmdmFc0PKgQzJ0Bw4euIQdkNLrnhLTOHq8FzZsuSz1AgG3epRd6K
 avVAp2bnw21PP3ChUePDBDpbG+PLJY1tZIHbRcKHbpIZrU7CuksicZ2uV7M+sEYzzHTn
 GnpFi+UKzsnLgdVFYSovb9bAYmkRf9PQNpTXpf9AHajCsGE2fxovhwHeAipHna7+gqvO
 MX/UHUzHAhrPRBE7TJcxhIT3awg0l5lpR1GIACYqsVy6Y6UjAXvnpf41TrVqMi49pJL0
 7uKGDsZ7KX8whFwXgIEgEbDfqB1OLILBWEY8Y73S2Chw0MgWRFiZbVedjO6bAictmCst
 zxfw==
X-Gm-Message-State: AOJu0YxrtcRssImPnWwNl1Zf+2F+LRHNTxsFjTfB5PesHE5f8NsYllIx
 ByVGP5BEy8zyHg5od4NoVDifVr0+H7KYstWP996+JzHlfNwc5TRTrspyOxSG7U8wLkBYb+pLWOT
 JjUn2dHAy2VzPE2nxxibZqzyvw6M+gdEjx7g7sIVbYWIfoebDD9hMI8o=
X-Gm-Gg: ASbGncuI05hRc1dPS+OZzodDAbsr6x6GYko2alLKvoeGtr4ly5KDpaRlJHzehnTSa7e
 eobfyIeVscj21OPXaa3oUJeom8XDs1lbEbEyLzvmg7i8h/0EyBWH3YsAUWmQuPwNKTw7vkcxiUi
 eiBs9vdvrbn4SFXbl3yRzyecWv7vkdqm89sEVUpd3inkdmmoIPq6eJWuB6sYSM+ZmU+tFm2jWzE
 hW5Wlo9WVUO9uo5mQUizYp2ubyrcBKkpVF9dyHmrrScWGkP7Exe4kQ+u9Ovnlj3mBCVH2/S8dPJ
 9+FYm2MxsscJL84B
X-Google-Smtp-Source: AGHT+IHo/APpXyk7ESfkCTA57Sre14e95ZC6tWA6m+XYs/+xnLDxqnu4nXHQF1t6yT+6cCNFa4/g5n2wD77ISExl1NI=
X-Received: by 2002:a17:903:1b0b:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-290272c1ab0mr432499695ad.35.1760614644563; Thu, 16 Oct 2025
 04:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250923103758.3192015-1-paul.szczepanek@arm.com>
 <20250923103758.3192015-2-paul.szczepanek@arm.com>
In-Reply-To: <20250923103758.3192015-2-paul.szczepanek@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 16 Oct 2025 07:36:38 -0400
X-Gm-Features: AS18NWBQXIYu39BL0xK5JVQ-u2cKWVsw5e0RVDQ2knJYvM5LQGi5P2N21aOTWKc
Message-ID: <CAJvnSUAQGDn3RJ5=JKmeU6maJiB1Fu4-9CgpTB89OZg_cdorbA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dts: add packet handling and test utilities to API
To: Paul Szczepanek <paul.szczepanek@arm.com>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="00000000000079cff40641450a56"
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

--00000000000079cff40641450a56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:38=E2=80=AFAM Paul Szczepanek <paul.szczepanek@ar=
m.com>
wrote:

> Split TestSuite methods between test run methods
> and packet related methods.
>
> Depends-on: series-36111 ("Split DTS framework and public API")
>
> Signed-off-by: Paul Szczepanek <paul.szczepanek@arm.com>
> Reviewed-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  doc/api/dts/api.packet.rst  |   8 +
>  doc/api/dts/api.rst         |   4 +-
>  doc/api/dts/api.test.rst    |   8 +
>  doc/guides/tools/dts.rst    |   2 +-
>  dts/api/packet.py           | 311 ++++++++++++++++++++++++++++++++++++
>  dts/api/test.py             | 126 +++++++++++++++
>  dts/framework/test_suite.py | 305 +----------------------------------
>  7 files changed, 460 insertions(+), 304 deletions(-)
>  create mode 100644 doc/api/dts/api.packet.rst
>  create mode 100644 doc/api/dts/api.test.rst
>  create mode 100644 dts/api/packet.py
>  create mode 100644 dts/api/test.py
>
> diff --git a/dts/api/packet.py b/dts/api/packet.py
> new file mode 100644
> index 0000000000..bf6f3e1be8
> --- /dev/null
> +++ b/dts/api/packet.py
> @@ -0,0 +1,311 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""Features common to all test suites.
> +
> +The module defines the :class:`TestSuite` class which doesn't contain an=
y
> test cases, and as such
> +must be extended by subclasses which add test cases. The
> :class:`TestSuite` contains the basics
> +needed by subclasses:
> +
> +    * Testbed (SUT, TG) configuration,
> +    * Packet sending and verification,
> +    * Test case verification.
> +"""
>

It looks like this docstring is taken directly from the old test_suite.py
and needs to be updated.


> +
>
>
Looks good overall, I think we can merge when the docstring update is sent.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--00000000000079cff40641450a56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 23,=
 2025 at 6:38=E2=80=AFAM Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepa=
nek@arm.com">paul.szczepanek@arm.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Split TestSuite methods between test ru=
n methods<br>
and packet related methods.<br>
<br>
Depends-on: series-36111 (&quot;Split DTS framework and public API&quot;)<b=
r>
<br>
Signed-off-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.co=
m" target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
Reviewed-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" tar=
get=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
---<br>
=C2=A0doc/api/dts/api.packet.rst=C2=A0 |=C2=A0 =C2=A08 +<br>
=C2=A0doc/api/dts/api.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 =
+-<br>
=C2=A0doc/api/dts/api.test.rst=C2=A0 =C2=A0 |=C2=A0 =C2=A08 +<br>
=C2=A0doc/guides/tools/dts.rst=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0dts/api/packet.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 311 +++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0dts/api/test.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 126 =
+++++++++++++++<br>
=C2=A0dts/framework/test_suite.py | 305 +----------------------------------=
<br>
=C2=A07 files changed, 460 insertions(+), 304 deletions(-)<br>
=C2=A0create mode 100644 doc/api/dts/api.packet.rst<br>
=C2=A0create mode 100644 doc/api/dts/api.test.rst<br>
=C2=A0create mode 100644 dts/api/packet.py<br>
=C2=A0create mode 100644 dts/api/test.py<br><br>
diff --git a/dts/api/packet.py b/dts/api/packet.py<br>
new file mode 100644<br>
index 0000000000..bf6f3e1be8<br>
--- /dev/null<br>
+++ b/dts/api/packet.py<br>
@@ -0,0 +1,311 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 Arm Limited<br>
+<br>
+&quot;&quot;&quot;Features common to all test suites.<br>
+<br>
+The module defines the :class:`TestSuite` class which doesn&#39;t contain =
any test cases, and as such<br>
+must be extended by subclasses which add test cases. The :class:`TestSuite=
` contains the basics<br>
+needed by subclasses:<br>
+<br>
+=C2=A0 =C2=A0 * Testbed (SUT, TG) configuration,<br>
+=C2=A0 =C2=A0 * Packet sending and verification,<br>
+=C2=A0 =C2=A0 * Test case verification.<br>
+&quot;&quot;&quot;<br></blockquote><div><br></div><div>It looks like this =
docstring is taken directly from the old test_suite.py and needs to be upda=
ted.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br><br></blockquote><div><br></div><div>Looks good overall, I think we ca=
n merge when the docstring update is sent.</div><div><br></div><div>Reviewe=
d-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu">probb@iol.unh.e=
du</a>&gt;=C2=A0</div></div></div>

--00000000000079cff40641450a56--
