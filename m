Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D3BCD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 08:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9221B402AD;
	Mon,  8 Jun 2026 10:09:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B5DB40265
 for <dev@dpdk.org>; Mon,  8 Jun 2026 10:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780906184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOuWw5zJSAOOpOmtdIvLZaWS19YRfrULzJn6l3M9yE4=;
 b=YclgTYplOiUBTcpnf1oDTaRnEa4wsdgvHP2v+pW/jb3/7rvsatz3aB7ZqLhndhsWbszaGL
 aHBuxIlAjK+G08iotRwB9mPUpycNNhu61rlWrXvSPw5iPSAwJm+wavqU6YDbTNIo2QFN0m
 t6XyGg4FvdsjQadAk8LNy48Vsr8kpAY=
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com
 [74.125.82.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-I2BAwK9IPmKWYYDiP9oXNQ-1; Mon, 08 Jun 2026 04:09:43 -0400
X-MC-Unique: I2BAwK9IPmKWYYDiP9oXNQ-1
X-Mimecast-MFC-AGG-ID: I2BAwK9IPmKWYYDiP9oXNQ_1780906182
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-137dd5100c7so805153c88.1
 for <dev@dpdk.org>; Mon, 08 Jun 2026 01:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780906182; x=1781510982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pOuWw5zJSAOOpOmtdIvLZaWS19YRfrULzJn6l3M9yE4=;
 b=gi6cR2BAiLVNARE7/DGu4dZNVp1Ax65TsdQ6JFXncxiwY8/kJucoTeH7b7Eyh6gVwJ
 7yEUfmWGPlI1VFvaC3PfoP1Abp4t1plo/t9x6o3OzgVb/pAczhROVYVOyuwk3yc9shYp
 38pfUGuFeZSIuotkyK/bKNVQ99Lc7b25zepX5Dfc/spQjx6pkYrhNZQYaTLWhCyUkIDr
 f2YoF0dKwNAuScxA5P31P5+IFDIts06+s6hWp0rbfRNTKX7ze6D1yeWcVLsGNQEFotyI
 UHHg7FiZ028fYnpn0s7MVuuh1FFBwMsKOAoEsKGRxUHcJ/3xS4OKqHQUHWzVxlBCPPnU
 5mVA==
X-Gm-Message-State: AOJu0Yw5CRXhFRPXlTf31j5w2e4g0AKwGQOu36fnKi+9A3coRq2HM7ip
 4sn5oSFFU+nSn7NXSRWiL6enOld8CbfhUBlk38IYRW112dHNr9qUkhUk8l33ccKU5LJgiw+NwN4
 3cC1O/wQl4LTx3U/rVKytps6+1QuX9+DFGXU8dcW2Jj2WWNhv1rNFJK5TRPZI4IP70bi3oIYHO1
 WvsGh+pzmES67E0b37lMk=
X-Gm-Gg: Acq92OFRZsJzqyHosAwapN5/lD0h89oTGIFN3cvp7FXLfSjwx9u1tdI7Jp12w6JxU4Q
 1K4sCp3Ps+7q+QG8Sv+jks7/UrYWZpagtANglJ/hWlPFerOv9IhgN1Uwmp6WH8rZX3BMprSKFxA
 Bd1ipw5z3juCP12z9dlFLraS0I0qRUVFsjvqtg0ecPq27IDe/V81bQTQzHX2lnPKftVUfvNFDNa
 CHO4zBEUjGBwtsYlFCpfi5rsoQinHcEiXjVAGDXRe/cZ18SSlW3u0TbNfWjuvQKFSssL+7Eanoz
X-Received: by 2002:a05:7022:fd05:b0:137:eac4:82ae with SMTP id
 a92af1059eb24-13806760af8mr6805278c88.37.1780906181934; 
 Mon, 08 Jun 2026 01:09:41 -0700 (PDT)
X-Received: by 2002:a05:7022:fd05:b0:137:eac4:82ae with SMTP id
 a92af1059eb24-13806760af8mr6805267c88.37.1780906181348; Mon, 08 Jun 2026
 01:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260604235723.1046607-1-pravin.bathija@dell.com>
 <CAO55csxM0wB4u4A8c9=C6epEs2dEt3DHxGc+C_EqQqG1aNUQew@mail.gmail.com>
In-Reply-To: <CAO55csxM0wB4u4A8c9=C6epEs2dEt3DHxGc+C_EqQqG1aNUQew@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Mon, 8 Jun 2026 10:09:29 +0200
X-Gm-Features: AVVi8CceiB2n_VSXbmF4rTON5GxAcuOqwDctcNL3hQjTpQGP0pPo6MD-1wPN_Pg
Message-ID: <CAO55csxK8VQVAvruqSKeF-b+KY1iXdyavLj0LCBPUM3modkmLw@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] Support add/remove memory region and get-max-slots
To: pravin.bathija@dell.com
Cc: dev@dpdk.org, fengchengwen@huawei.com, stephen@networkplumber.org, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wZ71GSRbscCjLISkm4DvAitX6iGuZE7vLtErGNrUgn0_1780906182
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

