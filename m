Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8D606A329
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gm2TK2pt
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 459E840150;
	Sun, 15 Nov 2026 22:41:55 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTPS id BD726400EF
 for <dev@dpdk.org>; Sun, 15 Nov 2026 22:41:53 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cdb2dfcca94so1252360a12.1
 for <dev@dpdk.org>; Sun, 15 Nov 2026 13:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794778912;
 x=1795383712; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VREYB0IjEYqn3zldzL5mmY/MgwI5drOiK8ifM/zHoNY=;
 b=gm2TK2ptleOGYa1JSGQz/RzGe0JpzncQhabmOVWBKwdATFs21T83xWTwXZHhBMtI6Y
 rPw8Jr4zKjk5BK3M99hORPJDvCEX6wr9faa7+1PuG3CTDkQr7EFvc96KNLwFXXnVQwVS
 YA9ntGVP1L26ICzCtCmn0ggwNFmB/6Av1cYgnoN60wHThv+A7jfitkxP0O1eAhAzx0nc
 zrFNHY8CwsKzGCLiNmP8q2mq9eIFr/MLm7thXMLY/KTz+M+4v2PkEEORSbDDGWrDqNVF
 BG7GU0oUqauDgptGYXriHvu+OXhMgy7pSoo+8Yty+XWEmPP8iUI9XDLS4gKirKTFzgLk
 YrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794778912; x=1795383712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VREYB0IjEYqn3zldzL5mmY/MgwI5drOiK8ifM/zHoNY=;
 b=reNWekxDvwb8FfIPLnzH7Nt/7ZuuR3mZI6Sh+6HZCC2qDxIYKcYPz3lkRX8vSuhBED
 I4nfEOwzgt9nC7y2H5rKqAPor/oVr8JQhz5Qk0a3aSPniuBwQp5azSXXbBWZfqrm0dqI
 WI0a6peuBECarQ/iW0N6T+riJFUS/6BCTpVWMIzlXaJrFKFABhucMKpTgugo1Mj7lYjc
 MHiMgLFg0/CnWJm2Q07zgzmdkF7HAHnDV8vj9iJ+WZ0as8F+bxKz20GhovYUkqrxhm/a
 V24XgIF/Emau22Bf7gF+eGwlOfvExXYTqQC/Rw8NFdLqQgQNERT1GxFonMbPY5pPa7fX
 zR0A==
X-Gm-Message-State: APuU4Z/6ZnQpowKdlmx2qWUgEsyYyaMBgNGGZe9Sh7Dh5eiEJfh/cGQu
 cgKFoTUhOaDdB3Ep8e57GHxGN8y20StnHLm1aU65JDYzppdju/kfGkekPl9z/dJs4OlXc+4GTA8
 F5jNpVwU=
X-Gm-Gg: AYBFou2HbJFb6XyPicflfiqFbkpsRktlsJCJoUlnXEHCbOBHXANDdnTS3/HM3gMG4R1
 PwzGSgqxFMi7Ek9rcOBRhUceRU1yDdeJxt0Xd4WZHBduwPSXqmWKG6ilf95ZHi/5xe3NvIPsXQT
 DjmuoOgPdJOVZMBk9lSx4ytzfFNDQgftOIr+1TvVCDCIbGmjPLYUmYHMDm6RCl+RelrKsZr3fzl
 Uz+vFx9GRjyQiJDj/gWKpi2A9hQTjdzyhzzd1JQgr4TI5OllUm2cpsIy1cOy9qxYfiJTqRLY+h/
 G+RjQt8jp2yoCSBwt9mzIxkhJATYIewIXv9DKcR3KOrAF0CaQEP72AY3UV5pMfU5HsgE23lpO1W
 J5JMfx94fSAa5h1/pZhCLgwq9ZPeFKCx2R2wJ0YH96skIMBvS2BPIJ5uNiOUlacEKqqqbQ4St0F
 CiPzdMa+SOo/w3eZEQ8SSJSJVR/cKTv3lgzD+erE0pBwAH7EHVJmobfmki9+8HG18W4kTOiSLSM
 wB7vFxNV7YDBgZiPzk2qNB47CMwEgue9kEuMBywGcQvb/dgto4og8pYIEnCQYcSMiMMVZHZDPBG
 +BRIPxudZcZZZimD57NZQq9c5e2GOcRRAXRyB9YlnC/PZ/84flk+KtHWkSHmNL6/5bQvLhtIZw=
 =
X-Received: by 2002:a17:90b:1cce:b0:3b0:9cc6:62c1 with SMTP id
 98e67ed59e1d1-3b1b0b6a455mr8273620a91.63.1794778911932; 
 Sun, 15 Nov 2026 13:41:51 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aeb17853sm13679953a91.5.2026.11.15.13.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:41:51 -0800 (PST)
