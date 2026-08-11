Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAE9C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:00:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53C764026F;
	Tue, 11 Aug 2026 19:00:31 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0E34F4021E
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:00:29 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso1860345ad.3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786467629;
 x=1787072429; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kQijRFvgFf25bIynP9BicbczlDvRCedNoRVijWDOwQg=;
 b=VrSpx6QURVBrwDch8gWIPNwyy2Gz70q1wPNWOMPXIuryH9PiG2Yy8/DQPZFJm7lKps
 VSJG6td0Bxce9rgGLQl0ZOQlyO8au5JoiDEVaBhQNLjYAj56jgEs3WsB6zJyN4T4WUlr
 34j+dxCgyUsOLYIWJTOqRQl4ohqZqm04ilj1erGfD9EcCu0MXO8oUnKBN8LfxfzR1eci
 vA7KJn/z4HViBCKKtXH+QFwzrEhqPF6gn21sQlXeovrXEexY4rNeY4pvSeQWdvEIvppo
 2qHuZCP5TwWbrHVfskzrysDtHu3690DF1Mx5NH7h3z39ClnXr9Hb3cdmJVFeRRSDPQ3O
 kBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786467629; x=1787072429;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQijRFvgFf25bIynP9BicbczlDvRCedNoRVijWDOwQg=;
 b=l4CWKi2l0ZBLVYBi5WBp/obiC+ohi0iOD6v04yHUEO5KKZ7gdmYfeC1cov1gatoYTY
 oGjo0QV1HzAJ7MfN+B+vjJfz/NWrkpf0RZ5nIAmRNWfKZ/5HesItXPBcBv4xeCEdeSqB
 Alu56VOEDkkapxVgsn0+xGdo/skm2aQO+xSVau6cpynSf2FrswKlBfpXdx5B9Z6LMAaL
 88pDDe0JYEsQJ40a6ch1d8YfjCW4XfYAIIYldB6LNzoOaqwKoHWIin3yAiDOUs9v9Yhy
 KgOw2Cbpg0fdUbMXLMcrDFtcSRMNWSrI+SKXMWoHTeDTn/eWD4pnMikuEIHJoWEKnHuT
 f2tQ==
X-Gm-Message-State: AOJu0YzHkbQQl0lq54z9RnNInBRQBmVXf1MU67drjVq8Mbt8wvo3bYvY
 A8HLDYvTxt5v2EoMoesL29NONgUbg7UO4cF1YoNkdGa0w1TdS2oFb2yfWwMwlzWwI14=
X-Gm-Gg: AR+sD11tKEZdFOwGCzYBBKTfGdXWc7nj9sl9YYs819rd8nfJCkPAsQS2jToGwQeWTTa
 wloHrweaewrih/bcfY6afiEM3apKxq6AHS5OZ4sHIKXysHF9abaC0uuRWPxi+DohzglfTPQL2qv
 +oLEub6MMk4tVaz6sTasBkqdshu9HHJW/UaHf+KhfX/qetIV1u9bE6UM8DVXf8bBlBtoh/adphd
 pkHF+EF6u0czyMMXwrrnaBfUiW5Z2DD31oTc4sT+DwboIpYscUNDFxbz3nh/vZC0+G3DZO7vBoK
 g07mvs9PnZDayBo0nIMkhEJ0S61PBBrpHG0yiBgmDkX9IeSGSrI1mnDEdXMiLMM8NpqAUxY7ypy
 OkRbONZMQJKyYoVd87HolSITbTOZ6NzZ19wQX95EyJ1mRMp/tByqHgF06lbGCHelHwxJPTnkVfS
 WvX7VUNY9ghYb0P4AvHp12Sjdl0ZXH/UtkjXifDL9d+tgemKtyDVVyEclaxWW/NOSYpY+THPP1O
 NlkdeJCRVfmukCpQe0CtvN8JQv4D6C8j89L+hNc
X-Received: by 2002:a05:6a20:2587:b0:3c3:64cc:311a with SMTP id
 adf61e73a8af0-3cc2ba57880mr5042316637.22.1786467624546; 
 Tue, 11 Aug 2026 10:00:24 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14124471f30sm1128545c88.4.2026.08.11.10.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:00:24 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:00:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v3 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver
