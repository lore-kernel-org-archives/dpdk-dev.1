Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B8EC982FF
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 13:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C79E0402B0;
	Tue, 22 Sep 2026 15:39:54 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 70DED400D5
 for <dev@dpdk.org>; Tue, 22 Sep 2026 15:39:53 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747eb79f7so28904965ad.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790084392;
 x=1790689192; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tpfQyx3/WB5+0fWQ0b7/Iv5EVeLK5tCs0Mv7Mnx5kt0=;
 b=QAz3JR4ZYrKupwTk8D3Ik//oXYPFtxAHJ91Mrlh17ZJI/3AepSOg7sm4KoymIi615g
 sqc2TloFVyVicT839BbccRUBU0kbb2nPLLmIv6RGld4ZLDSEJ9DnZI7iErH9qMzg7HRC
 lvSHadsyPuEeEpn2f9xsXP6x3a0nG8jDdDezubdTlSc+V0LaZ3R1BqmzHPBLsSK56q7A
 G5x9JUgNlbnwnweqherCLo98Q+B3VLW2Jm9N84jzVk8jZACevyMgsB1Eo9JKbeft/4g3
 jD9F665bN6ixGMuFI0X+USJN3JtjEX2w+IdE4OBwN5eonIQfmLjTlt593SuWpofh6M1B
 3+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084392; x=1790689192;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tpfQyx3/WB5+0fWQ0b7/Iv5EVeLK5tCs0Mv7Mnx5kt0=;
 b=uyOJCqfvhTOG1EijImM7hwb0iuBdXnpFp9l8U/PDb/0eycRPHFlXX8ktM/cdblpdSz
 W9fqqMq6RVWMEkdiOcwQvR7edmLy2Wj8qdHnCNEdXwmbk0b316j1Istc+dSkPoTfnlTr
 gJd4CfGeGpMOWD9/9aUyqU6TWHm2KI/jAIeYIYan9H3B1/F73g0ZvxOZshKk8I50k/Sn
 gTQyhDNipOmgoROcviL5AeBF07KLvB3QOykkvGguSA5pYQDfAelXSoKr+pnAYs4BVL5y
 PPfvDm8aCPQSbJTEsIAUX/J6TCUgh0II9CZaZFWpvQGrdY1bn0PFkq23f8KIfifl7djE
 2Klg==
X-Gm-Message-State: AFuF++ktCri8XhMrzIMziObXIInVbOA7bVbA2uK839FFeY2+M+IMTSY5
 P7mMuu78HkXJ6FDjUQ62qGynMzl4yhfGkKDikLAhhNRsVFYRYoRz5HvyD63T0Co1tYA=
X-Gm-Gg: AYBFou3rVl/avWNVuXDJo2nKVKRj1wdWxhOcHz8kGtRynGJ9+n66T7OcxGjkgLIp33T
 qHbjIks82ZaCIegQpGfDKBVqM9riA0xq7KQFTR2kFG0H879P3LBfKg5ki27PCvavpj2t1NnqiSG
 V59lXKHNPGT7qBON/mwHs/DXnuCqwGHf5VYMEmL+Htc2EQ4kN1GvvScdqEOiktTK+TVcPemA72L
 8CDMsl2RNBPZhLyVXTugntGT5q/6CQ+iXSe1XaARNjmCtGUjLibo7Yp5aJmfpz9/f2arhY7M9tA
 F6ONTHaxaUT5YFrloC1hXYWHYn3fP6nkFe0YR3H/Wg9lx8UozV/dxbhqH/hpHE/3yfCl+rVpgTb
 dsmAIKVYmEG61g8nCPgNhoXalDBYW35ld2VY3PbWoPjfhkuovrwNW6+lbgaTlndL0RcxyChwUL1
 2giDA//tfvFvVRvque8BumJE7Gtgdc1vvanAN/CkrlScmeZ5zvXCPY5WJXvomFtoKeIob2xGxM5
 TYIR43h2Y/yXakG7HsfXNqbiIq1QxSFktl6HZgL
