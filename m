Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FFEE6E80C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 11:08:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD63C402F1;
	Tue,  3 Feb 2026 12:08:53 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id B9627400EF;
 Tue,  3 Feb 2026 12:08:52 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 666551D00151;
 Tue,  3 Feb 2026 06:08:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 03 Feb 2026 06:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770116931;
 x=1770203331; bh=f2dNdDnjq0eIMy0t9oZ2yo1tKN2V4LW6+Qc3mat5mBE=; b=
 a2ggRD6a8hkMGBhC/fZVVxxLId3GEtTDHc3cqhRc6FTLmRa0l7tv6IEnA2jF5ks1
 rD8c5fCYNdcWLOvF+rt9Yj4X2aZwe0/HZSK0WOIqWe4rO0ESrMhW6btRIRBLoRNu
 0F9ObVREeH4mGPN9cjhntw3LGLS7z8btKg52RayyWhWLOmsP7g4oGvNPTIeWzwL0
 QCPwk/X0jNxt9KBcZfCK3pjxJE+LdFthjicdew/1Odh2U65iDHbf59KKp/clcROH
 tGn9Wfe/b7AW7cO4Ztj1QpjbYmd7x/6XUX+ZgpuB7mhUsAeNGoVZtDM4vujhr+LP
 yj9oaiW3NUw6UNOhVoTnmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770116931; x=
 1770203331; bh=f2dNdDnjq0eIMy0t9oZ2yo1tKN2V4LW6+Qc3mat5mBE=; b=w
 0iXVAsGUAogKLN4l+RQ+lpub8nEMQtSJelp10yD4jMEeFd+FDmb9N5ZYeNnmdjW5
 lsCMJS5AsjybP5OWZVxi7XljGYv1zq1ESnTVPaHGcSlKascWx4XIDz8zoPoh0LpK
 Mw4J1rLjLI/DxtzKdMaCRhw0dUKaX5J47egXp+6DGc4+h2ayGXgOZyxqA3uuqmQ9
 yRFj08UYY1qtgeZB9h1v6Y0vw1XjOHqtBDm7C/VDlZWQYMFrZ5yGldHqGgN/h10Y
 74qnqlLcWDUKtybkbEs9ovA/DSNBt/hz9FFtR6JaRgNtRiVq+iQ4Fn6paVycfZqy
 Y+F1RrTsP+0oeBoVAnwiQ==
X-ME-Sender: <xms:QteBaWlOE-KZ88zbEPSw635AABhdIU4QdTBtScqZtNF1tA8ALDC7wg>
 <xme:QteBaVcUUWX-nDY_k70y4HK_Msb_CbYsdNIJEPxyGbK9-ay8yEuxTaOLAXAwbwbo1
 l7xKF_8qq32a2R1cSZYe64yvl6R05TJLiIQ5DppY6m81aZdMCqvKA>
X-ME-Received: <xmr:QteBaSTOaLxeQeSkF9xYvzh96Ld_nEIiRiq7X4BQQKm6S01Oy0q0CbG0TfVXCFG0qRT2xVWWfaDJRDxvColXpjeNzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehrihiiiihordhunhhiphhisehgmhgrih
 hlrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshht
 rggslhgvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgush
 honhesihhnthgvlhdrtghomhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghn
 higvvheshhhurgifvghirdgtohhmpdhrtghpthhtohepshgvrhhgihhordhgohhniigrlh
 gviidrmhhonhhrohihsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgrrhhrhidrvhgr
 nhdrhhgrrghrvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnh
 gvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:QteBaUvbkDaEo3itRyyHrzq3CXFSKCh1t88u3kDO1QMIizGiUYMWuQ>
 <xmx:QteBabfevwhHTJDUXA0sr5xa3ZFfge9UECRmkbNm4v0BT5V27DfXkw>
 <xmx:QteBaWbMvEamgtK-y1z5NwpOGD8ZPoa3cYJlV1UrduMXXk9jLCgggA>
 <xmx:QteBaVapxoBzaN-v7jOnNzsNpUnWCFKDslhIXSJfd6QKuwtSrniEoA>
 <xmx:Q9eBachyH7XSqnoPboXGPWc8d9EJBi6_AwdG_eUT3497KpsxEKuMH7R->
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Feb 2026 06:08:49 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] eal/x86: fix TSC frequency query
Date: Tue, 03 Feb 2026 12:08:47 +0100
Message-ID: <2922341.PYKUYFuaPT@thomas>
In-Reply-To: <20260130101506.175ca913@phoenix.local>
References: <20260130171026.277418-1-thomas@monjalon.net>
 <20260130101506.175ca913@phoenix.local>
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

30/01/2026 19:15, Stephen Hemminger:
> On Fri, 30 Jan 2026 18:10:26 +0100
> Thomas Monjalon <thomas@monjalon.net> wrote:
> 
> > After getting TSC information from cpuid instruction,
> > some values must be multiplied and divided.
> > We must multiply first to get the most accurate value.
> > 
> > Example:
> > 	before: 1000000000 * (23 / 10) = 2 GHz
> > 	after:  1000000000 * 23 / 10 = 2.3 GHz
> > 
> > Bugzilla ID: 1869
> > Fixes: ad3516bb4ae1 ("eal/x86: implement arch-specific TSC freq query")
> > Cc: stable@dpdk.org
> > 
> > Reported-by: Luigi Rizzo <rizzo.unipi@gmail.com>
> > Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> 
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>

Applied



