Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA674C982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:56:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59C9342E6F;
	Mon, 21 Sep 2026 21:56:49 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id 8388B40E2B
 for <dev@dpdk.org>; Mon, 21 Sep 2026 21:56:48 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2d71d1cc8b2so9924535ad.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790020607; x=1790625407;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wUkPeHezxyMYt0bPHy3ssAi+pQJ5wDMmrnbSbnfZAok=;
 b=JNpEzlcLQOjacXjXAEbc5WpqIdJb9TNzNy72wu6Eu5hvQSn288cWoTpbdI6AA5xC5q
 dX5Opv2eJrdajf+KnZWLV83+er4cJuN1E4rxitjocxiFNLX6obWpdfXKSebaEARA+C43
 bhJd1/Ex51qv4xmF0XppMenSaGXoF2U/TtrksWVDn0K9HV+GvLQgv9agCtbdMesneMJp
 T6gLI8O1oUEd68FjvyYCZ3GL5kEgbg9+ziGBPwuwaaEtG2okcDbnqAAI+pWHjFv0+nsd
 T2gFqw9L0BJazUev2v0/tL7hHInj+knYg1N5GB8breMA9Gr35WrJE6v59sRISXQrWXFx
 MGuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrPnX6+u5c4hIhWaeQt8gID3fo3kdCfG1jZUJb/DyT/Fhh0WqbrWwPbFoG77NfW4HnilE=@dpdk.org
X-Gm-Message-State: AFuF++mBUUQRwkM9pKO4YnB8SPSyzxQfXdzawKVg7C3N4f65M61aTwFQ
 arm3Uq8pHEETS6zs79V5vximkeASJyO08HLqyqjBQudqtsrOdBc2/5/bIRnO3UAq09hfLVp9I3w
 UmcGTKrx7ijrKoxoByYv6CqoV0+60z1vYhYxR+8QDoTKoQYPS19vWnURpWR8A2Vgh0tAyvyRGap
 d5U+5fU4cEKhN895NVT/H+gV8w8GsU2FWDfiP11A5fK+WPS+4P5+34DLp/Td8Th4mUckOVGLKme
 U+pDw==
X-Gm-Gg: AYBFou1JYtTo++PYlUSKNF7AD8dfndOiioA5DKjcm+Wm0b8HlBs1Cx4NFgpYftjyQ7e
 7GUDotdX6uuaZMrbb0tctjygfMGbZ2p8EntF7swiMGIXNH/kx/AqrTRNtwqIzwEZUwO06TjYt9q
 QGWWoPVpK2BW5oxXo0Sw/5sZFbeUioxQ5r2hV/xRazSXxYC6WdCdvMh/mLS+JgguExCerb6/VhI
 MtikEa1onoHNc8Npzw9Z0az+sfgZdaKJN/46ZPr3X7qF7q0e5MNSZQx4+8LjRHKNWkPBlkklr6w
 PXAo+aWlZZcA72ivxpdo140SyTtHETBOixw6BJuNVe1vPQdJOAbThrtUxl8YUtAET+bJ7ZvIA8z
 XGnAqNAXzkqPxAiTFHjAa/op1T7oNrl60JR7VAFB4+7eh+JalgQqsd2mVWDiWYu6zHvf+VDmTXl
 yBJ5iWeQ4YRmGWWdjA5Y/+PLs9QM1UnsJs9CsTBWWLLzk=
X-Received: by 2002:a17:90a:da83:b0:39e:6c6a:6570 with SMTP id
 98e67ed59e1d1-39e6c6a6792mr11125205a91.51.1790020607178; 
 Mon, 21 Sep 2026 12:56:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e684f43b9sm773885a91.3.2026.09.21.12.56.46
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 12:56:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a22bf0so3997368a12.0
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790020605; x=1790625405; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wUkPeHezxyMYt0bPHy3ssAi+pQJ5wDMmrnbSbnfZAok=;
 b=c9OikN5ZiywOYx205emGiNt3w60Pm57rf47FadfF7OM297btz6sfbJvhhpDDdR5dOv
 k9YHl0n/tLnTQiy+hF49qywLYO/Ed4XeUhbo80KiERsNfzIAh6mX++WrOGuqt9tPDWYM
 E9Flo5byDz6Sb1Bcq+eRwZ9B72IUHG5z2StOA=
X-Forwarded-Encrypted: i=1;
 AKwUvBwHdb/ZH5Z/zI9UrphoS7rK0XjNnYm7H9msNl87V1SThoImckp043fexwQ/TrPw+29rgJA=@dpdk.org
