Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ED6CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 16:51:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CECA34027B;
	Tue,  6 Oct 2026 18:51:27 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id B183540151
 for <dev@dpdk.org>; Tue,  6 Oct 2026 18:51:26 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc751eddf25so527910a12.3
 for <dev@dpdk.org>; Tue, 06 Oct 2026 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791305486;
 x=1791910286; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C+cv3D0JIFAk/PaiY4Lk8L/XkLXnI8kiWdu8uc1/Y1M=;
 b=cnS/MaL0aOwrkf73ByBXyonTck6x1KM/IWtXjHeJVvGIDRWjKHv9g9XcaDVkx65vCA
 37sKhXyQt6/8F4ibHeD2uBRKHI3CureTT2Ztgz/YukgXC+0bFx6rIWiQJ/4ZphNZPjcW
 IoMqTMdgOE/X5e/8NkuwhgMTuEV2kUpGlFc+56l0C3J8hZZih2ZTUsOxb1IdQLnZFqQ9
 5p4dlYFIewCyFxHRHTuVvHyh5zpj+kRe0hLZWsOkRoveo1mDF3LEPB5v60uG1i02z6px
 LsZWY8/MwO+dRxx1qw+4oSEtykyx7au0xggw7gaHgpAgZAi4YZ950b4opcb1jj5MqsOx
 5wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791305486; x=1791910286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+cv3D0JIFAk/PaiY4Lk8L/XkLXnI8kiWdu8uc1/Y1M=;
 b=UtfKfFfZySwwYB2FW+xpM1LNqEZ8vK1nosAIFRRot6CaTarKnRxWGTODA8MniT5+7N
 3xlSUIHP1HBwV1i1Q5Vkmgm4vWU8/vPem0rj/SVM8BDBD8yHR2ksr0ie6sDKQJHXl7WO
 1zAbwUyxuruScfaGUmgyraPVgPRY2h7nWcqFdySSXFDitUgx1IUK4ZUqmI75RQNbikt5
 Jo4q9vQ5oPCITiHfQ9rPYplUlH7X31ewfz9IMha1ok33+RVZprX4vxlChoE/fkRFHEfn
 0UdvkIqaBWd6DyvhXThjQws3fRfT5AJjs8XjSRHZpUS/qG15FC/j01L61u8jL3TZ9gk9
 cMew==
X-Gm-Message-State: AFq9FYLU0e5pU99WwthI61+C2uR/jP7T5C+Ae00sPRruHVmfaGmDr6uL
 mfHFwovGdxN5DhBv73Qc8jDKBHbYK96EUxj5CRyNsGdczedpy3Xd8ZfB+5ZU7RzoOq8=
X-Gm-Gg: AYBFou0Cio6nwnLJEIMeKcHvuGEk9SAXh5fUu83kvUzbnUdQrUFAkV+gXFiwiNkdR7/
 YKKebEA8wprqojJUXNHoRsmZUEnpCBnju+k1tM3CACTjvckR0bIOMplHek1N2OcOwe1BbrarSha
 WoQ3KT7hr4rr9W/igDgKbZwWV9oTfqH5EJGIUr154H4S74j4HXP6J2DY16cTESFNSEpSQWn5tSY
 frf9HNaEjtIqVelGBsa3ZwiPt32eMPIGcjt7DOMQu8MYfakIu7bXlGuSTuDqTDh6qiGhdBhypTK
 ZPeHWQ+FeM5g2fXjkQb1Fx2OK/WL02MFHAe+dLy/KGnVGmKpui7LkVx3Kwe/bxpexDmwUMkwQj+
 6KjaJEI7FhYhyToDdavf+HrzhamMVjaasd7+Ud93G0l6uLQ7N/bApaErNJYtA9CKU/PARL+NZZ8
 vYdUle58xwyCubKmg12vM2cTx5UdTZCvodWb0uD2hrPBp4pPGsk1BOnm0k8Bia0WQzXFGi9O0qa
 sZuNlJgYHqAliN2PTnCskcN2gRRRCZyVxDqqtyF
