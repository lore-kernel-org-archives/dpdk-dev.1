Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA25BCFC500
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 19:24:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8C0E40280;
	Fri, 21 Nov 2025 20:24:25 +0100 (CET)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id 5402140269
 for <dev@dpdk.org>; Fri, 21 Nov 2025 20:24:23 +0100 (CET)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-434a80e5463so8911775ab.3
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763753062; x=1764357862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKmSS2t1kO0f/3b3E5Zg83RHMxO9MdyjlEwdwk4XMX8=;
 b=qeoH9j93ZkWX2Z6oQf678PLypq9oJNJfvuQghkTaITJjhriA0/gXzS9VufxX+TpuEp
 CIg9KyGRalWduFvej/Q5BKlna1zmyfm4FhEflzGO93WOCzLY2Gi26QNX6Txtp/QiLvNA
 fFS8o16B36VEQUbyyG+/rF6/M+Ftukl7wOU+RppJ26uAuBcpRKYwbQ77vT/3Z/ycsn3V
 Vxa58GnC+UnC6fFaSoJagSKDs3ex43ck/b+6yGMzxvgi51XvTAkMbNIJptc3+ZQxYaEt
 fB4JUaYZYRpoHLguQXhPQYnd79T6Vf1yymGp12NFQ72867rKiIbMvTw6MUzSOJtqV2rz
 ceBw==
X-Gm-Message-State: AOJu0Yx1uWR0wgE5iVSOMk2ajoeHhm0fbsogydzscIRt+C3rXzsraHPU
 kMeLrEHM6+NF9ul6lwXTW22bRrmpWA6vE2B0Jd8z3d+FNd54ee4t2NL9evbYm6gF9qIDWCCFomB
 qC1yqkxBRchNW6yTAGbMT7oP+S8jaSr9rmuLRWx/JDCJFHvZ9YvvhlDdcoR/SUCU8vCJedskCPD
 SWKam1TtHxaEZE1RuaK2D/rUou2T531Wo2b1YnYNEMIn3ccH8aSZsTIIjZQfqoS9uob08L//E=
X-Gm-Gg: ASbGncsK826TrTIfzIcrTX0dt/GaTr0pnG715V1fy6tRLGaWYxvx2GcjFzk9kcp1S2d
 tWNvcuVPC4A0u9ozHuQ2U/NsMnwqaikOzt0aKb1ezBHsyi9ZulJhTN+cup9FocvCajMes/7Tskr
 C0pVY5d3fgqGBrPrHHPkO6ofitO3kzUR1315JXouH6LSxhxgBmXP2iPTg4GgS8NMYNGxzXAwhcU
 gftHopLtAPx5MRq3PC13GSMrivzK0o3G99svyQgJ+2dpiCt3nHhl4wRFp5/g5oxx8UJ/C5myi3r
 P+0EXM3VXXzQKeUJN/IeyxpsYGISBpzL3S1GHrceFecN9wi8+08JZJFFj53ncjUJDtM2Jbo0ebY
 K19OQyK2FHkNYDfleijMZuICYxk6ZSYGe4UbnO9OgQ72H/PiaBAnzetkFvd8F7+fGUi9SgXhllE
 rWi1/bEsIk9egIz9kGMlzAv1bNuI6FHPGPpMuuVObufLokmA==
X-Google-Smtp-Source: AGHT+IHDmEFpPIk9lp4qc699WcXWTpYwdT8Z+oNZPKY4RlN00s9EZEnkXUqTlmdrJsNavfm3hV+TWoivFVJM
X-Received: by 2002:a05:6e02:1fe5:b0:430:aea6:833f with SMTP id
 e9e14a558f8ab-435b9844662mr26904445ab.8.1763753062416; 
 Fri, 21 Nov 2025 11:24:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-435a909aad7sm5730015ab.17.2025.11.21.11.24.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Nov 2025 11:24:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8804b9afe30so83163676d6.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1763753061; x=1764357861; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vKmSS2t1kO0f/3b3E5Zg83RHMxO9MdyjlEwdwk4XMX8=;
 b=KGGHvkPPDPtNXMRmnALLbIS4hiS3kAz9gIvd8HqhMrgfSJrOzfa9PwjtfCh4BVXgsc
 AnVXECslBlJDkmMMZlZuFw+53GdhVUxz4aZ3sw4G021xz64JBQ4SeYG/K9dbrgPGgQ36
 LT1+cIoxH1exo3JANFRPSuV7NEAMlQbUQhHmA=
X-Received: by 2002:ad4:5ca5:0:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-8847c52784bmr52059846d6.34.1763753060972; 
 Fri, 21 Nov 2025 11:24:20 -0800 (PST)
X-Received: by 2002:ad4:5ca5:0:b0:880:3e92:3d33 with SMTP id
 6a1803df08f44-8847c52784bmr52059306d6.34.1763753060325; Fri, 21 Nov 2025
 11:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20251114175112.1103784-1-stephen@networkplumber.org>
In-Reply-To: <20251114175112.1103784-1-stephen@networkplumber.org>
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
Date: Fri, 21 Nov 2025 11:24:01 -0800
X-Gm-Features: AWmQ_bmTcoavmI06hCwfbRDvCA3mbVLVgWOLumDsm0WKRvYLY-rwi8QcsUrGdbo
Message-ID: <CACZ4nhtooChGsnDsSHfDy_ZYcFGzqKxuWMO-GagGkUHrbDgNQg@mail.gmail.com>
Subject: Re: [PATCH] net/bnxt: remove unbuilt source files
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, shuanglin.wang@broadcom.com, 
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>, 
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000b8e0bb06441fc266"
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

--000000000000b8e0bb06441fc266
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 9:51=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Several C files are never used or built.
> Looks like they were converted to header files but the old source
> was never removed.
>
> Fixes: aa49b38fa7c3 ("net/bnxt/tf_core: cleanup external EM support")
> Cc: shuanglin.wang@broadcom.com
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>

