Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A9C10AB830
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 14:53:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7A9742DD6;
	Fri, 27 Mar 2026 15:53:51 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 3DB5D427C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 15:53:50 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12a747e7b2fso1275418c88.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 07:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774623229; cv=none;
 d=google.com; s=arc-20240605;
 b=bE2GgGpzK+haswAI+McqHMy09Df2iRtLKjdPeirtf+Ji0uL25gHB8aaSu/FCaVREJE
 HN0Qpt7NG4/L8bOSYU3ShDi8uWfp+hxAiNke9OvIPITk/HWvWYJzOS8WOLDsa00AFT+s
 FrxFqeArV+YZQ6OK4cf/e59HY6Us7/Rg0LVsDO49morPjAoy6tgtQ0yeUtO8clrthufs
 u9Q+m8XAbGhGbzm4CbtCkz7J4eXS4MDqzdaAHLrZqazRp94f4DPtJ0cvvT2wZ3wilaRJ
 4FyyUd462h+ymLs38GoqkxZdpASUCedpFcm32UHDEGIbb3uh4nIAzJA3XmBtkSkGsKJs
 IOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9Hdk3+cWcqjpSdRazVGrHZMX9MJJ6veo4zcGaKQyd4U=;
 fh=b/pxWTS8i8er6hBw6Cgk0aNHPfPDunRtIuBYWHOcBzM=;
 b=LPEkQzA5yLCj+iaict5/wQhXYyplIrRuDl0lKg3jJwFngYO7n3riUNCnGVmE9v4jIv
 FEoWNpRtHsPJ8ZL+06SnyAow9wBnKLFK/NJpdG7QBfZsCg1Cp8FPTzDdPHmYy7ug8C6h
 CEmB0UKm6PurvYs2jDcoGCmJvgZ3sVnk3yJvCOU+WBRN4ceVKUoqI9sQUEbut7w1NTOx
 GNu6wsiGtkdRfVY6Bhd7pNqfQ+6jZPWH29SFDC0qtwWFylaghUT9l99/vDwjbkjA4TmT
 0m2Soq8nqz4koFrId2vAZb7/GoM1A/ooCGTbMZTUEJH96ZrdkHPr7ESKRuLG8DcUUrgW
 CFBg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774623229; x=1775228029; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Hdk3+cWcqjpSdRazVGrHZMX9MJJ6veo4zcGaKQyd4U=;
 b=OBhMdgq++ZYT1pIeklMpD+RVtjofglbx2u3oIDHoq72/CKUmoA8AxeijyqvzBMiNEq
 JwYTzqmx3XhGhwde3SqsbqvDPR4JXFtPDEe8uJ2/V8kK2GCwRBQ9MnvQl0c74ZQcdzmj
 AHNxN9RGT+y73qqq0jIySXqraOmCAKjrIf9oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623229; x=1775228029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Hdk3+cWcqjpSdRazVGrHZMX9MJJ6veo4zcGaKQyd4U=;
 b=JKIyzs74hskSSai3aOzXKddXXHklZgxuY0bpgoNBYY35JKfrIg8OZuAO1uGQbP8CTs
 Gq+H3kuLNT4aDpx/HrrK9FqpZACUdMH4HUg3OH3wuqwraeqDEPYfyQ6/qYKIrVd7BJG+
 a34mOesum8R+eiPTBo2ORqFLtuV2c/j4P38GFVeKA8dtGlw3szcXEPljJ1ehcDfR15Ox
 WVkqGuAG7wDcv2KuCYS6G4Ns0O6eIgjQ4+Ny2Y0ieV7iroVPfmmQ+wXcPAPIs0LaEK8+
 qajJBeglS4vCgMk5jINV1KKaaxbJvKwqiwSburOFx0vN4hVXe/VRSWDZ1JSDRRSEOJhg
 cjsg==
