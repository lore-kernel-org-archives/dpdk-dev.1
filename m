Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBDC7EE39
	for <dpdk-dev@archiver.kernel.org>; Sun, 29 Jun 2025 18:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A340940288;
	Sun, 29 Jun 2025 20:11:28 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mails.dpdk.org (Postfix) with ESMTP id 6A11A4025D
 for <dev@dpdk.org>; Sun, 29 Jun 2025 20:11:27 +0200 (CEST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.stl.internal (Postfix) with ESMTP id A60177A00B2;
 Sun, 29 Jun 2025 14:11:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Sun, 29 Jun 2025 14:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1751220686;
 x=1751307086; bh=ww69qsfePfX+sb7Qu80+BFqGxq3hXlOE3T/pFE65eh0=; b=
 EBYhiLZUXB2fpq/FN2VnnNnPLl6fd2/zK0ex9k7ufGEqC8LP51GW5w9ekbiwBWUb
 GVUucHV+0fyRPR11b+Jb9FLyc8cEkdjO2+HhQttcOgik7juuxknV3vppd3wJ2gfQ
 TUnxFOJUhToSvf6TlLx7lg/WV9j0bHlgCRhoBoAMljg704pO/CBgc/GIOp+FuOaO
 74y72ZEVsix0ltsKxp7+i5iKWUn/v61YHMgqPQ0hVJucBV5PG8mpMPlNzsOc+Si3
 QqDAOWzVZjOg9gZYp1l2LlnCnimO1mvYJmj+OILOCrS6wS7vfkFBVldTcj1fOP02
 EkGkF0vrz0g/tne59GmXMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751220686; x=
 1751307086; bh=ww69qsfePfX+sb7Qu80+BFqGxq3hXlOE3T/pFE65eh0=; b=i
 YO7kyFPg7rrjdAcA0OOvSYgTZ1nZyscrjNPJK7p38qDoNNKhG3Bm2Dzgh2ipkmRI
 YT8ntMOZnwTgboMj83wLVitzPudV+iMRwyOFiPkuhbnX4L/eWaPHpTfH1UlWlza8
 qJjeZGil8fTiQHa4HVrI2jO+sd/DecS6UrXPFRqp2ZhBFkYPIEmg3NwLT1AMNvC6
 ztZYF+3GROI7ag5OlX684Uuje80JNlkSg7RjnJwIHwaY1njoFJjRfEvDg4Ygbi1l
 nTVw21HAXxEzUr+fZHJWrDH+kbUug/oomHy2bMWast7pcSOK0YgwotYggOZFkJ4X
 PzKwTQtJm9yZx95P+StOQ==
X-ME-Sender: <xms:zYFhaHWfUZdIDJ7fZz9raMQTut_a2iQyVos7UdlXxhDM0dNCcpapsA>
 <xme:zYFhaPke1oCG0ZypJS6L__ZVZBENjy1uc-3p3R2iidAWnierpwDyuRWmjr-3MMSS-
 ZmJo9_9eO6j2Qj4QA>
X-ME-Received: <xmr:zYFhaDY-663r1JRLP62XtFwR0-_9I5eg0R0n9dnC19zXkwkJSJpgp6Jcp4BFTF_QVXBSwZBCDuR7ufJY-tg4j32wQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 ephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfo
 ohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrg
 htthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdvuefg
 feekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopegsihhnghiisehnvhhiughirgdrtghomhdprh
 gtphhtthhopehvihgrtghhvghslhgrvhhosehnvhhiughirgdrtghomhdprhgtphhtthho
 pehmrghtrghnsehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdroh
 hrghdprhgtphhtthhopegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghp
 thhtohepshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprhgrsh
 hlrghnugesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:zoFhaCVtudkkwyG_sNmzuUQRiPFkfXnOu5zTS2GoqwZABQMcRETfXw>
 <xmx:zoFhaBl7Yjy6d1DneQ8mTK-0ZHa3LAjSW1v0UvUD0uu45oUviIGo5w>
 <xmx:zoFhaPd7edoRpBgfxIICmWZUEebrNpwpa9-De5DmjMhHQBs59uA37w>
 <xmx:zoFhaLFDaxddVhzdQzAxA2ktvLhsUmPQVWQHT28VBqtMjNxeTAJwmA>
 <xmx:zoFhaHH_mtEtEV4lkMPuGHXpb-1pOQjMbVL3M_1_Rzd6EdEOIWRSVizn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 14:11:24 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bing Zhao <bingz@nvidia.com>
Cc: viacheslavo@nvidia.com, matan@nvidia.com, dev@dpdk.org,
 dsosnowski@nvidia.com, suanmingm@nvidia.com, rasland@nvidia.com
Subject: Re: [PATCH v5 0/5] Use consecutive Tx queues' memory
Date: Sun, 29 Jun 2025 20:11:22 +0200
Message-ID: <8912871.uz5P2jW1tq@thomas>
In-Reply-To: <20250629172303.72049-1-bingz@nvidia.com>
References: <20250629170709.69960-1x-bingz@nvidia.com>
 <20250629172303.72049-1-bingz@nvidia.com>
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

> Bing Zhao (5):
>   net/mlx5: add new devarg for Tx queue consecutive memory
>   net/mlx5: calculate the memory length for all Tx queues
>   net/mlx5: allocate and release unique resources for Tx queues
>   net/mlx5: pass the information in Tx queue start
>   net/mlx5: use consecutive memory for Tx queue creation

Applied, thanks.



