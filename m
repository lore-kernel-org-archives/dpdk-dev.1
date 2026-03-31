Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1E51061B2F
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:26:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 688A340285;
	Tue, 31 Mar 2026 05:26:19 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 63CA54025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:26:18 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so23523985ad.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 20:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774927577;
 x=1775532377; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmLe1Yqzb5jduUUMZRkB+G0gHoU+lyLtWA2IY2Jo+pA=;
 b=dCyJE7F2KWPKAeNw8whH5raB5BpfXh8S8PQqF8P9Ws//MRfnfbT/TgpbkTx05xMVmd
 8VThrdRSvt7I7/RoVLH5z3e05+rM1Zi+UhOo5z1+Dyegx7xDz4RcVar/Ruli7V12pKRh
 rN1iofU7vbQJHGvJLpmFHkVoYaYY753N4q2AMnqsYwqIEUYUwCxnCTy3RdNM3pA70K26
 M/eQQTtPoY91uR8fENN93XjctZ4x6Rvs1r35bx90teaolt3sfIjM93nr2PDHelVOhzGM
 zpee9Df4jhD3lFhGC+43t8Hv+3IZwgZiBWE88l3xuXLCGV9P8hWSlIM/p967ieqWRqDw
 v+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774927577; x=1775532377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HmLe1Yqzb5jduUUMZRkB+G0gHoU+lyLtWA2IY2Jo+pA=;
 b=CNn8cAEd7/Qt4mpfTi2tOM15BzPKKezr2Yoi8jdJuPXP05ZBlkcAyx6Wgd+kJuoMPW
 SpmcrHs/Iybov+4W37SS1IPjviJZluvwq9Y4b5lH3EfP/Nrr6sFDU/+zl917qPFsP4Np
 N6snzufjE3XbJ/W8iAHuzpT6bZ3UM5pE8p3ioXL1osRpwQvVuMHL4aO7TDupVaoTmS+q
 JWNw8rjZbx9TsY7QnWyfQhZv/3Iex6nAnwEMpp/+RZWTmhCzeV95UAtWoI/l6VedqomE
 a8kjJtCYCMN7AnZnGkFt54vide2q8hNVraYLzjq6DnTFiP+LqHjDRwMk6YAIiO5wjgL5
 BGng==
X-Gm-Message-State: AOJu0Yz9qiveWsXoRSbOVAH32TdtlJgRpqwO46s/sBBYRIbncwU/yqWO
 vPXIwg8lHAvAkpDU06AOxHlPoFtAwIYZ1K4e4T/JG2RfkJ/l/5OMKXBaapmADjQRRH4=
X-Gm-Gg: ATEYQzwSf5QTy5ZbNHfpDZl2I/vJRBeJazA99U3lq7KctVr1gEYbCWhXURfsp/asLnX
 O3eJGIAKW3klHtCSpD8331wtPBH/dsxpwDeuKb95pddfPm9+rVad5m0QoA7q1iGhJ3cA7KbIXfF
 mkk6nNhfKdBZtRGRYpYe1grSGYqi3Jrr2tGKRUrCoe8+hvCtt9XNR7kDlnx8AOOu6Ko1KUy0h2S
 vOx3W4OoQm6+14B+LrHiY59WoyHti4VjaIgJ1qQSW7U/SZd5scpPfjrNsIghMO89MVa2v3X+zgG
 veCT2GZWugGHqEN+RaGV6jXwqtR1uNXAkW5jkCOGalwtYNvlVGsXdmfo5qL3sEVoQO5k6A1lyy7
 Xd0RIog5eWgdVfQ2Ldbo3XQkHsb124YOGK7zTv40Fnbs2nGiKN8ut2rgSNf0svnr5v7AlS5Bewb
 Me2OWjSOjARJC6uJWIr/6nLagHKZrFj60E424=
X-Received: by 2002:a17:902:e5cc:b0:2ae:a928:f544 with SMTP id
 d9443c01a7336-2b0cdd2f564mr160323975ad.45.1774927577219; 
 Mon, 30 Mar 2026 20:26:17 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24265a954sm98404625ad.18.2026.03.30.20.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 20:26:17 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:26:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: Re: [PATCH v7 0/5] Support add/remove memory region & get-max-slots
