Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7107CD343F
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 22:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFEE44013F;
	Tue, 19 May 2026 00:13:17 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id 937ED40041
 for <dev@dpdk.org>; Tue, 19 May 2026 00:13:16 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-c827313dac0so1637163a12.1
 for <dev@dpdk.org>; Mon, 18 May 2026 15:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779142395; x=1779747195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BR+nhtAVFR5gP/snGplhFXOF1olNGbGDsy2yUJDtAzE=;
 b=TOXYGiyyle+dQd+hEbjorRiUkH2IuSlNknsq7CAi+S4d1Vu99udOwEauxqBNCYFVD4
 3jT63C8kDcfAsIuiAT6A18vGt7ZsXwNGSPij05qL/CDu4IutyHdxeMnwpplZg9wfPw3z
 Dc8EPsMCavGIAZUWex/MRhm3FA3SlEmobjkhKM8qwERNN2OIgJioIWhhIyyyF1Gex0jC
 HXRIumsG47YRMOo91LSNN6/8feBlwkLJiH1LIL4+C5fWN4fhPGZid57Ti/oHCR53JT51
 nlnmE+R6Nt1A5usSMFw6kbu/32weRkj2mQkz5ySoKxW8LnSkCaG9X0DegQlS9PZSp8M8
 Aw9Q==
X-Gm-Message-State: AOJu0YyLdMkUh9t5iRYO9Pj3hIpmPuoq8MjPciW48iMRyY6hmw/tLCuK
 tHXuJgt6C57aKCLibiPWXeaFQ5yedqgEpwUklZaa2m5nIVOZyirtgH0H9w8/VWAoABxJEhtS5T/
 7VNfFsYy41Zpb1sH5LyMj4jTQP1zQFux7zemmOSlCSi776aCdS0Qy5fmOee4gZavBJJYzramYF8
 n835xdKNgpUdvQWSDSimEhZJ4Du47WWxJtUzS6sgx5vsy92z0miyELJaMsPCuMi0tjpouoHVjbu
 idlzw==
X-Gm-Gg: Acq92OGVx8Hv1bYjMMQdDM5QhPsZSegLC+8ym25SpqjgelFxXD9GI241vPUb3i5V7JV
 ENRYd9nz3S/urvRgfR/WpNYNQSY9dr2wlqSWIHbwh248qMU7P471IJ4hTMiASNafqvAIRR+2TPu
 Ll4RUT623KSuaQyn1xeklQEun6gNCROF5NhizgZntZIM75oreKj9p9OddskoqUIjJNEH/1cTGtB
 ZBojifwp4ZJ2446N0YVgfrgXWZIwJERaOdA4paGJsRYfX9Vmj+kdXblrP5gTpHBb9ms7bn8Na72
 MQy4I29PDMxAqWI0ntfV3N1SLa9tm5ywfr4W6m5zfAW5+WQRkznwgcA94rU8O8mH8y5WBaEYiaM
 3xO350Tp2EveiXZvSwV4UXqjYeRKp0dSigirK157wlVrPEOW85+U4RWlcZ+vBT3FFsvVq8Rlxjf
 hmQIVJoougFscbLhrQNHaszC3kUYW4/MJ1tuIXUboFLP6OrWa2Zl6WugDzjVQPLP1u
X-Received: by 2002:a17:903:4501:b0:2b0:ac1e:9730 with SMTP id
 d9443c01a7336-2bd5277cb20mr128775895ad.14.1779142395285; 
 Mon, 18 May 2026 15:13:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2bd5bd6876fsm11923995ad.11.2026.05.18.15.13.14
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2026 15:13:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bd86cf9d900so94719666b.2
 for <dev@dpdk.org>; Mon, 18 May 2026 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779142393; x=1779747193; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BR+nhtAVFR5gP/snGplhFXOF1olNGbGDsy2yUJDtAzE=;
 b=EZrKj6BCJ/KpD3mFBF9TMzGIE98eL8tWUIvP8Aqx/NtpX51Nq7kPMjM9S1tS7CwdCu
 WDn4mgCzMiKxpn6jXC+aHQCkMWVS7U/60WaveRvP1jwNkdDu2MtfH0PdZifSlDZTRFYG
 JRe74h1sEsJy6SC906xrT3CZvL5uULHpAFlKk=
X-Received: by 2002:a17:907:c291:b0:bd5:ca8:768c with SMTP id
 a640c23a62f3a-bd517964d14mr957837066b.31.1779142392993; 
 Mon, 18 May 2026 15:13:12 -0700 (PDT)
X-Received: by 2002:a17:907:c291:b0:bd5:ca8:768c with SMTP id
 a640c23a62f3a-bd517964d14mr957835666b.31.1779142392514; Mon, 18 May 2026
 15:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260403091836.1073484-1-david.marchand@redhat.com>
 <20260403091836.1073484-3-david.marchand@redhat.com>
 <CA+BST0nbexjrKN7EMd3MerKxbf0syDErkGd+QrKDfEVOWwS=7Q@mail.gmail.com>
 <CAJFAV8wGDsx+SD4JerfduxVvOOj5KJ-FxXeLS-78JOZiAtTgDA@mail.gmail.com>
