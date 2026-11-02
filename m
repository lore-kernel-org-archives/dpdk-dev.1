Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F12606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jYwqG1hT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B071F40264;
	Mon,  2 Nov 2026 08:52:25 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 962D24003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 08:52:24 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so27702755e9.3
 for <dev@dpdk.org>; Sun, 01 Nov 2026 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793605944;
 x=1794210744; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2myOs8jJaQIexGgvGyTpoVa3WUxg00AMHTeu6olpVck=;
 b=jYwqG1hTMWu5/o+y+lhIIACtXm6d9qWdo+nJo2KBvzfXa0kkR5GDZSdinVdIqdl6K+
 ku4xOp1G2+4uyhOqxJ4bHQRGJk+qjsEgwP8m2UizdXPOqmFMdpT77We8vhnie4CB4IjX
 qGNPdCYj/WBucCEfh3i4Ijdr06dg9JLwDx2l6iRxj4/OPGL1f5r3tbMVn4JBOjV0JKmV
 WuTlEXp0d2HfOzwwV60BYMv4fe7VBEA+1X2omDFnklnOeC3Ox6dP6qVvB5NWuLjGcN2V
 2bPiTfcX/jOXZ7+FvRbxqBIpsmHAExj8pfZN8kYFtNi74Xydigmp/OlvUmfAAA2GgWvx
 YXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793605944; x=1794210744;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2myOs8jJaQIexGgvGyTpoVa3WUxg00AMHTeu6olpVck=;
 b=0YNl+WqesGKF52zqy1ITd2aYJ0QPQYcjtNGQAP+Gd0jYC9uzTCoMmpYTDRqv6gfOS5
 eROWgQmCf9+A8fwmPajS5UVDpQ8MezVlauJ4TlBNJDHOt2R9PaB+H+QjI/TmLwlkPDks
 R0QZnQ4Xs0Pc4pN7KgvqrmP2Jn0p5wg3RdDcYD6/+Fzkgmp0dMJuUnKocX+KbkB6Ef+7
 FjvXFnQ01u0dFnxTvXi5GYI3xL/etu4O4jOFO9WmVySsTdrELL+AiPNLaTz7MLCNS92c
 /cDlbyleiYjXbdELkXwkfDxfTHV5bJVi5eOFrtFTS6ZngLv9JljBabshnTeJOG2aOyrm
 8Jlg==
X-Gm-Message-State: AFq9FYIXKA/rsYIkapFfL1pJI0EmpUHWuDy6t81NvJF5VPQstILUGN93
 GOnyAR1S7cqFIMBgc5nEXWpx9dutEiTZWsv0XbiIEicN9W2fovm08QuqqJzZ0ti3lF/nSKLy3ec
 lENmdWi4YRg==
X-Gm-Gg: AYBFou1qJ9sEM2ZEhKGew3ZJj4Pp+InOJQAOM7UsMSnooxIcOBMnTGhQpz7rONeEr/o
 AcNQRqreMyoPCzf45lyBezGNBy2f2EhI7eLKAO9ejx6c/x/dbl04cvvq6nC7YT6e+zEMgxI15v3
 UY5JAaSVrANDWRJWU/TwcP0fXlRcC+LTzWN89/m1gv0x7q1fdao6U7fLqIGoTd/TP867osRabG2
 wk+3EiTGw8BxpDc6oTGZ5PC/Msn08/jtMIgPV0nWgJ5/h9vPFkODnenTGtpvYdjKKhCQ7yjVIkd
 urALiZbInWSC1Yq+Ms9Jz3wcqRLTRYZvLMBkdbNiFDwvZfhcKXI+xJn6Br77ueUclEppU5bTD1e
 J1z2uQ50xBFQNrUquq9zBRTV8xLYJMvm5dRG/iWzloh5RkLtzsDvzlSY0gkwfcLhZiFtz8TsuPB
 rnzlLGZ2abMx7wZXyW9KEY05c4JWNS7jgpxFYln6OXHKDX6qsqCCUyKImcJUtl7LpBgVyG/PGXI
 BnW+UQaTubjqJDXhLou0z6RsMmN/j4578Fmv8b3CGq5Y9Sbs29Aj1+lNFbelisxm/MlQb304WXz
 /uGFFVleCH4S42R0kK8RRc4EuFvdSshlxVuL82ENE/jLoATcW4zL9QchK0KCat2Yhen07hHDg4L
 6/mph8WKe9rqtoQ==
