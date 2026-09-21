Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1AFC982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6633140E2B;
	Mon, 21 Sep 2026 21:42:07 +0200 (CEST)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by mails.dpdk.org (Postfix) with ESMTP id AA29840B94
 for <dev@dpdk.org>; Mon, 21 Sep 2026 21:42:05 +0200 (CEST)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-91041ee9230so6291316d6.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790019725; x=1790624525;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oiRdU9rEQP8DCLGHbzaHTmtnts0KC0SE1b1iT/u9NNQ=;
 b=VsFLOkC7K8kF0glvQAxjJColdRDD3lZJSIAyFAHsQmL8ZM0rveetCxTmEyh/xEgxMv
 z9UVVNLNQPyZAONq7tEgb+qMNLOZb8hBPv80z8iCgmeGu79aAY3XvdMYxTs1cEBS9Ya4
 lrWXN5VSfNJPqrA6WzX4gAH3Hy8iOpmPORZA990dUWxM3zyr0OFx1evqfbOXqmRJ642m
 zXur9Gh/7sluUrqUHmnaIR7z5Lx301cRWEovw56utfzez/CEvbltTPG+JZ8OM3lhVBO+
 f2IZHOwYvZtGiqdNkLfcSStQC7qDMCPc4G/I9cDXaTo/k4932qv4fNQZnV2bb9XbwVvR
 fniA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRwoM+2R6MGFPSHATEumHgpGt8Pc4T42kDEt4iUzOPLY34pH1ahTnAMwqlWDmGALpUu30=@dpdk.org
X-Gm-Message-State: AFuF++ln0xnICXcAGRxJU/MqS/cwtH1tnlkuIRPZYrG8+ijPJQzh410i
 dI9l0qw6BLKEguOrppk3gpExuIAeFKUKwh0IJwRdir/FNSJq1kpGPEfu0nWECaaeiZ4UM91FBHz
 LY+rxPj1o5bufav/svH20XV5FlQd3laFpoX/fwBiLqi3uEfhLC7DaOe+T4EKkByAYqnYUefIr9D
 Xl8gFoIV9TQW/bPdF5spH7ul7gZkutoVbgW5IOADriyrxhPcNjXp+OjegaKFTVjQblTspmqwbXB
 b3kHA==
X-Gm-Gg: AYBFou3SsHo7L2VM8RtQ+TL1xXHY+YD0KsgwzEbPOczTT6Ehtwr7RBDKXF2UvFrJNkq
 CGFySgByLUgA9em5UcHNa3dIlpmeBRa01t75My4ReJnG5fnB/feVDac5FHKDoUtpddIz4u/jUhb
 5uB36UqaT0VOXdev0QUNp2GxnFdRRl1nNmJunLJHGIDaF57Nm5gOvdv0HwlByXjd1qBTnV/HbHN
 rBn/WLJqDCgmu0UjoG/laCbKGMWZ/GOytEWnZHrebNJ17iDX4NQAm8GdO87hC2cmJyXqKKfEGkm
 M/cTIA463ILe/EJGQVhFd/vw2geL3uh2ZYAAoBz1u1nUuRXhT9MMTD4/LWvZnUK3IsXVzJpTZ0g
 GCeYEmLCMe9vHms5Dy++L3mULOtYfRmShzzrUa6zKzGzZxLw4UDXzWRcBE3E89DILP2cmGcvED8
 HYMx3tg6VJwSXO8eF6FTwUGZzPJyA/3C6CEqD77MO35r4=
X-Received: by 2002:a05:6214:3a89:b0:912:6093:e642 with SMTP id
 6a1803df08f44-913fc94834emr20546206d6.33.1790019724761; 
 Mon, 21 Sep 2026 12:42:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-91260bcc149sm633126d6.25.2026.09.21.12.42.04
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 12:42:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a98570af94so256828a12.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790019723; x=1790624523; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oiRdU9rEQP8DCLGHbzaHTmtnts0KC0SE1b1iT/u9NNQ=;
 b=Xp0kSJSEQHLqCTQDQ3jlrJB5ECLOxRiMpUuOaotRFfsIBVQPvddSWZWdbDFTIxCuP5
 dbU6lmTvCZI2V3mOHV23qMkzBlksAprF/HV7C8PDC4UBF7TuHu82+tkUiYWKilZUjD18
 F+3Lpycn06I/On4F0rwzH/6LMxN5tUJ0N8EKU=
X-Forwarded-Encrypted: i=1;
 AKwUvBxho9DxmpgZicF+IRUrnpYP1G2Q+Ml0QfvfijXCVTu7Q9ovjks/w9FEriojlnQdlgR6Of0=@dpdk.org
