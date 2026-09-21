Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461BC982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE93D42DF0;
	Mon, 21 Sep 2026 21:11:54 +0200 (CEST)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by mails.dpdk.org (Postfix) with ESMTP id 5909140E2B
 for <dev@dpdk.org>; Mon, 21 Sep 2026 21:11:53 +0200 (CEST)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cc4b5bdd578so162615a12.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790017912; x=1790622712;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ehn1HSCDl1QKsieoCeU8PbiQs466EhQNhvK3inSzcaM=;
 b=JNe+CwUiSbhj4Nf5jN4I/NFbe1tEtT1+KzPdeZpcfat2q9sSzSytq4ZTEmVy+RYQU5
 U0+NUEWNHBF/FX4WtEQdD28CgZYGpmy/wD/JT7cFIUU8lVtql+oCdiFYOckZmUGab3U2
 MDCzCN2tzAtUQjyTs4f1QCASb/l5k0/pR2RVOMXW2ENdfzCUzwHgfN+ekvWZu+49F9k6
 WY+tc8U+w/aawHSVHLD/nGNntWRIvhuk5vxVdPKzquppATVN+OFlYJoCDleqTzvyUbbt
 P/vouTuDO90hjUe2gafpsvEFcDCMOauoevnb/xXzAPZ8NERIWtVVScZZ45pazPL6kVS3
 qDfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOdqLQpBdMScNkSNpFNhmkEj/t/bLtkSWawKiKh7UmbdU5r8EQE5xtOhce+idObiQd+Vw=@dpdk.org
X-Gm-Message-State: AFuF++nc7ziw9r8isywzJSQ5g8CkvNArRfs41Xs422hxwcZXhRO4kkVh
 5F8tPKDRhzcjfDM/GZgskJABCQrQuS1EyzRTRIqVJqIaAJdhRrx78GayVLvbXIWV50Z+Isg337o
 m/fKSK0CWM4AB+uniW1ccIeDaR0+FIONsTnZH+C7WQT9VRUqGn98vssZBlmYWENg3wdIcQCtv6G
 n1CTqMtmjwHGCo5pB23A743H6EbePXD/VxS2LlwYjI+xhBLxkkNNaBrOc29U2DkyziQPjho0j1e
 h5S9w==
X-Gm-Gg: AYBFou3WTmUgreZMqt9h+REqeZG679VjPvar0IXoQp3kKZ9WSq8/C/OjHE73XCs+qDH
 pPYdBerQCQclWvkSB/enNB1/gC7+qHBTZYJ/TUhcU8V7Y4rQF/Sy7zuJlZm/CsG7mpHZikU7gX/
 za3Cl9kzAVEd7nJNb99JLqMGNtaitNN8aLDPkYa0LEGDH7aLJC3to7vJPBG0CXxXKvBuSEcuroX
 g3RcfLFpolDy3QDi+KbICsMa8ygkNTojtYh+GBZkAQyIKYniSQifpro0MlmQZLCb0pavBkcuWYm
 7W8Q/vaLS/KUzAa2+42n7DE5m6GrlPgOaFSXsmJKxLTRyzGdqaAO4HHhAOWoPX+9c7KheNIKbh4
 LyERM7X2dHaKbeLpxzDEOEvlUMpptgoDx9fjL34rylkj/01B2zwQrHPayXmL0swHGYq43yvFZaX
 Tlt0/9X+gna6cAFndMU4z0zBBxHdjQQrGyJu9t0tme8jo=
X-Received: by 2002:a05:6a20:3946:b0:3dd:85a8:cace with SMTP id
 adf61e73a8af0-3dd8c4ab5d2mr17498972637.37.1790017911988; 
 Mon, 21 Sep 2026 12:11:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72a285b65sm4168735a12.0.2026.09.21.12.11.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 12:11:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c29466736e3so355485466b.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790017910; x=1790622710; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ehn1HSCDl1QKsieoCeU8PbiQs466EhQNhvK3inSzcaM=;
 b=P/uPEXmxKarFBaIfsHGFClyNGkZU+W9a0UyBv53gUh1zX5enZEkWlKNAb5yRBvpFkC
 Lj9Nke5exYpyIirO69uEVmhIKkfAez5+iL0d9MO66IYLiApSrbvINzS2LlYzCnYBujvh
 674tBlUp4t5eno3CnFUPVKM53abdRsYGckmVQ=
X-Forwarded-Encrypted: i=1;
 AKwUvBzl5WuYJEKfN+KKQE031pbz1psHlPdhtzmTvhvKS7jCQo/l4uqNB+eiHNUqX2wgALp8E9o=@dpdk.org
X-Received: by 2002:a05:6402:551a:b0:6a6:32fa:cae with SMTP id
 4fb4d7f45d1cf-6aa56514857mr9209176a12.19.1790017909852; 
 Mon, 21 Sep 2026 12:11:49 -0700 (PDT)
X-Received: by 2002:a05:6402:551a:b0:6a6:32fa:cae with SMTP id
 4fb4d7f45d1cf-6aa56514857mr9209159a12.19.1790017909274; Mon, 21 Sep 2026
 12:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260915085502.430947-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915085502.430947-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 15:11:31 -0400
X-Gm-Features: AcwNN1WilBzHIkw7zvNicxilpU7lsgCv42MDSBOT8zgBYCwictYbR04I_s8qPdI
Message-ID: <CA+BST0=OBrW4vHGRDOMo4YKb4jeMGDd3PVwfD=mE=CY6451Scg@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: prevent overflow in alarm timeout calculation
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org, 
 kalesh-anakkur.purayil@broadcom.com, somnath.kotur@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000ad22fe065c0305a7"
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

