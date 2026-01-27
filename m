Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897E7D2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43BBA40F35;
	Tue, 27 Jan 2026 18:21:50 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 937C140E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:45 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48069a48629so9252815e9.0
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534505;
 x=1770139305; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=A60WeoqYmAhxFzvEPEiCHIt+/SyRHGSnSDReZszYkgSG7LBmEJfdpUY7AmqqivWfIV
 7xQveWxs8SSE4KmDmP4P8PiXHtEi7A4ufJ0piLg3HD8bpDhZccdFukIYqi3V+p2V+KV4
 GGrqAiHQoL6vcTHmMwY7E64JuSANrvaHu27QN68TVAR3D9q+Eprrih5TzmQ0tWhXH3r3
 POsmStjD6qWm/JzvURWjvI/9pHsXTJYSyXf+w1tLVfEM6Po+BakRjP2Xq9WDSDedHL9x
 mi2Sl53I6rdQ4zyZFV45eNgXZV2k7gPDC0PickUx4/z9u9IGQzoOQXViSsubU3GTzGSj
 7xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534505; x=1770139305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=Vb1QaUu0gCx3ld/VZ+klJGJS/rDQZXfBRLnH6gjSr9Z2aB5UEgbSUcQPFH08j4Fn78
 i22PXFYzKKRr0GbEP6iwi8Mh9qMv1t1wuNGuSgawJsVBQBV2lZeTg4bPwmAviBuLmcJx
 5uyqwKdduAbxiNxKLSXhiQZ4OJj7rfWGcMZvbMhfpgQBv/hRTXE3BgoX/P7EBiaa6S9O
 Qch7hOEZMQmLgE8N86JMIPALp48CLk2c7gpvO67we8pK4WTAxqIQzYMll2LqmSlsLqIo
 w0yboU3iDWFCF3zha0Xt88bE0dni2NXuiTxqqRFpUz4uV4uzULm9EB9wI46PGEGxh6hv
 Imhw==
X-Gm-Message-State: AOJu0YzBf8Wn4hJR6IwAlCWHDLcnRogHFJ9mLPphYokT9LwFRR72O0GP
 7cW+covqAdjwRpBLd8US0NJWDXYQneGHAzWjfMEkUw/XSii7kiXrYWXH0xM7zneJBCra/2Bc/dx
 pv+7s
X-Gm-Gg: AZuq6aIMY74+k96QjqXclFG7I+ywfACAQiO6m8SPSGXXr6cuDreyuVEJKFFP47jfXA4
 KlVq52MXkfj/u6QaSbEn9cwgN6LzpoNi4CepXZlBEnzrTyoAhs0HmlqCvhUQPUtRRcntCnLVj0+
 tZzk8CdkfNjLrT43yE2u3iWF/D4EmLz3M15UyVQTBSyiv4mztNcowtEsSCWVW3HwgKrCxnq3dIS
 cTS6X08RCodh6BBLofh9ifHZSJ+BYMndI1nLvhHUwvrqag5bzwdDB5t8/QLJauggosEwvJJceAr
 nnOSA7bisqxO7HDNt1qZIbG8sxq7026hrXfNsWF+CfWhFeqREt5iinN9xtH7hP49XYaNA+Emn7o
 Zq3waNnFKOMSHkkEBvYo9bIwX6LkSMnaKNLfEw6c258I1L+y9voGr3SUHhRwofuzzYbKtyNd1hx
 2I+lnvw0kdgIaI6zDmQpbImRN0GnFY9Zj2Ud5y+4YbNTZoyDIxyA==
X-Received: by 2002:a05:600c:4e15:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-48069c0fdf3mr34730745e9.2.1769534505127; 
 Tue, 27 Jan 2026 09:21:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 04/14] net/pcap: remove unnecessary casts
Date: Tue, 27 Jan 2026 09:18:45 -0800
Message-ID: <20260127172128.124473-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

The function rte_zmalloc returns void * so cast is unnecessary.

Correct the indentation in that code. Not really worth backporting.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index d09ba5abe9..0177cbc7df 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1221,9 +1221,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
+	pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 
 	if (pp == NULL) {
 		PMD_LOG(ERR,
@@ -1591,10 +1590,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 		unsigned int i;
 
 		internal = eth_dev->data->dev_private;
-			pp = (struct pmd_process_private *)
-				rte_zmalloc(NULL,
-					sizeof(struct pmd_process_private),
-					RTE_CACHE_LINE_SIZE);
+		pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+				 RTE_CACHE_LINE_SIZE);
 
 		if (pp == NULL) {
 			PMD_LOG(ERR,
-- 
2.51.0

