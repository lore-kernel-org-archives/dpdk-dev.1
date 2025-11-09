Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15672CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 18:30:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E605440268;
	Sun,  9 Nov 2025 19:30:14 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 2AB53400D5
 for <dev@dpdk.org>; Sun,  9 Nov 2025 19:30:14 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 7D008EC0174;
 Sun,  9 Nov 2025 13:30:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 09 Nov 2025 13:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762713013;
 x=1762799413; bh=i6BhtD4yOKCa80HBBcVgrAiCecie1FjXSKz861sJwhA=; b=
 SrxTAtxou4RlwsKP47ZPL5x04//kXVHJ3N6Fxi4qSTXnIltpVRvTTWVcDO7iOm1y
 qFR3qk8gj8mkSF4LN7Q9mw1HvPRa5h6OTMNalvgnO595kbfNQlnT+JjVRMKcAefs
 z+11wMa9tQr9Z23CNJ5I0GPbS8iBkTlNoEEXEhgtwW41WamPYhfU0jmkIKsumb1I
 VIkzveznYf5Qs89/WnlJBnFLgS/z9ijxE0CxGSHA4R75Lw0WmYJ2U1ux15z5g0TR
 KUoZIJyKU/wu3cxR1wgQRCOA1aT9HUa1sYolKo4S+ecVPv+Ev++NLUbSSU4SIJLy
 Cc4huG0ybL4VKvWNBK8Fwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762713013; x=
 1762799413; bh=i6BhtD4yOKCa80HBBcVgrAiCecie1FjXSKz861sJwhA=; b=m
 g77DB5lhlrFS9yQyk5UvNSwxmJ5kX+4GIPnWZmwp5EbzGQy9ACuFdhMclqf0g6V8
 eq6k2A+vfmzmWVzuJ+i4VuIbceazISxVbEwN0JT73XAM9SwVqb00ATzsEVVSc9kE
 jIlRCqs1QL3ZS0Z63Z/z/Pbulixe2VHQLkRRgqt+WfnBF9Qp6IyGLBd+NWSmA5jH
 Lkog//RXM4ubXh/PkINc5RZzNaO5U0fA9+cN0yCr+9w/38rXfajSVtxlKImyw7tn
 j/QeLHFQSR+3yE6mCuzON6GUQMu05z5oMlImQ3fSimjS8RaWJKliSSj+tJUceICe
 uI+J0Qex6wXxTsR7tcpGg==
X-ME-Sender: <xms:tN0Qacj22dzpVz50zxUzG2dXGqlfFzv8I-aHrjaa6Ht2H-2vLSpeRA>
 <xme:tN0QaQcRfBvJlvBb2Nj0v1XU5ziLw6QZEm2M_GIyWgAJ-AGvG8YKR1dp7b4iHoof3
 vZbxkio658o-VKyeMBmyRZGmNLTgSjCzvr4WFe1Erm0cL720qXUge4>
X-ME-Received: <xmr:tN0QaXmdfnd_mxdHSgMIdqvFfrb_hs-xvq2-zAnQGFE1WuNv9djCFhvpfblHIs_S_8DDi27cC29q8ZopwgCRC8pOVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeiudehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohephhhonhgvshhtrdhjihgrnhhgsehfohigmhgrihhl
 rdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtoheplhhiuh
 ihohhnghhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepvhgrthhtuhhnuhhr
 uhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:tN0QaRupHNcCbG3m0qoyHzPmD21hm83tNYRoDl2bIVzHoS47ENJnEw>
 <xmx:tN0QaV_VGEknw_JcTKTIem5WKjgwQQKYbAgzvLhbYx_cpzFF2LA3xg>
 <xmx:tN0QabNdewoctY3btuFyzRkwKEthIJomWmBSVLkZ8pGCvX23wuSWiw>
 <xmx:tN0QaTF0zxww9rhblNzWys1HUZy6U6mpb9XRIkhSYTYRX_Gqvn9H5Q>
 <xmx:td0QaXQ21GSHn7efe9Voujyukve5kPeDd4946p1fNoMTddyqixe5aIiq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Nov 2025 13:30:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: honest.jiang@foxmail.com, dev@dpdk.org, liuyonglong@huawei.com,
 vattunuru@marvell.com
Subject: Re: [PATCH v4 00/14] bugfix and refactor of dma-perf
Date: Sun, 09 Nov 2025 19:30:10 +0100
Message-ID: <6533809.peFUeoqG7q@thomas>
In-Reply-To: <20251020041105.1590-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251020041105.1590-1-fengchengwen@huawei.com>
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

20/10/2025 06:10, Chengwen Feng:
> This patchset contain one bugfix and refactor commits for
> test-dma-perf application.
> 
> Chengwen Feng (14):
>   app/dma-perf: fix use-after-free
>   app/dma-perf: add global section for config file
>   app/dma-perf: use argparse lib to parse argument
>   app/dma-perf: refactor output csv
>   app/dma-perf: support list DMA devices
>   app/dma-perf: add more global config
>   app/dma-perf: remove invalid or redundant field
>   app/dma-perf: refactor load config function
>   app/dma-perf: refactor benchmark function
>   app/dma-perf: support specific error info
>   app/dma-perf: fix segment fault with large size
>   app/dma-perf: fix on-flight DMA when verify data
>   app/dma-perf: fix wrong stage to stop dmadev
>   app/dma-perf: refactor benchmark function

Applied, thanks.



