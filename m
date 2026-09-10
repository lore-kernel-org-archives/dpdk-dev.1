Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78684C79FBF
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 16:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45E67427BA;
	Thu, 10 Sep 2026 18:57:44 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 1EF4E40274
 for <dev@dpdk.org>; Thu, 10 Sep 2026 18:57:42 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747ed9866so16550785ad.2
 for <dev@dpdk.org>; Thu, 10 Sep 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789059462;
 x=1789664262; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E/dOPyoHJfWrAMGHfzhTagZHm0IV5iaP5sfX1NORBd8=;
 b=KVPTYCrEe8d/ulMJOWBDxKKNXx2eiLlzDF3+8+xeoABS9qli/5j37bV0g8ENu82V5E
 gdpZtekaKVYuuTSjpf/A0oKHyApeafE6Qc593R/MRCy03obukL5gqCCVPUUylc8nvJe9
 rNnRBksX5MW5UN2elAnc2H6bq98YqI4m/XJpP9D/R30k4DsdOnSfKq0j0jrLIiQctiQF
 YbiC6YG2DXWqXFikzNwjedvtKKP7+BN2DLOsGoVUtGUnqLEMN4+/UFTFq+lzhFtXPgBH
 TShJgFjvo6hBEWpaOAHpwFk+LmjLyYBB/y7A2sYuU0XH4hEVLaCr9MDYFqsFx4ATduuM
 owBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789059462; x=1789664262;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E/dOPyoHJfWrAMGHfzhTagZHm0IV5iaP5sfX1NORBd8=;
 b=HKzbMLfjEDZtrLC+ENMMz5SfQtyw5vqbl+eKAkwIMrDeIpz8zNXP/eqPmJtCWwlMy6
 C8rMkCjk+PJ/rECFxLiJYeS//HdWlC4D3BKIBTgKorvmZPu3FRYCkXYl7Vm5pCdc3ahS
 fJRSnBjCZouok108AjOpFqj2ki7/RzHBcSE/e91RF6suVlH8gUNKLyx3hsz/6RpCcTfg
 b+gtI4IUZGUjqy3mTEsGgjWdVwzjLWEsSH+Z1u6NPeKv1kl6ghfZPP7y7EKrp8wiGMj7
 w5EqP828gO/8dJK1o8XIS7YJ3FawCm/1L6NkjxcKHX/9rRNkFbEPHQTG3YZwAWif2cvP
 7jyA==
X-Gm-Message-State: AFuF++nGj4CYzGsjwwylW8Y9l2vM1d7Ul7k1Lpub/kBAlza5gFzbOV1A
 7ghAq+GUuLf24xsdp9TMlaWLlnTi1oIJXozsZ6EaKOPaykmJCqUtVKobR69XIz2dX7Q=
X-Gm-Gg: AYBFou2m+DEvgHoTlqmS3ApICyFv/SbRLt5OYiQHpY82ev4whCpQvF+xntYWDcVIKx4
 ytAw1ZsEeZ2l3R4F2l4CrErM3n0q0CdbnB1M50DZWaXpwrijH2vyHgJKYbbQdlDJ31kxlLyr4vO
 dRxjQvymtzY2n8b5fIg1+e1Y4tvhi3SmB7EosdbQmwkbChitiOn3xTyPOgOdvLFXuw2QbohthoF
 bNq+3jJ8p9UCQudfjO6ARAalUUSQcDk4HmJns8K5bVh/pIn88SrcFw3vYCX0qZPBOMCiKTis2Gm
 yJ/BI7jc2OQ+qsE2MXCKwFfig/aPzSvSsT7B6gUjzyDnYKSSYSj1NU3YhomNN1TTYYiL1biRfNQ
 J6f9ujApT0c/QQ9wsqFAh1H0Rmr6FSNYWGg/OKlXeNKshRNyJ2fB3Ajo8lnNZA8GeufMuwu34fF
 HiBGVeN7gXo54l9THwgwrdrzsq23hnl49LdnGB8G4JkzHV2qxiyaUtNAQkF853sL4SEn/syIGwj
 zQYcvZZQi84jK4l3hzSMGqLWnioiczeybOyROWj
X-Received: by 2002:a17:90b:558c:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-39d70ae1a5emr13543755a91.13.1789059461644; 
 Thu, 10 Sep 2026 09:57:41 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d9947b847sm87109a91.7.2026.09.10.09.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 09:57:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:57:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/47] NXP DPAA2 driver updates and fixes
Message-ID: <20260910095732.16925849@phoenix.local>
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

