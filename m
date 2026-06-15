Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059BCD98D6
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:34:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 739EF436D0;
	Mon, 15 Jun 2026 09:33:42 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 513B4436E0
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:33:40 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=poO3ReN6MaJnvqtZTEqnV6a2kTlvnSvoCedYQ4ruN6s=;
 b=AgLTd95O8gHpQ04E+YOkgJI0Kr4m+Ezb3jqfyEDO73UQBpGVV2MIcdBqYwY0ME9sZnI+qb0mq
 5+MKtK34X9OCValN0yMX5OQw+rcsh99jLhnZvAVG5x66xKOZ1tcNqy9vPBkmNgIsv0iu2JRqxDk
 +dV4mYUHRtW5KnGrd4wopOM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gf1qk5BTZzpTY9;
 Mon, 15 Jun 2026 15:25:38 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 29DDA40561;
 Mon, 15 Jun 2026 15:33:38 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 15:33:37 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 7/9] power/kvm_vm: remove redundant lcore ID checks
Date: Mon, 15 Jun 2026 15:30:48 +0800
Message-ID: <20260615073050.1996063-8-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260615073050.1996063-1-lihuisong@huawei.com>
References: <20260615073050.1996063-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Now that the cpufreq framework validates the lcore ID using
RTE_POWER_VALID_LCOREID_OR_ERR_RET() before dispatching to any driver,
each individual cpufreq driver no longer needs its own range
check against RTE_MAX_LCORE.

Remove the duplicated lcore ID checks from the kvm_vm cpufreq
driver and its guest_channel helper.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/power/kvm_vm/guest_channel.c | 22 ----------------------
 drivers/power/kvm_vm/kvm_vm.c        | 10 ----------
 2 files changed, 32 deletions(-)

diff --git a/drivers/power/kvm_vm/guest_channel.c b/drivers/power/kvm_vm/guest_channel.c
index 42bfcedb56..dc8fe05fef 100644
--- a/drivers/power/kvm_vm/guest_channel.c
+++ b/drivers/power/kvm_vm/guest_channel.c
@@ -61,11 +61,6 @@ guest_channel_host_connect(const char *path, unsigned int lcore_id)
 	char fd_path[PATH_MAX];
 	int fd = -1;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		GUEST_CHANNEL_LOG(ERR, "Channel(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
-		return -1;
-	}
 	/* check if path is already open */
 	if (global_fds[lcore_id] != -1) {
 		GUEST_CHANNEL_LOG(ERR, "Channel(%u) is already open with fd %d",
@@ -127,12 +122,6 @@ guest_channel_send_msg(struct rte_power_channel_packet *pkt,
 	int ret, buffer_len = sizeof(*pkt);
 	void *buffer = pkt;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		GUEST_CHANNEL_LOG(ERR, "Channel(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
-		return -1;
-	}
-
 	if (global_fds[lcore_id] < 0) {
 		GUEST_CHANNEL_LOG(ERR, "Channel is not connected");
 		return -1;
@@ -169,12 +158,6 @@ int power_guest_channel_read_msg(void *pkt,
 	if (pkt_len == 0 || pkt == NULL)
 		return -1;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		GUEST_CHANNEL_LOG(ERR, "Channel(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
-		return -1;
-	}
-
 	if (global_fds[lcore_id] < 0) {
 		GUEST_CHANNEL_LOG(ERR, "Channel is not connected");
 		return -1;
@@ -225,11 +208,6 @@ int rte_power_guest_channel_receive_msg(void *pkt,
 void
 guest_channel_host_disconnect(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		GUEST_CHANNEL_LOG(ERR, "Channel(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
-		return;
-	}
 	if (global_fds[lcore_id] < 0)
 		return;
 	close(global_fds[lcore_id]);
diff --git a/drivers/power/kvm_vm/kvm_vm.c b/drivers/power/kvm_vm/kvm_vm.c
index 5754a441cd..e8b454bb55 100644
--- a/drivers/power/kvm_vm/kvm_vm.c
+++ b/drivers/power/kvm_vm/kvm_vm.c
@@ -24,11 +24,6 @@ power_kvm_vm_check_supported(void)
 int
 power_kvm_vm_init(unsigned int lcore_id)
 {
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Core(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
-		return -1;
-	}
 	pkt[lcore_id].command = RTE_POWER_CPU_POWER;
 	pkt[lcore_id].resource_id = lcore_id;
 	return guest_channel_host_connect(FD_PATH, lcore_id);
@@ -73,11 +68,6 @@ send_msg(unsigned int lcore_id, uint32_t scale_direction)
 {
 	int ret;
 
-	if (lcore_id >= RTE_MAX_LCORE) {
-		POWER_LOG(ERR, "Core(%u) is out of range 0...%d",
-				lcore_id, RTE_MAX_LCORE-1);
-		return -1;
-	}
 	pkt[lcore_id].unit = scale_direction;
 	ret = guest_channel_send_msg(&pkt[lcore_id], lcore_id);
 	if (ret == 0)
-- 
2.33.0

