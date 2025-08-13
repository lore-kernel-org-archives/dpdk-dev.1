Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B65C87FCF
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 15:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2AD940657;
	Wed, 13 Aug 2025 17:28:51 +0200 (CEST)
Received: from fhigh-a1-smtp.messagingengine.com
 (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
 by mails.dpdk.org (Postfix) with ESMTP id 06C2640265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 17:28:49 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 5136A1400156;
 Wed, 13 Aug 2025 11:28:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 13 Aug 2025 11:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm3; t=1755098929; x=1755185329; bh=EU0oQ2SGz7mhpExGYKmjD
 DDOxV/mDVWsTcHvS2hwyTU=; b=T52INTlrSkbIEINDmzgGmN6o0PlzI2Jk6ac9v
 s+zTMOuo2XOQV+IN79CZk+JDLiE7ShiugPsm2UFtt/TWAEZ6MmclUgA5iNKaNbD3
 R64fqvll+gWB5Gl20VcNx55sHKNUleoFOkwTX9L7nxnimZd2fZbqB0iMM7IyowlF
 5YK6WG/yPfJd7x/re3+ilwWEQYJb4/X36kbYyAjwu73YMfy5sLZWIUBj8iRnqmct
 4mJ2FV+J2niLdD+SI3vw/0zkNl0hAycLu+zRpY3162QjjiV7IHiqs9EVFXag88Uf
 aL1K6bAIljYOoDhicp6Y+j7rTciaSFybQ8tWuzIUZRS2tO1PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1755098929; x=1755185329; bh=EU0oQ2SGz7mhpExGYKmjDDDOxV/mDVWsTcH
 vS2hwyTU=; b=aU9HSDj+clY/6Yb03wyu+Oxv8ipVmmt+4b3Kro4I5ORWT1uY8Om
 mmLDn4B14cJl+nTgHQ/UZIJdx5+CZXRm62d8sZoNNvgkFhq0uHem/VE6jPC4B2gr
 07BxK/UBBt0C0v/DbeV5ZeJnv371Cigoapg+F9KTFN1ikA/0bi/1nIlzXsmAWLZY
 YBYf07STNISvNvsR/qmd1Hcq3KHYcoQYoKEcjCiJPG+rA187mZY4hw2ECDhS6luQ
 J3eiZZKLi1LalyFUv2oVm9kBw2tbNzRlkGFEDMNnqU9XfBRYyK7MqAAOEiYObdNu
 E2qLXHvfaYMEGtamrvTMSoeSNsrKRt9ojtQ==
X-ME-Sender: <xms:Ma-caP4PQEaB9-RrEhypYMkg6q8cliCGfMWvZDAJQ-z5tvDeS5yQmQ>
 <xme:Ma-caALQfYJ1fCiK1n3wOLQl2Zv5c40oLpYeMsEzVoTVd9sycyWTK_lkyMBW97-Zv
 MgGLy-L_aITrNW4Jw>
X-ME-Received: <xmr:Ma-caHFx67zSfnbswbN5SnQyO-iF6_dxx5Rg26--tqx8Yd2NSsqDR_lGJ2yZ0q3NCEzRkJv0T8NmLIcHP51-XTW-atQEstQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekheejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
 enucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhj
 rghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpedvledvudehvdduudevuedvveehge
 duleegiefgjeehudehtddtgeduffejiefhgfenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpd
 hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghv
 seguphgukhdrohhrgh
X-ME-Proxy: <xmx:Ma-caGU-eQaaTDYI_lePw2Gidc4Eta9IQ8HEZ_qrF0TpMJmK3M4FBA>
 <xmx:Ma-caCjQPzPAWwNpN_FP1HpRRG_soMMF_Owqhw16ve1ijdZTmrPwUw>
 <xmx:Ma-caHSGNF2Aj7klJTh3r1gSyrTn6pHcEPN7pVzGZTyjQfwH-6wZbw>
 <xmx:Ma-caFFkxCyIwQUCwVAou5DMxjl7r74pZH94cmLKXQ8EPj725Jh8XA>
 <xmx:Ma-caEIw5vii9vEpXVTrEg3IcnbCXA48DeeoFmOWaLF_uWIuwdZfzs2J>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Wed, 13 Aug 2025 11:28:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 0/3] fix build with MinGW 13
Date: Wed, 13 Aug 2025 17:25:22 +0200
Message-ID: <20250813152829.457463-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.47.1
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

Thomas Monjalon (3):
  bus/pci: fix build with MinGW 13
  net/mlx5: fix build with MinGW 13
  bbdev: wrong fix for MinGW 13

 drivers/bus/pci/windows/pci_netuio.c      | 6 ------
 drivers/bus/pci/windows/pci_netuio.h      | 4 +++-
 drivers/net/mlx5/windows/mlx5_ethdev_os.c | 2 +-
 lib/bbdev/rte_bbdev.c                     | 9 +++++++--
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.47.1

