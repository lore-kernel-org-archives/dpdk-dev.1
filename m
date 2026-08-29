Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671C8C61DD9
	for <dpdk-dev@archiver.kernel.org>; Sat, 29 Aug 2026 16:06:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A41AF4026D;
	Sat, 29 Aug 2026 18:06:53 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 126EB4025A
 for <dev@dpdk.org>; Sat, 29 Aug 2026 18:06:53 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d71a50caa9so25187055ad.0
 for <dev@dpdk.org>; Sat, 29 Aug 2026 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788019612;
 x=1788624412; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/kT329+aUxib4lx/5hC6dMEfrE+Ywn0leeK1/YqTbRo=;
 b=cJ1FwHOzvbIorSG+dwb1ENFUWURkDEI7NxaQQ5tkrbE9e6cmqJFiKclYtMnbr4L5R5
 karXTXwbt7WygIv+rdO9AGcz6i51Iuf/pwugVvjPhCnW0j1dhkJCNRZQRK7b7rzw/6ZO
 dfTOlMjjhOkArfWSzNjVHswgvMJNLIVRUQ+UwOcLuzAZEeOhaBwlCROYf+j9TXVSMVBj
 Y0RHng6VyPc/vnVVFV3XitA0yzNLScY/u0o+GfrHbCvKuJiRBHcdxA50HxT+61BHbXbn
 FaDiXHttjZkVQWYb+wxpxLS0IMuW3btFrlqCSwDPcWea2OUasFW/RWvmoDZfdMZDtGcT
 AHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788019612; x=1788624412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/kT329+aUxib4lx/5hC6dMEfrE+Ywn0leeK1/YqTbRo=;
 b=lBZJeDKismtuh+3HXSbSyCQHbHsdCaB+rNQavflLgKS6u/kq+vl+vq7NaVvGJ5PYMx
 CYBOAtCPOHzvV4FU6kgJbPo3Dyp046dXB+I2ZKvF4STmMsmNrtOTyxreU/K6OTOEb5Jm
 stnnBvM66koKkmQYrsLPLsvzQw/a+clMZW+uursRXldQ2moBV/E4GZWKzpUP1e51M97c
 rBgV8w/tkaMQOcgrpf8xoRbq640nkVDQL3WoPp6XgYZVTGTILuYAquo5YSbY45eNU9HF
 s8WF5ZHT3FyWaDkcERc0bnmBwB13+oOnszWMvslV3B+eZQI20QWqrpLNh4seAnr4t8mu
 gNRw==
X-Gm-Message-State: AFuF++mgVlJZ9QGUnCCtIIX+8yiqZqRT0TP5XoWGb7Oxo4b8unSmNxi3
 EKk4IMzQFK4ybN2UgdhV110MFRiVFqM2aC9LFyv9U/7c3DXR2TXyrlVbc83WLzLmGLU=
X-Gm-Gg: AYBFou3z+NY0oYluhC80fDt18T7PvecTF1egL5i3DYyETZsdUWHS54FZCetP7HOGN5z
 c8jpYrHZuEzjgG8rsr6SBPso149mDiZ2ZxqiOMP9nLV5vLUfQQHz9k+nEM09cM5p4tib90WN60R
 ZwGqAUUX2sb60lybotmuQjRpwS91WSHix7dJzj1ro4O1qjp0BUUyEOo393uXZcI5ZwLV2Y65IGQ
 icJl7HppU5ukQ4cOSfbn4S8VDFVFB/eA6RcXKZMzN/rwioQUr4wwOLYTXuAaquoVWNIfGt6+fNl
 LFCJFkw0HXobN+Td9yncHrX+BO0gpdhxh9CS0jyM1fhRxOgg1Vc7icKcz65gp/7i0mf+QrOfaiY
 PdGmMDWKi/0UvfF5s1qQINdvl2cwyi/Is9e/w7nyuuHwmL/Z+7UYUuazYIw6cQ133C73cNUdLxA
 /LF7AQrdRzFVlD2XGK2wVKbZ/O6mYY3ViN6jDNFtXUC8NdltJpI6UzBCRiChe8migG8XofslRfU
 Rgc39hZ9uftOuQ94Tgl/nzwVnMc5MsI4izZh4W4
