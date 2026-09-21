Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85EFC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:25:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0122942DF0;
	Mon, 21 Sep 2026 21:25:25 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id D26FE4067D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 21:25:22 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2dd68a16955so2838765ad.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790018722; x=1790623522;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n+eB+s/dBze1eEDcZWTKvp2RlC7+cESeJHEdSMzoHAo=;
 b=UDFbfbhoRyEwuVFLtbH7ICuVdIC48Q6nyjzF6YNbF5KtM3HMRlRlgEs2e/SZA3JpNm
 jZMsxxWJCMLVTUmBJgwQ4lNFcrG3oA1t8c+0p71bDpwjsGF7RuMi8Yc5PIBRb//8KUZ3
 a9HJktcpQw8iZj90/FteL6EkiYnvOJ6+WbCghx8uvmOhfvEBTewjUpjFJwDvYpQnztfh
 PcLDEmnpMZrRJmcLFSg2kUctXvKcYv1uIyzzuNtZyzcOmeL43WTN33HS2teAw8gtpylp
 hL+1U/gdhQD30mjUfAPvjUxvAp9oiB8is50sVQgHL6Qzo4msZJEiDt+NzT7YZh6lcCNL
 U+fA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFl7hgMXUj9RwfxAgMstpsVsmkDVZKLp/bqD/vXfQKOArTQmBFaBJ5YW83pigSV0UEkxA=@dpdk.org
X-Gm-Message-State: AFuF++lPuS9HY72GPn5+iNKm8YmQM5P3F3zmjo90Zzmpx4rtrr35GqW8
 6kymIOOPx6GFZth3LzHI0Oy/sRa1MovhcqB3aN+pI1s1glJ4qNsFoqxYDKxn0XKWS1Way8L+lW+
 LY/Wha9PZUss+ghEd+witU6seSPNilmZ2HDFykmwyQeWYuWH145RbW0LQXzWaeYgUCndQ3HC0HP
 wOuU+ZhgBa935cs+vqC4A+j7zMFHh8pGLqtNVdbngtBgY0K2xnle4LS0q3ole64ZEg9AXj1gFhc
 2YHzA==
X-Gm-Gg: AYBFou1DHsbDGtekxYFsdJkAOZnci7er3R0x/GLjoYg70VM7dRgx1gzB6snuIS7DqQW
 uYHVunSqozfO9k5VjI8NjBZhBRQ7KIu+CYI58C10dtlxQHeusxQYKAkjgBwqbBVxYeAIy7ZLe8I
 GCxaDRCDYm/O2QqNU7bLGY46agYvMHdNQEbhwGz1cT+we5mT4tR+WNSqbAiqT24P5O1K7wi7wL6
 5YEjbLEkwaDOd/GjjOsLndxQ0onnZrBSDlYTp1TjxHB7x9myLS5rmji0FBp72JMjN6Yc28UwzLk
 wc4kYTjTAnRAIwlK7XSPPsJDZR3EGPoT/6oEvioV5ZBtenqKuM8pGFpPKHRimIKAwSBoGulnlkv
 wGB+7iQIzNlQc18DoZ+TSYdoZ7uQ/IEpMx6c3PJxAcLhLxAxelc9MVv1fbmF1pXB9ltXRUexCEO
 ysJ9XVBRyEkPDZmwiJNF4dJUFZAnkHOSx1NSoJDWKSwoA=
X-Received: by 2002:a17:90b:52:b0:39e:4c7e:bc4 with SMTP id
 98e67ed59e1d1-3a066a75edamr444651a91.18.1790018721424; 
 Mon, 21 Sep 2026 12:25:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a069a398ecsm89783a91.5.2026.09.21.12.25.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 12:25:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a64cb77b0aso3951672a12.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790018719; x=1790623519; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n+eB+s/dBze1eEDcZWTKvp2RlC7+cESeJHEdSMzoHAo=;
 b=BHntTxSb3zQmWSMlhgHgOO+4WWrXhcmRMXJkn6sCEGhjcRH4iXPyF0yokeiw9IIL2J
 i2wiaoH/nHTMkW+8coUgs+8AbaqQiBudpxg0c/LVi6qUuGPRVcSnVSylE27hGmaJm1KW
 NNM0PV+1FxcK+l7u+BPSpWORtZ3+TdgxE6AP4=
X-Forwarded-Encrypted: i=1;
 AKwUvBwp7MhHrj9cKERstyWOwe9dEdHb2n5ybpIQEdrTyhLt5DM+AvT0GMlhmvJfK3onpHNeCio=@dpdk.org
X-Received: by 2002:a05:6402:3216:b0:6a9:850d:bb38 with SMTP id
 4fb4d7f45d1cf-6aa53124ec3mr9067862a12.10.1790018719248; 
 Mon, 21 Sep 2026 12:25:19 -0700 (PDT)
X-Received: by 2002:a05:6402:3216:b0:6a9:850d:bb38 with SMTP id
 4fb4d7f45d1cf-6aa53124ec3mr9067830a12.10.1790018718397; Mon, 21 Sep 2026
 12:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260915090524.431183-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915090524.431183-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 15:25:01 -0400
