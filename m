Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B42CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:17:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5C640655;
	Mon,  8 Jun 2026 18:17:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 01E8540655
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780935422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIXNN7bgVLNvp+owSx+1TMlJEr6pbE0T/kgh+BFIBc8=;
 b=iz9Chtae13IZZqPiVQ+bV41z65Rwe0vMwUHE4yPbltT8JTnczlPmg7W3fzz6Ugk/zXA0P1
 VkmkuWlZcwrzGPFSrsAsgb70AVi2dY0g55S1KpcT05f1Jv+CW2eLwOa/hIkb7gYMNSp6UP
 NriLCvWZ4BzAQVs88VkrCJS7U7FfY7U=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-o6a74KySMdWU_0P8QOLucg-1; Mon, 08 Jun 2026 12:17:01 -0400
X-MC-Unique: o6a74KySMdWU_0P8QOLucg-1
X-Mimecast-MFC-AGG-ID: o6a74KySMdWU_0P8QOLucg_1780935420
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-137fc6f8e9fso4646947c88.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 09:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780935420; x=1781540220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gIXNN7bgVLNvp+owSx+1TMlJEr6pbE0T/kgh+BFIBc8=;
 b=F6WPPLu0ajHSefoe4QaaD7vaiQXxnJoSldASVJRpBdcpiypYdeD8S7fy+OUF1PG9jh
 L8IsnqyCiLrkTY/KVklLG+HElldncm9EkyNxpai+y52fC2uXsa9b6l4qNh2LbgEyGD4i
 ASejgYmFqfI2MvJinsOOnyxThpYFJ0vRbXaOa6DG8C5gQGeDUYlDZoFXZU5iosWifksk
 XxYqkW2p5xsY4qqN7GWlM1aOTqkaENFJ/afJ6VsmREEn1mkVI2mkwpqo6cB1uip2y9/a
 kWR3ozBuUqIJnk/YfMWUNiO+2cwcUci7VebcChEw5PYCu3ysitlR4+OIIBWdrUN6Isr8
 1dnQ==
X-Gm-Message-State: AOJu0YzGLNYSvDbVV4tDrXBRv1XSxEszG3SlUaoTJK6meHv9hvYuiM+U
 cfCsydu4KH5nIvQIsPdKbrjkyegHMmHE92II5/U1ZJC67+lQcH2jeaYhMJzVrsphlB7KHhiaylW
 KRg7W/Svok9SribXcgpVGL08+7J+BCB8PGHOVwTlvnBEFwOYH3BgJ0otMvrJZ4Ez/X1XuZpqsDo
 ndkVO52g26ZK5aqNWfrM4=
X-Gm-Gg: Acq92OGHjClrtBO74hOjWXhO3Uf5rED3sUsxq8r8/56wKKu0dQbRvMcRVrv0rnlOzDr
 TuVFRwKgO+m3D5oJ5+6HTMiiNMOeYqnqi8R1JbNit4pYnVFWlug/iN2sOlfSg1tpcp6QArDO4Me
 ky093dusiSb7I1N+bT5B1Bt1WIlhN04x50K7j44q2W9wifokWlt71GGENRFsMG1BTorZJuWw1xf
 cXBpEFi4bTZs490a7TqoSR8eepL2KXRfrFa3hKnbr+C4oACDSpEjLskzCdomMVDdnalyAdcGK4X
X-Received: by 2002:a05:7022:2222:b0:138:63d:e328 with SMTP id
 a92af1059eb24-138065b6855mr7069764c88.0.1780935419968; 
 Mon, 08 Jun 2026 09:16:59 -0700 (PDT)
X-Received: by 2002:a05:7022:2222:b0:138:63d:e328 with SMTP id
 a92af1059eb24-138065b6855mr7069744c88.0.1780935419246; Mon, 08 Jun 2026
 09:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260606025211.1082615-1-pravin.bathija@dell.com>
 <20260606025211.1082615-5-pravin.bathija@dell.com>
