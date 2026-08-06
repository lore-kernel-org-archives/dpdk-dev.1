Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2EAC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 17:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8A3F402D0;
	Thu,  6 Aug 2026 19:11:51 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8329440262
 for <dev@dpdk.org>; Thu,  6 Aug 2026 19:11:50 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d01663d816so22799535ad.1
 for <dev@dpdk.org>; Thu, 06 Aug 2026 10:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786036310;
 x=1786641110; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9qGHsSqfCd3iM7aP+7L87VVshHQNPm6Oab3hwV5dTbA=;
 b=rCCPtSxNmtVtBX8tGz2EHaZcNBiLlNu9T7UyEYIh04u53wYz3gNkE0mBFPoUyuElgt
 ZrNSXFcJtCVCJYtdpHLo3Qop5CK0fSndsx7VLmNzWuoXq0Yzw1lC3lXI2lPp0kW0O/ts
 WKQe0lsj7H40Cbt7CF9KUq6N+zocwpOYoVcGIjp61OypIzr69PFBvTL49TgIgIlVQWAo
 J86wJhkMdyCefAlyXNeawxU575nf/PUID09V0XvhdBa5dps1QLfkZRDsZt7fC4wD0evv
 n16iAhXz9qgsNPMGIFe2WpTAdYIj0/idaeinabtzXW4jmEx7ZUQSq1oCG37qmCYsSLC1
 /mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786036310; x=1786641110;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9qGHsSqfCd3iM7aP+7L87VVshHQNPm6Oab3hwV5dTbA=;
 b=G8MRPjjW47SZIvIH/nGFRefsU+KzLL1x4N5CYh6zJ7sgtkrzI4r1COjKr9im4CQvih
 uHwaKsYtQKN4ZtWtkCooEIwsxWc7jxZyfCPNDHHSc8PeRatpFV8O+7inNPei6pqYWn0+
 2+7fUQpnm+d0IOjPgAFkCm+boldmGX7hrs3OIJZjBHeaBBLz1rz6246Z8sBfRCKqGRYb
 JsG+hyfxyX0qU3v9DfWAI9JYjYMDDS9dxXjGU9Xm0bBNWovpIBlHzlgS1EfB7lfuB0g8
 2ysj2VpCTEzUstSbT8gkCNDCzlaHtGDMsutCy2pNT62g6WckZnUtzixSbjt7VzLfLwGS
 6TSg==
X-Gm-Message-State: AOJu0YwahOqmL5cK3Hp38RHdxNs9gSn2fFHmW+XBeqNRjltxRDMa/ICf
 8RXe1wXqCcjCAKW8KAtUMgcAtIP7uRhCPQF3CShbl7kcduM5uOhjloYM5b7Mzt/jVLY=
X-Gm-Gg: AR+sD12Hnu7aqpJzLm7iW+j4khJP9Yw+eym6pPl0wUhssuvE6Y5PR1jNcPG1txjBwd6
 L0A6kEvhTpX7UAtVRmI1sYKn1fscr0fJiqYVqNaTPsf8FplDdCoMVN61VZ9VVpMrCpLzhGskLmA
 eivZfguqB2NfmwEdARD9S5qW6HJRx/2bPRmbgTGLpA4EkORl2x0cqQHJiBzcsvYIMG/RVCId5dc
 /4yn+2Qwt+hOSk+uzefIDUTp311Bimo8mHHTuNYRMur0l/A1C30VxmRVpjnhoU9TVRutkZFVyK3
 cRcnlaA6Q+YKQ+Mdy2Ug+ikebt/uSJ+cS0fcuMwQlq8Y2gRR2+OOqKz6lt6aKHfkST3ZkX2mhAQ
 r5f1crSIBWcmoUy/1SfBNrYssJOG36VCIXOFcKypEtUJa7bhaROpRza6Y88lq+3BLHIns8+ulHi
 p92tnowo7bCntVdZVlabciHKidle09PqHxhBKDgWbuRML+7HLaCqCD2kZ17y6LR3yLU00H6H17G
 PKoqlUdT062vsfhclyFk0MslWPHjQ==
X-Received: by 2002:a05:6a20:9c15:b0:3b3:2703:110 with SMTP id
 adf61e73a8af0-3cbada680bfmr4447044637.4.1786036309425; 
 Thu, 06 Aug 2026 10:11:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158676f579sm27511518eec.20.2026.08.06.10.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:11:49 -0700 (PDT)
