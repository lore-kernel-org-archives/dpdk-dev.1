Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A431061B20
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Mar 2026 21:38:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82862402D8;
	Mon, 30 Mar 2026 23:38:39 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 77B82402CE;
 Mon, 30 Mar 2026 23:38:37 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DC3141400243;
 Mon, 30 Mar 2026 17:38:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 17:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1774906716;
 x=1774993116; bh=ebwYhIJl7hn+WqVr2Q1VxHNRKB1BjpA4rremGqHJIlo=; b=
 hNXllk96+oBN4qab/Li3BDtoVHAuuR7UurNHGGYQupUMHOYEaRFp3Nggb0ObOqKi
 CLqTVNSbF6OS15paovm6RZaSn4Arzb0ZwGllUuC7WR6q5sNb5NeIYE8JSKh2jLMh
 gXPQrbp9fL3Kyd1cP6qGTQDuBYSlbCZhnU4M6SsDSTnPTBXW32aM04LUYSv5ZWwX
 o2Xt4+Ge7FaQZnAjS8ngrN+1C8eZD3ftrCWme3B1YJUlviEnsR91saoGmK1uNO79
 5BNdE2vxHZ4KvzDTyO6GN1wrIOMObfZPbfn0cXc9orgNfzd7EWTy2oLnnw0neeNq
 b6XtMrvmfl0Y2X6893xoTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774906716; x=
 1774993116; bh=ebwYhIJl7hn+WqVr2Q1VxHNRKB1BjpA4rremGqHJIlo=; b=5
 bZs/KET5hCkw5gXk7LuUfbHvrwgN4A7K1SZCE4r+BU++8y1tlaTFg+HLtdEkfSb5
 HnlzWJUCQQxRepUFfQGNaiQcimZG/sgMgrU1PBCE/OkqeHLbuwF3K5lTcwGw0Bk2
 fNwt+Q9S9hPdROa6JZqvM6c8qoqwDXo5J8fxUmd4wZNSq7sO03VX13q+ECXQC7li
 kZa6gUQ9XWyevENxZNCOlw6ljOZRCwp+Xe6fYdllUHttgO6uK7gadOC+Q89HoZk0
 D+1YEJjQNCkTXFypvVT925YBTYkMZMdU9wJYkBvqhDhpdY2rW2HhKc0eENt7b0li
 XUFwk+L7BRHn3ah9X8e4g==
X-ME-Sender: <xms:XO3KaSaVKAwji-ejnrs0FMmD8gfiaXp_WhjpVVFbURKo5ms3dJcsvA>
 <xme:XO3Kac2cIcj7SxjgVK4ACNB-6z3CQlstVtV1uIpguEW9sD5juCVHJzlcbyljkjoNT
 hbKx9M1uHFE7cQdVjkVO5HCRs7KBskLXEg2yNN-E1AIWB6NRsR87zE>
X-ME-Received: <xmr:XO3KaaX5qfBoLkBx_3sGM3WtmLeANY75j-dj4QE4JRav50I2Z6QdlfxTSd-KhdchnWWMXdSU2_OFoJFytzUe88PsPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedttdelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeekfeehfedtgedtjeehueeutdfgleefieevkeeikeelkefflefgtdev
 ieehheffudenucffohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdr
 nhgvthdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
 eprhhilhgvhihfsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepuggvvhesughp
 ughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:XO3KaeUMkFFKRt3UjkfWhouJhngwpX1gJgRREii2lr_ZHxvY_5Ffkw>
 <xmx:XO3KaRe3aAmO4XR0H9jPWMeGNUY3YJr9EzFvfke34d8FeVJrwBWFyA>
 <xmx:XO3KafUf2tugoAQ3F8OyXACUDhAypVjXjNC0Jz2vYCJcUjXUNiv9uw>
 <xmx:XO3KaSfDRO7APaKvBuCsy0vXS0Fo7n94uCWVhCkXQq4U5-glJjYDKQ>
 <xmx:XO3KafxskLe6jauT0iu2jAgrIvT0Fppov0xyIT4wYDbkdhRyWE5Z4tzj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:38:35 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] docs: add Power10 testing to 25.11 release page
Date: Mon, 30 Mar 2026 23:38:34 +0200
Message-ID: <7090434.rnE6jSC6OK@thomas>
In-Reply-To: <20260317155538.1282864-1-rileyf@linux.ibm.com>
References: <20260317155538.1282864-1-rileyf@linux.ibm.com>
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

17/03/2026 16:55, Riley Fletcher:
> Adding previous Power10 testing results; can be added to 25.11 docs as
> well if deemed necessary

Handling of this patch was discussed in the techboard:
https://mails.dpdk.org/archives/dev/2026-March/334925.html

Applied with a note and Cc: stable, thanks:

* IBM Power 10 with NVIDIA\ |reg| NIC `[added in March 2026]`



