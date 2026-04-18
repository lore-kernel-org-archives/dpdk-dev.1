Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF3F99C78
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Apr 2026 03:28:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 551B3402D9;
	Sat, 18 Apr 2026 05:28:45 +0200 (CEST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id A7FFE402C5
 for <dev@dpdk.org>; Sat, 18 Apr 2026 05:28:43 +0200 (CEST)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d4be94eeacso1305025a34.2
 for <dev@dpdk.org>; Fri, 17 Apr 2026 20:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776482923;
 x=1777087723; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sVWfiaLaVD0DuED2DqnUQeko8YtdL5jo+SKVLjSOWfk=;
 b=FgkdL83nYvasLEUuiAtNWJkyaNdJzltaYlfv1OtK9pPeniZf5BtzlRkMUknF6Fm2oq
 sT7FWwGsJcfVubYPbRvDpkWOUJdpJlKhy6zzS/N8oTHgyjInzLUvhj8gIpbALG+m/cHS
 PkMX0u0hqTuLGPlyID4Ewtm6B2g5D0SS/catb5J6/rLTo3VlMmDaqQDmmmWD1uWqqbWA
 ZbaF7iNdMBhFxmAvSiHA5j3UHC5pGpy0M7St5G5viVtTaz18YbVfnyyYySYmeYGftY0r
 ZrNorwYM5apvah8oW1GwjgPU291E5Mw1a+f+xifg+9ZEB83bnm6MUjDvwDV4DsJIEUP5
 QLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776482923; x=1777087723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sVWfiaLaVD0DuED2DqnUQeko8YtdL5jo+SKVLjSOWfk=;
 b=G41c6K/5HFH7DtT3A3N/SHOv4Zr4IQq2LYpQBErYiu5VuVLdl5zurDh0ZGHqBOd8YC
 3gUn1Ge+tFWPl9OgwKaM2zwQB7EtfVk7920Jg+wy8UVwiTXnagMydozyD71glBsACDag
 xZW4Psz23BN6ZjfAhw4BxUtVJeYCeSL4k6yEGjXu58zXcda+FByUfi1qNHWkNb7EnrMx
 NkpcvywJ3hh26D+k4EJHvKB18o3zcJ3hMtsUryhVwAanSbuD+o7hoclGvmhBNLeLDj4r
 4xSBnrpDLSYdOZgRWJOl03L1wIccliBMXqWkZUGnWlGaPNVma2QfwDz+/y3kRasmSdFQ
 q3Vg==
X-Gm-Message-State: AOJu0Yw+0YfZm8g84c676R6emj7v2UUiXTNMG2hTzpzKN6mF8+IW6WmN
 Hwx8wEPwM3cRjqSEyD/b85rFc2nQDcYSHD4StL3zp5U6AdmIZonJGIUMxPTENQTtHqA=
X-Gm-Gg: AeBDiesrZcZoluBh3atbypx395UaHL16LUgBWxW4Buhc/Th6W0ARaGmyy2b4oRV296X
 lMS+mmkPANkYWXnRie8vb+0g5LI5DOHiw8T7/z0ZZqr6MxxYl8awtVrhnLuzcaqa6ASJHIi/g0W
 0gvGIVG4RR8ClCzKmNXfro8xvovsWkpd8RDBpVvmCXiW1XVQzOIyoh9aHbxHhaKdtM/L+Ye26K3
 yNARPE0+JlkO2TKvq/BPcNFmDF6OGpV0uLrLPyBBys4rdRRICUv+hAQ/MLwxZIWrqLM5ONW8wWN
 Flf/NtyYWJADCG6iHQbGZinb/gixSZlQkzxEeFtR7ZNiAN/QIDyYV8D6wiYKZ0gPSfTQEBFazBp
 SS0edVlBtFZ4Rnz+5HlAXrARjLnWhsYxf1P1bO5UChSyvsAIB705JvfWnhcw3HKrRZWLjyQCNVR
 dWM6iIcUwtVH64kou+J4P50UQhB1LG4IxIdnl4yDtXtomY0E52anGXhBKM
X-Received: by 2002:a05:6820:f025:b0:67c:2857:e0e9 with SMTP id
 006d021491bc7-69462ef62edmr3166782eaf.44.1776482922620; 
 Fri, 17 Apr 2026 20:28:42 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69464e5e752sm2123871eaf.2.2026.04.17.20.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 20:28:42 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:28:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: <dev@dpdk.org>, <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v3 0/2] few improvemnts for SORING lib
Message-ID: <20260417202839.12cb9262@phoenix.local>
In-Reply-To: <20260417212358.212692-1-konstantin.ananyev@huawei.com>
References: <20260416191440.208066-1-konstantin.ananyev@huawei.com>
 <20260417212358.212692-1-konstantin.ananyev@huawei.com>
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

On Fri, 17 Apr 2026 22:23:56 +0100
Konstantin Ananyev <konstantin.ananyev@huawei.com> wrote:

