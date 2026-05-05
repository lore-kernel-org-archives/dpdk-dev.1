Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCBFCD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 20:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EE7440A71;
	Tue,  5 May 2026 22:45:20 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 54E3840A4B;
 Tue,  5 May 2026 22:45:18 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 940EB20B7168; Tue,  5 May 2026 13:45:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 940EB20B7168
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH 3/7] net/netvsc: retry full probe when IB device not ready
 during hotplug
Date: Tue,  5 May 2026 13:44:52 -0700
Message-ID: <20260505204457.267934-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260505204457.267934-1-longli@microsoft.com>
References: <20260505204457.267934-1-longli@microsoft.com>
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

When rte_eal_hotplug_add returns -ENODEV during VF hot-add, it means the
MANA IB/verbs device is not yet registered by the mana_ib kernel module.
This happens because the mana_ib auxiliary driver probes asynchronously
after the MANA net driver creates the network interface.

On Azure VMs, the gap between netdev registration and IB device
registration can be several seconds. Previously, netvsc would log the
error and give up after finding the matching MAC address.

Now, on -ENODEV, restart the full retry loop from the PCI device
existence check. This re-scans the net directory to pick up any
interface renames (e.g. eth1 -> ens1) and retries until the IB device
is ready.

The -EEXIST return (device already probed by another netvsc port on the
same PCI device) is handled silently, as hn_vf_add will find the
already-probed VF port.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 8bb2df3c19..5d1ef10eff 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -709,17 +709,33 @@ static void netvsc_hotplug_retry(void *args)
 			 * parent device, restore its args.
 			 */
 			ret = rte_eal_hotplug_add(d->bus->name, d->name, drv_str ? drv_str : "");
-			if (ret) {
-				PMD_DRV_LOG(ERR,
-					    "Failed to add PCI device %s",
+			free(drv_str);
+
+			if (ret == -ENODEV) {
+				/* IB device not ready yet (mana_ib not probed).
+				 * Restart the full retry from PCI device check
+				 * so we re-verify the device and get fresh
+				 * interface names after any renames.
+				 */
+				PMD_DRV_LOG(NOTICE,
+					    "IB device not ready for %s, "
+					    "restarting probe in 1 second",
 					    d->name);
+				closedir(di);
+				rte_eal_alarm_set(NETVSC_HOTADD_RETRY_INTERVAL,
+						  netvsc_hotplug_retry,
+						  hot_ctx);
+				return;
 			}
 
-			free(drv_str);
+			if (ret && ret != -EEXIST)
+				PMD_DRV_LOG(NOTICE,
+					    "Failed to add PCI device %s (ret=%d)",
+					    d->name, ret);
 
 			ret = hn_vf_add(dev, hv);
 			if (ret)
-				PMD_DRV_LOG(ERR, "Failed to add VF in hotplug retry: %d", ret);
+				PMD_DRV_LOG(ERR, "Failed to add VF: %d", ret);
 			break;
 		}
 	}
-- 
2.43.0

