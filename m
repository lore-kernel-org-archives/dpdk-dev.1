Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF2F436BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Apr 2026 16:43:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93847402DD;
	Fri, 17 Apr 2026 18:43:31 +0200 (CEST)
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com
 [209.85.160.227])
 by mails.dpdk.org (Postfix) with ESMTP id 9D85D402A7
 for <dev@dpdk.org>; Fri, 17 Apr 2026 18:43:29 +0200 (CEST)
Received: by mail-qt1-f227.google.com with SMTP id
 d75a77b69052e-50d7c12e48eso9183131cf.1
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444209; x=1777049009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WPeqEpXGN9SbM8PYxmxNeNFfy3bMUrx2ZwilUQeiKQ=;
 b=SN2xvC9SuhDwlmD3UjNqJ+jfQeNIGvN83YG4LCAyZ9ifBaOlXVn/WY4PQypqdD3Taw
 WWrpDUfbcDM0VhytS4+p4wLP/N8/i42Elcq0ar4KhWKkjV4u9D/FdgBPW3daOQ5JEGTN
 6PigtFnMu1PdHgBE4/Q+yEnKjLsi2RvekGeOnJWIneOZbmmu5bVkKZc8r+6YwbudlH4y
 MVRMV9mV0nbJewgGet57RrOI2XE4YmK2CNIU+XOiYouAWRtCRTownz0RHc851kCU4+u4
 5Qto0pJmdnHV4mlDx18h1Hs56kuKFUSX+GWZ1Gk2U/47gSDpGumkbnhakDSEovF6ikH6
 zX8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9riO/U5E9Cs/FVTtt+PYm8yTGb/0M+/yuGe2Z0zK26AK8YCODoHsgTPK5JJ4lxa9Eq1HY=@dpdk.org
X-Gm-Message-State: AOJu0Yy0oZJzktjypn5pzL/0GRUptFAP8PTHkwYUXELvTE7ZxjqW+D/Q
 9wsgOTYtCvofONjXUjcXo1uMcqqYwVYJbWFnTQCfctIikQLUdxHJE/vFMzi5B1mR+fb+pv+WuGY
 EDnvwdNZG3k69R9G4QBHKfwDcCsGRh7wLm9GZZaiHvMMSDoAE0DdhsNkL2PfGKQnFf1M2qYOnIv
 BBkaG1e23aQFp9nwm89xX0lLo1uevtuhnh9NQy4SSuhA5iRgrPClU53AZ9uUT55ix89rZENDV49
 VkKJA==
X-Gm-Gg: AeBDievYco8nEt7dhDEytxCiVEbAetQ6NTEc3tM3zCnxnYcsp45CJIpTABtWddQ9AgL
 tK9iRSOPmj1zjYuCjxIE77jDCdW7W1nTK1oKFCC/x8GdbxqguMEyzEpP6eWzJZ2yR0svCUsgPAA
 6BzMDQjoo07PL/lWGRVJDBkDVNiFJV3C/VPFwOWbeHuvlld8X59YxscaypXEmxgraP9VEPg8jKY
 4B5wuk8ajOVZNr0PvV+gvhaFYCOAjpvHe9PsRV/goZozPgg8FQPnQ6XLUUPUwn1blgGyvjOKy3s
 W7YwhSDIJnvdGgNIU0VA3P2dthJl9gi6sj6hjwDozw0dAILD+JDGYKg3fThg6ge+kRkYeZAYIyd
 QL6N3rcQtX6NdRCKRP15W0WmI4f2gE6u2XqICuswS7M8QwPVMQPWfJd2dI+M0Tpqicmmv6oE7gk
 PFybBBh7cnlvpZ3c2DK5fY8gVT/7AOpYxJyOwJyovKqGUlSRWKkUfALFVHANnqOybEnJ3javjEM
 6g=
