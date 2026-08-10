Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E7C5AD55
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Aug 2026 15:38:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 663E640272;
	Mon, 10 Aug 2026 17:38:04 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 386DC40144
 for <dev@dpdk.org>; Mon, 10 Aug 2026 17:38:03 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so17033305ad.3
 for <dev@dpdk.org>; Mon, 10 Aug 2026 08:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786376282;
 x=1786981082; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MqNsuF5P701wc83CqeMDHi6i2wWNPfGdg3IWE0ke11I=;
 b=c4QlqaO6tVJE/MNf97gyucP+pxkb9sDrqGwwRlxCMO8eOb9aUrO4w7LjwyQDMjRVhN
 zPs5vf8uc5Ub/HkqkJCfXf16k0/r/R8VgZW75w5jb+rtCJQzSKF113oHIvp5710V6Sx5
 YgKqJcPjmFTzk7/UXMCRPvLJCMjvBUiyElO3+w/yMliM3+r16C6K7Lojxfv9SLdwd3mh
 oBw+VdABVpfQY6DeGP3FOtkGBtf0nVM/FeMWrekZh9uWFCKYe6Ls8NkOWTxlvrSRV/j5
 iQ0KxeVG5f8wAt8jnKaBU6qI+b/zYcLqw33PgVZ4daEFu8EJZQTzXCBl1Xen4QbHvtmd
 hs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376282; x=1786981082;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MqNsuF5P701wc83CqeMDHi6i2wWNPfGdg3IWE0ke11I=;
 b=dQ0HPm4rPLMC3V7gMQV2FWyDJNtKBUD2H3ibYR2O9M5UkcVdQT6z873COGmu90goEm
 ErtUOrnXiwVe2dAajYMMlx5biKt35mKxXQKomiSBBiB2ZnoQN0VIHSGHH6UPFim5jpP6
 FSpmjYM20sfsNz1ku1Usu8ZgYIEG/soYsO7FxUBzAFJ+2nyG2Wth8dMiUOTeV3ST5sxN
 BrlbRaZqGlskw0k855ajXw2Uq8ISrWCF+o9/7ZN2nOZXNz5j42S+K5cSA3Si4475yepk
 7ayNg9FwEu+FP9caDBmVnkE1S5X2aGOvOPKoJDmSGq6KKYxXAQ3vMSjFm+O5pXnh5sMj
 kVOg==
X-Gm-Message-State: AOJu0YwgsVFv1lxxxWsfxF5eahj0fJ/leIRm/+D/e/Q4blkebnq88w3m
 tJx/4oB7gBsz0qfJUVvoAEGU2Tm7Cs426LoM63aq6VPrxx0AEuGPm9KvnClz+qb03Rg=
X-Gm-Gg: AR+sD126MJHIGNAT4GKQgt2ziaeqTaOw8bctjDEt3hnxgVaXjq6Z2pe9uoaZd8htYC3
 FWFocoBwKcAVrqDWJ51xeqTWmtozI2zyVbWjc/miNoOXskxjE4h02x61eP453wmjIZfEHn/LVGm
 GgeeIiA4iP4ki7dOV/c+Fx23nUMW9e8tgEVLY8bgxzTMxrDVYFH4J+aivwINxLLfoovBxAWsVg/
 qc4rc6jFOQX8hIyrukPctjuRn2sK32W8PpisxX15mWjlyMHNmO8KD9WZ7oDi/a79sLPZLJDFBMe
 D225/geT/scuyzDpW58SOZG20jA50SD9fB8uofvjLQjwh6H92WgA0UYOEqpdPaR3T/w8YHo3e0L
 iyHMm6jFaeqpV7xzTerDQEoDobi/qSwkKDzDh/9bl5nPdDFRzDkIWfeTOmElKOEVAq1Lj0VjS2D
 tiNJKYhQCjFR20IuUNaG3gzPpKg2Gy7xu3pfl9pvIJ6zzdmwyuizkl1KY2dBmIq1J97gfLfROaP
 myCYr/J/tndynJ86DFcOhE1ySNmKg==
X-Received: by 2002:a17:903:1a83:b0:2ca:17e2:2acc with SMTP id
 d9443c01a7336-2d300586275mr31252395ad.21.1786376282181; 
 Mon, 10 Aug 2026 08:38:02 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm44730087eec.1.2026.08.10.08.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:38:01 -0700 (PDT)
