Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E2606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=UvBYoc0n;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D1psK7l/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7370B40682;
	Thu, 12 Nov 2026 13:59:08 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTPS id 6CFCF402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 13:59:07 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 98615EC01DF
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:59:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 07:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1794488346;
 x=1794574746; bh=ypOn7oC+TWflcVF17beJYqipppehmbUqwwbqAVCTtes=; b=
 UvBYoc0n/dqfYt2y3mKmHOzoPoaxbCJE0LpR52C5pGydid5EQPVSqhVq4swUtAfd
 JWhgIJ1k443/j+CgRVFUFLP0u3uuyCgK2bZYi1oc+L7A4fuSLPndGnekV5waMnr8
 wj8xnL0b8kHzM6T9P+OBfZz6kRjyTHak/Tyjxksn46EoZ0YFFKGBhg9xYNlqG8Gp
 S0mVKc5RjTtEdsaXsQ/hQ4KaLx3gcd7EGi77kpPh8YrtfXJ4NKrguizPAZHRoOw8
 1JhH5vfUn4suHnUzb0+3m40iCTjT9MjgFvPsKi1DjVgq6VYATiCzCDt9A8baZzon
 3kaxAfDOPnlO5HBiMzWxBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794488346; x=
 1794574746; bh=ypOn7oC+TWflcVF17beJYqipppehmbUqwwbqAVCTtes=; b=D
 1psK7l/PBfcIf2shlQrN/UNZDUCOKKsEZ7QWnF9ic2k90o0+KsH8IUWj5O4P7j7o
 FuIe/DS3CH/+lUwnVUgrA5eG/FNhcNW1qkH8+mZbWnn0VVFWvruwMc3PHz/dD2EG
 geAfvNeURo2U28mJEnCkV9YoFImaf80Ng8/xZvnEbkSv32cxSGyVNVDYmutkVmzt
 q8Fpby0gX08rjSp/VzJ0TuWRQS2UGvG3LYrS+e+Zdh9ZvKllIezp8StgCvF+DQws
 AZ0FI8GxR+Ax3PXXXMTmOoCU4Jy+KLH/vZqH5069MqXBxUXtKWXduxW4+sEzMLug
 xAWE4ZwpwiB/QNCJaZr1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794488346; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm3:rsa-sha256:SYkKO3r1Ho8PSxmDXE77UBjIIm+ejxpU0bUgc+EnNaLzysT
 Cm+3wPB/LeYEDJhGaprYivNo2fSz+QJn6wcnQ2Yk0CJwZP0qQsY++cfjm8LFTnpb
 2BmZtwUF/1uNBXm4QarkBx+6EM0ULjlZtE1r5Ga9HjBKFRBvGnQWpMJ/mn20gB7r
 WWkRdTvknJbXygjK3v4n3ETs8IghWj4yk1YiBnFlNetdf5JCGLaqNq1/hE1LWXHq
 38+dmV0lYLjuip2nEgm6ipqPW6GoLPYIPm6wwGluhIK3L15RKDIBMynvxRBaiciU
 502H+A3o6e2yrOM8fL/p9pLi85GnqhSWy1zEsuA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:c0VGGN7t+wALu/2MTIeplP3UsR10qE4ofrTmUKPb3/Q=:ypOn7oC+TWflcVF17beJYqipppehmbUqwwbqAVCTtes=;
X-ME-Sender: <xms:Grj1al2ia28ijTYtJfZiIS2tmJBQP7xwl4AI8zQW3Utiojh8kH8Zxg>
 <xme:Grj1asMwAYN6Q1W9cUQHZVLln-Drtb7YBv4TrT1rj0BSe06kTt-YN4qEYRri9JHHC
 tqDEmJp9ViR39HdR24PYB_6c0dDUbcTb1MXWoxDao6rm5UxjunWlH0>
