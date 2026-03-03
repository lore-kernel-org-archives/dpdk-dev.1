Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E95EDEBE0
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 18:14:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8313440EE7;
	Tue,  3 Mar 2026 19:14:38 +0100 (CET)
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98]) by mails.dpdk.org (Postfix) with ESMTP id 14E4F40268
 for <dev@dpdk.org>; Tue,  3 Mar 2026 19:14:37 +0100 (CET)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-94dcf70af41so1359562241.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 10:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772561676; x=1773166476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6slqBePXR2XhQIJ0g4MUC87pU6zjzPLQveBqDaQ9eU=;
 b=cD3ui7VAvRIJ608bPLgushoyigr/Due8zaovXr5QZKaXdeJVT+d5mi7XutY6Xo2TE1
 de6L47WEVxt6Se+2MTIXmY77TI9NZkl0GGxym88xmzgQ/fGhKZzQcQsTfQAJDwwJwUii
 P7VBejbulSRSsUpqWtZVreOxQYtLllN7y9LNrSrmGSGh3ufZ/MK0xliGAe59yOlykoug
 rNRPRaWV5jhnJTxwCHKpaffQ1I3Ri0h82Tcd6hPA5AOepTmJnSORaVSUkqvkKIA6RL6O
 EYd3hPABUnc3ZNqgEi2ZrZsxgcbcmCvTLecFVoem1ZPMUQZgcg2HrvIVqD0e6jucgt5P
 uWSg==
X-Gm-Message-State: AOJu0YzuI0PBGWXbBY8bmZDaRw22eSjzz+q1hJg1izSlarIyxA1HlJI8
 hjdeowZMRHAQVhj0W+8lWUzPdj/RW99Q8DPhquMwqACX7GlXVC1at6M0N1aDewlG43QqVvS44hk
 CMZwlL4a3FOAdVmD8MdwjYQy5UIwn3OLtfOxg3DCtrXPxpcV2nc2Vwit6QVhX5GDY/y28uiLSTa
 KZ+KAL4yEW+/dVN4jMDqrSCaSAgsOhiGD1WaeIl2ywxHL0gASBOZgi/XR+W1GJbhAWHZ4g30VY4
 0XT9w==
X-Gm-Gg: ATEYQzxqPkdjr23oVdJXB8tZ7X4n30mbgHdoojN7wLRo9vKCnZ74+yIljR3r8v/2bfe
 JB6/PK0qbKRTVyPneSI8dKd+yDj0U0JTkMvBpAO5Sp0NiasexS8QL8YrKqA9dXlVtr8WexOY1Rh
 xhb89EAmjUIMcpHiDYMdXKN92JWzz6frucp3i/RiVcB2ArZHnC9MYbjwW7ntdy0sjIwWRipPS3q
 nfP7E0itQEAIy70sNSqsJIkb2jXPlgJ2NtNnISaHvEsTa0nHYtvLko/lP7VbKkotBVVxDB6/j/y
 flTMAuQnhc9Sw4TZRTiuccSYZ0zOekXiXwRUPDQj4nKsvBH2+3m4JpFFg10lb7MSmFW1ATJqtsf
 0YiDMAiBdJgczq75pAwD0dmTy0Z6kumHbKXmOgq8Lq+DgNLbfufJJKHXC/TO//YI0HI+OhXLfJK
 UtFzxhwdKwRXRqykmRD0mo1mh9AG97U3nkyG9ZzJKhdEsIPUz6NAshJ9saiAmT2r+KkgU=
