Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A11061B21
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 03:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DB39402E9;
	Tue, 31 Mar 2026 05:16:00 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 8F0124025E
 for <dev@dpdk.org>; Tue, 31 Mar 2026 05:15:59 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2c7e5f38b37so510870eec.0
 for <dev@dpdk.org>; Mon, 30 Mar 2026 20:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774926958;
 x=1775531758; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfsLZAc7Yz8D5Q7XAnhDH2QOzrRT8uNTxas2JFUlw0E=;
 b=NdmL5odXv1jYlAa13fjHW1nf2E6mGdTb2N/ksiht1llIcqi0AfalY6nEhSCFDULL3d
 069CuphzYkmjg2wC7yi0oqjoCeYX8Xq3VzKEfxuN6IEXy8/dXfZwAjbn60N0hOp88SCI
 gp8O+32v5YnqXb56MZIJVsCdWQ2puCULWQtTVe1hvdUQDts1fEMcMcyZT/NRGcNqFLGd
 tY0rK5jYfrbYyBblSCH2EI7kIg5XfRf6gzGaJlXJjGnKPP7ppo0jzFXCSuF8HWdEA77Q
 1AKWnVG6lbMp9QVlQhLgYCK7kDYk5kGlD21kiAGXgjJcxrtNJvXNJEYuUPouSrbpIrep
 k5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774926958; x=1775531758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nfsLZAc7Yz8D5Q7XAnhDH2QOzrRT8uNTxas2JFUlw0E=;
 b=Ytum5AOAx04ag1WI65hmB40l66xQJr6bKPX3c5TtFcG+T4LW6ahL9NdZCRzgTHBf5l
 e9L2QuvD0kYuWHjxTnuROGkP9KIrDhIk7MKruDcr7DzaMjDLCSy8lVz9lG9gjgCR8bhv
 I7PoyMEbKMu3xqKMXfu+TVXmIx0CsFfIBzeQvoaJo5O24ubr+NsYqDzmIKkHOMpbSEj2
 UC9sgHF2lOW/D84mCccfB0heqcw2K+bRrPKDl1faijFC0DwpDtVjPJiPK6/5qQXbcbpn
 y3Ll6XCENwF0eBu3PVKuv/Kh1lSEHje0ARXfC05RSNIoNvMtzMC8A58w3EarwwLY6NHA
 WY2g==
X-Gm-Message-State: AOJu0Yx0I6M9+dna6yAlA5akzofGLr0nLncLO/7RIVPu0RfmfNl96I0h
 p+5MjT1ppMpGaU36K1av9ESuo3A05TzX05CItx2aKmOokuE/aLQ/Wjv9SVXM4MXVSL8=
X-Gm-Gg: ATEYQzwYtMUV03etTV4c+ySzJcu/TI0IJymvwzXqQWxqHmbVSZdPtp0Hdu9tnZ1nHZf
 Enc0V7uo1SOV9DENnxBzLAVfa6TUdtOJRbeZDpB72yQQ/8WUrBBg/r0HrW3YOlk01YlTEjdUBkc
 hsFZd8sj5pXFoTUI7dMrnIhGE8pAAWe5nXRAZdH2fvoiCn4Voe+i0ClIbFLLraWpN3WCWCC0TLj
 7bZMhXunvCVMdvP94stGY/9PTJMpntuLc2gAZbtDUgJNditr8wo24uBsZKenQ5PWfGFpRY4dcLO
 tkAFKE1oxbjYEzUacn/fFmZOYahmvZgO4FjOFg435aIRJVeFKz2yJK7zL3AMjOVYRy2hD49d/+M
 tLxWhI0TgHFi3pQmnULU1QDB63Fjcc2/jbSF5VWKojIIUkZNRQuHMWCotGC2mNIpdnz6V7eLUqD
 exuTuwRlekMJxZN8aBw3jr8aeo02UIC3/2I+0=
X-Received: by 2002:a05:7301:1692:b0:2c8:1d56:3410 with SMTP id
 5a478bee46e88-2c81d5642e8mr394160eec.18.1774926958253; 
 Mon, 30 Mar 2026 20:15:58 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c6e9c088sm8744106eec.21.2026.03.30.20.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 20:15:58 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:15:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Cliff Burdick <cburdick@nvidia.com>
