Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0A6C5AD2B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2CB31402AA;
	Fri, 20 Feb 2026 18:23:53 +0100 (CET)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id CC9CE4026D
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:23:51 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4242A14001EB;
 Fri, 20 Feb 2026 12:23:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 20 Feb 2026 12:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771608231;
 x=1771694631; bh=eWyXiSSs4eVHTi36ODfwFFJYecbT1epXwvlh+EKAbLU=; b=
 bhfNFrD1LAZUpOwehO/dI2PRJIUNoJHffiEojXgnygxCYImloq/7E5W0Sug51+M/
 TPIEG3WhSVMr1tNbc4zxAFGhplk/EvU+lXpg+lCK6tTuFM7bb75S2dJ/CySRMPPN
 CaDY2wsJJKmL43H+RRnAXhyBTOwGU6Q3q/yphnmTZ+KRLRK69qpIp/zOjczPwi16
 OWcm2PT5B7BOgEahWgkzJSDBYNQCLi0K9z7uxFlABg3RfIuHIzSQb3q4X1L7Lrbt
 eFWZ9nLfjd3p+WiYKvP/kXsBwmVAixM9IBHfHKR11vTxPxtFfQXgIPM41kLXyxdq
 dEWkpG54Ytyk/eyvbTkpcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771608231; x=
 1771694631; bh=eWyXiSSs4eVHTi36ODfwFFJYecbT1epXwvlh+EKAbLU=; b=K
 W8uCcUcj1S+d/pNBSTO77JgCa38cwi55g7yIotd3+G03OsdlnQ1zF4KSL/9HQuC4
 xyap/txJY5l4IxHDrEa78P1sEOOUvaV6s1BlqkZulK9XSt/0+nRzuzCAl8iMc4Ca
 8jLM1RZ+3xM/nEXPN1L6ZAydDRW4G9/beosbDNj7NITrODoRe0+GnyaKuU7s1vir
 WmDuWHcY93zRQhJR/v/UHVP/1Ms5iDVFqKANvg7PPDis5zRtQ0ndRkBdreB0zke+
 hoC5UnF8ACNBS0aSVBi+hoNLeCev5WFg53LLJC2VwM41tLtnzvH5aj9IgIeZndY+
 z87vnG7U4GWIyGFjKDxiQ==
X-ME-Sender: <xms:ppiYaegrbcoH978fqnKUwiXH8o0caa19mI7XAuzuy8iyyaxU5YzwaQ>
 <xme:ppiYafKiX_oQOd60jGfMYqSFQg797LZ8gr5_vKHsxaUyiOc1hQR4aYoTCdQPj4GzN
 xkBjk4nHVGZc2Vr5PgNXPXrHYLzFMNVJJM9K2pI4EG21fzfU5-I7g>
X-ME-Received: <xmr:ppiYaeDWCAhw2QaiG7inrJhy8KgYomvwVH5O2arwpPWtcGjhruVaj2C0P3dBCE45KyIHC5e9VvvYMi--AvgeFI4SGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeltdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 epmhgrrhgrthdrkhhhrghlihhliheshhhurgifvghirdgtohhmpdhrtghpthhtohepshht
 vghphhgvnhesnhgvthifohhrkhhplhhumhgsvghrrdhorhhgpdhrtghpthhtohepuggvvh
 esughpughkrdhorhhgpdhrtghpthhtohepshhpihguvghruggvthgvtghtihhvvgdrshhs
 sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ppiYafh9fxbUdCNmvMUZlEYlD0aXkCXyhRmNF8qx4UgkX3PX5y1pdw>
 <xmx:ppiYaWmA_72XNPaWn4lpGGkz4DP81PkQwzWEHBuCsIoX6tNF7hg2Gg>
 <xmx:ppiYaboQFLv4yI9CT5l-SKs3X9STYcMHhJw9b6FbSrRmw375xbWXPA>
 <xmx:ppiYafFwSxM8BQ1e-4uNyqbllRrhd7Qw6awpdWGfroJSF3cYno_fhg>
 <xmx:p5iYadu5R489w4w5rQNTGrRuIEAtVJkNIe48YOeQBPm-trYfQSSznVPX>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 12:23:50 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>, Su Sai <spiderdetective.ss@gmail.com>
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
Date: Fri, 20 Feb 2026 18:23:48 +0100
Message-ID: <33965644.t2Qszz9eOc@thomas>
In-Reply-To: <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com>
References: <20250803090837.15589edd@hermes.local>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
 <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com>
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

20/02/2026 16:49, Marat Khalili:
> Hi folks,
> 
> What are we missing in order to merge this?

I didn't take time to review the full explanation and code.

Please could you review?

https://inbox.dpdk.org/dev/CAFQeoKi8W8WAYUY1OuSn+qMgG1c2V7PjLjEH608m894TpLOVvw@mail.gmail.com/


