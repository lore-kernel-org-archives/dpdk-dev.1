Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57DDC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 19:38:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A05140E2B;
	Mon, 21 Sep 2026 21:38:25 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 9109140B94
 for <dev@dpdk.org>; Mon, 21 Sep 2026 21:38:24 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so802118a91.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790019503; x=1790624303;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uU0jjVAlVCgthjs/7vbXL6Y/sIyhN2RPsil/Kb2+p9I=;
 b=TY4eQCJpolIw8nZrzrWWefu2RZm6v1ls9FE4MF0S/wRtEO/rMQmyPGf2EOV7X9Lan3
 cycfm8+Eg5VnnmxieypDeLqdLIKgkPvNJttG9KwdrHCAhT6mS/QxCht7Dik7Nnmb60I1
 ZtIfvKtv7Edebz4qPubVzATkwo4o7DALS1dkp0NU9jVrSsTf7EebaLXyeelGgoJkqiFP
 0pHvxvvLQBZZ6UF1dbNlO2huGrm5uxtuWD9eRvflDDzQPijNDGvH2IRuUIAiGNoxRoGM
 nv9yaQEiHDoXs38jKKOdq5RNsD4haX/8volAztBASZA5Wac27vLuv5Xt8YP0MIyIsmiT
 dW8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDhiKS9ZwoquDjRmE6qFscK5BVG65VBiubqqqeF9O7ns04WeRpZPEyq5lHOGadjslV2xs=@dpdk.org
X-Gm-Message-State: AFuF++mvoHoYlNvpWb3pxrp/5UUZSrtK0xBI2KofUoGNUFliqK9kfjhq
 j6frkntz+P28z+8ZdF9+lV3xTK1CEha60tujlpKmZEXHsHyIg5sH0f6mjN47nMryfE+8TrILKXH
 dPPPnaRxqAo8147e2aRdBcZoNSQ5YDX21cp8FYOwwSzsxoyyc0iC7YCS0FqcJ1YZR/6JDW1Z7hQ
 rwLBezO8Gem2+j98ajCXwKJIzAQepVHuIbMhYV1LbF0xH0XJ5ZEXL7IkiNWJY5iXLBYxEU1DIMj
 hcuDA==
X-Gm-Gg: AYBFou2JsCBuE1ohKcFFmZ0Kh3THjbRmGqMUzMTiWOfMiA7iTZbOXaaNH+TWTO9xYH7
 L/MPciPAPTrRmF4Iwf2Xvu4g7SG0cir6HeGb4geMiHQLRqroTUanAZS6Pmlacwv1WUhXgclT6ak
 kAcltQlom12uJhehuDg/fkrEvmhv4FzRVQ1kTs14LOW1lnDTtO/ocVIwCpWulB/YRfg5NdgD1iy
 Fdp6Dvg7mxYgeBgeO7xOs8rkIfluaG2mLVsBZq+9ddk+x1UIw5ewCeNLYRvYDIfZJGhWl+02v3V
 GA+/8w1rXCxlsvE+58QL+HBonI2N5RqAz64W6kEw2nnEYRJr1hxSHlFAawAt9q/jPCKP5S7J0mH
 h+FGnH/6Dfx3q2i9TEEProysgZgDZy6R1PLHo1F1wN3WfdpdQoOWqHpyE3eRW+KAeMIUkpl70Pv
 sXO1YztTF6GT4/Q4NzPQSLowD4N6Jm7lveaFfIPXj3VAw=
X-Received: by 2002:a17:90b:17cc:b0:39e:135e:130e with SMTP id
 98e67ed59e1d1-39e54af6a0emr17475073a91.3.1790019502761; 
 Mon, 21 Sep 2026 12:38:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a06947ce13sm124280a91.0.2026.09.21.12.38.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2026 12:38:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6a178080182so4495304a12.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790019500; x=1790624300; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uU0jjVAlVCgthjs/7vbXL6Y/sIyhN2RPsil/Kb2+p9I=;
 b=DsXMMWBt6nZF3jGYKyKY4IEHtD950KWjLmSLZO4eq8+NODy8ED8epd888HUbPROKE1
 7MRzfG6Em2UahWqTGu9NxahuEMF8U+G9Y/P9okzi1KXp2OkyvsxSA01RLYIjxJjtNz6Z
 rcX4uB25ynxssijTDCt99TQWzusNA4RvtCoew=
