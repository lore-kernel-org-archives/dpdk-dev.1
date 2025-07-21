Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E3C83F1A
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 16:23:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 141FE402DC;
	Mon, 21 Jul 2025 18:23:36 +0200 (CEST)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id EF20640297
 for <dev@dpdk.org>; Mon, 21 Jul 2025 18:23:34 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 73F2EEC0173;
 Mon, 21 Jul 2025 12:23:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 21 Jul 2025 12:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1753115014;
 x=1753201414; bh=kwc/c/qSe8kU71lm3ypFzIM29sYxXNPpnBN93IOniXc=; b=
 xobM932/wtmpV0FC9z6fjnhvdXn4NE/yuLVyzTkjeYochLu4nUIb2BYttSFZkYY9
 8HpoWg2Lzsr2V/CQGcZCgjf4NoRYSmzCQb69E151JXydLUwmmxBNmEJ+PHnFuAxx
 hl05HLGerlwnNPyBJN8ik5gL17ZSks9SgENcMgDjb8cZV+Sa9dv0E5z4+xOGl3kf
 umWAhYKgTCxtQ3A8zDZLMjHZU3IbrknuhIOMmB5oMyavX0ZzGlfmAM1ewusK9n9M
 SNDpSSek/JbV2kH/35yqMWLqlaxpvD1/XahLtJJno3LXqafEb/wwHFDnZr38lzEL
 +dR0MNxundSpBZtnyxH5uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753115014; x=
 1753201414; bh=kwc/c/qSe8kU71lm3ypFzIM29sYxXNPpnBN93IOniXc=; b=Q
 NWlSmMtV6pbxad5oaH7ZWvRfOpPPtdvmIaoJREnMKrcE0pGJSs6v8QKzs5pxN/sW
 ErVrYkHEF6xrnLbqouIwGHro3+iYNg+doBPD2wN/D8Y75pQeLN+VrdfhEyL1MRkd
 gaYYvM6KyIJVNmDH/SyONi18Cn/YI/i5NBvRdKRu4ISf057xIt/4I8zonNihlr5F
 FrwpNuS63VkZExzVUS9V8YWLJuczczVIxw+DK9CA/W6CCGDjE/VqZH/D0ppNRxdr
 0s4pKHwR9Xuf0vAdY9f8tryCb4IEsyCSVAbs9yh1tAW2YP+SGtLYZBeXh3YCUZZd
 6UlV2YilCL5Nm5ZbNFUcw==
X-ME-Sender: <xms:hml-aFMMBaY3kOw50HcviQyC48VC36MqHtp3ycqpKLq75K10r7NFRA>
 <xme:hml-aBmEUWsJMOhaJiRviUnIxZ7gb_Y6roPwqbZRNQDVif9DmlWSiMTVuUe917t8L
 jyzn3NTzWljPIim2w>
X-ME-Received: <xmr:hml-aESsQRWRHaV6l8hOaarLW_5J932B3aO_8xgmHfHXIIACGvxA08KAaIegkD98YI4obalGvyduxIP84F5Nv1VQ-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdehhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcu
 ofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrf
 grthhtvghrnhepjeduveehieevuddutdevfffgtdegkeeuveejffejgedtgeegkefgvdeu
 gfefkeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepfedpmhho
 uggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhgusehrvg
 guhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphhtthho
 pegsrhhutggvrdhrihgthhgrrhgushhonhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:hml-aFB56Qijxczewp1JPSkaivR0KO1GZcFTwJRHlilplNd0dKovJw>
 <xmx:hml-aLQK8axLHy9DR9BqjuzKE0TZq91v0DMohltrTbhvAb_SDwSzHw>
 <xmx:hml-aDrCkJLLHl5wZiBHThTIG4XaPAfi3zuwdUy2_WdKxfD9uygkpw>
 <xmx:hml-aNxPLNp04kulHWeNfFW4TqC8XTaaLDo66AyPNNTM-jS4j0JEhA>
 <xmx:hml-aAgfmmEsAKl9WZaB4cQBzaDWSiqgtV9BsNjXturRLxp5yN0vrs7U>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 12:23:33 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH] mailmap: keep only one name per contributor
Date: Mon, 21 Jul 2025 18:23:31 +0200
Message-ID: <4876099.rnE6jSC6OK@thomas>
In-Reply-To: <aH5lbXCH4WpxJRCJ@bricha3-mobl1.ger.corp.intel.com>
References: <20250721154403.2688034-1-david.marchand@redhat.com>
 <aH5lbXCH4WpxJRCJ@bricha3-mobl1.ger.corp.intel.com>
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

21/07/2025 18:06, Bruce Richardson:
> On Mon, Jul 21, 2025 at 05:44:01PM +0200, David Marchand wrote:
> > Some duplicates have slipped in the mailmap file.
> > Clean this up.
> > 
> > Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


