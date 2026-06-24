Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0130BCDE001
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 15:44:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0EAA402EE;
	Wed, 24 Jun 2026 17:44:50 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id ECEA6402E7
 for <dev@dpdk.org>; Wed, 24 Jun 2026 17:44:48 +0200 (CEST)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-519e7faecf1so14122711cf.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 08:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782315888; cv=none;
 d=google.com; s=arc-20240605;
 b=dCUraAeDtzhhekxgJkRjmWFov1noxUUJglZ4pcpzkmeZWcRq421mSm7Iw+pUY8rupi
 8btxgqVvu/tKcLSvI96Rr4awdnFm9G1haan81qwZLQXt60DIW+33EyUhnjnBb1l3SR5p
 QuZNOBIDAxRz2gMODAnWSzeTAP5F2MQ6N3/iRns8kV7RUoeTcrrjq+JBkfrJzb3bWutG
 q/CtsibTfvs4ZvUWMgcdr0zGzREeZPr68h/35/jMeQgtAXJzuxUWdyVbBoZhi6ylImh8
 m/Q5y246QXKZiKr8EM5hPsc/qUSV/KhNi9TLAId/DY7uEBgoNa/47ZGQiP2nTp6ZhFv4
 iOaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=miS7XTGYULK4oegWogIv2geCHfSc1WhEvrekpDlg+Qg=;
 fh=2nK8dTTQVLlTDnbQWrfDm6jpahqbG/Vgw5e+fmLHFd0=;
 b=XLb51ApKGEuId3s9EeN4Z6kyn7H0YEpjDTnPsDmuqHfQLmpAU0V3rfHvbDEIZAbSKS
 MO7aGOR+9onWdghBCjOsNribMq1dIRfqZWRRTfUQb5kS3ySw23HMvUDgXSFiieklmSad
 VU3YBJFRlQ4nZiAtKiCI+JVpfls8tI06nJBoBSQl8uVJ/Ci5cRp7IQL5FhjelBI51O7Q
 KVIdmS9+ootasAze2lyy8eFaXp1kR5AzIdHQJ9LZqj52GFE5boqqT8dwAzaVHqdyooEo
 mW7CCqOytdTDFO0ZTsYwqdkG3dIyQdWyt/cHulWSedG9GqAWyfGookKcfxg1VAVEvwZ5
 /m4g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1782315888; x=1782920688; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=miS7XTGYULK4oegWogIv2geCHfSc1WhEvrekpDlg+Qg=;
 b=QgYv34S03kXQM35EJ1nW+ObvE7jBglNU0HlMyk0sVJkhUk86DqLqoP/68KNWy9iAkA
 /GMgRzpmku5BODDPmrFmIb6e4ZAulBnt1/DXDpL37hDEc8N6OOfRpJ+Lr0T0bFSDIMO5
 CMoS08rAxQVjnaDcZZAC9SKUdKAw1CoZKLKbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315888; x=1782920688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=miS7XTGYULK4oegWogIv2geCHfSc1WhEvrekpDlg+Qg=;
 b=PcxjmONCFYwBUbYjREg5BOFx9Y3320ILOxul3Ik020L2WjAwJ5PsCscYnlXX668PoC
 bhvVC9KoPvsxiAsK/zK9JJjtHQpmzXb3/5nvacPQ0Lwrz/h+Vd3Oi3O01ijWyUAKlM9m
 wUJ/275BWkpdny7hRUXJBJSC4LJ1HIqHHJ41LPYpe+s9Xcafu37d9vG+1fkXUVvV7fz4
 sbCGJyU9u/vuPvgUNMH1cX/p7cxJWw8kDJ1BEViI/yH4xm0ffOdsuc0TKmVekQKdcsG0
 Rwhl8XN1h7ZCdvLL6eENGRWCjUcy2k/Tege7vrRfSPEYzgqLZbAKZO3K8p3dOAnR9NtX
 BvsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZuJGUWyGw3puFJtYLD5Qxau2jy4F16fyq2UHS1nKJjSZVvG1NWFUjGI80tNeZtvB3X1k=@dpdk.org
