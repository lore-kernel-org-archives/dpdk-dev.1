Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AB3606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=M2wuXe+z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F1B440297;
	Mon, 19 Oct 2026 18:52:47 +0200 (CEST)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mails.dpdk.org (Postfix) with ESMTP id CD2134021E
 for <dev@dpdk.org>; Mon, 19 Oct 2026 18:52:45 +0200 (CEST)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8a058f74a54so540142b3a.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 09:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792428765;
 x=1793033565; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PxisqfGzucQy1nOEAPIAavjsfhJPVyt3pN7Xv0l0aSE=;
 b=M2wuXe+zK5H5CzUqb5PfFNyww6f4m+3V857m+qkcw9I7h+zM2tDQSRcm0yRvVHqN8c
 JwLV5mrNbWaMBOpkks3/ERXCB0xdYmQCWuGMrLMVYeLqh2GJ/Xy2DGt/dvDSprLxvuO+
 ta2cSxbZZImwmOslp7+ljAupNzaIfK5Pg3wYlMtFHJ06c9QcxBGodb9aVfb68jpOXJzS
 9vGLJO2XXLXAc5PKzbWXHeocondmjXHyQhiy/yMhpp6rsj132Bxakbvn347SXEAqW43O
 2JEUR4OC35/pTxMdAdguSVZK71LGp8XDwXs+VNqBVou5RPCZ/PLPDiqF30OHfvIqB0cY
 wAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792428765; x=1793033565;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PxisqfGzucQy1nOEAPIAavjsfhJPVyt3pN7Xv0l0aSE=;
 b=2DXk42wPUREZ1DDACFklb14eFAPyVr9uBQIKnAvog5RxuVbNUDzAnC4fzzNrNNPVq6
 eHuQvYcKzlkxsaN7LiL4Ywd//RJIs7DxhIA2etVQUkgujnIGrO9+8IFr0CtHQgL2Cjq1
 RchliDcaxfeI4RTAw7aElMtS3heVFQGSH2wtBbzCto5KSFNnYgzfB7bMbom4xAwQvKmN
 c2iRmSNzZsTJm5mncWTIQSzIpcitLbrodEvL3Rag9Ewp5qYG0H4Ta9SdCAR/pozxKCAU
 QuL/CLMUbxu6P4geIrd4RVoDKhPbfGU91xH/0ogriM3qg13wBCaIlSewwXzSAGkvuA4w
 hEIQ==
X-Gm-Message-State: AFq9FYL2pPZCSjmjZQuqQRcXWLPQfLsVfH6qldTeZYVtJW4WQnKWQR0K
 hk+n3d9GsgQeDqQcd81TWFB574AO05gHqnrIdc2uO0sI43NqQ3EJyn2M1OzNEXGNFo4=
X-Gm-Gg: AYBFou1zM4Lu4rpdP2X1UAm/5u9GXehRK/YCAdaToF3UH8sj3MIbwWsRByno3yki2y5
 91Qt6A6XnYUwB8K+2uF8YXCombDHXLoh/TGwlwbodn+BWfxbzcxBl1ny58qlOBxypWZUbQncMqh
 62Kbk7QNNFR5C8JMiG+4HOi8cZGdzFh6CWpgEZjwk5oPJtOU7d9tc3P27Vk/YCZY8fsLcZ45lOV
 OKXLrMiNSThng67DfOw8FQ1cKSrrqILkIdbVvblzuhJ4AWlaa/oa/NDtx3NDIqrpMxzyUqMZreg
 F/k7WDK8KS8i+Frj0FCcIR8kZ44QiyHI1RiwBt4VFnYRAUKL4YckcsHjHBtC8MAKRgwT3swO9xR
 2FCkin/YHaCDnhrN9N0c46oIxpJ2Wq9bStj55qwrNHpODiN8c68cgo3ol0iqUlOjQxSrqRmm4AQ
 WKsFQvotGDjm+Fp4Cswo1SdlqvTTOhL2T8OpvER+qidJZOGhCzCcbl4k0k6+dRohBqYdtZNFdTg
 Djsgd8JazBkDxOGDvatcRt0SmvcqpuTJvuBwU2eBuKLmRf+xekmokS4HXtQwUGsFQBrTrGBhgUN
 rByScigeVVzq62HDxh9vP5Y=
X-Received: by 2002:a05:6a00:4f91:b0:89f:9ea6:1de6 with SMTP id
 d2e1a72fcca58-8a04c80effcmr6723595b3a.24.1792428764702; 
 Mon, 19 Oct 2026 09:52:44 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a056f3f2absm2378078b3a.25.2026.10.19.09.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:52:44 -0700 (PDT)
Date: Mon, 19 Oct 2026 09:52:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3 00/27] net/hinic3: add PMD features and fixes
Message-ID: <20261019095241.54d27257@phoenix.local>
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
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

