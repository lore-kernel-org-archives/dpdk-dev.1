Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A12C636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 17:33:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AB524067E;
	Sun, 22 Feb 2026 18:32:47 +0100 (CET)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45]) by mails.dpdk.org (Postfix) with ESMTP id 4EA0540656
 for <dev@dpdk.org>; Sun, 22 Feb 2026 18:32:39 +0100 (CET)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-679501fac3cso1616215eaf.1
 for <dev@dpdk.org>; Sun, 22 Feb 2026 09:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771781558;
 x=1772386358; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhRoQzIaEqwo5+dcyyeMdVEeCfy+ySlCcFGxbJr/+Do=;
 b=VIwCNme+B2odPY+FH56XtZ2QocaN9Cm6G8Lwtj+GTvMH/WGQSe6qLDIC+wun9HPWbx
 NknZig2zTGYQGe/r4v9Hj8B63rdcxw/uXNOJzqwK0ijsvm7mr14oQhgXVr25HYtfdv0y
 O/1YmpMdED4u24MZOSiGYRcZN3jCUI2LiSOlR2BOtIJ1aR+euSw5IeW5iHJuuouOSO7A
 XHNGw1Kny982yiA0JWjfQg9oZAUWfAeWNSaDc6i/xd9DEMbhv0v/bcCAWCQExxaE5nst
 ku5TyKKn6EzAfuRkaaQw/2a/0to5B7ZeUxc97LFpZGIW9fYl1+GRa8GFcJDzjUiVschH
 lCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771781558; x=1772386358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MhRoQzIaEqwo5+dcyyeMdVEeCfy+ySlCcFGxbJr/+Do=;
 b=McyprkaEw1QW9oYPNzGU55Qa5ps4exDrisAhDxVHaYSa+S/y0p+syl3lc0X4XZf9Ok
 F1Uk3s2B4qNf7FzMRwlWHtH594d5LJSD21QR29RNvwa7t3U/0IyfaSsmtbv9goOPCafw
 tl7gQ/I3E9vnFKqfOI7LnpZxhP+D6QuljwmVGuaEzxJgXIdavPcSfIiiTu6MrULu9i/O
 nrKYCBWqh6DUeZEYm0KE0/s6QfjNrjseJ7OgiPgqR4+o888uuBOiU0B7i7basd/SbuQo
 15hRqdSLHOSQYGSfY9MUf7twqlsnAraKbQim0pHnC6QM7lJ2EryDsrZ+LIBoCRuj6wXG
 4YsQ==
X-Gm-Message-State: AOJu0YyiNXPlUaE0wO86CZjjU84ynDBg+npVCH56oyvINpKVKopPGa5h
 Gld45s1KhLWg9lJHQ2fQ4hez/ehuzhc71lLZ4NnPXAQtDj1iaNE9cjysMUyWK5LF27G8A7/puCf
 6c6DU
X-Gm-Gg: AZuq6aKPS0QWcqs2Zaa8ohfCTFgMh0JBTG90qXy7DBRwbP7cRds/QdqlrmwuzifTHHz
 oYxqGrr4cheUFnM2F16J1uLAmmE9ZV378IZoPpbDkQFDUOZWrpi3MiVGgkoKTu+UaY+1Db2ALdL
 XVc1iYqh5zMFCS0DWB66RazyOaEJ+KuoOm4GIE4ZBl7BAxlElxGSAJckviNNvlIxTR4cgQrcvyj
 lKE/wAxyfOyl2z/S1LrnsRm5sdzTK1MT6+NBF9n2s9QtjmTmbsUC1HKam+BHtcl1u8el7P9N52J
 dwvGDk+mVOWZJasCj/TbZhVX76hZygNojs69TwvUipXpJ/SW0tRiSNGJZhLkyW4juW169yNtwAX
 lZf7NDig1apTukOESdwQ371k4WoMNFGkzVIJjQPC1UL1lE6SKuEV3YkpZqE51Ipk+3wnIpt6eBp
 yUcx5j8qKOY07bnXS7ZPMkfnuUSCDruY089zdoWJVci+odOnDauxRy7SSyVWuqpw==
X-Received: by 2002:a05:6820:2d03:b0:660:edc3:7bf2 with SMTP id
 006d021491bc7-679c4516a35mr4030147eaf.64.1771781558569; 
 Sun, 22 Feb 2026 09:32:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157d2d7922sm5608972fac.12.2026.02.22.09.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 09:32:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v5 09/19] net/tap: fix resource leaks in secondary process
 probe
Date: Sun, 22 Feb 2026 09:30:44 -0800
Message-ID: <20260222173225.522754-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260222173225.522754-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260222173225.522754-1-stephen@networkplumber.org>
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
index acae3b6d76..2707d63f29 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2491,31 +2491,38 @@ rte_pmd_tap_probe(struct rte_vdev_device *dev)
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

