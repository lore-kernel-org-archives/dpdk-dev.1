Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20DCCCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 17:40:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C70AA40276;
	Thu, 23 Oct 2025 19:40:08 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 422AB40144;
 Thu, 23 Oct 2025 19:40:07 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D6344EC0103;
 Thu, 23 Oct 2025 13:40:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 13:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1761241206;
 x=1761327606; bh=jKMso60e/kmd7P0Ytj+1dCSUT7lyKOu8c22RKw1nFiU=; b=
 Jq02gl+vv6ewnfHIN2DZlZk4kwx1FSmCkxefcLYZMTFHpt0bGfw71vGMz9u15m/L
 2oo+W6Ff1VXhNcJeEE4dOTnxLDV4c8lmQPGRZ6I+dp77aqxHj0G8kd25F5S65Xwz
 +ABHkwOaaRUB/ONEXCjsxsQJBN8QjhNLV/Al/YXV0+LzqvboI8lJpUZ2KaY2r+LT
 X6k5Y5AftAe82c5wulLSq9dRqBdtVBL9ro822IOEW4n8Nev74tBDPGBBenViTfCT
 NDEr5mAVb+FHR2aRC2yBCArwHrFFDBbaIfcE5s/bU8Or0qlpUIYGFr+sWdhh1jVU
 U+DlIaNHbXXyU53B1DD6cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761241206; x=
 1761327606; bh=jKMso60e/kmd7P0Ytj+1dCSUT7lyKOu8c22RKw1nFiU=; b=m
 4qgYfZVJrPyCUvRqS6RPRJVoaERornVoXRq8ZRVKq3aeQkCTjqF0Jj8B90Wh/bBY
 8NjgDQmfW01jgzZ/q1g7Z7SRpvU89s/nNAVdgn54GUvba/ITce/sJVhPcCS8zEDP
 MracxZ06Zij/NVbG9n1CnqlgmZSO+xu8HlzGu9Q4k9QAiOiUnbEeuloS8FgvlsSl
 OOxzJqN70CAyiIKKG4Q/Y2/DHb4kX75K5nIFsWW/2SYFjYfoQlN2oLUIurnOuxYu
 7fe187bQ7LIEtue/L+TlwpzEPCyv1Q0opl+z4U2+QL7hofoUKagoWCHrDei/VC68
 dRiHzwlAAb+rteqVsuM2w==
X-ME-Sender: <xms:dmj6aD_qsDILq0f7i3PHf7N6wK9OLv7Cp3Aq3AE5qIFBHWLuLdR02A>
 <xme:dmj6aLKkcmqHuZy6QpFJ8JWZZdliucd32noNzH-L3DhthQeVZUkY-sFSVEnRbCtvz
 Lk3_AHwcOU1oEPhY5ZbMTJWT_jJ_ECbUToDBSpdh5hZ8oNcQsuY>
X-ME-Received: <xmr:dmj6aEgfywqEgIcQTtmdLDrS0nv6Qtg3q3RJhvdvD2oI48BqKzPXQfH-i2jv1EwpkALUkW7ms291Fj6adSQzV0rwVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejtdekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehmvghghhgrrdgrjhhmvghrrgesihhnth
 gvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehj
 rghsvhhinhguvghrrdhsihhnghhhsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhtvg
 hphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepshhtrggs
 lhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:dmj6aD7oI3hEAdnJ_MM1BW_rQKHBnQL2FuT6xCT84mXhgjWWCxFtng>
 <xmx:dmj6aEYpLOrcG6wNKcWl4dcvR8PEW9JdHgkULIMt1RLj1K_xsxcp7A>
 <xmx:dmj6aA6hC6gxrhdbO6wM08cMsfcu5PxcsG2icXXL1c4LyrKSA9Qetw>
 <xmx:dmj6aPDjo9Hfa2SOmKr18xu42bZ35Buwyg6WUH3A1gfEZ7aCPGOQMA>
 <xmx:dmj6aA3vY37kjyTSGmSY0Fp9NiO1Gke8GNKf0objv8893Ipms4KOEbkI>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 13:40:05 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Megha Ajmera <megha.ajmera@intel.com>
Cc: dev@dpdk.org, jasvinder.singh@intel.com,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Subject: Re: [PATCH] sched: fix wrr parameter data type
Date: Thu, 23 Oct 2025 19:40:04 +0200
Message-ID: <6674915.uKWtJMOXK1@thomas>
In-Reply-To: <20250918085145.584fca13@hermes.local>
References: <20250918024609.2027038-1-megha.ajmera@intel.com>
 <20250918085145.584fca13@hermes.local>
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

18/09/2025 17:51, Stephen Hemminger:
> On Thu, 18 Sep 2025 08:16:09 +0530
> Megha Ajmera <megha.ajmera@intel.com> wrote:
> 
> > wrr tokens getting truncated to uint8_t in wrr_store function() due to
> > type mismatch. This patch changes the data type to uint16_t.
> > 
> > Fixes: e16b06da0908 ("sched: remove WRR from strict priority TC queues")
> > 
> > Signed-off-by: Megha Ajmera <megha.ajmera@intel.com>
> > Acked-by: Jasvinder Singh <Jasvinder.singh@intel.com>
> 
> The pipe tokens are updated in grinder_wrr_store by:
> 
> 	pipe->wrr_tokens[0] =
> 			(grinder->wrr_tokens[0] & grinder->wrr_mask[0]) >>
> 				RTE_SCHED_WRR_SHIFT;
> 
> The token in rte_sched_grinder is uint16_t.
> The mask value in wrr_mask is either 0 or 0xffff.
> The shift is 3.
> Therefore the range of pipe tokens is 0xffff >> 3 = 1FFF
> 
> The sched code is severely under commented and overly complex.
> The patch looks right.
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Cc stable

Applied, thanks.


