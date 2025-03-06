Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B66C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 17:42:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 538A340BA4;
	Thu,  6 Mar 2025 18:42:30 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id B048040B94;
 Thu,  6 Mar 2025 18:42:28 +0100 (CET)
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by mails.dpdk.org (Postfix) with ESMTP id 6D90E40B92
 for <announce@dpdk.org>; Thu,  6 Mar 2025 18:42:27 +0100 (CET)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C66AE1140143;
 Thu,  6 Mar 2025 12:42:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 06 Mar 2025 12:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1741282946; x=1741369346; bh=iG6tsVxjGS
 0Zf35Jd1884B/BxfMxaTBB+R8FbM+3Nck=; b=AKRfD9vysL3dIJ4UKIVRw5uKOT
 /6/iRspW8AlbCoDTmY6KbYoX2eM4P618HPHu7+nkBY8LTgbVFy+065wJdiPHsgQP
 lBhjI685Xtirv6JUny/XyrxUanbqIrS6WR4IF4Nstu1+kiaue5pEi4kBzNDQD6G4
 N6Ebw7v0qvXT5CMexoWEix3Uc9y0xZzrg2HHP2j0Kp7i/LzsmXaHbDB5J3acDH6L
 5xM2dV8e5D/Hrt6/+O3OTTW+LtQO+16wmNHEqxt5OHTIsdOEyV3Pr+QM5NosKlDc
 fLtnX7y0xr5mXKw9oTEED3RfcI/wZdNQ885TEGsn0//4P0XSqQ6ZhrHaNaFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1741282946; x=1741369346; bh=iG6tsVxjGS0Zf35Jd1884B/BxfMxaTBB+R8
 FbM+3Nck=; b=TTcdVBdzAZd0a9ELVwSgoYWzfgXSJvFqf9fKcAnnFgYSZH9K3RV
 aenIIK8MFkZPe8vcIv4u1LtcqPrYQsNM8uw9wLxKVWH9mLO8dGx6WPUB3rTYpqCo
 +ZYgL1ckWT6y9cDsPTKi5bWop3H7IV4+g6I92ukRc5YqBzfFZaCP9XJeNDfWbJEY
 zYzJj++YzqT7XjynEOm+Glzfd1Vk/J66HT9F3Pkg9Uk9WaxcInyykhqY/UY92eXZ
 Wyj05ERB46oH5zrsWk9tI09IqGG+XzGBrP8xxFbyNRK8oJN0c5Hv4I1CeRcFmX3p
 X/f8liS5awn/cW298jioygQke3Yu/qgGxtg==
X-ME-Sender: <xms:gt7JZ_Gcs2XzFtzAfJbYydH9z4Yw3M5KFFaqPcHFlYWf0mGRIPF1Sg>
 <xme:gt7JZ8V0nKB2gm5kzEx-hC9vSjHG7AGwtWHAWIMU03lmwHLEIGNiTOXO62ygoQPkI
 OU8rvPs1qtVRllriA>
X-ME-Received: <xmr:gt7JZxIOg2bThkxLZWvN1h4s1oKzYq48zvpKIEXO0ak-9p8gew1AjfsknY160w-qTQD_20yJ5ReFVsKTLoNFRTRaNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
 fufffkggfgtgesthfuredttddtjeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhho
 nhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpe
 eugeeuhfetuddvtdejveejhefggeejgeeiieelveevgeeiffdvheehjeevveekfeenucff
 ohhmrghinhepughpughkrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
 hmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnhgvthdpnhgspghr
 tghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnnhhouhhntg
 gvseguphgukhdrohhrgh
X-ME-Proxy: <xmx:gt7JZ9GV7D05aJtJdhqa7HobOoQM8Vlf1Klb0YohNNT0-7VBy8rlmw>
 <xmx:gt7JZ1VURYNyR5DO-zm5SYxgVlRJnTmeov-dvpXt2GjpS9ro5FtZCw>
 <xmx:gt7JZ4PiiyP0dDrtHB1pRugt0slgNX6jvrm13cLU8C9P2dXzVxfnag>
 <xmx:gt7JZ021cq1cxfCJlJdmrTxxqH2gZkkR5EqZzPV_RvfJM7adik_1og>
 <xmx:gt7JZ0cqGH4n3bT0BwtAyHXN_mpx3bct_9_c6fUCE848bks5RQfmcWWN>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Thu, 6 Mar 2025 12:42:25 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: release candidate 25.03-rc2
Date: Thu, 06 Mar 2025 18:42:23 +0100
Message-ID: <4098448.yKrmzQ4Hd0@thomas>
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
	https://git.dpdk.org/dpdk/tag/?id=v25.03-rc2

There are 251 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_03.html

Most significant changes are in multiple drivers.

Please test and report new issues on https://bugs.dpdk.org

DPDK 25.03-rc3 is expected in one week.
As it is a small release, we may try to close this cycle in advance.

Thank you everyone


