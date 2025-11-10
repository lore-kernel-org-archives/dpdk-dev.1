Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D17CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 09:39:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24B67400D6;
	Mon, 10 Nov 2025 10:39:45 +0100 (CET)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 41754400D5
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:39:44 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id AA2DA1D0019F;
 Mon, 10 Nov 2025 04:39:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 10 Nov 2025 04:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762767583;
 x=1762853983; bh=L0l2rBLk7GQMu7s7FUPefQWMet6vTttWXLYmuT88U4k=; b=
 Uu4hmzSy4L29NOrr5Fw94RCXdG4s2YGbcozd1RMu+BQDvNQrRVExWuEj9CwKpb4K
 kHp/gwz+QB8dpvZN2POKzIkkzWxo+szFIt+oi3kyO4JsD32xMr/DulifPy7ZXoIM
 df9Uj8tUnpHrgHGiK4N2SHtABrgdsMSbraojOwO3ZJiZ+h8i5K51WuJgRHYHb+sa
 bbPLzyWaW15XXJrsHP+Djv7tyKQQOHv0pCm+aV8PLHCG47RUS1btdbnLaWvm7DfD
 +cNq987FmXp3nxsAkDlPlc92BvlQ/e37tU6YWDnU8HOEKKx5fuouTo8ypTj3NqJm
 dqTpw4rb6LS714r6+OTB9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762767583; x=
 1762853983; bh=L0l2rBLk7GQMu7s7FUPefQWMet6vTttWXLYmuT88U4k=; b=a
 9OUENVNAOeCdaYkDgT/RuPqBIUK5Q6drR80MrhuDH9ivyye5xpFG2D/goAkcmtOf
 7gr7Cmx5xVcvgQhl+9oV/STshPMNZUNyL+fZFK7piYikT1SD9V7xLH8xyEoZ6WIx
 Y8MVKfmH9PsS4LV6GLHZJZERntlZXn8a57Wn5iROjBNqYDWo1GCVYljTCKhdmDCA
 lzJNoFLqR4/NHMllEmDtxNB5bfVecmGsz/zFzlk5m3D5+uonePSgeXwua5Hipas0
 wH8JriieC6nZtQdOJOdasd66lDLsnrJOW6bDVNDI4/zDZSdyqPvdG9dBYGrPWa8v
 Bt3RvrrwyfYOkKExAX4AA==
X-ME-Sender: <xms:37IRaafi6khKPcMs-3K-reVmT3VixA7Orr5VjnS-ivJqW1MmlHC2ug>
 <xme:37IRabNLxzonU7weInTaR9qidGFCan8r62joCo6x6My1qIEzLzL7lCj4C3GociCEn
 HPZd-BGBYIOAleSxEpZImo4MZhISOQ8W9T43p6vAHOmDCrlAPCQAUI>
X-ME-Received: <xmr:37IRaQgbzIW7TQJcg1t79FKT_fvXYfsZZ0sO4l3TJJVifw-4CFnkk2G0c9fkfmPJw8SqizM56lClXiVzvQhLuQlH1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejleekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnhihuvggthhhisehishgtrghsrd
 grtgdrtghnpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghr
 uhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvh
 hiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:37IRaW3AsAyNB4KEIMsy894-ReGnatSS_HY4Rl_e4r6Xyouu_6tjLw>
 <xmx:37IRaSgS4cu7-RlIc36i6fzrnQ5UMRjIXWVH2ZfPo3aHF0jJsgqZ3A>
 <xmx:37IRaef4msCsUhVe5Z9XNEuOpFm6MaXiM-lpHaf8G8zVNOJD_loRZg>
 <xmx:37IRadmXeow8-Fb0v8p0217NGoweswyByNF8rirzocqxsdmqa3LjIA>
 <xmx:37IRade6XC_xbONFMcz8Fbuw36LDQFltmregWFfjSizyaHsALLxYfQub>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 04:39:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: sunyuechi@iscas.ac.cn
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] devtools: add RISC-V vector in meson build test
Date: Mon, 10 Nov 2025 10:39:41 +0100
Message-ID: <2488151.i5x4bddO4K@thomas>
In-Reply-To: <11c5f45b.209a.19a6bafd5c3.Coremail.sunyuechi@iscas.ac.cn>
References: <20251110025220.3319989-1-sunyuechi@iscas.ac.cn>
 <11c5f45b.209a.19a6bafd5c3.Coremail.sunyuechi@iscas.ac.cn>
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

10/11/2025 03:54, sunyuechi@iscas.ac.cn:
> &gt; Maybe we want to replace the generic RISC-V build with the vector one.
> &gt; It could be discussed in another patch.
> 
> I think both scalar and vector build detection should exist,
> because I've seen several times in other projects that after adding vector optimization, 
> the scalar version build failed due to incorrect compilation conditions. 
> Some cautious projects also test various extension combinations. What do you think?

We can test it in a CI, but test-meson-builds.sh is supposed to be run
very frequently by all maintainers. I think it is too much.
As a comparison, in this script we test only
1 Arm target, 1 LoongArch, 1 Power.


