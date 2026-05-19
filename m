Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D20CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 21:03:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C700402B5;
	Tue, 19 May 2026 23:03:11 +0200 (CEST)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id EE51B402AA
 for <dev@dpdk.org>; Tue, 19 May 2026 23:03:09 +0200 (CEST)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so4157558d50.1
 for <dev@dpdk.org>; Tue, 19 May 2026 14:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779224589; x=1779829389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bK/+D3iKqIW0qfRZ88tK/ePUD9mt+lOo0CkYJdmlsLw=;
 b=guTYiww9u6bT/2jSuW2zRH6Fx1aUIqKE4yn5KpV2O9yLD3UJrH3JtLd82XZsS1z5qu
 ZvjaW1LzBlYAO8wXeD5PhBi3F4jA+uUS0plOowPZUAlFzjv6ux1s7Aw8h2uFgAuAdQyR
 mLyn9HfUARwiK1LZOFCODWqmqIy8m97khyf0O2y8bFbtQD9dMnmuC3BX10v/TGcRl1NZ
 V3sMdqO/wtTmdwHkIGtuFQESS5tjCWgwfK66sAFFwPWcje7RrEw6SWupMwPydGEx3yHS
 p1V81QMF/L5sxx1vbHiBPjfmWL2Y0pVMFvpLGQtpqGUuwx0NXpTEgx12YxVm3UIxeHst
 7JVw==
X-Gm-Message-State: AOJu0YxsFIJgk+N17ZOpxQCrBND7RuYbbFon3alEy/O9tSueutn8RbHy
 Ebnr2ZWtz/SQhNuquDJBDKoKG4Vo8h9TpjGlIkLJx4BVPjVvqLbKO339mW1VIQ3e//Ph/UIit+B
 xvs1B+Yvy0M77YsDP0iz3fyEnDFYz5YAQcMQr+cpf5m8By6J9RNVIGdnsuwAFjF4WBJuuHLkopI
 V+CU1LtyPJlJxtuuT4ikFRUv8SgGzIRoxiArbOPl6oLQrx+YtwHcwo4cSNY8wVGjhoLSF695o8M
 clKvQ==
X-Gm-Gg: Acq92OGSnL3ISC1AqYLz+XdWy/6Tm2RsIJlbxBpGL8uCgQig2e6Jm2O+MQ8Jvhg0Umk
 wI40Sjk164X7aPkeMrg/CHrVNogUGsGWBJF9ukh5gQZMvOvneTROiMoikuawpJPdpjRofSWrs4V
 5x4deEDi50hF1iAhqvkfQLvEgUZWhypHStk4Os/zl3kIBcUHM7g574JFEAYwyIK6ZrZmH2ezqr9
 y8C5+CPhlsDCZgTiyqMd21K1vvj3oe4mWpijzIuPyZ1cmsS3YCvuyOiUj0BsXLVzZgzqdZPr7t+
 TUb94V2u7siLSZl5vfFATwD9Q/K46el4M0Y29LweKEq0ndHsZAGE+29eDj2Lk74m2BcewuTL98G
 yFtc9/Xa/FDGoZbrgdV3vgAev7ZCsy3iWu7HDxbSEqB/BAV4AM9LgvLqMua/Hel5MXbRKtR+0ey
 Ly0ipDyZMSzH7Of+vOw7eUaAIfcI6fJTIpzXKrq7i55XqOEjy9pUpJ66GuP2CIDxdp
X-Received: by 2002:a05:690e:4144:b0:65e:41a4:54c5 with SMTP id
 956f58d0204a3-65e41a45741mr14255706d50.55.1779224588851; 
 Tue, 19 May 2026 14:03:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-65e0daeede5sm1364479d50.23.2026.05.19.14.03.08
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 May 2026 14:03:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-680d4986ff7so4545858a12.1
 for <dev@dpdk.org>; Tue, 19 May 2026 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779224587; x=1779829387; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bK/+D3iKqIW0qfRZ88tK/ePUD9mt+lOo0CkYJdmlsLw=;
 b=ZVKCCcpuWOuKn0UIeeOgpD+fC0IyMMPDwR8Ufbxqe0clRoT4dFfyV66q8VSPt8nONm
 /+wDma1FwpjIfayQ2j4gb24RNfXRwZKHQLXPA5cVJNf6D3DnSYSLcNhFI8hHg7Hu89WX
 +4obegyJxhP3BJhBVdlHWKN0U3wKtp+niLFrs=
X-Received: by 2002:a17:907:d091:b0:bc6:bb4b:1726 with SMTP id
 a640c23a62f3a-bd51553a62cmr1095732266b.22.1779224587188; 
 Tue, 19 May 2026 14:03:07 -0700 (PDT)
X-Received: by 2002:a17:907:d091:b0:bc6:bb4b:1726 with SMTP id
 a640c23a62f3a-bd51553a62cmr1095730366b.22.1779224586691; Tue, 19 May 2026
 14:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260519044344.9544-1-denserg.edu@gmail.com>
 <20260519044344.9544-2-denserg.edu@gmail.com>
In-Reply-To: <20260519044344.9544-2-denserg.edu@gmail.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Tue, 19 May 2026 17:02:48 -0400
X-Gm-Features: AVHnY4LcIfi4phM-gQXiyLkwJhvaKehX1W9VtCCq9CzmgRZ4-A0xIPlY_nCprCU
Message-ID: <CA+BST0nKjhifTBgKgn7qjb2oGEb7XFq3Ejr75u0T9Lm_c0p1EQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/bnxt/tf_core: fix ignored return of EM delete
To: Denis Sergeev <denserg.edu@gmail.com>
Cc: dev@dpdk.org, ajit.khaparde@broadcom.com, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000084cbc60652320128"
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

