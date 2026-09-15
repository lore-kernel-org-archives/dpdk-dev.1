Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B47DC88E7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 15:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F025542DB4;
	Tue, 15 Sep 2026 17:42:35 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 97A6140B91
 for <dev@dpdk.org>; Tue, 15 Sep 2026 17:42:34 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed9866so35915255ad.2
 for <dev@dpdk.org>; Tue, 15 Sep 2026 08:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789486953;
 x=1790091753; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ecuFgIUf6QCk3FnCVTh9eejW1v84Mli3dWxdHV7Yd3Q=;
 b=o+CQfVGnmgbzsW3RVIN0YxiHH3KKZoJS5Kyvu3rUNoEg6IYd+m83ORjw4eI8lYxL1q
 Q3gbEe2DmYdv+yQoziJNYThYR9kGlALq2a3d+XQqqnETZCrUFCZMAR9LEu8I9U6q0/Mx
 e/TwHvgukK78notw4ZSM97g9zIEvq7dKvDFi26hzExh7baC7gQ5XlcS/wytKqvYnf69r
 3KXa5WAt3nA/yBPeC/DiRzXGrqxUCLMXIlIzgFZfpx5PKRcnVvw/CaYk9A7aA7LM9IyW
 RmOPdfzdMnvwosYnLdliXunNDBcMhyHRXo/ArZoP6VE3NdsPkhFB7sCVbZfp5BzkG46n
 LgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486953; x=1790091753;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ecuFgIUf6QCk3FnCVTh9eejW1v84Mli3dWxdHV7Yd3Q=;
 b=kTZCiknAnvKSaT4SYKFN/fz1xLl0eFS0iS5hQxMGtCWYZPXUKc34OUy+tgc3z/u4h8
 NHR8zhpFDU3jYa48w49LUQ2xuhHTMkqtSmSr8lJOxM1PX9ychWiBwGgBJjJB/bdZyiU4
 74Rx3apxaFJKD1OKWFzz+bXHA3+D2REmlJN1WRf8ANPZsMc2Rx2oS0xUHmc7QvYry2Vu
 U2LP8kJpriyq8JcZwd6DkOBA5OLZvPjknatrRWob//0LsutRdqmcHShOkgcATxrfklWy
 S8jThkW7U058sxcdpcZuJzkKL9DhG+PuPe7RUyipm0VBjGM7OKb6S5SsYuB7oSnrcF3q
 RYTg==
X-Gm-Message-State: AFuF++n+nXlPu6Fxei74qrGEClVj46vvPnwkjYnBFMBhOEbRvbuqBzoU
 VN7tGwqbJ3SbtzP/WHgJDULgBuWQo8a65KmuXkDm9irXF+39y65wIqJOouxyZSsxuEFREIJdHu1
 I5+mTo18iGg==
X-Gm-Gg: AYBFou0AKzIDJLYcfSaconrhIiERjhrMrKqrDBdD9E5jpWhzxGsKwxp9tKAD6OiapTj
 SGHHo0nidA0IdUrp/5hXE0UZkJWz5BsXOLrq3sNkuj3KlAfEcmWBxoyJK/LtING0lguo7x4nEC/
 dI3tf0RL5W+MM0S2c3zAyQuaLXOyVw+Elz7QqAWQI9cqa+FahtWmi8oVqwfELUDF1aZ9D8pq7KH
 uSoHevA+x8DeVu0Xfs+ZAOTP0lhYBmn/QlLbY3G4hZcjMW7rykcvmtCUjpUI6u/J+sTePh9jtFy
 ahr2sBwbXLicvu5teH61qJyPpv00ybRUXj47O+PvB0zoBdAuF8CLCcCE1b6RF9tuCjYIujXHu50
 iq5+qeVDIjMe26UL6ooXNG+Qw8ylMfj+pN8lbRc5XfaGoYRLRZ5mYz1PQ/dy8X4v0J2InajMisc
 fWEZO86sTNnj48YLFSgstrkZhmzEvCcqJcXvRCGTJOEGC2BT1ik+ALoYL3NKje1Ok91H8yhNasI
 Kabzr7SQu5PxQ5V1g8JkvxtqEUSj7R/8jVe+aMeeA==
