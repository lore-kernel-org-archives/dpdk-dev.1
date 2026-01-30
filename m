Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA141E6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ED3D40658;
	Fri, 30 Jan 2026 18:35:13 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id B1201402E8
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:03 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so22712225e9.3
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794503;
 x=1770399303; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=o9yJ6VHwxeaMw+FAiZP+rPRC4it8G69S5ULQPI3DKjkiuU8s1t9ch/t/iYAaRy39iz
 UqhNBbw4k1FZgVuu5Ft234x1ZlhUcAEHIeoXa5Uwjah3ahApPjEi9nHjRHa63YnVFTYa
 RfPvBLuSzrRti3+89rxRLFpOb4W8ADUsm+dnzeqPWgTnkKDjPP0E3cbL3x0P20XXeuiJ
 9YNuqTRxBllvxn6sdaHhlFgI3aUTprlZvd/06v7Jl45THJU8ZqDsd0yrdmCk97atH+9W
 fsqjWvmeIBZhcJHwcYpohzzG1ffm9qsyr0tB7vQTJP/Yw8zzr2m69ErMGPDj3OtohdWF
 0Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794503; x=1770399303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=r1++N9sb3r1hn0O6zL3zSSEQFVMn6N5WtCKjb3UEuQlR2dNZ6TX6nUxd6vMMZARGst
 DLpRjZnQuZZUOIcFVv0TZt8uCsiZqbK0w5T/5UYV6eK0eeP8ScJ8QG5IkonNHzvxA+fP
 I3awcTKFJtVP1YtArqq52+/gQWIAFnPl1PMahC0lrcH+fiqdkr5UfOx1CpcCxvevdbL6
 QYFDZ8AdmRAGV3MIkAYVJG9Tvflv+UolUTyWzIsZd+zbo0mcPlobQWRKoGVGbjfZj/jU
 8j2F2r7LkfqOy6DZwLfkdLWMYvt8S8KB+zR+FdHONndDBask4rXrNPHUcl1Ku3a4b5WO
 YoJw==
X-Gm-Message-State: AOJu0Yz0tp1dI7Y+8yw9XnmZgucDvE3uIFiu04bD1tPBNGnDu3VaDFfo
 m+StePML77772N73mFLuW0dyl9XUC5k4bsqOjhe8tGTMQV+M1QNPvip/chUQwL3FjgxrErBUYzG
 yq3Ee
X-Gm-Gg: AZuq6aLwI4M1mQfYQpKprWAWuJE5bJuVQ2fom9Vb5UJR+s1NgIRCxGRGO7B1Wa92DFy
 +Fuhl6IrJ2/wg60fKn0ck76tZgRO7hg/IAZkma761ynrit98ju25uT+Fma2bqFoliZq9Y0u6ntM
 jVoiLqy50c5Pk+qN5z3M7RMk9NJXaRGakZT3S6nF7/k1GGbFywPQKySJ4stDjmBM4yCy8EWy3uI
 X/6Q7aiOoKJu/a4kET9Q78d3BHVoexQfR5hOctt+p+UCKpULBSHDbmpMxX3ENi6Ubw16+qJ1Ejx
 vswc6EDxiZ5kABpouVRpqjdjuV1yE+FxNqfiNQPK8YWFpoHsl+CU/PeHjLQfLZHhNIc6fSLb4PY
 SpMQiArBotGUugJ2U7w5LG151GamTq7qONCOnTaZPxN51Hx86ja3Has1zYQwE/CtZX1b41newb+
 ALCNShs/ug434Lk5slZ1smma/oh72J2urb1D6v1weXNZ8SfjYR+Q==
X-Received: by 2002:a05:600c:83ca:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-482db4979a7mr62524745e9.31.1769794503327; 
 Fri, 30 Jan 2026 09:35:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 04/19] net/pcap: remove unnecessary casts
Date: Fri, 30 Jan 2026 09:33:17 -0800
Message-ID: <20260130173447.14546-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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
index 4513d46d61..fbd1021c39 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1220,9 +1220,8 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	PMD_LOG(INFO, "Creating pcap-backed ethdev on numa socket %d",
 		numa_node);
 
-	pp = (struct pmd_process_private *)
-		rte_zmalloc(NULL, sizeof(struct pmd_process_private),
-				RTE_CACHE_LINE_SIZE);
+	pp = rte_zmalloc(NULL, sizeof(struct pmd_process_private),
+			 RTE_CACHE_LINE_SIZE);
 
 	if (pp == NULL) {
 		PMD_LOG(ERR,
@@ -1590,10 +1589,8 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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

