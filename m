Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B9C606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IGB5DGcp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F93C40671;
	Fri, 27 Nov 2026 22:08:17 +0100 (CET)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 33AD740616
 for <dev@dpdk.org>; Fri, 27 Nov 2026 22:08:14 +0100 (CET)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-ccca948203aso5905604a12.3
 for <dev@dpdk.org>; Fri, 27 Nov 2026 13:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795813693;
 x=1796418493; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zMachNB9Ya282Ulj3cgFinZ9gq2x+ModyLOmAepOS0=;
 b=IGB5DGcp503jM0QNAcRDwyxWd3OsjmN0qi18jVr5OJmiP/d2RrVi8RnRm4OrPyG03s
 k4LFc93atbgb5BoUuHB/WbMQJaqXZ6D1Y22R41l1iE2WNT0Ow7WJiVD7HlmgRAOEFk9F
 5vGLXikpRRkR/X9GNqQbQJFp18/USGAKCzVuAbVbwOzr6wJfnzYfCcutyUSPPcqVKoTC
 xFKw6zFYJvb5pQCknfz2XG0Sw4dC5S5k0XKmULBN4uvgFkLbFCN0+EhxXNoqrmFkdjYy
 4gwm19koSxuXvfg57rY1xy9lGm8lVJW+2kP25YLAPJrVDiP11fUd6O+8RZ6hXfsxXYBn
 ubFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795813693; x=1796418493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5zMachNB9Ya282Ulj3cgFinZ9gq2x+ModyLOmAepOS0=;
 b=CHyjQ1JUOllUYHvF1aZgHvni1bsQa1fzMIS+JT0/5AIQ8AkXzy0nVRcpNjgQvCOkEz
 9n3lYVAFlsIDo07lCS5e+R9YGTfpCryPd46+keFwd/ILYf6VCsEB7byRUATGcbjALIDx
 dz5Nc7zihBIwo45sbrzvCrf9Dn/nstlcMg+R4AmGHmB4FklKokTLXRhRIFQnEz+e+gTE
 Fv2dlUrr7w56IdFZRKjbaMoTvfSMPQSFtXlzVcj/+EOxBTZzirUpkwsYQXwBahoBoytg
 TGDX029+UpRzVROcwGyBOh0qFkgFt4TfSBMbtfkiuDTzhqS59S6N0UY3c3IN+Kkhqqup
 ktDQ==
X-Gm-Message-State: APuU4Z90Rs2bCseH7rW0Fyfh4udv9urUTLd8FCaL/N1KBm+smhr0jt2h
 nojayAdqyFjJ1+YmUoVcCQr5T81NFQ1KXX+wDMhj5lhUVl0uibFbG87MLxA6u57+ypQwEkZAiUL
 OZO41
X-Gm-Gg: AZFdTZdVlvNgYQ2njOC480DCjn2ZpC8Yd167zjty8twXcboAXTXKvdIxvCQbjlP28X9
 3FNR4D2DyF45Wd4YnWbDrJHt9HNObC6aBNcafhYvbKGWs/kMYA6Hrp1gdtJa0rOp8rhI6hhY07a
 jQdc6ABDOvBAI63MabZWFvKn5R957cd4cZ9QTF06EbgBSHueEqTbho4KUc0/IEBMSvHcGTrGJnG
 YN1wR1sCiSjFSexLTBTwKFmFpNvrhWVE/URh1SpdalgWKKS85mC7eiO0C6SUk8oQGswr0eo6xRN
 dFcZLfsOZi3t6RIAEY0vwUB8tEQFa2kpin+eayUJ79ypgiXl8gW1w9lGGU1nlNy1alN1qM9jPdv
 kOoEM0DdydAN6oqdxNKtcJ+jXQq7d5eSPjWtM+I3yTZjvU8naHhGRQmDbAKGPydraSMOnN3vQlg
 Gv5BX7T/+GanYhGOK6kAr8AcK9K/GIGkBaSC8oo28WwYOfwfR0PZOBJknM7vMeskG3gsmzLksK8
 9ERls9xshma6j0Rz3Kcwb/VptymMt+QmHQVjXEIPNkkQuCLkUt3ybeKS7taCe7SR8HmPV0ETzGq
 kPbOzhcNO7QRAbUz57Je2Vkzn3QARZf0qxsdjneDHhs2eez4ASCN9DewKK1ueRBUXejFEw==
