Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574FFF9EDD1
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 13:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A44CF40658;
	Wed, 22 Apr 2026 15:36:03 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id AA800402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 15:36:01 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so3654116a12.0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 06:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776864961; x=1777469761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXZh0SGa5YkRf+7wFzgjEyDvG8Kq0ny6Y5ZKEdM9CVM=;
 b=gKLEwoNGe5mKQGGhdEEVORym25/w72zPdDuQHn46Tz7NQG+WxeBD8mCDKf+WhzFVOP
 S2DpN3O9wwD/ZQAGfzJie64VzIKCUBBXKalcj4oShDXd4EtLxwpzjICQElt2Pb+INsqt
 v3qY93C89XneWL1jpLvB7/eyx2BAKm2IrfNXDwbpZS1vifi0j5YK1D/RXRiE61fiKm3K
 h1sut7+uOgE3zcnsJ1kM0Pz13ZzI2eMCHab81P2ccJimho6kZUTm7eu9XH08jDnCRmj7
 lAXqGGwKt/1A5aWV/eUvTof31SDOVd/alHQPyu6FcLDJKZJvhUyvWNcoTDNo1TYOog8P
 3G/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bUnYIQv4b71ctwrXzv7gW8T4pibsLuZ5qoCbIzN2m/boFXZw+6tpTKA9cUm1+gzj7mP8=@dpdk.org
X-Gm-Message-State: AOJu0YzOL36OpSq4UCKoumed0ERYzA0X4W4IculKPQv8jmo+Xks9Bt8M
 vWrbXVyE5d9cdXtkRMp8raFVbXq3iQT5zK7ra+Gop4VU0vVqGq/qgO8siij2nYIawF/TwETRjOd
 FIC19V/eXi/MBvf27EuZW5dJrOtaKDlcvZtl3U4GNnpy1xN2RHwPyO8sqhhyDS15qC7rHO+RQwk
 OTuw7X3pIgbOBYHFJw0Loa5LoXDtDxbHAKM6zRqeEMNJGP/loG9HBJMIa3Uaj3nT+5TS74keZ1w
 bSi8w==
X-Gm-Gg: AeBDievjJsz+45tyJ/uzHB+FMBb0yZS8yWHBV8R1NO7rgi2D2/L+6pwSXqRxjUjVd5k
 P/EwHa/Jys+WZZuriRTIl8uea23xRlmEq2AQoTB68DDclM6KbX6MEkbwKIVr9dsMztQ3KSZ+HZ5
 yzGoy+tTcp4OhQrqISJnmhTmU1PRbLlGORafNs9AzeZaKTpFY7euUxkIZR77QQfqd9M/jp/U5vu
 Jjj/7XmjcMN6L5KWg9m8t945xnWNjO4zCoMW9kblmUQdSM6/anCx3j70bMwkxoWxIHni4w5bBlr
 xBa1G+txJfZltchVb0s41IyPKhuEtafbj1Foa8ENJ/d0DQBZWfbX97l1q0YWrhcxJK4MZkCwdN8
 1/mBbgB1DVMnxCc6eHngc9Hwu9I65LSpOsIUfRNVBRUjjBhozGYlp39Xt3LNWmuZsaWYJEt27aL
 d7RaURJ3RnTz3lWQzUseJ7MQvtIBTGZ71zJod/Rx0DHMZGyGAhJuEysOC99COR2VQZ+9SejvpUM
 xQ=
X-Received: by 2002:a05:6a20:4324:b0:39b:862e:634d with SMTP id
 adf61e73a8af0-3a08d8fe954mr25422854637.39.1776864960551; 
 Wed, 22 Apr 2026 06:36:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c7976fac5f1sm633197a12.4.2026.04.22.06.35.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:36:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-670b68fc10bso3787188a12.3
 for <dev@dpdk.org>; Wed, 22 Apr 2026 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776864958; x=1777469758; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IXZh0SGa5YkRf+7wFzgjEyDvG8Kq0ny6Y5ZKEdM9CVM=;
 b=OjahYfcqhAalEzRx46zvjl0CyhhsJFbLgE225H5bfWAMvXnp1OOI8dx+oSK9w+03eG
 1TutfowGiZIOtt0vvgKZF+bhIpBMg8czumedxpBCHMBUYlhT1csNA098ur3hgonzTqmD
 Bo60Hq8vAZYwKAN6cyY+gM74MDqwD2/VZ9jyQ=
