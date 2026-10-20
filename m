Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D3606A31A
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=FiQEYFMC
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8E8B40283;
	Tue, 20 Oct 2026 15:41:37 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 0400C40150
 for <dev@dpdk.org>; Tue, 20 Oct 2026 15:41:36 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3ac7842c17dso1930132a91.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792503695; x=1793108495;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zrAiMbUUuWtw7ViAtiPY87k33Iq6rxv+fh77l0fOcns=;
 b=fTBl2zbBV2b4zKszyPa37SpBxHlw/pFakMwnbvAJxRoWCEGpO9eBOmS+6e56zuVTlw
 tIPrHImdutaph7kYmA9QCjd9uUlecxMHXG3Xv0ha0Df2q/dKrJDvfX4hsuZw7bZZq6Qh
 3vCAWAk3Am+EcwMdJjtBHT0OwICZCvoa6hFgxyUtBoSqjChYYnpGin3UrPJOut3IUEyo
 6LM+HKYkO4aoZJkPlxmE/ocmizgWW9My+WmWGmS9fENY+VFxQCWM/EPB22y9+pXEM642
 TkOf2kr9dPj4VZPe18lOoli1xm2sYVTLWxmAwuIReb1t+OtDHEALsI+g+tBcGehQw5Nb
 Qlsw==
X-Gm-Message-State: AFq9FYJAKcRGoIBqeWv85xBzfIUOC68d0XJMP6u671xajO+0yhpe860F
 b+gGGYmQbO9hxeUMv9lxssM9WxuC6JYWzG7SEnBwnqgVPB/uLB4EFuSBkwX0DkuVXXxS8L1p0n1
 IwprALxUTg3CsG8Q80ckBq2dDQs1MlpQfPIVVVeXqEB8etsqmXFPRjtExZXgNJQ/W8bz+Qk56iZ
 YXTIJFaXU/YzU4mimn2gbDcfMEL+aB3djRmpjrxMg+j9CfmtNLza5XRNl/wLldam38vIydl8wd8
 ZgB8g==
X-Gm-Gg: AYBFou0nMb6tLWzKU70hTVMCwPIpNEJOiJxQ9V1S2LHEBOQxgcpIm5ZAA2n8DCVRuv8
 EQVn+6wKcyPnmtWa2ddf8Yife1swBN43YJiPWaLyd/Ah/qD8g6t1y4HkRtad29xATpwhTUDFib+
 uGmcNxHccU4MVOVtZbQuPgbDdH3h3fktmbAsLOaqC5MgLFcc6bhObAoZQ//LIxmkkvOSUA7tp8t
 OOzyKroWD4auVq9lDVd/94+QpgUQoyFH2UXzrVz2n89jHZ+Gpw0oj3WZhz0AYQZJC7gxwCz2e9h
 rIf/8ILzxBqJFLR7W63C9S5EzV3xlOatT9TNdMaz3WGKBYes5Ygt0rl+SsPcjyuy9twE196aK+q
 hROvwPnn6WmlTIBI9px4HGiCm1OpOKDaMZBwfd3nOYCDZHgEHE3wse9h0Ww02pB10VUjxCh4/b0
 aFZQzLhOhQBRP/C8kbOaH6Ho81LW6IH+m57RGvb/uDqD+Bnw==
X-Received: by 2002:a17:90b:58f0:b0:3ac:9a5e:9ce7 with SMTP id
 98e67ed59e1d1-3acef4e5d60mr10666705a91.49.1792503694902; 
 Tue, 20 Oct 2026 06:41:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ad273c2779sm2241376a91.5.2026.10.20.06.41.34
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Oct 2026 06:41:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c40d92085ceso71620666b.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792503693; x=1793108493; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zrAiMbUUuWtw7ViAtiPY87k33Iq6rxv+fh77l0fOcns=;
 b=FiQEYFMCkYtLnCq7biIm5ANHEjI28GHwuQ7xe92i37ruwMQMwVQ1f9gPVXH8op3fJe
 nMj01g4CJyNVRPSHcTFQXM+cY5v0oOn9WMPBDY+hmso8q+CSuhiWGSM2B68J90cFtDyr
 7utX8p9od8K7MLA5FaalFaDpkkhu1wMin4zQU=
X-Received: by 2002:a17:907:8690:b0:c41:1f50:ea42 with SMTP id
 a640c23a62f3a-c4600c81c30mr169083666b.2.1792503692667; 
 Tue, 20 Oct 2026 06:41:32 -0700 (PDT)