On Thu, 10 Sep 2026 19:21:11 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series brings the NXP DPAA2 drivers (net, crypto, dma, event,
> mempool and the fslmc bus) up to date with the current internal tree.
> It carries bug fixes, a reworked flow engine, an extended parser, meter
> and policer support, PTP enhancements, and a number of performance
> improvements in the Rx/Tx and DQRR handling paths.
> 
> The series is based on commit c1a46b9d9243 and is intended for 26.11.
> 
> Changes in v2:
> 
> - Dropped the header-only patches; every remaining patch now contains
>   the implementation together with its declarations.
> - Addressed all findings reported by checkpatch; the series is clean
>   against the current checkpatch.
> - Removed the per-device Tx scatter/gather pool member that was never
>   assigned, and used the existing global pool instead.
> - Widened the DQRR held-mask shift to 64-bit to avoid undefined
>   behaviour when the DQRR index exceeds 31.
> - Bounded the MAC xstats collection loop by the size of the statistics
>   array.
> - Treated the traffic class priority mask as a bitmask rather than an
>   index.
> - Added a per-entry DQRR consume fallback for portals whose DQRR ring
>   does not fit the vectored consume encoding.
> 
> Each of the review fixes above has been folded into the patch that
> introduced the code in question, so the series remains bisectable.

Still get lots of issues when running this through Fable for review.

Subject: Re: [PATCH v2 00/47] DPAA2 driver updates

Reviewed all 47 patches against upstream main (d55ccd4) and diffed
each against its v1 counterpart. Series applies cleanly.

Summary: five v1 findings were fixed, two new ones were introduced,
and eleven patches still carry the errors reported on v1. Every
change in v2 was to something called out in the cover letter or to a
one-line site; nothing that required reading a v1 per-patch comment
was addressed. Details below, then the process points.


Fixed since v1
--------------
31: sg_mbuf allocated from the global dpaa2_tx_sg_pool (priv member
    was never assigned); UINT64_C(1) << dqrr_index restored.
35: mac_num bounded by DPAA2_MAC_XSTAT_MAX_NUM.
40: priority_mask = RTE_BIT32(tc_id).
41: vector consume gated to dqrr_size <= 16.
Flow engine split into 36 + 37/38/39; the broken "double free on
uninit" patch was dropped. AES-GMAC got its string table and note.