Date: Mon, 10 Aug 2026 08:37:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v2 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Message-ID: <20260810083758.1d3edb05@phoenix.local>
In-Reply-To: <20260807064853.1138187-1-g.singh@nxp.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
 <20260807064853.1138187-1-g.singh@nxp.com>
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

On Fri,  7 Aug 2026 12:18:48 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V2-changes:
>  - Added dependent patch: bus/platform: match device by devicetree compat=
ible string
>  - Fixed multiple AI reported issues includes:
>    - removed the alias from the driver, no need of it
>    - removed imx_edma5_write32 from data-path, reported as coherency
>      concern.
>    - fix submit for previously enqueued jobs.
>    - Added dsb in data path
>    - Added a commnet for rte_mem_iova2virt() NULL behaviour.
>    - Fixed: TCD NBYTES bits 31:30 are SMLOE/DMLOE =E2=80=94 full 32-bit l=
ength corrupts them
>    - Data path is fully synchronous: Acknowledged but intentionally defer=
red =E2=80=94
>      the synchronous design is a deliberate simplification for the initia=
l upstream submission.
>      Noted in docs.
>    - In-memory TCD64 pool is more complex than needed:
>      Noted/deferred =E2=80=94 the pool structure was retained for forward=
 compatibility
>      with hardware SG chaining.
>    - Extended `imx_edma5_dump()` to read and print `CH_CSR` and `CH_ES` r=
egisters
>      for every configured vchan.
>    - Double and stary lines removed.
>=20
> V1:
> This patch series adds a new dmadev Poll-Mode Driver (PMD) for the NXP
> i.MX95 eDMA5 (Enhanced DMA Type 5) controller.
>=20
> Key features supported by this driver:
>   - Memory-to-memory copy (RTE_DMA_OP_TYPE_MEMCPY)
>   - Scatter-gather memory copy (RTE_DMA_OP_TYPE_SG)
>   - 64-bit TCD (Transfer Control Descriptor) format
>   - Non-coherent DMA with explicit cache clean/invalidate
>   - Per-channel statistics and register dump for debug
>=20
> Patch breakdown:
>   [1/4] Skeleton: bus probe/remove, dmadev registration, MAINTAINERS,
>         doc index, and release notes for 26.11.
>   [2/4] Device configuration: vchan setup, TCD ring allocation,
>         start/stop, and capability reporting.
>   [3/4] Data path: enqueue (copy and sg), doorbell, completion poll.
>   [4/4] Statistics and dump: per-channel counters and register dump.
>=20
> Tested on NXP i.MX95 EVK with vfio-platform.
>=20
> Gagandeep Singh (5):
>   bus/platform: match device by devicetree compatible string
>   dma/imx_edma5: introduce eDMA5 dmadev skeleton
>   dma/imx_edma5: add device configuration
>   dma/imx_edma5: add data path
>   dma/imx_edma5: add statistics and dump
>=20
>  MAINTAINERS                                |    5 +
>  doc/guides/dmadevs/imx_edma5.rst           |   61 +
>  doc/guides/dmadevs/index.rst               |    1 +
>  doc/guides/rel_notes/release_26_11.rst     |    6 +
>  drivers/bus/platform/bus_platform_driver.h |    3 +-
>  drivers/bus/platform/platform.c            |   67 +-
>  drivers/dma/imx_edma5/imx_edma5_dmadev.c   | 1162 ++++++++++++++++++++
>  drivers/dma/imx_edma5/imx_edma5_dmadev.h   |  220 ++++
>  drivers/dma/imx_edma5/imx_edma5_hw.h       |  157 +++
>  drivers/dma/imx_edma5/imx_edma5_logs.h     |   16 +
>  drivers/dma/imx_edma5/meson.build          |   10 +
>  drivers/dma/meson.build                    |    1 +
>  12 files changed, 1707 insertions(+), 2 deletions(-)
>  create mode 100644 doc/guides/dmadevs/imx_edma5.rst
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
>  create mode 100644 drivers/dma/imx_edma5/meson.build
>=20

More AI feedback on V2