X-Received: by 2002:a17:903:1a6f:b0:2d9:2fc9:5706 with SMTP id
 d9443c01a7336-2dd6c5b17bdmr155381195ad.2.1789486953410; 
 Tue, 15 Sep 2026 08:42:33 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cfe80fdsm69062265ad.67.2026.09.15.08.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:42:33 -0700 (PDT)
Date: Tue, 15 Sep 2026 08:42:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3-S2 00/13] net/dpaa2: flow, meter and parser features
Message-ID: <20260915084227.6a6aecad@phoenix.local>
In-Reply-To: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
References: <20260910135158.2181141-48-prashant.gupta_3@nxp.com>
 <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
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

On Tue, 15 Sep 2026 17:04:46 +0530
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

AI review with Opus found lots of issues that still need to be fixed.

Series: [PATCH v3-S2 00/13] net/dpaa2 flow, meter, parser rework

Patch 10 claims no functional change but rewrites the Rx path and
introduces mbuf memory corruption on every received packet. Patches 5
and 7 have functional problems of their own. Not ready.

All 13 commits apply to main and build with -Dwerror=true (default
config, RTE_LIBRTE_IEEE1588 off).

----------------------------------------------------------------------
Patch 01/13 net/dpaa2: fix integer overflow in CCSR region mapping

Warning
  PAGE_SIZE and PAGE_MASK (dpaa2_recycle.c:32-35) have no users after
  this patch. Remove them.

Info (pre-existing, not introduced here)
  lsx_ccsr_map_region() rounds len down with page_mask and does not
  add offset to the mapped length, so a region crossing a page
  boundary is only partially mapped. The mapping is never unmapped.

----------------------------------------------------------------------
Patch 03/13 net/dpaa2: support larger burst size

Warning
  The non-LX2160A limit drops from DPAA2_BURST_MAX (65536) to 0xF7FF.
  The old value was broken anyway: max_burst_size was uint16_t, so
  65536 truncated to 0. Say both in the commit message; the
  truncation is a stable fix on its own.

Warning
  return (dpaa2_svr_family == SVR_LX2160A) ? 229375 : 0xF7FF;
  The header comment documents this as 0x37FFF. Use hex in both
  places, and name the 8.7 version like the existing
  DPNI_GET_MAC_SUPPORTED_IFS_VER_* defines.

Info
  DPNI_BURST_LO/HI describe the MC command layout and belong in
  fsl_dpni_cmd.h rather than fsl_dpni.h.

----------------------------------------------------------------------
Patch 04/13 net/dpaa2: support MPLS and PPPoE flow distribution

Warning
  mask = pattern->mask ? pattern->mask : &dpaa2_flow_item_mpls_mask;
  The driver default is { 0xff, 0xff, 0xff }, covering TC and the
  bottom-of-stack bit. rte_flow defines a NULL mask as the item
  default (label only). A spec with only the label set does not
  match single-label packets (S=1).

Warning
  Every MPLS item extracts NH_FLD_MPLS_MPLSL_1. For
  eth / mpls / mpls the second item overwrites the first label's key
  data instead of matching label 2. Reject a second MPLS item or map
  it to MPLSL_2 / MPLSL_N.

Info
  Extra blank line added after the #endif of the mask block.

----------------------------------------------------------------------
Patch 05/13 net/dpaa2: support meter and policing

Error
  The meter ops only maintain software lists. Nothing calls
  dpni_set_rx_tc_policing(), and dpaa2_flow.c has no
  RTE_FLOW_ACTION_TYPE_METER handling. Creating a meter has no effect
  on traffic, while capabilities, dpaa2.rst, dpaa2.ini and the
  release notes advertise metering and policing.

Error
  dpni_set_rx_tc_policing_v1() is declared in fsl_dpni.h and defined
  nowhere. DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS and
  DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS are unused.

