Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F58E9A021
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 17:24:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A287402C5;
	Tue, 17 Feb 2026 18:24:24 +0100 (CET)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id AA327400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 18:24:22 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2851E1400054;
 Tue, 17 Feb 2026 12:24:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 12:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1771349062;
 x=1771435462; bh=sTCIDO3Ur3BBYBxRUNlCNk1/EfxFYifomlYjmNGTwsc=; b=
 fNPixA4SXfe43ZE31gOrp/j1Em4ewWH6P7D3BJiDFN+ssAEIQpYstO//seLrg8Sa
 ioYyYoCMDAh+2Hj09TgFYwjRAS/rcObuz93tK8RfpGKD+kqkC3uHeXcAAWIxSKwB
 URPqHuG+BJvpOqEsMo++RzzFJ7geox4XLRzObUA6TVKbkjKOsOJV9sMc+KXGdyO8
 uRMvNz4QkOxCLrzLPgMIiHpb8vv0NkZbEPucL6YVoO5ETsdbS0XLcowGvRUnVpNZ
 zDTs/gzo1V5C3zW1BuztJWTL6OdK+/2CJvpKbocOZjuIhXmcgBN03b7K5hsRstkY
 mbO/XXsH3xFv7nJNrg10Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771349062; x=
 1771435462; bh=sTCIDO3Ur3BBYBxRUNlCNk1/EfxFYifomlYjmNGTwsc=; b=u
 05ABza8Hfo7Tlf3EqhzVOETWdJS6J8RDsrUuAFnCkHNheDtmQ56ycg3KQhQOant1
 jiYdeYDRqQN2dQaqt8g/vfR1bD6Z93giBJ6ukFKk1HJruow7z7bbMLOkI4ZNpbMl
 9XzK543kG95oA1GXgQGdC67PEc5MxSOAKGtfEUB2N2uR5Fiz4jc6hjkpI+xWNYyE
 SZ0cI9E1KSWDqL24RVsIUrI/M66oCub2ixQ0CzKMvkqXo+vJEC8vqlqqZt7HwDBU
 uC0GKSOpc0LRt6ViwkVXt7lxI3jb7ketv5PyTJek0VBPyLrMAQJJkG+0sSmWLIMY
 /oJgAvcl00DIRhEUeO5gg==
X-ME-Sender: <xms:RaSUaeBHtKJb2C0LICJSKOIHzePG5Yb6JT5KV3KqSvDKtoUSOsutUg>
 <xme:RaSUaU3HgIM7SASbYoU7vLDTPLKwxJ0hjlQhitOKTMMwgjsLBcGURKZl7c7RdRtFK
 LQPIsCjGdhhZEVcjrfwJhpR_bSfRZYGr8NIztwXKBG4-MNQ03mHtw>
X-ME-Received: <xmr:RaSUaUUT30D54cIa2_BeWtb47T2BXdnJgQyk44IlwqZGEPb4snJ-0N6l8x8S40H2VNJuxUZ9VWKce95dYIfm6s9KBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedvpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:RaSUaenRenzAOMzyaQ6MOw6C7A8L0l5RUBFnXRwpkv8ES_kv6belPQ>
 <xmx:RaSUaWCs9x2Ezu5b8eANJCvQS83sOP4WocxmLFjNHQe4L3vuVySAhQ>
 <xmx:RaSUaeftrJdVaaXn39yevUgy4cllDkMe2mWDIYjoloDoj7ZVTT3gSQ>
 <xmx:RaSUaRJTGX9yvCGVZut80CYvGzTdUQWb59jQKWxtGEKRS1QwMGjiCw>
 <xmx:RqSUaeo7d4D2fMR5xvMznSfOmSCjX4-to_AXR2UiihX5-2nMaqtmJorE>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 12:24:21 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] usertools/dpdk-devbind: add basic FreeBSD support
Date: Tue, 17 Feb 2026 18:24:19 +0100
Message-ID: <29431915.kUm4frHblb@thomas>
In-Reply-To: <20251210123854.68761-1-bruce.richardson@intel.com>
References: <20251210123854.68761-1-bruce.richardson@intel.com>
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

10/12/2025 13:38, Bruce Richardson:
> Add support for using dpdk-devbind to query device bind status on
> FreeBSD. For other ops, bind and unbind, which are unsupported,
> report a proper errors message indicating the unsupported status
> and pointing the user to the docs.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



