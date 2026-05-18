Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3685ACD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 17:13:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42D53402D9;
	Mon, 18 May 2026 19:13:49 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 357FC40041
 for <dev@dpdk.org>; Mon, 18 May 2026 19:13:48 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-133466cf955so9713947c88.0
 for <dev@dpdk.org>; Mon, 18 May 2026 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779124427;
 x=1779729227; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNdkQSCzYZ+sbBh+31L7tMbJPW4HxMrOnZGp8LMIX1A=;
 b=lCJ3lp+coKShii7mrVCADRGQBqEOCehUMYniwIncP4KFmPBUTKQ/sj5EOny/9tZFar
 fi6EdSITthGeczMVYJAbuMZIBs6zMz08+hgSEf9jqVZiMCazS9+/ygYIi+ufbE3USfEB
 dwa3eE/HWRRWkK/Abhp06YlBGhR8j6ql4gEA6CEyTTU5teSWst+NoB2FKjSKUkUla9sp
 hKlWRyzZ/z92lWbtAYlt8ECRxqmXO1hWQDJq+Ls3CRvxptkaOpRtWP4Q0foNzQdx6gdN
 q1uG2LMjv8JY2G6Qg5FgPN1cNmTdonIiTy76ZARcuaTatB9FuAdxggAC399nXc6a+Vv7
 Ybmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779124427; x=1779729227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UNdkQSCzYZ+sbBh+31L7tMbJPW4HxMrOnZGp8LMIX1A=;
 b=SMAvj7108MnR/6EyomzPsBWkDcV0UtFCld9dQDjmdMasR7pVoFNZ7DUH6WWbtsPtaw
 Ml6JlT79BEFJPcHDulPOfDgFkOhgSuN1lTNGrVmgE+ZS/nfhY1dd+76Y5dnkiV6gpG1O
 dDmGAzltfNli/HJNtPohmuE9/iPDSRD9sXhvhwCVHfFWbQ4SYVqvLiQy3tkjKacOEF/c
 Bu24hOjG9oV8aOrQYvzPobBeFvOpP6rNApHOxJ4hU6iJtR9GgcnMdRulGOOORgzZBg+D
 vuIwuLkNx73FIf+GPRMtk8D4hiyOvXRclZZl76DhFQveOp0eOMESs/+ZSe39SOa3562H
 qX8w==
X-Gm-Message-State: AOJu0YymUT0cMPKERPlsjKZGjg+dK1ZFeRPAU0l3kN/9DtuhLZkNzi7r
 pAL07C4hoysbvwrinRWkWKcqtSDZyjpnfr5lRoZPqDi1Or6vYqdJifw7Wj279a/vbMQ=
X-Gm-Gg: Acq92OGj5ar+PiSnHfe88ohXy/yecoGF3v1etPcOaSDqZWujcnS3IrvUCqY7DiVsesd
 lwb4ODS0FKApThe0Q0wP+G4JNcFI2emXtEsqXT6HyUCQVuo66PuAkgEKTDNgv1Wwd/chU/FuUk1
 usuv1Oy4DYn/Yi5IQBIbmNYK8SXlAzB5N1UqsAyWzmmnTJf1EFamrfwvh6fSjNHrmwGTjqM7f9m
 uC5rxZAHsckwAx181Ta0yq+538GbrqcO7GWA7osJpo7DfYQI4JvT/XFEtIsKzgQG0A20Vjo7REI
 dKwEdtF+voGP0rsAnTP8IGXzKgJaJoafqcfQneojPjvR5PywEmI5OUyYKdvXKxxcGBMy3GZpHOJ
 HYxWHR7NNDxdzeENinZsMNeqcq5jFv6dERzzEv7zriC5sV6p+Rz6BhqsPRib9secrSVE+w92rIH
 +rF+B+K2R4IYJwPsx+7rfehinoXewaIr3UmORdNXMeO2jcyQ==
X-Received: by 2002:a05:7022:ead3:b0:130:6904:e817 with SMTP id
 a92af1059eb24-13504a52c62mr6612836c88.39.1779124426924; 
 Mon, 18 May 2026 10:13:46 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ed3sm20284095c88.1.2026.05.18.10.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:13:46 -0700 (PDT)
