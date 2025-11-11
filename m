Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C78CCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 18:20:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E55D9402C8;
	Tue, 11 Nov 2025 19:20:50 +0100 (CET)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id 2360140280
 for <dev@dpdk.org>; Tue, 11 Nov 2025 19:20:49 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 3C8B21D000CD;
 Tue, 11 Nov 2025 13:20:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 11 Nov 2025 13:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1762885248;
 x=1762971648; bh=YxQWyVkJnYNMXAwd7Wv7I4LJ0PnsNvtSsSwWw2W4xs8=; b=
 E07OO0ESMW3lFLqTMVIFsvuFFoQJoGHybwLcKp9iwDkwfZGCoH0Wn1Fg9Tsoqi89
 YyU0xwKl9McrumxI8wvVjCesRwqDHwGQ99a8olN8K7jwKqZDa1PryfA1P9SIfFXZ
 wfI4YYopSEw2pDQL63pzQK4iWg6tD1n4I/Nct9oOrMqe3sjzjxquvn3fxsaUG9M5
 dk1IAdKF8WEzcRyCOrcM/EAKuJiD7rb1A6ATESFTQtCP3gJG/AQu0fn6xD1/XNuD
 3qJBPjthGdHHptklJmnSHcsXhhFGkm6ISUAo3+jGTD/SK7js2faaR0pT16HMor1t
 mlU4xjJGqJLu1dYAQ7vF9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762885248; x=
 1762971648; bh=YxQWyVkJnYNMXAwd7Wv7I4LJ0PnsNvtSsSwWw2W4xs8=; b=l
 T5LXA9Hp5Vhz4IOJP2YHdNJR8k7Sc7kPBapPYE1KkJrHKskBzVuPuE2seHEnrfzo
 RPJEEiI8sEhxDeIRZ6Vl9iu19Tt1uMh1bffG36i9RO2LE11/2AcShw45V/4cZNef
 jpMUZ4csKVh8Df5cGGX5pKNT8Q7R0rsUuDMztq/4mqIFtDpZVyTbio3pSqTuRhYe
 xKbvdUu8+5/LPnGW5Ais2e3hmHbwrXF1H9YsHjjZKd+nN2DnrIxOw5xpI0p5AvAe
 HWhOeFxg3rUnyKQvqG4yACYFKZh5eh5NM/yplFAgLF6FWVFRJXHvMtwdr6VrfizP
 U12NNWyU1JFxhkp/QJ27Q==
X-ME-Sender: <xms:f34TaSx3PuzacRpivHYeJ2HAQH0jszPZ1HQD9COrd-hssMJRg8p_HQ>
 <xme:f34TaUS9PJMHZ7SB-s6hc2SE5oDkK4LEqAALonaQq0TBOe1DkCArqJ_QjUN0DBlkv
 4y1QeKr-o4gBzmyH2ly2T6-7hd07CUU0farM6v4mtnZBN4-au4d6VQ>
X-ME-Received: <xmr:f34TafIWWEn_Tm1ddZiPBrtKT1Qr9aKW0kpnsME_cUV9tFema_s3rYLdX8RVPWpJr3eLg0GeswwDm9uNFKXhPykdIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduledtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeduuddp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhivhgrphhrrghsrggurdhtuhhmmh
 grlhgrsegrmhgurdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghp
 thhtohepmhgssehsmhgrrhhtshhhrghrvghshihsthgvmhhsrdgtohhmpdhrtghpthhtoh
 epuggrvhhiugdrmhgrrhgthhgrnhgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
 thhrrgihnhhorhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtih
 hnrdgrnhgrnhihvghvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehkohhnshhtrghn
 thhinhdrvhdrrghnrghnhigvvheshigrnhguvgigrdhruhdprhgtphhtthhopehmrgigih
 hmvgdrtghoqhhuvghlihhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrtghonhho
 lhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:f34TabVBqSQe7nJ57DyZITIB2MEp-4p13av-2NCpX28KpInexBCKWQ>
 <xmx:f34TaTRacL8e2lQnLLM05z4SBOCHrF3R-vjP-n9SEEr4n2VrD6LvaA>
 <xmx:f34TaTCmSRZXAXaq-_wNlTz14l8poBdgQ-aTp7nvf-YaZTbf_P0Wqg>
 <xmx:f34TaSImOXQETCLvQKU_6ET4n6kXVPW_3W3qgoG8SpNj-U3m8fkl4A>
 <xmx:gH4TaQI4Rj46ttJYXi2VB6fKGiiG8YtMyE0gSG96Yb99S4ooVMpp7mRd>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 13:20:45 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com, david.marchand@redhat.com,
 ktraynor@redhat.com, konstantin.ananyev@huawei.com,
 konstantin.v.ananyev@yandex.ru, maxime.coquelin@redhat.com,
 aconole@redhat.com, ferruh.yigit@amd.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] doc: document telemetry command name restrictions
Date: Tue, 11 Nov 2025 19:20:44 +0100
Message-ID: <4233963.o7rAqR3Ra6@thomas>
In-Reply-To: <aQylhdIWMJRNNDHV@bricha3-mobl1.ger.corp.intel.com>
References: <20251006094712.180432-1-sivaprasad.tummala@amd.com>
 <aQylhdIWMJRNNDHV@bricha3-mobl1.ger.corp.intel.com>
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

06/11/2025 14:41, Bruce Richardson:
> On Mon, Oct 06, 2025 at 09:47:12AM +0000, Sivaprasad Tummala wrote:
> > Telemetry command names must contain only alphanumeric characters
> > (`A-Z`, `a-z`, `0-9`), underscore (`_`), and forward slash (`/`).
> > Other characters, including hyphens (`-`), are not allowed and
> > cause registration to fail.
> > 
> > This patch updates the documentation to explicitly state these
> > restrictions and highlights the existing invalid example
> > "/l3fwd-power/stats" (in l3fwd-power app).
> > 
> > Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.