X-Received: by 2002:a17:907:8690:b0:c41:1f50:ea42 with SMTP id
 a640c23a62f3a-c4600c81c30mr169081566b.2.1792503692135; Tue, 20 Oct 2026
 06:41:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020095133.2811576-1-thomas@monjalon.net>
In-Reply-To: <20261020095133.2811576-1-thomas@monjalon.net>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Tue, 20 Oct 2026 09:41:15 -0400
X-Gm-Features: AclHuK9-1nm_R3VItZAKOW6mhyvn6BSjWathKV0C9juKG79YEPfDLfm-WPQTcII
Message-ID: <CA+BST0mwb_r5JnNJBHzoYaOtYWYxoP1QveQjVzXCXwmCDiefwA@mail.gmail.com>
Subject: Re: [PATCH] maintainers: update for next-net-brcm tree
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000e13912065e45c937"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000e13912065e45c937
Content-Type: multipart/alternative; boundary="000000000000d4af0e065e45c913"

--000000000000d4af0e065e45c913
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:51=E2=80=AFAM Thomas Monjalon <thomas@monjalon.ne=
t> wrote:

> Kishore is the maintainer of the Broadcom tree
> since DPDK 26.07 cycle.
>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93ad53027d..1720cff62e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -32,7 +32,7 @@ M: Stephen Hemminger <stephen@networkplumber.org>
>  T: git://dpdk.org/next/dpdk-next-net
>
>  Next-net-brcm Tree
> -M: Ajit Khaparde <ajit.khaparde@broadcom.com>
> +M: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
>  T: git://dpdk.org/next/dpdk-next-net-brcm
>
>  Next-net-intel Tree
> --

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.55.0
>
>

--000000000000d4af0e065e45c913
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 20,=
 2026 at 5:51=E2=80=AFAM Thomas Monjalon &lt;<a href=3D"mailto:thomas@monja=
lon.net">thomas@monjalon.net</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Kishore is the maintainer of the Broadcom tree<=
br>
since DPDK 26.07 cycle.<br>
<br>
Signed-off-by: Thomas Monjalon &lt;<a href=3D"mailto:thomas@monjalon.net" t=
arget=3D"_blank">thomas@monjalon.net</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 93ad53027d..1720cff62e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -32,7 +32,7 @@ M: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networ=
kplumber.org" target=3D"_blank">stephen@networkplumber.org</a>&gt;<br>
=C2=A0T: git://<a href=3D"http://dpdk.org/next/dpdk-next-net" rel=3D"norefe=
rrer" target=3D"_blank">dpdk.org/next/dpdk-next-net</a><br>
<br>
=C2=A0Next-net-brcm Tree<br>
-M: Ajit Khaparde &lt;<a href=3D"mailto:ajit.khaparde@broadcom.com" target=
=3D"_blank">ajit.khaparde@broadcom.com</a>&gt;<br>
+M: Kishore Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.co=
m" target=3D"_blank">kishore.padmanabha@broadcom.com</a>&gt;<br>
=C2=A0T: git://<a href=3D"http://dpdk.org/next/dpdk-next-net-brcm" rel=3D"n=
oreferrer" target=3D"_blank">dpdk.org/next/dpdk-next-net-brcm</a><br>
<br>
=C2=A0Next-net-intel Tree<br>
--</blockquote><div><span style=3D"font-family:Calibri;font-size:11pt;backg=
round-color:transparent">Acked-by:=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"> <br>
2.55.0<br>
<br>
</blockquote></div></div>

--000000000000d4af0e065e45c913--

--000000000000e13912065e45c937
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCjhTaO0I/z2dz54lyDfZSkQIpYCjtWC0cT19FayOXenjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjEwMjAxMzQxMzJaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBceseMlsfX
p+lnUErt3WBfG+jMVCMOqBl/qUu56xsDt0bt1Oqr//ASFn01xciLuf6RJZh9QTQNh8QeIlbhfZGl
VIdyv1Ke0nn2kMkTEsUqyVB+BTIFSPB3uuuYU+LFzk/YPyKhjjaHNJa/Ifrz4ebpHIaEqQZoRzPE
VeoJl6GqWfmOu+3DHziX2K0hPJoxEj9OYH+qqrVoA5aT41Eg0IxgozCA+hi/kcUVgJnAX9asvrxS
4DFeM8982d3GOAruS9h8XLWchoiH46WUN+m7FDu4FsYuw6idM61XbklFNuVONN9NI0cBuuwyn+ij
iY//abZFCJwjEBh9S3VANkHyuA7/
--000000000000e13912065e45c937--
