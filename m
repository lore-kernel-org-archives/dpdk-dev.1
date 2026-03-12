Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF50106ACEF
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 22:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6B3840285;
	Thu, 12 Mar 2026 23:46:30 +0100 (CET)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id D788540275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 23:46:29 +0100 (CET)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-829865a8471so1519793b3a.3
 for <dev@dpdk.org>; Thu, 12 Mar 2026 15:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773355589; x=1773960389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GS+COf3MX/9y9bzkR/uScfi2z0mPPLjcXT+iuhPm/DI=;
 b=TIZs8wBsCVEu+l51r+L847DJFyC+7jE1goZrK4lOBCaOln7BLyekIJvY7DF6Sn6bhy
 m1+areLhsNhSaIU3bftz3b38KyyCeNV1tjvYw7OFFp7NvwZhXo+heW4M8NKW/QSIaqvo
 Pl5R1cwz9cnXRtYTp+1BZmE11dTCmB3tIWB1J1LhEk0e7nYRABHqPzJ/mplgZ05go2BJ
 P8KSDvEuqRb5BRS6TQeGO/2kxlcUSFHCqNv33wC+2792nrLHfFsqNJ4/fYla1AT3/q2m
 ydMFkdVHauAexensy8golIgMyTew30F8CF5uOy8G370xAdSBcii841B0Ln/d0lYCa/Vl
 Pp3g==
X-Gm-Message-State: AOJu0Yy1psA2pd9GJKhJOIJ5uY2bU5NlCb4FlF2TaHhaRZSQcgk44EkD
 fPJTfJeG2cs3NLVjvbSk2svt5sqFXSMCoLO2T5nOHxv2uuqtKqLvRaIBaswT/gjQU3UUG96nV8c
 D/doeDcXTo/DstP27CYcKt4YbdcwmOnsA6/ZGC2sQc5tpfPcAoo+3+TOtgh9oiqhwR+L4NsvnRm
 iiHfYoae6pP4O8C6V13Lp0EiBWPihzJX2khe0xLWO8bIzAhuNYT4YAAst8yVV+430OS0g/lt0wq
 ujhPg==
X-Gm-Gg: ATEYQzyUMrtLvWF3ypeeMoTrm2bmqWs+WldfeW4fnveuu8hyGdZw+HmY+/bSNqpHoy7
 TalLu0UdFssgjkfXC+YM/JEzDdH4ZodPWlauhi3862lNhiaPmC7AtJtDaOcbmR0CatAhH9uD+yl
 vfr9gQtfqFKd7pri2drkt0XvvI31DKMYoyugOVUspl/lEMwwVCyNHmbSzrGo4FVwW+beMI+5VU2
 3sglNiON6Xle28b7ok6BCvBxPDkw3qzSNqBorhC5JqM2+ZMe1UVYYAEW+9FQBGJwdmqS16qXqpF
 /p9j+MOlmEUT1qfjpTaW1+Vh+EozDpwJCi9ApED7qsp4UN3bXMID0nU3q/+JQyfb7+IJaEKbhui
 U4uYcGO+y/IZHXAX7MPc+WIcvXWYOOqBGDJshTxQIMr9TNvwJSxlf7kP6iZreKLW2T+6XhjOLFa
 zxJxJfPKTDd7NPBhL1pnYcmFZOO0UZlDrwwdBhiKJR7aBBqWCJky7MYNzrIJBFMJui