On Fri, Jun 5, 2026 at 3:14=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> On Fri, Jun 5, 2026 at 1:57=E2=80=AFAM <pravin.bathija@dell.com> wrote:
> >
> > From: Pravin M Bathija <pravin.bathija@dell.com>
> >
> > This is version v15 of the patchset and it incorporates the
> > recommendations made by Maxime Coquelin.
> >
> > Patch 4/5
> > - Changed VHOST_USER_REM_MEM_REG handler declaration from
> >   accepts_fd=3Dtrue to accepts_fd=3Dfalse, as the remove request does n=
ot
> >   expect FDs in ancillary data.
> > - Removed all close_msg_fds(ctx) calls from vhost_user_rem_mem_reg(), n=
o
> >   longer needed since the handler is declared as not accepting FDs.
> > - Removed validate_msg_fds(dev, ctx, 0) check from
> >   vhost_user_rem_mem_reg(), as FD validation is now handled generically
> >   by the framework.
> > - Added targeted IOTLB cache invalidation in vhost_user_rem_mem_reg()
> >   using vhost_user_iotlb_cache_remove() for the removed region's GPA
> >   range, instead of the nuclear iotlb_flush_all() used by set_mem_table=
.
> >
> > This implementation has been extensively tested by doing Read/Write I/O
> > from multiple instances of fio + libblkio (front-end) talking to
> > spdk/dpdk (back-end) based drives. Tested with qemu front-end talking t=
o
> > dpdk testpmd (back-end) performing add/removal of memory regions. Also
> > tested post-copy live migration after doing add_memory_region.
> >
> > Version Log:
> > Version v15 (Current version): Incorporate code review suggestions from
> > Maxime Coquelin as described above.
> >
> > Version v14: Incorporate code review suggestions from Stephen Hemminger
> > and Fengcheng Wen.
> > Changes from Fengcheng Wen review:
> > Patch 3/5
> > - Moved free_all_mem_regions() call sites in vhost_user_set_mem_table()
> >   from patch 4/5 to patch 3/5 so each commit compiles independently
> > Patch 4/5
> > - Renamed _dev_invalidate_vrings() to vhost_user_invalidate_vrings() to
> >   follow vhost naming convention
> > -  Added comment explaining *pdev propagation through
> >    translate_ring_addresses / numa_realloc()
> > - Reordered local variables in vhost_user_add_mem_reg() and
> >   vhost_user_rem_mem_reg() by descending line length
> > - Shortened overlap check variable names (current_region_guest_start/en=
d
> >   --> cur_start/end, proposed_region_guest_start/end -> new_start/end)
> > - Fixed DMA error path in vhost_user_add_mem_reg(): added
> >   free_new_region_no_dma label so async_dma_map_region(false) is not
> >   called when the map itself failed.
> > Changes from Stephen Hemminger review:
> > Patch 4/5
> > - vhost_user_add_mem_reg() now constructs a reply with the back-end's
> >   host mapping address in userspace_addr and returns
> >   RTE_VHOST_MSG_RESULT_REPLY per the vhost-user spec
> > - Added validate_msg_fds(dev, ctx, 0) in vhost_user_rem_mem_reg() to
> >   reject malformed messages with unexpected file descriptors
> > - Dropped unnecessary (uint64_t) cast in vhost_user_get_max_mem_slots()
> >
> > Version v13: Incorporate code review suggestions from Fengcheng Wen
> > Patch 2/5
> > Renamed VhostUserSingleMemReg to VhostUserMemRegMsg and memory_single
> > to memreg
> > Patches 3/5 and 4/5
> > Relocated function remove_guest_pages from patch 3/5 to 4/5
> >
> > Version v12: Incorporate code review suggestions from Maxime Coquelin
> > and ai-code-review.
> > Patch 3/5
> > Refactored async_dma_map() to delegate to async_dma_map_region(),
> > eliminating code duplication between the two functions.
> > Restored original comments in async_dma_map_region() explaining why
> > ENODEV and EINVAL errors are ignored (these were stripped in v10)
> > Reverted unnecessary changes to vhost_user_postcopy_register() --
> > removed the host_user_addr =3D=3D 0 checks and reg_msg_index indirectio=
n
> > that were added in  v10, since this function is only called from
> > vhost_user_set_mem_table() where regions are always contiguous.
> >
> > Version v11: Incorporate code review suggestions from Stephen Hemminger=
.
> > Patch 4/5
> > Fix incomplete cleanup in vhost_user_add_mem_reg() when
> > vhost_user_mmap_region() fails after the mmap succeeds (e.g.
> > add_guest_pages() realloc failure) realloc failure). The error path now
> > calls remove_guest_pages() and free_mem_region() to undo the mapping
> > and stale guest-page entries, preventing a leaked mmap and slot reuse
> > corruption. The plain close(fd) path is kept for pre-mmap failures.
> >
> > Version v10: Incorporate code review suggestions from Stephen Hemminger=
.
> > Patch 4/5
> > Moved dev_invalidate_vrings after free_mem_region, array compaction, an=
d
> > nregions decrement. This ensures translate_ring_addresses only sees
> > surviving memory regions, preventing vring pointers from resolving into
> > a region that is about to be unmapped.
> >
> > Version v9: Incorporate code review suggestions from Stephen Hemminger.
> > Patch 3/5
> > Restored max_guest_pages initial value to hardcoded 8 instead of
> > VHOST_MEMORY_MAX_NREGIONS, matching upstream semantics.
> > Patch 4/5
> > Added close(reg->fd) and reg->fd =3D -1 before goto close_msg_fds in th=
e
> > mmap failure path to fix fd leak after fd was moved from ctx->fds[0].
> > Converted dev_invalidate_vrings from a plain function to a macro +
> > implementation function pair, accepting message ID as a parameter so
> > the static_assert reports the correct handler at each call site.
> > Updated dev_invalidate_vrings call in add_mem_reg to pass
> > VHOST_USER_ADD_MEM_REG as message ID.
> > Updated dev_invalidate_vrings call in rem_mem_reg to pass
> > VHOST_USER_REM_MEM_REG as message ID.
> >
> > Version v8:  Incorporate code review suggestions from Stephen Hemminger=
.
> > rewrite async_dma_map_region function to iterate guest pages by host
> > address range matching
> > change function dev_invalidate_vrings to accept a double pointer to
> > propagate pointer updates
> > new function remove_guest_pages was added
> > add_mem_reg error path was narrowed to only clean up the single failed
> > region instead of destroting all existing regions
> >
> > Version v7: Incorporate code review suggestions from Maxime Coquelin.
> > Add debug messages to vhost_postcopy_register function.
> >
> > Version v6: Added the enablement of this feature as a final patch in
> > this patch-set and other code optimizations as suggested by Maxime
> > Coquelin.
> >
> > Version v5: removed the patch that increased the number of memory regio=
ns
> > from 8 to 128. This will be submitted as a separate feature at a later
> > point after incorporating additional optimizations. Also includes code
> > optimizations as suggested by Feng Cheng Wen.
> >
> > Version v4: code optimizations as suggested by Feng Cheng Wen.
> >
> > Version v3: code optimizations as suggested by Maxime Coquelin
> > and Thomas Monjalon.
> >
> > Version v2: code optimizations as suggested by Maxime Coquelin.
> >
> > Version v1: Initial patch set.
> >
> > Pravin M Bathija (5):
> >   vhost: add user to mailmap and define to vhost hdr
> >   vhost: header defines for add/rem mem region
> >   vhost: refactor memory helper functions
> >   vhost: add mem region add/remove handlers
> >   vhost: enable configure memory slots
> >
> >  .mailmap               |   1 +
> >  lib/vhost/rte_vhost.h  |   4 +
> >  lib/vhost/vhost_user.c | 425 +++++++++++++++++++++++++++++++++++------
> >  lib/vhost/vhost_user.h |  10 +
> >  4 files changed, 378 insertions(+), 62 deletions(-)
> >
> > --
> > 2.43.0
> >
>
> Applied to next-virtio/for-next-net.

Given a new version has been posted and Thomas did not pull it yet,
I dropped this series from my pull request.

>
> Thanks,
> Maxime

