Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AAAE83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7CE240672;
	Mon, 16 Feb 2026 19:14:20 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id C8B414026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:17 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-436e8758b91so2845531f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265657;
 x=1771870457; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=kL9ay9RTVhHPDNQDIIClxJj3KAz4hK10KHr42U0kwPWEqbubXUdL6McJIgLtQ+3wlU
 EtBl1MnXl2BkJgGXiSh6us6kUdu4JOUK+5LhQlxMvhULuj2VyyBXJ9JpjVwr7E7Wcvra
 wMEKDHx6vUSEHBfBJ3UPaRnOvEKPILYMYyumug6LF2dw32G+gB7j0sAXLyIK/y0E64pA
 61KK7+4GnpGFtJVX6UQXEEygFesmnk3ldC33CWNvSbzVoDIFp+mwGU7ij32btycJfnZw
 d7ptqpZGhEUQhCF1N4pD+eUY/yphK9kWfnL+zRn/kqIJLwWErJKyUadilvjS9N+3cEXL
 F8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265657; x=1771870457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=HyrCIV1PlzKTo5K/mgbRruAVVZTLqnTNEYZOF9UVpm5ry8DwMMaT7JrOTmyLzTHot/
 FGPqpKzfdJNnaIQorzBnhA1qmX7Toc0jyDZlb5FuLvv3owb9l5i/FAUN9RwlN9jVd3/J
 KAUnC+qdy1pLqi4ey6uhsrjuSFpC5TaIWdNzxK1NFCoCnK6PKTsGWjlAUclX5Tn3wzwA
 iKwcSJjXDqbmtoVnkm32E4SOoswFfRabJCKZChYLUN5vqqgiID1CL6PnfxyLuE8/spyY
 bHU69O2+H2W/F/aIdP6IHlIzj5pEI605sTg6lwHpiiKEWamHdpS528B6dy9MowAQS2sz
 nQUQ==
X-Gm-Message-State: AOJu0Yy5nojEV51skVIPGtH8Wmk1ruaSdRoSNQyreU5+mqV2n8sk2JAx
 x3EO0axHnFYAnOUjTcHXwRImxxf2vz++6Qb7H/LuXDiYtaJu5/EpjX5sEMQsXPpwRpHgb9GutNt
 2M3O3ltA=
X-Gm-Gg: AZuq6aKS9bEcPx+sLJ5lgTRjnWm9nB3wLquJ08GguhHMMaEEJ0GNwvkmwxN1HXaDsyH
 IrFNeWd7tHzuheYh3qUOouLwBVjXH4j0WpNj0y/6wqlL8XHcHRXuVfolU1QQ9lpePlLF+9+sLKv
 VcOQ5KN1BAvIOE20Y6KnScdDfnY8RaBtvyE8cjvGJZzDPW2RIGczfJNkeksRQxs6Fn3ZAXm74fa
 fsYWCfB6craWHXqvrCPBAR25UWLMTvTJX+ELC2ODoEvYmsUtF6hzjp1XDRBaPa+yhklVFE1WeAu
 khLbcpfCdIdqItZT0kZXUheW0joVXtKPMESNNRJa6lnhzM75RY8Un4bNyhKLl3gd9fL3VxFDWn9
 Iu45KLim9Ag+1dasykF0qZNBdsxMEffDvXSLRBiHpVBR5q73MhedgWke6KeA57IsxmZEpp3uA4a
 iAphCsBYsTCpdPQ4Mj1Jy0VU7HLYwrGRAu8HIuMm3NEfLXgeuU/Gk3VDCYhvsnwA==
X-Received: by 2002:a05:6000:290c:b0:432:8537:85ca with SMTP id
 ffacd0b85a97d-4379db9857cmr14698398f8f.50.1771265657350; 
 Mon, 16 Feb 2026 10:14:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:17 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 04/21] net/pcap: remove unnecessary casts
Date: Mon, 16 Feb 2026 10:11:59 -0800
Message-ID: <20260216181407.428877-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

