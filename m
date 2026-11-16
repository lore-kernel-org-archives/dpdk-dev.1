Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F8606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Ro8sGIrR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56CA740297;
	Mon, 16 Nov 2026 22:57:57 +0100 (CET)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by mails.dpdk.org (Postfix) with ESMTPS id 26A5C40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 22:57:55 +0100 (CET)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso2182071a91.0
 for <dev@dpdk.org>; Mon, 16 Nov 2026 13:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866273; x=1795471073;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fh+0jTfhGrsoEnOu3vJYvBTH9tkkJZDZsNqIHfUSYZ4=;
 b=SX8UQE393naD3ezNKHd33rYrU0/w3rfYKKEESgv5AIaZd1RUDfCgT7sVehn9CkMw3D
 mKkxfH62cJmn2n7FGp+iwSz8THD82KANssYKCyphZ8EdfZX8tC6oENc+LNUVNXF5CF8D
 bZshEGBKOeAbhBaMd5Nx7Wf5mvPWSfCPiiZHlwUMKPPXZ68RgPOSu//KTdhqHEjevv8T
 cDhaly3oznd4SpvMbdusmNdOyO4RC2esjc+vQnjb3T5Yenmw30wykqiqQV4MVJCJGAwP
 dpn4cZXtFPiClzMJuymnrwyID7FNI7Y0st1tnWFDZmTIhSYC7r7/3JAx0A9vmfMVu0nM
 +E8A==
X-Forwarded-Encrypted: i=1;
 AL+hErF16oajnhTcozXPO+CeQ7kzSAiNped0Yjb1iNGxsy6TXzwvXm+ilQbFd0CXDZA10+lLkiM=@dpdk.org
X-Gm-Message-State: APuU4Z9Rq5obwd9HSqNICJ9IU0GREx0plzuingW6hwFQN5ywYCTp4hwC
 VS4n253/9y04Ywp6e+i0Age0k5mZ31n3rMvV2CLFxeLyzQqEEh/+Rxo5xEk1gTDQwY/P/sRBkr2
 tB0Z7Wds+bKOJxTnbVQ71dlW//ZcWL5G3lqRJxnjiIBqvIn+uosOmk89jI2gTUmzvjchWC+O7II
 0eFp9Jb/NkztMh56GihWVNcK4a1eut4rsTzL0eNUlifCDHO/dugLtMUEf1VPf9qMOCTwseq5H4D
 Ky/LQ==
X-Gm-Gg: AZFdTZdqHjsSVbhDf0i+/p8fBD4b9j9y1NPffU82a3WigP+j+qL4HQQMUOKgI+I8lP+
 x84bkL5KiSyjpD4Tx3Oq5p/rbxUiIeO8TfEYfFIu7rpfEGZnxnIbR4rs/cRpehnRuFJ/0/wAPk2
 MdpJAN8TxdoMdfY2kKBv2mtUSbXtYZru9Xet49Zmh08QtzR6eQvnXFVi2D0sxpsVr0FBr1m256s
 rqta8mR3TGTaeGAwrP27xaedqlFmwkBA3euNLRMt+Uu0wC8sssaCcVHj9QLWNZY1IjqrIPnmyTa
 VIaFrP+caNcN11h+l7risFTmrlxY/el2BhkuT8FOJu/sJdD4Q3YrvBR3tGprAKdTJXE6cAcaZ1H
 iDbzck6+Bsoj6oRJ8YpCC+6aY0m3CiW6Zg0vgtslhNdeqMKNxOcO/sZyg5TiV9IhA9wap2W0itP
 DszfDgHYjDg6e2sh1+W8G0ysNf0QiLbq2kdXSIa+OTQgs=
X-Received: by 2002:a17:90b:53c4:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b1b0b531cemr12130096a91.39.1794866273063; 
 Mon, 16 Nov 2026 13:57:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3ab9f98bdsm489880a91.0.2026.11.16.13.57.52
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:57:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5bff4099b52so605941e87.3
 for <dev@dpdk.org>; Mon, 16 Nov 2026 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794866271; x=1795471071; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fh+0jTfhGrsoEnOu3vJYvBTH9tkkJZDZsNqIHfUSYZ4=;
 b=Ro8sGIrR5n0T0QN/upUfwq8sIkYtnkuTy9gexKGajEjkUo8gSBrRGGZ9RZEh3O13LY
 /KJaUUJpyWkC0S6zqd6Mh+/sjvbiHLoREBe93dnPBP7B1gmKm0BV3iNMH6BgBk5PjI6B
 55M4ZA0S+bxpreHCF/R8vPIKTvrFmQovZbJFQ=
X-Forwarded-Encrypted: i=1;
 AL+hErEh/t1nwHJkWEKXRd1OmoDTp/WAFg6PMfzHmbg3pwAV4H2E1tajTF+VlSlIH97Qp7QiK5c=@dpdk.org
