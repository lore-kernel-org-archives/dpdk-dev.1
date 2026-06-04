Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B90FCD6E57
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 10:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 226B140611;
	Thu,  4 Jun 2026 12:27:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9CF2B402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 12:27:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780568826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUz2WE4nJMxXtiWAfXL/SMjJkp/AA6ShwTeAA6YskQk=;
 b=cRfkXZr6T4mYqRnmCbynyZxVu+jXcMOIj41ZGt+EVq7Mr2N35WoEeNjnpfETASwp07iXcx
 V4VPYOtmHlJ3Qy5wUJH1Dffki3zb/WKzIgumtrz+Z1NM7xT9yfJ5qcw+kp4FtWy59v5kxV
 KeauMqleOytYT6HdGXsE5GoWv1/pbjY=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-mudwy3hfMBOv1A_Lz_z1EA-1; Thu, 04 Jun 2026 06:26:59 -0400
X-MC-Unique: mudwy3hfMBOv1A_Lz_z1EA-1
X-Mimecast-MFC-AGG-ID: mudwy3hfMBOv1A_Lz_z1EA_1780568818
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137d003cf09so1335129c88.1
 for <dev@dpdk.org>; Thu, 04 Jun 2026 03:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780568818; x=1781173618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUz2WE4nJMxXtiWAfXL/SMjJkp/AA6ShwTeAA6YskQk=;
 b=kwUoTflX+m3JDUycuJ+udhtKPXUvnWeP8z+Fz6aJHrOwbZ3Zzu6nvi5+EszMwtQqjB
 5XFK84+8gBLslzO5lupINICgTJhOIRCUaqDFmbB2K3AA3BRHWwNgteVzvRXLNssXSpIZ
 sU1p02lIOUV8UGWUq1vl3c+BX9431CZJH/BgrOzc0s+MyMdaJ1dGGewI4vh0TX9U/GU5
 Tjgw7oLTIpS+W2Xe+uPpxeuCIfOxBISwRXzA4sbygpxWlDhmso3fWMi4MCZtU62AGyon
 Tv1B+rtfeyAH22TVmkkS2zk7TeDxE36V7sBGfwJ1lDMgYhTHiU7botHLcGj3Y5FnrZ6i
 INGg==
X-Gm-Message-State: AOJu0Yz+5R7zC/Hq9ZMFtcA8GjKXbILY9uoB06mkId/20MtflytZkQyd
 3x6Pf560JSuEV1COhOe9LBiyk/na4l+L2BCC+ckUKBqF6xCyQNlwU2vE1D3HKPMiOSHOx8Tbx9m
 deHpQEZlhHkpZqBPFwLBuIcNikDCMcZ2hIxSusW4F7NlErq+qqBq2NwUCpkRF9lye1zBFJAeENB
 MC6ZS0Q4weXA0jdFV3bAk=
X-Gm-Gg: Acq92OHYzKhPEFYY0ki4zApAQfgiJ9NgmeNVDahpBSkTK29D+WNbwjVvBBSR0rb2QVG
 YtqA9MtlrQiX0RavAd5Mk4Tl5jJsgmcmNEGQIjgXdZlLyerJhchov+Y/A0rFylAMg6N0bw14iFc
 JXL9ToOqiVctY9bQxaaYEgpGQTEsuxGJpkJqPYp2AEblQSj6CTaj5jithT1JiuHF6m87ZWUsyW7
 qskRfHJjZZivtpIp0tqHuiPA30NSGblQ+QUAGTAAda3u9Zg6qN0cD/h4K17JM6LKoHOzLm3EztO
X-Received: by 2002:a05:7022:b8d:b0:137:e2a8:4173 with SMTP id
 a92af1059eb24-137f6c278ebmr2692292c88.36.1780568818253; 
 Thu, 04 Jun 2026 03:26:58 -0700 (PDT)
X-Received: by 2002:a05:7022:b8d:b0:137:e2a8:4173 with SMTP id
 a92af1059eb24-137f6c278ebmr2692275c88.36.1780568817676; Thu, 04 Jun 2026
 03:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260520022012.243619-1-pravin.bathija@dell.com>
 <20260520022012.243619-5-pravin.bathija@dell.com>
