Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B75C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 19:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05C00406BB;
	Mon, 24 Aug 2026 21:23:51 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 1CD2B406A2
 for <dev@dpdk.org>; Mon, 24 Aug 2026 21:23:50 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-90a6b298887so21450506d6.2
 for <dev@dpdk.org>; Mon, 24 Aug 2026 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787599429; x=1788204229; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p34BidW1uIHMC1J31/Og1vKYIIbfHg3XfhoIef/A5cs=;
 b=L21kQ+ib3wuXFV4GAYMwXZs8RpsYIKobzBcANbkKiHmXYj3VtnbF1RfHe7NvkI+e+h
 qxpdwS98IC8Jb/gLl7Oie+UgF4CXPQZe8g83LLix+3tvgTzwPsOnMkVOZcOetT+VSdnP
 sCA19qhSS/eNlXnVz181mxTrNfLcr5ndpK9FMTU1RT+JPHlpfSF1O6pYxsC5QmfHi6Xp
 P37rG0rc8fDMH15Cwbi6FDw5MZuGFzVrgYQmlSYVb7zfa4wdgsxsuL8j202dKicX4uCU
 thaWulQsY6V9oYExjkz7XC7Act5a/AJ5K4/5wlAjts3cLXnuiu0z5ial15T6TFoqO7eQ
 Z3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787599429; x=1788204229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p34BidW1uIHMC1J31/Og1vKYIIbfHg3XfhoIef/A5cs=;
 b=WdqDvsvBHj03JnTnXCqX1DLVipNpCmSIWCAZuUyHAY6kFEkVn/kgF/2Dm1VZyT98KI
 VGTenxBiISwo0oSn5sdQQiZHrSu0+KqooeymcR+qfFRMjmWh0ZKUF1U2fJhOvdkCrUxo
 wQT/B8beAB5zHg+Mhu4obDaDC+WlrByUFRkYvp0HcOsMktQL+yNRBIGFcRl6FEWEibov
 42y2CNObwxeecblstyI4tsUgf2gDYqAPamXqiv0rJq0pVeCuyL4kfz/ZTLkjbXHuZiC+
 qiPQq+aNvIF5leIWakf0b8oHxkar8FWrZhuGSeUQUa4lfA9yWxmkIgI50itAZL0R6agJ
 F2Lw==
X-Gm-Message-State: AFuF++nLQ6urXly6Ss4Wzyk7LryAlgnJi4g0W/6UKqBz+ieEAuuQscaG
 KXz80vWdbiaMjbGmVDLHNA2CekzOvc955pION8gRiTEQcACoBLu5sDcGOxaxijVqvnA=
X-Gm-Gg: AR+sD13kZpnx8vdPUyCfZbymYFtKThlhsepU6ZMdgcuHMXwsdwdfzMUkd5L6HYyXvmH
 sYIklg7ICXF4r46011YT1I++gZn3kv8b+zLAj1ImakcDOtOT0Fxyd0Azm0Ua2BUQBENurbaeoXs
 tqI4/4in+l+CcDvh0G7D9EV8lItOGLKvPR2Iw33A9kayPR2p+zv/u8M3A06xWG5WD8PX4irJrAU
 b7KdVdBkSbM5NGIZyV3DbJV2xrtAskEUXFXqv6fGhQ/fVl0UFTA+uzl4dPh7TrkWEN9z1hvCMqd
 uNIy7LvL3LA5chycsNwXHX7ImnQl01+ePJhLAaY5MLAxE7qCKmjWOPQOcFTeC8WmxcUj9j+BZ09
 wKDcZbAMRGEt2yByM/IKckhrtyGZN0WtjSCj8whK+A0QPU8iEsoU46HX7FE+Ht0ifZUH6K8XqJf
 R1y32L6loqn/u54Cm7sVA3fHe+HyhLWmY1NypalLHqxmsUdVeenYx3RGSyOiFxEw==
X-Received: by 2002:ac8:5714:0:b0:51c:8432:1753 with SMTP id
 d75a77b69052e-52e09caf410mr179754831cf.30.1787599429197; 
 Mon, 24 Aug 2026 12:23:49 -0700 (PDT)