X-Forwarded-Encrypted: i=1;
 AKwUvBz/xegG1qNJSJM8OQfhjteovwric2usMK9jaa8PwZX0NiVwTc7HcJ2E9JmYCreLsZyWKww=@dpdk.org
X-Received: by 2002:a05:6402:4549:b0:6a9:aa8b:2e30 with SMTP id
 4fb4d7f45d1cf-6aa53cd7134mr7700070a12.33.1790019500527; 
 Mon, 21 Sep 2026 12:38:20 -0700 (PDT)
X-Received: by 2002:a05:6402:4549:b0:6a9:aa8b:2e30 with SMTP id
 4fb4d7f45d1cf-6aa53cd7134mr7700057a12.33.1790019500131; Mon, 21 Sep 2026
 12:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260915090919.431388-1-Evgeny.Sokolov@infotecs.ru>
In-Reply-To: <20260915090919.431388-1-Evgeny.Sokolov@infotecs.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 21 Sep 2026 15:38:01 -0400
X-Gm-Features: AcwNN1VcAApSDFy7qHhC1fWcXo-JuakKYXyLXT3_D8pyNlnpHaVJ6yGqeUp6MI0
Message-ID: <CA+BST0m5oORRg67AJ=M2LJtcSKZasvA7dbSiFcYGFUQgCU7PYQ@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: simplify NVGRE pointer validation
To: Evgeny Sokolov <Evgeny.Sokolov@infotecs.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000007cb92f065c0364f1"
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

--0000000000007cb92f065c0364f1
Content-Type: multipart/alternative; boundary="00000000000072809c065c03647f"

--00000000000072809c065c03647f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 5:09=E2=80=AFAM Evgeny Sokolov <Evgeny.Sokolov@info=
tecs.ru>
wrote:

