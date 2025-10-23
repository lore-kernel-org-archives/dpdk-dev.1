Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A389CCD1BC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 18:52:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D40D040151;
	Thu, 23 Oct 2025 20:52:41 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 5863A40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 20:52:40 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C85C6140008F;
 Thu, 23 Oct 2025 14:52:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 14:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761245559;
 x=1761331959; bh=Tr3LYQg/rCOk+2foguW6pmlvRtjzGKJboqlXT1oFzz8=; b=
 Dt+E/n1YhKGENbwuUsW83D0BlQCl3nwusigtRtSpmIDyGb6GESG3BbI2CoXJZCad
 Q7Z/xej0zvzqUkMkxyrvETARqddoHkYg8cFewvkBYRoLbNNJpZsbo0U2c5Jv5hbV
 G+MkrbOYpLSF54dGiDsgi3QcLShsR40s+wvKZBsNCapPZYmGAYkkw/bdMNadiRQm
 X5eLzyyfFN2J4Ypp05ZPCa77pplkTeS8VV1+BA+H+bQuirJFibl7O43p7pE7kdv9
 SyRm64/0EhiOw9CX+cbZV6hbK8et/CyxB9Jh8DVoG6xOzI/m6zJFHscMw8afEDS7
 zppojLQ+HgSzvyAzV/r6ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761245559; x=
 1761331959; bh=Tr3LYQg/rCOk+2foguW6pmlvRtjzGKJboqlXT1oFzz8=; b=x
 vFy6QS+uQ4lHPJPf0OesSjbOmCha/8+nmiyGps+sZwM9HydjX/S5bnzrpW8A1XFU
 nkOrpGv7g/8iVRKwof7fDuDUBq/kg9iR3RA9P2gCo10cb0Zg61v3kvEfxRi9VBu1
 UAI8FbZdI1qcYwfcQrKPUnJJGk7NsTk9dR/XaUw5Sw+z30LGmPxzNIWVza9TAMG6
 MVpM+JUfC7hXm4EFQZTcbJbMRGGkDlST3xoW4c7nwf4xD4cfi/XC//Aa09z3k7/H
 qMv9/EZ+BLH7lgqXxr7aDa2dbT+OdGhAZuTSklQJMsjCsT9zXtrQNs3W3R+EdYB0
 5ufbdZD+JgmS1YX+lsVrA==
X-ME-Sender: <xms:d3n6aO2MokP_V8Dcw1KlMoooAbsCUEvHdKCwhwWRhrPtQ9iVN3sMsA>
 <xme:d3n6aKBIS0vP0V9PBw2li8nANCtFp_ErmkVBByPsSFcitP9GiD71xL5IjfjNwl2pq
 -glMvZuKKcGteWnVXSo7Od6B4EhuSnHn7CGLRG86FefFa7FA0h8>
X-ME-Received: <xmr:d3n6aCf0Brz6R6B4O7iPif4giL657DdEWCB7di2A4KCFvZOPisXxhVTdbxPkTBtZS31WlrEtK7iS9q-p2q_FsU9mxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejvdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopeihihhpvghnghdurdifrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrg
 hmvghhrdhgohgsrhhivghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdr
 rhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepvhhlrgguihhmih
 hrrdhmvgguvhgvughkihhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:d3n6aP4_tivhrZH1YRQ88Jd1-Ky4uBrztiUfEzaRNM0fHC7BwLOTKg>
 <xmx:d3n6aNXNAuXafd5HMFZ9nq9kaEs_OIMZ-Mf-vT4I86PazYB_C87R7w>
 <xmx:d3n6aG5xaGHuG07pHpWO9Gmo2d1vDd_OrhHu8iuDl2WA7WRIldhW4w>
 <xmx:d3n6aArvPqvBVZ3nwroo-KbH8u4AlHThh0wSyn8JHGXWOB9HMfyNLQ>
 <xmx:d3n6aCPZDU13iitnQcCs7B8ouBCGVd77iQKgtIVB9iRZGBt0ghpowHEM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 14:52:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 0/4] Cuckoo hash optimization for small sizes
Date: Thu, 23 Oct 2025 20:52:36 +0200
Message-ID: <2964145.MzOyzyC30C@thomas>
In-Reply-To: <20250916150219.104936-1-stephen@networkplumber.org>
References: <0250818233102.180207-1-stephen@networkplumber.org>
 <20250916150219.104936-1-stephen@networkplumber.org>
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

16/09/2025 17:00, Stephen Hemminger:
> Recent discussion around handling small keys motivated furthur
> examination of the compare logic.
> 
> v4 - add test for more sizes, and a few more special case sizes.
> 
> Stephen Hemminger (4):
>   hash: move table of hash compare functions out of header
>   hash: use static_assert
>   hash: reduce architecture special cases
>   hash: add support for common small key sizes

I really would like to see a review from the hash lib maintainers.
We need at least some design and performance considerations.

Cc Yipeng, Sameh, Bruce and Vladimir



