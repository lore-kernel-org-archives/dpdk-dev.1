Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847EFC0219B
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 18:47:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78CE4402BC;
	Thu,  6 Feb 2025 19:47:19 +0100 (CET)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 259014026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 19:47:18 +0100 (CET)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-467a1d43821so20839051cf.1
 for <dev@dpdk.org>; Thu, 06 Feb 2025 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738867637; x=1739472437; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QX8nM30ckL7UTjMqfPqQigS03nKaDY4d0sqpjk8oztU=;
 b=CQZlYgiggEwbKJf+nYkYtp0Z2YZjhqNdV3Nmvbt6yxQ9a+Qri/5BYNJQL4Z8xcwkfL
 F3x5w7vH8zdcZ8QWu+kWEU6RnpgldAXFFgERxJJZ3Rg2xtCyDB2Fi8qEvGTyferHimUM
 CJlQTAS4gR6An2px4Su+565SGbydVt0V47oM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738867637; x=1739472437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QX8nM30ckL7UTjMqfPqQigS03nKaDY4d0sqpjk8oztU=;
 b=fdBEwD+BGlSrStK++Xg2CAKNIfxwBIMqinV9YWa9YvasFVIJ9bA8oPkEZ2ZU4c9CZ/
 fa9D0swOf2LAVO7MqOW+4bHEPH39lDCDOT8wPVP6iShri3n78qx84g34DMfgrFfNFriI
 ErCf0jmAVkZ5LQ54dPlS7qd7mlJfQ/tSsaOvr946Wjv6Mwz1cYtmNhkhkKPUvrUv2cti
 9xJK2qznQ2jW5/+I/F4Mdfhvw41lVksysVuC2HjO4OdsmXy7/ohYXz7pTSnQ6Y1Mf21l
 nLuyaMOpmoQ7GZ5rb7bEIqHmJ1onAw/Wbc6aYtIz3qqZvY9+BICynGVYgbps5tVWoxuN
 h3CA==
X-Gm-Message-State: AOJu0Yw/09tFCiTIjAYMMP8ZfoOEb3n7nQ/r1POux2K3gs9i2JGqhrS8
 QETRzfmCGuQLI4vfpz9WM7gXe2x/g2OAP2zfVpMPElXtHM5z1fDkYdkkU+92BD5em7dRBI8pT/A
 XiQ2kt7vrKk5aF4pC/4+qvWdcuphf4QheM6wd603wNDdumiS/Uw==
X-Gm-Gg: ASbGnct4Z6CYNT4pvWjQA0yXwbNF8T6pxc1OCUvWU81Zl0z8mDhvwQ1OaL+YUKdI9Zk
 zpVty/qAEauEl9mTKFbl8ureCVJybhA19gFeYA25ibTln4Z/0J+baFHO3Hbzr0GtGCrCVDAtTgA
 ==
X-Google-Smtp-Source: AGHT+IGPgJ8liDVAwoKosMdSznoiNGinzoUgRLUi3t6YveJsjNAUuwrzVmYxyd0i/b/1cL9GDB58BtmsJNyH7vPiPGw=
X-Received: by 2002:a05:6214:ace:b0:6e4:244b:b6bd with SMTP id
 6a1803df08f44-6e439b2a82cmr59174026d6.12.1738867637037; Thu, 06 Feb 2025
 10:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Thu, 6 Feb 2025 10:47:00 -0800
X-Gm-Features: AWEUYZkQVFxVMlnsCNGAmaBuFzXkWEoJ2yzdnVujPB5B2PYhX0syaJceES2UzBc
Message-ID: <CACZ4nhuM4nED67mapQoa3Yaf6MVAdZiNE1eVC0UKvAMm-1exfg@mail.gmail.com>
Subject: Re: [PATCH 00/11] bnxt patch set
To: dev@dpdk.org
Cc: thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000d6af12062d7dab07"
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

--000000000000d6af12062d7dab07
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 9:20=E2=80=AFAM Ajit Khaparde <ajit.khaparde@broadco=
m.com> wrote:
>
> Patchset with bug fixes for bnxt PMD.
> Also addresses various Coverity issues reported in the recent
> Coverity scan.
>
> Please apply.
Patchset applied to dpdk-next-net-brcm subtree. Thanks

>
> Ajit Khaparde (4):
>   net/bnxt: disable TruFlow if compressed CQE is set
>   net/bnxt: simplify check for CQE mode
>   net/bnxt: fix Rx handler
>   net/bnxt: fix burst handler initialization
>
> Peter Spreadborough (6):
>   net/bnxt: address coverity deadcode issue
>   net/bnxt: address coverity checked return issues
>   net/bnxt: address coverity overflow issues
>   net/bnxt: address coverity integer overflow issues
>   net/bnxt: address coverity uninitialized variables issues
>   net/bnxt: address coverity control flow issues
>
> Sangtani Parag Satishbhai (1):
>   net/bnxt/truFlow: Fix seg fault when rep are re-attached
>
>  drivers/net/bnxt/bnxt.h                       |   4 -
>  drivers/net/bnxt/bnxt_ethdev.c                |  31 ++--
>  drivers/net/bnxt/bnxt_hwrm.c                  |   2 +-
>  drivers/net/bnxt/bnxt_rxr.c                   |  16 +-
>  .../hcapi/cfa_v3/bld/p70/cfa_bld_p70_mpc.c    |  90 +++++------
>  .../p70/host/cfa_bld_p70_host_mpc_wrapper.c   | 150 +++++++++---------
>  drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     |   6 +-
>  drivers/net/bnxt/tf_core/v3/tfc_em.c          |   1 +
>  drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c   |   2 +-
>  drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h      |   2 +-
>  drivers/net/bnxt/tf_ulp/ulp_mapper.c          |  10 +-
>  drivers/net/bnxt/tf_ulp/ulp_rte_parser.c      |   8 +-
>  drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c          |   1 +
>  13 files changed, 174 insertions(+), 149 deletions(-)
>
> --
> 2.39.5 (Apple Git-154)
>

--000000000000d6af12062d7dab07
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
u50xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwM2Vrj
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILlb6x6OZJi82kucMUfh
TyVyqqfoZgFLpxiYVujns/ZVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDIwNjE4NDcxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCVb6btYE99GVD1sylon9AoOpABubWcRh4Yl49f
afExlsbD085h4iObL3fjBNeRMEnKSUa5K9qxLxrUglDTtXFUHjGE/jgGqglmpMnss55TnPZpgQ2r
MSD85gk6cNerp+zT2KWAeCii+nfCYTc+GfGqKOoaufJQJrmjibRpX+ZjAqqGs7HO3sbro1yZXQY0
VjCuP3NGzQOaQEWk1SgZpuICVmDaRVhqe6Awc1N/c4YgaXQGlRlYQGZzZ7Dg3jVZh6DR7GbOrghh
1FKD/GXkztY7kXazBL5shgOJFgHf7La5DhVI16QmjcKF6Gejy2QNy/coM8QMcOVm9T8+ZAgLt/9h
--000000000000d6af12062d7dab07--