Message-ID: <20260330202609.2e34cd13@phoenix.local>
In-Reply-To: <20260211102433.694516-1-pravin.bathija@dell.com>
References: <20260211102433.694516-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 11 Feb 2026 10:24:28 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> This is version v7 of the patchset and it incorporates the
> recommendations made by Maxime Coquelin and Feng Cheng Wen.
> The patchset includes support for adding and removal of memory
> regions, getting max memory slots and other changes to vhost-user
> messages.  These messages are sent from vhost-user front-end (qemu
> or libblkio) to a vhost-user back-end (dpdk, spdk). Support functions
> for these message functions have been implemented in the interest of
> writing optimized code. Older functions, part of vhost-user back-end
> have also been optimized using these newly defined support functions.
> This implementation has been extensively tested by doing Read/Write
> I/O from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end
> talking to dpdk + testpmd (back-end) performing add/removal of memory
> regions. Also tested post-copy live migration after doing
> add_memory_region.
> 
> Version Log:
> Version v7 (Current version): Incorporate code review suggestions
> from Maxime Coquelin. Add debug messages to vhost_postcopy_register
> function.
> Version v6: Added the enablement of this feature
> as a final patch in this patch-set and other code optimizations as
> suggested by Maxime Coquelin.
> Version v5: removed the patch that increased the
> number of memory regions from 8 to 128. This will be submitted as a
> separate feature at a later point after incorporating additional
> optimizations. Also includes code optimizations as suggested by Feng
> Cheng Wen.
> Version v4: code optimizations as suggested by Feng Cheng Wen.
> Version v3: code optimizations as suggested by Maxime Coquelin
> and Thomas Monjalon.
> Version v2: code optimizations as suggested by Maxime Coquelin.
> Version v1: Initial patch set.
> 
> Pravin M Bathija (5):
>   vhost: add user to mailmap and define to vhost hdr
>   vhost_user: header defines for add/rem mem region
>   vhost_user: support function defines for back-end
>   vhost_user: Function defs for add/rem mem regions
>   vhost_user: enable configure memory slots
> 
>  .mailmap               |   1 +
>  lib/vhost/rte_vhost.h  |   4 +
>  lib/vhost/vhost_user.c | 392 ++++++++++++++++++++++++++++++++++++-----
>  lib/vhost/vhost_user.h |  10 ++
>  4 files changed, 365 insertions(+), 42 deletions(-)
> 

Lots more stuff found by AI code review, this is not ready.

Review of [PATCH v7 1-5/5] vhost: configure memory slots support
Author: Pravin M Bathija <pravin.bathija@dell.com>

This patch series adds support for the VHOST_USER_F_CONFIGURE_MEM_SLOTS
protocol feature, enabling add/remove individual memory regions instead
of requiring a full SET_MEM_TABLE each time.  The approach is sound and
the feature is needed, but several correctness bugs need to be addressed.

Patch 3/5 -- vhost_user: support function defines for back-end
--------------------------------------------------------------------

Error: dev_invalidate_vrings loses *pdev update after numa_realloc

  translate_ring_addresses() calls numa_realloc(), which can reallocate
  the dev struct and update *pdev.  In the original set_mem_table the
  caller writes "*pdev = dev;" after the call to observe this.

  dev_invalidate_vrings() takes a plain "struct virtio_net *dev" and
  passes "&dev, &vq" to translate_ring_addresses -- but dev is a local
  copy.  If numa_realloc reallocates, the caller's *pdev (in
  vhost_user_add_mem_reg) is never updated, and all subsequent accesses
  use a stale/freed pointer -- a use-after-free.

  The function should take struct virtio_net **pdev (matching the
  pattern used in set_mem_table) and propagate updates back.

Error: async_dma_map_region can underflow reg_size

  The loop "reg_size -= page->size" uses unsigned subtraction. If
  page->size does not evenly divide reg->size (which can happen with
  misaligned guest pages), reg_size wraps to a huge value and the loop
  runs out of bounds.  The original async_dma_map avoids this by
  iterating over nr_guest_pages directly.

  Suggest checking "reg_size >= page->size" before subtracting, or
  better yet iterating like the original does.

Warning: free_all_mem_regions iterates all VHOST_MEMORY_MAX_NREGIONS
  but the original free_mem_region iterated only dev->mem->nregions

  This is intentional for the sparse-slot design, but free_mem_region()
  checks "reg->host_user_addr" while free_all_mem_regions checks
  "reg->mmap_addr" as the sentinel.  These should be consistent.
  A region that was partially initialized (mmap_addr set but
  host_user_addr not yet set, or vice versa) would behave
  differently depending on which sentinel is checked.

Warning: vhost_user_initialize_memory unconditionally allocates
  dev->mem without freeing any prior allocation

  If dev->mem is non-NULL when vhost_user_initialize_memory is called,
  the old allocation is leaked.  set_mem_table frees dev->mem before
  calling it, but add_mem_reg only checks "dev->mem == NULL" and skips
  the call otherwise.  This is safe as coded, but the function itself
  is fragile -- consider adding an assertion or early return if
  dev->mem is already set.

Info: vhost_user_postcopy_register changes use reg_msg_index but the
  second loop (postcopy_region_register) still iterates dev->mem->regions
  with nregions as the bound and just skips zeros.  This is correct
  but the two loops use different iteration strategies which is
  confusing.  Consider making both iterate VHOST_MEMORY_MAX_NREGIONS
  with a skip-zero check for consistency.


Patch 4/5 -- vhost_user: Function defs for add/rem mem regions
--------------------------------------------------------------------

