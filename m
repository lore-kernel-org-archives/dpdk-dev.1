Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1820CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 19:29:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E21940664;
	Fri, 15 May 2026 21:28:56 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2977340269;
 Fri, 15 May 2026 21:28:53 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 9AE7120B7167; Fri, 15 May 2026 12:28:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AE7120B7167
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH v3 2/7] net/netvsc: retry on SIOCGIFHWADDR failure during VF
 hotplug
Date: Fri, 15 May 2026 12:28:36 -0700
Message-ID: <20260515192843.552762-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260515192843.552762-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
 <20260515192843.552762-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When the MANA VF net directory appears after PCI rescan, udev may rename
the interface (e.g. eth1 → ens1) before DPDK can query its MAC address
via SIOCGIFHWADDR. The ioctl fails because the interface name is stale
during the rename window.

Instead of giving up when SIOCGIFHWADDR fails, close the directory and
schedule another retry. The next attempt will re-read the directory with
the updated interface name (e.g. ens1 instead of eth1) and succeed.

This was observed on Azure VMs where the MANA kernel driver takes >30
seconds to probe after PCI rescan, and udev renames the interface
immediately after registration.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v3: no change
v2:
- Changed SIOCGIFHWADDR retry log level from NOTICE to DEBUG
- Updated comment to reference PCI device check as safety bound

 drivers/net/netvsc/hn_ethdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 85e500c178..096489d66d 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -674,10 +674,18 @@ static void netvsc_hotplug_retry(void *args)
 		ret = ioctl(s, SIOCGIFHWADDR, &req);
 		close(s);
 		if (ret == -1) {
-			PMD_DRV_LOG(ERR,
-				    "Failed to send SIOCGIFHWADDR for device %s",
+			/* Interface may be renamed by udev (e.g. eth1 → ens1).
+			 * Retry from the top — the PCI device check above
+			 * ensures we stop if the device disappears.
+			 */
+			PMD_DRV_LOG(DEBUG,
+				    "Failed to send SIOCGIFHWADDR for device %s, "
+				    "interface may be renaming, retrying",
 				    dir->d_name);
-			break;
+			closedir(di);
+			rte_eal_alarm_set(NETVSC_HOTADD_RETRY_INTERVAL,
+					  netvsc_hotplug_retry, hot_ctx);
+			return;
 		}
 		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER)
 			continue;
-- 
2.43.0

