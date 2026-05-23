Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80399CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 07:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91088402C3;
	Sat, 23 May 2026 09:36:45 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id C424240264
 for <dev@dpdk.org>; Sat, 23 May 2026 09:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=dauhVrGVB8eR8vKqTtbv9bXNCxYfnbP4JfVs9Z5qSDQ=;
 b=LTF9ULSo+MDMZGHUoRYm2/09YkTFkUsTXUe1j8iJBmR08Q1S5sORYJWhXEIAXS
 v06TeuNKsyMXPyoIS9Bz+o25Mr+3GNrmI0IXaqYI27OKFyvxpLlPhsM0iY2OCBOV
 Bxl5C8rquCfEN1BqjrK7Xo6FfUuUj1YFRhjAHOE51G8uM=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAHjHYCWRFqzLsOCw--.49981S4;
 Sat, 23 May 2026 15:36:39 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [V2 0/1] net/hinic3: Fix VXLAN TSO issue
Date: Sat, 23 May 2026 15:36:16 +0800
Message-ID: <20260523073619.996-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260520065817.931-2-wff_light@vip.163.com>
References: <20260520065817.931-2-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAHjHYCWRFqzLsOCw--.49981S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOv38DUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNQc2QGoRWQc2UQAA3G
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

V1: The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function

V2: Modify the commit information issue and supplement the commit information

Feifei Wang (1):
  net/hinic3: Fix VXLAN TSO issue

 drivers/net/hinic3/hinic3_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.0.windows.2

