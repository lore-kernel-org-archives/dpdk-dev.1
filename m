Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009AC531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 12:17:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CA254029B;
	Fri, 24 Jul 2026 14:17:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DB51D40276
 for <dev@dpdk.org>; Fri, 24 Jul 2026 14:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784895419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cqNZ3HtOBLRVdGVz7Ib1YnpmtUlrmQn8y5dBNjIt2l4=;
 b=Wjvltp/8zyj3a7QnO3E9vJMsL22oySL4LPOoTUeJzj4zzLMJZ9IUY9ikA7EM79h0b+RJfc
 oc7lwu+xLoQ3WgnTN6bC02GaJ8M3oFgSAKH3jw0+KasX7lYZHZV8yJa1nerrdikofFPEen
 ONof3korLy263X91eDnZq2Hqxk2yRCk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-emjihq2zOmKBU1PX6pPFGQ-1; Fri, 24 Jul 2026 08:16:58 -0400
X-MC-Unique: emjihq2zOmKBU1PX6pPFGQ-1
X-Mimecast-MFC-AGG-ID: emjihq2zOmKBU1PX6pPFGQ_1784895417
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5b2a24ae6deso273087e87.0
 for <dev@dpdk.org>; Fri, 24 Jul 2026 05:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784895416; x=1785500216;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cqNZ3HtOBLRVdGVz7Ib1YnpmtUlrmQn8y5dBNjIt2l4=;
 b=L72JinVAq89GOWd/A3bXHKWsBlU83KOqp0v0Bev1gTJjKM80nVgjRrBheiUbxaCrw+
 bQ8O2oVgs65m9ea64Uu9vadLFYcBCRTF4XphGdWt0I0RS75TQsjiSSv//DeN3emYJx3k
 IsRZctSv1THS8vToFgDRqbdvt4vQg2CsDr4dvSEq5y7KTs9RDLT1nVZZWfWfkwBNORYS
 vNsZ3RT6ntg3Oe4eDf7xQVdrzrvEPhIi+LbO98Efln4KEKD2lfUPMxjnIodufNWae49s
 yZ1jVr/BRgczu264x5fI+85pD5ViY1ys4aT/j69jQyO/v18dk+OwD+xeMUpjoaNHfQlM
 d9NA==
X-Gm-Message-State: AOJu0Ywo6bK/hYZufbt2ydEeOpqtl9qdSABeMck4pAoGTY6VJcCqRkjj
 Gvd1JGkhrIWRJHDkpOtOkcI3vOEUfSiQB9paES1HLivZwgy9f0b9nwCT9mtXhCmhit2zHk/gT3r
 GLLeposvVYeLeb5bmneDS+1KacX5dbuoAG3Sw0CQc2uEerJtD7WxGM3ZYZhBXwvRwzYDzBdF8jS
 /rBK1hpxDezpUBMjo6F5gDjHqeN/mkcg==
X-Gm-Gg: AR+sD13/juw5QMs6dxzmV+bEp4f0+TrbXBHHlNiY7r5Y2bDt1XqTGpQAmzEnLtEhaeN
 rr+OEnGjxz77/98OyWeOMfTIC5Jw3SY93HNGfsz0crT5e4c+80fn4lfoicEXVGLccPyImYWMpFA
 Jpd2sjSncDztLMluPHVND0yzEpvP6ggLvyU8A7tA8M+M7pIljkbKhcBo7U7M2m7odJ1RxyVIAws
 9wEt6jOR7rCXXA1Q0K6PbN8nn3qid26TRwXrE5WakByWLqb
X-Received: by 2002:a05:6512:b88:b0:5b2:907c:e8b1 with SMTP id
 2adb3069b0e04-5b2b2f85074mr1559009e87.62.1784895415720; 
 Fri, 24 Jul 2026 05:16:55 -0700 (PDT)
X-Received: by 2002:a05:6512:b88:b0:5b2:907c:e8b1 with SMTP id
 2adb3069b0e04-5b2b2f85074mr1558991e87.62.1784895415176; Fri, 24 Jul 2026
 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260723131908.3313223-1-david.marchand@redhat.com>
 <20260723131908.3313223-4-david.marchand@redhat.com>
In-Reply-To: <20260723131908.3313223-4-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 24 Jul 2026 14:16:43 +0200
X-Gm-Features: AUfX_mxRkZak9FZTDGXwzM34ginZsn6oOFsRlcdCoNFnotYbnZrkbVTLK4nBg_c
Message-ID: <CAJFAV8w9iUsP3z_3X0kRKe=zRpS26YBP7WegZ4gQBKJGVRe9FA@mail.gmail.com>
Subject: Re: [RFC 3/4] interrupts: mark file descriptors invalid on allocation
To: dev@dpdk.org
Cc: hkalra@marvell.com, Nipun Gupta <nipun.gupta@amd.com>, 
 Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Chenbo Xia <chenbox@nvidia.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, 
 Gaetan Rivet <grive@u256.net>, Jakub Grajciar <jgrajcia@cisco.com>,
 Matan Azrad <matan@nvidia.com>, 
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yCKlHOr99WeAZ9Ucu5mUCxKNiVOduww-egtNEFLnP1U_1784895417
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