In-Reply-To: <20260520022012.243619-5-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 4 Jun 2026 12:26:46 +0200
X-Gm-Features: AVHnY4LOPCbWqbTLrP4_xPXgRycJMa98DWKADAZ3uZ-v-tuP-v8CH43D4gTea2k
Message-ID: <CAO55csyTk2TwYjiLmA3J5Tt+sJHKpNPE+0S0rYEbTyH71+-3Qg@mail.gmail.com>
Subject: Re: [PATCH v14 4/5] vhost: add mem region add/remove handlers
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net, Stephen Hemminger <stephen@networkplumber.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WP1l5y9-csffcIAytCIwpONcpw355VCyNOEI_nt6gXA_1780568818
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e0460006536afb40"
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

--000000000000e0460006536afb40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 4:20=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> Add support for VHOST_USER_ADD_MEM_REG, VHOST_USER_REM_MEM_REG and
> VHOST_USER_GET_MAX_MEM_SLOTS. Refactor memory initialization into
> common helper and add supporting functions for dynamic memory management.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> Acked-by: Fengchengwen <fengchengwen@huawei.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  lib/vhost/vhost_user.c | 255 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 255 insertions(+)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 94fca8b589..522ba1db82 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES,
> vhost_user_set_features, false, t
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false,
> true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner,
> false, false) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table=
,
> true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS,
> vhost_user_get_max_mem_slots, false, false) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg,
> true, true) \
> +VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg,
> true, true) \
>

The removal request does not expect FDs in ancillary data.
It should be:
VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg,
false, true)


>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base,
> true, true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true=
,
> true) \
>  VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num=
,
> false, true) \
> @@ -1167,6 +1170,24 @@ add_guest_pages(struct virtio_net *dev, struct
> rte_vhost_mem_region *reg,
>         return 0;
>  }
>
> +static void
> +remove_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region
> *reg)
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
> @@ -1591,6 +1612,240 @@ vhost_user_set_mem_table(struct virtio_net **pdev=
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
> + * translate_ring_addresses() may call numa_realloc(), which can
> reallocate
> + * the device structure.  The updated pointer is written back through
> *pdev
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
> +               #id " handler is not declared as locking all queue
> pairs"); \
> +       vhost_user_invalidate_vrings(pdev); \
> +} while (0)
> +
> +static int
> +vhost_user_add_mem_reg(struct virtio_net **pdev,
> +                       struct vhu_msg_context *ctx,
> +                       int main_fd __rte_unused)
> +{
> +       struct VhostUserMemoryRegion *region =3D
> &ctx->msg.payload.memreg.region;
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
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "too many memory
> regions already (%u)",
> +
>  dev->mem->nregions);
> +               goto close_msg_fds;
> +       }
> +
> +       /* make sure supplied memory fd present */
> +       if (ctx->fd_num !=3D 1) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "fd count makes no
> sense (%u)", ctx->fd_num);
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
> +                               "requested memory region overlaps with
> another region");
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
> +       struct rte_vhost_mem_region *reg =3D
> &dev->mem->regions[dev->mem->nregions];
> +
> +       reg->guest_phys_addr =3D region->guest_phys_addr;
> +       reg->guest_user_addr =3D region->userspace_addr;
> +       reg->size            =3D region->memory_size;
> +       reg->fd              =3D ctx->fds[0];
> +       ctx->fds[0]          =3D -1;
> +
> +       if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap
> region");
> +               if (reg->mmap_addr) {
> +                       /* mmap succeeded but a later step (e.g.
> add_guest_pages)
> +                        * failed; undo the mapping and any guest-page
> entries.
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
> +                * Cannot use vhost_user_postcopy_register() here because
> it
> +                * reads ctx->msg.payload.memory (SET_MEM_TABLE layout),
> but
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
> +       /* Reply with the back-end's mapping address per vhost-user spec =
*/
> +       ctx->msg.payload.memreg.region.userspace_addr =3D
> reg->host_user_addr;
> +       ctx->msg.size =3D sizeof(ctx->msg.payload.memreg);
> +       ctx->fd_num =3D 0;
> +
> +       return RTE_VHOST_MSG_RESULT_REPLY;
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
> +       struct VhostUserMemoryRegion *region =3D
> &ctx->msg.payload.memreg.region;
> +       struct virtio_net *dev =3D *pdev;
> +       uint32_t i;
> +
> +       if (dev->mem =3D=3D NULL || dev->mem->nregions =3D=3D 0) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to
> remove");
> +               close_msg_fds(ctx);
>
Not needed if properly declared.


> +               return RTE_VHOST_MSG_RESULT_ERR;
> +       }
> +
> +       if (validate_msg_fds(dev, ctx, 0) !=3D 0)
> +               return RTE_VHOST_MSG_RESULT_ERR;
>