X-Received: by 2002:a17:903:98d:b0:2dd:ad73:c984 with SMTP id
 d9443c01a7336-2df609d501cmr14310395ad.28.1790084392156; 
 Tue, 22 Sep 2026 06:39:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d0563eesm10347905ad.69.2026.09.22.06.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:39:51 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:39:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4-S2 00/13] net/dpaa2: flow, meter and parser features
Message-ID: <20260922063950.30337054@phoenix.local>
In-Reply-To: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
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

On Tue, 22 Sep 2026 15:25:15 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This is the second of four series upstreaming the missing NXP dpaa2
> driver changes. It does not depend on series 1 and can be applied
> independently. It adds the net/dpaa2 flow, metering and parser features:
> 
> - fix an integer overflow in the CCSR region mapping,
> - set Tx confirmation on device init and support a larger burst size,
> - support MPLS and PPPoE flow distribution, meter and policing, and the
>   flow drop action, with a per-device default flow miss action,
> - identify Rx mbuf hash information by FLC and add minimum key size
>   support,
> - restructure the parser processing, parse tunnel and fragmented packet
>   types, remove the unused soft parser driver and rename the Rx queue
>   flags.
> 
> Every commit builds cleanly (including the aarch64 DPAA cross build with
> -Werror) and the series is bisectable.
> 
> Gagandeep Singh (7):
>   net/dpaa2: set Tx confirmation on device init
>   net/dpaa2: support larger burst size
>   net/dpaa2: support MPLS and PPPoE flow distribution
>   net/dpaa2: support meter and policing
>   net/dpaa2: support flow drop action
>   net/dpaa2: set default flow miss action per device
>   net/dpaa2: identify Rx mbuf hash information by FLC
> 
> Hemant Agrawal (4):
>   net/dpaa2: fix integer overflow in CCSR region mapping
>   net/dpaa2: add minimum key size support
>   net/dpaa2: restructure dpaa2 parser processing
>   net/dpaa2: parse tunnel and fragmented packet types
> 
> Jun Yang (2):
>   net/dpaa2: remove unused soft parser driver
>   net/dpaa2: rename Rx queue flags
> 
>  doc/guides/nics/dpaa2.rst               |    1 +
>  doc/guides/nics/features/dpaa2.ini      |    3 +
>  doc/guides/rel_notes/release_26_11.rst  |    4 +
>  drivers/net/dpaa2/dpaa2_ethdev.c        |   84 +-
>  drivers/net/dpaa2/dpaa2_ethdev.h        |  227 +++-
>  drivers/net/dpaa2/dpaa2_flow.c          |  397 ++++--
>  drivers/net/dpaa2/dpaa2_meter.c         |  637 ++++++++++
>  drivers/net/dpaa2/dpaa2_parse_dump.h    |  374 ------
>  drivers/net/dpaa2/dpaa2_parser_decode.h | 1542 +++++++++++++++++++++++
>  drivers/net/dpaa2/dpaa2_pmd_logs.h      |   67 +
>  drivers/net/dpaa2/dpaa2_recycle.c       |   40 +-
>  drivers/net/dpaa2/dpaa2_rxtx.c          |  334 +++--
>  drivers/net/dpaa2/dpaa2_sparser.c       |  137 --
>  drivers/net/dpaa2/dpaa2_sparser.h       |  202 ---
>  drivers/net/dpaa2/dpaa2_tm.c            |   17 +-
>  drivers/net/dpaa2/mc/dpni.c             |   11 +-
>  drivers/net/dpaa2/mc/fsl_dpni.h         |   11 +-
>  drivers/net/dpaa2/mc/fsl_dpni_cmd.h     |    6 +-
>  drivers/net/dpaa2/meson.build           |    2 +-
>  19 files changed, 2999 insertions(+), 1097 deletions(-)
>  create mode 100644 drivers/net/dpaa2/dpaa2_meter.c
>  delete mode 100644 drivers/net/dpaa2/dpaa2_parse_dump.h
>  create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h
>  delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
>  delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h
> 