> v2 -> v3
> - fix MSVC complaints
> 
> v1 -> v2
> - fix formal API comments (doxygen complaints)
> - add section to release notes
> 
> First patch aims to improve enqueue/dequeue performance, specially
> for the cases with multiple stage workers lcores.
> Second one introduces 'Peek API' similar to what we have for
> conventional rte_ring. Also it adds new test-cases for this new API.
> 
> Konstantin Ananyev (2):
>   ring: make soring to finalize its own stage only
>   ring: introduce peek API for soring
> 
>  app/test/meson.build                   |   1 +
>  app/test/test_soring_mt_stress.c       |  74 +++++++
>  app/test/test_soring_peek_stress.c     |  75 +++++++
>  app/test/test_soring_stress.c          |   3 +
>  app/test/test_soring_stress.h          |   1 +
>  app/test/test_soring_stress_impl.h     |  87 +-------
>  doc/guides/rel_notes/release_26_07.rst |   8 +
>  lib/ring/rte_soring.h                  | 264 ++++++++++++++++++++++
>  lib/ring/soring.c                      | 289 ++++++++++++++++++++-----
>  9 files changed, 669 insertions(+), 133 deletions(-)
>  create mode 100644 app/test/test_soring_peek_stress.c
> 

Lots of little typos caught by AI.

Based on review of both patches against the upstream DPDK tree, here is a summary of findings suitable for posting to the list. I recommend you edit/trim before sending since this is a draft.

Subject: Re: [PATCH v3 0/2] few improvemnts for SORING lib
General: "improvemnts" in the cover letter subject is a typo (improvements).
Same type of typo recurs in the patches themselves (see below); worth
a quick pass on the prose.

[PATCH v3 1/2] ring: make soring to finalize its own stage only
Warning:
The file-level comment block at the top of lib/ring/soring.c is only
partially updated. The hunk rewrites the paragraph starting with
"Note that 'finalize()' for given stage...", but leaves the earlier
paragraph describing release() behavior intact:
  "After that, it checks does old head value equals to current tail
   value?  If yes, then it performs 'finalize()' operation, otherwise
   'release()' just returns (without spinning on stage tail value).
   As updated state[] is shared by all threads, some other thread can
   do 'finalize()' for given stage.
   That allows 'release()' to avoid excessive waits on the tail value."
After this patch, release() unconditionally calls
__rte_soring_stage_finalize() (no tail==pos check), and acquire()/
dequeue() no longer call finalize() at all. The stale paragraph should
be updated to match, otherwise readers will be misled about both the
release() fast path and the "shared state[] lets another thread
finalize" claim.
Info:
"Accorging" in the commit message body -> "According".

[PATCH v3 2/2] ring: introduce peek API for soring
Warnings:
Doxygen description/signature mismatch. Several of the new doxygen
blocks are copy-paste from the "enqueux"/"dequeux" variants and
describe a metadata parameter that the declared function does not
take:
- rte_soring_enqueue_finish: described as "Complete to enqueue
several objects plus metadata" but takes no meta argument.
- rte_soring_dequeue_bulk_start: "Start to dequeue several objects
plus metadata" - takes no meta.
- rte_soring_dequeue_burst_start: same.
Also, the @param objs blocks for the dequeue_bulk_start /
dequeue_burst_start / dequeux_bulk_start / dequeux_burst_start
variants say "Size of objects to enqueue" - that should be "to
dequeue".
Missing experimental warning in doxygen for rte_soring_dequeue_finish.
Every other new function in this patch carries
  @warning
  @b EXPERIMENTAL: this API may change without prior notice.
rte_soring_dequeue_finish is declared __rte_experimental but its
doxygen block omits this block. Please add for consistency.
Missing RTE_ASSERT in soring_dequeue_finish(). soring_enqueue_start(),
soring_enqueue_finish() and soring_dequeue_start() all begin with
  RTE_ASSERT(r != NULL && r->nb_stage > 0);
soring_dequeue_finish() does not. Inconsistent with the rest of the
datapath; please add.
Info:
Doxygen typos:
- "Start to enqueue excact number of objects" -> "exact"
(rte_soring_enqueue_bulk_start description).
- "please refer to corresping rte_ring peek API" -> "corresponding"
(SORING Peek API header comment at the top of the new block).
Double space in new helper signature:
__dequeue_elems(const struct rte_soring *r, void *objs,  void *meta,
^^
__enqueue_elems directly above it does not have this. Minor.
Stray trailing blank line inside the initializer in
app/test/test_soring_peek_stress.c ("static const struct test_case
tests[] = {\n\n\t{"). Cosmetic.
SPDX header in the new file test_soring_peek_stress.c reads
"Copyright(c) 2024 Huawei" but the file is being introduced in 2026.
(Copyright formatting is normally left to checkpatch, flagging for
awareness only.)

Nothing in either patch rose to the level of a correctness bug in my
review - no leaks, no UAF, no missing error paths, no races beyond what
the existing soring already accepts. The dependence on patch 1/2 for the
refactor into __enqueue_elems/__dequeue_elems helpers in patch 2/2 is
fine given normal series-apply order.
