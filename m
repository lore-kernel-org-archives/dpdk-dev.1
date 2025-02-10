Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37468C021A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 02:56:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62EBA402D1;
	Mon, 10 Feb 2025 03:56:25 +0100 (CET)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) by mails.dpdk.org (Postfix) with ESMTP id 5C2E0402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 03:56:24 +0100 (CET)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-867044e979dso882357241.3
 for <dev@dpdk.org>; Sun, 09 Feb 2025 18:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1739156183; x=1739760983; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Bjwt6gB8/SzCFNSpgOPtRKX57KCxBXVM4kgO+YZ4b0=;
 b=N89IwgHaVoz8FWgHOmErV3JtHG4iXx2vCcAlGxwTQsBnpw8yL8SJw+DLjZWSAWLLLJ
 6oPBIs+ir+FY6M1a3+6MdnsydOFTcyhenC1MSt0ErFzCr0wlzapgiuo8jNAfNB0juEPO
 Qbqcodw8sDrARiyFEbR2oxfPHm0k3DKJwhLbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739156183; x=1739760983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Bjwt6gB8/SzCFNSpgOPtRKX57KCxBXVM4kgO+YZ4b0=;
 b=RAjaylVVogzQV4D7fy0kPfayezgoWnZS1OytOa3xJ7W563f57VBVfcpULsl6vE/CjU
 t622ZEgzE7tamj3LSXP5AEcbcdH513/kcOK56UEa34VGWaDyA0HxUuj+jS9RswPcdGy0
 P9u7WTVO2wQMvnTxqopH1LmtJ9Kjg9L4Qmule68W8StqVMPAKsrTvwa2uxr30pQwj9UG
 r3r/oZ+Q+PgItxNje+uRh4YKaJqRdkm29hLFp6lvz7N2ce/suG8DI3EoaUOwOhBaJP2v
 SXUPIdIt26TlfseR71ohlajYWiiZ8Oul6WMmAr7lgs3GykD5feYv54uuxXx4L3wzeCez
 Z9+w==
X-Gm-Message-State: AOJu0YwzZ/ZQuZ0GmVK99NWCTYe0Ek+XpxHFFSyFJ4lHVQegWmsz7lmy
 pFxWmoPa+9bpVpbuZ/hw7TTnNrNWCZ+vk+K0SswFfgcn0wKKRhOIf9l6cJYSiKfnV6Xe1pCGfMb
 9wVUDBwVlkT2783rgl5vqO1ur9ttDouvWT8OI
X-Gm-Gg: ASbGnctEgXbzVCK4AwLUC0GIxPV2qyb2LR1BxrzQAZEEd+n+wFfZuI4PHBsKfBVRlCU
 cu+jALPdFuPK8f2fphyXCTqogzZFb0MhFbv2n1v84osUjcypVLf367bdoXj1D/Dlj61vgRg8njQ
 ==
X-Google-Smtp-Source: AGHT+IF+AGeVFqPDFsTresZ3lQKt+444E+sAxMkAXv6vwcVtFRcQxgnZnVHQUP/jknl9kfUBslJoCVl1/gDXGsYuT7k=
X-Received: by 2002:a05:6102:f0f:b0:4af:c58f:4550 with SMTP id
 ada2fe7eead31-4ba85de9d5fmr7395523137.7.1739156183578; Sun, 09 Feb 2025
 18:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20250208203142.242284-1-stephen@networkplumber.org>
 <20250208203142.242284-17-stephen@networkplumber.org>
In-Reply-To: <20250208203142.242284-17-stephen@networkplumber.org>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 10 Feb 2025 08:26:15 +0530
X-Gm-Features: AWEUYZmi7wF6xYAZKbQCYg8FPeSumikSpBf3fohgOUSZs1WWyApgOUQ5l6RAi6E
Message-ID: <CAOBf=msU1U=E8kACR+MH3E-_VPzazFAkrtmUW5GUr8R4UhE9xA@mail.gmail.com>
Subject: Re: [PATCH 16/32] net/bnxt: replace memcpy with structure assignment
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000008d3c70062dc0dae5"
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

