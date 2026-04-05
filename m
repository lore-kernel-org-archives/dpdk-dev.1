Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B05CE9D828
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 23:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98C554026D;
	Mon,  6 Apr 2026 01:29:42 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 7460240265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 01:29:40 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso21802495ad.1
 for <dev@dpdk.org>; Sun, 05 Apr 2026 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775431779;
 x=1776036579; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QzU97w/o/OdGCEaJSEBWuGRVRF6PCyXGobMQAoPxfDo=;
 b=p00k4Yh6ytmSgfbQsnXhyYTnMwLp3py5nKGjNt6bFvSd5wnULVNAiPMkApgPPW7CpD
 yoW7iCwCUv97F+gDemRogYCf7/Zw/ltx+zXVoOPRQOlX3rJ0Ajl/kx2T4DzYV0hABgEo
 aYAZyyqE5iHDa7aKSb1jmH9XMbscqokomUPiUkrAFprwzOnxIcYWBkvFrGrpDOFht4nB
 5HdXdWhCKu24p58OASUJb3q5ihBZ61LLcEUJbgUvh5JN85pLYBb853bls5GviHv19F9l
 ul8zjeKMWcPsK8Ez7nrGgWToHgPhRaiqQCl0bavMmGdz1bHFsdvXgEjejBCc1gZm3/JH
 rjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775431779; x=1776036579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QzU97w/o/OdGCEaJSEBWuGRVRF6PCyXGobMQAoPxfDo=;
 b=J3HnCp6PxaxkNI/TrOb/osEu2IN4016PD98Lnraq/LJRLMRfM0OjZOLMQGJqKb7kh9
 sGbFtk5ghFoVgt+oP9idfcYLNaZ1a73vOAih9F5sXq0Kbwl1Luk9FDm50NPjwx9bU7Li
 P6slhO9F0gvJ2UZqD5Fs0Bt5HbUPr066yag6qlnFCfi8efGcbO8Qv2dIwSJ9ibJxxmNa
 71r16/pz1kuW0H004+C3i4tRDvhk4FQAsujy5CTZFmJbGR84jN4qGyQcy+YDcyQpaMll
 F3WwT+8t4m7tfL0A/XKmDY7Zb1JG2d7Suwec97MPxSIXHK+U0f7y1xsV7UvyF2SIkYki
 ZApQ==
X-Gm-Message-State: AOJu0Ywf825JgVaG8ZUilxza13CbOwrUjdVY1QOjYA81VAxQSh0T+Bf8
 sJBjofIdGVZYwS7PFjOfSV0/zt9l7o/SLQOK3EDj/V11tKYm+yYJWY5tCBvoxIiWp+I=
X-Gm-Gg: AeBDieuAFtgmWfXMyTNJoTcUR1YSowu72enYe0AIF5sm1WMXK3+hHl7Cma8XAzTWDzb
 P5/RCjDN9zkqoeDzw0KmC1O1SR7rtaqXBAc3i1OFsVeKryJhBUUjpcl3xjwpbyw1NJ8WmpCnpLM
 pr5QuwvIMfXXMPgXbSFlDfeyqdXeI1Y5pCzphnUWgmMIKS9SuzViQvwdO9dq8c46aSyXEhnO/3Y
 Gx1Khfs34WH2+eUMPdoJ4gsuTvwt2aKRMxe2Jr+nbwdEVrQXF9l2FWc6yKDnmeW4NvxRPg0NOID
 9IzknYVmUGNqdin9l0QLRSY7h02pOiuouAMJsXMokQh1tD9TDRN4wWrw2oCKFQdbB3y7I3ktF+o
 fce6mdCC2id3WRLrScT+Kp/AyTHHI/RwyB81Ck3biM0JFJ31fOV/Q35YSj3BepxRE3PrbUodQkH
 S9NxI4Nuld8z7k0HM3bVP0tJA/gto34a97CuwPT/FkmHC/JA==
X-Received: by 2002:a17:903:11d2:b0:2b2:98d7:bff with SMTP id
 d9443c01a7336-2b298d73f89mr44435245ad.45.1775431779381; 
 Sun, 05 Apr 2026 16:29:39 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749a440csm116458065ad.65.2026.04.05.16.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 16:29:39 -0700 (PDT)
Date: Sun, 5 Apr 2026 16:29:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pravin.bathija@dell.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: Re: [PATCH v8 0/5] Support add/remove memory region and get-max-slots
Message-ID: <20260405162931.4a75f28b@phoenix.local>
In-Reply-To: <20260403015434.3124102-1-pravin.bathija@dell.com>
References: <20260403015434.3124102-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 3 Apr 2026 01:54:29 +0000
<pravin.bathija@dell.com> wrote:

