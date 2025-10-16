Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94397CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 08:08:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E166340684;
	Thu, 16 Oct 2025 10:08:30 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id A1049402C3
 for <dev@dpdk.org>; Thu, 16 Oct 2025 10:08:29 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BC4807A0083;
 Thu, 16 Oct 2025 04:08:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 16 Oct 2025 04:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1760602108;
 x=1760688508; bh=rmSLtW50DCiMVBsx1jtGRfhViPVCLmfUcXJ4UHjRZXo=; b=
 Qdo8sAnUXmmjEGeVbNrKqwCQhlvA0+nwE7Mm0Ez69R1ANDo78tSWvqmJGi80mNhz
 2/7Ce0VqkLqFsycP9n9luSO4gUwcsb2XV51LuuxQ+gIDPS4ICSmJtrwK6G5E9yh9
 Da+HX9GY5VGT4L+ryhobBlgHWGh3BvzqJd+YzFliEKD5KBxEmZq2NQQeC3a0sfMu
 E3MKc65v3RQaWYR4vE+hQWRVNp0SyEotUhCuLT8XqCT22wrTTe71X0Cz9JRAplDH
 +mkz8/fixeOqgETpP/LMjKynMo4RcwWB06bKI1zkNKIS80yO/umou+VTkuMEZW9X
 oeZtXbe6i9LRd3feEpcZ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760602108; x=
 1760688508; bh=rmSLtW50DCiMVBsx1jtGRfhViPVCLmfUcXJ4UHjRZXo=; b=f
 qROCsvbViC9ELmoDFTfvMYBYRoqonCPE/6aTlXkHx1h644BlCzr3oxOeGIYWi6oQ
 rehQsnk4QwwIYh0GL84HgwbzxQlFoNQUDRRnz0zE+qeg1mMOfEZwSrfiUDx78G5z
 Elja22afhI/cFO1C1xPIoRAKpOW+tr1aeP800S6WeIGVeJ3qix/RBsqV0bdMIVJ+
 59Z0lanPeZ9OjH4HsF7/o4pdj5FNm5669ISCak0v/VlI2NCAygoS54Ohj1+a5u7w
 ARbv4+p4XMk5U6lD4pel/cW6QdU1NRwKiPn5xba83laLoRlkfz0yiotcaARYtnfH
 EbVjDLqHZl4+wNIR/v+VQ==
X-ME-Sender: <xms:_KfwaLwRCWGkBPN1Rqk5wT1TU5BgVCMAYD2lHwuOMlWEwCtOOik40Q>
 <xme:_KfwaOOTS2eFea--gspebS51z9TISQDM8HkrnZosBJMbcBdDCOp8xpfbiBEeb2hln
 FAGv6O-VsuS3iF6VmMf3i5AnPS8Mfe0OVxYSsV-4YY0wtpVuspc7tQ>
X-ME-Received: <xmr:_KfwaEVgWB_KX25p3bhFBNiCdu02I9R5WgEvDMymzMCgEl_5ypxrMJlwr-PzOmiaQAhctSpH2MQbCNVOQXdJsBLicg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehjeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehnkhhishhhohhrsehmrghrvhgvlhhlrd
 gtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohepshgrtghh
 ihhnrdhsrgigvghnrgesnhigphdrtghomhdprhgtphhtthhopehhvghmrghnthdrrghgrh
 grfigrlhesnhigphdrtghomhdprhgtphhtthhopehshhhrvgihrghnshhhrdhjrghinhes
 nhigphdrtghomhdprhgtphhtthhopehjvghrihhnjhesmhgrrhhvvghllhdrtghomhdprh
 gtphhtthhopegrshgvkhhhrghrsehmrghrvhgvlhhlrdgtohhm
X-ME-Proxy: <xmx:_KfwaK3_iFMvaoBusPWB4O9Wg02CgvbgExkzCLqHV8KLjcowpQOnqA>
 <xmx:_KfwaKomykvsxeyE_2kZ6yjukINcBbB65uw3HnoY8t_-kNwjVkl1zw>
 <xmx:_KfwaJWgNoPdocDKkyOAT5jKa6HBnVeRTCHOFhrmOD1UUImmWYC1EQ>
 <xmx:_KfwaNYRmXlrt80pI_nynpsz4tT5-IuXCmtdB7fUKIJhw9MVM8o9dA>
 <xmx:_KfwaAsScQuvde3Y6_j90RCJXm6HdUVhHX_G47xYwDKm6_qRw3yKjRV4>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 04:08:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Nawal Kishor <nkishor@marvell.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>, Jerin Jacob <jerinj@marvell.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>
Subject: Re: [PATCH] rawdev: fix device ID retrieval function prototype
Date: Thu, 16 Oct 2025 10:08:24 +0200
Message-ID: <3733472.U7HbjWM52l@thomas>
In-Reply-To: <DS0PR18MB52705A2144204E371DDC6EC4B2E9A@DS0PR18MB5270.namprd18.prod.outlook.com>
References: <20250924055654.1986682-1-nkishor@marvell.com>
 <2509677.g5d078U9FE@thomas>
 <DS0PR18MB52705A2144204E371DDC6EC4B2E9A@DS0PR18MB5270.namprd18.prod.outlook.com>
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

16/10/2025 08:56, Nawal Kishor:
> 
> >> Fixed rte_rawdev_get_dev_id() function prototype and its usage.
> >
> >What? Why?
> 
> >[...]
> >> -uint16_t
> >> +int
> >>  rte_rawdev_get_dev_id(const char *name);
> 
> >Other functions handle dev_id as uint16_t, so why changing this function?
> 
> The spec says that rte_rawdev_get_dev_id() returns negative number in case of failure.
> But in the definition it is returning uint16_t which will never be negative, hence changed it to int.
> 
> If this is not acceptable, what fix will you suggest?

You should change to int16_t for all rawdev id parameters.


