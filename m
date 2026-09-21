Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D949C982EE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 18:49:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96203410DF;
	Mon, 21 Sep 2026 20:49:57 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 78B974067D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 20:49:56 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2dd665f341aso15892805ad.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790016595; x=1790621395;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YuvDH1UL3MEvnhrwPxNi9Vpru1rrUsBrTbSXjBMXlMs=;
 b=xfCxp0/2XqJrOnh90xTasjoDkFgP1YaNJpKExPTnlFJJ/eiwBeXrAzcYnr0cH7Exn1
 aaV31T7nt0AwuyL2ooIzQHy8o8kQTIgF9HlEk5CnKVWIFEgWx4I8Tz+iDlv4qtr6neAP
 re/xytg9HCmqBS5KYSd7Up/rE5ovBdx5zwRZ/Jen7r0ILFsxtnH9m8bTlQMcCvCZ7AMq
 R5cPq0ZUURf4YaZjIqpu6v5mw4InPb7BhTUJcuhT3C2fT0B4z59zHocEWRTlrIuk6oVj
 wQBWzj+C7cIBj3rEjCC/czN1yj0nF7dDjl4XoyW5sEF4a4fIA/VekCZUhtmBBFLSNiKo
 AJRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywZzvKngAfGYvfa3pbhB9PhN7u4t8dBzzlmTL/zsFdGQwE0an9+AtH2qZF7/wl4v+V8oM=@dpdk.org
X-Gm-Message-State: AFuF++mYLW6tREwO0O7L4N6t5SiQnh0r/tXQUx4olKlzKSqPEvPr4wFQ
 Idxlrlnce1bnvukKsDb1JZehN0EzRA9KMw3iL2MMR7lzfvwnxSsspK41vRfN/z/OBhR8Hd/Km8f
 s7Dhex8x5NO5mNXMPEpZ5OgYHHiKNCU1/9XUlzyrZQDC98gC0GOcMHJNnrxsSJshteW6eWU+OAS
 adbVpsc0Fq3JO4U26i6jqsrjxEcAnfpDmbrDJ3xCdo792KMjLBKYtHEl+l3dytsYFqqGMJwbydw
 euGoA==
X-Gm-Gg: AYBFou3mC0Qsgxmfq3Kupkly45EhJwOSg4veiFZQp1grOPIwI+ZJsnAvpoVlfq01h+Y
 fVBaAsFg3+g49BeqqcWaMPNsYYiQHhMJSySZ3STXzPHASOAi32WHnlDytlIFt+d1pMW7ZN73zYG
 hvydnSsoQObEXfkWrqicao2UP2tEaF68cdAv9H3xTgmeZOXuSyzTz2hhRHfmhBwNjENVQrio5LL
 k7Gse0CTHjTedlkxywTp4F04K23nzR+aWd/vgVMXMRR51dDOp/gYF7CfVJHHmFwoeGOXzgHyENf
 P9cRoqicS/BJ8KkYnfXLUc/AyVaSCfVXU+GhUk8rvHHB6Hf9C3bShk/9wagAmgUW2d6chTuZkmD
 rbZeetbO4qu1pxl94LcO7zzc0WtoOU+amgOpsfNCG32+hHrWZPihHMys6g5uT6egdJ0qrtxc0u3
 PRe03FxBoBNecAlyZ5ksJn45qSYhjNX+JeCD/N6WBQOEw=
X-Received: by 2002:a17:903:2443:b0:2d9:484:861d with SMTP id
 d9443c01a7336-2ddb1af6da8mr163330445ad.10.1790016595288; 
 Mon, 21 Sep 2026 11:49:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2df231a531asm2821865ad.43.2026.09.21.11.49.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 11:49:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a6735afb87so3218088a12.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790016593; x=1790621393; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YuvDH1UL3MEvnhrwPxNi9Vpru1rrUsBrTbSXjBMXlMs=;
 b=Kb7OryhtoBXWp0Rzj9GMM7bGdIiRIefjs/t7ItU8ziJbcdtQPx6sR7RCsJZlpjDW51
 OpRKdcTtIuKEqLtWHsdWSvWwZ7fSFKswc0b864Rx6Pv1hAXxIDZZHfPDZA8L7qhsVJDl
 kTtV8OkMVOM9K5bYRnjoSmpyYSC4/c+7LD8LQ=
X-Forwarded-Encrypted: i=1;
 AKwUvBztCLJDrAaI8QI4EdKqvV2b/uIo0FCGnnMZV4xIeQokI11LU9Yn91zKR6Cgq3i5ugx67WE=@dpdk.org
X-Received: by 2002:a05:6402:3908:b0:6a9:ae3a:9c9d with SMTP id
 4fb4d7f45d1cf-6aa531b797emr8640518a12.29.1790016593149; 
 Mon, 21 Sep 2026 11:49:53 -0700 (PDT)