New in v2
---------
1:  Unrelated hunks squashed into a Cc: stable fix. Besides the GCM
    change it now carries dpaa2_sec_parse_int() and the drv_dump_mode
    handler rewrite (patch 6's), fle_sdd_pre_populate() void->int and
    the long_copy mempool_put (patch 10's), and an unused
    #include <rte_string_fns.h> in dpaa2_flow.c. Backported as-is it
    drags dma and net into stable under a crypto tag.

31: struct dpaa2_queue * RTE_ATOMIC(next_txq_to_cnf);
    Under -Denable_stdatomic=true (the GitHub CI stdatomic job) this
    expands to _Atomic(next_txq_to_cnf) and does not compile. v1 had
    RTE_ATOMIC(struct dpaa2_queue *) next_txq_to_cnf; which is right.
    32 also dropped v1's rte_atomic_load_explicit() on it.

23/27/32: Regression. The DPAA2_PMD_DEBUG line-buffered dumps from v1
    are back to fprintf(rte_log_get_stream(), ...), bypassing log type
    and level (and a checkpatch forbidden token). 32 also uses %ld for
    time_t. v1 was correct here.


Still open from v1 (errors)
---------------------------
6:  Env vars override devargs. dpaa2_sec_get_devargs() is called once
    per key; whichever key is absent falls to env_set:, which reads
    both variables and overwrites what the other call took from
    devargs. Parsing was hardened; the control flow is the same.
    getenv() in a driver stands.

13: rte_dpaa2_mpool_get_ops_idx() returns 0, not the index, after a
    successful IPC round trip. mp_req is uninitialised (len_param,
    num_fds are stack garbage; send_msg() attaches num_fds fds).
    rte_mp_action_register() failure returns past bp_list/bp_info/
    dpbp allocations instead of goto err4.

15: nb_rx_queues/nb_tx_queues are uint8_t; num_rx_tcs * num_queues is
    truncated before the > MAX_RX_QUEUES check (8 x 32 -> 0). The new
    fqid != DPAA2_INVALID_FQ_ID early return in rx_queue_setup fires
    on every reconfigure because rx_queue_release never resets fqid,
    so new mb_pool/nb_desc/offloads are ignored and the CGID that
    release cleared is never re-installed.

18: dpaa2_mtr_ops_get() re-initialises priv->meter_lock on every call;
    rte_mtr_ops_get() invokes it at the start of every rte_mtr_*().
    profile/policy delete silently frees meters in use; rte_mtr.h
    says EBUSY.

23: priv->psr_dynfield_offset is never assigned in 47 patches; priv is
    zeroed, so dpaa2_dev_rx_parse_offset() writes l3/l4/l5 offsets
    into mbuf byte 0..2 (buf_addr) on every received packet. Rx
    timestamp path removed here and not restored until 32; the
    IEEE1588 build is broken in between (call to a deleted
    dpaa2_timestamp_dynfield()). The !by_channel guard from upstream
    57b8ce0 is still dropped in prefetch_rx_common.

26: num_rx in dpaa2_dev_rx_common() is uint8_t; wraps at 256 while
    next_pull keeps the loop going. cluster_sdest divides before the
    zero check.

27: mmap() result tested against NULL, not MAP_FAILED, in scan(), so
    any host with STRICT_DEVMEM dereferences (void *)-1 at EAL init.

28: dpaa2_eth_eventq_detach() clears DPNI_QUEUE_OPT_DEST before the
    dpni_set_queue(), so DEST_NONE is never sent and the FQ stays on
    the DPCON. Taildrop failure in rx_queue_setup returns instead of
    goto err_free_dpcon.

31: dpaa2_dev_tx_mbuf_to_simple_fd() frees the mbuf on copy failure
    (goto quit; rte_pktmbuf_free(mbuf)) and dpaa2_dev_tx() then
    goto send_n_return, returning a count that excludes it; the app
    retries a freed mbuf. Same shape for the cloned branch, the
    mid-chain -ENOMEM from no_conf_mbuf_to_sge() (chain already
    mutated, sg_mbuf leaked), and multi_txq_ordered via send_frames.
    A per-packet failure is either drop-and-continue or leave-and-
    return-short, not both.

32: rte_pmd_dpaa2_set_one_step_ts()/get_one_step_ts() (exported
    experimental, 24.11) deleted from dpaa2_ethdev.c; prototypes
    remain in installed rte_pmd_dpaa2.h. Link failure, no deprecation.


Still open from v1 (warnings, short form)
-----------------------------------------
3:  lib/cryptodev hunk should be its own patch; AES-GMAC still
    advertised in the plain-sym capability table while only the IPsec
    path accepts it.
7:  Byte-identical; PAGE_MASK on the two lines above the new check is
    still the unvalidated sysconf() value.
8:  Byte-identical; the -Warray-bounds it "fixes" is created by patch
    11, so Fixes:/Cc: stable are wrong, and 8 KB idxs[4096] per VQ
    for idxs[0].
10: Commit message now says rte_panic(); the code returns -ENOMEM.
12: BMT flag applied only when a pooled context is first initialised
    (sg_entry_post_populate() never writes ctrl.bmt); long-FD path
    ignores it entirely. New public flag undocumented.
16: dpni version gate is == 8 && >= 7; use dpaa2_dev_cmp_dpni_ver().
    Header says 0xF7FF, code returns 0x10000.
23: "No functional change" while packet_type on LX2160A changes.
24: dpaa2_supported_ptypes_get() not updated for any new ptype.
34: Callers moved to V3/V3/V2 MC command ids with no version gate
    until 36; older MC breaks every flow rule in between.
35: xstats_get_names() returns limit, not the available count, when
    limit < count.
36: RTE_DPAA2_FLOW_GROUP_TYPE_GET and friends are #ifndef stubs for
    macros nothing upstream defines; the QoS/FS group paths (and 39's
    miss-action group handling) are unreachable. getenv() still read
    on every flow_create(); 13 rte_memcpy() on the control path.
Docs: the only change under doc/ in 47 patches is the AES-GMAC note.
    Missing: three new devargs and a changed drv_tx_conf meaning,
    mpls/pppoes/geneve/meter/meter_mark in dpaa2.ini, metering, the
    Removed Items entry for 32.
Fold-ins: 33 carries edits to 31's code; 44 cleans up 36; 46 removes
    the duplicate mc_get_soc_version() that 26 adds.


Process
-------
The v1 -> v2 delta looks like a re-export from the internal tree with
a few fixes applied there, not an edit of the posted series: patch 1
picked up hunks from 6 and 10, three patches lost the logging cleanup
v1 had, and 31's atomic declaration went from right to wrong.
Working that way means every review comment has to be re-applied
twice, and upstream changes under you (57b8ce0 is still lost) have
to be re-done each time.

Recommendation unchanged: split by tree so the parts that are close
can go in. bus/fslmc first, then crypto, dma, mempool and net as
separate series, with the Cc: stable fixes at the front of each and
containing nothing else. Per-commit builds with -Denable_stdatomic
and RTE_LIBRTE_IEEE1588 before posting. Docs with the code, not in a
follow-up.
