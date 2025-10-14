Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1441ACCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 09:15:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46DC4402AE;
	Tue, 14 Oct 2025 11:15:36 +0200 (CEST)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by mails.dpdk.org (Postfix) with ESMTP id 9696F402A8
 for <dev@dpdk.org>; Tue, 14 Oct 2025 11:15:34 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 143DB14001B8;
 Tue, 14 Oct 2025 05:15:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Tue, 14 Oct 2025 05:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1760433334; x=
 1760519734; bh=pBpFppOQFgVk93m4Ssy9xObU4UU5ZOdiR1u+dnaIKRE=; b=X
 pvPDGc98UHJb91H8CVyKvr+5/BK/YbMMX40z4OEVBfdb8NJd+KMZ4bSZ85+n7+Tl
 vJFgGpV+U4pw66QmkZTGafhcsu/VXnm3IpJPIwwB/DEbXpi3bWBnDohGdpvVRrzn
 j9eou3db6i803QB1gS+SD7htus5ymfXmFtjaLFWtYaImsXGYCdY5JGKn1kemqnTb
 VDvyuEvRaa5VLx+V1BJup/VZUO1Y0jqA08WjDGp4kB+wJ5Srexr8VMagj56sE8z4
 Mo3278hKYu5Vx91dmbsoYEVchOO7ApJy+pTiWocqp72x4zyc+56BwxmG5dHI809J
 +QjmXCvm4CAPbXjIiElZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1760433334; x=1760519734; bh=p
 BpFppOQFgVk93m4Ssy9xObU4UU5ZOdiR1u+dnaIKRE=; b=H79cZTX92cugwhKxy
 wIzz8pCb+CLkS3giJtvSZVlrGzISjQab3t1/xJxHBOv+fQQf/ptg+sQLYewmC4VB
 Yyt0rJi9vX0J+jT9hGlFvPKHXrl9szht9e966h3R4LxOINBV/+t5JlhQBfpYYolN
 Psvdh9UpXP4/StYdA/gDqnmqw/CQefAX+GLW7VsMD83Acgv/Xu1UjoUmkxat9Ugw
 ZmYYRXoedkE8cM2XpAWl5rIxX96F20iJ2O9ZHmWgc09QtDzSg2aJOHWvWfXiOMNp
 8JrWUUWK7dCPIAfSzbEu0sTReE2U+vLoTOPv+1jCAH6+XQysMWGoKjJS5M9x2Byl
 zJEKQ==
X-ME-Sender: <xms:tRTuaMtqc_ZpIaJMBMHsYNGYgsNxMRswo_ex2vGJYTji0D88N1lPPQ>
 <xme:tRTuaFzH5d-p85wzQ4ZyCVsGDaPb6uGcoOje8200NlkslKoQcKBizlazPodu76d6h
 Ap9WNdg-WLSvTZ5W_H04qal8VIXF8FfO2p5iQd_4yGS_gGwwqHZj90>
X-ME-Received: <xmr:tRTuaKiTwWXwchJXtd2rFmJWjkwtrrfCEDfj2Dq7qkiqhMslnBMaeAoPOEXY-LlEuP5ksNHvELvtqFxh3hgD5DqyM1FtZpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtudegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpefvhhhomhgrshcuofhonhhjrghlohhnuceothhhohhmrghssehm
 ohhnjhgrlhhonhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejhfdugeehvddtieejie
 egteeuudfgjeeukeeiledthfetveekhefhieelhfdtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhmrghssehmohhnjhgrlhhonhdrnh
 gvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
 uggvvhesughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsoh
 hnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:tRTuaBBuiOWECjz8paEG0VbSHqWk6J3DjwY_3GFPmIZQXnZUX43bEg>
 <xmx:tRTuaPsyAtmymhexbuTouTUQ2cNFFV2yUdJRf7_Rcpz9yZowMj9hXw>
 <xmx:tRTuaOZ_-zAMGeLCLvEc_mIQ5zPUm0GnpVuvfMGPENzObSTwMC8Sug>
 <xmx:tRTuaKWWzBXbB4o68qAybGC4IFP2cYqcExbXrDdcRudPBn-d_A_0TQ>
 <xmx:thTuaG086JSbA_OZ0qSY0eOLrd0M1VKRp5_AZzFG6yvaiM4cb0-ZHDBA>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 05:15:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v4 0/3] fix build with MinGW 13
Date: Tue, 14 Oct 2025 11:13:58 +0200
Message-ID: <20251014091528.936405-1-thomas@monjalon.net>
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
v4: restore Windows build + fix Coverity warning for bbdev

Thomas Monjalon (3):
  bus/pci: fix build with MinGW 13
  net/mlx5: fix build with MinGW 13
  bbdev: fix build with MinGW 13

 drivers/bus/pci/windows/pci.c             | 11 ++++++-----
 drivers/bus/pci/windows/pci_netuio.h      |  6 +++---
 drivers/net/mlx5/windows/mlx5_ethdev_os.c |  2 +-
 lib/bbdev/rte_bbdev.c                     | 10 +++++++---
 4 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.51.0

