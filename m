Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA77CA5FED
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 08:40:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3D2E4026D;
	Fri,  9 Oct 2026 10:40:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CEB124021E
 for <dev@dpdk.org>; Fri,  9 Oct 2026 10:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791535201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8OcdWbcU35HwkdgZom1ue1pQqYDa770FhX+TE0QsNM=;
 b=bg3xqDiWmkMbQTq/nzzihqzt+Em4hxJ7KQVJNDX/MazakDFf2ZDxMcLTkzOD1u7W/TqurI
 KUd/toN94i++HKaty3f+mLsNOOrc8ZAszWdyoJFTY2LXOTQn2WinzbkflLLcpzlzT9veMV
 J0t6N9U+/csxVFnqR041njDtPOQbquk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-nQXMT_TEOP2SGmCdaDHZTA-1; Fri, 9 Oct 2026 08:39:58 +0000
X-MC-Unique: nQXMT_TEOP2SGmCdaDHZTA-1
X-Mimecast-MFC-AGG-ID: nQXMT_TEOP2SGmCdaDHZTA_1791535197
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a59ac42cd8so31377101fa.0
 for <dev@dpdk.org>; Fri, 09 Oct 2026 01:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791535197; x=1792139997;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s8OcdWbcU35HwkdgZom1ue1pQqYDa770FhX+TE0QsNM=;
 b=FW5COaUCJ0j2M5KdIt+B/hY61BQrihN+I2V1ABps9frq57aVGBNJVznBJGMSSaRvxO
 Wr4yAllEcQdcp0S7ajQUwu06HXLgXDqdI3UEZ4NXa3mYy9e1hz7r5/awytKNg6tdrXc8
 PzyTNU022yyxGH8QjYwGVw6qTqDU+WWeYAlku9FM5/9MejNxHaOouXbSIdvhs3ks+J3m
 RIfWRwKEpA6zp3xLh32cnGjDma0K82d8nP9u4mI/DWzBFarNkhAgCi/ZYthJ9+64oXfV
 e5YxZTTMwa9HyZq9RUJtw3FFSyIPblkVvX7ZDJndMFpIrN7FhrSurk/cWPUHD2jO85Eh
 6Dxg==
X-Gm-Message-State: AFq9FYL7UDWs3szzUc6xay2hapqyHCavOgT0l+hoRKE2qpVi/A5oJbqI
 owmu6RlIB7mxFyIf1h90PZEMgEXxBmQ/rq5hiSdhTC09gNz8sk+VcygJgcrtYTNKmygxeRor54u
 nq5kswJg4i1utyD5Xt5U21rEvxmoGueAGbu1IxleEeoVn4CEQ01pRhpIgoTe3FjksbMrkwkjZIH
 uT4/Qqix5kZabfDY8jkxU=
X-Gm-Gg: AYBFou39ogOywbNqTccGXcU9hYnZ81J4P+Q+SBju5ddccCQqR8NY7eMujpWeQXJ3JVH
 f4zt4Z7mb7oKMbTf/6tCBseDosAcXKUgiuN+568YLzQhrKlT3h1vzcdA6SfUBHTICJZ+3xvvdkF
 UJTC2wvwZhkOBneiIkQ+7mzQ3fxjcR6liwC8e8YjLGSIJHrbQ1mbv77wpOfGdfYnds1Kw/Q3aT3
 lNirVIREBGVUN2/+lqnE9mxx0xrmTbRGRS7fye/MrxcK19J
X-Received: by 2002:a05:6512:3086:b0:5ba:3ce3:815 with SMTP id
 2adb3069b0e04-5bcde8d7b53mr438029e87.62.1791535196983; 
 Fri, 09 Oct 2026 01:39:56 -0700 (PDT)
X-Received: by 2002:a05:6512:3086:b0:5ba:3ce3:815 with SMTP id
 2adb3069b0e04-5bcde8d7b53mr438018e87.62.1791535196392; Fri, 09 Oct 2026
 01:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
