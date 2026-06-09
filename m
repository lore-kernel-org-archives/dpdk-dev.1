Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02653CD8CAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:58:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 412D7402BE;
	Tue,  9 Jun 2026 09:58:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 584A7402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 09:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780991929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qW5O4aqu9NTEk4DDEQ5wP1WpySbSDxtaRFWyvc9phs8=;
 b=QcUdeS1GGEPHZ+QbCmLIZZ/crfm7UABoghqai5I4nxQ8yhlEsqHAzuWqgybv/RV9Ymunj4
 UvE8HYqV6GB+zYUyp22n9UdRfrIcI71I5nSxay1gs7EYJaLc9h9ZttB/TPGGaBuvgaE+YJ
 QeJj+BlHBFqJglCJjWf5OXCMo0SNc9U=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-OATwcOtoNnephLdJ0Mib4w-1; Tue, 09 Jun 2026 03:58:48 -0400
X-MC-Unique: OATwcOtoNnephLdJ0Mib4w-1
X-Mimecast-MFC-AGG-ID: OATwcOtoNnephLdJ0Mib4w_1780991927
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137f304f564so18217214c88.0
 for <dev@dpdk.org>; Tue, 09 Jun 2026 00:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780991927; x=1781596727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qW5O4aqu9NTEk4DDEQ5wP1WpySbSDxtaRFWyvc9phs8=;
 b=ZdoQxJb0Or4JCHUpgRCPBQHudEGRaSf9c2vV8yls6sGn6ZGnWjdLlcLGA5gZrHjC7N
 UHeQEZWfaLASxmmB83i56vDBMIwBZkspuaIbWAEcrT4kN67F3r56QmqB2J4eWABugNqC
 4h7vtZSm092invA/76WHQlKEmSKXrsmOyTlB5c6EshYgqXxsuG+90UUOwu0+4GkjrSqK
 76SQg0p67xNenDrCOqDxbv3PohlfmU1Piaxajbvp2wRcNJbjOOfskaRsUHvI3XQVeLok
 fvPTN/y9DSjg9nbZdkpHKVnsQ2Svq41+wclMF6BLEU/wR8eknY+RvkA3NXd+nxNaPk3P
 /Lfg==
X-Gm-Message-State: AOJu0Ywi6/npfH+fErbte+B/PpW5KWTDWYKo2KiS5DYnUyV4BBxZAYW2
 wH8oDvphcpxZ2XfQ6X0jl6K5BCU/HqtfupzN5vKKvjEM0NRIJ++ZAc580XzjZuzlb+SLDhXDddd
 okozP6nFPUEOb3ugKTG7vi5eVgjfGIdX3qUyAUkl0pKCM/i22eoRqWJXbpZj3htrc85PoFS9zn2
 Vy2gW6xoxKpNmHCzetBdo=
X-Gm-Gg: Acq92OFo/c4MpkpBSYl+OKJtxF0+vq/qV/3LHKYdepKBYsLa73FvjMicesqA1P8t0bk
 aq4J64peBgz3bAZ1ymeD4VGMeJ1vK71mHJEU3AJmAek7mfpGXnToTxEoHK/ZiILSoPSqbAp6wAk
 /vfRY88cGASaCZw8+2txFLlMVBeOJL0U25tMaBd5zqkzqQKlewFId7zscawnYfRw8YBDNdig6wf
 9rY5wy7W6/Zu73NX1874lEiZAJEE5vJm1nX7xz9QiBcW+DjAJy/MxcMGFPcAq1/M4Yxj7Le6+aS
X-Received: by 2002:a05:7022:fd0c:b0:137:99bd:d156 with SMTP id
 a92af1059eb24-1380666a13bmr10566022c88.7.1780991927075; 
 Tue, 09 Jun 2026 00:58:47 -0700 (PDT)
X-Received: by 2002:a05:7022:fd0c:b0:137:99bd:d156 with SMTP id
 a92af1059eb24-1380666a13bmr10565997c88.7.1780991926506; Tue, 09 Jun 2026
 00:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260606025211.1082615-1-pravin.bathija@dell.com>
In-Reply-To: <20260606025211.1082615-1-pravin.bathija@dell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 9 Jun 2026 09:58:35 +0200
X-Gm-Features: AVVi8CffeKn4hqQyp4nwNEpZ15S7UwXQwIAPiqN1z1DIHlUXsiaRSHZ1qQaC6G8
Message-ID: <CAO55csxFPeOhUyOva6aG3KKenoED9SLEXdseBUqYe5GK5vjPOQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/5] Support add/remove memory region and get-max-slots
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, stephen@networkplumber.org, fengchengwen@huawei.com, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FHUcw4n2IYYnDaUdEJzHOAqMnhX-IQ6HJOJAjxOiquM_1780991927
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
> This is version v16 of the patchset and it incorporates the
> recommendations made by Stephen Hemminger.
>
> Patch 4/5
> - Fixed use-after-free in vhost_user_add_mem_reg(): reg pointed into
>   dev->mem->regions[] but dev_invalidate_vrings() ->
>   translate_ring_addresses() -> numa_realloc() can relocate dev->mem ;
>   re-drive the region pointer from the refreshed dev before reading
>   host_user_addr for the reply.
> - Gated the ADD_MEM_REG mapping-address reply on dev->postcopy_listening
>   per the vhost-user spec (reply is postcopy-only); return
>   RTE_VHOST_MSG_RESULT_OK in non-postcopy mode,  matching SET_MEM_TABLE,
>   to avoid desyncing the channel.
>
> This implementation has been extensively tested by doing Read/Write I/O
> from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
> dpdk testpmd (back-end) performing add/removal of memory regions. Also
> tested post-copy live migration after doing add_memory_region.
>
> Version Log:
> Version v16 (Current version): Incorporate code review suggestions from
> Stephen Hemminger.
>
> Version v15: Incorporate review suggestions from Maxime Coquelin.
> Patch 4/5
> - Changed VHOST_USER_REM_MEM_REG handler declaration from
>   accepts_fd=3Dtrue to accepts_fd=3Dfalse, as the remove request does not
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
> removed the host_user_addr =3D=3D 0 checks and reg_msg_index indirection
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
> Added close(reg->fd) and reg->fd =3D -1 before goto close_msg_fds in the
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
>  lib/vhost/vhost_user.c | 438 +++++++++++++++++++++++++++++++++++------
>  lib/vhost/vhost_user.h |  10 +
>  4 files changed, 391 insertions(+), 62 deletions(-)
>
> --
> 2.43.0
>

Applied to next-virtio/for-next-net.

Thanks,
Maxime

