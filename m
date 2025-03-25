Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBAEC36008
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 08:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D63340E17;
	Tue, 25 Mar 2025 09:09:24 +0100 (CET)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45]) by mails.dpdk.org (Postfix) with ESMTP id 9903E40B9C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 09:09:22 +0100 (CET)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-549963b5551so5460057e87.2
 for <dev@dpdk.org>; Tue, 25 Mar 2025 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742890162; x=1743494962; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yDJYSqO8L1+ayiVSD2K2eUr0O7DajOddLCeKQE5Sn3E=;
 b=N9vLFgPqUFYViuU+iTYx7HLTRvE5qRdiRM2N6/ic40Z4utwT13GaH6LcehXILZ98Td
 dc4rdIKqJXML7FG0kys+SKCeFmP/LBQoKobdrDLYczYUrkfuRZGATJzIS0eU09yqvudI
 w3bKY9KCZWiZzwcEIb+CQHjjLE6bCkcWAUiusvk5HoQCbUa+/tlJuLHKPJL7d3Ewa49g
 npJAd2HhvQ27YBrfzqDD4daeNmH8JRwaiUfDzFtekORoZnNnsYGnzQdsCD8mqUpkRms5
 BT8h2xeVZumaTTf54K+GD1n1XiHSXES2UobWFePzdA3sVntaw7GbotmGREvBpIs5JTab
 anyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742890162; x=1743494962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDJYSqO8L1+ayiVSD2K2eUr0O7DajOddLCeKQE5Sn3E=;
 b=czWj7+Yz7AIVGcbeqEG0lhRZaVibE0xPafi7J6IWloP8NqygTOy8c85NT+3auqhi+u
 D3QjOvAiEBH6rDUnxQGikUqxhpnyGcyJDGa6AGD0TPlWD3Fj66YMaE+mSsOuFb6Txig1
 Yer4hIVUzCZVmvv4esvDaj3ujh/4qbw6bU0CFg4auO0tr7xg6xP6FFTf6PKcSVZkvSPR
 F8hNGyTLDLxp0i4FXygN0TRPMurfOsCZ4pXIYwbVhRRh+cgsOg0pdAEx8os/JxWl5qFb
 mdlHc6qJ0wrSF0JFgzTpWmTCenjOtF/P0H0HzCS+/ORLOX7YQ6UbiVNrCnPyb1DNLNBy
 xNNQ==
X-Gm-Message-State: AOJu0Yykf0dTa92O83FzkBvvcNlPQeybaxdSL5zYAirAVzmkQ/RBtxoe
 0P3avSVV0xUiQBwLTUusFykhLxb05rxRzZafyZ0Fna0vHrcfyAigjs6gLg+xYmWcKJq3KoESYFu
 GJMpbeD1f3R0L9L15rvpjxeHWNyDwGA==
X-Gm-Gg: ASbGncvXNiKjDTNE3aPSOe3qA81wotv07DI5TklC+3gQcchrp7OXhv+d26xKNPLHqSh
 0r7RJTwApilp/aG6BllrIJZDjMDDJIDs4riP+utdaB19kWW+6N1Tn6t0zrcBbnA4ea3SDGc4bf8
 CUb2lbW/Jz7mAbcx2DkEOtmNH2SPQ=
X-Google-Smtp-Source: AGHT+IFE6QIKKAKwJwV74XD/B4l/q0KmO+2Cpjr55Wzb5WOBmFQi8iwg6IZzN8DdG2/JyERVOxkwCWT3iVagEpZuF7w=
X-Received: by 2002:a05:6512:2351:b0:549:91d3:4f0f with SMTP id
 2adb3069b0e04-54ad646ce76mr5155256e87.11.1742890161470; Tue, 25 Mar 2025
 01:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <bug-1562-3@http.bugs.dpdk.org/>
 <bug-1562-3-P2fNaCPFLO@http.bugs.dpdk.org/>
 <CACOt6jyPUfBPaX7t4rYde8dTgn9-we38s7WYFrrYx0iOyOC7FQ@mail.gmail.com>
 <20250212070234.7f69425e@hermes.local>
In-Reply-To: <20250212070234.7f69425e@hermes.local>
From: Navin Srinivas <g.navinsrinivas@gmail.com>
Date: Tue, 25 Mar 2025 13:39:08 +0530
X-Gm-Features: AQ5f1Jr-kwU1J7SicL0PGfifR9bYBItLWH4aBzeC3RuQdEtWK1Anuztcy0cF_vg
Message-ID: <CACOt6jxdUmS-sno3LrnWzmfpAhwi8_8w1fhbKZ-Z=cOvuK5JsQ@mail.gmail.com>
Subject: Re: [DPDK/other Bug 1562] dumpcap captures all available network
 interfaces when specifying any PCI network interface
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f503ce0631263c7a"
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

--000000000000f503ce0631263c7a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oh, Thank you, Can you point me to those patches?
we require it on top of 22.11.1, I would like to get those patches back
ported on top 22.11.1

On Wed, Feb 12, 2025 at 8:32=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Wed, 12 Feb 2025 13:29:57 +0530
> Navin Srinivas <g.navinsrinivas@gmail.com> wrote:
>
> > Hi,
> >
> > Is this backported to 22.11.1?
> >
> > Thanks,
> > Navn Srinivas
>
> No, it required a couple of other patches related to management of networ=
k
> interface list.
>

--000000000000f503ce0631263c7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Oh, Thank you, Can you point me to those patches?=C2=
=A0</div><div>we require it on top of 22.11.1, I would like to get those pa=
tches back ported on top 22.11.1=C2=A0</div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 12,=
 2025 at 8:32=E2=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@ne=
tworkplumber.org">stephen@networkplumber.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">On Wed, 12 Feb 2025 13:29:57 +0=
530<br>
Navin Srinivas &lt;<a href=3D"mailto:g.navinsrinivas@gmail.com" target=3D"_=
blank">g.navinsrinivas@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Hi,<br>
&gt; <br>
&gt; Is this backported to 22.11.1?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Navn Srinivas<br>
<br>
No, it required a couple of other patches related to management of network =
interface list.<br>
</blockquote></div></div>

--000000000000f503ce0631263c7a--
