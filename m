Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFC4C36010
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 13:49:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72FA040DDE;
	Thu, 27 Mar 2025 14:49:33 +0100 (CET)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by mails.dpdk.org (Postfix) with ESMTP id 9A37F4027C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 14:17:42 +0100 (CET)
Received: by mail-il1-f169.google.com with SMTP id
 e9e14a558f8ab-3d4469b35e4so38721665ab.1
 for <dev@dpdk.org>; Tue, 25 Mar 2025 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742908662; x=1743513462; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8UBGAt79ZHKlBOLJT8MQZJu2Va5kA6qW60RcLniSuWs=;
 b=YG63vZXJjM0edrLdzb+ugFgWJHLzw0QJKVeWsS1hKEV+shHXdIOXn4Y2mpf92Ptpyq
 Vq32UO/mByDKcqJCQHVTYvZ+boopnytcZyj9GnZKbodW4U3SCjiDwzdrcC2koFbSO7XO
 lHOqg8YYTPU3VvDV+4+8yjuTUfvU/aQK+965U3SPJVVBEldB5YCFw4oOboQBjoEQ5FM0
 K9ydDqjMboaofGBN/eDdUnvhTVHARq3dYWMxIWsYwOms82aDIESmRQTczLseirx02fk4
 pnZCIAuyLpxQIcVfRdmz1AqEUm3qUd4bWPXgqvVD8ybNUpXQ2klxE7uQJCBN9EsVebaH
 EpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742908662; x=1743513462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8UBGAt79ZHKlBOLJT8MQZJu2Va5kA6qW60RcLniSuWs=;
 b=KOlBdKX0OUw81oEBcqagpWdrhM+uPxRnR8GmQBqJgJ5ruR5ADMDRmoJmr0uxH9fkoN
 iUqU0A+E/DRB+zehPT68M4//YeW6ISZmN6TTG0ACTcdMCgHorOtL4DVF82+2HT3mKvy4
 7j4AzJSqP3QCDbFpN9R7o+yJF0pCN6eOv5JyLKffX4RNe1VC2qo30/K3Cm5Cx1i2VlSd
 BjzlREmUGcotYya/nDBkq5YkqpfjonBCVkNeHWz3D9VJysvtPZruRG4ahvtv1mWZct1a
 uaCNVPxeb2A2uza/UtUxxsJeYzB1iY6zfTv8zCAH6rtx6bDEB3OuTSUjfBgPl3L5d6Ck
 2URA==
X-Gm-Message-State: AOJu0Yze7VwATjy2gPxy6RffwY+YePJ4wqhLXoQh0Co07Hu6O2I3twar
 Lq2TAtQmB2hb2I1yzLrGnH6IXJKnGkSHSHS9nm2ye0CVLomFGWfYx4gcvi+V+PfZbYYoJUSbq9A
 9eNNlnRgp5NCZbEfieim9Vrwetl8Csm7b
X-Gm-Gg: ASbGnctp7+l/PseFYQtw5cECtgINjYS/Db+gvyQzStOCwb7F7fiyE8ltm9wTh1dijk9
 W3hX8o0bnjbp9sN59QKjt73jPIylhr/13pWX7TKdmGTaUKJBxFVb5IDjVx8Ufw1iz2oxfkvk5ST
 EEDMPrsMCdzdlmXoargdaY4vvbRA==
X-Google-Smtp-Source: AGHT+IHPg9NdYAlndvSJ2X39Gnxw1qT/S/P4D7ONk9jSGwASyCOLZiQeSssOctCnM9ZOyV8epnDX5IFL4L66FEjmBm8=
X-Received: by 2002:a05:6e02:3e91:b0:3d3:d229:f166 with SMTP id
 e9e14a558f8ab-3d5961b12eamr144446045ab.17.1742908661627; Tue, 25 Mar 2025
 06:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFFPToi31bmGM76Uuiy0VAOsH=5YM6z0x1UH9EyyPGM-CF4tw@mail.gmail.com>
 <20250110100425.598c939c@hermes.local>
