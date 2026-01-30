Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB6D73EB7
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 05:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17C3440608;
	Fri, 30 Jan 2026 06:21:59 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id C7FCF40655
 for <dev@dpdk.org>; Fri, 30 Jan 2026 06:21:57 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so1510901f8f.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 21:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769750517;
 x=1770355317; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STlSnTY7dYbliiUwXgCDekUaMtWe6XB1Q9Xlw+83T1Q=;
 b=KdsxTuYUjRhxdot+JNLHH/VrNmOfrypUT95UUYFoW4STW6nUGZ/ig5x4+p/kEUbHgy
 D/saNst63THAkulJ7j3+FqScx9Ddb8EciXYPbPf7SHM7SgnHETQHSxq5odIlPwkZUi+m
 kUnPtpbSYQd43atszsjjHz6N7GUHqK5vX/C64x+HK8BZpBpOCg+12Kn4oMBGqPUCuV3I
 TUQ9+W7k1Kgsk2IQ0dRpmDgbigNHwJS1aGqbKaQlkmFwEItnKlELQWu6DtYP1uqIrrO/
 Y7JFxnTLBYqXS9GcjHOeNcdKe5DxM4VVNYD/PHrGWnaFsB4gJ+XnqCB+NSwCza1e0vdy
 eaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769750517; x=1770355317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=STlSnTY7dYbliiUwXgCDekUaMtWe6XB1Q9Xlw+83T1Q=;
 b=oBFpTr9ja4CscDn+XUGA2PWVvWDepKk59870tkCXOvE5uH1ZSPHEi6ue0bkaz4MQK3
 Q9QnZnE1dU08elcL8pOgdIK+j0AxRbQWRV24OtBFS9BFHsPOBdZ8U+S33fw4eYd7MxTQ
 yr/PiDOM9WwCojJ/+zpMjAUt4aQLNJ+miosL4oRcciYXBJgnYWpU7zyi9N3Q7+Fizkrq
 W1IgWL1ZzthNfH5Ji9c5AA6ugm9wTI97saU1rSsIs3tFXacMQKBznaZ/lKPxGVa4mnXS
 1djjmZbQImJPaSufBPLRDCiIfX3cGvnwvBgKXWZ9WwITbIM7obq3q73UvzpGhuV1/jh8
 lwCg==
X-Gm-Message-State: AOJu0YyqRa+PisJCTX2OlcCgIzWKf+CpjciZC8B8TDJee9LUMLgVmwoJ
 xD+WM2YnazCUQzcmIA41bNz/7oPOJ0gIce6caae9+LUOuzZyVYtzKtDZeyHEia3hI0YDizYsfA3
 6EaqN
X-Gm-Gg: AZuq6aLs5eulF/a6tNTVI9l7VhPZKKmYVPNeuASn0C0UI+hdz4v8PGWREvZL1jpREaU
 0zMU5ihwXahcx+yc0XLXb3+K/zw9jUvCYI/gOActUHcXmp20Y9+nphomOGwPjaZNvZhC0751g3h
 9Fohv3MgMj4aUtV5FCThZOof0Tqhpsq9IzkLmPdlR8M8VUTRUOAg2+EZET5QVAWPWK7X25TWZHk
 IAwUjP1MsPakVCYBRiEGvaiNMs3FfG63yTNkdypXEmvqMdOgwnXTjkYumanYLFUZKLY9jybyTk5
 BMD2TnBoJqI0QuJ0sV3futxZjpb+GcHWdRMTaqdtiHNPmnNrsnIVcarbyNST41Itd8rkoV3uR18
 vxzWFsrdDWRtzidSUUQF7zzXBm/23Y+iDCLKtB7dafH/ZGAWg2cCOv1ZBdFgS9+0fjzOxba1w+8
 9NmS+kILr3gMHG0yBbF3tvnJ43t5impmiDVSM1ixdh+JURamH88w==
X-Received: by 2002:a05:6000:420b:b0:431:104:6daf with SMTP id
 ffacd0b85a97d-435f3abc900mr2583857f8f.54.1769750517342; 
 Thu, 29 Jan 2026 21:21:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1323034sm19182107f8f.35.2026.01.29.21.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 21:21:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [RFC 4/6] net/axgbe: fix mutexes for multi-process
Date: Thu, 29 Jan 2026 21:17:35 -0800
Message-ID: <20260130052142.251649-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130052142.251649-1-stephen@networkplumber.org>
References: <20260130052142.251649-1-stephen@networkplumber.org>
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

The AXGBE driver supports secondary processes, as shown by the
explicit check in eth_axgbe_dev_init(). The xpcs_mutex, i2c_mutex,
an_mutex, and phy_mutex in axgbe_port are located in dev_private
which is in shared memory accessible by both primary and secondary
processes.

However, the mutexes are initialized without PTHREAD_PROCESS_SHARED
attribute, which means synchronization between processes is
undefined behavior.

POSIX mutexes are by default private to the process creating them.
When a mutex protects data structures in shared memory that are
accessed by multiple processes, pthread_mutexattr_setpshared() must
be called with PTHREAD_PROCESS_SHARED.

Bugzilla ID: 662
Fixes: 572890ef6625 ("net/axgbe: add structs for MAC init and reset")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/axgbe/axgbe_ethdev.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index cf3b0d9ef5..0fedac72ab 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -193,6 +193,17 @@ static const struct axgbe_xstats axgbe_xstats_strings[] = {
 #define AMD_PCI_AXGBE_DEVICE_V2A 0x1458
 #define AMD_PCI_AXGBE_DEVICE_V2B 0x1459
 
+static void
+axgbe_init_mutex(pthread_mutex_t *mutex)
+{
+	pthread_mutexattr_t attr;
+
+	pthread_mutexattr_init(&attr);
+	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(mutex, &attr);
+	pthread_mutexattr_destroy(&attr);
+}
+
 static const struct rte_pci_id pci_id_axgbe_map[] = {
 	{RTE_PCI_DEVICE(AMD_PCI_VENDOR_ID, AMD_PCI_AXGBE_DEVICE_V2A)},
 	{RTE_PCI_DEVICE(AMD_PCI_VENDOR_ID, AMD_PCI_AXGBE_DEVICE_V2B)},
@@ -2403,10 +2414,10 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 
 	pdata->tx_desc_count = AXGBE_MAX_RING_DESC;
 	pdata->rx_desc_count = AXGBE_MAX_RING_DESC;
-	pthread_mutex_init(&pdata->xpcs_mutex, NULL);
-	pthread_mutex_init(&pdata->i2c_mutex, NULL);
-	pthread_mutex_init(&pdata->an_mutex, NULL);
-	pthread_mutex_init(&pdata->phy_mutex, NULL);
+	axgbe_init_mutex(&pdata->xpcs_mutex);
+	axgbe_init_mutex(&pdata->i2c_mutex);
+	axgbe_init_mutex(&pdata->an_mutex);
+	axgbe_init_mutex(&pdata->phy_mutex);
 
 	ret = pdata->phy_if.phy_init(pdata);
 	if (ret) {
-- 
2.51.0

