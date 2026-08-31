Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58844C624A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 16:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DF284060B;
	Mon, 31 Aug 2026 18:11:49 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 1B6C440696
 for <dev@dpdk.org>; Mon, 31 Aug 2026 18:11:48 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cc891373e0so32719615ad.2
 for <dev@dpdk.org>; Mon, 31 Aug 2026 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788192707;
 x=1788797507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTUHMQ2mPnXCvb5O5ut7DXEjhzWs9/WdfkHywkdspo8=;
 b=vulVl2gmGcWoN/H2d9TMhNTjk5z49Ntk73sVRo2bzPk5NcvwgDK8CQYvrMerV2RAlm
 oV8rmEloCsG4Byz9IVxjcwqRwdQLBPWcBwBGUB0Iu39W3VZAj70GeC0YvPr9/cDOAl7r
 LlD3StYuhwACk4Yiv/o19hI+k01HQ3YavoDomDhF9bFY+ycFUvw/xXE6ZUvCXyFeX69x
 RtDPyzwn5Jzt4hGntcIHdOhcQ9YXeMb3+8uNRUA3XROp62vx1VLhqSkY/IJHArtyWb89
 9DlDrgE79KoviPwBW9ix/Q5uhD0rDdesmC5aOwdANDQZY3WW5siRqq/k+PdMdTdcOrQG
 6IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192707; x=1788797507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mTUHMQ2mPnXCvb5O5ut7DXEjhzWs9/WdfkHywkdspo8=;
 b=cllufjK/rnwceo8U33rAL4SqfG05Ez+j4ro8O1YX97iwKnZl6kSYNNf/YgrqSKRbKt
 kNBA3JQG9SM5ycVQApI16PqAOggxEAe2nDnDmXwtxRkTKs0JddrvQPLWOejAb6LUhMGS
 0VkN05Iw91im+4TbWDaGeSBy2gK6Ce1bJDW5spjuAdglej5bT2kk6WQ+qNBHRFN9AJi0
 O80i3k0U1PEUil6uaACKY9skDZqp3Ov2fxLNSvt3LbHkKuKYUwjzwY9CYV2wUjKfAoRt
 6X14yh0hT3Hki79Z9ybmnUGZFSP9XmL+L5eZD4U7NJxys/e3ztviPjbIndW6HTvbC5bs
 kUFA==
X-Gm-Message-State: AFuF++lLRPyNXjuAkhM5J4w9c0kpMh5HGLyfcby38NJMl1JEsZDm931v
 g5WMwvCgaDUjw8C/LUkDoUMGkq56LOC0vpoAXzNaZ+u86fvwur/k3IQoVEHkXF/zuX7FYgiXBD0
 qNgCT
X-Gm-Gg: AYBFou0jRiPPNr5KZV+V1xcZBVpvOPNGXgDhp+7HPsVLLgF3tGA47GeJS5wLCwvVmEp
 /pB/2YsZZlkRrah+iJZo3pWGxH3nFirjvuQw8kdcsC0uzgMrj7XwEksz8aeoWhZgBrIkEkhODMt
 R4Hw8nf1XPNr7t2dtvnPGyeHOX0TwigNBLz21n74ndeIcdk47evqSE/5WWMYks0LfTX10e4vF08
 7AAv+Lq7PaPwDh2ncdeibT6RDpV9YBqnUlwjvUP9q1PbGwMdJ+7YfU/2vHFmxXylzk2LRh8s6+8
 F3HHw/uB3Vdl/rHYho6nIWhHLp+Azo6eb4iJQSusTcWGe4xlL/npKjkTXag98P6XRMf77XVnUT0
 BVjPcCGrcnq6oHAH/MyTTt79IZLFI1fAqxaV4dAjL6P4UbpQWlC8agRnzuyuewadYAXKmjj6rVK
 +rogwuQGJs/ILtRWju7WIcKvzRUu4WQTbmJeNn27ukr/sbgx7Y2FsfvuNKfV4k1RddDhUIzrNfy
 No+mO6ds0csUHWr5CaBJJXcsJ8=
X-Received: by 2002:a17:903:f8e:b0:2d6:5beb:8692 with SMTP id
 d9443c01a7336-2d74dc53880mr450805905ad.6.1788192707140; 
 Mon, 31 Aug 2026 09:11:47 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f7be607sm31355741eec.10.2026.08.31.09.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:11:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH v2 7/8] test/bonding: add extended statistics test
