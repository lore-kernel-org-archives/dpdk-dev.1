Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9861C982CC
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:56:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8B8F4028B;
	Wed, 16 Sep 2026 17:56:26 +0200 (CEST)
Received: from mail.amicon.ru (mail.amicon.ru [77.108.111.100])
 by mails.dpdk.org (Postfix) with ESMTP id AB09D410FD;
 Wed, 16 Sep 2026 11:31:57 +0200 (CEST)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
 t=1789551115; h=from:subject:to:date:message-id;
 bh=rzhqiK/5bvYboFIMTrKxZRclKB1idoiOxs4EsdLyFto=;
 b=ET8UgMKpez46nvMGqMeFAplYVWdENs7B8q9COPE198QsfJUdpaUlcb+aARFOXKCmWlXrg9sBsED
 NzwexJP6QZ/50ZAbOTj3AmlqPA8/UWssA1eM3WoA0+wrIiVMDmziULnJpypo9UtG7Gt/wYZHIZxRx
 wxCnA+d+w3H5xWHT5rTSFo59lonoqj2zwiFTw15I6B2HXnZa1QD9N17ve8MsWuO2OGmeokUsXkpC5
 5vndxWnsSHlxADqlXRQYdt02RXC8UL1uhKt9/YdjwR+spU+FDm+tPjBRkNGyUsoMjy/xfHBxowQ9b
 ga7iy7r66UGJEVK5pWztLw9ggzGa6UY6iZTA==
Received: from amicon.ru (172.16.36.76) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 16 Sep
 2026 12:31:55 +0300
From: Artem Novikov <naa@amicon.ru>
To: <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <beilei.xing@intel.com>,
 <lvc-project@linuxtesting.org>, <naa@amicon.ru>, <rrv@amicon.ru>
Subject: [PATCH v2] net/i40e: fix ethertype filter restore diagnostics
Date: Wed, 16 Sep 2026 12:31:43 +0300
Message-ID: <20260916093143.100776-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914100823.55165-1-naa@amicon.ru>
References: <20260914100823.55165-1-naa@amicon.ru>
MIME-Version: 1.0
X-Originating-IP: [172.16.36.76]
X-Mailman-Approved-At: Wed, 16 Sep 2026 17:56:25 +0200
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
success. The restore path ignores command failures and logs statistics
even if no command succeeds. With an empty filter list, it reads
uninitialized statistics.

Check each restore result and log failures with the affected filter.
Continue restoring the remaining filters after an error. Log resource
usage once after the loop, using the last successful command's statistics,
and skip this log if no command succeeded. The command helper leaves the
statistics unchanged on failure.

Fixes: ddcd4d4dbbe0 ("net/i40e: restore ethertype filter")
Cc: stable@dpdk.org
Cc: beilei.xing@intel.com

Signed-off-by: Artem Novikov <naa@amicon.ru>
---
v2:
* Log resource statistics once, after the last successful restore.
* Keep per-filter error diagnostics and continue after failed commands.
* Keep the error format string on one line.

 drivers/net/intel/i40e/i40e_ethdev.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index d64d8dd7b5662cb79f52a3a256765a07588bac1e..208d72bac0d8c2acba080cb2f650084b8719ecd1 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11630,7 +11630,9 @@ i40e_ethertype_filter_restore(struct i40e_pf *pf)
 		*ethertype_list = &pf->ethertype.ethertype_list;
 	struct i40e_ethertype_filter *f;
 	struct i40e_control_filter_stats stats;
+	enum i40e_status_code ret;
 	uint16_t flags;
+	bool stats_valid = false;
 
 	TAILQ_FOREACH(f, ethertype_list, rules) {
 		flags = 0;
@@ -11640,18 +11642,29 @@ i40e_ethertype_filter_restore(struct i40e_pf *pf)
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
+				    "Failed to restore ethertype filter, ether_type=0x%04x, queue=%u, vsi_seid=%u, err %d",
+				    f->input.ether_type, f->queue,
+				    pf->main_vsi->seid, ret);
+			continue;
+		}
+
+		stats_valid = true;
+	}
+
+	if (stats_valid) {
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
