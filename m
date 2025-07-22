Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF166C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:36:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B47040A6B;
	Tue, 22 Jul 2025 19:36:07 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 91AF940678
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:03 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-7e050bd078cso530383785a.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205763;
 x=1753810563; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=nZcoa30+YaA8Hh55saOOkR2eCzDBKCyIbefDCZSO8RbICufJo7rNuRUekb7jh2zz4m
 /tIkXIZ3dEf15aNGNo7+4tsBrvqmsGc4w6Y55nN8Yw56eiAwK+YRRJYVKDaNwiOKWW2A
 Nr9PRnc2kQ2vE3wBQG4CBiY1EwTBQhy9AVdU4pI5U5wSIsYlvkUXehrG0HsWW0HRMGYK
 ob6jrnIF/0kaFKSV8vNOoj35TEFwf6pRYm9D/GJ4FO3C51alwhoAR4R1WN349QNUJLxp
 j2TJOS2hTb2dlTsKYyrZ8y8MIb4da7uVAHXkwc4YMkYgixRE5OUlXnpWP18XWxZsGg3J
 1BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205763; x=1753810563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThypW9o/Vk2sZlBhCf0ZAIhlCSmqP+2nUgz9n52a95k=;
 b=UMvht367chGpf+81h4wHdUcHCxT0S5yjPccRQjFmXfeIMSS6zCanNt6+9veCEZqlnN
 BLQEjD9ZNXyoUPf4ONkoaLa7nZ1BRo5tOdcPW7AVvv4XJ2utHlbFHCc2fbSV7bNbCffn
 cqAfItq8GkcA6QbD14f4lfDBGW1gC/VIkMPUjA7iOcktB88hnDC9knCenQGCsD34VUFV
 KsabF8EU/xQlUM+daNPPJyWUAAhYq0yoPxAIc6GuxDxPIrnnOsEuds0Wuo30sRe9J9Bm
 WFuJP9sfyIvQa6O3SA9F7QZ26+WhELJ5NS1uiF9AgKDuCkwuzqe3ChBM1YQb7CzuSm7r
 h8Tw==
X-Gm-Message-State: AOJu0Yy931Uz9nNrFoWbt/kgtk17aMNfVuTtsqqo3t6P+PRRy4JW65Rf
 VxJCbOho6fquXMIuUq0kWh07h3Fxy2XjWC79nnkpVkeYMfZiz/fvjMXAsKmmI8MAZqIIMhTNw8u
 OoHDY
X-Gm-Gg: ASbGncv6jQITkP4Y9FlgqZtPn+NesXdbgLUK7+tZQCs30OGYOC7dQGFJDZdZHxivXfq
 apnww+qbxUXsTC44H/jaVn1NGiWebyEID5iM8VygY6e8Ml98dJYFMX9yhC/PiAMjwmENRR9NVeM
 ct0FJObX2mBNDzFfhTc7NDvlcihEp0fRHkW5zWrerardlzzvkgJoQMS4eGEWVy62qFFrJsxi9rV
 NyvcSb9akc+nf1wQlN1TkW390FpyQLqcj1nK59ql03HC2PIwNeHAAkjp+3O98Mk1hUYk/JftIvv
 99U+Bqf9CbzCsbLiWYiw94gPsVcvn1LEzZZAGIfax2iRqY1aKmzhZ4U6j62z84zfUCpmTwRKD/1
 ctaFWVZVaFYNTbXf9DwOqKXXyDND1gasQjEl6/3DjejIQmgRXCfKiqFekCHEpt+v6Zn+bUhGazJ
 rO4keUSDM=
X-Google-Smtp-Source: AGHT+IEbBHL1UNxtRfYY8TaSY9aHj0a0tGBC1N2Ju/2SzlY8llUR1BiobBGxnmFl5Q1uQdk2TZJ7pA==
X-Received: by 2002:ae9:e40b:0:b0:7e1:538d:5c5e with SMTP id
 af79cd13be357-7e62a1b5d95mr10072185a.46.1753205762895; 
 Tue, 22 Jul 2025 10:36:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:36:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 05/13] net/ring: add new devarg to create vdev from
 existing ring
Date: Tue, 22 Jul 2025 10:34:36 -0700
Message-ID: <20250722173552.184141-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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

