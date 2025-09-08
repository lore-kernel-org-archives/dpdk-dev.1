Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82267CAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 21:20:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B8F0402D3;
	Mon,  8 Sep 2025 23:20:47 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 4B57C4025A
 for <dev@dpdk.org>; Mon,  8 Sep 2025 23:20:46 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A73391400189;
 Mon,  8 Sep 2025 17:20:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 17:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1757366445; x=
 1757452845; bh=fjZVuDbD6/HmxuzADQ5vQAs7ZlNW2UtaAfztiKiOYbw=; b=c
 5WQZLmx5JsKt7JpAHid76X5Z9oN0MZgfHVVknmBzVmbjGBBj8/oIjayza2pnCjDB
 8YXqWP8Bx9GDb8Ktd0EZeIWGPOQ0vjLohQrV/aY8xPh89FNvf/imFp4oeRvrwS2U
 +Et8zli5hT1I2xH/kNAFb3r2PxNZkkrYacEd/bPTzpkj3vzIfWd3V46DnHm47U3+
 m9dF6dKvH4NS/N22f1+eMruanEomNvZ2NZSDBaLtJ1psBnuOn8loyzm4spPmGuYt
 hIRU3Ex+CGJwN/Re5xYjzO+7Um4zkoGaOFdywGz8RaorTNJR/uXqd5z+ZhNP8Ltw
 21cou2pjy0TUCblt5EC8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1757366445; x=1757452845; bh=f
 jZVuDbD6/HmxuzADQ5vQAs7ZlNW2UtaAfztiKiOYbw=; b=FZ3S7fo1V2z++Z3y8
 ykpiClsXJhUKb+ad8FLNVARTxKlyaCSjqPB0ANbfWzn2PuRlmV7LPpHpHGQSJxyY
 +HlmSxmLIkhJNDRRlwLExlcttyg4TaFbV6kozYf73/nocELvpk2tYBxNnpYTsKNy
 CkOuqsIIOpVXQLIiOb7vsMluy7sfWviAPQqnqYnnZQ55xoIeFum09lWm93/WvDXC
 zpyzCBFyJLIAfHytNWuqvg5pJW1gdAJ5QPGhjxs3VXjau1oLLf7ZI++oDWe052Kp
 r6Punx7FocsjlXzfls8x1a65R6AKi7SwjytXLNi5uKKbGluJJovGUj6hqpA1CPoc
 TwkyQ==
X-ME-Sender: <xms:rUi_aK2h97wn9q-jtAt4ycrdjY07nyC82TullDdYTvriN37ybcXhqA>
 <xme:rUi_aCVOLBFmV22IFdaLD6zpFUOHhM2yIFnKC5hSnvp-PdidzEsH0CKjOr1B7T4IH
 9vZB-2uZtajT20cjw>
X-ME-Received: <xmr:rUi_aEkjwhZdUQx6ZTKfhyglmlrDWfDqZ7snjmEQD4_ElVGF6FuaHCro3CiaxjOY0VTRNiaodPeR-8FxnuSLDSQtpnlEzrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeitdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
 dttdenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhho
 nhhjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvjefhudeghedvtdeijeeige
 etuedugfejueekieeltdfhteevkeehhfeilefhtdenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvg
 htpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
 vghvseguphgukhdrohhrghdprhgtphhtthhopegsrhhutggvrdhrihgthhgrrhgushhonh
 esihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:rUi_aECS8SUcrVed-eHBAzYMny6aizOI1XkJHgYR3vQSBOg7Qj3tmA>
 <xmx:rUi_aEcOG6y4WMHLfA4Sfv1i8tWQST0NcM8TqTUHsW2SFj8OqzoC8w>
 <xmx:rUi_aPJbkzu2EyOkr73YT-T94toD1hSCISkS1cXalCB2syzLlLQkMA>
 <xmx:rUi_aHd9Cf9EmMiPo22tvMr_BimM_CbCSHtrTQXBMU-1URAhEPhjbQ>
 <xmx:rUi_aGU1IHL1iS-r13TEkek5gn1qfY30XOHCIwPmEc10WkJdd817trqs>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 17:20:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v3 0/3] fix build with MinGW 13
Date: Mon,  8 Sep 2025 23:17:48 +0200
Message-ID: <20250908212034.699713-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250813152829.457463-1-thomas@monjalon.net>
References: <20250813152829.457463-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After an upgrade to MinGW version 13, some compilation errors appear
in PCI, mlx5 and bbdev code.
This series fixes them all.

v2: improve bbdev patch
v3: try to fix Windows build of PCI patch

Thomas Monjalon (3):
  bus/pci: fix build with MinGW 13
  net/mlx5: fix build with MinGW 13
  bbdev: fix build with MinGW 13

 drivers/bus/pci/windows/pci.c             | 11 ++++++-----
 drivers/bus/pci/windows/pci_netuio.c      |  6 ------
 drivers/bus/pci/windows/pci_netuio.h      | 13 ++++++++++---
 drivers/net/mlx5/windows/mlx5_ethdev_os.c |  2 +-
 lib/bbdev/rte_bbdev.c                     |  8 ++++++--
 5 files changed, 23 insertions(+), 17 deletions(-)

-- 
2.51.0

