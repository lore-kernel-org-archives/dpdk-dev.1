Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02104C54E90
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 May 2025 13:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DF4440661;
	Thu, 22 May 2025 15:06:49 +0200 (CEST)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com
 [52.119.213.154])
 by mails.dpdk.org (Postfix) with ESMTP id 445E040661
 for <dev@dpdk.org>; Thu, 22 May 2025 15:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1747919207; x=1779455207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=mjViE5GihM/7hPFITPO6iPt4X7jcaYJLZw737c3eB+M=;
 b=LGEw6sYkeFVHcgaBLwu3izdXryz67RyyiCPxbKLgnBlNk5iVgtDry1Mm
 KNYuSoZhUJRLFt35NVjGehAtDq8dOwfrPXoAH9AJyMRu7o5Ar6VV2nklg
 Lp3+0qv8CeE9eeNeZSrm00VviEdB8Vwrp/xE1LZg7jz2FIMmgBwEQhnB2
 XPfXiTeUYFUtukhvxDfez6p0QIQJ8uKnrhH2g2GXOn5TcTFMt+JszrnSX
 uASTkREn68eLdUkqcU//a00uqA87pGHqlFwNAvmmB8yLhXNB4nwUnv37G
 OckInGuWty6VDO1s/IcfZasZj1tXJPgSPG1dqKVjwcwDs8DKGQILaWBdg A==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; d="scan'208";a="300686031"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
 by smtp-border-fw-52004.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:06:44 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:5700]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.1.135:2525]
 with esmtp (Farcaster)
 id 41817c00-49a9-4175-a7c4-313c955e3262; Thu, 22 May 2025 13:06:42 +0000 (UTC)
X-Farcaster-Flow-ID: 41817c00-49a9-4175-a7c4-313c955e3262
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:06:41 +0000
Received: from HFA15-CG15235BS.amazon.com (10.106.83.24) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:06:40 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 1/7] net/ena/base: avoid recalculating desc per entry
Date: Thu, 22 May 2025 16:06:16 +0300
Message-ID: <20250522130622.3192-2-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250522130622.3192-1-shaibran@amazon.com>
References: <20250522130622.3192-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.106.83.24]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

desc_per_entry is precomputed in ena_com_config_llq_info() using
desc_stride_ctrl and desc_list_entry_size, which remain unchanged after
device negotiation. Reuse the existing value instead of recalculating it
in the fast path.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_eth_com.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 90dd85c7ff..c6668238e5 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -248,11 +248,7 @@ static int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
 		       0x0, llq_info->desc_list_entry_size);
 
 		pkt_ctrl->idx = 0;
-		if (unlikely(llq_info->desc_stride_ctrl == ENA_ADMIN_SINGLE_DESC_PER_ENTRY))
-			pkt_ctrl->descs_left_in_line = 1;
-		else
-			pkt_ctrl->descs_left_in_line =
-			llq_info->desc_list_entry_size / io_sq->desc_entry_size;
+		pkt_ctrl->descs_left_in_line = llq_info->descs_per_entry;
 	}
 
 	return ENA_COM_OK;
-- 
2.17.1

