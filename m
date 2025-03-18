Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA03FC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Mar 2025 17:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 34E0C402E1;
	Tue, 18 Mar 2025 18:42:36 +0100 (CET)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51]) by mails.dpdk.org (Postfix) with ESMTP id A5031402D1
 for <dev@dpdk.org>; Tue, 18 Mar 2025 18:42:34 +0100 (CET)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-6e8f43c1fa0so59871786d6.3
 for <dev@dpdk.org>; Tue, 18 Mar 2025 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1742319754; x=1742924554; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8h6TMuz/VxSzODD+Rgsh4aJ+8HPSKU16cumQqn3BsYw=;
 b=IklinN/DNUqUNHIifnVH1+i0s9lMEr9CMGMBY+Aog+SXapwN7xHpnFpwU3XoP8q/xn
 HM0KVm6NcoP7DOiQ/drK8KSRY15mHcDmsrepKUG+W14Ldo0gDQAc1PmA0C3jQxhFtc2h
 Y1bXbWFrnXA1ZM0dEeoxpVowDiaq1eD1uW9SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742319754; x=1742924554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8h6TMuz/VxSzODD+Rgsh4aJ+8HPSKU16cumQqn3BsYw=;
 b=IW+OitBg4u+CndzREVc78oU1KR+e+J5vZYxZBrdC6eMyoOShIZgf+HaGTcABuCAwZQ
 yJnbqkwmabuTCAw9zl37dSPKKCHo0kavSYcS7Xq843hx6zWp6pPi/BDo77E1X5DIRHQQ
 ArxfoQhwoSpAq1u4ERWPpy+seK9a3WUSA+LThczqkfDNLboj6R3tqmmWhFvNGW18ezYm
 tRABK0mW3J8Qbq/kQNk9Zgqs1J8sfOqAelfGWWFoLxcr7z5MS5Ww4K1z49lWAgfrvPvH
 lVzI03YvTtmdU2qOXdXRSgje1hzifw83bGad9taPbwu2jdI5wY/gcza8T+uOnyUEnHK2
 vodQ==
X-Gm-Message-State: AOJu0YxzqY9llWhPyqzJXiorH459BlonXzhcq66JudRPkJCE1TCuCywl
 pMc2a2GVSE5PmRTKIUs7xBerUtcS8NbiWHG0xwQvKn3o5nvSPkUvDPPK484y++IBtVBG81A7wY5
 M04FgaceqsD8OLISf3Uh7/D0NBcxa4+G7d2MC
X-Gm-Gg: ASbGncvncCysmVEFKnxb7L3rr58kOuivJ79oe5k+EciMudBnwKWYc+czdeo+1hj+rLu
 RT+AHZxIsZkausvIkhmG4PvfLXfsMZcltLYxMPVuoWwiMqzUO1+FDOQ4PSY9c5hPz84hrV6SiKZ
 4CVUDnEjksVsgiWZ452rl5xyam0ZY=
X-Google-Smtp-Source: AGHT+IF/dl5VR/k1Cu9P1oq6Xiwf8ghML+tHAzQY9yulvo9ntjq+u4XCWz3AX3/wO8Kv6KrFgXO45QbJ/BCzyuiPZdw=
X-Received: by 2002:a05:6214:194c:b0:6d8:846b:cd8d with SMTP id
 6a1803df08f44-6eaeaa9afcbmr251178936d6.30.1742319753968; Tue, 18 Mar 2025
 10:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250318173505.314529-1-bruce.richardson@intel.com>
 <20250318173505.314529-5-bruce.richardson@intel.com>
In-Reply-To: <20250318173505.314529-5-bruce.richardson@intel.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Tue, 18 Mar 2025 10:42:16 -0700
X-Gm-Features: AQ5f1Jrf2tCBuwMwPq0KdVvCMJLkRHy02m9Nv9lAftwquYkM2OWujUyjYgneD04
Message-ID: <CACZ4nhvqY1JQbfX1Z+y2hUqm2BHydG76yZOm6AZawLvnqxvESw@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] drivers/net: remove AVX2 build-time define
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, 
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Vamsi Attunuru <vattunuru@marvell.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000000aa34c0630a16eb2"
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