In-Reply-To: <20260606025211.1082615-5-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 8 Jun 2026 18:16:47 +0200
X-Gm-Features: AVVi8Ce0HhIYYjhrq9EYO-nTUHXKUkcRT1ie7ekBzZjQ6FkcUBX437CYGWkoHcY
Message-ID: <CAO55csyEjjMV6kKqcpJdA3bN2PSL8owBmoqMJPVupJ4K4CqRuA@mail.gmail.com>
Subject: Re: [PATCH v16 4/5] vhost: add mem region add/remove handlers
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, stephen@networkplumber.org, fengchengwen@huawei.com, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8-zMteYO5WfgZsNmLA3qJe_6btIvuii3NyCMiGSd190_1780935420
X-Mimecast-Originator: redhat.com
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

On Sat, Jun 6, 2026 at 4:52=E2=80=AFAM <pravin.bathija@dell.com> wrote:
>
> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> Add support for VHOST_USER_ADD_MEM_REG, VHOST_USER_REM_MEM_REG and
> VHOST_USER_GET_MAX_MEM_SLOTS. Refactor memory initialization into
> common helper and add supporting functions for dynamic memory management.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 266 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 266 insertions(+)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 94fca8b589..020c993b29 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_us=
er_set_features, false, t
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false,=
 true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, fa=
