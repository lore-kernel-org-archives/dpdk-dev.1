Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA40CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 08:59:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A137A402C8;
	Wed, 20 May 2026 10:59:47 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id 7003840276;
 Wed, 20 May 2026 10:59:46 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id D94C1EC02CC;
 Wed, 20 May 2026 04:59:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 04:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1779267585;
 x=1779353985; bh=lIt8FRao6jyK7tWzV3RERPoX+y3Mk+SvrXEfCMyCpy0=; b=
 GGcFo5NoBfza/Rz6vKXk6t8q+JwLiFKYRDPi+2gNcC6vDzsjSrUiJqOQORIIFXMc
 ZnHfT/rn189geW411q0B2ymp7w1wcJF9N73LKrglORaR15Dz4n+9MHqpGX4YOA5y
 DbiDdrRDumhugN67FNhv4AumAHeD9Y1o9/SX9pf5YPwnNSBHBjnP78daUQfCUAsY
 pndk9kJ+a5Hs8tXlHZ2PlEOtPo9Muv3qIW8cpXjWngHkdNYTMHDZFRoy5o+HT2mD
 CwUkw/Gj4oOFq5GWkSzlDgyFszVN2QjvnKhKco1kFXmk5E6Zit6KZA6XdWqBj/vH
 tzTITfN6qIGvZevzbWJjdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779267585; x=
 1779353985; bh=lIt8FRao6jyK7tWzV3RERPoX+y3Mk+SvrXEfCMyCpy0=; b=p
 amAh26Ci6NSpf6Oj26bJ4TKuGAOaM1aQjMl0Izvyp8HqrnFs7HfZY93wiwtGlIU7
 8woS6ELk4KLbLLtFdOkZi9j/UEOCbrRcIz28iqpOsJ0vx8mIgNJQVk8RC2YaOYzr
 AoNGkcaZsNdO2jyDvrmatqqHe5mRhY9m2Vncn/xiOpqr8dt6exxhUeloDDsTh0CQ
 FEvTRmL/oq3BP6bq8zwuKem12Bg3NkIN9KvUcchrIPBwfsLWYblpXWgF+b9iXDlX
 Si9y0gm73ZpeddYlmqx7y2wB9ekcO4M/3smLApoQRvivN9P6Oa+ip6cGzoNUUZ0L
 fS8hf3og/M4yJC4ogbMnA==
X-ME-Sender: <xms:AHgNaiC5ueAT5fpk-9C0IaDoGJZRt9RxwHb3r9U4NVknOqJUzfI7NQ>
 <xme:AHgNanexFoR6NFFrKSsZpZk88BxiEdLJlDGm_IS8Euq-UlyZT-PhfsA-jQwTAkR1J
 jT91pL38T3MZTuRYq-RlPGat4XCasvzvmqQDig4xQiZnihKM2aGJA>
X-ME-Received: <xmr:AHgNaknw1no-R0JZbT4EcgtkBHzMNd_rHq0xGMKQguX8GCUrxADw_zYRtjt2YHq2fuNNIWcj-wx8n0U89cWxfTk-XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegvdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehjihhniihhihhguhgrnhhgsehkhihlih
 hnohhsrdgtnhdprhgtphhtthhopehkohhnshhtrghnthhinhdrrghnrghnhigvvheshhhu
 rgifvghirdgtohhmpdhrtghpthhtohepfigrthhhshgrlhgrrdhvihhthhgrnhgrghgvse
 grrhhmrdgtohhmpdhrtghpthhtohepughhrghrmhhikhhjrgihvghshhdrthhhrghkkhgr
 rhesrghrmhdrtghomhdprhgtphhtthhopehhohhnnhgrphhprgdrnhgrghgrrhgrhhgrlh
 hlihesrghrmhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:AHgNamHpfzmYqRW7wtkXcWjo6tlso3sYgi-WvBO4NNqplVzcBAi56A>
 <xmx:AHgNak5g05UrPVfb_iFX8fZTEdBUWzT3saKoFg24jiPzzWqBf2OmVw>
 <xmx:AHgNammDHa5z93uC3R5VkzlTnZKd4R6S-o1bsZBYHGXzy51fUSpxaQ>
 <xmx:AHgNahoeIiH_KY0Zoh5EXVVTd0dp5YG3TkAbA1azQd4bvyo-XiOXxQ>
 <xmx:AXgNarFcUwAXTM47uZn9nJvXevDvNKi81QVqdpLIGQ1pHY0y8yPs0s8_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 04:59:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: jinzhiguang <jinzhiguang@kylinos.cn>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH v3] ring: fix zero-copy burst API documentation
Date: Wed, 20 May 2026 10:59:42 +0200
Message-ID: <D6Rbi5-MSBSppW6LoqeJTg@monjalon.net>
In-Reply-To: <20260519133853.889-1-jinzhiguang@kylinos.cn>
References: <20260519114629.862-1-jinzhiguang@kylinos.cn>
 <20260519133853.889-1-jinzhiguang@kylinos.cn>
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

19/05/2026 15:38, jinzhiguang:
> --- a/.mailmap
> +++ b/.mailmap
> @@ -756,6 +756,7 @@ Jing Chen <jing.d.chen@intel.com>
>  Jingguo Fu <jingguox.fu@intel.com>
>  Jingjing Wu <jingjing.wu@intel.com>
>  Jingzhao Ni <jingzhao.ni@arm.com>
> +jinzhiguang <jinzhiguang@kylinos.cn>

Maybe you want to insert a space? What is your first name and family name?
Please use capital letters where appropriate.


