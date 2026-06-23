Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66204CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 09:13:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F4B9402A2;
	Tue, 23 Jun 2026 11:13:37 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6F15240269
 for <dev@dpdk.org>; Tue, 23 Jun 2026 11:13:36 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51a019e9ea9so38105771cf.2
 for <dev@dpdk.org>; Tue, 23 Jun 2026 02:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782206016; cv=none;
 d=google.com; s=arc-20240605;
 b=BoAsXQZM9/DB6eHbxp+6Xi++3tPA6o02FhAZwEwLsXybRJWSUSbO9/jlerrTaT1ceX
 E3I4sOmLR816rBZM1Q15/liver94DUYZueyowq7wF484bkSnJ2Y+I+ytY0rGyL9USVVP
 h1NENgKA7lzne/oH3iUdYLBaQH+PgwIi6Xqm/oHF/O2RZ2+1EC/AxqmyOdVuB9CZPwY4
 YWNRPZFJU8cFQbcBJ7O2/29Hz4KqfAcp/EUff7/SFWcJ62ceuzLT6XXD22pQt39GoXKc
 dn9mJlzAyGo5L2syJUU1jB09gQttLm+c498QQndg/ymYZG9UU8zyM4ueZhypS8DbS0Ze
 WQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TjK/zpROFrkpwlD5GFKLlcEhLGbaJxEPplxixofje7Q=;
 fh=UAhbHrKIlRPatncEeKTSPg1x7UbkReo/uRpYkz8//cw=;
 b=Q1UZHA0CqMHUZhmWHL4YOYvZvqxmAfylNEiqU9SiJeGQIKtBTANP+Elux3vNsctoWU
 2VC/ylfZdEcpbzN9tR3jJtFF1PJuENEyNJNbL9bmvQM8VykKOVWzDUSuNWYj0znnCOV0
 615P41L/0K/MsywvFbKMEgX9Z3FkM2KCA3ZA8xqXNnBiAkZfzZ5A+69VX63GzZkk35m1
 b5pY9XQtafAOQHSo82lPxCCsjuevFl70Qk35aOPoPuBdwPU1wC27+khjfaPM8OAasw6T
 m+266oqOkjtORXRRWZEDKTOtA9yBt4tgOA7E3vriQuzRqyOQo6ApT0xdWKaekjkgYjeA
 Pueg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782206016; x=1782810816; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjK/zpROFrkpwlD5GFKLlcEhLGbaJxEPplxixofje7Q=;
 b=XVoZ3/l3+UkHVKtbRNFpq9JpJrTSnOouLHS7NKt+dODzOM9sNZwVerH7baQSkUbLyK
 lLHkgozBAxFhaK8EmIlvEen3JaYeCljMfOAv3qJad+nPRnv89SavvKJBVlFld2KePx6z
 rY8y41VLzUrAhyRsfWflV/Gg0/fMPmLjDI7E7J5UoZfqukadHdOz+gBJmVxM1yATRwYw
 R0lQMLBz2V6+eHcIN/GTggrkjGvlIp/e9o6MU3uXmBI5htJhIAL58FaGxpSGopKB3fSw
 xGYnfBBacrzK++0khhuD8rJBO0yCe2MtdJNAjGEZzedIcdobYyMSKUBuCjyP6cVKS6Um
 Pe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782206016; x=1782810816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjK/zpROFrkpwlD5GFKLlcEhLGbaJxEPplxixofje7Q=;
 b=a+wZRY/y3zLRqZITcTkFgDaaFO+0EmMo2zj3WSICq0W55PYWPyIouxX3TAUDc6FSc0
 iuVRagNf8zNGhAM6YbzV52VruhxPAOl0198G59YUkmf1j/Ux0M+S4szzTB4hKIFi1fc8
 e+hBvzyQiv9ych1/KcRirMUOMprhyEq6LHiSfy3RelpgTiuySc0CTBpo999Xv0F4lOci
 +ev9eRruhe+4wzDclllr3FKmesEZO24SKsF1VkTFLhjTFH5Sj9SJMVKOuxcPtEVWjIIY
 Et6pJOHst7GlnEH43eh9qQ9/lwLXcGysycsH+6tUYQb37NkPDvzFKxwmev8ni5QB0Xru
 SPMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9USn/9K3v6DFK0D63WU1x0h0Wo9S/yNOYbrgYulVFwr9+9iIX7CaUPnzby+5LD/UFPMao=@dpdk.org
