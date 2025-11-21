Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C9CFC29A
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 19:24:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C8F7402A1;
	Fri, 21 Nov 2025 20:24:54 +0100 (CET)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id CB4A240269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 20:24:52 +0100 (CET)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-3e2d1477b9cso1593891fac.2
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763753092; x=1764357892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=If2eGsTElr/EDhsRZHo3uLENcWpDmz7VrFUJN/7te9I=;
 b=BIj+NO7sZauhcerq0Vqrr1REdBWjNZm3Lfn++1WRG8ez5AB0/TKt4ZVYL0DXVfYPrE
 ME9BLoz1xFQ8+k46w08EguPvCjtHZ0lW5sGN6jD8hJsDPnflQ/V2T1NoSAknGxHCa+01
 z0MrjN6AC2phIvAviK7GY6VIkxBOMkmmeWcg3Tu7WxIFo1OrfVlPaqrkLzKMvj6sGwTW
 VkChjl1YZ7KHTOzUkcTCW4heFKtUx7Eqj124ZOLe6EFlSaLU/YXjMhJGbKXxlcelPcp+
 qc/wd23wirpL0khePS1gYl6LLkCZvDZTn81xM+BMtfNCnqzeFTVKQKXxmKyNwil1qs+y
 znsg==
X-Gm-Message-State: AOJu0Ywz9SUmVu/Aol8x94ElRa/kxguNWNZ0emv6FqTk3aHyg0CeQW3q
 pPLQTCU6aeGUIgS42G1jubZD9WpqELR3996HehXG5joOxTpeSz3LqCbjDLv0tNtV/gz/WGR1tUB
 NGr4igwpzLtrmcPEvBquzgfb3IU7Nb3dc8O/iTF8PkFI9BEV7LyAqpAcElZTfwPl3gmydRfzj+F
 BpUjBGANPn/wA9qrSJ+GXPPimdWQThpaxfasjW7FlOzi0xVq0zSp+HJwSUG5QZ5sk2J2QVSvk=
X-Gm-Gg: ASbGncuLENtk0bVfvuWErMIZD3dKSoljoLspIrsjsR+KhXIZPhgzkMh5kVWuwE0aTn1
 FqJRWvlceIxoLKK89870zAZkWJlSUdlTU+zaQ9vy95lvtM2uASSbjY6B509dXxDN4byHg02m0Bk
 Qc2DL7+UkWY+mU1KNKZssl69MjfmixEozI+syNRl0pSkI3POrfyQaohiqhYVqmOHRAnZjM7TbOX
 MZ61T4TA1coCsQsmBU5A56U79/Tb1r+S58X1+blHeD7YEsijvyBl4NN6Mmm3fRS7HfbOeFWnpW3
 3fJEFIKuUyv2fuUMPo9o2wOevlupblPIjxfTmJmmavtAoKCn+pNfv7/HhUpuJlgp5f3Kwz6SXNk
 BlutadYcmXMSWDB1iNjWPUUX6lK23f9razELeM3H9JBhJKwl2a3ucsBuKf3At9IRSOoD6KDYFOU
 sRFkuAdpZ+IDtfWftkBixa+vjKE3SekPF2+KY5ZxJ7dw4geQ==
X-Google-Smtp-Source: AGHT+IG75bTrCus9qtNHWEc2wb1rTfNuV+549bJD1XaTglxUntb/PCYKCnImjeKmiTgi+19C3jtpQBdvJubu
X-Received: by 2002:a05:6870:3c15:b0:31d:736d:ebdd with SMTP id
 586e51a60fabf-3ecbe30b540mr1841094fac.13.1763753091923; 
 Fri, 21 Nov 2025 11:24:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3ec9c342b28sm592401fac.8.2025.11.21.11.24.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Nov 2025 11:24:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8823f4666abso75537026d6.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1763753091; x=1764357891; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=If2eGsTElr/EDhsRZHo3uLENcWpDmz7VrFUJN/7te9I=;
 b=azud4pk8LKlSvODk3uCRIfi1E3QKHHsttyto1i3yIl7Wro9eW8mosnoYs9+uEl2iiq
 i45rjUqoTPV20hquL7e9bdOofshyv/TaItf2P+k+21kvrfftvcqBUEAFe2xlcH/9ugdo
 2huZeyBVUZA1uFtBwF+MshVyVayqW9TqHkDH8=
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id
 6a1803df08f44-8847c525de0mr49928136d6.42.1763753091095; 
 Fri, 21 Nov 2025 11:24:51 -0800 (PST)