X-Received: by 2002:a05:600c:1f93:b0:4a5:87b3:ddc1 with SMTP id
 5b1f17b1804b1-4ac180f1ec7mr222906655e9.13.1793605943427; 
 Sun, 01 Nov 2026 23:52:23 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be.
 [194.78.224.93]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d295csm326268295e9.7.2026.11.01.23.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 23:52:23 -0800 (PST)
Date: Mon, 2 Nov 2026 08:52:20 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5-S3 00/14] net/dpaa2 and fslmc infrastructure updates
Message-ID: <20261102085220.600bfed2@stephen-xps.local>
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 10:50:02 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series is part of the ongoing DPAA2 upstreaming effort, applied on
> top of v7-S1 ("dpaa2: bus, DMA and mempool base fixes") and
> v14-S2 ("net/dpaa2 updates").
> 
> Compared to v4-S3, the series has been reduced and reorganized to focus
> on DPAA2 PMD and fslmc infrastructure improvements. It includes parser
> decode optimizations, common devargs handling, queue management
> enhancements, DPRTC infrastructure support, and runtime timestamping.

Still lots of outstanding issues identified by manually running Claude AI review

Review: [PATCH v5-S3 00/14] DPAA2 refactor (Jun Yang, Prashant Gupta)

Applied with git am --3way on dpdk-next-net for-main (52ebbf7d9de8),
all 14 apply. Per-commit builds clean with gcc 13.3, -Werror, with
and without RTE_LIBRTE_IEEE1588. v4 findings rechecked against the
v5 post-apply source.

Series-level
============

1. Progress since v4: the vfio include, bisect build breaks, missing
   subject on 12, secondary-process flag reset (02), key-only devarg
   crashes (03, 06), cluster_size divide (08), hex dump per byte (05),
   NO_CONF shared-buffer release, clone data_off/len and FAEAD
   headroom (12), Rx timestamp dynfield at offset 0 and the
   ts_to_cnfd race (14) are fixed.

2. Still no Fixes:/Cc: stable for bugs in released code that this
   set fixes or touches:
   - priv->ep_dev_type/ep_name never set in main (09).
     Fixes: a0f8ddc41218 ("net/dpaa2: add API to get endpoint name")
     Fixes: c78fa95fa9b0 ("net/dpaa2: set speed capabilities based on actual MAC")
   - tx_vq[16] overflow capped in 07.
     Fixes: 72100f0dee21 ("net/dpaa2: support level 2 in traffic management")
   - drv_err_queue (code) vs drv_error_queue (doc) mismatch, now
     silently renamed in 02.
     Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
   - dpaax_ptp.h compares be16 udp->dst_port to host order 319/320;
     UDP PTP never matches on LE, and 14 now warns and drops TMST on
     every UDP PTP frame because of it.
     Fixes: 6cc1246b3b1a ("net/dpaa: support IEEE 1588 by timesync API")
   Send these as standalone fixes ahead of the series.

3. Commit logs of 01, 02, 07, 08, 11, 12 and 14 do not describe their
   diffs (details per patch). 14 lost most of the v4 description.

4. Several reads of the frame annotation happen after
   dpaa2_eth_sg_fd_to_mbuf() has freed the SGT buffer (01 parser dump,
   06 parse offset, 14 Rx timestamp). Read the annotation inside the
   fd_to_mbuf helpers before the free.


Patch findings
==============

[01/14] net/dpaa2: refactor and optimize Rx parser result decode

Error: VLAN decode wipes L3/L4 and reports QinQ
  dpaa2_dev_rx_parse_vlan():
    *packet_type &= RTE_PTYPE_L2_MASK;
    *packet_type |= RTE_PTYPE_L2_ETHER_VLAN;
  keeps only the L2 field: single-tagged IPv4/UDP becomes
  ETHER(1) | VLAN(6) == L2_ETHER_QINQ with no L3/L4. The summary
  passed in still has sum.vlan cleared, so "sum->vlan > 1" never hits.
  Fix: pass the unmasked summary;
    *pt = (*pt & ~RTE_PTYPE_L2_MASK) |
          (sum->vlan > 1 ? RTE_PTYPE_L2_ETHER_QINQ
                         : RTE_PTYPE_L2_ETHER_VLAN);

