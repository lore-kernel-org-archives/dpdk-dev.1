Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EADC7115B
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 17:41:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC7E941140;
	Wed, 18 Jun 2025 19:41:11 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 70A4C40F1A
 for <dev@dpdk.org>; Wed, 18 Jun 2025 19:41:10 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-234dbbc4899so107918335ad.2
 for <dev@dpdk.org>; Wed, 18 Jun 2025 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1750268469; x=1750873269; darn=dpdk.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=afuATXqCKUYoS+LlKL3sKgZ0Kik8j4VQjaawfGTclLM=;
 b=MrH2w5IqvznCRTy9uXy8w2bbH91mJJ70rAnhkNYCmUh8yKMWFhZPp5aQIGQv7wSlqI
 4LzSRNWIeTeRNOBpv5WhVP0BNcCTbK+wVtSG7I7c5W6u/jhSTdSypwbTH8KwBXv6X7Vz
 vYY3WxFNjqs2FrdtEXithvGoIB9fi7b0n4LhUq81t90ODa/QWMGzmOfqsw1DoMHMIFVb
 Ezonnuzby5bebpfV2PpCaD8434VnHRmsBvAytFvcbqyT3L55M7XiKXtWRjitEuwhVPOW
 Di0Lj3+uDu24zmAW35MN15Y2w8QomNw3K++WGVjQDfVq3lKXY1kU4KqF2LtywLz7Sc9w
 YLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750268469; x=1750873269;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afuATXqCKUYoS+LlKL3sKgZ0Kik8j4VQjaawfGTclLM=;
 b=JfPDbUG904aI5zLVrUfzk/eOR9m8Ahhz5u3TGX/wxY3MWSa9AJ1s0lmBgc3RPqNgzH
 /syg5Yswg95tMZcK6UuPyzr9RHWHadiUpNqacg5yDmLyJEl1d7UXFtSUzvd7TOIqQxkf
 rAnvngcHOdOF9O/YZejJuVzgMZ2yoY+KxvbX8XD+OuQ9HpbMrRRuB+4sVErRXRmFXeHi
 iTuQBfvjfSbJ5eHDzUAg9uzI/m1PK0oVAKRanQ5ZKD/Y2x38ZKw90eE78OWQoqc742mU
 HuvzUJAnp9kABLE306/HzlwKlNIch3jPoQVm1iOwr3VM5qrASIQtqjvhg281ZCqxij08
 bxQA==
X-Gm-Message-State: AOJu0Yz1Jt9b0/gFxHiSPeXqkqj1lrp6/bdeQV1e+DNlFPNkrPRf4c5f
 sb6x9sl5yjD6om9fszr64NTKX2m4QkK4KVVDhpXWPAjASl4pq8CGLbeufWiujyWAOYaGd5gTJ+o
 38KEWQ+8xG4DMXlLti4q3nKIqrQ==
X-Google-Smtp-Source: AGHT+IFMZFvi86n564OFYVwuZglVuh73zb3CZWXzx/Ssnmalyd7uMLgDUaDVjGgvFE7GmlxzqL6tDopCzDPJrO34xQ==
X-Received: from plty5.prod.google.com ([2002:a17:902:8645:b0:231:def0:d268])
 (user=shivajikant job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f611:b0:234:e3b7:5ce0 with SMTP id
 d9443c01a7336-2366b40a02bmr267432795ad.47.1750268469414; 
 Wed, 18 Jun 2025 10:41:09 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:41:03 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250618174103.1345466-1-shivajikant@google.com>
Subject: [PATCH] net/af_xdp: add rx/tx queue support for af_xdp
From: Shivaji Kant <shivajikant@google.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Cc: dev@dpdk.org, Shivaji Kant <shivajikant@google.com>, 
 Joshua Washington <joshwash@google.com>
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

Driver like GVE do support rx/tx queue configuration
rather than combined queue. Enable AF_XDP vdev to use
rx/tx queue configuration instead of combined queue
configuration if available.

Signed-off-by: Shivaji Kant <shivajikant@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
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
index 05115150a7..6899b6b165 100644
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
+	/* For dirvers with rx/tx queue configured */
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
2.50.0.rc2.701.gf1e915cc24-goog

