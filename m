Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A020CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 14:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B59F402AC;
	Fri, 24 Oct 2025 16:45:59 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id 6290C40151;
 Fri, 24 Oct 2025 16:45:57 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by mails.dpdk.org (Postfix) with ESMTP id AB7F440150
 for <announce@dpdk.org>; Fri, 24 Oct 2025 16:45:56 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E404B7A01D1;
 Fri, 24 Oct 2025 10:45:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Fri, 24 Oct 2025 10:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1761317155; x=1761403555; bh=qzzkT2d6fJ
 RVJzPdJgCfCiTIZ7um74STQiJQ4hFRLL0=; b=aJ7ikAOM4m0piB/7GOvi5y1Wiq
 wJh2AeYnewbFWKsaGMwXG1RYrUDBx8VpPGMYd39OoNY7i3By9922YWA3V313VGnf
 4dpaOqLWLt5Rz860lZ5vxc4nDYXiNc9oWv/j3JZYHvsT3nTpNPAC7kMBWcfCquwG
 zExVzuCcJwa+B6zwANyj98U2h6RRDp9n4TfnPATehoRS3IiOxqZcc7WSQmmkjtri
 GP8Pf3e+XDUTVqYS+568g6RI/y8SyvUuZxm6YZq09K8/BJjkAhyrvg+HYoF9umeY
 yfWwlFwLPTOfKGt+lCEmKfAUH9+L8QuP6HkGT8Plsqm8Hs2te142YmQGrCRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1761317155; x=1761403555; bh=qzzkT2d6fJRVJzPdJgCfCiTIZ7um74STQiJ
 Q4hFRLL0=; b=cDOm0PEXsqGQ8zZ+NpXsnjidExHBMAwDg+Oqyay7jty51H/ptxU
 b2eCQSqSZr/caKq/RgX/AT32fcv5YkjekJPh8dKLRl9O8lboITCGktiNwNnj5iZB
 SECpscN1V0C28rwz86UBFB9l1hdJ16vazbOvgsJC9e7Nxsy7+vKTr8Ka985l6bgW
 z5NNVL08WPC+hJOGcUVBDDY9ARN0dSTMlpsHiPAz2lvK+wVfzYPd+wy+N2pmenEn
 F1AneIpeZgDVruCrijURQJGAkgQISZgd2AeuuF9qTJv2tKWERqnyJEO96ORqqjVz
 0HEgGgoIRr3Zn8jSRnwad5zB376jbPPLtsA==
X-ME-Sender: <xms:I5H7aM_Ldn8FpqiPnJ90-AssiUcfAUiXei0snTLqOYSgWHKAL_aE1Q>
 <xme:I5H7aKlSItjl9oTfQLVOSZkkR929Tpg_ThpmC7UVlbUwJuLAa0tZXuMk8kgXsbxfm
 P9KCAsiP84uQgJ-HteL2UZTL_mN36ebLyNMNQT2E5qkHnp55OJKLw>
X-ME-Received: <xmr:I5H7aNHUXaeMUj9e5SM99pgSOTQn1Fe2ylvTyMKx7WcepoXGVslmVCXgnCrycHxSc3oCHMPMO6rL5v-G7dpOxu4kiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeliedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkggfgtgesthfuredttddtje
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeeugeeuhfetuddvtdejveejhefgge
 ejgeeiieelveevgeeiffdvheehjeevveekfeenucffohhmrghinhepughpughkrdhorhhg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhoh
 hmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghrtghpthhtohepuddpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtoheprghnnhhouhhntggvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:I5H7aJR3c6Xe3MuSTma0vCWfQUmtYxaDu5B2ha_b9tzXK3wZJxY8QA>
 <xmx:I5H7aExNK0Bs4wl3FYAO27h3NX6utF0fvd5JV2TdMd5QaHwmv63Z1w>
 <xmx:I5H7aIOyZ8xK0xu33JWYsV5Wsx6LgmkvT3p6LRpYIMUu5x_2KQI1VQ>
 <xmx:I5H7aDOpcf4OMWZIE7Ga82GuD5MIrhM7WOD5f0owVZXr0JGnixft7A>
 <xmx:I5H7aEdPnKBdKeJFDxtzJpSZ6sMgGYYVtVLNr2PZixWdGP-L3nEhbTCz>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Fri, 24 Oct 2025 10:45:55 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK release candidate 25.11-rc1
Date: Fri, 24 Oct 2025 16:45:54 +0200
Message-ID: <24022415.5W6oEpyPa8@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
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

A new DPDK release candidate is ready for testing:
	https://git.dpdk.org/dpdk/tag/?id=v25.11-rc1

There are 634 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_11.html

Highlights of 25.11-rc1:
	- EAL option to remap lcore IDs
	- inter-domain DMA
	- mbuf optimizations
	- mbuf tracking for debug
	- cryptodev PQC ML algorithms
	- ethdev link connector info
	- Huawei SPx hinic3 ethernet driver
	- Nebulamatrix nbl ethernet driver
	- NXP ENETC4 ethernet driver
	- Wangxun Amber-Lite txgbe ethernet driver

Please test and report issues on bugs.dpdk.org.

This -rc1 was supposed to be released 18 days ago,
so we are late in the schedule, sorry about that.
We should try to close -rc2 during the first week of November.
It means we have less than 2 weeks remaining
for adding new features in the drivers.
Adding features in libraries after -rc1 would be an exception,
but it is possible.

Thank you everyone