X-Gm-Message-State: AOJu0YxQJEIB4g/jsfdX7l1fkp02wxbAOInXdr7+MeRKHJhz4m6UnqC3
 HPEew9McILxw7el70dV0ZY9e6yHoJwCO0Tudu1WNQ2e147meO6XGmtWxX1zxRSSz8vt2SVCHe/R
 Ou/gN8cQRU5aaZotkeFBuOsWrhLjn+0q2vhIZAV87tw==
X-Gm-Gg: ATEYQzxqor6IUAJzuAUPPLXiI+D30pLtM7+ZXBU5d4yXDnGqKnsLyIedNYaBYwd1IFy
 KxxQPPSw3KXjdp8yQmYx6RzSI4EU3L9lW6ovQbfmA/Ft38vbYwQjdS1up1h5GfUkOyJ44HMKDmW
 WdX7khKShw7YH6hhxplOEHPq4VMGG4SZY3kIWlAfYKvv7PC5N8i+kGU21W9jskg0+UMfWqdCQvd
 KROfaClnPd5u3yhHM2qztndcdDK/f7As14uqpxCt9eNiKFwiWbnNGpwIvF832roOPnXlKTFY2z5
 ymHBMSrrKMm8My+9MZy9gp9kV7LPC9xYhVPNTtWjD22V+KmywM6C7gIBpJuDCySa
X-Received: by 2002:a05:7022:e12:b0:128:d24a:a5ba with SMTP id
 a92af1059eb24-12ab28de7cbmr1478546c88.20.1774623229110; Fri, 27 Mar 2026
 07:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260326130000.2254853-1-luca.boccassi@gmail.com>
In-Reply-To: <20260326130000.2254853-1-luca.boccassi@gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Mar 2026 10:50:29 -0400
X-Gm-Features: AQROBzAS7dTMo_V85q4a5pn4NTQXfQNpAjTT67amqwYiv1kzSLLZN_j9__czRG0
Message-ID: <CAJvnSUA-hZHELRRFep7X85k21J4DsTzrMnFvt4YSBwDd+FT=7w@mail.gmail.com>
Subject: Re: please help backporting some patches to stable release 24.11.5
To: luca.boccassi@gmail.com
Cc: dpdk <dev@dpdk.org>, dpdk stable <stable@dpdk.org>,
 Andrew Bailey <abailey@iol.unh.edu>, 
 =?UTF-8?Q?Juraj_Linke=C5=A1?= <juraj.linkes@pantheon.tech>, 
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, 
 Vipin Varghese <vipin.varghese@amd.com>
Content-Type: multipart/alternative; boundary="0000000000002e7ca0064e02ab00"
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

--0000000000002e7ca0064e02ab00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

Will backport it to 24.11 and share back to you thanks.

On Thu, Mar 26, 2026 at 9:00=E2=80=AFAM <luca.boccassi@gmail.com> wrote:

> Hi commit authors (and maintainers),
>
> Despite being selected by the DPDK maintenance tool
> ./devtools/git-log-fixes.sh
> I didn't apply following commits from DPDK main to 24.11
> stable branch, as conflicts or build errors occur.
>
> Can authors check your patches in the following list and either:
>     - Backport your patches to the 24.11 branch, or
>     - Indicate that the patch should not be backported
>
> Please do either of the above by 2026/04/01.
>
> You can find the a temporary work-in-progress branch of the coming 24.11.=
5
> release at:
>     https://github.com/bluca/dpdk-stable
> It is recommended to backport on top of that to minimize further conflict=
s
> or
> misunderstandings.
>
> Some notes on stable backports:
>
> A backport should contain a reference to the DPDK main branch commit
> in it's commit message in the following fashion:
>     [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]
>
> For example:
>
> https://git.dpdk.org/dpdk-stable/commit/?h=3D18.11&id=3Dd90e6ae6f936ecdc2=
fd3811ff9f26aec7f3c06eb
>
> When sending the backported patch, please indicate the target branch in t=
he
> subject line, as we have multiple branches, for example:
>     [PATCH 24.11] foo/bar: fix baz
>
> With git format-patch, this can be achieved by appending the parameter:
>     --subject-prefix=3D'PATCH 24.11'
>
> Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".
>
> FYI, branch 24.11 is located at tree:
>    https://git.dpdk.org/dpdk-stable
>
> Thanks.
>
> Luca Boccassi
>
> ---
> 874312e261  Patrick Robb     dts: avoid resources conflict on quick
> stop/start
> bc15a33eee  Vipin Varghese   doc: update AMD EPYC guide
>