X-Received: by 2002:a05:6214:226c:b0:87d:fc3e:6d9b with SMTP id
 6a1803df08f44-8847c525de0mr49927866d6.42.1763753090681; Fri, 21 Nov 2025
 11:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20251114185240.1363648-1-stephen@networkplumber.org>
In-Reply-To: <20251114185240.1363648-1-stephen@networkplumber.org>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Fri, 21 Nov 2025 11:24:33 -0800
X-Gm-Features: AWmQ_bnFlmxl5wv2BBT1AJUZ0Xaqm6DwwCdymNPpyOJLlfUm9EVUmQQwl5qjo8M
Message-ID: <CACZ4nhve0VGWbhxZ_f8NxG471Sjdd+Cfp0OcHcahN2Uqvik3rA@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: fix unintialized warning
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Somnath Kotur <somnath.kotur@broadcom.com>, 
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>, 
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>, 
 Mike Baucom <michael.baucom@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000007d090506441fc453"
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

--0000000000007d090506441fc453
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:52=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> With gcc-16 it inlines a lot more code and creates a warnings
> where it thinks it might be manipulating bits that are not set.
> It looks like this is because the bits in control word (cword)
> in theory could be larger than the variable. Should not
> be possible because wc_ctl_size_bits is only set to 3, 16, or 32
> but that happens outside of the scope of these functions.
>
> Resolve by adding bounds check which compiler sees and knows
> the loop will only see those bits.
>
> In function =E2=80=98ulp_bs_push_msb=E2=80=99,
>     inlined from =E2=80=98ulp_blob_push=E2=80=99 at ../drivers/net/bnxt/t=
f_ulp/ulp_utils.h:407:8,
>     inlined from =E2=80=98ulp_blob_push_32=E2=80=99 at ../drivers/net/bnx=
t/tf_ulp/ulp_utils.h:551:7,
>     inlined from =E2=80=98ulp_mapper_wc_tcam_tbl_dyn_post_process=E2=80=
=99 at ../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2487:9:
> ../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: =E2=80=98cword=E2=
=80=99 may be used uninitialized [-Wmaybe-uninitialized]
>   336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function =E2=80=98ulp_mapper_=
wc_tcam_tbl_dyn_post_process=E2=80=99:
> ../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2443:18: note: =E2=80=98cword=E2=
=80=99 declared here
>  2443 |         uint32_t cword, i, rc;
>       |                  ^~~~~
>
> Bugzilla ID: 1821
> Fixes: 3fe124d2536c ("net/bnxt: support Thor platform")
> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>

