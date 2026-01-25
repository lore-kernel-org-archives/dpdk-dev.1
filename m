Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A4E63CBF
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5AB3402DB;
	Sun, 25 Jan 2026 20:23:22 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id B18E640269
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:18 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-42fb2314f52so2136406f8f.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769368998;
 x=1769973798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=FGeLGd15yE0douvvtnGAXoWgRtuzjNNBcpCiX8+iYEaFL9ahgcYUy/HvTofA4NdhHT
 EBN/vtn46PpVpxhjbI39gSqw6S+59DYnnUVFJclVD+yflCD5uo0PuHjKcf2ovLYEqISc
 eu4vbqvYYDMNERpLI6+MfxRm4iIOB5ZtVGI0jbFFuawblIncD4nlN4I/Gt8NJ9KStTJB
 KBXtPoq78LoavkSlD9OIXTQocTxcsmHxF671ur/890dlppZMmQTitS3+u5iqkRvocJuE
 fkcAbpjf0Ec+rYhJdkMKJcEN9HZkrxXuFXHaqiyXuzgfYUMntW4d5fQ9KaWUrlIQ2dTN
 +Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769368998; x=1769973798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bX/wAUt9rpXnXG9E2D0/5QMMd2Dzw2X1gxOArIcRj8Q=;
 b=PCg5bdggRa/YxBtjND/ohIbwI1Lp+Wzraa7dzHTblDfTQxis9MvT2OazJMyUk4+4Dz
 NmZRrw9IeFDa7uAZGdgx+OAOkn4DnctKzJP6lcyM3Bun5V2tXiORy6rXfZVrmGkZq8sH
 /t5i4irz7ai4CdhKZylaNkP7E+pNNkV+gS87RTkEpfqBOH6NXYFBrwb2tRAzxJ2n4G6U
 XHXh0lMZbxOF7y08T/0PrnMLzZq4Fb2otHH0aFQHyopl9iPmQD3/SjjFfkmhJIWV8vjM
 3K51qh976MlEnl/i2+0crHPBI5tfEKug+pDFMe6dwZr31HhPXn6M9+DUoESV1uzrKSA9
 +ggA==
X-Gm-Message-State: AOJu0YyCZlfsnba8zX27ePgnh2hlxBFbBL9cgEbV3PwR9yNteUAZy59C
 LDzpD6V6zEmLk2YIrWMzcalzfroRV58UD3WMMV2CP19KsIHSoZl168UGwJWFP3N1VEgQFCA6HCg
 B0a4Q
X-Gm-Gg: AZuq6aL4L5/mbUnPXNvP7mniId5j4JsrlOhruULdK7y0Ld0iyr/Koic0KzryFFGXRiU
 4IHaVFmonV1d7CLifDyUaiktwTtq6VfTx0VvDQfuYuQsY2YhpGgU/TLedlzNL9h4CDms1Cv/4m6
 M8NC94jqvLrQ2oXKC3WlqhRtT0KuNMouMW+NbZvovKh+O6k1NJJDaHYJilgVfc8ACeeq425Ka80
 FWAO3PnkcWYLJCzG4PdpPgLrQlGEKskeMOl95rimDM92AaE5K3XOE6f6B0nBufG30mGoqknje2C
 nrPHfjiyZH0baN82qBvNJicLnxb8qBv7fZpjMEIeER05B+/5UxhuguupIGkbzkxHvOmfNkQFyrq
 jljawf3Pbez0lgQY8n2rwQZQzoDzzQovH4w2FS/+whhN+QZwONrIqomD8mIdRovLOq7Q1PMPp2O
 w2uQQXBE3nlH//Hqp4wmJJOXc01xz48JES6ZMy6JGhi6Xca1Jrlw==
X-Received: by 2002:a05:6000:4010:b0:431:8f8:7f24 with SMTP id
 ffacd0b85a97d-435ca1add5bmr4242668f8f.39.1769368998293; 
 Sun, 25 Jan 2026 11:23:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 04/13] net/pcap: remove unnecessary casts
Date: Sun, 25 Jan 2026 11:20:02 -0800
Message-ID: <20260125192248.497563-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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

