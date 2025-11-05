Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CFBCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 10:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B9D140673;
	Wed,  5 Nov 2025 11:20:08 +0100 (CET)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
 by mails.dpdk.org (Postfix) with ESMTP id 70DB9400D7
 for <dev@dpdk.org>; Wed,  5 Nov 2025 11:20:07 +0100 (CET)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 02020140025D;
 Wed,  5 Nov 2025 05:20:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Wed, 05 Nov 2025 05:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762338006;
 x=1762424406; bh=qV9lvEQBee4VtiNrFV6DuLIHPmkuU3VZALyTQKjLC1Q=; b=
 SvEDIFdGo7099vn9I72Xa+wpOAnOlX27YmYQhxa4SSutAno3BZncDqi854p9STKL
 FvH1KabVpUCLYykpWRJOGdAHyhIRFuZoFDkT09o8TVWlRSkJIR5T3wpVVlE4e481
 GsD8pNkrAHTY/8FH2COp0PjTn1oJx3Ip5VE1C5/hC9QjRpjM3oCnmDjw+cWv3hDp
 g8JEQCVUT+2duL106ZZFStJZ9dJEx0Knl4yhp7beR3SCeQpa3tPwxrsMltlFk7cR
 kGKnrsYWGTL05BmIvjSFUBBZRK+sdumehMsXfBB76ALWrHhuDwbkDC/KI8SHb9a5
 PpFNhabEUuUZ0O/uBXKTMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762338006; x=
 1762424406; bh=qV9lvEQBee4VtiNrFV6DuLIHPmkuU3VZALyTQKjLC1Q=; b=U
 U8gpC6f8J0G3+piX2zX/HrsYppHyjvLxmq6E92RWMp7NXtFB6QTJ8Au1y/4ekK2l
 VjYHWizLKglUea8juzL5HDErt8qxy101NupCf14GAcC3B2jNBGoe2iiZyH26WXT/
 deloqefTwl27UYdgnvRkSM5uIkzgbdNotlrBo9q6n4ovytmprL2wD7+1909FfFEf
 me+ma5pcUdKWT+DpBxer8dhIK0bxRDWm2q13Oy6o/Owy0prXwd+qgs4/t8cbUPWo
 VRtkcBVCZxDpCdPPFYBXwz0qNXSy4GkK1twZuksMDs9TPnRMLZjZuVXB5IDLTkpL
 Z8KuBuRl9ppr2J8uuIbdg==
X-ME-Sender: <xms:1iQLaWD5LcMt0W7A-7SU5aCJ8D9yUbN9ze_MQ2UcPiveP8Pg1778Vg>
 <xme:1iQLac1ayk7zz1iu7kpIhwEYA23AoIqw8Amh-_WFNJv5Rmtt88CDSufDSQCq40LTE
 gLhuNU4xUts7DUhhMbKYpM-tbpzx6BJ-4oGEPQbCvJFk3pZRVCAtg>
X-ME-Received: <xmr:1iQLacXgt-NQ5GVEVn21GPoV_mK0mAhhJhzrf_YlOdAXMNr9abL3yfh9NeUwZMuOMPhS1kU4q5w4uu0kbAj7Ni6hHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeefieegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
X-ME-Proxy: <xmx:1iQLaWlRaw37gLz9WRjZoaWCGiUklGrvT_W47AO6WsMPXAMrCXJMQA>
 <xmx:1iQLaeD16nDV6w_FjHA16RdZtAp7TsmHnSncTm-er0YVXvdydHx6LQ>
 <xmx:1iQLaWc5TD9Q8YXvQmhkNqg5aLBmMHxzVpAZe7K4n81HgX4IywLTDw>
 <xmx:1iQLaZJ4wZVEuMiKbDRQjGA6MQKtEDOEDgz1u4ru-N64b6WGK_jIdQ>
 <xmx:1iQLaVxroMuw-g_33slHp7l7NBwki_l82ANXb0NPsHr9tULrzsKRrjO9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 05:20:05 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] test: support SVA copy for dmadev test
Date: Wed, 05 Nov 2025 11:20:04 +0100
Message-ID: <3103453.7eYt6pKtYU@thomas>
In-Reply-To: <20250918082025.17173-1-fengchengwen@huawei.com>
References: <20250918041534.38227-1-fengchengwen@huawei.com>
 <20250918082025.17173-1-fengchengwen@huawei.com>
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

18/09/2025 10:20, Chengwen Feng:
> This commit supports SVA copy for dmadev test.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Applied, thanks.



