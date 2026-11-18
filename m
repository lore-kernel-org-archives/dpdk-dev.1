Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54054606A332
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G0j5IWJg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C78F1402DA;
	Thu, 19 Nov 2026 00:54:19 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 7981E4029D
 for <dev@dpdk.org>; Thu, 19 Nov 2026 00:54:18 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so1245330a91.1
 for <dev@dpdk.org>; Wed, 18 Nov 2026 15:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795046057;
 x=1795650857; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7HyxK5PK44K0v/LsTNFRXCEiZ6ftKGmhKAKJBgcIpuo=;
 b=G0j5IWJg98pcXZe1vaRmvA7agWZ0NRajBIiz27Risp2QqH+J3ShAGMNO7FBsV5jo9S
 wNdUGVWTJNU9WSQpXYg3rMOUyAyB1ork9YGQbGbQI9F2JRaEDYrVy7pm9m1WEkbcGrYM
 rfVhwYD/I3/wXyjbzQ8prC40hhlTP9EtqNfQAj4aoGPe0w/WapStxjXtvzYVZyujXdHv
 flSBfdap3mmYsY5YiaLn52SBc7ti2bMUKW3sZejqH7+IJJLsnP9+noZPmOu2x1qSC5t5
 C13HorQxrxqbC4PZ25ljmI3xgTX44840ry+4250938Jwwtc2DnH1G8RNuqPo+5yRvOeT
 +Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795046057; x=1795650857;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7HyxK5PK44K0v/LsTNFRXCEiZ6ftKGmhKAKJBgcIpuo=;
 b=afWVJ59R4YuhfKCgqqfLKtcqv0dSvUTX9DlaFs1FzfU7XefftedjdU5yiSb7Yeb7hQ
 A/qTr6pub5C5HsJVyQiRdOTDIZ0edVrJkMjFDvfG7i8bqqsR4MOKxLkENOlu2UdOJBLM
 ooUmtPgZ+4HwMfzvA2gkYOKaGJgGc0QLhwCYgRVagUmvYSpvOESw5Do/KO9cgJug4HQf
 CYvZDiZVZEpU+1rBdt1DbTo30jiEeyHI6wdugLp64ufHuKGbedw7LwGojlNSCYZlbd6H
 YZ/FXCe/7NRkK0aoSgIQas6bl1O1ECHtW3uRz+AGn+7MXnts3eReMNU4cQahIJqnZtKy
 fihQ==
X-Gm-Message-State: APuU4Z+kAgTm5NbxijI3ULYfDqx1/2ALexpvv2mlzpIBW8/9wSprdhZy
 kb6A82ztrmSOzsY0F6uppZd232mbFWCnNVXDhgWctw30ZomFttgQfngBKg7G3MmyWgs=
X-Gm-Gg: AZFdTZflaXJw40WUIe4hpozGKua9jYA2lYONS8ADfCoKDdJYrN0O9hJ/fzMWqMqZEQF
 4vZj6gIgPYNUcqON2jhDcnyc8fU2ju/PmQ9a2Ox1nHLlkIkxNqGTbBQMfdiFdl3jbc41DFPDzlb
 kE6Qo5CCcGIaWNRHk6OJ+myQci7UfnF0SB886Up9vF90Nk9jE9PmO2zPLVTtXPjs45j6PmIAzJr
 4MPhkYSUZ7nGWivDqi6id8HdXpsdOK0Zi4uaTkmO/PXcNgGaG2tCDgjclAjjyp1CVYhhCP3b099
 opHYoBIM0fdkM6l4ozyjb7NmlFQHSN6gnNFjX2d38zKEnEqgNpsQgGBW8lwXaJucv0tiiLp0Znk
 8YaV30FmRxMRX0WFXhl1OzZeq+MK2AkHVt8cxYkmzQleDfvYG3nmDlqpuGZl83gDBzQyWs42TA2
 EJWUFM5+fdInk+QUWAd9N9iwEcmpLz4l8+m69J+ANSA3CM27HK7sMn4zVB8roLfscyLy2P9KJkq
 PFqSwyuhRE3AGHpvv3Z/ffuYcVijRmrJ5CkCVYOvwewBImQMVEVsRZbW6p1jDZp5dEHtBEjfWQw
 IjYN9oTRVW1DDNrPDCYzJupNFuhXRCumcbAKICZkDuXNuvj+lUhRSEVJE1XxJbQHLDeq6J4=
X-Received: by 2002:a17:90a:dfc8:b0:3b3:b704:118c with SMTP id
 98e67ed59e1d1-3b3d07d905bmr3880004a91.65.1795046056566; 
 Wed, 18 Nov 2026 15:54:16 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff611630asm20492415ad.17.2026.11.18.15.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 15:54:16 -0800 (PST)
Date: Wed, 18 Nov 2026 15:54:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v7 00/29] net/hinic3: add PMD features and fixes
Message-ID: <20261118155408.02146b5f@phoenix.local>
In-Reply-To: <20261117155711.1048-1-yejiacheng4@h-partners.com>
References: <20261109162033.1144-1-yejiacheng4@h-partners.com>
 <20261117155711.1048-1-yejiacheng4@h-partners.com>
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

