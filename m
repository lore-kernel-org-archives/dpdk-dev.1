Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEF606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YpvJ82Uh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD460402BF;
	Tue, 17 Nov 2026 17:28:47 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 5E613402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 17:28:46 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso2617465a91.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 08:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794932925;
 x=1795537725; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BcaePnRRJ04wY/nyaGzXllPvRtIW+DhAmxs9Wmhq+T8=;
 b=YpvJ82UhRKLTNZ5wah0I1tt9oqHcL8nqVpYwW6tbCPR2r0qXXNzP5qASkG9olChLfK
 sGExAbf75dZoS/qzH5pNCY88R6vovyBQE2NE3RogTQHXlxWa+qu6fbFyq9cKBlarMi61
 v1azq2QCAH2A8mU5yYiAs/ZQuYQyiIco9PNcMVYhToM1rluIWBnVocfkaw5p8So8rRm6
 J/J2rGUjnAmSRo0fBYx023uGagaeLNieoneduGeSsJswvoRaBl7qTcTF8PhtDlMDY6xJ
 V4RRxWEQy5TYRKf4gWB6RFjzRXdNYOguHXb6HuVeG3U77AZMm7m4gXGtczCB8U2BskSn
 w2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794932925; x=1795537725;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BcaePnRRJ04wY/nyaGzXllPvRtIW+DhAmxs9Wmhq+T8=;
 b=GAN6/BtVnJC2bF8/JZnVCCsdgRXr/JtvLuTaa7V2SBiGxVwVuFTSsDlN2iI3/K+8wM
 T5nVl/GW6fA3cGmbE0foVHCQjPyfZmPctK/hrSrKoqV+ax+wcYuRANVqksZotsdtkSCY
 M9mgCs/FNWm8jrJ8QQxnFhpuyxVdj5I+wucxW3MePXDfRpk1KMucwrMvbF2kGXaHWd/7
 wdeZc+rrAajPjuUUymbk+OHfuihpoQsI2Za288xJMGpfs4I32Bb2yaXUEDz7tsinp0dJ
 eiGsngAqSI2sJJs41016M9HKY3s5LCfy8rquZP+BBySWOuRyiOTff8ylve6AsWUBGnHG
 wrSg==
X-Gm-Message-State: APuU4Z8Zwb3k1hm7UDcgBcWTdPEuI5Gb3TdH0gvPpg+zsNCDUh4pzWlO
 NntsNOKwT8hpii0eGt1IbEpjipjWviz3xXWI2c1CoaT8mOATOVj+/S/urSlJVsj9GFA=
X-Gm-Gg: AZFdTZdbmUmGyby03/s/Tb8V9OM+SgrKfiT+Ab5dDlzXBddKS97tBx8a8HB1Rme9/4Y
 OWUkRTSMaCNwLfwt6vKN4UkBqhRG1XEMgZ1E/XlhratpH1G7C/PLPYA8GsbsgFf9Mv3fa8e2zRO
 nyw11oSFA/efS/S7R2ybCw6jLhxzci6okNjDy5VF0uoqvsItOxAc1ud4RXeALFFvaad+uPX57Pz
 HvZYgQh3KkFfU4YxM3a4yINffF/rHvH2I8SASFbkl9uzdKYUeJ4IF6TPWPhDA1AkJ2YgfaTlpwK
 TOSrhJLKQcOUTC5fAkw/N30vvbH2MJhzI4zoQO+q3ABjNDM7UxtSL4FPMSo3a1P03fF4Te8x8cK
 5kjA2p4doaX7/mq2/7IQ0TISbEIQQ0pCHt6yKvIwWw4fxN+3ELqaHkZK01a6I7xNXvNaUUJ41xv
 7Ut8nSZdJS9YJSPHMdLJ07PiZpouX6Kmo6XGyJSdmVBlQnR/F4dXX0P0KJfx8e5fBW7Svt8uJSV
 LDdBxicqcSSq+Bs/On2VS6q49UgLGEIrCgvKUntGNBT8QrEwI56xoRU/7M4HmTvY4lS3xGtBBcA
 08VNxVaOFZViJfeM1klh5zMijiGstFporahAPtQn2uQBlwoAdLrZ8T2ZNe1rzhOUya+UJYr9wA=
 =
X-Received: by 2002:a17:90b:1d03:b0:3ac:c005:cf07 with SMTP id
 98e67ed59e1d1-3b1b0b47a08mr13714983a91.42.1794932924657; 
 Tue, 17 Nov 2026 08:28:44 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b39d73c9sm12067369a91.2.2026.11.17.08.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:28:44 -0800 (PST)
Date: Tue, 17 Nov 2026 08:28:40 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 00/28] net/hinic3: add PMD features and fixes
Message-ID: <20261117082840.0ca1e95b@phoenix.local>
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
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

On Tue, 10 Nov 2026 00:20:04 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and several defects found during review, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.


AI feedback from v7 version (and fed it your feedback as well).

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
