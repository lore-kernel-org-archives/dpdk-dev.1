Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F78C5AD55
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Aug 2026 21:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A8A7402E8;
	Sun,  9 Aug 2026 23:00:14 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 5892D40298
 for <dev@dpdk.org>; Sun,  9 Aug 2026 23:00:13 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so828098a91.2
 for <dev@dpdk.org>; Sun, 09 Aug 2026 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786309212;
 x=1786914012; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hbqn09j1nGgOjAJyC/3tFw/2oucwCfrHN61mVwtIk0c=;
 b=z9rFhYBqJ7oDI7IylWZ7I5RYxD85+Z+jniQNdRtX0UAnk35hA8xG/7aMT7rz1OfhHG
 S+FIN+V56gIsPpycVhNw3DXzG48t8MWzlBHjMs7QEXU6tzWT7YxUg5maX4SbZu4ltx5m
 1t9tuKM24YmLnShKWacq2kSrkqNW/8/ldTVPZ0oHaBduK8cwg1iqf+/AkTHMDMnZHcI6
 lQJp3eb1Ts29qQhW5f4Mh0/s+WAZD9E8XD1cJqzIw8NN4dGvElzet9gqy/PSi8uvRt5s
 +/OFCN/vpSJ8/WRApkDHVC9qwxxaCkC6bgO+xpGMrniaI1kSi/eIitRmch+2730yJ/1i
 FIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786309212; x=1786914012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hbqn09j1nGgOjAJyC/3tFw/2oucwCfrHN61mVwtIk0c=;
 b=VCm29GCrXhZ7/r5tVx+j9/gNCdHTkdBri3aZ1P7rsJi+7WiGHqFUA/TnzRxT7az5Rd
 jG3JJM5WqdpTweie8pwckihk/mqHuPjsAAe6autLqs1zHFNqgnnCMfCDEwczj7ke0lym
 YPTrZAPY7sbWA+j2ZG1bjzhS48t5hgiBbJuMr9htLe0FeBA424swdgF1HGAvi5YgpnyZ
 uq7g3C34XnHEwOmwuShfHE+mmMpshd5HOGS7gGBa5nmDEJ35/KFf06FP3To7HSo7EY7T
 shraXwEixMzFfOcCKHLKdtfgPqV2aMysGbl+NdJkoJ5eXZ685sXzIPB3G1d8s6lEnY+g
 XVog==
X-Gm-Message-State: AOJu0YwvVgrXQ/hD22pg5wNR4Fn76cDNJLmi3OmxHsylQ58x5//i6ug6
 VxNA78BMEuJDbzwRVSZRIkjglpNE+pxPcg4bBTHSNzM1E+Q/63MXiGqy5Jow4hvdRgI=
X-Gm-Gg: AR+sD10lIiP+3lAzDKWzoh7yjqhdU/1H2QOnebJrhkRt2x7blvB2bZJ+3XMTnFRlI4r
 Hxl36nHhWZNWXuvYQnjX9Mnw/0O1f9L9uYWw7PsoBTXNonlfnedsgBETPRtorxPP5lgIH96D3I+
 HdzwT6ccT7RtYVj+Xz1hrv+7ULgyrqPg4NK2KktBCzg0t/SABa9sa8s3o3T4Foh/nztjILZguu/
 6ilLmS0OfVENhvjLIkw1SA79ixwE0CxeZihG6+dR8SNRoFlgmSmv9RjZsNPvJYzCzwRmiMcA35A
 EFTK1TygUouyGk0xCQguQ9IYuLaaUPWoZi6iP29ASgJCjMtG6MtgmvJJ2SqjSA93K+31FdbZddd
 5D1MbjZ30nQBtJC/UU7BVQTVEmooHtrs9TyF5syudZU2fVcKVOSf3PMzTN7hofzHwGqQfeGNO4l
 TBff52KHZLqdqhPO8a46I+G/zyVQjeWPziwYUnqXpjMXs4M+I1ksfOrNdSKOf4VSZR48jW5pP7/
 Vywc2a9qnQvyQsOfBQGi1hiEWdwyg==
