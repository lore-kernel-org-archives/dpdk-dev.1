Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EBC5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 20:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82859402BD;
	Wed, 19 Aug 2026 22:08:47 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 507D5400D5
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:08:46 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so990798a12.1
 for <dev@dpdk.org>; Wed, 19 Aug 2026 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787170125;
 x=1787774925; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TlTFv33X4IcKou+CnMcIMwv8LoMRmwAQWK0zCwr3yyU=;
 b=hIj4dZ0bM/f8HjTX5Ca/N1dY/L3D6IWMqNX5y6rsjNZyBEf/asarJzdsQWaOHmNSYz
 QW4IQCp+uTKLmXrLKo68srBcUOnz+aLyzLcktWwnVn3h+/oigGbQlTZwi4qkPEaGYADo
 1FbpuujOBSCSn8t0lVMn14u+JXAingiTxivExH2dl8wnhF0au3L7OD1AT5Hwp9B5sl3t
 IAnB43VPj4XOlSBNhiqUWRXvYM+GmaY2sSbNDTFHjZX6DPBMfr9Ib3x2xLpbDTO8FyM5
 eQZ71ITOVTKhO/0ifLGTS8xpvcPkESIL26qbmALng7q37LutOv8fPBWnzD6pKMEyKcsU
 wG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787170125; x=1787774925;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TlTFv33X4IcKou+CnMcIMwv8LoMRmwAQWK0zCwr3yyU=;
 b=grjW+dD3q9NbyUXHWBUjqczGvicot2lxWYfNuZCWdnVjF60eccdx+X4fV7zFIbsqBc
 32Uh605nAnY1pZIQgUk5JzvUwo+Khf/JrMTpyL3/tkueI6sGt+xsWZzJp652qs8zLRns
 RnMAXscWfZpv59fJ78J8918hEewOi5rFoIdejSGQ1Zlbx/uQEEaWRxUp7jDA4XzN8CiQ
 6+sSQYy0btdLAMAHww6QFmkvDn2ntU10UKshDjz9QHlXi9492+9wwqxnRy/ZhgsFP1qo
 70CUz1H93VYRcmcDKwp6ZbMyJizf6wM7VVJG/nFJS6JD+0ndwGYrjoBr39eSJrDCTTaB
 Mvnw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1iWMJ4IGck/1q83Tj5RzX2/NsMUx61DS6Dg9P3CeMYE+hI1vER6UjUw1bzml1TanjgZw=@dpdk.org
X-Gm-Message-State: AFuF++lyufPIl4SJsoqEGmu62SkYgIyAg4nQLG+XpHgpVRYXdoZPpETY
 MkQm92YN2Ofe2pzgKha2RKKg+vHlwYjIdSphRN446Q4IiS3h1hV6FHolk9mvxAuQwQ4=
X-Gm-Gg: AR+sD121FdYZUD31r62kh+3+zUniJKfzLuZeN9qAatqHjNmX0jM04el+xQXINI6nVgs
 NwmAKvemYQ4u00u76ObyL2DiltaTNh0Ob7SjM5uAYzTK3vCstt090E7dAAja5+zbh5ypsEiiwUo
 4ZIt5zDUG82+7XKpXkOs7QmouuAY4U/9Bny6HdZmkvWXj+xW6kO6yw/XZjSVmDTWI3ACW2qSRcR
 y/xplMpYV0QCqpckbWZJIFB7mwDHMeMEGbnkr43ALzyBfS/KBYxx6CH3lqMClv4m0A6Arbr/Fi2
 OYu2eN1lYsDRgRR5cROBLTa4BLEwtWDU+UDoGoto86HgBVcgR42B0WvFWZ56CbD8Qi+qoJj1Iyq
 Q+wq8Lt1HRXNm5Hxpkz1kU9m1LxO7eifyLghOSuGUuBXrSLhSJoC12aYK/OEVA6DFxAeYAKwugQ
 vfHcxy41gMNnWviZy1fZJuA6yjy1BPHBVL44BGp8XDsdqLfzd3aAACSHz+Nwj1e62E93vqatIPV
 1H+UA5Tc2e90vYeUT4YI8IMBqU9VA==