X-Received: by 2002:a05:6a00:1a8b:b0:81f:9bc0:e45e with SMTP id
 d2e1a72fcca58-82a1996ae94mr883884b3a.65.1773355588628; 
 Thu, 12 Mar 2026 15:46:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-82a07233b49sm521044b3a.1.2026.03.12.15.46.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Mar 2026 15:46:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b90bb54d034so287855566b.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 15:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773355586; cv=none;
 d=google.com; s=arc-20240605;
 b=g8xP1wvGuOqyvEQMlpUTArtsTJHGl7JtxaZU4PXgQ6MElBFuJdCIHNdvr86fM/PfA0
 yujzeg3HGDxdNeCwUgqz7B7vGpTtkiIXPRpPkwVq2fzvCEKlSZExEcxrlBWBRAjzGy1R
 56b3vZgo72AqdAEpuZKzLLbbBnXgX9iE9zinMHLh0IOE/YzxVETAUlACGJocpOUf4t3i
 Z2Y959+FMHzpGPsWfP57VIHYMgEk2jBCmumIa7zhaqOHBw+Kg+KsIjTK/DMZlmBD4pP9
 P4df5DT0Z2gUjKwC0633gD9LDVH/Wl2uQUmnt/w2qEfH+AIv4ToN/ukCQUk7z8sA7VLY
 95Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GS+COf3MX/9y9bzkR/uScfi2z0mPPLjcXT+iuhPm/DI=;
 fh=QiECP9uUWTb17iwIOUvFNg2qho9YwmMMgsVfEQa1WRM=;
 b=VROOpIcIhVlEeTNa/S4MTsFHl0pAY5VeddhAWQy9FfWqFmyqGf5OOf7biA9Ts41poO
 7dnidq36oH9DpwyL/ezJV2659cPggVulQhohl5aGuNfNmQLBiWXMrWt1Rw6O+cztXWTD
 WxT+GxR17ztV0w9KF9lbCY/V5QSLr5LhtnfxNHK3Drq3Y2jvCe3A+gHJLnMik34uOFF/
 D5sCUSu2Y0xq2BJK1T+gAT9qH7FNN1UEhxXJx73t2QVjGTxRYynCpWyrCkHuQo+Dcc3X
 m2sKQ+G+5OTk6LTJLcWdIt1HZoCOgmG6oBOAtwT9bmgwed56oEz08sAZOfIy5yw8i9/M
 DnYQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1773355586; x=1773960386; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GS+COf3MX/9y9bzkR/uScfi2z0mPPLjcXT+iuhPm/DI=;
 b=UTPrz8Fhbd+yvutGH42xch6mp9a56oomGnEyWLnyu1HS0RlVW1nQMaZkCmLiaGEJJT
 uWV1o6OLpewGPnRUSfnHjzkEgX821oH7L2d+VIKMa2KdGpyzAQs7MSPpr9Ma/vQeoAep
 HMBeGECvUd0NpquZy17W2iRcypwrWRY9Q21MI=
X-Received: by 2002:a17:906:9f87:b0:b96:dce1:2f52 with SMTP id
 a640c23a62f3a-b973ffd257cmr305410066b.19.1773355586267; 
 Thu, 12 Mar 2026 15:46:26 -0700 (PDT)
X-Received: by 2002:a17:906:9f87:b0:b96:dce1:2f52 with SMTP id
 a640c23a62f3a-b973ffd257cmr305408566b.19.1773355585699; Thu, 12 Mar 2026
 15:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260312002123.867357-1-stephen@networkplumber.org>
 <20260312002123.867357-3-stephen@networkplumber.org>
In-Reply-To: <20260312002123.867357-3-stephen@networkplumber.org>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Thu, 12 Mar 2026 18:46:08 -0400
X-Gm-Features: AaiRm50Un7NBDRWYGxVd-ICNsCEN1Rf6OQpSAAqcLXWS6WHSxt6Dmse4-9LTEIo
Message-ID: <CA+BST0kC0qFm85=TdG-Ct_UEfE4jKWdygKZXo_febajCY_5bPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] net/bnxt: fix shadow variable warnings
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Ajit Khaparde <ajit.khaparde@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000ce23e3064cdb85fe"
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

--000000000000ce23e3064cdb85fe
Content-Type: multipart/alternative; boundary="000000000000bf2299064cdb855c"

--000000000000bf2299064cdb855c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:21=E2=80=AFPM Stephen Hemminger <
stephen@networkplumber.org> wrote:

> Fix things flagged as warnings about shadowed variables.
> If the variable was harmless overlap then just drop the shadowed
> version. For min values case use RTE_MIN3() and RTE_MIN4().
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