X-Received: by 2002:a17:90b:1e43:b0:392:7f74:58c9 with SMTP id
 98e67ed59e1d1-3927f745de2mr10629977a91.15.1786309212171; 
 Sun, 09 Aug 2026 14:00:12 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm39719418eec.5.2026.08.09.14.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 14:00:11 -0700 (PDT)
Date: Sun, 9 Aug 2026 14:00:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <g.singh@nxp.com>
Cc: dev@dpdk.org, hemant.agrawal@nxp.com
Subject: Re: [PATCH v4 00/14] net/enetc: add new features for ENETC4 on i.MX95
Message-ID: <20260809140008.2141eb88@phoenix.local>
In-Reply-To: <20260807112623.1402493-1-g.singh@nxp.com>
References: <20260807070241.1151161-1-g.singh@nxp.com>
 <20260807112623.1402493-1-g.singh@nxp.com>
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

On Fri,  7 Aug 2026 16:56:09 +0530
Gagandeep Singh <g.singh@nxp.com> wrote:

> V4-changes:
>  - fix doc build issue: WARNING: undefined label: pmd_build_and_test
> 
> v3-changes:
>  - fix doc build issue.
>  - fix compilation issue on fedore:43-gcc-minsize
> 
> V2-changes:
>  - compilation fixes.
> 
> V1-changes:
> This series adds new PMD features to the ENETC4 driver targeting the
> NXP i.MX95 NETC IP.
> 
> The series covers:
> 
>  - KEEP_CRC Rx offload: preserve the Ethernet FCS in the receive buffer.
>  - TSO: TCP Segmentation Offload for the VF Tx path.
>  - RSC/LRO: hardware Receive Segment Coalesce for PF and VF Rx paths.
>  - Link speed code: extend the PF-to-VF mailbox field from 4-bit to
>    8-bit to support speeds beyond 10G.
>  - Firmware version: report the NETC IP version via fw_version_get.
>  - Register dump: dump SI, port (PF) and BD ring registers.
>  - Ring parameters: implement rxq_info_get / txq_info_get for the VF.
>  - Link-up interrupt: refresh the cached link speed on each VF link-up
>    interrupt so that link_update returns the current speed immediately.
>  - Stats reset: software snapshot/delta approach for VF counter reset.
>  - Per-queue Rx interrupt: MSI-X per-queue Rx interrupts for the VF,
>    enabling interrupt-driven receive with l3fwd-power.
>  - SI VLAN: hardware port VLAN insertion/removal for PF and VF.
>  - VF link status bitmask: switch VF link status to bitmask encoding
>    to align with the PF and newer kernel driver conventions.
>  - TX PAUSE: VF sets Rx congestion mode when the PF signals TX PAUSE
>    negotiated on the wire; adds Flow control = Y to enetc4.ini.
>  - WRR Tx scheduler: per-ring WRR weights via enetc4_txq_wrr devarg.
> 
> Gagandeep Singh (14):
>   net/enetc: add KEEP_CRC offload support for ENETC4
>   net/enetc: add TSO support for ENETC4 VF
>   net/enetc: add RSC (hardware LRO) support for ENETC4
>   net/enetc: extend link speed code field to 8-bit for PF-to-VF message
>   net/enetc: support firmware version get for VF
>   net/enetc: support registers dump
>   net/enetc: support ethtool ring parameters
>   net/enetc: refresh link speed on VF link-up interrupt
>   net/enetc: support stats reset for VF
>   net/enetc4: add per-queue Rx interrupt support for VF
>   net/enetc4: add SI-based port VLAN insertion and removal
>   net/enetc4: update VF link status to bitmask encoding
>   net/enetc4: enable TX PAUSE via VF RX congestion mode
>   net/enetc4: add WRR Tx scheduler devarg for VF rings
> 
>  doc/guides/nics/enetc4.rst             |  77 +++
>  doc/guides/nics/features/enetc4.ini    |   8 +
>  doc/guides/rel_notes/release_26_11.rst |  19 +
>  drivers/net/enetc/base/enetc4_hw.h     | 129 +++-
>  drivers/net/enetc/base/enetc_hw.h      |   6 +
>  drivers/net/enetc/enetc.h              | 135 ++++-
>  drivers/net/enetc/enetc4_ethdev.c      | 402 +++++++++++--
>  drivers/net/enetc/enetc4_vf.c          | 779 ++++++++++++++++++++++---
>  drivers/net/enetc/enetc_rxtx.c         | 529 ++++++++++++++++-
>  9 files changed, 1939 insertions(+), 145 deletions(-)
> 