X-Received: by 2002:a17:90b:1d49:b0:38e:9045:babe with SMTP id
 98e67ed59e1d1-39580eade6amr13723308a91.7.1787170125038; 
 Wed, 19 Aug 2026 13:08:45 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad564bcsm9885272c88.5.2026.08.19.13.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 13:08:44 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:08:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: thomas@monjalon.net, dev@dpdk.org
Subject: Re: [PATCH v13 00/25] NXP DPAA driver enhancements and fixes
Message-ID: <20260819130835.17faad6c@phoenix.local>
In-Reply-To: <20260819105004.2272880-1-hemant.agrawal@nxp.com>
References: <20260818111730.801760-1-hemant.agrawal@nxp.com>
 <20260819105004.2272880-1-hemant.agrawal@nxp.com>
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

On Wed, 19 Aug 2026 16:19:39 +0530
Hemant Agrawal <hemant.agrawal@nxp.com> wrote:

> This series collects a set of fixes and enhancements for the NXP DPAA
> bus, mempool, dma, crypto and net drivers targeting 26.11.
>=20
> It includes memory-leak and resource-cleanup fixes on the device
> remove/close paths, more robust frame queue and congestion-group
> shutdown, secondary-process safety guards, BPID and cgrid lifecycle
> handling, and several new features: offline (O/H) port device support,
> enhanced virtual storage profile (VSP) port support, fmcless Rx queue
> configuration via devargs, Rx/Tx taildrop threshold devargs, ORP queue
> create and burst enqueue, non fmX-macY shared Ethernet naming, and DMA
> scatter-gather and errata-workaround devargs. Documentation and release
> notes are updated accordingly.
>=20
> v13:
> * Addressed mailing-list review feedback on the previous revision.
> * Dropped the Tx port rate limiting patch.
>=20
>=20
> Gagandeep Singh (3):
>   net/dpaa: fix device remove
>   dma/dpaa: add devargs for SG and errata workaround
>   drivers: add offline (O/H) port device support
>=20
> Hemant Agrawal (6):
>   net/dpaa: fix free port resources on close
>   net/dpaa: optimize FM deconfig
>   net/dpaa: support Rx/Tx taildrop threshold devarg
>   net/dpaa: support non fmX-macY type of shared Ethernet name
>   bus/dpaa: improve log macro usages
>   doc: update release notes with NXP DPAA changes
>=20
> Jun Yang (13):
>   bus/dpaa: refine fman naming
>   bus/dpaa: scan max BPID from DTS
>   drivers: shutdown DPAA FQ by fq descriptor
>   drivers: add DPAA cgrid cleanup support
>   bus/dpaa: improve FQ shutdown with channel validation
>   drivers: add BMI Tx statistics
>   net/dpaa: optimize FMC MAC type parsing
>   drivers: release DPAA bpid on driver destructor
>   bus/dpaa: orp queue create and burst enqueue
>   net/dpaa: support fmcless rxq number as devargs
>   bus/dpaa: optimize DPAA multi-entry buffer pool operations
>   crypto/dpaa_sec: improve crypto fq resource handling
>   drivers: add dpaax enter destructor to gate EAL memory frees
>=20
> Prashant Gupta (2):
>   bus/dpaa: fix FQD dest wq channel decoding
>   drivers: add process-type guards for secondary process
>=20
> Vanshika Shukla (1):
>   net/dpaa: enhance VSP port support
>=20
>  doc/guides/dmadevs/dpaa.rst               |  30 +-
>  doc/guides/nics/dpaa.rst                  |  39 +-
>  doc/guides/rel_notes/release_26_11.rst    |  34 +
>  drivers/bus/dpaa/base/fman/fman.c         |  42 +-
>  drivers/bus/dpaa/base/fman/fman_hw.c      | 200 +++---
>  drivers/bus/dpaa/base/fman/netcfg_layer.c |   8 +-
>  drivers/bus/dpaa/base/qbman/bman.c        |  59 +-
>  drivers/bus/dpaa/base/qbman/bman_driver.c |  51 +-
>  drivers/bus/dpaa/base/qbman/qman.c        | 264 ++++++--
>  drivers/bus/dpaa/base/qbman/qman.h        |  23 +-
>  drivers/bus/dpaa/base/qbman/qman_driver.c |  29 +-
>  drivers/bus/dpaa/bus_dpaa_driver.h        |  11 +-
>  drivers/bus/dpaa/dpaa_bus.c               | 172 +++--
>  drivers/bus/dpaa/dpaa_bus_base_symbols.c  |   4 +
>  drivers/bus/dpaa/include/fman.h           |  25 +-
>  drivers/bus/dpaa/include/fsl_bman.h       |  49 +-
>  drivers/bus/dpaa/include/fsl_qman.h       |  65 +-
>  drivers/bus/dpaa/rte_dpaa_logs.h          |   2 +
>  drivers/common/dpaax/compat.h             |  22 +-
>  drivers/common/dpaax/dpaax_iova_table.c   |  24 +-
>  drivers/crypto/dpaa_sec/dpaa_sec.c        | 109 ++-
>  drivers/dma/dpaa/dpaa_qdma.c              | 110 ++-
>  drivers/mempool/dpaa/dpaa_mempool.c       |  60 +-
>  drivers/mempool/dpaa/dpaa_mempool.h       |   3 +-
>  drivers/net/dpaa/dpaa_ethdev.c            | 359 ++++++++--
>  drivers/net/dpaa/dpaa_ethdev.h            |  25 +-
>  drivers/net/dpaa/dpaa_flow.c              | 134 ++--
>  drivers/net/dpaa/dpaa_flow.h              |   7 +-
>  drivers/net/dpaa/dpaa_fmc.c               |  84 ++-
>  drivers/net/dpaa/dpaa_oldev.c             | 772 ++++++++++++++++++++++
>  drivers/net/dpaa/meson.build              |  11 +-
>  drivers/net/dpaa/rte_pmd_dpaa_oldev.h     | 149 +++++
>  32 files changed, 2499 insertions(+), 477 deletions(-)
>  create mode 100644 drivers/net/dpaa/dpaa_oldev.c
>  create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h
>=20

