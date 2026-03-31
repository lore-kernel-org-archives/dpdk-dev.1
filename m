Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D323510F92E5
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4372406FF;
	Tue, 31 Mar 2026 18:16:51 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id BEF5D40615
 for <dev@dpdk.org>; Tue, 31 Mar 2026 18:16:50 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-126ea4b77adso8371543c88.1
 for <dev@dpdk.org>; Tue, 31 Mar 2026 09:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774973810; cv=none;
 d=google.com; s=arc-20240605;
 b=dPTXsYGr5nNjsQFCXl5Sltt69cYZvdcu0FhzJXSsXYl04u0bq7zHFaDLMKuhwFWi7j
 ldLW52bPkGuOZCcwEBtWhaHXCHnR7JJod96guEYHl+PggAXzZHCsH/Ko+Gx71Oze4xfS
 4M+P5a9THyYN1Q5L0dbxJtyNtb8m6RThJ91NrXYrhAjsdXHRIVy26S6hN0KRb/6LNeHn
 lHyeqNPnIFGMzHUar5jT+PNPUmPWTBmQf2TCwIHR33RlLDRvcRwXPJwLHrRHr3dPgpN7
 PGrZ0zb+o0Bi2Yc9hiZd9DKJJjN8e9nmbU7ceal2RWfqidUJpUxOsMt/4rV2je3iEVMH
 2Bog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UhFq8J9zg4pYjsj6qxH73ARBcMlFsotKYsEInetcYmA=;
 fh=cggnm/Jm5NfhkXDTVfPSL7R/tlOioTQdwGyIvVBrVqQ=;
 b=INwz7gNtQTCJpxf1nDljP5LfJhJPYdxmjXbnoo/jZrvxxKTC0pcV/S3PUvpljQoHkl
 qUIPKCIB1qZt/sjmBISawp7vzlKx6ZTW++/bWZ2pjRxzp0ZhB4HitBEstSthVPAFq4ag
 S81aS6FiHzs02A/c3g0LUHvcbVw9+sRm6KHzlIV4MHmIKhit2HhJqwnu8Myz7xctjtQ/
 ep9Vi5VLVw+qvMsjA8TkxR5yQLwc9UsWTLJB68hBthjxI5svdUhVo84nXSclFvxAPiNl
 sk5Hq6W6oLtamC4yO0L+0c3dG9fOZ22fs2wWP3nGEdJWpe7l8bdiAB59BI7AOKwVN9yz
 KW8w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774973810; x=1775578610; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UhFq8J9zg4pYjsj6qxH73ARBcMlFsotKYsEInetcYmA=;
 b=hdsfT3///O9o4qmTiqiY4JOSubFceyojZ8sP9KSU7Ph7xFa1qAgZMSvlsPUech5n8b
 EWlsYNsl0cVMbYk1TYBioe9BTMQjhqKRFwbyH2k2azyYbb92wCdxkleY3OfFf3RKEYZ/
 aTohY0RkI2qIlBLxQpxQPev3c24KbrB+er0Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774973810; x=1775578610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhFq8J9zg4pYjsj6qxH73ARBcMlFsotKYsEInetcYmA=;
 b=qdlVBzyxOobCipNM1eYS3PjPLnOcmnpIXVQpl5DwaxWJNF/v/KiIIeqaw8zimEFu/N
 Uvx/z2WdVCEnH9hmIQ2yyOAhd6EHWrKLiVu1aBPg0ihTVbjQvtCol8C+LzaQK23u6PM9
 ADTJ6CLZzzvsBlr5F009EdsHFgIisL00UVIByd8ziTn0RayRb9i+YPmQHzQ5c36VX2k2
 iQxVJaLP5zwQm6BsMezY+VC94vFn8vS8TyzI5wOfk+axpsgUHQ/EMIJq2V2UcHGsljp3
 DIXWQnojHMWnXccfGBbUGcAjxa5SEbL0taEO9vP9fnK3bpb9i27lWaE5OmHj7yLbttST
 Iz2A==
X-Gm-Message-State: AOJu0YwoHSZtoAxOWDa7OQaGrgjZnhla2s6DZjhzrnDMJu/eAM+bzWq2
 JV1wu17qViRG9LjM1u6Ib0w74Hj5IIONPHS182IyHnoxFzIH+YJuS1+852lGADYIPvlMSTuohy8
 qA5604zYx7YkG/CrTplB5nbr40/tMZ5CLJbGlL8qDF0uyWNnLL1IWr/k=