Still lots of issues, the biggest one is that not each patch
builds; not bisectable.

More extensive AI review.

ENETC4 v4 series review - 14 patches

No Reviewed-by.  The headline finding from the previous round is
unchanged: 13 of the 14 commits fail to build.  Only the final commit
is clean, so git bisect is broken across essentially the whole series.

Build (applied on c1a46b9, gcc 13.3, -Dwerror=true):

  [1] 8a0a793 01/14 add KEEP_CRC offload support for ENETC4
  [1] 63cae7e 02/14 add TSO support for ENETC4 VF
  [1] b28e1a8 03/14 add RSC (hardware LRO) support
      ... all fail ...
  [1] e334f6c 13/14 enable TX PAUSE via VF RX congestion mode
  [0] b5e71d6 14/14 add WRR Tx scheduler devarg for VF rings

Three distinct causes, all introduced in patch 01.


Patch 01

Error: prev_seg used but never declared (fails commits 01-02).

  enetc_rxtx.c:597:25: error: 'prev_seg' undeclared
  enetc_rxtx.c:844:25: error: 'prev_seg' undeclared

Patch 01 assigns prev_seg and passes it to enetc_rx_crc_trim() in both
enetc_clean_rx_ring_nc() and enetc_clean_rx_ring_cacheable(), but the
declaration hunk only changes first_seg/cur_seg to = NULL.  The
*prev_seg = NULL declaration does not arrive until patch 03.  Move it
to patch 01.

Error: duplicate offload arrays (fails commits 01-13).

  enetc4_ethdev.c:110:17: error: redefinition of 'dev_rx_offloads_sup'
  enetc4_ethdev.c:117:17: error: redefinition of 'dev_tx_offloads_sup'

Patch 01 adds a second copy of both arrays at the top of
enetc4_ethdev.c; the pre-existing ones near line 97 are not deleted
until patch 14.  The deletion hunk belongs in patch 01.

Error: duplicate rx_enable declaration (fails commits 01-13).

  enetc4_ethdev.c:552:18: error: redeclaration of 'rx_enable' with no
  linkage

enetc4_rx_queue_setup() already declares uint32_t rx_enable upstream.
Patch 01 adds a second one; the removal is in patch 14.

This is the signature of building only the squashed series.  Please run
devtools/test-meson-builds.sh, or at minimum a -Dwerror=true build at
each commit, before v5.

Error: PF loses Scattered Rx and Multi-segment Tx.

The old arrays deleted in patch 14 contained
RTE_ETH_RX_OFFLOAD_SCATTER and RTE_ETH_TX_OFFLOAD_MULTI_SEGS.  The
replacements added in patch 01 do not.  Net result at the tip:

  upstream                      after the series
  RX: IPV4|UDP|TCP|SCATTER      RX: IPV4|UDP|TCP|KEEP_CRC|TCP_LRO
  TX: IPV4|UDP|TCP|MULTI_SEGS   TX: IPV4|UDP|TCP|TCP_TSO|UDP_TSO

Nothing in any commit message says this is intentional.  enetc4.ini
still declares "Scattered Rx = Y", and the new RSC path builds
multi-segment clusters, so the capability is still needed.  The VF
arrays keep both - only the PF regresses.


Patch 02

Error: mbuf leak in enetc_xmit_pkts_lso().

Two validation paths drop a TSO frame with "start++; continue;":

  - hdr_len >= pkt_len || hdr_len > data_len
  - tso_segsz == 0 || data_unit > ENETC4_LSO_MAX_DATA_UNIT ||
    hdr_len + tso_segsz > ENETC4_LSO_MAX_FRAME

