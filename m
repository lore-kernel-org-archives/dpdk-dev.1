Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC5AE7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2798540668;
	Tue,  3 Feb 2026 00:13:01 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 9538840657
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:12:59 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so3057730f8f.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073979;
 x=1770678779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=AlCjkWLUv2V48JEDCwZoJWvg0C79/Th5t42eelN3rCaT07MPxxVhQWs2p0jnPQ44W5
 Ona8HVtsw60Eqph6bp9i60Jpr60QXrCZIBnVv2X0OXH/+UwBbMldXlnVimvV1M/4yjMz
 Y0cogAu41U7J5H7/XTtEydRo91k1FpBjGijtEXzSCEmtOytor/jSEyNLJim+1QUJDIk8
 f31jE90MValM3P3ugTnxUmQz9MpKC1bqrme/47+5xEZ/CczIuMr6vywr3BwGa+p8ncnn
 UOcX65q+Ij78lx84YxB9Yvo41uUnx8iuYgcfnTOJPzStYE4TjNx8inDBft6DNDuz3YnT
 WqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073979; x=1770678779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qr2ibaKZFZ1WwKRZQD97rDlklZTjrIslHzDyjV82s/Y=;
 b=PyFsVkz6FzN9E1lmR0opS3fJiDXDAErsyyDtIgmA85Y2km3UVVrCdEW7A9l6FXc0a9
 tg8OEmp6TUh4JCTYQpEdF6lUxHlpnDsWZTXGDxX8IWETOovJVtceh5T3wuQuWYXL9Uek
 3gjI6lZp2UTbD3HsGRVhyyOW+L35vLduUgq3XPiAZyt7rphFPEGgro4LZNl55tjz6qp3
 XdeV+mSmMt68IDLcTcmG8hzFcR0UkEifxzqQde6GRUwo98I8sSExiwHGHfoGodk6OqdL
 zRHjtnNspE8IfMVvXAEwre4vAIHCPDw/zQYmgMOwEMB1V6DVYmArPGFKajPiq3osPcNo
 ZI0g==
X-Gm-Message-State: AOJu0YyE8Y00q/sXB9VIqVX1pQnmw2ANwLl9WTEIwtpJJbmEioMxfrMa
 yk0bHaqojV5GdJ91XQJ7PMgIsHr8chTFxTxo/ydwl6Io1yzSKn6voufb7sGNKEeW5KbSw+3Qk1G
 nrb8a
X-Gm-Gg: AZuq6aIwp5vpjBXfgr4qKhaA2YeDqQ/dGrkC5iHPc5wjhxLuRlD5BWAnCo0ll73B7CE
 VqXkesSMuLM1UIRBGGzhuONaxMbMem3W8uPjLplUDNW9wr2Nm8fSxPnMC2HmLYxC1NP5Tb4u4OV
 N1tY+vLLZEgB3Ld54dEUuiJ8+NmNFuFHKMm3AnjqnKOD3IZcyCmMlXMwSXNZf0iH2OczYV37+pe
 b2Dq540f/Yy3Cc8RkHHqibKpC7ghmyB/DMyUDPLI2RTyEmKPnKD7bh5iCN07ncA7TJOSwTytdYQ
 GPaJbwq6O3bQzHAVc+UbS2RG3WUajrfsKH4ezegWIMmFuuzbx00EYBcKQkJqNYw8eju/VX7sx9t
 LJ7e1wSXZ4c7p31lO6En93VgeVe8XmRlXHTlrHPA83iPAsYAzrFmit7Q+NtXGkThltTgdumsbe6
 xSddx6uvbkMJVilxnbPUpnrJGsozJ1WBIB5w+/KCce7HH4cqCcyA==
X-Received: by 2002:a05:6000:1ac8:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-435f3a8873dmr19634466f8f.18.1770073979202; 
 Mon, 02 Feb 2026 15:12:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:12:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 04/19] net/pcap: remove unnecessary casts
Date: Mon,  2 Feb 2026 15:09:07 -0800
Message-ID: <20260202231245.216433-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

