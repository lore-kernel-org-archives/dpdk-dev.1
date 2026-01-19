Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53E6D29C2E
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 15:18:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD5CC402CE;
	Mon, 19 Jan 2026 16:18:23 +0100 (CET)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 802694029D
 for <dev@dpdk.org>; Mon, 19 Jan 2026 16:18:22 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id F21ECEC0AC7;
 Mon, 19 Jan 2026 10:18:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 10:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1768835901;
 x=1768922301; bh=qhjFnL0sKo+UVdVNyz4O2ZhNlzVeGUqWj74obyZA+Ng=; b=
 qoMiHLE9QG6ayimK0HCHXrhxy/ZopPWed349HQ5pQCBx0Nqe5pJPEs6sxm/Zf9hv
 WPCYkqQdE9+kdCwEjaaC8zEIxdFxdC140Txuy5xI2jypqVzk0OL5RC+djk8Q1sH7
 6djLiXBZ9SffEGbVA4hWMJOrpkZrRvl19u2XvjF5+yNg8Z7nlR4ArEOwHRqSiICF
 h3mViDfYOFdvDIp4HF4P2GG/EwtunzzuZnHuBhzclCfPPugSlT98zZeLHiN9GmQ2
 JPmzzUUBshvFq2INT+AR0TDBssh3lF3ZI3MvLASiabMd0BmqVrjaBff3yAOze56y
 XRoXbEUPjxP7/RKQpb2gRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768835901; x=
 1768922301; bh=qhjFnL0sKo+UVdVNyz4O2ZhNlzVeGUqWj74obyZA+Ng=; b=Y
 1cMxDI5k2PdZMCDfHK9NWecEfafjxsKRHfs6fZFJS1XO0VHuBpWUzj6dlnDo27n+
 LV63KpoF7xSG5uL+6qHyRCDWWgGUuC6lDN9V7JsPjvCcyDKbKRr60R67XadswfiK
 uitXzobAYzM6jnZMXKDNpWxpdDMZP8Bz51lH7l7s/AP2V+yIYqnsCqJSnIivQ5X0
 Y5okwBpzZyyIfrOksFk9lWsIRNsHdUnCcBF+bjXpi8ZKcInng02mK9w74NpbE+p9
 Tc3/Cq5T6knCzL/z291VTbgjUoiOT22P/hDUBneyHfAfhJtkMDQu+Q2OXgjU58W/
 R9amTjiEUnHzKEq0WKZeQ==
X-ME-Sender: <xms:PUtuaWkMzC046HYXL_u0wBOSG6GRwMM1W9CIieByTzuvpghA5QL6xQ>
 <xme:PUtuaSKKa-98BIuvNZE04wEzigmbV_LaXrU0KyOQv3EX1aGROIzp5QZlxBqQdkG4A
 -fzbNKLu7dnJc2b1VbmCQPI-j0QMvD6N1iiEaKvtDAgXwNNk4_K1w>
X-ME-Received: <xmr:PUtuaTwP0T3af91EJsIap_PkCUUHmiC06IWxn921cEEeCQKUqAgNS9LBKfpOvL8oHRY5dozgC-3dqg8WRG0jMY5M1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegrjhhithdrkhhhrghprghruggvsegsrh
 horggutghomhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehkihhshhhorhgvrdhprggumhgrnhgrsghhrgessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:PUtuaStc1eqKhMUvuROF68fruEf-xpCBT7aj-bGbnLGIvo-Io-paAw>
 <xmx:PUtuaavoyCPJHNXl90n0HJGcnm7e4lXXP-WGGxNtFOiXYekJV1gNcQ>
 <xmx:PUtuaXM2A24wKC5yTZsbOt3bS8UcNHcRJvSN5rM_pBI4JG6bkG4rMQ>
 <xmx:PUtuaY38rhDXVT0NEF9b08lckIBGEIvzxQ7EhE0Xd1xp4c6RrZto-w>
 <xmx:PUtuaSK_wY3XSxgmtoOYy58HpKUq6rUm9zYImrDxnOFE2uV86U5a14mo>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 10:18:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: dev@dpdk.org, Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: Re: [PATCH] maintainers: update for bnxt driver
Date: Mon, 19 Jan 2026 16:18:19 +0100
Message-ID: <3733318.R56niFO833@thomas>
In-Reply-To: <20260106150012.49022-1-ajit.khaparde@broadcom.com>
References: <20260106150012.49022-1-ajit.khaparde@broadcom.com>
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

06/01/2026 16:00, Ajit Khaparde:
> Kishore is taking over the maintainer role of the bnxt driver.
> Updating the file accordingly.
> 
> Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
> Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>

Applied, thanks.