X-Received: by 2002:a05:6402:3908:b0:6a9:ae3a:9c9d with SMTP id
 4fb4d7f45d1cf-6aa531b797emr8640508a12.29.1790016592713; Mon, 21 Sep 2026
 11:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260915085125.430901-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915085125.430901-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 14:49:35 -0400
X-Gm-Features: AcwNN1VXt1Lpklvm7WoydSWoTvcoCA1FTn7SzzpScud2Dsyazp1Act3PkksHrgw
Message-ID: <CA+BST0=M0jBQs5brUhvg+7ZJvHiefv03syVc5rQ3GW9rugKbsg@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: check TSID retrieval failure
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org, 
 shuanglin.wang@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000003134fa065c02b757"
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

--0000000000003134fa065c02b757
Content-Type: multipart/alternative; boundary="00000000000026c4f1065c02b7d1"

--00000000000026c4f1065c02b7d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:51=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> Check the return value of bnxt_ulp_cntxt_tsid_get() and log an
> error when TSID retrieval fails.
>
> Found by InfoTeCS on behalf of Linux Verification Center (linuxtesting.or=
g)
> with SVACE.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> ---
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> index fa98b2bca9..d5ce4c3c18 100644
> --- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> +++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
> @@ -309,6 +309,8 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)
>                 return;
>
>         rc =3D bnxt_ulp_cntxt_tsid_get(bp->ulp_ctx, &tsid);
> +       if (unlikely(rc))
> +               BNXT_DRV_DBG(ERR, "Failed to get the table scope\n");
>
>         rc =3D bnxt_ulp_cntxt_fid_get(bp->ulp_ctx, &fid);
>         if (rc)
> --

 Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.30.2
>
>

--00000000000026c4f1065c02b7d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 15,=
 2026 at 4:51=E2=80=AFAM Evgeny Sokolov &lt;<a href=3D"mailto:Evgeny.Sokolo=
v@infotecs.ru">Evgeny.Sokolov@infotecs.ru</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">From: Sokolov Evgeny &lt;<a href=
=3D"mailto:Evgeny.Sokolov@infotecs.ru" target=3D"_blank">Evgeny.Sokolov@inf=
otecs.ru</a>&gt;<br>
<br>
Check the return value of bnxt_ulp_cntxt_tsid_get() and log an<br>
error when TSID retrieval fails.<br>
<br>
Found by InfoTeCS on behalf of Linux Verification Center (<a href=3D"http:/=
/linuxtesting.org" rel=3D"noreferrer" target=3D"_blank">linuxtesting.org</a=
>) with SVACE.<br>
<br>
Signed-off-by: Sokolov Evgeny &lt;<a href=3D"mailto:Evgeny.Sokolov@infotecs=
.ru" target=3D"_blank">Evgeny.Sokolov@infotecs.ru</a>&gt;<br>
---<br>
=C2=A0drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_u=
lp/bnxt_ulp_tfc.c<br>
index fa98b2bca9..d5ce4c3c18 100644<br>
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c<br>
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c<br>
@@ -309,6 +309,8 @@ ulp_tfc_tbl_scope_deinit(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_ulp_cntxt_tsid_get(bp-&gt;ulp_ctx, =
&amp;tsid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(rc))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BNXT_DRV_DBG(ERR, &=
quot;Failed to get the table scope\n&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_ulp_cntxt_fid_get(bp-&gt;ulp_ctx, &=
amp;fid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
--</blockquote><div>=C2=A0<span style=3D"font-family:Calibri;font-size:11pt=
;background-color:transparent">Acked-by:=C2=A0=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"> <br>
2.30.2<br>
<br>
</blockquote></div></div>

--00000000000026c4f1065c02b7d1--

--0000000000003134fa065c02b757
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDQnh4RBTrmv8UxIr5s+OdUH8WwJVGmM3hm707RgkWObzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExODQ5NTNaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAWmTXS6RY8
4hm/L58QWUib/P8khEG7qibYJr7PyygjzidfqhKGLfeJ4i8bIdv6MB8O6dA5RR4+aNOI2br2y961
7TMVKKi95qIzm2+mQxrFZLjDjWD2K+obhtVLYQN1fL6gn8jAmZ3+W4c+8Z/6XL5bwbCO5+Jt+pC7
p8TQcSXtDhXeiZRYGe4SmF0sZR8VWYB06SF4O1CaByJTfROorKs7oanuSIGCb+XvJ4kL93QYrotp
OMx5zyOIuGf9jwGaXYg1Z3/gZlWwuC8n4VeNx2JxVW+R9J2LFrynx0l9rFkMUZFQXo/WuewrzYhW
Pcsjh9ZyD01AX5Im+51hjLIn8XT+
--0000000000003134fa065c02b757--
