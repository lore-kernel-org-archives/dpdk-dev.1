Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA07CD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 18:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 079F042792;
	Wed, 10 Jun 2026 20:18:06 +0200 (CEST)
Received: from mail-oi1-f225.google.com (mail-oi1-f225.google.com
 [209.85.167.225])
 by mails.dpdk.org (Postfix) with ESMTP id E7DF6402B0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 20:18:03 +0200 (CEST)
Received: by mail-oi1-f225.google.com with SMTP id
 5614622812f47-48662d16d08so2825376b6e.2
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781115483; x=1781720283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3x56Pu4kgoR3OxBSYDeTv+9perciJmD5rzzKsTko6I=;
 b=SWy5TlNapqOm6+bCUFbQ/5q4tOE1y71pnq2/F++yFizrjYIicoUql3QglmxyQuqlyV
 pHM82uij/Y8stkTkqwACf65Oe16d5jVSQe5xPuSXhXPyL0jBn3wljujbqN6ONAM3J8lg
 hUDv3Vwil57OhPdG9VJBK60vNn7ly7LDpfKxidwcdidrAKZGxpk1VjUq6h5iZVI1GWKx
 kZqrWJbzClfkSdPoMFyG/in4B4wQL5IYpYXsHLT+TOxOL9QrrCgkf9tcgH3htKMxo7g6
 kf50ExAPs/QduCnXyHuRnVVQtjQxYcCuBCMI+hMBxprPJmN9dISLIaxXo4RU6/JHJEQe
 jMKw==
X-Gm-Message-State: AOJu0YxYG3p34Rs93clyjWNx4deqYasxRRHUoP+ZMdBhaK9f+x0FHyfR
 +ZIA7zM+g+bLBkweFSpago9qIInmBT4Q2bE7hKpTz5nu4KSP4I/2RGyP+WC50aZYpgQ/NT1/zIz
 tD+gUBAqYqU9yvCREaaOHmLdsSFHF4SZgxnWnLdrLdzyoQ5a49TJJ4PSVj6FIaY/islVo5zA2uK
 397rP0wuAyH0SWRxRj6+RzFqgg7jO9EaapPNN4ej8sRxhfTEi9GLrFq42+RUjNlIs8IxxONj6rA
 04utw==
X-Gm-Gg: Acq92OHnP3JUPgBncUgQH9hCyZgKTzQ0bV83myBew7ooQKuqO1UkPTfsc4OqzaEe23g
 7W3PnzNUErFOI/y2QMPAB9qXCLcig5hiW4ZCirlqLGgdeOi8ppYVuaNs1dwdqkyyVeQ124ipoUY
 Te/sg21jA3JlFUSIb/LJJGsIXri8S3IvZ5ch+g7406ORt+EEWloEDMwkSPFY6zCc/xMGDpUHuwQ
 0XWgLo2nCpUdyDp7EFjxBCKzI5/XVt77pO+oJDZ5sIMf2oPXC0P+bJ9zMyz8yH+b8Iz0rtNqmPs
 Y55bu8NHBfB/BAhUgoZ/4cdkwdV9Tjiv9BcmexUDKb/G+jW5ucVZ6OUbp2rZk/q21c+C8uATdHa
 9rswXxlQEKZYlQIgCzh7nudGTL8wwCRg0UggKs7hW9oKS9oKNqEbKwguZEPUOEWnBFsdHfUSCXg
 +e2xkRlATT3moLWXOmBGrM8u932s+K2B24bOyD/ajBp5LPre2QX/971wzl+A+aSBgpbp+pvlao9
 tIbTQ==
X-Received: by 2002:a05:6808:2389:b0:486:3634:e80b with SMTP id
 5614622812f47-4868dc46e34mr15924929b6e.10.1781115482881; 
 Wed, 10 Jun 2026 11:18:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-440d86c7c19sm2104268fac.15.2026.06.10.11.18.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 11:18:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so56924715e9.0
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1781115481; x=1781720281; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q3x56Pu4kgoR3OxBSYDeTv+9perciJmD5rzzKsTko6I=;
 b=SuM4tacroD8ZE48zdn90yEl0kURCn5/6gmCna0Kmw79TCoYFtJeIYwigpov1aajZ0w
 Ee2uNqGxw0QGTXHo1T3+KR1V40mSh6Nv5gU6NaosJUS4MbNNvQTnVKcCFaDrbDpx+mU+
 E7m/LuaBZYSWLWbjfqhdIq3VuS0MF5cRhh13M=
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490c25fc0d5mr418118205e9.21.1781115481137; 
 Wed, 10 Jun 2026 11:18:01 -0700 (PDT)