Lots of AI feedback on this.
Marking this as changes requested.
AI can be wrong, if so just respond on list.

[PATCH v4-S2 00/13] net/dpaa2: flow, meter and parser updates

Applied to main (6bbb7b3). Per-commit build with -Dwerror=true passes
for all 13 patches (x86, gcc 13, dpaa2 drivers only).

Series-level:
Patch 10 claims "no functional change" but drops Rx timestamping,
breaks the parser dump, reorders checksum flag handling, and adds VLAN
TCI extraction, GENEVE ptype, a parser-offset dynfield and
rte_mbuf_sched_set() on Rx. Split it into a pure move and separate
functional patches.

Patch 12 removes user-visible rte_flow support (VXLAN, eCPRI items)
without saying so.


Patch 1/13 net/dpaa2: fix integer overflow in CCSR region mapping

Warning: the new "len & page_mask == 0 -> return NULL" check is a
regression. All four callers pass 4096 or 6656 bytes. On a 64K page
kernel, len & page_mask is 0 and the mapping now fails, where the old
code bumped len up to PAGE_SIZE. The existing round-down is also
wrong. It ignores offset and truncates len. Map
RTE_ALIGN_CEIL(offset + len, page_size) and drop the len == 0 path.


Patch 4/13 net/dpaa2: support MPLS and PPPoE flow distribution

Warning: the MPLS extract passes size 3 (sizeof(label_tc_s)) for
NH_FLD_MPLS_MPLSL_1 with DPKG_FULL_FIELD. The driver key profile
must match the width firmware extracts for that field. If MC extracts
the 4-byte LSE, every key field placed after it is off by one byte.
Confirm against the MC field size, or use an offset/size extract.


Patch 5/13 net/dpaa2: support meter and policing

Error: wrong rate units. rte_mtr cir/pir/eir are bytes/s in byte mode
and packets/s in packet mode. DPNI takes Kbps or packets/s.
profile->cir / 1000 yields kilobytes/s, which is off by 8x. In packet
mode it divides a packet rate by 1000. cbs/ebs are also truncated
from uint64_t to uint32_t without a check.

Error: meter_create returns a positive value on HW failure.
dpni_set_rx_tc_policing() returns a negative errno, and
-rte_mtr_error_set(error, ret, ...) negates it. It also sets rte_errno
negative. Pass -ret.

Error: meter_profile_update and meter_policy_update only change the
software list. Hardware is never reprogrammed, but success is
returned.

Warning: mtr_id is used directly as the Rx TC, (uint8_t)mtr_id, with
no check against priv->num_rx_tc. mtr_id 256 aliases TC 0. Validate
the id, and document that a meter is per-TC, not attachable via an
rte_flow METER action.

Warning: capabilities advertise color_aware_trtcm_* but there is no
input-color handling.

Warning: profile_add and policy_add drop meter_lock between the
duplicate-ID check and the insert, so the lock does not prevent
duplicates.

Warning: meter_destroy ignores the dpni_set_rx_tc_policing() return.

Warning: features/dpaa2.ini "Rate limitation" is per-queue Tx rate
limiting (rte_eth_set_queue_rate_limit), not rte_mtr. Remove it.

Info: the release note line "flow classification on more protocol
fields" belongs with patch 4.


Patch 7/13 net/dpaa2: set default flow miss action per device

Warning: the commit message says default_flow is "computed at probe
time as the lowest priority flow of the FS table". The code sets it
to 0 and never changes it, so the only behavior change is removal of
the env override. Fix the message or implement it.

Info: DPAA2_FLOW_CONTROL_MISS_FLOW is removed. Add a release note.


Patch 8/13 net/dpaa2: identify Rx mbuf hash information by FLC

Warning: RTE_MBUF_F_RX_FDIR_ID is set without RTE_MBUF_F_RX_FDIR,
contrary to the commit message. Applications test RX_FDIR first. The
driver's own dump helper (patch 10, dpaa2_dev_rx_print_parser_result)
also tests RX_FDIR, so that branch is dead.

