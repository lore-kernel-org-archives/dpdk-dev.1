Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4CBFED9EB
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 16:52:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6172402B0;
	Tue, 17 Mar 2026 17:52:27 +0100 (CET)
Received: from fhigh-b7-smtp.messagingengine.com
 (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mails.dpdk.org (Postfix) with ESMTP id 72E0040270;
 Tue, 17 Mar 2026 17:52:26 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 846AA7A0033;
 Tue, 17 Mar 2026 12:52:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 17 Mar 2026 12:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773766345;
 x=1773852745; bh=y6rkcCeU3NDlmz1yBrb+5/nnq2nP4qjmWqOPt9WlfYU=; b=
 UnBObhW/3G67dYjJaDIQLpqj49GvuoJK2mNFXxkMTM2kNhtgZsnzxxWCOvR/yu+V
 PQAyLWbVtBEGcS3uuHQ2tYoVgChYm6VjI9FQJRyH2mU5s+odR4bg0mWDVTL7CfiG
 hNR81+HgQl4CnfprPK8sEfH0EwH/cGiYzi3io4E0TsxUf2lBYTq6Pvma1XgDNpS2
 RTdAlvrkDyp9MnHeGq/QHjaeRnjyDhfrsvIYADPhmD+71mw2/wOSkOzgzyyDkH/s
 EooL06rpA9AOKbv1WJG7DF2l7wYqx5tGtL1l3nVg4GBnKlKLsXEbiIKyYrk4/BT1
 QiyUlY5KmDVNqB+A2xqTjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773766345; x=
 1773852745; bh=y6rkcCeU3NDlmz1yBrb+5/nnq2nP4qjmWqOPt9WlfYU=; b=D
 SuFrmU4h04PRHpd/tQgYGYyNbDtipsb+z3LPHf2QWS/116r9umFw8x+n+AJheyC8
 IY2z9mhwOpzL2E5WgynMQapkSq9GFAXg/RfpjerOSDpTkdQ+J/OElJ7hRAkUP3Ms
 yh94mzTDcIZnvBf8wHmcV2M0lVJweCT+mLE7CLnudW4OKXszuyUmUb/8yTJhDE4a
 MAmnFRWcN2McH/KiATmsIFUH/LWwsNFeO4vBFsnf/zbSCtqGyWKr+erfFKWHzciL
 I4xMKZhAnwX7hjN4LbznNEkTP1vn61k349XtHikltL8D3koS29RdUt2COsM+ni4h
 XBNGWI0DHKVIWj6iipmBg==
X-ME-Sender: <xms:yIa5aayKtLKmwiuJuEES2hOMtMAgVM1chWgglFFFLUSklrPdOWKnzw>
 <xme:yIa5afPsAU71OuLkiZSGKasxpCAYp_AdFOB-0CcNeelXE8gNlZE_1Fj6XB2TS7yLh
 P6n2VrbfjVzgEHOponAt8o4YvO4cOfaKL_O9JXj3_vTYPZYkp3Jyg>
X-ME-Received: <xmr:yIa5aX598XHeQIQYS1L2Kt4mBx9QLjlxDOlu_B7K0jGZGTt_7EMVm4-EuB8BWk7nUPsSppGdhhF0Wx0V5cmVpERlMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddujeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtohepjhhinhhgjhhinhhgrd
 ifuhesihhnthgvlhdrtghomhdprhgtphhtthhopehhvghlihhnrdiihhgrnhhgsehinhht
 vghlrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvg
 hlrdgtohhm
X-ME-Proxy: <xmx:yIa5aQnkKmZRGh62hJ2_P-V-d21wNqCzWq0CWviXXb8oBZLDRGGuBA>
 <xmx:yIa5aYSIMliGi5vD1kJhDv8yxqu5G7MPtcU1GYnC9UOPFBDoOfnYhA>
 <xmx:yIa5afEnyCkpdkGvLMj0WxOJ0Ln6gsPt1d2qQ66k5sT6KnoYINR3Uw>
 <xmx:yIa5adFWvdTa1VyfTTt9Rmhxfyl8OctMSjYpq8xShqE5c9NhQSHjVw>
 <xmx:yYa5aerfDjcCdKhskYth3hatPeOqEDKDNxTi7nY8fsw3Hxl3u6fD0RFN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 12:52:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Jingjing Wu <jingjing.wu@intel.com>,
 Helin Zhang <helin.zhang@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] examples/vmdq_dcb: initialize all configuration structures
Date: Tue, 17 Mar 2026 17:52:22 +0100
Message-ID: <3023489.SvYEEZNnvj@thomas>
In-Reply-To: <aZbQ-QZN_c-35Muv@bricha3-mobl1.ger.corp.intel.com>
References: <20260219003354.83183-1-stephen@networkplumber.org>
 <aZbQ-QZN_c-35Muv@bricha3-mobl1.ger.corp.intel.com>
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

19/02/2026 09:59, Bruce Richardson:
> On Wed, Feb 18, 2026 at 04:33:54PM -0800, Stephen Hemminger wrote:
> > Replace field-by-field assignment of local configuration structures
> > with designated initializers. This ensures all fields, including
> > enable_loop_back and any padding, are zero-initialized.
> > 
> > The Coverity warning was always latent; the earlier use of
> > rte_memcpy() was hiding it from the analyzer.
> > 
> > Coverity issue: 501603
> > Fixes: 8cc72f2814dd ("examples/vmdq_dcb: support X710")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> > ---
> >  examples/vmdq_dcb/main.c | 31 +++++++++++++++----------------
> >  1 file changed, 15 insertions(+), 16 deletions(-)
> > 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



