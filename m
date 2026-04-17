Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9206F436BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:34:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82004402B0;
	Fri, 17 Apr 2026 18:34:16 +0200 (CEST)
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com
 [209.85.161.98]) by mails.dpdk.org (Postfix) with ESMTP id 526D9402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:34:15 +0200 (CEST)
Received: by mail-oo1-f98.google.com with SMTP id
 006d021491bc7-688a8e5fc2eso525199eaf.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776443654; x=1777048454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pbi2ya+tFYywKtbZN5UiX9JN4IFlcGHhPaKM18sxrJo=;
 b=UV4zIl0a4xr70AmNQQiUaPYf1fhjQK/uqvWleP+D5/PmC6mJXVH3i9XWnIO+0Am5tz
 elE1kTJ3YMMJbJlp/d4vA35l58t7kFRlBr9ifmIx1uxPoXfkrilLGOq49oJKNcN2PX3P
 I0m7sfi9MlPWmFuFrwzxYd969nW9w7llyWuOnNVU55VvHVTiN+G66t6s4R5E2fUzyEzi
 h1FgG6xl6HjXiLkkAyIdBb6/c8M/WQ9WDs0bS0wLCbL7EqdhuFHy0AvBk7Wz+syq3lCc
 ADOqlFp1/W5086fp0ZFtIUze87TSl8nZrGLjnziX9qh0yA5HOSnfLrIxCr1YArkpkdB6
 nmWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9M1uJanN0EhWULqVshOI6FZbax/eU9/e7HNJ28LTylInFbYNdy3X7mkeN/k+Xj2TbPRYk=@dpdk.org
X-Gm-Message-State: AOJu0YzOH2mUrvh+FFxVEyr5OtXxllTszC11obLixx5Ho2JVl2xf6446
 mp3d68jFpsbNI5zj13rkmTumdGX0b3BnDpl6qtkPrX0HH8lhBbwO/dlkGOk/QxpFw3qMA45rhjT
 CJjO0dxX3Aali3A8XZxBMA30ODW2A5X2SOTs06fJ20rNfagAgS934FaNwG9udTWI3yAI5l554DN
 S+yJLZwu5TuPJWzNVOnoQqm6t0EIKAjukiIOKm5eHvfObwRcNRY7vZlsKwmbX+ClVcxNIrf7xEy
 8GnvQ==
X-Gm-Gg: AeBDiev+H71FDtCS5nK8+qGUtNx1cRVdjDT0f+d0WqonojHxnbmamNrInQ39RooukfR
 S55mG7EphPbZc7WXiJRQpiF7/BS3XYa0pGAvIYxQFIuzI2IGnLo37k0aNq8zSjZwzCoLIgcG5GK
 GDSo7OhZ89ZiayiS6LDtaugO3y+JaaJBeZMGnvSpYmCw4y7Ny1RGtDkh65zOzgYV9Ss29nGhnX6
 3upBOWhPspneQP0blI3iUx5ZaldeOWz4PhLRWZuoNqMBuQVng51nzC7RvN+3dao3jvRYDepb15r
 8S3pv8GupomI06Ke6TFNEg5/dEt9u5O+oF5aOCCpEKgzaEEIMdshE0qD/dJAfyPoF95RVZeB9Zg
 +oyYwku2JhTvRBJWirM5BaT9I1c+V7+suMtb2ylaz6ZwPAGfp6T+M6HRpE7Ip5Lgj0pnkIBmded
 +6wgYWoSnxWrkJ0AFIrBtvyoCIZc+hgbrCbPstf0v02Yp+tKvxZjwo67Fj2s4J43lpmrBMgssKz
 RQ=
X-Received: by 2002:a05:6820:1622:b0:686:c7a9:d64c with SMTP id
 006d021491bc7-69462ede00cmr2013814eaf.43.1776443654200; 
 Fri, 17 Apr 2026 09:34:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-69464fcae1esm118048eaf.28.2026.04.17.09.34.13
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2026 09:34:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-67206e61ffcso1849045a12.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776443652; x=1777048452; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pbi2ya+tFYywKtbZN5UiX9JN4IFlcGHhPaKM18sxrJo=;
 b=eiVQh4VXmkHueCAr0ctN22fIvZBsX4VA7gSqy6zAdXAt7hMJymongjUAPt3Fy/6JGK
 dEwCThWhKv6WOKgeOrDPju70qjgaHcUWTZXbeWNKjm6+MEy2TP2orcTRY80juKGEJdVF
 HP5f/jKij3kyjioW9xtMwQdbdBlNtMJO3r6RA=
X-Forwarded-Encrypted: i=1;
 AFNElJ8VASnSG85IiQx/j17BylMIgw+D+SoQX+9QvCQ5eWGksMnaW3GPTMlsMytmuWSoPWN8J+w=@dpdk.org
X-Received: by 2002:a17:907:94c9:b0:b9b:171e:bae9 with SMTP id
 a640c23a62f3a-ba4236b069fmr202476566b.24.1776443652408; 
 Fri, 17 Apr 2026 09:34:12 -0700 (PDT)
X-Received: by 2002:a17:907:94c9:b0:b9b:171e:bae9 with SMTP id
 a640c23a62f3a-ba4236b069fmr202474266b.24.1776443651693; Fri, 17 Apr 2026
 09:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260416090252.2211405-1-lyulin.2003@mail.ru>