> From: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
>
> Previous validation guarantees that nvgre_spec and nvgre_mask are
> both non-NULL when this code is reached.
>
> Remove the redundant condition and execute the enclosed code
> directly.
>
> Signed-off-by: Sokolov Evgeny <Evgeny.Sokolov@infotecs.ru>
> Cc: stable@dpdk.org
> ---
>  drivers/net/bnxt/bnxt_flow.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
> index a2e590540b..4a38c036de 100644
> --- a/drivers/net/bnxt/bnxt_flow.c
> +++ b/drivers/net/bnxt/bnxt_flow.c
> @@ -632,26 +632,24 @@ bnxt_validate_and_parse_flow_type(const struct
> rte_flow_attr *attr,
>                                 return -rte_errno;
>                         }
>
> -                       if (nvgre_spec && nvgre_mask) {
> -                               tni_masked =3D
> -                                       !!memcmp(nvgre_mask->tni, tni_mas=
k,
> -                                                RTE_DIM(tni_mask));
> -                               if (tni_masked) {
> -                                       rte_flow_error_set
> -                                               (error,
> -                                                EINVAL,
> -                                                RTE_FLOW_ERROR_TYPE_ITEM=
,
> -                                                item,
> -                                                "Invalid TNI mask");
> -                                       return -rte_errno;
> -                               }
> -                               rte_memcpy(((uint8_t *)&tenant_id_be + 1)=
,
> -                                          nvgre_spec->tni, 3);
> -                               filter->vni =3D
> -                                       rte_be_to_cpu_32(tenant_id_be);
> -                               filter->tunnel_type =3D
> -
> CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE;
> +                       tni_masked =3D
> +                               !!memcmp(nvgre_mask->tni, tni_mask,
> +                                        RTE_DIM(tni_mask));
> +                       if (tni_masked) {
> +                               rte_flow_error_set
> +                                       (error,
> +                                        EINVAL,
> +                                        RTE_FLOW_ERROR_TYPE_ITEM,
> +                                        item,
> +                                        "Invalid TNI mask");
> +                               return -rte_errno;
>                         }
> +                       rte_memcpy(((uint8_t *)&tenant_id_be + 1),
> +                                  nvgre_spec->tni, 3);
> +                       filter->vni =3D
> +                               rte_be_to_cpu_32(tenant_id_be);
> +                       filter->tunnel_type =3D
> +                        CFA_NTUPLE_FILTER_ALLOC_REQ_TUNNEL_TYPE_NVGRE;
>                         break;
>
>                 case RTE_FLOW_ITEM_TYPE_GRE:
> --

Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.30.2
>
>

--00000000000072809c065c03647f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUdWUsIFNlcCAxNSwgMjAyNiBhdCA1OjA54oCvQU0gRXZnZW55IFNva29s
b3YgJmx0OzxhIGhyZWY9Im1haWx0bzpFdmdlbnkuU29rb2xvdkBpbmZvdGVjcy5ydSI+RXZnZW55
LlNva29sb3ZAaW5mb3RlY3MucnU8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUg
Y2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRl
ci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkZyb206
IFNva29sb3YgRXZnZW55ICZsdDs8YSBocmVmPSJtYWlsdG86RXZnZW55LlNva29sb3ZAaW5mb3Rl
Y3MucnUiIHRhcmdldD0iX2JsYW5rIj5FdmdlbnkuU29rb2xvdkBpbmZvdGVjcy5ydTwvYT4mZ3Q7
PGJyPg0KPGJyPg0KUHJldmlvdXMgdmFsaWRhdGlvbiBndWFyYW50ZWVzIHRoYXQgbnZncmVfc3Bl
YyBhbmQgbnZncmVfbWFzayBhcmU8YnI+DQpib3RoIG5vbi1OVUxMIHdoZW4gdGhpcyBjb2RlIGlz
IHJlYWNoZWQuPGJyPg0KPGJyPg0KUmVtb3ZlIHRoZSByZWR1bmRhbnQgY29uZGl0aW9uIGFuZCBl
eGVjdXRlIHRoZSBlbmNsb3NlZCBjb2RlPGJyPg0KZGlyZWN0bHkuPGJyPg0KPGJyPg0KU2lnbmVk
LW9mZi1ieTogU29rb2xvdiBFdmdlbnkgJmx0OzxhIGhyZWY9Im1haWx0bzpFdmdlbnkuU29rb2xv
dkBpbmZvdGVjcy5ydSIgdGFyZ2V0PSJfYmxhbmsiPkV2Z2VueS5Tb2tvbG92QGluZm90ZWNzLnJ1
PC9hPiZndDs8YnI+DQpDYzogPGEgaHJlZj0ibWFpbHRvOnN0YWJsZUBkcGRrLm9yZyIgdGFyZ2V0
PSJfYmxhbmsiPnN0YWJsZUBkcGRrLm9yZzwvYT48YnI+DQotLS08YnI+DQrCoGRyaXZlcnMvbmV0
L2JueHQvYm54dF9mbG93LmMgfCAzNiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS08YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvYm54dC9ibnh0X2Zsb3cuYyBi
L2RyaXZlcnMvbmV0L2JueHQvYm54dF9mbG93LmM8YnI+DQppbmRleCBhMmU1OTA1NDBiLi40YTM4
YzAzNmRlIDEwMDY0NDxicj4NCi0tLSBhL2RyaXZlcnMvbmV0L2JueHQvYm54dF9mbG93LmM8YnI+
DQorKysgYi9kcml2ZXJzL25ldC9ibnh0L2JueHRfZmxvdy5jPGJyPg0KQEAgLTYzMiwyNiArNjMy
LDI0IEBAIGJueHRfdmFsaWRhdGVfYW5kX3BhcnNlX2Zsb3dfdHlwZShjb25zdCBzdHJ1Y3QgcnRl
X2Zsb3dfYXR0ciAqYXR0ciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm4gLXJ0ZV9lcnJubzs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKG52Z3JlX3NwZWMgJmFtcDsmYW1wOyBudmdyZV9tYXNrKSB7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdG5pX21hc2tlZCA9
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgISFtZW1jbXAobnZncmVfbWFzay0mZ3Q7dG5pLCB0bmlfbWFzayw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgUlRFX0RJTSh0bmlfbWFzaykpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICh0bmlfbWFza2VkKSB7PGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRl
X2Zsb3dfZXJyb3Jfc2V0PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKGVycm9yLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBFSU5WQUwsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJURV9GTE9XX0VSUk9SX1RZUEVf
SVRFTSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaXRlbSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1
b3Q7SW52YWxpZCBUTkkgbWFzayZxdW90Oyk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1ydGVfZXJybm87PGJy
Pg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9tZW1j
cHkoKCh1aW50OF90ICopJmFtcDt0ZW5hbnRfaWRfYmUgKyAxKSw8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbnZncmVf
c3BlYy0mZ3Q7dG5pLCAzKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBmaWx0ZXItJmd0O3ZuaSA9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2JlX3RvX2NwdV8zMih0
ZW5hbnRfaWRfYmUpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGZpbHRlci0mZ3Q7dHVubmVsX3R5cGUgPTxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBDRkFfTlRVUExFX0ZJTFRFUl9BTExPQ19S
RVFfVFVOTkVMX1RZUEVfTlZHUkU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgdG5pX21hc2tlZCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgISFtZW1jbXAobnZncmVfbWFzay0mZ3Q7dG5pLCB0bmlfbWFzayw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgUlRFX0RJTSh0bmlfbWFzaykpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmICh0bmlfbWFza2VkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2Zsb3dfZXJyb3Jfc2V0PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKGVycm9y
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBFSU5WQUwsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFJURV9GTE9XX0VSUk9SX1RZUEVfSVRFTSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaXRlbSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7SW52YWxpZCBUTkkgbWFzayZxdW90Oyk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1y
dGVfZXJybm87PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJ0ZV9tZW1jcHkoKCh1aW50OF90
ICopJmFtcDt0ZW5hbnRfaWRfYmUgKyAxKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbnZncmVfc3BlYy0mZ3Q7dG5pLCAzKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmaWx0ZXItJmd0O3ZuaSA9PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2JlX3Rv
X2NwdV8zMih0ZW5hbnRfaWRfYmUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGZpbHRlci0mZ3Q7dHVubmVsX3R5cGUgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBDRkFfTlRVUExFX0ZJTFRFUl9BTExPQ19SRVFfVFVOTkVMX1RZUEVf
TlZHUkU7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7PGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2FzZSBSVEVfRkxPV19JVEVNX1RZUEVf
R1JFOjxicj4NCi0tPC9ibG9ja3F1b3RlPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OkNh
bGlicmk7Zm9udC1zaXplOjExcHQ7YmFja2dyb3VuZC1jb2xvcjp0cmFuc3BhcmVudCI+QWNrZWQt
Ynk6wqBLaXNob3JlDQpQYWRtYW5hYmhhICZsdDs8YSBocmVmPSJtYWlsdG86a2lzaG9yZS5wYWRt
YW5hYmhhQGJyb2FkY29tLmNvbSI+a2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTwvYT4m
Z3Q7PC9zcGFuPsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPiA8YnI+DQoyLjMwLjI8YnI+DQo8YnI+DQo8L2Jsb2Nr
cXVvdGU+PC9kaXY+PC9kaXY+DQo=
--00000000000072809c065c03647f--

--0000000000007cb92f065c0364f1
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
oIHHMC8GCSqGSIb3DQEJBDEiBCBNIWI1OPh/C4wuE3qXr2QwJfeOmB57oepbrQh3bqTUwzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA5MjExOTM4MjBaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBPVws/oJYc
R4/l9tx4dZsqgLUT/oTeWZ5wrzzmOnuluIsWyqQpmYMza9/00TvQaiHfFYlH1Swq8Cmn/fjK5sN+
K1FwLGVGzN6LBzVth+IPmWVkzzDd6uWLlKHeS8NrtdQD+hyk/2Ic55cQgTZYZEmZSaAwQP10xRjp
gvcEaLQuxtDoFfM0+SC7b3W+0W9jPQYrPm6QSJpNmTi0MVInKXRdBjBAJzHHGe3iwGRuD1dQkqFd
AUlr47+nHqpZglboEXpZN3uaMnGS6LPGsWEpggqUUXlHHrpcTewTX4/k4NiCN8orpIKFCBce4mcC
HRIw+RD7JunXOlfDVqv1ZOyLrwZE
--0000000000007cb92f065c0364f1--