In-Reply-To: <20250110100425.598c939c@hermes.local>
From: Eldho Paul Mathew <eldho789@gmail.com>
Date: Tue, 25 Mar 2025 18:47:30 +0530
X-Gm-Features: AQ5f1Jr_2LWza8XrUApUdqgUEb4IViqzYBYxc2VEO905TRLw1fgsJv-95dcEdS8
Message-ID: <CAOFFPTrA3fu7kxBcdwMPJvLjeNeSurms+dsXXK5Cg4gogfwa8w@mail.gmail.com>
Subject: Re: Driver: bnxt_en
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a703eb06312a8b3c"
X-Mailman-Approved-At: Thu, 27 Mar 2025 14:49:31 +0100
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

--000000000000a703eb06312a8b3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

What is the importance of the 'ice' driver?

Right now I am using 18.05.1. Does it have 'ice' driver support?

We bought a new card: BCM57508 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb/200Gb
Ethernet

To support this card using the 'ice' driver, is the DPDK 18.05.1 version
sufficient, or is there any other driver that is the placeholder for 'ice'
in 18.05.1?

If I need to go for an upgrade, which is the minimum version to support
this card by 'ice'?

Kindly help!



On Fri, Jan 10, 2025 at 11:34=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> On Fri, 10 Jan 2025 10:02:48 +0530
> Eldho Paul Mathew <eldho789@gmail.com> wrote:
>
> > We are using DPDK 18.05.1
> >
> > We received a new network card.
> >
> > Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA
> Ethernet
> > Controller
> >
> > DPDK 18.05.1 has support for this card and driver bnxt_en?
> >
> > If not, which stable version onwards has this driver support added?
>
> Release 18.05 is not a stable LTS version.
>
> Let me teach you how to look this question up.
>
> To look up device you need the actual PCI-ID, using pcilookup.com
>         14e4:16d7
>
> Look at source of drivers/net/bnxt/bnxt_ethdev.c for the pci table
> bnxt_id_pci_map.
> The entry for 16d7 is
>         #define BROADCOM_DEV_ID_57414           0x16d7
>
> Using git blame find the commit that added that:
>
> $ git blame drivers/net/bnxt/bnxt_ethdev.c | grep BROADCOM_DEV_ID_57414
> 3fab7694403 (Ajit Khaparde                   2017-04-26 14:20:02 -0500
>  51)    { RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414_VF=
)
> },
> 1f4a84672ec (Ajit Khaparde                   2017-01-06 13:55:17 -0600
>  60)    { RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414) }=
,
> 1f4a84672ec (Ajit Khaparde                   2017-01-06 13:55:17 -0600
>  68)    { RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414_MF=
)
> },
> 3f6d59b0c88 (Kalesh AP                       2019-12-02 09:48:07 +0530
> 4999)    case BROADCOM_DEV_ID_57414_VF:
>
> So we want 1f4a84672ec
>
> If you look at that commit with a tool like gitk it shows it happened way
> back in 17.02
> And the card is listed in driver for 18.11
>
>

--000000000000a703eb06312a8b3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D""><font face=3D"aria=
l, sans-serif">Hi All,</font></div><div class=3D"gmail_default" style=3D"">=
<font face=3D"arial, sans-serif"><br></font></div><div class=3D"gmail_defau=
lt" style=3D""><font face=3D"arial, sans-serif">What is the importance of t=
he &#39;ice&#39; driver?</font></div><div class=3D"gmail_default" style=3D"=
"><font face=3D"arial, sans-serif"><br></font></div><div class=3D"gmail_def=
ault" style=3D""><font face=3D"arial, sans-serif">Right now I am using 18.0=
5.1. Does it have &#39;ice&#39; driver support?</font></div><div class=3D"g=
mail_default" style=3D""><font face=3D"arial, sans-serif"><br></font></div>=
<div class=3D"gmail_default" style=3D""><font face=3D"arial, sans-serif">We=
 bought a new card:=C2=A0BCM57508 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb/200=