Review of [PATCH v2 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver

Verification: each of the five commits builds independently with
-Dwerror=3Dtrue on x86_64 and aarch64 cross (gcc), full build including
documentation is clean, check-git-log reports 5/5 valid. Confirmed by
disassembly that the new DSB sequences are emitted on aarch64.

Thanks for the v2. The bus matching, the SUBMIT-flag semantics, the missing
DSB, the coherency contradiction and the style nits are all resolved. The
NBYTES cap is applied to copy() but not to copy_sg(), and a few smaller
items remain.

Patch 1/5 (bus/platform: match by devicetree compatible):

Warning: The quote-stripping in of_device_is_compatible() is unnecessary
and should be dropped. Now that imx_edma5 sets .driver.alias directly in
the driver struct, no in-tree caller passes a quoted string, so the branch
is dead code. It exists to paper over RTE_PMD_REGISTER_ALIAS, which
stringifies its argument via RTE_STR and therefore cannot express a
compatible string containing a comma. Silently accepting a mangled alias
in the bus hides that defect from the next driver that hits it. Either
leave the macro alone and drop the quote handling, or fix the macro (e.g.
a variant that takes the string unmodified) and drop it as well.

Info: The last match block ends with "goto out;" immediately above the
"out:" label; the goto is redundant.

Info: The commit changes matching behaviour for every platform-bus driver
and has no release notes entry. There is currently one in-tree consumer,
so this is a judgement call, but a line under New Features would be
reasonable.

Patch 2/5 (skeleton):

Warning: The driver documentation does not match the code. Both the
Supported Features and Limitations sections describe scatter-gather as
requiring equal-length or equal-sized source and destination segment
pairs, but imx_edma5_copy_sg() walks the two lists as independent cursors
and correctly handles unequal segmentation, requiring only equal totals.
The doc understates the driver. Please update both sections.

Info: IMX_EDMA5_CH_MATTR_COHERENT (and the RCACHE/WCACHE/RDOMAINS/WDOMAINS
macros it is built from) is now unused after the CH_MATTR write was
dropped in patch 3/5. Remove the definitions or note why they are kept.

Patch 4/5 (data path):

Error: The IMX_EDMA5_MAX_NBYTES cap is enforced in imx_edma5_copy() but
not in imx_edma5_copy_sg(). Sub-transfer lengths there come from
RTE_MIN(s_rem, d_rem) over rte_dma_sge.length, which is uint32_t, so a
single segment larger than 1 GiB - 1 reaches imx_edma5_program_copy() and
writes a count with bit 30 or 31 set into TCD_NBYTES - exactly the
SMLOE/DMLOE corruption the copy() check was added to prevent. Validate
each segment length (or each computed sub-transfer length) against
IMX_EDMA5_MAX_NBYTES and return -EINVAL.

Warning: An enqueue call can now block for a very long time. Each
sub-transfer waits up to IMX_EDMA5_WAIT_TIMEOUT_MS (1000 ms), and
imx_edma5_run_job() serialises SG sub-transfers, so a job with the maximum
32 sub-transfers can spin for up to 32 seconds inside rte_dma_copy_sg()
with RTE_DMA_OP_FLAG_SUBMIT, or inside rte_dma_submit(). Consider a
per-job deadline rather than a per-sub-transfer one.

Warning: imx_edma5_wait_done() still cannot stop a transfer it gave up on.
On timeout it calls imx_edma5_reset_hw_chan(), which writes CH_CSR.DONE,
CH_ES and the TCD control fields but does not cancel an in-flight transfer
(there is no MP_CSR.CX use in the driver), so a channel that is genuinely
stuck rather than merely slow will still be reprogrammed while ACTIVE and
the abandoned transfer keeps writing to the old destination. The length
cap makes this much harder to hit, so this is no longer an error, but a
cancel on the timeout path would close it properly.

Warning: The data path remains fully synchronous - enqueue or submit
programs the TCD, starts the channel and busy-waits for DONE - so the CPU
spins for the duration of every copy and the offload gains nothing over
memcpy. The hardware can run detached: program and START at submit time,
poll CH_CSR.DONE in completed()/completed_status(), and serialise only
when a second job needs the single register TCD. If this is deliberate for
the first submission, please state it in the Limitations section of the
driver doc rather than leaving it implicit.

Warning: When rte_mem_iova2virt() returns NULL, cache maintenance is
skipped and, on this non-coherent master, the transfer silently returns
wrong data. The v2 comment documents this, but a code comment is not
reachable by the application author. Either reject such addresses with
-EINVAL or state the restriction in the driver documentation.

Warning: rte_mem_iova2virt() is called per operation (source and
destination, and per segment in copy_sg) in the fast path; it walks the
memseg lists. In IOVA=3DVA mode the lookup is unnecessary and the value is
the address itself.