Date: Sun, 15 Nov 2026 13:41:49 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Renyong Wan" <wanry@yunsilicon.com>
Cc: <dev@dpdk.org>, <nana@yunsilicon.com>, <qianr@yunsilicon.com>,
 <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>
Subject: Re: [PATCH 0/2] net/xsc: fix two issues reported by GCC analyzer
Message-ID: <20261115134149.051d5ace@phoenix.local>
In-Reply-To: <179453942560.1554.11439899391590171416@yunsilicon.com>
References: <179453942560.1554.11439899391590171416@yunsilicon.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 11:10:25 +0800
"Renyong Wan" <wanry@yunsilicon.com> wrote:

> >From 0fe3f49419330852df7d2a82fcf179fa6f80a9a0 Mon Sep 17 00:00:00 2001  
> From: Renyong Wan <wanry@yunsilicon.com>
> Date: Fri, 13 Nov 2026 10:44:51 +0800
> Subject: [PATCH 0/2] net/xsc: fix two issues reported by GCC analyzer
> 
> Two fixes for net/xsc coming out of the GCC -fanalyzer report.
> 
> 45: when rte_malloc_virt2iova() fails, the jumbo buffer is leaked and
> RTE_BAD_IOVA ends up in the WQE.
> 
> 46: xsc_dev_init() leaks a structure on the dev_ops failure path, and
> the Tx queue allocation is dereferenced without a NULL check.
> 
> The two patches are independent.
> 
> Renyong Wan (2):
>   net/xsc: fix jumbo buffer on IOVA conversion failure
>   net/xsc: fix leak and missing NULL check
> 
>  drivers/net/xsc/xsc_dev.c    | 1 +
>  drivers/net/xsc/xsc_ethdev.c | 6 ++++++
>  drivers/net/xsc/xsc_rx.c     | 5 ++++-
>  3 files changed, 11 insertions(+), 1 deletion(-)

AI review picked up some possible issues:

Subject: Re: [PATCH 1/2] net/xsc: fix jumbo buffer on IOVA conversion failure

Both patches apply to main and build with -Dwerror=true. Fixes tags
resolve and point at 25.03 commits, so Cc: stable is correct.

Patch 2/2 has no findings.

[PATCH 1/2] net/xsc: fix jumbo buffer on IOVA conversion failure

Warning: the fix stops the use of RTE_BAD_IOVA, but the fallback path
it lands in is still unsafe.

When rte_malloc_virt2iova() fails it will fail the same way on every
retry (e.g. IOVA as PA without access to physical addresses). With
this patch every WQE of every Rx queue now does rte_malloc(),
virt2iova, rte_free() and logs at ERR level: up to 1024 log lines per
queue on each start.

Worse, the fallback sets seg->seg_len = XSC_MAX_RECV_LEN (9800) on a
segment that points at an mbuf whose data room is only
rte_pktmbuf_data_len(mbuf). The second segment exists so oversized
frames land in the jumbo buffer; without it, a frame larger than the
mbuf is DMA'd past the end of the mbuf. "Rely on mtu" only holds if
the MTU fits in the mbuf, which nothing here checks.

Allocate the buffer once before the loop and fail queue start on
error instead of degrading per WQE:

static int
xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
{
	...
	if (rx_ds_num != 1 && xdev->jumbo_buffer_va == NULL) {
		void *buf = rte_malloc(NULL, XSC_MAX_RECV_LEN, 0);
		rte_iova_t iova;

		if (buf == NULL) {
			PMD_DRV_LOG(ERR, "Failed to alloc jumbo buffer");
			return -ENOMEM;
		}
		iova = rte_malloc_virt2iova(buf);
		if (iova == RTE_BAD_IOVA) {
			PMD_DRV_LOG(ERR, "Failed to get IOVA of jumbo buffer");
			rte_free(buf);
			return -EFAULT;
		}
		xdev->jumbo_buffer_pa = buf;
		xdev->jumbo_buffer_va = (void *)iova;
	}

	for (i = 0; i != wqe_n; ++i) {
		/* fill seg and seg_next, no allocation here */
	}
	...
	return 0;
}

and in the caller:

	ret = xsc_rxq_initialize(xdev, rxq_data);
	if (ret != 0) {
		rte_errno = -ret;
		goto set_qp_fail;
	}

Info: xdev->jumbo_buffer_pa is never freed. There is no rte_free() of
it anywhere in the driver, so it leaks on device close. Free it in
the close/uninit path (separate patch is fine).

Info: the names are swapped relative to content: jumbo_buffer_pa holds
the virtual address and jumbo_buffer_va holds the IOVA (as a void *).
That is how the original bug went unnoticed. Consider
"void *jumbo_buf; rte_iova_t jumbo_iova;" in struct xsc_dev, which
also removes the casts.
