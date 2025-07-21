Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B9FC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 21:55:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAE8D4064C;
	Mon, 21 Jul 2025 23:55:33 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 216404026C;
 Mon, 21 Jul 2025 23:55:32 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mails.dpdk.org (Postfix) with ESMTP id DE9D64021E
 for <announce@dpdk.org>; Mon, 21 Jul 2025 23:55:30 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal
 [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 4304BEC0278;
 Mon, 21 Jul 2025 17:55:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 21 Jul 2025 17:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1753134930; x=1753221330; bh=4nVrCBRI/p
 LIF/eVZyWkdqLoKP/ED4MynBzB9pMhSxs=; b=TKsHNYCJiQb67MPZQXP9/sf3sH
 uo9qu0p0E3ZQY1wpKOPBLp01oLvYDzU8o/FwkXceU/cPpi9iCc3gQXfvQZEk353Z
 oLv+Ipmh4137Kosqf6hVEkobdWh8GiLyq9fj8KQLWGTbixETLOpNBU9qXF42+Iau
 8aioWgLnuDw9z2HHQoSq7Pyv4ginrYklNP2cEe+kNFKeEZtaySOzipPARUjeanAj
 pUvzOOV2olts/T3fPrCuDDfpY47uw8Jr0ayeLRFZqSEiKsNrrDLUj8TkRChFE4O9
 oNC++2vb2vRj71s3Sm7jKFcyX8oqvElmqTUVlyY5QQwIP+mwHvrDmLPfGpxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1753134930; x=1753221330; bh=4nVrCBRI/pLIF/eVZyWkdqLoKP/ED4MynBz
 B9pMhSxs=; b=l0hZ3jyto4iIbomErSh2B+g7eAQ5BwLg6G2lfIDb9etrT9x+fzm
 j8ysimrZcQQsksTagpPtL53OEdbNFjB1laOA2qu2Mqh+W9rZHhWf9bT+GBetVytD
 WkA1pqOX8BDWdUNSq57Yr5WCzbq5Y4bMC4+VAfi9C6z5vdU3TqvUM2YN3tSDZH9z
 gYBBLoywbNwKy7LnM9qj3DDlD58d+Jn+CpuE97KHPhRtUIz/4j0MW7IFMA2u0i78
 7MsiYVTFRKTKB82EG530pc5Hrh6+52eN1zW6fvgnwjy3XZzJP/FPpXMyFab5saa7
 32nJlHVEizeyeSUirOjvY/Btyq6k2glQiXQ==
X-ME-Sender: <xms:Urd-aDLE6FH9-_Y7qkbdkYHvXM26fvI8D_ZhiQT_B9ZSLJKmN2LbuA>
 <xme:Urd-aCZCKUMZ4QVWuzl8wS-EKpGWrK2CTIAHQyBQ_1wy3ITvhff86B0VWVy230ZpJ
 rUEXuloq60oAW1Vfw>
X-ME-Received: <xmr:Urd-aMVipz8XEp06U-Y36x2vT_-LmMh99dYWcuD9-d8946mfGfp8suYMsUFLZuSndYIYGpO-VbAdx0eu73njYECTgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgggfgtsehtqhertddttdejne
 cuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehmohhnjhgr
 lhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepffeivdffveffleekfedtkefgfeevje
 eggedtveekhfegtdduteetieevgedvvdeunecuffhomhgrihhnpeguphgukhdrohhrghen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomh
 grshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopedupdhmohguvgepshhm
 thhpohhuthdprhgtphhtthhopegrnhhnohhunhgtvgesughpughkrdhorhhg
X-ME-Proxy: <xmx:Urd-aCl3wNybOh445L-tqi2NVHAYs8aRSRB8ShyxD6rAQktH8XEG_Q>
 <xmx:Urd-aJwTQ7lKyNSwqNNYfjwiS86ZLSe8sMpALq_-pwFHe_5KyIWOdg>
 <xmx:Urd-aNh2IiLnrRZirrgUbgOAd5Hg8X0Leo1kljK8FAdVs2N8W1gV1Q>
 <xmx:Urd-aOWWPSAAosAbaoSK08IO8wb_bDv0apN2CQjiBt6eeQ-HdMVVuQ>
 <xmx:Urd-aGZzonP7jnTNgZ0_2yziH8HktBQJtgEmifggwIWipt0PT_zBZT0_>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Mon, 21 Jul 2025 17:55:29 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK 25.07 released
Date: Mon, 21 Jul 2025 23:55:27 +0200
Message-ID: <2942910.yaVYbkx8dN@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

A new major release is available:
	https://fast.dpdk.org/rel/dpdk-25.07.tar.xz

It was a small release cycle:
	806 commits from 133 authors
	1685 files changed, 94020 insertions(+), 27600 deletions(-)

It is not planned to start a maintenance branch for 25.07.
This version is ABI-compatible with 24.11 and 25.03.

Highlights of 25.07:
	- Mucse RNP driver
	- ZTE Storage Data Accelerator (ZSDA) crypto driver
	- Performance Monitoring Unit (PMU) library
	- mempool optimization
	- zeroing of sensitive memory
	- RSS type for RoCE v2
	- graph feature arc and nodes for FIB
	- eventdev vector adapter
	- argparse enhanced
	- more libraries enabled with Windows MSVC
	- export symbols with macros instead of .map file

More details in the release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_07.html


There are 28 new contributors (including authors, reviewers and testers).
Welcome to Amiya Ranjan Mohakud, Baoyuan Li, Bingbin Chen, Changqing Li,
Clemens Famulla-Conrad, Dhanya Pillai, Edvard Fagerholm, Hengqi Chen,
Jake Freeland, Janardhanan Arumugam, Jarom=C3=ADr Smr=C4=8Dek, Jasper Tran =
O'Leary,
Khadem Ullah, Luke Seewald, Marat Khalili, Mikolaj Filar,
Mohamed Feroz Abdul Majeeth, Pieter Jansen Van Vuuren, Rui Ferreira,
Rupesh Chiluka, Shivaji Kant, Tanzeel Ahmed, Thiyagarajan P,
Tirthendu Sarkar, Wenbo Cao, Yan Lu, Yaniv Rosner and Ziwei Xiao.

Below is the number of commits per employer (with authors count):
	173     Intel (30)
	137     Marvell (23)
	 73     NVIDIA (13)
	 47     Microsoft (3)
	 41     stephen@networkplumber.org (1)
	 40     Red Hat (5)
	 33     Ark Networks (2)
	 29     Napatech (2)
	 29     Mucse (1)
	 29     Huawei (4)
	 25     ZTE (3)
	 22     Arm (3)
	        ...

A big thank to all courageous people who took on the non rewarding task
of reviewing other's job.
Based on Reviewed-by and Acked-by tags, the top non-PMD reviewers are:
	 28     Bruce Richardson <bruce.richardson@intel.com>
	 21     Patrick Robb <probb@iol.unh.edu>
	 20     Morten Br=C3=B8rup <mb@smartsharesystems.com>
	 15     Jerin Jacob <jerinj@marvell.com>
	 14     Konstantin Ananyev <konstantin.ananyev@huawei.com>
	 13     Dean Marx <dmarx@iol.unh.edu>
	 13     Chengwen Feng <fengchengwen@huawei.com>
	 13     Anatoly Burakov <anatoly.burakov@intel.com>


The next version will be 25.11 in November.
The new features for 25.11 can be submitted until the end of August:
	http://core.dpdk.org/roadmap/

Enjoy the summer!

Thanks everyone


