Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70124CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:43:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 964874068A;
	Wed, 12 Nov 2025 10:43:22 +0100 (CET)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id 8EFD44067E
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:43:20 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 0BCA9EC0114;
 Wed, 12 Nov 2025 04:43:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Nov 2025 04:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762940600;
 x=1763027000; bh=PEYnYCA0TvQHEdaMwsDzvaC+fkqbOKx2nOGloQJnEBw=; b=
 NpxUis+oRtvD91+w7dt5JBFTHOLsqRB/qO4fjScoNQgTzk3sGrIfzGO3E/bjBW/v
 EOS852GADRSFwLrOZ72ym1SCkjKwjV5Zxpm513NTlWL8RiHQIzSyPIHSA1T13MzO
 oe0kyiqs7bsCC/WIYKCPMjzV/0nAtgmZWtvagg51lepwV5vZRMZsOixNiWbiMCBn
 4nUsMahSHSIlq3vo87OaBr70X6ViP3leGWkN/V2IsDe10CrDBqgyY2yn3HnC7VIF
 8XOoPLQ41x0aSJMy7H0hk+wYRTq2QPs3+dAfe2pK7F4Gj4OamD9E9pkPF8NR5tie
 60u5SDXkb69fIUDr8cgfKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762940600; x=
 1763027000; bh=PEYnYCA0TvQHEdaMwsDzvaC+fkqbOKx2nOGloQJnEBw=; b=u
 U9J/rTW1bweTBolRN9eqEqekEoxzfKLyCFjTEWF2x04KP6+uAY1tibLOQYG8FHe2
 7bUN2LMFt+wTy/zvhqaEVz7qY4p8oQULkag7/RsX2rxuONUyvhBu37Z2fyLc5bjJ
 zAddO97BIoZc54OPA3tOj7Fv9H2mUqOny+CZY9AujCjlsK+aHm3bjHEHDHFEtOkc
 SVvjrYZg1Hmsv2NJgp02MSHaaiC1h1KEYTEgzoAb7w2Qju38rLkauYHoaByKyDEK
 t+aMApGGXh8xQwOx3/rqsAgxo1I7RocmVqn1MqCJciRJ+bAjLbg2IrB3HY5q1haF
 WvH/VcbpdLpUkPB/QTueA==
X-ME-Sender: <xms:t1YUafRdXxGT3tEqTxvL9AVtSUYnWdi_ca4VIaqfnpl6XGiq81e34w>
 <xme:t1YUacOGipf-SVi9cPUI7eBl9jkcD3MYYY7-o3iyDz4aRBRqUL8pIDFJiaQa6hcN1
 XzHoROY6vqDFtqJmgrO6qCaPQl1WeN4D5-QJowitNhiy9l4wcZQU_4>
X-ME-Received: <xmr:t1YUaYWmvdjD9CeL3pGBaTuq4sC7qer4ef7r5Vw8PKI2tELOQBgxm12O57O_wB4MB2sinyosSpzYv9BDDUpkj65CUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefjeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeevledtudetjeekueekhfdvieeileefgfelgeeiieekleegveelieet
 gffguefhtdenucffohhmrghinhepshhpugigrdguvghvnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlse
 hngihprdgtohhmpdhrtghpthhtohepshgrtghhihhnrdhsrgigvghnrgesnhigphdrtgho
 mhdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrgh
X-ME-Proxy: <xmx:t1YUaTdLJKCNM1eOvmdZuxRypIjDCW-wTlamiEEa83oatVlgvspFQQ>
 <xmx:t1YUaUsDznbhlsWZWu71K4pUrxVunXvTEnk6xUjsSvDxOYqHVr4_Hw>
 <xmx:t1YUaS_zcUVIZWGiGg5C3ly25iyRLQmpoSAt6FZSAd8VnDjjAg7jYQ>
 <xmx:t1YUaf2Bahg9GJ2rn6yxTjaJD0VGXc98BuF-Sg53ywfsDa3bdhMCHg>
 <xmx:uFYUafOWLafcxzhWly_hXv6n5UQs4WzpoKBHsW9L1menR2OqZBFQuPik>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 04:43:18 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] license: standardize SPDX tag for 3-Clause BSD
Date: Wed, 12 Nov 2025 10:43:16 +0100
Message-ID: <3883425.DVCPrJfaZc@thomas>
In-Reply-To: <aRRWWdQjWTodkYxG@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <7067595.Whz1cUOskA@thomas>
 <aRRWWdQjWTodkYxG@bricha3-mobl1.ger.corp.intel.com>
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

12/11/2025 10:41, Bruce Richardson:
> On Wed, Nov 12, 2025 at 10:38:44AM +0100, Thomas Monjalon wrote:
> > 12/11/2025 10:31, Bruce Richardson:
> > > On Wed, Nov 12, 2025 at 10:13:35AM +0100, Thomas Monjalon wrote:
> > > > Make sure the SPDX tag is used as defined in license/README.
> > > > Reduce separator to single space.
> > > > Use parenthesis and uppercased "OR" when a second license is applied.
> > > 
> > > Upper-case or is fine, I suppose, but I'm not convinced we need the
> > > parentheses. However, I see other drivers tend to have it, so let's
> > > standardize on that.
> > 
> > I'm not convinced as well.
> > 
> > Looking at https://spdx.dev/learn/handling-license-info/
> > it seems we don't need parentheses in general.
> > 
> Shall we just avoid fixing the parens until we definitively decide on that.
> Just standardize on spacing and upper case "OR"? Whatever approach you
> decide for this release, you can keep my ack.

I plan to rework this patch by standardizing without parentheses,
and add more checks.


