Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CFECCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:38:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EC464066D;
	Wed, 12 Nov 2025 10:38:47 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id F3535402E1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:38:46 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 9C2B8140017A;
 Wed, 12 Nov 2025 04:38:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 04:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762940326;
 x=1763026726; bh=1ntOq0XB/g7NjWD7+SBDVh5cIv5G5aPREgFYarQzFTU=; b=
 pcLHgUfqFZQ1wND1Uuf7YeaVkayBszg2VPBcwSN4h+psPoNr53qofrF0sLnkiFLn
 gPi9T7hnzStruG6XhC38FsXIgK7JlAJymMqXyH5j2FRG084EeFZ5wPOzIEf8uxS/
 BrnwrbQbHk2NGLMy/2NzfNxFVKyrZoZR6S1McXkB/Jp2YgPoEuJiFq2zd174w+lW
 +n+6EjTJuZfArlz4/WXvmtwEqb9p1JJvTwrsXQFX5fURunh1JcIsB9phEfBnnyJM
 8r+kw0+Qd2gZ+94t7fNPDQKrAvwGRo0ytSKmxZRrToSCDBYfKxOMlmPuUZpYIOee
 iCwj6hXjokGaybFBSkuJJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762940326; x=
 1763026726; bh=1ntOq0XB/g7NjWD7+SBDVh5cIv5G5aPREgFYarQzFTU=; b=f
 7A08b3gckdBsTLW69ivbSxFw32ZCpO3HbRkI+jscjFXsTMxwbSBTzuUijoWKnVgi
 YGQiQWs5cTGuYOzlY/1QaoQmt02c0azWMKq6ilVkT2G9io1vOVsY3Ag2KxX/zyrG
 DctRK+Os409o5Wn8jR+9XEvzb1+fRirCsY2l/hlwhJ0mxtH0tHIuQ+qtTP0jXGlB
 6LpihuunRbSQoIeEoStldPkND6gi45lnVLxCowDJ5++2ukf6nnfNN37b0r3Kdqh9
 itBW0dtuxEBaVbkwWaC8qT9NULBAAa0K5ZQLEYhHaFrYSk7A6aL93kLMPV3ZCrT7
 uiUCcaEdsnYv9WVhKBOXA==
X-ME-Sender: <xms:plUUaWKbjRfzhXd_0vbnrHkJfFE799QQw7Xszwj2rF5aoaq6ZmYuOQ>
 <xme:plUUaZmC08mAuf5UkPubYs43TxOVw0dyRRCWQDoAK3GEjIRCT6NvIrVA05r_6LnQQ
 fd7GXPM1eLhsnVBMv0_S0NLHK1a1VhzWU9T1U4r0DYuKlm8w-2jNH4>
X-ME-Received: <xmr:plUUaaMkW5HQbsalHdw80vjp5k-nRjvX7n-0dCU9shxbEmekm9z6DHHu5ECR-nkQYv1bWhh1_D43mckOeIdduMPqMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefjeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:plUUaf3xKQJHhRLXDt1GqDXArhUCHh4GyJ5A6Qf0YM8n1qTfvhB3TA>
 <xmx:plUUaZnpk7kSA9pvTglgpQmGHIbcQpOYa4JHG5QyyGCMab13bNpJTw>
 <xmx:plUUaWUWh3Tkcx3lFn3ztzRmbk-PsCvdnN_v4couT4OoKp4YQ1ZN1A>
 <xmx:plUUafsD1WsAiUSy01A_9WEFIGUJV74e6k90smQIelQLrnlMa2QcqQ>
 <xmx:plUUadm46DCeqUKN_sarfKiZD72jutwEWasbkhoydbKP_WWWwvcN9uAC>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 04:38:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH] license: standardize SPDX tag for 3-Clause BSD
Date: Wed, 12 Nov 2025 10:38:44 +0100
Message-ID: <7067595.Whz1cUOskA@thomas>
In-Reply-To: <aRRT31JDkFl1hpsI@bricha3-mobl1.ger.corp.intel.com>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <aRRT31JDkFl1hpsI@bricha3-mobl1.ger.corp.intel.com>
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

12/11/2025 10:31, Bruce Richardson:
> On Wed, Nov 12, 2025 at 10:13:35AM +0100, Thomas Monjalon wrote:
> > Make sure the SPDX tag is used as defined in license/README.
> > Reduce separator to single space.
> > Use parenthesis and uppercased "OR" when a second license is applied.
> 
> Upper-case or is fine, I suppose, but I'm not convinced we need the
> parentheses. However, I see other drivers tend to have it, so let's
> standardize on that.

I'm not convinced as well.

Looking at https://spdx.dev/learn/handling-license-info/
it seems we don't need parentheses in general.

Also we should improve our script to check SPDX tag.
Stephen has a patch already in this area.


