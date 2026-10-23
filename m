Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E692606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=H3QVOAPO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BA2840276;
	Fri, 23 Oct 2026 18:21:28 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 0AADF40268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:21:26 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3acdcfa2bd3so847220a91.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792772485;
 x=1793377285; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S7ZoCSXjgBHJvvrAnJDY0jciPhJV5RnNRstDUSkKTvk=;
 b=H3QVOAPO84okUJHfkKsxZjDzv3mp5KaTS63P49Q1irJSpOXR6AaBCloZiNBmUv8bEA
 dimi4Q8jtQHf0bdQ4ZofNeBWW/CBsQ4QdhFpRbdwF3BFPT67XHrNci/4iw6L0i4K27Ii
 ifeQcz41UHVNGXAGBD19fKQbxD9f4FpVBk85snyYG2DRn/BPxsOUhn5TE9pphvi5kj4m
 CK13yl/G3sISNs10hJrRp66O2gj8zJ3eIQYUy+yQK2ZU4n0yb3a0jpz8AK9gEPSZFmcl
 +MNnjKvLN4IpkS5skCLhKmdsztHjP4LEK4SokeePPjvWOlINZy+Vin51dhnRwDIBACG5
 YvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772485; x=1793377285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S7ZoCSXjgBHJvvrAnJDY0jciPhJV5RnNRstDUSkKTvk=;
 b=AFZPE4xzuj8K/DfNTOj1q0emJBR05msQoX5BVB4F/TpFP9zinv5xtEZcF6FYj5j5n9
 R1TBx9M7qP4bFC3DGsYt1Rkx5QoMYfU01v8IMEhgXPyPgNb60cxWvDxVbba47iFWtdAw
 SIu9YvxPAb5AAyYGrmYEQBvEkds4qQAXJeVHDru2rUE1rIulSoI4Ttl8/zH+MnuBHl5q
 IFU0G3PbUtZIrIBiqc3dVo1+wIpp2ILiboWN4mwYKZxpL+Ylovu4j+f7/kozgXY2tUCP
 r91i6GejjWuU2t0M133pS7TV5PojGCHn58Z57Al+YFisLHiZMEZHFLNKsgziLhGxUqsB
 KDtw==
X-Gm-Message-State: AFq9FYI5cIdVWhzToykSM12yaRDT4qq8GkQWnZV6SSBVYV+Qb9jDqwqC
 7f1aPi+mkbI7BCpeKfvMn5tzyUv3yTalPAJpSNuSVcIb3NkPp1Lq9oXfrNbQ+r67CgE=
X-Gm-Gg: AYBFou364VcyOZMApIhocSjC4ON+8QjwhQ6esvX58BvCHD8xVIUmNIjA2OAwvAb4DvO
 6Z80GNGNu2w0fbntQI6SMnqMWEzzVJ8+pDWlIbIIxYgd80xIOHr14mTb0YKXz6LntzNUMxNzjoE
 qIQt2lUY9w023UYTO1mrT+8QukxMktnw+O0LmatbhX1oCBiSqB4POsFjP//J3pe8GYvfuX3tWzI
 ZihaFn9s7t1QfZcjT4Hw2GL6jfOFOmfZTFmdNCSJKdsR3jn04kavDrCfanPDGccUXE93ZKaDUj/
 5URZOp+FJk4KdU8AUT9+dGWuYMbNpFUFzBEJIgFh8jBScrFJDw1nNF6iApqu9KymXfMMwm2Uq9g
 w88NhmmrKtHc3G3byFiLGJ/EJq5IibU4jPbARzwQ8et57PDy4pGq4e10e2yRhJDzQ2AB52ChWWE
 TQl/6GI0rENJ/EYrnU66UYxGgMSoweV5ReekAOLkD1urRTUKgoOI+PNFvTowhbCnZ0IW+HZP2+O
 L2T4XOzerSgtJH0fXRt6HDoQzFiJyZRWKxF+LcBLfY5E8irrvwzsVXsaNbRgJphb8UXLXRIqm+5
 WoQgYiPf8AR0vkpIGTUkZQ==
