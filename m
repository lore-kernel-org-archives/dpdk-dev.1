Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F90CA9EC5
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 21:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB5AE4027A;
	Mon, 12 Oct 2026 23:37:57 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 9ABE240272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 23:37:56 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ab066bef7dso1050745a91.1
 for <dev@dpdk.org>; Mon, 12 Oct 2026 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791841075;
 x=1792445875; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ssN5xiyaQIlPTUwWbVpQ2ekYpUnXsqF3iLwyIj8cnE4=;
 b=yhqtcu6FZnPFUiXFjJjJoHPEpK4A4pDCqLYJzdX5KSN8Sp7CJhZY7uxOfi5H/xech7
 HiOpBWzB4JjM7Qlhp/inNJU2JfncTFXRoSd3xBF57t+EfT/L1A2ewIAE+Lm4SEchnGjW
 1eA9L/zsj6Sp1kURkCUTDpFGZkv8JiKvN/C8jbkErJc1xV+xFTF98CcocbNxJD65YxD0
 FUBSoygECtR2uQu8ge1FXC162F3iWojONpVpo8IKShFof20D8jCAFKbzd1sdAvtxD1Vj
 ZM1wg3QzS6fp25Pdez4EEg80zBYLFS8XCmBqKGDsgYhZQ4NV99iRtnA+uIyIUSWCp6GJ
 PlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841075; x=1792445875;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssN5xiyaQIlPTUwWbVpQ2ekYpUnXsqF3iLwyIj8cnE4=;
 b=04c4x6TF5z1m/D12IFkRPreAAoOh6Ng9NliZZT0zlyG7M2AoSrZZ6G/oFCAxd9tSaF
 n5l9eBbhRpTZ3s6li1KRT5mp34LfThLSvYDXrKfHY31kL5Mj6pKo75sXmDjWF+7bDOxB
 1vX+jKFJc6DtDmhiCxs+aADhGrKviLTGTCUDAMTlqsT2cs2jhYD6oHY6lX0+1xy71Fqk
 JlpR28JBUDxeY3pjUdqcEN9xVWut1U6XZWCHshB3O61nBjwAEF7PN/myrnIWEUDJUHap
 v8ZIp2lb0K2C2zq8bjgibBnBRZgGM9A4hXuCuQnlBtAWz/RXL6TS3K+P3iZEC+GmDnB0
 Txkw==
X-Gm-Message-State: AFq9FYK+1fzyIqmLW+LP/+Orc5+dZiiBZapmhkkUXseCIG+I0KpD96Wl
 RbvPcN2hbhe8QPEZbQgPeOPNMTpMqwDEAtt6bE6OGTNr6yPCGHfzKE6O8IeTZah14y4=
X-Gm-Gg: AYBFou3D/3cN2H6sAmDUmuAMwWi325XaCjNv5oJXNA3PcAX6HeNHSEGsnpOfU3kz07H
 nQfcu8B94YRTVb9INMlPGseNyAEsHaDequcF1ejYNV97Ef1EGXWRBQXB71xT17/8zTZrXt4KWvg
 Gb/f+5Zvu/jcb/55QIf5Wxxn4+s56psAoh3Zd0/KfNmn9UdjJWn6QogxYRkcx8VO/s4SU9qnGbg
 Mg/ydNbCZY65rK4RofgO7Pw7kqN3TGJOh8ycZXG37wRkJWnRxDnHyw7FnWAke1jpCoJBH7MxEBA
 E+ZTbNQbzw8WzkhvOWM0xLLE3Av46N9uWCwlDCSMCBglydvhl4SxFyd242e7Z/QQsFfUwCe6MDJ
 w26gaktXpqhytPBL/3+RTCSBseWm8mzEZGwzUX6YftVZgJUhKuftcAR5fUs+nNeBDKA8Nltnv7n
 PlUw1PQOfQYhjgvjcx/DWtU9f+3CT07ngME8lanqdap+N7rt2W+EOQvpS1hZtdEHJyiXqKnMxYQ
 ZnKtU4UwbqzKh1qK2R+5zTPO0e1DyNpEBsCDFDk
X-Received: by 2002:a17:90b:268f:b0:3a4:6e84:e7f6 with SMTP id
 98e67ed59e1d1-3ab3a32cbadmr8860840a91.5.1791841075352; 
 Mon, 12 Oct 2026 14:37:55 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab32d5a429sm10113324a91.0.2026.10.12.14.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:37:55 -0700 (PDT)
Date: Mon, 12 Oct 2026 14:37:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Cc: dev@dpdk.org, Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH 0/2] net/mana: fix transmit burst and add hardware TSO
 support
Message-ID: <20261012143752.184a7fbe@phoenix.local>
In-Reply-To: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
References: <20261012073626.642397-1-tathagat.dpdk@gmail.com>
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

On Mon, 12 Oct 2026 07:36:24 +0000
Tathagat Priyadarshi <tathagat.dpdk@gmail.com> wrote:

> This patch series addresses transmit burst error handling and introduces
> hardware TCP Segmentation Offload (TSO) support for the Microsoft Azure
> MANA PMD.
> 
> Patch 1 fixes the transmit burst loop in mana_tx_burst() to terminate
> with break instead of continue upon packet errors. Under the DPDK
> rte_eth_tx_burst() API contract, callers expect a contiguous prefix of
> transmitted packets. Skipping a packet caused unsent packets to be treated
> as unsent and freed by caller, followed by a second free upon hardware CQE
> arrival.
> 
> Patch 2 adds support for hardware TCP Segmentation Offload (TSO),
> formatting SGL entries with packet headers in SGE0, handling GDMA work
> request flags, advertising RTE_ETH_TX_OFFLOAD_TCP_TSO, and updating
> the mana driver feature table.
> 
> Tathagat Priyadarshi (2):
>   net/mana: fix transmit burst error handling
>   net/mana: add hardware TSO support


Several problems with this patch series.

Review: [PATCH 1/2] net/mana: fix transmit burst error handling
        [PATCH 2/2] net/mana: add hardware TSO support

Series summary
--------------
Patch 1 correctly identifies the bug (continue breaks the prefix
contract and leads to double free) but the fix trades it for a
head-of-line block. Patch 2 carries a stable-worthy bounds fix that
should be in patch 1, and adds more break-on-bad-packet paths.


Patch 1/2
---------

Error: break on a per-packet validation failure stalls the queue.

A packet that exceeds max_send_sge, or whose MR lookup fails, will
fail again on every retry. Applications that loop until all packets
are sent (testpmd with retry, most forwarding apps) spin forever on
it. Short return from tx_burst is for ring full / backpressure only;
a bad packet must be dropped, counted, and consumed so the prefix
contract still holds.

Keep pkt_sent for the doorbell, and return a separate count of
consumed packets:

	uint16_t nb_done = 0;
	...
	if (unlikely(m_pkt->nb_segs > priv->max_send_sge)) {
		DP_LOG(ERR, "send packet segments %d exceeding max",
		       m_pkt->nb_segs);
		goto drop;
	}
	...
	if (seg_idx != m_pkt->nb_segs)
		goto drop;
	...
	if (!ret) {
		...
		pkt_sent++;
		nb_done++;
		...
	} else {
		break;		/* ring full: real backpressure */
	}
	continue;
drop:
	txq->stats.errors++;
	rte_pktmbuf_free(m_pkt);
	nb_done++;
	}
	...
	return nb_done;

Note the RTE_ARCH_32 short doorbell break happens after nb_done is
incremented, so the count stays correct there.

Info: CQE suppression is decided before the next packet is known to
be valid. If the packet after a suppressed WQE fails, no completion
is generated until a later burst posts an unsuppressed WQE; with no
further traffic those mbufs are held indefinitely. This existed
before, but break makes it reachable from any mid-burst failure
rather than only the last packet. With drop-and-continue it is back
to the last-packet case only.


Patch 2/2
---------

Error: same as 1/2. The new "TSO header cannot be fragmented",
"Invalid IP version for TSO" and "failed to build TSO SGL" paths
all break and leave the packet at the head of the burst. They are
permanent per-packet failures; use the drop path.

Warning: the MAX_SGL_ENTRIES_FOR_TRANSMIT check fixes an existing
bug and does not belong in a feature patch. sgl.gdma_sgl[] is sized
MAX_SGL_ENTRIES_FOR_TRANSMIT (30) but the old non-TSO loop writes up
to nb_segs <= max_send_sge entries, and max_send_sge comes from the
device with nothing clamping it to 30. Move that check to patch 1
(or its own fix with Fixes/Cc stable), and clamp what is advertised:

	dev_info->tx_desc_lim.nb_seg_max =
		RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);
	dev_info->tx_desc_lim.nb_mtu_seg_max =
		RTE_MIN(priv->max_send_sge, MAX_SGL_ENTRIES_FOR_TRANSMIT);

Also, a TSO packet with payload in the first segment needs one
extra SGE. An application that honours nb_seg_max will still get
drops; either advertise nb_seg_max - 1 when TSO is enabled or
document the limit in mana.rst.

Warning: RTE_MBUF_F_TX_TCP_SEG implies RTE_MBUF_F_TX_TCP_CKSUM
(rte_mbuf_core.h). When TCP_SEG is set but the packet falls back to
the non-TSO path (tso_segsz == 0 or no payload), the TCP checksum
is only offloaded if the application also set TCP_CKSUM. Make the
fallback honour the implied flag:

	} else if ((m_pkt->ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
			RTE_MBUF_F_TX_TCP_CKSUM ||
		   (m_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {

Warning: no release note. New driver features go in
doc/guides/rel_notes/release_26_11.rst under New Features.

Warning: commit message is a bullet list restating the diff (which
macro is defined where, which field is zeroed). Say what is added
and why, and how it was tested: which Azure SKU / MANA firmware,
IPv4 and IPv6, single and multi-segment mbufs, e.g. testpmd
"csum set tcp hw" + "tso set <mss>" with iperf through the VM.

Info: the num_sge >= MAX_SGL_ENTRIES_FOR_TRANSMIT check inside the
TSO segment loop cannot trigger; expected_sge was already checked
against the same limit and nb_segs bounds the walk. Drop it.

Info: GDMA_WR_OOB_IN_SGL and GDMA_WR_PAD_BY_SGE0 are hardware work
request flags. Put them next to struct gdma_work_request (the flags
member comment already refers to them) rather than between the
offload capability macros.
