Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43007EEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:04:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 945F64065C;
	Fri, 13 Feb 2026 18:03:47 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 10220402E7
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:46 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so5971935e9.0
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002226;
 x=1771607026; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=zqqjfC7SalQQ2povf8IXepstHo+MwCh8AJtgzLbn9oVPkha3IOCHTesHHJgWKS0Y5f
 AlwKxWQOsiBOYjU1dTsciXaoGR9eHpcyHIw7lnfKLqoPhdFK229GRrbDEFMxjXQtnjLM
 doOgAoLIMXVp+SIfdgOBcplsnpFe5Lf5Yt0TZqQHlnW1Gju5/6qmTnmsZnLqedaW0nOU
 HLZl7BHFprhAFFltQblIWNMlqVfH5ap9IWDw/ZluQ7a1ciqTbgyAEdlFhyxom2Iu8l2t
 PQwv6RYvs0GEpqZPcO5yuZctuIvBAJmsiAKcu+tdhSEj7koGSLU3tUuGn4h9r72Ma4BQ
 /FpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002226; x=1771607026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=X6p9etrp0bgZJq6F3WePkJ3za0NuA188MEAyAyZFdzlhYykS83s4xiytwX0QMCpu8Y
 IivFdror18JiE6cMI1hpMvIrIVLPBmRnqR8toLS9PiW8Dl7vShqTF1ST8flTyVJZQhLO
 OSEa1BsugUJbknVwWquue6OBiqhBYJncKL3J0mT2zI+lNRLZSVod/C65L7MVTeAGN+qm
 PCJiqsUW6ue2qZqaplA8HnWYeJZ6ttLpdJaxCUdGPchLx1kMfrtiODQyWaaQiVeUSUpF
 OgQumlr6HTGV/JR1hm+iFXxCaJUddcixNEkBaYJUitxxjAQ3rVSpBgvLNmEz2wO7ftDb
 J8oA==
X-Gm-Message-State: AOJu0YxCGuI1m5a8/elF39UUD0KDjlh13Q3LtuvuI5Vt7jCvSHgk/1JY
 otAmoHiSHBGlgojjeywrvEe/MQNR78cFu18M1TPxTqerXNU35PVCmCBwXg97gBGRwbUO/FjF6dN
 oxYIj
X-Gm-Gg: AZuq6aL4HwLFrU8o6MUPW1GULdhs9c0HJjq75ot50BzVpi8c7U/3NIDRIDM+2xZjT2F
 1NEyKJXv7YVOwCAJ72dCy1AyBTs2N8mY/o9zzBp9FLlx5qIZCZrKrwOs50l5Ec5GchOxDXnNT/d
 B/+Cs9nI/COBMtnAaffPs/QOUWyIWXaj9+kttU6rd9OePaO1jqd+yJ4NYRhdC0Qi670AsSxww6Y
 Kw2nIjzPcRu9E8L9W5bJiBtWjBWFS8JXtWcsOz7UIVTmnH7toJLfHhBop84VPdL7rchjx5GOxdp
 XUz7vl6DvrJS16394dF2YBay8pk4miyTJx0AakIDZDRw/iVRQacZlBbRkA/OQgLnOqINX/kjrdb
 3mexrk339DyTAJHGSW1OUIF6GjzXVQ8G362e+FkTa31KZM52x5KwKNkGaCFx224zsgl3z7bKHBG
 rTMno89YTQIKg/jszzMOgEScSLWVkWN1q0UrujyfhwJAm0MfRymPS0pDy3Shzdhg==
X-Received: by 2002:a05:600c:3e14:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-483710904ecmr50622315e9.29.1771002225394; 
 Fri, 13 Feb 2026 09:03:45 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:44 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 04/18] net/pcap: remove unnecessary casts
Date: Fri, 13 Feb 2026 09:01:27 -0800
Message-ID: <20260213170333.40089-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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

