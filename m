Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A0BC5ACD3
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:07:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 398AB4066F;
	Fri, 20 Feb 2026 18:06:33 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id 716F7402EB
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:26 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-506c00df428so20536071cf.3
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607186;
 x=1772211986; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4b23B6SnlWqkiDUZMz81fRy0A7mA0B6xTLcIFNKEBE=;
 b=nLKwQRubvznafdxq61ctuaV8lgxLzzLMozgYrA8rpd/mZ4OxlE2gfPe5ghrIwv2qv5
 Hqx7Qw84qfO+on55HnGtKvOaUdD3fBi4tHCtDReta2fmaxBvGj5XPhvZ0noiVexk3uL6
 VnM7ZR1G5UCFxvkCUcfFhKxWlcxzd0rxjTTCcg49giuyFpDQ84t2RxQy/qSOu8GsIsgh
 3f4feOeuujp2yvEoRqD568yQAWKAvKcwmNvTSry5RKrru1p//tD72Lhb4WqdqPe6nv/l
 6qv0puEvu7wYInkRBeGAij9UJFwXql49g4zc9xwZS8xdMPZpPab79uzDmU4cwqRY3FMI
 Jz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607186; x=1772211986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J4b23B6SnlWqkiDUZMz81fRy0A7mA0B6xTLcIFNKEBE=;
 b=MScdwKgS7A/aj0Od9m/fHiPn8gEdLY/W4SB00RBtO5RJuMnJlpm92cBblTCrHKwlXZ
 +KfiUoGuG7l/vD7af5yNJ3rnXDZ9mS6AIrckqtQAoGelJ2r7U23zAQp1j8ZXx/e4S2b8
 A6du9o3/eXcPq0sKYLAuQo2rXWNJlgR38ed1iODOU/wz01WsBsMRkyHPtAonardjAERL
 DvSPWCAcrxh+2QxuDtaSYUQhpIT/YQ/CcR7F5WIM/cggr+QDZeSmBFzAeGQWqPgoZdlU
 tQXImEhfdlkpLN7kuSLVbg7q90AQvYnaXE32E0JL1qlQl56uApQgYHwtWQ3pNqmDzEsz
 QMyA==
X-Gm-Message-State: AOJu0Yxpy0JcAjZWLzsJSfDfYGUYxrx+qY91PDrkWDTri6yCOZQZPN4B
 zx1vuO32syi9/KXr/Afecs3kT87ETPmegyMFAyJZDeiXxetN5shhyvX8wk8SIpHV8/pY42REhYg
 e0YW8
X-Gm-Gg: AZuq6aLRRY7WSLlnYk267orLNH2MEYrI0/jYoYKYpnOg/e056acj7+efOZpvKSgpj2E
 E8KTXYLG6UbrtAGL1A3tz1P/FGxsgrwEOWqCFWzek/9eSJK9xGwiCcmooAj9kSC3GIq9+jsZPFI
 v0WoT0sL3hSwRnqR0J9HLU+0ok2vY3dqZTJjMD9JGzVcjTSVQ4HgASqk7XQmNCW4uQuKUkZyWjO
 n3SPb6DD3nYj7TAqfitVVGsKOugwQX4faNJUZAFgZhfsC/sREoC0QvBNxS8cBl+CoA6Ww0pQki+
 GM2rqUsDIBDc+mvk21NpXui65sOb2U5VpZULZe4Gg1VvBMQdjTDjVv18DUyAA1RURayn78p7cRC
 GegrIs8fnLT8gdP0bpd7DoQV1xvLS+dZJL8JkA1eVNcKuiBkXa0rttf0Z4J49aQEn+3AdKAMXu5
 cOaU2YiS9IjimHXEqp/SN3LVFjdcDdc9OliZSuI0sR5RRPbo3WJV52jTONFnx3Aw==
X-Received: by 2002:a05:622a:4a:b0:506:be2c:a96a with SMTP id
 d75a77b69052e-5070bbd0688mr7747981cf.17.1771607185563; 
 Fri, 20 Feb 2026 09:06:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v4 06/10] net/tap: fix resource leaks in secondary process
 probe
Date: Fri, 20 Feb 2026 09:02:06 -0800
Message-ID: <20260220170614.75560-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
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

