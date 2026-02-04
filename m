Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647AE95363
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 09:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BC1D402EE;
	Wed,  4 Feb 2026 10:35:51 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 10B47402DE;
 Wed,  4 Feb 2026 10:35:50 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 1D81A1400286;
 Wed,  4 Feb 2026 04:35:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 04 Feb 2026 04:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770197744;
 x=1770284144; bh=ylrdXG5r4Ti/d5RS+VgRi/1Bb/SPX44H1jAdpdc3uNc=; b=
 GBQqUmzkNPwab09qnatH4KDW2v1OuVQFVXb+Y0IsWIKv58Xi9ETtH/v0/vE2Q03e
 P2V4p3HSLrjk1w41ARoeH7YdYCI7+B5c1rtN1CjUVcCcQMeaRtBExPnBBV33OG43
 r+2xB6VUif4gjeBB5gNSEIdkLAhygPXM2+DEpN01RavIMxENqajTD0zsKIUGS/P3
 n+ZoJa0rNFfkaYwEpt4O+mmQcjtiK6pCnJrnUsJks4ycMRhJI0Ou3FnLRg3z/oLN
 UhPQ/4qPHM8t7Oydk1DW+rg3Z3/hli7pqLYuJZOPrDE+5U1HSKc9WaudXRagprf6
 AleBm8nU+CQEvrhBrJ52Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770197744; x=
 1770284144; bh=ylrdXG5r4Ti/d5RS+VgRi/1Bb/SPX44H1jAdpdc3uNc=; b=p
 Yza4skwe964ZjEfAdmjomDFMYrpHtlzG2zkrtD3a51diOdNRa5MqpSfq4qPlThFv
 XF47AIe5RFlNQDGnzyUWcs1dv5xIidK05qCUN8dyWyDUWrO4JIAsDqO2w54kVBiU
 T/YKTiAtPdYkOF1b+W6d7YF6XjzKwXm/3keg0eKvhQPKbejrqtghslv0+nO8dozJ
 aTrH5euL3Ra87uSljMoE1nr623WkTrJ7Ouv1ci6fnbJAwgsSZOA/fCviR1jVbMp4
 VTabBWCwEUGl6JL4vh4DyAqNjzR3gwEejWtD1O7foxFvZvllXw8TKtz9I0+HzVpj
 OEZ8z+dFXfk/06Cg5al3w==
X-ME-Sender: <xms:7xKDafWZp-BnsV36Dq7mN8D-d4X8zC-7ic_9npIUia5R16fYQfdLHg>
 <xme:7xKDaSjKui4R8ZPT9lbgLTbAN3WdYQDGXB9yPrNnIdxUpELBJkt1my-IlKvscBYpc
 _7dNmrDaHdqgFPs3Uhv9x--pFxbS93VBZaTKskRo1YQIal-EHWUDTU>
X-ME-Received: <xmr:7xKDaaZ5ENLaf0p3_pAasyDlA_reA82fMAyHo7-wFnaL_UnJbbNZ7irhq9W4HluWXm-mNMswDm0Cb7q4D81IV_skhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedvuddvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvudegudehvdehjeehudeiudfhveelteejieeiuedttdeghfekveet
 lefhteekffenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuih
 iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhho
 nhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
 htohepmhgrrhgrthdrkhhhrghlihhliheshhhurgifvghirdgtohhmpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkh
 hplhhumhgsvghrrdhorhhgpdhrtghpthhtohepkhhonhhsthgrnhhtihhnrdgrnhgrnhih
 vghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehfvghrrhhuhhdrhihighhithesrg
 hmugdrtghomhdprhgtphhtthhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:7xKDafrzJFawZFzyrx4BMMBYgwmtWzvBbJKalmK7IzBwfSM0XAeYiw>
 <xmx:7xKDaXNZqoKWxrLOiVbArW3Fn_VpCEzBpzvq839Zp6VtYh91pCU5XQ>
 <xmx:7xKDaSrWmG1IWCK1RMLEIV_55l7tHpMwQNazdRciJGs-SGRrAEtdig>
 <xmx:7xKDaUfA6Rw75c9qOOncRRnRkTmv_9BYwrMJmv1ty0UhHy8P3BR0iw>
 <xmx:8BKDafhbkqDK7T4Y6lpLJAeSqek5lamZu2cNSEvWjqImIgZPBUyb8Am0>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 04:35:42 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, stable@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3] bpf: fix x86 call stack alignment for external calls
Date: Wed, 04 Feb 2026 10:35:40 +0100
Message-ID: <7022287.MhkbZ0Pkbq@thomas>
In-Reply-To: <20260121101653.66438-1-marat.khalili@huawei.com>
References: <20260105160958.80443-1-marat.khalili@huawei.com>
 <20260121101653.66438-1-marat.khalili@huawei.com>
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

21/01/2026 11:16, Marat Khalili:
> Correctly align stack pointer on x86 JIT if external calls are present.
> 
> According to x86-64 ABI (https://gitlab.com/x86-psABIs/x86-64-ABI,
> section 3.2.2 The Stack Frame) stack needs to be 16 (or more) bytes
> aligned immediately before the call instruction is executed. Once
> control has been transferred to the function entry point it is always
> off by 8 bytes. It means that JIT-compiled BPF function will always have
> its stack misaligned for any nested call unless it performs operations
> with the stack; even if it does use stack there is still 50% chance of
> stack being misaligned since it uses it in multiples of 8.
> 
> To solve the issue mark RBP as used whenever we have external function
> calls, and align RSP using AND instruction at the end of the prolog.
> Marking RBP as used triggers stack pointer saving in prolog and
> restoration in epilog.
> 
> Add tests for external calls from BPF program demonstrating the problem:
> * direct verification of a local variable alignment;
> * operations with 128-bit integers;
> * aligned and unaligned SSE2 instructions;
> * memcpy and rte_memcpy (may use vector instructions in their code).
> 
> (Such variety is needed because not all of these tests are available or
> reproduce the problem on all targets even when the problem exists.)
> 
> Fixes: cc752e43e079 ("bpf: add JIT compilation for x86_64 ISA")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

Applied, thanks.



