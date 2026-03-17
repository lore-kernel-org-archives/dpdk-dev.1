Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80054FD877F
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Mar 2026 14:48:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB8DA402B0;
	Tue, 17 Mar 2026 15:48:11 +0100 (CET)
Received: from fout-b3-smtp.messagingengine.com
 (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mails.dpdk.org (Postfix) with ESMTP id DFD6640270;
 Tue, 17 Mar 2026 15:48:09 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id E6B7F1D000BF;
 Tue, 17 Mar 2026 10:48:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 17 Mar 2026 10:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1773758888;
 x=1773845288; bh=XWzpE0dJtG8wThMB01qppbefVfVGlTtY/pWCDf/gsao=; b=
 ko8b6vSkenSziSK/LGAwlBFfylTMGxffsmxEOJeP/dMSUXJgIJN94bJ2gJLndKI0
 61LydeiF7QGAQSl9rg9xA7I8DlAEYo7UaalszRIswuy4gS62dmgG784N/3cVZ00Q
 uKlT32QBCjPo4UjwVtT20JyBdmUvgiYLydqVKqqOCio9Vx60RlCy/hEXyAzqNxd5
 0/btFM+h1efoPfGS4QOBA9CV/D5dbO4FzObswyXhNQP7AfZnoXM0dawCrQlrMLLX
 9snHJeqQ6cknZaQCG05vngXuXtaK9XjrCwOdG8WPFEXgIuo+XL+IufY4gGlfHltM
 Hy/ulLTkpcBej+R2zrokdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773758888; x=
 1773845288; bh=XWzpE0dJtG8wThMB01qppbefVfVGlTtY/pWCDf/gsao=; b=a
 oCnR4Cq0V0J6Xt8RCFhv6PFLRXzYyWfJ2YWHrVYlDwJN0l6xnXgRO/jOOTIhP9zQ
 4vnYx2tdbTcjmkVbkQgOJg7lCAjZxk2Sd/KuMcxes0zczs6JUSBaC7fFuH+7j0b5
 fyu6jaVy1mU+LOlptN+Ewfw7XxRVHUv/R/Ol8Ntf9lTXlFjPyl8zercd9Tr1zIy9
 c+eECouQhASM44iBCSs1BH6wTe0r/eOCNQ2PJHkI3uPLpa6fysixwdX0sziwCMTL
 4gaHA1LMCEBEQFOq/LNTTxVN0W3z4bWK/BZJuttE2IWwMPrEmAwGLWFWC4BCSYTb
 c7PSPVT0ngH4ivey4dK6w==
X-ME-Sender: <xms:p2m5ae2Ux08FU_DUbdon3XWRMX1LVrfW7RmNXNZ7AG8ahiERCynOmA>
 <xme:p2m5aaCwPxyAmhv53x0tfKIHnGL37qhcDoHENCRTSoQgC1tSQS90q0TCjQ5uUmaS1
 btOd22IbfBiBU11meHz6hTsgsy6T-g-SSQSjHOVUpJoXKjgi2XxdA>
X-ME-Received: <xmr:p2m5aSc8hylx8Xso6dUkDNin9qQGGUPU4SOl3Zs9rAd4UOyajBdnC2l4mE1MtYpTS4FCCYVtPdrp-R9dQVx1CD0aPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduheefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeeipdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeifrghnghhlihgrnhhggihinhhgsehhhi
 hgohhnrdgtnhdprhgtphhtthhopehhohhnvghsthdrjhhirghnghesfhhogihmrghilhdr
 tghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthhopehvihhpih
 hnrdhvrghrghhhvghsvgesrghmugdrtghomhdprhgtphhtthhopehsthgrsghlvgesughp
 ughkrdhorhhgpdhrtghpthhtohepfhgvnhhgtghhvghnghifvghnsehhuhgrfigvihdrtg
 homh
X-ME-Proxy: <xmx:p2m5af7nBGycdcf9p0f-8bUX6ZT5Nj85jFgdCM6mmDQk6oMOubJljw>
 <xmx:p2m5adVVcNHKn-YsLdq6nu8U7MiRxBJY0IgZk1v9qPVGwEjrqvIUBg>
 <xmx:p2m5aW5ZO9T6DcTUceMiNws2MiwVJsnKCSUPkDdAm8fmpgBKrVj5LA>
 <xmx:p2m5aQq3e-uKF4Lo6dft-XGVXeVJi8j333oHUn6jGZyY7Zyo7fng5g>
 <xmx:qGm5abDQob8wwEmMPlM3HsEPHB1ifxOe-MImAYRsmkPvKXZfdUhT3D-K>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 10:48:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Liangxing Wang <wangliangxing@hygon.cn>
Cc: honest.jiang@foxmail.com, dev@dpdk.org, vipin.varghese@amd.com,
 stable@dpdk.org, fengchengwen <fengchengwen@huawei.com>
Subject: Re: [PATCH] app/test-dma-perf: fix reversed src and dst for memcpy
Date: Tue, 17 Mar 2026 15:48:04 +0100
Message-ID: <2293419.1BCLMh4Saa@thomas>
In-Reply-To: <544edfc3-0e6f-4c57-8b6b-8d937dd0be4c@huawei.com>
References: <20260303091804.41761-1-wangliangxing@hygon.cn>
 <544edfc3-0e6f-4c57-8b6b-8d937dd0be4c@huawei.com>
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

05/03/2026 01:41, fengchengwen:
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> On 3/3/2026 5:18 PM, Liangxing Wang wrote:
> > Fixes: 2f2f7af66791 ("app/dma-perf: fix crash with IOVA as physical address")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>

Applied, thanks.



