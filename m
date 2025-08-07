Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E81C87FDA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1976540687;
	Thu,  7 Aug 2025 19:35:02 +0200 (CEST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 454CF4067E
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:35:01 +0200 (CEST)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so11749335e9.1
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588101;
 x=1755192901; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=aRUZALHWs0PZtTNioOlow/bQAnYdagqWD98QrB2euB4Y7p3NikyZMnnlzqXM9Ayv1a
 FR9+Goms8jpPc01qhDzneTgN8CSch6id4E1BrVrpISgq3c+2cpwf/LNYjkEYLLuw7FFT
 sP+AXGkSGsym2h4vJ+W2Z7LrrqMjakDOgNuVYoEUuRsDokCY0bMUf1y+Md2MkmUGMVS7
 Ead5LIHNXIXjPhDqDqDMkCabwoahgXskN7b5yeXmEufksBYx1lKc670S/mD1csDWU4nC
 DD5d6HooiNelRsTIgqm0Q080wA4br5BfDz49/aVFp7nvsY7XBwUxxUR8l7KGCiMCL97q
 sr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588101; x=1755192901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=qGmw9Qd+xfz50aRUha9b3bVG6mjrf90d/287hHvamYQupEs/e7ntWq0BhSXWeTl2Va
 nlags3xZ6bwf6hNDAc1qV+7U+FtI2cpVemQ34UWNZ4stRghXFVmJ2aJeL1Uwf7/gdJak
 O9p5TYQPscwRy7TI4yq9lFmyvJz5k1gKVSby90R9SsxqzUYdwnpJbjoeOnrTYfJ27xeU
 Lunm5sBz426H/CM0fjr7WKNKc86eoGv+jA9jbHRjZmWnEyFRvGgMVh/ACXR1A2MAMQZT
 i8edusQahYeFGKpCsLthcbptDL/cuwnZRrB/r1tXa8nT1Z1328sd0pje934G1OqU4eG5
 yvqw==
X-Gm-Message-State: AOJu0YwAQgUsxvc875G+kDkFqR4q7DQg+rKtisxyv/T7bEwEVirG7FYD
 a2LdrRKdI1I/gAPwggX7ZXsQeZxMyJP9hchcD868L8X0sSSA43ui3BwCHBJ7UyhJ/Q2/pOLv+T9
 d2mxw
X-Gm-Gg: ASbGncs6uN6N3GMAry+glUUmpCXUvciKJ+P8DWkzKmFBjZtBnQ1I/bGRfnM0n03idw+
 eNzraLgmUf8CFXPv9QOnV081P+tnHN4O5uBsjqRO7WzJyZVVqCDpwfEz7n5lAOilR/rC3j7Mey5
 QDuP76RvX2n1QynnYIHCfe50h9ZitE8fkrKV5y9gKkD7EAbLmKTH9OitP1pmZP4dGs0RBH5QA9P
 567k+jQjQQKQLNccHYE0BycOFWs3p+HxR+SR2Nc7BS5Feb2XVjT4KXfJFpLFLQZJwpRJf0EB4xA
 /C26cUSQhx3N2M1l2spfa2mvNNlw+6ge52ZR9fGJC1mR8+8OGSNg1hqSaHJlpgmK53Ti3HMVcqo
 2sqZIEiK41iE7vKbR80ANRI6gd2POzKix+4SqZdd7upF6BcFH0dbPXxX1b9KnVvp1Niz0ZqEvQP
 fpwYpETTI=
X-Google-Smtp-Source: AGHT+IEX77cMQ7NZGTbAQugk+oQJmaxTk1XbPYLuf4nRzMgdJ6ydF4f+llxG6GH08W5UmAoOBMrS4A==
X-Received: by 2002:a05:600c:3b8a:b0:456:f9f:657 with SMTP id
 5b1f17b1804b1-459f0261f59mr28376885e9.27.1754588100791; 
 Thu, 07 Aug 2025 10:35:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:35:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v10 07/14] net/ring: add new devarg to create vdev from
 existing ring
Date: Thu,  7 Aug 2025 10:33:21 -0700
Message-ID: <20250807173437.11442-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

