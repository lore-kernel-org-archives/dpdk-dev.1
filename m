Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8008CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:53:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1055F40691;
	Tue, 28 Oct 2025 15:53:57 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 91764402F0;
 Tue, 28 Oct 2025 15:53:55 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 1B96CEC0334;
 Tue, 28 Oct 2025 10:53:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 10:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1761663235;
 x=1761749635; bh=uiMqlLKQ4S7OdXJmJIKf9c8pq5Eyslxmb5ytNmM8jKk=; b=
 TFa2lKUmBIrYiXJnyfRazrch9iz2IzjYyL+yGYQXP7bylgqxwdZsjg04I6JjMCiH
 PsCawjQrP+F7tW8nY1p4pyEOXlzKCBM7lYolmZ8hCRVUScUR7AhEX8gmlMM223dB
 Safpbfw1IwRDn+Ez57cLjVRh7awE/cMVrtXzRCB7WxSh8+/W6lLaMq25h2mYZHFh
 ZBMFNkI6era6oR+kUaEm4dUN9VN10oW1CDy45IbX0W0bdLIEXeRHJJiE4YEJlEl+
 94Qa0IRbZRghAkTTZO4+nF6vBF1rzZFjNwJtuUT0G8ym4XBS6heOG2Vx3V3X9xop
 lbNBxmGMCjb07bP3ylhzRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761663235; x=
 1761749635; bh=uiMqlLKQ4S7OdXJmJIKf9c8pq5Eyslxmb5ytNmM8jKk=; b=v
 iKuo4YD5wO0jBil+6xO0BJyn/MYFRVbEdGrkNzQsDwLGcEXqf2xlB/9aC4hF1HF5
 8BxE9bDbWYJs3OoegHZ1jOzpqAMrVmijMwoK55KO4/2td3K3NT1XSov7gmOWLMEM
 jujAJpzlRKdEF/GlQQSREx/1fvF23a2mRPdsDnBV1gTC0KvBx0668h+AxrWIEOsZ
 yGyA+hw5fDm8Ft3dywW0mXunF+/yUvpryYd8AfRiiNXjDPEMhKkYbgUIdzYVT/1d
 e7/bOSQiaiLDjm7FMzCGHgBDYvtRy7Xjtaa2DBWZ40dI3FL5mMRrFV9ZMgtWWv7K
 5+AQu2SNqBLBEqowoMu8g==
X-ME-Sender: <xms:AtkAaWKGS0xz_grzKQttjGz4ygmU5SIa-wNKv_7XlW_cz28Up1I6SQ>
 <xme:AtkAaekKqVB0qoJZCODII4OVbVbD_-M5QkqKCF7MTIUDuZsATK7cZgyw-e8wqC8py
 Skm-y_KlAkATHiv9h-0i04yOdSRtuvLL99fFlwSylinHP7SYhg->
X-ME-Received: <xmr:AtkAacI-USmD-CDEfS-S2BVcRMfkKGrSIOWAmet-OpcSqZY8ihuoVlr1H97xTvXEsf83j0U4QmKmCKn_APxt1Oi8Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduudegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvfedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhivhgrphhrrghsrggurdhtuhhmmh
 grlhgrsegrmhgurdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgt
 ohhmpdhrtghpthhtohepkhhirhgrnhhkuhhmrghrkhesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopehnuggrsghilhhpuhhrrghmsehmrghrvhgvlhhlrdgtohhmpdhrtghpthht
 ohephigrnhiihhhirhhunhgpudeifeesudeifedrtghomhdprhgtphhtthhopegurghvih
 gurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhtrhgrhihn
 ohhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrg
 hnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdhv
 rdgrnhgrnhihvghvseihrghnuggvgidrrhhu
