Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD01AC5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:59:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC5D40270;
	Mon, 24 Aug 2026 18:59:03 +0200 (CEST)
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com
 [209.85.217.99]) by mails.dpdk.org (Postfix) with ESMTP id 20D85400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:59:03 +0200 (CEST)
Received: by mail-vs1-f99.google.com with SMTP id
 ada2fe7eead31-74a86e9d4a8so947040137.2
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590742; x=1788195542;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qUXqNOMdquE8jwASFiRyjffwoVsUZB9WJdaOw+Td+Ys=;
 b=gesfMlbNF2+Ag0/dIuGk9EgI1VBMH/YKs7ajAMJ7qH3/ogd+9W5x40zfEs+Y6UDM8r
 ilBJWRTlK36TR3w3qw1j7DEfs/IPUFp5tZj0cURPfo/Ms80+M18HBNCreDmIZd/R3l3c
 ukc48n2C5J1m6Soc4jn7aqu45CdOM55BaGVHtva7kQTT8eBxUyCclUyWG8rp5Tky8y+o
 tyP2U/lKdBvukt0hvGorvpGlW68X7cg7ILWrTqe/WqmgTrCQWk0ZX2KcMbFNfVW+JO8S
 TieAuhSFwLE7MZKbQHvtmdW/WV+NVuuzRaPGkoj4rA9ugDxvlMblQF1L5kHieeITf0/n
 zUBA==
X-Gm-Message-State: AFuF++liDAwN8oQDXpO2Zv2/AXvE/0QVa4xmzOsRjGzAGPM5JrsqJ+CV
 G82XpQzCrK0cCzDdbTVWn/a9aMhVk97/JPAQv1Bvf/h/ETjUltF/XDrz/HKX9jkAg9thPbKFOJU
 Or1bJQIbkeOSIRvkQf7UKFvny8nNZ/71RdTyMRDVCTll6377yKRyx2gOUD4MjRzI+1HyNRsB4yY
 NWW8e5qtF+gbsPn0aF14LqoukCSOd/osL7uqYmpmxfmfduanO18Eb1S+2XDzuLAJw5HNjUOsBSB
 hs5Ow==
X-Gm-Gg: AR+sD10Wz+Ppz0jIEg/2enwMie/q5sv/LZPc3anQxn3o9dEz8D2Wjfrv2tj+AmPaOEM
 iTotZU1Xrbndb0jK+lPFzMQoiUrmR8bo6k0fbcP4Trj8C1LWdznU5DlsH5jgMxvxPmC6a2WhT/x
 sTO3LmRqlFoLgH32viM/Wss2AnFGUUxRqWYJIHOWLSjmitsGAPqueVcGMExCFe3MDRYrlytXyBS
 0tInJRjKd7754gX7chS0k8NZRVVzEitwLXoyt0PUI30P4R4k33inQWsOjh4wvXnA7p+Wh32cmGI
 baRL/G01uYn12IsgEDalE5ifNQd8bkNlj9N7DRobwkI4vqIcqUN1dNhyT57qPomDVDMGS1qICYW
 5ij1h3mT8ZcMwsIZ2Jh9HtCLxLhAuE4DAqPuOjZIoX6s1LUTj1t9NdXA25godkN5mQEQdKL7Zix
 MYjC6LXB0r3PgX3eYqAo30audiW2DhGF0PsTQ0CpCa4NHdqQ==
X-Received: by 2002:a05:6102:6c1:b0:777:50f1:c202 with SMTP id
 ada2fe7eead31-77a64b67f1fmr9872460137.10.1787590742048; 
 Mon, 24 Aug 2026 09:59:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-97c833fa521sm409060241.6.2026.08.24.09.59.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2026 09:59:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so7267545a91.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787590741; x=1788195541; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qUXqNOMdquE8jwASFiRyjffwoVsUZB9WJdaOw+Td+Ys=;
 b=en9feAt1hW9U5IRLtW0fqste8ZuCilXfWRF8S10AGnO+LiamEItoyuLA0oTDOYihva
 OwbctHiM+IoBsdaZfo6XW2PiYStpAo1imbEWbxG5CbVNbRcmHce5TytSJx3dIWk/JE7P
 fXHOhqs8OQzsnuPedmtJ9amvXSoa990un/53k=
X-Received: by 2002:a17:90b:55cc:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-395c334042emr56138793a91.1.1787590740238; 
 Mon, 24 Aug 2026 09:59:00 -0700 (PDT)