On Tue, 17 Nov 2026 23:56:41 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> net/hinic3: add PMD features and fixes
> 
> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and a handful of driver defects, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.
> 
> Changes in v7:

Need to resolve the last warning.

Subject: Re: [PATCH v7 00/29] net/hinic3 series

All 29 patches apply to main and every commit builds with
-Dwerror=true. The open items from v6 are resolved: SP230 no longer
allocates eventfds or enables the Rx vectors when intr_conf.rxq is
off, dev_start honours admin_down, set_link_down restores admin_down
on failure, the Fixes: hashes are 12 characters, and rss_en now
tracks rss_type.

Two warnings remain, both about documentation rather than code.


Warning
=======

[PATCH 20/29] net/hinic3: refactor flow rule parsing

The patch drops every vlan_flag mask/value pair from the TCAM key,
e.g.:

	-	tcam_key->key_mask.vlan_flag = 1;
	-	tcam_key->key_info.vlan_flag = 0;

Before, FDIR rules matched only untagged packets. Now they match
tagged and untagged packets alike. That is a behaviour change, and
the commit message does not mention it. If it is intended, add a
sentence such as:

	FDIR rules no longer match on the VLAN flag, so a rule now
	hits both tagged and untagged packets.

If it is not intended, restore the vlan_flag lines.


[PATCH 22/29] net/hinic3: add device kvargs parameters support
[PATCH 23/29] net/hinic3: add compact CQE Rx path and ptype table

The new "Runtime Configuration" section uses a bullet list of
term/description pairs. Make it a definition list:

	``tx_pending_limit`` (default ``2``)
	   Tx completion coalescing pending limit, in units of 8
	   packets.

	``tx_coalescing_time`` (default ``2``)
	   Tx completion coalescing time, in microseconds.

	``rx_cqe_compact_en`` (default ``1``)
	   Enable (``1``) or disable (``0``) compact CQE mode.
	   Ignored on NICs without compact CQE support.

	``rx_cqe_coalesce_num`` (default ``7``)
	   Rx CQE coalescing count, in units of 8 packets.

	``rx_cqe_timer_loop`` (default ``5``)
	   Rx CQE coalescing timer, in microseconds.

The rx_cqe_compact_en entry belongs in 23/29 and the rest in 22/29.


Info
====

[PATCH 06/29] rte_atomic_thread_fence() orders memory between CPUs,
not between the CPU and the device. If the cleared rq_ci has to be
ordered before the device runs again, use rte_io_wmb(). Otherwise
drop the fence.

[PATCH 07/29] dev_private is always present in a secondary process,
so this check is dead code, and the message and -ENOMEM do not match
what it tests:

	if (nic_dev == NULL) {
		PMD_DRV_LOG(ERR, "nic_dev hwdev is NULL, dev_name: %s",

Drop it.

[PATCH 10/29] This patch has Cc: stable, but it uses
HINIC3_IS_SP230_NIC() from 09/29, which is not tagged. Either tag
09/29 as well, or name the dependency so 25.11 backporters can find
it.

[PATCH 11/29] The explanation in the v6 reply checks out:
disable_all_msix() turns off every vector at hwif init, and
hinic3_dev_rx_queue_intr_enable() returns before
hinic3_set_msix_state(..., HINIC3_MSIX_ENABLE) on SP230 when
intr_conf.rxq is off. One gap remains. Nothing compares
nb_rx_queues + HINIC3_RX_VEC_START against hwif->attr.num_irqs, so
on a function with fewer vectors than queues, INTR names a vector
that does not exist. The intr_conf.rxq path has the same gap. Reject
that configuration in dev_configure, or skip the SP230 branch when
there are not enough vectors.

[PATCH 15/29] hinic3_dump_aeq_mbox_info() prints all
HINIC3_MBOX_SAVE_NUM slots even when fewer messages were recorded,
so empty slots appear as cmd 0, mod 0. Loop to save_mbox->count
instead.

[PATCH 17/29] hinic3_dev_set_link_up() clears admin_down before the
vport and port enable, but unlike set_link_down it does not restore
it on failure. If either call fails, admin_down stays cleared, and
the next PF link-up event enables the vport. Restore it on the error
paths, as set_link_down does.

[PATCH 25/29] The hinic3_copy_mempool_init() comment says the pool
"must be able to cover a full ring of in-flight packets", but the
pool is capped at 256 mbufs per queue. Reword the comment to say the
cap is deliberate, and that when the pool runs out the burst stops at
that packet.

[PATCH 26/29] Before this patch, every NIC got TCPUDP_CS set for
VXLAN, VXLAN-GPE and GENEVE packets:

	SQ_CTRL_QUEUE_INFO_SET(queue_info->udp_dp_en, TCPUDP_CS) |

The new scalar path builds queue_info from TSO, PLDOFF, MSS and UC
only, so NICs without TX_WQE_COMPACT_TASK no longer set the bit. The
commit message does not mention this.

[PATCH 26/29, 28/29] The Tx path is selected by
NIC_F_TX_WQE_COMPACT_TASK and has no CQE, yet the function is named
hinic3_xmit_pkts_compact_cqe() and burst mode reports "compact CQE".
"compact task" would match what it does. In the scalar burst,
hinic3_get_sq_wqe() never returns NULL, so the !sq_wqe branch is dead
code.

Review-Result: WARNING