--000000000000ad22fe065c0305a7
Content-Type: multipart/alternative; boundary="0000000000009fe440065c03050a"

--0000000000009fe440065c03050a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This change is already added as part of
https://git.dpdk.org/next/dpdk-next-net-brcm/commit/?id=3Dc2b39669f47956d01=
5d490dfa6e405d4272c08d2

On Tue, Sep 15, 2026 at 4:55=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> The alarm timeout is calculated by multiplying wait_msec by
> US_PER_MS before passing the value to rte_eal_alarm_set().
>
> Since wait_msec is a uint32_t, the multiplication may overflow
> when performed using 32-bit arithmetic for large timeout values.
>
> Cast wait_msec to uint64_t to ensure the multiplication is
> performed in 64-bit arithmetic.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> Cc: stable@dpdk.org
> ---
>  drivers/net/bnxt/bnxt_ethdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index a2429561b9..16a65f9770 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -4855,7 +4855,7 @@ static void bnxt_check_fw_health(void *arg)
>
>         info->last_reset_counter =3D val;
>
> -       rte_eal_alarm_set(US_PER_MS * info->driver_polling_freq,
> +       rte_eal_alarm_set(US_PER_MS * (uint64_t)info->driver_polling_freq=
,
>                           bnxt_check_fw_health, (void *)bp);
>
>         return;
> @@ -4877,7 +4877,7 @@ static void bnxt_check_fw_health(void *arg)
>         else
>                 wait_msec =3D info->normal_func_wait_period;
>
> -       rte_eal_alarm_set(US_PER_MS * wait_msec,
> +       rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_msec,
>                           bnxt_fw_reset_cb, (void *)bp);
>  }
>
> @@ -4895,7 +4895,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)
>
>         polling_freq =3D bp->recovery_info->driver_polling_freq;
>
> -       rte_eal_alarm_set(US_PER_MS * polling_freq,
> +       rte_eal_alarm_set(US_PER_MS * (uint64_t)polling_freq,
>                           bnxt_check_fw_health, (void *)bp);
>         bp->flags |=3D BNXT_FLAG_FW_HEALTH_CHECK_SCHEDULED;
>
> --
> 2.30.2
>
>

--0000000000009fe440065c03050a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>This change is already=C2=A0added as part of=C2=A0<a =
href=3D"https://git.dpdk.org/next/dpdk-next-net-brcm/commit/?id=3Dc2b39669f=
47956d015d490dfa6e405d4272c08d2">https://git.dpdk.org/next/dpdk-next-net-br=
cm/commit/?id=3Dc2b39669f47956d015d490dfa6e405d4272c08d2</a></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, Sep 15, 2026 at 4:55=E2=80=AFAM Evgeny Sokolov &lt;<a href=
=3D"mailto:Evgeny.Sokolov@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Soko=
lov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_bla=
nk">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
<br>
The alarm timeout is calculated by multiplying wait_msec by<br>
US_PER_MS before passing the value to rte_eal_alarm_set().<br>
<br>
Since wait_msec is a uint32_t, the multiplication may overflow<br>
when performed using 32-bit arithmetic for large timeout values.<br>
<br>
Cast wait_msec to uint64_t to ensure the multiplication is<br>
performed in 64-bit arithmetic.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index a2429561b9..16a65f9770 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -4855,7 +4855,7 @@ static void bnxt_check_fw_health(void *arg)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;last_reset_counter =3D val;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * info-&gt;driver_p=
olling_freq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * (uint64_t)info-&g=
t;driver_polling_freq,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bnxt_check_fw_health, (void *)bp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
@@ -4877,7 +4877,7 @@ static void bnxt_check_fw_health(void *arg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_msec =3D info-=
&gt;normal_func_wait_period;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * wait_msec,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_ms=
ec,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bnxt_fw_reset_cb, (void *)bp);<br>
=C2=A0}<br>
<br>
@@ -4895,7 +4895,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 polling_freq =3D bp-&gt;recovery_info-&gt;drive=
r_polling_freq;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * polling_freq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_eal_alarm_set(US_PER_MS * (uint64_t)polling=
_freq,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bnxt_check_fw_health, (void *)bp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;flags |=3D BNXT_FLAG_FW_HEALTH_CHECK_SCH=
EDULED;<br>
<br>
-- <br>
2.30.2<br>
<br>
</blockquote></div></div>

--0000000000009fe440065c03050a--

--000000000000ad22fe065c0305a7
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
oIHHMC8GCSqGSIb3DQEJBDEiBCC9Y0EEDh2eb6bIVxE1kBlI1BRl6YY5xeOh1P/YCEUlkjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExOTExNTBaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCG2HLxnQj8
oIjp2aUakmNNA3AaJvQ/YjMWwAakTfazkixxGLbNJQTtu5bD23vcZx2U7at9C3CWibb0Q3SNNBPO
W5nqxpK2WNEF0w/8nrlVCjYUhfWOtTsbDJzay3ZNvYTmOfe/Q2PNG17O0LP5PMG3iFMTUdG8JX74
r7Bly+mrgu0PD/Cpe9padHDAsblYR8xEKQ4pzPDlleB5AFmuk1YsSpdCBV9+MiH7nSZX50CoXGtZ
bsHzUU0Ev/FGo3BuIhFl28U2SeNNCsYgix1RI+3cBARlKxC8IHMook2NyJgcOI7A5rMv078NpY1t
iqwzHz2+HhkRg9IAeB89hYDNUbiv
--000000000000ad22fe065c0305a7--
