Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6764CD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 13:01:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B4B0402AF;
	Thu, 28 May 2026 15:01:52 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 9721B4003C
 for <dev@dpdk.org>; Thu, 28 May 2026 15:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=emmDvtXtpUcRKXIgFs62QfCDc8JkOxRmT5r11N22mnc=;
 b=S10r06lINn5kE1h0nGvGYkGHpFjbNcyTu+cvEhnRqSkWeqRkHeWxNhfw+S3f9n
 cns/eD3uAtl7ouBdcXzPMpzEMPUYCIlXMU0WPR9/7Km8FN3TbnWseMcCM9O7uRgf
 C7F5LTDD9Rktt94SG9beEpZzYjSz0Zk/xgOLWiyQP0+Nk=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgD3g3ayPBhqOOLhCw--.25977S4;
 Thu, 28 May 2026 21:01:45 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Subject: [v6 0/2] net/hinic3: Fix the hinic3 driver issue
Date: Thu, 28 May 2026 21:01:18 +0800
Message-ID: <20260528130122.1213-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260526121820.1093-2-wff_light@vip.163.com>
References: <20260526121820.1093-2-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgD3g3ayPBhqOOLhCw--.25977S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrXFWkurWrJFWrWryfXFyxXwb_yoWxWrb_Cr
 40g3s7u34kWFWDAw1Fka17A345KF48WF1fJry0qF93Jry3ZrsIqr1kuryqqa4kXF4j9Fnx
 Xw15X3s3A39IkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbhZ2DUUUUU==
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNRnd52oYPLmtBQAA3J
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

v5: Add fix tag

v6: MOdify SP230 NIC vf device id

Feifei Wang (2):
  net/hinic3: Fix VXLAN TSO issue
  net/hinic3: Modify SP230 VF device id

 drivers/net/hinic3/base/hinic3_csr.h | 2 +-
 drivers/net/hinic3/hinic3_ethdev.c   | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.47.0.windows.2