lse, false) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table=
, true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_m=
em_slots, false, false) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, tr=
ue, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, fa=
lse, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, =
true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true=
, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num=
, false, true) \
> @@ -1167,6 +1170,24 @@ add_guest_pages(struct virtio_net *dev, struct rte=
_vhost_mem_region *reg,
>         return 0;
>  }
>
> +static void
> +remove_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *=
reg)
> +{
> +       uint64_t reg_start =3D reg->host_user_addr;
> +       uint64_t reg_end =3D reg_start + reg->size;
> +       uint32_t i, j =3D 0;
> +
> +       for (i =3D 0; i < dev->nr_guest_pages; i++) {
> +               if (dev->guest_pages[i].host_user_addr >=3D reg_start &&
> +                   dev->guest_pages[i].host_user_addr < reg_end)
> +                       continue;
> +               if (j !=3D i)
> +                       dev->guest_pages[j] =3D dev->guest_pages[i];
> +               j++;
> +       }
> +       dev->nr_guest_pages =3D j;
> +}
> +
>  #ifdef RTE_LIBRTE_VHOST_DEBUG
>  /* TODO: enable it only in debug mode? */
>  static void
> @@ -1591,6 +1612,251 @@ vhost_user_set_mem_table(struct virtio_net **pdev=
,
>         return RTE_VHOST_MSG_RESULT_ERR;
>  }
>
> +
> +static int
> +vhost_user_get_max_mem_slots(struct virtio_net **pdev __rte_unused,
> +                       struct vhu_msg_context *ctx,
> +                       int main_fd __rte_unused)
> +{
> +       uint32_t max_mem_slots =3D VHOST_MEMORY_MAX_NREGIONS;
> +
> +       ctx->msg.payload.u64 =3D max_mem_slots;
> +       ctx->msg.size =3D sizeof(ctx->msg.payload.u64);
> +       ctx->fd_num =3D 0;
> +
> +       return RTE_VHOST_MSG_RESULT_REPLY;
> +}
> +
> +/*
> + * Invalidate and re-translate all vring addresses after the memory tabl=
e
> + * has been modified (add/remove region).
> + *
> + * translate_ring_addresses() may call numa_realloc(), which can realloc=
ate
> + * the device structure.  The updated pointer is written back through *p=
dev
> + * so callers must refresh their local "dev" afterwards: dev =3D *pdev.
> + */
> +static void
> +vhost_user_invalidate_vrings(struct virtio_net **pdev)
> +{
> +       struct virtio_net *dev =3D *pdev;
> +       uint32_t i;
> +
> +       for (i =3D 0; i < dev->nr_vring; i++) {
> +               struct vhost_virtqueue *vq =3D dev->virtqueue[i];
> +
> +               if (!vq)
> +                       continue;
> +
> +               if (vq->desc || vq->avail || vq->used) {
> +                       vq_assert_lock(dev, vq);
> +
> +                       vring_invalidate(dev, vq);
> +
> +                       translate_ring_addresses(&dev, &vq);
> +               }
> +       }
> +
> +       *pdev =3D dev;
> +}
> +
> +/*
> + * Macro wrapper that performs the compile-time lock assertion with the
> + * correct message ID at the call site, then calls the implementation.
> + */
> +#define dev_invalidate_vrings(pdev, id) do { \
> +       static_assert(id ## _LOCK_ALL_QPS, \
> +               #id " handler is not declared as locking all queue pairs"=
); \
> +       vhost_user_invalidate_vrings(pdev); \
> +} while (0)
> +
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +                       struct vhu_msg_context *ctx,
> +                       int main_fd __rte_unused)
> +{
> +       struct VhostUserMemoryRegion *region =3D &ctx->msg.payload.memreg=
.region;
> +       struct virtio_net *dev =3D *pdev;
> +       uint32_t i;
> +
> +       /* convert first region add to normal memory table set */
> +       if (dev->mem =3D=3D NULL) {
> +               if (vhost_user_initialize_memory(pdev) < 0)
> +                       goto close_msg_fds;
> +       }
> +
> +       /* make sure new region will fit */
> +       if (dev->mem->nregions >=3D VHOST_MEMORY_MAX_NREGIONS) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "too many memory regio=
ns already (%u)",
> +                                                                       d=
ev->mem->nregions);
> +               goto close_msg_fds;
> +       }
> +
> +       /* make sure supplied memory fd present */
> +       if (ctx->fd_num !=3D 1) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "fd count makes no sen=
se (%u)", ctx->fd_num);
> +               goto close_msg_fds;
> +       }
> +
> +       /* Make sure no overlap in guest virtual address space */
> +       for (i =3D 0; i < dev->mem->nregions; i++) {
> +               struct rte_vhost_mem_region *cur =3D &dev->mem->regions[i=
];
> +               uint64_t cur_start =3D cur->guest_user_addr;
> +               uint64_t cur_end =3D cur_start + cur->size - 1;
> +               uint64_t new_start =3D region->userspace_addr;
> +               uint64_t new_end =3D new_start + region->memory_size - 1;
> +
> +               if (new_end >=3D cur_start && new_start <=3D cur_end) {
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "requested memory region overlaps with an=
other region");
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "\tRequested region address:0x%" PRIx64,
> +                               region->userspace_addr);
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "\tRequested region size:0x%" PRIx64,
> +                               region->memory_size);
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "\tOverlapping region address:0x%" PRIx64=
,
> +                               cur->guest_user_addr);
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "\tOverlapping region size:0x%" PRIx64,
> +                               cur->size);
> +                       goto close_msg_fds;
> +               }
> +       }
> +
> +       /* New region goes at the end of the contiguous array */
> +       struct rte_vhost_mem_region *reg =3D &dev->mem->regions[dev->mem-=
>nregions];
> +
> +       reg->guest_phys_addr =3D region->guest_phys_addr;
> +       reg->guest_user_addr =3D region->userspace_addr;
> +       reg->size            =3D region->memory_size;
> +       reg->fd              =3D ctx->fds[0];
> +       ctx->fds[0]          =3D -1;
> +
> +       if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region=
");
> +               if (reg->mmap_addr) {
> +                       /* mmap succeeded but a later step (e.g. add_gues=
t_pages)
> +                        * failed; undo the mapping and any guest-page en=
tries.
> +                        */
> +                       remove_guest_pages(dev, reg);
> +                       free_mem_region(reg);
> +               } else {
> +                       close(reg->fd);
> +                       reg->fd =3D -1;
> +               }
> +               goto close_msg_fds;
> +       }
> +
> +       dev->mem->nregions++;
> +
> +       if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
> +               if (async_dma_map_region(dev, reg, true) < 0)
> +                       goto free_new_region_no_dma;
> +       }
> +
> +       if (dev->postcopy_listening) {
> +               /*
> +                * Cannot use vhost_user_postcopy_register() here because=
 it
> +                * reads ctx->msg.payload.memory (SET_MEM_TABLE layout), =
but
> +                * ADD_MEM_REG uses the memreg payload.  Register the
> +                * single new region directly instead.
> +                */
> +               if (vhost_user_postcopy_region_register(dev, reg) < 0)
> +                       goto free_new_region;
> +       }
> +
> +       dev_invalidate_vrings(pdev, VHOST_USER_ADD_MEM_REG);
> +       dev =3D *pdev;
> +       dump_guest_pages(dev);
> +
> +       /*
> +        * In postcopy mode the front-end expects the back-end to reply w=
ith
> +        * the base of the mapped region (see VHOST_USER_SET_MEM_TABLE, w=
hich
> +        * applies here accordingly).  No reply is expected otherwise.
> +        *
> +        * translate_ring_addresses() above may have reallocated dev->mem=
 via
> +        * numa_realloc(), so re-derive the region pointer from the refre=
shed
> +        * dev rather than using the now-stale reg.  The new region is th=
e last
> +        * entry in the contiguous array.
> +        */
> +       if (dev->postcopy_listening) {
> +               reg =3D &dev->mem->regions[dev->mem->nregions - 1];
> +               ctx->msg.payload.memreg.region.userspace_addr =3D reg->ho=
st_user_addr;
> +               ctx->msg.size =3D sizeof(ctx->msg.payload.memreg);
> +               ctx->fd_num =3D 0;
> +               return RTE_VHOST_MSG_RESULT_REPLY;
> +       }