X-Gm-Features: AcwNN1VmHefLTr-FwLc3XuTRz-YesZwluZUr9I_Y830VJLScixeMZoRVnMxM7xk
Message-ID: <CA+BST0nU-MwUJa0QOJPC8UvXQy--V-v5S3iyL5uJCZjWcaNdrg@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove redundant Rx queue array check
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000ebc63b065c03359a"
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

--000000000000ebc63b065c03359a
Content-Type: multipart/alternative; boundary="000000000000da4ace065c03359f"

--000000000000da4ace065c03359f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:05=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> The rx_queues array is allocated during device configuration
> before nb_rx_queues is set. Since bnxt_rx_queue_setup_op() is
> called from rte_eth_rx_queue_setup(), which validates the queue
> index against nb_rx_queues, the rx_queues NULL check is redundant.
>
> Remove the unnecessary condition.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> Cc: stable@dpdk.org
> ---
>  drivers/net/bnxt/bnxt_rxq.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
> index 023cb0e174..a89d5ab611 100644
> --- a/drivers/net/bnxt/bnxt_rxq.c
> +++ b/drivers/net/bnxt/bnxt_rxq.c
> @@ -370,11 +370,9 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev
> *eth_dev,
>                 return -EINVAL;
>         }
>
> -       if (eth_dev->data->rx_queues) {
> -               rxq =3D eth_dev->data->rx_queues[queue_idx];
> -               if (rxq)
> -                       bnxt_rx_queue_release_op(eth_dev, queue_idx);
> -       }
> +       rxq =3D eth_dev->data->rx_queues[queue_idx];
> +       if (rxq)
> +               bnxt_rx_queue_release_op(eth_dev, queue_idx);
>         rxq =3D rte_zmalloc_socket("bnxt_rx_queue", sizeof(struct
> bnxt_rx_queue),
>                                  RTE_CACHE_LINE_SIZE, socket_id);
>         if (!rxq) {
> --

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.30.2
>
>

--000000000000da4ace065c03359f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 5:05=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny &lt;<a href=
=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.Sokolov@inf=
otecs.ru</a>&gt;<br>
<br>
The rx_queues array is allocated during device configuration<br>
before nb_rx_queues is set. Since bnxt_rx_queue_setup_op() is<br>
called from rte_eth_rx_queue_setup(), which validates the queue<br>
index against nb_rx_queues, the rx_queues NULL check is redundant.<br>
<br>
Remove the unnecessary condition.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
---<br>
=C2=A0drivers/net/bnxt/bnxt_rxq.c | 8 +++-----<br>
=C2=A01 file changed, 3 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c<br>
index 023cb0e174..a89d5ab611 100644<br>
--- a/drivers/net/bnxt/bnxt_rxq.c<br>
+++ b/drivers/net/bnxt/bnxt_rxq.c<br>
@@ -370,11 +370,9 @@ int bnxt_rx_queue_setup_op(struct rte_eth_dev *eth_dev=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (eth_dev-&gt;data-&gt;rx_queues) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rxq =3D eth_dev-&gt=
;data-&gt;rx_queues[queue_idx];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rxq)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bnxt_rx_queue_release_op(eth_dev, queue_idx);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rxq =3D eth_dev-&gt;data-&gt;rx_queues[queue_id=
x];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rxq)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bnxt_rx_queue_relea=
se_op(eth_dev, queue_idx);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rxq =3D rte_zmalloc_socket(&quot;bnxt_rx_queue&=
quot;, sizeof(struct bnxt_rx_queue),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_CACHE_LINE_SIZE, socket_id=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!rxq) {<br>
--</blockquote><div><span style=3D"font-family:Calibri;font-size:11pt;backg=
round-color:transparent">Acked-by: Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"> <br>
2.30.2<br>
<br>
</blockquote></div></div>

--000000000000da4ace065c03359f--

--000000000000ebc63b065c03359a
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
oIHHMC8GCSqGSIb3DQEJBDEiBCA4nTr8bWchPgwCc4NT0jFwSxjIu/+DUs5Zmo9Kz6xUMDAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExOTI1MTlaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCzi11oP2Rz
OyqOud3AuYQ74+onFXxVYMInJgEAlCptUQ1UiMYxxJAkZJiOhqV860xq3/B9zhYM0ntAoql8slLZ
QIguo7BQtX7rn1e0vSUwK3vf036MHAjzazNxUHBKoie7U28TPzcqmBkDM5yrGkdvyM5vcNzUKBo+
wusqMc0Y8/EqUhcmijkwunKykmrqTHWGQ2o59D/aHpFY+vWkL8UEtjGZkqwshCmiAYdm5wIX+fYl
IqBRp5bFUabaeCQHb0OdpbyLJ3QsOC3vZYtU/qX9aalN1JeD4RNLJnL/6VHdXLCtXVrl6K+t6t/P
BHpvtkb1e+nj0cHp1NW9zY5hVHgV
--000000000000ebc63b065c03359a--
