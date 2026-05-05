Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A4CD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 09:48:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B37FC4060B;
	Tue,  5 May 2026 11:48:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id DEF2040272
 for <dev@dpdk.org>; Tue,  5 May 2026 11:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777974495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DSbHSR3m3DVdHjRwONc+8RAONWsSM3M+2x8uICcsrLs=;
 b=Vd+OtEC8JRS8l2W+uWqLVp4P6Tg0gtJ2uqURS7BXApS4Jy0UzXc3XZ+DaBJClYINbygmYL
 dZ+ODk2HHYxZOE+1hGBvQHIRwdgR0u+zPWpN95fEvCWK1MyULp9+SL7WayJlVUdGLWszuu
 McR3E3ntj5/o9f747rJ5nQYj+bVeoUQ=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-fkx6nh4xNeOHbQXxG7QokQ-1; Tue, 05 May 2026 05:48:13 -0400
X-MC-Unique: fkx6nh4xNeOHbQXxG7QokQ-1
X-Mimecast-MFC-AGG-ID: fkx6nh4xNeOHbQXxG7QokQ_1777974492
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-130bcd94d53so1537600c88.1
 for <dev@dpdk.org>; Tue, 05 May 2026 02:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777974492; x=1778579292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSbHSR3m3DVdHjRwONc+8RAONWsSM3M+2x8uICcsrLs=;
 b=r/AXleQRQ+3dYOaD6f4lTlxf4sTcz0xXQ7MC2q8KagHz76GTGvhCw7ybScVZGjD3rM
 YoXncBQmAQ/smPPojRkrYFEWsnaFRs2HjoZ4sz2ZzBjwBN0cV2/cCJdjJIFe5xDJOCKN
 cyS5Kr1AGbOtocHTpZWe2wC0XBoXvM77cMQ94hnMbwAQJ0UK6NuU2Lef0LhxLIdrATMd
 tqUDmQpBUW7lALrwePgLijPuG72fsWIwzxbhzRL4jPNSFouVtoEef6aDmPyD86lm7sEi
 v4y/OY6fUbDtfjocQnUT3z4yDQXl+57KxTPaxFGTljGBAkOHgkJykOB7xHGTh/0yueyX
 HN6Q==
X-Gm-Message-State: AOJu0Ywb7RAtK55e89tgyF7lrXuH8a6q1KHSwEvu+hK8rfdEI8QakryD
 ri7lgrou/icQuuso43DcnewT5RnuHcfmbL6eg9t7fcjh8R2kg3VzI7MCzPrSwcEBhwmFvoQ9ISa
 Umd9g0LDH7hXNvckZ3T4dvi4uOMaH7NvD1dfWGMfK9fgOADQHGI7ebxJgGEWGDwh7UWneYNZ1IE
 LyMCItE83UzxuJ+Y3pfmQ=
X-Gm-Gg: AeBDietfI3RmGPfqIizR0/qPLJEr8ZkpnH+qRGZKI9py2uwNLKFf2urBR3k7qD9RiEc
 bJ9Ah9oWI/tncjOlOtF+OrhwpejHwAU59SrtvYk0xBYhPb9c0ZfbJwHRSoMDXQenkJSjW7phccc
 Krys1nvyGee5mbaANvEAEyEFtPdzmQTQ+ROQdvhquTlDPzQBGbHcLDmDRP3j5ludNnOJrDvvbj7
 KuWDYGBsNjWs2RZI3QRSFSl7JqKJn68mxfT7CulQYCnl9npk2qqbfE8DVMsjd3OJlJshy0DGMAg
X-Received: by 2002:a05:7022:43a3:b0:12d:b7e5:a691 with SMTP id
 a92af1059eb24-12dfd7a0e78mr6253872c88.7.1777974492092; 
 Tue, 05 May 2026 02:48:12 -0700 (PDT)
X-Received: by 2002:a05:7022:43a3:b0:12d:b7e5:a691 with SMTP id
 a92af1059eb24-12dfd7a0e78mr6253866c88.7.1777974491533; Tue, 05 May 2026
 02:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260505055251.818594-1-pravin.bathija@dell.com>
 <20260505055251.818594-4-pravin.bathija@dell.com>
In-Reply-To: <20260505055251.818594-4-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 5 May 2026 11:47:59 +0200
X-Gm-Features: AVHnY4L6OLqSu7JAyfjOKmFw8PmThA6mgpCVWsst_azU22DyYQEBqOFO5pvGna4
Message-ID: <CAO55cswyN6wL5sh5Y+0mt5UcfwSef9N6DFE4eoOQ5zxiWtP12w@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] vhost_user: support function defines for back-end
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, stephen@networkplumber.org, thomas@monjalon.net, 
 fengchengwen@huawei.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S2kbjy5FtaXGoWkENFYYnl5LqE5m-EMYkS9ERar-6V8_1777974492
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fce8d306510ef125"
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

