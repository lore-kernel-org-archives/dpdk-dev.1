Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2784CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 16:42:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D383B4026C;
	Fri,  2 Oct 2026 18:42:30 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id C96DB4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 18:42:29 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e4a2daa7d7so2173485ad.1
 for <dev@dpdk.org>; Fri, 02 Oct 2026 09:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790959349;
 x=1791564149; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=areue978erZLlhlHQkxgJo8oVgABJr/r8/kFkFS+310=;
 b=dE0EIMAMT0IiHkzCPKw2048ERxWs8E7whnvxRULW8vaKKLrmBhav7OsvVJZlxmyOoA
 j28JetzNsTPujLQi4lLktyR1GNP2u6Tg3MeYnapADoZwkXhJOs3I9pJreTtS/xi/rKSw
 rm+0hu3NXzFb4Vk2hPz9wKP+Nq5R985jNl4z7RRdbW/hg1yJYyyCxc2qq+fUhfMHcVyT
 8inqwQbjbck26We5uT8Jm4BPWLc3yVeFr6dedeJNrFan+FvyuaUohMC8cfQiVtWA72Nq
 iiKth0K6LV6MgibKT/hzwHBjPhFTbRT47+dDh3n+L1IZ0qQW6noLUNXnACjc3ZqMPsc/
 3gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790959349; x=1791564149;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=areue978erZLlhlHQkxgJo8oVgABJr/r8/kFkFS+310=;
 b=WyBHk+YObYkrCAKvzTLn4GGTDLjz1vk+doP1V6GcYE3FkePs44joNvBpq/a7nCPKXg
 P/sA6og8+1Pb5iZsCjHRzQOqKJaInardHVBZaUREhBKDGjn/B/FGDeG7DNRBve6Iqbyt
 ol+O3Vh060QHLyossH8X48j4j3WCGLlsp0bis9cRQeDgC9U1mCbYn7l1YjqH9FUqq1T5
 qsCSdwGLyWpCyM2Y+1uB+/p76PEO/Mlpn9mSv07aZesoHklRMhtupEeVxcbT7OoPtnIz
 fK+C/6xoSVyuON3Kb5zd0ShhPI6J+nQZm5sur3ol2at/TXhI9v7sAETos1N+Ys7JFUTW
 fV2A==
X-Gm-Message-State: AFq9FYKo1Q5MQK48P7bLk8Rlpi0kRpcy6EW4ig/YLZA2k+pG3r4fLIU5
 vZ5a3qnmEpcGYcldLoaetjZ/JChon7Ss7VG+fiUNUkLTbFQ57EDvMw02n+B7SBecwY0=
X-Gm-Gg: AYBFou1ogZ5oaw62kb5EhV3Mz1CYzyzdKppXw6NXRpNloJnTqD9l/4PM3b/uxIudsgK
 BRa4NIlRjhIaG6i0W/UHLeDhAsZs85a6pfIGQdkRyHhZizrwLak6c8eyYQg6du6yF9vbu6o+RYG
 wKRqPxTF09AdIMEgjrNjbxLpr6CXEDZ2zQP7+KyRGdK1bNW7GSEPHirFx4TjrFgnL3LF/S99POn
 f5rHvtqiVzd0JGAxVXjDSj2nkMgXzptDJnz5tSubkc4raAiJqUQDlDRAezrW1OsBz2Q34ki08cq
 RmUmJerOKGHHy+7BZ5/DWfVpIfabkqCMpHC3a1645lvQ7mWgttj3ngppN5y8wYFTRtqICDWCcuq
 ttOrUGXDabey/+ZjX9yjGoB20DPXQL0LbsncrQ6A4Qfgg3tyFCL3TWF+s3jw/kNJK5vrxZj6h72
 8PBIV+vqDvmugSxbPPSW+zOfM/XU47DnaHuEuH0K22MYp/pvokqgHHQNjDzKya1MihMYPooRByr
 f1O7VtSMUmEcgtPC+HIDpUKROQTkPHBk+VGxUYp
