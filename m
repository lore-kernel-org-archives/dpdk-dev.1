Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021ACC021A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 16:50:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42A4642E61;
	Wed, 12 Feb 2025 17:50:04 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id AEE4442DBB;
 Wed, 12 Feb 2025 17:50:03 +0100 (CET)
Received: from fout-a4-smtp.messagingengine.com
 (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mails.dpdk.org (Postfix) with ESMTP id C344142D9D
 for <announce@dpdk.org>; Wed, 12 Feb 2025 17:50:01 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 3D57E1380896;
 Wed, 12 Feb 2025 11:50:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 12 Feb 2025 11:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1739379001; x=1739465401; bh=cr0pXxOLby
 pKyj6Aa7xM2gC0fOc8bVZ2PPl/h61JqmA=; b=0M6Oyf5S5RjQKSixcvSZK2M8ib
 HxVdiEf1JLhOlbL5oCWxnFRnZs331o0KOw72KRr+a3XIlMRz/QzuYv+QDVPErZ+2
 xs+B2aLm9YXRG1H5FQFNPFtk4cVzVWco4+mw6S6aibGQwU6mKMWA9pR6Uq8ThXzN
 XqXJR2g7SG8U2B2z3EdVRqh/zYZiiJi1gO0tJhYRX6wqw1AYftZU0RAe0dKZrvLY
 64thkAMoyT9BXtx7PwtB/C2FmcSkG4+l28KELCl272qUAdXvooqHqwIkbtMFkhIG
 fVRUmj5CiwD0v3imfIIKBfweQKI4sd5tvWVY+bTzIP0EmXvDZH5Wa02gsneA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1739379001; x=1739465401; bh=cr0pXxOLbypKyj6Aa7xM2gC0fOc8bVZ2PPl
 /h61JqmA=; b=MmKEZv5lppeFxDuOI2OjldIysEbGhhe0UCODHdWs5A6eF6Kkv37
 weOS39TCGRx9MRhmFtAUBwM9PYSME3VdneIulGlU8GwfrcFdcSqn6HwFJ4fgPDoT
 6w/cx81lN3CgoJ60Dl16WK2NQko0NZHO9dVoAXU7Reaqwua0yyHB1Dt5fNdSOgqO
 NBF7zeKVMEC9IQ4UzTyaOHpFTf7de3IoZP8ViY3PweBI8ojg/ZPOOgLHE4ijax/r
 djUnYaBdOs8wt67ZuRg21XPpaEviT0Y4z3po6OfsbyLnKlb5Z7c/1n79q7mCYaZW
 C9uJ5dSSYZ4Yyv6rROCW8YzG1IVhrwVxeew==
X-ME-Sender: <xms:ONGsZ_Qq150P73SdutnL1mPpKC83bIedvMNEE-92Z04nVvS3g2FwfA>
 <xme:ONGsZwyeGv4j6QqowFt_Wk3mp4naMqEY0q5HDHGtIrlwqi_5otd3Okwfq7Q8E5lKV
 DJtwHe4mR9lEgy9eQ>
X-ME-Received: <xmr:ONGsZ01rxC1IxpaKEA2G9d7-2xQ_o3_kriIDCFGQNZrqbaNB_R02ReaAczemSklemDoNE6uMy--FgGJqk6MVdJ-8mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeegtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
 ffkfgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhn
 uceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
 eguefhteduvddtjeevjeehgfegjeegieeileevveegieffvdehheejveevkeefnecuffho
 mhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgt
 phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhnohhunhgtvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:ONGsZ_BJ6OpUlZeyZL4N0W72sQuI6TtDjf7TX_7jfuSy2yAmCmD-FQ>
 <xmx:ONGsZ4jf2DxsN5G_6XaruBKNWhUMNGrL5supKym8lr_1O4ksyCJyqg>
 <xmx:ONGsZzr5cUMO1LMg6VR_Mh6Hv_m0ceF2J6oosHgS9yG0M1KToKmRaQ>
 <xmx:ONGsZzjLhp30zktLKV8T940bV4axsClRkXgk03WoAoXv-OwK96mIzw>
 <xmx:OdGsZ0aj5Gixn3Ys8J3bJ3XxJ-5vbGRasL8Qd3SeaKDFWcMrw9wbVPdJ>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Wed, 12 Feb 2025 11:50:00 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: release candidate 25.03-rc1
Date: Wed, 12 Feb 2025 17:49:59 +0100
Message-ID: <17054329.0ZKypZ73Fx@thomas>
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
	https://git.dpdk.org/dpdk/tag/?id=v25.03-rc1

There are 478 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_03.html

Highlights of 25.03-rc1:
	- Staged-Ordered ring (SORING)
	- mbuf raw bulk functions
	- some Intel drivers merged together
	- Yunsilicon xsc networking driver
	- ZTE Storage Data Accelerator (ZSDA) driver
	- Intel compiler icc support replaced by icx
	- more function annotations for analyzers
	- more MSVC compatibility

Please test and report issues on bugs.dpdk.org.

DPDK 25.03-rc2 is expected in more than two weeks (end of February).

Thank you everyone


