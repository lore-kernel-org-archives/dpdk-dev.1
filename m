Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCB0CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 08:47:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCF2B40262;
	Tue, 28 Oct 2025 09:47:31 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 79B114021E
 for <dev@dpdk.org>; Tue, 28 Oct 2025 09:47:29 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59S8lQrtD2161579,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1761641247;
 bh=Bur+lL+0n4YpSp7kLzxlQSKkKE5NsV8BEc+0+xwskJM=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=N8ZqS6RjExSF3SKqfhpQREM9LX6bQsNrhvw49jmbHkQkt3ybX43NQl1yj1dKuyl5g
 /gzDRQnikjcC67SNV2meWq7aiMgMUnJs4ruzSpvYlOq3kqxphy7+eB0x1x59Ernh1f
 AzkKUeb8r7Rdgep2eh4pjV/aPX5ADuSr6wT2dzn5UBVKDn+MN7HLyKr+RNYsSFlvor
 v+IuT4/OUuZdrczDmgSXZezMVIV5mXSB5BXGpGwLGOAGMzyRus7eJlcdptuBqml+zn
 a2B9UtvhOZDRUWSyBJ+aIlUpxv8TbzoBi1czJsu3QUS2HVgWS1m226fO2Q+wxaK1dX
 x7m/+WCTU4aug==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59S8lQrtD2161579
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Tue, 28 Oct 2025 16:47:26 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Tue, 28 Oct 2025 16:47:26 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Tue, 28 Oct 2025 16:47:26 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v1 0/3] net/r8169: support multiq and code refactor
Date: Tue, 28 Oct 2025 16:47:13 +0800
Message-ID: <20251028084716.369128-1-howard_wang@realsil.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Howard Wang (3):
  net/r8169: support multiq for 8126 and 8127
  net/r8169: simplify config method check with if
  net/r8169: fix issues reported by Coverity

 .mailmap                           |   1 +
 MAINTAINERS                        |   1 +
 doc/guides/nics/features/r8169.ini |   3 +
 doc/guides/nics/r8169.rst          |   2 +
 drivers/net/r8169/r8169_compat.h   |  10 +
 drivers/net/r8169/r8169_ethdev.c   | 212 ++++++-
 drivers/net/r8169/r8169_ethdev.h   | 149 ++++-
 drivers/net/r8169/r8169_hw.c       | 607 +++++++------------
 drivers/net/r8169/r8169_hw.h       |   3 +
 drivers/net/r8169/r8169_phy.c      | 239 +-------
 drivers/net/r8169/r8169_rxtx.c     | 930 ++++++++++++++++++++---------
 11 files changed, 1230 insertions(+), 927 deletions(-)

-- 
2.34.1