X-Gm-Message-State: AOJu0YwREqfG12aEs04AghDWTrfvdKx8j606+EMLks3Qj1mrZGZDGa7+
 kamTgXBSEbLEQpxOYyWWYysExovlCloDuHuLfaUDYS8e7qbJMAYQzD2Nq4oJJ9hzsMbQEuQPbmq
 5JMFtyV/XME/wxOQf3FLdnr7eNwXq6Yg=
X-Gm-Gg: AfdE7clUfcDw6p4fXO4JY7XVK0qqiJEM96xPORltrD6IqsMoAEGiOfS6nVbHkEPI5Zk
 QJmHekEbplj2Duc2ezv7Sx0j7aZwIVKa3rZViHMVm2Fx0c//4HUVHcryOW6tD4YnUzjsuFYAyoj
 G4pcfiGdiDZsAXaeTx7HDOTq7wxljfMoBOOmDgtUNRfCc+DU6eBIwttsqqx0hUnL+T1ib9rfreS
 +ud2pB4XwvKfPSmUTDBRBUOUf0PLqmEC9ZqZ4wLbDe8vMmWAQ8cwjeS/ds62T0bPnDq
X-Received: by 2002:a05:622a:291:b0:517:5e32:f3ad with SMTP id
 d75a77b69052e-51a06937e84mr203396451cf.26.1782206015602; Tue, 23 Jun 2026
 02:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260617054943.287815-1-rkudurumalla@marvell.com>
 <20260623054424.1943810-1-rkudurumalla@marvell.com>
In-Reply-To: <20260623054424.1943810-1-rkudurumalla@marvell.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 23 Jun 2026 14:43:07 +0530
X-Gm-Features: AVVi8Ce3f8mCGGircen_NifiD2EWGmg5xCuMuGFPNdRegOal-bjF2R-ZaOrrcnA
Message-ID: <CALBAE1PCDvCJC88_f+w+TqRgSWKu1XB1QToKoVk+Sj_cTyEFnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] common/cnxk: add bulk Rx queue enable/disable
To: rkudurumalla <rkudurumalla@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, 
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, 
 Harman Kalra <hkalra@marvell.com>, dev@dpdk.org, jerinj@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 23, 2026 at 11:21=E2=80=AFAM rkudurumalla <rkudurumalla@marvell=
.com> wrote:
>
> From: Rakesh Kudurumalla <rkudurumalla@marvell.com>
>
> Add roc_nix_rq_multi_ena_dis() to batch RQ enable/disable mailbox
> AQ operations and process them in a single mbox_process() call.
>
> Skip mbox_process() when no messages were queued (e.g. all qid are
> UINT16_MAX) by checking num_msgs and msg_size via mbox_nonempty_nolock().
>
> Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>


Always add change diff. Also Cc: the commenter who commented on v1.
Cc: @Stephen Hemminger

Applied to dpdk-next-net-mrvl/for-main. Thanks