With proper declaration, we can remove this check, as it is done in a
generic way.



> +
> +       for (i =3D 0; i < dev->mem->nregions; i++) {
> +               struct rte_vhost_mem_region *current_region =3D
> &dev->mem->regions[i];
> +
> +               /*
> +                * According to the vhost-user specification:
> +                * The memory region to be removed is identified by its
> GPA,
> +                * user address and size. The mmap offset is ignored.
> +                */
> +               if (region->userspace_addr =3D=3D
> current_region->guest_user_addr
> +                       && region->guest_phys_addr =3D=3D
> current_region->guest_phys_addr
> +                       && region->memory_size =3D=3D current_region->siz=
e) {
> +                       if (dev->async_copy && rte_vfio_is_enabled("vfio"=
))
> +                               async_dma_map_region(dev, current_region,
> false);
> +                       remove_guest_pages(dev, current_region);
>

You are missing the step to clear the IOTLB cache entries matching with
this removed region.
In vhost_user_set_mem_table(), a vhost_user_iotlb_flush_all() call is made,
but that would be kind of a nuclear option for memory hotplug.

I suggest removing only the entries matching the removed area, something
like this:
  if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
      vhost_user_iotlb_cache_remove(dev, current_region->guest_phys_addr,
current_region->size);


> +                       free_mem_region(current_region);
> +
> +                       /* Compact the regions array to keep it contiguou=
s
> */
> +                       if (i < dev->mem->nregions - 1) {
> +                               memmove(&dev->mem->regions[i],
> +                                       &dev->mem->regions[i + 1],
> +                                       (dev->mem->nregions - 1 - i) *
> +                                       sizeof(struct
> rte_vhost_mem_region));
> +
>  memset(&dev->mem->regions[dev->mem->nregions - 1],
> +                                       0, sizeof(struct
> rte_vhost_mem_region));
> +                       }
> +
> +                       dev->mem->nregions--;
> +                       dev_invalidate_vrings(pdev,
> VHOST_USER_REM_MEM_REG);
> +                       dev =3D *pdev;
> +                       close_msg_fds(ctx);
>
And no need to close FDs, are we are now sure none were provided.


> +                       return RTE_VHOST_MSG_RESULT_OK;
> +               }
> +       }
> +
> +       VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to find region");
> +       close_msg_fds(ctx);
>

Same, no more needed.


> +       return RTE_VHOST_MSG_RESULT_ERR;
> +}
> +
>  static bool
>  vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
>  {
> --
> 2.43.0
>
>

--000000000000e0460006536afb40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 20,=
 2026 at 4:20=E2=80=AFAM &lt;<a href=3D"mailto:pravin.bathija@dell.com">pra=
vin.bathija@dell.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">From: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bat=
hija@dell.com" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
<br>
Add support for VHOST_USER_ADD_MEM_REG, VHOST_USER_REM_MEM_REG and<br>
VHOST_USER_GET_MAX_MEM_SLOTS. Refactor memory initialization into<br>
common helper and add supporting functions for dynamic memory management.<b=
r>
<br>
Signed-off-by: Pravin M Bathija &lt;<a href=3D"mailto:pravin.bathija@dell.c=
om" target=3D"_blank">pravin.bathija@dell.com</a>&gt;<br>
Acked-by: Fengchengwen &lt;<a href=3D"mailto:fengchengwen@huawei.com" targe=
t=3D"_blank">fengchengwen@huawei.com</a>&gt;<br>
Reviewed-by: Stephen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber=
.com" target=3D"_blank">stephen@networkplumber.com</a>&gt;<br>
Acked-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin@redhat.com"=
 target=3D"_blank">maxime.coquelin@redhat.com</a>&gt;<br>
---<br>
=C2=A0lib/vhost/vhost_user.c | 255 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 255 insertions(+)<br>
<br>
diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c<br>
index 94fca8b589..522ba1db82 100644<br>
--- a/lib/vhost/vhost_user.c<br>
+++ b/lib/vhost/vhost_user.c<br>
@@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user=
_set_features, false, t<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, fal=
se, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner,=
 false, false) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_ta=
