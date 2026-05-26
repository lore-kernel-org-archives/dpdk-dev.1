Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E01CD5BB1
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 12:18:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22041402E1;
	Tue, 26 May 2026 14:18:45 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.5])
 by mails.dpdk.org (Postfix) with ESMTP id 005BF402AC
 for <dev@dpdk.org>; Tue, 26 May 2026 14:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=4shopRdG8J+07FhI8ce+sMjLJvuD1Xj6suohAydVZwU=;
 b=OFB9b7RoBt7BdwVIW5ueV6s2wFMidw1D6rnw6v9CIkaLdchjwRcbDais4hq0AO
 2sPrR+WuL4Ike7Ft1aDba+f4seomIsL/D8UnyL9L9gNk1EI1SPx64BOMR8CpeGiL
 QHsMkwUlYY1tu3fLCRX1f2/Fzn0dquKggQYbubL/3yD5k=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgC3e2ecjxVq8f2ZCw--.62826S4;
 Tue, 26 May 2026 20:18:39 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [v4 0/1] net/hinic3: Fix VXLAN TSO issue
Date: Tue, 26 May 2026 20:18:17 +0800
Message-ID: <20260526121820.1093-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260520065817.931-2-wff_light@vip.163.com>
References: <20260520065817.931-2-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgC3e2ecjxVq8f2ZCw--.62826S4
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOWlkDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNgDr9WoVj6Di3AAA3G
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

v1: The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function

v2: Modify the commit information issue and supplement the commit information

v3: Revise review comments. First, deterine whether the hardware supports it, then add the flag bit

v4: Fix the compilation error caused by leading spaces

Feifei Wang (1):
  net/hinic3: Fix VXLAN TSO issue

 drivers/net/hinic3/hinic3_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.47.0.windows.2