Thanks Stephen, good catch by the AI.
I did some digging into Qemu code, which AI later confirmed, and if
the series was tested,
the test passed "by accident" when postcopy was not enabled because
Qemu would read the
padding field of the payload, and would treat its value as
RTE_VHOST_MSG_RESULT_OK
because it is zero-initialized...


With this fix:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

> +
> +       return RTE_VHOST_MSG_RESULT_OK;
> +
> +free_new_region:
> +       if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +               async_dma_map_region(dev, reg, false);
> +free_new_region_no_dma:
> +       remove_guest_pages(dev, reg);
> +       free_mem_region(reg);
> +       dev->mem->nregions--;
> +close_msg_fds:
> +       close_msg_fds(ctx);
> +       return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
> +static int
> +vhost_user_rem_mem_reg(struct virtio_net **pdev,
> +                       struct vhu_msg_context *ctx,
> +                       int main_fd __rte_unused)
> +{
> +       struct VhostUserMemoryRegion *region =3D &ctx->msg.payload.memreg=
.region;
> +       struct virtio_net *dev =3D *pdev;
> +       uint32_t i;
> +
> +       if (dev->mem =3D=3D NULL || dev->mem->nregions =3D=3D 0) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to =
remove");
> +               return RTE_VHOST_MSG_RESULT_ERR;
> +       }
> +
> +       for (i =3D 0; i < dev->mem->nregions; i++) {
> +               struct rte_vhost_mem_region *current_region =3D &dev->mem=
->regions[i];
> +
> +               /*
> +                * According to the vhost-user specification:
> +                * The memory region to be removed is identified by its G=
PA,
> +                * user address and size. The mmap offset is ignored.
> +                */
> +               if (region->userspace_addr =3D=3D current_region->guest_u=
ser_addr
> +                       && region->guest_phys_addr =3D=3D current_region-=
>guest_phys_addr
> +                       && region->memory_size =3D=3D current_region->siz=
e) {
> +                       if (dev->async_copy && rte_vfio_is_enabled("vfio"=
))
> +                               async_dma_map_region(dev, current_region,=
 false);
> +                       if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATF=
ORM))
> +                               vhost_user_iotlb_cache_remove(dev,
> +                                       current_region->guest_phys_addr,
> +                                       current_region->size);
> +                       remove_guest_pages(dev, current_region);
> +                       free_mem_region(current_region);
> +
> +                       /* Compact the regions array to keep it contiguou=
s */
> +                       if (i < dev->mem->nregions - 1) {
> +                               memmove(&dev->mem->regions[i],
> +                                       &dev->mem->regions[i + 1],
> +                                       (dev->mem->nregions - 1 - i) *
> +                                       sizeof(struct rte_vhost_mem_regio=
n));
> +                               memset(&dev->mem->regions[dev->mem->nregi=
ons - 1],
> +                                       0, sizeof(struct rte_vhost_mem_re=
gion));
> +                       }
> +
> +                       dev->mem->nregions--;
> +                       dev_invalidate_vrings(pdev, VHOST_USER_REM_MEM_RE=
G);
> +                       dev =3D *pdev;
> +                       return RTE_VHOST_MSG_RESULT_OK;
> +               }
> +       }
> +
> +       VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to find region");
> +       return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
>  static bool
>  vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
>  {
> --
> 2.43.0
>

