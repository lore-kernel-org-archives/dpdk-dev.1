Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AC1CEACCC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 20:45:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 109B0410DC;
	Fri, 14 Nov 2025 21:45:24 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id A901C40E34
 for <dev@dpdk.org>; Fri, 14 Nov 2025 21:45:22 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-297ef378069so24063905ad.3
 for <dev@dpdk.org>; Fri, 14 Nov 2025 12:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763153122; x=1763757922; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ithB6l7palTMTXOA/V/osN/6vL1w/RKETbdQISh/uo=;
 b=ICBXbTp+Pwpa47RItI4mhgvlSj48p5opnatP3qK/dFqqy/0+RBQsqb/RU+FKYJ2OG6
 /GeSpm4xsFjlRf22Xw1wWF2RFsi2WTkjhEnsXmIAotP9yTqNflZKPQHoQmGdVW24DLZS
 4Pp3ZymzEiFG2gDJ0ADS32DxUc6S8LuB0Q1wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763153122; x=1763757922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ithB6l7palTMTXOA/V/osN/6vL1w/RKETbdQISh/uo=;
 b=CJliBNDqcZ3Q1mL1RZCI8Msbx0OxTgBuQZuraYL18DPK3RkmXLy2/iD1oNrsPwDtVg
 WH1bmaktKD+UKLnoFzXoLuEkXquy1yyNtwxxvHEW4gdrRnVhZKEDLm/2wk6HfNj9hjVs
 FdK1NZqF38HwfIcCQw9XW4g1iuR98evULO+ocGlXxoj/IkwBP82PMxUvG2f0nqg9UT1s
 QPx8D6nXxP8dNmEoolFOmQZ0FU+umbTrW8pipf8SCUkLiSrtTfmG42JOEwo6eqFbmw68
 o91z8s5sWgZ3gZig2iIymu/N0l86ETA8dvq/Fc/tb13Zxzkc/uqx2DUQguU/Qu5WwZ/U
 kbDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV1B5PUoPWizBywG8wxgIBnLTWJR/i/VA3JEprtCrdDM598dLZq4qfZOFrkLPIZs/1St0=@dpdk.org
X-Gm-Message-State: AOJu0Yxtom76NuqfzPTSuybFrqvAkpp8CnNLFmCPaww6yhSArQ+w3Wv7
 bsKCv1XOGhTAL67ETafhw+avFDCy082zNJGByy+Hzw5Qvl6aXHDht+0WdZZLbQNx+7kHdXtHQtD
 yyMLkn/AmhMojx+MdgcnnVTZFhZ1L5YIGkULOUX1GYw==
X-Gm-Gg: ASbGncvLbLjIBPxVt34bmCbYOiRvsreOdB6Lfaa4dW0Md1/cQfIg6jEyNj33eN3l6ex
 oO+TnMzorP+ut3BGzVu1Vv6gLScFKvCYjdtmFdKTR4oLIxo7/TOn27FoZoSj35vjDwkGuPqPfKv
 HHGOj/4budPm67f0laHH0K4+BrrmpkaCQyPzGNA4SUatqJYO32yjPnjVCb2e5kfPhI8ZODjFW/x
 ad0kF9rNt1OQU79reiwEWNbSoYbktMMd0jb/GlU6XWRptPULwP0FJBjTMDtfj29x4ue1TGTYPPW
 hL4xJt0S3wTjW9JFjtrXbO/CVoh0
X-Google-Smtp-Source: AGHT+IEPfqlsTOP7Ro3aN97oYKWXyg0IjoLiaR5AZZdWJbm85sJW+7OZQ8v0P7CErtfdup1XOlQdRCBZXFBZA3b2tMg=
X-Received: by 2002:a05:7022:43a6:b0:11a:5065:8763 with SMTP id
 a92af1059eb24-11b40e846d3mr1957891c88.5.1763153114241; Fri, 14 Nov 2025
 12:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20251114185944.337957-1-dmarx@iol.unh.edu>
In-Reply-To: <20251114185944.337957-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 14 Nov 2025 15:43:57 -0500
X-Gm-Features: AWmQ_bk4RXnEa-MWaLthBWE2EjUmPGSX2s5TtjBU4DxXxmAo_7lzcq-fOOco9DQ
Message-ID: <CAJvnSUDTa9jA+52p8TbfNqQbK+s9bDzjo5ZHL6J9DpV_p5zH3w@mail.gmail.com>
Subject: Re: [PATCH v1] dts: update dts.rst with current API status
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000000f2e6206439413e1"
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