X-ME-Received: <xmr:Grj1at3-51TWvtp05mvs6BEMrL0bsdZqKY_IS6pq0ui0z9uTPuiAmRGLCcqMqY0eVqNs-x8O8xH_V2IydlrPLh8>
X-ME-Proxy-Cause: dmFkZTE7vjur+jNFJxadNC+norcX5lD0yxfQ94Wdq2to/5l0fCJHXG6Xy/lzCY16xrHqXg
 fZDe3dfmbqp4QWq6iRwaAh8237AycvhkwDW9wE7RUgpe481h8WgTw3U5+4pMoQ/2ovT5D+
 YJ+G3Gd1Z+y0yEqRr2L6T9HAtv05UYcsDi6AslkggC7A7jvtrZ45VVgb8QxzSp4pFM/Awx
 utpDyCOLLtWN/uL5zZj72YuRWQ4IiPmdmzS9zZfupmCIHA4WnHnucrje0uvXYxjeS5hCum
 +iU0fIv4fPbb0cMwLjEKAysllKygugSOdKWvn/q2Adm7CE4QgUE2KiI4+ahFadSl6AnGQM
 3j2Elov/vv+PHyIOx6PtBS7uITjbP0fx+il1U1BGxa3C2+v1x21X3Upp+nq840bSXjcpQ0
 9pSJQgSgAnAJJQBPw13/LJu4rdYL8n5saHKWG5mLrFFoS7DC/kq53kcqiS6+OUsTrMmEfA
 jyUKHm81b+2Y/P/+AvgQ8r7SKL5wZAR9c9QyjvR0UdF0Ov2ArtBr1j2PDPWhyH6O9/sA8L
 dyt25p2qMm9Dfk5xqc01o2uEpvPoscxbyXPcCCNaChwDCNHyswcCFT7xrb5U9kTmDYbCwP
 KuRcgVyP16dnyfbZacyM8zhIsdTaaUUm1iPstUxqyfxESFwUzxMeUr0i6Cgw
X-ME-Proxy: <xmx:Grj1arHSrJKeXFGYyumQDs-mRecavvz4B4zwa7SOO0S7NW1j2sS0gQ>
 <xmx:Grj1ai7J9t9gkuWfN-xeTnXlIQ3ec7Q3KQ5k8rcKkLk-Y8v-EdVMdw>
 <xmx:Grj1apsKW0jyOYUx85jiXBT6PwGNu4F9_YVEuCb02PMeyAIDV-VAqA>
 <xmx:Grj1ar77b3ivE5h0zzbYustOxCKusGZspG7XeTMmPcC_Rl5g0K-1hQ>
 <xmx:Grj1aq3dh4OmgscNxykA2Fzv6ZuLInrw_dD3Nql2avW4M2TzOoOesCyY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 07:59:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robert Sanford <rsanford2@gmail.com>, rsanford@akamai.com
Cc: dev@dpdk.org, "Medvedkin, Vladimir" <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v1] rib: reduce node mempool memory footprint
Date: Thu, 12 Nov 2026 13:59:04 +0100
Message-ID: <clQ67m5gSq-Sep6Lg_COvg@monjalon.net>
In-Reply-To: <86bc4512-892f-4b7e-95cf-f9fd322b92db@intel.com>
References: <20261030161926.1185112-1-rsanford2@gmail.com>
 <86bc4512-892f-4b7e-95cf-f9fd322b92db@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > RIB nodes are allocated from a mempool created with no flags, so each
> > object is cache-line aligned and padded for memory-channel spreading.
> > On x86-64, an object takes 192 bytes for a 40-byte rte_rib_node or a
> > 56-byte rte_rib6_node. Nodes are small and only accessed by the CPU,
> > so the padding is wasted. The whole pool is reserved up front, and
> > rte_fib and rte_fib6 size it at twice max_routes nodes.
> >
> > Create the node pools with RTE_MEMPOOL_F_NO_CACHE_ALIGN,
> > RTE_MEMPOOL_F_NO_SPREAD and RTE_MEMPOOL_F_NO_IOVA_CONTIG.
> > RTE_MEMPOOL_F_NO_SPREAD is implied by RTE_MEMPOOL_F_NO_CACHE_ALIGN,
> > but is passed explicitly to document the intent. Nodes remain 8-byte
> > aligned, which is all the node structures need. The extension area
> > returned by rte_rib_get_ext() and rte_rib6_get_ext() was only 8-byte
> > aligned before as well.
> >
> > With 2M nodes (1M routes), the pool shrinks from 390 MiB to 128 MiB
> > for IPv4 and to 160 MiB for IPv6. On an AMD EPYC 7643 with 1 GiB
> > hugepages, fib_perf_autotest (about 1M IPv4 routes) shows average add
> > and delete times 13 and 29 percent lower. Lookup times, and the add
> > and delete times in fib6_perf_autotest, which uses 1000 routes, are
> > unchanged.
> >
> > Signed-off-by: Robert Sanford <rsanford@akamai.com>
> Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>

Applied, thanks.