> From: Pravin M Bathija <pravin.bathija@dell.com>
>=20
> This is version v8 of the patchset and it incorporates the
> recommendations made by Stephen Hemminger.
> The async_dma_map_region function was rewritten to iterate guest pages
> by host address range matching rather than assuming contiguous array
> indices after sorting, and now returns an error code so that DMA mapping
> failures are treated as fatal during add_mem_reg. The
> dev_invalidate_vrings function was changed to accept a double pointer to
> propagate pointer updates from numa_realloc through
> translate_ring_addresses, preventing a user-after-free in both
> add_mem_reg and rem_mem_reg callers.
>=20
> A new remove_guest_pages function was added to clean up stale guest page
> entries when removing a region. The rem_mem_reg handler now compacts the
> regions array using memmove after removal, keeping it contiguous so that
> all existing nregions-based iteration in address translation functions
> like qva_to_vva and hva_togpa continues to work correctly. This
> compaction also eliminates the need for the guest_user_addr =3D=3D 0
> free-slot sentinel in add_mem_reg, which was problematic since guest
> virtual address zero is valid.
>=20
> The add_mem_reg error path was narrowed to only clean up the single
> failed region instead of destroying all existing regions. A missing
> ctx->fds[0] =3D -1 assignment was added after the fd handoff to prevent
> double-close on error paths. The overlap check was corrected to use
> region size instead of mmap_size, which included alignment padding and
> caused false positives. The rem_mem_reg handler registration was fixed
> to accept file descriptors as required by the vhost-user protocol, with
> proper fd cleanup added in all exit paths. Finally, the postcopy
> registration in add_mem_reg was changed to call
> vhost_user_postcopy_region_register directly for the single new region,
> avoiding the use of vhost_user_postcopy_register which reads the wrong
> payload union member, and a defensive guard was added to
> vhost_user_initialize_memory against double initialization.
>=20
> This implementation has been extensively tested by doing Read/Write I/O
> from multiple instances of fio + libblkio (front-end) talking to
> spdk/dpdk (back-end) based drives. Tested with qemu front-end talking to
> dpdk testpmd (back-end) performing add/removal of memory regions. Also
> tested post-copy live migration after doing add_memory_region.
>=20
> Version Log:
> Version v8 (Current version): Incorporate code review suggestions from
> Stephen Hemminger as described above.
> Version v7: Incorporate code review suggestions from Maxime Coquelin.
> Add debug messages to vhost_postcopy_register function.
> Version v6: Added the enablement of this feature as a final patch in
> this patch-set and other code optimizations as suggested by Maxime
> Coquelin.
> Version v5: removed the patch that increased the number of memory regions
> from 8 to 128. This will be submitted as a separate feature at a later
> point after incorporating additional optimizations. Also includes code
> optimizations as suggested by Feng Cheng Wen.
> Version v4: code optimizations as suggested by Feng Cheng Wen.
> Version v3: code optimizations as suggested by Maxime Coquelin
> and Thomas Monjalon.
> Version v2: code optimizations as suggested by Maxime Coquelin.
> Version v1: Initial patch set.
>=20
> Pravin M Bathija (5):
>   vhost: add user to mailmap and define to vhost hdr
>   vhost_user: header defines for add/rem mem region
>   vhost_user: support function defines for back-end
>   vhost_user: Function defs for add/rem mem regions
>   vhost_user: enable configure memory slots
>=20
>  .mailmap               |   1 +
>  lib/vhost/rte_vhost.h  |   4 +
>  lib/vhost/vhost_user.c | 392 ++++++++++++++++++++++++++++++++++++-----
>  lib/vhost/vhost_user.h |  10 ++
>  4 files changed, 364 insertions(+), 43 deletions(-)
>=20

AI still finds a number of issues.

Patches 1/5, 2/5, and 5/5 look fine.

In patch 4/5, there is an fd leak in vhost_user_add_mem_reg() when
vhost_user_mmap_region() fails. The fd has already been moved from
ctx->fds[0] into reg->fd (and ctx->fds[0] set to -1) before the
mmap call. On failure the goto lands at close_msg_fds which only
closes ctx->fds[] (all -1 at that point). The fd in reg->fd is
never closed because free_mem_region() is not reached (it guards
on reg->mmap_addr which mmap never set). Suggest adding
close(reg->fd) before the goto, or introducing a cleanup label.

Also in patch 4/5, dev_invalidate_vrings() hardcodes
VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_ADD_MEM_REG) but is
called from both add_mem_reg and rem_mem_reg. The static_assert
passes because both handlers set lock_all_qps =3D true, but the
debug assertion message will report the wrong message ID on the
remove path. Consider passing the message ID as a parameter.

Minor: in patch 3/5, vhost_user_initialize_memory() uses
VHOST_MEMORY_MAX_NREGIONS as max_guest_pages. Upstream uses a
hardcoded 8 for this. The two values happen to be equal today
but have different semantics =E2=80=94 max_guest_pages is about hugepage
tracking granularity, not region count.
