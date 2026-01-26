Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC9D1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 19:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CEFF402AB;
	Mon, 26 Jan 2026 20:58:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3D33D402A0
 for <dev@dpdk.org>; Mon, 26 Jan 2026 20:58:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769457481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4SjueXkOhRctM1f2GmUi7BPhCeltjysnfmVFvnfY9Kk=;
 b=BEZxnNjSPSyOtaqFxwLib6wGzpDjJy9v5HcptR3o0/H8PpvpaKOa8sRJbBgAxYZjduRz5c
 7VD/XONFACrWHzVrxD4EbYsYaqqwuUDqNDQXe590NpiJElpfDXBgt5wMfYywbbo3uSsQq2
 DqCb1f8N9cK/4MH0t7vaJkKBqBEe30c=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-m3MkhFn-M0GnMy3lUthcfA-1; Mon, 26 Jan 2026 14:57:58 -0500
X-MC-Unique: m3MkhFn-M0GnMy3lUthcfA-1
X-Mimecast-MFC-AGG-ID: m3MkhFn-M0GnMy3lUthcfA_1769457477
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12339eea50bso30367547c88.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 11:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769457477; x=1770062277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4SjueXkOhRctM1f2GmUi7BPhCeltjysnfmVFvnfY9Kk=;
 b=Ua82XjrXS1nq/mr+zT9CfvFDB4O+tCf9kIL5AGT6Dqe/7KgSYqeiaGvWFvJAgwsArr
 3byWVbivSOy016AG7uRINXCKI9vJTq05f89ibfpKjF6mzk375UEtesm4tJhNJT1tRfWS
 /vpWGUTxNQg7ijxobX8hWeWoz+JTI07n7cT4FNtoPgT/lumXASd2KCf3f2QdjWGRoDcl
 MTN/i8V+yMXoWe/4325kJO+yNG8K0zy7J3ZyOofnrivZNugIChliDhEG4X+Ei0zW4yts
 wNMTLsmBS1r1zehlzLNgMuauBrev/ysXESrFEjZNTOgb26OlyrpKn/8LimLQl8AGAP4H
 nJMQ==
X-Gm-Message-State: AOJu0YyyjbicznjSZN845P/ptX+IVi4ONmyKxsmqf9MBsoGW/TFC4TQ6
 uLO9W8fvWjqnAEaATVuldO9/+5xnJoe3bbNsTvbBp8076bh2TgSyqAjNkqcmVAJroFcogMCBrFk
 NMlgNe/ge3TBr/j0yc86DrYYhHrp3AYGyFL0K3Jsj7IDm+tblS/MGSvgVSZ9AiYmVTZid4yOQBb
 Kfab6Kgqm8WRVipHdXET0=
X-Gm-Gg: AZuq6aJpgFTVrp+oqQJh77Xph2eRpv1taTgWQMWiO2pQi7bKkohyjiUrjLbKG2onQcM
 iHNnECmcFRudupjTuHm+1G9BGjhp3XnWALI9NRC0wuvIeExJ/dxYrmv6JybCpS63Zd+Wxmv2E4z
 YcjuGkiGPWF4cFgbxteXeOleBFkBNsOH5jjMv4m/gH9gCQC0pxOFxrnIgQdvhRyAKi2O4yfLjPV
 Otbf6uQ8iGZlsJ/VpdWgMxwqhBL+OP89WxezZOJpyqaKoASJpKPIA==
X-Received: by 2002:a05:7022:6724:b0:119:e569:f262 with SMTP id
 a92af1059eb24-1248ebea5bcmr3462332c88.11.1769457476962; 
 Mon, 26 Jan 2026 11:57:56 -0800 (PST)
X-Received: by 2002:a05:7022:6724:b0:119:e569:f262 with SMTP id
 a92af1059eb24-1248ebea5bcmr3462312c88.11.1769457476396; Mon, 26 Jan 2026
 11:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20260122074906.127942-1-pravin.bathija@dell.com>
 <20260122074906.127942-5-pravin.bathija@dell.com>
In-Reply-To: <20260122074906.127942-5-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 26 Jan 2026 20:57:45 +0100
X-Gm-Features: AZwV_Qgld1XGA9dqK0wbSwxIpCh2rp6A9WQ05iDJQhe3TI4JLgJb475MDNPCeMw
Message-ID: <CAO55csy0oikG_HxUeqnU7tMvg+mjCdXP3uEUq7vUNsx8DgBGNw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vhost_user: Function defs for add/rem mem regions
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UIbcxob5JUBnZhsT8V-n5875a72TSy3c1Z23pRYQhIk_1769457477
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