--000000000000fce8d306510ef125
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 7:53=E2=80=AFAM <pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>
> Here we define support functions which are called from the various
> vhost-user back-end message functions like set memory table, get
> memory slots, add memory region, remove memory region.  These are
> essentially common functions to initialize memory, unmap a set of
> memory regions, perform register copy, align memory addresses,
> dma map/unmap a single memory region and remove guest pages by
> removing all entries belonging to a given memory region.
>
> Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
> ---
>  lib/vhost/vhost_user.c | 146 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 136 insertions(+), 10 deletions(-)
>
> diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
> index 4bfb13fb98..1f96ecf963 100644
> --- a/lib/vhost/vhost_user.c
> +++ b/lib/vhost/vhost_user.c
> @@ -171,6 +171,52 @@ get_blk_size(int fd)
>         return ret =3D=3D -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
>  }
>
> +static int
> +async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region
> *reg, bool do_map)
> +{
> +       uint32_t i;
> +       int ret;
> +       uint64_t reg_start =3D reg->host_user_addr;
> +       uint64_t reg_end =3D reg_start + reg->size;
> +
> +       for (i =3D 0; i < dev->nr_guest_pages; i++) {
> +               struct guest_page *page =3D &dev->guest_pages[i];
> +
> +               /* Only process pages belonging to this region */
> +               if (page->host_user_addr < reg_start ||
> +                   page->host_user_addr >=3D reg_end)
> +                       continue;
> +
> +               if (do_map) {
> +                       ret =3D
> rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
> +                                       page->host_user_addr,
> +                                       page->host_iova,
> +                                       page->size);
> +                       if (ret) {
> +                               if (rte_errno =3D=3D ENODEV)
> +                                       return 0;
> +
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA
> engine map failed");
> +                               return -1;
> +                       }
> +               } else {
> +                       ret =3D
> rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
> +                                       page->host_user_addr,
> +                                       page->host_iova,
> +                                       page->size);
> +                       if (ret) {
> +                               if (rte_errno =3D=3D EINVAL)
> +                                       return 0;
> +
> +                               VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA
> engine unmap failed");
> +                               return -1;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static void
>  async_dma_map(struct virtio_net *dev, bool do_map)
>  {
> @@ -225,7 +271,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
>  }
>

I think async_dma_map and async_dma_map_region should be refactored to
avoid code duplication,
What about something like this:

  static void
  async_dma_map(struct virtio_net *dev, bool do_map)
  {
      uint32_t i;
      struct rte_vhost_mem_region *reg;

      for (i =3D 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
          reg =3D &dev->mem->regions[i];
          if (reg->host_user_addr =3D=3D 0)
              continue;
          async_dma_map_region(dev, reg, do_map);
     }
  }

Also, duplicating code and stripping comments is not ideal as they are
important
(i.e. to understand why we can ignore ENODEV and EINVAL)


>  static void
> -free_mem_region(struct virtio_net *dev)
> +free_mem_region(struct rte_vhost_mem_region *reg)
> +{
> +       if (reg !=3D NULL && reg->mmap_addr) {
> +               munmap(reg->mmap_addr, reg->mmap_size);
> +               close(reg->fd);
> +               memset(reg, 0, sizeof(struct rte_vhost_mem_region));
> +       }
> +}
> +
> +static void
> +free_all_mem_regions(struct virtio_net *dev)
>  {
>         uint32_t i;
>         struct rte_vhost_mem_region *reg;
> @@ -236,12 +292,10 @@ free_mem_region(struct virtio_net *dev)
>         if (dev->async_copy && rte_vfio_is_enabled("vfio"))
>                 async_dma_map(dev, false);
>
> -       for (i =3D 0; i < dev->mem->nregions; i++) {
> +       for (i =3D 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>                 reg =3D &dev->mem->regions[i];
> -               if (reg->host_user_addr) {
> -                       munmap(reg->mmap_addr, reg->mmap_size);
> -                       close(reg->fd);
> -               }
> +               if (reg->mmap_addr)
> +                       free_mem_region(reg);
>         }
>  }
>
> @@ -255,7 +309,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
>                 vdpa_dev->ops->dev_cleanup(dev->vid);
>
>         if (dev->mem) {
> -               free_mem_region(dev);
> +               free_all_mem_regions(dev);
>                 rte_free(dev->mem);
>                 dev->mem =3D NULL;
>         }
> @@ -704,7 +758,7 @@ numa_realloc(struct virtio_net **pdev, struct
> vhost_virtqueue **pvq)
>         vhost_devices[dev->vid] =3D dev;
>
>         mem_size =3D sizeof(struct rte_vhost_memory) +
> -               sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
> +               sizeof(struct rte_vhost_mem_region) *
> VHOST_MEMORY_MAX_NREGIONS;
>         mem =3D rte_realloc_socket(dev->mem, mem_size, 0, node);
>         if (!mem) {
>                 VHOST_CONFIG_LOG(dev->ifname, ERR,
> @@ -808,8 +862,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void
> *ptr)
>         uint32_t i;
>         uintptr_t hua =3D (uintptr_t)ptr;
>
> -       for (i =3D 0; i < mem->nregions; i++) {
> +       for (i =3D 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
>                 r =3D &mem->regions[i];
> +               if (r->host_user_addr =3D=3D 0)
> +                       continue;
>                 if (hua >=3D r->host_user_addr &&
>                         hua < r->host_user_addr + r->size) {
>                         return get_blk_size(r->fd);
> @@ -1136,6 +1192,24 @@ add_guest_pages(struct virtio_net *dev, struct
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
> @@ -1246,10 +1320,14 @@ vhost_user_postcopy_register(struct virtio_net
> *dev, int main_fd,
>          * DPDK's virtual address with Qemu, so that Qemu can
>          * retrieve the region offset when handling userfaults.
>          */
> +       int reg_msg_index =3D 0;
>         memory =3D &ctx->msg.payload.memory;
>         for (i =3D 0; i < memory->nregions; i++) {
>                 reg =3D &dev->mem->regions[i];
> -               memory->regions[i].userspace_addr =3D reg->host_user_addr=
;
> +               if (reg->host_user_addr =3D=3D 0)
> +                       continue;
> +               memory->regions[reg_msg_index].userspace_addr =3D
> reg->host_user_addr;
> +               reg_msg_index++;
>         }
>
>         /* Send the addresses back to qemu */
> @@ -1278,6 +1356,8 @@ vhost_user_postcopy_register(struct virtio_net *dev=
,
> int main_fd,
>         /* Now userfault register and we can use the memory */
>         for (i =3D 0; i < memory->nregions; i++) {
>                 reg =3D &dev->mem->regions[i];
> +               if (reg->host_user_addr =3D=3D 0)
> +                       continue;
>                 if (vhost_user_postcopy_region_register(dev, reg) < 0)
>                         return -1;
>         }
> @@ -1382,6 +1462,52 @@ vhost_user_mmap_region(struct virtio_net *dev,
>         return 0;
>  }
>
> +static int
> +vhost_user_initialize_memory(struct virtio_net **pdev)
> +{
> +       struct virtio_net *dev =3D *pdev;
> +       int numa_node =3D SOCKET_ID_ANY;
> +
> +       if (dev->mem !=3D NULL) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                       "memory already initialized, free it first");
> +               return -1;
> +       }
> +
> +       /*
> +        * If VQ 0 has already been allocated, try to allocate on the sam=
e
> +        * NUMA node. It can be reallocated later in numa_realloc().
> +        */
> +       if (dev->nr_vring > 0)
> +               numa_node =3D dev->virtqueue[0]->numa_node;
> +
> +       dev->nr_guest_pages =3D 0;
> +       if (dev->guest_pages =3D=3D NULL) {
> +               dev->max_guest_pages =3D 8;
> +               dev->guest_pages =3D rte_zmalloc_socket(NULL,
> +                                       dev->max_guest_pages *
> +                                       sizeof(struct guest_page),
> +                                       RTE_CACHE_LINE_SIZE,
> +                                       numa_node);
> +               if (dev->guest_pages =3D=3D NULL) {
> +                       VHOST_CONFIG_LOG(dev->ifname, ERR,
> +                               "failed to allocate memory for
> dev->guest_pages");
> +                       return -1;
> +               }
> +       }
> +
> +       dev->mem =3D rte_zmalloc_socket("vhost-mem-table", sizeof(struct
> rte_vhost_memory) +
> +               sizeof(struct rte_vhost_mem_region) *
> VHOST_MEMORY_MAX_NREGIONS, 0, numa_node);
> +       if (dev->mem =3D=3D NULL) {
> +               VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate
> memory for dev->mem");
> +               rte_free(dev->guest_pages);
> +               dev->guest_pages =3D NULL;
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>

I think it should be in a dedicated patch, and in the same patch
would vhost_user_set_mem_table() make use of it.
The idea is to make it straitforward you are doing a refactoring, and
easily check the code you are extracting out from
vhost_user_set_mem_table() into a new function has not been changed
in-between.


>  static int
>  vhost_user_set_mem_table(struct virtio_net **pdev,
>                         struct vhu_msg_context *ctx,
> --
> 2.43.0
>
>

--000000000000fce8d306510ef125
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSBnbWFpbF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBUdWUsIE1heSA1LCAyMDI2IGF0IDc6NTPigK9BTSAmbHQ7PGEgaHJlZj0i
bWFpbHRvOnByYXZpbi5iYXRoaWphQGRlbGwuY29tIj5wcmF2aW4uYmF0aGlqYUBkZWxsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+RnJvbTogUHJhdmluIE0gQmF0aGlqYSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOnByYXZpbi5iYXRoaWphQGRlbGwuY29tIiB0YXJnZXQ9Il9ibGFuayI+
cHJhdmluLmJhdGhpamFAZGVsbC5jb208L2E+Jmd0Ozxicj4NCjxicj4NCkhlcmUgd2UgZGVmaW5l
IHN1cHBvcnQgZnVuY3Rpb25zIHdoaWNoIGFyZSBjYWxsZWQgZnJvbSB0aGUgdmFyaW91czxicj4N
CnZob3N0LXVzZXIgYmFjay1lbmQgbWVzc2FnZSBmdW5jdGlvbnMgbGlrZSBzZXQgbWVtb3J5IHRh
YmxlLCBnZXQ8YnI+DQptZW1vcnkgc2xvdHMsIGFkZCBtZW1vcnkgcmVnaW9uLCByZW1vdmUgbWVt
b3J5IHJlZ2lvbi7CoCBUaGVzZSBhcmU8YnI+DQplc3NlbnRpYWxseSBjb21tb24gZnVuY3Rpb25z
IHRvIGluaXRpYWxpemUgbWVtb3J5LCB1bm1hcCBhIHNldCBvZjxicj4NCm1lbW9yeSByZWdpb25z
LCBwZXJmb3JtIHJlZ2lzdGVyIGNvcHksIGFsaWduIG1lbW9yeSBhZGRyZXNzZXMsPGJyPg0KZG1h
IG1hcC91bm1hcCBhIHNpbmdsZSBtZW1vcnkgcmVnaW9uIGFuZCByZW1vdmUgZ3Vlc3QgcGFnZXMg
Ynk8YnI+DQpyZW1vdmluZyBhbGwgZW50cmllcyBiZWxvbmdpbmcgdG8gYSBnaXZlbiBtZW1vcnkg
cmVnaW9uLjxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IFByYXZpbiBNIEJhdGhpamEgJmx0Ozxh
IGhyZWY9Im1haWx0bzpwcmF2aW4uYmF0aGlqYUBkZWxsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnBy
YXZpbi5iYXRoaWphQGRlbGwuY29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGxpYi92aG9zdC92
aG9zdF91c2VyLmMgfCAxNDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS08YnI+DQrCoDEgZmlsZSBjaGFuZ2VkLCAxMzYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25z
KC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2xpYi92aG9zdC92aG9zdF91c2VyLmMgYi9saWIv
dmhvc3Qvdmhvc3RfdXNlci5jPGJyPg0KaW5kZXggNGJmYjEzZmI5OC4uMWY5NmVjZjk2MyAxMDA2
NDQ8YnI+DQotLS0gYS9saWIvdmhvc3Qvdmhvc3RfdXNlci5jPGJyPg0KKysrIGIvbGliL3Zob3N0
L3Zob3N0X3VzZXIuYzxicj4NCkBAIC0xNzEsNiArMTcxLDUyIEBAIGdldF9ibGtfc2l6ZShpbnQg
ZmQpPGJyPg0KwqAgwqAgwqAgwqAgcmV0dXJuIHJldCA9PSAtMSA/ICh1aW50NjRfdCktMSA6ICh1
aW50NjRfdClzdGF0LnN0X2Jsa3NpemU7PGJyPg0KwqB9PGJyPg0KPGJyPg0KK3N0YXRpYyBpbnQ8
YnI+DQorYXN5bmNfZG1hX21hcF9yZWdpb24oc3RydWN0IHZpcnRpb19uZXQgKmRldiwgc3RydWN0
IHJ0ZV92aG9zdF9tZW1fcmVnaW9uICpyZWcsIGJvb2wgZG9fbWFwKTxicj4NCit7PGJyPg0KK8Kg
IMKgIMKgIMKgdWludDMyX3QgaTs8YnI+DQorwqAgwqAgwqAgwqBpbnQgcmV0Ozxicj4NCivCoCDC
oCDCoCDCoHVpbnQ2NF90IHJlZ19zdGFydCA9IHJlZy0mZ3Q7aG9zdF91c2VyX2FkZHI7PGJyPg0K
K8KgIMKgIMKgIMKgdWludDY0X3QgcmVnX2VuZCA9IHJlZ19zdGFydCArIHJlZy0mZ3Q7c2l6ZTs8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IGRldi0mZ3Q7bnJfZ3Vl
c3RfcGFnZXM7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBndWVz
dF9wYWdlICpwYWdlID0gJmFtcDtkZXYtJmd0O2d1ZXN0X3BhZ2VzW2ldOzxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBPbmx5IHByb2Nlc3MgcGFnZXMgYmVsb25naW5nIHRv
IHRoaXMgcmVnaW9uICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHBhZ2UtJmd0
O2hvc3RfdXNlcl9hZGRyICZsdDsgcmVnX3N0YXJ0IHx8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcGFnZS0mZ3Q7aG9zdF91c2VyX2FkZHIgJmd0Oz0gcmVnX2VuZCk8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRvX21hcCkgezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IHJ0ZV92ZmlvX2NvbnRhaW5lcl9kbWFfbWFwKFJU
RV9WRklPX0RFRkFVTFRfQ09OVEFJTkVSX0ZELDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhZ2UtJmd0O2hvc3RfdXNlcl9h
ZGRyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHBhZ2UtJmd0O2hvc3RfaW92YSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYWdlLSZndDtzaXplKTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0KSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJ0ZV9l
cnJubyA9PSBFTk9ERVYpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFZIT1NUX0NPTkZJR19MT0coZGV2
LSZndDtpZm5hbWUsIEVSUiwgJnF1b3Q7RE1BIGVuZ2luZSBtYXAgZmFpbGVkJnF1b3Q7KTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
LTE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0ID0gcnRlX3ZmaW9fY29udGFpbmVyX2RtYV91bm1hcChSVEVfVkZJT19E
RUZBVUxUX0NPTlRBSU5FUl9GRCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYWdlLSZndDtob3N0X3VzZXJfYWRkciw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBwYWdlLSZndDtob3N0X2lvdmEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGFnZS0mZ3Q7c2l6ZSk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCkgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChydGVfZXJybm8gPT0g
RUlOVkFMKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiAwOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWSE9TVF9DT05GSUdfTE9HKGRldi0mZ3Q7aWZu
YW1lLCBFUlIsICZxdW90O0RNQSBlbmdpbmUgdW5tYXAgZmFpbGVkJnF1b3Q7KTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLTE7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oHJldHVybiAwOzxicj4NCit9PGJyPg0KKzxicj4NCsKgc3RhdGljIHZvaWQ8YnI+DQrCoGFzeW5j
X2RtYV9tYXAoc3RydWN0IHZpcnRpb19uZXQgKmRldiwgYm9vbCBkb19tYXApPGJyPg0KwqB7PGJy
Pg0KQEAgLTIyNSw3ICsyNzEsMTcgQEAgYXN5bmNfZG1hX21hcChzdHJ1Y3QgdmlydGlvX25ldCAq
ZGV2LCBib29sIGRvX21hcCk8YnI+DQrCoH08YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSB0aGlua8KgYXN5bmNfZG1hX21hcCBhbmTCoGFzeW5jX2RtYV9tYXBfcmVnaW9uIHNo
b3VsZCBiZSByZWZhY3RvcmVkIHRvIGF2b2lkIGNvZGUgZHVwbGljYXRpb24sPC9kaXY+PGRpdj5X
aGF0IGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXM6PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7C
oCBzdGF0aWMgdm9pZDxicj7CoCBhc3luY19kbWFfbWFwKHN0cnVjdCB2aXJ0aW9fbmV0ICpkZXYs
IGJvb2wgZG9fbWFwKTxicj7CoCB7PGJyPsKgIMKgIMKgIHVpbnQzMl90IGk7PGJyPsKgIMKgIMKg
IHN0cnVjdCBydGVfdmhvc3RfbWVtX3JlZ2lvbiAqcmVnOzxicj48YnI+wqAgwqAgwqAgZm9yIChp
ID0gMDsgaSAmbHQ7IFZIT1NUX01FTU9SWV9NQVhfTlJFR0lPTlM7IGkrKykgezxicj7CoCDCoCDC
oCDCoCDCoCByZWcgPSAmYW1wO2Rldi0mZ3Q7bWVtLSZndDtyZWdpb25zW2ldOzxicj7CoCDCoCDC
oCDCoCDCoCBpZiAocmVnLSZndDtob3N0X3VzZXJfYWRkciA9PSAwKTxicj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCBjb250aW51ZTs8YnI+wqAgwqAgwqAgwqAgwqAgYXN5bmNfZG1hX21hcF9yZWdpb24o
ZGV2LCByZWcsIGRvX21hcCk7PGJyPsKgIMKgIMKgfTxicj7CoCB9PC9kaXY+PGRpdj7CoDwvZGl2
PjxkaXY+QWxzbywgZHVwbGljYXRpbmcgY29kZSBhbmQgc3RyaXBwaW5nIGNvbW1lbnRzIGlzIG5v
dCBpZGVhbCBhcyB0aGV5IGFyZSBpbXBvcnRhbnQ8L2Rpdj48ZGl2PihpLmUuIHRvIHVuZGVyc3Rh
bmQgd2h5IHdlIGNhbiBpZ25vcmUgRU5PREVWIGFuZCBFSU5WQUwpPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHgg
MHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmct
bGVmdDoxZXgiPg0KPGJyPg0KwqBzdGF0aWMgdm9pZDxicj4NCi1mcmVlX21lbV9yZWdpb24oc3Ry
dWN0IHZpcnRpb19uZXQgKmRldik8YnI+DQorZnJlZV9tZW1fcmVnaW9uKHN0cnVjdCBydGVfdmhv
c3RfbWVtX3JlZ2lvbiAqcmVnKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKHJlZyAhPSBO
VUxMICZhbXA7JmFtcDsgcmVnLSZndDttbWFwX2FkZHIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBtdW5tYXAocmVnLSZndDttbWFwX2FkZHIsIHJlZy0mZ3Q7bW1hcF9zaXplKTs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZShyZWctJmd0O2ZkKTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBtZW1zZXQocmVnLCAwLCBzaXplb2Yoc3RydWN0IHJ0ZV92aG9zdF9t
ZW1fcmVnaW9uKSk7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0
aWMgdm9pZDxicj4NCitmcmVlX2FsbF9tZW1fcmVnaW9ucyhzdHJ1Y3QgdmlydGlvX25ldCAqZGV2
KTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHVpbnQzMl90IGk7PGJyPg0KwqAgwqAgwqAgwqAg
c3RydWN0IHJ0ZV92aG9zdF9tZW1fcmVnaW9uICpyZWc7PGJyPg0KQEAgLTIzNiwxMiArMjkyLDEw
IEBAIGZyZWVfbWVtX3JlZ2lvbihzdHJ1Y3QgdmlydGlvX25ldCAqZGV2KTxicj4NCsKgIMKgIMKg
IMKgIGlmIChkZXYtJmd0O2FzeW5jX2NvcHkgJmFtcDsmYW1wOyBydGVfdmZpb19pc19lbmFibGVk
KCZxdW90O3ZmaW8mcXVvdDspKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFzeW5jX2Rt
YV9tYXAoZGV2LCBmYWxzZSk7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAm
bHQ7IGRldi0mZ3Q7bWVtLSZndDtucmVnaW9uczsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgZm9y
IChpID0gMDsgaSAmbHQ7IFZIT1NUX01FTU9SWV9NQVhfTlJFR0lPTlM7IGkrKykgezxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlZyA9ICZhbXA7ZGV2LSZndDttZW0tJmd0O3JlZ2lvbnNb
aV07PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlZy0mZ3Q7aG9zdF91c2VyX2Fk
ZHIpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtdW5tYXAocmVn
LSZndDttbWFwX2FkZHIsIHJlZy0mZ3Q7bW1hcF9zaXplKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZShyZWctJmd0O2ZkKTs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlZy0mZ3Q7bW1h
cF9hZGRyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZyZWVfbWVt
X3JlZ2lvbihyZWcpOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQrCoH08YnI+DQo8YnI+DQpAQCAt
MjU1LDcgKzMwOSw3IEBAIHZob3N0X2JhY2tlbmRfY2xlYW51cChzdHJ1Y3QgdmlydGlvX25ldCAq
ZGV2KTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZkcGFfZGV2LSZndDtvcHMtJmd0O2Rl
dl9jbGVhbnVwKGRldi0mZ3Q7dmlkKTs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAoZGV2LSZn
dDttZW0pIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlX21lbV9yZWdpb24oZGV2
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcmVlX2FsbF9tZW1fcmVnaW9ucyhkZXYp
Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJ0ZV9mcmVlKGRldi0mZ3Q7bWVtKTs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXYtJmd0O21lbSA9IE5VTEw7PGJyPg0KwqAgwqAg
wqAgwqAgfTxicj4NCkBAIC03MDQsNyArNzU4LDcgQEAgbnVtYV9yZWFsbG9jKHN0cnVjdCB2aXJ0
aW9fbmV0ICoqcGRldiwgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqKnB2cSk8YnI+DQrCoCDCoCDC
oCDCoCB2aG9zdF9kZXZpY2VzW2Rldi0mZ3Q7dmlkXSA9IGRldjs8YnI+DQo8YnI+DQrCoCDCoCDC
oCDCoCBtZW1fc2l6ZSA9IHNpemVvZihzdHJ1Y3QgcnRlX3Zob3N0X21lbW9yeSkgKzxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemVvZihzdHJ1Y3QgcnRlX3Zob3N0X21lbV9yZWdpb24p
ICogZGV2LSZndDttZW0tJmd0O25yZWdpb25zOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNpemVvZihzdHJ1Y3QgcnRlX3Zob3N0X21lbV9yZWdpb24pICogVkhPU1RfTUVNT1JZX01BWF9O
UkVHSU9OUzs8YnI+DQrCoCDCoCDCoCDCoCBtZW0gPSBydGVfcmVhbGxvY19zb2NrZXQoZGV2LSZn
dDttZW0sIG1lbV9zaXplLCAwLCBub2RlKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAoIW1lbSkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFZIT1NUX0NPTkZJR19MT0coZGV2LSZndDtpZm5h
bWUsIEVSUiw8YnI+DQpAQCAtODA4LDggKzg2MiwxMCBAQCBodWFfdG9fYWxpZ25tZW50KHN0cnVj
dCBydGVfdmhvc3RfbWVtb3J5ICptZW0sIHZvaWQgKnB0cik8YnI+DQrCoCDCoCDCoCDCoCB1aW50
MzJfdCBpOzxicj4NCsKgIMKgIMKgIMKgIHVpbnRwdHJfdCBodWEgPSAodWludHB0cl90KXB0cjs8
YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgbWVtLSZndDtucmVnaW9u
czsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IFZIT1NUX01FTU9S
WV9NQVhfTlJFR0lPTlM7IGkrKykgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHIgPSAm
YW1wO21lbS0mZ3Q7cmVnaW9uc1tpXTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAo
ci0mZ3Q7aG9zdF91c2VyX2FkZHIgPT0gMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoaHVh
ICZndDs9IHItJmd0O2hvc3RfdXNlcl9hZGRyICZhbXA7JmFtcDs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBodWEgJmx0OyByLSZndDtob3N0X3VzZXJfYWRkciArIHIt
Jmd0O3NpemUpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gZ2V0X2Jsa19zaXplKHItJmd0O2ZkKTs8YnI+DQpAQCAtMTEzNiw2ICsxMTkyLDI0IEBAIGFk
ZF9ndWVzdF9wYWdlcyhzdHJ1Y3QgdmlydGlvX25ldCAqZGV2LCBzdHJ1Y3QgcnRlX3Zob3N0X21l
bV9yZWdpb24gKnJlZyw8YnI+DQrCoCDCoCDCoCDCoCByZXR1cm4gMDs8YnI+DQrCoH08YnI+DQo8
YnI+DQorc3RhdGljIHZvaWQ8YnI+DQorcmVtb3ZlX2d1ZXN0X3BhZ2VzKHN0cnVjdCB2aXJ0aW9f
bmV0ICpkZXYsIHN0cnVjdCBydGVfdmhvc3RfbWVtX3JlZ2lvbiAqcmVnKTxicj4NCit7PGJyPg0K
K8KgIMKgIMKgIMKgdWludDY0X3QgcmVnX3N0YXJ0ID0gcmVnLSZndDtob3N0X3VzZXJfYWRkcjs8
YnI+DQorwqAgwqAgwqAgwqB1aW50NjRfdCByZWdfZW5kID0gcmVnX3N0YXJ0ICsgcmVnLSZndDtz
aXplOzxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGksIGogPSAwOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgZGV2LSZndDtucl9ndWVzdF9wYWdlczsgaSsrKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGRldi0mZ3Q7Z3Vlc3RfcGFnZXNbaV0u
aG9zdF91c2VyX2FkZHIgJmd0Oz0gcmVnX3N0YXJ0ICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkZXYtJmd0O2d1ZXN0X3BhZ2VzW2ldLmhvc3RfdXNlcl9hZGRy
ICZsdDsgcmVnX2VuZCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
b250aW51ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaiAhPSBpKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRldi0mZ3Q7Z3Vlc3RfcGFnZXNbal0g
PSBkZXYtJmd0O2d1ZXN0X3BhZ2VzW2ldOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGor
Kzs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgZGV2LSZndDtucl9ndWVzdF9w
YWdlcyA9IGo7PGJyPg0KK308YnI+DQorPGJyPg0KwqAjaWZkZWYgUlRFX0xJQlJURV9WSE9TVF9E
RUJVRzxicj4NCsKgLyogVE9ETzogZW5hYmxlIGl0IG9ubHkgaW4gZGVidWcgbW9kZT8gKi88YnI+
DQrCoHN0YXRpYyB2b2lkPGJyPg0KQEAgLTEyNDYsMTAgKzEzMjAsMTQgQEAgdmhvc3RfdXNlcl9w
b3N0Y29weV9yZWdpc3RlcihzdHJ1Y3QgdmlydGlvX25ldCAqZGV2LCBpbnQgbWFpbl9mZCw8YnI+
DQrCoCDCoCDCoCDCoCDCoCogRFBESyYjMzk7cyB2aXJ0dWFsIGFkZHJlc3Mgd2l0aCBRZW11LCBz
byB0aGF0IFFlbXUgY2FuPGJyPg0KwqAgwqAgwqAgwqAgwqAqIHJldHJpZXZlIHRoZSByZWdpb24g
b2Zmc2V0IHdoZW4gaGFuZGxpbmcgdXNlcmZhdWx0cy48YnI+DQrCoCDCoCDCoCDCoCDCoCovPGJy
Pg0KK8KgIMKgIMKgIMKgaW50IHJlZ19tc2dfaW5kZXggPSAwOzxicj4NCsKgIMKgIMKgIMKgIG1l
bW9yeSA9ICZhbXA7Y3R4LSZndDttc2cucGF5bG9hZC5tZW1vcnk7PGJyPg0KwqAgwqAgwqAgwqAg
Zm9yIChpID0gMDsgaSAmbHQ7IG1lbW9yeS0mZ3Q7bnJlZ2lvbnM7IGkrKykgezxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHJlZyA9ICZhbXA7ZGV2LSZndDttZW0tJmd0O3JlZ2lvbnNbaV07
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtb3J5LSZndDtyZWdpb25zW2ldLnVzZXJz
cGFjZV9hZGRyID0gcmVnLSZndDtob3N0X3VzZXJfYWRkcjs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAocmVnLSZndDtob3N0X3VzZXJfYWRkciA9PSAwKTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoG1lbW9yeS0mZ3Q7cmVnaW9uc1tyZWdfbXNnX2luZGV4XS51c2Vyc3BhY2VfYWRkciA9
IHJlZy0mZ3Q7aG9zdF91c2VyX2FkZHI7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVn
X21zZ19pbmRleCsrOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCAv
KiBTZW5kIHRoZSBhZGRyZXNzZXMgYmFjayB0byBxZW11ICovPGJyPg0KQEAgLTEyNzgsNiArMTM1
Niw4IEBAIHZob3N0X3VzZXJfcG9zdGNvcHlfcmVnaXN0ZXIoc3RydWN0IHZpcnRpb19uZXQgKmRl
diwgaW50IG1haW5fZmQsPGJyPg0KwqAgwqAgwqAgwqAgLyogTm93IHVzZXJmYXVsdCByZWdpc3Rl
ciBhbmQgd2UgY2FuIHVzZSB0aGUgbWVtb3J5ICovPGJyPg0KwqAgwqAgwqAgwqAgZm9yIChpID0g
MDsgaSAmbHQ7IG1lbW9yeS0mZ3Q7bnJlZ2lvbnM7IGkrKykgezxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHJlZyA9ICZhbXA7ZGV2LSZndDttZW0tJmd0O3JlZ2lvbnNbaV07PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJlZy0mZ3Q7aG9zdF91c2VyX2FkZHIgPT0gMCk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAodmhvc3RfdXNlcl9wb3N0Y29weV9yZWdpb25fcmVnaXN0
ZXIoZGV2LCByZWcpICZsdDsgMCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCByZXR1cm4gLTE7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCkBAIC0xMzgyLDYgKzE0NjIs
NTIgQEAgdmhvc3RfdXNlcl9tbWFwX3JlZ2lvbihzdHJ1Y3QgdmlydGlvX25ldCAqZGV2LDxicj4N
CsKgIMKgIMKgIMKgIHJldHVybiAwOzxicj4NCsKgfTxicj4NCjxicj4NCitzdGF0aWMgaW50PGJy
Pg0KK3Zob3N0X3VzZXJfaW5pdGlhbGl6ZV9tZW1vcnkoc3RydWN0IHZpcnRpb19uZXQgKipwZGV2
KTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHZpcnRpb19uZXQgKmRldiA9ICpwZGV2
Ozxicj4NCivCoCDCoCDCoCDCoGludCBudW1hX25vZGUgPSBTT0NLRVRfSURfQU5ZOzxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqBpZiAoZGV2LSZndDttZW0gIT0gTlVMTCkgezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFZIT1NUX0NPTkZJR19MT0coZGV2LSZndDtpZm5hbWUsIEVSUiw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmcXVvdDttZW1vcnkgYWxyZWFk
eSBpbml0aWFsaXplZCwgZnJlZSBpdCBmaXJzdCZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgLyo8YnI+DQorwqAgwqAgwqAgwqAgKiBJZiBWUSAwIGhhcyBhbHJlYWR5IGJlZW4gYWxs
b2NhdGVkLCB0cnkgdG8gYWxsb2NhdGUgb24gdGhlIHNhbWU8YnI+DQorwqAgwqAgwqAgwqAgKiBO
VU1BIG5vZGUuIEl0IGNhbiBiZSByZWFsbG9jYXRlZCBsYXRlciBpbiBudW1hX3JlYWxsb2MoKS48
YnI+DQorwqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqBpZiAoZGV2LSZndDtucl92cmlu
ZyAmZ3Q7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbnVtYV9ub2RlID0gZGV2LSZn
dDt2aXJ0cXVldWVbMF0tJmd0O251bWFfbm9kZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZGV2
LSZndDtucl9ndWVzdF9wYWdlcyA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKGRldi0mZ3Q7Z3Vl
c3RfcGFnZXMgPT0gTlVMTCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRldi0mZ3Q7
bWF4X2d1ZXN0X3BhZ2VzID0gODs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZXYtJmd0
O2d1ZXN0X3BhZ2VzID0gcnRlX3ptYWxsb2Nfc29ja2V0KE5VTEwsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2LSZndDtt
YXhfZ3Vlc3RfcGFnZXMgKjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemVvZihzdHJ1Y3QgZ3Vlc3RfcGFnZSksPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgUlRFX0NBQ0hFX0xJTkVfU0laRSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBudW1hX25vZGUpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChkZXYtJmd0O2d1ZXN0X3BhZ2VzID09IE5VTEwpIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBWSE9TVF9DT05GSUdfTE9HKGRldi0m
Z3Q7aWZuYW1lLCBFUlIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgJnF1b3Q7ZmFpbGVkIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3IgZGV2LSZndDtn
dWVzdF9wYWdlcyZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAg
wqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGRldi0mZ3Q7bWVtID0gcnRlX3ptYWxsb2Nf
c29ja2V0KCZxdW90O3Zob3N0LW1lbS10YWJsZSZxdW90Oywgc2l6ZW9mKHN0cnVjdCBydGVfdmhv
c3RfbWVtb3J5KSArPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2l6ZW9mKHN0cnVjdCBy
dGVfdmhvc3RfbWVtX3JlZ2lvbikgKiBWSE9TVF9NRU1PUllfTUFYX05SRUdJT05TLCAwLCBudW1h
X25vZGUpOzxicj4NCivCoCDCoCDCoCDCoGlmIChkZXYtJmd0O21lbSA9PSBOVUxMKSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgVkhPU1RfQ09ORklHX0xPRyhkZXYtJmd0O2lmbmFtZSwg
RVJSLCAmcXVvdDtmYWlsZWQgdG8gYWxsb2NhdGUgbWVtb3J5IGZvciBkZXYtJmd0O21lbSZxdW90
Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcnRlX2ZyZWUoZGV2LSZndDtndWVzdF9w
YWdlcyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2LSZndDtndWVzdF9wYWdlcyA9
IE5VTEw7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCivCoCDC
oCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KK308YnI+DQor
PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdGhpbmsgaXQgc2hvdWxkIGJl
IGluIGEgZGVkaWNhdGVkIHBhdGNoLCBhbmQgaW4gdGhlIHNhbWUgcGF0Y2ggd291bGTCoHZob3N0
X3VzZXJfc2V0X21lbV90YWJsZSgpIG1ha2UgdXNlIG9mIGl0LjwvZGl2PjxkaXY+VGhlIGlkZWEg
aXMgdG8gbWFrZSBpdCBzdHJhaXRmb3J3YXJkIHlvdSBhcmUgZG9pbmcgYSByZWZhY3RvcmluZywg
YW5kIGVhc2lseSBjaGVjayB0aGUgY29kZSB5b3UgYXJlIGV4dHJhY3Rpbmcgb3V0IGZyb208L2Rp
dj48ZGl2PnZob3N0X3VzZXJfc2V0X21lbV90YWJsZSgpIGludG8gYSBuZXcgZnVuY3Rpb24gaGFz
IG5vdCBiZWVuIGNoYW5nZWQgaW4tYmV0d2Vlbi48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVv
dGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0K
wqBzdGF0aWMgaW50PGJyPg0KwqB2aG9zdF91c2VyX3NldF9tZW1fdGFibGUoc3RydWN0IHZpcnRp
b19uZXQgKipwZGV2LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0
cnVjdCB2aHVfbXNnX2NvbnRleHQgKmN0eCw8YnI+DQotLSA8YnI+DQoyLjQzLjA8YnI+DQo8YnI+
DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+DQo=
--000000000000fce8d306510ef125--

