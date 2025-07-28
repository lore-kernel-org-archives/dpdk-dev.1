Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC36EC83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5B8040A6D;
	Tue, 29 Jul 2025 00:10:08 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 640BA40A6E
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:06 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e62a1cbf82so308003285a.2
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740606;
 x=1754345406; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=BELm9alJyfXKwsapvARj8ubmVpdKByEwL8l05J0HMZckRL3VM6ErBlzcTiY6mtPy5T
 HroyQpYyhsAU+1eiMheUcyy30y8gz3JSawLJjjm98SpDbm7HOhTtLbt2x17vSWhJIaov
 Pcvjq1e4SFeLAuv8kPRtmWBJ3j1B2uGPAz4AmOs1i3B0SIarFjYRlzWTPDKQsD77XilA
 mwKORSd2C3pHqd6KJeC6nGpIq/0icuOsXDAgU41jXpFnhkdpP5Yr8oSzLSuJ5MgYQcbI
 OOJIG0b7iLrksELntjPVQv9xnJlDIPyUjBkTzcszWMeoZ7Ca20tevEOGR9WRjYut6PAg
 zgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740606; x=1754345406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=fCFztYl+UzaMJuSLUL8/4cfzMHztA6gCOMRFThKfV/K/ZiTBVHUo+XcassLrDce7so
 tfbnqwKXNmNEH3CcwvtW4hDlhq25GvaiBWwEj5dV0L2TLi6wSPg/0MvdVuvaYkr/tFbH
 1LYlFgSPpZtM1JS+XOcm0VdEfGn9tAsit2qOO3F9XLfHgqXtcYlwkGW27KH4MU1cpjSs
 g0afqZNuhbsl4FDQcZ5/pJZESdHuxbFeIR25gD2kadzlhEwoMoeDJ3UaAeJeKgeiXT1R
 XWB1YEIfMhDf7+5MBdupXBzcUgFr6WkZ7yE5R/3cZ+qas59bLm4jXA+X0EnsLi63bUsE
 4p7g==
X-Gm-Message-State: AOJu0YzZoTs2Fg5mJd7oCZrrPkPoJzVGZ4SCp4Y62bsMIIfnoONbEy3S
 tGmuBgE6fGoMJPGIW3eCuTwZv3YTbnEYmuEEAXyPMdfrogg373sd9VII5xhwf+8NP3sBfI/7s4x
 DQfQX
X-Gm-Gg: ASbGnctxKg1UNApBP8l1dg0//laCRJXoQqdYa38qlyRlqQowaODm+Oy6p5gt6TrtnMi
 1hGPFHCXAXNiKKLbp3nPlsKS5yEeSgcoP+Rxg+4RvsCQXtrGWYBjuoODIBW7wkXPlikpPvNIn3H
 V4Oc8sdJv4TyHbUgSBM7PyltKQadBCiOtmofDn4m2xvefBrKhmMnDo8NfIoiYEoWUoGf1K8d2nJ
 pDqBqUJbc9rEwhjBUkhIAQ7RU1zfmH7+1zBi8upnOx9KJOzQzdr4QbSn6aQPbJ46r1WwPRgQ9IZ
 s0dDONl9QWj8+OKFBfsF6pHNg/sKuPTeDnsX1jZwZFl9UHjyINFcN6y8oYS7rIpEM2gO5nGOeta
 D87P9LuCkbLEYzxWUFPKEbzEVQePizfXhgOtYaUyMm222im7IrInITX6u/J2iksScXPiSC4p6
X-Google-Smtp-Source: AGHT+IEYPp9/SZKKWr7d1Sdf4bJ3dquoNZkZ9jN8PfmeIuqJmsYnAyl65jdVzy0p0aOpaPFVFv4wrA==
X-Received: by 2002:a05:620a:9519:b0:7e3:4399:9c4a with SMTP id
 af79cd13be357-7e63bfc1f7cmr1532986985a.41.1753740605719; 
 Mon, 28 Jul 2025 15:10:05 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 05/12] net/ring: add new devarg to create vdev from
 existing ring
Date: Mon, 28 Jul 2025 15:08:13 -0700
Message-ID: <20250728220955.332924-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