X-Received: by 2002:a05:6512:3a94:b0:5c1:5981:5a44 with SMTP id
 2adb3069b0e04-5c17077fda5mr4472649e87.10.1794866270806; 
 Mon, 16 Nov 2026 13:57:50 -0800 (PST)
X-Received: by 2002:a05:6512:3a94:b0:5c1:5981:5a44 with SMTP id
 2adb3069b0e04-5c17077fda5mr4472644e87.10.1794866270363; Mon, 16 Nov 2026
 13:57:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116073721.236658-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20261116073721.236658-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 16 Nov 2026 16:57:32 -0500
X-Gm-Features: Aa3M54oHJ0Ahy7CWl2EPL1H1CxImUkn_vRsfbmQ6wGlp360zJlydqt05OdoATRo
Message-ID: <CA+BST0kCGoBkbeqDpCOzVOCikY-zG3Z6VJndo24k1897sSnLNQ@mail.gmail.com>
Subject: Re: [PATCH] From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru> Date:
 Mon,
 26 Oct 2026 20:39:23 +0300 Subject: [PATCH] net/bnxt: remove redundant lines
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000008332d606606bdea1"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000008332d606606bdea1
Content-Type: multipart/alternative; boundary="00000000000076fdbb06606bde53"

--00000000000076fdbb06606bde53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:37=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> Remove the redundant lines
>
> The return value of the _mm256_permutevar8x32_epi32 function
> stored in the info3_v varable is overwritten a line below
> and can be safely removed.
>
> Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.or=
g)
> with SVACE.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---
>  drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
> b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
> index 80074a56c4..07806f7357 100644
> --- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
> +++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
> @@ -570,9 +570,6 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf
> **rx_pkts, uint16_t nb_pkts)
>                  * bits and count the number of set bits in order to
> determine
>                  * the number of valid descriptors.
>                  */
> -               const __m256i perm_msk =3D
> -                               _mm256_set_epi32(7, 3, 6, 2, 5, 1, 4, 0);
> -               info3_v =3D _mm256_permutevar8x32_epi32(errors_v2, perm_m=
sk);
>                 info3_v =3D _mm256_and_si256(errors_v2, info3_v_mask);
>                 info3_v =3D _mm256_xor_si256(info3_v, valid_target);
>
> --
> 2.47.3
>
> This change is not relevant, this is already fixed in commit 242965acd785=
.
Update to latest dpdk release.

--00000000000076fdbb06606bde53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 16,=
 2026 at 2:37=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Remove the redundant lines<br>
<br>
The return value of the _mm256_permutevar8x32_epi32 function<br>
stored in the info3_v varable is overwritten a line below<br>
and can be safely removed.<br>
<br>
Found by InfoTeCS on behalf of Linux Verification Center (<a href=3D"http:/=
/linuxtesting.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a=
>) with SVACE.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
---<br>
=C2=A0drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 3 ---<br>
=C2=A01 file changed, 3 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_=
rxtx_vec_avx2.c<br>
index 80074a56c4..07806f7357 100644<br>
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c<br>
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c<br>
@@ -570,9 +570,6 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx=
_pkts, uint16_t nb_pkts)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* bits and co=
unt the number of set bits in order to determine<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the number =
of valid descriptors.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const __m256i perm_=
msk =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_mm256_set_epi32(7, 3, 6, 2, 5, 1, 4,=
 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info3_v =3D _mm256_=
permutevar8x32_epi32(errors_v2, perm_msk);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info3_v =3D _mm256_=
and_si256(errors_v2, info3_v_mask);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info3_v =3D _mm256_=
xor_si256(info3_v, valid_target);<br>
<br>
-- <br>
2.47.3<br>
<br></blockquote><div>This change is not relevant, this is already fixed in=
 commit 242965acd785. Update to latest dpdk release.</div></div></div>

--00000000000076fdbb06606bde53--

--0000000000008332d606606bdea1
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDj9EVUWdxiMtPO9qN5SwweZY3wtmgynKi/xrSu2alZeTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjExMTYyMTU3NTFaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBzzBx+l58m
IAN7NJe3fB1JHbEfioQCCVBv8jnP+a0PLfe/AhvrXeGLHuzOcOLrjxuRETKDwvHOCkodlXG/HCL4
ext5u1KoaS5zri9wwQbJ1NMac15FvKr0Ojxw3OCRra82Uz5fwLXBIB7rTquK2FgpwKwaVWDqT9Uz
wHi00a6Fqoe21+4jyWOL1/U+WyedmTPnU4sAWyOG6V1mxuUDQoITo/xGL777mbO7JWKtV4C3Q98u
KE2QITRdOv/9EQBNFLqzzwm0QgSSdpksAcJGmu0oA50Uo/BTZul/9kzUeCvbigroduCYG5GvsIXL
35ripuDvmIjZYnozSpjgMOmdMEam
--0000000000008332d606606bdea1--
