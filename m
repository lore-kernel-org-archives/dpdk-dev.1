Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6544CFCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5194A40697;
	Tue, 10 Mar 2026 03:49:38 +0100 (CET)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45]) by mails.dpdk.org (Postfix) with ESMTP id B4BD44069D
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:34 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7d75371d873so1431239a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110974;
 x=1773715774; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=ug8L3JtOyejCxERjnDTfc58Odc5GHWn3537TsLEkLU5JbgUBH3Igjkg81NBeFYR53q
 QdVczErR9znBqYUmYretO3y9xV7nciZC0qdIDCSq4qYcJcn2OuBACwHt7b/Wgg9JtyMN
 cAChOW1dCPlSXnEO6zd0IqeXikPRCM9AcKS/S2tmMzAgwXKUoPs9PVDMr/A7dcgrsMO+
 l3Hi5G0uJp4zxSbkIZt+X9vWLqGVx/wBVYiF5z7d7oI1B1whhEkkIckDvdbIuCvmOdeO
 ParGihZmSFUHwyAu4GHQJm578sdTJRLFwxS9g1/VK0BdhZ7EK74YM333aNk+6Q4GHoCC
 g6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110974; x=1773715774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=pLHP9uC69CIdlKiqUasc7+SEXOpyOA1d+btOn5x+wYd1699h13N1TxnxcKnYTyXFwI
 6HKr8vfLY3HPrh7WOkJXpdjDwF8DU0mep/8XvmPGYaFWS+dNPrfib2nCqepS9Ergr1zt
 6Uq70dFsSiGXACUqmGdfnPrZxP9H19DyfLSk+XgA+3rhhZR1HiaU+FPJY/9SAxiV9Hri
 EaM+YBSCiQZP6cxDdenV+yNWadB6wuc44viWN8yFJRpwAXfBlAcrprMdsN962xONHpPH
 gFXQ32l9qc2R0Z8a68V1SLbDP5OV0rVRk4wt9/oouM5kmv2MqNNhdaKOWvgg+efSKTIu
 BGCg==
X-Gm-Message-State: AOJu0YwY3o8Stwh1ObyCS8/wM9CD1cMBEhUJAt9CfsVjSS1zYHM9oG5y
 bIIrnb8Ng58NJ5p2O2q7I9bXiVOS05yGqiF6bSbFQxoXBbPur/+0bRYxb7aLuN0d2OHXpz5cz/o
 40WP7ecQ=
X-Gm-Gg: ATEYQzwCo6LOivHGJNHyYG3ZmvRHeLhOEPa8RT849iYI6KG6eWmhAkQiO36O6qUHTx4
 igVwWN6cR0ovQPh/W/nK00RJCmAN9xQ/GYM6P2yPcQprULwkE007hv+vq0P8K2cyaSHr9HU3R80
 DAOm8XKAig8IVNnG5OZSX5gdUHqY+SJYwdJVz8dBLNg8O04GhL8l4Kb5jnam4e8MOZp8HBIAB3W
 EI5lsyF1ZjumZzdikuKM018G/pK9yjg1gbFdL7w9nlQYw9uySoEm8oFPXNj4eKlhYu4x/HRW+Ty
 LoflOjXWmKJj9isa3aVnMeAyw5iXyiSPCG3uuLiMm8ldOdT5VDmBFaLhMnDJgvvlju7QRAl04Rs
 9DBBnj0pE47DiuxGUuW0rnl6RSq9N90YIt2u2dxS3+lGKKUExJl86yk0xKX6eEEKb0zSX6i0eDE
 DWXI25eKYQh68KjN9q28YCIa4YPoT5mSGGB7a+aMatNg4=
X-Received: by 2002:a05:6830:6419:b0:7ca:c7a2:c935 with SMTP id
 46e09a7af769-7d727077910mr7740020a34.35.1773110974022; 
 Mon, 09 Mar 2026 19:49:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 05/25] net/pcap: remove unnecessary casts
Date: Mon,  9 Mar 2026 19:47:40 -0700
Message-ID: <20260310024925.476543-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