X-Received: by 2002:a17:903:2f84:b0:2da:f7ad:cfea with SMTP id
 d9443c01a7336-2e4ea0e92c2mr1623945ad.8.1790959348677; 
 Fri, 02 Oct 2026 09:42:28 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f706617sm10296745ad.63.2026.10.02.09.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 09:42:28 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:42:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5-S2 00/13] net/dpaa2: flow, meter and parser features
Message-ID: <20261002094129.60fbe122@phoenix.local>
In-Reply-To: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
References: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
 <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
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

On Thu,  1 Oct 2026 13:02:54 +0530
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
> Note that patch 12 removes the soft parser driver and, with it, the
> rte_flow VXLAN and eCPRI pattern items that were only accepted while an
> SP image was believed to be loaded. Both items are dropped from the dpaa2
> feature matrix and a release note is added.
> 
> Every commit builds cleanly (including the aarch64 DPAA cross build with
> -Werror) and the series is bisectable.

Still have several open issues in AI review.

[PATCH v5-S2 00/13] net/dpaa2: flow, meter and parser updates

Applied to main (062b389). Patches 5 and 12 conflict in
release_26_11.rst; applied with release notes excluded. Rebase.
Per-commit build with -Dwerror=true passes for all 13 patches
(x86, gcc, dpaa2 drivers only).

Series-level:
The v4 review comments for patches 5, 7, 8 and 10 were pasted into
the commit messages as "Known limitations and follow-up items"
instead of being fixed. Known regressions and bugs in new code are
fixed before merge, not listed as TODOs. Several of the pasted items
describe code no longer in the patch. Remove these sections and fix
the issues.


Patch 1/13 net/dpaa2: fix integer overflow in CCSR region mapping

Info: the commit message says the old round-down did not account for
offset + len crossing a page boundary, but "len = len & page_mask" is
kept. All callers pass page-aligned addresses and touch only the
first page, so nothing faults today. Map
RTE_ALIGN_CEIL(offset + len, page_size) or drop the sentence.


Patch 3/13 net/dpaa2: support larger burst size

Info: on non-LX2160A or MC < 8.7 the accepted burst drops from 65536
to 0xF7FF. Say so in the commit message.


Patch 5/13 net/dpaa2: support meter and policing

Error: nothing in the tree calls dpni_set_rx_tc_policing() after this
series. Every rte_mtr op returns success and only edits the software
lists. Profile mode, unit, rates and policy red_drop are stored and
never read. dpaa2.rst and the release note advertise policing that
does not happen. Implement it or drop the patch.

Error: the "Known limitations" section describes code that is not in
this patch (the /1000 conversion, the meter_create HW error sign,
meter_destroy ignoring the dpni return).

Warning: profile_add and policy_add have no duplicate-ID check.

Warning: the profiles, policies and meters lists are never freed on
dpaa2_dev_close().

Warning: s_dpaa2_mtr_capa is file-scope and written under the
per-device meter_lock, so two ports race on it. s_err_msg is a shared
static buffer returned through error->message. Use a local capa and
constant strings.

Warning: capabilities still advertise color_aware_trtcm_rfc2698 and
color_aware_trtcm_rfc4115.

Warning: dpaa2.ini adds "Rate limitation = Y", which the commit
message itself says is wrong.

Warning: dpni_set_rx_tc_policing_v1() is declared and never defined.
DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS is unused.

Info: of the four release note bullets, only metering belongs to
this patch. Flow classification belongs with patch 4.


Patch 7/13 net/dpaa2: set default flow miss action per device

Error: default_flow = RTE_MIN(fs_entries, dist_queues) - 1 sends FS
misses to DPNI flow dist_queues - 1. Rx queues map
flow_id = dist_idx % num_rxqueue_per_tc over all DPNI queues, so that
flow is ethdev Rx queue dist_queues - 1 of the TC. An application
that configures fewer Rx queues never polls it. Once a QUEUE or DROP
rule exists, unmatched traffic is lost. Previously it went to flow 0.
fs_entries is a table size, not a queue count.