>  drivers/net/bnxt/bnxt.h        | 6 +++---
>  drivers/net/bnxt/bnxt_ethdev.c | 3 +--
>  drivers/net/bnxt/bnxt_rxq.c    | 6 ++----
>  drivers/net/bnxt/bnxt_txr.c    | 3 ---
>  4 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
> index 7515f0564f..8b81c11b32 100644
> --- a/drivers/net/bnxt/bnxt.h
> +++ b/drivers/net/bnxt/bnxt.h
> @@ -1110,9 +1110,9 @@ inline uint16_t bnxt_max_rings(struct bnxt *bp)
>          * max Tx rings =3D=3D max Rx rings, one stat ctx for each.
>          */
>         if (BNXT_STINGRAY(bp)) {
> -               max_rx_rings =3D RTE_MIN(RTE_MIN(max_rx_rings / 2U,
> -                                              MAX_STINGRAY_RINGS),
> -                                      bp->max_stat_ctx / 2U);
> +               max_rx_rings =3D RTE_MIN3(max_rx_rings / 2U,
> +                                       MAX_STINGRAY_RINGS,
> +                                       bp->max_stat_ctx / 2U);
>         } else {
>                 max_rx_rings =3D RTE_MIN(max_rx_rings / 2U,
>                                        bp->max_stat_ctx / 2U);
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index b677f9491d..f033c34aab 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -473,7 +473,7 @@ static int bnxt_setup_one_vnic(struct bnxt *bp,
> uint16_t vnic_id)
>
>         /* Alloc RSS context only if RSS mode is enabled */
>         if (dev_conf->rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
> -               int j, nr_ctxs =3D bnxt_rss_ctxts(bp);
> +               unsigned int nr_ctxs =3D bnxt_rss_ctxts(bp);
>
>                 /* RSS table size in P5 is 512.
>                  * Cap max Rx rings to same value
> @@ -3560,7 +3560,6 @@ bnxt_rx_descriptor_status_op(void *rx_queue,
> uint16_t offset)
>          */
>  #if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
>         if (bp->flags & BNXT_FLAG_RX_VECTOR_PKT_MODE) {
> -               struct rx_pkt_cmpl *rxcmp;
>                 uint32_t cons;
>
>                 /* Check status of completion descriptor. */
> diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
> index 91b3555df6..df9ed391c4 100644
> --- a/drivers/net/bnxt/bnxt_rxq.c
> +++ b/drivers/net/bnxt/bnxt_rxq.c
> @@ -98,10 +98,8 @@ int bnxt_mq_rx_configure(struct bnxt *bp)
>                         /* ETH_8/64_POOLs */
>                         pools =3D conf->nb_queue_pools;
>                         /* For each pool, allocate MACVLAN CFA rule & VNI=
C
> */
> -                       max_pools =3D RTE_MIN(bp->max_vnics,
> -                                           RTE_MIN(bp->max_l2_ctx,
> -                                           RTE_MIN(bp->max_rsscos_ctx,
> -                                                   RTE_ETH_64_POOLS)));
> +                       max_pools =3D RTE_MIN4(bp->max_vnics, bp->max_l2_=
ctx,
> +                                           bp->max_rsscos_ctx,
> RTE_ETH_64_POOLS);
>                         PMD_DRV_LOG_LINE(DEBUG,
>                                     "pools =3D %u max_pools =3D %u",
>                                     pools, max_pools);
> diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
> index 27758898b0..498778aae0 100644
> --- a/drivers/net/bnxt/bnxt_txr.c
> +++ b/drivers/net/bnxt/bnxt_txr.c
> @@ -179,9 +179,6 @@ bnxt_check_pkt_needs_ts(struct rte_mbuf *m)
>                 if (proto =3D=3D RTE_ETHER_TYPE_ECPRI)
>                         return true;
>                 if (proto =3D=3D RTE_ETHER_TYPE_VLAN) {
> -                       const struct rte_vlan_hdr *vh;
> -                       struct rte_vlan_hdr vh_copy;
> -
>                         vh =3D rte_pktmbuf_read(m, off, sizeof(*vh),
> &vh_copy);
>                         if (unlikely(vh =3D=3D NULL))
>                                 return false;
> --
> 2.51.0
>
>

--000000000000bf2299064cdb855c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBXZWQsIE1hciAxMSwgMjAyNiBhdCA4OjIx4oCvUE0gU3RlcGhlbiBIZW1t
aW5nZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZyI+c3Rl
cGhlbkBuZXR3b3JrcGx1bWJlci5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkZp
eCB0aGluZ3MgZmxhZ2dlZCBhcyB3YXJuaW5ncyBhYm91dCBzaGFkb3dlZCB2YXJpYWJsZXMuPGJy
Pg0KSWYgdGhlIHZhcmlhYmxlIHdhcyBoYXJtbGVzcyBvdmVybGFwIHRoZW4ganVzdCBkcm9wIHRo
ZSBzaGFkb3dlZDxicj4NCnZlcnNpb24uIEZvciBtaW4gdmFsdWVzIGNhc2UgdXNlIFJURV9NSU4z
KCkgYW5kIFJURV9NSU40KCkuPGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogU3RlcGhlbiBIZW1t
aW5nZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZyIgdGFy
Z2V0PSJfYmxhbmsiPnN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnPC9hPiZndDs8YnI+DQotLS08
YnI+PC9ibG9ja3F1b3RlPjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmk7Zm9u
dC1zaXplOjExcHQiPkFja2VkLWJ5OsKgwqBLaXNob3JlDQpQYWRtYW5hYmhhICZsdDs8YSBocmVm
PSJtYWlsdG86a2lzaG9yZS5wYWRtYW5hYmhhQGJyb2FkY29tLmNvbSI+a2lzaG9yZS5wYWRtYW5h
YmhhQGJyb2FkY29tLmNvbTwvYT4mZ3Q7PC9zcGFuPsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9
ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KwqBkcml2ZXJz
L25ldC9ibnh0L2JueHQuaMKgIMKgIMKgIMKgIHwgNiArKystLS08YnI+DQrCoGRyaXZlcnMvbmV0
L2JueHQvYm54dF9ldGhkZXYuYyB8IDMgKy0tPGJyPg0KwqBkcml2ZXJzL25ldC9ibnh0L2JueHRf
cnhxLmPCoCDCoCB8IDYgKystLS0tPGJyPg0KwqBkcml2ZXJzL25ldC9ibnh0L2JueHRfdHhyLmPC
oCDCoCB8IDMgLS0tPGJyPg0KwqA0IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JueHQvYm54
dC5oIGIvZHJpdmVycy9uZXQvYm54dC9ibnh0Lmg8YnI+DQppbmRleCA3NTE1ZjA1NjRmLi44Yjgx
YzExYjMyIDEwMDY0NDxicj4NCi0tLSBhL2RyaXZlcnMvbmV0L2JueHQvYm54dC5oPGJyPg0KKysr
IGIvZHJpdmVycy9uZXQvYm54dC9ibnh0Lmg8YnI+DQpAQCAtMTExMCw5ICsxMTEwLDkgQEAgaW5s
aW5lIHVpbnQxNl90IGJueHRfbWF4X3JpbmdzKHN0cnVjdCBibnh0ICpicCk8YnI+DQrCoCDCoCDC
oCDCoCDCoCogbWF4IFR4IHJpbmdzID09IG1heCBSeCByaW5ncywgb25lIHN0YXQgY3R4IGZvciBl
YWNoLjxicj4NCsKgIMKgIMKgIMKgIMKgKi88YnI+DQrCoCDCoCDCoCDCoCBpZiAoQk5YVF9TVElO
R1JBWShicCkpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXhfcnhfcmluZ3MgPSBS
VEVfTUlOKFJURV9NSU4obWF4X3J4X3JpbmdzIC8gMlUsPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1BWF9T
VElOR1JBWV9SSU5HUyksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJwLSZndDttYXhfc3RhdF9jdHggLyAyVSk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgbWF4X3J4X3JpbmdzID0gUlRFX01JTjMobWF4X3J4X3Jpbmdz
IC8gMlUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgTUFYX1NUSU5HUkFZX1JJTkdTLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJwLSZndDttYXhfc3Rh
dF9jdHggLyAyVSk7PGJyPg0KwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBtYXhfcnhfcmluZ3MgPSBSVEVfTUlOKG1heF9yeF9yaW5ncyAvIDJVLDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgYnAtJmd0O21heF9zdGF0X2N0eCAvIDJVKTs8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
ZXQvYm54dC9ibnh0X2V0aGRldi5jIGIvZHJpdmVycy9uZXQvYm54dC9ibnh0X2V0aGRldi5jPGJy
Pg0KaW5kZXggYjY3N2Y5NDkxZC4uZjAzM2MzNGFhYiAxMDA2NDQ8YnI+DQotLS0gYS9kcml2ZXJz
L25ldC9ibnh0L2JueHRfZXRoZGV2LmM8YnI+DQorKysgYi9kcml2ZXJzL25ldC9ibnh0L2JueHRf
ZXRoZGV2LmM8YnI+DQpAQCAtNDczLDcgKzQ3Myw3IEBAIHN0YXRpYyBpbnQgYm54dF9zZXR1cF9v
bmVfdm5pYyhzdHJ1Y3QgYm54dCAqYnAsIHVpbnQxNl90IHZuaWNfaWQpPGJyPg0KPGJyPg0KwqAg
wqAgwqAgwqAgLyogQWxsb2MgUlNTIGNvbnRleHQgb25seSBpZiBSU1MgbW9kZSBpcyBlbmFibGVk
ICovPGJyPg0KwqAgwqAgwqAgwqAgaWYgKGRldl9jb25mLSZndDtyeG1vZGUubXFfbW9kZSAmYW1w
OyBSVEVfRVRIX01RX1JYX1JTUykgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBq
LCBucl9jdHhzID0gYm54dF9yc3NfY3R4dHMoYnApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHVuc2lnbmVkIGludCBucl9jdHhzID0gYm54dF9yc3NfY3R4dHMoYnApOzxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFJTUyB0YWJsZSBzaXplIGluIFA1IGlzIDUxMi48
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogQ2FwIG1heCBSeCByaW5ncyB0byBzYW1l
IHZhbHVlPGJyPg0KQEAgLTM1NjAsNyArMzU2MCw2IEBAIGJueHRfcnhfZGVzY3JpcHRvcl9zdGF0
dXNfb3Aodm9pZCAqcnhfcXVldWUsIHVpbnQxNl90IG9mZnNldCk8YnI+DQrCoCDCoCDCoCDCoCDC
oCovPGJyPg0KwqAjaWYgZGVmaW5lZChSVEVfQVJDSF9YODYpIHx8IGRlZmluZWQoUlRFX0FSQ0hf
QVJNNjQpPGJyPg0KwqAgwqAgwqAgwqAgaWYgKGJwLSZndDtmbGFncyAmYW1wOyBCTlhUX0ZMQUdf
UlhfVkVDVE9SX1BLVF9NT0RFKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0
IHJ4X3BrdF9jbXBsICpyeGNtcDs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50MzJf
dCBjb25zOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIENoZWNrIHN0YXR1
cyBvZiBjb21wbGV0aW9uIGRlc2NyaXB0b3IuICovPGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bmV0L2JueHQvYm54dF9yeHEuYyBiL2RyaXZlcnMvbmV0L2JueHQvYm54dF9yeHEuYzxicj4NCmlu
ZGV4IDkxYjM1NTVkZjYuLmRmOWVkMzkxYzQgMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9uZXQv
Ym54dC9ibnh0X3J4cS5jPGJyPg0KKysrIGIvZHJpdmVycy9uZXQvYm54dC9ibnh0X3J4cS5jPGJy
Pg0KQEAgLTk4LDEwICs5OCw4IEBAIGludCBibnh0X21xX3J4X2NvbmZpZ3VyZShzdHJ1Y3QgYm54
dCAqYnApPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogRVRIXzgv
NjRfUE9PTHMgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwb29s
cyA9IGNvbmYtJmd0O25iX3F1ZXVlX3Bvb2xzOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIC8qIEZvciBlYWNoIHBvb2wsIGFsbG9jYXRlIE1BQ1ZMQU4gQ0ZBIHJ1bGUg
JmFtcDsgVk5JQyAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1h
eF9wb29scyA9IFJURV9NSU4oYnAtJmd0O21heF92bmljcyw8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBSVEVfTUlO
KGJwLSZndDttYXhfbDJfY3R4LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9NSU4oYnAtJmd0O21heF9yc3Nj
b3NfY3R4LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFJURV9FVEhfNjRfUE9PTFMpKSk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWF4X3Bvb2xzID0gUlRFX01J
TjQoYnAtJmd0O21heF92bmljcywgYnAtJmd0O21heF9sMl9jdHgsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnAt
Jmd0O21heF9yc3Njb3NfY3R4LCBSVEVfRVRIXzY0X1BPT0xTKTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQTURfRFJWX0xPR19MSU5FKERFQlVHLDxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O3Bv
b2xzID0gJXUgbWF4X3Bvb2xzID0gJXUmcXVvdDssPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcG9vbHMsIG1heF9wb29scyk7PGJyPg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2JueHQvYm54dF90eHIuYyBiL2RyaXZlcnMvbmV0L2Ju
eHQvYm54dF90eHIuYzxicj4NCmluZGV4IDI3NzU4ODk4YjAuLjQ5ODc3OGFhZTAgMTAwNjQ0PGJy
Pg0KLS0tIGEvZHJpdmVycy9uZXQvYm54dC9ibnh0X3R4ci5jPGJyPg0KKysrIGIvZHJpdmVycy9u
ZXQvYm54dC9ibnh0X3R4ci5jPGJyPg0KQEAgLTE3OSw5ICsxNzksNiBAQCBibnh0X2NoZWNrX3Br
dF9uZWVkc190cyhzdHJ1Y3QgcnRlX21idWYgKm0pPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaWYgKHByb3RvID09IFJURV9FVEhFUl9UWVBFX0VDUFJJKTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiB0cnVlOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGlmIChwcm90byA9PSBSVEVfRVRIRVJfVFlQRV9WTEFOKSB7PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3RydWN0IHJ0ZV92bGFuX2hkciAqdmg7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IHJ0ZV92bGFu
X2hkciB2aF9jb3B5Ozxicj4NCi08YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB2aCA9IHJ0ZV9wa3RtYnVmX3JlYWQobSwgb2ZmLCBzaXplb2YoKnZoKSwgJmFtcDt2aF9j
b3B5KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAodW5saWtl
bHkodmggPT0gTlVMTCkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmV0dXJuIGZhbHNlOzxicj4NCi0tIDxicj4NCjIuNTEuMDxicj4NCjxicj4N
CjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4NCg==
--000000000000bf2299064cdb855c--

--000000000000ce23e3064cdb85fe
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
oIHHMC8GCSqGSIb3DQEJBDEiBCAquLYS2wApHtsjoPR2FflSokpK5WZNBBBA6/wbTyqnwzAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMTIyMjQ2MjZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA/FJEDKOOk
G7Dmq6xnrlVANnYBhbUmsb2GQ86QjK6Rd2ngcHi2FnThoxG7Ikc0gixfoVru1NBCgjxWfLO+LAQM
exc4U7bkEAcni2BwrOD5HNzVcACAnM7lStoZKHRUjll4kImXMz/tqcGka2qbA80rzZwdCVJGTo0P
ye0ctkt9Iawcz7p9iKpbObTwnYE4u1wi3vL8mUVik/TmqFQspF9vLbQR7kwxlzYOCJG/K6oXKv8+
tsIOl04+9x2rHgoMe7Vc/kwLk5l3OXpRb0KWcmaf/LAXfaw9xJDmU0luwFmJTmvCjGtWxTEUWWt/
c7R+n8cxG4kh29efFE2WbHKVy2yL
--000000000000ce23e3064cdb85fe--
