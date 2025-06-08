Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC72C5B552
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 19:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1477402EF;
	Sun,  8 Jun 2025 21:57:26 +0200 (CEST)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTP id D25564026B;
 Sun,  8 Jun 2025 21:57:23 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 2B195114010E;
 Sun,  8 Jun 2025 15:57:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 08 Jun 2025 15:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749412643;
 x=1749499043; bh=ZSSIkynU1tJ90wUAhr/F5mYx69nbVrUVqdSuxUTimko=; b=
 gCk/fjKQKBb8LQDd2qwj5gifl1s7S9xt9KigysBF1/CgNdSrTJGZyQ5RXRqGT4sn
 fswH15yaLxayET/T5gEi29tBgWoi/QQjoP6NReBSm8Y9wIgCykfKp0Mjjt4uGvv4
 vCImDZ6T9+atUhmAgCBF1wR2Nq/qC4uGq5BArxBCMt/J5UX5+nGY0nLVEZj2oE8u
 /MXySQM5k34NRxIXcnOk7WmjlPjcKw/dZwHPLs0gON0A9P9zzd+JZrHX2YW/p/KL
 0WZfz2EH33TbXJPvzIFNE03KAwOYTDCiIcfPJ0OQtCsq2x3c3ydKh9rDDCwI6P/B
 owtPzHM7oVYLp3zkhJjKzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749412643; x=
 1749499043; bh=ZSSIkynU1tJ90wUAhr/F5mYx69nbVrUVqdSuxUTimko=; b=o
 KqrFfxcX601eG1xBQ/0YnShe8eNz7QsfGFC0vYdCQ/wIjFL+uHSMl8oK+DMyYpkN
 hSOE9/ziflrTLnwZcRODIPKB6FNI1Umnh4o4LOAvaUIDMEbDSem3EScXqh2P4Vf9
 l9R0AwYROH09FcpHcjqBSR1WwCZofvSaXq+iIQvpDGZoBjcmfnA8Gh8leEmfjCrZ
 HgmAkh6fC7hQcG3ozi+dmlD2OhtIIHNYYs+FyN6UH1OgqWKR/X27BHt+mI+zjVDg
 XfQaRpISqG5aZRhKFGHUd33cZB1Lm3gdIKGnOn6xXtpFvFh5b6aNtLtcx46sHdPV
 viV8J+VpE4E/pLyQ1e5ug==
X-ME-Sender: <xms:IutFaH-c6aTkVNSeIFb4l0Phcg1Q3I4Mr6coL1dI5GbXE1uJrUZJmA>
 <xme:IutFaDvYG8lCVK-m7tMS6iLY5zm4kjbFys-WXYpqH9mXbtZ_BXwK6NLe_tFNlD2nB
 yVyxOrsGMvLQwZjZg>
X-ME-Received: <xmr:IutFaFBr5ByUgTnx3YLNAF5Mr84O0wOMfESCDk2xcjiopsho-ks7a4eHxbSDx5QsEgW8BkA5NWgf7OyY_zXm87m6kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdekfedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
 ffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghl
 ohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnh
 epjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeugfefkeejnecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrg
 hssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtohepphgshhgrghgrvhgrthhulhgrsehmrghrvhgvlhhlrdgtoh
 hmpdhrtghpthhtoheprghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdp
 rhgtphhtthhopegvrhhikhdrghdrtggrrhhrihhllhhosehinhhtvghlrdgtohhmpdhrtg
 hpthhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthht
 ohepjhgvrhhinhhjsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprhhorhgvthiilh
 grsehlihhnuhigrdhmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:IutFaDf9ThhDl5SNddtgSZfeCS3_HJ7sOH2NIDNbTJfyIXUHeA5mSw>
 <xmx:IutFaMP-GK4pYidPhIfPix4-HJJf1TUSHglmfVAeu8fNBn4sWwNPJw>
 <xmx:IutFaFlHMgxN5HzIC9nP0gjl2zfR8DPO7eMQd-6VvgemkcPcNFIckA>
 <xmx:IutFaGvoK8Rk8-JsbOpiL6yAQoJA59r6f8plB3COw87mh1U--gFRqw>
 <xmx:I-tFaL2dsJde3M7i7FsSs4dqkiQR4sgiHE0TalhVqGTz4Z9edgoL1Oun>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Jun 2025 15:57:21 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Pavan Nikhilesh <pbhagavatula@marvell.com>
Cc: anatoly.burakov@intel.com, erik.g.carrillo@intel.com,
 mb@smartsharesystems.com, jerinj@marvell.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] eal: fix return value of lcore role
Date: Sun, 08 Jun 2025 21:57:19 +0200
Message-ID: <3958894.6tgchFWduM@thomas>
In-Reply-To: <20250520201726.7420-1-pbhagavatula@marvell.com>
References: <20250520201726.7420-1-pbhagavatula@marvell.com>
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

20/05/2025 22:17, pbhagavatula@marvell.com:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Update rte_lcore_has_role() to return false instead of a
> negative value for invalid lcore IDs, removing the need
> for callers to pre-validate the ID.
> 
> Fixes: b0a1502a277c ("eal: make semantics of lcore role function more intuitive")
> Cc: stable@dpdk.org

The API comment says:

 * @return
 *   Boolean value: positive if test is true; otherwise returns 0.

So yes we can consider this as a fix.

> --- a/lib/eal/common/eal_common_lcore.c
> +++ b/lib/eal/common/eal_common_lcore.c
> @@ -87,7 +87,7 @@ rte_lcore_has_role(unsigned int lcore_id, enum rte_lcore_role_t role)
>  	struct rte_config *cfg = rte_eal_get_configuration();
>  
>  	if (lcore_id >= RTE_MAX_LCORE)
> -		return -EINVAL;
> +		return 0;
>  
>  	return cfg->lcore_role[lcore_id] == role;
>  }

Applied, thanks.


