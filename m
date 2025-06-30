Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB80DC7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 08:51:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E20E4402E0;
	Mon, 30 Jun 2025 10:50:59 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 6D4CE4025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 10:50:58 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-235f6b829cfso13147245ad.2
 for <dev@dpdk.org>; Mon, 30 Jun 2025 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751273457; x=1751878257; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=evZ7Jul8OoIiH0BKNfcM95Y5nlYOfPHYCP6/0Nam4f4=;
 b=ejyMk+6jvZ84+rXfcyW0pIFrQQf3SaDjDVitWXPH/b/KSBZ9MU4DEPoolid/KFlH8F
 zARo+InrZzWwNgJ5TGPThyD2NNJ9KDb1IhEWLpGGu3/9cfSIhgT995y6JgE+Cs+nKglT
 zA4Aq99B2hwC7k+OGDRHgiBid76GpYc0cBz2uhYFdYFXY34PGi0P/G2P19dCYghIKVXR
 CCVmYZ3uuwNxjQlzQTcsa8bdZWz8jBLZdmoB+p81Hp0LGXrW3LjvnUvqUGpy+zKVdYZq
 MvioFEt/UTTelvK0sLIfvzKQesB3xNEnfSnPbgppEBugXLdd6LO7ZWqJWbQMSQR9UWOr
 rg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751273457; x=1751878257;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evZ7Jul8OoIiH0BKNfcM95Y5nlYOfPHYCP6/0Nam4f4=;
 b=vSL01RTI429Y9HZR4qZY4+Vz0GfpIyDe/VgcifxJHJvhruOkxRDbCSetwpnQDGVKj0
 j/kXbsOwhquzyK4NaTSKDs0D07+0iT4d3vnZUkZjbsJFY4Kk7HYCR7LSpDSiWQ+u9wur
 f9L81s4ctE2ss+HOYvyn21CJ7j7SQUKup9lWSkwXSeUq6p9C/Y6phLmxyc2594yyMt9H
 nhhEPsb7CsdeEZ5MEZBDk7fDEIdNDfGUaLTbHPzRMrGcxr8K1THODHOICNSareKfbU57
 t6Uanfv5TSmVoa3aI2sh97cEFncRUkXTluPBPhDcocRdp26ElSaKiFeDEFSH7ofwfp7W
 fP3A==
X-Gm-Message-State: AOJu0YzFsrvjTJEDdzeojaKaRngqpbRbQMLHK3mpEsKHxHnL3Gjp771/
 Uq0H0yUHO3aCQmyOB1gNYHa+mzWsVi/a8turQnUbenhTRHckW/lVd2a6kwq+yEt97t1c4WarqJB
 h7lH+JgtTg2uXA0fbf1iF/Tm9tA==
X-Google-Smtp-Source: AGHT+IHpAgGFhR6bXtGHbvhCE/Ki9kNLVH5AqAfuBvbV9ovMHh4UXaFGZS87nBFzZKo3nz53rbkrB4xzQd1w1OSJ3g==
X-Received: from pfbhx13.prod.google.com
 ([2002:a05:6a00:898d:b0:746:30f0:9b33])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:618f:b0:220:8373:355f with SMTP id
 adf61e73a8af0-220a180b26fmr20582225637.32.1751273457615; 
 Mon, 30 Jun 2025 01:50:57 -0700 (PDT)
Date: Mon, 30 Jun 2025 08:50:52 +0000
In-Reply-To: <20250618174103.1345466-1-shivajikant@google.com>
Mime-Version: 1.0
References: <20250618174103.1345466-1-shivajikant@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630085052.585867-1-shivajikant@google.com>
Subject: [PATCH v2] net/af_xdp: add rx/tx queue support for af_xdp
From: Shivaji Kant <shivajikant@google.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Shivaji Kant <shivajikant@google.com>, 
 Joshua Washington <joshwash@google.com>, Thomas Monjalon <thomas@monjalon.net>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