Message-ID: <20260811100020.3a896d84@phoenix.local>
In-Reply-To: <20260811104933.3843522-1-g.singh@nxp.com>
References: <20260807064853.1138187-1-g.singh@nxp.com>
 <20260811104933.3843522-1-g.singh@nxp.com>
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

On Tue, 11 Aug 2026 16:19:28 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V3-changes:
>  - Fixed below AI comments:
>    - Dead quote-stripping removed (`of_device_is_compatible`)
>    - Redundant `goto out` removed
>    - New Features entry added for bus platform changes.
>    - Scatter-gather doc corrected in both sections
>    - Unused CH_MATTR macros removed
>    - Fixed SG sub-transfer length cap (`imx_edma5_copy_sg`)
>    - Updated Per-job timeout logic.
>    - Updated `rte_mem_iova2virt` per-op in IOVA=3DVA mode logic
>    - Updated comments and documentation as per the AI comments.
>=20
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
>  doc/guides/dmadevs/imx_edma5.rst           |   69 ++
>  doc/guides/dmadevs/index.rst               |    1 +
>  doc/guides/rel_notes/release_26_11.rst     |   15 +
>  drivers/bus/platform/bus_platform_driver.h |    3 +-
>  drivers/bus/platform/platform.c            |   52 +-
>  drivers/dma/imx_edma5/imx_edma5_dmadev.c   | 1190 ++++++++++++++++++++
>  drivers/dma/imx_edma5/imx_edma5_dmadev.h   |  234 ++++
>  drivers/dma/imx_edma5/imx_edma5_hw.h       |  144 +++
>  drivers/dma/imx_edma5/imx_edma5_logs.h     |   16 +
>  drivers/dma/imx_edma5/meson.build          |   10 +
>  drivers/dma/meson.build                    |    1 +
>  12 files changed, 1738 insertions(+), 2 deletions(-)
>  create mode 100644 doc/guides/dmadevs/imx_edma5.rst
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
>  create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
>  create mode 100644 drivers/dma/imx_edma5/meson.build
>=20

Still lots of AI review feedback if run with stronger model.
Nothing major

Review of [PATCH v3 0/5] dma/imx_edma5: introduce NXP i.MX95 eDMA5 driver



Verification: the full series applies cleanly to main. Each of the five
commits builds independently with -Dwerror=3Dtrue on x86_64 and on aarch64
cross, for both the bus and the driver objects. Documentation renders
without sphinx warnings and both release-notes entries appear, ordered
bus-before-PMD per the suggested ordering in the template. check-git-log
reports 5/5 valid. No trailing whitespace, no lines over 100 characters.

Patch 1/5 addresses both v2 findings: the quote-stripping block is gone
and the redundant goto before the out: label is gone. The release-notes
entry has been added. Two small things remain, neither of them defects:

Info: With the quote handling removed, the `want` buffer in
of_device_is_compatible() is a straight copy of `compat` and is no longer
needed - strcmp(s, compat) would do. Dropping it also removes 8 KB
(BUFSIZ) of stack from a function that currently reserves about 20 KB
across path[], buf[] and want[]. The rte_strscpy() return value is also
unchecked, which becomes moot once the copy goes away.

Info: The working pattern for a device-tree compatible is now to set
.driver.alias directly in the rte_platform_driver initializer, because
RTE_PMD_REGISTER_ALIAS stringifies its argument and cannot express a
string containing a comma. That is a reasonable resolution, but nothing
in bus_platform_driver.h says so, and the next driver author will
reach for the macro first. A sentence in the comment above
RTE_PMD_REGISTER_ALIAS would save someone the debugging session.

Info: imx_edma5_hw.h line 77 has a double blank line left where the
CH_MATTR attribute macros were removed, and IMX_EDMA5_CH_MATTR (line 55)
is now the only CH_MATTR definition remaining and has no user. Keeping a
complete register-offset map is defensible.

Info: The cover letter's "Patch breakdown" still lists [1/4] through
[4/4] from v1; the series has been five patches since v2.

The correctness issues from v1 and v2 - the unreachable probe, the broken
alias, the missing DSB, the SUBMIT-flag semantics, the NBYTES truncation
in both copy paths, the per-sub-transfer timeout, and the coherency
contradiction - are all resolved and verified against the applied tree.