Warning
  s_dpaa2_mtr_capa is file-scope and written under priv->meter_lock.
  The lock is per port, so two ports race on the shared struct. Fill
  the caller's capa directly.

Warning
  static char s_err_msg[128] is shared across ports and threads and
  handed back through rte_mtr_error. Concurrent failures overwrite
  each other's message.

Warning
  dpaa2_mtr_profile_add() and dpaa2_mtr_policy_add() accept a
  duplicate id; the new entry is appended and lookups return the
  first.

Warning
  Profiles, policies and meters are never freed on dev_close.
  priv->profiles, priv->policies and priv->meters are referenced only
  in dpaa2_meter.c.

Warning
  rte_zmalloc() for control-path bookkeeping. Use malloc/calloc.

Warning
  The release note hunk adds "Tx queue based flow control and
  confirmation queue handling" and "software parser based packet
  dump", neither of which is in this patch; patch 12 removes the soft
  parser. Each patch should carry only its own note.

----------------------------------------------------------------------
Patch 07/13 net/dpaa2: set default flow miss action per device

Error
  priv->default_flow = RTE_MIN(priv->fs_entries,
          priv->dist_queues) - 1;
  fs_miss_flow_id is a queue id within the TC. fs_entries is the FS
  table size and has nothing to do with it.

  The miss queue also moves from 0 to the last hardware queue of the
  TC. dev_info reports max_rx_queues = priv->nb_rx_queues, so an
  application that configures fewer queues never sets up or polls
  that queue and loses every unmatched frame. Queue 0 is always
  configured.

  With fs_entries == 0 the value becomes 0xffff, which is
  DPNI_FS_MISS_DROP.

Warning
  The commit message calls this the "lowest priority flow". The field
  is a queue id, not a priority.

----------------------------------------------------------------------
Patch 08/13 net/dpaa2: identify Rx mbuf hash information by FLC

Warning
  rte_mbuf_sched_set(m, flow, tc, 0) together with
  RTE_MBUF_F_RX_FDIR. hash.sched is the Tx scheduler field; RX_FDIR
  tells applications to read hash.fdir from the same union. Use
  hash.fdir.hi with RTE_MBUF_F_RX_FDIR_ID, or implement
  RTE_FLOW_ACTION_TYPE_MARK.

Warning
  The FS action sets DPNI_FS_OPT_SET_FLC |
  DPNI_FS_OPT_SET_STASH_CONTROL with data stashing on every SoC.
  dpaa2_dev_rx_queue_setup() skips FLC/stashing on SVR_LS2080A; the
  FS path must follow the same rule.

Info
  The QUEUE action index is checked against MAX_RX_QUEUES and
  rx_vq[] != NULL, not against dev->data->nb_rx_queues, so an
  unconfigured hardware queue is accepted.

----------------------------------------------------------------------
Patch 09/13 net/dpaa2: add minimum key size support

Warning
  Removes "Current MC only support fixed entry size(56)" and starts
  using 24-byte entries with no MC/DPNI version check. State the
  minimum firmware in the commit message and gate it with
  dpaa2_dev_cmp_dpni_ver(), or older MC rejects the table setup.

----------------------------------------------------------------------
Patch 10/13 net/dpaa2: restructure dpaa2 parser processing

Error
  if (priv->psr_dynfield_offset >= 0)
          dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
  psr_dynfield_offset is never assigned anywhere in the driver. With
  zeroed dev_private the test is true for every packet, and
  dpaa2_dev_rx_parse_offset() writes the l3/l4/l5 offsets at
  (uint8_t *)mbuf + 0, i.e. into buf_addr. The RTE_ASSERT guarding it
  is compiled out in release builds. Affects
  dpaa2_dev_prefetch_rx_common(), dpaa2_dev_rx_common() and
  dump_err_pkts().

Error
  dpaa2_timestamp_dynfield() is removed, but dpaa2_dev_rx_common()
  still calls it under #if defined(RTE_LIBRTE_IEEE1588). The build
  breaks with IEEE1588 enabled.

