Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8359CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36EF540615;
	Fri,  9 Oct 2026 01:37:00 +0200 (CEST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id C5B30402E1
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:36:56 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-88bda150550so2159728b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502616;
 x=1792107416; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuuS5IIWpatk8c/vXxFju+eG9cw0viWkqLpuCE8mPW0=;
 b=WBUAwOh4KsGBIfAVOCcNCONHVLUwIWHJQCIbmreqSbxYhoXlbbywsDapZk+5unrF7o
 1l0xm4pAaSVZzPpBz8NggYHKCSB7iP7SgP6123EgbyC8dPYTf8mWftIqvR4rCnM3IQw6
 gIGi6HihxPBIHTN3rWoPP0gPGfUCHF2rBZIcYIshSHNTKfuO4ZYsPmqbzomgxtU4KI4Z
 70unAOjjE4SmDnvTgxZEpp9+8NWEs8lTlI1weJPQtanuv3ZEZ5umWSwXgtkP1M17LSiz
 cBeb/kPMHZFi1HUpEqDs9PcjIfgBJO2oFYzGNJEqtZDpoO5mlvrE4Hfab9uHY5+ZjUnH
 g+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502616; x=1792107416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZuuS5IIWpatk8c/vXxFju+eG9cw0viWkqLpuCE8mPW0=;
 b=pOjCGpw7qOlVLIJq/vjEICEVF6dt5RwLQ2Yj8Wbt9weaLWoQLvzzFUL8hrioBmpUl9
 rBoDd1ZyIudUaqMlmBLUkKVu5SiSuTzOUa9IegiyDY+g9xqLlt8Ky9TQQqI/KqF7b0yq
 miIfnNxaQchhXn3+ju0KSJBNfkCEPp/muu8BDVP6jfjfYWGnr0rnM4FxL46PN7dDgc/N
 zr4Pb2PS1rPP4fMFj2PeB1qxofzlGeULPm78RABtmxEyDhl6vb5pHKpCdX8soanU8sQt
 kjnDZOq6ZnUzCu/3yFOkwa0v4qSZ/auyc+yZpYK19FDu/lsZqZLJtWvJykqBFxB0X614
 5M6g==
X-Gm-Message-State: AFq9FYKB8cYggSlTo6uExuyUx0ZKAm3SOiIdHZXx4ayx9xBZTER2eNXR
 6CNO2Icnq330d5O55934lMw3aVVIT6ljNA0BRMJ6sXUGNXViT5gVKdNKUl+Uj+wqTV3NfiNGA3C
 mLZA/FoM=
X-Gm-Gg: AYBFou2eNvSyVMM+n+AKIVrES5x4DeUsdgnq4BADQ0A/+S1QV47NYBcWApxXMsOTvg1
 y5iSXUfXGqWiMifTYrIPokuc6JgkQiot4NnxUOWmNd8YiDjDKUN9k9semmi/P91JCrAIdytckS4
 smJcgwd9hegcRxttzVyv3ZhRyrdipF8E2liAtTZUPeG39OeQjgnjK1aiBVdhkSKwIHlkm4Lkl3y
 85/cXFZ1t3ElgAjTJo1VHiX56rvywqvHBqcgYRnukE/ocqAHVQaHbFq1/L1WSIQmLDk/wm5CdA2
 3bV/HuYr8tlNT7XP/SD39W+LNstYTCb3IuaAztZyQjRXLrFuXzClijIi7ujc52Xj/g6hi3Xtu9B
 naRxfQbls6girPe0gl8UB/EaMbyrWAA53jmWXJpPWu5+0I67ghM4tOB60AdctAy5MExZsshEBJs
 jX9V2Aty7j2wQMiO8wqQORu4h3rpMAbuEiR5QZluxxPC+WsignGVpYJ9UCU8Z785UpXfsuTP4vK
 p+LJ2q/TQ2XKYCrGCoLEo4TMIiGavE1aapoag==
X-Received: by 2002:a05:6a00:349b:b0:87d:d6d1:b72b with SMTP id
 d2e1a72fcca58-897c653b2eemr62440b3a.11.1791502615911; 
 Thu, 08 Oct 2026 16:36:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:36:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 04/29] bus/vmbus: fix missing acquire on receive ring index
Date: Thu,  8 Oct 2026 16:34:57 -0700
Message-ID: <20261008233649.1260843-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

The receive path checks available data by reading the write index and
then copies ring data. The link between the two is only the comparison,
a control dependency, which does not order load against load on a
weakly ordered architecture: packet data can be read before the host
has finished writing it. Load the write index with acquire, pairing
with the host's release store. This is the equivalent of virt_rmb()
in the Linux hv_pkt_iter code.

On x86 no barrier instruction is added and every affected function
keeps its size; on arm64 the load becomes ldar.

Fixes: 831dba47bd36 ("bus/vmbus: add Hyper-V virtual bus support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Wei Hu <weh@microsoft.com>
---
 drivers/bus/vmbus/private.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 6b7782724f..33545b6614 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -12,6 +12,7 @@
 #include <bus_driver.h>
 #include <bus_vmbus_driver.h>
 #include <rte_log.h>
+#include <rte_stdatomic.h>
 #include <rte_eal_paging.h>
 #include <rte_vmbus_reg.h>
 
@@ -130,7 +131,16 @@ vmbus_br_availwrite(const struct vmbus_br *br, uint32_t windex)
 static inline uint32_t
 vmbus_br_availread(const struct vmbus_br *br)
 {
-	return br->dsize - vmbus_br_availwrite(br, br->vbr->windex);
+	uint32_t windex;
+
+	/* Pairs with the host's release store of the write index;
+	 * ring data must not be read before the index.
+	 */
+	windex = rte_atomic_load_explicit(
+		(volatile uint32_t __rte_atomic *)&br->vbr->windex,
+		rte_memory_order_acquire);
+
+	return br->dsize - vmbus_br_availwrite(br, windex);
 }
 
 int vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
-- 
2.53.0

