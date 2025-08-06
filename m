Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8737EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:43:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1CE64065C;
	Wed,  6 Aug 2025 23:42:30 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 649104064F
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:29 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so186544f8f.3
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516549;
 x=1755121349; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=iBnFt9ksqvG2lD1vYWEOrx6A4vLOmf8SEoGKe38VIzeMRrLvJ+HzCebc71JVl7xWxK
 9P1VFhZ3rCQ46eQvVsFSKiWTCLZFi/fK1YS86AlBFQ3c2SCFxlcDWyie/VkIW+zxhntl
 8npyFj9FRKSSNmhOmcOjMMHHNEqsESQ4jT/PL+XLNJ62H/VFnQKo2HIsFcipPhUzjLtB
 +GLQTJW4Y10UKhu1sK60vlnUAgnOkMmqHUzPWZkz6AQDoBdr6YRyFFPrt2240xcMSa+d
 djZQHIPk0iaaaRlqkKtn712Zq1xQPyrbHWKKONhSyZ2qv1hKD1eg5ztPBcQclMxoGS3L
 BZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516549; x=1755121349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=UzakpeGV8p7I0r9iYKney2ZYAbPcUs5kcXqB5oF/l1b0OCPel3kz7mozPNI0+JSAC7
 qO8+/7Rm9FcU/nTNYzHXUA7GKGQJfty9DV3fZP64sMkyJO3lc2TnYjr11OfOqr335ndg
 DDnMWsZgNnS/uaHbzIV/OPexl1AmaNdhwegLyxlzxXjAE/s5IG7R7+wadvmcffZf6hHr
 8kJntfDOdx7t6loHnYnTxrlG+oeU1UnCL9QB2QaRDmJJR5CPG58KNlUSJzIOY5Lvs+g1
 J/teIr6k8j+UZVongXzHIiAOfbxcLIJV4OfQoA+19Jw4oTXk6m8svqBkL08RHL/BwmEn
 4eVg==
X-Gm-Message-State: AOJu0Yxywj/GLNaChE+NCYyC12Xz7k8Mknro1rz7SAxkZsURTrv6TQFk
 Sq+E3oj00BH9ABcYnNyq3Q7pHo5Bcii+xx8KHr8qrZas7fjkN6Vdk80fy8sRAN2fulX8LczLyc5
 x/FfR
X-Gm-Gg: ASbGnct49ATsq+FW/djbbu8whyoYh7XKEfGMiV57vGR+0kDe2W2FhIiHG5THg9rK2ud
 /ORtRr7U/f8ysd4WDCCEOq/f+X+5uJBEGZtVf/C8qfw3NzVgPeLwqEw3CV1Fz81APDEoL1Z62Zo
 tM0rUGJj6+4ZbAaIC4kG1w41GGcbJ1eBQgrhnmSaeV1Jyp/64Ch0jMwL83S25gWoZf/wmHtOCiC
 7iB8uCUPxt1oA5ZwEVyNYsisgCx+qMLPAtWzgDi32SYwTz633K6CyPM/Bdn++BGGhkQiZiK1j9Q
 Ufp09W9trewc+JU+TrMyvxbHYCbVFyq/DGVp/0fJUlbnQ7ij8yCwKvwrYstKT5hkbnsHqe4QNnC
 +D/4ZAXz1BuCy4RfnVdFA8A/X4lm6lpyz/hkXPEXFLMCHAfQfFuYuZnrtd+UOgBVApqjU+Lp7
X-Google-Smtp-Source: AGHT+IFPV82nLzVY9rBC/m0D6btrU/lHDTICjwa6gRLTW/jkcFX+8Q8CKRwvROr7put2FHO7YxdPPg==
X-Received: by 2002:a5d:5f56:0:b0:3b7:7563:9d59 with SMTP id
 ffacd0b85a97d-3b8f49447f9mr3082501f8f.57.1754516548931; 
 Wed, 06 Aug 2025 14:42:28 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 07/13] net/ring: add new devarg to create vdev from
 existing ring
Date: Wed,  6 Aug 2025 14:40:36 -0700
Message-ID: <20250806214200.193029-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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

Need ability to allow process like dumpcap to make a ring ethdev
with a pre-existing ring. Do this via devargs so it can work
with hotplug.

It looked like the API rte_eth_from_ring() would work for this,
but it doesn't do the right thing. That API makes new vdev but
names the ring based on the parameter.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 966c64d9a5..a43ff20ecc 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -23,9 +23,12 @@
 #define ETH_RING_INTERNAL_ARG		"internal"
 #define ETH_RING_INTERNAL_ARG_MAX_LEN	19 /* "0x..16chars..\0" */
 
+#define ETH_RING_RING_ARG		"ring"
+
 static const char *valid_arguments[] = {
 	ETH_RING_NUMA_NODE_ACTION_ARG,
 	ETH_RING_INTERNAL_ARG,
+	ETH_RING_RING_ARG,
 	NULL
 };
 
@@ -693,6 +696,20 @@ parse_internal_args(const char *key __rte_unused, const char *value,
 	return 0;
 }
 
+static int
+parse_ring_arg(const char *key __rte_unused, const char *value, void *data)
+{
+	struct rte_ring **rp = data;
+
+	*rp = rte_ring_lookup(value);
+	if (*rp == NULL) {
+		PMD_LOG(ERR, "ring '%s' not found", value);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 rte_pmd_ring_probe(struct rte_vdev_device *dev)
 {
@@ -770,6 +787,20 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
 				&eth_dev);
 			if (ret >= 0)
 				ret = 0;
+		} else if (rte_kvargs_count(kvlist, ETH_RING_RING_ARG) == 1) {
+			struct rte_ring *rxtx[1] = { };
+
+			ret = rte_kvargs_process(kvlist, ETH_RING_RING_ARG, parse_ring_arg, rxtx);
+			if (ret < 0)
+				goto out_free;
+
+			/* Note: rte_eth_from_ring() does not do what is expected here! */
+			ret = do_eth_dev_ring_create(name, dev, rxtx, 1, rxtx, 1,
+						     rte_socket_id(), DEV_ATTACH, &eth_dev);
+			if (ret < 0)
+				goto out_free;
+
+			ret = 0;
 		} else {
 			ret = rte_kvargs_count(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG);
 			info = rte_zmalloc("struct node_action_list",
@@ -843,4 +874,5 @@ static struct rte_vdev_driver pmd_ring_drv = {
 RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv);
 RTE_PMD_REGISTER_ALIAS(net_ring, eth_ring);
 RTE_PMD_REGISTER_PARAM_STRING(net_ring,
+	ETH_RING_RING_ARG "=<string> "
 	ETH_RING_NUMA_NODE_ACTION_ARG "=name:node:action(ATTACH|CREATE)");
-- 
2.47.2