Summary of longish AI review..

Still open

Patch 15 =E2=80=94 no response, and unchanged. getenv("DPAA_TX_TAILDROP_THR=
ESHOLD") is still the fallback, and the RST is still a bullet list. This is=
 the one item that got no reply at all, so it may just have been missed rat=
her than rejected.

Patch 19 =E2=80=94 marked fixed, but only the commit message was. U48_BY_HI=
16_LO32() still shifts hi by 32 with no cast, and BIT_SIZE/MAX_U48/HI16_OF_=
U48/LO32_OF_U48 are still unprefixed in fsl_bman.h. The new message also sa=
ys the macros were "dropped" when they were moved into the installed header.

Patch 22 =E2=80=94 genuinely improved. MAX_NUM_PORTS/MAX_NUM_SUBNETS are pr=
efixed (the collision that actually mattered) and dpaa_ip4_addr_s =E2=86=92=
 dpaa_ip_addr_s. Still unprefixed in the installed header: struct ip_pair_s=
, struct lgw_subnet_s, and the DPA_ISC_* macros. I'd narrow the remaining a=
sk to just those.

Patch 24 =E2=80=94 unchanged in substance, and the contradiction is now sha=
rper than in v12: patch 13 deliberately made dpaa_mpool_finish() the only p=
lace rte_dpaa_bpid_info is freed, so that function calls dpaax_enter_destru=
ctor() and then rte_free() on EAL memory a few lines later. dpaa_finish() d=
oes the same =E2=80=94 latch, then dpaa_fm_term() and rte_dpaa_portal_fq_cl=
ose().

Patch 25 =E2=80=94 new inconsistency introduced by the patch 14 fix: the re=
lease note still says "Added NXP DPAA DMA scatter-gather support" and "Adde=
d scatter-gather (SG) batching... enabled by default", which is exactly the=
 claim patch 14's message was corrected to drop.

Patch 16 (ORP) =E2=80=94 on "NXP customer applications use it": qman_enqueu=
e_multi_orp() is tagged __rte_internal, so it isn't reachable from an appli=
cation at all; internal symbols are restricted to DPDK's own libs and drive=
rs. If NXP customer code is calling it, either it's building in-tree (in wh=
ich case that user should come with the patch) or the tag is wrong. Worth p=
utting back to them as a question rather than a demand.

