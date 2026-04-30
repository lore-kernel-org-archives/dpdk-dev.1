Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F944FF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 13:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C5DE40608;
	Thu, 30 Apr 2026 15:12:11 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id C25784021F;
 Thu, 30 Apr 2026 15:12:09 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id D7CF91D0006A;
 Thu, 30 Apr 2026 09:12:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 09:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1777554728;
 x=1777641128; bh=aMKLDLq1JK6GJajEKlLXc9iE7earuroPqx8YXmNXxwc=; b=
 Rt+hMlxWq9J8AGOCZs7mC8yMQs7mgDm8zCZE7IHsvV8tnEddBF4KfiDYWmSsHt22
 SHNeqhJa4W/vAll4+v6msB7h6a/SHZcYzZ0Zn6IyIr5N20LS+wj75oISkW8BLfOW
 Sb+qJNlON0t9zlK7GQBxfdtZ4MFKyMHy45HO2VGfRx9RkPkAWmYdjEUj6/0iqNMh
 jb5fyNpuEbLfOD+ujnjMLG4iaJlAuiecn2Hhrwwzuyl0NgC3Ux/OgtIEQCMeuyxG
 6pw9L/ao8kpGAyNWNn/7DZjcTWm5J4HuCnBQbOQA/77u4ZmDOiM2DZxMG6S4xjx2
 FPfFJJa80x3qTgsadLL2Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777554728; x=
 1777641128; bh=aMKLDLq1JK6GJajEKlLXc9iE7earuroPqx8YXmNXxwc=; b=S
 llzd3UurXT+iYIcWc13rx+eWs34FBr4rjTKkuodz6ptNJjtjm4K+zdDGYgUne0hV
 bhmS1bYdfHhnaR1miwupRycCoKJapukIb2ccX+h9bh0ueVsS5kpwtoBpvGWYuvYc
 nNF9jgeLCTvFtzv4u1n2zCLMW3dkcx38wF7EfTGe6uNvn2ECwjRQbN4xYBZ8yezZ
 kHg042pzBSOXBRSqqQ43WGu2j/7C1WEE6wCmYsUt8PA3KEvRXVjQ3b9bFjYaXT37
 ux1a2uVHG9NunisWqfPY68jiDG6q+f6rmxxwNylX6KG3B09x03WIvgj3yQ163iGW
 B6FrD+6lnbzE5tVy682bw==
X-ME-Sender: <xms:KFXzaSyWIbg7MSFZcKeGuSFtdteKr-4TMdPqNCq1jgXZbJJaimdRVQ>
 <xme:KFXzacPAAYIX4zOdIF88wbiKrV1KvFtdpSx31HJMT9_So1PHQG9LgEF1abTs5zNj4
 4xIueCuhSoE2U4g8QASjKt1i5ycZBiYj51gQEp0hocvxQZg0XveHA>
X-ME-Received: <xmr:KFXzaWqGI7M91hJQ1LT47lGwViRC-YVetMCw_q5kjVrdemxBjDLzRkWlPv3d5TkRjnt4fwaRlEtO2iEVYvrhs6PGtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepiedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhgrthdrkhhhrghlihhliheshhhurg
 ifvghirdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhgpdhrtghpthhtohep
 shhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopegurghvihgurdhmrghrtghhrg
 hnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughs
 ohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohephhgvmhgrnhhtrdgrghhrrgifrghlse
 hngihprdgtohhm
X-ME-Proxy: <xmx:KFXzadHRXk8pNCY-WaAQxJfdV-Oqfs2AGBJBsqojD9jGuD92zG4P1Q>
 <xmx:KFXzabqLeopPgB3tMIFtf5x4G9e3v4IlA-E5RfKsOm86C4ANT0eHDA>
 <xmx:KFXzaWZppJGf5XAF2i4giMcUe8GTP7ZgHIDKb87q36a874zllFZ6_w>
 <xmx:KFXzaUWj6uZnX4BGjyZjgsUeAFDGMrY4mwSO5OF-LJujaFmoAAw0SQ>
 <xmx:KFXzaaf_3g0umUANX9B4wzdxno_KyUibh32sklb-p3c5Aq0V7TPEwJel>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 09:12:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>,
 David Marchand <david.marchand@redhat.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH] devtools: fix SPDX tag check
Date: Thu, 30 Apr 2026 15:12:05 +0200
Message-ID: <3848991.RUnXabflUD@thomas>
In-Reply-To: <2cdb8d9fa0884d9388be9b08b8aaab09@huawei.com>
References: <20260429130935.3681177-1-thomas@monjalon.net>
 <2cdb8d9fa0884d9388be9b08b8aaab09@huawei.com>
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

29/04/2026 18:17, Marat Khalili:
> Patch definitely improves the situation, but after a quick prompt Gemini suggested `| grep -vF "$files_without_spdx"` for safe filtering (man page confirms that patterns can be separated with newlines).

Yes grep looks simpler than sed for this filter.
I'll send a v2 with your suggestion.
Thank you


