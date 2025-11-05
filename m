Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A416CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 14:53:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FB5440430;
	Wed,  5 Nov 2025 15:53:48 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 4C75B40430
 for <dev@dpdk.org>; Wed,  5 Nov 2025 15:53:47 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C82701400234;
 Wed,  5 Nov 2025 09:53:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 09:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762354426;
 x=1762440826; bh=nx9OsPP7xTFdhRykZ1Ml6d5MjUg9r4AIhIKfnNOQOxI=; b=
 woH9dGuyXEelkNxCKxmA45mRnmypv9NOaA1EgtJPAvqT6T+24VlIBosjQma3wisF
 nLG3HIKS8HISRVBQ36SNXDO+luZKATD/fv5rPM3UEzPXusfr4D7ckerMY4zvCk+B
 Pi/LFn6/DU98m2WwDqaNAyaylGdSXmDGTpwc9/YvP9qBQQq3Fp7JiOSF/Fx2ViNU
 kqS7BYXz8IfjqnChALbHUlA7O1vvafP+G9lswyeUjjBxN5DgVaOdbGtjiYEBVFWI
 1ooxA3k9u5YfWeFe2HzlCCH/+V4ufQRcftUrz1guju6ahEqMcl3+oYd+kfJR0sUX
 niV1U7n9dPflgdEICE7ReQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762354426; x=
 1762440826; bh=nx9OsPP7xTFdhRykZ1Ml6d5MjUg9r4AIhIKfnNOQOxI=; b=M
 2pelrns43FmYRUhMxssi6xS35iOF609vheSy2RL4x6wXbtb32uu3d1oSVH84vmf2
 WCLXOIg5XZKCX2tKjQG/r4QnMBNiotVVsJHpEUY2hKUWR46L0JV2GlI1q1pVCkLX
 nK4pit3Fj2rd4EYMm4Z3+diej9DhKf4KUppO2Ky6zKCMehQXkIk4ZophsuaW/DWX
 eJcyVbqqSTzkTrdlgTUDunothHpwmQZq/7AtKkVUaE/ytxSxV4MkTJOb1+U7Ikc1
 BzCqO96yE+iG5H1cnrwSjNvM1o1WnafGt30/QDikayQsS5cWBXdhfuWLNuEoIr23
 Go8m94erjkGlwWD5WqH6A==
X-ME-Sender: <xms:-mQLacCIC31Ixzg7JRgkhUrPvuDGJnrkWRJX7VmMF96w0U1FWDy46g>
 <xme:-mQLaUgxyATvoXtKfib_TmXjee54BcitXzxBRJENegig2LLVt10kqAoNxsDgmfCSw
 h5WP02hQdt6PR7Ivey-2gIBa83Y8duQQPnAYPZr36TO9Iy1rBWSSSI>
X-ME-Received: <xmr:-mQLaaYUpFcybkk95vHjt5YND-K5Ij-YYsV2_mBK2TDy2ZGnHuet8PUiWBirB5Ebhf6-1zvomgLh9cs-aQme-tSNHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduuddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhvvghluhhmuhhrihesmhgrrhhvvg
 hllhdrtghomhdprhgtphhtthhopegrmhhithhprhgrkhgrshhhshesmhgrrhhvvghllhdr
 tghomhdprhgtphhtthhopehkvghvihhnrdhlrggrthiisehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghp
 thhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepghgrkhhhihhlsehmrghrvh
 gvlhhlrdgtohhmpdhrtghpthhtohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhr
 tghpthhtoheprghnohhosghjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprghsrg
 hsihguhhgrrhgrnhesmhgrrhhvvghllhdrtghomh
X-ME-Proxy: <xmx:-mQLaVn_43oYeJ4j6n7b32M9uSIWZ6bn5GkU9KFUvRVucYEo_5XJAA>
 <xmx:-mQLaQhxBEjA15tSkrsB6bEI79MaMR8XrhI-BVG-Ci_FeFjfbJO23w>
 <xmx:-mQLaXTWSS1prUCKY98_3WusK1arq6bkvtC0VAO-VrJ2HR_Bg1mZZw>
 <xmx:-mQLaRbLWuERo90EUkAupfUqgtzV-k7VmBPMWKKWCg5t9z-vEI2NHQ>
 <xmx:-mQLaaSYnjH6cXad70yqGgKrRF375jTpFtFFshTiORDV6xoIVs7WalE3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 09:53:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Vidya Sagar Velumuri <vvelumuri@marvell.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>
Cc: Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 gakhil@marvell.com, jerinj@marvell.com, anoobj@marvell.com,
 asasidharan@marvell.com, dev@dpdk.org, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH v4 2/2] test/dma: add functions to verify zero and one fill
Date: Wed, 05 Nov 2025 15:53:42 +0100
Message-ID: <4608289.UHzMenYllF@thomas>
In-Reply-To: <3051d7ed-ccc8-45c3-8e2e-d76efa1146c5@huawei.com>
References: <20250606094031.2961842-1-vvelumuri@marvell.com>
 <20250609030314.4098409-2-vvelumuri@marvell.com>
 <3051d7ed-ccc8-45c3-8e2e-d76efa1146c5@huawei.com>
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

Any news?


10/06/2025 08:48, fengchengwen:
> Hi Vidya,
> 
> How about add a wrap function and keep this function (could modify it's name).
> 
> static int
> test_enqueue_fill() {
> 	uint64_t pattern[3] = {0x0, 0xfedcba9876543210, 0xffffffffffffffff};
> 	int i;
> 	for (i = 0; i < RTE_DIM(pattern); i++) {
> 		ret = test_enqueue_fill_patter(dev_id, vchan, pattern[i]);
> 		if (ret)
> 			return ret;
> 	}
> 	return 0;
> }