Neither writes q_swbd[i].buffer_addr, and neither frees the mbuf, but
both count the packet in the burst return value.  The application
considers it transmitted; enetc_clean_tx_ring() never sees it.
Free-and-continue is the right shape here - add rte_pktmbuf_free(seg)
before each start++.

Error: 16-bit byte swap on a uint8_t field.

In the non-TSO path of the same function:

  txbd->flags |= rte_cpu_to_le_16(ENETC4_TXBD_FLAGS_F);

struct enetc_tx_bd.flags is uint8_t.  On big-endian this evaluates to
0x8000 and truncates to 0, so the frame-last flag is never set and Tx
stalls.  Upstream and the LSO path in this very function both use plain
"txbd->flags |= ENETC4_TXBD_FLAGS_F;".  Drop the conversion.

Warning: ring doubling bypasses MAX_BD_COUNT.

Both enetc4_alloc_txbdr() (LSO, patch 02) and enetc4_alloc_rxbdr()
(RSC, patch 03) double nb_desc, but the nb_desc > MAX_BD_COUNT check
runs before the doubling.  With MAX_BD_COUNT at 64000 the effective
ring reaches 128000 descriptors, and ENETC_RTBLENR_LEN(n) is just
((n) & ~0x7) with no upper clamp.  Validate the post-doubling count, or
halve the accepted nb_desc when LSO/RSC is on.


Patch 04

Warning: link speed decode has no upper bound.

  link.link_speed = (reply_msg->status - ENETC_SPEED_5000) * 1000 + 5000;

status is uint8_t and the default arm now catches everything from 8 to
255, so a garbage or unrecognized code yields a fabricated speed
(0xFF -> 253000 Mbps) rather than RTE_ETH_SPEED_NUM_UNKNOWN.  Note also
that 0xF, previously ENETC_SPEED_NOT_SUPPORTED, now decodes as 13000
Mbps in non-legacy mode.  Bound the result, or reject codes that do not
map to a defined RTE_ETH_SPEED_NUM_* value.

Warning: flipping the reply-status extraction from 4-bit to 8-bit by
default is a wire-protocol compatibility break.  Users on a PF kernel
older than 6.18.37 must add vf_link_legacy=1 or link reporting breaks
silently.  That deserves an explicit line in the release notes, not
just "extended the field to 8-bit".

Info: adds a second #include <rte_kvargs.h> immediately below the
existing one.


Series-wide

Warning: mailbox ops added to the no-VSI ops table.

enetc4_vf_ops_no_vsi_m is selected when the user passes
enetc4_vsi_disable, that is, explicitly asks for no VSI-PSI messaging.
The series adds fw_version_get, mac_addr_set, mac_addr_add,
promiscuous_*, allmulticast_*, vlan_filter_set, vlan_offload_set,
vlan_pvid_set and stats_reset to it.  Most of those reach
enetc4_msg_vsi_send() directly or through a helper, so they will now
attempt a transaction on the disabled mailbox and stall until
vsi_timeout.  Previously ethdev returned -ENOTSUP immediately.  Only
the genuinely register-local ops (get_reg, rxq_info_get, txq_info_get,
and stats_reset if it stays direct-register) belong in that table.

Warning: new devargs undocumented.

vf_link_legacy (patch 04) and enetc4_txq_wrr (patch 14) are both in
RTE_PMD_REGISTER_PARAM_STRING but absent from
doc/guides/nics/enetc4.rst, which documents every pre-existing devarg.
Same gap flagged in the previous round.

Info: patch 01 adds two stray blank lines in enetc4_ethdev.c (one
before enetc4_rx_queue_release, later removed in patch 03); patch 02
adds three more around enetc4_alloc_txbdr/enetc4_free_bdr and in
struct enetc_bdr.

Info: enetc_recv_pkts_rsc is assigned to dev->rx_pkt_burst from
enetc4_rx_queue_setup(), which will silently override the nc=1 burst
selection made in dev_init.  Worth a guard or at least a comment on
precedence.

I stopped short of a full read of patches 05-14 since the build
breakage has to be resolved first and several of these findings will
shift hunks around.  I can go back through 05-14 in detail once there
is a v5, or now if you would rather have the complete list before the
author respins.

