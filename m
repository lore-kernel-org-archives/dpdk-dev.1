Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950ADF9D0D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 14:43:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13C134065E;
	Tue, 14 Apr 2026 16:42:57 +0200 (CEST)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 1800740653
 for <dev@dpdk.org>; Tue, 14 Apr 2026 16:42:55 +0200 (CEST)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2d17b8fbedaso2291366eec.1
 for <dev@dpdk.org>; Tue, 14 Apr 2026 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776177774;
 x=1776782574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJ1qdAYB4+rqfLrDWp8NPkDvpEdi6D7pd0WAGnH4Yag=;
 b=oTspq3ZcH8IGhR+4ChQxVCVy3+jriVv2jcqru4kAHwt38Rjx13CzBajD5Q4sE21uRr
 LR8cJLHjDzvcaNGAyZJnkF4Flon2dxUNL0xhUCzZjI0X7NYji0ME83UMCURz2rKi2W97
 ZpMUyCA2ywaDGiZpAvtsnURCwt4Y7n7ORzJ7t2pSLpYuYBQt+fBnj+QFslUiEeUn2EcV
 /DTvEHk+zl94YGTsF84KB3+yGn6fhgDQzBjRrIgolFkVzQM5sgc2Fznhuq2BbwHI2d+2
 Yi9aO8jDwC3JJSq3QNSsr+OhegwZ/PA0+YawwiEHjOM423IRlThdI2YkX63/OAKNwYGa
 EaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776177774; x=1776782574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJ1qdAYB4+rqfLrDWp8NPkDvpEdi6D7pd0WAGnH4Yag=;
 b=hNgZZfFCa94ZvTxAVrf1sD3+C1l5upqtKGhU4fP3NYDsCZsz0PbOCXDEmSQYJAAMs9
 roX3Dk75hFiXzzJG00beizaoBKayNO2ELWhyMy8rHN93gS9u5wUh50mUou4HBnfIVYdg
 I+d2F5dbBU18Yt/xoXEgrxkil6427wTo2+rL/NCX7NXa8qz3HjDr1nCsBs+fotgvuIA0
 x+66GQkkyaFAw9OQEy7lC9iackcRzgB7svv7g9TPUemM1NzGlOO7KVGWdLoMQ+UXSgN1
 aa6sEgls4/i9Iy1JKJOayKhpEqxflTlyMq3voyT4AMETYgHf84ICWDXrtXNA6moYytMx
 GR4Q==
X-Gm-Message-State: AOJu0YyCa34iw+jhQQO6Tz7f6yIjspyEGl0uK2iYiXqyn+Bx8buHE7a5
 6chTuj6LAyKWTbTHcjvr9xcirwdXCT0Ceq5GUCc8RUVnzbcP2kqNF2gybd0ZAIAfEQNIzkm+MIr
 fyCXz
X-Gm-Gg: AeBDieuwKwp7TWgULhFaasXUqYu/VUn7GdRfnlsS1TnLvhix3s5L3zi7Ar+OPm39D8c
 HjsUH4AtCq+DIXuQMv/M2GsKVuHotxqnzxo16D/scrv81DjAG11dvN1uCgSfhMzxhutHNJJCN9E
 eNQk3vdfhih3JUp91VHb2/50umc+uc5uiEsyOpJxfmReyDgE6nlJ7WerQDNFLHdfe1wvyKug7zk
 EaSoX9SAJqFuZyasapblQ8bBApQvnHJ9nzmeHAFELE1JNOtkaPlA7sUhHWlug/x6CdurA89tVqQ
 rP+HGkoGPzSoE+CM+BSEFEwE09FPpcq0mMJHdDHKH9aPrBAva6ll4JC9ygqvRTpq7cZM0WsluDz
 g6cwzNHlaBQ1J3nCHDwiLEe17WR1iZVH41Hlc9kjwbu4n2taqkpbrvIp+ts70qzexNIDzC9QIGU
 trUUFrux6t3keEhuCk6AcUjnhCOoNJ1QosZ0Thok3pZIw=
X-Received: by 2002:a05:7300:4316:b0:2c1:82c2:bc31 with SMTP id
 5a478bee46e88-2d40fce76c1mr11155273eec.10.1776177774049; 
 Tue, 14 Apr 2026 07:42:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm24985835eec.3.2026.04.14.07.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:42:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v2 4/6] net/axgbe: fix mutexes for multi-process
Date: Tue, 14 Apr 2026 07:39:56 -0700
Message-ID: <20260414144246.110681-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414144246.110681-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260414144246.110681-1-stephen@networkplumber.org>
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
index cfcd880961..4aadf0993e 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -194,6 +194,17 @@ static const struct axgbe_xstats axgbe_xstats_strings[] = {
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
@@ -2419,10 +2430,10 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 
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
2.53.0