X-Received: by 2002:a05:600c:c16f:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490c25fc0d5mr418117745e9.21.1781115480700; Wed, 10 Jun 2026
 11:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Wed, 10 Jun 2026 14:17:45 -0400
X-Gm-Features: AVVi8CcxiJFFK8eYyaBiVABmEKj8feeAQL8vyDWlwOKgx-GRKJZGzIpHh-0cf2Y
Message-ID: <CA+BST0nLhVCYvcvcePF13gqFuR09zNVRb7OX+ZzLfQM8xNwaqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] net/bnxt: interrupt handling, external mbuf and
 stability fixes
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000009463320653ea431e"
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

--0000000000009463320653ea431e
Content-Type: multipart/alternative; boundary="0000000000008814670653ea439e"

--0000000000008814670653ea439e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:48=E2=80=AFPM Mohammad Shuab Siddique <
mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
>
> This series addresses interrupt handling, external memory, and crash bugs=
:
>
>  - Fix incorrect completion validation for NQEs and RX completions causin=
g
>    excess interrupts
>  - Use buf_addr instead of IOVA for mbufs from external memory pools
>  - Skip IOVA range check for external mbuf head nodes to avoid false
> failures
>  - Add null checks to prevent segfaults when accessing uninitialized
> structures
>  - Fix segfault on exit when bonded ports are present, by checking whethe=
r
>    ethdev has already freed the RX/TX queue arrays
>
> All patches carry Fixes: tags and Cc: stable@dpdk.org.
>
> Note: this series depends on series "net/bnxt: ULP stats timer and PTP".
>
> Changes in v2:
>  - Patch 1/5: replace printf() with PMD_DRV_LOG_LINE() (DPDK logging
> standard)
>  - Patch 2/5: replace custom bnxt_mbuf_buf_addr() with
> rte_pktmbuf_mtod_offset()
>
> Ajit Khaparde (2):
>   net/bnxt: use buf address for external mbuf
>   net/bnxt: prevent a potential segfault
>
> Keegan Freyhof (2):
>   net/bnxt: fix NQ/CQ processing for interrupt handling
>   net/bnxt: fix for segmentation fault that would occur on exit
>
> Mohammad Shuab Siddique (1):
>   net/bnxt: fix IOVA range check for external mbuf head node
>
>  drivers/net/bnxt/bnxt.h        |  2 +
>  drivers/net/bnxt/bnxt_cpr.c    | 100 ++++++++++++++++++++++++++++++++++
>  drivers/net/bnxt/bnxt_cpr.h    |  34 +++++++++++-
>  drivers/net/bnxt/bnxt_ethdev.c |   3 ++
>  drivers/net/bnxt/bnxt_hwrm.c   |   3 ++
>  drivers/net/bnxt/bnxt_ring.c   |  11 +++-
>  drivers/net/bnxt/bnxt_rxq.c    |  47 +++++++++++++++-
>  drivers/net/bnxt/bnxt_rxr.c    |   2 +-
>  drivers/net/bnxt/bnxt_stats.c  |  17 +++---
>  drivers/net/bnxt/bnxt_txr.c    |  19 +++++--
>  10 files changed, 223 insertions(+), 15 deletions(-)
>
> patches merged into dpdk-next-net-brcm
Thanks

> --
> 2.47.3
>
>

