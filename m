Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6074CC88E75
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:26:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80C6242B71;
	Tue, 15 Sep 2026 17:26:15 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1A53D40A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:26:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789485973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CQ4wFeQUoVNVgPt59mgXxczcwm5ypkvLiE2gr0vqsfo=;
 b=UGOVA/XM+ibOdPjdlPOmzvqXoLHjTEMqcniAB211rvaFV9ZeilFfs1BJq6xuEoQbyNxgml
 82LDReVFPfINbIjD4fzZCt33tGJWBBzK6dA4XtlYHX9QNKZuB9J9ghWrLPErRg9nLQ0fWC
 IUniyTliA/leEvHr4x7Zjng5EYg+emg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-WmIywWz8NY6LZR1_pgzuMA-1; Tue, 15 Sep 2026 11:26:12 -0400
X-MC-Unique: WmIywWz8NY6LZR1_pgzuMA-1
X-Mimecast-MFC-AGG-ID: WmIywWz8NY6LZR1_pgzuMA_1789485971
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a5a78026e4so7127641fa.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789485971; x=1790090771;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CQ4wFeQUoVNVgPt59mgXxczcwm5ypkvLiE2gr0vqsfo=;
 b=bFN9A2BW3nqWR1HwA3bU7b5YDoah7CkUDnKHRADHWcnWeEO14aSmSwMYdlJePiUqz+
 5zyMCTQAQqhDZPjgfvvAVskdw2Geclath3H0MaeFQL58fzfOiii7krQmyqXoqDGbPF09
 Q3LsiJgGvudz1QohCmytpykhM6dFRsIXPOEsqaB/OgdxtG3h0ycRNcpjxnitycbSWsdf
 lyQbrpNF5veMBa2oq4WEwE+BQ02ugGnfGzblStP993de0hLkRBBWODrlx7A8c8wvYK/k
 SjRkSwAuPj18jXzV8oAHV7nm12lVVpNCoE2DNTcjrfqX5v+QQs8pli57fV1R3fddxmC6
 adoQ==
X-Gm-Message-State: AFuF++lCaH1vhSh6sTl6DqaUGXiAd0513eQabI+mGc5qv5qHFSVyfJhr
 5L4puyjQn+2M0ChHMDWggpx4u0u5+TNzeCvkswaAoe1Ep2j7CQBBPnIWQ7f7MLJWmAzqCC5mcEq
 dp1xJ2lUYAogl2670Vx4FbRGnwM1+oDANNu/9lRKRu1Y1ihsdxnNv4fA7H05wC18VY4ncsjP8kw
 0zJuvYD6MatjcAfi8QDMc=
X-Gm-Gg: AYBFou3PHNxX+GhF90/b2j2IycZQcqACHrnC3WHqZWtrG8cJN1RzcQ38jHBqLu78oGM
 9hrHyYcUad5IYsgw0yN590YS7MTLDeeoyd7J1UTG9WerrQF+wQNoOVFa0wsRbegUur+zgBj2BPE
 twPUAc/cgktsHh62pjt9kL9Q5+m0wMKHd2T5COQOKhGkC5UVALxBmw6vxCD0loD8UnddH1Dfdvi
 1OzG9X29WZfsSmBoZt5ZA+J1ruOGq5NglGjxhsYCsIQy5Cm
X-Received: by 2002:a2e:a5cb:0:b0:39b:11f9:6132 with SMTP id
 38308e7fff4ca-3a5d18817dfmr6490441fa.1.1789485970741; 
 Tue, 15 Sep 2026 08:26:10 -0700 (PDT)
X-Received: by 2002:a2e:a5cb:0:b0:39b:11f9:6132 with SMTP id
 38308e7fff4ca-3a5d18817dfmr6490381fa.1.1789485970301; Tue, 15 Sep 2026
 08:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <818e1b48e7656636b76f223d1769b1b25897dcc6.1789044747.git.anatoly.burakov@intel.com>
