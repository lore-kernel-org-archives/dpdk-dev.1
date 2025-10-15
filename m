Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3DCCD195
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4175D402AB;
	Wed, 15 Oct 2025 11:36:24 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id DCDE340276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:36:22 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 2355C1D00103;
 Wed, 15 Oct 2025 05:36:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 05:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760520981;
 x=1760607381; bh=1ytUfgACDCyQTvHIuiMbNtRhFNa6A33JrKaeEzgpwUI=; b=
 YYU+2OFXVhyv3rBgczOkGy3StOGerxEV0Th1DvtfCoKxIb7bBE33B7Xbb6OTQ14u
 Y3xO+gzr09Oj7bcc0OfvCwEsfAwx2u+oyv/lEomTLfXVMxxvT0vBlyXGKdawnoS3
 SoWB6+PXsw0tqe1FSHRHU0/nOxYamd+obciO0gH+046GLjZ963SA1a1C/2BHUDRr
 lW/qZIw9mS01V+Ttv0J0cXOzMWXFNhQqH9NZOGXJtpoLNawpbf+n5SsEkUTZk390
 q+/JFu86nJoIFPRjRUbg73wZAJ9OY32MSwiuYSzg60rM5n4RsXdLNO98j2TSwGIO
 MquPPELhzoSPaKzgTNNPGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760520981; x=
 1760607381; bh=1ytUfgACDCyQTvHIuiMbNtRhFNa6A33JrKaeEzgpwUI=; b=e
 nvlFgB9y2EJWgviQavvUIbHE9LfwLf5aoH1gGG7ejboZqk6KeUblqmyF19RObkQg
 aHHXjh0GTT+SyialkKUx32gvnNLNh6xTL8IfvSPSYbR03yo9+LylBeZD0m7I1HZ2
 xJUKpwvQPpvtkueINM7IKNhQ5QrDlw9ajQYvO8i0EkL32lkrPw6pPpK4JXFboLvX
 E2jcFSQ1vLPNYmLx5mdLh5I4vUQiRsYIBlGDZ0ls+MRM/ONL+7vu/wt2I8V46K76
 lZw+waCV1lQ2NwduG9UYsW3Y19w8t6fJ3jiJkik5xF+Crfb0eUr+3alRMQLnCIyx
 6fSLEehcZVi16V5d3Oemw==
X-ME-Sender: <xms:FWvvaIZePDDiUOjaw-01vI5ZxkbUz0YK1emmYTkBkl6Dv8uNHcgC1Q>
 <xme:FWvvaPuP09_1XaGojtuAj_7ue7mixWkYoS2RbnFAmytC04dDPD799Dbudjb92pQUJ
 73k72mXSOlZqnRL2WEY3rCcoeGuF1UMHlJD61hbqJx0C4hfz4bPew>
X-ME-Received: <xmr:FWvvaFvZ0tT4toTwKFiGLlOc95ISHm1_s5MSv2FKz5xyztell8h0Xth7bhU-jWp3EoiTx1gCiaqmLl3w5gtWA29ztA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeftdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:FWvvaEfthS-Vn_4KCCE1bn7C1g7BdtJGA2IzJKH5Q9uJIjCuvWxqUg>
 <xmx:FWvvaGbH8BK7fOlHZLuDdKoGoPJeD3WwOSGiP84DL0nftX5BthCQFA>
 <xmx:FWvvaHXTjNFJz_NCdecDS6oS1lUais2MDYHHCBPEhhRpsZWBQd4wZg>
 <xmx:FWvvaIikkw7ohCIepXAfjVHPrAK5AL9xeKVjfvj60HoAIOklQ4kwqg>
 <xmx:FWvvaBJz6jPeC_uolnh-GIYNQEcWTr0rSqPo8ev9-z-yduHJGD7gjG5U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 05:36:20 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] dma/hisilicon: fix stop dmadev fail
Date: Wed, 15 Oct 2025 11:36:19 +0200
Message-ID: <13676403.VsHLxoZxqI@thomas>
In-Reply-To: <20251013092211.6804-1-fengchengwen@huawei.com>
References: <20251013092211.6804-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

13/10/2025 11:22, Chengwen Feng:
> Stop dmadev may fail if there are pending DMA transfers, we need make
> sure there are no pending DMA transfers when stop.
> 
> This commit uses following scheme:
> 1. flag stop proc so that new request will not process.
> 2. setting drop flag for all descriptor to quick complete.
> 3. waiting dmadev to complete.
> 
> Fixes: 3c5f5f03a047 ("dma/hisilicon: add control path")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
[...]
> +static int
> +hisi_dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan,
> +		      enum rte_dma_vchan_status *status);

This declaration can be avoided by moving hisi_dma_stop()
which is anyway almost new.

>  static int
>  hisi_dma_stop(struct rte_dma_dev *dev)
>  {
> +#define MAX_WAIT_MSEC	10
> +	struct hisi_dma_dev *hw = dev->data->dev_private;
> +	enum rte_dma_vchan_status status;
> +	uint32_t i;
> +
> +	/* Flag stop processing new requests. */
> +	hw->stop_proc = 1;
> +	rte_delay_ms(1);
> +
> +	/* Force set drop flag so that the hardware can quickly complete. */
> +	for (i = 0; i <= hw->sq_depth_mask; i++)
> +		hw->sqe[i].dw0 |= SQE_DROP_FLAG;
> +
> +	i = 0;
> +	do {
> +		hisi_dma_vchan_status(dev, 0, &status);
> +		if (status != RTE_DMA_VCHAN_ACTIVE)
> +			break;
> +		rte_delay_ms(1);
> +	} while (i++ < MAX_WAIT_MSEC);
> +	if (status == RTE_DMA_VCHAN_ACTIVE) {
> +		HISI_DMA_ERR(hw, "dev is still active!");
> +		return -EBUSY;
> +	}
> +
>  	return hisi_dma_reset_hw(dev->data->dev_private);
>  }

Applied with suggested move, thanks.