Cc: <dev@dpdk.org>, <anatoly.burakov@intel.com>
Subject: Re: [PATCH v4 0/2] support dmabuf
Message-ID: <20260330201554.5c1ad08e@phoenix.local>
In-Reply-To: <20260204155206.2345189-1-cburdick@nvidia.com>
References: <20260203230338.1066297-1-cburdick@nvidia.com>
 <20260204155206.2345189-1-cburdick@nvidia.com>
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

On Wed, 4 Feb 2026 15:50:07 +0000
Cliff Burdick <cburdick@nvidia.com> wrote:

> Fixes since v3:
> * Fixed version in RTE_EXPORT_EXPERIMENTAL_SYMBOL
> 
> Add support for kernel dmabuf feature and integrate it in the mlx5 driver.
> This feature is needed to support GPUDirect on newer kernels.
> 
> I apologize for all the patches. Still trying to learn how to submit these.
> 
> Cliff Burdick (2):
>   eal: support dmabuf
>   common/mlx5: support dmabuf
> 
>  .mailmap                                      |   1 +
>  doc/guides/rel_notes/release_26_03.rst        |   6 +
>  drivers/common/mlx5/linux/meson.build         |   2 +
>  drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 ++++-
>  drivers/common/mlx5/linux/mlx5_glue.c         |  19 ++
>  drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
>  drivers/common/mlx5/mlx5_common.c             |  42 ++++-
>  drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++-
>  drivers/common/mlx5/mlx5_common_mr.h          |  17 +-
>  drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
>  drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
>  drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
>  lib/eal/common/eal_common_memory.c            | 165 +++++++++++++++++-
>  lib/eal/common/eal_memalloc.h                 |  21 +++
>  lib/eal/common/malloc_heap.c                  |  27 +++
>  lib/eal/common/malloc_heap.h                  |   5 +
>  lib/eal/include/rte_memory.h                  | 145 +++++++++++++++
>  17 files changed, 612 insertions(+), 14 deletions(-)
> 

I don't think anyone look at the details here.
If they did they would see the same thing as what AI did.


Review: [PATCH v4 1/2] eal: support dmabuf
        [PATCH v4 2/2] common/mlx5: support dmabuf

Good approach using a side-table to avoid ABI changes to
rte_memseg_list. The dmabuf support for mlx5 is well-structured
with proper compile-time gating via HAVE_IBV_REG_DMABUF_MR.

Patch 1/2 - eal: support dmabuf

Error: rte_extmem_register is broken by rte_extmem_register_dmabuf.