> ---
>  drivers/net/bnxt/tf_ulp/ulp_mapper.c     | 5 +++++
>  drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_u=
lp/ulp_mapper.c
> index 0ff952950b..960cdda311 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
> @@ -2446,6 +2446,11 @@ ulp_mapper_wc_tcam_tbl_dyn_post_process(struct bnx=
t_ulp_device_params *dparms,
>
>         slice_width =3D dparms->wc_slice_width;
>         clen =3D dparms->wc_ctl_size_bits;
> +       if (clen > 32) {
> +               BNXT_DRV_DBG(ERR, "Key size bits %d too large\n", clen);
> +               return -EINVAL;
> +       }
> +
>         max_slices =3D dparms->wc_max_slices;
>         blen =3D ulp_blob_data_len_get(key);
>
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/=
tf_ulp/ulp_mapper_tfc.c
> index f99698a1d8..2d89f10d5e 100644
> --- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
> +++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
> @@ -90,6 +90,10 @@ ulp_mapper_tfc_wc_tcam_post_process(struct bnxt_ulp_de=
vice_params *dparms,
>
>         slice_width =3D dparms->wc_slice_width;
>         clen =3D dparms->wc_ctl_size_bits;
> +       if (clen > 32) {
> +               BNXT_DRV_DBG(ERR, "Key size bits %d too large\n", clen);
> +               return -EINVAL;
> +       }
>         max_slices =3D dparms->wc_max_slices;
>         blen =3D ulp_blob_data_len_get(key);
>
> --
> 2.51.0
>

--0000000000007d090506441fc453
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
MYymAUVcWV0wVj6phKCeHUoRXxK4X8pFfsbz0Sjt+EMT/qE/zZE0/2EcCBES5X48iDmzTwTcJ+TD
NOvJwY7xRNwUvbI9EUViKMHPr+tQIeHsuDT0CXRwjzvZrNSssqegLdpnnV24YK5bUiTUw52wxWoh
QTlMtZHRCyQg3RQ6GIJ7KRdR/sPpJmnPBKbgwweDUNv6ZbCxcuTu5mhdtMT7TUSNjCi5aSKn85zv
Xg41ku+Wm1cAeXwZUeZagNjdHHsOFQD1uqLsCsbLsTV8WaqksE8CAwEAAaOCAd4wggHaMA4GA1Ud
DwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNy
dDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8E
OjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5j
cmwwJQYDVR0RBB4wHIEaYWppdC5raGFwYXJkZUBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFPJnigXvVxTA
07l8oe1CkMEkw+YLMA0GCSqGSIb3DQEBCwUAA4ICAQBE7rCtjYFJ7tog+ee/1HnzPN4L1J2asifX
LdXeYICQse0kNEfXvUo1ayItAbuJnklmWwlP7IYPQyOlP3mJ4OGjvjuJhGF5d2Eb9iFuO+JW6vwf
EosKt72uSd8homroli/RVma5W2tjKM7kU1HoSnz4rQV0YRWNH7OEzezNOZF7+aTJYJSaUXkK85/9
M1KYO/S8x9Pd2WRn39KIrw1g03sTjiTL/wpEiJNClL4GE/M3YZ6uXciSJX4au5UCWuV8gFtAV0ql
aU36K35Grrc/xmzg6EDqNEDG0A9oTEWwLCTCYfxg+jO2lvpHj6gV+IE31MpZYzlR6/bQSe7NVz0g
yDiC1bPtj2QVqpMvrEi5cmqpI/97cqbsK6Ud7xCvep6oYUJ2QS4RPw0slATdJjSwlb4Uk1Y+xR4b
6FbGm1N40N146szaI8aoV46hcI98/rWIr6kvmxy0wcoYx3U6kYkA/ywFqCXX0BgFNpZX5K8i64D4
E4nhwQjGDbUfMEJyAUr955c7lBXB87fotrW+90jSrpl4vK2qP4+W8ntJTX30iR3NmPyUhBkbnewo
O0GHGnKcLdmowdbU5+n3HjvCoMiKOYbENHxJxar2zM+cPZ3EORk4rAW1TBGLLeZg5Y+5ScQgc5aa
YbbIKKKsxmMaZkoB62zWnWrb2T5WPPLjYcFfjutmoDGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMC
QkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2
IFNNSU1FIENBIDIwMjMCDEkL1Rxtyl5iiSFALTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0B
CQQxIgQghdlivuC6ujgKx5wzoEdThufbAAyRr1y8ewAsNa4L+98wGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTIxMTkyNDUxWjBcBgkqhkiG9w0BCQ8xTzBNMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAoD8vnQZO1ikONjpqStlqsQHxvCeb
2DAzo92g8oB7EQHKp84NLXQ3Cex/3V85nkSMnkP0hoszDmpcCfSHeZOZxyDi/NwNOBnqB8dLnDXe
ilHIxaPElXLZezZIVBJtoAU3/N5Ii7eGrHwvxsPN/uQQedcn8PAobixjbtmPzPvACg3CFI9hphPt
GpPuPJFCF82ADejb8YGshCgcnowVeKVQXEpX4pwoxWUQh7zngYg+HPAENiTSK4WfZ4c9nlDyK2P+
+EbuUjVxBBL2q2hdUlCOCBbMTYGPxF0+Qul94JK2jLhxTAS/ElAxs/Qqzsonme4fvU6ydNqOn/a1
/adWul7AHg==
--0000000000007d090506441fc453--
