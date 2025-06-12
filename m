Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7EAC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 01:56:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 863A840BA6;
	Thu, 12 Jun 2025 03:56:53 +0200 (CEST)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id DF3824021F;
 Thu, 12 Jun 2025 03:56:51 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 2748240156
 for <announce@dpdk.org>; Thu, 12 Jun 2025 03:56:51 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 821412540188;
 Wed, 11 Jun 2025 21:56:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 11 Jun 2025 21:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1749693410; x=1749779810; bh=ELpRar/0so
 DKcZh25YWWDk7Ay11i7lVHtwnEqKW8m/s=; b=T8QsqGpQ8R4F3fcDGscTHH15H/
 trHGMDck5YlAMItlm3w5SRSN5fbnjtmle3ks//znHgfEeEkouOt0HhJ32M5akgMP
 JDRM7CKu0Ub32SDHb4lSlxWQv1P2IkNxih3rI4jdFNMXe/YwiZCUQJrrNedEvn5o
 /oVfM3x+/q5sMStwztfydtILnC4WqxTkf8U4ThFEo1jIJvIFakC98SgYEMYU4Ez1
 JhBtCQQ8VvVQdeXloGyJxsR4I0YKuHKTmS0yMf/CStIBQhMVbyqHufXdigLJ75Ag
 TnWsQrihekA1PyIAWPmZ5HiJL0xem8CO5SF2IOIzicwGo5XeEfCgQfGnasZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1749693410; x=1749779810; bh=ELpRar/0soDKcZh25YWWDk7Ay11i7lVHtwn
 EqKW8m/s=; b=Y0q2cjlMg+L0ooW+lNQFnKq1y7BtWdx/hVPEFes2e8lODEgrP5U
 WZQtsOBmY34uZJX68MQRIb8HuZfJhUCOfFdrGpqzqJLmVsT4LSOQ7f8bRU86KyUw
 0rCnileh8AKfaDzQH3cjum8ylXdJnsbnQ0z9dTZmrWTdaCALtC5xF1oOzDM8g8Hn
 7g51MZO8vVjIlS7BBvqVJV9dN/cg+OAVwdQvZbA807hXY3XsvtLZdGISRbQGn7cM
 xuU/dnU1qMgLASByKFBMdP28KKZQiwmNa5cdWt48Lj647dEKjonSeV4rqewfmxE3
 JM6XkJbO09axdB/gal8BCroiDxGC1s+W9VQ==
X-ME-Sender: <xms:4jNKaBksP0WGb87uSSK91KEs3Wiq1AtCTSJLDS3F9yVHyP6YWJ4JRw>
 <xme:4jNKaM1YhtoFPf9E6x_0HfZqaNaZd4eMhLmg9KygUcEOZr1GlCyQQiQnm3taRGnvL
 jv6d1OlP7--cb38SQ>
X-ME-Received: <xmr:4jNKaHpVWFnQNdKFj0e_0LTVBbXIEiQNz9Iejy0dzZpiPAsJ_qpc2LjN_0UVM7zoXXAS340sLK8FSYn-6FsFBsdLog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddufeektdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
 ffkfgggfgtsehtufertddttdejnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhn
 uceothhhohhmrghssehmohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepue
 eguefhteduvddtjeevjeehgfegjeegieeileevveegieffvdehheejveevkeefnecuffho
 mhgrihhnpeguphgukhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgt
 phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhnohhunhgtvg
 esughpughkrdhorhhg
X-ME-Proxy: <xmx:4jNKaBltw0R6-2CZ2Pk9bFKLGij00OdNubep6K-GzEIlctdoSYC09A>
 <xmx:4jNKaP2tiVgXDC7cb39Bn4QoSD5oACkJM47ZxQYbpw2yvJXbawR90A>
 <xmx:4jNKaAv_ErH8N9d1uUffrD-ZGxG7eY8r4dxnGxmSqVj6lMgF3da4pg>
 <xmx:4jNKaDUL_JBZAJJnIu-mX-LFtwz8-liAV2sdqSRfwlmBADqhKiwf_Q>
 <xmx:4jNKaEmwG5gRu_upxDyXFHfoqGqUBbj6ZhKBTOuY-qWc9dhq0DjSGw5j>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Wed, 11 Jun 2025 21:56:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: release candidate 25.07-rc1
Date: Thu, 12 Jun 2025 03:56:48 +0200
Message-ID: <5554581.qSoW2BAyJ8@thomas>
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
	https://git.dpdk.org/dpdk/tag/?id=v25.07-rc1

There are 542 new patches in this snapshot.

Release notes:
	https://doc.dpdk.org/guides/rel_notes/release_25_07.html

Highlights of 25.07-rc1:
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

Please test and report issues on bugs.dpdk.org.

DPDK 25.07-rc2 is expected in two weeks.

Thank you everyone


