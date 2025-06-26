Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4AC7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 16:04:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AAAA40276;
	Thu, 26 Jun 2025 18:04:22 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id AB43A40156
 for <dev@dpdk.org>; Thu, 26 Jun 2025 18:04:21 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2826C1400029;
 Thu, 26 Jun 2025 12:04:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 26 Jun 2025 12:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750953861;
 x=1751040261; bh=VVY9Pv0gYgQLdX7KwxmHFw/JfJmkqV7Kg7E5IyNtuVE=; b=
 vYDO6FK8UzY7CnR9nSTFe8cy7fOm6BIO/funb4QiqmLd+5/HdG6O1zKRYhvNVxUp
 7UAcaKMKyKCm+NXhIHTq7bmXkDI5Ol3I5LZsUx7Jz57WTVmce1ZO/ksbQqSTDgZj
 b6/mwMLYBd1XsiNfj2ZSU6ilpmSVZAp/Mw5xNXY8kGMgW0elWjHbTGWPf1vyROmz
 0zjI29qxZifHnynm5SspT7gm67LuWtp+ZMZOYUoBYD1McDcGbgyh/pFuoGqvt4iR
 DSo5ijqlbacgNyUcbmBbyV8mLxXqP8sX4hpUdQgpcjWVp83ePfWbXivz2/JQ3yO8
 NeGiRvjWy4wqfJYgJrWheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750953861; x=
 1751040261; bh=VVY9Pv0gYgQLdX7KwxmHFw/JfJmkqV7Kg7E5IyNtuVE=; b=D
 Lhs8MG1WL+/1hc0U9UxBC/S+ZKHIzzU527CvSSQfLMDCyHKteNqlEGVIXm9eEIn9
 ZDNXvRt1aEWqOW8bPcmvWBh6GNxY07A0tTJMrxNFGkEsqUVk32nI5tvsyHARNYQv
 dEogjDwWUbN6SlC/e93rC5B2hCuwnbpeWWezBAps8zAG72cwnsE3dWwXznfloyVU
 hnipgvddWGEFi9mV98oeVq9JhWlJIHWas1CoTONoteTeeyH5JsyNdm3FZQIrxHpv
 nO6+rp5drisAnjWTc9JPKia7mLSt+C6u3lA4xBZpfHjvmtMsO3S1o3riyvSotGCl
 9wAAi+6aSgXkGxBDGVplg==
X-ME-Sender: <xms:hG9daAEwoePl_UbpNeLjma6LXU8XO1SD7ygUEjhEhFyFwdmLWM43RQ>
 <xme:hG9daJVypCNcddDTTiPIur5-EA7_tZ8jNqvNlNv9FcgtxL_riQ7VfeNtLVibzHwj9
 pDfR6e6UiyP8XL7dg>
X-ME-Received: <xmr:hG9daKL_srruSO_wQXG0eQGcXI_eiiJFO_X1EGLHLf5e1TrwQx0GBjxImh50bE7KSemheTnXkJ9gbA0sQ9MNm1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepghgvthgvlhhsohhnsehnvhhiughirgdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmkhgrshhhrghn
 ihesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgrshhlrghnugesnhhvihguihgrrd
 gtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
 ughsohhsnhhofihskhhisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:hG9daCHQHbrvsDo74NB3ECOQNMcffQXRC-qmuW4xpcTqh2AeUk6s3g>
 <xmx:hG9daGUIX8C2dqAEdpLjA0f-jdsHSzsOWNuIyr-RUarg_a5OlPHoxQ>
 <xmx:hG9daFPtAx5PqR3eh085IRGDR6km_LrLHfaDKttdSOdccuZ5VuLX6w>
 <xmx:hG9daN0vBoQejZ5Gy5eUtkWmbiS0BtwpRwtkc9cJKZjXuteC0LQjdg>
 <xmx:hW9daA1Rh3lHeCos5X1gOb-nTfZFOCkC7E-wI1oFmjBJ1Wf39jQiONty>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 12:04:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Gregory Etelson <getelson@nvidia.com>
Cc: dev@dpdk.org, getelson@nvidia.com, mkashani@nvidia.com,
 rasland@nvidia.com, Bing Zhao <bingz@nvidia.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>
Subject: Re: [PATCH v2 0/4] net/mlx5: support non template SAMPLE flow action
Date: Thu, 26 Jun 2025 17:28:47 +0200
Message-ID: <6412646.QLehXeTyEo@thomas>
In-Reply-To: <20250626075945.537256-1-getelson@nvidia.com>
References: <20250617133933.313443-1-getelson@nvidia.com>
 <20250626075945.537256-1-getelson@nvidia.com>
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

26/06/2025 09:59, Gregory Etelson:
> Support SAMPLE flow action in the non-template API. 
> 
> Bing Zhao (1):
>   net/mlx5: fix the table flags of mirror action
> 
> Gregory Etelson (3):
>   net/mlx5: add a stand alone function for mirror creation
>   net/mlx5: add functions for non template sample action
>   net/mlx5: support non-template SAMPLE flow action

Applied, thanks.

Note: UINT32_WIDTH was replaced with 32 to help with Alpine musl.



