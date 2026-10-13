Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EB4CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D8F04069F;
	Wed, 14 Oct 2026 00:35:02 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 216784060B
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:34:59 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e60f9af6e6so2721285ad.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930898;
 x=1792535698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZuuS5IIWpatk8c/vXxFju+eG9cw0viWkqLpuCE8mPW0=;
 b=QiAGFOdJ43GSAOKk0AiX0lBlg6sbWl/iC1FhP81bv5ZOD7FZoQmaE0+bOesobMC3BR
 W0iSMgYUbujo4YTZ2GR5FPxAbn/lYuUzMWOZlysHT9fAaYOj3Dl3PhTr3cqxze+efHCh
 88nyAj/ecZBbMAmrPw+FTYRXS4UYK9xb8072AhsEWH8U0+fw2UverGZrlqaXWiNrcUU5
 fZOYkZEKVC4Y/TtPS7RA/Eybmthk9V5K4pWivjjircmLGtqnE7hWilKxvErTrY6BTqK8
 Q0ZzYqQXvJwaCUNA+G76SZsZTfqzBHbJgMcsDq7GqqguWjdWqIDSX5LD9pZTvsycuo4v
 pkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930898; x=1792535698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZuuS5IIWpatk8c/vXxFju+eG9cw0viWkqLpuCE8mPW0=;
 b=jiLZbWW5Iez8CjiFKIYleZTQ7CGYm+3+LDgh9azF4PShxUYntsy1dsf11JRG2t9FuV
 /ghd7zA4BRZLbUiI2cjJJbbTllUYMWqfnUsDZ50SN0MCJTBVmquelpoxAxDg0cGugafz
 q/3BElxn3GzD3wpYEzNu/XXbeGtjqTKLOTHFnLaJDp0hz5e8VVn+sfXkWdd9TwP0giDz
 I0FL23KTPYc1jr3uVdi+1SLCGv4eUlBr9hGhOyXAl2Gqn75t+XBH6fK/tHZZN7lJrH25
 2pCxZzvl6yKR6rpGsP66XESwkufPja0r27aTYorIpZy48gjzSKGHc7w9/iCwc2lasTuZ
 fVKw==
X-Gm-Message-State: AFq9FYLRIzqvf9bYFz387z0kWoB2aE5tTz/cJMaYnp4GfHyXY3r3JJFL
 fpX/+swc1TxINbXUGkU2MVL8fEaxRbtnuPHKe0wh+mtFAGRPu9vlPZ4U1qzUOUN8aEM1i5wQc1i
 MP6awjDM=
X-Gm-Gg: AYBFou13CvRkKANu08EKPk40T9iwiny5KPhNm2PgRQU9Wp8OTrOwb9usGkCRZFL7k0r
 UuiIHt1yWG2q+w+sN/B39lA7ZWorsZ8t0ftmzIOcJv01rN8ky2efLxIRCkW3I/MOcpzPFx8RxrI
 RugzApDY5Ty6+1XAFTvj6KW/eT49vMVIkeZHzxMmvQ9HOq6HyPfF2YrixqdAJVeeznv2DN7CSpN
 +FD7l1dWzMamrADWJi6DYfIMn23z/v6PxMkQ1NDLvHRCUB2BNnfn4Ujs8K64OZLBWSUz6ewNvx1
 loUngGAT8MwePlkkRWmfKqIL5KQ0jFIN1yQjgo8zMeI3qpT3OBQhNbz6LZ97R43LLagRvJP4Ksz
 LYWkMM8knSlzNuR0qlLauthCaSv3/ZZyJgh2heoEIMqU6vLvcnmnKGsQdRHiRLDmb75FfQrXgXj
 ZanEnsbJMxWeq//JZ8FhSAH3AHYYFy7KHXr9ATFu0no1VLAxDRmUnBqPICxzbouR2eGICODF6ks
 UNC+AhIFdAZmtTa1jTHQ7xAKXH0e4vE/gwbxKI=
X-Received: by 2002:a17:902:e548:b0:2e5:54c6:e5a2 with SMTP id
 d9443c01a7336-2e842820581mr138587275ad.6.1791930898282; 
 Tue, 13 Oct 2026 15:34:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:34:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 04/29] bus/vmbus: fix missing acquire on receive ring index
Date: Tue, 13 Oct 2026 15:22:17 -0700
Message-ID: <20261013222410.2257622-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

