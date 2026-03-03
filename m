Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19012EDA694
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:17:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D6A40E7C;
	Tue,  3 Mar 2026 17:17:33 +0100 (CET)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id AD440402B0
 for <dev@dpdk.org>; Tue,  3 Mar 2026 17:17:31 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 36F2CEC0582;
 Tue,  3 Mar 2026 11:17:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 03 Mar 2026 11:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1772554651;
 x=1772641051; bh=KLTRdyo/e5iBAN0NXpguqMvmIvXDguUhwhQiWOm28Hg=; b=
 QDx+12UE39z13psxl5dyl0giXLPtLZ9LaRyhGC3DnEosmxZuOJSLchJh5OGqK63Q
 QS8HT/62xFf3S+taAnVLA9o7Qhu/rlykGZ/SmqDEnCT7b2tn/VzIpjDufTsvzQsk
 UHtzKztgEd2WlA79n4cdpCzIDoJcoWGNJO47krSt1Avepj2IBn01STYVTyEwQf3Y
 /6r2uLrGYoJKhJxbLGCoPPy8r+rpdQcUYzk/9y7aUXWmxv81E/fwRvBo5M1ABaNF
 RURBuZoKyjDRGSlQfmkZ2tGaK9otii6nFcYgTHA04ixVpbPM5se5W37kl5oV29Sj
 9AacByHxNNxAeSkL1n+NvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772554651; x=
 1772641051; bh=KLTRdyo/e5iBAN0NXpguqMvmIvXDguUhwhQiWOm28Hg=; b=w
 gyukqeQe4ufbMydh2+IBxYCA3nwJyRY1wixh/Wkp6oxe1Sm9fCZfogG0rWP3b2TI
 j9ISaa8gwT0spQKCAI7bm8QIf1e/0ODZmAGInGALpCvsZIP7Ty3NVxsE3O8h44n2
 JrCljQShehxNrD/TXzfAZDsyqzbudg3IwipmXFJL242OsMp0fwj+QI5lWmSkMghZ
 uCzViix7dxCQiuISkjU1DvXo8MBU1RNNjWpA3qsZ8eEGOzW0dwHNUm+Zff3oscw8
 oyWWMhtGezQdS7qW4rFevaRzG6H/aLGExT1jGy76zpV00nnCZvIZraw76Mg6gEaH
 Jj3bLIYsjrGAEqDMRKbBw==
X-ME-Sender: <xms:mgmnafnLAlLR6FX1q1o7vXl5e9p3YT6VsJDO8W-gZy-MWvdVZj8zVA>
 <xme:mgmnafJ7qSeqQNfucF4tM8-KBtLTmkHX9bcVs9aE4Vwj9baBTkG7FivFN4oPjMJqg
 OEjMITle_-eNravthlCcZKpH4T0lR6_Vobel838mlz3hlaxGUlI0Q>
X-ME-Received: <xmr:mgmnaYY7nFY4yYSMjQ5OqbsK9F6WlHMMkc0ue82bahKzGxi7yBANZxuaUBfNCujbaWSMAoHsQQgZEO3UHDaxfMRXTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedutdegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkph
 hluhhmsggvrhdrohhrghdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:mwmnaZZbGyqGFowUVuZBPChs6B3TBRuNagi8c8EcUlzZmjU6e22pmw>
 <xmx:mwmnaQm5fzhe526-htxmLdAWrWrhxxiOqAxilqkqsFLYyP-nZBdkZQ>
 <xmx:mwmnadwnxlhx-R3D8XQOM291F7AOISmyWVqScuZvouQo9nq7XGBsmw>
 <xmx:mwmnaWMexUTnmTso4-2GIExcp1ZVZ8bQQU-KdVaKnpmj4eziKKxYKQ>
 <xmx:mwmnacFn922CfRQIlYvLeslnlqHPy0RWJ6cpNvEzh7K786VmzceiVZwR>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 11:17:30 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [RFC] MAINTAINERS: update NBL maintainers
Date: Tue, 03 Mar 2026 17:17:28 +0100
Message-ID: <3832610.EG9au9Sx1z@thomas>
In-Reply-To: <20260303151425.20121-1-stephen@networkplumber.org>
References: <20260303151425.20121-1-stephen@networkplumber.org>
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

03/03/2026 16:14, Stephen Hemminger:
> The email for kyo.liu@nebula-matrix.com bounces.
> Drop as maintainer for NBL driver.

I had sent a patch already for many maintainers.
I will apply now that some time has passed to allow comments.