X-Gm-Message-State: AOJu0YwiNzFSBp+H+TvQyi2Y0MjFUwIKLb8Y2t+wBMEWU4Mo2BwOG4vx
 dbnOKJOyCGeIZau//HObNPMpilRq2wXgjLJydzbbIPUHeLRiJNIWrrl6ijCkESDRHTlKrAm1TiZ
 bICTRYxCp3j/7K/d2fFjk7fbpHV8u2lTJwFOfV/erdA==
X-Gm-Gg: AfdE7cnVqMoS6vnywrhP293ALFTq190E3BEbeBT+I3+wOV6D/DkE1rpKIEuKfmK5r0Q
 JB1ZhI+/7ENoI6p/S1KnT7xntvvUf0AUt9Em6YnfBf2ilYoAXQr2GX9/RtPogp16O3WRgKMF200
 CcZPJlW9A5YQZYXUmHCzmaFc4xUSgv0LrMJ40d30F3dMzyz4wH9AG7w/Rrtz9HSLz923OqMy7CJ
 GWkvwMp6SRbEHbvMVOmAmaZUIcWaHmgnlP+0zp1s2PpJSiEkNoQEvtc+wDHVrh6VmkgZNrUFr0O
 vp1PQHHeTUsi5AV6VFkimpZC7C7zCqQDMB5HEsaDoIVp+Y4b4CEY0t9J9hY3hSHIO1ty+SsgH26
 fIYjZZ2KImWPQ+5VAhTJ/8jld39llemwCxDLQC4zwNFaLs+ZUlbRNcxDDo4U8DldMt052TWm6
X-Received: by 2002:a05:622a:2d2:b0:519:a934:3a70 with SMTP id
 d75a77b69052e-51a61b2a194mr57754441cf.16.1782315888026; Wed, 24 Jun 2026
 08:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260609144501.1441468-1-knimoji@iol.unh.edu>
 <20260618204525.1010218-1-knimoji@iol.unh.edu>
 <CAK6Duxs-o_OcgjM9_dm-oBFTU7zKjk1g1X0bvbS=gtgwFSd0=Q@mail.gmail.com>
In-Reply-To: <CAK6Duxs-o_OcgjM9_dm-oBFTU7zKjk1g1X0bvbS=gtgwFSd0=Q@mail.gmail.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Wed, 24 Jun 2026 11:44:12 -0400
X-Gm-Features: AVVi8CcU7zZiPFx_St0DEaBAS-d0ffZAIi9mmepmbzWNBoTtftkkBljdIgIxKB4
Message-ID: <CAKYPG+yNBoEjb40y2qhqvEZL04W+4WxZ40PfB+AR96frOfi0zQ@mail.gmail.com>
Subject: Re: [PATCH v2] dts: update dts check format script and resolve errors
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu, 
 NBU-Contact-Thomas Monjalon <thomas@monjalon.net>
Content-Type: multipart/alternative; boundary="000000000000623b3a065501c1af"
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

--000000000000623b3a065501c1af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 6:35=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail=
.com>
wrote:

> Looks like your patch is failing some of the checks on patchwork,
> including doc build:
> https://github.com/ovsrobot/dpdk/actions/runs/27789008643
>
> Remember to run a doc build locally before sending any patches:
>
> meson setup build
> ninja -C build doc
>
>
I will resolve this and send a patch out shortly.

Otherwise, please provide a little more info regarding your info. So, you
> have updated some of the dependencies used in the dts check format script=
.
> I think what I see from a quick look that is relevant is:
>
> -mypy =3D "^1.13.0"
> +mypy =3D "^2.1.0"
>  toml =3D "^0.10.2"
> -ruff =3D "^0.8.1"
> -types-paramiko =3D "^3.5.0.20240928"
> +ruff =3D "^0.15.16"
> +types-paramiko =3D "^4.0.0.20260518"
>  types-invoke =3D "^2.0.0.10"
> -types-pyyaml =3D "^6.0.12.20240917"
> +types-pyyaml =3D "^6.0.12.20260518"
>
> What is being done broadly? All dependencies covered by poetry are being
> updated? or just the subset included in format checks? Are dependencies
> being brought to current latest or something different?
>

Overall, only the dependencies being used by the dts-check-format.sh script
were updated. They were brought to the latest versions that were compatible
with each other. This allows for more rigorous format checking, as new
errors surfaced once the tool versions were updated.