In-Reply-To: <CAJFAV8wGDsx+SD4JerfduxVvOOj5KJ-FxXeLS-78JOZiAtTgDA@mail.gmail.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 18 May 2026 18:12:55 -0400
X-Gm-Features: AVHnY4LhGBCQXHn-kiHKFyv2ouhBs5HxadShPxICTxOKvONwye6g-e6jMzT1--Q
Message-ID: <CA+BST0k4m+CXGm+0C0CUus25SKSd-6HRjscr7QK0pvpq75Vh0w@mail.gmail.com>
Subject: Re: [PATCH 2/4] ethdev: announce VMDq capability
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, rjarry@redhat.com, cfontain@redhat.com, 
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Rosen Xu <rosen.xu@altera.com>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Zaiyu Wang <zaiyuwang@trustnetic.com>, Thomas Monjalon <thomas@monjalon.net>, 
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000005ca0b206521ede4c"
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

--0000000000005ca0b206521ede4c
Content-Type: multipart/alternative; boundary="0000000000004fa56106521eded3"

--0000000000004fa56106521eded3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 10:18=E2=80=AFAM David Marchand <david.marchand@red=
hat.com>
wrote:

> On Tue, 7 Apr 2026 at 00:22, Kishore Padmanabha
> <kishore.padmanabha@broadcom.com> wrote:
> >> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> >> index b677f9491d..0f783b9e98 100644
> >> --- a/drivers/net/bnxt/bnxt_ethdev.c
> >> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> >> @@ -1214,7 +1214,8 @@ static int bnxt_dev_info_get_op(struct
> rte_eth_dev *eth_dev,
> >>
> >>         dev_info->speed_capa =3D bnxt_get_speed_capabilities(bp);
> >>         dev_info->dev_capa =3D RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP=
 |
> >> -                            RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
> >> +                            RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP |
> >> +                            RTE_ETH_DEV_CAPA_VMDQ;
> >
> > We have not been testing the VMDq feature for sometime, planning to
> deprecate this feature. Please remove this change.
>
> Currently, the driver supports VMDq:
> $ git grep -i vmdq doc/guides/nics/features/bnxt.ini
> doc/guides/nics/features/bnxt.ini:VMDq                 =3D Y
>
> I don't intend to own this feature drop with my series :-).
> Please announce such a deprecation and flag it properly.
>
> I will post another patch to remove VMDq feaure from bnxt driver.

>
> --
> David Marchand
>
>

--0000000000004fa56106521eded3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 29,=
 2026 at 10:18=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marcha=
nd@redhat.com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On Tue, 7 Apr 2026 at 00:22, Kishor=
e Padmanabha<br>
&lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com" target=3D"_blank">ki=
shore.padmanabha@broadcom.com</a>&gt; wrote:<br>
&gt;&gt; diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnx=
t_ethdev.c<br>
&gt;&gt; index b677f9491d..0f783b9e98 100644<br>
&gt;&gt; --- a/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt;&gt; +++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
&gt;&gt; @@ -1214,7 +1214,8 @@ static int bnxt_dev_info_get_op(struct rte_e=
th_dev *eth_dev,<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;speed_capa =3D bnxt_=
get_speed_capabilities(bp);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info-&gt;dev_capa =3D RTE_ETH=
_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP =
|<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ETH_DEV_CAPA_VMDQ;<br>
&gt;<br>
&gt; We have not been testing the VMDq feature for sometime, planning to de=
precate this feature. Please remove this change.<br>
<br>
Currently, the driver supports VMDq:<br>
$ git grep -i vmdq doc/guides/nics/features/bnxt.ini<br>
doc/guides/nics/features/bnxt.ini:VMDq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D Y<br>
<br>
I don&#39;t intend to own this feature drop with my series :-).<br>
Please announce such a deprecation and flag it properly.<br>
<br></blockquote><div>I will post another patch to remove VMDq feaure from =
bnxt driver.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div></div>

--0000000000004fa56106521eded3--

--0000000000005ca0b206521ede4c
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
oIHHMC8GCSqGSIb3DQEJBDEiBCAdUj1frSSMZgFFC0PH37JKt/+vOUJRRt5rdvujqIyOCTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTgyMjEzMTNaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCuh0EZSXQo
iki1E25YhubzTAYTqimq6YoFk+j8HclZtUg7qBC3dxx/dIkoTldD7rYCAD9GUV8/bkpsSed7IlNa
WNAp8uGYldrnjVhFbj8fZkiZPI1ehP6JCYTbLCs1owHNZwL2Ae7OK9RuN/Kl/dPfcRz3MgMof5fl
8uiedumYjlJUofv3GHG53MyL1DTO2/aRFHK3AoHe4H9DgZduQDd/G0pUh+KM7JtovFEXxG4yWZnt
IjPryS9CFgV4jIioaHBG9wuLqsjmUzflR2uhywUPdrw4Ldaw11wTq2ujvRGAu443cNDv4YmTuQ/9
L4ALJMcbMRwLs2XQq47Y3GnenHnW
--0000000000005ca0b206521ede4c--
