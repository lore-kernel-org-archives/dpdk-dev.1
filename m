Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F310EF5867
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 17:28:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2849940662;
	Mon, 16 Feb 2026 18:28:41 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id D036B40289;
 Mon, 16 Feb 2026 18:28:38 +0100 (CET)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id B0CBE1D0048F;
 Mon, 16 Feb 2026 12:28:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 12:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771262917;
 x=1771349317; bh=nJCQZXKU20E8vJigR9dnT5JJde1So8L4jkRpQfJYodo=; b=
 YiCU4ZqFd0UQovbcFpzK2QjILNeNECta8vKiPWHZqKjQXIpd7YUnwEWer0EedONf
 a7Ly4hN6FZkHqTraRD/yPeMgaJuqKO28EDLdjPoeZT5QsZhDS61SbTTh4wYokv66
 XIC4vhILP9JhqIwIfKouaCCA6DGQJpynSOg3m3JahNwV9HZGNmB+oKHCnhcva20P
 x98yjRkB8Dj/SzwBR24yETcuChkm2qqTNhQVKIy6Vhi0uPaNq1MIZA6M/UwbV29L
 eX3RFf/0S0ncmtMnFq9kX1TXnDXAGs3rC9Fk38HZuzAfDoIM3wI9WheOMlC9QOGK
 GQMcAhrN1ths+ZIDcLJ0aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771262917; x=
 1771349317; bh=nJCQZXKU20E8vJigR9dnT5JJde1So8L4jkRpQfJYodo=; b=p
 9cFRivtVFuv8usNlxVWhBUx+Ol+QZcRbCUzPcooq1AjnODTpNXcl1tPhxgPHnXWW
 Lf/hHDTXvT0v4qH+4n1IW4uNOJDBmg9DDx5r7s+lIg/aYGJLXng5BCbjEAV5UO+3
 VSu0q6T3eqQN5HmKedId7oKSrxtsRw3CKsLaS4NJkhzwvFTkvuv+SkJ8gK7qocHS
 lbjj6gPm/3bKWpi0HGhO7+h8cFK7KeGSIEvTC1QaruEAQpzEcwKD1GG2iRAUQQ1p
 3W9+S0Jo1H2lqN9Bv8LuYcSuVW1T17+WAz7cU43YiZU2tfEtOPFLY1Ar1cDQaey2
 GrRAaxd3fwe1ozBkAX/Pg==
X-ME-Sender: <xms:xVOTaWI-3S3W3i0QTSZzl3VX8d0b7yGxfH2H_1txkGnDQsMWG6d_3g>
 <xme:xVOTaZG6x1phAZ2eLwZg5I5IFnK6-zuVFlRWoNCLzNoih2nyYqmegMFf9fuGfq3Ib
 _iXHuTiXkkeL_oeeJ1ikbEAKvhsXKPzQOUDy6LcdoTP13pl4dKofA>
X-ME-Received: <xmr:xVOTaVssXeLCXOr6OrDV5pPl_6YYY40V_Qri6jV0dhQBv50HcWQhpJtFKPW9ZhHRLYxlU0bPmC6GQUR5_0vGe4r7PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejgeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepshgtohhtthdrkhdrmh
 hithgthhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrlhgrrghtiies
 ihhnthgvlhdrtghomhdprhgtphhtthhopegtohhnohhrrdifrghlshhhsehinhhtvghlrd
 gtohhm
X-ME-Proxy: <xmx:xVOTaQupN-RUKIz7oxNuvao31M7pMGuG6i-gftSOp6Qk-wc0HOaBXw>
 <xmx:xVOTabC3-ng5QiWrigOKiXB_tUgrWGpD6yM_6pQJmiB6wOfqFyr0Vw>
 <xmx:xVOTaSPEt0gOPOceBFPGLQd4KHPhYqkl5kN-GTXjHWyTGQKBNkd0YQ>
 <xmx:xVOTaUzJboIpB4rqrFoByInavZVd6Yf8ydWawXs_KZ90Y6uKLRNfMw>
 <xmx:xVOTafMmWSafNEGlDNdlTbdSD7KXpSgvt49Qv5G2XrwQVELXInen0-AC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 12:28:36 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, scott.k.mitch1@gmail.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Conor Walsh <conor.walsh@intel.com>
Subject: Re: [PATCH] dma/idxd: mark portal pointer as volatile
Date: Mon, 16 Feb 2026 18:28:34 +0100
Message-ID: <5971878.DCG2G0Ltq2@thomas>
In-Reply-To: <20260126101357.2770431-1-bruce.richardson@intel.com>
References: <bug-1871-3@http.bugs.dpdk.org>
 <20260126101357.2770431-1-bruce.richardson@intel.com>
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

26/01/2026 11:13, Bruce Richardson:
> The portal pointer for writing descriptors to the idxd device should be
> volatile for consistency with how it is used. Only time we need to cast
> away the volatility is when unmapping it.
> 
> Bugzilla ID: 1871
> Fixes: e888bb1278c6 ("dma/idxd: add bus device probing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