X-Received: by 2002:a17:90b:55cc:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-395c334042emr56138709a91.1.1787590739751; Mon, 24 Aug 2026
 09:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
 <20260821192646.146382-29-stephen@networkplumber.org>
In-Reply-To: <20260821192646.146382-29-stephen@networkplumber.org>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Mon, 24 Aug 2026 12:58:40 -0400
X-Gm-Features: AcwNN1VQQVoUppmnyMYBpyg8JijYO5umoLUK24NMrpWSGkZsmIp10n0oKfBvlGQ
Message-ID: <CA+BST0k73jjT5xh0Se5R1od+Usc5k4tdXW-f4fD4ssUrKVay4g@mail.gmail.com>
Subject: Re: [PATCH v2 28/68] net/bnxt: replace use of rte_memcpy
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000204d4c0659cde77d"
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

--000000000000204d4c0659cde77d
Content-Type: multipart/alternative; boundary="0000000000000c14550659cde79f"

--0000000000000c14550659cde79f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 3:29=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> Don't need rte_memcpy for fixed size value.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/bnxt/bnxt_flow.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
> index a2e590540b..901b019e66 100644
> --- a/drivers/net/bnxt/bnxt_flow.c
> +++ b/drivers/net/bnxt/bnxt_flow.c
> @@ -233,8 +233,9 @@ bnxt_validate_and_parse_flow_type(const struct
> rte_flow_attr *attr,
>                                                     "DMAC is invalid!");
>                                         return -rte_errno;
>                                 }
> -                               rte_memcpy(filter->dst_macaddr,
> -                                          &eth_spec->hdr.dst_addr,
> RTE_ETHER_ADDR_LEN);
> +                               memcpy(filter->dst_macaddr,
> +                                      &eth_spec->hdr.dst_addr,
> +                                      RTE_ETHER_ADDR_LEN);
>                                 en |=3D use_ntuple ?
>
> NTUPLE_FLTR_ALLOC_INPUT_EN_DST_MACADDR :
>                                         EM_FLOW_ALLOC_INPUT_EN_DST_MACADD=
R;
> @@ -257,8 +258,9 @@ bnxt_validate_and_parse_flow_type(const struct
> rte_flow_attr *attr,
>                                                     "SMAC is invalid!");
>                                         return -rte_errno;
>                                 }
> -                               rte_memcpy(filter->src_macaddr,
> -                                          &eth_spec->hdr.src_addr,
> RTE_ETHER_ADDR_LEN);
> +                               memcpy(filter->src_macaddr,
> +                                      &eth_spec->hdr.src_addr,
> +                                      RTE_ETHER_ADDR_LEN);
>                                 en |=3D use_ntuple ?
>
> NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_MACADDR :
>                                         EM_FLOW_ALLOC_INPUT_EN_SRC_MACADD=
R;
> @@ -423,23 +425,23 @@ bnxt_validate_and_parse_flow_type(const struct
> rte_flow_attr *attr,
>                                 en |=3D EM_FLOW_ALLOC_INPUT_EN_SRC_IPADDR=
 |
>                                         EM_FLOW_ALLOC_INPUT_EN_DST_IPADDR=
;
>
> -                       rte_memcpy(filter->src_ipaddr,
> -                                  &ipv6_spec->hdr.src_addr, 16);
> -                       rte_memcpy(filter->dst_ipaddr,
> -                                  &ipv6_spec->hdr.dst_addr, 16);
> +                       memcpy(filter->src_ipaddr,
> &ipv6_spec->hdr.src_addr,
> +                              16);
> +                       memcpy(filter->dst_ipaddr,
> &ipv6_spec->hdr.dst_addr,
> +                              16);
>
>                         if
> (!bnxt_check_zero_bytes(ipv6_mask->hdr.src_addr.a,
>                                                    16)) {
> -                               rte_memcpy(filter->src_ipaddr_mask,
> -                                          &ipv6_mask->hdr.src_addr, 16);
> +                               memcpy(filter->src_ipaddr_mask,
> +                                      &ipv6_mask->hdr.src_addr, 16);
>                                 en |=3D !use_ntuple ? 0 :
>
> NTUPLE_FLTR_ALLOC_INPUT_EN_SRC_IPADDR_MASK;
>                         }
>
>                         if
> (!bnxt_check_zero_bytes(ipv6_mask->hdr.dst_addr.a,
>                                                    16)) {
> -                               rte_memcpy(filter->dst_ipaddr_mask,
> -                                          &ipv6_mask->hdr.dst_addr, 16);
> +                               memcpy(filter->dst_ipaddr_mask,
> +                                      &ipv6_mask->hdr.dst_addr, 16);
>                                 en |=3D !use_ntuple ? 0 :
>
>  NTUPLE_FLTR_ALLOC_INPUT_EN_DST_IPADDR_MASK;
>                         }
> @@ -591,8 +593,8 @@ bnxt_validate_and_parse_flow_type(const struct
> rte_flow_attr *attr,
>                                         return -rte_errno;
>                                 }
>
> -                               rte_memcpy(((uint8_t *)&tenant_id_be + 1)=
,
> -                                          vxlan_spec->hdr.vni, 3);
> +                               memcpy(((uint8_t *)&tenant_id_be + 1),
> +                                      vxlan_spec->hdr.vni, 3);
>                                 filter->vni =3D
>                                         rte_be_to_cpu_32(tenant_id_be);
>                                 filter->tunnel_type =3D
> @@ -645,8 +647,8 @@ bnxt_validate_and_parse_flow_type(const struct
> rte_flow_attr *attr,
>                                                  "Invalid TNI mask");
>                                         return -rte_errno;
>                                 }
> -                               rte_memcpy(((uint8_t *)&tenant_id_be + 1)=
,
> -                                          nvgre_spec->tni, 3);
> +                               memcpy(((uint8_t *)&tenant_id_be + 1),
> +                                      nvgre_spec->tni, 3);
>                                 filter->vni =3D
>                                         rte_be_to_cpu_32(tenant_id_be);
>                                 filter->tunnel_type =3D
> --

Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>
> 2.53.0
>
>

