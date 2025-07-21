Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AE6C83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 12:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 341404021E;
	Mon, 21 Jul 2025 14:07:22 +0200 (CEST)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mails.dpdk.org (Postfix) with ESMTP id 732224014F;
 Mon, 21 Jul 2025 14:07:20 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id E0C2BEC0283;
 Mon, 21 Jul 2025 08:07:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Mon, 21 Jul 2025 08:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753099639;
 x=1753186039; bh=7bmKT8SvznHYLdn2vq1sCQEaTf71fRdx73yh8i7r/jc=; b=
 kw14pmxJXJTBRPQB7kgU8EdZDcJ8+iRoSgyUA5HoQSkqMsJprhvJWx1K195VFJ6g
 JugoCHTKLwv/u1f+HJpr0MHg/SaMkkwV8TcGzr6rno1Hm+rjRmR3oscaHa/edAwj
 7zfw34H8kftjlDcXeVsn48kw6DishUq6WGD5fHZfn9kL2ZEw8BkN+dS+986FRsSv
 IoFifw1B6a+9TqO58UcZMUp6DGwJ5F9PCeJcBZ+Z8DtVkXiK/rO0pk1VJOgoD0tQ
 gaKEMghWmL0/mjXJlgCrdrhmx/E1eXQEifTYKc77GrzhxAfZr6f7ilPwIh8XZA8q
 Rgdi8HLtHmRamnyve1tJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753099639; x=
 1753186039; bh=7bmKT8SvznHYLdn2vq1sCQEaTf71fRdx73yh8i7r/jc=; b=L
 0ZiDPmHF8Mf9hilyXwtzpIa86WUuAZWIveX3ka4DEzRa/7xu7MQh6hkIdKeVtZ/L
 OCEwe7CegAqLUjF0HzxNhlsbvKZiB+H3sjpWIngT3xLqF2f1thQEIzFdG7wtZ15F
 +w20fa6k2Y+3FRQrzgqm8T0ICJlOOhNIl2YjhKIoNymPkl5PIDp8c0wnObyygHqf
 xZwiYKnojHNIAKHKsVlMuhUXDb7qjmJ824QWaC/EKYD2d60e14OKvtGl8jfeOJaI
 Md9XqRCFHpQEoBOUlKL6T7iojJvMsBksAyGD2yXF7VnjQk+IRIEY6mzuGnWFal/w
 zNKKKhbAHXM++wNShKDpA==
X-ME-Sender: <xms:dy1-aD9ubn35FQ2XMMME_FmhLIHzAG7ULQu1XUkGhd_mC4Gfs0fH4Q>
 <xme:dy1-aFGeEGt8PJqhB5JEO-OyBuf9Qxp9-uXTMqjjJpECfrTwKOVOiAWTxdSkMry0E
 swxuvmYTdGmvop-3w>
X-ME-Received: <xmr:dy1-aBMVKdDDmr8x6xGTLDNNED2mqn9YGfqyn_PtF9tAX_icaToOQfGTlQTEMydrpx7B5rdloq-DUpQ4m2OgXa7jTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvddtgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohephedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhihrghnghdrfihusehjrghguhgrrh
 hmihgtrhhordgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthht
 ohepfhgvrhhruhhhrdihihhgihhtsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvg
 ifrdhrhigstghhvghnkhhosehokhhtvghtlhgrsghsrdhruhdprhgtphhtthhopehsthgr
 sghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:dy1-aPedAxXXQf262tTFMAz6BNnPkTOMWd8HLrlgXMTP3KmerrCHNg>
 <xmx:dy1-aGtWy4nPjblHY9wV-igTAuN83zrhxHeVB55UB0a4jciP8MIHmQ>
 <xmx:dy1-aImq8QTjSmCsJ3dbx2QreJvZdaDrGN4m57ZHS90Xk2uGUmIwag>
 <xmx:dy1-aAwMZUJklfI2ne-hO5ZeKTcNUy1aXPXtRhQSB7q6dQ1AJ0Q7gw>
 <xmx:dy1-aNyl92hlo1UaLbICOtII_2Xq8RBugyrj8V-3U-n5fILJH52clcXw>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 08:07:18 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sunyang Wu <sunyang.wu@jaguarmicro.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru,
 stable@dpdk.org
Subject: Re: [PATCH] ethdev: keep promiscuous/allmulti value before enabling
Date: Mon, 21 Jul 2025 14:07:17 +0200
Message-ID: <3628442.V25eIC5XRa@thomas>
In-Reply-To: <20250721115139.46728-1-sunyang.wu@jaguarmicro.com>
References: <20250721115139.46728-1-sunyang.wu@jaguarmicro.com>
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

21/07/2025 13:51, Sunyang Wu:
> The values of the promiscuous and allmulticast variables
> are set after calling the driver, according to the return value.
> 
> Fixes: 400d75818266 ("ethdev: check device promiscuous state")
> de5ccf0775ae ("ethdev:do nothing if all-multicast mode is applied
> again")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
[...]
>  	diag = dev->dev_ops->promiscuous_enable(dev);
> -	dev->data->promiscuous = (diag == 0) ? 1 : 0;
> +	if (diag == 0)
> +		dev->data->promiscuous = 1;

I remember seeing this strange behavior of resetting the value if failed.
And it is done differently in the "disable" functions.

But it is not so wrong, because if it was enabled, the function returns early.
So the value changes only if it is successful.

What is the issue you observe?
Is it a rework to make the code easier to understand?


