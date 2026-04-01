Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003510F6FC5
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D444029D;
	Wed,  1 Apr 2026 17:02:20 +0200 (CEST)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id 2136C4029D
 for <dev@dpdk.org>; Wed,  1 Apr 2026 17:02:19 +0200 (CEST)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1271195d2a7so2800272c88.0
 for <dev@dpdk.org>; Wed, 01 Apr 2026 08:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775055738; cv=none;
 d=google.com; s=arc-20240605;
 b=hEhCTc9zoaQ+uPLBJpHDpEXsM7h+3/xHWFLTZbHI1v8ZevM0d5iA5fgN/0oLTLmKib
 Sh2D8Qul+Awo+VaECp14G8dpcKHZLMgI8qBEjUuDP4AZU0Tcse+nSJpZDht3Ywm2Iq24
 HKELA0p7nLSuprnv/bKo6BqqB3kHJgYyaRESagVxLiG3O2U3a2i2ovjaZpJTxUe59YlS
 QUhHN+rFmb3N4qT21wEqsVz6XmtyO6LCQYkG+bIvgR2RUiYjoWVQ+ZFxBHDnfy1+8Pn0
 E+dG+loWBQdJOcbV/WNYKuRMeYpOPAhmx4prga0PwfN3nbDW636h/pEfPmjdUqOME2fb
 2aGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ot8zxfhemaU2WIuCw+EcmygPgs3HS3d8ELAvM+OtOnU=;
 fh=8fq7E6DGvZq6yIU9vVc+Ihcr0ryRHOD5mB8o+Wt7evs=;
 b=cC1zSDH4vovpEAZn58HfAfqcNeXdp3ElIXtFENAcDjmIfUyP0ozCFND7yJloWr5S3L
 qap6xguqdgedZCIp0b8of1GAnw1TPBANNniMkacbjgh1Ui2e/MFDBHJnulyj3T7HFtMV
 rY9CC145brva84qLB6Kawj48WtCZwsqhvaNBpKcwaQFbj7nN/hH+uIXKOTn/aHAbN4Gd
 ra4XT+6+xsCqeCd0RBy/GGWHEm/IqVatyNay5V5SB5KuXZDKP12dawFl6JFucpMO/god
 0IDfOfPppNyKsLMdKra63/Du4PY8Ows4O1geP1slw3wALKnlaO0CoxCQ3PJNZoNid8d+
 bJqw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775055738; x=1775660538; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ot8zxfhemaU2WIuCw+EcmygPgs3HS3d8ELAvM+OtOnU=;
 b=evDm2Q+4GOQwETjJlNwEHkSGxhwZ1VcMYso5tTk8TBmEXDMj/aIsX5wmUKUV0COHUL
 Ke3mxvpcYwEEXFy669M0WvvfHMcOvi6d8FxHnl7ct2I4VD2l/AFPsVDe6aUWR4hrykEv
 ou+ywgiG4486mtN2v3QPmqIs8LchmyFJNn/0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775055738; x=1775660538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ot8zxfhemaU2WIuCw+EcmygPgs3HS3d8ELAvM+OtOnU=;
 b=M9Behd+x47xVtvWyoDtJ4q9BsofdvmVrqi8DJzBxcUbhA6z7lqbmbXk0jIegI848ds
 rhEpErjPF+dJGl7HhJ8B/SGFFMBwkOWEdQRTfNXmV/tTvpGhX9WliwIa3F/w3eFnr/yk
 beWcbMuaiI4ZFgb9EYdXZwlgHe5fN+ZuLUGkOdts7JQ/54SisxCxkDMpU7sv2yzznnLI
 5IIwcK5w29f6TgMCuvAgUUiMEZRntYd8LaxQWnByUUtTTIFn43VB6FGXWZyT9rXfoaw+
 XOpj5KkZrp7dtiM8+gUXAE5hp+QroyH1Q+PX891ZvTsbTWyB70hD5Z8mpJx4Hb5Z2mtX
 LJWg==
X-Gm-Message-State: AOJu0Yyt0BIn7Q7tP0oIwd+E2x5jjZnIVOd5zL4AlceaB2ar5NAZ9JOy
 993O/fzDuS0FnsnKHnY9q+XOBzIA9UBJkaXIs7o7my1YcmsGMhfpe8/kiH3ZX1Na1dlA97fGvzl
 8cd86dSows2PvsCx2Ca3vXBn8R2jCz+dABFEIL3e59Q==
X-Gm-Gg: ATEYQzwJ7JHC0TtfathX9GizvkZh5+vBa530ivnD2I6U2b2mXXlZhYUF6MAIgfWoDg0
 eGV6wEfNFW29o3wlDoUo1OxjgXg8vtSUVimWsi4scUXFnG14pk58Qp/SxQHX7x93qHr/i/TfzGA
 ZBbTIfLDqJnNkXlUb1boCV3CaI/a2Xv2MSBng4wppjqpnMejlNXWGfrcf81Crm6fSxY3m4ym2Yj
 fZFdIKVDRYkS8oQgwyKhR3mcbwlPE/snWULRuOGgcwRGGm9L5w5E5loywrN9oRh72OHVROPVFnU
 dMVM/IMfZYTqVQToEY9Aye85jSI/M5yCsAru0CFNZGxqydCJkKgnOg==
X-Received: by 2002:a05:7022:e19:b0:12a:68cc:3efb with SMTP id
 a92af1059eb24-12be643856fmr2167825c88.16.1775055737728; Wed, 01 Apr 2026
 08:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260326130000.2254853-1-luca.boccassi@gmail.com>
In-Reply-To: <20260326130000.2254853-1-luca.boccassi@gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 1 Apr 2026 10:58:54 -0400
X-Gm-Features: AQROBzDObTtRwU68yFiHNdHB1Xt_R0ucvA88h8eM0LrCdB_zqXdvL93wKy0WUcU
Message-ID: <CAJvnSUCD10o3k=Ltosq=-uz2uQje6rQpBcYaWkhKxQVxOoXXKg@mail.gmail.com>
Subject: Re: please help backporting some patches to stable release 24.11.5
To: luca.boccassi@gmail.com
Cc: dpdk <dev@dpdk.org>, dpdk stable <stable@dpdk.org>,
 Andrew Bailey <abailey@iol.unh.edu>, 
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>, 
 Vipin Varghese <vipin.varghese@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b44174064e675e3b"
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

--000000000000b44174064e675e3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luca,

874312e261 does not need to be backported to 24.11, as the issue it fixes
only manifests when running cryptodev testing (which has only been added
during DPDK 26.03).

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

--000000000000b44174064e675e3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Luca,<div><br></div><div>874312e261 does not need to be=
 backported to 24.11, as the issue it fixes only manifests when running=C2=
=A0cryptodev testing (which has only been added during DPDK 26.03).</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Thu, Mar 26, 2026 at 9:00=E2=80=AFAM &lt;<a href=3D"=
mailto:luca.boccassi@gmail.com">luca.boccassi@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi commit authors (a=
nd maintainers),<br>
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

--000000000000b44174064e675e3b--