On Thu, Jan 22, 2026 at 8:49=E2=80=AFAM <pravin.bathija@dell.com> wrote:
>
> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> These changes cover the function definition for add/remove memory
> region calls which are invoked on receiving vhost user message from
> vhost user front-end (e.g. Qemu). In our case, in addition to testing
> with qemu front-end, the testing has also been performed with libblkio
> front-end and spdk/dpdk back-end. We did I/O using libblkio based device
> driver, to spdk based drives. There are also changes for set_mem_table
> and new definition for get memory slots. Our changes optimize the set
> memory table call to use common support functions. Message get memory
> slots is how the vhost-user front-end queries the vhost-user back-end
> about the number of memory slots available to be registered by the
> back-end. In addition support function to invalidate vring is also
> defined which is used in add/remove memory region functions.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 234 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 202 insertions(+), 32 deletions(-)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index e2831b7625..1a2dcfbbca 100644
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
> @@ -1520,7 +1523,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>         struct virtio_net *dev =3D *pdev;
>         struct VhostUserMemory *memory =3D &ctx->msg.payload.memory;
>         struct rte_vhost_mem_region *reg;
> -       int numa_node =3D SOCKET_ID_ANY;
>         uint64_t mmap_offset;
>         uint32_t i;
>         bool async_notify =3D false;
> @@ -1565,39 +1567,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev=
,
>                 if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
>                         vhost_user_iotlb_flush_all(dev);
>
> -               free_mem_region(dev);
> +               free_all_mem_regions(dev);
>                 rte_free(dev->mem);
>                 dev->mem =3D NULL;
>         }
>
> -       /*
> -        * If VQ 0 has already been allocated, try to allocate on the sam=
e
> -        * NUMA node. It can be reallocated later in numa_realloc().
> -        */
> -       if (dev->nr_vring > 0)
> -               numa_node =3D dev->virtqueue[0]->numa_node;
> -
> -       dev->nr_guest_pages =3D 0;
> -       if (dev->guest_pages =3D=3D NULL) {
> -               dev->max_guest_pages =3D 8;
> -               dev->guest_pages =3D rte_zmalloc_socket(NULL,
> -                                       dev->max_guest_pages *
> -                                       sizeof(struct guest_page),
> -                                       RTE_CACHE_LINE_SIZE,
> -                                       numa_node);
> -               if (dev->guest_pages =3D=3D NULL) {
> -                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> -                               "failed to allocate memory for dev->guest=
_pages");
> -                       goto close_msg_fds;
> -               }
> -       }
> -
> -       dev->mem =3D rte_zmalloc_socket("vhost-mem-table", sizeof(struct =
rte_vhost_memory) +
> -               sizeof(struct rte_vhost_mem_region) * memory->nregions, 0=
, numa_node);
> -       if (dev->mem =3D=3D NULL) {
> -               VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate me=
mory for dev->mem");
> -               goto free_guest_pages;
> -       }
> +       if (vhost_user_initialize_memory(pdev) < 0)
> +               goto close_msg_fds;
>
>         for (i =3D 0; i < memory->nregions; i++) {
>                 reg =3D &dev->mem->regions[i];
> @@ -1661,11 +1637,167 @@ vhost_user_set_mem_table(struct virtio_net **pde=
v,
>         return RTE_VHOST_MSG_RESULT_OK;
>
>  free_mem_table:
> -       free_mem_region(dev);
> +       free_all_mem_regions(dev);
>         rte_free(dev->mem);
>         dev->mem =3D NULL;
> +       rte_free(dev->guest_pages);
> +       dev->guest_pages =3D NULL;
> +close_msg_fds:
> +       close_msg_fds(ctx);
> +       return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
> +
> +static int
> +vhost_user_get_max_mem_slots(struct virtio_net **pdev __rte_unused,
> +                       struct vhu_msg_context *ctx,
> +                       int main_fd __rte_unused)
> +{
> +       uint32_t max_mem_slots =3D VHOST_MEMORY_MAX_NREGIONS;
> +
> +       ctx->msg.payload.u64 =3D (uint64_t)max_mem_slots;
> +       ctx->msg.size =3D sizeof(ctx->msg.payload.u64);
> +       ctx->fd_num =3D 0;
> +
> +       return RTE_VHOST_MSG_RESULT_REPLY;
> +}
> +
> +static void
> +dev_invalidate_vrings(struct virtio_net *dev)
> +{
> +       uint32_t i;
> +
> +       for (i =3D 0; i < dev->nr_vring; i++) {
> +               struct vhost_virtqueue *vq =3D dev->virtqueue[i];
> +
> +               if (!vq)
> +                       continue;
>
> -free_guest_pages:
> +               if (vq->desc || vq->avail || vq->used) {
> +                       /* vhost_user_lock_all_queue_pairs locked all qps=
 */
> +                       VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_ADD_ME=
M_REG);
> +
> +                       /*
> +                        * If the memory table got updated, the ring addr=
esses
> +                        * need to be translated again as virtual address=
es have
> +                        * changed.
> +                        */
> +                       vring_invalidate(dev, vq);
> +
> +                       translate_ring_addresses(&dev, &vq);
> +               }
> +       }
> +}
> +
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +                       struct vhu_msg_context *ctx,
> +                       int main_fd __rte_unused)

The parameter is marked as unused but is actually used.

