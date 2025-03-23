Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A5C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 16:39:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E27D540277;
	Sun, 23 Mar 2025 17:39:27 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id B2DE540150
 for <dev@dpdk.org>; Sun, 23 Mar 2025 17:39:25 +0100 (CET)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 0102111400E3;
 Sun, 23 Mar 2025 12:39:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Sun, 23 Mar 2025 12:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742747964;
 x=1742834364; bh=fJ/7S1uEWzS9qBz23A3SbUDFPORrAS7tPLke7pa+38w=; b=
 vgycCZCubLM060rWTAfDb3RoOoKJXM9Y67tWGmu1JmcBnwhDOnHGHs7smWgVWF87
 +KylqYiLsLd29xI6+aQlJa3EU19lbs5oNARVmvhXDSO8I5Sthtyc9it6EbHCNKO4
 v6GdkSpDh+qcHHMbIePnYkk4bhC7dWmtc83Ahqeq2DfX2kDi+QOidwYXavICTSRE
 jn1WBatDyaPvEoDkhRvM9rbC8dAXJryOeKNuEbHD3f3hP8VZvsRBGiIhjwVL3eGe
 MQHqKULK70/5Yn/XrSPeeFYJLNFVrUoQdLKXjHmwba8NTMbDNE6+I/XytgSyBk0t
 rNhQBBk3G452yvd6hdZTdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742747964; x=
 1742834364; bh=fJ/7S1uEWzS9qBz23A3SbUDFPORrAS7tPLke7pa+38w=; b=7
 3fMxlIcoBSHigNbMBw5GKBepPZDpOhhOgyi8lmn6/Y3NlPCeqAWRN8YvHpWDNbOz
 LJQuUAiY9VXJ75YnPfDLXl6Towv3FUEy/kw14ZcqvnKIl9A9R0p/8u/TX+yuoEOU
 yKRraNrZl0sFrw0I0cyfgYgO8uA9LQTVYgLQTNatrDIMUACK/ylg7U7CvZbPC9Hr
 mdQqbqQbpq5Vsp58g87sbNjK2S8FYb6VZLjzyWJDnxupA79MajMvp0Ws8BdGwnW/
 Evy6hpXWbTop2d0Er6zD+k7xP7kP7SBt6JU+YN2GdxFopf6F3rO7+lrm4XaUCNij
 8l4/DcTdNmO+MnMdISpBw==
X-ME-Sender: <xms:PDngZ9lq9FCH7mrRmOlaCIvKUTiaWajD8w-eO7iw_DHhuw_oJR7Trw>
 <xme:PDngZ42QEgZbPSQIcWQVyWTdRl7D-XeaS4LiCdK6Q60BsQ2d41N-YR5StQm_GgL72
 jSvP8eKrFPZRtl_jw>
X-ME-Received: <xmr:PDngZzqSIsNnWSA0ytNw4j6QfaVU1aJGf_JKfJHYRmaMsGjZUcnobzaleoyP0OrbkdCXupTzqMETbJR7_ZoyZvzxdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrrg
 hslhgrnhgusehnvhhiughirgdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhr
 ghdprhgtphhtthhopehhrghijhhivgdusehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:PDngZ9nKc4MDEY3g_KA45k-d7RcnZndZzpNTnvw9D5Cmo_GWEgctqA>
 <xmx:PDngZ70Y3GrkmeZPn_rXUOs47G442uZ9Tigp-Zj3ADTSnXGu1kWLsQ>
 <xmx:PDngZ8vyEnOP0ygE-u8wRsPHy6C3vBUGnkmndJ1Kz-7niRi1ZA_nDg>
 <xmx:PDngZ_VT9VT9b1ieRa-S8OmedSlxWdO4IuplzOh8ubBD48EB3iyF5A>
 <xmx:PDngZ8zGPKyrNHbfErfTXp_KbUZkWAQ8F18kUT8WtuyQzCDiqETPpG5z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 12:39:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, haijie1@huawei.com
Subject: Re: [PATCH] app/testpmd: fix VLAN header parsing
Date: Sun, 23 Mar 2025 17:39:22 +0100
Message-ID: <5993081.QJadu78ljV@thomas>
In-Reply-To: <20250323122822.90407-1-rasland@nvidia.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
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

23/03/2025 13:28, Raslan Darawsheh:
> Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
> headers.

You should describe what is broken and how.

> Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
> Cc: haijie1@huawei.com

Do you think it is critical for the release?