X-Received: by 2002:a17:90b:390b:b0:3b4:1336:4f6c with SMTP id
 98e67ed59e1d1-3b41c7b6994mr24128233a91.2.1795813692435; 
 Fri, 27 Nov 2026 13:08:12 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm42457179a91.17.2026.11.27.13.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 13:08:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 3/6] pdump: validate queues before installing callbacks
Date: Fri, 27 Nov 2026 13:07:05 -0800
Message-ID: <20261127210806.318387-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127210806.318387-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
 <20261127210806.318387-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Check for hairpin queue before enabling queues to detect
errors before registering callbacks.

The other failure possible is running out of memory while adding a
callback. Remove the callbacks already installed for the request
when that happens, rather than leaving them referencing a ring
the client is about to free.

Fixes: cf5516696d77 ("ethdev: add hairpin queue")
Fixes: 278f945402c5 ("pdump: add new library for packet capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 177 +++++++++++++++++++++++++++++++-----------
 1 file changed, 130 insertions(+), 47 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index 56a12f96ca..b5b1c95b07 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -8,6 +8,7 @@
 #include <rte_alarm.h>
 #include <rte_mbuf.h>
 #include <rte_ethdev.h>
+#include <ethdev_driver.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memzone.h>
@@ -250,6 +251,64 @@ pdump_tx(uint16_t port, uint16_t queue,
 }
 
 
+/*
+ * Check all queues before changing any. Unusable queues are skipped
+ * when capturing all queues, but rejected if asked for explicitly.
+ */
+static int
+pdump_check_queues(uint16_t port, uint16_t queue, uint16_t end_q,
+		   bool rx, uint16_t operation)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[port];
+	bool all = queue == RTE_PDUMP_ALL_QUEUES;
+	const char *dir = rx ? "rx" : "tx";
+	uint16_t qid, count = 0;
+
+	qid = all ? 0 : queue;
+	for (; qid < end_q; qid++) {
+		const struct pdump_rxtx_cbs *cbs =
+			rx ? &rx_cbs[port][qid] : &tx_cbs[port][qid];
+
+		/* hairpin queues do not pass through rx/tx burst */
+		if (rx ? rte_eth_dev_is_rx_hairpin_queue(dev, qid) :
+			 rte_eth_dev_is_tx_hairpin_queue(dev, qid)) {
+			if (all)
+				continue;
+			PDUMP_LOG_LINE(ERR,
+				"cannot capture on hairpin %s queue port=%u queue=%u",
+				dir, port, qid);
+			return -EINVAL;
+		}
+
+		if (operation == ENABLE && cbs->cb != NULL) {
+			if (all)
+				continue;
+			PDUMP_LOG_LINE(ERR,
+				"%s callback for port=%u queue=%u, already exists",
+				dir, port, qid);
+			return -EEXIST;
+		}
+		if (operation == DISABLE && cbs->cb == NULL) {
+			if (all)
+				continue;
+			PDUMP_LOG_LINE(ERR,
+				"no existing %s callback for port=%u queue=%u",
+				dir, port, qid);
+			return -EINVAL;
+		}
+		++count;
+	}
+
+	/* Enabling nothing would capture nothing, silently */
+	if (count == 0 && operation == ENABLE) {
+		PDUMP_LOG_LINE(ERR, "no %s queue available on port=%u",
+			dir, port);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 pdump_register_rx_callbacks(enum pdump_version ver,
 			    uint16_t end_q, uint16_t port, uint16_t queue,
@@ -257,19 +316,20 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 			    struct rte_bpf *filter,
 			    uint16_t operation, uint32_t snaplen)
 {
+	struct rte_eth_dev *dev = &rte_eth_devices[port];
 	uint16_t qid;
 
 	qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
 	for (; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &rx_cbs[port][qid];
 
+		if (rte_eth_dev_is_rx_hairpin_queue(dev, qid))
+			continue;
+
+		if (operation == ENABLE ? cbs->cb != NULL : cbs->cb == NULL)
+			continue;
+
 		if (operation == ENABLE) {
-			if (cbs->cb) {
-				PDUMP_LOG_LINE(ERR,
-					"rx callback for port=%d queue=%d, already exists",
-					port, qid);
-				return -EEXIST;
-			}
 			cbs->use_count = 0;
 			cbs->ver = ver;
 			cbs->ring = ring;
@@ -281,8 +341,8 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 								pdump_rx, cbs);
 			if (cbs->cb == NULL) {
 				PDUMP_LOG_LINE(ERR,
-					"failed to add rx callback, errno=%d",
-					rte_errno);
+					"failed to add rx callback port=%u queue=%u: %s",
+					port, qid, rte_strerror(rte_errno));
 				return -rte_errno;
 			}
 
@@ -290,12 +350,6 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 		} else if (operation == DISABLE) {
 			int ret;
 
-			if (cbs->cb == NULL) {
-				PDUMP_LOG_LINE(ERR,
-					"no existing rx callback for port=%d queue=%d",
-					port, qid);
-				return -EINVAL;
-			}
 			ret = rte_eth_remove_rx_callback(port, qid, cbs->cb);
 			if (ret < 0) {
 				PDUMP_LOG_LINE(ERR,
@@ -318,20 +372,20 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 			    struct rte_bpf *filter,
 			    uint16_t operation, uint32_t snaplen)
 {
-
+	struct rte_eth_dev *dev = &rte_eth_devices[port];
 	uint16_t qid;
 
 	qid = (queue == RTE_PDUMP_ALL_QUEUES) ? 0 : queue;
 	for (; qid < end_q; qid++) {
 		struct pdump_rxtx_cbs *cbs = &tx_cbs[port][qid];
 
+		if (rte_eth_dev_is_tx_hairpin_queue(dev, qid))
+			continue;
+
+		if (operation == ENABLE ? cbs->cb != NULL : cbs->cb == NULL)
+			continue;
+
 		if (operation == ENABLE) {
-			if (cbs->cb) {
-				PDUMP_LOG_LINE(ERR,
-					"tx callback for port=%d queue=%d, already exists",
-					port, qid);
-				return -EEXIST;
-			}
 			cbs->use_count = 0;
 			cbs->ver = ver;
 			cbs->ring = ring;
@@ -343,20 +397,14 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 								cbs);
 			if (cbs->cb == NULL) {
 				PDUMP_LOG_LINE(ERR,
-					"failed to add tx callback, errno=%d",
-					rte_errno);
+					"failed to add tx callback port=%u queue=%u: %s",
+					port, qid, rte_strerror(rte_errno));
 				return -rte_errno;
 			}
 			memset(&pdump_stats->tx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
 			int ret;
 
-			if (cbs->cb == NULL) {
-				PDUMP_LOG_LINE(ERR,
-					"no existing tx callback for port=%d queue=%d",
-					port, qid);
-				return -EINVAL;
-			}
 			ret = rte_eth_remove_tx_callback(port, qid, cbs->cb);
 			if (ret < 0) {
 				PDUMP_LOG_LINE(ERR,
@@ -376,7 +424,8 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 static int
 set_pdump_rxtx_cbs(const struct pdump_request *p)
 {
-	uint16_t nb_rx_q = 0, nb_tx_q = 0, end_q, queue;
+	struct rte_eth_dev_info dev_info;
+	uint16_t nb_rx_q, nb_tx_q, queue;
 	uint16_t port;
 	int ret = 0;
 	struct rte_bpf *filter = NULL;
@@ -422,18 +471,15 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 		return -EINVAL;
 	}
 
-	/* validation if packet capture is for all queues */
-	if (queue == RTE_PDUMP_ALL_QUEUES) {
-		struct rte_eth_dev_info dev_info;
-
-		ret = rte_eth_dev_info_get(port, &dev_info);
-		if (ret != 0) {
-			PDUMP_LOG_LINE(ERR,
-				"Error during getting device (port %u) info: %s",
-				port, strerror(-ret));
-			return ret;
-		}
+	ret = rte_eth_dev_info_get(port, &dev_info);
+	if (ret != 0) {
+		PDUMP_LOG_LINE(ERR,
+			"Error during getting device (port %u) info: %s",
+			port, strerror(-ret));
+		return ret;
+	}
 
+	if (queue == RTE_PDUMP_ALL_QUEUES) {
 		nb_rx_q = dev_info.nb_rx_queues;
 		nb_tx_q = dev_info.nb_tx_queues;
 		if (nb_rx_q == 0 && flags & RTE_PDUMP_FLAG_RX) {
@@ -452,26 +498,63 @@ set_pdump_rxtx_cbs(const struct pdump_request *p)
 				"both tx&rx queues must be non zero");
 			return -EINVAL;
 		}
+	} else {
+		if (((flags & RTE_PDUMP_FLAG_RX) && queue >= dev_info.nb_rx_queues) ||
+		    ((flags & RTE_PDUMP_FLAG_TX) && queue >= dev_info.nb_tx_queues)) {
+			PDUMP_LOG_LINE(ERR,
+				"invalid queue %u for port %u", queue, port);
+			return -EINVAL;
+		}
+		nb_rx_q = nb_tx_q = queue + 1;
+	}
+
+	/* check all queues before changing any */
+	if (flags & RTE_PDUMP_FLAG_RX) {
+		ret = pdump_check_queues(port, queue, nb_rx_q, true, operation);
+		if (ret < 0)
+			return ret;
+	}
+	if (flags & RTE_PDUMP_FLAG_TX) {
+		ret = pdump_check_queues(port, queue, nb_tx_q, false, operation);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* register RX callback */
 	if (flags & RTE_PDUMP_FLAG_RX) {
-		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_rx_q : queue + 1;
-		ret = pdump_register_rx_callbacks(p->ver, end_q, port, queue,
+		ret = pdump_register_rx_callbacks(p->ver, nb_rx_q, port, queue,
 						  ring, mp, filter,
 						  operation, p->snaplen);
 		if (ret < 0)
-			return ret;
+			goto undo;
 	}
 
 	/* register TX callback */
 	if (flags & RTE_PDUMP_FLAG_TX) {
-		end_q = (queue == RTE_PDUMP_ALL_QUEUES) ? nb_tx_q : queue + 1;
-		ret = pdump_register_tx_callbacks(p->ver, end_q, port, queue,
+		ret = pdump_register_tx_callbacks(p->ver, nb_tx_q, port, queue,
 						  ring, mp, filter,
 						  operation, p->snaplen);
 		if (ret < 0)
-			return ret;
+			goto undo;
+	}
+
+	return 0;
+
+undo:
+	/*
+	 * Remove the callbacks already installed, they reference a ring the
+	 * client is about to free. Registration is called directly here
+	 * because the checks above reject this half enabled state.
+	 */
+	if (operation == ENABLE) {
+		if (flags & RTE_PDUMP_FLAG_RX)
+			pdump_register_rx_callbacks(p->ver, nb_rx_q, port, queue,
+						    ring, mp, filter,
+						    DISABLE, p->snaplen);
+		if (flags & RTE_PDUMP_FLAG_TX)
+			pdump_register_tx_callbacks(p->ver, nb_tx_q, port, queue,
+						    ring, mp, filter,
+						    DISABLE, p->snaplen);
 	}
 
 	return ret;
-- 
2.53.0