> ---
>  drivers/common/cnxk/roc_mbox_priv.h           |   6 +-
>  drivers/common/cnxk/roc_nix.h                 |   2 +
>  drivers/common/cnxk/roc_nix_queue.c           | 102 ++++++++++++++++++
>  .../common/cnxk/roc_platform_base_symbols.c   |   1 +
>  4 files changed, 107 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/common/cnxk/roc_mbox_priv.h b/drivers/common/cnxk/ro=
c_mbox_priv.h
> index 354c8fa52a..e9da1959b6 100644
> --- a/drivers/common/cnxk/roc_mbox_priv.h
> +++ b/drivers/common/cnxk/roc_mbox_priv.h
> @@ -113,14 +113,12 @@ mbox_rsp_init(uint16_t mbox_id, void *msghdr)
>  }
>
>  static inline bool
> -mbox_nonempty(struct mbox *mbox, int devid)
> +mbox_nonempty_nolock(struct mbox *mbox, int devid)
>  {
>         struct mbox_dev *mdev =3D &mbox->dev[devid];
>         bool ret;
>
> -       plt_spinlock_lock(&mdev->mbox_lock);
> -       ret =3D mdev->num_msgs !=3D 0;
> -       plt_spinlock_unlock(&mdev->mbox_lock);
> +       ret =3D mdev->num_msgs !=3D 0 && mdev->msg_size !=3D 0;
>
>         return ret;
>  }
> diff --git a/drivers/common/cnxk/roc_nix.h b/drivers/common/cnxk/roc_nix.=
h
> index 8ba8b3e0b6..f495e2a5ad 100644
> --- a/drivers/common/cnxk/roc_nix.h
> +++ b/drivers/common/cnxk/roc_nix.h
> @@ -1094,6 +1094,8 @@ int __roc_api roc_nix_rq_modify(struct roc_nix *roc=
_nix, struct roc_nix_rq *rq,
>                                 bool ena);
>  int __roc_api roc_nix_rq_cman_config(struct roc_nix *roc_nix, struct roc=
_nix_rq *rq);
>  int __roc_api roc_nix_rq_ena_dis(struct roc_nix_rq *rq, bool enable);
> +int __roc_api roc_nix_rq_multi_ena_dis(struct roc_nix *roc_nix, struct r=
oc_nix_rq *rqs,
> +                                      int nb_rx_queues, bool enable);
>  int __roc_api roc_nix_rq_is_sso_enable(struct roc_nix *roc_nix, uint32_t=
 qid);
>  int __roc_api roc_nix_rq_fini(struct roc_nix_rq *rq);
>  int __roc_api roc_nix_cq_init(struct roc_nix *roc_nix, struct roc_nix_cq=
 *cq);