X-Received: by 2002:a05:6102:3a11:b0:5de:db29:5c07 with SMTP id
 ada2fe7eead31-5ff324d892dmr6527037137.19.1772561676050; 
 Tue, 03 Mar 2026 10:14:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-5ff1e9f156fsm1809204137.4.2026.03.03.10.14.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2026 10:14:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-65ba5ca08eeso1826867a12.0
 for <dev@dpdk.org>; Tue, 03 Mar 2026 10:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772561674; cv=none;
 d=google.com; s=arc-20240605;
 b=QZ4cuN4Sz0obWmhPhUoCsrByuHaEtqO5p2/Heexq6XJ4Z00U88TnYhfnAPR/BMNFKq
 Wd4HvBhKP4Dgh/U/QV5WJ+4GXWmEeYHfxeIjQUnpiRY0i0Dib/o32rAcBBYuXnb0sgoy
 lEwR5t5GBjPpYK6HU5ipW5z4gVtXI6PvOW2Lz3Jkd+1qm6fqQZ1YBBtiwQzOdaSrLLRD
 fpFrn5TfwGp64KB2OEjZCJxn5enY2D1WDPWnthVfMGtD+M4vhuQ0FoVQiA8EFJZhuAr1
 LanKGShotkWU1xk6LCF1golcnkMWKMLeJW+jG1Cdh35JMe1eQ2CoCMtd2brW0cRDtO8D
 MjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V6slqBePXR2XhQIJ0g4MUC87pU6zjzPLQveBqDaQ9eU=;
 fh=ZM/Q+maMBufmZ4AECQZKz7wfFKp42pv804lz4VHaNO8=;
 b=IVwlIAEDnXSenpi2fZoMBwW3NbN7bU3BK7ntlFLaMKROnJRWvU6ApixDf35N80RSE+
 8jsjVQuX+lwoNSjPLbbCax/p41CfVtRF7hJ4fJPwNbDpjFZhMUz4MU5Tvs6ymRf1kMQV
 R9Qmzh/trTgzPKVP+SaATz0unEvD2sWc1DvhFK2LK4geVySGExkWW18c2EAb454mBL6q
 N4FFre2NhRJ9spkxvMejPpkJtmECkvGwP2ssAIEXY8WN7jvamOG/2y3XZN2Rlo1aryp5
 gtbvqqkGq7ZwGbQ6vgH6WPIj7Pp463g6DGgL7uF69BjqavDrQ+da1KbBzw6gBA4Kgig4
 F53g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772561674; x=1773166474; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V6slqBePXR2XhQIJ0g4MUC87pU6zjzPLQveBqDaQ9eU=;
 b=hIDfNVg+xfwtavanLr5nbIOr4TPsENVMdEB3M9iXNQhl0BOSCenkzfT0GrpFWtHeN7
 jEVzWOelcQIjc08j5B0zKu36PCvgUrB4/dCmtWBN4cLdVmlIEA7kQm3eGYaM2XNuq1i0
 6sCZIAzhtMbvbqY/UVVM0xqHzGie/0kipSyl4=
X-Received: by 2002:a05:6402:3988:b0:65c:23f0:a7f7 with SMTP id
 4fb4d7f45d1cf-65fdddef448mr7297332a12.20.1772561674217; 
 Tue, 03 Mar 2026 10:14:34 -0800 (PST)
X-Received: by 2002:a05:6402:3988:b0:65c:23f0:a7f7 with SMTP id
 4fb4d7f45d1cf-65fdddef448mr7297311a12.20.1772561673541; Tue, 03 Mar 2026
 10:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20260303173156.204872-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260303174219.204977-1-Mohammad-Shuab.Siddique@broadcom.com>
In-Reply-To: <20260303174219.204977-1-Mohammad-Shuab.Siddique@broadcom.com>
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Date: Tue, 3 Mar 2026 13:14:16 -0500
X-Gm-Features: AaiRm52v9QeDBzuDqckZY5qZ83fBtf3hopgO1QsEMoySyjbFqw_RFJwMycdoRYU
Message-ID: <CA+BST0nENuxNg5R3cgec8b6T8++bA_puqsPNoqL_G2bQ3xZNcQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/bnxt: add multi-doorbell support
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, stable@dpdk.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000f81996064c22acc7"
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

