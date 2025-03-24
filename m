Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDC9C36002
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 20:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6830440B9F;
	Mon, 24 Mar 2025 21:00:07 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id EC59240612
 for <dev@dpdk.org>; Mon, 24 Mar 2025 21:00:05 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 0364213848FA;
 Mon, 24 Mar 2025 16:00:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 16:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1742846404;
 x=1742932804; bh=bsd3lAtLRABwfZkmObdydfc+fCB3tqNUpdpYLuy3C4k=; b=
 DyX4kuaav1LrivM7vj3W6cOrk792k4u3NqN/oeN2J3/Y3GBshQkV66w/QB1UmKs4
 5rKGQSIWjjnyTWV351G1+4ILzFJi3fp/8uEYwKc2OBbg6dt2rgS6Dfnr4bYHTGPh
 p9oP3Ocp1vqOSeDPDscyAIY20RO4/qkaprBqVAVHt6SdB5nbmGBbowsYTtxlKRzT
 c4SXM2rHFYHvlR8eremmQsZ+oDbxGAo5QgnPsxJ6DqxYOcTUYqcsH8Vyd2/6GpF5
 JIHoN8MTAyCHiZ1hkUgmvlmXfuQqsWcssjhGxRsnEhCVQF9+0LQPcXLpny9y0o33
 cetimcDYlz/RZ5wNqVj1wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742846404; x=
 1742932804; bh=bsd3lAtLRABwfZkmObdydfc+fCB3tqNUpdpYLuy3C4k=; b=x
 GTSCW7MxS1AdqATBhLCBppy1qMQ4C+kG/O4ssS7Znkkzz13DbMbUqGddbIKea7ln
 jbDtdQgm7kTNwNs7EQhfhz5N/i+CI/br/504/mn6y7cmoDiA3M6mOrFgU1yD4Dks
 nucRLT39cCX8G18pItrTF0y9TvL8S5hN+5vbkK+NURhO6SiysX72YEXdQVr4dZSg
 uHnvPAu//nJgHJu2qLYGNlY0ctASJBbh0XpbsAdkqMEyvkwR+5R1dKsLKHXah3oe
 rP5CmSO+Jae/2+P5EtzLwQkJudPEsYR/fDqLxwKiA51UjLEuaPG88RQbQ2ZTW6uW
 56ZIpYoD2kQFM+d7PXP6Q==
X-ME-Sender: <xms:xLnhZ3gW-XyVSdaQlbN0d-ZAZK2a5DxX3ATjdgnmyVBBM0HSNCErRw>
 <xme:xLnhZ0B91A4_RJ-qUFsDnXdSzk4cgA79jfYsWXX_eZmiK5VAaDmhvMNazCjrQ87vH
 oZALIFN1ZPao4corA>
X-ME-Received: <xmr:xLnhZ3EsYSfAgNia1ICLqEXytsdeXtQsBIudJm2q0tgFANRPTQonAwrJ_YJiNcCaemA_4UB-eiYDu74UXsrd6m4x1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
 hhnhdrmhgtnhgrmhgrrhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhg
X-ME-Proxy: <xmx:xLnhZ0TeXE03vSklMkQh87euWL8ak7BGGwh60KT1Ji4x-IS92PObrQ>
 <xmx:xLnhZ0x_L3vZL9IJJk53y-6v8OZqJkLDJMvmzR64ctMpvXpvFzv0nQ>
 <xmx:xLnhZ64XjuLoc79Me9YWbAyqbXWG9eeOQlEudQUuto0o1tEgqqlpgA>
 <xmx:xLnhZ5z6y0qM2rl7wtTL-xjE3FQr7mQMcWNF4RiIuPC5owddVyYi7A>
 <xmx:xLnhZ_-p9rfUXJhfoGeUYLja4fuNEcv_Fa9N-ssSTeJBztxKdhF086g8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 16:00:03 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: John McNamara <john.mcnamara@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1] doc: update release notes for 25.03
Date: Mon, 24 Mar 2025 21:00:01 +0100
Message-ID: <4955010.jE0xQCEvom@thomas>
In-Reply-To: <20250321173435.1335993-1-john.mcnamara@intel.com>
References: <20250321173435.1335993-1-john.mcnamara@intel.com>
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

21/03/2025 18:34, John McNamara:
> Fix grammar, spelling and formatting of DPDK 25.03 release notes
> 
> Signed-off-by: John McNamara <john.mcnamara@intel.com>

Applied with an additional merge of vhost and virtio RSA features.
Also removed the comments.
Thanks