X-ME-Proxy: <xmx:AtkAaZVbCsMzpZ38xLCVAmC5HkkViq_YyQwBXBirmdlfoKrYXGUTEw>
 <xmx:AtkAaRNVxPSsR_wiYcGm2ZRWvjIgWQ0LnAO-RBQPAQPMEjRjYuqmOg>
 <xmx:AtkAaVlSVJn_tC6kLjGpZNbJxOibd4uA8peKwV49pqQbDeP2fWpH4A>
 <xmx:AtkAaUXrsInbdMtksLFSBajSv9Qlshlm9oz-Cf03YnVt-oYaFmcc0g>
 <xmx:A9kAaesgL8bSBn-6aoCxq8Lxfs2aomtZzh0MdKrdX2Kx8wmyvauZ9e9d>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 10:53:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: jerinj@marvell.com, kirankumark@marvell.com, ndabilpuram@marvell.com,
 yanzhirun_163@163.com, david.marchand@redhat.com, ktraynor@redhat.com,
 konstantin.ananyev@huawei.com, konstantin.v.ananyev@yandex.ru,
 bruce.richardson@intel.com, maxime.coquelin@redhat.com,
 anatoly.burakov@intel.com, aconole@redhat.com, dev@dpdk.org,
 akozyrev@nvidia.com, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Matan Azrad <matan@nvidia.com>, Maayan Kashani <mkashani@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix spurious CPU wakeups caused by invalid CQE
Date: Tue, 28 Oct 2025 15:53:50 +0100
Message-ID: <2369437.4herOUoSWf@thomas>
In-Reply-To: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
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

Cc mlx5 maintainers

15/10/2025 15:39, Sivaprasad Tummala:
> Previously, the PMD used a common monitor callback to determine
> CQE ownership for power-aware polling. However, when a CQE contained
> an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliable.
> As a result, the monitor condition could falsely indicate CQE
> availability and cause the CPU to wake up unnecessarily during
> low traffic periods.
> 
> This resulted in spurious wakeups in monitor-wait mode and reduced
> the expected power savings, as cores exited the sleep state even
> when no valid CQEs were available.
> 
> This patch introduces a dedicated callback that skips invalid CQEs
> and optimizes power efficiency by preventing false wakeups caused
> by hardware-owned or invalid entries.
> 
> Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> ---
>  drivers/net/mlx5/mlx5_rx.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
> index 420a03068d..2765b4b730 100644
> --- a/drivers/net/mlx5/mlx5_rx.c
> +++ b/drivers/net/mlx5/mlx5_rx.c
> @@ -295,6 +295,20 @@ mlx5_monitor_callback(const uint64_t value,
>  	return (value & m) == v ? -1 : 0;
>  }
>  
> +static int
> +mlx5_monitor_cqe_own_callback(const uint64_t value,
> +		const uint64_t opaque[RTE_POWER_MONITOR_OPAQUE_SZ])
> +{
> +	const uint64_t m = opaque[CLB_MSK_IDX];
> +	const uint64_t v = opaque[CLB_VAL_IDX];
> +	const uint64_t match = ((value & m) == v);
> +	const uint64_t opcode = MLX5_CQE_OPCODE(value);
> +	const uint64_t valid_op = (opcode ^ MLX5_CQE_INVALID);
> +
> +	/* ownership bit is not valid for invalid opcode; CQE is HW owned */
> +	return -(match & valid_op);
> +}
> +
>  int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
>  {
>  	struct mlx5_rxq_data *rxq = rx_queue;
> @@ -312,12 +326,13 @@ int mlx5_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
>  		pmc->addr = &cqe->validity_iteration_count;
>  		pmc->opaque[CLB_VAL_IDX] = vic;
>  		pmc->opaque[CLB_MSK_IDX] = MLX5_CQE_VIC_INIT;
> +		pmc->fn = mlx5_monitor_callback;
>  	} else {
>  		pmc->addr = &cqe->op_own;
>  		pmc->opaque[CLB_VAL_IDX] = !!idx;
>  		pmc->opaque[CLB_MSK_IDX] = MLX5_CQE_OWNER_MASK;
> +		pmc->fn = mlx5_monitor_cqe_own_callback;
>  	}
> -	pmc->fn = mlx5_monitor_callback;
>  	pmc->size = sizeof(uint8_t);
>  	return 0;
>  }