> ---
>  .../net/bnxt/tf_core/cfa_tcam_mgr_session.c   |  390 ------
>  drivers/net/bnxt/tf_core/tf_em_common.c       |   23 -
>  drivers/net/bnxt/tf_core/tf_em_host.c         |   23 -
>  drivers/net/bnxt/tf_ulp/ulp_utils.c           | 1100 -----------------
>  4 files changed, 1536 deletions(-)
>  delete mode 100644 drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c
>  delete mode 100644 drivers/net/bnxt/tf_core/tf_em_common.c
>  delete mode 100644 drivers/net/bnxt/tf_core/tf_em_host.c
>  delete mode 100644 drivers/net/bnxt/tf_ulp/ulp_utils.c
>
> diff --git a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c b/drivers/ne=
t/bnxt/tf_core/cfa_tcam_mgr_session.c
> deleted file mode 100644
> index 40bbcc54c8..0000000000
> --- a/drivers/net/bnxt/tf_core/cfa_tcam_mgr_session.c
> +++ /dev/null
> @@ -1,390 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2021-2023 Broadcom
> - * All rights reserved.
> - */
> -
> -#include <inttypes.h>
> -#include "hcapi_cfa_defs.h"
> -#include "tf_util.h"
> -#include "cfa_tcam_mgr.h"
> -#include "cfa_tcam_mgr_device.h"
> -#include "cfa_tcam_mgr_session.h"
> -#include "cfa_tcam_mgr_sbmp.h"
> -#include "tfp.h"
> -#include "cfa_tcam_mgr_p58.h"
> -#include "cfa_tcam_mgr_p4.h"
> -
> -struct cfa_tcam_mgr_session_data {
> -       uint32_t session_id;
> -       /* The following are per-session values */
> -       uint16_t max_entries[TF_DIR_MAX][CFA_TCAM_MGR_TBL_TYPE_MAX];
> -       uint16_t used_entries[TF_DIR_MAX][CFA_TCAM_MGR_TBL_TYPE_MAX];
> -};
> -
> -static struct cfa_tcam_mgr_session_data session_data[TF_TCAM_MAX_SESSION=
S];
> -
> -static uint16_t last_entry_id;
> -
> -static struct sbmp *session_bmp[TF_TCAM_MAX_SESSIONS];
> -
> -int
> -cfa_tcam_mgr_session_init(int sess_idx, enum cfa_tcam_mgr_device_type ty=
pe)
> -{
> -       int rc;
> -
> -       switch (type) {
> -       case CFA_TCAM_MGR_DEVICE_TYPE_P4:
> -       case CFA_TCAM_MGR_DEVICE_TYPE_SR:
> -               rc =3D cfa_tcam_mgr_sess_table_get_p4(sess_idx, &session_=
bmp[sess_idx]);
> -               break;
> -       case CFA_TCAM_MGR_DEVICE_TYPE_P5:
> -               rc =3D cfa_tcam_mgr_sess_table_get_p58(sess_idx, &session=
_bmp[sess_idx]);
> -               break;
> -       default:
> -               CFA_TCAM_MGR_LOG(ERR, "No such device %d\n", type);
> -               rc =3D -CFA_TCAM_MGR_ERR_CODE(NODEV);
> -       }
> -
> -       return rc;
> -}
> -
> -int
> -cfa_tcam_mgr_get_session_from_context(struct cfa_tcam_mgr_context *conte=
xt,
> -                                     uint32_t *session_id)
> -{
> -       if (context =3D=3D NULL) {
> -               CFA_TCAM_MGR_LOG_0(ERR, "context passed as NULL pointer.\=
n");
> -               return -CFA_TCAM_MGR_ERR_CODE(INVAL);
> -       }
> -
> -       *session_id =3D context->tfp->session->session_id.id;
> -       return 0;
> -}
> -
> -int
> -cfa_tcam_mgr_session_find(unsigned int session_id)
> -{
> -       unsigned int sess_idx;
> -
> -       for (sess_idx =3D 0; sess_idx < ARRAY_SIZE(session_data); sess_id=
x++) {
> -               if (session_data[sess_idx].session_id =3D=3D session_id)
> -                       return sess_idx;
> -       }
> -
> -       return -CFA_TCAM_MGR_ERR_CODE(INVAL);
> -}
> -
> -int
> -cfa_tcam_mgr_session_empty(void)
> -{
> -       unsigned int sess_idx;
> -
> -       for (sess_idx =3D 0; sess_idx < ARRAY_SIZE(session_data); sess_id=
x++) {
> -               if (session_data[sess_idx].session_id)
> -                       return 0;
> -       }
> -
> -       return 1;
> -}
> -
> -int
> -cfa_tcam_mgr_session_add(unsigned int session_id)
> -{
> -       int sess_idx;
> -
> -       sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> -       if (sess_idx >=3D 0) {
> -               CFA_TCAM_MGR_LOG_0(ERR, "Session is already bound.\n");
> -               return -CFA_TCAM_MGR_ERR_CODE(BUSY);
> -       }
> -
> -       /* Session not found in table, find first empty entry. */
> -       for (sess_idx =3D 0;
> -            sess_idx < (signed int)ARRAY_SIZE(session_data);
> -            sess_idx++) {
> -               if (session_data[sess_idx].session_id =3D=3D 0)
> -                       break;
> -       }
> -
> -       if (sess_idx >=3D (signed int)ARRAY_SIZE(session_data)) {
> -               /* No room in the session table */
> -               CFA_TCAM_MGR_LOG_0(ERR, "Session table is full.\n");
> -               return -CFA_TCAM_MGR_ERR_CODE(NOMEM);
> -       }
> -
> -       session_data[sess_idx].session_id =3D session_id;
> -
> -       return sess_idx;
> -}
> -
> -int
> -cfa_tcam_mgr_session_free(unsigned int session_id,
> -               struct cfa_tcam_mgr_context *context)
> -{
> -       struct cfa_tcam_mgr_free_parms free_parms;
> -       int entry_id;
> -       int sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> -
> -       if (sess_idx < 0)
> -               return sess_idx;
> -
> -       memset(&free_parms, 0, sizeof(free_parms));
> -       /* Since we are freeing all pending TCAM entries (which is typica=
lly
> -        * done during tcam_unbind), we don't know the type of each entry=
.
> -        * So we set the type to MAX as a hint to cfa_tcam_mgr_free() to
> -        * figure out the actual type. We need to set it through each
> -        * iteration in the loop below; otherwise, the type determined fo=
r
> -        * the first entry would be used for subsequent entries that may =
or
> -        * may not be of the same type, resulting in errors.
> -        */
> -       for (entry_id =3D 0; entry_id < cfa_tcam_mgr_max_entries[sess_idx=
]; entry_id++) {
> -               if (SBMP_MEMBER(session_bmp[sess_idx][entry_id], sess_idx=
)) {
> -                       SBMP_SESSION_REMOVE(session_bmp[sess_idx][entry_i=
d], sess_idx);
> -
> -                       free_parms.id =3D entry_id;
> -                       free_parms.type =3D CFA_TCAM_MGR_TBL_TYPE_MAX;
> -                       cfa_tcam_mgr_free(context, &free_parms);
> -               }
> -       }
> -
> -       memset(&session_data[sess_idx], 0, sizeof(session_data[sess_idx])=
);
> -       return 0;
> -}
> -
> -int
> -cfa_tcam_mgr_session_cfg(unsigned int session_id,
> -                        uint16_t tcam_cnt[][CFA_TCAM_MGR_TBL_TYPE_MAX])
> -{
> -       struct cfa_tcam_mgr_table_data *table_data;
> -       struct cfa_tcam_mgr_session_data *session_entry;
> -       unsigned int dir, type;
> -       int sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> -       uint16_t requested_cnt;
> -
> -       if (sess_idx < 0)
> -               return sess_idx;
> -
> -       session_entry =3D &session_data[sess_idx];
> -
> -       /* Validate session request */
> -       for (dir =3D 0; dir < ARRAY_SIZE(cfa_tcam_mgr_tables[sess_idx]); =
dir++) {
> -               for (type =3D 0;
> -                    type < ARRAY_SIZE(cfa_tcam_mgr_tables[sess_idx][dir]=
);
> -                    type++) {
> -                       table_data =3D &cfa_tcam_mgr_tables[sess_idx][dir=
][type];
> -                       requested_cnt =3D tcam_cnt[dir][type];
> -                       /*
> -                        * Only check if table supported (max_entries > 0=
).
> -                        */
> -                       if (table_data->max_entries > 0 &&
> -                           requested_cnt > table_data->max_entries) {
> -                               CFA_TCAM_MGR_LOG_DIR_TYPE(ERR, dir, type,
> -                                               "Requested %d, available =
%d.\n",
> -                                               requested_cnt,
> -                                               table_data->max_entries);
> -                               return -CFA_TCAM_MGR_ERR_CODE(NOSPC);
> -                       }
> -               }
> -       }
> -
> -       memcpy(session_entry->max_entries, tcam_cnt,
> -              sizeof(session_entry->max_entries));
> -       return 0;
> -}
> -
> -void
> -cfa_tcam_mgr_mv_session_used_entries_cnt(int sess_idx, enum tf_dir dir,
> -                                        enum cfa_tcam_mgr_tbl_type dst_t=
ype,
> -                                        enum cfa_tcam_mgr_tbl_type src_t=
ype)
> -{
> -       session_data[sess_idx].used_entries[dir][dst_type]++;
> -       session_data[sess_idx].used_entries[dir][src_type]--;
> -}
> -
> -int
> -cfa_tcam_mgr_session_entry_alloc(unsigned int session_id,
> -                                enum tf_dir dir,
> -                                enum cfa_tcam_mgr_tbl_type type)
> -{
> -       int sess_idx;
> -
> -       sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> -       if (sess_idx < 0) {
> -               CFA_TCAM_MGR_LOG_0(ERR, "Session not found.\n");
> -               return -CFA_TCAM_MGR_ERR_CODE(NODEV);
> -       }
> -
> -       if (session_data[sess_idx].used_entries[dir][type] >=3D
> -           session_data[sess_idx].max_entries[dir][type]) {
> -               CFA_TCAM_MGR_LOG_0(ERR, "Table full (session).\n");
> -               return -CFA_TCAM_MGR_ERR_CODE(NOSPC);
> -       }
> -
> -       do {
> -               last_entry_id++;
> -               if (cfa_tcam_mgr_max_entries[sess_idx] <=3D last_entry_id=
)
> -                       last_entry_id =3D 0;
> -       } while (!SBMP_IS_NULL(session_bmp[sess_idx][last_entry_id]));
> -
> -       SBMP_SESSION_ADD(session_bmp[sess_idx][last_entry_id], sess_idx);
> -
> -       session_data[sess_idx].used_entries[dir][type] +=3D 1;
> -
> -       return last_entry_id;
> -}
> -
> -int
> -cfa_tcam_mgr_session_entry_free(unsigned int session_id,
> -                               unsigned int entry_id,
> -                               enum tf_dir dir,
> -                               enum cfa_tcam_mgr_tbl_type type)
> -{
> -       int sess_idx;
> -
> -       sess_idx =3D cfa_tcam_mgr_session_find(session_id);
> -       if (sess_idx < 0) {
> -               CFA_TCAM_MGR_LOG_0(ERR, "Session not found.\n");
> -               return -CFA_TCAM_MGR_ERR_CODE(NODEV);
> -       }
> -
> -       SBMP_SESSION_REMOVE(session_bmp[sess_idx][entry_id], sess_idx);
> -       session_data[sess_idx].used_entries[dir][type] -=3D 1;
> -
> -       return 0;
> -}
> -
> -#if SBMP_WORD_WIDTH =3D=3D 16
> -#define SBMP_FORMAT PRIX16
> -#define SBMP_PRECISION "4"
> -#elif SBMP_WORD_WIDTH =3D=3D 32
> -#define SBMP_FORMAT PRIX32
> -#define SBMP_PRECISION "8"
> -#elif SBMP_WORD_WIDTH =3D=3D 64
> -#define SBMP_FORMAT PRIX64
> -#define SBMP_PRECISION "16"
> -#else
> -#error "Invalid value for SBMP_WORD_WIDTH."
> -#endif
> -
> -static void
> -cfa_tcam_mgr_session_bitmap_print(struct sbmp *session_bmp)
> -{
> -       unsigned int i;
> -
> -       printf("0x");
> -       for (i =3D 0;
> -            i < ARRAY_SIZE(session_bmp->bits);
> -            i++) {
> -               printf("%0" SBMP_PRECISION SBMP_FORMAT,
> -                      session_bmp->bits[i]);
> -       }
> -}
> -
> -#define SESSION_DUMP_HEADER_1 "                             RX          =
TX\n"
> -#define SESSION_DUMP_HEADER_2 \
> -       "                         Max   Used  Max   Used\n"
> -
> -static void
> -cfa_tcam_mgr_session_printf(struct cfa_tcam_mgr_session_data *session,
> -                           enum cfa_tcam_mgr_tbl_type tbl_type)
> -{
> -       printf("%-22s: %5u %5u %5u %5u\n",
> -              cfa_tcam_mgr_tbl_2_str(tbl_type),
> -              session->max_entries[TF_DIR_RX][tbl_type],
> -              session->used_entries[TF_DIR_RX][tbl_type],
> -              session->max_entries[TF_DIR_TX][tbl_type],
> -              session->used_entries[TF_DIR_TX][tbl_type]);
> -}
> -
> -void
> -cfa_tcam_mgr_sessions_dump(void)
> -{
> -       struct cfa_tcam_mgr_session_data *session;
> -       unsigned int sess_idx;
> -       bool sess_found =3D false;
> -       enum cfa_tcam_mgr_tbl_type tbl_type;
> -
> -       printf("\nTCAM Sessions Table:\n");
> -       for (sess_idx =3D 0; sess_idx < ARRAY_SIZE(session_data); sess_id=
x++) {
> -               if (session_data[sess_idx].session_id !=3D 0) {
> -                       session =3D &session_data[sess_idx];
> -                       if (!sess_found) {
> -                               printf(SESSION_DUMP_HEADER_1);
> -                               printf(SESSION_DUMP_HEADER_2);
> -                       }
> -                       printf("Session 0x%08x:\n",
> -                              session->session_id);
> -                       for (tbl_type =3D CFA_TCAM_MGR_TBL_TYPE_START;
> -                            tbl_type < CFA_TCAM_MGR_TBL_TYPE_MAX;
> -                            tbl_type++) {
> -                               cfa_tcam_mgr_session_printf(session, tbl_=
type);
> -                       }
> -                       sess_found =3D true;
> -               }
> -       }
> -
> -       if (!sess_found)
> -               printf("No sessions found.\n");
> -}
> -
> -/* This dumps all the sessions using an entry */
> -void
> -cfa_tcam_mgr_entry_sessions_dump(int sess_idx, uint16_t id)
> -{
> -       bool session_found =3D false;
> -
> -       if (id >=3D cfa_tcam_mgr_max_entries[sess_idx]) {
> -               printf("Entry ID %u out of range for sess_idx %d.  Max ID=
 %u.\n",
> -                      id, sess_idx, cfa_tcam_mgr_max_entries[sess_idx] -=
 1);
> -               return;
> -       }
> -
> -       if (!SBMP_IS_NULL(session_bmp[sess_idx][id])) {
> -               printf("Sessions using entry ID %u:\n", id);
> -               for (sess_idx =3D 0; sess_idx < SBMP_SESSION_MAX; sess_id=
x++)
> -                       if (SBMP_MEMBER(session_bmp[sess_idx][id], (sess_=
idx))) {
> -                               if (session_data[sess_idx].session_id !=
=3D 0) {
> -                                       printf("0x%08x (index %d)\n",
> -                                         session_data[sess_idx].session_=
id,
> -                                         sess_idx);
> -                                       session_found =3D true;
> -                               } else {
> -                                       printf("Error! Entry ID %u used b=
y "
> -                                              "session index %d which is=
 not "
> -                                              "in use.\n",
> -                                              id, sess_idx);
> -                               }
> -                       }
> -               if (!session_found)
> -                       printf("No sessions using entry ID %u.\n", id);
> -       } else {
> -               printf("Entry ID %u not in use.\n",
> -                      id);
> -               return;
> -       }
> -}
> -
> -/* This dumps all the entries in use by any session */
> -void
> -cfa_tcam_mgr_session_entries_dump(int sess_idx)
> -{
> -       bool entry_found =3D false;
> -       uint16_t id;
> -
> -       printf("\nGlobal Maximum Entries for sess_idx %d: %d\n\n",
> -              sess_idx, cfa_tcam_mgr_max_entries[sess_idx]);
> -       printf("TCAM Session Entry Table:\n");
> -       for (id =3D 0; id < cfa_tcam_mgr_max_entries[sess_idx]; id++) {
> -               if (!SBMP_IS_NULL(session_bmp[sess_idx][id])) {
> -                       if (!entry_found)
> -                               printf("  EID Session bitmap\n");
> -                       printf("%5u ", id);
> -                       cfa_tcam_mgr_session_bitmap_print(&session_bmp[se=
ss_idx][id]);
> -                       printf("\n");
> -                       entry_found =3D true;
> -               }
> -       }
> -
> -       if (!entry_found)
> -               printf("No entries found.\n");
> -}
> diff --git a/drivers/net/bnxt/tf_core/tf_em_common.c b/drivers/net/bnxt/t=
f_core/tf_em_common.c
> deleted file mode 100644
> index 2449759db0..0000000000
> --- a/drivers/net/bnxt/tf_core/tf_em_common.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2019-2023 Broadcom
> - * All rights reserved.
> - */
> -
> -#include <string.h>
> -#include <math.h>
> -#include <sys/param.h>
> -#include <rte_common.h>
> -#include <rte_errno.h>
> -#include <rte_log.h>
> -#include "tf_core.h"
> -#include "tf_util.h"
> -#include "tf_common.h"
> -#include "tf_em.h"
> -#include "tf_em_common.h"
> -#include "tf_msg.h"
> -#include "tfp.h"
> -#include "tf_device.h"
> -#include "tf_ext_flow_handle.h"
> -#include "hcapi_cfa.h"
> -#include "bnxt.h"
> -
> diff --git a/drivers/net/bnxt/tf_core/tf_em_host.c b/drivers/net/bnxt/tf_=
core/tf_em_host.c
> deleted file mode 100644
> index 6db0057b2c..0000000000
> --- a/drivers/net/bnxt/tf_core/tf_em_host.c
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2019-2023 Broadcom
> - * All rights reserved.
> - */
> -
> -#include <string.h>
> -#include <math.h>
> -#include <sys/param.h>
> -#include <rte_common.h>
> -#include <rte_errno.h>
> -#include <rte_log.h>
> -
> -#include "tf_core.h"
> -#include "tf_util.h"
> -#include "tf_common.h"
> -#include "tf_em.h"
> -#include "tf_em_common.h"
> -#include "tf_msg.h"
> -#include "tfp.h"
> -#include "lookup3.h"
> -#include "tf_ext_flow_handle.h"
> -
> -#include "bnxt.h"
> diff --git a/drivers/net/bnxt/tf_ulp/ulp_utils.c b/drivers/net/bnxt/tf_ul=
p/ulp_utils.c
> deleted file mode 100644
> index 85e309d7a2..0000000000
> --- a/drivers/net/bnxt/tf_ulp/ulp_utils.c
> +++ /dev/null
> @@ -1,1100 +0,0 @@
> -/* SPDX-License-Identifier: BSD-3-Clause
> - * Copyright(c) 2014-2023 Broadcom
> - * All rights reserved.
> - */
> -
> -#include <rte_common.h>
> -#include "ulp_utils.h"
> -#include "bnxt_tf_common.h"
> -
> -/*
> - * Initialize the regfile structure for writing
> - *
> - * regfile [in] Ptr to a regfile instance
> - *
> - * returns zero on success
> - */
> -int32_t
> -ulp_regfile_init(struct ulp_regfile *regfile)
> -{
> -       /* validate the arguments */
> -       if (!regfile) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL;
> -       }
> -       memset(regfile, 0, sizeof(struct ulp_regfile));
> -       return 0; /* Success */
> -}
> -
> -/*
> - * Read a value from the regfile
> - *
> - * regfile [in] The regfile instance. Must be initialized prior to being=
 used
> - *
> - * field [in] The field to be read within the regfile.
> - *
> - * data [in/out]
> - *
> - * returns zero on success
> - */
> -int32_t
> -ulp_regfile_read(struct ulp_regfile *regfile,
> -                enum bnxt_ulp_rf_idx field,
> -                uint64_t *data)
> -{
> -       /* validate the arguments */
> -       if (!regfile || field >=3D BNXT_ULP_RF_IDX_LAST) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL;
> -       }
> -
> -       *data =3D regfile->entry[field].data;
> -       return 0;
> -}
> -
> -/*
> - * Write a value to the regfile
> - *
> - * regfile [in] The regfile instance.  Must be initialized prior to bein=
g used
> - *
> - * field [in] The field to be written within the regfile.
> - *
> - * data [in] The value is written into this variable.  It is going to be=
 in the
> - * same byte order as it was written.
> - *
> - * size [in] The size in bytes of the value being written into this
> - * variable.
> - *
> - * returns 0 on success
> - */
> -int32_t
> -ulp_regfile_write(struct ulp_regfile *regfile,
> -                 enum bnxt_ulp_rf_idx field,
> -                 uint64_t data)
> -{
> -       /* validate the arguments */
> -       if (!regfile || field >=3D BNXT_ULP_RF_IDX_LAST) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL; /* failure */
> -       }
> -
> -       regfile->entry[field].data =3D data;
> -       return 0; /* Success */
> -}
> -
> -static void
> -ulp_bs_put_msb(uint8_t *bs, uint16_t bitpos, uint8_t bitlen, uint8_t val=
)
> -{
> -       uint8_t bitoffs =3D bitpos % 8;
> -       uint16_t index  =3D bitpos / 8;
> -       uint8_t mask;
> -       uint8_t tmp;
> -       int8_t shift;
> -
> -       tmp =3D bs[index];
> -       mask =3D ((uint8_t)-1 >> (8 - bitlen));
> -       shift =3D 8 - bitoffs - bitlen;
> -       val &=3D mask;
> -
> -       if (shift >=3D 0) {
> -               tmp &=3D ~(mask << shift);
> -               tmp |=3D val << shift;
> -               bs[index] =3D tmp;
> -       } else {
> -               tmp &=3D ~((uint8_t)-1 >> bitoffs);
> -               tmp |=3D val >> -shift;
> -               bs[index++] =3D tmp;
> -
> -               tmp =3D bs[index];
> -               tmp &=3D ((uint8_t)-1 >> (bitlen - (8 - bitoffs)));
> -               tmp |=3D val << (8 + shift);
> -               bs[index] =3D tmp;
> -       }
> -}
> -
> -static void
> -ulp_bs_put_lsb(uint8_t *bs, uint16_t bitpos, uint8_t bitlen, uint8_t val=
)
> -{
> -       uint8_t bitoffs =3D bitpos % 8;
> -       uint16_t index  =3D bitpos / 8;
> -       uint8_t mask;
> -       uint8_t tmp;
> -       uint8_t shift;
> -       uint8_t partial;
> -
> -       tmp =3D bs[index];
> -       shift =3D bitoffs;
> -
> -       if (bitoffs + bitlen <=3D 8) {
> -               mask =3D ((1 << bitlen) - 1) << shift;
> -               tmp &=3D ~mask;
> -               tmp |=3D ((val << shift) & mask);
> -               bs[index] =3D tmp;
> -       } else {
> -               partial =3D 8 - bitoffs;
> -               mask =3D ((1 << partial) - 1) << shift;
> -               tmp &=3D ~mask;
> -               tmp |=3D ((val << shift) & mask);
> -               bs[index++] =3D tmp;
> -
> -               val >>=3D partial;
> -               partial =3D bitlen - partial;
> -               mask =3D ((1 << partial) - 1);
> -               tmp =3D bs[index];
> -               tmp &=3D ~mask;
> -               tmp |=3D (val & mask);
> -               bs[index] =3D tmp;
> -       }
> -}
> -
> -/*
> - * Add data to the byte array in Little endian format.
> - *
> - * bs [in] The byte array where data is pushed
> - *
> - * pos [in] The offset where data is pushed
> - *
> - * len [in] The number of bits to be added to the data array.
> - *
> - * val [in] The data to be added to the data array.
> - *
> - * returns the number of bits pushed.
> - */
> -uint32_t
> -ulp_bs_push_lsb(uint8_t *bs, uint16_t pos, uint8_t len, uint8_t *val)
> -{
> -       int i;
> -       int cnt =3D (len) / 8;
> -       int tlen =3D len;
> -
> -       if (cnt > 0 && !(len % 8))
> -               cnt -=3D 1;
> -
> -       for (i =3D 0; i < cnt; i++) {
> -               ulp_bs_put_lsb(bs, pos, 8, val[cnt - i]);
> -               pos +=3D 8;
> -               tlen -=3D 8;
> -       }
> -
> -       /* Handle the remainder bits */
> -       if (tlen)
> -               ulp_bs_put_lsb(bs, pos, tlen, val[0]);
> -       return len;
> -}
> -
> -/*
> - * Add data to the byte array in Big endian format.
> - *
> - * bs [in] The byte array where data is pushed
> - *
> - * pos [in] The offset where data is pushed
> - *
> - * len [in] The number of bits to be added to the data array.
> - *
> - * val [in] The data to be added to the data array.
> - *
> - * returns the number of bits pushed.
> - */
> -uint32_t
> -ulp_bs_push_msb(uint8_t *bs, uint16_t pos, uint8_t len, uint8_t *val)
> -{
> -       int i;
> -       int cnt =3D (len + 7) / 8;
> -
> -       /* Handle any remainder bits */
> -       int tmp =3D len % 8;
> -
> -       if (!tmp)
> -               tmp =3D 8;
> -
> -       ulp_bs_put_msb(bs, pos, tmp, val[0]);
> -
> -       pos +=3D tmp;
> -
> -       for (i =3D 1; i < cnt; i++) {
> -               ulp_bs_put_msb(bs, pos, 8, val[i]);
> -               pos +=3D 8;
> -       }
> -
> -       return len;
> -}
> -
> -/*
> - * Initializes the blob structure for creating binary blob
> - *
> - * blob [in] The blob to be initialized
> - *
> - * bitlen [in] The bit length of the blob
> - *
> - * order [in] The byte order for the blob.  Currently only supporting
> - * big endian.  All fields are packed with this order.
> - *
> - * returns zero on success
> - * Notes - If bitlen is zero then set it to max.
> - */
> -int32_t
> -ulp_blob_init(struct ulp_blob *blob,
> -             uint16_t bitlen,
> -             enum bnxt_ulp_byte_order order)
> -{
> -       /* validate the arguments */
> -       if (!blob || bitlen > (8 * sizeof(blob->data))) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL;
> -       }
> -       if (bitlen)
> -               blob->bitlen =3D bitlen;
> -       else
> -               blob->bitlen =3D BNXT_ULP_FLMP_BLOB_SIZE_IN_BITS;
> -       blob->byte_order =3D order;
> -       blob->write_idx =3D 0;
> -       memset(blob->data, 0, sizeof(blob->data));
> -       return 0; /* Success */
> -}
> -
> -/*
> - * Add data to the binary blob at the current offset.
> - *
> - * blob [in] The blob that data is added to.  The blob must
> - * be initialized prior to pushing data.
> - *
> - * data [in] A pointer to bytes to be added to the blob.
> - *
> - * datalen [in] The number of bits to be added to the blob.
> - *
> - * The offset of the data is updated after each push of data.
> - *
> - * returns zero on success
> - */
> -#define ULP_BLOB_BYTE          8
> -#define ULP_BLOB_BYTE_HEX      0xFF
> -#define BLOB_MASK_CAL(x)       ((0xFF << (x)) & 0xFF)
> -int32_t
> -ulp_blob_push(struct ulp_blob *blob,
> -             uint8_t *data,
> -             uint32_t datalen)
> -{
> -       uint32_t rc;
> -
> -       /* validate the arguments */
> -       if (!blob || datalen > (uint32_t)(blob->bitlen - blob->write_idx)=
) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL;
> -       }
> -
> -       if (blob->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> -               rc =3D ulp_bs_push_msb(blob->data,
> -                                    blob->write_idx,
> -                                    datalen,
> -                                    data);
> -       else
> -               rc =3D ulp_bs_push_lsb(blob->data,
> -                                    blob->write_idx,
> -                                    datalen,
> -                                    data);
> -       if (!rc) {
> -               BNXT_DRV_DBG(ERR, "Failed to write blob\n");
> -               return -EINVAL;
> -       }
> -       blob->write_idx +=3D datalen;
> -       return 0;
> -}
> -
> -/*
> - * Insert data into the binary blob at the given offset.
> - *
> - * blob [in] The blob that data is added to.  The blob must
> - * be initialized prior to pushing data.
> - *
> - * offset [in] The offset where the data needs to be inserted.
> - *
> - * data [in/out] A pointer to bytes to be added to the blob.
> - *
> - * datalen [in] The number of bits to be added to the blob.
> - *
> - * The offset of the data is updated after each push of data.
> - *
> - * returns zero on success
> - */
> -int32_t
> -ulp_blob_insert(struct ulp_blob *blob, uint32_t offset,
> -               uint8_t *data, uint32_t datalen)
> -{
> -       uint32_t rc;
> -       uint8_t local_data[BNXT_ULP_FLMP_BLOB_SIZE];
> -       uint16_t mov_len;
> -
> -       /* validate the arguments */
> -       if (!blob || datalen > (uint32_t)(blob->bitlen - blob->write_idx)=
 ||
> -           offset > blob->write_idx) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL;
> -       }
> -
> -       mov_len =3D blob->write_idx - offset;
> -       /* If offset and data len are not 8 bit aligned then return error=
 */
