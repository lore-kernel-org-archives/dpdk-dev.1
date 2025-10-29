Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBCDCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 02:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 039A1402EE;
	Wed, 29 Oct 2025 03:08:52 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by mails.dpdk.org (Postfix) with ESMTP id 387A540262
 for <dev@dpdk.org>; Wed, 29 Oct 2025 03:08:49 +0100 (CET)
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59T28ko963479729,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
 s=dkim; t=1761703727;
 bh=Bur+lL+0n4YpSp7kLzxlQSKkKE5NsV8BEc+0+xwskJM=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=Ys08xDgTQ6cw9BU3O24k6zIlfS7QXOXaUhVSqtUj+1Kv2f8DuMyKPvnqXfeE+2AQG
 DA2RCzyR1A7PTt3lsBIiueibkyG3VVJXdqCIeIyjZyZDVOeZwbfSPLd4vj5hMjVQeW
 TsgiJ7BTGxFVvHuqEljt3Ut92GEnmUJRqvYh21wZOZr3JvrSIlmi2LXNMhq1cAOEGI
 1i3UdmCAdB57YWAElYTDrTBT88KPXrPNznmVEbtxf/vduGM2gu9xjZfwF7e3SDxmDk
 /ZO5CtoMgoK4Xj8oUB6PSbVovBJX80kHmBZXLhcefCKmvLl07gi1WEhMQhSCUBwunN
 mSW+QiV2iw2IA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
 by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59T28ko963479729
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <dev@dpdk.org>; Wed, 29 Oct 2025 10:08:46 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Wed, 29 Oct 2025 10:08:46 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Wed, 29 Oct 2025 10:08:46 +0800
From: Howard Wang <howard_wang@realsil.com.cn>
To: <dev@dpdk.org>
CC: <pro_nic_dpdk@realtek.com>, Howard Wang <howard_wang@realsil.com.cn>
Subject: [PATCH v2 0/3] net/r8169: support multiq and code refactor
Date: Wed, 29 Oct 2025 10:08:35 +0800
Message-ID: <20251029020838.401035-1-howard_wang@realsil.com.cn>
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