> diff --git a/drivers/common/cnxk/roc_nix_queue.c b/drivers/common/cnxk/ro=
c_nix_queue.c
> index ef9b651022..075c9c1591 100644
> --- a/drivers/common/cnxk/roc_nix_queue.c
> +++ b/drivers/common/cnxk/roc_nix_queue.c
> @@ -10,6 +10,49 @@
>  /* Default SQB slack per SQ */
>  #define ROC_NIX_SQB_SLACK_DFLT 24
>
> +typedef void *(*nix_aq_enq_alloc_t)(struct mbox *mbox);
> +
> +static inline void
> +nix_aq_enq_write_rq_ena(void *msg, uint16_t qid, bool enable)
> +{
> +       struct nix_aq_enq_req *aq =3D msg;
> +
> +       aq->qidx =3D qid;
> +       aq->ctype =3D NIX_AQ_CTYPE_RQ;
> +       aq->op =3D NIX_AQ_INSTOP_WRITE;
> +       aq->rq.ena =3D enable;
> +       aq->rq_mask.ena =3D ~(aq->rq_mask.ena);
> +}
> +
> +static inline int
> +nix_rq_bulk_ena_dis_fill(struct mbox *mbox, struct roc_nix_rq *rqs, int =
nb_rx_queues,
> +                        bool enable, nix_aq_enq_alloc_t alloc)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nb_rx_queues; i++) {
> +               void *aq;
> +               int rc;
> +
> +               if (rqs[i].qid =3D=3D UINT16_MAX)
> +                       continue;
> +
> +               aq =3D alloc(mbox);
> +               if (!aq) {
> +                       rc =3D mbox_process(mbox);
> +                       if (rc)
> +                               return rc;
> +                       aq =3D alloc(mbox);
> +                       if (!aq)
> +                               return -ENOSPC;
> +               }
> +
> +               nix_aq_enq_write_rq_ena(aq, rqs[i].qid, enable);
> +       }
> +
> +       return 0;
> +}
> +
>  static inline uint32_t
>  nix_qsize_to_val(enum nix_q_size qsize)
>  {
> @@ -47,6 +90,28 @@ nix_rq_vwqe_flush(struct roc_nix_rq *rq, uint16_t vwqe=
_interval)
>         }
>  }
>
> +static int
> +nix_rq_bulk_ena_dis(struct nix *nix, struct roc_nix_rq *rqs, int nb_rx_q=
ueues, bool enable)
> +{
> +       struct mbox *mbox =3D mbox_get((&nix->dev)->mbox);
> +       nix_aq_enq_alloc_t alloc;
> +       int rc;
> +
> +       if (roc_model_is_cn9k())
> +               alloc =3D (nix_aq_enq_alloc_t)mbox_alloc_msg_nix_aq_enq;
> +       else if (roc_model_is_cn10k())
> +               alloc =3D (nix_aq_enq_alloc_t)mbox_alloc_msg_nix_cn10k_aq=
_enq;
> +       else /* CN20K */
> +               alloc =3D (nix_aq_enq_alloc_t)mbox_alloc_msg_nix_cn20k_aq=
_enq;
> +
> +       rc =3D nix_rq_bulk_ena_dis_fill(mbox, rqs, nb_rx_queues, enable, =
alloc);
> +       if (!rc && mbox_nonempty_nolock(mbox, 0))
> +               rc =3D mbox_process(mbox);
> +
> +       mbox_put(mbox);
> +       return rc;
> +}
> +
>  int
>  nix_rq_ena_dis(struct dev *dev, struct roc_nix_rq *rq, bool enable)
>  {
> @@ -126,6 +191,43 @@ roc_nix_sq_ena_dis(struct roc_nix_sq *sq, bool enabl=
e)
>         return rc;
>  }
>
> +int
> +roc_nix_rq_multi_ena_dis(struct roc_nix *roc_nix, struct roc_nix_rq *rqs=
, int nb_rx_queues,
> +                        bool enable)
> +{
> +       struct nix *nix =3D roc_nix_to_nix_priv(roc_nix);
> +       struct roc_nix_rq *rq;
> +       int rc, i;
> +
> +       rc =3D nix_rq_bulk_ena_dis(nix, rqs, nb_rx_queues, enable);
> +       if (rc) {
> +               plt_err("Failed to %s Rx queues rc=3D%d pf=3D%d vf=3D%d n=
b_rx_queues=3D%d",
> +                       enable ? "enable" : "disable", rc, nix->dev.pf, n=
ix->dev.vf,
> +                       nb_rx_queues);
> +               return rc;
> +       }
> +
> +       for (i =3D 0; i < nb_rx_queues; i++) {
> +               rq =3D &rqs[i];
> +
> +               if (rq->qid =3D=3D UINT16_MAX)
> +                       continue;
> +
> +               nix_rq_vwqe_flush(rq, nix->vwqe_interval);
> +
> +               /* Check for meta aura if RQ is enabled */
> +               if (enable && nix->need_meta_aura) {
> +                       rc =3D roc_nix_inl_meta_aura_check(rq->roc_nix, r=
q);
> +                       if (rc) {
> +                               plt_err("Failed meta aura check for rq=3D=
%u rc=3D%d pf=3D%d vf=3D%d",
> +                                       rq->qid, rc, nix->dev.pf, nix->de=
v.vf);
> +                               return rc;
> +                       }
> +               }
> +       }
> +       return 0;
> +}
> +
>  int
>  roc_nix_rq_ena_dis(struct roc_nix_rq *rq, bool enable)
>  {
> diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/co=
mmon/cnxk/roc_platform_base_symbols.c
> index ed34d4b05b..08b2f4c6f8 100644
> --- a/drivers/common/cnxk/roc_platform_base_symbols.c
> +++ b/drivers/common/cnxk/roc_platform_base_symbols.c
> @@ -353,6 +353,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_ena_dis)
>  RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_is_sso_enable)
>  RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_init)
>  RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_modify)
> +RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_multi_ena_dis)
>  RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_cman_config)
>  RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_fini)
>  RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_init)
> --
> 2.25.1
>
