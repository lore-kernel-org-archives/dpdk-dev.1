Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E4CFD36C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 00:56:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F37AB406A2;
	Tue, 25 Nov 2025 01:56:11 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id A3D60402A1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 01:56:10 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 28CF1EC0218;
 Mon, 24 Nov 2025 19:56:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 24 Nov 2025 19:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764032170;
 x=1764118570; bh=LbTjpR6kxs/NhYirvpTnNwNdUqfOPfRcswmT56qMZ2c=; b=
 iXSsPOYrhtMRvZiGnHPI0fU3z3u6q/SPb14CkN6Yz1gKCIkB7LNvQk3TqdfZrlxp
 SKx6BhZNpYcAyMUUw9Q9rQLrkiS4Nc81WvMbfKwmvzATCeaIvHr+0kx25Cou9tnE
 qgr0oKz6USE1ypFlndmRvGyby2RX3RJB1+S+kUVuo5HKy2XKgv0dT5d7BaRLPZZn
 rPg9pOjA1MkW0Q64Bak0O8P2S4CXZOU9V7G+ZXfuy2oSjJyhthm+tLKsuX/bjEqj
 bpJraOw/RoOyzgYQ4hrht2SAtkgwnOtHmNjCkCvZgm4wZCulmRJYS4nZKb6403+h
 ImnLLQQJKbcBiJIsDzjtqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764032170; x=
 1764118570; bh=LbTjpR6kxs/NhYirvpTnNwNdUqfOPfRcswmT56qMZ2c=; b=I
 BvktUzyshycpIXbCpGYpLCko5pYkhiwlNPwnCUQY6hGTNV3CW9QaL2O145p08bYK
 XodXsqBMJwIg7g2XBmnC5h8P6CZF78EST4u47Mq3iZozJ55V4ENU27eyXey7S7La
 0/th+wdZHLnyntNaLcCoZf6LHCz0pbTrk0C3XMahXzQcRO7/y5J5uRXv4d5yYfAb
 fpQm9ui7MklQLKcVhFmqwR89QMbMyUx5GKH/KPp48zBHyJMDCZ9hYHAsmq3ueIgy
 9u4rofaxzBMtO3M9OEa/6me7uBWNV2zC9z99ZHzpTI34SQyxeZ6OTDhpqks/ADs1
 DfAKCNilWThA6Axs5e09w==
X-ME-Sender: <xms:qP4kaevzzzappL0-cwkAckjRAzC6TJ50udY7C8mCRDTusH0KVLhwRQ>
 <xme:qP4kaQ300yjCWJR3meFZ_8SqFbL0EayRhQpx1RtdWdoomBzjvznBpemCZPYwvhk3Q
 jD5Y1-R75o4Xv71Z9Y6X0peuFubQwgxgqBPp4DltmQ4j1nUsLOwvDU>
X-ME-Received: <xmr:qP4kaVyMYOZ7vI7c4j79ZcUztaqGARYZ9xre8XYVRPcAZva1MBZSIhfg79gPKwI_k4TcdQB_6RI75oea-Kp2Pnb8tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedtuddtucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpeejudevheeiveduuddtveffgfdtgeekueevjeffjeegtdeggeekgfdv
 uefgfeekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefiedp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugdrmhgrrhgthhgrnhguse
 hrvgguhhgrthdrtghomhdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtphht
 thhopehkrghirdhjihesihhnthgvlhdrtghomhdprhgtphhtthhopehjuhhlihgvnhgpug
 hpughksehjrghusggvrdhfrhdprhgtphhtthhopehjohhhnhgurghlvgestghishgtohdr
 tghomhdprhgtphhtthhopehhhihonhhkihhmsegtihhstghordgtohhmpdhrtghpthhtoh
 epsghruhgtvgdrrhhitghhrghrughsohhnsehinhhtvghlrdgtohhmpdhrtghpthhtohep
 rghnrghtohhlhidrsghurhgrkhhovhesihhnthgvlhdrtghomhdprhgtphhtthhopegtrg
 hofigvnhgsohesmhhutghsvgdrtghomh
X-ME-Proxy: <xmx:qP4kac7t0KNLkt1zqLOHLhg3vROaUtiIpCRpBRX6PSEdQeDTEHR-cQ>
 <xmx:qP4kaaigIJDLHHmYkCux8R7IoAIdOdFh36kjNoiIByrDV6Ug_uM_0Q>
 <xmx:qP4kaR29Ox1FnfXCWGJ_4pNWstNMlskw9dsXgeUYCZW6macn2s-6tw>
 <xmx:qP4kabApoXi56fF9maf6NgLmO6HSdat0wvfFYTf4QzA-XR9XZFcsnQ>
 <xmx:qv4kaaH1TOBaPUN4VKODvqIkz1sJDyQ0QaRmz1MRAITKcko5SL_H7i1x>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 19:56:04 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Kai Ji <kai.ji@intel.com>,
 Julien Aube <julien_dpdk@jaube.fr>, John Daley <johndale@cisco.com>,
 Hyong Youb Kim <hyonkim@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Wenbo Cao <caowenbo@mucse.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Jochen Behrens <jochen.behrens@broadcom.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Byron Marohn <byron.marohn@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Srikanth Yalavarthi <syalavarthi@marvell.com>,
 Anoob Joseph <anoobj@marvell.com>, Volodymyr Fialko <vfialko@marvell.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 David Hunt <david.hunt@intel.com>,
 Sivaprasad Tummala <sivaprasad.tummala@amd.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>, Patrick Robb <probb@iol.unh.edu>,
 Sunil Kumar Kori <skori@marvell.com>,
 Rakesh Kudurumalla <rkudurumalla@marvell.com>
Subject: Re: [PATCH v2 1/2] doc: remove unused anchors
Date: Tue, 25 Nov 2025 01:56:03 +0100
Message-ID: <3216645.72vocr9iq0@thomas>
In-Reply-To: <20251002113208.3415704-1-david.marchand@redhat.com>
References: <20250527140435.21361-1-nandinipersad361@gmail.com>
 <20251002113208.3415704-1-david.marchand@redhat.com>
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

02/10/2025 13:32, David Marchand:
> The documentation has unused anchors that were either left behind after
> a documentation refactoring, or just unused since day 1.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Some blank lines around anchors should be removed at the same time.



