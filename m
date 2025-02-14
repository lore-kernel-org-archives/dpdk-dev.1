Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF1C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 17:22:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3530640696;
	Fri, 14 Feb 2025 18:21:50 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id E9F5140678
 for <dev@dpdk.org>; Fri, 14 Feb 2025 18:21:47 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-220c8f38febso43755165ad.2
 for <dev@dpdk.org>; Fri, 14 Feb 2025 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739553707;
 x=1740158507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NG0mwUzmw7cwMjhGyMB/MhgT9FfBfaMB/HdVwTgE4xI=;
 b=aKIMFS4/eSFuyvzKjIDOH5JYna2f1QL2QqvtKjrfg3pSeJ+EEGS8/UhCmAi6AnQIYW
 AQciqJWU6cN50chgdZ6QQyxgc3vMNEq64XMh+6adYUIQgpolGb6IhICXa4hqfKprZdZR
 AbswQl8isEnxUVW2wrlvcw2NNyuX07gCkksYE86quSPFQrFU+kC1UJH8d+SRMSf/jYZ+
 Gf2bn9FEgpOp5UdVdMi4mDS9+wG/HEO7oJjOKCFDj5rXvO7WC6hTaqgxNoBR9DKr3B0y
 yzFoy3E2yUeaOdwYmKpy0E1nMKrgqIvgPn5guWBy7FqDLRKmufm+MsJgxAyKZAZKAHXZ
 X3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739553707; x=1740158507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NG0mwUzmw7cwMjhGyMB/MhgT9FfBfaMB/HdVwTgE4xI=;
 b=CIiahb/LUzTp6ZVyBG9A4CDUdsMMN06NOGz9xVXUOEQXwQa1y5p82NevaDejNwawDx
 xiT/pCp2cXQj4dl1jOdJufDfTPtu46ufBBCPn+3I1uODAl+09yT7Fj1snXrncEh9fRVw
 CrJ+YOiOyVpFfviOf1xEAxAICeUXS3TgI5+OxTapk/prCqMtglubdS+O7BUkLvU3bsW0
 iHmNE7wCHtpxNaCq7wO3tK8oSYiMBA4DGqhKha/+hElh9BsNWehIztE+4zsY+p5On/Rt
 66m9wCfY7DmP+bC+N/H2p3eTSYnF8Pk4nAVP7kVsMr/LomQ9YBbdh1TtCiWh4ZKg8rjO
 wU3g==
X-Gm-Message-State: AOJu0YzroOWorn4xSNOvu0XVr1fiCrKlhooO889rsx/SWbULZZC6fecm
 FK+QS7g+m4wRvsHHCjQdrgvX0qhSLzwgJkic+QzpWi++UQ2ILNAUfP5QC+4r1NWEG8XiLoOfYhB
 AQUk=
X-Gm-Gg: ASbGncsQUF7Yoe4m3Xq/xssf72y/Cy9eM75eZgN5UHJ/kAdPiDiknGG2VqpcgYO3ykV
 frVzsPjYcUCWvotl1Dj0whHVUqy9C2R/zIbIfsPQ7OZe3+Thndl8yJv1i+clANumugcLzXMW2mX
 nqp/J8EEGkCLFvARH2EQ7ztw3sNiulvpziLMepNse31osB2yvvDTkTog1GUK15Ovtqyzb+jwH4/
 IFzoUR34kp4KrspuAc8Yh8QpaKV6eBGyklMWRsgAtGgzyZdUVUWzAijoc8PE+jt96C8TjlwPtZR
 pQSAnOXxN6fDFwJltpGCiJKiexoAlLAh/+7Avjn4o+N0BL61zhcXKhmb0NFjKUWwDnl6
X-Google-Smtp-Source: AGHT+IG7TAKwJjO5hSw7D9Dk91pKSFON1S5mz6xVuRBnuqk8ju7k6retA3w2Y7ig0bRJOayf+gbk0Q==
X-Received: by 2002:a05:6a21:999e:b0:1e1:a094:f20e with SMTP id
 adf61e73a8af0-1ee8cb4f08emr475862637.17.1739553707179; 
 Fri, 14 Feb 2025 09:21:47 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb5a52af8bsm3134264a12.50.2025.02.14.09.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 09:21:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shahed.shaikh@cavium.com,
 stable@dpdk.org, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Shahed Shaikh <shshaikh@marvell.com>
Subject: [PATCH v2 2/7] net/qede: fix use after free
Date: Fri, 14 Feb 2025 09:20:10 -0800
Message-ID: <20250214172134.73908-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250214172134.73908-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250214172134.73908-1-stephen@networkplumber.org>
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

The loop cleaning up flowdir resources was using SLIST_FOREACH
but the inner loop would call rte_free. Found by building with
address sanitizer undefined check.

Also remove needless initialization, and null check.

Fixes: f5765f66f9bb ("net/qede: refactor flow director into generic aRFS")
Cc: shahed.shaikh@cavium.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/qede/qede_ethdev.h |  3 +--
 drivers/net/qede/qede_filter.c | 13 +++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/qede/qede_ethdev.h b/drivers/net/qede/qede_ethdev.h
index 3015c18504..b502658425 100644
--- a/drivers/net/qede/qede_ethdev.h
+++ b/drivers/net/qede/qede_ethdev.h
@@ -8,8 +8,7 @@
 #ifndef _QEDE_ETHDEV_H_
 #define _QEDE_ETHDEV_H_
 
-#include <sys/queue.h>
-
+#include <rte_queue.h>
 #include <rte_ether.h>
 #include <ethdev_driver.h>
 #include <ethdev_pci.h>
diff --git a/drivers/net/qede/qede_filter.c b/drivers/net/qede/qede_filter.c
index 14fb4338e9..c3f74c89d9 100644
--- a/drivers/net/qede/qede_filter.c
+++ b/drivers/net/qede/qede_filter.c
@@ -154,15 +154,12 @@ int qede_check_fdir_support(struct rte_eth_dev *eth_dev)
 void qede_fdir_dealloc_resc(struct rte_eth_dev *eth_dev)
 {
 	struct qede_dev *qdev = QEDE_INIT_QDEV(eth_dev);
-	struct qede_arfs_entry *tmp = NULL;
+	struct qede_arfs_entry *tmp, *tmp2;
 
-	SLIST_FOREACH(tmp, &qdev->arfs_info.arfs_list_head, list) {
-		if (tmp) {
-			rte_memzone_free(tmp->mz);
-			SLIST_REMOVE(&qdev->arfs_info.arfs_list_head, tmp,
-				     qede_arfs_entry, list);
-			rte_free(tmp);
-		}
+	SLIST_FOREACH_SAFE(tmp, &qdev->arfs_info.arfs_list_head, list, tmp2) {
+		rte_memzone_free(tmp->mz);
+		SLIST_REMOVE(&qdev->arfs_info.arfs_list_head, tmp, qede_arfs_entry, list);
+		rte_free(tmp);
 	}
 }
 
-- 
2.47.2

