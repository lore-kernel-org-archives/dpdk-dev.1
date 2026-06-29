Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB84BC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 22:37:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E524021E;
	Tue, 30 Jun 2026 00:37:43 +0200 (CEST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0731C40150
 for <dev@dpdk.org>; Tue, 30 Jun 2026 00:37:42 +0200 (CEST)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-39af6402933so24681951fa.2
 for <dev@dpdk.org>; Mon, 29 Jun 2026 15:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782772661; cv=none;
 d=google.com; s=arc-20260327;
 b=nOdBTKGZkohtVSwsjPhLDxQw7okUcTGsVlNy4bH30LGR88qx9BkDACN87asETthKk2
 +P49N8RBGrHKnlG++lxCjJHw7QhQMbanv6qalMvUxhVYER+RTG8h3UxM01Gi36REc8QY
 GRzNFskIwVz1SXNJ2x/iRd7YSuruwHg2hQCtiZiuQDLs62MWMY1AQ9CUQ//zm8HzoqwW
 GrJEinDMPiRK9DbHK7zZzyoKEiZyqWfbz/KV3T7ue+vDEnSTqD54SYHBYZJ1xptn0bzw
 S8Wzh21+JOIZ1x86f8KWvHmUVhFrDANL9ydJ0A7/NZ5K/zZ/YkrOIalbQJj4lARFNYOW
 EOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tgcv+dEPFQ9v9aQHxcNL2bSct/znVcyhlaKal+2qFiI=;
 fh=eC58ciQJhlecYYmRkc2O8kfbktZq72tvkOSI38KrRgg=;
 b=PZLKD2b8svhgIf3NNnDtsGkDHOxuvYefU+W/9ljHd9ckkwFVhY7We6e+4dd26JmEX7
 YAPW9jD0ivzghL3aVTS1yP/B1faJg6OLXbmo9Yrq+ndXM0V+Zxnw5xiFC9V8uyvi83tC
 ubtkPgAJ/toPfN7un5SU8BTjT+18LkvKK55xXLRoeHFb1Dy9GSbav5Qh1q71kQmMtu52
 YHOkNZx33w3XrLqG2G0bljfJbgm0OIOLXRLDgwRyUWEHWJDHw5eNc50XCZGCVP3+Cu18
 vajz4eWpZC+H4SeFj70s+4F0WRpacG42TFTrP+Z4/f8B2XXR0BHsI7Bs3JZHCURRkyjr
 632w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782772661; x=1783377461; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Tgcv+dEPFQ9v9aQHxcNL2bSct/znVcyhlaKal+2qFiI=;
 b=TXesY66rsy8oPlZBu5ZYSnY/KNBz3q9WxVwfOR6DsTrB/5cClgK/WsL3ERN7vSGX4C
 8a0i1vu22an/nYk6UvBpjmzB3jV+u65g0mkp/ahhdYZoMHU5awRoyTTtLW9v0wSowiK6
 pDSOZAM5pc8x+R0iseqygwDDnnEtJv54AxfOU2XNvHI5Lw2bizUgEqVVoyY1z0exmpmh
 E/3kFs0+FOrEdhV0VhPYZLfCnC7AidCV63U+NwkLWgq0QL/5/bnij84DuREfoAQqczSu
 zIPZqTImKiX1kxQgaDfsk/23vYZSgLkcDRR7+PvRagmY7ZnypFcyR9aCO12yh8/8Z/dO
 VCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782772661; x=1783377461;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tgcv+dEPFQ9v9aQHxcNL2bSct/znVcyhlaKal+2qFiI=;
 b=Z+pDtFOQSiSGeLzVsj7cfG+AEedKRpI4KNam0tEWmREHICcm9aICSO1d1XiBDLfG4g
 YNP2otAeKwofmO11zqEFG03Pp4xFer+HK/823NTu/iBvPIOzGeR8V42iLw9amR01/kqm
 q/W90/HXDqhbD53vr7VxdLBZ1RLXlF1dmvmcBYB3RJ4/uPFSaLZ4tiVDZT5qYkbMG1fP
 RqGZ4PkIdFtiVJ7+B1yy7ecI/JKTXDa5gg1LACE35rXwjzT2HbcZv+oidvFArrTnIbLk
 fqJUroBDD7xCvwY5YydNedeVINZ6aY25i3n8AHEjOGr7oVF8o5OfVHh+psShI/R0Bxxo
 KnZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6M657FL1jQRiPVdQC9lBEM5NHQq8sjAKAsdRTELXEbSCUf6tnai0HaYvC1PCh+jaULwU=@dpdk.org
X-Gm-Message-State: AOJu0YwmyOXtoH4U1TOHF9sIYsFkfeyh9XHp8AOE1P6cJOhuETJnnOje
 pygPMAiOt4JxTHMjUPCA1BPv/mEXIe9HvGS8KiBRJPgiaEON9t+z2JkhjJg9w9TCro8kok+vqtL
 484sn+WOrt18mEgVkO53ED3+NDHxPT1Q=
X-Gm-Gg: AfdE7clnKrDIGV/EtxOjH0VciRf49nVQTPS2jQ0R2CiNzj+dD0xSjInQ5uNEwYJ7obG
 MqxtU6SU4tcAf03i4bYCezLsLlmoMApW1gND77Z5o7JXETUZ21iTuqr2Ph/dK2bzOkAyBFnShzb
 Z6yd872sVTq/dY4V1Pq0VDAtUlj4bM4pTeEaWA1iCsasXNF38WXO3FXutERmHVcYiHX1MNOVQX5
 Fc5J9pwsXlIGbUszt1PIWo/FjUEhwNlD5eRkZVQvPLYR8CLtBNETz+b90I6JUaxXCXiCXPoFMBi
 BFBZ9pS0G+/b1GCqToWd4BfQn/rw6DRwam2B+kKa
X-Received: by 2002:a05:651c:1544:b0:393:4e44:63ba with SMTP id
 38308e7fff4ca-39b1de3ef20mr2146731fa.29.1782772661180; Mon, 29 Jun 2026
 15:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260609142330.1423729-1-knimoji@iol.unh.edu>
 <20260625172233.2288663-1-knimoji@iol.unh.edu>
In-Reply-To: <20260625172233.2288663-1-knimoji@iol.unh.edu>
From: Patrick Robb <patrickrobb1997@gmail.com>
Date: Mon, 29 Jun 2026 18:37:29 -0400
X-Gm-Features: AVVi8CdlbN8YwWLuxSHExzddxAA1RVNut6yc_aRlWv6poYvVFTATmheRqOolcxY
Message-ID: <CAK6Duxvkpxh8XzwvmMaX2y=Am2ePXD092JwX61H5EizDv5f2Gg@mail.gmail.com>
Subject: Re: [PATCH v3] dts: update dts check format script and resolve errors
To: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="0000000000002f5ec006556c1b59"
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

--0000000000002f5ec006556c1b59
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the UNH jenkins repo, please read the jenkinsfile for running the
dts-check-format script, check which image it is pulling, and check how it
meets dependencies. I can't remember if the dependencies are met at runtime
or build time, or even if it uses poetry or not. So, there is a risk that
the checks in CI could continue to run with older dependency versions even
after this patch hits main. Let me know if you have questions.

On Thu, Jun 25, 2026 at 1:22=E2=80=AFPM Koushik Bhargav Nimoji <knimoji@iol=
.unh.edu>
wrote:

>
>
> +Tar_modes: TypeAlias =3D Literal["w:gz", "w:bz2", "w:xz", "w:tar"]
> +
>

Should this be tar_modes (snake case)?


>
>  def expand_range(range_str: str) -> list[int]:
>      """Process `range_str` into a list of integers.
> @@ -154,7 +156,11 @@ def extension(self) -> str:
>          For other compression formats, the extension will be in the form=
at
>          'tar.{compression format}'.
>          """
> -        return f"{self.value}" if self =3D=3D self.none else
> f"{type(self).none.value}.{self.value}"
> +        return (
> +            f"{self.value}"
> +            if self =3D=3D self.none
> +            else f"{TarCompressionFormat.none.value}.{self.value}"
> +        )
>
>
>  def convert_to_list_of_string(value: Any | list[Any]) -> list[str]:
> @@ -207,7 +213,8 @@ def filter_func(tarinfo: tarfile.TarInfo) ->
> tarfile.TarInfo | None:
>          return None
>
>      target_tarball_path =3D
> dir_path.with_suffix(f".{compress_format.extension}")
> -    with tarfile.open(target_tarball_path, f"w:{compress_format.value}")
> as tar:
> +    tarball_mode =3D cast(Tar_modes, f"w:{compress_format.value}")
> +    with tarfile.open(target_tarball_path, tarball_mode) as tar:
>

Have you completed a testrun which flexes create_tarball(), i.e. running a
DTS testrun which copies over a normal DPDK dir (instead of defining a
tarball in test_run.yaml you define a normal dpdk dir source) to the SUT,
i.e. it actually has to create the tarball?


>          tar.add(dir_path, arcname=3Ddir_path.name,
> filter=3Dcreate_filter_function(exclude))
>
>
Thanks, let me know about the questions above but the patch looks good.
I'll do a testrun and then merge to next-dts.

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>

--0000000000002f5ec006556c1b59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>In the UNH jenkins repo, please read the jenkinsfile =
for running the dts-check-format script, check which image it is pulling, a=
nd check how it meets dependencies. I can&#39;t remember if the dependencie=
s are met at runtime or build time, or even if it uses poetry or not. So, t=
here is a risk that the checks in CI could continue to run with older depen=
dency versions even after this patch hits main. Let me know if you have que=
stions.</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Jun 25, 2026 at 1:22=E2=80=AFPM Koush=
ik Bhargav Nimoji &lt;<a href=3D"mailto:knimoji@iol.unh.edu">knimoji@iol.un=
h.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><br>
<br>
+Tar_modes: TypeAlias =3D Literal[&quot;w:gz&quot;, &quot;w:bz2&quot;, &quo=
t;w:xz&quot;, &quot;w:tar&quot;]<br>
+<br></blockquote><div><br></div><div>Should this be tar_modes (snake case)=
?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0def expand_range(range_str: str) -&gt; list[int]:<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Process `range_str` into a list of in=
tegers.<br>
@@ -154,7 +156,11 @@ def extension(self) -&gt; str:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0For other compression formats, the extens=
ion will be in the format<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;tar.{compression format}&#39;.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return f&quot;{self.value}&quot; if self =3D=
=3D self.none else f&quot;{type(self).none.value}.{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self =3D=3D self.none<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else f&quot;{TarCompressionForma=
t.none.value}.{self.value}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
<br>
=C2=A0def convert_to_list_of_string(value: Any | list[Any]) -&gt; list[str]=
:<br>
@@ -207,7 +213,8 @@ def filter_func(tarinfo: tarfile.TarInfo) -&gt; tarfile=
.TarInfo | None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
<br>
=C2=A0 =C2=A0 =C2=A0target_tarball_path =3D dir_path.with_suffix(f&quot;.{c=
ompress_format.extension}&quot;)<br>
-=C2=A0 =C2=A0 with tarfile.open(target_tarball_path, f&quot;w:{compress_fo=
rmat.value}&quot;) as tar:<br>
+=C2=A0 =C2=A0 tarball_mode =3D cast(Tar_modes, f&quot;w:{compress_format.v=
alue}&quot;)<br>
+=C2=A0 =C2=A0 with tarfile.open(target_tarball_path, tarball_mode) as tar:=
<br></blockquote><div><br></div><div>Have you completed a testrun which fle=
xes create_tarball(), i.e. running a DTS testrun which copies over a normal=
 DPDK dir (instead of defining a tarball in test_run.yaml you define a norm=
al dpdk dir source) to the SUT, i.e. it actually has to create the tarball?=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tar.add(dir_path, arcname=3D<a href=3D"ht=
tp://dir_path.name" rel=3D"noreferrer" target=3D"_blank">dir_path.name</a>,=
 filter=3Dcreate_filter_function(exclude))<br><br></blockquote><div><br></d=
iv><div>Thanks, let me know about the questions above but the patch looks g=
ood. I&#39;ll do a testrun and then merge to next-dts.</div><div><br></div>=
<div>Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.=
com">patrickrobb1997@gmail.com</a>&gt;=C2=A0</div></div></div>

--0000000000002f5ec006556c1b59--
