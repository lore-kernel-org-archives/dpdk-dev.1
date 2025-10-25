Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A84CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 09:42:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98E3B402A1;
	Sat, 25 Oct 2025 11:42:54 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 1C323402A1
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:42:52 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Iuu8rMDjoaH9oj05s9Er3NjAFDQAoolvhAz7sJzXlms=;
 b=EJWdf3raBwmUTRjP3fwU+HB2KP40QhoCOo94z4g1LdioyLDRFJW6ykBpZFf+dl9WLyv0bX4K4
 rYF8YswXP8K757WqjDJM3s5LwthX16/jhnnDR/3MgS0VgWTlbfJSjJyPJcRoggAPE8DDjY+W0U5
 vw4hp4vEhRq3aohHXhAkLFI=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ctvtl5HmjznTW3;
 Sat, 25 Oct 2025 17:42:07 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 30FAF1402CC;
 Sat, 25 Oct 2025 17:42:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 17:42:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH 1/2] ethdev: support telemetry RSS algorithm
Date: Sat, 25 Oct 2025 17:42:38 +0800
Message-ID: <20251025094239.4915-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251025094239.4915-1-fengchengwen@huawei.com>
References: <20251025094239.4915-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

This commit adds dump RSS algorithm when doing telemetry.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ethdev/rte_ethdev_telemetry.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index 519ad34be7..020e3979b0 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -726,6 +726,10 @@ eth_dev_add_rss_info(struct rte_eth_rss_conf *rss_conf, struct rte_tel_data *d)
 		strlcat(rss_key, key, key_len);
 	}
 	ret = rte_tel_data_add_dict_string(d, "rss_key", rss_key);
+	if (ret < 0)
+		goto free_rss_key;
+	ret = rte_tel_data_add_dict_string(d, "algorithm",
+			rte_eth_dev_rss_algo_name(rss_conf->algorithm));
 
 free_rss_key:
 	free(rss_key);
-- 
2.17.1