In-Reply-To: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 9 Oct 2026 10:39:42 +0200
X-Gm-Features: AclHuK9lVtbbxt4_AoIxqAZEi2IuKYBNR-mscCGy1Zkcd0PJ0u1SLtBkfikRSTM
Message-ID: <CAJFAV8xK6GxW8WQcSHYYJ6zv7J5xg=do3aYaTv-ZmjEmvQOOeA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] dma/ae4dma: add AMD AE4DMA DMA PMD
To: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com, bruce.richardson@intel.com, 
 selwin.sebastian@amd.com, bhagyada.modali@amd.com, rjarry@redhat.com, 
 thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0WKrqIFzWaMQnJGlex8dEoDP_ohhrHj9Ta7kQiCZ9rE_1791535197
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

Hello,

On Fri, 10 Jul 2026 at 09:36, Raghavendra Ningoji
<raghavendra.ningoji@amd.com> wrote:
>
> This series adds a new dmadev poll-mode driver for the AMD AE4DMA
> hardware DMA engine, split into introduction, control path and data
> path patches, plus a small dmadev test-suite patch.
>
> v5 addresses the v4 review comments from Chengwen Feng.
>
> Changes since v4:
>
> Patch 1/4 (introduce):
>  - Drop the custom AE4DMA_BIT() macro and use RTE_BIT32() from
>    rte_bitops.h for the DWORD0 control-bit and memory-type defines.
>  - Remove the now-unused per-queue status[] array from
>    struct ae4dma_cmd_queue (completion status is derived directly from
>    the descriptors in patch 3).
>
> Patch 3/4 (data path):
>  - Fix rte_dma_completed(): stop at the first failed descriptor and
>    return only the run of successful ops preceding it, set *has_error,
>    and leave the failed op to be reported by rte_dma_completed_status().
>    last_idx now reports the last successfully completed ring_idx.
>  - Drop the redundant 'if (last_idx != NULL)' check; the framework
>    always passes a non-NULL last_idx.
>
> Patch 4/4 (test):
>  - Unchanged; retains TEST_SKIPPED for sub-32 burst capacity.
>
> Changes since v3 (carried over, for reference):
>
> Patch 1/4 (introduce):
>  - Fix copyright years (2025/2024 -> 2026) in ae4dma.rst and meson.build.
>  - Drop the unnecessary memzone lookup/reuse logic; rings are reserved
>    once at probe.
>  - Trim ae4dma_hw_defs.h includes; move the rest to ae4dma_internal.h.
>  - Remove redundant double blank lines in ae4dma_internal.h.
>  - Use an initialiser instead of memset() for hwq_dev_name and reorder
>    local declarations in descending length.
>  - Make the probe-failure log message more descriptive.
>  - Build only on Linux (add the is_linux guard to meson.build).
>  - Add a hw_base field to anchor the free-running ring index.
>
> Patch 2/4 (control path):
>  - Advertise RTE_DMA_CAPA_OPS_COPY in dev_info_get.
>  - Use 'conf_sz < sizeof(...)' instead of '!=' to stay ABI compatible.
>  - Drop checks already performed by the dmadev framework.
>  - Reset the free-running ring indices in vchan_setup and dev_start,
>    anchoring index 0 to the current HW consumer slot (hw_base).
>  - Reword the commit log for the 2 to 32 descriptor range.
>
> Patch 3/4 (data path):
>  - Return free-running 16-bit ring_idx values from rte_dma_copy() and
>    completed()/completed_status(); HW slot = (hw_base + idx) & mask.
>  - Map the AE4DMA alignment error to RTE_DMA_STATUS_ERROR_UNKNOWN.
>  - Drop the redundant power-of-two/range check in burst_capacity().
>  - Document the 32-descriptor / 31-outstanding ring-depth limitation.
>
> Patch 4/4 (test) - added in v4:
>  - Return TEST_SKIPPED instead of failing the instance suite when a
>    device reports burst capacity below 32, matching the existing < 64
>    skip used by the burst_capacity test.
>
> Note: the power-of-two rounding of nb_desc in vchan_setup is retained
> on purpose: the free-running ring index is mapped to a HW ring slot by
> masking, which is only correct for a power-of-two depth.
>
> Raghavendra Ningoji (4):
>   dma/ae4dma: introduce AMD AE4DMA DMA PMD
>   dma/ae4dma: add control path operations
>   dma/ae4dma: add data path operations
>   test/dma: skip instance suite on low burst capacity
>
>  .mailmap                               |   1 +
>  MAINTAINERS                            |   5 +
>  app/test/test_dmadev.c                 |   8 +-
>  doc/guides/dmadevs/ae4dma.rst          |  77 +++
>  doc/guides/dmadevs/index.rst           |   1 +
>  doc/guides/rel_notes/release_26_07.rst |   7 +
>  drivers/dma/ae4dma/ae4dma_dmadev.c     | 677 +++++++++++++++++++++++++
>  drivers/dma/ae4dma/ae4dma_hw_defs.h    | 149 ++++++
>  drivers/dma/ae4dma/ae4dma_internal.h   | 113 +++++
>  drivers/dma/ae4dma/meson.build         |  13 +
>  drivers/dma/meson.build                |   1 +
>  usertools/dpdk-devbind.py              |   5 +-
>  12 files changed, 1054 insertions(+), 3 deletions(-)
>  create mode 100644 doc/guides/dmadevs/ae4dma.rst
>  create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
>  create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
>  create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
>  create mode 100644 drivers/dma/ae4dma/meson.build