Date: Thu, 6 Aug 2026 10:11:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH 0/4] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Message-ID: <20260806101145.336c193f@phoenix.local>
In-Reply-To: <20260806084245.561305-1-g.singh@nxp.com>
References: <20260806084245.561305-1-g.singh@nxp.com>
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

On Thu,  6 Aug 2026 14:12:41 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> This patch series adds a new dmadev Poll-Mode Driver (PMD) for the NXP
> i.MX95 eDMA5 (Enhanced DMA Type 5) controller.
> 
> Key features supported by this driver:
>   - Memory-to-memory copy (RTE_DMA_OP_TYPE_MEMCPY)
>   - Scatter-gather memory copy (RTE_DMA_OP_TYPE_SG)
>   - 64-bit TCD (Transfer Control Descriptor) format
>   - Non-coherent DMA with explicit cache clean/invalidate
>   - Per-channel statistics and register dump for debug
> 
> Patch breakdown:
>   [1/4] Skeleton: bus probe/remove, dmadev registration, MAINTAINERS,
>         doc index, and release notes for 26.11.
>   [2/4] Device configuration: vchan setup, TCD ring allocation,
>         start/stop, and capability reporting.
>   [3/4] Data path: enqueue (copy and sg), doorbell, completion poll.
>   [4/4] Statistics and dump: per-channel counters and register dump.
> 
> Tested on NXP i.MX95 EVK with vfio-platform.
> 
> Gagandeep Singh (4):
>   dma/imx_edma5: introduce eDMA5 dmadev skeleton
>   dma/imx_edma5: add device configuration
>   dma/imx_edma5: add data path
>   dma/imx_edma5: add statistics and dump
> 
>  MAINTAINERS                              |    5 +
>  doc/guides/dmadevs/imx_edma5.rst         |   61 ++
>  doc/guides/dmadevs/index.rst             |    1 +
>  doc/guides/rel_notes/release_26_11.rst   |    6 +
>  drivers/dma/imx_edma5/imx_edma5_dmadev.c | 1096 ++++++++++++++++++++++
>  drivers/dma/imx_edma5/imx_edma5_dmadev.h |  203 ++++
>  drivers/dma/imx_edma5/imx_edma5_hw.h     |  158 ++++
>  drivers/dma/imx_edma5/imx_edma5_logs.h   |   16 +
>  drivers/dma/imx_edma5/meson.build        |   10 +
>  drivers/dma/meson.build                  |    1 +
>  10 files changed, 1557 insertions(+)
>  create mode 100644 doc/guides/dmadevs/imx_edma5.rst
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
>  create mode 100644 drivers/dma/imx_edma5/meson.build
> 

Always good to see more hardware support.

Detailed AI review showed lots of problems:

Patch 1/4 (skeleton):

Error: The driver can never match a device through the upstream platform
bus. platform_bus_match() compares (1) the kernel driver name against the
DPDK driver name, (2) the kernel driver name against the alias, and (3) the
sysfs device name against the DPDK driver name. Devices are only scanned if
bound to vfio-platform, so the kernel driver name is always
"vfio-platform", and a DT device name like "42000000.dma-controller" never
equals "dma_imx_edma5". No match path can succeed, so probe is unreachable.
The cover letter says this was tested on i.MX95 EVK - presumably against a
modified bus. The series needs an accompanying bus/platform change (e.g.
match on of_node/compatible) or an explanation of the intended binding.

Error: RTE_PMD_REGISTER_ALIAS(dma_imx_edma5, IMX_EDMA5_COMPAT) produces a
broken alias. RTE_PMD_REGISTER_ALIAS stringifies its argument via RTE_STR,
and IMX_EDMA5_COMPAT is already a string literal, so the alias becomes
"\"fsl,imx95-edma5\"" with embedded quote characters (verified with cpp).
It can never strcmp-equal anything. The macro takes an unquoted token, and
"fsl,imx95-edma5" cannot be expressed as one (comma splits macro args), so
the compatible string cannot be used as an alias at all - which feeds back
into the matching problem above.

Warning: probe() does not verify the device's compatible string. If the bus
matching is fixed, any allowlisted vfio-platform device would be claimed by
this driver. Read of_node/compatible and check for "fsl,imx95-edma5"
before touching registers.

Patch 2/4 (device configuration):