Error: rejected Tx SG FD still freed with the Rx SG converter in
  dpaa2_dev_free_eqresp_buf() (dpaa2_rxtx.c:1644).

Warning: parse_frc() ORs L2 values: ETHER | TIMESYNC == ARP,
  VLAN | ARP, VLAN | MPLS. TMST set without RTE_LIBRTE_IEEE1588 and
  on the prefetch path, which records no rx_timestamp. Assign the L2
  field; set TMST only where the timestamp is stored.

Warning: parse_slow() gets a second VLAN block; the old block after it
  overwrites vlan_tci with the outer tag for QinQ. Keep one.

Warning: !by_channel guard on the error queue drain still removed on
  the prefetch path.

Warning: dpaa2_dump_print() still logs to RTE_LOGTYPE_USER1. eCPRI
  type 4 dump still memcpy()s wire bytes into a bitfield. FAFE layout
  change still unexplained; flow code still builds ECPRI_FAFE_TYPE_x
  with the old layout, so dump and flow disagree.

Warning: parser dump runs after the SGT buffer is freed (series 4);
  from dump_err_pkts() every error frame logs "Received on invalid
  rxq".

Warning: commit log still omits the eventdev SG fix, eqresp SG,
  by_channel removal, RSS/FDIR on non-LX2, new public FDIR macros and
  getenv removal. Unused DPAA2_PKT_TYPE_*_EXT/GRE/SCTP/ICMP macros,
  enum dpaa2_parser_protocol_id and no-op ECPRI()/ROCEv2() remain.


[02/14] drivers: net/dpaa2 centralize devargs definitions

Warning: drv_err_queue renamed to drv_error_queue without accepting the
  old key; dpaa2.rst:587 still says drv_err_queue (series 2).

Warning: commit log only describes the X-macro table. Not mentioned:
  new net devarg drv_strict_order, DPAA2_STRICT_ORDERING_ENABLE getenv
  moved to probe, the rename, primary-only parsing, per-arg INFO logs
  dropped, "=0" now clears (main accepted only "1").

Warning: dpaax_devarg.h: flag_bit is uint64_t but written through
  "*((uint32_t *)flags)" on a void *; logs to RTE_LOGTYPE_USER1
  ("Failed to get value of %s" missing "\n"); includes ethdev_driver.h
  for crypto/dma users while <string.h>, <errno.h>, <stdarg.h> are
  missing.
  Fix: typed uint32_t *flags, caller's logtype, include what is used.


[03/14] crypto/dpaa2_sec: use table-driven devargs parsing

Error: drv_strict_order still never takes effect
  parsed at dpaa2_sec_dpseci.c:4388, then
    internals->en_loose_ordered = true;
  at :4437 overwrites it. Regression against main.
  Fix: set the default before dpaax_get_devargs(), drop :4437.


[06/14] net/dpaa2: export parser protocol offsets via mbuf dynfield

Error: dpaa2_dev_rx_parse_offset() reads DPAA2_GET_FD_ADDR(fd) after
  the SGT buffer is freed; v5 adds the same call to the three eventdev
  Rx paths (dpaa2_rxtx.c:1052, :1086, :1123). Series 4.

Warning: the public struct in rte_pmd_dpaa2.h has no rte_ prefix, no
  doxygen for offset base or absent-header value, and the comment
  block after it attaches to the next declaration. No release note.


[07/14] drivers: net/dpaa2 rework Tx queue mapping

Error: channel = txq % num_channels, but
    nb_tx_queues = num_tx_tcs * num_queues
  no longer scales with channels. With SINGLE_SENDER a 2-channel DPNI
  gets 8 Tx queues: ch0 sees even TCs, ch1 odd TCs. dpaa2_tm.c still
  advertises num_tx_tc * num_channels leaves and rejects leaf id >=
  nb_tx_queues, so a TM tree for the second channel cannot be built.
  Fix: nb_tx_queues = num_tx_tcs * num_channels (capped) with
  channel = txq / num_tx_tcs, or update dpaa2_tm to match.

Warning: commit log says tc_index is no longer derived from the queue
  number; "mc_q->tc_index = i / num_queue_per_tc" still is. Queue count
  formula, MAX_TX_QUEUES 16 -> 128, caps and Rx re-setup guard not
  mentioned. tx_channels[] is write-only; the Rx "already setup" guard
  is unreachable (release resets fqid). Split the caps into a Fixes:
  patch (series 2).


