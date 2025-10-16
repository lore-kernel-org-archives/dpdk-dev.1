Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD1CCD19F
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 20:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A18A409FA;
	Thu, 16 Oct 2025 22:02:40 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 1528B409FA
 for <dev@dpdk.org>; Thu, 16 Oct 2025 22:02:39 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7491114000C9;
 Thu, 16 Oct 2025 16:02:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 16 Oct 2025 16:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760644958;
 x=1760731358; bh=psVYZCYKNsv5UHoD1HUEzHcxnp5Ilt0oHPa8yao1w2g=; b=
 PDWykVkWvbwsHrbenw6TKOm49O/1nM2RMdFknHrf+0iYwep7sohPrH0TORl13rb1
 Zt2u21SDivrmN4DF4Z9U9NOoBIxDX5wPND+ESAH80E9B59jIliZnjLJCAOpGDngJ
 rwzczY1p8dNNgQeR3avH2fbPMr/roIx41ACbUD7Mz4OXdWZ8Q+NLfReqrv4YDJd8
 d8whKMZGselVqY+dFDZh/3/GuruqA1efvkSjd4I7dTxrv/+rLDPMLXXvvXdWIadA
 ZVP/sAzMCz6XKpLGbQkfWhIw8B8BVWo8s4l3SAvJ0Hr0nm5G6z0QxItGsnTLjT67
 jwLLQQU6TQsV4YZ1X4hwhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760644958; x=
 1760731358; bh=psVYZCYKNsv5UHoD1HUEzHcxnp5Ilt0oHPa8yao1w2g=; b=s
 ZvHn27ePFJ5DXl5IzWer8IKeQrahRUFTpYhE0J8kGGidDfqFjUQgsm0/3oNcXmIR
 v7Nf1WPDbvZG/3xty4qu/M1AiFkLzdwlmYZSWjS/ku5vSGGcQPWp2ssXCwPeRzc2
 LUCnb1ymF3xMVIl5UKSjI5kyHUbZyPgi2dpvpEaJV49rj4ESk6Q07FPRO9a/28MU
 p6LgKFh8I2/g43Bj7qhsmGk47Wgzmi3TM4ZMgaIIqLZwXp8aKAtdOlVvvx2CfLFL
 EftxscsQlqtedF7rbwVpjJ3ett9ObnDZILv+0SKIRFgqu3B4cYyzcWK31QJq2k0t
 GTD7P2nZ3wOAc9RvvKKJg==
X-ME-Sender: <xms:Xk_xaJzBqN0Tun60oyVoHGjlFawkLXJWlgRnTZmVddzlrh_y8JdeGA>
 <xme:Xk_xaJYYLs1AzuPaX_LtUx7FeYHULx33MbOJ7wSc6-PgoCtd75ZobDhSESwBl4t1A
 pamMJ3ZsQu5HF3rLQPJGibub8nmq7v_-xqzlJSDNo-Zs6XZ3780gg>
X-ME-Received: <xmr:Xk_xaLRF0vJ_ctIV7Uvel3fJidjDeDkSOA9AmgM7pwhUtYZQNxMee7c4SRKbhqCekzffn3DnBWWQAlaZUzwkVAL09w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejvddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehkthhrrgihnhhorhesrhgvughhrghtrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhhiug
 drmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:Xk_xaDwmRgsUrp1zv80fIujsjrRpKImahkFHRehqEiqrc2G4D2oJCg>
 <xmx:Xk_xaF09coiZyRKjhxw8da6TfedYbF-_zuRlZZe6cFcokf6JkS9vIA>
 <xmx:Xk_xaJ68oczCjbNaaXlnRpr7JceMerp1F7Inea03EmLDFrcP9wBtQg>
 <xmx:Xk_xaAV5PANYlyjgvHWvkkGR4LPP0_I6sVp-MbsGuMe5CYvqxgaolA>
 <xmx:Xk_xaNhboGc-og-NuIkjLg-keL4YG-croUmsZDNoJGt0sekYWgUest6o>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 16:02:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, david.marchand@redhat.com
Subject: Re: [PATCH v3 0/2] build: add backward compatibility for nested
 drivers
Date: Thu, 16 Oct 2025 22:02:36 +0200
Message-ID: <10319547.2WqB4rESCP@thomas>
In-Reply-To: <20250929100528.18365-1-ktraynor@redhat.com>
References: <20250924123422.224988-1-ktraynor@redhat.com>
 <20250929100528.18365-1-ktraynor@redhat.com>
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

29/09/2025 12:05, Kevin Traynor:
> Since Intel drivers moved from 'net/*' to 'net/intel/*' there are some
> changes required when enabling or disabling those drivers from the meson
> command line. e.g. 'net/ixgbe' no longer works and needs to be replaced
> by 'net/intel/ixgbe'
> 
> These patches are to allow backwards compatibility for legacy driver names
> and wildcarding of nested drivers e.g. 'net/ixgbe' and 'net/*'

Applied with Cc stable@dpdk.org, thanks.