X-Received: by 2002:a05:622a:1183:b0:50d:7eb4:4c5d with SMTP id
 d75a77b69052e-50e367752a9mr42783591cf.21.1776444208664; 
 Fri, 17 Apr 2026 09:43:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 d75a77b69052e-50e3afcf566sm1385581cf.1.2026.04.17.09.43.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2026 09:43:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8f848ebcbbso78681366b.0
 for <dev@dpdk.org>; Fri, 17 Apr 2026 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776444206; x=1777049006; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7WPeqEpXGN9SbM8PYxmxNeNFfy3bMUrx2ZwilUQeiKQ=;
 b=NG/BIeK+lhSnALHq/OzmnfHnFXsrX785qWb1pTdPDO8jvEpBbZIxwWEPV0qQg6n/oj
 YZfi9GEx3UE6YdwBM2y2tW7fcz0u6fBmNGn2vD52QxktYd1KGFwxq5OLjQrPLu272i0Q
 8P56cDyZ56e574w88TUunKWYpZExOr9AYO/eE=
X-Forwarded-Encrypted: i=1;
 AFNElJ+O+06cTb1Rrn6T+jSvgcIm0GHS0nfUtRD2oLbRvpELHX97AIkWqeAszVKvtE69maZxoXc=@dpdk.org
X-Received: by 2002:a17:907:c789:b0:ba5:3e3a:81ee with SMTP id
 a640c23a62f3a-ba53e3a831dmr7070066b.39.1776444206012; 
 Fri, 17 Apr 2026 09:43:26 -0700 (PDT)
X-Received: by 2002:a17:907:c789:b0:ba5:3e3a:81ee with SMTP id
 a640c23a62f3a-ba53e3a831dmr7067966b.39.1776444205328; Fri, 17 Apr 2026
 09:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260417045640.2217188-1-lyulin.2003@mail.ru>
In-Reply-To: <20260417045640.2217188-1-lyulin.2003@mail.ru>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Fri, 17 Apr 2026 12:43:07 -0400
X-Gm-Features: AQROBzAp5OrwQo2282LbuwG_h4JkEFyddw2ab3XThvNkcPJ3EhMBRz2hYkSvNkQ
Message-ID: <CA+BST0=Ntw_W_57uZ7DqLLFhxs9fvFsGBOiKGiZvy7GFwwubHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/bnxt: fix string bounds checks and format
 specifiers
To: Denis Lyulin <lyulin.2003@mail.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, dev@dpdk.org,
 stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000e4c51b064faaa513"
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

--000000000000e4c51b064faaa513
Content-Type: multipart/alternative; boundary="000000000000d29815064faaa516"

--000000000000d29815064faaa516
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 12:57=E2=80=AFAM Denis Lyulin <lyulin.2003@mail.ru>=
 wrote:

> Some strings, primarily for memory zone names, could
> exceed their buffer of size 32 (RTE_MEMZONE_NAMESIZE),
> because PCI_PRI_FMT format string is not strictly limited in size.
> This commit adds bounds checking via using snprintf instead
> of sprintf. It also adds use of appropriate format specifiers,
> which take width of integers in account.
>
> Fixes: 02a95625fe9c ("net/bnxt: add flow stats in extended stats")
> Cc: somnath.kotur@broadcom.com
> Cc: stable@dpdk.org
>
> Signed-off-by: Denis Lyulin <lyulin.2003@mail.ru>
>
Acked-by:  Kishore Padmanabha <kishore.padmanabha@broadcom.com>