X-Received: by 2002:a17:903:1b25:b0:2d8:d4cc:5bb3 with SMTP id
 d9443c01a7336-2d8d4cc5d8bmr108678605ad.19.1788019610549; 
 Sat, 29 Aug 2026 09:06:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7bf283sm18387023eec.8.2026.08.29.09.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 09:06:50 -0700 (PDT)
Date: Sat, 29 Aug 2026 09:06:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v13 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260829090642.60b55372@phoenix.local>
In-Reply-To: <20260829074155.3524274-1-wang.junlong1@zte.com.cn>
References: <20260825120007.3328990-1-wang.junlong1@zte.com.cn>
 <20260829074155.3524274-1-wang.junlong1@zte.com.cn>
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

On Sat, 29 Aug 2026 15:41:50 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v13:
>   - Patch 3/4: simplify `zxdh_set_rxtx_funcs()` (keep the runtime
>     `ZXDH_NET_F_MRG_RXBUF` check that is always negotiated);
>     remove the unused `size_bins[]` xstats (both Rx and Tx) and
>     the long-dead `#ifdef QUEUE_XSTAT` body.
>   - Patch 4/4: the inner `do { ... } while (curr_id != id)` is kept
>     (defensive backstop matching the commercial branch, run once
>     under the `desc[k].id == k` invariant).


AI review is still seeing lots of things that look concerning:

Review of [PATCH v13 0/4] net/zxdh: optimize queue/Rx/Tx paths

Resolved since v12
------------------

- Patch 3: the ZXDH_NET_F_MRG_RXBUF check is back in
  zxdh_set_rxtx_funcs(), and zxdh_dev_start() now propagates its
  return value instead of dropping it.  A device that did not
  negotiate the feature now fails the start rather than running
  with unassigned rx_pkt_burst/tx_pkt_burst.
