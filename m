Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2FACCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:26:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FBAF4026A;
	Thu, 23 Oct 2025 19:26:03 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 9908D40144;
 Thu, 23 Oct 2025 19:26:02 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id E766EEC029C;
 Thu, 23 Oct 2025 13:26:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 13:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761240361;
 x=1761326761; bh=EN7mTSlM+HZulYY5KQJYglP9Lu//aTVQRYGCnQcjSaA=; b=
 JnSTHHCoj4HoTMgfSasw9gl1LBnhDeFF/z059tlqI6JTF3byYOzBp9MzRtHmnAkg
 J2LGOlBpmBM7Jo1W9RTNofRFdNbLIf55P3DyxzCLbY87PhW+6jKwVDoSxgMJPQ5Z
 ujoZIdCj3XTCkBUYTxeJZ8D771eUS5beqKEggkuYEeiMe48FT64eOEfsnxWWwTjd
 XEsOUkzCKjhl7OqwYX/6JnELMGo7lmniXlD9uEhAK8Ir5VXy3DZ7mY2Qlc3WJw7E
 ZBZR8TlbYJVWJ35omOePD+GhFjVWiE0wBfjJJ5C1G5YYzEmXwwnR6CuQF0CD89cN
 ZRGukXtfYui1FlRFGSu/6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761240361; x=
 1761326761; bh=EN7mTSlM+HZulYY5KQJYglP9Lu//aTVQRYGCnQcjSaA=; b=i
 kqNDaUNTC1c6jttj+2OJEJQQC1WVlBXi/AXSjs2IH8YxvcUy1SgHpiPRLJJqKTXS
 WovvkaMVqrVEt2obLndPIvhnxOuOXpG2iBS8hzVTnaWsGA1PFrsLVVThlAarTwxM
 G6tTc1TSiCW7jdPG/5//AyGhiYt4npbmi0KAi+NypK1PARbifhuHoki5ewsD/jkW
 PBiZEQSHKWIk4dEo4B2ZcfSPxYxuoMp0BfLu3PdQ2HhdyRw8KrP51oO7LbSuHkuT
 +r1yniNTjvrott6BJv9Gs4mImbvp990GYVrO8UjGkC1XSESw6oQos5Jf5/P0JORB
 BuSGOVwmt5xov8VSUbTzw==
X-ME-Sender: <xms:KGX6aHdJlRxHh0g-fru9TJVUtyxtEHTP8eWVMihK3ESuqyTzvNGdoQ>
 <xme:KGX6aN6f9MVvhcD10XnRQK2RUGLjn4Ai4QLcsuVmBmjFsBUxAYMi4Fq0a3KFuT4C_
 coC37Q8S4lvvq-ArOi3ObtjuazNj8Mjds1cU1tGdQcyU0IuZ4Pu>
X-ME-Received: <xmr:KGX6aOtZJj1kqD9hSDxPxQ2MAD6ggUOOg0sfIyVSXJNfsb1ojdmxKg3obeD055cma_gmPgnqTQsuvL-mbnlFkdFImA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejtdeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeegtddtleejjeegffekkeektdejvedtheevtdekiedvueeuvdeiuddv
 leevjeeujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghtthhirghsrdhrohhnnhgslhhomh
 esvghrihgtshhsohhnrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughs
 ohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtg
 hpthhtohepjhgrtghkrdgsohhnugdqphhrvghsthhonhesfhhoshhsrdgrrhhmrdgtohhm
 pdhrtghpthhtohephhhofhhorhhssehlhihsrghtohhrrdhlihhurdhsvgdprhgtphhtth
 hopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepmhgssehsmhgrrhhtshhh
 rghrvghshihsthgvmhhsrdgtohhm
X-ME-Proxy: <xmx:KGX6aNjKDn_t4PLw7DWiXJOYQ9Zxs6fbTvVKhJg2t6IPtUHoCoDYQA>
 <xmx:KGX6aJrJhCb3ulVb_WQPRc62rlCDlb6fnR2LUO1lAJXoafLRHYdlPA>
 <xmx:KGX6aKstC6j7yyoAXnLjvI6djDCdkzFNx4gTBlPD3zNpZg_veiHq6w>
 <xmx:KGX6aMbR-o4cX_jhSJvsADt6EFV3XHALorahzV6KzJe0DS6uMKfWJQ>
 <xmx:KWX6aN7ZJU3flcUSpN4yUUFCa2KD7bVNCAf0-tWPmRXg7hHtBYSXX2Wl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 13:25:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Mattias =?UTF-8?B?UsO2bm5ibG9t?= <mattias.ronnblom@ericsson.com>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org,
 Jack Bond-Preston <jack.bond-preston@foss.arm.com>,
 Mattias =?UTF-8?B?UsO2bm5ibG9t?= <hofors@lysator.liu.se>, stable@dpdk.org,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Subject: Re: [PATCH] bitops: improve power of 2 alignment function
 documentation
Date: Thu, 23 Oct 2025 19:25:58 +0200
Message-ID: <2357650.d7IHhHJzqS@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FDBF@smartserver.smartshare.dk>
References: <20250722075321.121254-1-mattias.ronnblom@ericsson.com>
 <aH9Ob8sReOBJw-yv@bricha3-mobl1.ger.corp.intel.com>
 <98CBD80474FA8B44BF855DF32C47DC35E9FDBF@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

> > > In the documentation, make clear
> > > rte_align(32|64)prevpow2(<n>) -> <n>, provided <n> is a power of 2.
> > >
> > > The original documentation stated the "previous" power of 2 would be
> > > returned, potentially leaving the user to erroneously conclude that,
> > > for example, rte_align32prevpow2(32) -> 16.
> > >
> > > The rte_align(32|64)pow2(<n>) documentation, suffering from a similar
> > > issue, is reworded in the same manner.
> > >
> > > Fixes: 08f683174e94 ("eal: add functions for previous power of 2
> > alignment")
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Mattias R=C3=B6nnblom <mattias.ronnblom@ericsson.com>
> > > ---
> > Much clearer, thanks.
> >=20
> > Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>=20
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.


