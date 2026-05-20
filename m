Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638C4CD4F5E
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 06:58:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33915402F0;
	Wed, 20 May 2026 08:58:46 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id 699DE40276
 for <dev@dpdk.org>; Wed, 20 May 2026 08:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=JysJaNvAGLiUuPsUIvyS2PE3M2dpiVoAVK5N4ycyXZE=;
 b=I3gy/rMxCooZKlwqNFM+kUFkdZoRcluc0zVG9dFe+6iGcGlD3APv615NWjLzPG
 Yoo7G5rISTvxyxHuQBvvkcTGTnua+EMymuGXkhaniAMFHa1wywGK0rRJ1wr68Re0
 OiUstsje7KHW6JjO+QIQv0rRBaqGqbYXt/fojiDy7wWoo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgD3z8eZWw1qNLy5Cg--.60640S4;
 Wed, 20 May 2026 14:58:40 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [V1 0/1] Add VXLAN TSO function
Date: Wed, 20 May 2026 14:58:14 +0800
Message-ID: <20260520065817.931-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgD3z8eZWw1qNLy5Cg--.60640S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOWlkDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQDc5moNW6AbagAA3i
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

V0: The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function
V1: Add sign-off in the commit message

Feifei Wang (1):
  net/hinic3: Add VXLAN TSO function

 drivers/net/hinic3/hinic3_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.0.windows.2