Error: vhost_user_add_mem_reg does not set ctx->fds[0] = -1 after
  assigning reg->fd = ctx->fds[0]

  In the original set_mem_table, after "reg->fd = ctx->fds[i]" the
  code sets "ctx->fds[i] = -1" to prevent the fd from being double-
  closed if the error path calls close_msg_fds().  The new add_mem_reg
  omits this.  If vhost_user_mmap_region or vhost_user_postcopy_register
  fails, the error path calls close_msg_fds(ctx) which closes
  ctx->fds[0] -- but reg->fd still holds the same value.  Later,
  free_all_mem_regions will close(reg->fd) again -- double close.

  Fix: add "ctx->fds[0] = -1;" after "reg->fd = ctx->fds[0];".

Error: vhost_user_add_mem_reg error path frees all memory on
  single-region failure

  If postcopy_register fails after successfully mmap'ing one region
  (when other regions already exist), the "free_mem_table" label
  calls free_all_mem_regions + rte_free(dev->mem) + rte_free
  (dev->guest_pages), destroying ALL previously registered regions.
  This is disproportionate -- the error should only unmap the single
  region that was just added and decrement nregions.

Error: overlap check uses mmap_size for existing region but
  memory_size for proposed region

  The overlap check compares:
    current_region_guest_end = guest_user_addr + mmap_size - 1
    proposed_region_guest_end = userspace_addr + memory_size - 1

  mmap_size = memory_size + mmap_offset (set by vhost_user_mmap_region).
  So the existing region's range is inflated by the mmap_offset,
  potentially producing false overlaps.  Use current_region->size
  (which corresponds to memory_size) instead of mmap_size for a
  correct comparison.

Error: vhost_user_add_mem_reg uses guest_user_addr == 0 as "slot
  is empty" but guest_user_addr 0 is a valid guest virtual address

  The free-slot search does:
    if (dev->mem->regions[i].guest_user_addr == 0)
  
  Guest address 0 is valid (common in some VM configurations).
  If a region is mapped at guest VA 0, it would appear as a free
  slot.  The original code uses compact packing (nregions as the
  count), avoiding this problem.  Consider using a dedicated
  "in_use" flag or checking mmap_addr == NULL instead (mmap
  never returns NULL on success, it returns MAP_FAILED).

Warning: vhost_user_rem_mem_reg matches on guest_phys_addr but the
  spec says "identified by guest address, user address and size"

  The comment in the code says "identified by its guest address,
  user address and size. The mmap offset is ignored." but the
  comparison also checks guest_phys_addr (which is the GPA, not
  the guest user address).  The spec says matching is by
  userspace_addr (GVA), guest_phys_addr (GPA), and memory_size.
  So the match is actually correct in practice, but the comment
  is misleading -- it should mention GPA too, or remove the
  comment about what the spec says.

Warning: nregions becomes inconsistent with actual slot usage

  After add_mem_reg, nregions is incremented.  After rem_mem_reg,
  nregions is decremented.  But regions are not packed -- removing
  a region from the middle leaves a hole.  Functions like
  qva_to_vva, hva_to_gpa, and rte_vhost_va_from_guest_pa all
  iterate "i < mem->nregions" and index "mem->regions[i]"
  sequentially.  With sparse slots these functions will miss
  regions that are stored at indices >= nregions.

  Example: 3 regions at slots 0,1,2 (nregions=3).  Remove slot 1
  (memset to 0, nregions=2).  Now qva_to_vva iterates slots 0,1
  only -- slot 2 (still valid) is never checked.  Address
  translations for memory in the third region will fail.

  This is a correctness bug that will cause packet processing
  failures.  Either pack the array on removal (shift later entries
  down) or change all iteration to use VHOST_MEMORY_MAX_NREGIONS
  with skip-zero checks.

Warning: dev_invalidate_vrings does not update *pdev in add_mem_reg

  Related to the Error in patch 3 -- even if dev_invalidate_vrings
  is fixed to take **pdev, the caller vhost_user_add_mem_reg must
  also write "*pdev = dev;" to propagate the possibly-reallocated
  pointer back through the message handler framework.


Patch 5/5 -- vhost_user: enable configure memory slots
--------------------------------------------------------------------

Warning: the feature is enabled unconditionally but several
  address translation functions (qva_to_vva, hva_to_gpa,
  rte_vhost_va_from_guest_pa) have not been updated to handle
  sparse region arrays.  Enabling the feature flag before fixing
  the nregions iteration issue means any front-end that uses
  ADD_MEM_REG/REM_MEM_REG will hit broken address translations.


Summary
--------------------------------------------------------------------

The most critical issues to fix before this can be merged:

1. nregions vs sparse-slot iteration mismatch -- this will cause
   address translation failures at runtime after any REM_MEM_REG.
   All loops that iterate mem->regions must either use compact
   packing or be updated to scan all VHOST_MEMORY_MAX_NREGIONS
   slots with skip-zero checks.

2. dev_invalidate_vrings / translate_ring_addresses *pdev propagation
   -- use-after-free if numa_realloc fires.

3. Missing ctx->fds[0] = -1 in add_mem_reg -- double-close on
   error paths.

4. Overlap check using mmap_size instead of size -- false positive
   overlaps.

5. Error path in add_mem_reg destroys all regions instead of just
   the failed one.

