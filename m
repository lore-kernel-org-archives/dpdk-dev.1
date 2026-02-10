Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FBEA8112
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 13:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BC7840664;
	Tue, 10 Feb 2026 14:30:45 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 19753400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 14:30:44 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 35E701D000AC;
 Tue, 10 Feb 2026 08:30:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 10 Feb 2026 08:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1770730242;
 x=1770816642; bh=9djtnBViHqbzwcXlqsK06ONJawBpARYo9m/xbhhGq74=; b=
 YW8rFJZSNwGb6Qvum08ymTYuKOdNjX56/1IQmRExIG1WMMpvXczkRL69wYVgevDC
 6v6BwDOw3iVKdGyrtfdwt7uRQY3fIu2uGZ2cv8uoxVizDR6NKtGLNgbYeT6u9XP3
 a/vdrIgs/kfaGYUaFJZmxRBVZv2zLX2Ae3n1O7Kf44Q8TUjHQEM0BabMkFian2t0
 n5hzE+ckiBBjrcsSITDwpzMXF8SkWPBskdUXMDjRKyn2JMkfwuFCybTCSbRYa1qs
 CUMCB2GkcxeeGNib/D/zHmw3tA7b9CnHfa2b8xn2M22ykCIbOt/OpoyiO3Y/Vaoe
 W9LJRRQyiXvRF712+3JUXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770730242; x=
 1770816642; bh=9djtnBViHqbzwcXlqsK06ONJawBpARYo9m/xbhhGq74=; b=F
 fsrGP8Htu/dJNduSnx3o4LQQeX9CTmRoTfNoEka6KyzwXTusXkkPxFDOihMvD3H1
 +l0yPSrRcair6THvNTo4rVCk2XKoSKExvG2kGyDNvPWKp3VmOVVhLLBazESltobn
 ekBKmLNHp7WHJF6fYOGiz8104PmbhW3fbnl4vaSiMJmjwxiR+eRNcoaCRiIOQ4Oq
 ydVgcOZhVP4Te26rdOtq2yz7ERZ2RpQc6hrpMk0La1QU228cIL6hMxpMOJ99IaLV
 jccqrRkHLn8PecI9+qqpECXbNlVhnDv5gRkt7naDHaj/SyiYCPO8Y2Y5PqjXxqa2
 bh9991dFGcsrXcEzy7D8g==
X-ME-Sender: <xms:ATOLaehQolVur8ccTXS37gd3fA0plbN3P-6Hb70I39x6sA1tURYddA>
 <xme:ATOLaacwQ19ag6lBPh8hP6zdskPgMgZ9hvI93Dsa8ceVqKjGhcPGp1g8KPhUIZ2bW
 aX2Sff-2lWfq4OStmAd5xOngSZhzcCbMmcoEvjIoFI_VPZYYsld6H4>
X-ME-Received: <xmr:ATOLaZnUMCEiWKSpCAcHA8jBTLfj01Hk7AS_6293Fuw5qEp1fJEc8SUOcJpIUYJ6phDyfLBAMHJz0343Kmeba8gbXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelkedtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghhlihgrnhhggihinhhgsehhhi
 hgohhnrdgtnhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehs
 thgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphhtthhopehfvg
 hnghgthhgvnhhgfigvnheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:ATOLabvhBMcy0Akq4SEnOK_HoaCwt_70gIznfPdoDy5tq1yAEHSeVg>
 <xmx:ATOLaX-xWAWWo1A7C7bTi8Br0RC-KgMqy5qgqbUvQ3p4sJKmawo-ew>
 <xmx:ATOLaVPX8D4fkbFlRPMPnfrG0UayqLG5_SN26248G6bBwttRKFcthA>
 <xmx:ATOLaVH9md3C1MaXTNKZLHMregwUNmEDDMVqNvpd6_NNIpHSVAHneg>
 <xmx:AjOLaTlykgp8xb3ETH1fed-qLsEb8d7TaCOD9mQayiVEXH4ZUfV-cLsM>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 08:30:40 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Liangxing Wang <wangliangxing@hygon.cn>
Cc: dev@dpdk.org, "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "fengchengwen@huawei.com" <fengchengwen@huawei.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Date: Tue, 10 Feb 2026 14:30:38 +0100
Message-ID: <12551721.nUPlyArG6x@thomas>
In-Reply-To: <5c38455874a1433aa34842391525e8a5@hygon.cn>
References: <20260108072919.1279731-1-wangliangxing@hygon.cn>
 <15656361.tv2OnDr8pf@thomas> <5c38455874a1433aa34842391525e8a5@hygon.cn>
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

10/02/2026 11:15, Liangxing Wang:
> Hi Thomas,
> 
> This simple series has been without a delegate for about a month. Could you help have a look? Thanks.

There are more instances to fix in app/graph, examples/ip_reassembly and examples/vhost_crypto.
Could you fix all please?
I think you can split in 2 commits: examples and app.
In the case of apps, please check it is not increasing the memory usage too much.
Thanks


