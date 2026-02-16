Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282FE83841
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 23:05:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C589740679;
	Tue, 17 Feb 2026 00:04:56 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 73008402EE
 for <dev@dpdk.org>; Tue, 17 Feb 2026 00:04:55 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43767807da6so2546788f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 15:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771283095;
 x=1771887895; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4b23B6SnlWqkiDUZMz81fRy0A7mA0B6xTLcIFNKEBE=;
 b=aZIDwkFVQiOUUIM7ANFiInc2nBAA92AeUttOyXGUdWN2DGnFhQkmR6JOSafVX9CB/q
 DdNB0tP1ZNl5gE/l4a+hDonXxjSkg8jf9S6hlBlBt99Dpv3RqF3/XrIzGTxuj6uoTOMi
 fHWhkWq/ZpWpvHzTdwf5vW5egfUmq2StGMg1G4aRedrpvlSB3V5+4uQGllj0omYQCG1w
 vw8Z2LRSOdTaf94Col/m1LYU026X54fHquCxf1lcXHoc9Ixtxxtnd1nf9aAsbMla+Tjh
 eDH+sW/dZBb8WfHfxZkgysXYMoUhHj2/mHMJ0iITCuVW4NCsG2LI74wifWET8tKkYiiW
 3WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771283095; x=1771887895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J4b23B6SnlWqkiDUZMz81fRy0A7mA0B6xTLcIFNKEBE=;
 b=k2F3JUwMtWCZMutGiRTmYwlzxL8kIoMiHzZDQ8P0DeZZ8XK3W9R2boHCPHZnddbgmA
 uwmaaB4oXtex+HF0liyLmUMC+ZJim3RA7jplG0Sb75gkOudSs/V9ole1lkJMDZjVIF2A
 3wWRJTqGcQpU9LdNoMXmR5UF5I3ZDcD3joQ1LIBQuTDk+S1Pkr5lecJVj/0vo5uyhFJQ
 IxO6bBNn21c6ctGE3au9mqUDP4mq7LIqU4PIlqOhZgZO4kc0vV+6Ljnws33x8XWz0dQP
 hJRdSEXjBF3r8sez8t/skIvB9+08uSh3+T6ipf9VDob/6kBAyUAi77cemweuVUB86NqE
 N0Jg==
X-Gm-Message-State: AOJu0Yy0DjYAv7NV+dzVHUhfZQ/dMr7q9LN7a0S4WleBDqONhkgHhtID
 Hwk4d3ipxpVhS7/rbyEKGrn79j1aPlAXKF/gKTfzZvyscpgge1emIPP6jPMDsp0EFi6gv2nEHuA
 V4Q9WyKo=
X-Gm-Gg: AZuq6aLeYZqe093Pgs206UrDaR4HMn7ziYvRw78qQSWYxXHUridVgIMG8jqgLZ6ts9F
 YnTBlNzJdyRBh7bUOj2k2HVvmrOQPW2MPHWoYtdo958/62uQfPDw1T9XrpynU50n0ghH8JqHoDi
 cpgq0+XIB/aNPubBLZzR/I8ztRvAXp/MZ+rOiyxgQ+04IWmvzmeandg22xzEKBGL4+Z9I0kjvoF
 7v3x+Dfk+/4qilRe8ZFgwvYUV0KXG2SVvyUpBuIJRIAgahx4/86s5HtgvsSLUq2yIaUcw/4DKYM
 nMPvWPCNuZw9kmRJ0Ohq78D8gOBBQvkdZifNZ2bznUieH5mv8nuZ8M3vVb4oYZQFb1wqkLdYbOy
 x4faP2GD2G6VJO0ErcqJawX5fhGJGDDJr7/EzoB7QLYFPu6ozxbfEC0Ppn+tXocIP2cXX3q6VJX
 /P4nAPfniQImgIbrjf5GTFKBBsSmZtcKCO2OEMMM6wn6Ebh+zQ5l0j4T5iB/3tyw==
X-Received: by 2002:a05:6000:22c1:b0:432:586f:2a9d with SMTP id
 ffacd0b85a97d-4379790e8c4mr22377588f8f.32.1771283094963; 
 Mon, 16 Feb 2026 15:04:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm33158867f8f.28.2026.02.16.15.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 15:04:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v2 07/11] net/tap: fix resource leaks in secondary process
 probe
Date: Mon, 16 Feb 2026 15:02:31 -0800
Message-ID: <20260216230437.847578-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216230437.847578-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260216230437.847578-1-stephen@networkplumber.org>
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

Four error paths in the secondary-process branch of
rte_pmd_tap_probe() returned -1 without cleanup:

- primary process not alive: leaked eth_dev
- process_private malloc failure: leaked eth_dev
- tap_mp_attach_queues failure: leaked eth_dev and process_private
- rte_mp_action_register failure: leaked eth_dev and process_private

Add secondary_fail and secondary_fail_pp labels to free
process_private and release the ethdev port.

Bugzilla ID: 1881
Fixes: c9aa56edec8e ("net/tap: access primary process queues from secondary")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 9b38d1f50b..974b45ecad 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2502,31 +2502,38 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
 		eth_dev->tx_pkt_burst = pmd_tx_burst;
 		if (!rte_eal_primary_proc_alive(NULL)) {
 			TAP_LOG(ERR, "Primary process is missing");
-			return -1;
+			goto secondary_fail;
 		}
 		eth_dev->process_private = malloc(sizeof(struct pmd_process_private));
 		if (eth_dev->process_private == NULL) {
 			TAP_LOG(ERR,
 				"Failed to alloc memory for process private");
-			return -1;
+			goto secondary_fail;
 		}
 		memset(eth_dev->process_private, 0, sizeof(struct pmd_process_private));
 
 		ret = tap_mp_attach_queues(name, eth_dev);
 		if (ret != 0)
-			return -1;
+			goto secondary_fail_pp;
 
 		if (!tap_devices_count) {
 			ret = rte_mp_action_register(TAP_MP_REQ_START_RXTX, tap_mp_req_start_rxtx);
 			if (ret < 0 && rte_errno != ENOTSUP) {
 				TAP_LOG(ERR, "tap: Failed to register IPC callback: %s",
 					strerror(rte_errno));
-				return -1;
+				goto secondary_fail_pp;
 			}
 		}
 		tap_devices_count++;
 		rte_eth_dev_probing_finish(eth_dev);
 		return 0;
+
+secondary_fail_pp:
+		free(eth_dev->process_private);
+		eth_dev->process_private = NULL;
+secondary_fail:
+		rte_eth_dev_release_port(eth_dev);
+		return -1;
 	}
 
 	/* use tap%d which causes kernel to choose next available */
-- 
2.51.0