Rebased on top of v26.11-rc0, and recent cleanup:
https://patchwork.dpdk.org/project/dpdk/patch/20261008144313.2000554-1-david.marchand@redhat.com/
I fixed a few coding style issues.

Series applied.
Thanks to Chengwen Feng for the reviews.



AI reported a few (minor) issues, please have a look and send followup
patches if those issues are confirmed.

. **HW queue enabled but base address programmed afterward**

   In `ae4dma_add_queue()`:
   ```c
   AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
AE4DMA_CMD_QUEUE_ENABLE);
   ...
   AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo, dma_addr_lo);
   AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_hi, dma_addr_hi);
   ```

   The queue is enabled before the base address is programmed. If the
hardware starts processing before the base address is set, it could
read from an undefined location. The queue should be enabled **after**
programming the base address.

. **`qbase_desc` cast drops const qualifier**

   In `ae4dma_add_queue()`:
   ```c
   cmd_q->qbase_desc = q_mz->addr;
   ```

   `q_mz->addr` is `void *` (mutable), but this is aliased with
`qbase_addr` pointing to the same location. The descriptor ring should
be zero-initialized before use if the hardware expects valid initial
descriptor state.

. **Typo: MEMEORY**

   ```c
   #define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE  RTE_GENMASK64(7, 6)
   #define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    (0x0)
   #define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  RTE_BIT32(6)
   ```

   "MEMEORY" should be "MEMORY".

. **`RTE_GENMASK64` used for 8-bit masks**

   ```c
   #define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE  RTE_GENMASK64(5, 4)
   #define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE      RTE_GENMASK64(7, 6)
   ```

   These masks are for bits 4-5 and 6-7 of an 8-bit field.
`RTE_GENMASK32` would be more appropriate for 32-bit register fields.

. **Potential NULL pointer dereference in `ae4dma_dev_start()`** (lines 82-93)

   The function dereferences `cmd_q->hwq_regs` without checking if it
is NULL. While `ae4dma_dev_stop()` and `ae4dma_vchan_status()`
correctly check `cmd_q->hwq_regs != NULL` before dereferencing,
`ae4dma_dev_start()` does not. If `dev_start()` is called before the
queue is properly initialized via `ae4dma_add_queue()`, this will
cause a crash.

   ```c
   static int
   ae4dma_dev_start(struct rte_dma_dev *dev)
   {
       ...
       /* No NULL check before these dereferences */
       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
       AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
AE4DMA_CMD_QUEUE_ENABLE);
       ...
       hw_pos = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx)
& (nb - 1));
   ```

   **Suggested fix**: Add a NULL check at the start of `ae4dma_dev_start()`:
   ```c
   if (cmd_q->hwq_regs == NULL)
       return -EINVAL;
   ```

. **Mismatched brace placement in `ae4dma_dev_dump()`**

   The output includes `fprintf(f, "  }\n");` that doesn't have a
corresponding opening brace in the output, creating confusing debug
output.



-- 
David Marchand

