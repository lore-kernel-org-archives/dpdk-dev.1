Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31255CD4F5E
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 06:42:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E2B240608;
	Wed, 20 May 2026 08:42:27 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id E61464025E
 for <dev@dpdk.org>; Wed, 20 May 2026 08:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=BtxSm1PleCh/TT82L3rEbocCFm+mUN1Kknk6edGV5TU=;
 b=jPvfrNb/hPUjStHVcbk6isC+oh/N01qF/BXCm+FK3RQ9ZXmuPZYkX9IPdqqWYW
 zKrEm02SyUVBXi9Ug98gk3U3FIFx/W5hET77wiXh7RlLYO2Q3V0IqAzdM+dQ1vrT
 0rwQoWHwWTCBMTlEDti0S/B7nEnBKm44A22zoiUMhZt1A=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgD3byzIVw1q4vOuCg--.13197S4;
 Wed, 20 May 2026 14:42:19 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [V0 0/1] Add VXLAN TSO function
Date: Wed, 20 May 2026 14:41:09 +0800
Message-ID: <20260520064112.705-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgD3byzIVw1q4vOuCg--.13197S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOv38DUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNAzm8GoNV8z9awAA3E
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

V0:The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function

Feifei Wang (1):
  Add VXLAN TSO function

 drivers/net/hinic3/hinic3_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.0.windows.2

