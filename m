Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C554CD8C90
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:17:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCF1F42797;
	Wed, 10 Jun 2026 20:17:24 +0200 (CEST)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id 816FF42792
 for <dev@dpdk.org>; Wed, 10 Jun 2026 20:17:23 +0200 (CEST)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-7de68222e96so66062767b3.2
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781115443; x=1781720243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYRQ0BhbttscIU5Qlq0AQwHO54M+BvtKdCfDbtS8QQU=;
 b=CbdT6Y7JdN5fE56QQ4H8b1T8bXIFoTPPG0DRzkyDNrpo4SwQBcwH3XUsJwuhDqxIy+
 gT2pcX1/Htr6XWqlp9q5yzI0TEYVPmzt+8HbIbYaC/ksbdnuH1j6wsl3k/po1GsPqtl3
 2b9fTMMBqshbRk5IpIlzL/m9ucHPIjKrHT4ASqBT1TuRo3q3Iqhie2s9nec0Z0Hk2QKL
 Id42QKXQ6LNXpVKOM0JH+xsvWEs8XWVc8hJQML9amw3RjgssuaPUhaPLN91qVdHZUQ08
 gOeC3dywx+KHIpE5cCS5hpJCcx9tHJIAeVRAT8HS54LbBiNufhGq5VlgJ3u2yVEQy25z
 oE2w==
X-Gm-Message-State: AOJu0YzJH2MB8B02qbQysjxGd3ejqnxiYPuNBw0Kf0U3qD74zAnY4c5+
 7VR6Izwy4WrBk2blnVtbZuLU5kfQ6orROnml8gpnjWEEfQNivVU2NQkkL8LIqAaQ3X6v+Wtc5dF
 UcdJuNN3FbKdxJ+S9QbMX6znksOK2bTAIYJYx/g58DSirC5Ts1yEL371PCftSgKaYyMt69HYXMO
 K84s4dhloTc0FdvrRcqmbkUgDOCb1OoJlOQVmVCqKVvUkriWE8nGB62qlDUEa3IXqwBsZrAU/6l
 dbhrQ==
X-Gm-Gg: Acq92OFPPOeUSq0upn1eUjaUSzbDeoNcrKm6Zpstez+s8Ez7Hvvgi22v2llgrCFBID1
 uZKIeeahXOl7q7cUjC9FgZeMjL2kyT0B3Urr4j2keaKEOuTvhCULe5GFHlSDZ8fTfwgipF0OLXs
 aGY/tu2p2zeTh4VMOikA68BexwDr/dXXBc1clyiyLtwqagDnv9pwKqmdjRyAHcO2rEutGKsOtuz
 Xq1EwDnmZU2vc35pp8cXYf4jONDXCy6X14FRw+xIQH3fC0DWh+TiW7kYu6+btVmT+Cu7ScOB9tp
 pTevQj/vn3LTx1Yzbux9Pmt0P2bbCXyGdZCfMwf0SnggvBCIJW03cEnOMw/25+aYJpMiIG0qV32
 wlwaS7ZbHk7EO4YgZ9E0buNOPTxbFkbOZadvaIbIYbIEWXBsTh1m+C7UK9vebJktvzUVWD9m9Xj
 ShoXaYA3EcYEgBhpzUxwPihuTfrJ0tIkd6wBp/WXe3Qud9XJ16thfe8gHPQEIT9ilvnsC4srKKi
 rvMYw==
X-Received: by 2002:a05:690c:45c3:b0:7dc:fc4c:58bd with SMTP id
 00721157ae682-7f61a17c22cmr3298987b3.35.1781115442493; 
 Wed, 10 Jun 2026 11:17:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7ea23a99589sm17083507b3.24.2026.06.10.11.17.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:17:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef616db45so6058991f8f.2
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1781115441; x=1781720241; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GYRQ0BhbttscIU5Qlq0AQwHO54M+BvtKdCfDbtS8QQU=;
 b=E7A93Dy9X3h2wjCAcuTPb1s14VuAcd4ZCNkO1s7Q1c9mOVnWTtQzGFMvSL/5k/MVQR
 rujayBonWVhsOldjV7ulHYiNzuHQRErnqAE4CB3fVJaPA/xpLtiCyMJ2VlWAhMUe1bCr
 fDHgZpUqj6pTKFbVRQwPXuLtmMwTQmNEAClgw=
X-Received: by 2002:a5d:42d1:0:b0:43c:fa96:d939 with SMTP id
 ffacd0b85a97d-46030609782mr29555011f8f.22.1781115441017; 
 Wed, 10 Jun 2026 11:17:21 -0700 (PDT)
X-Received: by 2002:a5d:42d1:0:b0:43c:fa96:d939 with SMTP id
 ffacd0b85a97d-46030609782mr29554988f8f.22.1781115440511; Wed, 10 Jun 2026
 11:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Wed, 10 Jun 2026 14:17:04 -0400