--0000000000000f2e6206439413e1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Makes sense, thanks. I'll push it to next-dts.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Fri, Nov 14, 2025 at 1:59=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Rewrite the section of dts.rst outlining use of the DTS
> framework in writing test suites to properly reflect
> the current state of the DTS API and how to use it.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  doc/guides/tools/dts.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst
> index f0abfdcb7a..195e8f752a 100644
> --- a/doc/guides/tools/dts.rst
> +++ b/doc/guides/tools/dts.rst
> @@ -503,20 +503,19 @@ Leveraging the DTS framework in writing testsuites
>
>  One should avoid directly importing DTS framework code to their
> testsuites where possible.
>  Instead, for performing common processes required in testsuites,
> -one should use (or add to) the list of methods provided in the
> ``Testsuite`` class
> -(the base class of all testsuites).
> +one should use (or add to) the list of methods provided in the ``api``
> module.
>
>  For instance, for sending a list of packets,
>  one should work through the packet transmitting function
> -already made available in the ``TestSuite`` class,
> +already made available in the ``api`` module,
>  instead of directly importing the DTS traffic generator class
>  and using that class in one's testsuite implementation.
>  It is also acceptable to import and instantiate classes for various DPDK
> applications.
>  For instance, writing a testsuite for a simple packet forwarding operati=
on
> -would involve importing the DTS ``TestPmd`` class,
> +would involve importing the DTS ``TestPmd`` class from the ``api`` modul=
e,
>  instantiating ``TestPmd``, calling ``TestPmd``'s ``start()`` method,
>  and then sending traffic via one of the traffic transmitting functions
> -exposed in the ``Testsuite`` class.
> +exposed in the ``api`` module.
>
>  Test Case Verification
>  ~~~~~~~~~~~~~~~~~~~~~~
> --
> 2.51.0
>
>

--0000000000000f2e6206439413e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Makes sense, thanks. I&#39;ll push it to next-dts.<div><br=
></div><div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.e=
du">probb@iol.unh.edu</a>&gt;</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14, 20=
25 at 1:59=E2=80=AFPM Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu">dm=
arx@iol.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Rewrite the section of dts.rst outlining use of the DTS<br>
framework in writing test suites to properly reflect<br>
the current state of the DTS API and how to use it.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0doc/guides/tools/dts.rst | 9 ++++-----<br>
=C2=A01 file changed, 4 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/doc/guides/tools/dts.rst b/doc/guides/tools/dts.rst<br>
index f0abfdcb7a..195e8f752a 100644<br>
--- a/doc/guides/tools/dts.rst<br>
+++ b/doc/guides/tools/dts.rst<br>
@@ -503,20 +503,19 @@ Leveraging the DTS framework in writing testsuites<br=
>
<br>
=C2=A0One should avoid directly importing DTS framework code to their tests=
uites where possible.<br>
=C2=A0Instead, for performing common processes required in testsuites,<br>
-one should use (or add to) the list of methods provided in the ``Testsuite=
`` class<br>
-(the base class of all testsuites).<br>
+one should use (or add to) the list of methods provided in the ``api`` mod=
ule.<br>
<br>
=C2=A0For instance, for sending a list of packets,<br>
=C2=A0one should work through the packet transmitting function<br>
-already made available in the ``TestSuite`` class,<br>
+already made available in the ``api`` module,<br>
=C2=A0instead of directly importing the DTS traffic generator class<br>
=C2=A0and using that class in one&#39;s testsuite implementation.<br>
=C2=A0It is also acceptable to import and instantiate classes for various D=
PDK applications.<br>
=C2=A0For instance, writing a testsuite for a simple packet forwarding oper=
ation<br>
-would involve importing the DTS ``TestPmd`` class,<br>
+would involve importing the DTS ``TestPmd`` class from the ``api`` module,=
<br>
=C2=A0instantiating ``TestPmd``, calling ``TestPmd``&#39;s ``start()`` meth=
od,<br>
=C2=A0and then sending traffic via one of the traffic transmitting function=
s<br>
-exposed in the ``Testsuite`` class.<br>
+exposed in the ``api`` module.<br>
<br>
=C2=A0Test Case Verification<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--0000000000000f2e6206439413e1--