X-Received: by 2002:a05:6402:46c8:b0:6aa:82f:8093 with SMTP id
 4fb4d7f45d1cf-6aa5699f368mr7837590a12.37.1790020605061; 
 Mon, 21 Sep 2026 12:56:45 -0700 (PDT)
X-Received: by 2002:a05:6402:46c8:b0:6aa:82f:8093 with SMTP id
 4fb4d7f45d1cf-6aa5699f368mr7837580a12.37.1790020604673; Mon, 21 Sep 2026
 12:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260915095504.432070-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915095504.432070-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 15:56:26 -0400
X-Gm-Features: AcwNN1Veoy87W9CDcyydGKWZ9FxvF_G5UmIxt9SMGujTMgn1uEWFwP49hgyCMAc
Message-ID: <CA+BST0=oF8_Gjq+8oYS2z34coC5XxLMyOa6nyG1=rg7Hck_ZHg@mail.gmail.com>
Subject: Re: [PATCH 4/5] Fixing the printing the data that can be referenced
 by the null pointer
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org, 
 damodharam.ammepalli@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000051fb00065c03a637"
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

--00000000000051fb00065c03a637
Content-Type: multipart/alternative; boundary="000000000000486f61065c03a681"

--000000000000486f61065c03a681
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Missing Signed-off-by, No commit message, The patch treats a symptom that
does not exist in sane path and doesn't in the representor path. So
rejecting the change.

On Tue, Sep 15, 2026 at 5:55=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> ---
>  drivers/net/bnxt/bnxt_ethdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index 920b298486..6da4247a7a 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -1408,7 +1408,7 @@ void bnxt_print_link_info(struct rte_eth_dev
> *eth_dev)
>                         (uint32_t)link->link_speed,
>                         (link->link_duplex =3D=3D RTE_ETH_LINK_FULL_DUPLE=
X) ?
>                         ("full-duplex") : ("half-duplex"),
> -                       (uint16_t)bp->link_info->active_lanes);
> +
>  (bp->link_info)?(uint16_t)bp->link_info->active_lanes:-1);
>         else
>                 PMD_DRV_LOG_LINE(INFO, "Port %d Link Down",
> eth_dev->data->port_id);
>  }
> --
> 2.39.5
>
>

--000000000000486f61065c03a681
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Missing Signed-off-by, No commit message, The patch t=
reats a symptom=C2=A0that does not exist in sane path and doesn&#39;t in th=
e representor path. So rejecting the change.</div><br><div class=3D"gmail_q=
uote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, S=
ep 15, 2026 at 5:55=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.=
Sokolov@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny &lt;<a =
href=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.Sokolov=
@infotecs.ru</a>&gt;<br>
<br>
---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index 920b298486..6da4247a7a 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -1408,7 +1408,7 @@ void bnxt_print_link_info(struct rte_eth_dev *eth_dev=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (uint32_t)link-&gt;link_speed,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (link-&gt;link_duplex =3D=3D RTE_ETH_LINK_FULL_DUPLEX) ?<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (&quot;full-duplex&quot;) : (&quot;half-duplex&quot;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(uint16_t)bp-&gt;link_info-&gt;active_lanes);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(bp-&gt;link_info)?(uint16_t)bp-&gt;link_info-&gt;active_lanes:-1=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PMD_DRV_LOG_LINE(IN=
FO, &quot;Port %d Link Down&quot;, eth_dev-&gt;data-&gt;port_id);<br>
=C2=A0}<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div></div>

--000000000000486f61065c03a681--

--00000000000051fb00065c03a637
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
oIHHMC8GCSqGSIb3DQEJBDEiBCD2wEdG8WEloQ4b750WTOlIOLnMbMWyfK4h8kxlfi0ZUzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExOTU2NDVaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAVVGNKkmGI
dLJgjA5ZaL21CIgUVmd7n2fX0h+aJJEExVIIyJt2MHZSNN8vQ1wjTp0ISxpy0pdKrvdS/TwkfH29
ucb3jSCp4sugnSTkn8mXy+dEUKVDWp7Qcnaz7n7dVKjs3WIPsaHiLBmYpHKNTAmYc/iKy9ZNrV+L
AA22CV/XdZaD0/C39HzumpQeTdvlAUBXzmrfUF1gWPXpgjM+X3sblyfCy+9Psdj3TVuqV4z3Q2hk
HwW6Pb+aGUXWXLpMHRHTNeD0/Cng5UjVnOkBk9jGKH/djga6M5JLfu+TjMp2DmGH8VF4vsLH2h9N
Lcqu9TizvR5Q37myaxmbDF1SnBSD
--00000000000051fb00065c03a637--