In-Reply-To: <20260416090252.2211405-1-lyulin.2003@mail.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Fri, 17 Apr 2026 12:33:54 -0400
X-Gm-Features: AQROBzCCLnecfUTUbESfFt4sePFzxWvCroHBS3I4zoX-0Gub0fmC0MwaGPYjmRc
Message-ID: <CA+BST0m7zXt0YD2kgg5nXzHsAk_3n8aYsgncifRxm5dvJt1SyQ@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: fix memset size mismatch in Tx queue start
To: Denis Lyulin <lyulin.2003@mail.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Manish Kurup <manish.kurup@broadcom.com>, 
 Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Randy Schacher <stuart.schacher@broadcom.com>, dev@dpdk.org, 
 stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000e51572064faa840f"
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

--000000000000e51572064faa840f
Content-Type: multipart/alternative; boundary="000000000000d2c41d064faa844e"

--000000000000d2c41d064faa844e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 5:03=E2=80=AFAM Denis Lyulin <lyulin.2003@mail.ru> =
wrote:

> When the tx_queue is started, previous stats are reset.
> For tpa_v2 and P7, extended stats structure is used:
> `struct bnxt_ring_stats_ext`, so passing wrong size to memset
> makes not all stats to be reset. This commit sets correct size of
> the structure passed to memset when zeroing-out previous stats.
>
> Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
> Cc: shuanglin.wang@broadcom.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_txr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
> index 27758898b0..b6ad37f872 100644
> --- a/drivers/net/bnxt/bnxt_txr.c
> +++ b/drivers/net/bnxt/bnxt_txr.c
> @@ -729,7 +729,7 @@ int bnxt_tx_queue_start(struct rte_eth_dev *dev,
> uint16_t tx_queue_id)
>          */
>         if (BNXT_TPA_V2_P7(bp))
>                 memset(&bp->prev_tx_ring_stats_ext[tx_queue_id], 0,
> -                      sizeof(struct bnxt_ring_stats));
> +                      sizeof(struct bnxt_ring_stats_ext));
>         else
>                 memset(&bp->prev_tx_ring_stats[tx_queue_id], 0,
>                        sizeof(struct bnxt_ring_stats));
> --
> 2.34.1
>
>

--000000000000d2c41d064faa844e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 16,=
 2026 at 5:03=E2=80=AFAM Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mai=
l.ru">lyulin.2003@mail.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">When the tx_queue is started, previous stats are r=
eset.<br>
For tpa_v2 and P7, extended stats structure is used:<br>
`struct bnxt_ring_stats_ext`, so passing wrong size to memset<br>
makes not all stats to be reset. This commit sets correct size of<br>
the structure passed to memset when zeroing-out previous stats.<br>
<br>
Fixes: dd0191d5e70d (&quot;net/bnxt/tf_ulp: support Thor2 ULP layer&quot;)<=
br>
Cc: <a href=3D"mailto:shuanglin.wang@broadcom.com" target=3D"_blank">shuang=
lin.wang@broadcom.com</a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.ru" targ=
et=3D"_blank">lyulin.2003@mail.ru</a>&gt;<br></blockquote><div><span style=
=3D"color:black;font-family:Calibri,sans-serif;font-size:11pt">Acked-by:</s=
pan><span style=3D"color:black;font-family:Calibri,sans-serif;font-size:11p=
t">=C2=A0 </span><span style=3D"color:black;font-family:Calibri,sans-serif;=
font-size:11pt">Kishore Padmanabha &lt;</span><a href=3D"mailto:kishore.pad=
manabha@broadcom.com" style=3D"font-family:Calibri,sans-serif;font-size:11p=
t;color:rgb(5,99,193)">kishore.padmanabha@broadcom.com</a><span style=3D"co=
lor:black;font-family:Calibri,sans-serif;font-size:11pt">&gt;</span>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/bnxt_txr.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c<br>
index 27758898b0..b6ad37f872 100644<br>
--- a/drivers/net/bnxt/bnxt_txr.c<br>
+++ b/drivers/net/bnxt/bnxt_txr.c<br>
@@ -729,7 +729,7 @@ int bnxt_tx_queue_start(struct rte_eth_dev *dev, uint16=
_t tx_queue_id)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BNXT_TPA_V2_P7(bp))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;bp-&gt;=
prev_tx_ring_stats_ext[tx_queue_id], 0,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(struct bnxt_ring_stats));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sizeof(struct bnxt_ring_stats_ext));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;bp-&gt;=
prev_tx_ring_stats[tx_queue_id], 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sizeof(struct bnxt_ring_stats));<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000d2c41d064faa844e--

--000000000000e51572064faa840f
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
oIHHMC8GCSqGSIb3DQEJBDEiBCACnKUKIFa8TrSDVcl0e/stxk1Usuz7Ck8II2qBcy1k1TAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTcxNjM0MTJaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBGAAY+wu2w
HsbcsLpN0NxKtkWsKZtwXFfVLZaAYyDv6KRdIdbxLXP7+63fj9DLd763+Fjhsy4+fP8VPKOx6m3h
RxHbATPsSZy8qWJaH/EnEGKtX8xqYQW7kYEK4hv95510NqA+ty8SB7joaJks3emv7LpS2+9dP1+l
jiMfu241ALY/b3dd6HyzcwmuE/t84u8qTMG0W3+bJF8475yhXDS9g4MY5DK/79I88K3Fi6eKjLah
dWnOIg2bj5cat6f3kh00hk9WPb1ExTzrlB1ff2+1gvHj2NvSJcMp/A56ZRAIZ9MmVGU4jtNe7ka7
GsAbPjXRWICYym9ff3PokzeGhzXJ
--000000000000e51572064faa840f--