>
> I remember Thomas mentioning that DTS was not checking the
> dts-check-format.sh at DPDK Summit and that confused me. Perhaps he is
> running DTS and dts-check-format.sh outside of poetry (which we have said
> is okay to do) and he is on newer versions of the formatting dependencies
> than what we currently have committed to the poetry.lock.
>

The lab was notified by Thomas about the following:

"About DTS, I think you are running an old version of the tools used in
devtools/dts-check-format.sh. When I run it, I have a lot of warnings. We
should fix them in DTS and then update the tools in the lab."

This may be what he was referring to at the DPDK summit. When running on
poetry it uses the older tool versions, to which none of the errors show
up. When running outside of poetry, it most likely uses the newer tool
versions which causes the underlying errors to appear.

Thanks,
Koushik

--000000000000623b3a065501c1af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><span style=3D"background-color:transparent">On Tue, Jun 23, 2026=
 at 6:35=E2=80=AFPM Patrick Robb &lt;</span><a href=3D"mailto:patrickrobb19=
97@gmail.com" style=3D"background-color:transparent" target=3D"_blank">patr=
ickrobb1997@gmail.com</a><span style=3D"background-color:transparent">&gt; =
wrote:</span></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr">Looks like your patch is failing some=
 of the checks on patchwork, including doc build:=C2=A0<a href=3D"https://g=
ithub.com/ovsrobot/dpdk/actions/runs/27789008643" target=3D"_blank">https:/=
/github.com/ovsrobot/dpdk/actions/runs/27789008643</a><div><br></div><div>R=
emember to run a doc build locally before sending any patches:</div><div><b=
r></div><div>meson setup build</div><div>ninja -C build doc</div><div><span=
 style=3D"background-color:transparent">=C2=A0</span></div></div></blockquo=
te><div>I will resolve this and send a patch out shortly.=C2=A0</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div></div><div>Otherwise, please provide a little more info regarding you=
r info. So, you have updated some of the dependencies used in the dts check=
 format script. I think what I see from a quick look that is relevant is:</=
div><div><br></div><div>-mypy =3D &quot;^1.13.0&quot;<br>+mypy =3D &quot;^2=
.1.0&quot;<br>=C2=A0toml =3D &quot;^0.10.2&quot;<br>-ruff =3D &quot;^0.8.1&=
quot;<br>-types-paramiko =3D &quot;^3.5.0.20240928&quot;<br>+ruff =3D &quot=
;^0.15.16&quot;<br>+types-paramiko =3D &quot;^4.0.0.20260518&quot;<br>=C2=
=A0types-invoke =3D &quot;^2.0.0.10&quot;<br>-types-pyyaml =3D &quot;^6.0.1=
2.20240917&quot;<br>+types-pyyaml =3D &quot;^6.0.12.20260518&quot;</div><di=
v><br></div><div>What is being done broadly? All dependencies covered by po=
etry are being updated? or just the subset included in format checks? Are d=
ependencies being brought to current latest or something different?</div></=
div></blockquote><div>=C2=A0</div><div>Overall, only the dependencies being=
 used by the dts-check-format.sh script were updated. They were brought to =
the latest versions that were compatible with each other. This allows for m=
ore rigorous=C2=A0format checking, as new errors surfaced once the tool ver=
sions were updated.</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div><br></div><div>I remember Thomas mentioning that DTS =
was not checking the dts-check-format.sh at DPDK Summit and that confused m=
e. Perhaps he is running DTS and dts-check-format.sh outside of poetry (whi=
ch we have said is okay to do) and he is on newer versions of the formattin=
g dependencies than what we currently have committed to the poetry.lock.</d=
iv></div></blockquote><div>=C2=A0</div>The lab was notified by Thomas about=
 the following:<br><br>&quot;About DTS, I think you are running an old vers=
ion of the tools used in devtools/dts-check-format.sh. When I run it, I hav=
e a lot of warnings. We should fix them in DTS and then update the tools in=
 the lab.&quot;</div><div class=3D"gmail_quote"><br></div><div class=3D"gma=
il_quote">This may be what he was referring to at the DPDK summit. When run=
ning on poetry it uses the older tool versions, to which none of the errors=
 show up. When running outside of poetry, it most likely uses the newer too=
l versions which causes the underlying errors to appear.<br><div><br></div>=
<div>Thanks,</div><div>Koushik</div></div></div>
</div>
</div>
</div>

--000000000000623b3a065501c1af--
