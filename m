Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A7C53214
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9935040616;
	Fri, 20 Feb 2026 06:04:26 +0100 (CET)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by mails.dpdk.org (Postfix) with ESMTP id 58B0740655
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:04:21 +0100 (CET)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cb5138df1aso171985085a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771563861;
 x=1772168661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4b23B6SnlWqkiDUZMz81fRy0A7mA0B6xTLcIFNKEBE=;
 b=rBAdxT3/5gbvRNlDqle+nGDWE6s2EiJLfM+wK04nWuF4t+JgzMaAHvFmWfVhLQG6kE
 akmvpTRQ+5Hjnx38TxTZ0PXXJcouzTCyct2LLWo/C14y1s+eeJQkbj4fVuEtIWq3/y8n
 c+1TVAz/dqyPKz1ZjeZR5/UeX4oSgxritFtjlBSmqRV/0LOr9Oqc/ZGzkr57jDnjo4Zh
 0aYZ84mowdIccwYT/A9Er/6664Sic9OanYibSyeyBBI9EHX6matWwCnlFfJt55W/91oR
 4gBFZdpcgR+0sijTp12rrVHTphthQ43GEV0LZK/SoQ4eWsC3J2A1KTqOZMLWrFdxSoZP
 BCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771563861; x=1772168661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J4b23B6SnlWqkiDUZMz81fRy0A7mA0B6xTLcIFNKEBE=;
 b=R1A2yGdP1TginAdsQOSoziNvWX3aKKLqlxuvedXWBIUdyZXBPe6I+v+Crtl+R153LL
 WbdA+w3oZvwQOl0FHcdzgU8hxlHdMIXX9+qc8n6p+PEARywlWkkt5QwBzZnRjqV2pGU8
 3j7yfz6qmwWIP/8WPl5+uDB1RSt417uvgCQquOaRC6NDgjmYabNVGr/XkM47wENjlVdp
 nM0TRyFP1h/+UbC798f1Nw47nezt77ihzafo8M5PNp7Po7IAyBW1QVZkBE+x5EOO/FVX
 tyr/NsmUy19w6Tzo91PUn9/h59byoBJzlG10Aic0nfb44zGqOhx1Tm3eq03KZWTBrvHv
 W3KQ==
X-Gm-Message-State: AOJu0YxHIMppDaoogrJ4IW1NSXr84BkOjYCv0FoHDuJUz8yrRLFzsgdx
 PKgUXXo/wuk7KcM7Xsj5Ozr2UUhftOfsC+QhidI7ZdrXX8HsRZSqT+Lyzuaf+B7Y4fhEP2rTfP7
 oJdNK
X-Gm-Gg: AZuq6aK7sBd/oyFpOAnoJvvoL5BVs/Rn1voierN5BVDuu97YODvT7UxYlk0q7BVMujt
 QR6KSZNI9ijtYWj7RM6KxxJT3dCQDeb4hxLFC9fGdsarfc3bp1y2HpHGV9sibbT3OOob9XOY/ZU
 XoZjGX7dKUxQ0dAtcVcXtjLpqPNpL4qcxdNdtsNj6v6cpV+Z+wDBDNtarIe7lfiIdj45ledfaPg
 4xdhrsQX8eGE7bEcQ4chZFoKM5BuzgB1zsu95XI4EhuVXdQCJvc30+3siCIejCAVFn881MDjxb8
 sJ6bOUxNDwCi8D9juaAiC+7G3QSEcQxa0UolSY1YoGTtY2gMpOYzYwWdRZov1ZseNua1ytkr7cu
 GCnWAQtfKmNxEbI83PgHOF/jh8CUSd5onx9vY6YMn9lIM0hxEvNYM33r1D/nAfQiREL9/MgjYSw
 jjEB2gA+lLYIsglpc6olmzAPsEkwk0iOpruHa9GPRG3xgZ+VCU4NayR1Jjvca7ORCUnq+fS6i+
X-Received: by 2002:a05:620a:31a7:b0:8ca:4014:6151 with SMTP id
 af79cd13be357-8cb4c00d09fmr2452497585a.54.1771563860667; 
 Thu, 19 Feb 2026 21:04:20 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b0f38dbsm2289278685a.21.2026.02.19.21.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:04:20 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH v3 07/10] net/tap: fix resource leaks in secondary process
 probe
Date: Thu, 19 Feb 2026 21:02:09 -0800
Message-ID: <20260220050409.1571022-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220050409.1571022-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220050409.1571022-1-stephen@networkplumber.org>
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