X-Gm-Features: AVVi8Ccx2hsMs2Tuo9mzT-MRFd9Jn4_IR0qPJsdrnCnkUmK6eAv8bO1vstFMlSw
Message-ID: <CA+BST0=Yp__SEo5ZENEg3Vb5BYDw+oaAQspArJuCObSsQg_YMA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net/bnxt: miscellaneous bug fixes
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000002ecf4a0653ea410a"
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

--0000000000002ecf4a0653ea410a
Content-Type: multipart/alternative; boundary="00000000000022df830653ea417b"

--00000000000022df830653ea417b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 6:54=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
>
> This series collects four independent bug fixes for the bnxt PMD:
>
>  - Eliminate unnecessary long TX BDs when only checksum offload is needed
>  - Pass QP1 resource count correctly when configuring backing store
>  - Fix implicit integer sign-extension in the doorbell calculation
>  - Prevent VFs from attempting global RSS configuration
>
> All patches carry Fixes: tags and Cc: stable@dpdk.org.
>
> Changes in v2:
>  - Patch 4/4: add missing Fixes: tag for RSS hash mode fix
>
> Ajit Khaparde (2):
>   net/bnxt: modify check for short Tx BDs
>   net/bnxt: fix QP resource count in backing store config
>
> Mohammad Shuab Siddique (1):
>   net/bnxt: fix RSS hash mode configuration for VFs
>
> Zoe Cheimets (1):
>   net/bnxt: remove implicit integer sign-extension
>
>  drivers/net/bnxt/bnxt_ethdev.c |  4 ++--
>  drivers/net/bnxt/bnxt_hwrm.c   | 18 ++++++++++++++++--
>  drivers/net/bnxt/bnxt_ring.c   |  7 ++++---
>  drivers/net/bnxt/bnxt_txr.c    |  3 +--
>  4 files changed, 23 insertions(+), 9 deletions(-)
>
> patches merged into dpdk-next-net-brcm
Thanks

> --
> 2.47.3
>
>

--00000000000022df830653ea417b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 4, =
2026 at 6:54=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moham=
mad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@broad=
com.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt;<br>
<br>
This series collects four independent bug fixes for the bnxt PMD:<br>
<br>
=C2=A0- Eliminate unnecessary long TX BDs when only checksum offload is nee=
ded<br>
=C2=A0- Pass QP1 resource count correctly when configuring backing store<br=
>
=C2=A0- Fix implicit integer sign-extension in the doorbell calculation<br>
=C2=A0- Prevent VFs from attempting global RSS configuration<br>
<br>
All patches carry Fixes: tags and Cc: <a href=3D"mailto:stable@dpdk.org" ta=
rget=3D"_blank">stable@dpdk.org</a>.<br>
<br>
Changes in v2:<br>
=C2=A0- Patch 4/4: add missing Fixes: tag for RSS hash mode fix<br>
<br>
Ajit Khaparde (2):<br>
=C2=A0 net/bnxt: modify check for short Tx BDs<br>
=C2=A0 net/bnxt: fix QP resource count in backing store config<br>
<br>
Mohammad Shuab Siddique (1):<br>
=C2=A0 net/bnxt: fix RSS hash mode configuration for VFs<br>
<br>
Zoe Cheimets (1):<br>
=C2=A0 net/bnxt: remove implicit integer sign-extension<br>
<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c |=C2=A0 4 ++--<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0| 18 ++++++++++++++++--<br>
=C2=A0drivers/net/bnxt/bnxt_ring.c=C2=A0 =C2=A0|=C2=A0 7 ++++---<br>
=C2=A0drivers/net/bnxt/bnxt_txr.c=C2=A0 =C2=A0 |=C2=A0 3 +--<br>
=C2=A04 files changed, 23 insertions(+), 9 deletions(-)<br>
<br></blockquote><div>patches merged into dpdk-next-net-brcm</div><div>Than=
ks</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--00000000000022df830653ea417b--

--0000000000002ecf4a0653ea410a
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDuiJXDpqxkrioAELUqgz7Ho58/3Sj0pyAdZCwr40Mb9DAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MTAxODE3MjFaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAliGl5tDzO
+Zk9BUGXRsWAhQU90NVZ5HeSO4IJPzgaUdxXR7vKXQkFKDJi4iAnlIkjqj5J84uo/y19CmK00M7z
vvk5pIoZMPpG5XXrXxeT2Cnkk0xS7P767dQ39U5TJA/iB4cJ4VPpPC30njJ4vDx+yM8eY+4ys0Tr
xRgqG8k2x1NAealc+y2hxG8qTh2AO8s3b8syYVPvlk/N/Vs4FJbmAfeCvMuUQlRLWghMns89Ycah
jVtU4/lTvDZxUbEBJOfTULND8Wi8moPfPJWQCd+74l54SVD/I3iY96Rz15lo7A7VKrZmxziMoeby
KeQZlGIoUBYU7flKUOTmT5XXXD+X
--0000000000002ecf4a0653ea410a--
