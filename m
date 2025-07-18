Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA4C83F17
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:33:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0EEB40E22;
	Fri, 18 Jul 2025 18:32:54 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id D99E740E20
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:32:53 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e29616cc4fso222611285a.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856373;
 x=1753461173; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUZCv7JfSH1Pqlfrhim8mO7FN121qgtWdXLSeZz07nY=;
 b=BBvpika03UThTFwPD94QNnXCzFTKXEMUhsc8L6HAQZlA0LTjU6PWqct3BAnukULdcF
 +DSPrEsg184EF5OF3RzfdElVsoR2JY4rzYULI8HNN3QKRh2v6zZtp0dZiSQ/HVNCKMig
 AVKxe+hf/nEd1rhn/c7y/Ocn/x1oIYXkJ+q3C4pGSZe32N3EbiKF6wOW0nBA+9oV4Uu9
 y86eaGlKV3bCZjQ1ML5wXcbGuR09C02rRp6CmONeqEGG5Nm+ZD76cAh5FEcKM6rAKuXG
 UNoBhGU2CcUUSidxKksnoxEwf6iQ939TgpgSg1DdUwRtihlYDxMGtOGujyLbj6Z+SuFP
 kkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856373; x=1753461173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUZCv7JfSH1Pqlfrhim8mO7FN121qgtWdXLSeZz07nY=;
 b=brWcUAHBDfceLdieIm1Jq3wpoGPn32X1KhpVEK8cKGHU/v7drrmQqw9XxhAG7Rocxo
 xAhqjP+LR3Udp7tKh8oMnQJ8hAAIe+/sZIp3u/vXaSWJVnPeCs85ed5vkxycLF5NKLVn
 1FUbvYIQGSp3QuCA/OgSUA4Fmi4TShh6jou70waPtuSAvQ9jqJBQfO9+knbOnfrYer5F
 YFNj1hvgSLXqQbtUSMoB0YJaCsnVMz5mjaf5GFdbWA83BnhsIlx4Vu39D4Ohwr8bzBP8
 x0hTkDONBWptmAOs7V4MGnC2L/BVtxKUS+c+sNxzMq+QYNWheiqOli///LlFmRI8eHhO
 hb3g==
X-Gm-Message-State: AOJu0YyYPIwMtkkxdsvMegMJfxop0XbwArEjNGA/N06ahFMjw4xwO7xn
 Vs29WwzhLMrGny2e2srdrmFQlFTVYPstgwWTQIu0GUCHyHiYliM8buLrfk0GoSGs5MZKwa5/KX2
 3G2pT
X-Gm-Gg: ASbGncukvt0YrGB4kBbxh3Mk+c8V+VPc9IrCEtznTaSLrwkIKxoawJL1JirnCV0JCaE
 bgGFuSSg32qCAN/4VLW8s2wOf+LVfi7g0hWn6+SFFMbJ1cXYWxRLnnor0yg9DZ/xH1nNVuEHP+e
 gxgjwdVY84/AAQwYOiDPsr/aryRYacdOuNdi02O/0us3Tm4kefrXbAKqK7nR93sZYnWjjQ5NSQR
 YqzJp1m3YImzB/9mA1NMgw6bgnv6qH+nR2yz78S4Z7eipdGsJEuvT1W90ZNkYPc4CpDiOzgYBpd
 o07jGc3q9cwvQh3jiJR1skSSFuAI/trzQ1QcIb60Wsc4p7T0BaZYHOa04F8LgDvKubBqwHQDiK4
 Pxtt6fSKJ4X4sjCxWgaAYz6H/25+CAY3Vshv5tcHU/PP7yri2/2bCM4mSqSgqWLkloj8B5Neq
X-Google-Smtp-Source: AGHT+IHl3H0H+6/VZjKs5P0mUQZJslE3aFLCWOhwNaPGLdR7hBuPIky4QQVocWYF20iHlGfvdXnwiQ==
X-Received: by 2002:a05:620a:4113:b0:7e3:46da:9e2f with SMTP id
 af79cd13be357-7e346daa47bmr1068943485a.34.1752856372973; 
 Fri, 18 Jul 2025 09:32:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 05/13] net/ring: add new devarg to create vdev from
 existing ring
Date: Fri, 18 Jul 2025 09:28:22 -0700
Message-ID: <20250718163236.9870-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