X-Received: by 2002:a17:90a:2c9:b0:3a8:796e:ca18 with SMTP id
 98e67ed59e1d1-3a8796ecbd4mr879917a91.59.1791305485227; 
 Tue, 06 Oct 2026 09:51:25 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8543bf138sm5856953a91.15.2026.10.06.09.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 09:51:25 -0700 (PDT)
Date: Tue, 6 Oct 2026 09:51:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Randy L Tice <rtice@cisco.com>
Cc: dev@dpdk.org, Morten =?UTF-8?B?QnLDuHJ1cA==?=
 <mb@smartsharesystems.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: Re: [PATCH v4 0/1] mbuf: add runtime metadata dynamic-field storage
Message-ID: <20261006095123.3166b4dd@phoenix.local>
In-Reply-To: <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
References: <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179130207755.4.10786861462241375385.v4-0000-cover-letter.patch@cisco.com>
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

On Tue, 06 Oct 2026 11:54:37 -0400
Randy L Tice <rtice@cisco.com> wrote:

> This revision changes direction from the v3 build-time dynfield3
> layout.  It adds a runtime EAL-configured per-mbuf metadata area that is
> placed after the fixed struct rte_mbuf header and before per-pool private
> data.  This keeps sizeof(struct rte_mbuf) fixed while allowing deployments
> that need globally consistent per-mbuf metadata to reserve that storage.
> 
> The metadata area is still managed by the mbuf dynamic-field registry.
> Fields registered with RTE_MBUF_DYNFIELD_F_METADATA are allocated from the
> metadata area and are not copied by generic mbuf copy, clone, or attach
> operations.  Fields registered without the flag continue to use the existing
> copied mbuf dynamic-field storage and cannot overlap the metadata area.
> 
> The existing per-pool private data area does not provide a central layout
> registry and is configured independently for each mbuf pool.  That makes it
> hard for multiple libraries, drivers, or application modules to safely share
> metadata without out-of-band coordination, especially when pools are created
> by different components.
> 
> Mbuf object layout calculations that need to include the optional metadata
> area now use rte_mbuf_size().  The primary process validates and publishes
> the metadata size through the shared mem config; secondary processes may
> omit the option, but if provided it must match the primary value.
> 
> The octeontx mempool driver rejects allocation when mbuf metadata is
> configured because the hardware mbuf header offset must remain 128 bytes.

I did a brief look at this and still not convinced about the exact use case.
What is the problem this is trying to solve and why can't it be done
by using existing API's.

On a reviewer level, you need to break this up into:
  - core mbuf changes
  - per-driver patch to use those core mbuf changes
  - example of usage
  - documentation
  - any review safe guards that future changes don't break this.

The more detailed AI review focused on problems as well...


[PATCH v4 1/1] mbuf: add runtime metadata dynamic-field storage

Does not apply to current main: rte_mbuf_from_indirect() and
rte_mbuf_to_priv() now have RTE_ASSERT lines. Needs rebase.
Fixed up by hand for testing; builds with -Dwerror=true for the cnxk,
bnxt, nfp, softnic and mempool drivers. mbuf_autotest passes with
metadata size 0, 64, 256 and 65472.

Error

