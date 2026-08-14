Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D88BC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:21:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51F274067C;
	Fri, 14 Aug 2026 22:21:20 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 01E4440395
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:21:18 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso1074315a12.0
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738878;
 x=1787343678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dF9i+55tKc/SovdqOqxuOBvl5cFWvNyAIAbUsbC5AmI=;
 b=ELRnUht5+dWZUrRMOLBkxpEWR2E5Nr7wAaXaXfiRbSETuHo0SHOLxReeX61rSdKvDQ
 yUrvh1e8cUlcSv/cAdhsqufDkxeyxfvqMbrqfCUVyU98GaBrXEveHm/3O5TpaHR9kS0l
 X4LzSjEcTUJJlefBQjCFcMWNTo+PgRq7NUpaWdCAHF049FwNys7qKVeSnGIep3f5dZzD
 e1N5swrk0YFG8HtoICtdQ2clQuE+atee6/ZeVZ5WKG6TWAJjwGp06Svpb5XGAk3UOHGe
 nydbxUrcBIguCIDr2CzCEV1TUFKz4XTdEC0q1q0AYkZvI/VdScetaaHcp88LqkNaz7kA
 2+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738878; x=1787343678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dF9i+55tKc/SovdqOqxuOBvl5cFWvNyAIAbUsbC5AmI=;
 b=imHDn4CFOBKJvVLM8F62FAMQkShGeIlM9f8PLoc2MSxR9zh6uQYUoE1jvf2Z+ZrPxu
 sCMbzHDjCrAjpT6xVDioQPprlWJnesNcIuvyGdwHeX6OLDwPFazQNkbbsT0cl93f52/v
 y3MTpR5QFSLeQC3+kVVT/PL03de8h9aPyMvjhrWyz3el1iVr+hLu1Nv1qGzqXE7CE6tR
 7oEszXAu01z8hg0nYPeTbdLLuuAG7wVE2YF29l+cj8cx7vGQ+zqX+9UglrXx35kwdm+t
 7kRhS5D9z8KOuIjqpsIJjV7naHeVFfaBIodPnkVaLHwGtGRnnRiHeja7S4sCle6OupQ9
 oCQA==
X-Gm-Message-State: AOJu0YxOoTZL8kJKaR/sYbkUqVvJL09YmWr7yDWWZ5eMnVDF/LOFafg/
 jPEUNmlkiEXVllSD3yTxwnrC75ZYftqB4H/3xVwX1C/f3fjSDfZNzAZX1pPVUTpsY8PUhZvh4EL
 xe8SS
X-Gm-Gg: AR+sD13falC3oIZeweKoD7Xx8CGjaRZ0RmcTkTTSj9+sWx5imUeGGv/7BwyZ1LQqzSt
 ol5NE5Wopdi8XqNPIwPiSu7sNVae1K4xlfitxrJKni5hQ20oMOhqwMHeuHQ2Sy1+TCLdpkLWzDR
 tZdCpIHS9d/F4F1Mo1fQ4VsvkXLrz2kYW+uMR2PajJod+XDEIIe0siVlmJCttWzExkT8EYObPp7
 KTAFo9H5hTPqDA/syKh2cuy4L9t9mi+Vv+V8UeL0twNS2bZaiIw56IPL+a593b6V0RjhVT7Ba2w
 4BeF73Zuyu57C6yi2F67kGdWGXk6dOk7Hx55xrKAvvWItA6/jFFAPrTv11xGV9904K2+UUCQ1jF
 V9LPk/Ll6az2angvOdSFnyJWfyWZBvpuDNr+nBuCuLNI0mPXhjueE6KQtDojQ1yi2jyya4GfY4a
 gc9ZYwxvJwI45WqVx2qpAXi23lfEHXFXSiA0mZpe3CyPax2IOLhg+qTLJJlgPFnRYjy6S2EB8c6
 O+GsnNdvOkkGltvAnVPfjeB9zs=
X-Received: by 2002:a05:6a21:33a2:b0:3c4:3321:4fe8 with SMTP id
 adf61e73a8af0-3cc71be2ba0mr9162896637.14.1786738877981; 
 Fri, 14 Aug 2026 13:21:17 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:21:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 16/16] test/pmd_ring: test per-queue xstats
Date: Fri, 14 Aug 2026 12:46:12 -0700
Message-ID: <20260814194757.329424-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

Add a test that per-queue xstats are reported for every configured
queue, and only for those. Uses different Rx and Tx queue counts so
that each direction is checked independently.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_ring.c | 145 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/app/test/test_pmd_ring.c b/app/test/test_pmd_ring.c
index cb08dcf1d9..1f245f5ad5 100644
--- a/app/test/test_pmd_ring.c
+++ b/app/test/test_pmd_ring.c
@@ -4,7 +4,10 @@
 #include "test.h"
 #include <string.h>
 
+#include <inttypes.h>
+#include <stdbool.h>
 #include <stdio.h>
+#include <stdlib.h>
 
 #include <rte_eth_ring.h>
 #include <rte_ethdev.h>
