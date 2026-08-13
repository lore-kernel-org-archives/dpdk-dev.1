Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1491C5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FD4D42E93;
	Thu, 13 Aug 2026 20:05:37 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id C259442E86
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:05:35 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-39266382df6so101323a91.3
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644335;
 x=1787249135; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=33e0emZkbFecAB6/dA7WwWCzGUtXjsK/j4Vwk2aFIts=;
 b=BfjbA16e7ICQEy8RD7l87PXLnewRwXyOsouhw2OredLNAWknyk6Jxn3JbK5d2kc+Lb
 vBNqllCwRuMjr8LjhULBZPvZA+9W4dytmSlICenBLWR/Ifgny2huUTkXHoVFIq/WHqRj
 m6CX/HWWLRj7qWzhtthijBmo/FsLdYZkQAGvf7bz/fQB30RVXwlm3mGxFsbdt3PqjdB/
 23uZS6HwgKinBG0YU+R0S+ens3fi3YyJo/GVS8wFprCgP01Yo0TXX9BTMUVdnd8FROaa
 +0UlGKtsvKBGqeFYzk9EiDN9MKIkae3jGNIsT8W0r4g2Leb2INQ4tfi+EGI8L17XOObI
 iY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644335; x=1787249135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=33e0emZkbFecAB6/dA7WwWCzGUtXjsK/j4Vwk2aFIts=;
 b=R9RUBxgo98VHR14qHXBUvl9RITUmMJ/IpI7WQJKm78/KeeTGju7cyIVtI56l+NBRZ+
 cFvNwJvycYN6YkYtWbiYFNBH7v30Ry8/fTJ1Ma6yYTFv3wrUzTOe5ddkxoK6gyEBxZFY
 swt4MA5NjCG4bVFxQchhmx0v2HZ7RIiNkB/P/tD/KaTi+AY3LXU81G1iCE8caRBmLThh
 PWSVBJu9BFOcRQUPrfBPlnEPUMFtfK7PS06r0jz3bbMyqelluPvzl2GM65I6yjDg0e8S
 ZhOtssMn6Jr2We+AVv6Qx/3nxt2/zRG48W6zh61Hrkx3v+IamBhjQxgrykAMP6CuU27X
 g8uA==
X-Gm-Message-State: AOJu0YyXEqH6zxH/L6v7Je5GhSwCnX0XNeFlrVWbtqElcf32nw8ROFS/
 5ZOyJCA/5538mMWcjpmf/+6q0rWOQMSNIewypXqh5X8ooxkMU8sxtzjG71AlHRyx6PH9aExVHLT
 3NNhG
X-Gm-Gg: AR+sD10HNPYroFoQa3/7glXtpFjAcIiAcM/G+b/E3B6e5vhfCLoerUPGL/ROitjOeOS
 lYm6WhpR2OEp9/pDSKNfsCCW+EgoIeqWFKtienUxO4MKc2MUD09paw0JiLJiHSLXEI36JAvo/n9
 X6DjWpa9I3SY/vQtj7JIxVsnzQY/2kJJVLgBRYOxj2x19yGSpE6zND3Q/uK8uZm5o9u9RzX77vZ
 LGAlzWvLzxXEVNTEBvpyoDEwpEHVPALnbAky1cAL23xkFKUtqS/EHqZvb+RVRxxV6IsaU+LfL7U
 PQMvX1d9PVegFc428aga/yworXt/wa7xbmenrlAdnCFjBKHixxeVYLjmo5njxEwSDhJSKAWgQmk
 swjvR12hLKeVSzizTEIkYt5QmzMDxQN63PvBI+bMDxGyu+dbJW6sboni2U4QLMokv6NiC0qzCCk
 LDHEsyY5JvTmW/ZH+6SZ8HLvT1Fq6S08bOg0Ibiit7OYktKsNbJvugfwQC0F/sMZ0B9OHjvySZD
 XsdXF/PpecBcOQt8TzRHik=
X-Received: by 2002:a17:90a:d647:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-3931e04a995mr9589654a91.8.1786644334856; 
 Thu, 13 Aug 2026 11:05:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:05:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 16/16] test/pmd_ring: test per-queue xstats
Date: Thu, 13 Aug 2026 10:55:15 -0700
Message-ID: <20260813180402.622784-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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
index cb08dcf1d9..e7682906df 100644
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
+#define QSTATS_NB_RINGS RTE_MAX(QSTATS_NB_RXQ, QSTATS_NB_TXQ)
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

