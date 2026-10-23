Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BB7606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WaadsBAe
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AC2940299;
	Fri, 23 Oct 2026 13:43:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 25FF440268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 13:43:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792755788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RVNBuf4HEeTaCWo8pGijcKw2ZgPM4pudEWB7q/D06UY=;
 b=WaadsBAeZbXdGP9JL9OepMYBW1ZX6+WUqNnEKMuZglctcPkv/O8alZPPyc6fMOy96WAscA
 ksi7pyeV8IAFtX8E+s/EuzLTAb7sjh38fHE6WIlLotbv2LLZ8hNz5wMnsHNnrd2v+b6mhF
 i/MMLeejvQ96yDxsFnVgpfdDfzLtF+0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-AuT_bhoAMYKMOqC9xM7sfQ-1; Fri, 23 Oct 2026 07:43:07 -0400
X-MC-Unique: AuT_bhoAMYKMOqC9xM7sfQ-1
X-Mimecast-MFC-AGG-ID: AuT_bhoAMYKMOqC9xM7sfQ_1792755786
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab426be412so3352961fa.1
 for <dev@dpdk.org>; Fri, 23 Oct 2026 04:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755785; x=1793360585;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RVNBuf4HEeTaCWo8pGijcKw2ZgPM4pudEWB7q/D06UY=;
 b=eI0YS/lP1orCqIJXJ0iUfEwhzJnIj07jxoSA+Lrfq0pUVolEmFgXJcN/SwpLvMF8WW
 ten3SohsR8pV2hdzqT8tnhzJB7CrJFpyXU5fLGZ0gxylObub1gEZyfum71LB+ToDt5rh
 OV1Ui5IIq6l339iPNoD3ujaGOK1aR0GdqDh8X6VGvQA1rwx8UthjSWSRMeUWb2CfJmQD
 dCBKWy9so1DQTDB+CU8TdVU4mU2ckeUxDOogkyBE8Zg12CGwMUAUowbK3amtgcOGh7pA
 DyQchlhk+plIOL5VbgsePhnuVYev0CoJlt9/lorUYezoYcm3Cy6TOfal8Jqjfwo0qjho
 kjeQ==
X-Gm-Message-State: AFq9FYKdjXODwtF7wqN5YcI9cYeuDH+2a4LnSt3cj84NWZdUPjZ1hSHS
 TVKd2ayE6KbEBEKXw5kFwgwGDgMPxyYreD1HgPWByqIRwu6x/yOKiMDPnp0bBknhXkbhZt1smep
 OzPK08gr533MAH1MMNPJHf7ZAKhRIbsGgRcCXgQwYJ/wZ/N/RdaTWq5XXdiJCA5WnhHqNcZmWPG
 Pb3eSRcLizMNtK2SNUHaE=
X-Gm-Gg: AYBFou3cjLvQ1/LBB94Ig8lYBIgZYlcpMg0j3WJIXWdoDys/DgG3m4+A/ctKzyqo0W+
 RjmrNhHtrkQWTsAkiZImECyJrM9CbHx2WKwvkr8X9b7opPF6YAIX7W/Y9G8hTYKG7trJxa8CXx2
 OlFwHTJsBehx+9PRfWSnRAormMU85CePNk31hiJd5QHh8ZWbERCo1q8If9ewAUUJ3EtCEYI7MH+
 4TEV94m4d3prvihUaboNyNN2BqdvMYPAIlb283+Z5cW5cni
X-Received: by 2002:a05:651c:150a:b0:3a6:6831:6e28 with SMTP id
 38308e7fff4ca-3ac66315d73mr4703181fa.6.1792755785499; 
 Fri, 23 Oct 2026 04:43:05 -0700 (PDT)
X-Received: by 2002:a05:651c:150a:b0:3a6:6831:6e28 with SMTP id
 38308e7fff4ca-3ac66315d73mr4703131fa.6.1792755784996; Fri, 23 Oct 2026
 04:43:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <af76b0050fa71836d9663515f5efd66c8c910061.1792748199.git.anatoly.burakov@intel.com>
In-Reply-To: <af76b0050fa71836d9663515f5efd66c8c910061.1792748199.git.anatoly.burakov@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 23 Oct 2026 13:42:53 +0200
X-Gm-Features: AclHuK8JjRyn3MQnurc2NmTcIAWAZbVxPustzn9wLb1IT8QBMjV_rwCQJ73i8DQ
Message-ID: <CAJFAV8y8OUGxGKshkO_3GKFc2GbE9a2XEZo6Cdh1QUQFS9fX2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] eal/linux: fix eventfd leaks when enabling
 interrupts
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Harman Kalra <hkalra@marvell.com>, 
 Cunming Liang <cunming.liang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lP4FnzzdsJs1HRz20YJvsaVyLgnjeTDFE9D6TZNl6rI_1792755786
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

