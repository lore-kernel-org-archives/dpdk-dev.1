Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C3C88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8E8142B71;
	Tue, 15 Sep 2026 17:25:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0453C40A6B
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:25:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789485909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrBOhhe/thhFUGC3fMfVy/7pmxZvPlYoWjVXUJ7fhwU=;
 b=KxacTFBsPYL9s6dqQnuB0I+h984AYhqOSUGM+QMw3cxpAtj6qLHj+Sv7CRf6wde6ZR/iz4
 74oFvHhZCzwSFKGPzpfH+CxysAVurYoUJM1eY8zcNk+3lodtB0ph7Ca/F5MlFdr7Rcc7Cg
 Q55Xa52HMVGrepSZoDmG8l5SVXprJx0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-YFyLwlN2PqOftiIbnAnKZQ-1; Tue, 15 Sep 2026 11:25:08 -0400
X-MC-Unique: YFyLwlN2PqOftiIbnAnKZQ-1
X-Mimecast-MFC-AGG-ID: YFyLwlN2PqOftiIbnAnKZQ_1789485907
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so21054231fa.0
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789485907; x=1790090707;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GrBOhhe/thhFUGC3fMfVy/7pmxZvPlYoWjVXUJ7fhwU=;
 b=D0pYJQXi1W+nDM2S37QTrpgjYpX6VfcD2b9m+D3ws92qToDJW8XZD1o/LU2oLLUJ6g
 CwBsq+PgKwzyvVN9GgY47lGsyssMpDMVfK2dROLMUf6s5ZIlP90+Saobq/WM5vvuXGHG
 LNgcbueZdJ6bRDnyhKyPQql6VhA6iKi4qeHprCbQPwV4WEN/xERicEJuczfjXYCHkGiA
 21Aq3mCjwsyN0/lYPQojq9Xwvs/23ATIj2CybwGaa7bbx6W7BAkGWI4VE1iyqSH8TGFT
 pUtLD+kQw940BJlIDqIL/HudL7RjhK+U/DW88G8zdTWhw5UazOOr/pnUMP0zefyFYkRt
 aiTg==
X-Gm-Message-State: AFuF++kh7XPuvCoAMs2b6kgVkpbIr+8yHRWmNVtOiSPqYQ33zYC3k2lN
 vgyW4geQe6Aa26kdTKb08COqmDQJCj79Ta8GZKXeOy23O2N2cIevErPAsl9Xc/mfb9Ced2Vt9KS
 1d+Lyna7UGaopDQFCEE/vYiuwC4tNrtA1xEteOe2cczyHeV7Y5maUfkZVz1yM74yRmyeCmtDy50
 FrhvAH48mHgYmFDjc5biE=
X-Gm-Gg: AYBFou1s35oEWc8Dn96W3m3tvokq2S3SA/v8LajkjHv641SWL9NaFw26X+mwmDQ1d9+
 8Zo0GlDJx/SYGN9fomhvBoiBEGh+70BFHWiz88ve/ZBcnhEARZdqSGheWWeoZdyd14KYJb9zbud
 zXYzGVRZSNCQ+tyQHqpUW6nTm0+4WepHWF5FZfQyucrXIYj8s/dsxth8PpIYYkJHknEwyZmgXoA
 2eouSOeEyKkfPB+J4LY2hLOvshDDzYdYjjOTgM0Hz0OTw/i
X-Received: by 2002:a05:651c:2117:b0:3a5:903c:1f46 with SMTP id
 38308e7fff4ca-3a5c8984143mr25957521fa.11.1789485906610; 
 Tue, 15 Sep 2026 08:25:06 -0700 (PDT)
X-Received: by 2002:a05:651c:2117:b0:3a5:903c:1f46 with SMTP id
 38308e7fff4ca-3a5c8984143mr25957341fa.11.1789485906032; Tue, 15 Sep 2026
 08:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789044746.git.anatoly.burakov@intel.com>
 <b4a07e530751c91f6c3d8a7619c4f926de6d1583.1789044747.git.anatoly.burakov@intel.com>
