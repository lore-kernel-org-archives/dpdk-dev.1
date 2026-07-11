Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B5BC43458
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Jul 2026 22:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFECB40274;
	Sun, 12 Jul 2026 00:57:51 +0200 (CEST)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id 730494026F;
 Sun, 12 Jul 2026 00:57:50 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D2D8E140008A;
 Sat, 11 Jul 2026 18:57:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Sat, 11 Jul 2026 18:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783810669;
 x=1783897069; bh=US8OTLTBG04EbW0UHUbqqmbUkGWBJYU0n6S3sWMM4D4=; b=
 REzvepql/zzSrggAFyDru9ax1x1Er4CSrmxgikgbNzP0nD6LdaAEyuT5Ky1rEbuH
 7XDFojNmLvS45BsgDEmr65BsF2v1oWhDZdf+12zvu60Q334asklSYYxA96E05MuK
 xWtHK7bjjGfmaKZdh9tjhj/O7wmOANFsGA+QxBMvHY8GDqpayDvTrMkVKFPG9CQ0
 FsCMb4zQ3aD3PRHI7e48L3rXZ0m8lVTzl85QDNFFvW8cU4uYQ3P+Ieciq0H2fS/7
 gojCZIulNFo2VEjrbFBNdzuYjRLfuPUfeHPzmxx7E0wZfCgN6uUJSFi4bma2Xq/g
 FA+FnsxyNzSlEPMGb3feJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783810669; x=
 1783897069; bh=US8OTLTBG04EbW0UHUbqqmbUkGWBJYU0n6S3sWMM4D4=; b=i
 f+aWujBaFnOybsxXWwdWpk0jl/MrQhEQ7oqQ3SKVjo8N4u4oLPMz/VZhp4ESp8JM
 LNidpTJ2YCX02nXH/S82JBBN8SiusIjd+lYv1zaC2ig4QFC7kCmNHNj69Wg7G4Yt
 IRzBJRaaERLQYBiVonu9iuULsOh1kpdMMBhnclzcGQrM5xXD7Ai+vOEvqPu76HzA
 qnCYARZMcSV7fAhexjBUSgao2k4beJlq/o3w8q7F8eok29J5KTVnN5XUgVZHM6UA
 br3ME9nR0mnAS0C2dIxJCNLQ7oIm99YEDK2SbqplG8rSkE29cL6zGh5API2AVi8u
 xBY63Hvr4eaKTMYvKurpA==
X-ME-Sender: <xms:a8pSatBm7-m5-ghqng0h3J9IDHCk36-7XNdHNZ-v9xHCQzcrO4ZFPA>
 <xme:a8pSanN2sOV-717RtOhpsgwETnq608O4_guCDd3Y2zt3qNqoTy3csIcvRPFcWKbRO
 HvjxvtGhhjGbxHyO9zse2055KK2vPM4JaU113kVhhjcRZwSwiWcSQ>
X-ME-Received: <xmr:a8pSajQa2t7wMR5wFYLR59DMyvHgCYsD22u4DJII5BTHQ4Oz1DXFSyq-UCdiRs7_eckR3zufVOitklSe1Q>
X-ME-Proxy-Cause: dmFkZTG0CopQMSNU4Q3tC0c0216gQK76I7/KCvBF5UEwOxUkvszT8ZXF3uQkuSJlstSPqO
 KMughSHq6F8rkxo6jvMm8zfOrUJnHhMdeIcCFlM4p+/tMnK9TILhLf3XTOeLm0ZFgP0r3U
 oycWXPviYKA0iXVK4zV4W5VDG9Ed17oUIKRuEEqVZD6bz2twfcWXHZm279nH6sbj7YrXkj
 BMaOK55mQDw+2svi1d88eSQ3mLM4L0CTn1kStbID5NHQZwkjZsTjk/ZyiBFldOfxQx5O4g
 mXnsEJ6Lj3lT2AlKfkFnQSHMLsQgrJI4LZSIKt9JDKKKFE/mnrTh3AC10jZanp0k/DcTK7
 NeAmSYASWnHMMIIS7/rCyIveXHNnXCi6vr33TM4ntYuIVgHOnuwu+Eihg64tiKcUZhzngo
 c6qVGvsWDlQNNDxibL4LTS9KArQkUjlZs6e1Wm0kBM31w3s7Kl/gcF9VXTZkjkIDUSPbAG
 wmxHlHte313iLNr3y24hH6Bozx1j1Jr5G43934ADqMZ/Ubz2BF/lNlXwmtDLDejulO0MVO
 yVpBM8xgK90YAcX9BOBrWk58OxGwMyGmSnWxsmOCV6y9Auf0z+L1QG5/wUXb9nQZP+dwOD
 RfKtkzsnzA1fmKcqZHn+QTrC+BK+HJY8EkXtCrbbLlZUSldbpdeTH2vHN33A
X-ME-Proxy: <xmx:a8pSaosnguSNszUjTvfeuUZKqoBvBve8c2s6_IfYlDfAbXfLB78kDA>
 <xmx:a8pSahX40oHqHFY-zKCrDa_yjDReEwwldQhnAhOfwPJoLE4UDvJ2tg>
 <xmx:a8pSasmP7ixDiTEhlal9jEReKvcqnoU-lGJJUlaowUjMY0W6n1h_Kg>
 <xmx:a8pSakAh1iBvPsgjbdpaI2jW7cBmGtGkoO58TiLlhBHg3eUpyADvgw>
 <xmx:bcpSas0gELpfjWqm8E8xHleAnTfKulQVypafB1CdmXp0DVQbmIgtVPrk>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 18:57:43 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kai Ji <kai.ji@intel.com>,
 Cheng Jiang <honest.jiang@foxmail.com>,
 Chengwen Feng <fengchengwen@huawei.com>, Jerin Jacob <jerinj@marvell.com>,
 Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 Michal Kobylinski <michalx.kobylinski@intel.com>,
 Piotr Azarewicz <piotr.azarewicz@intel.com>,
 Marcin Kerlin <marcinx.kerlin@intel.com>,
 Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
 Declan Doherty <declan.doherty@intel.com>,
 Aleksander Gajewski <aleksanderx.gajewski@intel.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>,
 Guduri Prathyusha <gprathyusha@caviumnetworks.com>,
 Harry van Haaren <harry.van.haaren@intel.com>,
 Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 Jiayu Hu <hujiayu.hu@foxmail.com>, Yuan Wang <yuanx.wang@intel.com>,
 Anoob Joseph <anoobj@marvell.com>, Xiaoyu Min <jackmin@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Yuval Avnery <yuvalav@nvidia.com>
Subject: Re: [PATCH] app: remove use of strncpy
Date: Sun, 12 Jul 2026 00:57:41 +0200
Message-ID: <k-KIiEGMTXip2iNpHfk9hQ@monjalon.net>
In-Reply-To: <20260623145028.711712-1-bruce.richardson@intel.com>
References: <20260623145028.711712-1-bruce.richardson@intel.com>
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

23/06/2026 16:50, Bruce Richardson:
> Use of strncpy is not recommended, so replace it with strlcpy or memcpy
> as appropriate.
> 
> Fixes: f8be1786b1b8 ("app/crypto-perf: introduce performance test application")
> Fixes: 8ecd4048ba5d ("app/crypto-perf: fix string not null terminated")
> Fixes: 0add6c27cd7c ("app/testeventdev: define the test options")
> Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
> Fixes: 1e8a4e97b057 ("app/testpmd: add flow dump command")
> Fixes: de06137cb295 ("app/regex: add RegEx test application")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