--0000000000000c14550659cde79f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBGcmksIEF1ZyAyMSwgMjAyNiBhdCAzOjI54oCvUE0gU3RlcGhlbiBIZW1t
aW5nZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZyI+c3Rl
cGhlbkBuZXR3b3JrcGx1bWJlci5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkRv
biYjMzk7dCBuZWVkIHJ0ZV9tZW1jcHkgZm9yIGZpeGVkIHNpemUgdmFsdWUuPGJyPg0KPGJyPg0K
U2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1taW5nZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpzdGVw
aGVuQG5ldHdvcmtwbHVtYmVyLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPnN0ZXBoZW5AbmV0d29ya3Bs
dW1iZXIub3JnPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGRyaXZlcnMvbmV0L2JueHQvYm54dF9m
bG93LmMgfCAzNCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tPGJyPg0KwqAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JueHQvYm54dF9mbG93LmMgYi9kcml2ZXJzL25ldC9i
bnh0L2JueHRfZmxvdy5jPGJyPg0KaW5kZXggYTJlNTkwNTQwYi4uOTAxYjAxOWU2NiAxMDA2NDQ8
YnI+DQotLS0gYS9kcml2ZXJzL25ldC9ibnh0L2JueHRfZmxvdy5jPGJyPg0KKysrIGIvZHJpdmVy
cy9uZXQvYm54dC9ibnh0X2Zsb3cuYzxicj4NCkBAIC0yMzMsOCArMjMzLDkgQEAgYm54dF92YWxp
ZGF0ZV9hbmRfcGFyc2VfZmxvd190eXBlKGNvbnN0IHN0cnVjdCBydGVfZmxvd19hdHRyICphdHRy
LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O0RNQUMgaXMgaW52YWxpZCEmcXVvdDsp
Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJldHVybiAtcnRlX2Vycm5vOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfbWVtY3B5KGZpbHRlci0mZ3Q7ZHN0X21hY2FkZHIs
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZhbXA7ZXRoX3NwZWMtJmd0O2hkci5kc3RfYWRkciwgUlRFX0VUSEVSX0FE
RFJfTEVOKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBtZW1jcHkoZmlsdGVyLSZndDtkc3RfbWFjYWRkciw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtldGhfc3BlYy0m
Z3Q7aGRyLmRzdF9hZGRyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSVEVfRVRIRVJfQUREUl9MRU4pOzxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVuIHw9IHVzZV9udHVwbGUg
Pzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIE5UVVBMRV9GTFRSX0FMTE9DX0lOUFVUX0VOX0RTVF9NQUNBRERSIDo8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBFTV9GTE9XX0FMTE9DX0lOUFVUX0VOX0RTVF9NQUNBRERSOzxicj4NCkBAIC0yNTcsOCArMjU4
LDkgQEAgYm54dF92YWxpZGF0ZV9hbmRfcGFyc2VfZmxvd190eXBlKGNvbnN0IHN0cnVjdCBydGVf
Zmxvd19hdHRyICphdHRyLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O1NNQUMgaXMg
aW52YWxpZCEmcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtcnRlX2Vycm5vOzxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfbWVtY3B5KGZpbHRlci0m
Z3Q7c3JjX21hY2FkZHIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7ZXRoX3NwZWMtJmd0O2hkci5zcmNfYWRk
ciwgUlRFX0VUSEVSX0FERFJfTEVOKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkoZmlsdGVyLSZndDtzcmNfbWFjYWRkciw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JmFtcDtldGhfc3BlYy0mZ3Q7aGRyLnNyY19hZGRyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBSVEVfRVRIRVJfQUREUl9MRU4p
Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVu
IHw9IHVzZV9udHVwbGUgPzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5UVVBMRV9GTFRSX0FMTE9DX0lOUFVUX0VOX1NSQ19N
QUNBRERSIDo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBFTV9GTE9XX0FMTE9DX0lOUFVUX0VOX1NSQ19NQUNBRERSOzxicj4N
CkBAIC00MjMsMjMgKzQyNSwyMyBAQCBibnh0X3ZhbGlkYXRlX2FuZF9wYXJzZV9mbG93X3R5cGUo
Y29uc3Qgc3RydWN0IHJ0ZV9mbG93X2F0dHIgKmF0dHIsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZW4gfD0gRU1fRkxPV19BTExPQ19JTlBVVF9F
Tl9TUkNfSVBBRERSIHw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBFTV9GTE9XX0FMTE9DX0lOUFVUX0VOX0RTVF9JUEFERFI7
PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX21lbWNw
eShmaWx0ZXItJmd0O3NyY19pcGFkZHIsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7aXB2Nl9zcGVjLSZndDtoZHIuc3JjX2FkZHIs
IDE2KTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBydGVfbWVtY3B5
KGZpbHRlci0mZ3Q7ZHN0X2lwYWRkciw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJmFtcDtpcHY2X3NwZWMtJmd0O2hkci5kc3RfYWRkciwg
MTYpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1lbWNweShmaWx0
ZXItJmd0O3NyY19pcGFkZHIsICZhbXA7aXB2Nl9zcGVjLSZndDtoZHIuc3JjX2FkZHIsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE2KTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkoZmlsdGVyLSZndDtkc3Rf
aXBhZGRyLCAmYW1wO2lwdjZfc3BlYy0mZ3Q7aGRyLmRzdF9hZGRyLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxNik7PGJyPg0KPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFibnh0X2NoZWNrX3plcm9fYnl0ZXMo
aXB2Nl9tYXNrLSZndDtoZHIuc3JjX2FkZHIuYSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE2
KSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJ0ZV9tZW1jcHkoZmlsdGVyLSZndDtzcmNfaXBhZGRyX21hc2ssPGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7
aXB2Nl9tYXNrLSZndDtoZHIuc3JjX2FkZHIsIDE2KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkoZmlsdGVyLSZndDtzcmNfaXBhZGRy
X21hc2ssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZhbXA7aXB2Nl9tYXNrLSZndDtoZHIuc3JjX2FkZHIsIDE2KTs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbiB8PSAhdXNl
X250dXBsZSA/IDAgOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIE5UVVBMRV9GTFRSX0FMTE9DX0lOUFVUX0VOX1NSQ19JUEFERFJfTUFT
Szs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCFibnh0X2NoZWNrX3plcm9f
Ynl0ZXMoaXB2Nl9tYXNrLSZndDtoZHIuZHN0X2FkZHIuYSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDE2KSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJ0ZV9tZW1jcHkoZmlsdGVyLSZndDtkc3RfaXBhZGRyX21hc2ssPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZhbXA7aXB2Nl9tYXNrLSZndDtoZHIuZHN0X2FkZHIsIDE2KTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkoZmlsdGVyLSZndDtkc3Rf
aXBhZGRyX21hc2ssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZhbXA7aXB2Nl9tYXNrLSZndDtoZHIuZHN0X2FkZHIsIDE2KTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbiB8
PSAhdXNlX250dXBsZSA/IDAgOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgTlRVUExFX0ZMVFJfQUxMT0NfSU5QVVRfRU5fRFNUX0lQ
QUREUl9NQVNLOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+
DQpAQCAtNTkxLDggKzU5Myw4IEBAIGJueHRfdmFsaWRhdGVfYW5kX3BhcnNlX2Zsb3dfdHlwZShj
b25zdCBzdHJ1Y3QgcnRlX2Zsb3dfYXR0ciAqYXR0ciw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLXJ0ZV9lcnJu
bzs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9
PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcnRlX21lbWNweSgoKHVpbnQ4X3QgKikmYW1wO3RlbmFudF9pZF9iZSArIDEpLDxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB2eGxhbl9zcGVjLSZndDtoZHIudm5pLCAzKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtZW1jcHkoKCh1aW50OF90ICopJmFtcDt0ZW5h
bnRfaWRfYmUgKyAxKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgdnhsYW5fc3BlYy0mZ3Q7aGRyLnZuaSwgMyk7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlsdGVyLSZndDt2
bmkgPTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHJ0ZV9iZV90b19jcHVfMzIodGVuYW50X2lkX2JlKTs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWx0ZXItJmd0O3R1bm5l
bF90eXBlID08YnI+DQpAQCAtNjQ1LDggKzY0Nyw4IEBAIGJueHRfdmFsaWRhdGVfYW5kX3BhcnNl
X2Zsb3dfdHlwZShjb25zdCBzdHJ1Y3QgcnRlX2Zsb3dfYXR0ciAqYXR0ciw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZxdW90O0ludmFsaWQgVE5JIG1hc2smcXVvdDspOzxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAt
cnRlX2Vycm5vOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBydGVfbWVtY3B5KCgodWludDhfdCAqKSZhbXA7dGVuYW50X2lkX2JlICsgMSksPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIG52Z3JlX3NwZWMtJmd0O3RuaSwgMyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtY3B5KCgodWludDhfdCAqKSZhbXA7dGVuYW50
X2lkX2JlICsgMSksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIG52Z3JlX3NwZWMtJmd0O3RuaSwgMyk7PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmlsdGVyLSZndDt2bmkgPTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJ0ZV9iZV90b19jcHVfMzIodGVuYW50X2lkX2JlKTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaWx0ZXItJmd0O3R1bm5lbF90eXBl
ID08YnI+DQotLTwvYmxvY2txdW90ZT48ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpDYWxp
YnJpO2ZvbnQtc2l6ZToxMXB0O2JhY2tncm91bmQtY29sb3I6dHJhbnNwYXJlbnQiPkFja2VkLWJ5
OsKgwqBLaXNob3JlDQpQYWRtYW5hYmhhICZsdDs8YSBocmVmPSJtYWlsdG86a2lzaG9yZS5wYWRt
YW5hYmhhQGJyb2FkY29tLmNvbSI+a2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbTwvYT4m
Z3Q7PC9zcGFuPsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPiA8YnI+DQoyLjUzLjA8YnI+DQo8YnI+DQo8L2Jsb2Nr
cXVvdGU+PC9kaXY+PC9kaXY+DQo=
--0000000000000c14550659cde79f--

--000000000000204d4c0659cde77d
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
oIHHMC8GCSqGSIb3DQEJBDEiBCDC56qUQAUkzMAhVEjnrhiI05tYYUTSdpDnEV2yzdRSEzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MjQxNjU5MDFaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAP+6qPvhIZ
e/TI4HB834fYGkt8EDtN1XTb5PfcaOVfMZNRE5iUb178OysHO7IiNdyu7HUyCZSBnUK7EKiUNkm7
HQqiZzSrQutuRuPyc8tb1bc1/u3a9IqWeAGv/hFfRPWkZXGYIPA11jbYXksPDeV5jXJu1YfPIpiu
4mDx3+XqCV+WCRcR6w1Ji5SLj8fzaoMGRU3xnDKSk912sCiErQWTeCPy66JgzGIq7xIdLH2//iwY
/SJ7AijDCSZDjw7ahDRtq/adapl7pL3YA0fh2F7F+EgI5+v5DV6aXCG2C+ejTqDWTwmdBJAxat+k
V0YlRSIuT3Qo1kgza7+HQpLBKH6F
--000000000000204d4c0659cde77d--
