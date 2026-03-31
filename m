Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96560FF60EE
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 09:13:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 993CC4042F;
	Tue, 31 Mar 2026 11:13:44 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 0F9B04026A
 for <dev@dpdk.org>; Tue, 31 Mar 2026 11:13:43 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7FAEF1400103;
 Tue, 31 Mar 2026 05:13:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 05:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1774948422;
 x=1775034822; bh=alP8ujsE/ZMwKZweUdwUhTpmFh3b7yt40aGM4QN77Ds=; b=
 adO3VI/yCvtzH4yh/Ena1CfHIzdDMXKAiodJ4b55fzRcd2J/gUcdCa+2t9HOdQkm
 MFyXvK4cYeyBzbk6258xKzsOqhkRVdVRGcleNDyi4rI83LwA6yxvM7yR25yHDqw3
 FdfML2CtY8Ver6fNDLe6yF8/CA7b0EWn2vSvYWK29eltt4ks6GpIyE5UVjR/9peB
 kXY7HlV2iaq98dPpdtcbagpBJX9+a2woU2z2U8Q2/dlccMzvKCnMbmMf7UlHKGVg
 Y4HZBa+/8CbmxKLUimADyS9wRuRdAgQ1P1j/B1+tMLfCKYDpgETz/8C399eFISI/
 43nIvPcTVW1WGSmqzhyiUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774948422; x=
 1775034822; bh=alP8ujsE/ZMwKZweUdwUhTpmFh3b7yt40aGM4QN77Ds=; b=N
 MH6yrEKssPw51MYwp2+iizvzDsfMH3DABUKBS/4i1vC7ujZsmZG5d+/GidTILHhU
 OwSBExeMNs77LehHeTj3lmBvPs+KSw3fNpuyl6AuEmJGKCnNebOGT/LbX+aF63+U
 on+1DtNpre9ZdlSt7r1uZqCZ1RMItLS/Er38HpFBAqa+4upncS7VxgE5/OCNpZPv
 zMnVsNFD6tGZSurhWYbotDn7YtKofdLZAkJaOIV0liiCKlOSEEiNfFtFxLuhIr4i
 uvJJE+nvzUwaiNv6GBLS0GIq1t+it31dCX0GmiazAwG2cT4KkB3NXX+czIUYvQiS
 oj6GjJ4JmnMyHkvVOjzYQ==
X-ME-Sender: <xms:RpDLabmmiPLzdaKheFS5RYvQ1Hu7pzzYmjEkcQjnoMrT1jI-fNLFng>
 <xme:RpDLae-zFjVnODrIWS68oysIO49_8FZn-86WLAlwU8-4griCkSm-_DOvKXGA5xHGx
 KbKAZrOmnexeG86sQmbrKy309Ma8P0S8QDOFulYpepfkHshz63_0ek>
X-ME-Received: <xmr:RpDLaZlgepCSBlvZZQecR3W3OkdK8VS69OCY9Mc685PhatFTf6tbDk-i970HSx6G-Y-Tg0M6A3sGLBZCq8PavHThlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedugeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeihuhigrdhjihgrnhhgsehinhhtvghlrd
 gtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgt
 ohhmpdhrtghpthhtohepjhhohhhnrdhmtghnrghmrghrrgesihhnthgvlhdrtghomhdprh
 gtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:RpDLab1XH5UKHqCSGkA2q6kzZDShOAcH7vdD2Tpr9wOPumm7_A_dNA>
 <xmx:RpDLaUo3Ut05LM45ZsvbgiMWpy0skI_kcjNW1UHJcciK-2GNFS6iQQ>
 <xmx:RpDLaYcUBheSfF3I1yZtKmXLI7C3ZejkAY62i1Exyy7dqacYwMn4IQ>
 <xmx:RpDLaTo9ve-wSm_yNP-J7IhFSlKJOet7fxbYg7cSudvMBSh7TpNThQ>
 <xmx:RpDLacWPiZXiUHMvNYdE8_YB2sYfJqVqk8KoTW2_gvrmR1inpBKaOwCk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 05:13:41 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yu Jiang <yux.jiang@intel.com>
Cc: bruce.richardson@intel.com, john.mcnamara@intel.com, dev@dpdk.org
Subject: Re: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Tue, 31 Mar 2026 11:13:40 +0200
Message-ID: <10228085.lvqk35OSZv@thomas>
In-Reply-To: <20260327105150.607424-1-yux.jiang@intel.com>
References: <20260327105150.607424-1-yux.jiang@intel.com>
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

27/03/2026 11:51, Yu Jiang:
> Add tested Intel platforms with Intel NICs to v26.03 release note.
> 
> Signed-off-by: Yu Jiang <yux.jiang@intel.com>

Applied, thanks.