> +{
> +       uint32_t i;
> +       struct virtio_net *dev =3D *pdev;
> +       struct VhostUserMemoryRegion *region =3D &ctx->msg.payload.memory=
_single.region;
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
> +       if (dev->mem !=3D NULL && dev->mem->nregions > 0) {
> +               for (i =3D 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +                       struct rte_vhost_mem_region *current_region =3D &=
dev->mem->regions[i];
> +
> +                       if (current_region->mmap_size =3D=3D 0)
> +                               continue;
> +
> +                       uint64_t current_region_guest_start =3D current_r=
egion->guest_user_addr;
> +                       uint64_t current_region_guest_end =3D current_reg=
ion_guest_start
> +                                                               + current=
_region->mmap_size - 1;
> +                       uint64_t proposed_region_guest_start =3D region->=
userspace_addr;
> +                       uint64_t proposed_region_guest_end =3D proposed_r=
egion_guest_start
> +                                                               + region-=
>memory_size - 1;
> +                       bool overlap =3D false;
> +
> +                       overlap =3D !((proposed_region_guest_end < curren=
t_region_guest_start) ||
> +                               (proposed_region_guest_start > current_re=
gion_guest_end));
> +
> +                       if (overlap) {
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "requested memory region overlaps=
 with another region");
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "\tRequested region address:0x%" =
PRIx64,
> +                                       region->userspace_addr);
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "\tRequested region size:0x%" PRI=
x64,
> +                                       region->memory_size);
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "\tOverlapping region address:0x%=
" PRIx64,
> +                                       current_region->guest_user_addr);
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                                       "\tOverlapping region size:0x%" P=
RIx64,
> +                                       current_region->mmap_size);
> +                               goto close_msg_fds;
> +                       }
> +
> +               }
> +       }
> +
> +       /* find a new region and set it like memory table set does */
> +       struct rte_vhost_mem_region *reg =3D NULL;
> +
> +       for (i =3D 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +               if (dev->mem->regions[i].guest_user_addr =3D=3D 0) {
> +                       reg =3D &dev->mem->regions[i];
> +                       break;
> +               }
> +       }
> +       if (reg =3D=3D NULL) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "no free memory region=
");
> +               goto close_msg_fds;
> +       }
> +
> +       reg->guest_phys_addr =3D region->guest_phys_addr;
> +       reg->guest_user_addr =3D region->userspace_addr;
> +       reg->size            =3D region->memory_size;
> +       reg->fd              =3D ctx->fds[0];
> +
> +       if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region=
");
> +               goto close_msg_fds;
> +       }
> +
> +       dev->mem->nregions++;
> +
> +       if (dev->async_copy && rte_vfio_is_enabled("vfio"))
> +               async_dma_map_region(dev, reg, true);
> +
> +       if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)

Post-copy live-migration is broken.
The assumes the vhost-user message is of type SET_MEM_TABLE,
and so assumes ctx contains a VhostUserMemory payload.
But here ctx contains a VhostUserMemoryRegion payload.

Given the complexity of the patch, it is worrying that such issues are
overlooked.
What other features could be broken?

> +               goto free_mem_table;
> +
> +       dev_invalidate_vrings(dev);
> +       dump_guest_pages(dev);
> +
> +       return RTE_VHOST_MSG_RESULT_OK;
> +
> +free_mem_table:
> +       free_all_mem_regions(dev);
> +       rte_free(dev->mem);
> +       dev->mem =3D NULL;
>         rte_free(dev->guest_pages);
>         dev->guest_pages =3D NULL;
>  close_msg_fds:
> @@ -1673,6 +1805,44 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
>         return RTE_VHOST_MSG_RESULT_ERR;
>  }
>
> +static int
> +vhost_user_rem_mem_reg(struct virtio_net **pdev __rte_unused,
> +                       struct vhu_msg_context *ctx __rte_unused,

pdev and ctx are actually used.


> +                       int main_fd __rte_unused)
> +{
> +       uint32_t i;
> +       struct virtio_net *dev =3D *pdev;
> +       struct VhostUserMemoryRegion *region =3D &ctx->msg.payload.memory=
_single.region;
> +
> +       if (dev->mem !=3D NULL && dev->mem->nregions > 0) {
> +               for (i =3D 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
> +                       struct rte_vhost_mem_region *current_region =3D &=
dev->mem->regions[i];
> +
> +                       if (current_region->guest_user_addr =3D=3D 0)
> +                               continue;
> +
> +                       /*
> +                        * According to the vhost-user specification:
> +                        * The memory region to be removed is identified =
by its guest address,
> +                        * user address and size. The mmap offset is igno=
red.
> +                        */
> +                       if (region->userspace_addr =3D=3D current_region-=
>guest_user_addr
> +                               && region->guest_phys_addr =3D=3D current=
_region->guest_phys_addr
> +                               && region->memory_size =3D=3D current_reg=
ion->size) {
> +                               if (dev->async_copy && rte_vfio_is_enable=
d("vfio"))
> +                                       async_dma_map_region(dev, current=
_region, false);
> +                               dev_invalidate_vrings(dev);
> +                               free_mem_region(current_region);
> +                               dev->mem->nregions--;
> +                               return RTE_VHOST_MSG_RESULT_OK;
> +                       }
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

