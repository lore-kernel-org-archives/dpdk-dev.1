Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B14F436B4
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:46:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5491A402DD;
	Fri, 17 Apr 2026 18:46:53 +0200 (CEST)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by mails.dpdk.org (Postfix) with ESMTP id B83E3402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:46:51 +0200 (CEST)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-8d933da14f0so92660985a.2
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444411; x=1777049211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3hc/Km3ja6nQa2LhB2tu3AXIwEDYuekdRKiKQuS7zw=;
 b=bmyYaadtSsnJaLxitM7DOELJ6PXNa+NxhKJI2IoYsDsURUatgq/4jt/GpedQHxqSdx
 5hCtBoHhBDV7rymwwLl7BkfKxY7dKh9Elej/Aua89dSIGE7p9PJXrJlb/O21g0TN5y14
 XPDoZ0HD1wxFO7T+DNb4PNBk6na49mj8kFi1WUttVu/meNdfTTv8GNoPF8QycH3Icdf+
 O9i/f94NnK51pMiDsonnlBsBfZmijkUp9Vc1+Rhtw+SE3NVlTFEklAAgH2kP+Nw7wAID
 b3ai5Z02+CnNi3Ab21YbjXS2TECpxeKgLs25/C03sGEXETZaFdAr9YCpWjS6LB6YwFXD
 H5Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0+JuqWJ47Y6prYiAd/w/wBhtN0BZ2kFdeQlRj1EuhJhMU9RS9m4GqKzzF7JMlcgbiRaM=@dpdk.org
X-Gm-Message-State: AOJu0Yws7SHgxYQAueIF46kM2pq9PUMz7vyDmu7gmAqkB44Fvnw6IlN+
 GQlAFkI0q5uD0Go8eQQM35GMy3FmsbYLtoY2AC/d30xPfFRQHnbyu4ZzJ6VnxEJpxfToeTdYsQe
 Na/u4VMeFxwB2Vn9n+TAhhbYbYNTXV3xbHbOs73POtPRKqcyu2az7tc6sybTz9WavtD2/DHVdI1
 cvPArFhfC8KZ7Zp9urFTY+qNih3qCzrNpMwT2OnwBEHoMlAwByFK1RHYXYn8bwUaoTpUfQpMPFS
 lAyMg==
X-Gm-Gg: AeBDievVSXPQT12YIoWEkI/zNZr3l5Vaa4C5GsBezRPS5/7+2DmlUj7QVVRFut1l2AK
 uVjEiAUcqURl74i4nYNN6REAVoQUdKhxMibij0fkCjpVkN3r4j4PdvXrfhIT6mg7M6pcUv4aOe+
 7vhsyefT6vhpYNDDpQGiWoaoBlj2bc4lJf+JeIHOA1Vf9tjm1B7MNJaMLcle/AnZOf7w3jjIVlT
 3YBwTqZtqv6gVQII5yMVMC8r3avbqZRojfrHn3/uR4gZlYp3hHpJ9+RjC2ccFC3LO7jc2AgpkTP
 FDDPzIm0SM/lfwJXLGjkLYzu0/Z9BDpQ6DDcFsJJUJuJ+AeIU17HtIMB89Ua7ekkQBZ82rN1kIc
 0AtrKA3OdKzSZOejsMHMKnhNKDNzO4HirJcaeYHZbZODYe0pP5YQ+lbtpm7ywfYyVimqM9Tb0fu
 4v/fgLS8Eh1Yb1qrZcwSqq2zazarJqbQ3V7/KBvMU6rhPSi+BD4MXbTBotc6LjEsY7gQvxAdhiE
 X4=
X-Received: by 2002:a05:622a:5c0c:b0:50b:5130:e35f with SMTP id
 d75a77b69052e-50e36b87628mr50077161cf.8.1776444405724; 
 Fri, 17 Apr 2026 09:46:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-50e41fb6e3fsm126771cf.0.2026.04.17.09.46.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2026 09:46:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ba3de9b3ca7so111502866b.1
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776444404; x=1777049204; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S3hc/Km3ja6nQa2LhB2tu3AXIwEDYuekdRKiKQuS7zw=;
 b=UUvOo++hmNBjpocwD5Z9dcTrrfoIVsyZnxD+WPEjOJVHzwURGQ13n8XO1c24rTRTy/
 BMe6bgOx7EGOGP1ixWn3gLrZfO1T+H8SpGv+WDhcrzikbfdY5mduxKKCyrCYaHsQIwpI
 JLebl8W5LMsWLenB05OG8pN98uSeqnpNo3U+8=
X-Forwarded-Encrypted: i=1;
 AFNElJ+Wz6FT4cqwsZuhgHmJlO3bl0XyikBVr/Ads1lWgn52Eu3XVPUajdE2FTgJR5/40GU39xQ=@dpdk.org
X-Received: by 2002:a17:907:d8f:b0:ba3:5e81:7a88 with SMTP id
 a640c23a62f3a-ba42063bcdfmr191164066b.11.1776444403941; 
 Fri, 17 Apr 2026 09:46:43 -0700 (PDT)
X-Received: by 2002:a17:907:d8f:b0:ba3:5e81:7a88 with SMTP id
 a640c23a62f3a-ba42063bcdfmr191162166b.11.1776444403440; Fri, 17 Apr 2026
 09:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260417052334.2217652-1-lyulin.2003@mail.ru>
In-Reply-To: <20260417052334.2217652-1-lyulin.2003@mail.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Fri, 17 Apr 2026 12:46:27 -0400
X-Gm-Features: AQROBzAOoVvygAcUCSQFosPo4h17Ck_z8ceGKuiANO2LBNal3yulux0MZCGGr54
Message-ID: <CA+BST0=McqcXBkCKaibAG=d8u=EsM2XTRxbqA5azE-yd2jcY8g@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: add cast to wider type before multiplication
To: Denis Lyulin <lyulin.2003@mail.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b0e81a064faab1cc"
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