--0000000000000aa34c0630a16eb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:35=E2=80=AFAM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> Since all supported compilers can generate AVX2 code, we will always
> enable the build of the AVX2 files on x86. This means that
> CC_AVX2_SUPPORT is always true on x86, so it can be removed and a
> regular "#ifdef RTE_ARCH_x86" used in its place.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
For bnxt:
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> ---
>  drivers/net/bnxt/bnxt_ethdev.c        | 2 --
>  drivers/net/octeon_ep/meson.build     | 1 -
>  drivers/net/octeon_ep/otx_ep_ethdev.c | 4 ----
>  3 files changed, 7 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethde=
v.c
> index 144d4377bd..a318604c20 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -3238,8 +3238,6 @@ static const struct {
>  #if defined(RTE_ARCH_X86)
>         {bnxt_crx_pkts_vec,             "Vector SSE"},
>         {bnxt_recv_pkts_vec,            "Vector SSE"},
> -#endif
> -#if defined(RTE_ARCH_X86) && defined(CC_AVX2_SUPPORT)
>         {bnxt_crx_pkts_vec_avx2,        "Vector AVX2"},
>         {bnxt_recv_pkts_vec_avx2,       "Vector AVX2"},
>  #endif
> diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/me=
son.build
> index 9bf4627894..a4a7663d1d 100644
> --- a/drivers/net/octeon_ep/meson.build
> +++ b/drivers/net/octeon_ep/meson.build
> @@ -15,7 +15,6 @@ sources =3D files(
>
>  if arch_subdir =3D=3D 'x86'
>      sources +=3D files('cnxk_ep_rx_sse.c')
> -    cflags +=3D ['-DCC_AVX2_SUPPORT']
>      sources_avx2 =3D files('cnxk_ep_rx_avx.c')
>  endif
>
> diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_e=
p/otx_ep_ethdev.c
> index 8b14734b0c..10f2f8a2e0 100644
> --- a/drivers/net/octeon_ep/otx_ep_ethdev.c
> +++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
> @@ -91,11 +91,9 @@ otx_ep_set_rx_func(struct rte_eth_dev *eth_dev)
>                 eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts;
>  #ifdef RTE_ARCH_X86
>                 eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts_sse;
> -#ifdef CC_AVX2_SUPPORT
>                 if (rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_2=
56 &&
>                     rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1)
>                         eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts_avx;
> -#endif
>  #elif defined(RTE_ARCH_ARM64)
>                 eth_dev->rx_pkt_burst =3D &cnxk_ep_recv_pkts_neon;
>  #endif
> @@ -105,11 +103,9 @@ otx_ep_set_rx_func(struct rte_eth_dev *eth_dev)
>                 eth_dev->rx_pkt_burst =3D &cn9k_ep_recv_pkts;
>  #ifdef RTE_ARCH_X86
>                 eth_dev->rx_pkt_burst =3D &cn9k_ep_recv_pkts_sse;
> -#ifdef CC_AVX2_SUPPORT
>                 if (rte_vect_get_max_simd_bitwidth() >=3D RTE_VECT_SIMD_2=
56 &&
>                     rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) =3D=3D 1)
>                         eth_dev->rx_pkt_burst =3D &cn9k_ep_recv_pkts_avx;
> -#endif
>  #elif defined(RTE_ARCH_ARM64)
>                 eth_dev->rx_pkt_burst =3D &cn9k_ep_recv_pkts_neon;
>  #endif
> --
> 2.43.0
>

--0000000000000aa34c0630a16eb2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
pZEyqKnwS1lKCzjX7mV5W955rFsFxChdAKfw0HilwtqdY24mhy62+GeaEkD0gYIj1tCmw9gnQToc
K+0s7xEunfR9pBrzmOwS3OQbcP0nJ8SmQ8R+reroH6LYuFpaqK1rgQIDAQABo4IB2zCCAdcwDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAlBgNVHREEHjAcgRphaml0LmtoYXBhcmRlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUbrcTuh0mr2qP
xYdtyDgFeRIiE/gwDQYJKoZIhvcNAQELBQADggEBALrc1TljKrDhXicOaZlzIQyqOEkKAZ324i8X
OwzA0n2EcPGmMZvgARurvanSLD3mLeeuyq1feCcjfGM1CJFh4+EY7EkbFbpVPOIdstSBhbnAJnOl
aC/q0wTndKoC/xXBhXOZB8YL/Zq4ZclQLMUO6xi/fFRyHviI5/IrosdrpniXFJ9ukJoOXtvdrEF+
KlMYg/Deg9xo3wddCqQIsztHSkR4XaANdn+dbLRQpctZ13BY1lim4uz5bYn3M0IxyZWkQ1JuPHCK
aRJv0SfR88PoI4RB7NCEHqFwARTj1KvFPQi8pK/YISFydZYbZrxQdyWDidqm4wSuJfpE6i0cWvCd
u50xggJgMIICXAIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwM2Vrj
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIGnq7S5CDJvKgou8H4XE
wxC6c9BRcoXUUAiSj/f8ICb3MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDMxODE3NDIzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAFh/drBoPt0+it+EKy7uvZY8OMTaGgncK9Vg4H3x/lz5kkpU4o0/+Bwe
IlKETU24+MASwrGXc2u2o1viJoyOt26Re3HcWrCUXB7xxahCwiNKLXIZhqHBu/6mZoO6ovfSXurG
aXWNKqN/VFrZS25YLOvNLbd3hyV8aa87TdC4EU5S7gZN8zkHEK5OD5Lh42N1F5ah20EE0PCVGodJ
PuJInbJnmC3MKTFlzp5XU4HIQM3lc0L+Rf3K/GivhYtOL5WBXFDwh5CeLX/GzeElp1XNA0Ctt1v0
xyAGAyJ8GitkYpF50P4HJZiB66TWz33vnwy69h3Kvn4PJQzs9ari6hVGXGg=
--0000000000000aa34c0630a16eb2--
