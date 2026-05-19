Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42A5CD4F57
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 10:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD6C0402C8;
	Tue, 19 May 2026 12:35:19 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id C1B2440296;
 Tue, 19 May 2026 12:35:18 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 7E1151D00085;
 Tue, 19 May 2026 06:35:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 19 May 2026 06:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779186917;
 x=1779273317; bh=1hKBOFjLxbCgWILeYEXHmG1Mll+CbCApQ4+QMa8YOHI=; b=
 as8Sj+TXVCOE77DRNhpNBDnBLF8FNDMrckljfsY2JGayOo2fqxnGJAsmTRaiFzCD
 IsGPuE+ye3BBEFw1llNzTl2h6Qm5CzTWr30rGVfLMVTnXw/FLDd6JsT30uUkOD/S
 WJpuXyVWz9iQeLdE7jBjWZtstiaJefvVCHXcG4bXzyJBn7JlPoBss3yO4h6b6yyU
 A+iYJvotSjZu+YscfOTW5AX+ewsNuOFNkHdlTp3HxvkaX0FOvIKnRlaf1Jl4ouG3
 nyy7YpMsGqAa2CWB4I2vYgLTqcJXb/o2U4xM5tNxSwkSEsg9jXNDeN0hX3rJvsr9
 D9WVi6B2RffzjP6OcLjE+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779186917; x=
 1779273317; bh=1hKBOFjLxbCgWILeYEXHmG1Mll+CbCApQ4+QMa8YOHI=; b=P
 gnCaUU//7/5rLrYflYqoBhKy/bw4zt4+7VybrDpGxVkXTgTekka0Mvk29EQq4pi7
 qDMo9G3Q1VEuwrB4Dhmr5M2Z0NVOtmwIwHP2fI/+RPZTmEHyCSFTg05tJk4TTRU+
 9KGsGKOfgKMyg4Y8yg3m9XuSMHFV+L7ofYbWL/8XzQ6B6WK6s6FKeCgsGbbd36s4
 Tc7ZSypvxRn0JFhxrjyihekXaSGK5rQ1KMQi9O2WCA5OmrOop2m2LPrUgKyZdQOO
 nAniCVxgGSTF0CyVA/yfJWdWcQZkymlAv8wvAb7Etu38R3LfiFABK0xdquAgEAeW
 4ybq0wPgMqS0rJWGA6Dyg==
X-ME-Sender: <xms:5DwMag9J2IHzSXR3pR5O8Pod5P7PuTpIK20INgb4y44NrM9jVO7HWg>
 <xme:5DwMahrvivrvnp_OEd-BYl3yUwmgj36O8ypKbCTYJHLvbtQr1UK7oNfX4sTxBul9x
 LjVC0JPx6a-CAExdqc9BxvbbeBtbvqDNvMBA7HxHLi9-fJ9qNJ7sw>
X-ME-Received: <xmr:5DwMahlyKs5-yOW8yEFwB0BlRI_8Wqt1o1DyT60CFpH0pOn_8rDxYwscqeJfHxQw-1LneDGqs6x9iS9jg3exPf3nJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeduhedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrjhgrrhhrhiesrhgvughhrghtrdgtoh
 hmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhm
 pdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshhtvghphhgvnh
 esnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepkhhonhhsthgrnhht
 ihhnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:5DwMaghMEr9_tddtcwNh54Q-ALdiv0jcRyrYqsrvdUSQkRFTNpWp9Q>
 <xmx:5DwMahfqPBvpIAa8CrZt0z4M9bCmtEzNG-HFALzCw-0_8Hd1i3Q2eg>
 <xmx:5DwMaojFYfZsBZVNyrQRmsFTDv8k1117Hivf8uCudCKzNHLb31f5wg>
 <xmx:5DwMahwa7y7rUFE8H-xLqbXQUf4CAxwRthT7foe-H6B6xU9pPIBoqw>
 <xmx:5TwMasupZpD-hMcu4-xdbTg2sjbJgYahj56s-d1zZQosklBkUPO8XrqK>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 06:35:15 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Robin Jarry <rjarry@redhat.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>, stable@dpdk.org
Subject: Re: [PATCH v2 1/2] spinlock: remove volatile qualifier
Date: Tue, 19 May 2026 12:35:13 +0200
Message-ID: <2rJMwQooRL2VVZaxkrqBEg@monjalon.net>
In-Reply-To: <DIMJH4P7RJRX.3PUWC7L1KC4I8@redhat.com>
References: <20260504083714.2904729-1-thomas@monjalon.net>
 <agswGt0gN-edMzjZ@bricha3-mobl1.ger.corp.intel.com>
 <DIMJH4P7RJRX.3PUWC7L1KC4I8@redhat.com>
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

19/05/2026 11:17, Robin Jarry:
> Bruce Richardson, May 18, 2026 at 17:28:
> > On Mon, May 18, 2026 at 05:25:43PM +0200, Thomas Monjalon wrote:
> >> 18/05/2026 17:14, Robin Jarry:
> >> > Thomas Monjalon, May 18, 2026 at 17:07:
> >> > > @@ -246,10 +246,9 @@ static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
> >> > >  	__rte_no_thread_safety_analysis
> >> > >  {
> >> > >  	if (--(slr->count) == 0) {
> >> > 
> >> > This code is completely broken. Any thread can unlock without any check.
> >> 
> >> Maybe, but I don't intend to fix recursive unlock in this patch.
> >> The subject is "remove volatile qualifier" (and unblock GCC 16).
> >> 
> > As with regular mutexes, threads should not go around unlocking when not
> > holding the lock. Therefore, I think this is fine. [With regular spinlocks
> > we can't check since we don't track threads, therefore I think we just need
> > to assume a well-behaved app.]
> 
> Ok, fair enough :)
> 
> As Stephen suggested, maybe we could add some assertions?
> 
>  static inline void rte_spinlock_recursive_unlock(rte_spinlock_recursive_t *slr)
>         __rte_no_thread_safety_analysis
>  {
> +       RTE_ASSERT(rte_atomic_load_explicit(&slr->user, rte_memory_order_relaxed) == rte_gettid());
> +       RTE_ASSERT(slr->count > 0);
> +

OK I add it as a separate patch in v3.