Received: from wpc.example.org ([67.221.51.185])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52e09974dc5sm53906081cf.1.2026.08.24.12.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:23:48 -0700 (PDT)
From: William Bland <blandwwa@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Chas Williams <3chas3@gmail.com>
Cc: dev@dpdk.org,
	William Bland <blandwwa@gmail.com>
Subject: [PATCH 3/3] net/af_packet: fix QinQ outer TPID on VLAN reinsertion
Date: Mon, 24 Aug 2026 15:22:27 -0400
Message-ID: <20260824192228.1197189-3-blandwwa@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824192228.1197189-1-blandwwa@gmail.com>
References: <20260824192228.1197189-1-blandwwa@gmail.com>
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

eth_af_packet_rx() called rte_vlan_insert(), which hardcodes EtherType
0x8100 (802.1Q). This was wrong when reinserting a stripped tag whose
original TPID was 0x88a8 (802.1ad QinQ).

Fix by reading the actual TPID from tp_vlan_tpid (struct tpacket2_hdr),
then passing it to rte_vlan_insert_tpid().

Fixes: 23deeebfcfa8 ("net/af_packet: support 802.1Q VLAN")

Signed-off-by: William Bland <blandwwa@gmail.com>
---
 app/test/meson.build                      |   2 +-
 app/test/test_net_ether.c                 | 122 ++++++++++++++++++++++
 drivers/net/af_packet/rte_eth_af_packet.c |  10 +-
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index 51abeeb732..e927d4306a 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -134,7 +134,7 @@ source_file_deps = {
     'test_meter.c': ['meter'],
     'test_metrics.c': ['metrics'],
     'test_mp_secondary.c': ['hash'],
-    'test_net_ether.c': ['net'],
+    'test_net_ether.c': ['net', 'mbuf'],
     'test_net_ip6.c': ['net'],
     'test_pcapng.c': ['net_null', 'net', 'ethdev', 'pcapng', 'bus_vdev'],
     'test_pdcp.c': ['eventdev', 'pdcp', 'net', 'timer', 'security'],
diff --git a/app/test/test_net_ether.c b/app/test/test_net_ether.c
index ec11224171..19f9c85e5b 100644
--- a/app/test/test_net_ether.c
+++ b/app/test/test_net_ether.c
@@ -3,6 +3,8 @@
  */
 
 #include <rte_ether.h>
+#include <rte_mbuf.h>
+#include <rte_mempool.h>
 
 #include <rte_test.h>
 #include "test.h"
@@ -162,4 +164,124 @@ test_net_ether(void)
 	return 0;
 }
 
