Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC5C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 09:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7874740666;
	Tue, 27 May 2025 11:22:08 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id BBF16402D6
 for <dev@dpdk.org>; Tue, 27 May 2025 11:22:07 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 5B6A71380138;
 Tue, 27 May 2025 05:22:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 05:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1748337727;
 x=1748424127; bh=3cqZ6STe2s33sKByiWxebbz69351Y1jjuBipw264U9E=; b=
 MurYSlQr5jldyeYSo2mUihXq2Y72flwkAOTpj4UvcgqxpjbMuc3iXQ8r3PVp+AVA
 MRXyh4M8JpKGQwz0Xhkg/BY6S0L+DQ96S+jAr/QoM1iTK4+7OHUqqzJvgKbL7YxT
 gmOYE0cvGWQGZHaW38Wyq2b5NMPR+NmMXXQyQKYhBx9kmcianauBdptRXN8uaDwb
 DbscOUMWb5Y67GjfsyESHoZO1DJpNWADj1Km6JoT4j9KVIiAQxmafaAD0DM8ydSF
 tFu7nSNJCDn4Rj32RSNFO9Y5B3WbmGHsse63LT2db7UaxkKqN3yKC4hqEdPn7dip
 i6JuIG8trvt0M3elotHl1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748337727; x=
 1748424127; bh=3cqZ6STe2s33sKByiWxebbz69351Y1jjuBipw264U9E=; b=R
 JwZ4+aUCRtAqco+s2bYb9FOYfiJVjzXrlQRFHwtwP9ALerpMPVsHiQyZfgisa7YC
 iYDxrmg9qk2uCtNKqfTMVofmxTjeZ6W5ydStwKJJkQLwiXzMCKfH2OFmxdRHUAX3
 b9qY1/Th9XJEgKC3sCu0X0NnOOB49YlBICCHilraCjLrMf+t4rfWtz4yXQ2zlDY5
 I1YsqIyksps6uqf+R02GGCkPxUewont5ragatE02fCxvUcGCK3Rn/8XzypLJZeVY
 zqBCbGCH/6pR6D6PvaB7+RBehckNpuWYZnwPzXaacZbA9veRbM0mnSA2aWXLmfTl
 JIiTE1Gd+07J09su1xjYA==
X-ME-Sender: <xms:P4Q1aIK8wOknmf70qO1ydTm3N5Sd_7bESxAdbAipuAYNvA8votEkUQ>
 <xme:P4Q1aIIrO3yWdD_RPZKLg-FlvzoNa9in775ktdFMzGSbI5nwzTkfDJYE9Cwma6FUT
 RNooxQt1x8Z3WO1yg>
X-ME-Received: <xmr:P4Q1aIuqgN3rWWIKe27lDFT3J2DtYBEch65vb5PlIwQflloBqKk49s4vdvGffxElxIbxtqRQU63LiBCWGP4sTE4jfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtddttdculddtuddrgeefvddrtd
 dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
 fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
 dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgj
 fhgggfgtsehtqhertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuc
 eothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepffdt
 uefhhedvkeelleevffdvlefhleehvdegtddvvdduueeivedtgfejvddugeefnecuffhomh
 grihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtph
 htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmsgesshhmrghrthhs
 hhgrrhgvshihshhtvghmshdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:P4Q1aFbrCPCochMpTFxgm_P5afK9Pk_TmlWn7_rj3ikvhGYV0pmADQ>
 <xmx:P4Q1aPY7x_p6fCZ7AvK-GgxQd2mTueQwOtsC4bW16MLpnD01N_X1PQ>
 <xmx:P4Q1aBAoYuIS7WeIsS8xI9NubMzFc1EKSUvKKYmYXz8e3N7Mb0Rrhg>
 <xmx:P4Q1aFYAJ9W5d9rCX5AA5rX_QNXtEdRwf_7LUHFMApr1QbkPNa8Y2A>
 <xmx:P4Q1aFyTzAkqre7OfqqTnUFQyYbJlucmyb31z4_AB6IiYV3Hm4ANJQxJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 05:22:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org
Subject: Re: patch state
Date: Tue, 27 May 2025 11:22:05 +0200
Message-ID: <6836044.tM3a2QDmDi@thomas>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FC99@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FC99@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

27/05/2025 10:07, Morten Br=C3=B8rup:
> Hi Thomas,
>=20
> I have two patch series ready for RC1:
> https://patchwork.dpdk.org/project/dpdk/list/?submitter=3D591
>=20
> Do you want me to change their state from New to Awaiting Upstream?

Awaiting Upstream is very special, it means you wait for something in anoth=
er project.

> The "mempool perf test" series only has one Ack, from Mempool co-maintain=
er Andrew Rybchenko. Should I solicit more reviews?

It should be enough, I will merge these 2 series.


