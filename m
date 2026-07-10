Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C39C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 13:47:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57A0E4060F;
	Fri, 10 Jul 2026 15:47:00 +0200 (CEST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 0C7894069F
 for <dev@dpdk.org>; Fri, 10 Jul 2026 15:46:59 +0200 (CEST)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so7061755e9.2
 for <dev@dpdk.org>; Fri, 10 Jul 2026 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783691219; x=1784296019; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wse77dCKc6MQC39EHwl0BXZH79Ei9Ih+z0y+LrpNUXM=;
 b=fO6j0b7RvDF/Umle/HhKff9RbiCFbyideW+MMtqzdT2YwFFBAn3n3sXAOms778Uje7
 peNvSlSFHuSVCMKI9cVPMCBxHy72JmaHAvtXXu0bVKHlTv4JrPgPqyhzGo4mu9sfPfUA
 iQNWrdxkb1SaBBBprhmLO1Y1HwfcJdwE/tI89eIuTIh2JRbFy3hwSwmEdcz6YaBCeY6J
 /uTDn9N6hVTzguGmjb3qSoRfDYx7ubkg3Pqs02nCTuPjsgPTCn6X+1eP6AWYnJ4cLNfq
 5ef5UyZwc3ZYS4LEzlJWlQj/XeaIwrkGnTiURHk3TY1VH6AMBTECMZD+FqLtSwUVqBFb
 2s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691219; x=1784296019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wse77dCKc6MQC39EHwl0BXZH79Ei9Ih+z0y+LrpNUXM=;
 b=QGpTT7SRqu6r3KTwu61iQWVOpS9xSjaCYRrXUmNbTaeHCl00IbCTAuITGNWdSDanx1
 an0W0qsiaZUwO95QnAiOBM4C9Qb+2IOveDyNK61j8+eiCLMPUwWI6V2HX5ckdC5xy0fe
 Mmyg19RjM7nV0iuR1o3bDsTY8C0Jz3ZO7mYqaogyyDp+BObmdq+7LrU9Z6R+kiv1OE9H
 pIuZeWGGgwtjq45Wjb+NMLEE3fOg5yYfW8XIGgi/wsnPukBZZp/+xTvZybowVtSHHjmQ
 dwL4nbY7zTqwHV/8aydK7s/Fs5KJ9M6pUJ/flBkmjXhRXrZPzNjd+wpnEgtbOvogCxhC
 d4ng==
X-Gm-Message-State: AOJu0Yx4d9Xzuyg4SrXaQ4cF7ZUD56w+RLs47ONdEJX8LNFyuh3tpkT5
 k8Ime4FGvJfpeC2JQDARsDqEabe+i+pPGeUFB+jCe6fQU/TdPdDItMGdOL9LaevE
X-Gm-Gg: AfdE7ckfLyX59rFvqAS+T0CBCLGw76js1SDY6h0DcTgkKo8WGniokb+RivMWZiWJj1/
 Ngu0h71H/veJDKaKBuhPdGyQU0ix05t8LfCwe5mHbmGTStmKx39WHtvHlDEVUHf1LNbgVPJ5nl/
 ITCDbgpUD+ariQl7KOOyc7lkgmjTftjkJ5g6kSMXQShEe380YhBbgqLkV8iWCUx3YZxaOpw4Q8d
 6sG8BJyY60HtcdQ2jSSwfBsrlh2xaP5G0OO0s14WAtMnmRt8sIxSUqnjPxT7CLqnZ9g7RpBXQSW
 pkj19nf9NeF1BQOwQsjztZNF8+HHhAKiuz97GECV4MHPvtIrmFdpdWbtIPm+u4J+FT7aFFz/qNw
 NzPCnQTl2ExfMhN02Fc4o++KzpNPWFHHkdfv3OTf+TsY5aHZTjpLFJ/ZKWN4DBF3CdolVVfpU80
 0I+7SzMyKByxr83EPomsh8wo0gj8jtAnvFCCaHEgcU1FBQeVL1soS1y0A9m4wCfEbo49we37u7l
 an9Sthhn7+H+G2XlGckBA8bUEzpjhlSMcgv0Q==
X-Received: by 2002:a05:600d:8444:20b0:492:66fb:5dc5 with SMTP id
 5b1f17b1804b1-493e68df9c2mr87081625e9.24.1783691218475; 
 Fri, 10 Jul 2026 06:46:58 -0700 (PDT)
Received: from ll-cherrati.online.lan (gw-online.ijclab.in2p3.fr.
 [134.158.76.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74835esm154557295e9.14.2026.07.10.06.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:46:57 -0700 (PDT)
From: SidAli CHERRATI <scherrati1@gmail.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 SidAli CHERRATI <scherrati1@gmail.com>, stable@dpdk.org
Subject: [PATCH 2/2] net/ixgbe: fix return value of close operation
Date: Fri, 10 Jul 2026 15:46:39 +0200
Message-Id: <20260710134639.108129-2-scherrati1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710134639.108129-1-scherrati1@gmail.com>
References: <20260710134639.108129-1-scherrati1@gmail.com>
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

rte_intr_callback_unregister() returns the number of unregistered
callbacks on success. Since the close operation started returning
the ret variable instead of 0, this positive value leaks as the
return value of ixgbe_dev_close(), so applications checking
rte_eth_dev_close() != 0 treat a successful close as a failure.

Fixes: 62024eb82756 ("ethdev: change stop operation callback to return int")
Cc: stable@dpdk.org
Signed-off-by: SidAli CHERRATI <scherrati1@gmail.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index c5010f623c..6b1799d7a0 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3121,6 +3121,7 @@ ixgbe_dev_close(struct rte_eth_dev *dev)
 		ret = rte_intr_callback_unregister(intr_handle,
 				ixgbe_dev_interrupt_handler, dev);
 		if (ret >= 0 || ret == -ENOENT) {
+			ret = 0;
 			break;
 		} else if (ret != -EAGAIN) {
 			PMD_INIT_LOG(ERR,
-- 
2.34.1

