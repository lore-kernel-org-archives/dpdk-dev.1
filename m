Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C5C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2B0440E13;
	Thu, 13 Mar 2025 00:17:29 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 48F1D40E01
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:17:28 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-224171d6826so7801235ad.3
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741821447;
 x=1742426247; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NG0mwUzmw7cwMjhGyMB/MhgT9FfBfaMB/HdVwTgE4xI=;
 b=DRGM/k9APTBMNEz43qbAOZYo/+Zqzzw15CWP5mDExC/BM3Yz12L28aF6DhG+T+YCZS
 w1BuPVN3mqF9MNqGUNNTCsbJvN0F/SqaU2MyMbdmtS3/w5ovtj8cw13ddCaQnBRcbZDJ
 dkM50E9dGvxboCiaIqhAgq7Bb3S43QWfj0ecWQUlEH26TWEg6rhEtsr++0PgGNHE4v6E
 +zWCxItPd1ZG2Qa8ucu2qeD8VzeCzT0oZmmyKYLYdLYm1586+KNamwlCKcpxpSOBNNuW
 FdZtVsFBDdnXJLRiIp+1/OOaqKyWl3y5kZ3XSGdUVLx3UfgZYmWr0kq8Ol5ruLJO6rEL
 Kg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741821447; x=1742426247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NG0mwUzmw7cwMjhGyMB/MhgT9FfBfaMB/HdVwTgE4xI=;
 b=vp6sRo+buU/I/XH+Ls7lhDUQdTU8W9q+YbNyXWhQrWCgB/DrwHgN8f6onP2cGTLQCw
 y3uYDCdopd25vWDJKRsW3DCP/koBLNCUfXIXVBMSjDM4BRhCrmCADUYUlKdldcFVkFxw
 crwCR3W20yb8da3/95jxbUtn2QA4fHuschQRFcYhUPsghLgmTLQ3XjQAogG8bKnq1/JO
 HcT99pVt6spruMZbS693LJ7RaCiS0VSXyjfIp4t9jl0TfqA0Ij5cSOWQmSSjZ5o4iBO2
 v5+t4ZPPA2yPFxlkMGSeQ6MxlX1O+V/E7IRv2ogz4TXLnfWtviQBCI7W2Y88PvOg55Uy
 acDw==
X-Gm-Message-State: AOJu0Yyj2E+76wjQjoQunixDTBR7Z7yLYeaAy3oL+RJXHkgiSYjNK1wD
 kNCc4Z++WL+n2R6EwZc5sNjQazCahQ8RvP4l23MHQiyClr0QVb7CvTtlW9W83YuiXY9K4t7sU9r
 x
X-Gm-Gg: ASbGncs/yzLk0eMxHJ1+pWaCvFTpiUO2GJ1ZHfmRcBgotfUm9Py6mWkiuhqovTCZpUt
 2EgByvbPBxnQavkPBYxZ5EvG5iclyiDN6WEy0lpOa2EgO766SCdwd/uvccqPqg6h2ZP1oQp1jw+
 1oqls+alFwh5CmSD6o2Hw6FLkH0r9gAydOJBmQzN6450UnqQ/nRbwLMMOQFFKJ6V/D3oHgaUSPm
 uc4YnM5Vepw7sPzDuMyIhP3AE7o9gjXHl7B27OEMtpwCA4LIsk74Bxznm3k8ochU8I3+zOP2CYf
 humrVTOEmgpIhpWP2jgo4SvrJoobCkszn8hxokoBITpFzX3H5oslbUh9Izj8hKqRDPZGsaFXQZm
 DhOm99v3hCPUuvfXn9rWsFaJB17h32Gw4
X-Google-Smtp-Source: AGHT+IEMPNKeIZDIbCqG3xXm65PV1+sI1Kz2HyTg0oCy8frNBMmYJ2WTZLitkgxMVKOB3qld2z4K1Q==
X-Received: by 2002:a17:903:22c8:b0:224:1dd5:4878 with SMTP id
 d9443c01a7336-2242887b34fmr292887625ad.7.1741821447467; 
 Wed, 12 Mar 2025 16:17:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f38sm1028305ad.129.2025.03.12.16.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:17:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, shahed.shaikh@cavium.com,
 stable@dpdk.org, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Shahed Shaikh <shshaikh@marvell.com>
Subject: [PATCH v3 2/9] net/qede: fix use after free
Date: Wed, 12 Mar 2025 16:15:31 -0700
Message-ID: <20250312231715.222149-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312231715.222149-1-stephen@networkplumber.org>
References: <20250127180842.97907-1-stephen@networkplumber.org>
 <20250312231715.222149-1-stephen@networkplumber.org>
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