+/*
+ * Build a minimal Ethernet frame in an mbuf: Ethernet header with the given
+ * ether_type followed by payload_len zero bytes.
+ */
+static struct rte_mbuf *
+alloc_frame(struct rte_mempool *mp, uint16_t ether_type, uint16_t payload_len)
+{
+	struct rte_ether_hdr *eh;
+	struct rte_mbuf *m;
+
+	m = rte_pktmbuf_alloc(mp);
+	if (m == NULL)
+		return NULL;
+
+	eh = (struct rte_ether_hdr *)rte_pktmbuf_append(m,
+			sizeof(*eh) + payload_len);
+	if (eh == NULL) {
+		rte_pktmbuf_free(m);
+		return NULL;
+	}
+
+	memset(eh->dst_addr.addr_bytes, 0xff, RTE_ETHER_ADDR_LEN);
+	memset(eh->src_addr.addr_bytes, 0x00, RTE_ETHER_ADDR_LEN);
+	eh->ether_type = rte_cpu_to_be_16(ether_type);
+
+	return m;
+}
+
+static int
+test_vlan_insert_8021q(struct rte_mempool *mp)
+{
+	struct rte_ether_hdr *eh;
+	struct rte_vlan_hdr *vh;
+	struct rte_mbuf *m;
+	int ret;
+
+	m = alloc_frame(mp, RTE_ETHER_TYPE_IPV4, 46);
+	TEST_ASSERT_NOT_NULL(m, "Failed to allocate mbuf");
+
+	m->vlan_tci = 100;
+	m->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+
+	ret = rte_vlan_insert(&m);
+	TEST_ASSERT_SUCCESS(ret, "rte_vlan_insert failed");
+
+	eh = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(eh->ether_type), RTE_ETHER_TYPE_VLAN,
+		"Expected 802.1Q TPID 0x%04x, got 0x%04x",
+		RTE_ETHER_TYPE_VLAN, rte_be_to_cpu_16(eh->ether_type));
+
+	vh = (struct rte_vlan_hdr *)(eh + 1);
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->vlan_tci), 100,
+		"Expected VID 100, got %u", rte_be_to_cpu_16(vh->vlan_tci));
+
+	rte_pktmbuf_free(m);
+	return TEST_SUCCESS;
+}
+
+static int
+test_vlan_insert_tpid(struct rte_mempool *mp)
+{
+	struct rte_ether_hdr *eh;
+	struct rte_vlan_hdr *vh;
+	struct rte_mbuf *m;
+	int ret;
+
+	m = alloc_frame(mp, RTE_ETHER_TYPE_VLAN, sizeof(*vh) + 46);
+	TEST_ASSERT_NOT_NULL(m, "Failed to allocate mbuf");
+
+	vh = (struct rte_vlan_hdr *)(rte_pktmbuf_mtod(m, struct rte_ether_hdr *) + 1);
+	vh->vlan_tci = rte_cpu_to_be_16(200);
+	vh->eth_proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	m->vlan_tci = 50;
+	m->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+
+	ret = rte_vlan_insert_tpid(&m, RTE_ETHER_TYPE_QINQ);
+	TEST_ASSERT_SUCCESS(ret, "rte_vlan_insert_tpid failed");
+
+	eh = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(eh->ether_type), RTE_ETHER_TYPE_QINQ,
+		"Outer TPID: expected 0x%04x (802.1ad) got 0x%04x",
+		RTE_ETHER_TYPE_QINQ, rte_be_to_cpu_16(eh->ether_type));
+
+	vh = (struct rte_vlan_hdr *)(eh + 1);
+	TEST_ASSERT_EQUAL(rte_be_to_cpu_16(vh->vlan_tci), 50,
+		"Outer VID: expected 50, got %u",
+		rte_be_to_cpu_16(vh->vlan_tci));
+
+	rte_pktmbuf_free(m);
+	return TEST_SUCCESS;
+}
+
+static int
+test_vlan_insert(void)
+{
+	struct rte_mempool *mp;
+	int ret;
+
+	mp = rte_pktmbuf_pool_create("vlan_insert_test_pool", 64, 0, 0,
+				     RTE_MBUF_DEFAULT_BUF_SIZE,
+				     SOCKET_ID_ANY);
+	if (mp == NULL) {
+		fprintf(stderr, "Failed to create mempool\n");
+		return -1;
+	}
+
+	ret = test_vlan_insert_8021q(mp);
+	if (ret != TEST_SUCCESS)
+		goto out;
+
+	ret = test_vlan_insert_tpid(mp);
+
+out:
+	rte_mempool_free(mp);
+	return ret;
+}
+
 REGISTER_FAST_TEST(net_ether_autotest, NOHUGE_OK, ASAN_OK, test_net_ether);
+REGISTER_FAST_TEST(vlan_insert_autotest, NOHUGE_OK, ASAN_OK, test_vlan_insert);
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index b0ff22ea55..8225e0d7f9 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -222,11 +222,17 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
+			uint16_t tpid;
+
 			mbuf->vlan_tci = ppd->tp_vlan_tci;
 			mbuf->ol_flags |= (RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED);
 
-			if (!pkt_q->vlan_strip && rte_vlan_insert(&mbuf))
-				PMD_LOG(ERR, "Failed to reinsert VLAN tag");
+			if (!pkt_q->vlan_strip) {
+				tpid = (ppd->tp_status & TP_STATUS_VLAN_TPID_VALID) ?
+					ppd->tp_vlan_tpid : RTE_ETHER_TYPE_VLAN;
+				if (rte_vlan_insert_tpid(&mbuf, tpid))
+					PMD_LOG(ERR, "Failed to reinsert VLAN tag");
+			}
 		}
 
 		/* add kernel provided timestamp when offloading is enabled */
-- 
2.43.0