Warning: Internal contradiction on coherency. imx_edma5_reset_hw_chan()
programs CH_MATTR to IMX_EDMA5_CH_MATTR_COHERENT with a comment saying the
eDMA "snoops the CPU caches, matching the Linux fsl-edma driver on a
dma-coherent controller", while the cover letter, patch 3 commit message,
and the data path all say the master is non-coherent and do full manual
clean/invalidate. Both cannot be the intended design: if the interconnect
honors those attributes, the per-op cache maintenance and iova2virt lookups
are pure overhead; if it does not, this comment is wrong. Pick one and make
the comments match the code.

Patch 3/4 (data path):

Error: RTE_DMA_OP_FLAG_SUBMIT does not submit previously enqueued jobs.
The API defines the flag as issuing the doorbell "after enqueued jobs",
i.e. equivalent to rte_dma_submit(). imx_edma5_copy()/copy_sg() with the
flag run only the current job. Jobs enqueued earlier without the flag are
skipped, so they execute out of order relative to the flagged job, and if
the application relies on the flag alone they never execute:
imx_edma5_completed() stops at the unsubmitted job at tail and the
application waits forever. In the flag branch, run all pending jobs from
tail through this one (same walk as imx_edma5_submit()).

Error: The arm64 cache maintenance helpers lack a DSB. imx_edma5_cache_clean()
issues DC CVAC per line but never executes DSB; completion of cache
maintenance to the PoC is only guaranteed after a DSB, and the DMB inside
rte_write32() does not provide that. The device can be started before the
cleans reach memory and read stale source data; likewise the CPU can read
the destination before the CIVAC loop in imx_edma5_cache_inval() has
completed. Add asm volatile("dsb sy" ::: "memory") at the end of both
helpers (compare Linux arch_sync_dma_for_device()).

Error: 1 ms completion timeout with unbounded transfer length can corrupt
memory. The API length is uint32_t and the driver imposes no maximum, but
the timeout comment assumes "the largest single-block copy ... completes in
well under a millisecond". A large copy exceeds 1 ms, imx_edma5_wait_done()
times out, and imx_edma5_reset_hw_chan() does not actually cancel an active
transfer (it only writes CH_CSR.DONE; there is no MP_CSR.CX cancel in this
driver), so the next job reprograms the TCD while the channel is still
ACTIVE and the aborted transfer keeps writing to the old destination.
Enforce a maximum length in copy()/copy_sg() and scale the timeout, or
implement cancel via MP_CSR.CX on timeout.

Error: TCD NBYTES is written with the full 32-bit length, but on
eDMA3/4/5 the NBYTES register carries SMLOE/DMLOE in bits 31:30 when
minor-loop offsets are supported, leaving a 30-bit count. A length with
bit 30 or 31 set silently enables minor-loop offset mode and truncates the
count. (Confidence moderate - please confirm against the i.MX95 RM.) A
length cap per the previous item resolves this too.

Warning: The data path is fully synchronous: enqueue (or submit) programs
the TCD, starts the channel, and busy-waits for DONE, so the CPU spins for
the duration of every copy and the offload gains nothing over memcpy. The
hardware can run detached: program and START at submit time, poll
CH_CSR.DONE in completed()/completed_status(), and only serialize when a
second job needs the single register TCD. At minimum the limitation
deserves a line in the driver doc.

Warning: rte_mem_iova2virt() is called per operation (src and dst) in the
hot path; it walks the memseg lists and is expensive. In IOVA=VA mode the
lookup is unnecessary. Also, when it returns NULL (e.g. external memory),
cache maintenance is silently skipped, which corrupts data on the
non-coherent path - reject such addresses or document the restriction.

Info: The in-memory TCD64 pool is only used as a parameter store: fields
are converted to LE at enqueue and read back with le_to_cpu in
imx_edma5_run_job()/job_invalidate_dst(); no descriptor is ever fetched by
hardware, and the "must be cleaned from the CPU cache" comment in
imx_edma5_hw.h is not (and need not be) honored. A plain array of
src/dst/len triples would be simpler, or use E_SG hardware chaining.

Patch 4/4 (statistics and dump):

Info: The cover letter advertises "register dump for debug", but dev_dump
prints software state only (the commit message is accurate). Either dump
CH_CSR/CH_ES/TCD registers or fix the cover letter wording.

Series:

Info: A few double blank lines (imx_edma5_dmadev.h:46, 69, 132;
imx_edma5_hw.h:157) and a stray blank line before the closing brace of
struct imx_edma5_dev; checkpatch will flag these.