Gb Ethernet</font></div><div class=3D"gmail_default" style=3D""><font face=
=3D"arial, sans-serif"><br></font></div><div class=3D"gmail_default" style=
=3D""><font face=3D"arial, sans-serif">To support this card using the=C2=A0=
&#39;ice&#39; driver, is the DPDK 18.05.1 version sufficient, or is there a=
ny other driver that is the placeholder for &#39;ice&#39; in 18.05.1?=C2=A0=
</font></div><div class=3D"gmail_default" style=3D""><font face=3D"arial, s=
ans-serif"><br></font></div><div class=3D"gmail_default" style=3D""><font f=
ace=3D"arial, sans-serif">If I need to go for an upgrade, which is the mini=
mum=C2=A0version to support this card by &#39;ice&#39;?</font></div><div cl=
ass=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:verdana,sans-serif">Kindly =
help!</div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-s=
erif"><br></div><div class=3D"gmail_default" style=3D"font-family:verdana,s=
ans-serif"><br></div></div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 10, 2025 at 11:34=E2=
=80=AFPM Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org=
">stephen@networkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Fri, 10 Jan 2025 10:02:48 +0530<br>
Eldho Paul Mathew &lt;<a href=3D"mailto:eldho789@gmail.com" target=3D"_blan=
k">eldho789@gmail.com</a>&gt; wrote:<br>
<br>
&gt; We are using DPDK 18.05.1<br>
&gt; <br>
&gt; We received a new network card.<br>
&gt; <br>
&gt; Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Eth=
ernet<br>
&gt; Controller<br>
&gt; <br>
&gt; DPDK 18.05.1 has support for this card and driver bnxt_en?<br>
&gt; <br>
&gt; If not, which stable version onwards has this driver support added?<br=
>
<br>
Release 18.05 is not a stable LTS version.<br>
<br>
Let me teach you how to look this question up.<br>
<br>
To look up device you need the actual PCI-ID, using <a href=3D"http://pcilo=
okup.com" rel=3D"noreferrer" target=3D"_blank">pcilookup.com</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 14e4:16d7<br>
<br>
Look at source of drivers/net/bnxt/bnxt_ethdev.c for the pci table bnxt_id_=
pci_map.<br>
The entry for 16d7 is <br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define BROADCOM_DEV_ID_57414=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00x16d7<br>
<br>
Using git blame find the commit that added that:<br>
<br>
$ git blame drivers/net/bnxt/bnxt_ethdev.c | grep BROADCOM_DEV_ID_57414<br>
3fab7694403 (Ajit Khaparde=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02017-04-26 14:20:02 -0500=C2=A0 =C2=A051)=C2=A0 =C2=A0 =
{ RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414_VF) },<br>
1f4a84672ec (Ajit Khaparde=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02017-01-06 13:55:17 -0600=C2=A0 =C2=A060)=C2=A0 =C2=A0 =
{ RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414) },<br>
1f4a84672ec (Ajit Khaparde=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02017-01-06 13:55:17 -0600=C2=A0 =C2=A068)=C2=A0 =C2=A0 =
{ RTE_PCI_DEVICE(PCI_VENDOR_ID_BROADCOM, BROADCOM_DEV_ID_57414_MF) },<br>
3f6d59b0c88 (Kalesh AP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02019-12-02 09:48:07 +0530 4999)=C2=A0 =C2=A0=
 case BROADCOM_DEV_ID_57414_VF:<br>
<br>
So we want 1f4a84672ec <br>
<br>
If you look at that commit with a tool like gitk it shows it happened way b=
ack in 17.02<br>
And the card is listed in driver for 18.11<br>
<br>
</blockquote></div>

--000000000000a703eb06312a8b3c--
