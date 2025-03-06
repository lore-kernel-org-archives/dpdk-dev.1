Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2E4C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 16:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C7264064A;
	Thu,  6 Mar 2025 17:41:44 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id EBE714025A
 for <dev@dpdk.org>; Thu,  6 Mar 2025 17:41:42 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8A64E11400D8;
 Thu,  6 Mar 2025 11:41:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 11:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1741279302;
 x=1741365702; bh=bJogNGzWfbUZCZ3kY013xmpEtLrxvpO2zQoFkixInmY=; b=
 K+CEpgN0AFmaOGn3BcOI0hNxQBdWvWRCROT1/kodRix9Tgj3QRYGSVKzkzI5e0f8
 v7G/MZLwYaY+xgAH4WVadxurhHQWjDdFnZaRloSKTV4TukqF90PNCbO2VlyopWod
 ObNKO27oZgkbPlira90Le0K32gtyCnexXM3IQK0YDhkESX2FAW22on4H0dHVihkg
 FtJPsokv2Nkz4fPJQlO/yTg2dj2v4R1z/uMbgh4QPu+ZnNNjexGHpcakmywGd9Hg
 7hm+zHP7EmVLNedQsr0pIqFnmBlhQBgOtqsRXyWrJ4JVCdkzhWJf5whHo48Wx7JF
 r9IJsrhlFZF0HFspCnt/SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741279302; x=
 1741365702; bh=bJogNGzWfbUZCZ3kY013xmpEtLrxvpO2zQoFkixInmY=; b=c
 /cIQsTVynmfHPCx4FWDUEC+l1qP9zBX0kix8juSOmoA8DGTGwf+pasIsYnQb1amU
 0hC3QkPcdAF46q35VhNkpmTp9ZZUmAW+PNp1VTQv0i2317bvn/3pSUHm5+K+AfOo
 p64ze+KZWfifocE7JLkt9LTxiJoD+VcVZvo5kKfJzyFbbglOCFA7n7h8l0wllln5
 TUL6KTVPoWY1A451V9DgG61eJ+jl1ZHhlboqFX1ydhUMmcdHbQYRgghOrLMkKUDN
 N8PeRe+j5m8+EMNSwb8f8HH5K+ohuNSDx98bZP+dIHmqrFfzfqXjcYCtSIX4ojGl
 mIcfk4QSEgP+8/PdP4K4A==
X-ME-Sender: <xms:RdDJZ8_x7gJz1zMmEGdd3iOWBz5E9Wnzpj3U5xdeHDEnX9aoAVxWug>
 <xme:RdDJZ0sLx6F-4xEyxMFUCVNiNF8gjNB_zGvko7PZ4-gEJHg9PafmAiI6XwCFwRDzI
 OUFzh-AXdwZaGm68Q>
X-ME-Received: <xmr:RdDJZyCJaSDxJbo1O0B5FV6qE70LXil3yTN2xywQDwn9lIdGjdB5RNsvwsFojanToHfQBIqMzo0Bwd1vc30Tt3wJYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekvdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkoh
 hnshhtrghnthhinhdrrghnrghnhigvvheshhhurgifvghirdgtohhmpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohephhhonhhnrghpphgrrdhnrghgrghrrg
 hhrghllhhisegrrhhmrdgtohhmpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehh
 uhgrfigvihdrtghomh
X-ME-Proxy: <xmx:RdDJZ8eOhQx8POSUOQzP9ZZnUzYOjQgExppGjS88gpIddJNDTLVgKg>
 <xmx:RdDJZxNZ3MBdSSpaLcGdVBjhqhPPJGtUZqGzFzGfo28YVYFp_u6Vxg>
 <xmx:RdDJZ2mbQy7F2apZ3sM0XeuZOMp7xQQMWcMmCW2v0JWkyVK5fegSQA>
 <xmx:RdDJZzsT0zXMZy__niGFYaL1UIsBz152aKf6TE0vFAFo8r8ujfY5_A>
 <xmx:RtDJZ2qun8pqCU6cG3nRhR_Ctgo1NbRqqchfKmBagrfTY49wanGXIvaE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 11:41:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org, honnappa.nagarahalli@arm.com,
 fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH] test/ring: fix return uninitialized variable
Date: Thu, 06 Mar 2025 17:41:39 +0100
Message-ID: <4999286.N7aMVyhfb1@thomas>
In-Reply-To: <cc6faa6a-6c22-48d4-a9fc-c29b070eb57f@huawei.com>
References: <20250219142314.82235-1-konstantin.ananyev@huawei.com>
 <cc6faa6a-6c22-48d4-a9fc-c29b070eb57f@huawei.com>
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

22/02/2025 03:08, fengchengwen:
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 2025/2/19 22:23, Konstantin Ananyev wrote:
> > This change addresses the CID 455328: Uninitialized variables  (UNINIT).
> > Strictly speaking right now it should never happen, as role_mask is not
> > zero. But that might change in future, as more test-cases will be
> > introduced. Anyway the fix is trivial.
> > 
> > Coverity issue: 455328
> > Fixes: 70581c355d69 ("test/ring: add unit tests for soring API")
> > 
> > Signed-off-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