--00000000000084cbc60652320128
Content-Type: multipart/alternative; boundary="0000000000007750e506523201a0"

--0000000000007750e506523201a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:44=E2=80=AFAM Denis Sergeev <denserg.edu@gmail.c=
om>
wrote:

> The return value of tfc_em_delete_raw() in tfc_em_delete() was
> silently discarded: rc was unconditionally overwritten by the
> subsequent tfc_cpm_get_cmm_inst() call without any error check.
>
> If tfc_em_delete_raw() fails, the HW EM entry is not removed but
> the function continues to free the corresponding SW pool entry,
> creating a HW/SW state inconsistency that can lead to stale flow
> matches or incorrect pool slot reuse.
>
> Add an error check after the call and return -EINVAL on failure.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
> Cc: stable@dpdk.org
>
> Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
> ---
>  drivers/net/bnxt/tf_core/v3/tfc_em.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c
> b/drivers/net/bnxt/tf_core/v3/tfc_em.c
> index 3fe4dbe3fe..4c126dc2f4 100644
> --- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
> +++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
> @@ -661,6 +661,11 @@ int tfc_em_delete(struct tfc *tfcp, struct
> tfc_em_delete_parms *parms)
>                                &db_offset
>  #endif
>                                );
> +       if (rc !=3D 0) {
> +               PMD_DRV_LOG_LINE(ERR, "tfc_em_delete_raw() failed: %s",
> +                                strerror(-rc));
> +               return -EINVAL;
> +       }
>
>         record_offset =3D REMOVE_POOL_FROM_OFFSET(pi.lkup_pool_sz_exp,
>                                                 record_offset);
>
This change is not required, even if deletion of the HW entry fails, it
should continue to delete the SW state, since at the end all the HW entries
are invalidated. Have you been able to reproduce a scenario where this
failure is seen.

> --
> 2.50.1
>
>

--0000000000007750e506523201a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 19,=
 2026 at 12:44=E2=80=AFAM Denis Sergeev &lt;<a href=3D"mailto:denserg.edu@g=
mail.com">denserg.edu@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">The return value of tfc_em_delete_raw() in=
 tfc_em_delete() was<br>
silently discarded: rc was unconditionally overwritten by the<br>
subsequent tfc_cpm_get_cmm_inst() call without any error check.<br>
<br>
If tfc_em_delete_raw() fails, the HW EM entry is not removed but<br>
the function continues to free the corresponding SW pool entry,<br>
creating a HW/SW state inconsistency that can lead to stale flow<br>
matches or incorrect pool slot reuse.<br>
<br>
Add an error check after the call and return -EINVAL on failure.<br>
<br>
Found by Linux Verification Center (<a href=3D"http://linuxtesting.org" rel=
=3D"noreferrer" target=3D"_blank">linuxtesting.org</a>) with SVACE.<br>
<br>
Fixes: 80317ff6adfd (&quot;net/bnxt/tf_core: support Thor2&quot;)<br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Denis Sergeev &lt;<a href=3D"mailto:denserg.edu@gmail.com" t=
arget=3D"_blank">denserg.edu@gmail.com</a>&gt;<br>
---<br>
=C2=A0drivers/net/bnxt/tf_core/v3/tfc_em.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_cor=
e/v3/tfc_em.c<br>
index 3fe4dbe3fe..4c126dc2f4 100644<br>
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c<br>
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c<br>
@@ -661,6 +661,11 @@ int tfc_em_delete(struct tfc *tfcp, struct tfc_em_dele=
te_parms *parms)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;db_offset<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PMD_DRV_LOG_LINE(ER=
R, &quot;tfc_em_delete_raw() failed: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror(-rc));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 record_offset =3D REMOVE_POOL_FROM_OFFSET(pi.lk=
up_pool_sz_exp,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 record_offset);<br>
</blockquote><div>This change is not required, even if deletion of the HW e=
ntry fails, it should continue to delete the SW state, since at the end all=
 the HW entries are invalidated. Have you been able to reproduce a scenario=
 where this failure is seen.=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--0000000000007750e506523201a0--

--00000000000084cbc60652320128
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
oIHHMC8GCSqGSIb3DQEJBDEiBCCkHEmkaweli4lncgZQrf1zG2/Nh1pOba53HgqjruMkuTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA1MTkyMTAzMDdaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCWltZmblv+
XEJIFYEgjD11PyFWEvqBgF68OrXRKslLINln2s2wXhHOWHTcWs9TFKqzjlu2JfF0s7e23GjTJrQr
YwCon0ZB/SBDGEQ6y6orCjw1wUJYnsGRt16ktwDWa08u5JFRRhASJMAlO/Gz10edlJbFXDlpsd54
h1cTIElIv8HRS5/hdWdrphnSskJWDM7b/DytL4Sp7JfYUisfa24Xf1rES8T+d8DR3LAKMTJWvv7x
0rFMO2oHvNdTW5myqt2Wy5pel0Sr9WPieXe664H9G0umxlmCi4F6fcE2B3trGkSz4f6kAqI9a3yb
sl85FxjjyQzhbpvTtFOCwK5Opt4M
--00000000000084cbc60652320128--
