Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E606FC369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA7340E15;
	Sat, 12 Apr 2025 01:49:48 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0BCF940DDD
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:44 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-225477548e1so26160715ad.0
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415383;
 x=1745020183; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VS1sP22iQEF9tt4nXOSm+gjTUJD4AtP0jkCIK2t5Fc=;
 b=0xwpox7AbD9oBrh8kmfhpr7alCLi0JQXKDBaD4lCjZTn3kYetZPDdmbSsM4o9BAzdT
 T2TucQ0VVnFBZmy3cn5dzhVrFB8h3ZiuvJMI39diL3Lw+zKW/gY+7USbu4B/qzqIjyVw
 RIKKMWujy+AE99wwg7qYVejj8C8L31J6bNU0Up4+6p9erGkM+IFltWyNDdTmGqYh+Y4a
 b+5Pskb+w4yVqocj1m31c/gl8pV9Ljmv1Kldl6x9EOe9uXHH90CnXtNgYkw2yjixCZXX
 fNNgQZ6kNBASVH8HLOgj1LmfGJnzOwgcEc/ZubTqBMz341aUJVdMHpwOPi3nVTIfHCnq
 Q8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415383; x=1745020183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VS1sP22iQEF9tt4nXOSm+gjTUJD4AtP0jkCIK2t5Fc=;
 b=fr/5ifkTgACcwMyA0REV4rubw/ivBkjgUcYiBjM7+VEKyrHvdWD/NYIxXif6RBRAFx
 ddf1+P2ALEDg0GZTzd5ky2T3Bzpi7r9Rbl4+iwd/tbhOW79jsKf67qutVtHLmi9B9wcK
 lstCuRYsahj64YZjdKvWZ9KcErOSf0NoIft23BDv55f54GrGc1nMi/2k5cGxuqnyUGOB
 eQqd75U2N8rzyPhPjw58yrHYM/cnq2f7pYqtxBMg/Pr9UhasfjO+h00jOpvIawvK1hTG
 10K1mFqndFkCrYxyx1Aop7y9z/dMUyWmI/OjecOqPIPXOPJEfYx480EfLmoswg1Xs9Nv
 b+4A==
X-Gm-Message-State: AOJu0YxWrxI2MnklGmDCSszvrW5a9mZNjtYhIe06YaX1O96YhCvedBRG
 7DomXcg2VHsfh45BCNbw3Eod1ADWtKvrZXqrcA0kSb3qajRPZjQxBmiQr2sQBDM6BFfHtG95pUC
 9
X-Gm-Gg: ASbGncv2AqbkquSTR3yC6X2/9sXLdgczjSWNDxENBl3UVA5SOKaZkahoPJx+JUfZxc1
 q48Q/3oD0w725+NBOh2mXQhJzww1QVwfllvoygqeqNeXkpU57rxy+jMQYRsNUQg+fyzFQpVdogX
 iz2joukV3F+q9PS9qs6I3Y5SnGwKIoR6GmikIN/qFQ1/eTtxezAX55txFQSeL3ONiRuZ58UPFRv
 yRGZ3KXkJqHqQdoBVQGSIwf4m1lk3m+fD5hOMdx4wPdwmWzV7l37T1AQSyyymPMc4linkiuIsBw
 X1aZtaZ5slt/E3+SeqwRruiuB/u5wrEO6gLVyrk+iLhxRV3gTAbnmRpt+pVGKvtNO+pocd36VSZ
 sTZ02J5lK1u1w00as
X-Google-Smtp-Source: AGHT+IEneHqzXoyFkejVx6lWET0gtAp8ADoLj4zwRKQbhFS9CC4k5psZlt0jy+OxRlkyLFU5WzTgEg==
X-Received: by 2002:a17:902:f78a:b0:224:1eab:97b5 with SMTP id
 d9443c01a7336-22bea49530dmr71225025ad.1.1744415383043; 
 Fri, 11 Apr 2025 16:49:43 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC 05/13] net/ring: add argument to attach existing ring
Date: Fri, 11 Apr 2025 16:44:42 -0700
Message-ID: <20250411234927.114568-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

The API rte_eth_from_ring() doesn't do this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ring/rte_eth_ring.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 966c64d9a5..94a739a925 100644
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
@@ -770,6 +787,18 @@ rte_pmd_ring_probe(struct rte_vdev_device *dev)
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
 		} else {
 			ret = rte_kvargs_count(kvlist, ETH_RING_NUMA_NODE_ACTION_ARG);
 			info = rte_zmalloc("struct node_action_list",
@@ -843,4 +872,5 @@ static struct rte_vdev_driver pmd_ring_drv = {
 RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv);
 RTE_PMD_REGISTER_ALIAS(net_ring, eth_ring);
 RTE_PMD_REGISTER_PARAM_STRING(net_ring,
+	ETH_RING_RING_ARG "=<string> "
 	ETH_RING_NUMA_NODE_ACTION_ARG "=name:node:action(ATTACH|CREATE)");
-- 
2.47.2