On Thu, 23 Jul 2026 at 15:19, David Marchand <david.marchand@redhat.com> wrote:
>
> Initialize fd, dev_fd, and all efds array elements as invalid in
> rte_intr_instance_alloc().
> This follows Unix convention, avoiding confusion with fd 0
> which could result from zero-initialization.
>
> Update the API documentation to reflect this behavior and add a
> unit test check to verify the fd is invalid after allocation.
>
> Remove now-redundant initialization calls that were setting the fd
> invalid right after allocation.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---
>  app/test/test_interrupts.c             |  5 +++--
>  doc/guides/rel_notes/release_26_11.rst |  5 +++++
>  drivers/bus/cdx/cdx_vfio.c             |  6 ------
>  drivers/bus/pci/linux/pci_vfio.c       | 11 -----------
>  drivers/bus/pci/pci_common_uio.c       |  6 ------
>  drivers/bus/vmbus/vmbus_common_uio.c   |  6 ------
>  drivers/net/failsafe/failsafe.c        |  3 ---
>  drivers/net/mana/mana.c                |  4 ----
>  drivers/net/memif/rte_eth_memif.c      |  6 ------
>  drivers/net/mlx4/mlx4.c                |  3 ---
>  drivers/net/tap/rte_eth_tap.c          |  1 -
>  lib/eal/common/eal_common_interrupts.c |  6 ++++++
>  lib/eal/freebsd/eal_alarm.c            |  3 ---
>  lib/eal/include/rte_interrupts.h       |  2 ++
>  lib/eal/linux/eal_dev.c                |  4 ----
>  15 files changed, 16 insertions(+), 55 deletions(-)
>
> diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
> index 3a5be92cd7..5901cec2fe 100644
> --- a/app/test/test_interrupts.c
> +++ b/app/test/test_interrupts.c
> @@ -73,11 +73,12 @@ test_interrupt_init(void)
>                         rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
>                 if (!intr_handles[i])
>                         return -1;
> +               /* Verify fd is initialized to -1 */
> +               if (rte_intr_fd_get(intr_handles[i]) != -1)
> +                       return -1;
>         }
>
>         test_intr_handle = intr_handles[TEST_INTERRUPT_HANDLE_INVALID];
> -       if (rte_intr_fd_set(test_intr_handle, -1))
> -               return -1;
>         if (rte_intr_type_set(test_intr_handle, RTE_INTR_HANDLE_UNKNOWN))
>                 return -1;
>

An "interesting" failure came from the unit test.

The unit test does not set a dev_fd in its simulated interrupt handles.
However, Linux implementation in rte_intr_enable(), rte_intr_ack() and
rte_intr_disable() enforce that a valid dev_fd is set.

So the unit test for RTE_INTR_HANDLE_UIO type was passing so far
because the interrupt handler contained a valid 0 dev fd...  that was
unused in EAL in RTE_INTR_HANDLE_UIO only.

None of the other UIO and VFIO types (that do need a dev_fd) are
covered by the unit test.

On the other hand, actual usage of RTE_INTR_HANDLE_UIO type in the PCI
bus driver does set a dev_fd.

drivers/bus/pci/linux/pci_uio.c-        uio_cfg_fd = open(cfgname, O_RDWR);
drivers/bus/pci/linux/pci_uio.c-        if (uio_cfg_fd < 0) {
drivers/bus/pci/linux/pci_uio.c-                PCI_LOG(ERR, "Cannot
open %s: %s", cfgname, strerror(errno));
drivers/bus/pci/linux/pci_uio.c-                goto error;
drivers/bus/pci/linux/pci_uio.c-        }
drivers/bus/pci/linux/pci_uio.c-
drivers/bus/pci/linux/pci_uio.c-        if
(rte_intr_dev_fd_set(dev->intr_handle, uio_cfg_fd))
drivers/bus/pci/linux/pci_uio.c-                goto error;
drivers/bus/pci/linux/pci_uio.c-
drivers/bus/pci/linux/pci_uio.c-        if (dev->kdrv == RTE_PCI_KDRV_IGB_UIO) {
drivers/bus/pci/linux/pci_uio.c:                if
(rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UIO))

I'd lean towards removing the funky UIO part of the unit test.

Opinion?


-- 
David Marchand

