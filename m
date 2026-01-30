Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172AD73EAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E31040661;
	Fri, 30 Jan 2026 02:14:04 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 697D140395
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:56 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4806fbc6bf3so16018525e9.2
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735636;
 x=1770340436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=oOAYPzcpov/RuOzVmGSJ5j5DzHmpB6WzQK9pmHDJhkxcxG36bbK+gpNmXCRUMPEQaf
 rXYiSS3bVvBRv+8UhmHFH/1FjTUabYLN9py9pbL65wIgQPyuke9vaVA0ECzu2gCoVHB0
 lVxvs1VIuJYiWr/CcCsIIkiMtPEqqkM/GN7bHJuFxIV9o30E4hQ7hKTRVw4pVum7xhYS
 18+8wKHxiDwiSiEw7jJIsXVBpRJdWGJLCyhJh9SSeuM3LujRDXwUfJWivLR640uD+hE4
 bVaUKk99O0QI7lbfvLhutF/3Tzg9c05K3Ys8xp5hBM+G4E7NcLH/To0BZdZnJ60i2S8U
 il2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735636; x=1770340436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=nhwalu/dI1Vif/a3hLM7GRP3mmzjjfEJoe2DbBO9nIcLFN8IpZc6Mta5YLLEpkpCz1
 5sq+KbPh1zUlhS7CO94JvEOg5eKfQhANGm7tyLa4oS2by4weWDwu8hCS0JFsvh+zlG8y
 Ose74cTeDiQccjOuz2AreA44RyT/PpKsgdpmEslUQKxSeP/1FhF2Vgcl5yC6Dcq97WKp
 Ojh0dgK4zMIOb/KHnvv6RHFx332ffX8KfokbAhUIPA75GroaKdAhqDVNTZkLxu+wX/dV
 nptdXHLSssrFHuvBk9BiEGZKRiTx334B+cktU8xB5t6AXnx1DsQrnE3dvKB4EqxkO3GV
 LNUA==
X-Gm-Message-State: AOJu0YyDikV1QJ255DPXGAxRS/0Jez1uPUh6/WjxEuh+Vj8M5nLN0sor
 9Wbc+6XTftLU2WvR09s9gw+UmB0yKueYgE2ghA/wqfu8L6rUlv324sF7/7BEUfJJuWquOe3keZ5
 w3dF5
X-Gm-Gg: AZuq6aLVwiQ8SX+Cut+a5rnEAjchypSMIhmCsg1uVsoABgcNt7qIsKiHpTjDV2I7Mxr
 HrTB/tpyQ8hG+Eswv/7YwHK/9haft/2Pz9pvByPoPWV4qI+WxxnwyVwHZ1pIeQDTV+90Xe+WHzs
 23Ks9c0tpTK9FgJYCNDYthaaOjOkj8sQE1buQWyaLw9WlIRlBD/4Wyh8u3oi2lMWwX0bQQbFT+9
 nK/mXgROcjkORyj9HbjQTAjcW9TbxCu9Q61AmBLf7zPnTksLzbutZWffzxiChJc6KyBE2IIgEAG
 gtT5lBLYcuO2Fs4kgBPBCN3VH+JFRbcVc8ZgHPPD26TBMZ+8HJ1YT4G6Pyj5Kp99yamPeCJ33Nx
 4WU4Kp/KfH3lHp3Nzg3+2kVB4ZnvaVwYiiglMO6ZcrKQdmRJ1foqTMY8EQcw5hT9NaZAsLcMPwo
 lOkXm5wktdzi/UP+ioEmqyco37ieK+tWn0XdDdsZ282G66cjAF6w==
X-Received: by 2002:a05:600c:4fd5:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-482db213bc7mr11923485e9.0.1769735635968; 
 Thu, 29 Jan 2026 17:13:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 04/19] net/pcap: remove unnecessary casts
Date: Thu, 29 Jan 2026 17:12:20 -0800
Message-ID: <20260130011344.204233-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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

