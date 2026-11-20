Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA0606A32A
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peresvet.it header.i=@peresvet.it header.a=rsa-sha256 header.s=mail header.b=Td8GvDEL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C0133402E0;
	Fri, 20 Nov 2026 12:13:33 +0100 (CET)
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net
 [31.44.14.17]) by mails.dpdk.org (Postfix) with ESMTPS id 682E840151;
 Fri, 20 Nov 2026 12:13:32 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-53
 (mail-nwsmtp-smtp-production-main-53.yp-c.yandex.net)
 by forward501d.mail.yandex.net (postfix) with ESMTPS id D8C5480DD4;
 Fri, 20 Nov 2026 14:13:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-53 with ESMTPSA id
 SDagr3JcdKo0-BXIVW1yj; Fri, 20 Nov 2026 14:13:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peresvet.it; s=mail;
 t=1795173210; bh=8GHhBSB3dz2Lk93jWEkQYY3thcHGZVpzbYfIQA0ZDwQ=;
 h=Subject:Message-ID:Date:In-Reply-To:Cc:References:To:From;
 b=Td8GvDELLwTW9WJXvSE2R3uFa+Obych3ePsuhsYSqRjkf2GDtjQeRxFAMOIFLwaXi
 TxNJlrp9k6J1zI6XKqKbRue2fIiAQCC6VZFsS/HaNyiHLvodvEHrjQGy6yzWWOTbcV
 9iarxe/Nsrl5p8yKaO74O6qxVrEu2RZAxyfP7gio=
Authentication-Results: mail-nwsmtp-smtp-production-main-53;
 dkim=pass header.i=@peresvet.it
From: "Daniil Bobryshev (daniil@peresvet.it)" <daniil@peresvet.it>
To: dev@dpdk.org
Cc: stable@dpdk.org, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>
Date: Fri, 20 Nov 2026 14:12:44 +0300
Message-ID: <179517316488.3655.14347438927516252681@peresvet.it>
Subject: Re: [PATCH] net/mlx5: fix Rx queue count with enhanced CQE compression
In-Reply-To: <20261119203447.41203-2-daniil@peresvet.it>
References: <20261119203447.41203-2-daniil@peresvet.it>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ai-code-review check on this patch (https://dpdk.org/patch/173059)
says that in the enhanced layout cq_ci should move by one entry per
compressed CQE rather than by MLX5_CQE_NUM_MINIS() + 1, since all
mini-CQEs of an array sit in one 64-byte entry.

I do not think so. In the enhanced layout an array of N mini-CQEs is
written into one entry, but it still takes N entries of the CQ: the
NIC leaves the other N - 1 reserved (02a6195cbeaa: "The invalidation of
reserved CQEs between miniCQEs arrays is not needed"), and the next
CQE is N entries further. The Rx burst advances the consumer index the
same way:

- mlx5_rx_poll_len(): zip->cqe_cnt = MLX5_CQE_NUM_MINIS(op_own) + 1,
  zip->cq_ci = rxq->cq_ci + zip->cqe_cnt, and rxq->cq_ci = zip->cq_ci
  once the array is consumed.
- rxq_cq_decompress_v(): the next array is looked up at &cq[mcqe_n]
  with check_cqe_iteration(cq, rxq->cqe_n, rxq->cq_ci + pkts_n), and
  rxq_burst_v() then does rxq->cq_ci += rxq->decompressed.
- The kernel driver does the same in mlx5e_decompress_enhanced_cqe():
  wq->cc moves by get_cqe_enhanced_num_mini_cqes() per array.

So in this layout, as in the basic one, the number of packets of a
compressed CQE and the number of CQ entries it takes are the same
value, and rx_queue_count() moves cq_ci by it. Moving by one would
land on a reserved entry the NIC did not write in this pass.

With this patch, on ConnectX-6 Dx with rxq_cqe_comp_en=129 at 100G, the
reported depth stayed within 0..568 of a 32768-entry ring, and the
datapath threads that poll it no longer hang.

The ternary in the loop condition is the same one mlx5_rx_poll_len()
uses; I can move it into a helper in a v2 if you prefer.

Thanks,
Daniil Bobryshev (daniil@peresvet.it)