In-Reply-To: <b4a07e530751c91f6c3d8a7619c4f926de6d1583.1789044747.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 15 Sep 2026 17:24:53 +0200
X-Gm-Features: AcwNN1XT80_qmJM-iLeYGMCZFRHQmRHF82063oscnj0kvwdMfHhImzegmD0wO74
Message-ID: <CAJFAV8znFXjkAzntYP9WMfDzh_NkuxuTTPpoZyenL7qAr4uNOA@mail.gmail.com>
Subject: Re: [PATCH v17 10/26] vfio: split get device info from setup
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>, Chenbo Xia <chenbox@nvidia.com>, 
 Tomasz Duszynski <tduszynski@marvell.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ujp3EKKh9KsI2Bty8oDtQ2xT_kRVqsuc5Aln0K_a-NE_1789485907
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
> Currently, setup gets device info as part of setup, while the separate get
> device info API also calls setup if the fd is zero. Untangle these two APIs
> and make each do one thing, and adjust all existing callers.
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/bus/cdx/cdx_vfio.c        | 12 ++++++++--
>  drivers/bus/pci/linux/pci_vfio.c  | 18 ++++++++++----
>  drivers/bus/platform/platform.c   |  9 ++++++-
>  drivers/crypto/bcmfs/bcmfs_vfio.c |  8 ++++++-
>  lib/eal/freebsd/eal.c             | 12 ++++++++--
>  lib/eal/include/dev_vfio.h        | 23 +++++++-----------
>  lib/eal/linux/eal_vfio.c          | 40 +++++++++----------------------
>  7 files changed, 68 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
> index 02a34d6f18..531e4ccc8d 100644
> --- a/drivers/bus/cdx/cdx_vfio.c
> +++ b/drivers/bus/cdx/cdx_vfio.c
> @@ -401,10 +401,14 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
>                 return -1;
>
>         ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
> -                                   &vfio_dev_fd, &device_info);
> +                                   &vfio_dev_fd);
>         if (ret)
>                 return ret;
>
> +       ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
> +       if (ret)
> +               goto err_vfio_dev_fd;
> +
>         /* allocate vfio_res and get region info */
>         vfio_res = rte_zmalloc("VFIO_RES", sizeof(*vfio_res), 0);
>         if (vfio_res == NULL) {
> @@ -510,10 +514,14 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
>         }
>
>         ret = dev_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
> -                                       &vfio_dev_fd, &device_info);
> +                                       &vfio_dev_fd);
>         if (ret)
>                 return ret;
>
> +       ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
> +       if (ret)
> +               goto err_vfio_dev_fd;
> +
>         /* map MMIO regions */
>         maps = vfio_res->maps;
>
> diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
> index 3e87e759f5..0363a4a6c5 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -753,10 +753,14 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
>                         loc->domain, loc->bus, loc->devid, loc->function);
>
>         ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
> -                                       &vfio_dev_fd, &device_info);
> +                                       &vfio_dev_fd);
>         if (ret)
>                 return ret;
>
> +       ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
> +       if (ret)
> +               goto err_vfio_dev_fd;
> +
>         if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd))
>                 goto err_vfio_dev_fd;
>
> @@ -962,10 +966,14 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
>         }
>
>         ret = dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
> -                                       &vfio_dev_fd, &device_info);
> +                                       &vfio_dev_fd);
>         if (ret)
>                 return ret;
>
> +       ret = dev_vfio_get_device_info(vfio_dev_fd, &device_info);
> +       if (ret)
> +               goto err_vfio_dev_fd;
> +
>         ret = pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info);
>         if (ret)
>                 goto err_vfio_dev_fd;
> @@ -1195,12 +1203,14 @@ pci_vfio_ioport_map(struct rte_pci_device *dev, int bar,
>                 if (vfio_dev_fd < 0) {
>                         return -1;
>                 } else if (vfio_dev_fd == 0) {

Not the fault of this patch, but comparing a FD against 0 is a bad sign...


> -                       if (dev_vfio_get_device_info(rte_pci_get_sysfs_path(), pci_addr,
> -                               &vfio_dev_fd, &device_info) != 0)
> +                       if (dev_vfio_setup_device(rte_pci_get_sysfs_path(), pci_addr,
> +                               &vfio_dev_fd) != 0)
>                                 return -1;
>                         /* save vfio_dev_fd so it can be used during release */
>                         if (rte_intr_dev_fd_set(dev->intr_handle, vfio_dev_fd) != 0)
>                                 return -1;
> +                       if (dev_vfio_get_device_info(vfio_dev_fd, &device_info) != 0)
> +                               return -1;
>
>                         if (pci_vfio_fill_regions(dev, vfio_dev_fd, &device_info) != 0)
>                                 return -1;

And we have various leaks in case VFIO fails...

I'll make a note to fix this later as this is already present, unless
you can have a look.


-- 
David Marchand