On Fri, 23 Oct 2026 at 11:37, Anatoly Burakov <anatoly.burakov@intel.com> wrote:
>
> When enabling MSI-X eventfds, a failure after creating some descriptors
> leaves them open. The eventfd count is recorded only after all allocations
> succeed, so disabling eventfds cannot clean up a partial allocation.
>
> Calling enable again without disabling first also leaks descriptors by
> overwriting the existing eventfd entries.
>
> Reject repeated MSI-X enable calls with EBUSY before modifying the handle.
> On failure, close all eventfds created by the call, clear their entries
> and reset the eventfd count while preserving the original error.
>
> Fixes: b9e0662a931d ("eal/linux: add interrupt API for drivers")
> Cc: stable@dpdk.org
>
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Good catch.
How did you find this issue?

I did not put warnings on the efd side, but maybe worth extending
d770ee9caed0 ("interrupts: warn on leaked FDs").

One comment below.


> ---
>  lib/eal/linux/eal_interrupts.c | 39 +++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/lib/eal/linux/eal_interrupts.c b/lib/eal/linux/eal_interrupts.c
> index 4cfaeba7fe0..ff05d649607 100644
> --- a/lib/eal/linux/eal_interrupts.c
> +++ b/lib/eal/linux/eal_interrupts.c
> @@ -1570,30 +1570,43 @@ int
>  rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
>  {
>         uint32_t i;
> -       int fd;
> +       int fd, ret;
>         uint32_t n = RTE_MIN(nb_efd, (uint32_t)RTE_MAX_RXTX_INTR_VEC_ID);
>
>         assert(nb_efd != 0);
>
>         if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VFIO_MSIX) {
> +               if (rte_intr_nb_efd_get(intr_handle) != 0) {
> +                       EAL_LOG(ERR, "Interrupt eventfds are already enabled");
> +                       return -EBUSY;
> +               }
> +
>                 for (i = 0; i < n; i++) {
>                         fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
>                         if (fd < 0) {
> +                               ret = -errno;
>                                 EAL_LOG(ERR,
>                                         "can't setup eventfd, error %i (%s)",
>                                         errno, strerror(errno));
> -                               return -errno;
> +                               goto error;
>                         }
>
> -                       if (rte_intr_efds_index_set(intr_handle, i, fd))
> -                               return -rte_errno;
> +                       if (rte_intr_efds_index_set(intr_handle, i, fd)) {
> +                               ret = -rte_errno;
> +                               close(fd);
> +                               goto error;
> +                       }
>                 }
>
> -               if (rte_intr_nb_efd_set(intr_handle, n))
> -                       return -rte_errno;
> +               if (rte_intr_nb_efd_set(intr_handle, n)) {
> +                       ret = -rte_errno;
> +                       goto error;
> +               }
>
> -               if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n))
> -                       return -rte_errno;
> +               if (rte_intr_max_intr_set(intr_handle, NB_OTHER_INTR + n)) {
> +                       ret = -rte_errno;
> +                       goto error;
> +               }
>         } else if (rte_intr_type_get(intr_handle) == RTE_INTR_HANDLE_VDEV) {
>                 /* only check, initialization would be done in vdev driver.*/
>                 if ((uint64_t)rte_intr_efd_counter_size_get(intr_handle) >
> @@ -1611,6 +1624,16 @@ rte_intr_efd_enable(struct rte_intr_handle *intr_handle, uint32_t nb_efd)
>         }
>
>         return 0;
> +
> +error:
> +       while (i > 0) {

The i variable should have been declared only in the scope of VFIO
type, in the first place.
Using i here could blow up later when this error label is used for
other interrupt types.

As mentionned in the commitlog, could we accumulate the number of
valid efds in the vfio setup loop?
The cleanup code here could then loop on rte_intr_nb_efd_get.


> +               i--;
> +               close(rte_intr_efds_index_get(intr_handle, i));
> +               rte_intr_efds_index_set(intr_handle, i, -1);
> +       }
> +       rte_intr_nb_efd_set(intr_handle, 0);
> +
> +       return ret;
>  }
>
>  RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_efd_disable)
> --
> 2.52.0
>


-- 
David Marchand

