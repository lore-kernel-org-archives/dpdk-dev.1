Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C484109B461
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 12:53:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B6B74042F;
	Tue, 31 Mar 2026 14:53:40 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id E1D00402C3
 for <dev@dpdk.org>; Tue, 31 Mar 2026 14:53:38 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 90F281D00126;
 Tue, 31 Mar 2026 08:53:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 08:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774961617;
 x=1775048017; bh=cd8vN1lVJmCS2yaqVPYRPEZdawRT4x7YAB6M6Bszpz8=; b=
 ezULhx0+WOsr9kNyjqOGWeE7507QbBm5E2qKwwAvhE6Z/cWApNtEtKiu9nfPNV3D
 tylwG+oK5ySAnL2BIw4d+sUYGysZORS8pf5GefhWG+ANSQR8z/xQMSquuVWyb+Bg
 67vBwJtQvmQBDf5n6ed5zVAH3+HMwZ6e5zQDzPKTH+Ugkpsm0PEVcSZjUtQmtBWu
 1E95/2mJbdL2vWPEIkZJQn9pB5dFUjdw4sd+aZv42ErnkxOOEBX1BhxiePxRbBI+
 +OJ0yBE1zZEGTFdHWRqmCa1RyvDXXCe/e8q8eUMSviym5aC0N15PS8uoDgt5RUwM
 KiV7Hs0LekH52Gy0LG7x7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774961617; x=
 1775048017; bh=cd8vN1lVJmCS2yaqVPYRPEZdawRT4x7YAB6M6Bszpz8=; b=a
 xhE51qgkGAS5RYqjtHci86mfeIzFygWtcBrA50snYYzT0NDGQDlJX0pmERtVzdlH
 QdxXB0IBW5szTvXgpiEI4hzFT1oLnp6urXfu95v60f6CUIKoROh5+KbZ0LK6OHuX
 GvBRH4Z9BS5sboDbSNwJo0/rFFXIgzYVx29PvEi5g+9KXrYtKbfsfgLyx4q1VUD1
 uWsvaF1G8Y0Xf07nvQ8oYRUDB3nVbKz00f+xlHl1wxdbcjp48S9S7TjQ7GI8Z9wN
 y2eDVP8XAxS8jDeai42OdD++1BarqPvea8mO8Op8nh387u4S2PXpf3FcHDe96HHg
 wSg3pxsHXIzQ1/gEPBrgg==
X-ME-Sender: <xms:0MPLacYC34dmXyrdzDfOAMOYm-1fvzoxmzH1M7MqFxlbQpRmbJWYBw>
 <xme:0MPLabv9kRYpg4MpgMoalB-WGTJmlNZWrj5GNdcAp6odp4tdk7qPYH3Bv8IyDZ1DD
 HvwlfuQGnc7AwZiotW24LNPrJ4qFow01SYMptTDYp6kWqBtbmdQ>
X-ME-Received: <xmr:0MPLaWG9F7TRBgF5G9ji81sx_revZNQpeO-IlFKFFoZiAZEmm_a2nMP-Eo9Ems8bNvlPpZFinLsJkBvR1jtk3Uvm-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
 ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
 fhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofho
 nhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrth
 htvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfef
 keejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepth
 hhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhhouggv
 pehsmhhtphhouhhtpdhrtghpthhtohepshhunhihrghnghdrfihusehjrghguhgrrhhmih
 gtrhhordgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhtvghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhg
X-ME-Proxy: <xmx:0MPLaey_fmfzs8BlIAxdd2dNM1iytsBa-Gn-LtUejJkoxnjLiN9DxQ>
 <xmx:0MPLadjHc7tReQiSdP4W3Hfac_YZPnMekK2a_XI2ok-IXk8u3ckEwQ>
 <xmx:0MPLaZyqwknQuITXwcaHgnCyDng5l06CdUhjzqFmZnwAW1Qe0bLZcg>
 <xmx:0MPLaQJIXEfM08FLgG-FdbTNFZDolRO9wYRxFiSliLshSIGSoHbLgQ>
 <xmx:0cPLaSyiHR-UOJ1zjNwIPSlJ97SuzoW39soXqrwMPGH8fdguE46H_YNl>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 08:53:36 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, stephen@networkplumber.org
Subject: Re: [PATCH] doc: flow-perf: document the --query-rate option
Date: Tue, 31 Mar 2026 14:53:34 +0200
Message-ID: <6009025.DvuYhMxLoT@thomas>
In-Reply-To: <20260113025738.33944-1-sunyang.wu@jaguarmicro.com>
References: <20260113025738.33944-1-sunyang.wu@jaguarmicro.com>
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

13/01/2026 03:57, Sunyang Wu:
> The flow-perf tool already supports the --query-rate option to enable
> query rate calculations, but the option was missing from the
> documentation.
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>

Applied, thanks.



