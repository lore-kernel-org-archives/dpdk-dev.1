Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7442C5B552
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 08:18:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB926402D4;
	Tue, 10 Jun 2025 10:18:55 +0200 (CEST)
Received: from fout-b6-smtp.messagingengine.com
 (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mails.dpdk.org (Postfix) with ESMTP id 824C440299
 for <dev@dpdk.org>; Tue, 10 Jun 2025 10:18:54 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id CDCA31140197;
 Tue, 10 Jun 2025 04:18:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 10 Jun 2025 04:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1749543533;
 x=1749629933; bh=QbAgSkY51Tg9Q6lIv0bBXpJ0v3yI7G28wY2IID8y4mI=; b=
 XBKvsBT4TYkXLlyMbtSpwI3h4qKiyEIjz1Im+H7eB2ykeybirJv85ICioWKSUA6L
 /21JYXOChYcgsF/UB9mVnwEroJifn1YMwiqp+TDPFqUU3+0sRAN8IapcAdiokyVH
 r+2BgXW5fLN/IvaRk+5nk0+OThjZzcNf/0HhyZNE/924ZkE6RqH+QZJdrzRfA313
 PKJncD77M6cglDu9602il5S7zuUP56gBj1zmE8+T3kfZTpkvRt7ojJGfYhn07sXW
 suMhbLp1XcFWv9hesW0pJy/BC+M1z4tu8EiinfzlFKSWU5BcXmn8I7wapnBOqYPR
 r4WT9YYYxI3+U37TJ3BLxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749543533; x=
 1749629933; bh=QbAgSkY51Tg9Q6lIv0bBXpJ0v3yI7G28wY2IID8y4mI=; b=F
 WwodQPgAkNwML7cMDxEF+eXY8EEyEOz2LngrsOwmcpGIEhMft/9fxOwSH7cznwMv
 GiJcmVSoL1Qj79kUX6qIYDL/RR7yi4wDc19NVDgoLwXJqqqgC+c3zc3xAHYBDOoY
 DDBGe7oDo5SQ+wVhCTAv3EiR8P5Aj3stK2nDDMjr06H7ufoFrI2s2lFOrpAPb1Of
 Zt+axCfZ8JdJThon9k8xS0oDmfRMIcI3TmV05DrKYMepvyJbdvGeb9ST3YaR9bpi
 jiQp8JLRXU6Qb4W/k8na/Yg0Y3uSn9qC382DdEndmTH4Ah5NeMRoPBF2ixSm7c3n
 XLeQlhDNiq6QzWPu0Vezg==
X-ME-Sender: <xms:bepHaEE88or5StMuGxFW47XZyqCy9Z-owgxwach66RLLgcTnm-lcmw>
 <xme:bepHaNUpKP2nMN1K606X3KZRzEyCLn0l5pk4gcBBGOXLm4fz8v9Q-IBa4lYcO55fM
 kHicJ202DqoPWlZRg>
X-ME-Received: <xmr:bepHaOKFax1Utx2hI18ZKbpHMqln1Vruls1tEL30LK9gc5sMFRx0ni7weQEt2pQGALnwM70QyXi2szsyOC00driwgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdegkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhurg
 hnghguvghnghguuhhisehhuhgrfigvihdrtghomhdprhgtphhtthhopeguvghvseguphgu
 khdrohhrghdprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrh
 drohhrghdprhgtphhtthhopehjrghsvhhinhguvghrrdhsihhnghhhsehinhhtvghlrdgt
 ohhmpdhrtghpthhtoheprghmrghnrdguvggvphdrshhinhhghhesihhnthgvlhdrtghomh
 dprhgtphhtthhopehlihhhuhhishhonhhgsehhuhgrfigvihdrtghomhdprhgtphhtthho
 pehfvghnghgthhgvnhhgfigvnheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhiuh
 ihohhnghhlohhngheshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:bepHaGF5TM5abOvNtvd6xU9ngnmgWtYgoZgP1d1l7wUtU4_KEwKppg>
 <xmx:bepHaKWYTMtFH9-NfOWvo0Uwl1v5zJFUz7FwNRccKR3UqEi6swhlhg>
 <xmx:bepHaJPYw6_Zwm9bH7sdib7gCX4a7T6hnOnxANcC3GI8tL2AMzu_tw>
 <xmx:bepHaB3aGF8QN4sNkRw0TTFV9CqKI_p_fp3CT3GVEGVpHb_AvXlAXg>
 <xmx:bepHaDPmCbokLXflbdxrSmCLFqmCeQ_qrxMQ7KpeRTnRDBPOknrMrctb>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 04:18:52 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Dengdui Huang <huangdengdui@huawei.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, jasvinder.singh@intel.com,
 aman.deep.singh@intel.com, lihuisong@huawei.com, fengchengwen@huawei.com,
 liuyonglong@huawei.com
Subject: Re: [PATCH v5] net: fix GTP packet parsing
Date: Tue, 10 Jun 2025 10:18:50 +0200
Message-ID: <41753403.J2Yia2DhmK@thomas>
In-Reply-To: <20250603120622.82092-1-huangdengdui@huawei.com>
References: <20250411084303.770040-1-huangdengdui@huawei.com>
 <20250603120622.82092-1-huangdengdui@huawei.com>
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

03/06/2025 14:06, Dengdui Huang:
> After parsing the GTP packet header, the next protocol type should
> be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
> Otherwise, the next protocol cannot be parsed.
> 
> Bugzilla ID: 1672
> Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
> Acked-by: Jie Hai <haijie1@huawei.com>

Applied, thanks.



