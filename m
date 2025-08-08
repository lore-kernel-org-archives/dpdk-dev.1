Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BE0C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:59:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 072CE4069F;
	Fri,  8 Aug 2025 18:59:04 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 37FD440A71
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:59:03 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-459e72abdd2so13887245e9.2
 for <dev@dpdk.org>; Fri, 08 Aug 2025 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754672343;
 x=1755277143; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=CYaF2/NkcqTGKva9Phe2QnPvXF4Qqb0YXuHhdcYMXq6IzkOh2ENn9hl+ANaFj6vfLZ
 nuAkEq255feMbyMrVMV+TaU3nptPUx7A3ELFBujVRWils+n9SCb3Ne7hgZgY1C/H/Jia
 uKl3bqoA0n0BH6cz9FNttsCbzIwNa4XaiH9QY7y3/gesuDxjLpwkikUufNUPi0AUhU3Z
 smKllNZlMM6iVLz69DxMtcmjkQTQgb9ZeTstLA38WqmRJZa/wgr9VRIeaTtVSCGhc5JP
 mfNO2Cyo2bm4f+PYJ4gM+hI71i0XM1UouV1PXhmEUBNCvkuw/jydM4ua9e+ikPOQdOX+
 mGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672343; x=1755277143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=GQ/S8MZC8SQiNZDfRfSK6Kw9EGf3gb7qzotGa270cpV5cj6yJDWVI8Cou2VzNDHojR
 BiNkJ08z+aFojG9jGp1ePYxQAB2yp0a/KfmmTZ8VY38pgvp48lrvBI3QTr2zT+/oTruD
 dIuTzHWjHULMXJWkpuSx9nfZno0m3ZOqpbFA9C36UVzX6mOvg4T59BxrebmvE2795VYL
 J5ApgwnfO703/6RcEMssH2XVcvQucEGdI5GJSNYV4lKYOqUcuQj2ibJ0fUM8wNX+ZHAZ
 ZITxesQa2F+4NhzeUKxkpDt85y3dZAifVruQhw4Xv+EA3Ml7/GfXkCuI3Shox/BIt1q3
 +jvw==
X-Gm-Message-State: AOJu0Yw6rKP9IMspVAk/3IgROif2yV1rPUinZxAe41yOTFGn+kTcGTIf
 e2lCw6omuvk1AEyw5399dwjcLMA96hJOBxxTtZ1fOpSABE+ynbFND0Eco8xsDnMZ493A+COypSx
 P3l25
X-Gm-Gg: ASbGncs80bVgyU334Zw/0gRzHTgVntV0sJ9j5H9EMY80kHnFNMqeTJoAbRbMupCGTF5
 Z05Xj9gZ0ZQtAKvq/5Xrdyz9fNJ7UXaLz2foJyDAw7nhzVZHxZhZ3kNjbX19gViDsDSLK13etKj
 LNUtUqB+yN2hvE/b3pUU6AZL/cdwsrFUru7QOW6KdWERs/R6UcLUnMWxABEjZbsV8yK0qnvciiM
 hy99KD1PbelJJgYqDYTdErS3XcDts8we3jCLDgQAacBqJ9RxHii4CdipPgJvM+4OL9m1O6GVg5J
 rYENyM/1F/FIBGjrGWfXNaNlgxIww0Wtk4VngJ2p5bddZJ00bWOtWNfR5QYN0E2sO1W05jXatOQ
 lmFl5HOxEmzkLb9OkT4SEcBo3Y7pEsz6ZuvzOxZ792aVE2NAbQjvbh1IDdstf24mSP19RBlhJ
X-Google-Smtp-Source: AGHT+IFLmJ5EmbkWrrll/jdEYVFQMPqws0oxSnwamKjJS/sP9s8QyPAuOG2D7WT2i17UZPNB799HIg==
X-Received: by 2002:a05:6000:2507:b0:3b8:eb9f:a756 with SMTP id
 ffacd0b85a97d-3b90092cab1mr2938284f8f.11.1754672342800; 
 Fri, 08 Aug 2025 09:59:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ac115sm30997531f8f.12.2025.08.08.09.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 09:59:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v11 07/14] net/ring: add new devarg to create vdev from
 existing ring
Date: Fri,  8 Aug 2025 09:55:45 -0700
Message-ID: <20250808165843.39075-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808165843.39075-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250808165843.39075-1-stephen@networkplumber.org>
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