X-Forwarded-Encrypted: i=1;
 AFNElJ+T+AUHBnZfv3EFAge0Tuu2w2keNtTjtRG7pRYzpcdK2HvtWMFxpBn2Idz6PaPZLYahodE=@dpdk.org
X-Received: by 2002:a17:907:25c3:b0:bab:ca56:a42a with SMTP id
 a640c23a62f3a-babca56aa66mr29550266b.42.1776864958463; 
 Wed, 22 Apr 2026 06:35:58 -0700 (PDT)
X-Received: by 2002:a17:907:25c3:b0:bab:ca56:a42a with SMTP id
 a640c23a62f3a-babca56aa66mr29547066b.42.1776864957827; Wed, 22 Apr 2026
 06:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260417045640.2217188-1-lyulin.2003@mail.ru>
 <CA+BST0=Ntw_W_57uZ7DqLLFhxs9fvFsGBOiKGiZvy7GFwwubHA@mail.gmail.com>
 <20260417100357.7ef0dd36@phoenix.local> <1776833074.769361490@f461.i.mail.ru>
In-Reply-To: <1776833074.769361490@f461.i.mail.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Wed, 22 Apr 2026 09:35:41 -0400
X-Gm-Features: AQROBzCHTR5vnGEmDguYfWSBKZJiGoc-3ASfwgCWgj0syK2IhmZ73Gq9emQQWIM
Message-ID: <CA+BST0nDyxKvqiubCjCvQ+zK0F2J9pw-_O6UTvtdPqCBXQ5EVQ@mail.gmail.com>
Subject: Re: Re[2]: [PATCH 1/1] net/bnxt: fix string bounds checks and format
 specifiers
To: =?UTF-8?B?0JTQtdC90LjRgSDQm9GO0LvQuNC9?= <lyulin.2003@mail.ru>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, dev@dpdk.org,
 stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b0e57206500c9c66"
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

--000000000000b0e57206500c9c66
Content-Type: multipart/alternative; boundary="000000000000a0363006500c9cdc"

--000000000000a0363006500c9cdc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The size of the string should not exceed 27 or 28 bytes less than
RTE_MEMZONE_NAMESIZE.

On Wed, Apr 22, 2026 at 12:44=E2=80=AFAM =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=
=9B=D1=8E=D0=BB=D0=B8=D0=BD <lyulin.2003@mail.ru> wrote:

> > > diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> > > b/drivers/net/bnxt/bnxt_ethdev.c
> > > index b677f9491d..bb02a2579b 100644
> > > --- a/drivers/net/bnxt/bnxt_ethdev.c
> > > +++ b/drivers/net/bnxt/bnxt_ethdev.c
> > > @@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
> > >
> > > max_fc =3D bp->flow_stat->max_fc;
> > >
> > > - sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
> > > - pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> > > + snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_in_" PCI_PRI_FMT,
> > > + pdev->addr.domain, pdev->addr.bus,
> > > + pdev->addr.devid, pdev->addr.function);
> > > /* 4 bytes for each counter-id */
>
> >Rather than silently truncating, it should return an error.
>
> As far as I understand, these strings are used as diagnostic information
> when tracing is enabled. Is the truncation of a debug string so critical
> that we should interrupt device initialization by returning an error? For
> example, Linux kernel truncates worker thread names if the strings are to=
o
> long
> =D0=BF=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D0=B0, 17 =D0=B0=D0=BF=D1=80=D0=B5=
=D0=BB=D1=8F 2026=D0=B3., 20:04 +03:00 =D0=BE=D1=82 Stephen Hemminger
> stephen@networkplumber.org:
>
> On Fri, 17 Apr 2026 12:43:07 -0400
> Kishore Padmanabha <kishore.padmanabha@broadcom.com
> <https://e.mail.ru/compose?To=3Dkishore.padmanabha@broadcom.com>> wrote:
>
> > > diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> > > b/drivers/net/bnxt/bnxt_ethdev.c
> > > index b677f9491d..bb02a2579b 100644
> > > --- a/drivers/net/bnxt/bnxt_ethdev.c
> > > +++ b/drivers/net/bnxt/bnxt_ethdev.c
> > > @@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
> > >
> > > max_fc =3D bp->flow_stat->max_fc;
> > >
> > > - sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
> > > - pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> > > + snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_in_" PCI_PRI_FMT,
> > > + pdev->addr.domain, pdev->addr.bus,
> > > + pdev->addr.devid, pdev->addr.function);
> > > /* 4 bytes for each counter-id */
>
> Rather than silently truncating, it should return an error.
>
>

