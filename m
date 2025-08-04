Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB208C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF48E40A7D;
	Mon,  4 Aug 2025 18:31:02 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 60924406BC
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:31:00 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-459d40d16bdso10298345e9.0
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325060;
 x=1754929860; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=YL/hKXcY+ozf3fZoUz7Rk1UMynMlss+22fEFkQM3xoq4kPvptQkWS2cbTz83HTuvGv
 3VrD2AZ9DKJqlTKCXKACZ5bpy+6rnCrFJgS60VPcizMlNQWpzoqOxOlPQWdCYPOmoRyw
 PI1SP5ZxStqq2o/7gZwK4lfGbxm64SDgrfuWS6A8xIMXqVT2PYHllTa6HNYnKL+LgKK9
 jYgZKq60B6WVFk6xSNhywwkONXXmGZsLpj/8wzJST+VYMwKArICJkSXCIVYX7fbT6c1y
 o7E7MogMu+cxhSha/qOOeTvyJNjVixVZ9iCcffjtu0Da8ayn+lOTQsPXKlPrPycauX4O
 8m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325060; x=1754929860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=jf/G3wdVJInh+y7DO3s7bubyMCXMQpQajwyvJ36Ii2zEzIDuNSGVUuBT9elpvgi6+e
 Jy2zd3mO+nNaw4vqY11W5FG8QnerGXdaKZrShtVLozjgF1tG/XG9vf62asqB2OS47ecS
 M0vS3BZ3DAFZW+klh5VPWdb0nAm1SeTucMXkogPy+r62J2gksSSy8p/anvUujuXq5A9G
 6+/dFWcIOs7VHLv5/J/Y5+d7djB04GCcdHMQo+3ydzieI0cFCa7YoGod38faqY3NqgzE
 UPKxRmjB80YVGqBho5fafnuaWkeSK1jccb650UbuQLkaf9zs45YqRdXNpEfJnBNspzvU
 oStA==
X-Gm-Message-State: AOJu0YxNdhmmD1408V/CvGpKtzezJYVvYPOsXEoYZHw08HRqt7MRs+0X
 35FyZol688oK8xOu2UlGY16dzsQGXDWKx6YVx1ZnkZTn+RYn1CUlVSrrOsqvglWJBuxL/oLRYdw
 0JuHV
X-Gm-Gg: ASbGncsE3o6uc1iDJY2A/cRlXPa3k7tS6ygvSsBcVbUPR7zNAPl/7y9S6CDUgbtUU7a
 3tW8WmsMnIl+vc6bnKC8+8hpGSg6gAigLXfwQ23SapCLrByBgrxGXeZm/xQAksAJ/h3/yXyuxse
 tPWY9pnk9LL9wM1oUNddllPqn6JYXJ5Y8XCaw1/Ru3Tjl+oXuEkACW4GUCSEGaBWyuEAcL4l+le
 Q4RItKEvLklz2zIywI83sK3XE0mwdsvBw47W/blHNUW/YPz9nKZf3f4AwTdIA9bFsC5vTzqx17V
 ha1HQpDL/CsxIs7RT413Fvs9VwL8L7XghBu0NlNnhJJszosjr8B7tnKU+0KMal+Faee02GNYtmh
 9oNekKFL7P0FMt0rbyREH46ir23fN/bEFHTG3FnNBMIOUVdaYCN8zChRpqc+e6SDeYBE7bfiyeb
 QclEIUT+hsuCGOffprkw==
X-Google-Smtp-Source: AGHT+IFb6fNmytLtWNmJXcsegKxBCCvULjzigOvKm/l1tgkbKBfwd3V1GLYSPNtWRkZudhO3MFXVAA==
X-Received: by 2002:a05:600c:4ecd:b0:459:e048:af42 with SMTP id
 5b1f17b1804b1-459e048af80mr7807325e9.24.1754325059983; 
 Mon, 04 Aug 2025 09:30:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 07/13] net/ring: add new devarg to create vdev from
 existing ring
Date: Mon,  4 Aug 2025 09:27:38 -0700
Message-ID: <20250804163039.138959-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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

