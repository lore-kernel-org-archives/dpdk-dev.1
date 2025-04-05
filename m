Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209BAC3601E
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Apr 2025 00:36:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7517F4064A;
	Sat,  5 Apr 2025 02:35:49 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2C38940611
 for <dev@dpdk.org>; Sat,  5 Apr 2025 02:35:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 856012027DF8; Fri,  4 Apr 2025 17:35:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 856012027DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1743813346;
 bh=JXt2TsVr+5vy/Q9kpkSYak47kfrBbmCieKaDKD8tXHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nuVqByVGIDTfq5ZiiA3LsEZ+ecB/KmD0SphAyQOgdDak8DVHcbH2Mc9rNuEy/T1z+
 /LvhD56WR9ZlMI9G5iIdO3V7LD3t1lO77odbFR0Y6qaKE4V26cXZRljR/91CdJG7QJ
 l9mzppPRAe8FXVkBd2H+gKDe7Zojwp6HrJOIHo2E=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3 4/6] bus/vmbus: support channels without monitoring enabled
Date: Fri,  4 Apr 2025 17:35:36 -0700
Message-Id: <1743813338-28238-5-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
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

From: Long Li <longli@microsoft.com>

Hyperv host may offer channels without monitor enabled. The max monitor
ID it supports is 128. Over those channels without monitor enabled,
Hyperv does not send or receive large amount of data traffic and almost all
the data traffic is going over the VF.

Change the code to not fail on creating channels without monitor enabled.
Use UINT8_MAX (256) to indicate this channel have no monitoring.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/linux/vmbus_bus.c | 9 ++++++---
 drivers/bus/vmbus/linux/vmbus_uio.c | 4 ++--
 drivers/bus/vmbus/vmbus_channel.c   | 3 +++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 01d8111b85..79fd3370b8 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -280,9 +280,12 @@ vmbus_scan_one(const char *name)
 
 	/* get monitor id */
 	snprintf(filename, sizeof(filename), "%s/monitor_id", dirname);
-	if (eal_parse_sysfs_value(filename, &tmp) < 0)
-		goto error;
-	dev->monitor_id = tmp;
+	if (eal_parse_sysfs_value(filename, &tmp) >= 0) {
+		dev->monitor_id = tmp;
+	} else {
+		VMBUS_LOG(NOTICE, "monitor disabled on %s", name);
+		dev->monitor_id = UINT8_MAX;
+	}
 
 	/* get numa node (if present) */
 	snprintf(filename, sizeof(filename), "%s/numa_node",
diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index 26edef342d..33edc151f6 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -451,9 +451,9 @@ int vmbus_uio_get_subchan(struct vmbus_channel *primary,
 		err = vmbus_uio_sysfs_read(subchan_path, "monitor_id",
 					   &monid, UINT8_MAX);
 		if (err) {
-			VMBUS_LOG(NOTICE, "no monitor_id in %s:%s",
+			VMBUS_LOG(NOTICE, "no monitor_id in %s:%s use int mode",
 				  subchan_path, strerror(-err));
-			goto fail;
+			monid = UINT8_MAX;
 		}
 
 		err = vmbus_chan_create(dev, relid, subid, monid, subchan);
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index 925c2aa081..d4b5ba1979 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -52,6 +52,9 @@ rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 		      const struct vmbus_channel *chan,
 		      uint32_t latency)
 {
+	if (chan->monitor_id == UINT8_MAX)
+		return;
+
 	uint32_t trig_idx = chan->monitor_id / VMBUS_MONTRIG_LEN;
 	uint32_t trig_offs = chan->monitor_id % VMBUS_MONTRIG_LEN;
 
-- 
2.34.1

