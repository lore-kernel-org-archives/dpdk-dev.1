Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E6FCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:43:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5643F40280;
	Tue, 11 Nov 2025 19:43:15 +0100 (CET)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id D77EC4026D;
 Tue, 11 Nov 2025 19:43:13 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id CEE677A0195;
 Tue, 11 Nov 2025 13:43:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 13:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762886592;
 x=1762972992; bh=dItH1feMFKfeVzk7k7YgQnJH0ahqBbqmrBVT4GwPD08=; b=
 c9QrDVIazIo2IVjdCG1fTlLioKK2my3XOn1WGnY4Q8Sk8DRxNRBA6E9Cc8JhXfKa
 vr2jFO9z0jwao1ikW23oI6yfsIm0hhAIyixhf13/GDTuhpKfIx3eaoZeAEw6S6JZ
 u24JSHQu4VbwPt+odbEkpBMIaYFpXQNCDxE8crFq3BqWfYmEYNuMzl4tegZi4cwM
 ks8E4oRm8cMMv4zYoBHT0eEqQaLYJSHrS0kW0GLiyTffEQYV6Qwh4053xCVL+aWo
 QcLLpbZrfnOd0ie/9NkvzYzhbDHduBz4TAVHsYZF9kU+TvE/l4JROnVqU5Zq+arX
 Pf1C/jMtbRwNtE1ZvZnI3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762886592; x=
 1762972992; bh=dItH1feMFKfeVzk7k7YgQnJH0ahqBbqmrBVT4GwPD08=; b=y
 sz5KAI1c//jgVrsBtYghes40Y0rYXoKALm7qL3oGWHDafyjXsBIbn+tS/qVKw6TM
 nxISCCnwrDC6EOEvOGeFm6wx9H3ZDXOCrDVp3knvRq5nzv8lvkmMS17xPEMhUU2a
 2Vy+qCYMgjTsKtryo7Nzln6w9AwEgvffNP6imMbgknXj2ELyAe858zc5yBKLF7oB
 CYLpy+9YNLw/xXfB0lWeHDiSRY+Xak4+SqE18tj2lK+p5rs47Q3y8LT38Eo/tGMf
 Ht6zoutCshyZ3B14YYEWOZWSKFdA6Y36jceAxN9y6X7G5LbeWxQRt7xIwbx6G+RM
 cvGbjD8pfdJmWQlj7LLHg==
X-ME-Sender: <xms:wIMTaUCeGIg2Vwwims2m-I7Jjs5Trq86neE6Dhtv-dXhuwIbGEP3Ig>
 <xme:wIMTaQlB9sVAq5WtOVIMzysFa86KAyxrbW8FAxqVg6j5tp--OrVPSErBbToZwy3fX
 1PkzPOnIPDgQwiqgBqLqI5uPntRyC-oALrev_Aas_aruE8OA8vg8Q>
X-ME-Received: <xmr:wIMTaXcibr7ksdcjxPfb-q3sMmFDDiEolXxRPokFyuMEiOISxizdCnkPwZKbr33fmwsWEaqTZ22U8SA0u921jkrFNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtg
 homhdprhgtphhtthhopegvrhhikhdrghdrtggrrhhrihhllhhosehinhhtvghlrdgtohhm
 pdhrtghpthhtohepshgrtghhihhnrdhsrgigvghnrgesnhigphdrtghomhdprhgtphhtth
 hopehhvghmrghnthdrrghgrhgrfigrlhesnhigphdrtghomhdprhgtphhtthhopehpsghh
 rghgrghvrghtuhhlrgesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehsthgrsghlvg
 esughpughkrdhorhhgpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:wIMTacSR-I0-cnxKtLcD2jtGkHtdcny0NAHUkiLS8d9haGK1Dq-Hyg>
 <xmx:wIMTaWvmCLJYygdJRoPcQBg6ajZEFVgppNO3K2CckM-P1wGf8eyTFQ>
 <xmx:wIMTaVdbW3Ze7w9E6n-Xjoak048JL_aBWTZfBU4UUD4iJLjN573mcA>
 <xmx:wIMTaYacaEdhqxKh30zz-Yx_EAvEIuIUGPPuKejA50YTuQf-NhSakA>
 <xmx:wIMTaSvlxp_-KVJIKUn2O0sFZygymErKWSgTyqwWhiiyLAl_TrufvUJX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 13:43:11 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Jerin Jacob <jerinj@marvell.com>
Cc: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>, stable@dpdk.org, dev@dpdk.org,
 david.marchand@redhat.com
Subject: Re: [dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.0
Date: Tue, 11 Nov 2025 19:43:09 +0100
Message-ID: <2386076.axiByQ7kbq@thomas>
In-Reply-To: <20251028141159.177727-1-jerinj@marvell.com>
References: <20251028141159.177727-1-jerinj@marvell.com>
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

> Doxygen detects valid errors. Fixing the same.
> 
> Example:
> lib/eventdev/rte_event_timer_adapter.h:720: error: Reached end of file
> while still searching closing '`' of a verbatim block starting at line
> 569 (warning treated as error, aborting now)
> 
> Fixes: a6562f6d6f8e ("eventdev: introduce event timer adapter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>

Applied, thanks.



