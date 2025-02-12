Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A285C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7994642707;
	Wed, 12 Feb 2025 16:43:57 +0100 (CET)
Received: from fhigh-a7-smtp.messagingengine.com
 (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mails.dpdk.org (Postfix) with ESMTP id C8CCD4114B;
 Wed, 12 Feb 2025 16:43:56 +0100 (CET)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 309C81140102;
 Wed, 12 Feb 2025 10:43:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Wed, 12 Feb 2025 10:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1739375036;
 x=1739461436; bh=ZcEWFEITfSScTuyv4NzIBzrEBR6m9abLNfLJfPwtx3c=; b=
 dNoe0ASYw7Q77aDXt9oGkIXBLZlTyAr3dZVNNWNwjyWmcgt5Ne2wd7tpTkwxqJ3q
 LKLXCa1cf2iAn143iWAluv8lBp5o7CRlA+//r4qz/vCql2VVdkHyE4qC5YQmLFuR
 ctxxFssbmPpErHYJm0TTrOfWboDJC9hQdWBKNqdMf/jTG+wZ++vlusVMqO+cdI6q
 yixhiMh/PGjeMDj1fSyfywyyiEZx+gX9hQwnIMFWBk6ZlkVTaxPvyR0/juzh38aM
 H6go4ve/rvYXb3hfOqq4PRBl2/JJQ3WwlGMQvtmRK+t2P8FZtyc6zh6yZN4fOgv6
 kqUvp3oGCCo6FqjjmrtlmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739375036; x=
 1739461436; bh=ZcEWFEITfSScTuyv4NzIBzrEBR6m9abLNfLJfPwtx3c=; b=Y
 9NVsL67+pOU81bSMQjD/stv7Sm/gwZ33ndumhs3Un9PrEnX/WCnqGAV+FuuidoaV
 zNTbOiOYLMhd8HdSOjY4SD6ILMAuqF5/jNuyJjCWDHMFFsA6UM4yJn6MBb6FU75/
 vZj2Q407+wxT/AY6piaThHsFcL+/vGWeQjWIqDLIacfexkdW5TL/hQO2Vy5Z8UfG
 vGSlDAq+8w8ltK/p4YhiNXT4aV+P7I7c1Ci+OJKEFF+jDQsOd2V7yrgSLgiiDmXF
 P2IpMQBGM0cIpgpSC8b/OkOgJkqJsk/4FtOmNA9sdw6FKQ2xfW2+f6jWjeKpioDZ
 XN10B9ic3pnDvO/0lYKTg==
X-ME-Sender: <xms:u8GsZ8DyuMEqdV1ManwoAjRqZWLhUwcfKuREOtfSNMpITIVm_m8H9w>
 <xme:u8GsZ-j3zTZaZNKsOUsUjinw_Cabxb-AUcqb8-e1x_1pNXNnqXZjAxoTHB2PZh1w3
 feZ900QoVWqCc8I-g>
X-ME-Received: <xmr:u8GsZ_lVrROCPN-TG-Ji1F7JrU9FoYqeR-hnrXF_GDsSc8SrBMR5j3HbBUSpS189m59HTLgAxae-CY-VTesZce8JRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdej
 necuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjh
 grlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepjeduveehieevuddutdevfffgtdeg
 keeuveejffejgedtgeegkefgvdeugfefkeejnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrsh
 hlrghnugesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggvvhesughpughkrdhorhhg
 pdhrtghpthhtohepshhtrggslhgvseguphgukhdrohhrghdprhgtphhtthhopeifrggvlh
 grsehnvhhiughirgdrtghomhdprhgtphhtthhopehmkhgrshhhrghnihesnhhvihguihgr
 rdgtohhm
X-ME-Proxy: <xmx:u8GsZyy9epBhP9D78Z2cU3CUwr95Z6YHh8l11kNOKEWpbG3MNvH4Vw>
 <xmx:u8GsZxTYC5PctycCsGHgIj700m1U4W1Rtts08GIXiX0uat0s7ok5mA>
 <xmx:u8GsZ9aUg0u5dkPJA7fWZP6Uq6IFcXddEinbGnJxMYAU86MHBeuB1w>
 <xmx:u8GsZ6Q0pJoGhAyPP92BVQp3pxOqQt5hscg9WW25zBZhKVLZRQ7ZPA>
 <xmx:vMGsZ6JmaVw5jwsTxjDVt4gqcvzko7vOHnCoBf483a6sQKTyteCDs11e>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 10:43:55 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Raslan Darawsheh <rasland@nvidia.com>
Cc: dev@dpdk.org, stable@dpdk.org, waela@nvidia.com, mkashani@nvidia.com
Subject: Re: [PATCH] doc: add tested platforms with NVIDIA NICs
Date: Wed, 12 Feb 2025 16:43:53 +0100
Message-ID: <2333195.8uLHfb51uz@thomas>
In-Reply-To: <20241203075914.62923-1-rasland@nvidia.com>
References: <20241203075914.62923-1-rasland@nvidia.com>
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

03/12/2024 08:59, Raslan Darawsheh:
> Add tested platforms with NVIDIA NICs to the 24.11 release notes.
> 
> Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>

Cc: stable@dpdk.org

Applied after the release, and can be backported, thanks.