In-Reply-To: <818e1b48e7656636b76f223d1769b1b25897dcc6.1789044747.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Sep 2026 17:25:58 +0200
X-Gm-Features: AcwNN1V_qmqZY-L9KakbD2oJZB0G9i36wQeIihAbULckEYg0dNp1AmR4qSB6QAI
Message-ID: <CAJFAV8w31Awymm2y=h9ja75erkV4yX+KvRd50scitH9rwQ2-KA@mail.gmail.com>
Subject: Re: [PATCH v17 06/26] vfio: do proper teardown on VFIO cleanup
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SOO9V7ku0BghrkCm7jNHs9dwreAEn_5A-gV6BFlULLw_1789485971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 10 Sept 2026 at 14:54, Anatoly Burakov
<anatoly.burakov@intel.com> wrote:
>
> Currently, VFIO cleanup only unregisters multiprocess callback, but does
> not destroy containers, groups, and user mem maps. Do all of that on VFIO
> cleanup. In order to distinguish between config that is not initialized vs.
> config that has been initialized but happens to have fd == 0, move the
> global VFIO enabled flag out of the config, and add a separate per-config
> "enabled" flag that can be checked to avoid attempting to clean up configs
> that were never initialized in the first place.
>
> While we're at it, also harden the API against repeated initialization and
> attempts at using the API without having VFIO initialized.

- At this point of the series, I don't see the need for this change.
The default config vfio_enabled should be set to 0 and could serve the
same purpose?

- Should we reset vfio_enabled in rte_vfio_cleanup()?

>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  lib/eal/freebsd/eal.c    |   3 +-
>  lib/eal/linux/eal_vfio.c | 151 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 147 insertions(+), 7 deletions(-)
>
> diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
> index 991ca45064..aa6d4c2e16 100644
> --- a/lib/eal/freebsd/eal.c
> +++ b/lib/eal/freebsd/eal.c
> @@ -846,8 +846,7 @@ int rte_vfio_enable(__rte_unused const char *modname)
>  }
>
>  RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
> -void
> -rte_vfio_cleanup(void)
> +void rte_vfio_cleanup(void)
>  {
>  }
>

Nit: unrelated.

> diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
> index 6c77076bc3..d4173f7a01 100644
> --- a/lib/eal/linux/eal_vfio.c
> +++ b/lib/eal/linux/eal_vfio.c

[snip]

> @@ -2218,9 +2296,72 @@ rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
>         return container_dma_unmap(vfio_cfg, vaddr, iova, len);
>  }
>
> +static void
> +vfio_cleanup_config(struct vfio_config *vfio_cfg)
> +{
> +       unsigned int i;
> +
> +       for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
> +               struct vfio_group *group = &vfio_cfg->vfio_groups[i];
> +
> +               if (group->group_num == -1)
> +                       continue;
> +               if (group->devices != 0) {
> +                       EAL_LOG(ERR, "Cannot cleanup VFIO group %d with %d devices",
> +                               group->group_num, group->devices);
> +                       return;

Why stop?
Should we continue for other groups?

> +               }
> +               if (group->fd >= 0 && close(group->fd) < 0) {
> +                       EAL_LOG(ERR, "Cannot close VFIO group %d: %s",
> +                               group->group_num, strerror(errno));
> +                       return;
> +               }
> +
> +               group->group_num = -1;
> +               group->fd = -1;
> +               group->devices = 0;
> +               vfio_cfg->vfio_active_groups--;
> +       }
> +
> +       /* if there are still active groups, we cannot cleanup the container */
> +       if (vfio_cfg->vfio_active_groups != 0) {
> +               EAL_LOG(ERR, "Cannot cleanup VFIO container with %d active groups",
> +                       vfio_cfg->vfio_active_groups);
> +               return;
> +       }
> +
> +       if (vfio_cfg->vfio_container_fd >= 0 &&
> +                       close(vfio_cfg->vfio_container_fd) < 0) {
> +               EAL_LOG(ERR, "Cannot close VFIO container: %s", strerror(errno));
> +               return;
> +       }
> +
> +       vfio_cfg->vfio_container_fd = -1;
> +       vfio_cfg->enabled = false;
> +       vfio_cfg->vfio_iommu_type = NULL;
> +
> +       vfio_cfg->mem_maps.n_maps = 0;
> +       memset(vfio_cfg->mem_maps.maps, 0, sizeof(vfio_cfg->mem_maps.maps));
> +}



-- 
David Marchand