Drivers like GVE work with rx/tx queue configuration
rather than combined queue. Enable AF_XDP vdev to use
rx/tx queue configuration instead of combined queue
configuration if available.

Signed-off-by: Shivaji Kant <shivajikant@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>

---
Changes in v2:
- Rephrased the first sentence of the commit message for clarity.
- Corrected spelling error "dirvers" to "drivers" in code comment.
---
 .mailmap                            |  1 +
 drivers/net/af_xdp/rte_eth_af_xdp.c | 30 ++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/.mailmap b/.mailmap
index 8483d96ec5..c67caa7c9d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1423,6 +1423,7 @@ Shijith Thotton <sthotton@marvell.com> <shijith.thotton@caviumnetworks.com>
 Shiqi Liu <835703180@qq.com>
 Shiri Kuzin <shirik@nvidia.com> <shirik@mellanox.com>
 Shivah Shankar S <sshankarnara@marvell.com>
+Shivaji Kant <shivajikant@google.com>
 Shivanshu Shukla <shivanshu.shukla@intel.com>
 Shiweixian <shiweixian@huawei.com>
 Shiyang He <shiyangx.he@intel.com>
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 05115150a7..5f65850a27 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -168,7 +168,7 @@ struct pmd_internals {
 	int start_queue_idx;
 	int queue_cnt;
 	int max_queue_cnt;
-	int combined_queue_cnt;
+	int configured_queue_cnt;
 	bool shared_umem;
 	char prog_path[PATH_MAX];
 	bool custom_prog_configured;
@@ -2043,11 +2043,11 @@ parse_prog_arg(const char *key __rte_unused,
 
 static int
 xdp_get_channels_info(const char *if_name, int *max_queues,
-				int *combined_queues)
+				int *configured_queues)
 {
 	struct ethtool_channels channels;
 	struct ifreq ifr;
-	int fd, ret;
+	int fd, ret, rxtx_q_count;
 
 	fd = socket(AF_INET, SOCK_DGRAM, 0);
 	if (fd < 0)
@@ -2066,15 +2066,23 @@ xdp_get_channels_info(const char *if_name, int *max_queues,
 		}
 	}
 
-	if (channels.max_combined == 0 || errno == EOPNOTSUPP) {
+	/* For drivers with rx/tx queue configured */
+	rxtx_q_count = RTE_MIN(channels.rx_count, channels.tx_count);
+
+	if ((channels.max_combined == 0 && rxtx_q_count == 0) || errno == EOPNOTSUPP) {
 		/* If the device says it has no channels, then all traffic
 		 * is sent to a single stream, so max queues = 1.
 		 */
 		*max_queues = 1;
-		*combined_queues = 1;
-	} else {
+		*configured_queues = 1;
+	} else if (channels.max_combined > 0) {
 		*max_queues = channels.max_combined;
-		*combined_queues = channels.combined_count;
+		*configured_queues = channels.combined_count;
+		AF_XDP_LOG_LINE(INFO, "Using Combined queues configuration");
+	} else {
+		*max_queues = RTE_MIN(channels.max_rx, channels.max_tx);
+		*configured_queues = rxtx_q_count;
+		AF_XDP_LOG_LINE(INFO, "Using Rx/Tx queues configuration");
 	}
 
  out:
@@ -2215,15 +2223,15 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	strlcpy(internals->dp_path, dp_path, PATH_MAX);
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
-				  &internals->combined_queue_cnt)) {
+				  &internals->configured_queue_cnt)) {
 		AF_XDP_LOG_LINE(ERR, "Failed to get channel info of interface: %s",
 				if_name);
 		goto err_free_internals;
 	}
 
-	if (queue_cnt > internals->combined_queue_cnt) {
-		AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger than combined queue count %d.",
-				queue_cnt, internals->combined_queue_cnt);
+	if (queue_cnt > internals->configured_queue_cnt) {
+		AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger than configured queue count %d.",
+				queue_cnt, internals->configured_queue_cnt);
 		goto err_free_internals;
 	}
 
-- 
2.50.0.727.gbf7dc18ff4-goog