rte_extmem_register now calls rte_extmem_register_dmabuf with
fd=-1. But rte_extmem_register_dmabuf rejects dmabuf_fd < 0:

  int
  rte_extmem_register_dmabuf(void *va_addr, size_t len,
      int dmabuf_fd, uint64_t dmabuf_offset,
      rte_iova_t iova_addrs[], unsigned int n_pages, size_t page_sz)
  {
      if (dmabuf_fd < 0) {
          rte_errno = EINVAL;
          return -1;
      }
      ...

So every call to rte_extmem_register will now fail with EINVAL.
rte_extmem_register should call extmem_register directly (with
fd=-1), not rte_extmem_register_dmabuf:

  int
  rte_extmem_register(void *va_addr, size_t len, rte_iova_t iova_addrs[],
      unsigned int n_pages, size_t page_sz)
  {
      return extmem_register(va_addr, len, -1, 0, iova_addrs,
          n_pages, page_sz);
  }

Error: Input validation from rte_extmem_register is lost.

The original rte_extmem_register validated va_addr, page_sz, len,
alignment, and n_pages before doing anything. The new
extmem_register function has no input validation -- it only has
the locking and memseg creation logic. The parameter checks that
were in the original function (va_addr == NULL, page_sz == 0,
len == 0, power-of-2, alignment) need to be in extmem_register
or duplicated in both rte_extmem_register and
rte_extmem_register_dmabuf.

Error: eal_memseg_list_init uses type_msl_idx to index dmabuf_info
but this is not the same as the memseg list index in mcfg->memsegs.

eal_memseg_list_init initializes dmabuf_info[type_msl_idx], but
type_msl_idx is a per-type index used for naming, not the global
memseg list position. When malloc_heap_create_external_seg_dmabuf
later sets dmabuf_info[msl_idx] where msl_idx = msl - mcfg->memsegs,
these are different index spaces. The init in eal_memseg_list_init
may write to wrong slots, and external segments may use indices
that were never initialized by eal_memseg_list_init. The static
dmabuf_info array is zero-initialized at program start (fd=0,
offset=0), but fd=0 is a valid file descriptor (stdin), so fd
should be initialized to -1 for all entries, or the
eal_memseg_list_init initialization should be removed and
initialization done only in malloc_heap_create_external_seg and
malloc_heap_create_external_seg_dmabuf.

Warning: malloc_heap_create_external_seg now redundantly
initializes dmabuf_info.

malloc_heap_create_external_seg calls
eal_memseg_list_set_dmabuf_info(i, -1, 0) at the end, but
malloc_heap_create_external_seg_dmabuf also calls
malloc_heap_create_external_seg (which sets fd=-1) and then
immediately overwrites with the actual fd. This works but is
confusing -- the redundant initialization in the base function
was added for non-dmabuf paths but makes the dmabuf path do a
useless set-then-overwrite.

Warning: dmabuf_info is process-local static storage.

The side-table approach means dmabuf metadata is not shared with
secondary processes via shared memory. The commit message mentions
rte_extmem_attach for cross-process use, but secondary processes
will not have the dmabuf_info populated. If a secondary process
calls rte_memseg_list_get_dmabuf_fd, it will always get -1. This
limitation should be documented in the Doxygen for
rte_extmem_register_dmabuf.

Warning: dmabuf fd lifetime / ownership is not documented.

The API does not specify whether DPDK takes ownership of the
dmabuf_fd (will it close it?) or whether the caller must keep it
open. Since ibv_reg_dmabuf_mr likely holds a reference through
the kernel, the fd can probably be closed after registration,
but this should be explicitly documented in the Doxygen. Also,
rte_extmem_unregister does not clean up the dmabuf_info entry
(reset fd to -1), so stale metadata remains after unregistration.

Warning: the public API functions in eal_memalloc.h have the same
names as the public API functions in rte_memory.h but different
signatures.

eal_memalloc.h declares:
  int eal_memseg_list_get_dmabuf_fd(int list_idx);
  int eal_memseg_list_get_dmabuf_offset(int list_idx, uint64_t *offset);

rte_memory.h declares:
  int rte_memseg_list_get_dmabuf_fd(const struct rte_memseg_list *msl);
  int rte_memseg_list_get_dmabuf_offset(const struct rte_memseg_list *msl, ...);

These are distinct functions, but the eal_memalloc.h header claims
to declare:
  "Get dma-buf fd for a memseg list."
  "Get dma-buf offset for a memseg list."
...with names prefixed eal_ vs rte_. This is fine functionally but
the internal and public function signatures should use the same
error convention. The internal eal_memseg_list_get_dmabuf_fd
returns -EINVAL on error, while the public
rte_memseg_list_get_dmabuf_fd_unsafe returns -1 with rte_errno.
The public function does not call the internal function at all --
it accesses dmabuf_info directly. The internal functions in
eal_memalloc.h appear unused.

Patch 2/2 - common/mlx5: support dmabuf

Warning: mlx5_os_set_reg_mr_cb signature change is an internal
ABI break.

The function signature changes from 2 to 3 parameters. This is
an internal symbol so it's not a public ABI break, but all
callers must be updated atomically. The Windows and Linux
implementations are both updated, and the crypto caller is
updated, so this appears complete. Verify no other callers exist
outside this patch.

Warning: duplicate dmabuf detection logic in mlx5_common.c and
mlx5_common_mr.c.

The pattern of checking msl->external, getting dmabuf_fd, getting
dmabuf_offset, and calculating the adjusted offset is repeated
nearly identically in mlx5_common_dev_dma_map and
mlx5_mr_mempool_register_primary. This should be factored into a
helper function to avoid the code duplication and ensure consistent
behavior.

Info: mlx5_common_verbs_reg_dmabuf_mr passes addr as iova.

The call is:
  reg_dmabuf_mr_cb(pd, dmabuf_offset, len, addr, dmabuf_fd, ...)

where addr is the user-space virtual address. For ibv_reg_dmabuf_mr,
the iova parameter is the "IO virtual address the device will use
to access the region." Using the user-space VA as iova means the
MR maps virtual addresses 1:1. This is the common pattern for
DPDK but worth noting that it won't work if the device expects
different IO addresses.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
