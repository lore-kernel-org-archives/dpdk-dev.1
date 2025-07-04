Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1026C83030
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 01:59:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBECA4028B;
	Fri,  4 Jul 2025 03:59:41 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id B6C2F4027D
 for <dev@dpdk.org>; Fri,  4 Jul 2025 03:59:40 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-af51596da56so407236a12.0
 for <dev@dpdk.org>; Thu, 03 Jul 2025 18:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751594380; x=1752199180; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XwiOfC47deguemybLWtTpgbrZaIqNfdb8VgjH7jrfyw=;
 b=Qz7xXBk9uT645NyGFfLExJshN+5qmtU3gzcr0G1iLFNwR4HPO+KQ0PxigCeefPzN0S
 XEqXh7EuyhWRki8/rpXLJ+WgRb7G/CauVA8/+1N9A69ZgbOK8BZhbiH42Xw2tiiwvNG3
 URGiDVzjdXPPwihy2LL9M7i757im4u7axmHcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751594380; x=1752199180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XwiOfC47deguemybLWtTpgbrZaIqNfdb8VgjH7jrfyw=;
 b=bFl+fc/O3j2d48ZLCo61wH0l9s2/m6wB7i6m+9mR6IvaZh6doknfpDyv4FMTvRaITK
 mSZbdv2DLB/TE52ecwjNumS4Pxwc9BOSWgxj15oQyhMDto3U3GBwYhWseTqI87nDlmBB
 sT9CCAkfB+eR270mi37mW4vXW63/rd2aD0QV+wmO2IJ+k6CgtOiAFPoWALckZt5twYrU
 mFhEQPEnj/ycU1nl3xIHPEhh2EezQJ9D0Okup2HEh0+5OUuzR7jy4u4pDLib4ymUA9kL
 Mm1sHFzLJSwzPQwC7DWKIHtJk83Xc+01IuCoWudG5skAgWClIJsIigZlGwkBK53s8UFE
 jljg==
X-Gm-Message-State: AOJu0YwmuhM/ZF7sDo30MXwzil2K/U9qBppKrBk3WheklU+u2a8d/HCA
 yvKDynJqa/VB2q9ldW/l7tlPYlfELHa/GIVVHKDTr/Bej5Kv6QIp9sWpgLBsFqNbnVBXDYAsyok
 dRXXJltr0uDuPtSKKpPyc91jJEjzwpXIVt0jZI2nIOd8ie1Oo97I9
X-Gm-Gg: ASbGncs6RR7fUsL/LBiWHqcqjqLodG+A8a2LuPDSDXozHmm5EAxCjGish/lAXaCsRbA
 lPLC7dLFbbTc0aPgZYy2uKwoJejJR/gQ+wcwAKL6C0MbrJBSRfBZ4wj097bDAWSAWxwlsVEZO9x
 L4uxI3e3P+Hg11nv825xf6pnh1l5+CA0W5ogFlHHRE6dmWDRHNAqkFTr30osE=
X-Google-Smtp-Source: AGHT+IHsDgtJ4H3d3cAXUls42UuOL+hGAb0ScW6zNcfc4+/S/+mXUyiOCbr2vlSLAFQQE3eSUXbsO2smW8E9FjE5mM0=
X-Received: by 2002:a17:90b:3b44:b0:311:a314:c2d1 with SMTP id
 98e67ed59e1d1-31aadcf8350mr480075a91.6.1751594379656; Thu, 03 Jul 2025
 18:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250627151241.335114-1-thomas.wilks@arm.com>
 <20250627151241.335114-2-thomas.wilks@arm.com>
In-Reply-To: <20250627151241.335114-2-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Jul 2025 21:54:02 -0400
X-Gm-Features: Ac12FXwNsw7JZRhxRkGy1zz0F5UFEj4RxX5MitLtdhzxgHqGZnn6v-Ul55lJIxI
Message-ID: <CAJvnSUDwxW6hkWk+xmKpEW+XtAfAJ5DGw3iwG2sCK+7unBzaHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: change test suite name property
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000ca5598063910d876"
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

--000000000000ca5598063910d876
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Fri, Jun 27, 2025 at 11:12=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:

> From: Luca Vizzarro <luca.vizzarro@arm.com>
>
> The test suite name property was previously returning the class name
> instead of the way that test suite are actually named, e.g.
> TestHelloWorld instead of hello_world.
>
> This change rectifies this inconsistency.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
> ---
>  dts/framework/test_suite.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
> index 145b79496f..d4e06a567a 100644
> --- a/dts/framework/test_suite.py
> +++ b/dts/framework/test_suite.py
> @@ -110,8 +110,11 @@ def __init__(self, config: BaseConfig):
>
>      @property
>      def name(self) -> str:
> -        """The name of the test suite class."""
> -        return type(self).__name__
> +        """The name of the test suite."""
> +        module_prefix =3D (
> +
> f"{TestSuiteSpec.TEST_SUITES_PACKAGE_NAME}.{TestSuiteSpec.TEST_SUITE_MODU=
LE_PREFIX}"
> +        )
> +        return type(self).__module__[len(module_prefix) :]
>
>      @property
>      def topology(self) -> Topology:
> --
> 2.43.0
>
>

--000000000000ca5598063910d876
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.=
unh.edu">probb@iol.unh.edu</a>&gt;</div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 27, 202=
5 at 11:12=E2=80=AFAM Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.c=
om">thomas.wilks@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">From: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizz=
arro@arm.com" target=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
<br>
The test suite name property was previously returning the class name<br>
instead of the way that test suite are actually named, e.g.<br>
TestHelloWorld instead of hello_world.<br>
<br>
This change rectifies this inconsistency.<br>
<br>
Signed-off-by: Luca Vizzarro &lt;<a href=3D"mailto:luca.vizzarro@arm.com" t=
arget=3D"_blank">luca.vizzarro@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/framework/test_suite.py | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py<br>
index 145b79496f..d4e06a567a 100644<br>
--- a/dts/framework/test_suite.py<br>
+++ b/dts/framework/test_suite.py<br>
@@ -110,8 +110,11 @@ def __init__(self, config: BaseConfig):<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def name(self) -&gt; str:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The name of the test suite c=
lass.&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return type(self).__name__<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;The name of the test suite.&=
quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 module_prefix =3D (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{TestSuiteSpec.TEST_SUITE=
S_PACKAGE_NAME}.{TestSuiteSpec.TEST_SUITE_MODULE_PREFIX}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return type(self).__module__[len(module_prefix=
) :]<br>
<br>
=C2=A0 =C2=A0 =C2=A0@property<br>
=C2=A0 =C2=A0 =C2=A0def topology(self) -&gt; Topology:<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000ca5598063910d876--