Date: Mon, 18 May 2026 10:13:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>, <maxime.coquelin@redhat.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v13 0/5] Support add/remove memory region and get-max-slots
Message-ID: <20260518101344.7a1de0ef@phoenix.local>
In-Reply-To: <20260514020157.1937404-1-pravin.bathija@dell.com>
References: <20260514020157.1937404-1-pravin.bathija@dell.com>
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

On Thu, 14 May 2026 02:01:52 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> This is version v13 of the patchset and it incorporates the
> recommendations made by Fengcheng Wen.
> 
> Changes made to patch 3/5 and 4/5
> * Relocated function remove_guest_pages from patch 3/5 to 4/5.
> * Renamed VhostUserSingleMemReg to VhostUserMemRegMsg and memory_single
>   to memreg.
> 
> This implementation has been extensively tested by doing Read/Write I/O
> from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
> dpdk testpmd (back-end) performing add/removal of memory regions. Also
> tested post-copy live migration after doing add_memory_region.
> 
> Version Log:
> Version v13 (Current version): Incorporate code review suggestions from
> Fengcheng Wen as described above.
> Version v12: Incorporate code review suggestions from Maxime Coquelin
> and ai-code-review.
> Changes made to patch 3/5
> Refactored async_dma_map() to delegate to async_dma_map_region(),
> eliminating code duplication between the two functions.
> Restored original comments in async_dma_map_region() explaining why
> ENODEV and EINVAL errors are ignored (these were stripped in v10)
> Reverted unnecessary changes to vhost_user_postcopy_register() --
> removed the host_user_addr == 0 checks and reg_msg_index indirection
> that were added in  v10, since this function is only called from
> vhost_user_set_mem_table() where regions are always contiguous.
> 
> Version v11: Incorporate code review suggestions from Stephen Hemminger.
> Change made to patch 4/5
> Fix incomplete cleanup in vhost_user_add_mem_reg() when
> vhost_user_mmap_region() fails after the mmap succeeds (e.g.
> add_guest_pages() realloc failure) realloc failure). The error path now
> calls remove_guest_pages() and free_mem_region() to undo the mapping
> and stale guest-page entries, preventing a leaked mmap and slot reuse
> corruption. The plain close(fd) path is kept for pre-mmap failures.
> 
> Version v10: Incorporate code review suggestions from Stephen Hemminger.
> Change made to patch 4/5
> Moved dev_invalidate_vrings after free_mem_region, array compaction, and
> nregions decrement. This ensures translate_ring_addresses only sees
> surviving memory regions, preventing vring pointers from resolving into
> a region that is about to be unmapped.
> 
> Version v9: Incorporate code review suggestions from Stephen Hemminger.
> Changes made to patch 3/5
> Restored max_guest_pages initial value to hardcoded 8 instead of
> VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.
> Changes made to patch 4/5
> Added close(reg->fd) and reg->fd = -1 before goto close_msg_fds in the
> mmap failure path to fix fd leak after fd was moved from ctx->fds[0].
> Converted dev_invalidate_vrings from a plain function to a macro +
> implementation function pair, accepting message ID as a parameter so
> the static_assert reports the correct handler at each call site.
> Updated dev_invalidate_vrings call in add_mem_reg to pass
> VHOST_USER_ADD_MEM_REG as message ID.
> Updated dev_invalidate_vrings call in rem_mem_reg to pass
> VHOST_USER_REM_MEM_REG as message ID.
> 
> Version v8:  Incorporate code review suggestions from Stephen Hemminger.
> rewrite async_dma_map_region function to iterate guest pages by host
> address range matching
> change function dev_invalidate_vrings to accept a double pointer to
> propagate pointer updates
> new function remove_guest_pages was added
> add_mem_reg error path was narrowed to only clean up the single failed
> region instead of destroting all existing regions
> 
> Version v7: Incorporate code review suggestions from Maxime Coquelin.
> Add debug messages to vhost_postcopy_register function.
> 
> Version v6: Added the enablement of this feature as a final patch in
> this patch-set and other code optimizations as suggested by Maxime
> Coquelin.
> 
> Version v5: removed the patch that increased the number of memory regions
> from 8 to 128. This will be submitted as a separate feature at a later
> point after incorporating additional optimizations. Also includes code
> optimizations as suggested by Feng Cheng Wen.
> 
> Version v4: code optimizations as suggested by Feng Cheng Wen.
> 
> Version v3: code optimizations as suggested by Maxime Coquelin
> and Thomas Monjalon.
> 
> Version v2: code optimizations as suggested by Maxime Coquelin.
> 
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
>  lib/vhost/vhost_user.c | 418 +++++++++++++++++++++++++++++++++++------
>  lib/vhost/vhost_user.h |  10 +
>  4 files changed, 371 insertions(+), 62 deletions(-)
> 

