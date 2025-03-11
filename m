Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BCBC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 17:11:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8C8540263;
	Tue, 11 Mar 2025 18:11:19 +0100 (CET)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 18AC34014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 18:11:19 +0100 (CET)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-476977848c4so16352671cf.1
 for <dev@dpdk.org>; Tue, 11 Mar 2025 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1741713078; x=1742317878; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zkWewzwjd5C2cUtMQOzJXqUAnNbEWCARet4mt34ZlzM=;
 b=Rk55JtOEHvpGWSJUn7rcnR1dleL8zxMBOD/4ieXSMUNWR6/HlUifMuphs5JeOes3/5
 qDFJmwO/cWVyAVdAn4LeC1WwbkB9kTPrD7Jw06KpkK7CvxW9cVCI04ty8+vZBzRUfPeN
 BNGNjidpayujydqvwSPZhS7txZ9cjzW6se7dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741713078; x=1742317878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zkWewzwjd5C2cUtMQOzJXqUAnNbEWCARet4mt34ZlzM=;
 b=CytGSFHn5ywdP5792oa51R+MvgXVjeji0Aa1nH5QlpChulTArwcNZPpkQW+fkAo2C3
 A16gPTF5T0+W5gO0Y74UhkVlbBGVhXcA+xGPJt7JqROlzgPTRMIoUXX/1aCkj9LrmAjq
 8BeNFSXoek/Pnc9L+AUAFbYvXvAwCnLq7A8ECcIdSFoatdf3GJADRF+XnLPN8H/6ED17
 ugOBdjraa7pKSruFhA4azzeEwsxXEWJ7nCiuejwOUvlOutVJ4eOEfGw86qI2/rIaDNMG
 q6BDO9/RQMN1pCqeEf2G9n9jJU1vDNeOpQRQJ8fjb1kh2+IgpPElSI29amvY/xoNJMqb
 Mt4Q==
X-Gm-Message-State: AOJu0Yxew5WYYGMYN/Da5tG9XOC0bZp2ogx8wXzoAsw/s10MDbWH2LxA
 sCJRwdEQsgMIkuWfYhBioiHu38MrI1htd/S7iFHBFfKbptnm3wtWZipReOa82T05LOq1yRT+OkU
 QaI3X+39HrcLDTyIC5dei0oJ6/6tels63JO1f+TUdPtmnTQJZVQ==
X-Gm-Gg: ASbGnctNJ7TLoFTT97GNodfaFNINMNhmpmZ0TRuS3JMQGZne40xzjnRRkgH/vnpWae0
 a/PL/cCOpXHtu2Gko11FEwd1KQHut6Fx2UWFQm8+qVMukRRpzLUvBRl1VNmaJW2XZkYlSHevTWb
 9nhTmspxC2biQhnKiufohxkfWoGwg9V8OexnEN8g==
X-Google-Smtp-Source: AGHT+IFR33mYSPD8XZXmygK7Qb8HRpoBvh4WSnvlV6T2cI6SFsfBSXmX8g7nMiiWMT/pSzN8hXYHLZ7/jEVpiBt9P8w=
X-Received: by 2002:a05:6214:20e8:b0:6e8:fee2:aae6 with SMTP id
 6a1803df08f44-6e90068cba1mr215163286d6.41.1741713078252; Tue, 11 Mar 2025
 10:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
In-Reply-To: <20250310210132.48829-1-ajit.khaparde@broadcom.com>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Tue, 11 Mar 2025 10:11:00 -0700
X-Gm-Features: AQ5f1JrinK3xw-QEZckqqNRXasqVCUy9W_-sSIFbAO3IEk7k_vdFUTvJ_RElQNs
Message-ID: <CACZ4nhseSNxteFjmZVFuCVFNaD5ARKayC+5jKUjOqzr1F=8aeg@mail.gmail.com>
Subject: Re: [PATCH 0/2] bxnt fixes
To: dev@dpdk.org
Cc: thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000058e3f10630142dc9"
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

--00000000000058e3f10630142dc9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 2:01=E2=80=AFPM Ajit Khaparde
<ajit.khaparde@broadcom.com> wrote:
>
> These patches address a couple of issues in the BNXT PMD.
> Please apply.

Merged in dpdk-next-net-brcm. Thanks
>
> Ajit Khaparde (2):
>   net/bnxt: configure burst threshold based on speed
>   net/bnxt: fix epoch bit calculation
>
>  drivers/net/bnxt/bnxt_ethdev.c          | 20 ++++++++++++++++++++
>  drivers/net/bnxt/bnxt_ring.h            | 19 +++++++++++++++++++
>  drivers/net/bnxt/bnxt_rxq.c             |  1 +
>  drivers/net/bnxt/bnxt_rxq.h             |  2 ++
>  drivers/net/bnxt/bnxt_rxr.c             |  4 ++++
>  drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   | 18 ++++++++++--------
>  drivers/net/bnxt/bnxt_rxtx_vec_common.h | 11 +++++------
>  drivers/net/bnxt/bnxt_rxtx_vec_neon.c   |  9 +++++----
>  drivers/net/bnxt/bnxt_rxtx_vec_sse.c    | 18 ++++++++++--------
>  9 files changed, 76 insertions(+), 26 deletions(-)
>
> --
> 2.39.5 (Apple Git-154)
>

--00000000000058e3f10630142dc9
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
4nZK0WWosNswDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIMD0/HEDhAF+1qgjVGkD
vwe8U12DWyJcgMD7jrOYAWO4MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTI1MDMxMTE3MTExOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0G
CSqGSIb3DQEBAQUABIIBAA5PtqDi5SpUQo0FtxOejGI40uynbZspW9xOgRsinPUQdxQGfoQkWMHb
+A6P4K+vSFxP5IwwO1BliefF+bXLjAYUKIGiZ4M3oFXydnt4CoiE6RYWMXooeRHlPd7Fcod+8WqR
sPYgT/hxL7/TGBnXYNbnzJuPScs96YWtr8ujL07GAYaT+6YULpxMhADUs2x+6ZnglZmAfxq1UdGm
qk876mbf4O/FzVKwAN8XfAzf96sUUCvm272B1fcEcDE1AYnqQWjaXx+tSTU4vQOYFsPR/Z94ShoT
Fl33a6dGI/A4V2kjj0KtUISjHbKKmkA1YvRB1KGyoW2OgnEncs0wOhjBJFY=
--00000000000058e3f10630142dc9--
