Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB777CD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 16:45:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF770402E4;
	Fri,  5 Jun 2026 18:45:39 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 4A319402E0
 for <dev@dpdk.org>; Fri,  5 Jun 2026 18:45:38 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso2177110eec.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780677937;
 x=1781282737; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4tsbMKFUJyyOA2pLOLTZIiC7aDf2pl2sICckKb+pos=;
 b=Va0OSJfe0QLmkQyJ3VoiGRx636grh63IAubb0dGzdqUqjV7xkyh6YtNkbPQcQNwq3y
 EdS4z12jli4+vIcAMOQoA9XjrVs9uoiuPgwfdXN3qvi9c60JEtwEtDyVS3AQOiu8Lyso
 vRKo83SuBOq2g7mHeMSJ16ZBlWUwkFRAGrOd7MHgSqJibKa9e26KTucUIoSdfuIMD2jd
 ugLEMRViSiSy6BCWAKHXugfDNiEGWFUMfyqVKITPEqiQIYaQkJZSJ4cZGbvpXguyu7fT
 9fFZ5LUF7vCvGuqtMjPF+Y7iFMjcnaAr1agyo2k2Txtr5h4aOxwjSui3nfB+B35eUMoq
 LjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780677937; x=1781282737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D4tsbMKFUJyyOA2pLOLTZIiC7aDf2pl2sICckKb+pos=;
 b=LVLsHLmDwIwNEXilruiwkmU6U2h4fmvtvcOdnb7ha/TdUTP6E0IdSUK94zViECq5BH
 D2YqUaTBf+hYSGOrQbGYhsAvtR24V2xWImvh10t2Usuk/3fXShKKsaGAoGKYPd2WpxuB
 WUvrjZ3zz2ngs261YlNslq92o8TFvcZrXtRfQkfR+3ZS9BHsU0EcTNvMV4EF2VEX5pds
 U7QJq7y25BB3vNW4aGUIdbK9ZYHbWcEW7eWkl6jc/29a1+r2VZ/McfhKx4qVoSWzbfuu
 GiFsXH5MbUiyVTmLbI+hrXCw2yhCmLi3PPyWBmChaQwb1Jmccnm5wD65KIr/hP1I8FNl
 vQ0g==
X-Gm-Message-State: AOJu0YzQ3gu1x8H37y47gP/oKF8q3vTzJjpeufQFj/Jb9nsS9gmtbHLZ
 eiXEBH5VfHfHo8eQELMkqXF7RuFPxFQcfwlLetfqCXfiIURQixGbcxOoxCwkEdITWoQ=
X-Gm-Gg: Acq92OEx3k3T+4fW26qmajM2iZhgQrzpFzhhiFYKUZAO2g7DGvpxzOSu2cHOGnMvQQq
 9leSgFmely7H7dGdXhu80vSbt00sS+Zrn/gxGwWOPjtD+GcI1bCuRXrMAHB0ZvPhT0i7rGPJ9jC
 rot3GoMAYJI7LBpCVaRSuhcJxvpRWx9QKv+MnLrPJYLUoMPJNYg0F/SslSby7nzvG+Nsve6EOHK
 S/NgYhzcKtg1ACkpMc1Ik4AHeAFup1Gy7cEUJXOQEr6W3iW8pd9ACIpIJ77w6D0eaql8GSJypzF
 wWj5rz6xS8hVJOoJ+6LWtCudjG7EUMa6GsYzumjwmAlRJnarFzVmO1t5s0O9UwE4kJNrQVkhmPn
 uoksmKW1k36b/0PqPnkmnOCR1mA8mK/RRzdTYFNatYmyy7yoqwkl8quS1z1n3q689U2UabSooZ3
 La5kaNHLWwjZn58XIKkNDtq0rDNh86f+rhwXJpwcdwyuEolW1waJyJb5upK42N/KUocDLcmXoY3
 ig=
X-Received: by 2002:a05:7300:fb87:b0:304:e587:5063 with SMTP id
 5a478bee46e88-3077af54770mr2115276eec.12.1780677936890; 
 Fri, 05 Jun 2026 09:45:36 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3078c1ac378sm564875eec.1.2026.06.05.09.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 09:45:36 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:45:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <fengchengwen@huawei.com>, <maxime.coquelin@redhat.com>,
 <thomas@monjalon.net>
Subject: Re: [PATCH v15 0/5] Support add/remove memory region and get-max-slots
Message-ID: <20260605094533.26cd079c@phoenix.local>
In-Reply-To: <20260604235723.1046607-1-pravin.bathija@dell.com>
References: <20260604235723.1046607-1-pravin.bathija@dell.com>
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