--0000000000002e7ca0064e02ab00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Luca,=C2=A0<div><br></div><div>Will backport it to 24.1=
1 and share back to you thanks.</div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 26, =
2026 at 9:00=E2=80=AFAM &lt;<a href=3D"mailto:luca.boccassi@gmail.com">luca=
.boccassi@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Hi commit authors (and maintainers),<br>
<br>
Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixe=
s.sh<br>
I didn&#39;t apply following commits from DPDK main to 24.11<br>
stable branch, as conflicts or build errors occur.<br>
<br>
Can authors check your patches in the following list and either:<br>
=C2=A0 =C2=A0 - Backport your patches to the 24.11 branch, or<br>
=C2=A0 =C2=A0 - Indicate that the patch should not be backported<br>
<br>
Please do either of the above by 2026/04/01.<br>
<br>
You can find the a temporary work-in-progress branch of the coming 24.11.5<=
br>
release at:<br>
=C2=A0 =C2=A0 <a href=3D"https://github.com/bluca/dpdk-stable" rel=3D"noref=
errer" target=3D"_blank">https://github.com/bluca/dpdk-stable</a><br>
It is recommended to backport on top of that to minimize further conflicts =
or<br>
misunderstandings.<br>
<br>
Some notes on stable backports:<br>
<br>
A backport should contain a reference to the DPDK main branch commit<br>
in it&#39;s commit message in the following fashion:<br>
=C2=A0 =C2=A0 [ upstream commit &lt;commit&#39;s dpdk main branch SHA-1 che=
cksum&gt; ]<br>
<br>
For example:<br>
=C2=A0 =C2=A0 <a href=3D"https://git.dpdk.org/dpdk-stable/commit/?h=3D18.11=
&amp;id=3Dd90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb" rel=3D"noreferrer" targ=
et=3D"_blank">https://git.dpdk.org/dpdk-stable/commit/?h=3D18.11&amp;id=3Dd=
90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb</a><br>
<br>
When sending the backported patch, please indicate the target branch in the=
<br>
subject line, as we have multiple branches, for example:<br>
=C2=A0 =C2=A0 [PATCH 24.11] foo/bar: fix baz<br>
<br>
With git format-patch, this can be achieved by appending the parameter:<br>
=C2=A0 =C2=A0 --subject-prefix=3D&#39;PATCH 24.11&#39;<br>
<br>
Send the backported patch to &quot;<a href=3D"mailto:stable@dpdk.org" targe=
t=3D"_blank">stable@dpdk.org</a>&quot; but not &quot;<a href=3D"mailto:dev@=
dpdk.org" target=3D"_blank">dev@dpdk.org</a>&quot;.<br>
<br>
FYI, branch 24.11 is located at tree:<br>
=C2=A0 =C2=A0<a href=3D"https://git.dpdk.org/dpdk-stable" rel=3D"noreferrer=
" target=3D"_blank">https://git.dpdk.org/dpdk-stable</a><br>
<br>
Thanks.<br>
<br>
Luca Boccassi<br>
<br>
---<br>
874312e261=C2=A0 Patrick Robb=C2=A0 =C2=A0 =C2=A0dts: avoid resources confl=
ict on quick stop/start<br>
bc15a33eee=C2=A0 Vipin Varghese=C2=A0 =C2=A0doc: update AMD EPYC guide<br>
</blockquote></div>

--0000000000002e7ca0064e02ab00--
