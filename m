Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28376C61DEB
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:27:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B689640615;
	Sun, 30 Aug 2026 22:27:16 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id DFEA740611
 for <dev@dpdk.org>; Sun, 30 Aug 2026 22:27:15 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3964e76d0f4so2844719a91.3
 for <dev@dpdk.org>; Sun, 30 Aug 2026 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788121635;
 x=1788726435; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTUHMQ2mPnXCvb5O5ut7DXEjhzWs9/WdfkHywkdspo8=;
 b=e5rnH8l8E5+trHaIQIvx4IbxkRthcBd458BvgRp1f7+FETzuJ8deBF7jvBaUZJxycB
 xytaI33I+RCOsA1fBhLSGgc+OceZH4QY1Cpt/CSJe+yCe3OWeURTyEIIzyIeEw5S08r2
 kCrcxUVLkHBgATKwlVkTR4cR0wN+Q2yeCHb4/pj1yKR0dBd4/UOxaqNoywIMokfKtv+T
 +3wLyKmRXOmcbekxoPpCpptLPze8wgdyxWwKXYXA1ifyVve9X4j1zQZnz/L5uQ6E26AT
 ixQymeWHb/p5sCIODShxY2aorp3/JnLHcJGDaH7k4LdzHf++uU1z7E98dWpKA1moB99I
 3llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788121635; x=1788726435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mTUHMQ2mPnXCvb5O5ut7DXEjhzWs9/WdfkHywkdspo8=;
 b=JfgDuHjdYY0jIlUHIr1feHZrfF261voKES3ableb0fWF0R9OvtekfuTM0w2Srs1cw3
 UMKODn/AqV8As8CZMqbGvk81AjgsvDiHhuD3Kgsa7noz0NmURhmcKIMlqssnp+evHKA2
 nrDJJOsZbr+9xQjkNPLItpzwIUs1hDUP2HcGdJZizdZ3dxg5toB43ByyVuko3sAMNID3
 FE0N0VBpuz7upG9M8Wp4SDr2KvK1MSlGwFpNn1zN6igRVJykzZqOQzpoNrASGXoUcL82
 joYGz6QrWdCgxBskMX7w6lPzDGUWOvbNZTK0prRGz1yETyMGELJ+EXnfdddKw5U3WhUG
 kagg==
X-Gm-Message-State: AFuF++mMFIa5cqxaiHjgilfWCiLkBgcu8FlBwDlKh04yxxQybxRJSNkX
 T4NzIJw/SuVrU3Vnev2qvOdue2+AGuyjxEGsTcqU8+LNtCX+qPF2xpg8IjnMe9kANrE8WCDxxED
 qyFZ0
X-Gm-Gg: AYBFou1Pg/5GxHpVy6jU0cJMKXBW6kzeQa5f43p7jKKIi1IoosV7FNzWe8niZX5P2AB
 WJoI0elzXiZYucag0PNL7ghrB2D3gbQXfbPkwKRVRsk0Ohhx2YGKTUXKQaYAliaAye93VfinKMy
 8j+QxttGAgRS2vUaqsQ72Jo7M140ignqKUbvQ1WjKtSxHgLxiN5KsScd7ylAX5/zKyPaFG9ojp3
 uCJnIkLfc6X091FZgm4/1hAiCLCyM9gt/rr3OUAJTU6xqB4Y5kRUJP2qOy5fCg6K+2ovBkfUSJV
 MR8M/niMAdrUcZfBRYFjzam5aRpd4aAjm2oo3BttCItlAwZu8ezB6DjjyJUXMmKleaZzDtshkQx
 DkD3aO7Vi2jgJB7Akw9ZDsuRoDi0SbY9vmFCQLk6kYfnELhHVc2jg9aXdtRSwJXZPfFL9jeZnby
 /oUOZqwbiIDAZSSNC/HUGKoX7JVYvz5rC8nI4P0XN0mZm1dXsr4QkNWYsfiznpn54XAPOeyWZAC
 Gxmg+QNhl1EFo7luyHBbiR4FVs=
X-Received: by 2002:a17:90b:1d05:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-396d0ff519cmr34175755a91.14.1788121635016; 
 Sun, 30 Aug 2026 13:27:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd5c34sm17683165a91.8.2026.08.30.13.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:27:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>
Subject: [PATCH 7/8] test/bonding: add extended statistics test
Date: Sun, 30 Aug 2026 13:23:49 -0700
Message-ID: <20260830202636.760014-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830202636.760014-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260830202636.760014-1-stephen@networkplumber.org>
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