--000000000000b0e81a064faab1cc
Content-Type: multipart/alternative; boundary="000000000000a18c74064faab188"

--000000000000a18c74064faab188
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:23=E2=80=AFAM Denis Lyulin <lyulin.2003@mail.ru> =
wrote:

> Some static analyzers generate warnings about possible integer
> overflow on multiplication. The first parameter of
> `rte_eal_alarm_set()` is `uint64_t`, so this commit adds cast
> of `uint32_t` values before the multiplication to prevent overflow.
> The fix is cosmetic.
>
> Fixes: 9d0cbaecc91a ("net/bnxt: support periodic FW health monitoring")
> Cc: kalesh-anakkur.purayil@broadcom.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_ethdev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index b677f9491d..bdfab3eef2 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -4861,7 +4861,7 @@ static void bnxt_dev_recover(void *arg)
>  void bnxt_dev_reset_and_resume(void *arg)
>  {
>         struct bnxt *bp =3D arg;
> -       uint32_t us =3D US_PER_MS * bp->fw_reset_min_msecs;
> +       uint64_t us =3D US_PER_MS * (uint64_t)bp->fw_reset_min_msecs;
>         uint16_t val =3D 0;
>         int rc;
>
> @@ -5008,7 +5008,7 @@ static void bnxt_check_fw_health(void *arg)
>
>         info->last_reset_counter =3D val;
>
> -       rte_eal_alarm_set(US_PER_MS * info->driver_polling_freq,
> +       rte_eal_alarm_set(US_PER_MS * (uint64_t)info->driver_polling_freq=
,
>                           bnxt_check_fw_health, (void *)bp);
>
>         return;
> @@ -5030,7 +5030,7 @@ static void bnxt_check_fw_health(void *arg)
>         else
>                 wait_msec =3D info->normal_func_wait_period;
>
> -       rte_eal_alarm_set(US_PER_MS * wait_msec,
> +       rte_eal_alarm_set(US_PER_MS * (uint64_t)wait_msec,
>                           bnxt_fw_reset_cb, (void *)bp);
>  }
>
> @@ -5048,7 +5048,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)
>
>         polling_freq =3D bp->recovery_info->driver_polling_freq;
>
> -       rte_eal_alarm_set(US_PER_MS * polling_freq,
> +       rte_eal_alarm_set(US_PER_MS * (uint64_t)polling_freq,
>                           bnxt_check_fw_health, (void *)bp);
>         bp->flags |=3D BNXT_FLAG_FW_HEALTH_CHECK_SCHEDULED;
>
> --
> 2.34.1
>
>

--000000000000a18c74064faab188
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 17,=
 2026 at 1:23=E2=80=AFAM Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mai=
l.ru">lyulin.2003@mail.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Some static analyzers generate warnings about poss=
ible integer<br>
overflow on multiplication. The first parameter of<br>
`rte_eal_alarm_set()` is `uint64_t`, so this commit adds cast<br>
of `uint32_t` values before the multiplication to prevent overflow.<br>
The fix is cosmetic.<br>
<br>
Fixes: 9d0cbaecc91a (&quot;net/bnxt: support periodic FW health monitoring&=
quot;)<br>
Cc: <a href=3D"mailto:kalesh-anakkur.purayil@broadcom.com" target=3D"_blank=
">kalesh-anakkur.purayil@broadcom.com</a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.ru" targ=
et=3D"_blank">lyulin.2003@mail.ru</a>&gt;<br></blockquote><div><span style=
=3D"font-family:Calibri;font-size:11pt">Acked-by:=C2=A0=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index b677f9491d..bdfab3eef2 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -4861,7 +4861,7 @@ static void bnxt_dev_recover(void *arg)<br>
=C2=A0void bnxt_dev_reset_and_resume(void *arg)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bnxt *bp =3D arg;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t us =3D US_PER_MS * bp-&gt;fw_reset_min=
_msecs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t us =3D US_PER_MS * (uint64_t)bp-&gt;fw=
_reset_min_msecs;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t val =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
<br>
@@ -5008,7 +5008,7 @@ static void bnxt_check_fw_health(void *arg)<br>
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
@@ -5030,7 +5030,7 @@ static void bnxt_check_fw_health(void *arg)<br>
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
@@ -5048,7 +5048,7 @@ void bnxt_schedule_fw_health_check(struct bnxt *bp)<b=
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
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000a18c74064faab188--

--000000000000b0e81a064faab1cc
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
oIHHMC8GCSqGSIb3DQEJBDEiBCD0xkzvkyzrcbnOawHHlAWBv0EslCyow/y2i3uiWFB1IjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTcxNjQ2NDRaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA5dgIBDJvm
xgqC4viRc8cZZJIV4Ldy9fjw8hkasIkfmunHzGMrWnxRZpmFF+7uvsedTZ2smBP4Ex5bqi7B4yXI
ddUPLByazP8bM0+p7VqiWr26I1DgZDALRPPMnTUYkRSEk18tcBkK71zqH4xWv1hUm2EYC6PLzht4
7x1WJbHgEGpwV1c5VCCLrnGO1ip6qzctNWr9I8PD8PEzv2naDK/Puhf4ugeVTQSNJykZnabTgkaP
O078bBCso1qCwpcm0vUqdoPx9bO2BtWlI/YxX/18ykQBUO/FtS5p0atJUPzeK4vs1WaxA33hACI0
beTR405TZYJ76XBNq4KKYx1cKdeQ
--000000000000b0e81a064faab1cc--