--0000000000008814670653ea439e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 4, =
2026 at 8:48=E2=80=AFPM Mohammad Shuab Siddique &lt;<a href=3D"mailto:moham=
mad-shuab.siddique@broadcom.com">mohammad-shuab.siddique@broadcom.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Mohammad Shuab Siddique &lt;<a href=3D"mailto:mohammad-shuab.siddique@broad=
com.com" target=3D"_blank">mohammad-shuab.siddique@broadcom.com</a>&gt;<br>
<br>
This series addresses interrupt handling, external memory, and crash bugs:<=
br>
<br>
=C2=A0- Fix incorrect completion validation for NQEs and RX completions cau=
sing<br>
=C2=A0 =C2=A0excess interrupts<br>
=C2=A0- Use buf_addr instead of IOVA for mbufs from external memory pools<b=
r>
=C2=A0- Skip IOVA range check for external mbuf head nodes to avoid false f=
ailures<br>
=C2=A0- Add null checks to prevent segfaults when accessing uninitialized s=
tructures<br>
=C2=A0- Fix segfault on exit when bonded ports are present, by checking whe=
ther<br>
=C2=A0 =C2=A0ethdev has already freed the RX/TX queue arrays<br>
<br>
All patches carry Fixes: tags and Cc: <a href=3D"mailto:stable@dpdk.org" ta=
rget=3D"_blank">stable@dpdk.org</a>.<br>
<br>
Note: this series depends on series &quot;net/bnxt: ULP stats timer and PTP=
&quot;.<br>
<br>
Changes in v2:<br>
=C2=A0- Patch 1/5: replace printf() with PMD_DRV_LOG_LINE() (DPDK logging s=
tandard)<br>
=C2=A0- Patch 2/5: replace custom bnxt_mbuf_buf_addr() with rte_pktmbuf_mto=
d_offset()<br>
<br>
Ajit Khaparde (2):<br>
=C2=A0 net/bnxt: use buf address for external mbuf<br>
=C2=A0 net/bnxt: prevent a potential segfault<br>
<br>
Keegan Freyhof (2):<br>
=C2=A0 net/bnxt: fix NQ/CQ processing for interrupt handling<br>
=C2=A0 net/bnxt: fix for segmentation fault that would occur on exit<br>
<br>
Mohammad Shuab Siddique (1):<br>
=C2=A0 net/bnxt: fix IOVA range check for external mbuf head node<br>
<br>
=C2=A0drivers/net/bnxt/bnxt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +<br>
=C2=A0drivers/net/bnxt/bnxt_cpr.c=C2=A0 =C2=A0 | 100 ++++++++++++++++++++++=
++++++++++++<br>
=C2=A0drivers/net/bnxt/bnxt_cpr.h=C2=A0 =C2=A0 |=C2=A0 34 +++++++++++-<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c |=C2=A0 =C2=A03 ++<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0|=C2=A0 =C2=A03 ++<br>
=C2=A0drivers/net/bnxt/bnxt_ring.c=C2=A0 =C2=A0|=C2=A0 11 +++-<br>
=C2=A0drivers/net/bnxt/bnxt_rxq.c=C2=A0 =C2=A0 |=C2=A0 47 +++++++++++++++-<=
br>
=C2=A0drivers/net/bnxt/bnxt_rxr.c=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0drivers/net/bnxt/bnxt_stats.c=C2=A0 |=C2=A0 17 +++---<br>
=C2=A0drivers/net/bnxt/bnxt_txr.c=C2=A0 =C2=A0 |=C2=A0 19 +++++--<br>
=C2=A010 files changed, 223 insertions(+), 15 deletions(-)<br>
<br></blockquote><div>patches merged into dpdk-next-net-brcm</div><div>Than=
ks=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
2.47.3<br>
<br>
</blockquote></div></div>

--0000000000008814670653ea439e--

--0000000000009463320653ea431e
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
oIHHMC8GCSqGSIb3DQEJBDEiBCA2K8oazIumtjbeXkDTnAXwZXgViMKkZtZkd2JOLHOLoDAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA2MTAxODE4MDFaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQChTbL7CuxE
LxuEKtrro05hMR1jQLiIP0smj2DyC5tpUfI8EGn/8rIv4gazSyFgZzkwkVZ08JilSChqL7Yv2Pm2
mI2T0itGetKcyREtKXpDABaMyl7lFQNZH/ycCHEuw7xK/K0QtTekr8x524UiwIpbREB36ddlde49
4k1bWXC2Wj3jsEkHRP0jTZHBr1u8UF0zegIaKbeoKr0K9XON2sZXSkPPvUzBBsJGYqVepE3+s9B3
MkYg8a2iADR7Tzehj9p2TPAYOP5jvtrSKRNDaDyl3lsjXf4AQbWFjsegvhp7sW5RKZ52yx18fs5N
lJocWCwUV4ZhvbRT/RYegXz7cTAK
--0000000000009463320653ea431e--