--000000000000a0363006500c9cdc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The size of the string should not exceed 27 or 28 byt=
es less than RTE_MEMZONE_NAMESIZE.=C2=A0</div><br><div class=3D"gmail_quote=
 gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 2=
2, 2026 at 12:44=E2=80=AFAM =D0=94=D0=B5=D0=BD=D0=B8=D1=81 =D0=9B=D1=8E=D0=
=BB=D0=B8=D0=BD &lt;<a href=3D"mailto:lyulin.2003@mail.ru">lyulin.2003@mail=
.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<div><p style=3D"margin-top:0px" dir=3D"ltr">&gt; &gt; diff --git a/drivers=
/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; b/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; index b677f9491d..bb02a2579b 100644<br>
&gt; &gt; --- a/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; +++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; @@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *=
bp)<br>
&gt; &gt;<br>
&gt; &gt; max_fc =3D bp-&gt;flow_stat-&gt;max_fc;<br>
&gt; &gt;<br>
&gt; &gt; - sprintf(type, &quot;bnxt_rx_fc_in_&quot; PCI_PRI_FMT, pdev-&gt;=
addr.domain,<br>
&gt; &gt; - pdev-&gt;addr.bus, pdev-&gt;addr.devid, pdev-&gt;addr.function)=
;<br>
&gt; &gt; + snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt_rx_fc_in_&quot;=
 PCI_PRI_FMT,<br>
&gt; &gt; + pdev-&gt;addr.domain, pdev-&gt;addr.bus,<br>
&gt; &gt; + pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
&gt; &gt; /* 4 bytes for each counter-id */</p>
<p dir=3D"ltr">&gt;Rather than silently truncating, it should return an err=
or.</p>
<p dir=3D"ltr">As far as I understand, these strings are used as diagnostic=
 information when tracing is enabled. Is the truncation of a debug string s=
o critical that we should interrupt device initialization by returning an e=
rror? For example, Linux kernel truncates worker thread names if the string=
s are too long</p>
=D0=BF=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D0=B0, 17 =D0=B0=D0=BF=D1=80=D0=B5=D0=
=BB=D1=8F 2026=D0=B3., 20:04 +03:00 =D0=BE=D1=82 Stephen Hemminger <a href=
=3D"mailto:stephen@networkplumber.org" target=3D"_blank">stephen@networkplu=
mber.org</a>:<br><br><blockquote id=3D"m_5315368748831621944mail-app-auto-q=
uote" cite=3D"http://17764454431941097980" style=3D"border-left:1px solid r=
gb(41,123,239);margin:0px 0px 0px 10px;padding:0px 0px 0px 10px"><div>
   =20
   =20
   =20
    <div id=3D"m_5315368748831621944style_17764454431941097980">
        <div id=3D"m_5315368748831621944style_17764454431941097980_BODY">On=
 Fri, 17 Apr 2026 12:43:07 -0400<br>
Kishore Padmanabha &lt;<a href=3D"https://e.mail.ru/compose?To=3Dkishore.pa=
dmanabha@broadcom.com" target=3D"_blank">kishore.padmanabha@broadcom.com</a=
>&gt; wrote:<br>
<br>
&gt; &gt; diff --git a/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; b/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; index b677f9491d..bb02a2579b 100644<br>
&gt; &gt; --- a/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; +++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt; &gt; @@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *=
bp)<br>
&gt; &gt;<br>
&gt; &gt;         max_fc =3D bp-&gt;flow_stat-&gt;max_fc;<br>
&gt; &gt;<br>
&gt; &gt; -       sprintf(type, &quot;bnxt_rx_fc_in_&quot; PCI_PRI_FMT, pde=
v-&gt;addr.domain,<br>
&gt; &gt; -               pdev-&gt;addr.bus, pdev-&gt;addr.devid, pdev-&gt;=
addr.function);<br>
&gt; &gt; +       snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt_rx_fc_in_=
&quot; PCI_PRI_FMT,<br>
&gt; &gt; +               pdev-&gt;addr.domain, pdev-&gt;addr.bus,<br>
&gt; &gt; +               pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
&gt; &gt;         /* 4 bytes for each counter-id */<br>
<br>
Rather than silently truncating, it should return an error.</div>
       =20
    </div>
</div></blockquote></div>
</blockquote></div></div>

--000000000000a0363006500c9cdc--