--0000000000008d3c70062dc0dae5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 2:02=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Prefer structure assignment over memcpy.
> Found by struct-assign.cocci.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/bnxt/bnxt_hwrm.c      | 3 +--
>  drivers/net/bnxt/tf_core/tf_rm.c  | 8 ++------
>  drivers/net/bnxt/tf_ulp/ulp_tun.c | 3 +--
>  3 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
> index d015ba2b9c..b2f73207ae 100644
> --- a/drivers/net/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/bnxt/bnxt_hwrm.c
> @@ -3266,8 +3266,7 @@ int bnxt_hwrm_func_qstats(struct bnxt *bp, uint16_t=
 fid,
>
>         HWRM_CHECK_RESULT();
>         if (func_qstats)
> -               memcpy(func_qstats, resp,
> -                      sizeof(struct hwrm_func_qstats_output));
> +               *func_qstats =3D *resp;
>
>         if (!stats)
>                 goto exit;
> diff --git a/drivers/net/bnxt/tf_core/tf_rm.c b/drivers/net/bnxt/tf_core/=
tf_rm.c
> index e9a2fbd851..18f46c0a0a 100644
> --- a/drivers/net/bnxt/tf_core/tf_rm.c
> +++ b/drivers/net/bnxt/tf_core/tf_rm.c
> @@ -1265,9 +1265,7 @@ tf_rm_get_info(struct tf_rm_get_alloc_info_parms *p=
arms)
>         if (cfg_type =3D=3D TF_RM_ELEM_CFG_NULL)
>                 return -ENOTSUP;
>
> -       memcpy(parms->info,
> -              &rm_db->db[parms->subtype].alloc,
> -              sizeof(struct tf_rm_alloc_info));
> +       *parms->info =3D rm_db->db[parms->subtype].alloc;
>
>         return 0;
>  }
> @@ -1299,9 +1297,7 @@ tf_rm_get_all_info(struct tf_rm_get_alloc_info_parm=
s *parms, int size)
>                         continue;
>                 }
>
> -               memcpy(info,
> -                      &rm_db->db[i].alloc,
> -                      sizeof(struct tf_rm_alloc_info));
> +               *info =3D rm_db->db[i].alloc;
>                 info++;
>         }
>
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_tun.c b/drivers/net/bnxt/tf_ulp/=
ulp_tun.c
> index 7ebe81c4ea..b90b4bf252 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_tun.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_tun.c
> @@ -40,8 +40,7 @@ ulp_app_tun_search_entry(struct bnxt_ulp_context *ulp_c=
tx,
>         }
>         if (free_entry >=3D 0) {
>                 *tun_entry =3D  &tun_ent_list[free_entry];
> -               memcpy(&tun_ent_list[free_entry].app_tunnel, app_tunnel,
> -                      sizeof(struct rte_flow_tunnel));
> +               tun_ent_list[free_entry].app_tunnel =3D *app_tunnel;
>                 tun_ent_list[free_entry].ref_cnt =3D 1;
>                 rc =3D 1;
>         } else {
> --
> 2.47.2
>
Acked-by: Somnath Kotur <somnath.kotur@broadcom.com>

--0000000000008d3c70062dc0dae5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBHHWmg+5bYniSYhRQ8mf7A6UUea
1vQxPWIZUvHMTsgXMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDIxMDAyNTYyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBshTB+7zucrrSCzITfbOlqpcYmQ3h2eu4+ZXF4CdQ/VJXX
ZWwJftPtOH84b+P6EcR7+bvskqj0vvnKF/ZFGy954hYmv/RBVaCK6oC+IwPyGFMjZ6N6kFS2x7pQ
bzkQhQ3MXNaHad6frrzudCyReXDrB1z7aPqEE6GOv0CZZnzolBiXJSvddkrPLU9c9H4z8KN6KE40
CuCSZVCPWtlu8uLo9gC6UtAZdewyZY8z1I8CXjOg+nhbayaQ3E7VT7fmOV0W3NRlOC5zMFVJVCdD
geij4pFKmiIr6aSv5jKvYd6ZKK3YLvxA8Mrp/QPNVsBPNQcVtWsXfDwZ3kzF0Ao7VB9m
--0000000000008d3c70062dc0dae5--
