Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0D8E94623
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F224066D;
	Tue, 10 Feb 2026 01:02:16 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id AEEE34065F
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:14 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4362c635319so253663f8f.2
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681734;
 x=1771286534; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=iP/CaEv2rXsJJAeNg/WExBM6oGEIz2CMHHSkShj0UaTUSMjtUQI84SOiLXGexmneXF
 +QCCn3q4bzsvos+lZI14fnlQgLcMwzL8TYIUbRyxa4YqPLKOnUVeTzQIjEYhlEgjQjO6
 IOnwDbbgDvkwp/QpVVXsMmdNRFsS4f0QBrK+gdm1GWCZdW7/AR2jCNq7LabWNz8cCyV7
 qwwpOUopsfEzdrnowYXhwqY4dylMpJI7wQGMDJBpQEl666v/wwjUvKF8rw1h/akTGw+0
 Rn6WtFa3nQp27B85sDYaC7riRI4cPXMU6bACzapILoPFhH9mFGXePH9CVxObNRjRBlIu
 01YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681734; x=1771286534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=seD2gNGd1sYakozcVaJe8PeMHiB0t6VJOc++04rLEJ7lwAQTjtiv/z2gtPSisUAQz3
 ZVy0AxDZAAr/r0FtJnbIl+GAEmiEOyk5qm9WsCVCEYRLHQN7eJmdLOBTHkyyQe5x6H5l
 gLLhbiu50lJjP8trk74P+tk8IjL2cZIvmeZKGfBitoLAhtSrZymkjIlS/B5CbNvioldJ
 /pe79UarMzJpqA96waKEYLVFp79ad0NiCEcmNs8dNyJ0YMCn7nZNEeJ0j3k/bTCGGr8h
 kGIX8wTdkICMnFZ6RA1DbE72vTjvQb0VYPQ0pfUcqBXcpEoc+iRZHSbe+Zs3ELyZg1E5
 yboQ==
X-Gm-Message-State: AOJu0YwmcWFqsGvfq3DWHJ/CGQ7om7vSni18fuHD2O4O0DzzCdPtWxmq
 bDiAGpKggu5J+qBmI1sjD9ZlaG58O4X+Hw/rPc7OkOw40LczMqRivca+8YxvoU2aEAV2cMdDbvg
 fsaZU
X-Gm-Gg: AZuq6aLHNDZKdDnZiU1xtKTnhT7an1IeG/rBtvxurDicIQjLvvY0XAgIg8BDceruvrO
 UYf4uDW4629OrCzgq2micbc83rI832vH+iCm0ndAsVgn3TMmT0yiqhOTY6ftyaspRGQtNQSwMWD
 Lqx5McjTNs3NL3RbhS56g0aaTgH3rIHa7f087mipFTqDw0qt0cPNHdIhE9CFda5bQzFOGEwE5da
 +izjYMtU/w+pXZgefPaiwsDnairZ3zV59a9WTitn2CvZjFFMcDS/JrpIioF3uMCDimcyXsngq9Z
 gVNCfsKcPEhL1zu4ZIDbb/VgRngi50WqLaQ0SSAT52HLgmaM1pRHjWJM3zOFgK3V202Cnyn/+yD
 oDjWoGJAqDQ3qv6pWsCMLkreTONyl4CPsKAtKGy6+oKhE4b13NPoVUd7NC2NnnhPA0taNTTUGpz
 2SAZnBcV6RXaR6rA/bjt9xYsTH6ApavEow/viEUbW6cgCP0f84mQ==
X-Received: by 2002:a05:6000:2304:b0:436:b87:ce5c with SMTP id
 ffacd0b85a97d-43629237819mr19590505f8f.20.1770681734186; 
 Mon, 09 Feb 2026 16:02:14 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 04/16] net/pcap: remove unnecessary casts
Date: Mon,  9 Feb 2026 16:00:35 -0800
Message-ID: <20260210000201.295839-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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