Error
  Rx timestamp handling is removed from dpaa2_dev_rx_parse() and
  dpaa2_dev_rx_parse_new(). dpaa2_enable_ts[] is still set in
  dpaa2_dev_configure() but never read, so
  RTE_ETH_RX_OFFLOAD_TIMESTAMP silently stops working. The IEEE1588
  priv->rx_timestamp update in dpaa2_dev_prefetch_rx_common() is also
  gone.

Error
  Checksum flag handling is removed from dpaa2_dev_rx_parse() and now
  exists only in dpaa2_dev_rx_parse_slow(). On non-LX2160A SoCs the
  fast-path return (word3 test false) no longer reports
  RX_IP_CKSUM_* or RX_L4_CKSUM_*.

Error
  The "if (!by_channel)" guard around dump_err_pkts() is removed from
  dpaa2_dev_prefetch_rx_common(). The removed comment explains that
  the channel/interrupt path owns the ethrx portal, and
  dpaa2_dev_rx_common() still keeps the guard. This reverts that fix.

Error
  The commit message says no functional change is intended. Also
  changed:
    - DPAA2_PKT_TYPE_IPV4_EXT 0x0001 -> 0x0040,
      IPV6_EXT 0x0021 -> 0x0050
    - VLAN_1/VLAN_2 0x0160/0x0260 -> 0x0100/0x0200
    - new VLAN TCI reporting (RTE_MBUF_F_RX_VLAN)
    - event and eqresp paths now handle SG frames
    - IPv4/IPv6 EXT, SCTP and ICMP dropped from the LX2 fast switch
    - parser result no longer printed for error-queue frames
    - hash.sched.color now set from DPAA2_GET_FD_DROPP() on FS frames
  Split into the header move plus separate functional patches, each
  with its own justification.

Warning
  dpaa2_dev_rx_print_parser_result() loops i < MAX_RX_QUEUES and
  dereferences priv->rx_vq[i]->tc_index; entries past
  priv->nb_rx_queues are NULL. The function is unreachable today
  because DPAA2_RX_PRINT_PSR_RESULT_FLAG is never set, while
  dpaa2_dev_init() still sets dpaa2_print_parser_result from getenv()
  and nothing reads it. The parser debug print is broken either way.

Warning
  Leftovers: rx_ts_offset, rx_ts_flag and
  L3/L4/L5_OFFSET_OF_MBUF_DYN are unused. sp_protocol is never set,
  so the fafe2/fafe3 GENEVE branch in dpaa2_dev_rx_parse_new() is
  dead. dpaa2_dev_rx_parse_new() does RTE_SET_USED(priv) and then
  uses priv.

----------------------------------------------------------------------
Patch 11/13 net/dpaa2: parse tunnel and fragmented packet types

Warning
  The commit message says the new types are mapped "in the slow-path
  parser". They are added only to the LX2160A FRC switch in
  dpaa2_dev_rx_parse_new(); dpaa2_dev_rx_parse() for other SoCs is
  unchanged.

Warning
  DPAA2_PKT_TYPE_IPV4_FRAG and IPV6_FRAG evaluate to 0x0001 and
  0x0021, the values the driver reported as RTE_PTYPE_L3_IPV4_EXT and
  L3_IPV6_EXT before patch 10. Fragments were misreported as IP
  options. That is a bug fix for released code and should be a
  separate patch with Fixes: and Cc: stable@dpdk.org.

----------------------------------------------------------------------
Patch 12/13 net/dpaa2: remove unused soft parser driver

Warning
  dpaa2_soft_parser_loaded() is still defined in dpaa2_flow.c and
  declared in dpaa2_ethdev.h with no callers, and it still opens
  /dev/mem. Remove it together with dpaa2_sp_loaded.

Warning
  The commit message is one sentence. Explain what users lose and why
  runtime loading is unsupported.

----------------------------------------------------------------------
Patch 13/13 net/dpaa2: rename Rx queue flags

Info
  The commit message refers to "the Tx confirmation rework that
  follows", but this is the last patch in the series.

Info
  The rename should come before patch 10, which adds
  DPAA2_RX_PRINT_PSR_RESULT_FLAG next to the old DPAAX_ name.
