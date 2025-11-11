Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FF4CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 16:13:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCFE0402B0;
	Tue, 11 Nov 2025 17:13:48 +0100 (CET)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id E376440280;
 Tue, 11 Nov 2025 17:13:46 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id F250D1D0014B;
 Tue, 11 Nov 2025 11:13:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 11 Nov 2025 11:13:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762877625;
 x=1762964025; bh=WqMT5rcVC0+tqiFNbHdz7e+S0UaI95eeWENPVf488z8=; b=
 DomD84CSE5LhEar3lVx7QgsqLI5BBfi3JQQifRT5o+WLu1s/yvbarE+V0fitCmgH
 q9GGYIWQyBblw4ySx9dQQ9NpgGBec2eC7UZt0htj7WxKziCjZMwOorC/0+FnMBT+
 qMstd1rJDKNoONm5Jt40kzxCfd+XGd5vg3LV2CN/JuFhT1xWgJU/IQ+7PNSb4Lzp
 Rbpb95RAtym0mvsOEIGjJ4FCCAL+q/E0Zo9d9DpRqpekYEmdVUY51Y/i0pTYnfjq
 dLxsbBp2h6HH8eF1fsd6728Luv281NpZ0txwtcryQIpO0nS1TPXFY1z+FiaHlAqE
 8Kne8LfqVjm0iFS463Aihg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762877625; x=
 1762964025; bh=WqMT5rcVC0+tqiFNbHdz7e+S0UaI95eeWENPVf488z8=; b=C
 Pg7zIzmbUj7b180e5RL+Itw/ZsLZZL8ouh0RRy80Xks03CWmvBOF4Go2H6CGQPVT
 a0jonVPRZZ9k5y9m8MBp4R3bSXhgsDp8bEbpXEvX8J6sa51+YzaVGJ8+DQTvCG2J
 0QoOoruKTXEaJ1FxrXqoqiSNU9xpXAvyf/2Uk7x8ie0mst/xCoXPaITCQVNJ0qxa
 eIXOPkkvh9nF4qeWqye553kBC4UXDJ14mAkiOAqBq9QNyJ9Z6w96yF+qAiErctva
 s1D4sYCsNLpfIPpnPo8iTxoH5q96pOngNTEOif1ww4jwxxfLYrd8lCX3ZpTB4KXY
 ly6N68xgKAZW+vTqGTFAQ==
X-ME-Sender: <xms:uWATadyq71k9S0yMsqZF2Kv36XdYMwPxs9cd1UTKC7IJ6jULztLwAw>
 <xme:uWATadbo7vP6sF8DMGBI5VYPexP9xctn8y344AqADJkwfBwc4uczjQ3ZNUJ-ShsbC
 9wZXEO2bjQcLmcHz8D51iSaRlMJmGdd36V2lY5SjHxrPL_tpDAsNw>
X-ME-Received: <xmr:uWATafRwBCm3Clk1JskveLVkP3JGEkFFsXnmM6EAG81yyHWkf3_GZnD-R6H3j6qy0P_8APJLRc_5WrgI7YYEfhZEew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehsthgrsghlvgesughpughkrdhorhhgpdhrtghpthhtoheprghnrghtohhlhidrsg
 hurhgrkhhovhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:uWATaXwQfpDcGf5dTOjdCoRQ3zy3XFd5ZuCwdOA60TbvYm9GAJwzWA>
 <xmx:uWATaZ16tvCPCHvIT5T8rkTebYEgsqSzxYutF0G_VMGiyqvD7-t33Q>
 <xmx:uWATad5Qt3e6w5Thllb9qefWbAmnkxejVf-OkNHUY5OG4fEODXoD3A>
 <xmx:uWATaUUYnmk7Nrew-fCs_m7GTPPaLqjzkQXGejqFpgPJuEENdxVipw>
 <xmx:uWATaTjd5UOF_iqpK_nQktSS78K5681ENQ-CdZLxYOcmbIlDG3tMkpSi>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 11:13:44 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org,
 "Burakov, Anatoly" <anatoly.burakov@intel.com>
Subject: Re: [PATCH 1/2] app/pdump: remove hard-coded memory channels EAL arg
Date: Tue, 11 Nov 2025 17:13:42 +0100
Message-ID: <41535341.3d39sCTmQd@thomas>
In-Reply-To: <72033313-c9f6-4b7a-8298-c32265ae8489@intel.com>
References: <20251017110638.1094371-1-bruce.richardson@intel.com>
 <72033313-c9f6-4b7a-8298-c32265ae8489@intel.com>
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

07/11/2025 17:10, Burakov, Anatoly:
> On 10/17/2025 1:06 PM, Bruce Richardson wrote:
> > The pdump main function modifies argc/argv before calling EAL init
> > function. It needs to do so in order to add the proc-type=secondary
> > flag, but also adds in "-n4" as parameter. This parameter is unnecessary
> > and also causes duplicate parameter errors if the user also passes in -n
> > flag on the commandline. Just remove this flag.
> > 
> > Fixes: caa7028276b8 ("app/pdump: add tool for packet capturing")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> > ---
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>

Series applied, thanks.