On Thu, 4 Jun 2026 23:57:18 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
> 
> This is version v15 of the patchset and it incorporates the
> recommendations made by Maxime Coquelin.
> 
> Patch 4/5
> - Changed VHOST_USER_REM_MEM_REG handler declaration from
>   accepts_fd=true to accepts_fd=false, as the remove request does not
>   expect FDs in ancillary data.
> - Removed all close_msg_fds(ctx) calls from vhost_user_rem_mem_reg(), no
>   longer needed since the handler is declared as not accepting FDs.
> - Removed validate_msg_fds(dev, ctx, 0) check from
>   vhost_user_rem_mem_reg(), as FD validation is now handled generically
>   by the framework. 
> - Added targeted IOTLB cache invalidation in vhost_user_rem_mem_reg()
>   using vhost_user_iotlb_cache_remove() for the removed region's GPA
>   range, instead of the nuclear iotlb_flush_all() used by set_mem_table.
> 
> This implementation has been extensively tested by doing Read/Write I/O
> from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
> dpdk testpmd (back-end) performing add/removal of memory regions. Also
> tested post-copy live migration after doing add_memory_region.
> 
> Version Log:
> Version v15 (Current version): Incorporate code review suggestions from
> Maxime Coquelin as described above.
> 
> Version v14: Incorporate code review suggestions from Stephen Hemminger
> and Fengcheng Wen.
> Changes from Fengcheng Wen review:
> Patch 3/5
> - Moved free_all_mem_regions() call sites in vhost_user_set_mem_table()
>   from patch 4/5 to patch 3/5 so each commit compiles independently
> Patch 4/5
> - Renamed _dev_invalidate_vrings() to vhost_user_invalidate_vrings() to
>   follow vhost naming convention
> -  Added comment explaining *pdev propagation through
>    translate_ring_addresses / numa_realloc()
> - Reordered local variables in vhost_user_add_mem_reg() and
>   vhost_user_rem_mem_reg() by descending line length
> - Shortened overlap check variable names (current_region_guest_start/end
>   --> cur_start/end, proposed_region_guest_start/end -> new_start/end)  
> - Fixed DMA error path in vhost_user_add_mem_reg(): added
>   free_new_region_no_dma label so async_dma_map_region(false) is not
>   called when the map itself failed.
> Changes from Stephen Hemminger review:
> Patch 4/5
> - vhost_user_add_mem_reg() now constructs a reply with the back-end's
>   host mapping address in userspace_addr and returns
>   RTE_VHOST_MSG_RESULT_REPLY per the vhost-user spec
> - Added validate_msg_fds(dev, ctx, 0) in vhost_user_rem_mem_reg() to
>   reject malformed messages with unexpected file descriptors
> - Dropped unnecessary (uint64_t) cast in vhost_user_get_max_mem_slots()
> 
> Version v13: Incorporate code review suggestions from Fengcheng Wen
> Patch 2/5
> Renamed VhostUserSingleMemReg to VhostUserMemRegMsg and memory_single
> to memreg
> Patches 3/5 and 4/5
> Relocated function remove_guest_pages from patch 3/5 to 4/5
> 
> Version v12: Incorporate code review suggestions from Maxime Coquelin
> and ai-code-review.
> Patch 3/5
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
> Patch 4/5
> Fix incomplete cleanup in vhost_user_add_mem_reg() when
> vhost_user_mmap_region() fails after the mmap succeeds (e.g.
> add_guest_pages() realloc failure) realloc failure). The error path now
> calls remove_guest_pages() and free_mem_region() to undo the mapping
> and stale guest-page entries, preventing a leaked mmap and slot reuse
> corruption. The plain close(fd) path is kept for pre-mmap failures.
> 
> Version v10: Incorporate code review suggestions from Stephen Hemminger.
> Patch 4/5
> Moved dev_invalidate_vrings after free_mem_region, array compaction, and
> nregions decrement. This ensures translate_ring_addresses only sees
> surviving memory regions, preventing vring pointers from resolving into
> a region that is about to be unmapped.
> 
> Version v9: Incorporate code review suggestions from Stephen Hemminger.
> Patch 3/5
> Restored max_guest_pages initial value to hardcoded 8 instead of
> VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.
> Patch 4/5
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
>   vhost: header defines for add/rem mem region
>   vhost: refactor memory helper functions
>   vhost: add mem region add/remove handlers
>   vhost: enable configure memory slots
> 
>  .mailmap               |   1 +
>  lib/vhost/rte_vhost.h  |   4 +
>  lib/vhost/vhost_user.c | 425 +++++++++++++++++++++++++++++++++++------
>  lib/vhost/vhost_user.h |  10 +
>  4 files changed, 378 insertions(+), 62 deletions(-)
> 

I don't think this is ready to merge based on AI review.
Did AI review with Opus 4.8 on a chat which has past context.

Summary of v15 findings


New in v15 (both patch 4/5, both errors):

    Use-after-free on the reply path: reg points into dev->mem->regions[], but dev_invalidate_vrings() -> translate_ring_addresses() -> numa_realloc() can relocate dev->mem. dev is refreshed via *pdev, reg is not, then reg->host_user_addr is read for the reply. Re-derive reg (or capture host_user_addr) after dev = *pdev.
    ADD_MEM_REG reply sent unconditionally: handler always returns RESULT_REPLY, but the spec makes the mapping-address reply postcopy- only. In non-postcopy mode this desyncs the channel (no REPLY_ACK: the front-end never reads it; with REPLY_ACK: it expects a u64 ack, not a memreg). Gate the reply on dev->postcopy_listening, else return RESULT_OK -- same as SET_MEM_TABLE.

Carried over from v13 (now in a different form):

    The v13 Warning (missing postcopy mapping-address reply) is addressed but mis-gated; correct fix is the conditional reply above. Until then postcopy correctness still isn't right.