--000000000000f81996064c22acc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 12:41=E2=80=AFPM Mohammad Shuab Siddique
<mohammad-shuab.siddique@broadcom.com> wrote:
>
> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
>
> Add multi-doorbell support to spread doorbell accesses across
> multiple doorbell pages for improved performance on P5/P7 chips.
>
> Detect capability via HWRM_FUNC_QCAPS
> Round-robin DPI assignment for NQ rings per device
> TX rings inherit DPI from parent NQ
> RX/CQ rings use privileged DPI 0
> P7: DPI 0=3Dlegacy, DPI 1=3Dpush, DPI 2+ for multi-DB
> P5: DPI 0=3Dlegacy, DPI 1+ for multi-DB
>
> Cc: stable@dpdk.org
>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.=
com>
Acked-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> ---
>  drivers/net/bnxt/bnxt.h                | 13 +++++
>  drivers/net/bnxt/bnxt_cpr.h            |  1 +
>  drivers/net/bnxt/bnxt_hwrm.c           | 51 +++++++++++++++++--
>  drivers/net/bnxt/bnxt_hwrm.h           |  2 +-
>  drivers/net/bnxt/bnxt_mpc.c            |  4 +-
>  drivers/net/bnxt/bnxt_ring.c           | 70 ++++++++++++++++++--------
>  drivers/net/bnxt/bnxt_ring.h           |  3 +-
>  drivers/net/bnxt/bnxt_rxr.h            |  1 +
>  drivers/net/bnxt/bnxt_txr.h            |  1 +
>  drivers/net/bnxt/hsi_struct_def_dpdk.h | 30 +++++++++++
>  10 files changed, 147 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
> index 83ae151066..30baabcf92 100644
> --- a/drivers/net/bnxt/bnxt.h
> +++ b/drivers/net/bnxt/bnxt.h
> @@ -433,6 +433,13 @@ struct bnxt_coal {
>  #define DB_PF_OFFSET                   0x10000
>  #define DB_VF_OFFSET                   0x4000
>
> +#define BNXT_PRIVILEGED_DPI            0
> +#define BNXT_RESERVED_DPI_ONE          1
> +#define BNXT_RESERVED_DPI_TWO          2
> +#define BNXT_DEFAULT_DB_PAGE_SIZE      4096
> +
> +#define BNXT_KB_TO_BYTES(kb)           ((kb) * 1024)
> +
>  #define BNXT_RSS_TBL_SIZE_P5           512U
>  #define BNXT_RSS_ENTRIES_PER_CTX_P5    64
>  #define BNXT_MAX_RSS_CTXTS_P5 \
> @@ -873,6 +880,7 @@ struct bnxt {
>  #define BNXT_FW_CAP_RX_ALL_PKT_TS      BIT(11)
>  #define BNXT_FW_CAP_BACKING_STORE_V2   BIT(12)
>  #define BNXT_FW_CAP_RX_RATE_PROFILE    BIT(17)
> +#define BNXT_FW_CAP_MULTI_DB           BIT(18)
>  #define BNXT_FW_BACKING_STORE_V2_EN(bp)        \
>         ((bp)->fw_cap & BNXT_FW_CAP_BACKING_STORE_V2)
>  #define BNXT_FW_BACKING_STORE_V1_EN(bp)        \
> @@ -1079,6 +1087,11 @@ struct bnxt {
>         struct rte_eth_rss_conf rss_conf; /* RSS configuration. */
>         uint16_t                tunnel_disable_flag; /* tunnel stateless =
offloads status */
>         uint8_t                 chip_rev;
> +       uint16_t                l2_db_multi_page_size_kb;       /* Multi-=
L2 DB BAR size in KB */
> +       uint16_t                db_page_size;                   /* DB pag=
e size (typically 4KB) */
> +       uint8_t                 nq_dpi_start;                   /* Starti=
ng DPI for NQ rings */
> +       uint8_t                 nq_dpi_count;                   /* Number=
 of DPI pages for NQ */
> +       uint8_t                 nq_dpi_counter;                 /* Round-=
robin counter for NQ DPI */
>  };
>
>  static
> diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
> index 94f449e8b5..858ee15c47 100644
> --- a/drivers/net/bnxt/bnxt_cpr.h
> +++ b/drivers/net/bnxt/bnxt_cpr.h
> @@ -89,6 +89,7 @@ struct bnxt_cp_ring_info {
>         struct bnxt_ring        *cp_ring_struct;
>         bool                    valid;
>         uint32_t                epoch;
> +       uint8_t                 dpi;
>  };
>
>  #define RX_CMP_L2_ERRORS                                               \
> diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
> index 0cef22b5ec..7c58727e59 100644
> --- a/drivers/net/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/bnxt/bnxt_hwrm.c
> @@ -1254,6 +1254,9 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
>         if (flags_ext3 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_RX_RATE_PROFIL=
E_SEL_SUPPORTED)
>                 bp->fw_cap |=3D BNXT_FW_CAP_RX_RATE_PROFILE;
>
> +       if (flags_ext3 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MULTI_L2_DB_SU=
PPORTED)
> +               bp->fw_cap |=3D BNXT_FW_CAP_MULTI_DB;
> +
>         /* This block should be kept at the end of this function because =
it
>          * sends another hwrm msg.
>          */
> @@ -2176,7 +2179,7 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
>                          struct bnxt_ring *ring,
>                          uint32_t ring_type, uint32_t map_index,
>                          uint32_t stats_ctx_id, uint32_t cmpl_ring_id,
> -                        uint16_t tx_cosq_id)
> +                        uint16_t tx_cosq_id, uint16_t dpi)
>  {
>         int rc =3D 0;
>         uint32_t enables =3D 0;
> @@ -2280,6 +2283,11 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
>                 HWRM_UNLOCK();
>                 return -EINVAL;
>         }
> +
> +       if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB) {
> +               req.dpi =3D rte_cpu_to_le_16(dpi);
> +               enables |=3D HWRM_RING_ALLOC_INPUT_ENABLES_DPI_VALID;
> +       }
>         req.enables =3D rte_cpu_to_le_32(enables);
>
>         rc =3D bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHI=
MP_MB);
> @@ -4195,12 +4203,15 @@ int bnxt_set_hwrm_link_config(struct bnxt *bp, bo=
ol link_up)
>
>  int bnxt_hwrm_func_qcfg(struct bnxt *bp, uint16_t *mtu)
>  {
> -       struct hwrm_func_qcfg_input req =3D {0};
>         struct hwrm_func_qcfg_output *resp =3D bp->hwrm_cmd_resp_addr;
> +       struct hwrm_func_qcfg_input req =3D {0};
> +       uint16_t l2_db_multi_kb;
> +       uint16_t total_pages;
> +       uint16_t svif_info;
>         uint16_t flags;
>         int rc =3D 0;
> +
>         bp->func_svif =3D BNXT_SVIF_INVALID;
> -       uint16_t svif_info;
>
>         HWRM_PREP(&req, HWRM_FUNC_QCFG, BNXT_USE_CHIMP_MB);
>         req.fid =3D rte_cpu_to_le_16(0xffff);
> @@ -4246,9 +4257,39 @@ int bnxt_hwrm_func_qcfg(struct bnxt *bp, uint16_t =
*mtu)
>                 bp->flags &=3D ~BNXT_FLAG_NPAR_PF;
>                 break;
>         }
> -
>         bp->legacy_db_size =3D
> -               rte_le_to_cpu_16(resp->legacy_l2_db_size_kb) * 1024;
> +               BNXT_KB_TO_BYTES(rte_le_to_cpu_16(resp->legacy_l2_db_size=
_kb));
> +
> +       /* Configure multi-doorbell if supported */
> +       if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB) {
> +               l2_db_multi_kb =3D rte_le_to_cpu_16(resp->l2_db_multi_pag=
e_size_kb);
> +               bp->l2_db_multi_page_size_kb =3D l2_db_multi_kb ? l2_db_m=
ulti_kb :
> +                       rte_le_to_cpu_16(resp->l2_doorbell_bar_size_kb);
> +
> +               if (bp->l2_db_multi_page_size_kb > 0) {
> +                       bp->db_page_size =3D BNXT_DEFAULT_DB_PAGE_SIZE;
> +                       total_pages =3D BNXT_KB_TO_BYTES(bp->l2_db_multi_=
page_size_kb) /
> +                                       bp->db_page_size;
> +
> +                       /* P7: DPI 0=3Dlegacy, DPI 1=3Dpush reserved; P5:=
 DPI 0=3Dlegacy */
> +                       bp->nq_dpi_start =3D BNXT_CHIP_P7(bp) ?
> +                               BNXT_RESERVED_DPI_TWO : BNXT_RESERVED_DPI=
_ONE;
> +                       bp->nq_dpi_count =3D (total_pages > bp->nq_dpi_st=
art) ?
> +                               (total_pages - bp->nq_dpi_start) : 0;
> +                       bp->nq_dpi_counter =3D 0;
> +                       PMD_DRV_LOG_LINE(INFO,
> +                                       "Multi-doorbell: %u KB, "
> +                                       "DPI range %u-%u (%u pages)",
> +                                       bp->l2_db_multi_page_size_kb,
> +                                       bp->nq_dpi_start,
> +                                       bp->nq_dpi_start + bp->nq_dpi_cou=
nt - 1,
> +                                       bp->nq_dpi_count);
> +               } else {
> +                       PMD_DRV_LOG_LINE(INFO,
> +                                       "Multi-doorbell supported "
> +                                       "but no pages allocated");
> +               }
> +       }
>
>         HWRM_UNLOCK();
>
> diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
> index ecb6335b3d..fc56223ab4 100644
> --- a/drivers/net/bnxt/bnxt_hwrm.h
> +++ b/drivers/net/bnxt/bnxt_hwrm.h
> @@ -221,7 +221,7 @@ int bnxt_hwrm_ring_alloc(struct bnxt *bp,
>                          struct bnxt_ring *ring,
>                          uint32_t ring_type, uint32_t map_index,
>                          uint32_t stats_ctx_id, uint32_t cmpl_ring_id,
> -                        uint16_t tx_cosq_id);
> +                        uint16_t tx_cosq_id, uint16_t dpi);
>  int bnxt_hwrm_ring_free(struct bnxt *bp,
>                         struct bnxt_ring *ring, uint32_t ring_type,
>                         uint16_t cp_ring_id);
> diff --git a/drivers/net/bnxt/bnxt_mpc.c b/drivers/net/bnxt/bnxt_mpc.c
> index 259066fa61..d77f9dd308 100644
> --- a/drivers/net/bnxt/bnxt_mpc.c
> +++ b/drivers/net/bnxt/bnxt_mpc.c
> @@ -502,7 +502,7 @@ static int bnxt_mpc_ring_alloc_one(struct bnxt *bp, e=
num bnxt_mpc_chnl chnl_id)
>                                   map_index,
>                                   cpr->hw_stats_ctx_id,
>                                   cp_ring->fw_ring_id,
> -                                 MPC_HW_COS_ID);
> +                                 MPC_HW_COS_ID, BNXT_PRIVILEGED_DPI);
>         if (rc) {
>                 PMD_DRV_LOG_LINE(ERR, "mpc ring %d tx ring alloc failed r=
c:%d!",
>                             chnl_id, rc);
> @@ -510,7 +510,7 @@ static int bnxt_mpc_ring_alloc_one(struct bnxt *bp, e=
num bnxt_mpc_chnl chnl_id)
>         }
>
>         bnxt_set_db(bp, &mpr->db, HWRM_RING_ALLOC_INPUT_RING_TYPE_TX, chn=
l_id,
> -                   ring->fw_ring_id, ring->ring_mask);
> +                   ring->fw_ring_id, ring->ring_mask, BNXT_PRIVILEGED_DP=
I);
>
>         bnxt_hwrm_set_ring_coal(bp, &coal, cp_ring->fw_ring_id);
>
> diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
> index b6d411a931..ccca779b97 100644
> --- a/drivers/net/bnxt/bnxt_ring.c
> +++ b/drivers/net/bnxt/bnxt_ring.c
> @@ -353,8 +353,11 @@ void bnxt_set_db(struct bnxt *bp,
>                  uint32_t ring_type,
>                  uint32_t map_idx,
>                  uint32_t fid,
> -                uint32_t ring_mask)
> +                uint32_t ring_mask,
> +                uint16_t dpi)
>  {
> +       uint64_t dpi_offset;
> +
>         if (BNXT_CHIP_P5_P7(bp)) {
>                 int db_offset =3D DB_PF_OFFSET;
>                 switch (ring_type) {
> @@ -379,8 +382,14 @@ void bnxt_set_db(struct bnxt *bp,
>                 } else if (BNXT_VF(bp)) {
>                         db_offset =3D DB_VF_OFFSET;
>                 }
> -
>                 db->doorbell =3D (char *)bp->doorbell_base + db_offset;
> +
> +               if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB &&
> +                               dpi !=3D BNXT_PRIVILEGED_DPI) {
> +                       dpi_offset =3D (dpi - bp->nq_dpi_start) *
> +                                       bp->db_page_size;
> +                       db->doorbell =3D (char *)db->doorbell + dpi_offse=
t;
> +               }
>                 db->db_key64 |=3D (uint64_t)fid << DBR_XID_SFT;
>                 db->db_64 =3D true;
>         } else {
> @@ -404,32 +413,33 @@ void bnxt_set_db(struct bnxt *bp,
>  int bnxt_alloc_cmpl_ring(struct bnxt *bp, int queue_index,
>                          struct bnxt_cp_ring_info *cpr)
>  {
> -       struct bnxt_ring *cp_ring =3D cpr->cp_ring_struct;
> -       uint32_t nq_ring_id =3D HWRM_NA_SIGNATURE;
>         int cp_ring_index =3D queue_index + BNXT_RX_VEC_START;
>         struct bnxt_cp_ring_info *nqr =3D bp->rxtx_nq_ring;
> +       struct bnxt_ring *cp_ring =3D cpr->cp_ring_struct;
> +       uint32_t nq_ring_id =3D HWRM_NA_SIGNATURE;
> +       uint8_t dpi =3D BNXT_PRIVILEGED_DPI;
>         uint8_t ring_type;
>         int rc =3D 0;
>
>         ring_type =3D HWRM_RING_ALLOC_INPUT_RING_TYPE_L2_CMPL;
>
>         if (BNXT_HAS_NQ(bp)) {
> -               if (nqr) {
> -                       nq_ring_id =3D nqr->cp_ring_struct->fw_ring_id;
> -               } else {
> +               if (!nqr) {
>                         PMD_DRV_LOG_LINE(ERR, "NQ ring is NULL");
>                         return -EINVAL;
>                 }
> +               nq_ring_id =3D nqr->cp_ring_struct->fw_ring_id;
>         }
>
> +       cpr->dpi =3D dpi;
>         rc =3D bnxt_hwrm_ring_alloc(bp, cp_ring, ring_type, cp_ring_index=
,
> -                                 HWRM_NA_SIGNATURE, nq_ring_id, 0);
> +                                 HWRM_NA_SIGNATURE, nq_ring_id, 0, dpi);
>         if (rc)
>                 return rc;
>
>         cpr->cp_raw_cons =3D 0;
>         bnxt_set_db(bp, &cpr->cp_db, ring_type, cp_ring_index,
> -                   cp_ring->fw_ring_id, cp_ring->ring_mask);
> +                   cp_ring->fw_ring_id, cp_ring->ring_mask, dpi);
>         bnxt_db_cq(cpr);
>
>         return 0;
> @@ -437,10 +447,12 @@ int bnxt_alloc_cmpl_ring(struct bnxt *bp, int queue=
_index,
>
>  int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
>  {
> +       int ring_index =3D BNXT_NUM_ASYNC_CPR(bp);
> +       uint8_t dpi =3D BNXT_PRIVILEGED_DPI;
>         struct bnxt_cp_ring_info *nqr;
>         struct bnxt_ring *ring;
> -       int ring_index =3D BNXT_NUM_ASYNC_CPR(bp);
>         uint8_t ring_type;
> +       uint8_t offset;
>         int rc =3D 0;
>
>         if (!BNXT_HAS_NQ(bp) || bp->rxtx_nq_ring)
> @@ -481,8 +493,18 @@ int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
>
>         ring_type =3D HWRM_RING_ALLOC_INPUT_RING_TYPE_NQ;
>
> +       /* Assign DPI using round-robin if multi-doorbell is enabled */
> +       if (bp->fw_cap & BNXT_FW_CAP_MULTI_DB && bp->nq_dpi_count > 0) {
> +               offset =3D bp->nq_dpi_counter % bp->nq_dpi_count;
> +               dpi =3D bp->nq_dpi_start + offset;
> +               bp->nq_dpi_counter++;
> +               PMD_DRV_LOG_LINE(DEBUG, "NQ ring assigned DPI %u", dpi);
> +       }
> +
> +       nqr->dpi =3D dpi;
> +
>         rc =3D bnxt_hwrm_ring_alloc(bp, ring, ring_type, ring_index,
> -                                 HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0=
);
> +                                 HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0=
, dpi);
>         if (rc) {
>                 rte_free(ring);
>                 rte_free(nqr);
> @@ -490,7 +512,7 @@ int bnxt_alloc_rxtx_nq_ring(struct bnxt *bp)
>         }
>
>         bnxt_set_db(bp, &nqr->cp_db, ring_type, ring_index,
> -                   ring->fw_ring_id, ring->ring_mask);
> +                   ring->fw_ring_id, ring->ring_mask, dpi);
>         bnxt_db_nq(nqr);
>
>         bp->rxtx_nq_ring =3D nqr;
> @@ -523,13 +545,16 @@ static int bnxt_alloc_rx_ring(struct bnxt *bp, int =
queue_index)
>         struct bnxt_rx_ring_info *rxr =3D rxq->rx_ring;
>         struct bnxt_ring *ring =3D rxr->rx_ring_struct;
>         uint8_t ring_type;
> +       uint16_t dpi;
>         int rc =3D 0;
>
>         ring_type =3D HWRM_RING_ALLOC_INPUT_RING_TYPE_RX;
> +       dpi =3D BNXT_PRIVILEGED_DPI;
> +       rxr->dpi =3D dpi;
>
>         rc =3D bnxt_hwrm_ring_alloc(bp, ring, ring_type,
>                                   queue_index, cpr->hw_stats_ctx_id,
> -                                 cp_ring->fw_ring_id, 0);
> +                                 cp_ring->fw_ring_id, 0, dpi);
>         if (rc)
>                 return rc;
>
> @@ -537,7 +562,7 @@ static int bnxt_alloc_rx_ring(struct bnxt *bp, int qu=
eue_index)
>         if (BNXT_HAS_RING_GRPS(bp))
>                 bp->grp_info[queue_index].rx_fw_ring_id =3D ring->fw_ring=
_id;
>         bnxt_set_db(bp, &rxr->rx_db, ring_type, queue_index, ring->fw_rin=
g_id,
> -                   ring->ring_mask);
> +                   ring->ring_mask, dpi);
>         bnxt_db_write(&rxr->rx_db, rxr->rx_raw_prod);
>
>         return 0;
> @@ -568,7 +593,8 @@ static int bnxt_alloc_rx_agg_ring(struct bnxt *bp, in=
t queue_index)
>         }
>
>         rc =3D bnxt_hwrm_ring_alloc(bp, ring, ring_type, map_idx,
> -                                 hw_stats_ctx_id, cp_ring->fw_ring_id, 0=
);
> +                                 hw_stats_ctx_id, cp_ring->fw_ring_id, 0=
,
> +                                 BNXT_PRIVILEGED_DPI);
>
>         if (rc)
>                 return rc;
> @@ -578,7 +604,7 @@ static int bnxt_alloc_rx_agg_ring(struct bnxt *bp, in=
t queue_index)
>         if (BNXT_HAS_RING_GRPS(bp))
>                 bp->grp_info[queue_index].ag_fw_ring_id =3D ring->fw_ring=
_id;
>         bnxt_set_db(bp, &rxr->ag_db, ring_type, map_idx, ring->fw_ring_id=
,
> -                   ring->ring_mask);
> +                   ring->ring_mask, BNXT_PRIVILEGED_DPI);
>         bnxt_db_write(&rxr->ag_db, rxr->ag_raw_prod);
>
>         return 0;
> @@ -796,14 +822,16 @@ int bnxt_alloc_async_cp_ring(struct bnxt *bp)
>                 ring_type =3D HWRM_RING_ALLOC_INPUT_RING_TYPE_L2_CMPL;
>
>         rc =3D bnxt_hwrm_ring_alloc(bp, cp_ring, ring_type, 0,
> -                                 HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0=
);
> +                                 HWRM_NA_SIGNATURE, HWRM_NA_SIGNATURE, 0=
,
> +                                 BNXT_PRIVILEGED_DPI);
>
>         if (rc)
>                 return rc;
>
>         cpr->cp_raw_cons =3D 0;
> +       cpr->dpi =3D BNXT_PRIVILEGED_DPI;
>         bnxt_set_db(bp, &cpr->cp_db, ring_type, 0,
> -                   cp_ring->fw_ring_id, cp_ring->ring_mask);
> +                   cp_ring->fw_ring_id, cp_ring->ring_mask, BNXT_PRIVILE=
GED_DPI);
>
>         if (BNXT_HAS_NQ(bp))
>                 bnxt_db_nq(cpr);
> @@ -900,17 +928,19 @@ int bnxt_alloc_hwrm_tx_ring(struct bnxt *bp, int qu=
eue_index)
>         else
>                 tx_cosq_id =3D bp->tx_cosq_id[0];
>
> +       /* TX ring inherits DPI from parent NQ */
> +       txr->dpi =3D bp->rxtx_nq_ring ? bp->rxtx_nq_ring->dpi : BNXT_PRIV=
ILEGED_DPI;
>         rc =3D bnxt_hwrm_ring_alloc(bp, ring,
>                                   HWRM_RING_ALLOC_INPUT_RING_TYPE_TX,
>                                   queue_index, cpr->hw_stats_ctx_id,
>                                   cp_ring->fw_ring_id,
> -                                 tx_cosq_id);
> +                                 tx_cosq_id, txr->dpi);
>         if (rc)
>                 goto err_out;
>
>         bnxt_set_db(bp, &txr->tx_db, HWRM_RING_ALLOC_INPUT_RING_TYPE_TX,
>                     queue_index, ring->fw_ring_id,
> -                   ring->ring_mask);
> +                   ring->ring_mask, txr->dpi);
>         txq->index =3D idx;
>
>         return rc;
> diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
> index 3e2bd634a8..496c3e111f 100644
> --- a/drivers/net/bnxt/bnxt_ring.h
> +++ b/drivers/net/bnxt/bnxt_ring.h
> @@ -89,7 +89,8 @@ void bnxt_set_db(struct bnxt *bp,
>                  uint32_t ring_type,
>                  uint32_t map_idx,
>                  uint32_t fid,
> -                uint32_t ring_mask);
> +                uint32_t ring_mask,
> +                uint16_t dpi);
>
>  static inline void bnxt_db_write(struct bnxt_db_info *db, uint32_t idx)
>  {
> diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
> index 7357ca4427..82d6b86fa5 100644
> --- a/drivers/net/bnxt/bnxt_rxr.h
> +++ b/drivers/net/bnxt/bnxt_rxr.h
> @@ -142,6 +142,7 @@ struct bnxt_rx_ring_info {
>
>         uint32_t ol_flags_table[BNXT_OL_FLAGS_TBL_DIM];
>         uint32_t ol_flags_err_table[BNXT_OL_FLAGS_ERR_TBL_DIM];
> +       uint8_t                 dpi;  /* Doorbell page index for multi-do=
orbell support */
>  };
>
>  uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
> diff --git a/drivers/net/bnxt/bnxt_txr.h b/drivers/net/bnxt/bnxt_txr.h
> index 09078d545d..fd92a242c3 100644
> --- a/drivers/net/bnxt/bnxt_txr.h
> +++ b/drivers/net/bnxt/bnxt_txr.h
> @@ -26,6 +26,7 @@ struct bnxt_tx_ring_info {
>
>         unsigned short          *nr_bds;
>         struct bnxt_ring        *tx_ring_struct;
> +       uint8_t                 dpi;  /* Doorbell page index for multi-do=
orbell support */
>  };
>
>  static inline uint32_t bnxt_tx_bds_in_hw(struct bnxt_tx_queue *txq)
> diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hs=
i_struct_def_dpdk.h
> index 06c61cba8f..26d5e9ca78 100644
> --- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
> +++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
> @@ -15744,6 +15744,15 @@ struct __rte_packed_begin hwrm_func_qcaps_output=
 {
>          */
>         #define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTE=
D \
>                 UINT32_C(0x20)
> +       /*
> +        * When this bit is '1', it indicates that, when rx/tx/cq/nq l2
> +        * rings are allocated, each ring can be associated with a
> +        * non-common doorbell page index. When '0', a common doorbell
> +        * page is used for all rings on a PF. This bit is only set on a
> +        * PF.
> +        */
> +       #define HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_MULTI_L2_DB_SUPPORTED \
> +               UINT32_C(0x200)
>         /*
>          * The number of VFs that can be used for RoCE on the function. I=
f less
>          * than max_vfs, roce vfs will be assigned to the first VF of the
> @@ -16268,6 +16277,12 @@ struct __rte_packed_begin hwrm_func_qcfg_output =
{
>          * of the doorbell BAR between L2 and RoCE is required.
>          */
>         uint16_t        l2_doorbell_bar_size_kb;
> +       /*
> +        * The size of the doorbell BAR in KBytes reserved for multi-L2
> +        * doorbell pages. This area is a subset of l2_doorbell_bar_size_=
kb,
> +        * which is size of the total doorbell BAR space reserved for L2.
> +        */
> +       uint16_t        l2_db_multi_page_size_kb;
>         /*
>          * A bitmask indicating the active endpoints. Each bit represents=
 a
>          * specific endpoint, with bit 0 indicating EP 0 and bit 3 indica=
ting
> @@ -45464,6 +45479,13 @@ struct __rte_packed_begin hwrm_ring_alloc_input =
{
>          */
>         #define HWRM_RING_ALLOC_INPUT_ENABLES_RX_RATE_PROFILE_VALID \
>                 UINT32_C(0x1000)
> +       /*
> +        * This bit must be '1' for the dpi field to be configured.
> +        * This should only be used when 'multi_l2_db_supported'
> +        * bit is set in flags_ext3 field of FUNC_QCAPS response.
> +        */
> +       #define HWRM_RING_ALLOC_INPUT_ENABLES_DPI_VALID \
> +               UINT32_C(0x2000)
>         /* Ring Type. */
>         uint8_t ring_type;
>         /* L2 Completion Ring (CR) */
> @@ -45831,6 +45853,14 @@ struct __rte_packed_begin hwrm_ring_alloc_input =
{
>          * record.
>          */
>         uint64_t        cq_handle;
> +       /*
> +        * The "doorbell page index" is specified when allocating a l2 ri=
ng.
> +        * It is applicable for rx/tx/completion/nq rings, and should onl=
y be
> +        * used when 'multi_l2_db_supported' bit is set in flags_ext3 fie=
ld of
> +        * FUNC_QCAPS response.
> +        */
> +       uint16_t        dpi;
> +       uint16_t        unused_5[3];
>  } __rte_packed_end;
>
>  /* hwrm_ring_alloc_output (size:128b/16B) */
> --
> 2.47.3
>

--000000000000f81996064c22acc7
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
oIHHMC8GCSqGSIb3DQEJBDEiBCBPJchHrlicAm8wog17IUB2rOVd8wJ8itSsEDzeBeVNSDAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMDMxODE0MzRaMFwGCSqG
SIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBojh6NnV2z
P0KB8jZEkQDTiwh09jbCdrSZiqZpKPpV7zTTRi8DYaJqk7ikProKb/luM2NJ/Rq60Yg9TZP2SmbD
dB3RwXXpVDHKOGjP7rJri0lWIvwg/h2pBl1HZedT43E7/RGIeQEwUXVK/cLI7TF2XOhwugghYwqp
lhLB0dJLRECqIgR5gz2lNl3OH2Plzf8m20I4RbYoXi3t+zOgsw31Ic1uS9f0P8m9DYJ0aY3YPFcM
1jGQiS+ADhLUk1cicpczSAjSDr7v2VUdg96X5M9lQO79Kw0b4zPWZrOhUmFPDfGJavo+Ux5dnXsJ
xOnotsIuqzISmFqZspe9qKy+5nSB
--000000000000f81996064c22acc7--
