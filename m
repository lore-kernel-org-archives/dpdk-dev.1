Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8697C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 16:32:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D19940663;
	Tue, 18 Feb 2025 17:32:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 38904402CF
 for <dev@dpdk.org>; Tue, 18 Feb 2025 17:32:15 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 710A520376EA; Tue, 18 Feb 2025 08:32:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 710A520376EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739896334;
 bh=I0OlH4Ul25PFMJ3/4vyDDa4MZ+hWDtB0eOogQkZ+zm4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G8agwvTlbrAqo3+dMa5V9S3B8pmcNgV1t2CEbecWkI9oy2TWnOqJ11ambqQ42h3DI
 QcXCZyfwPcWORjOeX3S+Dl9FYHONhj6hufSLbyVOiCN1zyWat5yhRIt8OKVfD7cFU3
 yBjf9WfwcScgexmFK7VRZ45ABWWQghkbxJiHhUUQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v2 04/10] test-pmd: do explicit 64-bit shift to avoid implicit
 conversion
Date: Tue, 18 Feb 2025 08:32:03 -0800
Message-Id: <1739896329-1946-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739896329-1946-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in warnings like the one below:

app/test-pmd/util.c(201): warning C4334: '<<': result of 32-bit shift
    implicitly converted to 64 bits (was 64-bit shift intended?)

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c | 4 ++--
 app/test-pmd/testpmd.c | 2 +-
 app/test-pmd/util.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 86d763b66a..2afcf916c0 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -12632,11 +12632,11 @@ cmd_config_dynf_specific_parsed(void *parsed_result,
 	}
 	old_port_flags = ports[res->port_id].mbuf_dynf;
 	if (!strcmp(res->value, "set")) {
-		ports[res->port_id].mbuf_dynf |= 1UL << flag;
+		ports[res->port_id].mbuf_dynf |= RTE_BIT64(flag);
 		if (old_port_flags == 0)
 			add_tx_dynf_callback(res->port_id);
 	} else {
-		ports[res->port_id].mbuf_dynf &= ~(1UL << flag);
+		ports[res->port_id].mbuf_dynf &= ~RTE_BIT64(flag);
 		if (ports[res->port_id].mbuf_dynf == 0)
 			remove_tx_dynf_callback(res->port_id);
 	}
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 0520aba0db..0a5b999c3a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4152,7 +4152,7 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
 		for (i = 0; i < vmdq_rx_conf->nb_pool_maps; i++) {
 			vmdq_rx_conf->pool_map[i].vlan_id = vlan_tags[i];
 			vmdq_rx_conf->pool_map[i].pools =
-				1 << (i % vmdq_rx_conf->nb_queue_pools);
+				RTE_BIT64(i % vmdq_rx_conf->nb_queue_pools);
 		}
 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
 			vmdq_rx_conf->dcb_tc[i] = i % num_tcs;
diff --git a/app/test-pmd/util.c b/app/test-pmd/util.c
index 5fa05fad16..3934831b19 100644
--- a/app/test-pmd/util.c
+++ b/app/test-pmd/util.c
@@ -201,7 +201,7 @@ dump_pkt_burst(uint16_t port_id, uint16_t queue, struct rte_mbuf *pkts[],
 				MKDUMPSTR(print_buf, buf_size, cur_len,
 					  " - dynf %s: %d",
 					  dynf_names[dynf_index],
-					  !!(ol_flags & (1UL << dynf_index)));
+					  !!(ol_flags & RTE_BIT64(dynf_index)));
 		}
 		if (mb->packet_type) {
 			rte_get_ptype_name(mb->packet_type, buf, sizeof(buf));
-- 
2.48.1.vfs.0.0