ble, true, true) \<br>
+VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem=
_slots, false, false) \<br>
+VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true=
, true) \<br>
+VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true=
, true) \<br></blockquote><div><br></div><div>The removal request does not =
expect FDs in ancillary data.</div><div>It should be:</div><div>VHOST_MESSA=
GE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, false, true)</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_bas=
e, true, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, t=
rue, true) \<br>
=C2=A0VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_=
num, false, true) \<br>
@@ -1167,6 +1170,24 @@ add_guest_pages(struct virtio_net *dev, struct rte_v=
host_mem_region *reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
+static void<br>
+remove_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *re=
g)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t reg_start =3D reg-&gt;host_user_addr;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t reg_end =3D reg_start + reg-&gt;size;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i, j =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; dev-&gt;nr_guest_pages; i+=
+) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;guest_p=
ages[i].host_user_addr &gt;=3D reg_start &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&=
gt;guest_pages[i].host_user_addr &lt; reg_end)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (j !=3D i)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev-&gt;guest_pages[j] =3D dev-&gt;guest_pages[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0j++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;nr_guest_pages =3D j;<br>
+}<br>
+<br>
=C2=A0#ifdef RTE_LIBRTE_VHOST_DEBUG<br>
=C2=A0/* TODO: enable it only in debug mode? */<br>
=C2=A0static void<br>
@@ -1591,6 +1612,240 @@ vhost_user_set_mem_table(struct virtio_net **pdev,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RTE_VHOST_MSG_RESULT_ERR;<br>
=C2=A0}<br>
<br>
+<br>
+static int<br>
+vhost_user_get_max_mem_slots(struct virtio_net **pdev __rte_unused,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct vhu_msg_context *ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int main_fd __rte_unused)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_mem_slots =3D VHOST_MEMORY_MAX_NRE=
GIONS;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;msg.payload.u64 =3D max_mem_slots;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;msg.size =3D sizeof(ctx-&gt;msg.payload=
.u64);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;fd_num =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return RTE_VHOST_MSG_RESULT_REPLY;<br>
+}<br>
+<br>
+/*<br>
+ * Invalidate and re-translate all vring addresses after the memory table<=
br>
+ * has been modified (add/remove region).<br>
+ *<br>
+ * translate_ring_addresses() may call numa_realloc(), which can reallocat=
e<br>
+ * the device structure.=C2=A0 The updated pointer is written back through=
 *pdev<br>
+ * so callers must refresh their local &quot;dev&quot; afterwards: dev =3D=
 *pdev.<br>
+ */<br>
+static void<br>
+vhost_user_invalidate_vrings(struct virtio_net **pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_net *dev =3D *pdev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; dev-&gt;nr_vring; i++) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vhost_virtqu=
eue *vq =3D dev-&gt;virtqueue[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vq)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vq-&gt;desc || =
vq-&gt;avail || vq-&gt;used) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vq_assert_lock(dev, vq);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vring_invalidate(dev, vq);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0translate_ring_addresses(&amp;dev, &amp;vq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*pdev =3D dev;<br>
+}<br>
+<br>
+/*<br>
+ * Macro wrapper that performs the compile-time lock assertion with the<br=
>
+ * correct message ID at the call site, then calls the implementation.<br>
+ */<br>
+#define dev_invalidate_vrings(pdev, id) do { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0static_assert(id ## _LOCK_ALL_QPS, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#id &quot; handler =
is not declared as locking all queue pairs&quot;); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_user_invalidate_vrings(pdev); \<br>
+} while (0)<br>
+<br>
+static int<br>
+vhost_user_add_mem_reg(struct virtio_net **pdev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct vhu_msg_context *ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int main_fd __rte_unused)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct VhostUserMemoryRegion *region =3D &amp;c=
tx-&gt;msg.payload.memreg.region;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_net *dev =3D *pdev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* convert first region add to normal memory ta=
ble set */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;mem =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vhost_user_init=
ialize_memory(pdev) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto close_msg_fds;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make sure new region will fit */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;mem-&gt;nregions &gt;=3D VHOST_MEMO=
RY_MAX_NREGIONS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_CONFIG_LOG(de=
v-&gt;ifname, ERR, &quot;too many memory regions already (%u)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;mem-&gt;nregions);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto close_msg_fds;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* make sure supplied memory fd present */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ctx-&gt;fd_num !=3D 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_CONFIG_LOG(de=
v-&gt;ifname, ERR, &quot;fd count makes no sense (%u)&quot;, ctx-&gt;fd_num=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto close_msg_fds;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Make sure no overlap in guest virtual addres=
s space */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; dev-&gt;mem-&gt;nregions; =
i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_vhost_me=
m_region *cur =3D &amp;dev-&gt;mem-&gt;regions[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t cur_start =
=3D cur-&gt;guest_user_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t cur_end =
=3D cur_start + cur-&gt;size - 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t new_start =
=3D region-&gt;userspace_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t new_end =
=3D new_start + region-&gt;memory_size - 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (new_end &gt;=3D=
 cur_start &amp;&amp; new_start &lt;=3D cur_end) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VHOST_CONFIG_LOG(dev-&gt;ifname, ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;requested memory region overlap=
s with another region&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VHOST_CONFIG_LOG(dev-&gt;ifname, ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\tRequested region address:0x%&=
quot; PRIx64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region-&gt;userspace_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VHOST_CONFIG_LOG(dev-&gt;ifname, ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\tRequested region size:0x%&quo=
t; PRIx64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0region-&gt;memory_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VHOST_CONFIG_LOG(dev-&gt;ifname, ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\tOverlapping region address:0x=
%&quot; PRIx64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur-&gt;guest_user_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VHOST_CONFIG_LOG(dev-&gt;ifname, ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\tOverlapping region size:0x%&q=
uot; PRIx64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cur-&gt;size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto close_msg_fds;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* New region goes at the end of the contiguous=
 array */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_vhost_mem_region *reg =3D &amp;dev-&=
gt;mem-&gt;regions[dev-&gt;mem-&gt;nregions];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;guest_phys_addr =3D region-&gt;guest_ph=
ys_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;guest_user_addr =3D region-&gt;userspac=
e_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;size=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D region-&gt;memory_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0reg-&gt;fd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D ctx-&gt;fds[0];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;fds[0]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D -1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (vhost_user_mmap_region(dev, reg, region-&gt=
;mmap_offset) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_CONFIG_LOG(de=
v-&gt;ifname, ERR, &quot;failed to mmap region&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (reg-&gt;mmap_ad=
dr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* mmap succeeded but a later step (e.g. add_guest_pages)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * failed; undo the mapping and any guest-page entries.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0remove_guest_pages(dev, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_mem_region(reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0close(reg-&gt;fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0reg-&gt;fd =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto close_msg_fds;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;mem-&gt;nregions++;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;async_copy &amp;&amp; rte_vfio_is_e=
nabled(&quot;vfio&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (async_dma_map_r=
egion(dev, reg, true) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto free_new_region_no_dma;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;postcopy_listening) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Cannot use vhost=
_user_postcopy_register() here because it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * reads ctx-&gt;ms=
g.payload.memory (SET_MEM_TABLE layout), but<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * ADD_MEM_REG uses=
 the memreg payload.=C2=A0 Register the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * single new regio=
n directly instead.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vhost_user_post=
copy_region_register(dev, reg) &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto free_new_region;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_invalidate_vrings(pdev, VHOST_USER_ADD_MEM_=
REG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D *pdev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dump_guest_pages(dev);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reply with the back-end&#39;s mapping addres=
s per vhost-user spec */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;msg.payload.memreg.region.userspace_add=
r =3D reg-&gt;host_user_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;msg.size =3D sizeof(ctx-&gt;msg.payload=
.memreg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;fd_num =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return RTE_VHOST_MSG_RESULT_REPLY;<br>
+<br>
+free_new_region:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;async_copy &amp;&amp; rte_vfio_is_e=
nabled(&quot;vfio&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0async_dma_map_regio=
n(dev, reg, false);<br>
+free_new_region_no_dma:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0remove_guest_pages(dev, reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free_mem_region(reg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev-&gt;mem-&gt;nregions--;<br>
+close_msg_fds:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0close_msg_fds(ctx);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return RTE_VHOST_MSG_RESULT_ERR;<br>
+}<br>
+<br>
+static int<br>
+vhost_user_rem_mem_reg(struct virtio_net **pdev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct vhu_msg_context *ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int main_fd __rte_unused)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct VhostUserMemoryRegion *region =3D &amp;c=
tx-&gt;msg.payload.memreg.region;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_net *dev =3D *pdev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dev-&gt;mem =3D=3D NULL || dev-&gt;mem-&gt;=
nregions =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_CONFIG_LOG(de=
v-&gt;ifname, ERR, &quot;no memory regions to remove&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close_msg_fds(ctx);=
<br></blockquote><div>Not needed if properly declared.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RTE_VHOST_MS=
G_RESULT_ERR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (validate_msg_fds(dev, ctx, 0) !=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return RTE_VHOST_MS=
G_RESULT_ERR;<br></blockquote><div><br></div><div>With proper declaration, =
we can remove this check, as it is done in a generic way.</div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; dev-&gt;mem-&gt;nregions; =
i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rte_vhost_me=
m_region *current_region =3D &amp;dev-&gt;mem-&gt;regions[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * According to the=
 vhost-user specification:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The memory regio=
n to be removed is identified by its GPA,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * user address and=
 size. The mmap offset is ignored.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (region-&gt;user=
space_addr =3D=3D current_region-&gt;guest_user_addr<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; region-&gt;guest_phys_addr =3D=3D current_region-&gt;g=
uest_phys_addr<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; region-&gt;memory_size =3D=3D current_region-&gt;size)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (dev-&gt;async_copy &amp;&amp; rte_vfio_is_enabled(&quot;vfio&=
quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0async_dma_map_region(dev, current_reg=
ion, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0remove_guest_pages(dev, current_region);<br></blockquote><div><br=
></div><div>You are missing the step to clear the IOTLB cache entries match=
ing with this removed region.</div><div>In vhost_user_set_mem_table(), a=C2=
=A0vhost_user_iotlb_flush_all() call is made,</div><div>but that would be k=
ind of a nuclear option for memory hotplug.</div><div><br></div><div>I sugg=
est removing only the entries matching the removed area, something like thi=
s:</div><div>=C2=A0 if (dev-&gt;features &amp; (1ULL &lt;&lt; VIRTIO_F_IOMM=
U_PLATFORM))<br>=C2=A0 =C2=A0 =C2=A0 vhost_user_iotlb_cache_remove(dev, cur=
rent_region-&gt;guest_phys_addr, current_region-&gt;size);</div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_mem_region(current_region);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Compact the regions array to keep it contiguous */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (i &lt; dev-&gt;mem-&gt;nregions - 1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memmove(&amp;dev-&gt;mem-&gt;regions[=
i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;dev-=
&gt;mem-&gt;regions[i + 1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(dev-&gt;=
mem-&gt;nregions - 1 - i) *<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(st=
ruct rte_vhost_mem_region));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;dev-&gt;mem-&gt;regions[d=
ev-&gt;mem-&gt;nregions - 1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, sizeof=
(struct rte_vhost_mem_region));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev-&gt;mem-&gt;nregions--;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_invalidate_vrings(pdev, VHOST_USER_REM_MEM_REG);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev =3D *pdev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0close_msg_fds(ctx);<br></blockquote><div><div>And no need to clos=
e FDs, are we are now sure none were provided.</div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return RTE_VHOST_MSG_RESULT_OK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VHOST_CONFIG_LOG(dev-&gt;ifname, ERR, &quot;fai=
led to find region&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0close_msg_fds(ctx);<br></blockquote><div><br></=
div><div>Same, no more needed.</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return RTE_VHOST_MSG_RESULT_ERR;<br>
+}<br>
+<br>
=C2=A0static bool<br>
=C2=A0vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)<br>
=C2=A0{<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000e0460006536afb40--

