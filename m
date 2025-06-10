Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF71C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 07:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7979402D4;
	Tue, 10 Jun 2025 09:07:16 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id E6D2540299;
 Tue, 10 Jun 2025 09:07:15 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 058F7254018A;
 Tue, 10 Jun 2025 03:07:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 03:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749539234;
 x=1749625634; bh=Q02pUdsma8mUMIM1LajGaQ5VjBNE1bQNrNNCHaneIzw=; b=
 geHiMIYw08vTzd4d9KbFt8LuCEFbvRLDegpcmMk6GuYapNa2OUMAqEaoV3gFZ5Rk
 P5eDtAY3RNhLz3HVEXWIrx7BvfDsz+1pteqB8L7gmitCww3zAYCGvV9Wm5+Topsh
 svMgypquQeZYjSHio4jE30yG3rIXE8W/+mKooceABSzgJI9xn3JNRF0yTDc1XLKK
 CqwAA2eDYqpDq82DyaHdJlLdR2bmg6gd++Atza1ZR7O0N3VgWAC8YSrtK4aILlwk
 CpwSzsZy48YbTrZINebe1/rkmtldIfD9Dk5e610GXKNkJpmsd50lwIOkORLfqzIJ
 FDQQX2BReLUPw/qi9mexUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749539234; x=
 1749625634; bh=Q02pUdsma8mUMIM1LajGaQ5VjBNE1bQNrNNCHaneIzw=; b=a
 cfjLxtiSSRkDZushl1VwMpkDZpBPLYYdh1g8iDh7Ixog6V+c6k4u4X7J+5otIk7I
 H5MHO/GoEAEL5ifG8VPzIEn3Ac54TAG8CJd+kGofoZUBAvKtrPIM+sq1Q9GJe0Uk
 nsbtm9cFDlyJOook8BINocjKJdpKoYK7qAYfuFWMAN63wKBcgDx5hPLHktUgY7a/
 yZiOfDCBuPEntP7gCyyI2FIXBqFWONI3NAfoWX6VduTrv0/izreM0SdtO9Ve9eW0
 XB4BboXrM3n4522YLe+ONw94BEex4915XTZ0ZWEVJTiUrValuEliF/jBalnGwWXP
 V8Cqfn0DwDlCHh+6QGiqQ==
X-ME-Sender: <xms:otlHaMMkrqMFY9nCOEKWRRcB7X8f3tR9js0WaSBZ2tXWcdhTz4O7tw>
 <xme:otlHaC_15mv2QR_X3ZSWS6cGslgvwbLTDyN-blMz5YRsjTJt98gAJYgK4w_6ndT_j
 1t38xwJOipGZYoZcw>
X-ME-Received: <xmr:otlHaDT3UjL3PVRr3TIwlaX7LOl584zY9Ou2WzOgWoLyueRWWTj67iW_fep3mR0ZDdewWoBQwPx0VEr4YF38pO7jRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghruh
 gtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtph
 htthhopegrnhgrthholhihrdgsuhhrrghkohhvsehinhhtvghlrdgtohhmpdhrtghpthht
 ohepuggrvhhiugdrhhhunhhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhivhgrph
 hrrghsrggurdhtuhhmmhgrlhgrsegrmhgurdgtohhmpdhrtghpthhtohepthgrughhghdr
 khgvrghrnhgvhiesihhnthgvlhdrtghomhdprhgtphhtthhopehkvghvihhnrdhlrggrth
 iisehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:otlHaEtlPzhcSXfmYUq0oo9VIJNKFCQLPfEwAnEkhP1_-szOJ8Yhtw>
 <xmx:otlHaEdHZ49lQj8xONnkkkqzSpFs196BO146Wz07yBfPX6Q_SGsD8A>
 <xmx:otlHaI2_XaELRg0kHlTUF3-J1Bg8jXnINv3lZbXIAsJulbZT4oFr3Q>
 <xmx:otlHaI_OnD0WvPd2BF67OrvbJreb_wSyAWxQkS4xd6pC0ZXJIkR4BA>
 <xmx:otlHaBVFCrJ4N3a2eWxh10OPtZ94OtzyQkTtwRlGi0opUgLNqRGonZNm>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 03:07:13 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Tadhg Kearney <tadhg.kearney@intel.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH 1/2] power/intel_uncore: fix crash closing uninitialized
 driver
Date: Tue, 10 Jun 2025 09:07:12 +0200
Message-ID: <4690957.tIAgqjz4sF@thomas>
In-Reply-To: <c4352c31-dbe1-4790-94b4-018a32628aba@intel.com>
References: <20250515165854.1087247-1-bruce.richardson@intel.com>
 <c4352c31-dbe1-4790-94b4-018a32628aba@intel.com>
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

21/05/2025 15:06, Kevin Laatz:
> On 15/05/2025 17:58, Bruce Richardson wrote:
> > When the power_intel_uncore_autotest unit test is run as an unprivileged
> > user which cannot init the power library, it crashes the unit test
> > binary due to calling "rte_power_uncore_exit" after the first test case
> > (initialization) fails. This crash is due to trying to write to NULL
> > file handles.
> >
> > Fix the crash by checking each file handle is non-null before writing to
> > it and closing it.
> >
> > Fixes: 60b8a661a957 ("power: add Intel uncore frequency control")
> > Cc:stable@dpdk.org
> >
> > Signed-off-by: Bruce Richardson<bruce.richardson@intel.com>
> >
> Acked-by: Kevin Laatz <kevin.laatz@intel.com>

Series applied, thanks.