[08/14] drivers: bus/fslmc centralize device handling

Warning: MC version check relaxed
    if (bus_info->mc_rev <
        RTE_FSL_MC_REV(MC_VER_MAJOR, MC_VER_MINOR, 0))
  accepts any newer major; main rejected major != MC_VER_MAJOR (new
  major means incompatible command ABI). Unknown SVR or failed
  mc_get_soc_version() now fails bus probe (main fell back to
  defaults). The check also runs in secondary now: the kept comment
  "In case of secondary processes, MC version check is no longer
  required" is wrong and the if/else below it is identical in both
  branches. Keep the exact-major check; say the rest in the log.

Info: bus_info->sp_protocol has no writer until 10; svr/pvr written
  but never read; fw_version_get still issues MC commands for values
  bus_info already has; "extern struct rte_bus rte_fslmc_bus" moved
  out of private.h into dpaa2_hw_dprc.c; unrelated dqrr/eqcr size type
  changes in rxtx.c.


[09/14] drivers: net/dpaa2: move DPNI endpoint lookup to PMD

Warning: log does not say priv->ep_* was never set in main; needs the
  Fixes:/Cc: stable in series 2.


[10/14] drivers: net/dpaa2 remove unused soft parser loader

Warning: ss_offset/ss_iova/ss_param_iova now unused; remove. SP
  detection changed to a u16 magic 0xabcd at sp_ins[4], not in the log
  or dpaa2.rst. DPAA2_BUS_NOTICE added but unused.


[11/14] drivers: net/dpaa2 cache Rx queue config and share TC CGIDs

Error: cgid_in_use[] is MAX_TCS entries, xstats still loops
    for (j = 0; j < priv->max_cgs; j++) if (!priv->cgid_in_use[j])
  with max_cgs up to 255 (dpaa2_ethdev.c:2138).
  Fix: priv->max_cgs = RTE_MIN(attr.num_cgs, MAX_TCS).

Error: eventq_detach still passes dpaa2_ethq->options (no
  DPNI_QUEUE_OPT_DEST unless napi), so the FQ stays on the DPCON; cfg
  dereferenced unchecked (dpaa2_ethdev.c:2966).
  Fix: if (!cfg) return -EINVAL; set DEST_NONE and pass
  DPNI_QUEUE_OPT_DEST.

Warning: early err_quit (DPCON alloc/enable failure) decrements
  cgid_in_use[tc] although cfg->cgid is still 0 from zmalloc; it takes
  another queue's reference and release then wraps the u8.
  Fix: local cgid_taken flag, or cfg->cgid = DPAA2_INVALID_CGID after
  the alloc.

Info: taildrop moves from per queue to one threshold per TC
  (nb_rx_desc * dist_queues, set by the first queue); not in the log.


[12/14] drivers: net/dpaa2 add dynamic Tx confirmation mode

Error: rx_err_vq never assigned
  The rte_zmalloc() is gone and a slot is reserved, but nothing sets
  priv->rx_err_vq; drv_error_queue=1 dereferences NULL in
  dpaa2_queue_storage_alloc() and dev_start. Still so at 14.
  Fix: priv->rx_err_vq = mc_q++ (eth_data, fqid) before the alloc.