@@ -557,6 +560,147 @@ test_ethdev_configure_ports(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Per-queue xstats are added by ethdev for all configured queues.
+ * Use a port with different Rx and Tx queue counts to check that each
+ * direction is reported independently.
+ */
+#define QSTATS_NB_RXQ 3
+#define QSTATS_NB_TXQ 5
+#define QSTATS_NB_RINGS 5 /* RTE_MAX(QSTATS_NB_RXQ, QSTATS_NB_TXQ) */
+
+static int
+test_queue_xstats(void)
+{
+	struct rte_ring *qrings[QSTATS_NB_RINGS] = { };
+	struct rte_eth_xstat_name *names = NULL;
+	struct rte_eth_xstat *xstats = NULL;
+	struct rte_eth_conf null_conf;
+	unsigned int i, nb_names, found;
+	char expected[RTE_ETH_XSTATS_NAME_SIZE];
+	int port = -1, nb_xstats, ret = -1;
+	uint16_t q;
+
+	for (q = 0; q < QSTATS_NB_RINGS; q++) {
+		char name[RTE_RING_NAMESIZE];
+
+		snprintf(name, sizeof(name), "RQ%u", q);
+		qrings[q] = rte_ring_create(name, RING_SIZE, SOCKET0,
+				RING_F_SP_ENQ | RING_F_SC_DEQ);
+		if (qrings[q] == NULL) {
+			printf("rte_ring_create %s failed\n", name);
+			goto out;
+		}
+	}
+
+	port = rte_eth_from_rings("net_ringq", qrings, QSTATS_NB_RXQ,
+			qrings, QSTATS_NB_TXQ, SOCKET0);
+	if (port < 0) {
+		printf("failed to create port\n");
+		goto out;
+	}
+
+	memset(&null_conf, 0, sizeof(null_conf));
+	if (rte_eth_dev_configure(port, QSTATS_NB_RXQ, QSTATS_NB_TXQ,
+			&null_conf) < 0) {
+		printf("configure failed\n");
+		goto out;
+	}
+
+	for (q = 0; q < QSTATS_NB_RXQ; q++) {
+		if (rte_eth_rx_queue_setup(port, q, RING_SIZE, SOCKET0,
+				NULL, mp) < 0) {
+			printf("Rx queue %u setup failed\n", q);
+			goto out;
+		}
+	}
+	for (q = 0; q < QSTATS_NB_TXQ; q++) {
+		if (rte_eth_tx_queue_setup(port, q, RING_SIZE, SOCKET0,
+				NULL) < 0) {
+			printf("Tx queue %u setup failed\n", q);
+			goto out;
+		}
+	}
+
+	nb_xstats = rte_eth_xstats_get_names(port, NULL, 0);
+	if (nb_xstats <= 0) {
+		printf("no xstats reported\n");
+		goto out;
+	}
+
+	names = calloc(nb_xstats, sizeof(*names));
+	xstats = calloc(nb_xstats, sizeof(*xstats));
+	if (names == NULL || xstats == NULL) {
+		printf("out of memory\n");
+		goto out;
+	}
+
+	nb_names = rte_eth_xstats_get_names(port, names, nb_xstats);
+	if (nb_names != (unsigned int)nb_xstats) {
+		printf("got %u names, expected %d\n", nb_names, nb_xstats);
+		goto out;
+	}
+
+	if (rte_eth_xstats_get(port, xstats, nb_xstats) != nb_xstats) {
+		printf("xstats count does not match names count\n");
+		goto out;
+	}
+
+	/* No traffic has passed, so every counter must still be zero. */
+	for (i = 0; i < (unsigned int)nb_xstats; i++) {
+		if (xstats[i].value != 0) {
+			printf("xstat '%s' is %"PRIu64", expected 0\n",
+					names[xstats[i].id].name, xstats[i].value);
+			goto out;
+		}
+	}
+
+	/* Every configured queue must have its counters, in both directions. */
+	for (q = 0; q < QSTATS_NB_RXQ + QSTATS_NB_TXQ; q++) {
+		bool rx = q < QSTATS_NB_RXQ;
+
+		snprintf(expected, sizeof(expected), "%s_q%u_packets",
+				rx ? "rx" : "tx", rx ? q : q - QSTATS_NB_RXQ);
+
+		for (i = 0, found = 0; i < nb_names; i++)
+			if (strcmp(names[i].name, expected) == 0)
+				found++;
+
+		if (found != 1) {
+			printf("expected one '%s', got %u\n", expected, found);
+			goto out;
+		}
+	}
+
+	/* Queues beyond the configured count must not be reported. */
+	snprintf(expected, sizeof(expected), "rx_q%u_packets", QSTATS_NB_RXQ);
+	for (i = 0; i < nb_names; i++) {
+		if (strcmp(names[i].name, expected) == 0) {
+			printf("unexpected stat '%s'\n", expected);
+			goto out;
+		}
+	}
+
+	snprintf(expected, sizeof(expected), "tx_q%u_packets", QSTATS_NB_TXQ);
+	for (i = 0; i < nb_names; i++) {
+		if (strcmp(names[i].name, expected) == 0) {
+			printf("unexpected stat '%s'\n", expected);
+			goto out;
+		}
+	}
+
+	ret = TEST_SUCCESS;
+out:
+	free(names);
+	free(xstats);
+	if (port >= 0)
+		rte_eth_dev_close(port);
+	for (q = 0; q < QSTATS_NB_RINGS; q++)
+		rte_ring_free(qrings[q]);
+
+	return ret;
+}
+
 static int
 test_get_stats_for_port(void)
 {
@@ -581,6 +725,7 @@ unit_test_suite test_pmd_ring_suite  = {
 		TEST_CASE(test_send_basic_packets),
 		TEST_CASE(test_get_stats_for_port),
 		TEST_CASE(test_stats_reset_for_port),
+		TEST_CASE(test_queue_xstats),
 		TEST_CASE(test_pmd_ring_pair_create_attach),
 		TEST_CASE(test_command_line_ring_port),
 		TEST_CASES_END()
-- 
2.53.0

