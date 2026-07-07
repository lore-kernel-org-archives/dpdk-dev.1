Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F78C43458
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 14:01:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F232840687;
	Tue,  7 Jul 2026 16:01:17 +0200 (CEST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50]) by mails.dpdk.org (Postfix) with ESMTP id 3E8904027E
 for <dev@dpdk.org>; Tue,  7 Jul 2026 16:01:16 +0200 (CEST)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5aeb36ed873so3030136e87.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783432876; x=1784037676; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8925+08lVABqmBNrueXtyapbA+TeBh33wAqt0g5UJTQ=;
 b=DvoxREjRraYusnyA1+T6HjglNsucd7ylDnDw3qlFPqzqBwZ3+0cg+dML7alyJ8T5TC
 rq2mo++CFPDzjfWDOnNlsHjnIho6izhpxFa93Z1/rZIjr7tPR+ejTcw+vxWLansRNBAh
 DiOgs7/zcJ5jAjaz+kDRwLg3zClSPPF59zuSeRSwhkLRPnODj3jYxExBMufD2toeEurJ
 j654mgnNG2AHu7uRqi3Xz1oPsotk7dH8buWgijzp1NByT8FhN8e8qguFa828gviYnbL9
 R1Z8Rd/Jpla5j3ULVyM9KzGg1x8LEYmQf+V/FbUqkJufL/2zPrTBCKuXlVxYPxI+UkuB
 tSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432876; x=1784037676;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8925+08lVABqmBNrueXtyapbA+TeBh33wAqt0g5UJTQ=;
 b=lPwNW3PV/kQSFig9HJb7gz00qRu2uvOFUeXj6WEIqbMPcexJbfWbHaHPVUc6fSXF0h
 fJJSm++/fdJPWljdGVpf+lxrHli6pO2GUoGSmZhDsMzfECNeyLLnZR9uBCCFxORv3zbr
 JqwrOXrhbUlhMAsLzPO9Y66PJZ1jP6Ukh6L65ucB6Wh9hZU+LdvqrUpag8aQw/Tneehb
 hZQtLBFaZeNLZTusHB/iY37TnPco7I0i3g6dKFRcaDvjpXlvPGmwQFZOBrv/PAUvlGZC
 QMuYf5L+F3DbSxFMH0cTBeWiwc26+YVH8H2kBltomKngFuN7NEE8iTPUg5somulXZ7dq
 cBew==
X-Gm-Message-State: AOJu0YygCw4x0whRR04uW6exPBFDUiOV0fFy9e4HN3G+rtASbZMANILJ
 BRBH85LtvXrWD2e/rii+KwDXqRpyQXooaofpFAzuRG+ZhDv6g5ubomOj
X-Gm-Gg: AfdE7ckceDkFZ9C9Hi2weKE9HsR+f+rZ2mXN8Om5VSsKp7UfnihVnDNxVz6/CSxW2GJ
 SzDtCdQ8T3W+ZYIJ04WHY0RqCCFvBIKR2nT6WZ3+oyS7uP/P1kCrtJ6O6/sBog962koWFwJDW33
 wSUD1qZISqKEDIFsfEJvdKI+qsCFMtfugXOkEd/15TjGsAhpP/zU1zmdvTSMhkKV/bmx3PaAd6T
 Ckcll4Irh7fWeXkCZHGZEABeglxXvdFtKSwn+J/jcp1cWBaNXE/6Sqz++UBAKGR9cfv+AXOqxkR
 mEN4oGJbDU8HjUxChhKasf4iI11TXHx5tmw+/Tch1zcekyD2kYkmHoUGUDtX2zd4Uky/UYikQkk
 /4/05KUlbHriEQSwYbJehzmYSiafxXv+VTp8lPUJTMEIYFWuKeoMRL3O4SmHd3Q8gV6H1fI081Y
 AtQnW8FjAMKT+cMm65ca9CvtS9aKnBBUJRNHWyIWuGRn9UBwKw
X-Received: by 2002:a05:6512:6416:b0:5ae:bd53:70f6 with SMTP id
 2adb3069b0e04-5b007b8c94fmr1349240e87.4.1783432874876; 
 Tue, 07 Jul 2026 07:01:14 -0700 (PDT)
Received: from home-server.lan ([31.204.104.167])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b00c763974sm218741e87.49.2026.07.07.07.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 07:01:14 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Chaoyong He <chaoyong.he@corigine.com>,
 Alejandro Lucero <alejandro.lucero@netronome.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/nfp: fix UB in BAR size shift operations
Date: Tue,  7 Jul 2026 17:01:11 +0300
Message-Id: <20260707140112.140833-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The literal '1' is a signed 32-bit int. Shifting it by bar->bitsize
is undefined behavior when bitsize >= 31, and sign-extends when
bitsize == 31 (producing a wrong upper-bound check). BAR aperture
sizes from hardware can exceed this range.

Fix by using RTE_BIT64() which produces a 64-bit unsigned value,
matching the type of the operands (uint64_t base, uint64_t offset).

Fixes: c7e9729da6b5 ("net/nfp: support CPP")
Fixes: 1fbe51cd9c3a ("net/nfp: extend usage of BAR from 8 to 24")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/net/nfp/nfpcore/nfp6000_pcie.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/nfp/nfpcore/nfp6000_pcie.c
index 83b7116097..e03c4776d0 100644
--- a/drivers/net/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/nfp/nfpcore/nfp6000_pcie.c
@@ -55,11 +55,11 @@
  */
 #define NFP_PCI_MIN_MAP_SIZE        0x080000        /* 512K */
 
-#define NFP_PCIE_P2C_FIXED_SIZE(bar)               (1 << (bar)->bitsize)
-#define NFP_PCIE_P2C_BULK_SIZE(bar)                (1 << (bar)->bitsize)
+#define NFP_PCIE_P2C_FIXED_SIZE(bar)               RTE_BIT64((bar)->bitsize)
+#define NFP_PCIE_P2C_BULK_SIZE(bar)                RTE_BIT64((bar)->bitsize)
 #define NFP_PCIE_P2C_GENERAL_TARGET_OFFSET(bar, x) ((x) << ((bar)->bitsize - 2))
 #define NFP_PCIE_P2C_GENERAL_TOKEN_OFFSET(bar, x) ((x) << ((bar)->bitsize - 4))
-#define NFP_PCIE_P2C_GENERAL_SIZE(bar)             (1 << ((bar)->bitsize - 4))
+#define NFP_PCIE_P2C_GENERAL_SIZE(bar)             RTE_BIT64(((bar)->bitsize - 4))
 
 #define NFP_PCIE_P2C_EXPBAR_OFFSET(bar_index)      ((bar_index) * 4)
 
@@ -443,7 +443,7 @@ matching_bar_exist(struct nfp_bar *bar,
 			(bar_token < 0 || bar_token == token) &&
 			bar_action == action &&
 			bar->base <= offset &&
-			(bar->base + (1 << bar->bitsize)) >= (offset + size))
+			(bar->base + RTE_BIT64(bar->bitsize)) >= (offset + size))
 		return true;
 
 	/* No match */
-- 
2.34.1

