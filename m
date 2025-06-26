Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE776C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:27:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 242CA40156;
	Thu, 26 Jun 2025 14:27:38 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFAE400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:27:37 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal
 [10.202.2.47])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B4EEF1400040;
 Thu, 26 Jun 2025 08:27:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Thu, 26 Jun 2025 08:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1750940856;
 x=1751027256; bh=ME19OMud1Yfk12zW60XDge4TVT7fyZqhrM5TrATb300=; b=
 cX9On2wUXZRvThTVaUoLCqY7ZBQAjGtsMGPjfSn4B+afNpnqOiGgdQ7DwxfC4R0+
 mJrGChy5DQWRnoA/hFB+FAej/HvTkG0k6lNbbEtxQKioxsd1Frz/IQ9EvAIEZzim
 Fk98eGy7yQkxfSdNez8SzcKgyDfh7nprHpqELJMvSU4KOPcDh7F2L6wPECmOMyNb
 D4IdKVvWVezy8eHWyodYCRI7DcSQSKy659q6ztdRoUMv/y3XzcYEFi3eM9ifQuu5
 ezo4kMgfkxHWyq4f6IR30Y4qy+oZfpdVG7pwuh6n2hpj2XrAXSol7MGFOQQ4zuyk
 00kpH1iqHZzUSdjqXGfiVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750940856; x=
 1751027256; bh=ME19OMud1Yfk12zW60XDge4TVT7fyZqhrM5TrATb300=; b=I
 0OaQvE1hstJ6JNWe7RykIBaLOcXte3tzndTktE+qf/SFEZa0mIpX0HoDcbS2tv7W
 ASuRnJxpbkLcYxn+GBgY4l43WPjgNM7344XHq36U+2BtcVkleTUIv+x0fpM0MFer
 iM3IWDC5qFZPrhsyQKfDS6tpzwFLytwkPHRPYHw1Yv4t1+XkmSmEryERBOrtf88g
 ApWtaMDMykovO1Pw/1cYIjzixCnrEHsU/IwisKCwFrj9t87CWGCLgQkn+uzShUCW
 vd4SQTI3kO9sicQ2RtlFSMZ0uIPfBtNlj+myLap9odca/4Pqd+pg3TClVUiYHPm2
 bSy24vjmZl5Xf9vrCei/A==
X-ME-Sender: <xms:uDxdaCZLW5jjI6QqedKvp2pQJZuMq2cXAvUXzbU1uj34kLYGYF2DJQ>
 <xme:uDxdaFY_YWcciL1eRalgGV_DqmcQpoRx9HOZJ-xLfOCyH2Jxta-5S_vr192J9XJbA
 QVb9PsikzC7IL_ezw>
X-ME-Received: <xmr:uDxdaM-T91EaTBFWLMd64YNMXgNVs6suwhX0qLlzCdRq_oK3Yjk4huvUQwZGliuEfEYLuHW2Mu7WuiRhBL_A_lz-NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtoheprhhonhhgfigvihhlsehnvhhiughirgdrtghomh
 dprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehmrghtrghnsehn
 vhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirg
 drtghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthho
 pehsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopegushhoshhnoh
 ifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgr
 rdgtohhm
X-ME-Proxy: <xmx:uDxdaEpV7V4VyVjNaf-MD3CsYuqOIkzpVTJT4KyxoR25Cz-691dIwQ>
 <xmx:uDxdaNqQKa4xZVjbjSNy_RRMhDGO2MYxnJnisG5skIG18ECTWUBLxQ>
 <xmx:uDxdaCQltZUM7KXzdVYYy_5vB_YFLYsQAc4diI3k8c1yrgZQZdjHAw>
 <xmx:uDxdaNq5TGXXl3FLA5ojvDWWyo8IJSBkb5W8LThaKJy1vfdiZ3eQHA>
 <xmx:uDxdaHaJ1xluQrIKt8lN4zjWJNnLZ129t2YT5Ai1kFCdVRSV_bFuUesb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 08:27:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rongwei Liu <rongweil@nvidia.com>
Cc: dev@dpdk.org, matan@nvidia.com, viacheslavo@nvidia.com, orika@nvidia.com, 
 suanmingm@nvidia.com, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>
Subject: Re: [PATCH v1] net/mlx5: use reg to match eswitch manager
Date: Thu, 26 Jun 2025 14:27:34 +0200
Message-ID: <12667519.U7f9L36N0a@thomas>
In-Reply-To: <20250619071704.1718079-1-rongweil@nvidia.com>
References: <20250619071704.1718079-1-rongweil@nvidia.com>
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

19/06/2025 09:17, Rongwei Liu:
> Rdma-core exposes E-Switch Manager vport metadata
> for matching in flow rules.
> Use that metadata when available.
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
> Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied, thanks.



