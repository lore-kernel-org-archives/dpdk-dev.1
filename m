Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC4FCFD36C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 01:47:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C69B40693;
	Tue, 25 Nov 2025 02:47:07 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id DD529402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 02:47:06 +0100 (CET)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3CA8F1400288;
 Mon, 24 Nov 2025 20:47:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 24 Nov 2025 20:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764035226;
 x=1764121626; bh=XxCiZaidYvMOZIfvj4yF6ImTbXXmuFmJBhIdPeLSNyo=; b=
 OtK3uFq7q3YO+scZLD61vwnTBnou5BKNxRehGVT/uXc8OGfrnGz5MtRwoRSPpIXQ
 HhzGWARR8b6l80x147NYAbq7iQOm/v15r3ST5J9OPIBAkBVJT8r14fPAkZ+7wn5Q
 UhrcBfmc1DA9Axcwwk/s7TeEp+T6czkewWpeYBPh9cjgt6m+nalCaxV2WWP9QXLc
 lGdf2zRkDGj8xm5n8TRY/p3YIwJ1KiIF+XAZyiSXic/zuWyvSkP83Li+yE8hKBcl
 fV0wvvsfxeuGgxOciAG7J7LpyzwqqIaNZXTrPhEhDU2v80rJTIqy7YIqtdbvifHH
 5mEyik78ROXzk2AL/rkC9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764035226; x=
 1764121626; bh=XxCiZaidYvMOZIfvj4yF6ImTbXXmuFmJBhIdPeLSNyo=; b=e
 JM9Q3li9CvGrDcc5gdXuwxzLUl1b+uETjtMb59MLDFyAowh5l5Jph7w91pbU6FkB
 iGaO0ajpCD0lnatDblHhecxcIgQ5XSf1hTcp28AUlA7cTso5GbrzwG6vVL5gXS85
 OLUHQ4UZg9GPBv83aXR6zMMgLFL85STWB2yzZ9FugHjGsFRUO+Oi3SyNGjMMjTTG
 xjnB/6DOqs6JJj8/QBnVShnMjSbbFK3znhI1+LeP3Gud/R429Itjkr0ouUMpL1IH
 j6pBUZFCMbf4N5tLrX3SQ3KJnYAKdDzwkT9ZMn5CcGYi7r8Dk3p9SayDetXxKf1H
 WRKmdOVysjRPrUcQnipzA==
X-ME-Sender: <xms:mQolaRYiv3lMtgSzB5zPYQZq558yNAk-LI1DYJ_9e_MO_OanEg1jOA>
 <xme:mQolaYjI2hkdp4eUTF3Td7VZ_nXQTULDLjBsJxcKfWgzDscr4xBDHwvkzDHL8iK3P
 tWYipzWqxsM1yurCbqtrMVVC7GUBWaVYqFEC9elN-WX-gWL3lnbsC4>
X-ME-Received: <xmr:mQolab6bhM16mGrqN6UsT3Spgt-N2SHeWSdT7H3irf5WYA5aKwvk0naoJ_6Snfy-OKgjsSWBrRGRT3JsjfUBDaPPxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtudelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeihuhigrdhjihgrnhhgsehinhhtvghlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgt
 vgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhohhhnrd
 hmtghnrghmrghrrgesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:mQolaX7EuV-HrspOXE3HNQHgko2vZ7-GsiYfOc3zJCdYkaYy-Nm70A>
 <xmx:mQolaXfrs36ha82U5mIIVoeC-UI7CI9q-L9OrtUjhT0pT9mjjpUcAQ>
 <xmx:mQolabA5_LShPb8LJEmULWdhLIT9uNktElCTc4cNPO2Qt-OIkMkVMw>
 <xmx:mQolaa_luSbY9LE_5OUgp3toYOmTZsM7FCZfc744bfHmqy3q4v2vuA>
 <xmx:mgoladKJE78Sq13iecsnzPz1bKUSiLc8-FebDP_BvJSXrl127fj_xjeH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 20:47:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Yu Jiang <yux.jiang@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, john.mcnamara@intel.com
Subject: Re: [PATCH V1] doc: add tested Intel platforms with Intel NICs
Date: Tue, 25 Nov 2025 02:47:03 +0100
Message-ID: <5822813.rnE6jSC6OK@thomas>
In-Reply-To: <20251124083418.61881-1-yux.jiang@intel.com>
References: <20251124083418.61881-1-yux.jiang@intel.com>
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

24/11/2025 09:34, Yu Jiang:
> Add tested Intel platforms with Intel NICs to v25.11 release note.
> 
> Signed-off-by: Yu Jiang <yux.jiang@intel.com>

Applied, thanks.