--000000000000b0e57206500c9c66
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGpzCCBI+g
AwIBAgIMTxuM8PbwRQIs9uJeMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTIxOFoXDTI3MDYyMTEzNTIxOFowgekxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzETMBEGA1UEBBMKUGFkbWFuYWJoYTEQMA4GA1UEKhMHS2lzaG9yZTEWMBQGA1UEChMNQlJP
QURDT00gSU5DLjEoMCYGA1UEAwwfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTEuMCwG
CSqGSIb3DQEJARYfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtFWP+ax39qiJZsJuukdoqMyp0GWGaJ6MdaHvAxXWiEY5zmTiVU
QnpmNYp5SO1Cd1cBqDB0dcelQbiQ1qh+lnlUchJLR63y0ysUvUNvqV493q8+pHCm/2jPb0/R9rec
/jxwM9jaPAVkhGBwvudSfOAQlMPORtAHZyLHKFINcsNfLrGP/3lx+zj30v5tmDN7isOLWos7Jm/U
qRdC7UuUiXgX7q8xXd1MQlA95O73IY/Qb/y0ChEjGPb+U1wr+OsAWJ5fcjQXA/ffBb2GmMp9OUOs
wVNq8iHfie9nzNaaRw+yoyn0ovoiq2W3Q6r+U53ha/lz0itqCrJZN+G0MFf+cX8CAwEAAaOCAeMw
ggHfMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggr
BgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1l
Y2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2Ny
NnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGg
MgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5
LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWlt
ZWNhMjAyMy5jcmwwKgYDVR0RBCMwIYEfa2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTAT
BgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNV
HQ4EFgQURIyot+ZP/mdwQsofZexqAvOm5pMwDQYJKoZIhvcNAQELBQADggIBAKc5gYnhyTf+f6cm
kAHy1a4cLIWou43yaS+M/r69Pv44EVYvHxqt0mMvKh3U40Y+pHKph+VCjdoINKCd1SaqAFIqqEO4
XHWrFi3QAI3snUB6spPIoHN/srAcpX9tdrnAlyK593pq+H+mTMoFIGBP/oc8XCtaDgHp37rpuK9Q
qhF9h5cEJWgShmD7/Q02YydW3jsioy8HdTUD9fib1fRwiSc9uGq8JV5NJsYiJsi9FUz7kTUPohO0
h6U9tRUVmAf9gPbU46rin9By5X4Lt1jKge5O0vFEawCTr/pLmDcIf7CqRZfBoNalKOsBDovoeAOf
pXmQzQEMhnaf93MvbFvZaxC9Ir92DR45BH42xZuLKcQVUsqyLKwC6kEZg81AnZsRAUVpMvqiGbVb
hZnabsHragNY7Br3VCA2OaWk9yRRjt1UwzfIEEMNWqZeQzzAqKIR3XdXIrqAUlMQOX42tSV9FaIv
PSmR3uaH2M0/bRtz4TE1qRuTsLlr+XEGMxHssK7u7+WYM7EGF3ueZLcE7WmnwXEFli5Y5QX0SnmT
W8uDQvdvRdxXg4lkBLyifOudYTP3fULjpD6RWQPFlUPlh8F5QQEdKlfKW94rGD+O0u4sWi/msZw0
6VTvZ6C2BbUMJAo7coFff48NkW2xfICC8Kn1eU1eiWCrPSAls8STm9q25wOQMYICVzCCAlMCAQEw
YjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xv
YmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMTxuM8PbwRQIs9uJeMA0GCWCGSAFlAwQCAQUA
oIHHMC8GCSqGSIb3DQEJBDEiBCA4MON8bU0sLxLC7MKMo/yWhNSrbFKKfnzABWhphmA6vDAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MjIxMzM1NThaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAHd7P2WeXP
VsmQZrBWLlqK3EdRu4chrpXpZnTLXgauu095ygqn1T7x4MpnvjG4ZHaPepgIxMeks0ujF9yPuQh+
v2xmofcnLVtTV3T81vkddi1tiqwgwTDYx3486BA45VhjS6cQ2rmIY8A3oQZY6RL8OklebmepFkVJ
804VzN5dnm1q6NlE+M5PLuZ1tvvvUq22O1qaTePsT5ndo8tA9C5z/hpm20DOTPiUZrw3zPhQsZMm
OCiB4MdeB/9JuhJ2/dJqlc2TS6+AMW7kooCg1xxqO3LUA34LVZu4AY/HgVBLL/hNuRrjS0iAd2kj
sZO/bsyzwXmO9zBGA+iaXpgeHPUb
--000000000000b0e57206500c9c66--