Date: Mon, 31 Aug 2026 09:06:47 -0700
Message-ID: <20260831161105.289670-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831161105.289670-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260831161105.289670-1-stephen@networkplumber.org>
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

The bonding extended statistics had no coverage. Add a test that
exercises the contract of the three new dev_ops.

The test checks that the name and value queries agree on the count,
that a NULL or undersized table returns the required size rather than
filling it, that the per-member names are generated from the member
port ids in member order, and that a burst received on one member is
attributed to that member alone and to no other. It then resets and
confirms the member counters are cleared.

ethdev prepends its own basic statistics to the driver's, so the
offset of the first member entry is discovered at runtime rather than
assumed to be zero.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_link_bonding.c | 148 +++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/app/test/test_link_bonding.c b/app/test/test_link_bonding.c
index 19b064771a..33652948be 100644
--- a/app/test/test_link_bonding.c
+++ b/app/test/test_link_bonding.c
@@ -1663,6 +1663,153 @@ test_roundrobin_rx_burst_on_single_member(void)
 	return remove_members_and_stop_bonding_device();
 }
 
+/* The bonding PMD reports rx and tx packets, bytes and errors per member.
+ * ethdev prepends its own basic statistics to the driver's, so the member
+ * entries start at an offset that has to be discovered at runtime.
+ */
+#define TEST_XSTATS_PER_MEMBER 6
+
+#define TEST_XSTATS_MEMBER_COUNT 4
+
+#define TEST_XSTATS_DRIVER_COUNT \
+	(TEST_XSTATS_MEMBER_COUNT * TEST_XSTATS_PER_MEMBER)
+
+/* Enough room for the driver entries plus any basic statistics. */
+#define TEST_XSTATS_MAX 64
+
+static int
+test_xstats(void)
+{
+	struct rte_mbuf *gen_pkt_burst[MAX_PKT_BURST];
+	struct rte_mbuf *rx_pkt_burst[MAX_PKT_BURST] = { NULL };
+	struct rte_eth_xstat_name names[TEST_XSTATS_MAX];
+	struct rte_eth_xstat xstats[TEST_XSTATS_MAX];
+	uint16_t bonding_port_id = test_params->bonding_port_id;
+	unsigned int count;
+	int burst_size = 17;
+	int basic, total;
+	int i, j;
+	char name[RTE_ETH_XSTATS_NAME_SIZE];
+
+	TEST_ASSERT_SUCCESS(initialize_bonding_device_with_members(
+			BONDING_MODE_ROUND_ROBIN, 0,
+			TEST_XSTATS_MEMBER_COUNT, 1),
+			"Failed to initialize bonding device with members");
+
+	/* A NULL table is a query for the number of xstats. The bonding
+	 * driver contributes six per member on top of the basic statistics.
+	 */
+	total = rte_eth_xstats_get_names(bonding_port_id, NULL, 0);
+	TEST_ASSERT(total > TEST_XSTATS_DRIVER_COUNT,
+			"Expected more than %d xstats names, got %d",
+			TEST_XSTATS_DRIVER_COUNT, total);
+	TEST_ASSERT(total <= TEST_XSTATS_MAX,
+			"xstats count %d exceeds test table size %d",
+			total, TEST_XSTATS_MAX);
+
+	basic = total - TEST_XSTATS_DRIVER_COUNT;
+
+	count = rte_eth_xstats_get(bonding_port_id, NULL, 0);
+	TEST_ASSERT_EQUAL(count, (unsigned int)total,
+			"xstats count %u differs from names count %d",
+			count, total);
+
+	/* A table smaller than the xstats count must be rejected, and the
+	 * required size returned instead.
+	 */
+	count = rte_eth_xstats_get_names(bonding_port_id, names, total - 1);
+	TEST_ASSERT_EQUAL(count, (unsigned int)total,
+			"Undersized names query returned %u, expected %d",
+			count, total);
+
+	count = rte_eth_xstats_get_names(bonding_port_id, names, total);
+	TEST_ASSERT_EQUAL(count, (unsigned int)total,
+			"Failed to get %d xstats names, got %u", total, count);
+
+	/* Driver names follow the basic ones, per member port id in member
+	 * order, rx before tx.
+	 */
+	for (i = 0; i < TEST_XSTATS_MEMBER_COUNT; i++) {
+		uint16_t member_id = test_params->member_port_ids[i];
+		static const char * const dir[] = { "rx", "tx" };
+		static const char * const stat[] = {
+			"packets", "bytes", "errors"
+		};
+		unsigned int base = basic + i * TEST_XSTATS_PER_MEMBER;
+		unsigned int d, s, idx = 0;
+
+		for (d = 0; d < RTE_DIM(dir); d++) {
+			for (s = 0; s < RTE_DIM(stat); s++) {
+				snprintf(name, sizeof(name), "%s_member%u_%s",
+					 dir[d], member_id, stat[s]);
+				TEST_ASSERT_SUCCESS(strcmp(
+						names[base + idx].name, name),
+						"xstats name %u is \"%s\", expected \"%s\"",
+						base + idx,
+						names[base + idx].name, name);
+				idx++;
+			}
+		}
+	}
+
+	/* Receive a burst on a single member, so that the per-member
+	 * counters can be told apart.
+	 */
+	TEST_ASSERT_EQUAL(generate_test_burst(gen_pkt_burst, burst_size,
+			0, 1, 0, 0, 0), burst_size, "burst generation failed");
+
+	virtual_ethdev_add_mbufs_to_rx_queue(test_params->member_port_ids[0],
+			gen_pkt_burst, burst_size);
+
+	TEST_ASSERT_EQUAL(rte_eth_rx_burst(bonding_port_id, 0,
+			rx_pkt_burst, MAX_PKT_BURST), burst_size,
+			"rx burst failed");
+
+	count = rte_eth_xstats_get(bonding_port_id, xstats, total);
+	TEST_ASSERT_EQUAL(count, (unsigned int)total,
+			"Failed to get %d xstats, got %u", total, count);
+
+	/* Only the member that received the burst has a non-zero rx packet
+	 * count. Ids are the index into the table.
+	 */
+	for (i = 0; i < TEST_XSTATS_MEMBER_COUNT; i++) {
+		unsigned int base = basic + i * TEST_XSTATS_PER_MEMBER;
+		uint64_t rx_packets = xstats[base].value;
+
+		TEST_ASSERT_EQUAL(xstats[base].id, (uint64_t)base,
+				"xstat %u has id %"PRIu64, base, xstats[base].id);
+
+		if (i == 0)
+			TEST_ASSERT_EQUAL(rx_packets, (uint64_t)burst_size,
+					"Member %u rx packets is %"PRIu64", expected %d",
+					test_params->member_port_ids[i],
+					rx_packets, burst_size);
+		else
+			TEST_ASSERT_EQUAL(rx_packets, 0,
+					"Member %u rx packets is %"PRIu64", expected 0",
+					test_params->member_port_ids[i], rx_packets);
+	}
+
+	/* Reset clears the underlying member statistics. */
+	TEST_ASSERT_SUCCESS(rte_eth_xstats_reset(bonding_port_id),
+			"Failed to reset xstats");
+
+	count = rte_eth_xstats_get(bonding_port_id, xstats, total);
+	TEST_ASSERT_EQUAL(count, (unsigned int)total,
+			"Failed to get %d xstats after reset, got %u",
+			total, count);
+
+	for (i = basic; i < total; i++)
+		TEST_ASSERT_EQUAL(xstats[i].value, 0,
+				"xstat \"%s\" is %"PRIu64" after reset, expected 0",
+				names[i].name, xstats[i].value);
+
+	for (j = 0; j < burst_size; j++)
+		rte_pktmbuf_free(rx_pkt_burst[j]);
+
+	return remove_members_and_stop_bonding_device();
+}
+
 #define TEST_ROUNDROBIN_TX_BURST_MEMBER_COUNT (3)
 
 static int
@@ -5160,6 +5307,7 @@ static struct unit_test_suite link_bonding_test_suite  = {
 		TEST_CASE(test_set_bonding_port_initialization_mac_assignment),
 		TEST_CASE(test_status_interrupt),
 		TEST_CASE(test_adding_member_after_bonding_device_started),
+		TEST_CASE(test_xstats),
 		TEST_CASE(test_roundrobin_tx_burst),
 		TEST_CASE(test_roundrobin_tx_burst_member_tx_fail),
 		TEST_CASE(test_roundrobin_rx_burst_on_single_member),
-- 
2.53.0

