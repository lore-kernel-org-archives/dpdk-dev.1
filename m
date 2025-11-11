Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77236CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:14:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA12240651;
	Tue, 11 Nov 2025 19:14:35 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 849954026D;
 Tue, 11 Nov 2025 19:14:34 +0100 (CET)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 894A61D000CD;
 Tue, 11 Nov 2025 13:14:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Nov 2025 13:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762884873;
 x=1762971273; bh=sd6eO4ONnUKoCipZnI1Fo9/aEGAHsVuy8wuwJgRqVUE=; b=
 iTKM8qW6YmGkulfwe1Er3NjvIvmjaWLVW8ZHC4oVEjH6Ox11ej4Qkv1w5NqGdt4C
 p5ePbQHMN882B+L3BastBru4JvArNp9DV+PNZN0XqqkYw7uqZdKq5FlTEaLLupI5
 I4IMJvx3ZsCCd7f/pjy1El6mIl+FTOKVRcIWqdnwAQwOd2Pz/gU1Wh+HNqWcupsm
 ew7i/iAugXOdgntd2xKAcOuMNTOW4CKoTTWKCIkbC1ttq+wUsYCB5MQi7LBi9Uqw
 LYgk5ZYt17wPG6ZCdHt40YK5Qdbb6SDBcIot/klPaklILi7qo/YKFOcvlmI64/ae
 +TK7SqZfgnuAYPUlQC8zsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762884873; x=
 1762971273; bh=sd6eO4ONnUKoCipZnI1Fo9/aEGAHsVuy8wuwJgRqVUE=; b=A
 SkL8pghC3pFLOIuCAQALW/zoy3avSFh5nzAwkc7Q9/va55LuuOh84SdhScwRoTgj
 mbBpWIvJXRaV+tu7SZ6RKrkSCTyXcr56aUYx4u/4zOfeShDqL7ZLFvWgt+uH3Wdb
 YU7R1y16caNVOMc71mTTZS5Xf9UQkB6RIUZNx4nLfMr8E1ve4jiRZHRMJnFm6Nss
 B1TeW1GP1J9pC3tjGgJon3YDDhS7Iv+2DdgjBM5JOF/6wWcjWeISu5/T8Nth8zxx
 Qlq4LpzQsV3Nmd9gXS/m3HF8tmx4jGacD6pGClLFkZiEnCzfNfEWrG1AYHKe6JF6
 yI5lXDGTaVV07pvAcMQiw==
X-ME-Sender: <xms:CH0TaWQyjV2boE3T9Cd6BwxA7BZVC2mpnOgEbtrT_gQoYejy44OsEw>
 <xme:CH0TaXOaKiu7WOuaeFrAvPKiCMBEFkqlpwvlIUXOrA8FfoBIMgH3e7Wu13l_qbEuE
 bE_1LHOlbpcHgVn6d9jpMCSHFGr7lP3d8WUweODYsQFjlRyACdbMg>
X-ME-Received: <xmr:CH0TaXUo1ks7Pmj_tfkVt3BcX5cX3UOiAfzdG2roBa6rxjhFlU0YcdZ_6KAEpzE3UUkdVNWvGcpxjXPM-ugL1p6cdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddukeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeehpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
 epshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopehfvghnghgthhgvnhhgfigv
 nheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:CH0TaWc-kY_XhvfgP_QqP4ZoxregY5CD_HmerXMvK8rBq_hggm4lVQ>
 <xmx:CH0Tabuu7hqO8F2VZQoVJ1zjAz-3AOfB1wiXTipiajwXOTsmTPDnkA>
 <xmx:CH0Tad-RoaxbktPw2haN-6pI4pdzdekCGdWr5BXicwcdLk_ndOl_uA>
 <xmx:CH0Tae0yg7rDsn9ytmj752_GpkfHOKQ_kgJsp9AfEWzz5ormoaEsjA>
 <xmx:CX0Tad6YndVGisc8rKEvScpPYdqpwmda8Zla8UDXxhokcG78oHLn-H4J>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 13:14:31 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, stable@dpdk.org,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: Re: [PATCH] telemetry: make socket handler typedef private
Date: Tue, 11 Nov 2025 19:14:30 +0100
Message-ID: <6375554.3sPnXxR9tc@thomas>
In-Reply-To: <20251107093259.3305537-1-bruce.richardson@intel.com>
References: <20251107093259.3305537-1-bruce.richardson@intel.com>
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

07/11/2025 10:32, Bruce Richardson:
> The socket handler typedef, just called "handler" does not belong in the
> public namespace, especially since it is unprefixed. Rename to
> "telemetry_sock_handler" and move to internal header.
> 
> Doing so also clears shadowing warnings in dmadev library, when it is
> built with -Wshadow.
> 
> Fixes: 6dd571fd07c3 ("telemetry: introduce new functionality")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Chengwen Feng <fengchengwen@huawei.com>
> 
> ---
> NOTE: This patch was originally submitted as part of series[1], but I
> think this is a serious enough fix to consider taking into 25.11.

Applied, thanks.



