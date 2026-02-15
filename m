Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67318E63F08
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Feb 2026 19:54:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85D6340666;
	Sun, 15 Feb 2026 20:54:08 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 4E9F840662
 for <dev@dpdk.org>; Sun, 15 Feb 2026 20:54:06 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so19585725e9.0
 for <dev@dpdk.org>; Sun, 15 Feb 2026 11:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771185246;
 x=1771790046; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEsCmc25z2wCozFEO4p1jD7mpxzwJ6xSOlKrGB4iLN4=;
 b=GnIxPOMaz6xY9fMdItYv86udxsiwmkJ4YHYTpQAAc1lfUDGNGiEUr+KQClLdjPd9g7
 DGeVdWu5k/H3NRM+coJDygRR2jqPJ0p4HOouEvgal2K5ACBuGgeRpp9yWbp0+BpsTKsB
 QQm8iupE8Mb5z1Ocl9eAwgrxeBE44SWmm0wEHraERavME5YslqK28VtbJlu/09UOnnHw
 lNCN2suOgF/ZP6aOeX/ZIi9wejJhmgBVvV38rPhMASFm2KC6D4Cl8MTV7ko6haxRyDj7
 IClU90K3aukYCSSbRX+DOBhe2JqVeUa/u8tMLwaICx96l/tp52paXy+samSEG7QxigGl
 /6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771185246; x=1771790046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NEsCmc25z2wCozFEO4p1jD7mpxzwJ6xSOlKrGB4iLN4=;
 b=Baq2qqEY8UOlt5vuhxo1WcwFgDtUT9y89GcjuKGcE9RaxAxvYatphbUq6OoEeDynq4
 iCu3kKs3T5bVmBBdu/EMJTG+SSGZJFSdgPlgW0mnxN6vP5alNuOh10+aSSxHLl6QgpOf
 I9tgZsadeaUtJN3lIlR6MUXyz+8SRWAUP7q9ktrGMMHlGYSgovM/RvmiLVsKL3oZ4JNb
 Yks/f4QVp6kgsCEs3FCzihJn3yDIGNxIa8Eisii8Du1cUg1PLH7+ZIakKvj6OBRtMofq
 bdaJ1oYc/crTfkMr2Mz5lg+gnK/M9lQ8q2FzAjBhmjjZRK4PJ9mrYu2s+5MN3UZrha5p
 P6Yg==
X-Gm-Message-State: AOJu0YwCTfCR51exkGndyTbkjv3OUeH3L/JKr5SkQdORliEwtwCza2m9
 lwLaA9fU+fBZnyAB1tUf9P9CptfAcHJycV/JMLMzZw2L0/PxdvlvCSj1/l5vVtQtA0nuIn1J30H
 QPLE3P/k=
X-Gm-Gg: AZuq6aKLq6ujkpsIbKT1A3XbaOgWPJ5O6Q9PPBXEmzuid5LCr9XdpOmNbuzDlCsg+f+
 R4VjKS2zIJUCj47ne3unbhVJEtws4CX3KvZ1VDtPi+19AvIegxdqsQIrVvSH/Vc0zEjNpkJyw14
 M8PsYJcU7tVCVhVcjVADhw641cDd4EKLZI23psxZepgEQYnnyJNxV69MREgfH9VK9xgyzIhfppm
 /9sM406WnZeMuiUtmjRgTB89VU1WQ+0l/rmzW6ORNQGrtKmBWsY7A/Uci3s+cQDHfpY+IY3HJWE
 4HmR8QhE6w3CMvcadUulUHA7N9h1g0twEMCDx2+R5QLUeTSg0GLzkd/h4MGQzewr2D00XVBy1dD
 1hjz7TecHJ0U9kiYLOdpYPVxOIvg0HEvaTFVqLX5/0zwu6XA60HRpVBIJ07BEYSwHcTgYNWSGRX
 SMoxTNI/rDpwmYXDgtmHeUR+z9IU+50R5aApljGzVvFHaGohnekXThTg5IP4F513HXP+hxn1OM
X-Received: by 2002:a05:600c:870b:b0:483:6f37:1b56 with SMTP id
 5b1f17b1804b1-48371051b15mr171161805e9.10.1771185245874; 
 Sun, 15 Feb 2026 11:54:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d99497asm526490415e9.6.2026.02.15.11.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 11:54:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Raslan Darawsheh <rasland@nvidia.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH 07/10] net/tap: fix resource leaks in secondary process probe
Date: Sun, 15 Feb 2026 11:52:25 -0800
Message-ID: <20260215195348.557945-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215195348.557945-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
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
index 0bc0e11e0b..251b05b27b 100644
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

