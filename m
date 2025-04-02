Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6364C3601B
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1416D40653;
	Thu,  3 Apr 2025 01:24:53 +0200 (CEST)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id D631940649
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:50 +0200 (CEST)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7c5f720c717so145748585a.0
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636290;
 x=1744241090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KMuaNLid2kvfEsS4x9CmGhvT6QPUxdtnzQ1nWAj2DM=;
 b=ETCdmgbqp6dEBbw8oOy8d1C4MeC7xwdmFbIhEisAQsyFPDBMc4MoTRqgkNY0RVIQKA
 GRSkhOyEeEasCd5dUXWoR8L1VIZ8gPv55qgWKyIp+ghjir/5nneDozuqSaZXAXuGJqwu
 F3AnW5Rm+IMU3RIJTZEkXY0kykmw4UqIfwCb5Y9N4tbHPwz7AMQxE135tWGP1CGjD64D
 vnZrz4WMxNaG3BxHUFtGEfLiVPcv3ajGB92HxGxiHLImn0Ue3y7Z9EIFBjrvTCscvNAC
 VSUyKGSV6WIXF3KNKzRea/xs7vIcDNDLaIO/jjx3/Cf5q+v4HXkvbenOjQxDYSCZxlIF
 cJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636290; x=1744241090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KMuaNLid2kvfEsS4x9CmGhvT6QPUxdtnzQ1nWAj2DM=;
 b=AlGNl+S8d9Kb9UtlyTR4EqWAqPGYDm3OwRV48yQMU22xNLixcZKS18In8mg5VZAkOx
 GNZeN17E95Mu5DSW1oeQVGCRlIBNOO2kNz+QhEZVpooU4jGyFrCrZ3yRi0D2o85KnEln
 zwrvdRAmKs/445DmR0RQ7oxhFLa+5vnvNHhxdTMi4MxZjjrBp/l6e698RDAg/WqsEfmw
 FlkIVDTv/KUOwC2Vz//PZyEwNdROCpxZ8/bIq8AS+E0ljNBOSz8DMI2n72EPsBMJ/3+c
 St0Iu+yaIqXm1cEEDvZKLPqOVlbdrFG8KeKjtJGENKWFHcCTP8SgJiJ6HUklDesUNfB+
 /02Q==
X-Gm-Message-State: AOJu0Yxv68UOvQG82TiD1bJWzscego7rJEPYe4Ct7HwRxNuCcit5SY8f
 Sf661eOdrewGh0UoX2ECj+dR62xhIAybKXgGSLBWPctOo44693CR0k28pKhof6AvKLzqdw1OygZ
 R
X-Gm-Gg: ASbGncupKXsbrdzzjg7xY3WXBh8TJLDXqvaqxg4OJCLTT7D4sBv0jkStFC1O/op7qXl
 1xMYcLUQPLEu7kjZIUkAAlRm6tk67L3b5XTYdvN9IIDqw4/O3rKsvZYccMepKxy0w3hVZ/OaPIh
 SCCNI55HOMLtQhb47te3mNAQEHMnE8gVedLUhN35TAkvyhPlqvaa3KufImpcLk+Bu0tQ56JtgXK
 XoQwT83wH8+z9sOTngiGSqtQmg2CwjZuAvLhHeFr87nYuGKCrXER8l1GeIIBYPS3RQKSagbOAhv
 4O58cGHHlT7t4mdsTf4NmKlLVC2G/S458Yr2Ve82QzWRC2ORn4yDbxjD1KYfyhOixTP4lVy1sl/
 ladgI5+4S5/kNuInp9w==
X-Google-Smtp-Source: AGHT+IEO4bcuCf2gqyT+owAWyz4uChc6hXQlwori7bJO2+L0eosUaU1xk27BoH270xKjpJwYSgzoFQ==
X-Received: by 2002:a05:620a:1789:b0:7c5:e8c5:a307 with SMTP id
 af79cd13be357-7c76c97ddaamr224842685a.9.1743636290192; 
 Wed, 02 Apr 2025 16:24:50 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Steven Webster <steven.webster@windriver.com>,
 Matt Peters <matt.peters@windriver.com>
Subject: [PATCH v12 02/10] net/avp: replace use of rte_mbuf_sanity_check
Date: Wed,  2 Apr 2025 16:23:12 -0700
Message-ID: <20250402232441.440346-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
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

Renamed to rte_mbuf_verify.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/avp/avp_ethdev.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index ed44c1645d..1a6ba82b41 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -1231,7 +1231,7 @@ _avp_mac_filter(struct avp_dev *avp, struct rte_mbuf *m)
 
 #ifdef RTE_LIBRTE_AVP_DEBUG_BUFFERS
 static inline void
-__avp_dev_buffer_sanity_check(struct avp_dev *avp, struct rte_avp_desc *buf)
+__avp_dev_buffer_check(struct avp_dev *avp, struct rte_avp_desc *buf)
 {
 	struct rte_avp_desc *first_buf;
 	struct rte_avp_desc *pkt_buf;
@@ -1272,12 +1272,12 @@ __avp_dev_buffer_sanity_check(struct avp_dev *avp, struct rte_avp_desc *buf)
 			  first_buf->pkt_len, pkt_len);
 }
 
-#define avp_dev_buffer_sanity_check(a, b) \
-	__avp_dev_buffer_sanity_check((a), (b))
+#define avp_dev_buffer_check(a, b) \
+	__avp_dev_buffer_check((a), (b))
 
 #else /* RTE_LIBRTE_AVP_DEBUG_BUFFERS */
 
-#define avp_dev_buffer_sanity_check(a, b) do {} while (0)
+#define avp_dev_buffer_check(a, b) do {} while (0)
 
 #endif
 
@@ -1302,7 +1302,7 @@ avp_dev_copy_from_buffers(struct avp_dev *avp,
 	void *pkt_data;
 	unsigned int i;
 
-	avp_dev_buffer_sanity_check(avp, buf);
+	avp_dev_buffer_check(avp, buf);
 
 	/* setup the first source buffer */
 	pkt_buf = avp_dev_translate_buffer(avp, buf);
@@ -1370,7 +1370,7 @@ avp_dev_copy_from_buffers(struct avp_dev *avp,
 	rte_pktmbuf_pkt_len(m) = total_length;
 	m->vlan_tci = vlan_tci;
 
-	__rte_mbuf_sanity_check(m, 1);
+	__rte_mbuf_verify(m, 1);
 
 	return m;
 }
@@ -1614,7 +1614,7 @@ avp_dev_copy_to_buffers(struct avp_dev *avp,
 	char *pkt_data;
 	unsigned int i;
 
-	__rte_mbuf_sanity_check(mbuf, 1);
+	__rte_mbuf_verify(mbuf, 1);
 
 	m = mbuf;
 	src_offset = 0;
@@ -1680,7 +1680,7 @@ avp_dev_copy_to_buffers(struct avp_dev *avp,
 		first_buf->vlan_tci = mbuf->vlan_tci;
 	}
 
-	avp_dev_buffer_sanity_check(avp, buffers[0]);
+	avp_dev_buffer_check(avp, buffers[0]);
 
 	return total_length;
 }
@@ -1797,7 +1797,7 @@ avp_xmit_scattered_pkts(void *tx_queue,
 
 #ifdef RTE_LIBRTE_AVP_DEBUG_BUFFERS
 	for (i = 0; i < nb_pkts; i++)
-		avp_dev_buffer_sanity_check(avp, tx_bufs[i]);
+		avp_dev_buffer_check(avp, tx_bufs[i]);
 #endif
 
 	/* send the packets */
-- 
2.47.2

