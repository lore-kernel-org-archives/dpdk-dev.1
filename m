Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C6C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C54642E6D;
	Thu, 13 Aug 2026 19:23:19 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mails.dpdk.org (Postfix) with ESMTP id 8C93142DC1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:17 +0200 (CEST)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848474825ffso79283b3a.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641797; x=1787246597; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pnhxIf34BeD2LPKlcRYUfYynrr87KCSKkOgsNukgFrI=;
 b=dsPOngIuNjr4DUnIawFHcV6+M5uY/EFjKrJB3NFCkm6dSFqI3TzVQV4NbAmrvIHWYv
 a0vRX05RFKWdgwbuXduDSMbp04IagSlad1UD9vevyVX3uczaWcyeaxEK3anNOpb5wkh6
 hU8KcvROycplvhz+YjWfcs6Nt/pqh8pdyASmoonACpnNViwIwtAReuuI4j4T2wp24Ojw
 01OxtA45JcXRuC+/j1cN65HfWXm66MounueCqMynYuQPXkjiTDAN8/Xc1VS/DxZ8tjOL
 cQNvDolCpTwtRQZPOSaTW3uS2g4ooDf/BnXeBHWdGb1t6TlDB1SLFoiIemAkO5H1Y6U3
 iEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641797; x=1787246597;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnhxIf34BeD2LPKlcRYUfYynrr87KCSKkOgsNukgFrI=;
 b=kt/8jvjRv8ZOKqeOo1i2e5NptQpDG/vt7ClNqSfaks6ImYuFY9/R+UaKRZ8oFcvxZd
 Pwte2Ye8tFIGIu8JPnSfKuPtxFZvXzVGDsYua3R2GFIuY5PgHazErHyiUcbu0QgdBBdl
 B+X23F9NVcOUnBIXNvyB4tmDbJaoNRL0pLvbg6nAyT7WxNWYw9IAypVXpRGbhXnY5+mZ
 v9Cz94+xy6s94wMTykeGSCdzn67Ez//t0ZJvrxu/M8pseLvBzb2wbW2n1U/2SI4Cr4P4
 30k66pHzFsz9BlV5t1Bkxa4mGmt9Ydz5XNEc8uR8F1iOOMUri8fISrlROzkUAkc/n8TK
 3Vrw==
X-Gm-Message-State: AOJu0Ywzap1J3c0DNwnrIDGi1z7yg2kFz73XnLi0O/FdCo8AKvaB5urA
 hpHe9dtwgj0OQLF8w/qBypnGxFhqVRY5l1g8hxqr8JqN7W9qRD5XRaEsQuRflbMtUZmqC+28cME
 IM8sceAWPFyG8mQ==
X-Received: from pfij2.prod.google.com ([2002:aa7:8002:0:b0:848:56a2:f6a9])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1254:b0:84a:2b96:5986 with SMTP id
 d2e1a72fcca58-84fc7b46bc8mr7239652b3a.8.1786641796558; 
 Thu, 13 Aug 2026 10:23:16 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:39 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-15-joshwash@google.com>
Subject: [PATCH v2 14/14] app/procinfo: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Reshma Pattan <reshma.pattan@intel.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 app/proc-info/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 5925bbb765..9c22fb8f01 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -48,7 +48,6 @@
 
 #define ETHDEV_FWVERS_LEN 32
 #define RTE_RETA_CONF_GROUP_NUM 32
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #define EEPROM_DUMP_CHUNKSIZE 1024
 
 #define STATS_BDR_FMT "========================================"
@@ -1830,7 +1829,7 @@ show_port_rss_reta_info(void)
 			return;
 		}
 
-		num = DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
+		num = RTE_DIV_ROUND_UP(dev_info.reta_size, RTE_ETH_RETA_GROUP_SIZE);
 		memset(reta_conf, 0, sizeof(reta_conf));
 		for (i = 0; i < num; i++)
 			reta_conf[i].mask = ~0ULL;
-- 
2.55.0.691.gc56d675ccc-goog