lib/mbuf/rte_mbuf_core.h: RTE_MARKER8 is not defined when building
with MSVC (rte_common.h wraps the marker typedefs in
#ifndef RTE_TOOLCHAIN_MSVC). The markers were removed from struct
rte_mbuf for exactly this reason; this re-adds one and breaks the
Windows MSVC build. The marker is also unnecessary: the metadata
area starts at sizeof(struct rte_mbuf), so use that instead of
offsetof(struct rte_mbuf, metadata) and drop the member.

lib/eal/common/eal_common_config.c: rte_mbuf_metadata_size is
exported with RTE_EXPORT_SYMBOL and lands in DPDK_27 (stable).
New API must be experimental. Same for rte_mbuf_metadata_size_get(),
rte_mbuf_size() and RTE_MBUF_DYNFIELD_F_METADATA. Exporting a bare
variable as stable ABI is worse than a function; it freezes the type
and the symbol location.

drivers/net/cnxk, drivers/event/cnxk: the hardware skip fields are
narrow and roc_nix_rq_init() only checks 8-byte alignment, not range:
  wqe_skip   2 bits, in 128B lines  -> rte_mbuf_size() <= 384
  later_skip 6 bits, in 8B units    -> mbuf + meta + priv <= 504
  first_skip 7 bits, in 8B units    -> mbuf + meta + priv
                                       + headroom <= 1016
With --mbuf-metadata-size=384, wqe_skip becomes 4 and is truncated to
0. With metadata 256 and priv_size 128, later_skip is 512 and is
truncated to 0. Hardware then writes the WQE/packet over the mbuf.
The driver must reject configurations that do not fit, as was done
for octeontx.

Warning

EAL defines and exports a symbol named rte_mbuf_*, and it is declared
extern in both eal_private.h and rte_mbuf_core.h. Follow the existing
--mbuf-pool-ops-name pattern: EAL stores the value and provides a
getter (rte_eal_mbuf_user_pool_ops() equivalent); mbuf owns any
mbuf-named symbols.

Fast path cost. rte_mbuf_size() turns a compile-time constant into a
load of a global (through the GOT in shared builds) in
rte_mbuf_to_priv(), rte_mbuf_from_indirect(), rte_mbuf_buf_addr() and
rte_pktmbuf_detach(), all inline and used per packet. cnxk Rx vector
paths now do vdupq_n_u64(rte_mbuf_size()) inside the burst loop, and
the cn9k get_work asm needs an extra register load per event. The
cnxk paths should cache the value in rxq/ws at setup like data_off.
Need l3fwd or testpmd numbers with the option unset, on cnxk at
least, before this goes in.

lib/eal/common/eal_common_options.c: upper bound of UINT16_MAX is not
justified. Beyond the cnxk limits above, examples/fips_validation
DEF_MBUF_SEG_SIZE is UINT16_MAX - rte_mbuf_size() - headroom and
wraps for large values. Cap the option at a small number of cache
lines and document the limit.

drivers/net/cnxk/cn10k_rx.h nix_cqe_xtract_mseg(): the rx_inj block
was reindented one tab too deep; it is still inside the same if.
Only the two wqe assignment lines need to change.

Too much in one patch. Put the mbuf helpers first, then the
conversions, then the feature:
  1. mbuf: add rte_mbuf_size() returning sizeof(struct rte_mbuf),
     no behaviour change
  2. convert libs, apps and examples
  3. convert drivers (one per driver family, so maintainers can ack)
  4. add the EAL option, metadata dynfield flag, driver rejections
     and docs
Patches 1-3 are a no-op and can be reviewed and merged on their own.
Patch 4 is then small enough to review for what it actually changes.
It also makes it bisectable when a driver conversion is wrong.

Many of the conversions open-code rte_mbuf_size() where an existing
helper fits: RTE_PTR_ADD(m, rte_mbuf_size()) is rte_mbuf_to_priv(m),
and mbuf + rte_mbuf_size() + priv_size is rte_mbuf_buf_addr(). Use
the helpers so drivers stop depending on the layout directly.

Info

Unrelated whitespace churn: blank line removed in
drivers/mempool/octeontx/meson.build, in the release notes Known
Issues section, and in test_mbuf(). Drop these.

lib/mbuf/rte_mbuf_dyn.c: the "check if this offset can be used"
comment now sits above dynfield_in_metadata() instead of
check_offset().

drivers/mempool/octeontx: the check rejects every fpavf pool, not
just pktmbuf pools. mp->private_data_size is known at alloc time, so
the check could be limited to pools carrying
rte_pktmbuf_pool_private. Not required since net/octeontx is the only
user that cares.

app/test/test_mbuf.c: with metadata configured, dynfield_fail_big
(size 128) passes the size check and fails only because no free
space exists, so the size limit path is no longer tested in the
metadata run.

Any out-of-tree code using (m + 1) or sizeof(struct rte_mbuf) to find
private data silently breaks when a user adds this EAL option. That
belongs in the API changes section of the release notes, not only
under New Features.