- Patch 3: the release note bullet is generic ("Changed the set of
  per-queue xstats counters") rather than enumerating counters.
- Patch 4: ndescs is removed from struct zxdh_vq_desc_extra rather
  than renamed to rsv.
- Patch 4: the macro is ZXDH_NEXT_CACHELINE_OFF_16B, matching the
  prefix used everywhere else in the file.
- Patch 4: the comment in zxdh_xmit_enqueue_append() names
  zxdh_queue_detach_unused() as the reader of the head cookie.

I also checked that nothing in the tree still references the fields
and helpers the series removes (sw_ring, ndescs, size_bins,
stats.full/norefill/multicast/broadcast, fake_mbuf,
mbuf_initializer, vq_packed.cached_flags/used_wrap_counter/
event_flags_shadow, zxdh_desc_used(), notify_queue, tx_indir,
vq->offset).  Fixes: 7677f3871ef3 resolves to a real commit whose
subject matches.


Warnings
--------

Patch 2/4 (net/zxdh: optimize queue structure to improve
performance)

1. Commit message, item 4

       4.rename the misleading rsv_8B (uint32_t) field and remove
         unused next_qidx member.

   Neither rsv_8B nor next_qidx exists anywhere under
   drivers/net/zxdh, before or after this patch.  The reserved
   fields in struct zxdh_virtqueue are rsv, rsv1 and rsv2 both
   before and after, and no member named next_qidx has ever been
   in the driver.  This item looks left over from an earlier
   revision; please drop it or reword it to describe what the
   patch actually does to the struct.


Patch 4/4 (net/zxdh: optimize Tx xmit pkts performance)

2. Commit message, item 2

       under the invariant the inner loop runs once, and the
       curr_id-anchored walk backstops the case where the device
       overwrites the id.

   That holds only for the single-descriptor push path.  For
   anything that goes through zxdh_xmit_enqueue_append() the
   driver builds a real packed-ring chain: the head descriptor
   carries ZXDH_VRING_DESC_F_NEXT, and one descriptor follows per
   segment.  The device returns one used descriptor per chain, at
   the head position, carrying the buffer id taken from the last
   descriptor of the chain.  So in zxdh_xmit_fast_flush()

	id = desc[used_idx].id;

   is the index of the last descriptor, not of used_idx, and the

	do { ... } while (curr_id != id);

   walk is what frees the per-segment cookies and accounts
   free_cnt.  It is the primary mechanism, not a backstop.

   This is not an edge case: any mbuf that fails the can_push test
   takes the append path, so a plain single-segment packet without
   enough headroom already produces a two-descriptor chain.  If
   the inner loop really ran once there, the payload mbuf would
   leak and vq_free_cnt would be short by one on every packet.

   The code looks correct as written.  The description does not
   match it, and it is worth confirming against the hardware that
   the device does return the last-descriptor id here rather than
   the head's - the whole flush depends on that.


Info
----

Patch 3/4

3. drivers/net/zxdh/zxdh_rxtx.c, zxdh_dequeue_burst_rx_packed()
   drivers/net/zxdh/zxdh_queue.c, zxdh_queue_rxvq_flush()

   Both index vq_descx[] with a device-written id and neither
   bounds-checks it:

	id = desc[used_idx].id;
	cookie = (struct rte_mbuf *)vq->vq_descx[id].cookie;

   Patch 4 adds exactly this guard on the Tx side ("break on
   id >= size"), so the two paths are now asymmetric.  The Rx
   exposure is pre-existing, but it is a one-line check and worth
   adding while the surrounding code is being touched.

4. drivers/net/zxdh/zxdh_rxtx.c, zxdh_refill_desc_unwrap()

   This is a near-copy of zxdh_enqueue_recv_refill_packed() in
   zxdh_queue.c, which after this patch is only reached from
   zxdh_dev_rx_queue_setup_finish().  Since the setup path is not
   performance sensitive, it could call the new wrap-aware
   helper (or a small wrapper over it) and the old one could go
   away.

5. drivers/net/zxdh/zxdh_rxtx.c, refill path

   zxdh_queue_notify() is still called whenever vq_free_cnt > 0,
   including when rte_pktmbuf_alloc_bulk() inside
   zxdh_refill_que_descs() failed and no descriptor was made
   available.  Item 4 of the commit message covers dropping the
   kick_prepare check but not this case.  Having
   zxdh_refill_que_descs() return the number refilled and
   notifying only on a non-zero result would avoid an MMIO write
   on the mempool-exhausted path.

6. drivers/net/zxdh/zxdh_rxtx.c, zxdh_init_mbuf()

   The first error path increments invalid_hdr_len_err only:

	rte_pktmbuf_free(rxm);
	rxvq->stats.invalid_hdr_len_err++;
	return -1;

   The second error path in the same function, and the equivalent
   path in zxdh_recv_pkts_packed(), also increment
   rxvq->stats.errors.  A packet dropped on the single-segment
   fast path is therefore invisible in the "errors" counter.

7. doc/guides/rel_notes/release_26_11.rst

   The added block leaves a single blank line before the "Removed
   Items" heading; the file (and every other release notes file)
   uses two blank lines between sections.

Patch 4/4

8. drivers/net/zxdh/zxdh_rxtx.c, zxdh_xmit_fast_flush()

	do {
		desc[used_idx].id = used_idx;

   Both enqueue paths write id unconditionally before making a
   descriptor available - zxdh_xmit_enqueue_push() does
   "dp->id = id" and zxdh_xmit_enqueue_append() does
   "start_dp[idx].id = idx" for the head and for every segment -
   so the invariant is re-established at enqueue time regardless.
   This store is redundant, and it is a write to DMA-coherent
   memory in the Tx fast path of a patch whose purpose is Tx
   performance.

9. drivers/net/zxdh/zxdh_queue.h

   Split-ring leftovers survive the cleanup in patch 2:
   vq_desc_head_idx and vq_desc_tail_idx are written in
   zxdh_init_vring() and never read, and struct
   zxdh_vq_desc_extra's "next" is written by
   zxdh_vring_desc_init_packed() and never read.  Dropping "next"
   would shrink vq_descx[] to a single pointer per entry.

   The Doxygen-style block comment on vq_desc_head_idx also ends
   with "**/" rather than "*/".