On Mon, 19 Oct 2026 23:19:02 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and several defects found during review, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.
> 
> v3:
> - Move the ethertype-flow TCAM index leak fix out of the flow-refactor
>   patch into its own patch with a Fixes tag and a stable Cc tag.
> - Set burst function pointers and tx_pkt_prepare for both primary and
>   secondary processes, and select the Tx path on its own feature bit.
> - Zero the RQ/SQ context buffers and honour dp_intr_en for the STN CEQ
>   attribute in compact CQE mode.
> - Return the number of Tx packets consumed instead of the doorbell
>   count, and guard the Tx prefetch against overreading the array.
> - Validate device kvargs and reject values above the hardware field
>   width; document the real defaults and units.
> - Reject mismatched queue depths and reset saved depths in
>   dev_configure(), and size the TSO copy pool per port.
> - Report FEC capabilities per supported speed regardless of link state.
> - Route the private dump through fprintf() on the provided FILE*.
> - Derive the pseudo-header L4 protocol from the offload flags and fail
>   shared or indirect mbufs; add Fixes and stable Cc tags.
> - Drop stable Cc tags where the Fixes target is not in an LTS release
>   and remove dead code and unused definitions.

Still lots of AI feedback, biggest issue is the bisect break.
You should run semi-automated incremental builds on any large
patch series like this. CI does that.


Subject: Re: [PATCH 00/27] net/hinic3: fixes and new features

This is v3 of the series; please mark it as such in the subject, and
put a changelog in the cover letter so reviewers can see what changed.

Applies to main (26.11-rc1). Tip builds with -Dwerror=true. Most of
the v2 comments are addressed: Tx burst return value, prefetch, kvargs
error and bounds, secondary process burst setup, RQ/SQ context memset,
queue depth checks, per-port copy pool, priv_dump to FILE, TCAM leak
split out, Fixes/Cc tags.


Errors
======

Series: bisect broken at 20 through 26.

[PATCH 20/27] sets tx_pkt_prepare = hinic3_prep_pkts, which is not
defined until 27/27, and uses hinic3_xmit_pkts_compact_cqe, which
arrives in 22/27.
[PATCH 21/27] uses nic_dev->txq_depth, which is added in 23/27.

Every commit must build. Move 27/27 ahead of 20 (it is a Fixes: patch
anyway), select only hinic3_xmit_pkts in 20 and add the compact
choice in 22, and add txq_depth in 21 or move the pool sizing to 23.


[PATCH 08/27] net/hinic3: add SP230 Rx queue interrupt handling

On SP230 hinic3_init_rxq_intr() now runs the full Rx interrupt setup
even when intr_conf.rxq is 0. That path requires
rte_intr_cap_multiple(), so on igb_uio or uio_pci_generic dev_start
fails with -ENOTSUP for an application that never asked for
interrupts. It also creates eventfds and sets rxq->dp_intr_en = 1,
so the RQ context is programmed with the CEQ interrupt enabled.

Split the SP230 masking out of the interrupt setup:

	if (!dev->data->dev_conf.intr_conf.rxq) {
		if (HINIC3_IS_SP230_NIC(nic_dev))
			return hinic3_sp230_mask_rxq_msix(dev);
		return 0;
	}

where the helper only programs coalescing/auto-mask on vectors
i + HINIC3_RX_VEC_START, with no efd, no intr_vec and no dp_intr_en.


[PATCH 21/27] net/hinic3: expand TSO from 127 to 255 segments

hinic3_copy_tx_mbuf_multi() always copies from the start of the source
segment:

	rte_memcpy((uint8_t *)cur_mbuf->buf_addr + copy_offset,
		   (uint8_t *)mbuf->buf_addr + mbuf->data_off,
		   copy_size);

When a source segment spans two copy mbufs, the second copy repeats
the first bytes of that segment, and the packet goes out corrupted.
This was also in v2; I missed it there.

	uint32_t src_off = mbuf->data_len - remaining_len;

	rte_memcpy((uint8_t *)cur_mbuf->buf_addr + copy_offset,
		   rte_pktmbuf_mtod_offset(mbuf, uint8_t *, src_off),
		   copy_size);


Warnings
========

[PATCH 18/27] net/hinic3: add SP560 NIC type identification and
  handling

The STN op still forces EN=1 (interrupt disabled) with SW compact CQE,
and the commit marks Rx interrupt as "P". An application that sets
intr_conf.rxq still gets success from configure and start, and then
never gets an interrupt. Reject it:

	if (dev->data->dev_conf.intr_conf.rxq &&
	    nic_dev->config.rx_cqe_compact_en &&
	    HINIC3_SUPPORT_RX_SW_COMPACT_CQE(nic_dev))
		return -ENOTSUP;


[PATCH 21/27] net/hinic3: expand TSO from 127 to 255 segments

The copy pool is now num_sqs * txq_depth 4 KB mbufs, created at every
dev_start. With 16 queues of 4096 descriptors that is about 280 MB of
hugepage memory per port, for a slow path that only fires on packets
with too many segments. Cap it, for example:

	depth = nic_dev->num_sqs * RTE_MIN(nic_dev->txq_depth, 256u);


[PATCH 27/27] net/hinic3: add pseudo-header checksum calculation

For IPv6 the L4 offset still comes from walking extension headers,
while the descriptor (hinic3_get_tx_offload) uses mbuf->l3_len. When
the two disagree, software writes the checksum in one place and the
hardware computes it at another. mbuf->l3_len is the application's
contract and includes extension headers; use it, and drop
hinic3_get_ipv6_len_proto().


Info
====

[PATCH 27/27] "l4_proto = (uint32_t)proto << 24" is only correct on
little endian. The old rte_cpu_to_be_16(proto) was fine, since the
ones' complement sum ignores word position. Use
rte_cpu_to_be_32(proto).

[PATCH 27/27] Has Cc: stable, but it depends on NIC type
identification from 07/27. Put it right after 07, so the stable
backport is the pair.