Error: cloned single-segment mbuf leaks or crashes tx_conf
    if (unlikely(RTE_MBUF_CLONED(mbuf))) {
        DPAA2_MBUF_TO_CONTIG_FD(mbuf, fd, MAX_BPID);
        DPAA2_SET_FD_IVP(fd); ...
        rte_mbuf_refcnt_update(mbuf, -1);
  refcnt 1 goes to 0 without rte_pktmbuf_free(): indirect and parent
  leak. refcnt > 1: other owner can free the parent during DMA. With
  drv_tx_conf=1 the FD is confirmed with FLC 0 and tx_conf derefs
  NULL. Log claims clones are confirmed in dynamic mode.
  Fix: conf modes use dpaa2_mbuf_to_conf_contig_fd() and free in
  tx_conf; NO_CONF copies to hw_mp and frees the original.

Error: conf-mode S/G with SGT from dpaa2_tx_sg_pool leaks the chain
  FLC = sg_mbuf, all SGEs IVP, and "sg_mbuf->next = cur_seg" was
  dropped, so tx_conf frees only the SGT buffer. Any chain over 7
  segments with drv_tx_conf=1, or foreign/indirect head.
  Fix: carry the packet head in FLC and free sg_mbuf separately.

Error: inline SGT buffer still gets a BPID in both FD and SGE[0], and
  its refcnt is decremented twice (dpaa2_rxtx.c:720/722, :632/634).
  Set DPAA2_SET_FLE_IVP for cur_seg == sg_mbuf.

Error: no_conf_mbuf_to_sge() still rte_pktmbuf_init()+free_seg() the
  indirect regardless of refcnt (dpaa2_rxtx.c:606).

Error: per-packet helper failure still returns short after freeing or
  relinking segments; sg_mbuf leaks; the caller frees again. Free the
  packet, count a drop, continue.

Error (IEEE1588 builds, bisect): enable_tx_tstamp(&fd_arr[loop]) runs
  before the FD is built and writes through a stale FD address; the
  IEEE1588 block in dpaa2_dev_tx() is duplicated. 14 replaces it;
  fold that rework here.

Warning: confirmations pending at stop/close are never drained (drain
  is never true); their mbufs leak.

Warning: eqresp free rebuilds conf FDs via rte_dpaa2_bpid_info[256];
  loopback FDs on tx_vq[0] have stash config in FLC, deref'd as an
  mbuf with drv_tx_conf=1.

Warning: drv_tx_conf/drv_tx_dyn_conf order dependent (any 0 resets to
  NO_CONF, both 1 picks dyn silently). dy_conf[] written never read,
  struct sw_buf_free unused, "void *mq[nb_pkts]" VLA, tx_conf pulled
  once per packet.

Info: log does not mention the tx_deferred_start rejection or the
  error queue allocation change.


[13/14] drivers: bus/fslmc provide shared DPRTC RTC services

Warning: priv->rtc_handle in shared dev_private points at a
  dpaa2_dprtc_dev whose regs are the primary's DPMCP mapping. A
  secondary passes the -ENODEV guard and sends MC commands through an
  address not mapped that way, with the primary's token and its own
  mc_portal_lock. Return -ENOTSUP in secondary or open the DPRTC on
  the secondary's DPMCP.

Info: rte_dpaa2_alloc/free_dprtc_dev() exported but only the bus calls
  them, via fslmc_vfio_get/put_rtc_handle() wrappers unrelated to
  VFIO; handle is void *; DPRTC never closed; "DPCI" comments copied.
  Keep them static, use struct dpaa2_dprtc_dev *.


[14/14] net/dpaa2: support runtime IEEE1588 timestamping

Error: Tx timestamp only latched by a later tx_burst
  tx_timestamp is stored in dpaa2_dev_tx_conf(), called only at the
  start of tx_burst; read_tx_timestamp() just exchanges it with 0.
  examples/ptpclient and testpmd ieee1588fwd poll after one tx_burst
  and always time out.
  Fix: record the sending queue at transmit; read_tx_timestamp drains
  that conf queue with a bounded retry.

Error: timesync_disable leaves tx_tm_en set; the next TMST frame
  re-enables one-step from tx_burst. Clear tx_tm_en in disable.

Error: tx_burst still calls dpni_set_single_step_cfg() (MC lock, up to
  1 s spin) and tx_tm_offset is plain read/written by all Tx lcores.
  Configure one-step on the control path only.

Error: S/G frames read the Rx timestamp from m->buf_addr after the SGT
  buffer is freed (series 4).

Warning: Rx PTP flags now require RTE_ETH_RX_OFFLOAD_TIMESTAMP;
  testpmd ieee1588fwd enables timesync without it and rejects every
  frame. rx_tm_en never cleared. Register the dynfield and set
  rx_tm_en in timesync_enable() too.

Warning: eventdev Rx paths still drop the timestamp. Per-packet WARN
  and INFO in the Tx path, plus a per-burst "Multiple ptp formats"
  WARN. dpaa2.rst does not say PTP needs drv_tx_conf or
  drv_tx_dyn_conf. configure returns -1, not -rte_errno, on register
  failure.

Warning: commit log no longer describes the change: IEEE1588 guards
  dropped, absolute confirmation no longer forced, Rx flags tied to
  the offload, confirmation forced for TMST, multi-seg PTP rejected.

Info: TMST frames with headroom < 96 take the no-conf path: no Tx
  timestamp in DYNAMIC mode, FAEAD written into packet data in
  ABSOLUTE mode; "fd_faead->ctrl |=" should assign.
