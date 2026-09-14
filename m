Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE9EC88E64
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 11:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9CBC40BA0;
	Mon, 14 Sep 2026 13:49:31 +0200 (CEST)
Received: from mail.amicon.ru (unknown [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id 9D0F040144;
 Mon, 14 Sep 2026 12:08:35 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789380515; h=from:subject:to:date:message-id;
 bh=z8sJehbBtLgj7px4e7c3zQkOZ0EZiEcjesvo9hHVY2M=;
 b=lMJ6cYdcnT2GtXyA+YqPl5v+3ONfnlacEF9J52620hwGm1ZR7T+PiZ4z4YrvP1tg+RU85kmFPHq
 HOJWxfx4phIJoxc79UmJOwy5+1vKumcZ/Q+AuL6gd/vhtX03Lx6FDvVKFCywi57e8L3jBRDPUpFL0
 jEKu6xAbyPkmxG8QrCjUzkqZpPwydcjz8OURIKvjcJ2BtYtH/uil4h2czwPqCXfhn8/VfEbWb4avO
 YIYeZhLav02Jh0XLszT/NqW8Z3tD4q7vNn3m772GHPymYSFsTej3vUHQj3sFQ1ONScAH5hAihF0gj
 bMr2+BztvgOT3HWv3kVAMEYNZeEP4cBQwuJA==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 14 Sep
 2026 13:08:34 +0300
From: Artem Novikov <naa@amicon.ru>
To: <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <lvc-project@linuxtesting.org>, <naa@amicon.ru>,
 <rrv@amicon.ru>, <beilei.xing@intel.com>, <stable@dpdk.org>
Subject: [PATCH] net/i40e: fix ethertype filter restore diagnostics
Date: Mon, 14 Sep 2026 13:08:22 +0300
Message-ID: <20260914100823.55165-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [172.16.36.76]
X-Mailman-Approved-At: Mon, 14 Sep 2026 13:49:28 +0200
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

The control packet filter command only fills its statistics output on
success. The restore path logs the last output even when the command
fails, and reads uninitialized statistics when the filter list is empty.
It also ignores the command status.

Check each restore result and log failures with the affected filter.
Only report statistics after a successful command, when all fields are
valid. Continue restoring the remaining filters after an error, preserving
the existing best-effort restore policy.

Fixes: ddcd4d4dbbe0 ("net/i40e: restore ethertype filter")
Cc: stable@dpdk.org
Cc: beilei.xing@intel.com

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index b6b2d291eee4f13ae59c80c5a281cee6d4be2f48..f135bd13dcfc885e030d17798159ae9b4bfb5f07 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11617,6 +11617,7 @@ i40e_ethertype_filter_restore(struct i40e_pf *pf)
 		*ethertype_list = &pf->ethertype.ethertype_list;
 	struct i40e_ethertype_filter *f;
 	struct i40e_control_filter_stats stats;
+	enum i40e_status_code ret;
 	uint16_t flags;
 
 	TAILQ_FOREACH(f, ethertype_list, rules) {
@@ -11627,18 +11628,26 @@ i40e_ethertype_filter_restore(struct i40e_pf *pf)
 			flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_DROP;
 		flags |= I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TO_QUEUE;
 
-		memset(&stats, 0, sizeof(stats));
-		i40e_aq_add_rem_control_packet_filter(hw,
+		ret = i40e_aq_add_rem_control_packet_filter(hw,
 					    f->input.mac_addr.addr_bytes,
 					    f->input.ether_type,
 					    flags, pf->main_vsi->seid,
 					    f->queue, 1, &stats, NULL);
+		if (ret != I40E_SUCCESS) {
+			PMD_DRV_LOG(ERR,
+				    "Failed to restore ethertype filter, "
+				    "ether_type=0x%04x, queue=%u, vsi_seid=%u, err %d",
+				    f->input.ether_type, f->queue,
+				    pf->main_vsi->seid, ret);
+			continue;
+		}
+
+		PMD_DRV_LOG(INFO, "Ethertype filter:"
+			    " mac_etype_used = %u, etype_used = %u,"
+			    " mac_etype_free = %u, etype_free = %u",
+			    stats.mac_etype_used, stats.etype_used,
+			    stats.mac_etype_free, stats.etype_free);
 	}
-	PMD_DRV_LOG(INFO, "Ethertype filter:"
-		    " mac_etype_used = %u, etype_used = %u,"
-		    " mac_etype_free = %u, etype_free = %u",
-		    stats.mac_etype_used, stats.etype_used,
-		    stats.mac_etype_free, stats.etype_free);
 }
 
 /* Restore tunnel filter */
-- 
2.43.0