Some useful AI feedback

Review of [PATCH v13 0-5/5] vhost: configure memory slots support
Author: Pravin M Bathija <pravin.bathija@dell.com>

This revision addresses essentially every correctness issue raised in
the v7-v12 reviews:

  - ctx->fds[0] = -1 ownership transfer is now done before mmap, and
    the mmap-failure path closes reg->fd explicitly when mmap never
    set reg->mmap_addr.
  - _dev_invalidate_vrings now takes struct virtio_net **pdev and
    writes back *pdev = dev at the end, so a numa_realloc inside
    translate_ring_addresses propagates correctly. Both call sites
    refresh "dev = *pdev;" afterwards.
  - The dev_invalidate_vrings() macro now takes the message id and
    uses static_assert(id ## _LOCK_ALL_QPS, ...), matching the
    existing VHOST_USER_ASSERT_LOCK pattern. Works for both
    VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG call sites.
  - Overlap check in vhost_user_add_mem_reg uses guest address
    space (guest_user_addr, size / userspace_addr, memory_size),
    no longer mmap_size.
  - free_new_region undoes only the failed region: async DMA unmap,
    remove_guest_pages, free_mem_region(reg), nregions--.
  - async_dma_map_region iterates dev->nr_guest_pages and filters
    by [reg_start, reg_end), eliminating the prior reg_size
    underflow loop.
  - The regions array is kept contiguous via memmove on REM_MEM_REG,
    so existing iterators that walk mem->nregions remain correct.
  - max_guest_pages is back to 8 in vhost_user_initialize_memory.

One protocol-level issue remains worth raising.


Patch 4/5 -- vhost_user: Function defs for add/rem mem regions
--------------------------------------------------------------------

Warning: ADD_MEM_REG does not send the host_user_addr reply

  Per the vhost-user spec for VHOST_USER_ADD_MEM_REG, the back-end
  is expected to reply with the same message format and the
  userspace_addr field replaced by the host userspace address that
  the region was mapped into. The handler returns
  RTE_VHOST_MSG_RESULT_OK with no reply constructed, so the
  dispatcher does not call send_vhost_reply().

  For postcopy migration this matters in particular: the original
  vhost_user_postcopy_register() does two things -- exchange the
  host_user_addr with the front-end and wait for an ack, then
  register the regions with userfaultfd. The patch only does the
  userfaultfd registration via vhost_user_postcopy_region_register().
  The in-code comment notes the payload-layout mismatch with
  vhost_user_postcopy_register() but stops there.

  Without the address reply, QEMU will not know the back-end's
  mapping for regions added via ADD_MEM_REG, so the userfaultfd
  handling on the QEMU side cannot resolve faults in those
  regions. Postcopy migration combined with the
  CONFIGURE_MEM_SLOTS feature will not work.

  Suggested fix: construct a memreg-payload reply with
  region->userspace_addr replaced by reg->host_user_addr and
  return RTE_VHOST_MSG_RESULT_REPLY. At minimum, refuse
  ADD_MEM_REG when dev->postcopy_listening is set, so that the
  combination fails cleanly rather than silently mis-mapping.


Info: vhost_user_rem_mem_reg does not validate ctx->fd_num

  The handler is registered with accepts_fd = true and does not
  call validate_msg_fds(). The trailing close_msg_fds(ctx) cleans
  up whatever fds were passed, so this is not a leak, but a
  malformed message with an unexpected fd count is silently
  accepted. The other accepts_fd handlers in this file validate
  fd_num explicitly.


Info: vhost_user_get_max_mem_slots cast is unnecessary

  ctx->msg.payload.u64 = (uint64_t)max_mem_slots;

  max_mem_slots is uint32_t and the assignment widens
  automatically; the cast can be dropped. Minor.


Reviewed-by would be appropriate once the postcopy reply is
addressed (or the combination is rejected). The rest of the
series looks correct.

