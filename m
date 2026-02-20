Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFC7C53216
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 734B14066B;
	Fri, 20 Feb 2026 06:48:46 +0100 (CET)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id DC0F24064E
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:43 +0100 (CET)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-8951c720496so10147196d6.2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566523;
 x=1772171323; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=iJHUGDXyq8JicgDlrCWhr0j59JgHg3CxqBwHHWjAVTybIfRZYhXN9tYDVRHt+c10ic
 fRV3UVJzNLDOG3WzdJzrox87k1Z2VjZWqB2qnhp4a4c+Wqqkh8rK8UzRPBYnfqZMiaIW
 qN2m8tiJGpsWplqCiijEhituQYtjEBQMi2Mi1WWkv7yYtsRFk0zgZAD5dQ1xNDvfEv9/
 4gNK/KwOdlDIt477liMVBgtq+4YjIEKLZJmtOYm5F5+iDUZlEL4AOA+76wfMhjiUs5dr
 fXP1bejzkBo5QQM9hYztTfunUuejRIBFeSTMpZDmxDdxSD8QVRKJ5JeUy2CNiAa24D5y
 9E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566523; x=1772171323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=k6TwFjryQ9fFVLC0Tk1adjhv2gARh7c6NV1Df49mYO7Q9fvIYaxsSaGmzst/JzY87u
 QeSu+Cw3i/wIc3HyAgPvoh8dGGsxiv56pehNgPdESpq0QlUk49zgd9AF0noYx35Ro6Mb
 vnSkmzyj2nGr1lQqhYuNlH8gSzyfwnr6Fi6/BYzXbhRNFbL/jWyC5JIMvteaZZ/xg2vA
 AGvZ3LMSQbKFCdsf1PSK93CRRiKFMHiJZQmRaaG19PJwgfG3kVWsxR3egfJZ30c8P5bb
 ifZN3e2RZw1EPDiB+tDNkdCM0q0d2KIA0AWYmmqwdWjkxk8yG6lLS9DGscYSVDMCVRFX
 BoRg==
X-Gm-Message-State: AOJu0YyNp3SXKqZjm/YRhxrSQsn+oSqttKhObL9q99VFzalMYw+XUw/s
 ykNFEPcYqViiYc2vT0EtrlztaKzoHe/GUhnwegvPHt3JXFnHF3JVy689Fku9M2Rp7mXq7WXEZdm
 +OuHd
X-Gm-Gg: AZuq6aLz4vSJ0k1MpQga1Cd6pQADI1wtFrFu/WxrDfndzV8e33AYZIVInhYvkIleNjD
 3Q0sdmCIKjRTelj8EVkrq9R4SdRjYa1IIJ1LekaoUJJ9zsoFIPrbO9n5dppahJFzohwGfvALYul
 Jyby0A4btkCWkppM7A0NT/NqCtEQ1+O0nIZhUVPe1ikVZrwiD1AzG0YBkkigIOghQey97XiU43K
 r+3BmzEMjXksCrqQYx4Ws2zjGgw+4pp+Agslnf2AQwQPgHSe5N7pq7VJq+rqwYIsDlvzjLug04g
 DWERIQBdtCz1VeYxUEeiPjvUUANNYlJQzIdqRQyQY3MLVX81IiC/tSyql6UuAcKM/jfUmsYjRX+
 02c2fqU03HSXuzcHAF2V6m4BE6E+mL8uMH9DHKM+yhPuUSAWZOyyCSnFcT9iWjXiiV4QYD2mfV6
 WQedfVdx6Ol2PyaF6NJ0SWZgps0T2PCR8dgc4DCRSlGQmmEHl2aJKyG+cuRM3pvQ==
X-Received: by 2002:a05:6214:1311:b0:892:6681:a92b with SMTP id
 6a1803df08f44-899580f15dbmr96730036d6.49.1771566523196; 
 Thu, 19 Feb 2026 21:48:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 05/23] net/pcap: remove unnecessary casts
Date: Thu, 19 Feb 2026 21:45:40 -0800
Message-ID: <20260220054834.1632201-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