X-Gm-Gg: ATEYQzx9Tu+DwHL43onLiDKQYvsqgJu1D68r4HjNxujmwvVc/ypSMENjKWhc/toyxZg
 UVI1Ke7oMZywDlAphrWwzhcvnwkSlDFfUGjy6Fc8Lpi+DeFXBAEzUlIOsMyCVkCXQGjV8jCXzg5
 Z+Na+9r4Sh71koD5uw1hE2wCozx5KNEyp97XycxYKRQDJaxuhy9j+ODQ8gPwjTL3nbcJC+mzaIv
 1Uq01VI40YDFYZoNOo7u8lgbqP5cgCAVB8cL/T9IvXY3sZWZevPhc80GMWE4gDLtQnUKINaBC3Z
 mBUsH85LL6S8bglwFlY2Ow1bDukZT60OkhkweuFI+pLw/RZniBx+bC2/p7025iB0nHgi/LpOdJF
 NUfsKjiM=
X-Received: by 2002:a05:7022:e19:b0:128:bd5b:61f6 with SMTP id
 a92af1059eb24-12be657a69fmr27409c88.35.1774973809615; Tue, 31 Mar 2026
 09:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260331161253.462180-1-thomas@monjalon.net>
In-Reply-To: <20260331161253.462180-1-thomas@monjalon.net>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 31 Mar 2026 12:13:26 -0400
X-Gm-Features: AQROBzAZkoMiUuFEsJHJ73QwMjFY1LcYxIuaXnfSzKR6TPLZYGMzqxJ6qVw7bBE
Message-ID: <CAJvnSUACPMwpZr+QEYp=rj3gvQwg4=6Y=1AHmsjVDgiLLJ1_uQ@mail.gmail.com>
Subject: Re: [PATCH] dts: fix Sphinx parsing of a docstring
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000687618064e544b38"
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

--000000000000687618064e544b38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Thomas for fixing this.

I had done a manual doc build (and checked the doc builds from CI) before
merging patches to next-dts, so I suppose my Sphinx version must be less
than 9.1.0. I can check this when I do my next doc build.

On Tue, Mar 31, 2026 at 12:13=E2=80=AFPM Thomas Monjalon <thomas@monjalon.n=
et>
wrote:

> With Sphinx 9.1.0, the word "ports" is wrongly parsed as a reference,
> and the doc fails to generate.
> Splitting the docstring (as the next one) seems to be a workaround.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  dts/api/testpmd/config.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py
> index e71a3e1ef0..1e59bccd08 100644
> --- a/dts/api/testpmd/config.py
> +++ b/dts/api/testpmd/config.py
> @@ -30,7 +30,8 @@
>  class PortTopology(StrEnum):
>      """Enum representing the port topology."""
>
> -    #: In paired mode, the forwarding is between pairs of ports, e.g.:
> (0,1), (2,3), (4,5).
> +    #: In paired mode, the forwarding is between pairs of ports, e.g.:
> +    #: (0,1), (2,3), (4,5).
>      paired =3D auto()
>
>      #: In chained mode, the forwarding is to the next available port in
> the port mask, e.g.:
> --
> 2.53.0
>
>

--000000000000687618064e544b38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Thomas for fixing this.<div><br></div><div>I had do=
ne a manual doc build (and checked the doc builds from CI) before merging p=
atches to next-dts, so I suppose my Sphinx version must be less than 9.1.0.=
 I can check this when I do my next doc build.</div></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Mar 31, 2026 at 12:13=E2=80=AFPM Thomas Monjalon &lt;<a href=3D"mail=
to:thomas@monjalon.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">With Sphinx 9.1.0, the word &quo=
t;ports&quot; is wrongly parsed as a reference,<br>
and the doc fails to generate.<br>
Splitting the docstring (as the next one) seems to be a workaround.<br>
<br>
Signed-off-by: Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" t=
arget=3D"_blank">thomas@monjalon.net</a>&gt;<br>
---<br>
=C2=A0dts/api/testpmd/config.py | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/dts/api/testpmd/config.py b/dts/api/testpmd/config.py<br>
index e71a3e1ef0..1e59bccd08 100644<br>
--- a/dts/api/testpmd/config.py<br>
+++ b/dts/api/testpmd/config.py<br>
@@ -30,7 +30,8 @@<br>
=C2=A0class PortTopology(StrEnum):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Enum representing the port topology.&=
quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 #: In paired mode, the forwarding is between pairs of ports,=
 e.g.: (0,1), (2,3), (4,5).<br>
+=C2=A0 =C2=A0 #: In paired mode, the forwarding is between pairs of ports,=
 e.g.:<br>
+=C2=A0 =C2=A0 #: (0,1), (2,3), (4,5).<br>
=C2=A0 =C2=A0 =C2=A0paired =3D auto()<br>
<br>
=C2=A0 =C2=A0 =C2=A0#: In chained mode, the forwarding is to the next avail=
able port in the port mask, e.g.:<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>

--000000000000687618064e544b38--