X-Received: by 2002:a17:90b:4b84:b0:3ab:27f0:c90b with SMTP id
 98e67ed59e1d1-3adce13ab78mr2336650a91.53.1792772484957; 
 Fri, 23 Oct 2026 09:21:24 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3addd676e49sm831078a91.1.2026.10.23.09.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:21:24 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:21:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiacheng Ye <yejiacheng4@h-partners.com>
Cc: dev@dpdk.org, Feifei Wang <wangfeifei40@huawei.com>, Thomas Monjalon
 <thomas@monjalon.net>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v4 00/27] net/hinic3: add PMD features and fixes
Message-ID: <20261023092121.751fb6be@phoenix.local>
In-Reply-To: <20261023155809.855-1-yejiacheng4@h-partners.com>
References: <20261019151930.1572-1-yejiacheng4@h-partners.com>
 <20261023155809.855-1-yejiacheng4@h-partners.com>
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

On Fri, 23 Oct 2026 23:57:41 +0800
Jiacheng Ye <yejiacheng4@h-partners.com> wrote:

> This series fixes offload capability advertisement, cmdq/compact CQE
> configuration, and several defects found during review, and adds NIC
> type identification, FEC, CIR drop statistics, VF LAG/link state, COS
> mask/map, mbox recording, RSS hash configuration, compact CQE Rx/Tx
> paths, TSO segment expansion, Tx burst mode reporting, queue statistics,
> pseudo-header checksum, per-tile cmdq ops, SP560 NIC support, and device
> kvargs tunables.


AI review still sees some issues that need addressing before merge.
PS: it is ok to respond with "AI is hallucinating about XXX"

Subject: Re: [PATCH v4 00/27] net/hinic3: fixes and new features

Applies to main. Every commit builds with -Dwerror=true; bisect is
fixed. The v3 comments on copy offset, IPv6 l3_len, SP230 interrupt
masking, copy pool size and be32 proto are addressed.

Please include a changelog in the cover letter.


Errors
======

[PATCH 08/27] net/hinic3: fix pseudo-header checksum calculation

The fix adds hinic3_prep_pkts(), but nothing installs it until 21/27
sets tx_pkt_prepare. At 08 through 20, and in any stable backport of
08, the code is dead and checksums are still wrong. Wire it up in the
same patch:

	eth_dev->rx_pkt_burst = hinic3_recv_pkts;
	eth_dev->tx_pkt_burst = hinic3_xmit_pkts;
	eth_dev->tx_pkt_prepare = hinic3_prep_pkts;

The commit message mentions SP560, which is not added until 19/27.
Say SP620 here.


Warnings
========

[PATCH 19/27] net/hinic3: add SP560 NIC type identification and
  handling

hinic3.ini now says "Rx interrupt = Y", and the explanation of partial
support was dropped from the commit message, but the STN op still
does:

	if (wqe_type == HINIC3_COMPACT_RQ_WQE && support_rq_sw_compact_cqe) {
		rq_ctxt->ceq_attr |= RQ_CTXT_CEQ_ATTR_SET(1, EN);

In the same function EN is set from intr_disable. If EN=1 means
interrupt disabled, Rx interrupts never fire on SP560 with compact
CQE, and configure should reject intr_conf.rxq in that mode. If the
bit means something else when SW compact CQE is on, add a comment
saying so. Either way, the ini and the code must agree.


Info
====

[PATCH 23/27] The new tso_segsz == 0 check logs at ERR for every bad
packet in the Tx path. The drop is already counted in
offload_errors; drop the log or use a rate-limited data path log.

Series: a lot of v4 is splitting log format strings across lines and
reindenting. DPDK checkpatch ignores long string lines, and split
strings are harder to grep for. No need to do this.