Warning: the commit message says default_flow is "initialised to 0".

Warning: the commit message says a release note "should be added".
Add it in this patch.


Patch 8/13 net/dpaa2: identify Rx mbuf hash information by FLC

Warning: "Known limitations" describes RX_FDIR_ID and a raw FLC word
in hash.fdir.hi. The code sets RTE_MBUF_F_RX_FDIR and writes
hash.sched. Remove the section.

Info: hash.sched is the rte_sched Tx field. The TC/flow it carries
is the Rx queue the application already polled.


Patch 9/13 net/dpaa2: add minimum key size support

Warning: the removed comment says MC only supports 56-byte entries.
State which MC version supports 24 bytes and gate on
dpaa2_dev_cmp_dpni_ver() as patch 3 does.


Patch 10/13 net/dpaa2: restructure dpaa2 parser processing

Error: Rx timestamping is broken. The dynfield write is removed.
dpaa2_enable_ts[] is set in dpaa2_eth_dev_configure() and never read.
dpaa2_dev_rx_common() reads a dynfield nothing writes. Listing it as
a known limitation does not make it acceptable.

Error: on non-LX2160A, dpaa2_dev_rx_parse() no longer sets L3/L4
checksum flags for the common IPv4/IPv6 TCP/UDP cases. The switch
returns directly, and only parse_slow sets the flags. Before, the
flags were set at function entry for every packet. Bad checksums are
no longer reported. The commit message claim that the observable
result is the same is false.

Error: dpaa2_dev_rx_parse_frc() starts with
packet_type = RTE_PTYPE_L4_NONFRAG (0x600) and ORs in L4 values.
L4_TCP and L4_ICMP become 0x700 (L4_IGMP). L4_UDP and L4_SCTP
collapse to NONFRAG. Per the commit message, ICMP and SCTP now always
take this path on LX2160A, so every ICMP packet is reported as IGMP.
GTPU/GTPC report L4 NONFRAG instead of UDP. Non-VLAN frames get no
RTE_PTYPE_L2_ETHER. Assign the L4 type rather than OR it.

Warning: VLAN-tagged frames on LX2160A now take the fast switch with
the VLAN bit stripped and report RTE_PTYPE_L2_ETHER. Before, they
went to parse_slow and reported L2_ETHER_VLAN/QINQ. This is an
undescribed functional change.

Warning: dpaa2_dev_rx_mbuf_sched_set() now also runs on the
non-LX2160A path, so those SoCs report RX_RSS_HASH from flc_hi for
the first time. This is not described.

Warning: the parser dump is dead. The env var sets
dpaa2_print_parser_result, which is never read. The helper tests
DPAA2_RX_PRINT_PSR_RESULT_FLAG, which nothing sets. Once wired up,
its RX_FDIR branch walks rx_vq[0..MAX_RX_QUEUES) and dereferences
rxq without a NULL check, but only nb_rx_queues entries exist.

Warning: psr_dynfield_offset is never registered, so
dpaa2_dev_rx_annot_prefetch(), dpaa2_dev_rx_parse_offset() and struct
dpaa2_dyn_rx_protocol_pos are dead. sp_protocol is never assigned,
so the GENEVE block is dead. dpaa2_parser_ecpri_extract() and
dpaa2_protocol_psr_bit_offset() are unused.


Patch 12/13 net/dpaa2: remove unused soft parser driver

Warning: rte_flow_create() does not call dpaa2_dev_verify_patterns().
In dpaa2_generic_flow_set() the default case sets ret = -ENOTSUP and
breaks only out of the switch. The loop continues, and later item and
action calls overwrite ret. With the VXLAN case gone, a pattern
eth/ipv4/udp/vxlan/eth is installed with VXLAN ignored and the inner
eth handled as in_tunnel. Return from the default case.

Info: soft parser leftovers remain: priv->ss_offset, ss_iova,
ss_param_iova, sp_protocol, enum dpaa2_ecpri_fafe_type and
DPAA2_ECPRI_MAX_EXTRACT_NB.
