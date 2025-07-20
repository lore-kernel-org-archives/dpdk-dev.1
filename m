Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE74C83F1A
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Jul 2025 21:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12B06402D6;
	Sun, 20 Jul 2025 23:27:59 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 87E6B4026D
 for <dev@dpdk.org>; Sun, 20 Jul 2025 23:27:54 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id D9191EC0202;
 Sun, 20 Jul 2025 17:27:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 20 Jul 2025 17:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753046873;
 x=1753133273; bh=foMDLLr8M1x1vKtcEkNcIalHsnBngFZc/Txluhspwio=; b=
 zBSyyl3wdeFTmQ/X1cymg+tWpIIHCFs8vwjlVl9YYLx8TOFvGKBlva3GTV/ElU+S
 BsA1EqjHi1YmIF5XYExtHWkxSZUotjiFr0f3rZfzmmIGNVGMTaC0UT8jkxat9gDI
 S70t+KQLH0s2ILYZYOJwPLPRg6xQk0dm8/XSwxicEKgErwMdhwTVbm3jj+b7eZSB
 mnU3Gz4hmoCskquxThssuj63kSvSPo43JROEhcS8+pfhlEr/1/2iU9lYUHSigYo+
 lTVi7XmJh7fqHxRZ55Yd15vgrej62bapIymsM6fPhFBRgy53FNtuCuCOf5ybU2mD
 okKrLhWP0MLMZNAlpmJ/5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753046873; x=
 1753133273; bh=foMDLLr8M1x1vKtcEkNcIalHsnBngFZc/Txluhspwio=; b=H
 NkutdWVxX3Ft0Vq2UmgOvqQA5PZ7nv1IKH8TaHZOKdHgwkP1FLmM8gF/f6QphM5v
 2QFyQ63xT1TLTR+GV9K2AJ1yYZNJ6ELPhrYWnm8LZi43BSBA2BMCTbffhlGl82E5
 lU1n0dgJv+eS/5bU7CRLJ3gYQilyx6ZRqyrjw7OPm+w0z6wYjHXVhI60+L8KfSVH
 vkSkOg2JyXNjJ5skdSYm6rAnF3IEVfRyJiJKRxzAnn3vWGgjimz5IXV2m4Z0Q28d
 Wc5UIoThHhj7As1YH4gjFCVkHGMRX1eOnYKpdCo4YoebsnPrmtYZUzMFWGSXujEc
 K7/eYPJ/AScMidZUaGlZg==
X-ME-Sender: <xms:WV99aCkBuiWHgUu4MT1p9_MsPHL_zqNrXkrXXcUxVyIBQCvTVe3dSQ>
 <xme:WV99aGwSlmC24KrwWGBpem0wJBWT-BuuXrsTebqldhqgkNhbSiNJEspjMRK6iNQ7r
 UUzNRIhRlqkg0XF_w>
X-ME-Received: <xmr:WV99aMT96wyuzOTokP5DoDwIf3Rhp-gmm-SfHLhz85knuZkYoQ5Y4yjRSAgaf0sKq5dUtq-hvUER_ukkIn0jNSo4Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejtddvkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepkedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmih
 gtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhvihguihgrrdgtohhm
 pdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepughsohhsnhhofi
 hskhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehmrghtrghnsehnvhhiughirgdr
 tghomhdprhgtphhtthhopehorhhikhgrsehnvhhiughirgdrtghomhdprhgtphhtthhope
 hsuhgrnhhmihhnghhmsehnvhhiughirgdrtghomhdprhgtphhtthhopehvihgrtghhvghs
 lhgrvhhosehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:WV99aO-yZ5eeElZkM21gdWe5YKI2PZclKwU38aTACGXIFMDa0-OZdw>
 <xmx:WV99aKvn9biWBmbGthjKfZwYdWXXVmMaJIV5-6-Jlh_KqIAIv5K01g>
 <xmx:WV99aGOWPg2xJtZc4jz4M4I84wgN9ZdyANzfjP-NdHy1zh8Bz7WYrQ>
 <xmx:WV99aHjauo65lEBMgNjuyniCZHt2Y2uiYkOB6Sgnhog44KUa1fQldw>
 <xmx:WV99aMIr_RfISSL06Qh4DNdo91MZ_ovlrkqngZv9vP583f3GxNqlFMDQ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Jul 2025 17:27:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: bingz@nvidia.com, dev@dpdk.org, dsosnowski@nvidia.com, matan@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, viacheslavo@nvidia.com
Subject: Re: [PATCH v2] doc: update parameters to use for mlx5 on Windows
Date: Sun, 20 Jul 2025 23:27:50 +0200
Message-ID: <116876127.nniJfEyVGO@thomas>
In-Reply-To: <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
 <1752588889-27133-1-git-send-email-andremue@linux.microsoft.com>
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

15/07/2025 16:14, Andre Muezerie:
> The linker parameters to use with MSVC and Clang differ.
> Showing explicitly what to use with each in the documentation.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Patrick Robb <probb@iol.unh.edu>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Applied, thanks.