Warning: hash.fdir.hi carries the raw FLC low word, including stash
bits and the mark bit. It is not a usable filter ID. User-visible IDs
belong to RTE_FLOW_ACTION_TYPE_MARK.


Patch 10/13 net/dpaa2: restructure dpaa2 parser processing

Error: Rx timestamping is broken. The dpaa2_enable_ts[] write of
annotation->word2 into the timestamp dynfield, and the
dpaa2_timestamp_rx_dynflag set, are removed from both parse paths and
not re-added. After the series, dpaa2_enable_ts[] is set in
dpaa2_eth_dev_configure() for RTE_ETH_RX_OFFLOAD_TIMESTAMP but never
read, and dpaa2_dev_rx() reads a dynfield nothing writes.

Error: dpaa2_dev_rx_mbuf_sched_set() writes m->hash.fdir.hi and then
calls rte_mbuf_sched_set(). hash.sched overlays hash.fdir.
traffic_class and color land in bytes 4-5, so fdir.hi is corrupted
while RX_FDIR_ID is still flagged. hash.sched is a Tx/rte_sched
field, not an Rx report. Pick one.

Warning: dpaa2_dev_rx_parse() now takes the parse_slow return before
the L3/L4 checksum flags are set. Previously they were set first.
parse_slow sets the checksum flags itself, so confirm the two
paths agree and state it, or restore the order.

Warning: the parser dump is dead. The DPAA2_PRINT_RX_PARSER_RESULT env
still sets the global dpaa2_print_parser_result, but the new helper
tests DPAA2_RX_PRINT_PSR_RESULT_FLAG in priv->flags, which nothing
sets. Remove the orphaned global and set the flag, preferably from a
devarg.

Warning: priv->psr_dynfield_offset is initialized to -1 and never
registered, so dpaa2_dev_rx_annot_prefetch(),
dpaa2_dev_rx_parse_offset() and struct dpaa2_dyn_rx_protocol_pos are
dead code. priv->sp_protocol is never assigned (and after patch 12
cannot be), so the GENEVE/inner IPv4 ptype block in rx_parse_new is
dead as well. Drop them or add the code that enables them.

Warning: IPV4/6_EXT, SCTP and ICMP fast-path cases are removed from
rx_parse_new and now go through dpaa2_dev_rx_parse_frc(). This is a
functional change and must be described.


Patch 11/13 net/dpaa2: parse tunnel and fragmented packet types

Warning: dpaa2_supported_ptypes_get() is not updated. RTE_PTYPE_L4_FRAG,
TUNNEL_ESP, TUNNEL_GTPU and TUNNEL_GTPC are reported in mbufs but not
advertised.

Info: GTP runs over UDP. The GTPU/GTPC cases omit RTE_PTYPE_L4_UDP.

Info: the commit message says the new types are mapped "in the
slow-path parser". They are in the rx_parse_new fast switch.


Patch 12/13 net/dpaa2: remove unused soft parser driver

Warning: this is not removal of unused code. dpaa2_dev_verify_patterns()
no longer accepts RTE_FLOW_ITEM_TYPE_VXLAN or ECPRI, which were only
permitted when the soft parser was loaded. features/dpaa2.ini still
lists vxlan and ecpri as Y, and dpaa2_configure_flow_vxlan/_ecpri plus
their switch cases remain as unreachable code. Remove the ini entries
and the dead handlers, drop the DPAA2_ENABLE_SOFT_PARSER env var, and
add a release note.

Info: the commit message ("only supports to be loaded before Linux
starts") does not explain the change. Say that the SP must be loaded
by firmware at boot, so runtime loading from the PMD never worked.


Patch 13/13 net/dpaa2: rename Rx queue flags

Info: the commit message says the rename "prepares the flag namespace
for the Tx confirmation rework that follows". Nothing follows in this
series. Drop the sentence.