> -       if (ULP_BITS_IS_BYTE_NOT_ALIGNED(offset) ||
> -           ULP_BITS_IS_BYTE_NOT_ALIGNED(datalen)) {
> -               BNXT_DRV_DBG(ERR, "invalid argument, not aligned\n");
> -               return -EINVAL;
> -       }
> -
> -       /* copy the data so we can move the data */
> -       memcpy(local_data, &blob->data[ULP_BITS_2_BYTE_NR(offset)],
> -              ULP_BITS_2_BYTE(mov_len));
> -       blob->write_idx =3D offset;
> -       if (blob->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> -               rc =3D ulp_bs_push_msb(blob->data,
> -                                    blob->write_idx,
> -                                    datalen,
> -                                    data);
> -       else
> -               rc =3D ulp_bs_push_lsb(blob->data,
> -                                    blob->write_idx,
> -                                    datalen,
> -                                    data);
> -       if (!rc) {
> -               BNXT_DRV_DBG(ERR, "Failed to write blob\n");
> -               return -EINVAL;
> -       }
> -       /* copy the previously stored data */
> -       memcpy(&blob->data[ULP_BITS_2_BYTE_NR(offset + datalen)], local_d=
ata,
> -              ULP_BITS_2_BYTE(mov_len));
> -       blob->write_idx +=3D (mov_len + datalen);
> -       return 0;
> -}
> -
> -/*
> - * Add data to the binary blob at the current offset.
> - *
> - * blob [in] The blob that data is added to.  The blob must
> - * be initialized prior to pushing data.
> - *
> - * data [in] 64-bit value to be added to the blob.
> - *
> - * datalen [in] The number of bits to be added to the blob.
> - *
> - * The offset of the data is updated after each push of data.
> - * NULL returned on error, pointer pushed value otherwise.
> - */
> -uint8_t *
> -ulp_blob_push_64(struct ulp_blob *blob,
> -                uint64_t *data,
> -                uint32_t datalen)
> -{
> -       uint8_t *val =3D (uint8_t *)data;
> -       int rc;
> -
> -       int size =3D (datalen + 7) / 8;
> -
> -       if (!blob || !data ||
> -           datalen > (uint32_t)(blob->bitlen - blob->write_idx)) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return NULL;
> -       }
> -
> -       rc =3D ulp_blob_push(blob, &val[8 - size], datalen);
> -       if (rc)
> -               return NULL;
> -
> -       return &val[8 - size];
> -}
> -
> -/*
> - * Add data to the binary blob at the current offset.
> - *
> - * blob [in] The blob that data is added to.  The blob must
> - * be initialized prior to pushing data.
> - *
> - * data [in] 32-bit value to be added to the blob.
> - *
> - * datalen [in] The number of bits to be added to the blob.
> - *
> - * The offset of the data is updated after each push of data.
> - * NULL returned on error, pointer pushed value otherwise.
> - */
> -uint8_t *
> -ulp_blob_push_32(struct ulp_blob *blob,
> -                uint32_t *data,
> -                uint32_t datalen)
> -{
> -       uint8_t *val =3D (uint8_t *)data;
> -       uint32_t rc;
> -       uint32_t size =3D ULP_BITS_2_BYTE(datalen);
> -
> -       if (!data || size > sizeof(uint32_t)) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return NULL;
> -       }
> -
> -       rc =3D ulp_blob_push(blob, &val[sizeof(uint32_t) - size], datalen=
);
> -       if (rc)
> -               return NULL;
> -
> -       return &val[sizeof(uint32_t) - size];
> -}
> -
> -/*
> - * Add encap data to the binary blob at the current offset.
> - *
> - * blob [in] The blob that data is added to.  The blob must
> - * be initialized prior to pushing data.
> - *
> - * data [in] value to be added to the blob.
> - *
> - * datalen [in] The number of bits to be added to the blob.
> - *
> - * The offset of the data is updated after each push of data.
> - * NULL returned on error, pointer pushed value otherwise.
> - */
> -int32_t
> -ulp_blob_push_encap(struct ulp_blob *blob,
> -                   uint8_t *data,
> -                   uint32_t datalen)
> -{
> -       uint8_t         *val =3D (uint8_t *)data;
> -       uint32_t        initial_size, write_size =3D datalen;
> -       uint32_t        size =3D 0;
> -
> -       if (!blob || !data ||
> -           datalen > (uint32_t)(blob->bitlen - blob->write_idx)) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -1;
> -       }
> -
> -       initial_size =3D ULP_BYTE_2_BITS(sizeof(uint64_t)) -
> -           (blob->write_idx % ULP_BYTE_2_BITS(sizeof(uint64_t)));
> -       while (write_size > 0) {
> -               if (initial_size && write_size > initial_size) {
> -                       size =3D initial_size;
> -                       initial_size =3D 0;
> -               } else if (initial_size && write_size <=3D initial_size) =
{
> -                       size =3D write_size;
> -                       initial_size =3D 0;
> -               } else if (write_size > ULP_BYTE_2_BITS(sizeof(uint64_t))=
) {
> -                       size =3D ULP_BYTE_2_BITS(sizeof(uint64_t));
> -               } else {
> -                       size =3D write_size;
> -               }
> -               if (ulp_blob_push(blob, val, size)) {
> -                       BNXT_DRV_DBG(ERR, "push field failed\n");
> -                       return -1;
> -               }
> -               val +=3D ULP_BITS_2_BYTE(size);
> -               write_size -=3D size;
> -       }
> -       return datalen;
> -}
> -
> -/*
> - * Adds pad to an initialized blob at the current offset
> - *
> - * blob [in] The blob that data is added to.  The blob must
> - * be initialized prior to pushing data.
> - *
> - * datalen [in] The number of bits of pad to add
> - *
> - * returns the number of pad bits added, -1 on failure
> - */
> -int32_t
> -ulp_blob_pad_push(struct ulp_blob *blob,
> -                 uint32_t datalen)
> -{
> -       if (datalen > (uint32_t)(blob->bitlen - blob->write_idx)) {
> -               BNXT_DRV_DBG(ERR, "Pad too large for blob\n");
> -               return -1;
> -       }
> -
> -       blob->write_idx +=3D datalen;
> -       return datalen;
> -}
> -
> -/*
> - * Adds pad to an initialized blob at the current offset based on
> - * the alignment.
> - *
> - * blob [in] The blob that needs to be aligned
> - *
> - * align [in] Alignment in bits.
> - *
> - * returns the number of pad bits added, -1 on failure
> - */
> -int32_t
> -ulp_blob_pad_align(struct ulp_blob *blob,
> -                  uint32_t align)
> -{
> -       int32_t pad =3D 0;
> -
> -       pad =3D RTE_ALIGN(blob->write_idx, align) - blob->write_idx;
> -       if (pad > (int32_t)(blob->bitlen - blob->write_idx)) {
> -               BNXT_DRV_DBG(ERR, "Pad too large for blob\n");
> -               return -1;
> -       }
> -       blob->write_idx +=3D pad;
> -       return pad;
> -}
> -
> -/* Get data from src and put into dst using little-endian format */
> -static void
> -ulp_bs_get_lsb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t *d=
st)
> -{
> -       uint8_t bitoffs =3D bitpos % ULP_BLOB_BYTE;
> -       uint16_t index  =3D ULP_BITS_2_BYTE_NR(bitpos);
> -       uint8_t mask, partial, shift;
> -
> -       shift =3D bitoffs;
> -       partial =3D ULP_BLOB_BYTE - bitoffs;
> -       if (bitoffs + bitlen <=3D ULP_BLOB_BYTE) {
> -               mask =3D ((1 << bitlen) - 1) << shift;
> -               *dst =3D (src[index] & mask) >> shift;
> -       } else {
> -               mask =3D ((1 << partial) - 1) << shift;
> -               *dst =3D (src[index] & mask) >> shift;
> -               index++;
> -               partial =3D bitlen - partial;
> -               mask =3D ((1 << partial) - 1);
> -               *dst |=3D (src[index] & mask) << (ULP_BLOB_BYTE - bitoffs=
);
> -       }
> -}
> -
> -/*
> - * Get data from the byte array in Little endian format.
> - *
> - * src [in] The byte array where data is extracted from
> - *
> - * dst [out] The byte array where data is pulled into
> - *
> - * size [in] The size of dst array in bytes
> - *
> - * offset [in] The offset where data is pulled
> - *
> - * len [in] The number of bits to be extracted from the data array
> - *
> - * returns None.
> - */
> -void
> -ulp_bs_pull_lsb(uint8_t *src, uint8_t *dst, uint32_t size,
> -               uint32_t offset, uint32_t len)
> -{
> -       uint32_t idx;
> -       uint32_t cnt =3D ULP_BITS_2_BYTE_NR(len);
> -
> -       /* iterate bytewise to get data */
> -       for (idx =3D 0; idx < cnt; idx++) {
> -               ulp_bs_get_lsb(src, offset, ULP_BLOB_BYTE,
> -                              &dst[size - 1 - idx]);
> -               offset +=3D ULP_BLOB_BYTE;
> -               len -=3D ULP_BLOB_BYTE;
> -       }
> -
> -       /* Extract the last reminder data that is not 8 byte boundary */
> -       if (len)
> -               ulp_bs_get_lsb(src, offset, len, &dst[size - 1 - idx]);
> -}
> -
> -/* Get data from src and put into dst using big-endian format */
> -static void
> -ulp_bs_get_msb(uint8_t *src, uint16_t bitpos, uint8_t bitlen, uint8_t *d=
st)
> -{
> -       uint8_t bitoffs =3D bitpos % ULP_BLOB_BYTE;
> -       uint16_t index  =3D ULP_BITS_2_BYTE_NR(bitpos);
> -       uint8_t mask;
> -       int32_t shift;
> -
> -       shift =3D ULP_BLOB_BYTE - bitoffs - bitlen;
> -       if (shift >=3D 0) {
> -               mask =3D 0xFF >> -bitlen;
> -               *dst =3D (src[index] >> shift) & mask;
> -       } else {
> -               *dst =3D (src[index] & (0xFF >> bitoffs)) << -shift;
> -               *dst |=3D src[index + 1] >> -shift;
> -       }
> -}
> -
> -/*
> - * Get data from the byte array in Big endian format.
> - *
> - * src [in] The byte array where data is extracted from
> - *
> - * dst [out] The byte array where data is pulled into
> - *
> - * offset [in] The offset where data is pulled
> - *
> - * len [in] The number of bits to be extracted from the data array
> - *
> - * returns None.
> - */
> -void
> -ulp_bs_pull_msb(uint8_t *src, uint8_t *dst,
> -               uint32_t offset, uint32_t len)
> -{
> -       uint32_t idx;
> -       uint32_t cnt =3D ULP_BITS_2_BYTE_NR(len);
> -
> -       /* iterate bytewise to get data */
> -       for (idx =3D 0; idx < cnt; idx++) {
> -               ulp_bs_get_msb(src, offset, ULP_BLOB_BYTE, &dst[idx]);
> -               offset +=3D ULP_BLOB_BYTE;
> -               len -=3D ULP_BLOB_BYTE;
> -       }
> -
> -       /* Extract the last reminder data that is not 8 byte boundary */
> -       if (len)
> -               ulp_bs_get_msb(src, offset, len, &dst[idx]);
> -}
> -
> -/*
> - * Extract data from the binary blob using given offset.
> - *
> - * blob [in] The blob that data is extracted from. The blob must
> - * be initialized prior to pulling data.
> - *
> - * data [in] A pointer to put the data.
> - * data_size [in] size of the data buffer in bytes.
> - *offset [in] - Offset in the blob to extract the data in bits format.
> - * len [in] The number of bits to be pulled from the blob.
> - *
> - * Output: zero on success, -1 on failure
> - */
> -int32_t
> -ulp_blob_pull(struct ulp_blob *blob, uint8_t *data, uint32_t data_size,
> -             uint16_t offset, uint16_t len)
> -{
> -       /* validate the arguments */
> -       if (!blob || (offset + len) > blob->bitlen ||
> -           ULP_BYTE_2_BITS(data_size) < len) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -1; /* failure */
> -       }
> -
> -       if (blob->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> -               ulp_bs_pull_msb(blob->data, data, offset, len);
> -       else
> -               ulp_bs_pull_lsb(blob->data, data, data_size, offset, len)=
;
> -       return 0;
> -}
> -
> -/*
> - * Get the data portion of the binary blob.
> - *
> - * blob [in] The blob's data to be retrieved. The blob must be
> - * initialized prior to pushing data.
> - *
> - * datalen [out] The number of bits that are filled.
> - *
> - * Returns a byte array of the blob data or NULL on error.
> - */
> -uint8_t *
> -ulp_blob_data_get(struct ulp_blob *blob,
> -                 uint16_t *datalen)
> -{
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return NULL; /* failure */
> -       }
> -       *datalen =3D blob->write_idx;
> -       return blob->data;
> -}
> -
> -/*
> - * Get the data length of the binary blob.
> - *
> - * blob [in] The blob's data len to be retrieved.
> - *
> - * returns length of the binary blob
> - */
> -uint16_t
> -ulp_blob_data_len_get(struct ulp_blob *blob)
> -{
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return 0; /* failure */
> -       }
> -       return blob->write_idx;
> -}
> -
> -/*
> - * Set the encap swap start index of the binary blob.
> - *
> - * blob [in] The blob's data to be retrieved. The blob must be
> - * initialized prior to pushing data.
> - *
> - * returns void.
> - */
> -void
> -ulp_blob_encap_swap_idx_set(struct ulp_blob *blob)
> -{
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return; /* failure */
> -       }
> -       blob->encap_swap_idx =3D blob->write_idx;
> -}
> -
> -/*
> - * Perform the encap buffer swap to 64 bit reversal.
> - *
> - * blob [in] The blob's data to be used for swap.
> - *
> - * returns void.
> - */
> -void
> -ulp_blob_perform_encap_swap(struct ulp_blob *blob)
> -{
> -       uint32_t i, idx =3D 0, end_idx =3D 0, roundoff;
> -       uint8_t temp_val_1, temp_val_2;
> -
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return; /* failure */
> -       }
> -       idx =3D ULP_BITS_2_BYTE_NR(blob->encap_swap_idx);
> -       end_idx =3D ULP_BITS_2_BYTE(blob->write_idx);
> -       roundoff =3D ULP_BYTE_2_BITS(ULP_BITS_2_BYTE(end_idx));
> -       if (roundoff > end_idx) {
> -               blob->write_idx +=3D ULP_BYTE_2_BITS(roundoff - end_idx);
> -               end_idx =3D roundoff;
> -       }
> -       while (idx <=3D end_idx) {
> -               for (i =3D 0; i < 4; i =3D i + 2) {
> -                       temp_val_1 =3D blob->data[idx + i];
> -                       temp_val_2 =3D blob->data[idx + i + 1];
> -                       blob->data[idx + i] =3D blob->data[idx + 6 - i];
> -                       blob->data[idx + i + 1] =3D blob->data[idx + 7 - =
i];
> -                       blob->data[idx + 7 - i] =3D temp_val_2;
> -                       blob->data[idx + 6 - i] =3D temp_val_1;
> -               }
> -               idx +=3D 8;
> -       }
> -}
> -
> -/*
> - * Perform the blob buffer reversal byte wise.
> - * This api makes the first byte the last and
> - * vice-versa.
> - *
> - * blob [in] The blob's data to be used for swap.
> - * chunk_size[in] the swap is done within the chunk in bytes
> - *
> - * returns void.
> - */
> -void
> -ulp_blob_perform_byte_reverse(struct ulp_blob *blob,
> -                             uint32_t chunk_size)
> -{
> -       uint32_t idx =3D 0, jdx =3D 0, num =3D 0;
> -       uint8_t xchar;
> -       uint8_t *buff;
> -
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return; /* failure */
> -       }
> -
> -       buff =3D blob->data;
> -       num =3D ULP_BITS_2_BYTE(blob->write_idx) / chunk_size;
> -       for (idx =3D 0; idx < num; idx++) {
> -               for (jdx =3D 0; jdx < chunk_size / 2; jdx++) {
> -                       xchar =3D buff[jdx];
> -                       buff[jdx] =3D buff[(chunk_size - 1) - jdx];
> -                       buff[(chunk_size - 1) - jdx] =3D xchar;
> -               }
> -               buff +=3D chunk_size;
> -       }
> -}
> -
> -/*
> - * Perform the blob buffer 64 bit word swap.
> - * This api makes the first 4 bytes the last in
> - * a given 64 bit value and vice-versa.
> - *
> - * blob [in] The blob's data to be used for swap.
> - *
> - * returns void.
> - */
> -void
> -ulp_blob_perform_64B_word_swap(struct ulp_blob *blob)
> -{
> -       uint32_t i, j, num;
> -       uint8_t xchar;
> -       uint32_t word_size =3D ULP_64B_IN_BYTES / 2;
> -
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return; /* failure */
> -       }
> -       num =3D ULP_BITS_2_BYTE(blob->write_idx);
> -       for (i =3D 0; i < num; i =3D i + ULP_64B_IN_BYTES) {
> -               for (j =3D 0; j < word_size; j++) {
> -                       xchar =3D blob->data[i + j];
> -                       blob->data[i + j] =3D blob->data[i + j + word_siz=
e];
> -                       blob->data[i + j + word_size] =3D xchar;
> -               }
> -       }
> -}
> -
> -/*
> - * Perform the blob buffer 64 bit byte swap.
> - * This api makes the first byte the last in
> - * a given 64 bit value and vice-versa.
> - *
> - * blob [in] The blob's data to be used for swap.
> - *
> - * returns void.
> - */
> -void
> -ulp_blob_perform_64B_byte_swap(struct ulp_blob *blob)
> -{
> -       uint32_t i, j, num;
> -       uint8_t xchar;
> -       uint32_t offset =3D ULP_64B_IN_BYTES - 1;
> -
> -       /* validate the arguments */
> -       if (!blob) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return; /* failure */
> -       }
> -       num =3D ULP_BITS_2_BYTE(blob->write_idx);
> -       for (i =3D 0; i < num; i =3D i + ULP_64B_IN_BYTES) {
> -               for (j =3D 0; j < (ULP_64B_IN_BYTES / 2); j++) {
> -                       xchar =3D blob->data[i + j];
> -                       blob->data[i + j] =3D blob->data[i + offset - j];
> -                       blob->data[i + offset - j] =3D xchar;
> -               }
> -       }
> -}
> -
> -static int32_t
> -ulp_blob_msb_block_merge(struct ulp_blob *dst, struct ulp_blob *src,
> -                        uint32_t block_size, uint32_t pad)
> -{
> -       uint32_t i, k, write_bytes, remaining;
> -       uint16_t num;
> -       uint8_t *src_buf =3D ulp_blob_data_get(src, &num);
> -       uint8_t bluff;
> -
> -       for (i =3D 0; i < num;) {
> -               if (((dst->write_idx % block_size) + (num - i)) > block_s=
ize)
> -                       write_bytes =3D block_size -
> -                               (dst->write_idx % block_size);
> -               else
> -                       write_bytes =3D num - i;
> -               for (k =3D 0; k < ULP_BITS_2_BYTE_NR(write_bytes); k++) {
> -                       ulp_bs_put_msb(dst->data, dst->write_idx, ULP_BLO=
B_BYTE,
> -                                      *src_buf);
> -                       dst->write_idx +=3D ULP_BLOB_BYTE;
> -                       src_buf++;
> -               }
> -               remaining =3D write_bytes % ULP_BLOB_BYTE;
> -               if (remaining) {
> -                       bluff =3D (*src_buf) & ((uint8_t)-1 <<
> -                                             (ULP_BLOB_BYTE - remaining)=
);
> -                       ulp_bs_put_msb(dst->data, dst->write_idx,
> -                                      ULP_BLOB_BYTE, bluff);
> -                       dst->write_idx +=3D remaining;
> -               }
> -               if (write_bytes !=3D (num - i)) {
> -                       /* add the padding */
> -                       ulp_blob_pad_push(dst, pad);
> -                       if (remaining) {
> -                               ulp_bs_put_msb(dst->data, dst->write_idx,
> -                                              ULP_BLOB_BYTE - remaining,
> -                                              *src_buf);
> -                               dst->write_idx +=3D ULP_BLOB_BYTE - remai=
ning;
> -                               src_buf++;
> -                       }
> -               }
> -               i +=3D write_bytes;
> -       }
> -       return 0;
> -}
> -
> -/*
> - * Perform the blob buffer merge.
> - * This api makes the src blob merged to the dst blob.
> - * The block size and pad size help in padding the dst blob
> - *
> - * dst [in] The destination blob, the blob to be merged.
> - * src [in] The src blob.
> - * block_size [in] The size of the block in bytes after which padding ge=
ts
> - *                 applied.
> - * pad [in] The size of the pad to be applied.
> - *
> - * returns 0 on success.
> - */
> -int32_t
> -ulp_blob_block_merge(struct ulp_blob *dst, struct ulp_blob *src,
> -                    uint32_t block_size, uint32_t pad)
> -{
> -       if (dst->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE &&
> -           src->byte_order =3D=3D BNXT_ULP_BYTE_ORDER_BE)
> -               return ulp_blob_msb_block_merge(dst, src, block_size, pad=
);
> -
> -       BNXT_DRV_DBG(ERR, "block merge not implemented yet\n");
> -       return -EINVAL;
> -}
> -
> -int32_t
> -ulp_blob_append(struct ulp_blob *dst, struct ulp_blob *src,
> -               uint16_t src_offset, uint16_t src_len)
> -{
> -       uint32_t k, remaining =3D 0;
> -       uint16_t num;
> -       uint8_t bluff;
> -       uint8_t *src_buf =3D ulp_blob_data_get(src, &num);
> -
> -       if ((src_offset + src_len) > num)
> -               return -EINVAL;
> -
> -       /* Only supporting BE for now */
> -       if (src->byte_order !=3D BNXT_ULP_BYTE_ORDER_BE ||
> -           dst->byte_order !=3D BNXT_ULP_BYTE_ORDER_BE)
> -               return -EINVAL;
> -
> -       /* Handle if the source offset is not on a byte boundary */
> -       remaining =3D src_offset % ULP_BLOB_BYTE;
> -       if (remaining) {
> -               bluff =3D src_buf[src_offset / ULP_BLOB_BYTE] & ((uint8_t=
)-1 >>
> -                                     (ULP_BLOB_BYTE - remaining));
> -               ulp_bs_put_msb(dst->data, dst->write_idx,
> -                              ULP_BLOB_BYTE, bluff);
> -               dst->write_idx +=3D remaining;
> -               src_offset +=3D remaining;
> -       }
> -
> -       src_buf +=3D ULP_BITS_2_BYTE_NR(src_offset);
> -
> -       /* Push the byte aligned pieces */
> -       for (k =3D 0; k < ULP_BITS_2_BYTE_NR(src_len); k++) {
> -               ulp_bs_put_msb(dst->data, dst->write_idx, ULP_BLOB_BYTE,
> -                              *src_buf);
> -               dst->write_idx +=3D ULP_BLOB_BYTE;
> -               src_buf++;
> -       }
> -
> -       /* Handle the remaining if length is not a byte boundary */
> -       if (src_len > remaining)
> -               remaining =3D (src_len - remaining) % ULP_BLOB_BYTE;
> -       else
> -               remaining =3D 0;
> -       if (remaining) {
> -               bluff =3D (*src_buf) & ((uint8_t)-1 <<
> -                                     (ULP_BLOB_BYTE - remaining));
> -               ulp_bs_put_msb(dst->data, dst->write_idx,
> -                              ULP_BLOB_BYTE, bluff);
> -               dst->write_idx +=3D remaining;
> -       }
> -
> -       return 0;
> -}
> -
> -/*
> - * Perform the blob buffer copy.
> - * This api makes the src blob merged to the dst blob.
> - *
> - * dst [in] The destination blob, the blob to be merged.
> - * src [in] The src blob.
> - *
> - * returns 0 on success.
> - */
> -int32_t
> -ulp_blob_buffer_copy(struct ulp_blob *dst, struct ulp_blob *src)
> -{
> -       if ((dst->write_idx + src->write_idx) > dst->bitlen) {
> -               BNXT_DRV_DBG(ERR, "source buffer too large\n");
> -               return -EINVAL;
> -       }
> -       if (ULP_BITS_IS_BYTE_NOT_ALIGNED(dst->write_idx) ||
> -           ULP_BITS_IS_BYTE_NOT_ALIGNED(src->write_idx)) {
> -               BNXT_DRV_DBG(ERR, "source buffer is not aligned\n");
> -               return -EINVAL;
> -       }
> -       memcpy(&dst->data[ULP_BITS_2_BYTE_NR(dst->write_idx)],
> -              src->data, ULP_BITS_2_BYTE_NR(src->write_idx));
> -       dst->write_idx +=3D src->write_idx;
> -       return 0;
> -}
> -
> -/*
> - * Read data from the operand
> - *
> - * operand [in] A pointer to a 16 Byte operand
> - *
> - * val [in/out] The variable to copy the operand to
> - *
> - * bytes [in] The number of bytes to read into val
> - *
> - * returns zero on success.
> - */
> -int32_t
> -ulp_operand_read(uint8_t *operand,
> -                uint8_t *val,
> -                uint16_t bytes)
> -{
> -       /* validate the arguments */
> -       if (!operand || !val) {
> -               BNXT_DRV_DBG(ERR, "invalid argument\n");
> -               return -EINVAL;
> -       }
> -       memcpy(val, operand, bytes);
> -       return 0;
> -}
> -
> -/*
> - * Check the buffer is empty
> - *
> - * buf [in] The buffer
> - * size [in] The size of the buffer
> - *
> - */
> -int32_t ulp_buffer_is_empty(const uint8_t *buf, uint32_t size)
> -{
> -       return buf[0] =3D=3D 0 && !memcmp(buf, buf + 1, size - 1);
> -}
> -
> -/* Function to check if bitmap is zero.Return 1 on success */
> -uint32_t ulp_bitmap_is_zero(uint8_t *bitmap, int32_t size)
> -{
> -       while (size-- > 0) {
> -               if (*bitmap !=3D 0)
> -                       return 0;
> -               bitmap++;
> -       }
> -       return 1;
> -}
> -
> -/* Function to check if bitmap is ones. Return 1 on success */
> -uint32_t ulp_bitmap_is_ones(uint8_t *bitmap, int32_t size)
> -{
> -       while (size-- > 0) {
> -               if (*bitmap !=3D 0xFF)
> -                       return 0;
> -               bitmap++;
> -       }
> -       return 1;
> -}
> -
> -/* Function to check if bitmap is not zero. Return 1 on success */
> -uint32_t ulp_bitmap_notzero(const uint8_t *bitmap, int32_t size)
> -{
> -       while (size-- > 0) {
> -               if (*bitmap !=3D 0)
> -                       return 1;
> -               bitmap++;
> -       }
> -       return 0;
> -}
> -
> -/* returns 0 if input is power of 2 */
> -int32_t ulp_util_is_power_of_2(uint64_t x)
> -{
> -       if (((x - 1) & x))
> -               return -1;
> -       return 0;
> -}
> --
> 2.51.0
>

--000000000000b8e0bb06441fc266
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
CQQxIgQgcsuzTqDQRkyrfF4WMV5Eb3LbZtd+HF3C3TUTvGT3m6kwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUxMTIxMTkyNDIxWjBcBgkqhkiG9w0BCQ8xTzBNMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAkeTtPNGs4Kv+voB3rWSn24un6Zzb
bp+ADPqs1vl2Opp3UcTz80sU1S2tiSbJmfNUh83DqY3evbiUd3fZmnV6cmsMXmWst+UcGSWZmGKg
CjDSK57Vc6aVZhqqaSJzvI1QygB6w6vCVmzCWTtdqLgqP31QF3r3Ve2J+vA9D9VZ8MQwhi6zstMe
vMC04hsDZwzotAqrzp60UIisbNJRhoXC+gRWtEY3eh6fq2La6iON0TIuy3LrHfnCC8RcWe+jK/11
7K+wGLwGWMewbblh3kb/rKJo6KJ2MBAMgmM4U+BqOD93tVXc1ajiSwTbrqi2ywfOnfZ0wCVI7Vxa
malNGmQU+w==
--000000000000b8e0bb06441fc266--