X-Received: by 2002:a05:6402:5606:b0:6a6:b2b9:7667 with SMTP id
 4fb4d7f45d1cf-6aa9ff2bf95mr413620a12.20.1790019723156; 
 Mon, 21 Sep 2026 12:42:03 -0700 (PDT)
X-Received: by 2002:a05:6402:5606:b0:6a6:b2b9:7667 with SMTP id
 4fb4d7f45d1cf-6aa9ff2bf95mr413614a12.20.1790019722729; Mon, 21 Sep 2026
 12:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260915091150.431471-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915091150.431471-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 15:41:44 -0400
X-Gm-Features: AcwNN1VHAamUqBnVVGfU1vNjCr3eM46DP_DGjQk49YzqONskWNF4zVHdrbUNNtc
Message-ID: <CA+BST0=1h4LWdoGmL-q3yfHZWPMvwBBGWhqd2dN2PhqHHaEwzw@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt/tf_ulp: use 64-bit shift in burst size
 calculation
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org, 
 stuart.schacher@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000c16796065c0371b9"
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

--000000000000c16796065c0371b9
Content-Type: multipart/alternative; boundary="000000000000b7091b065c03711d"

--000000000000b7091b065c03711d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:11=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> Use 1ULL instead of 1 in the left shift operation when
> calculating the burst size mantissa.
>
> This avoids undefined behavior when the shift count exceeds
> the width of a 32-bit integer.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> Cc: stable@dpdk.org
> ---
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> index 7f6a84e699..88a2f30521 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c
> @@ -155,7 +155,7 @@ bnxt_ulp_flow_mtr_xbs_calc(int64_t xbs, uint16_t *reg=
)
>          *   =3D round(xbs*2^(8-e) - 2^7)
>          *
>          */
> -       m =3D xbs / (1 << (e - 8)) - (1 << 7);
> +       m =3D xbs / (1ULL << (e - 8)) - (1ULL << 7);
>         *reg =3D ((m & 0x7F) << 5) | (e & 0x1F);
>         *reg =3D rte_cpu_to_be_16(*reg);
>  }
> --

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.30.2
>
>

--000000000000b7091b065c03711d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 5:11=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny &lt;<a href=
=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.Sokolov@inf=
otecs.ru</a>&gt;<br>
<br>
Use 1ULL instead of 1 in the left shift operation when<br>
calculating the burst size mantissa.<br>
<br>
This avoids undefined behavior when the shift count exceeds<br>
the width of a 32-bit integer.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
---<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c b/drivers/net/bnxt/tf=
_ulp/bnxt_ulp_meter.c<br>
index 7f6a84e699..88a2f30521 100644<br>
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c<br>
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c<br>
@@ -155,7 +155,7 @@ bnxt_ulp_flow_mtr_xbs_calc(int64_t xbs, uint16_t *reg)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0=3D round(xbs*2^(8-e) - 2^7=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D xbs / (1 &lt;&lt; (e - 8)) - (1 &lt;&lt; =
7);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D xbs / (1ULL &lt;&lt; (e - 8)) - (1ULL &lt=
;&lt; 7);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *reg =3D ((m &amp; 0x7F) &lt;&lt; 5) | (e &amp;=
 0x1F);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *reg =3D rte_cpu_to_be_16(*reg);<br>
=C2=A0}<br>
--</blockquote><div><span style=3D"font-family:Calibri;font-size:11pt;backg=
round-color:transparent">Acked-by:=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"> <br>
2.30.2<br>
<br>
</blockquote></div></div>

--000000000000b7091b065c03711d--

--000000000000c16796065c0371b9
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCIL9nFfFN9SW4msfApHwy63WhP+6dcz4u1AODk+G/54TAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExOTQyMDNaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQByZatlA5A5
CyXOSKyJheS17fxVmpr5HMQrU31EWk+3dw/QfHl4LhnO8JEuvgoYbaVGAbnsP9tsd6CkDuJLI1AY
A6wbKSkxrKwt5/qnXB3smGxd7uq0hgDnciVRgYwFVDBtbaujCFlQFafDycdpXjxTKUwPzYB0Lqnv
Z663ZpkAt1VMGdwrSkFCm2SZOx1YEDQ58iax/dq5zeJd9ALfNokhSPd4lyQnmn+7BCvi9ynYiSig
d9gWnMDPojIoOBlw56A28/eDscnPkE3bx3eEU10jzZIPHilMFfXN+1K0/uBlvVIpHKhpW/Bh+uZq
R5KEzN4+xuLMINNz3CLVuahKvsno
--000000000000c16796065c0371b9--
