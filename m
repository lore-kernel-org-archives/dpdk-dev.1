Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E12C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 12:45:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B6204060F;
	Mon,  9 Jun 2025 14:45:30 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id C1E15400EF;
 Mon,  9 Jun 2025 14:45:28 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id DE91411403CE;
 Mon,  9 Jun 2025 08:45:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 09 Jun 2025 08:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749473127;
 x=1749559527; bh=PGg68EoEQRoEpxbjeIYm2l0k9tJc+AEpyQPqCLZmBPc=; b=
 UNrsrlcUPqFLYtcyHMbxw5tvvUzoOp3gtE9LBMP8C1Jvvthp2NBajbLDz7lpjzJg
 0cIjflXSRpEJ1wl9h+CBeLfwW/mHj422TRvaKF+dKd6zTFz63LkRJ6Cdh659pG50
 vBYhDC52w7wXgp2VXJur/8eBixwp0C2IxfJsqtHvnKuV/wVWIVHf1VyW7779qrWa
 WDWFJZxXww3etr4DarY+UFCE2w0p/opms5Z3al8nUhcUHttLpG9jr04mjW/O1JEC
 XBd3tCb2/OusRj3v8W8t27psjbSgRLtwY0eKQlxXe++pKo8jSed7QaPVC+OBY5H8
 M1SK63adz2tD5jnXt4/gJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749473127; x=
 1749559527; bh=PGg68EoEQRoEpxbjeIYm2l0k9tJc+AEpyQPqCLZmBPc=; b=W
 8odIh2jpbc/ufdl4R/7xgv9xnIVTsWv0SK3BzcsniCHmTnjtml0C+Xu1DQPknmxB
 PPeObAdoJmmtLCkFFYjhCElL0lF+00SU5xzqM9fQYHkHSBo2KHUeHZyl7cJt6TZ3
 JudIJMBqvbHsrWlUAJcqHZP6Il/R8eeIuy2xDsFQOYJrOaNYQ7XFiyRoxDe+corM
 mv/sAatyqMSIXuJmwaYAhGAaTGNUp2pKRpXvOsztIfDsF3S0lgAD0KbkaYEdZOsj
 nCT+mhWNfdIc31JVFHjUgI5fcFd4PLRArKZeAFws5m93vTta9lxRE2gVXorA8ejs
 ZDWRrfeSjxqdlq+jPFivA==
X-ME-Sender: <xms:ZtdGaLzUpHwG56S7gXWVar7rUKL4AKITmab1oIrXWjFpAJSj6axvGQ>
 <xme:ZtdGaDSYlZap8W5LgeTPQan4B6CR1ineA5JL3xovIshzwOrqjTUQNlzYUR0AWTbbU
 qfP85WZ31uOGSoYLA>
X-ME-Received: <xmr:ZtdGaFXewOMdXI-Pd1Jz2zdZDJAYttpxjpzmJVX58ZLi9EiBFBMW2nAoXH4bR_nYn8tOJCUikRJnOKM5_RQVzEokcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelfeduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeen
 ucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrg
 hlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeek
 ueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhn
 sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhird
 hfvghrrhgvihhrrgdusehhqdhprghrthhnvghrshdrtghomhdprhgtphhtthhopehsthgr
 sghlvgesughpughkrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:ZtdGaFh0HjL66WA9G05NUloE7kitT3-o5QnEr-W32Pc9HERvK4B-YQ>
 <xmx:ZtdGaNBd4oD7Vwp0zmndq85fcst1bARtbmENtSJRFq3KDVQFB7I4cQ>
 <xmx:ZtdGaOJtUZ1rCcdizgLbhtkPPGRi54RQTaHpoxzWhkpQLC0-Poyu6w>
 <xmx:ZtdGaMBmWt_b4VB2uiQifB9Cnc7tH_1uJ6i9rz4T_JANHYN4oBtQMA>
 <xmx:Z9dGaCDZMU_2olvkL8OdlMlD-iLy7p40klquYz-UPvPwQtV5DIre5hft>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 08:45:26 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Rui Ferreira <rui.ferreira1@h-partners.com>
Cc: stable@dpdk.org, dev@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 2/2] fix eal/freebsd: unregister alarm callback before
 free
Date: Mon, 09 Jun 2025 14:45:23 +0200
Message-ID: <4901987.Y6S9NjorxK@thomas>
In-Reply-To: <aD6yTxLUgI3jxlPe@bricha3-mobl1.ger.corp.intel.com>
References: <dcbff1c1ee8c48598294306fe80167ef@h-partners.com>
 <20250530081845.64297-3-rui.ferreira1@h-partners.com>
 <aD6yTxLUgI3jxlPe@bricha3-mobl1.ger.corp.intel.com>
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

03/06/2025 10:29, Bruce Richardson:
> On Fri, May 30, 2025 at 09:18:44AM +0100, Rui Ferreira wrote:
> > Unregister callback on cleanup to avoid use after free from the
> > interrupt thread (eal_intr_thread_main).
> > 
> > To be more defensive, set ptr to NULL if we can unregister.
> > 
> > rte_intr_callback_unregister_sync may (optionally) use traces
> > so the alarm cleanup must happen before eal_trace_fini to avoid
> > accessing freed memory.
> > 
> > Bugzilla ID: 1683
> 
> Source of bug is probably:
> 
> Fixes: 90b13ab8d4f7 ("alarm: remove direct access to interrupt handle")
> 
> > 
> > Signed-off-by: Rui Ferreira <rui.ferreira1@h-partners.com>
> 
> Patch looks ok to me.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

I think we should keep trace saving just before trace closing.
Applied with this change, thanks.