> ---
>  drivers/net/bnxt/bnxt_ethdev.c | 34 +++++++++++++++++++---------------
>  drivers/net/bnxt/bnxt_hwrm.c   | 16 +++++++++-------
>  2 files changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt_ethdev.c
> b/drivers/net/bnxt/bnxt_ethdev.c
> index b677f9491d..bb02a2579b 100644
> --- a/drivers/net/bnxt/bnxt_ethdev.c
> +++ b/drivers/net/bnxt/bnxt_ethdev.c
> @@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
>
>         max_fc =3D bp->flow_stat->max_fc;
>
> -       sprintf(type, "bnxt_rx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
> -               pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> +       snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_in_" PCI_PRI_FMT=
,
> +               pdev->addr.domain, pdev->addr.bus,
> +               pdev->addr.devid, pdev->addr.function);
>         /* 4 bytes for each counter-id */
>         rc =3D bnxt_alloc_ctx_mem_buf(bp, type,
>                                     max_fc * 4,
> @@ -661,8 +662,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
>         if (rc)
>                 return rc;
>
> -       sprintf(type, "bnxt_rx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
> -               pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> +       snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_rx_fc_out_" PCI_PRI_FM=
T,
> +               pdev->addr.domain, pdev->addr.bus,
> +               pdev->addr.devid, pdev->addr.function);
>         /* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes
> byte_count */
>         rc =3D bnxt_alloc_ctx_mem_buf(bp, type,
>                                     max_fc * 16,
> @@ -670,8 +672,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
>         if (rc)
>                 return rc;
>
> -       sprintf(type, "bnxt_tx_fc_in_" PCI_PRI_FMT, pdev->addr.domain,
> -               pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> +       snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_tx_fc_in_" PCI_PRI_FMT=
,
> +               pdev->addr.domain, pdev->addr.bus,
> +               pdev->addr.devid, pdev->addr.function);
>         /* 4 bytes for each counter-id */
>         rc =3D bnxt_alloc_ctx_mem_buf(bp, type,
>                                     max_fc * 4,
> @@ -679,8 +682,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)
>         if (rc)
>                 return rc;
>
> -       sprintf(type, "bnxt_tx_fc_out_" PCI_PRI_FMT, pdev->addr.domain,
> -               pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> +       snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_tx_fc_out_" PCI_PRI_FM=
T,
> +               pdev->addr.domain, pdev->addr.bus,
> +               pdev->addr.devid, pdev->addr.function);
>         /* 16 bytes for each counter - 8 bytes pkt_count, 8 bytes
> byte_count */
>         rc =3D bnxt_alloc_ctx_mem_buf(bp, type,
>                                     max_fc * 16,
> @@ -3252,7 +3256,7 @@ bnxt_fw_version_get(struct rte_eth_dev *dev, char
> *fw_version, size_t fw_size)
>         uint8_t fw_rsvd =3D bp->fw_ver & 0xff;
>         int ret;
>
> -       ret =3D snprintf(fw_version, fw_size, "%d.%d.%d.%d",
> +       ret =3D snprintf(fw_version, fw_size, "%hhu.%hhu.%hhu.%hhu",
>                         fw_major, fw_minor, fw_updt, fw_rsvd);
>         if (ret < 0)
>                 return -EINVAL;
> @@ -5199,13 +5203,13 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp=
,
>                 RTE_ALIGN_MUL_CEIL(mem_size, BNXT_PAGE_SIZE) /
> BNXT_PAGE_SIZE;
>         rmem->page_size =3D BNXT_PAGE_SIZE;
>
> -       snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_pg_arr%s_%x_%d",
> +       snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_pg_arr%s_%hx_%hu",
>                  suffix, idx, bp->eth_dev->data->port_id);
>         ctx_pg->ctx_pg_arr =3D rte_zmalloc(name, sizeof(void *) *
> rmem->nr_pages, 0);
>         if (ctx_pg->ctx_pg_arr =3D=3D NULL)
>                 return -ENOMEM;
>
> -       snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_dma_arr%s_%x_%d",
> +       snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_dma_arr%s_%hx_%hu"=
,
>                  suffix, idx, bp->eth_dev->data->port_id);
>         ctx_pg->ctx_dma_arr =3D rte_zmalloc(name, sizeof(rte_iova_t *) *
> rmem->nr_pages, 0);
>         if (ctx_pg->ctx_dma_arr =3D=3D NULL)
> @@ -5219,7 +5223,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
>
>         if (rmem->nr_pages > 1) {
>                 snprintf(name, RTE_MEMZONE_NAMESIZE,
> -                        "bnxt_ctxpgtbl%s_%x_%d",
> +                        "bnxt_ctxpgtbl%s_%hx_%hu",
>                          suffix, idx, bp->eth_dev->data->port_id);
>                 name[RTE_MEMZONE_NAMESIZE - 1] =3D 0;
>                 mz =3D rte_memzone_lookup(name);
> @@ -5244,7 +5248,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,
>                 rmem->pg_tbl_mz =3D mz;
>         }
>
> -       snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_%s_%x_%d",
> +       snprintf(name, RTE_MEMZONE_NAMESIZE, "bnxt_ctx_%s_%hx_%hu",
>                  suffix, idx, bp->eth_dev->data->port_id);
>         mz =3D rte_memzone_lookup(name);
>         if (!mz) {
> @@ -5393,7 +5397,7 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)
>                 for (i =3D 0; i < w && rc =3D=3D 0; i++) {
>                         char name[RTE_MEMZONE_NAMESIZE] =3D {0};
>
> -                       sprintf(name, "_%d_%d", i, type);
> +                       snprintf(name, RTE_MEMZONE_NAMESIZE, "_%d_%hu", i=
,
> type);
>
>                         if (ctxm->entry_multiple)
>                                 entries =3D bnxt_roundup(ctxm->max_entrie=
s,
> @@ -6977,7 +6981,7 @@ static int bnxt_rep_port_probe(struct rte_pci_devic=
e
> *pci_dev,
>                 }
>
>                 /* representor port net_bdf_port */
> -               snprintf(name, sizeof(name), "net_%s_representor_%d",
> +               snprintf(name, sizeof(name), "net_%s_representor_%hu",
>                          pci_dev->device.name,
> eth_da->representor_ports[i]);
>
>                 if (rte_eth_dev_allocated(name) !=3D NULL) {
> diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
> index 0c82935de9..5c51108b65 100644
> --- a/drivers/net/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/bnxt/bnxt_hwrm.c
> @@ -1693,7 +1693,8 @@ int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t
> timeout)
>              (dev_caps_cfg &
>               HWRM_VER_GET_OUTPUT_DEV_CAPS_CFG_SHORT_CMD_REQUIRED)) ||
>             bp->hwrm_max_ext_req_len > HWRM_MAX_REQ_LEN) {
> -               sprintf(type, "bnxt_hwrm_short_" PCI_PRI_FMT,
> +               snprintf(type, RTE_MEMZONE_NAMESIZE,
> +                       "bnxt_hwrm_short_" PCI_PRI_FMT,
>                         bp->pdev->addr.domain, bp->pdev->addr.bus,
>                         bp->pdev->addr.devid, bp->pdev->addr.function);
>
> @@ -3526,8 +3527,9 @@ int bnxt_alloc_hwrm_resources(struct bnxt *bp)
>         struct rte_pci_device *pdev =3D bp->pdev;
>         char type[RTE_MEMZONE_NAMESIZE];
>
> -       sprintf(type, "bnxt_hwrm_" PCI_PRI_FMT, pdev->addr.domain,
> -               pdev->addr.bus, pdev->addr.devid, pdev->addr.function);
> +       snprintf(type, RTE_MEMZONE_NAMESIZE, "bnxt_hwrm_" PCI_PRI_FMT,
> +               pdev->addr.domain, pdev->addr.bus,
> +               pdev->addr.devid, pdev->addr.function);
>         bp->max_resp_len =3D BNXT_PAGE_SIZE;
>         bp->hwrm_cmd_resp_addr =3D rte_malloc(type, bp->max_resp_len, 0);
>         if (bp->hwrm_cmd_resp_addr =3D=3D NULL)
> @@ -6573,7 +6575,7 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt
> *bp)
>                 if (ctxm->instance_bmap)
>                         n =3D hweight32(ctxm->instance_bmap);
>
> -               sprintf(name, "bnxt_ctx_pgmem_%d_%d",
> +               snprintf(name, RTE_MEMZONE_NAMESIZE,
> "bnxt_ctx_pgmem_%hu_%hu",
>                         bp->eth_dev->data->port_id, type);
>                 ctxm->pg_info =3D rte_malloc(name, sizeof(*ctxm->pg_info)=
 *
> n,
>                                            RTE_CACHE_LINE_SIZE);
> @@ -7535,7 +7537,7 @@ int bnxt_hwrm_cfa_pair_exists(struct bnxt *bp,
> struct bnxt_representor *rep_bp)
>         }
>
>         HWRM_PREP(&req, HWRM_CFA_PAIR_INFO, BNXT_USE_CHIMP_MB);
> -       snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
> +       snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%hu",
>                  bp->eth_dev->data->name, rep_bp->vf_id);
>         req.flags =3D
>
> rte_cpu_to_le_32(HWRM_CFA_PAIR_INFO_INPUT_FLAGS_LOOKUP_TYPE);
> @@ -7564,7 +7566,7 @@ int bnxt_hwrm_cfa_pair_alloc(struct bnxt *bp, struc=
t
> bnxt_representor *rep_bp)
>
>         HWRM_PREP(&req, HWRM_CFA_PAIR_ALLOC, BNXT_USE_CHIMP_MB);
>         req.pair_mode =3D HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFL=
OW;
> -       snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
> +       snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%hu",
>                  bp->eth_dev->data->name, rep_bp->vf_id);
>
>         req.pf_b_id =3D rep_bp->parent_pf_idx;
> @@ -7609,7 +7611,7 @@ int bnxt_hwrm_cfa_pair_free(struct bnxt *bp, struct
> bnxt_representor *rep_bp)
>         }
>
>         HWRM_PREP(&req, HWRM_CFA_PAIR_FREE, BNXT_USE_CHIMP_MB);
> -       snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%d",
> +       snprintf(req.pair_name, sizeof(req.pair_name), "%svfr%hu",
>                  bp->eth_dev->data->name, rep_bp->vf_id);
>         req.pf_b_id =3D rep_bp->parent_pf_idx;
>         req.pair_mode =3D HWRM_CFA_PAIR_FREE_INPUT_PAIR_MODE_REP2FN_TRUFL=
OW;
> --
> 2.34.1
>
>

--000000000000d29815064faaa516
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 17,=
 2026 at 12:57=E2=80=AFAM Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@ma=
il.ru">lyulin.2003@mail.ru</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Some strings, primarily for memory zone names, co=
uld<br>
exceed their buffer of size 32 (RTE_MEMZONE_NAMESIZE),<br>
because PCI_PRI_FMT format string is not strictly limited in size.<br>
This commit adds bounds checking via using snprintf instead<br>
of sprintf. It also adds use of appropriate format specifiers,<br>
which take width of integers in account.<br>
<br>
Fixes: 02a95625fe9c (&quot;net/bnxt: add flow stats in extended stats&quot;=
)<br>
Cc: <a href=3D"mailto:somnath.kotur@broadcom.com" target=3D"_blank">somnath=
.kotur@broadcom.com</a><br>
Cc: <a href=3D"mailto:stable@dpdk.org" target=3D"_blank">stable@dpdk.org</a=
><br>
<br>
Signed-off-by: Denis Lyulin &lt;<a href=3D"mailto:lyulin.2003@mail.ru" targ=
et=3D"_blank">lyulin.2003@mail.ru</a>&gt;<br></blockquote><div><span style=
=3D"font-family:Calibri;font-size:11pt">Acked-by:=C2=A0=C2=A0Kishore
Padmanabha &lt;<a href=3D"mailto:kishore.padmanabha@broadcom.com">kishore.p=
admanabha@broadcom.com</a>&gt;</span>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
---<br>
=C2=A0drivers/net/bnxt/bnxt_ethdev.c | 34 +++++++++++++++++++--------------=
-<br>
=C2=A0drivers/net/bnxt/bnxt_hwrm.c=C2=A0 =C2=A0| 16 +++++++++-------<br>
=C2=A02 files changed, 28 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.=
c<br>
index b677f9491d..bb02a2579b 100644<br>
--- a/drivers/net/bnxt/bnxt_ethdev.c<br>
+++ b/drivers/net/bnxt/bnxt_ethdev.c<br>
@@ -652,8 +652,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_fc =3D bp-&gt;flow_stat-&gt;max_fc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(type, &quot;bnxt_rx_fc_in_&quot; PCI_PR=
I_FMT, pdev-&gt;addr.domain,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.bus, =
pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_rx_fc_in_&quot; PCI_PRI_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.domai=
n, pdev-&gt;addr.bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.devid=
, pdev-&gt;addr.function);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 4 bytes for each counter-id */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_alloc_ctx_mem_buf(bp, type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_fc * 4,<br>
@@ -661,8 +662,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(type, &quot;bnxt_rx_fc_out_&quot; PCI_P=
RI_FMT, pdev-&gt;addr.domain,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.bus, =
pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_rx_fc_out_&quot; PCI_PRI_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.domai=
n, pdev-&gt;addr.bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.devid=
, pdev-&gt;addr.function);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 16 bytes for each counter - 8 bytes pkt_coun=
t, 8 bytes byte_count */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_alloc_ctx_mem_buf(bp, type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_fc * 16,<br>
@@ -670,8 +672,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(type, &quot;bnxt_tx_fc_in_&quot; PCI_PR=
I_FMT, pdev-&gt;addr.domain,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.bus, =
pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_tx_fc_in_&quot; PCI_PRI_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.domai=
n, pdev-&gt;addr.bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.devid=
, pdev-&gt;addr.function);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 4 bytes for each counter-id */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_alloc_ctx_mem_buf(bp, type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_fc * 4,<br>
@@ -679,8 +682,9 @@ static int bnxt_init_fc_ctx_mem(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return rc;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(type, &quot;bnxt_tx_fc_out_&quot; PCI_P=
RI_FMT, pdev-&gt;addr.domain,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.bus, =
pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_tx_fc_out_&quot; PCI_PRI_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.domai=
n, pdev-&gt;addr.bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.devid=
, pdev-&gt;addr.function);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* 16 bytes for each counter - 8 bytes pkt_coun=
t, 8 bytes byte_count */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D bnxt_alloc_ctx_mem_buf(bp, type,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_fc * 16,<br>
@@ -3252,7 +3256,7 @@ bnxt_fw_version_get(struct rte_eth_dev *dev, char *fw=
_version, size_t fw_size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t fw_rsvd =3D bp-&gt;fw_ver &amp; 0xff;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D snprintf(fw_version, fw_size, &quot;%d.=
%d.%d.%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D snprintf(fw_version, fw_size, &quot;%hh=
u.%hhu.%hhu.%hhu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fw_major, fw_minor, fw_updt, fw_rsvd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
@@ -5199,13 +5203,13 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_ALIGN_MUL_CEIL(=
mem_size, BNXT_PAGE_SIZE) / BNXT_PAGE_SIZE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rmem-&gt;page_size =3D BNXT_PAGE_SIZE;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_ctx_pg_arr%s_%x_%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_ctx_pg_arr%s_%hx_%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0suffix, idx, =
bp-&gt;eth_dev-&gt;data-&gt;port_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx_pg-&gt;ctx_pg_arr =3D rte_zmalloc(name, siz=
eof(void *) * rmem-&gt;nr_pages, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctx_pg-&gt;ctx_pg_arr =3D=3D NULL)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_ctx_dma_arr%s_%x_%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_ctx_dma_arr%s_%hx_%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0suffix, idx, =
bp-&gt;eth_dev-&gt;data-&gt;port_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx_pg-&gt;ctx_dma_arr =3D rte_zmalloc(name, si=
zeof(rte_iova_t *) * rmem-&gt;nr_pages, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctx_pg-&gt;ctx_dma_arr =3D=3D NULL)<br>
@@ -5219,7 +5223,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rmem-&gt;nr_pages &gt; 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(name, RTE_=
MEMZONE_NAMESIZE,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;bnxt_ctxpgtbl%s_%x_%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;bnxt_ctxpgtbl%s_%hx_%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0suffix, idx, bp-&gt;eth_dev-&gt;data-&gt;port_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name[RTE_MEMZONE_NA=
MESIZE - 1] =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mz =3D rte_memzone_=
lookup(name);<br>
@@ -5244,7 +5248,7 @@ static int bnxt_alloc_ctx_mem_blk(struct bnxt *bp,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rmem-&gt;pg_tbl_mz =
=3D mz;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_ctx_%s_%x_%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_ctx_%s_%hx_%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0suffix, idx, =
bp-&gt;eth_dev-&gt;data-&gt;port_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mz =3D rte_memzone_lookup(name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mz) {<br>
@@ -5393,7 +5397,7 @@ int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt=
; w &amp;&amp; rc =3D=3D 0; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 char name[RTE_MEMZONE_NAMESIZE] =3D {0};<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sprintf(name, &quot;_%d_%d&quot;, i, type);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0snprintf(name, RTE_MEMZONE_NAMESIZE, &quot;_%d_%hu&quot;, i, type=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (ctxm-&gt;entry_multiple)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 entries =3D bnxt_roundup(ctxm-&gt;ma=
x_entries,<br>
@@ -6977,7 +6981,7 @@ static int bnxt_rep_port_probe(struct rte_pci_device =
*pci_dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* representor port=
 net_bdf_port */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, size=
of(name), &quot;net_%s_representor_%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, size=
of(name), &quot;net_%s_representor_%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pci_dev-&gt;<a href=3D"http://device.name" rel=3D"noreferr=
er" target=3D"_blank">device.name</a>, eth_da-&gt;representor_ports[i]);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rte_eth_dev_all=
ocated(name) !=3D NULL) {<br>
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c<br=
>
index 0c82935de9..5c51108b65 100644<br>
--- a/drivers/net/bnxt/bnxt_hwrm.c<br>
+++ b/drivers/net/bnxt/bnxt_hwrm.c<br>
@@ -1693,7 +1693,8 @@ int bnxt_hwrm_ver_get(struct bnxt *bp, uint32_t timeo=
ut)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dev_caps_cfg &amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HWRM_VER_GET_OUTPUT_DEV_CA=
PS_CFG_SHORT_CMD_REQUIRED)) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;hwrm_max_ext_req_len &gt; =
HWRM_MAX_REQ_LEN) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(type, &quot=
;bnxt_hwrm_short_&quot; PCI_PRI_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(type, RTE_=
MEMZONE_NAMESIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;bnxt_hwrm_short_&quot; PCI_PRI_FMT,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bp-&gt;pdev-&gt;addr.domain, bp-&gt;pdev-&gt;addr.bus,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bp-&gt;pdev-&gt;addr.devid, bp-&gt;pdev-&gt;addr.function);<br>
<br>
@@ -3526,8 +3527,9 @@ int bnxt_alloc_hwrm_resources(struct bnxt *bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct rte_pci_device *pdev =3D bp-&gt;pdev;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char type[RTE_MEMZONE_NAMESIZE];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(type, &quot;bnxt_hwrm_&quot; PCI_PRI_FM=
T, pdev-&gt;addr.domain,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.bus, =
pdev-&gt;addr.devid, pdev-&gt;addr.function);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(type, RTE_MEMZONE_NAMESIZE, &quot;bnxt=
_hwrm_&quot; PCI_PRI_FMT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.domai=
n, pdev-&gt;addr.bus,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pdev-&gt;addr.devid=
, pdev-&gt;addr.function);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;max_resp_len =3D BNXT_PAGE_SIZE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;hwrm_cmd_resp_addr =3D rte_malloc(type, =
bp-&gt;max_resp_len, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bp-&gt;hwrm_cmd_resp_addr =3D=3D NULL)<br>
@@ -6573,7 +6575,7 @@ static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ctxm-&gt;instan=
ce_bmap)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 n =3D hweight32(ctxm-&gt;instance_bmap);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(name, &quot=
;bnxt_ctx_pgmem_%d_%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name, RTE_=
MEMZONE_NAMESIZE, &quot;bnxt_ctx_pgmem_%hu_%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bp-&gt;eth_dev-&gt;data-&gt;port_id, type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctxm-&gt;pg_info =
=3D rte_malloc(name, sizeof(*ctxm-&gt;pg_info) * n,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0RTE_CACHE_LINE_SIZE);<br>
@@ -7535,7 +7537,7 @@ int bnxt_hwrm_cfa_pair_exists(struct bnxt *bp, struct=
 bnxt_representor *rep_bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 HWRM_PREP(&amp;req, HWRM_CFA_PAIR_INFO, BNXT_US=
E_CHIMP_MB);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(req.pair_name, sizeof(req.pair_name), =
&quot;%svfr%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(req.pair_name, sizeof(req.pair_name), =
&quot;%svfr%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;eth_de=
v-&gt;data-&gt;name, rep_bp-&gt;vf_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req.flags =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rte_cpu_to_le_32(HW=
RM_CFA_PAIR_INFO_INPUT_FLAGS_LOOKUP_TYPE);<br>
@@ -7564,7 +7566,7 @@ int bnxt_hwrm_cfa_pair_alloc(struct bnxt *bp, struct =
bnxt_representor *rep_bp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 HWRM_PREP(&amp;req, HWRM_CFA_PAIR_ALLOC, BNXT_U=
SE_CHIMP_MB);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req.pair_mode =3D HWRM_CFA_PAIR_FREE_INPUT_PAIR=
_MODE_REP2FN_TRUFLOW;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(req.pair_name, sizeof(req.pair_name), =
&quot;%svfr%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(req.pair_name, sizeof(req.pair_name), =
&quot;%svfr%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;eth_de=
v-&gt;data-&gt;name, rep_bp-&gt;vf_id);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req.pf_b_id =3D rep_bp-&gt;parent_pf_idx;<br>
@@ -7609,7 +7611,7 @@ int bnxt_hwrm_cfa_pair_free(struct bnxt *bp, struct b=
nxt_representor *rep_bp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 HWRM_PREP(&amp;req, HWRM_CFA_PAIR_FREE, BNXT_US=
E_CHIMP_MB);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(req.pair_name, sizeof(req.pair_name), =
&quot;%svfr%d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(req.pair_name, sizeof(req.pair_name), =
&quot;%svfr%hu&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bp-&gt;eth_de=
v-&gt;data-&gt;name, rep_bp-&gt;vf_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req.pf_b_id =3D rep_bp-&gt;parent_pf_idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 req.pair_mode =3D HWRM_CFA_PAIR_FREE_INPUT_PAIR=
_MODE_REP2FN_TRUFLOW;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000d29815064faaa516--

--000000000000e4c51b064faaa513
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
oIHHMC8GCSqGSIb3DQEJBDEiBCC9vxYX9U0iHEGo5DlrUiu/7Am4+n+10InKWIaIjC+zdjAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTcxNjQzMjZaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCuLKS2f02L
1BCKnfKnTvZdbv8KpHHBdqq1Bo1liH2MXHTUWVH8+69qhiKXSO/by8EOxYYHd676Rxd8D4wWpdlo
BT1gJC4l3lSmcMzyq/Gi6R8azSpdNaUhfLjnkuDeigmSyu5Fg0R9JFJTC1mUhtT6y2HkCc0RZaJ5
oxUfsnjw5m7gcl90W/3nVjzNIyLHQKAsZZQLSFhgQhmUkBxyDAEXzdi+HH4BxRn4x4MncFn9dsmo
SfSYFnu3xHqzmVG0s3vdQvDVw8zdaKDuKN1ywynk0ibtKT0NWIbQDqfo56oxRKImbKbSbmxIXT/R
2K7zON41sWmTGNn0/lcEy5ZeOdg/
--000000000000e4c51b064faaa513--
