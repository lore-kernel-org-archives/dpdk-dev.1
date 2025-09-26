Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B410CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Sep 2025 15:58:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC6B9406B7;
	Fri, 26 Sep 2025 17:58:11 +0200 (CEST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44]) by mails.dpdk.org (Postfix) with ESMTP id 613874069F
 for <dev@dpdk.org>; Fri, 26 Sep 2025 17:58:10 +0200 (CEST)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b3727611d76so262158766b.2
 for <dev@dpdk.org>; Fri, 26 Sep 2025 08:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758902290;
 x=1759507090; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWwzOj9auYhj3i5Abjc0R7yUjKztvoxLgqZ8gWdYmnU=;
 b=y8y5GYrgoKdeMmOdr1WrX23vAvNBMYVmpnr6fu3SfdIW62oVpxoY7rNuoY8NRFDB/u
 UyP3HeQZzCHBUFWDFr5wU06hpoB8kRzQuu3P6OlpW8zj12bb7IZwKL5qxseCUt+ZLUIp
 ARduN+4vOU1lodbyQCDelDtYi6uB+FCBO2TZvacMU09z0edJQS/cDjPjMYt9MXlzfGkl
 sN/r0M67u1CuLgrExU5feNU8sPgGjFn+2d/3QfToNRUx7mVqjjMzvc98G2Ng80dpu68H
 Z9MvbEuOcEH9YF2/WpnnrfzyWsMieqIt1BJoxORJPQv7XhH22K3bqYJGMGHPEuzqEyxC
 9g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902290; x=1759507090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWwzOj9auYhj3i5Abjc0R7yUjKztvoxLgqZ8gWdYmnU=;
 b=FTYq4xMLIzg7SbD6u/6Z61P1tkh7cckMMNm7UO1K87DoScV+fx4EeJhqThOputUMQW
 683XXpu1mVtY3qeuW7Q/nB+j7UIwYeq3hY60slRJ0KhoiQLFzOJDdfb1xEfy4y4rGd/r
 MBREij8hduD1vFQuM8SosFleeGPbDM/k/SvYHcnUGEyiKF18nCiqVlBMYTkQ8BNz4zmK
 7YYlMfXl99KmNemBQ5szk8GLJJ+f886zs3ESLR4sZVjH0+YwsjQwIzm4vk2X1d79994w
 ta1HdQ6veWm4I4kRF6Vm0+UPZjJChCHQYvqh0elXVQPcIlBU843RTvQ/z0HOhnpQcKF0
 3vFg==
X-Gm-Message-State: AOJu0Yxkju/oW/ZpOPigsFhG8dDY/kBU1qgaJ3w6y4BIQq+vBhbJ/WWF
 xhKmtIixSkRavlOIhJec0xFB7f8bKgxocv4TpKRbOKvXOW++F7CjNGHEXUQRzRHEscWt5Er/yss
 hqjYa3q4=
X-Gm-Gg: ASbGncvtFi2Coa24hHnjjzY3D1r+WWcz9MbiJjn7dvSBQ1+Lt7tAS4mxRBmnmGb9oLo
 zW4Gir7YxYJJVjl/Wm8Kh5TAUob9Mz3DOIqhdFzlhqQH1ptGLhXxOuGU1zn7FASXMOVNHVjzxqB
 dW771eesu8+29ntF0NKe4iS873fCMswh9BpeCjojhgt98uQtPIXMFDOOW47GdJeyZXmmae3gXO+
 E6WYpPIQ4ULE8aCtRCYWuDqpGVhr5FEczxM2zqpglfNR36xDQJq4YfC9Mtz/07enDwmy1017kK1
 ZPcyfjs+R+1JAZKdmaMgACK0JNmz3osPGdo4Gd1tF8ErQZa+XZsFgx1fnAobcxNJPKWaqWscPyd
 8p7tyuS2VJABjbjUwaEl+KOKZhTiGOOj88wEANTbp7miCX8VeaBaSHLYUvjmeQbGMlrwv+lPh
X-Google-Smtp-Source: AGHT+IHNxWH+bgytyxFqec2N+tMe/caygmA7MKxtyQEuxHc9bGignmg/b0ws/kkcP9ut/cJ7w0sPrg==
X-Received: by 2002:a17:907:9486:b0:b2b:f498:e2f4 with SMTP id
 a640c23a62f3a-b34b9f5b496mr778425966b.6.1758902289842; 
 Fri, 26 Sep 2025 08:58:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353f86f98bsm389099166b.41.2025.09.26.08.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:58:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, longli@microsoft.com,
 Wei Hu <weh@microsoft.com>
Subject: [PATCH 2/2] net/netvsc: rename get_vmbus_device internal function
Date: Fri, 26 Sep 2025 08:58:01 -0700
Message-ID: <20250926155802.398869-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926155802.398869-1-stephen@networkplumber.org>
References: <20250926155802.398869-1-stephen@networkplumber.org>
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

All global functions should use a common prefix. For netvsc all
globals start with hn_. Rename get_vmbus_device to
hn_nvs_get_vmbus_device to follow pattern used in this code.

Fixes: 11c0663c9445 ("net/netvsc: add function to get vmbus device")
Cc: longli@microsoft.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_nvs.c  | 10 +++++-----
 drivers/net/netvsc/hn_nvs.h  |  6 +++---
 drivers/net/netvsc/hn_rxtx.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netvsc/hn_nvs.c b/drivers/net/netvsc/hn_nvs.c
index 0b7e6c0264..c6bd60dbda 100644
--- a/drivers/net/netvsc/hn_nvs.c
+++ b/drivers/net/netvsc/hn_nvs.c
@@ -44,7 +44,7 @@ static const uint32_t hn_nvs_version[] = {
 	NVS_VERSION_1
 };
 
-struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv)
+struct rte_vmbus_device *hn_nvs_get_vmbus_device(struct hn_data *hv)
 {
 	struct rte_vmbus_device *vmbus = hv->vmbus;
 
@@ -62,7 +62,7 @@ struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv)
 static int hn_nvs_req_send(struct hn_data *hv,
 			   void *req, uint32_t reqlen)
 {
-	return rte_vmbus_chan_send(get_vmbus_device(hv), hn_primary_chan(hv),
+	return rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), hn_primary_chan(hv),
 				   VMBUS_CHANPKT_TYPE_INBAND,
 				   req, reqlen, 0,
 				   VMBUS_CHANPKT_FLAG_NONE, NULL);
@@ -82,7 +82,7 @@ __hn_nvs_execute(struct hn_data *hv,
 	int ret;
 
 	/* Send request to ring buffer */
-	ret = rte_vmbus_chan_send(get_vmbus_device(hv), chan,
+	ret = rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), chan,
 				  VMBUS_CHANPKT_TYPE_INBAND, req, reqlen, 0,
 				  VMBUS_CHANPKT_FLAG_RC, NULL);
 
@@ -93,7 +93,7 @@ __hn_nvs_execute(struct hn_data *hv,
 
  retry:
 	len = sizeof(buffer);
-	ret = rte_vmbus_chan_recv(get_vmbus_device(hv), chan, buffer, &len, &xactid);
+	ret = rte_vmbus_chan_recv(hn_nvs_get_vmbus_device(hv), chan, buffer, &len, &xactid);
 	if (ret == -EAGAIN) {
 		rte_delay_us(HN_CHAN_INTERVAL_US);
 		goto retry;
@@ -530,7 +530,7 @@ hn_nvs_ack_rxbuf(struct hn_data *hv, struct vmbus_channel *chan, uint64_t tid)
 	PMD_RX_LOG(DEBUG, "ack RX id %" PRIu64, tid);
 
  again:
-	error = rte_vmbus_chan_send(get_vmbus_device(hv), chan,
+	error = rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), chan,
 				    VMBUS_CHANPKT_TYPE_COMP, &ack, sizeof(ack),
 				    tid, VMBUS_CHANPKT_FLAG_NONE, NULL);
 
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index b7691a5dc2..bf10621927 100644
--- a/drivers/net/netvsc/hn_nvs.h
+++ b/drivers/net/netvsc/hn_nvs.h
@@ -222,14 +222,14 @@ void	hn_nvs_handle_vfassoc(struct rte_eth_dev *dev,
 			      const struct vmbus_chanpkt_hdr *hdr,
 			      const void *data);
 
-struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv);
+struct rte_vmbus_device *hn_nvs_get_vmbus_device(struct hn_data *hv);
 
 static inline int
 hn_nvs_send(struct hn_data *hv, struct vmbus_channel *chan,
 	    uint16_t flags, void *nvs_msg, int nvs_msglen, uintptr_t sndc,
 	    bool *need_sig)
 {
-	return rte_vmbus_chan_send(get_vmbus_device(hv), chan, VMBUS_CHANPKT_TYPE_INBAND,
+	return rte_vmbus_chan_send(hn_nvs_get_vmbus_device(hv), chan, VMBUS_CHANPKT_TYPE_INBAND,
 				   nvs_msg, nvs_msglen, (uint64_t)sndc,
 				   flags, need_sig);
 }
@@ -240,6 +240,6 @@ hn_nvs_send_sglist(struct hn_data *hv, struct vmbus_channel *chan,
 		   void *nvs_msg, int nvs_msglen,
 		   uintptr_t sndc, bool *need_sig)
 {
-	return rte_vmbus_chan_send_sglist(get_vmbus_device(hv), chan, sg, sglen, nvs_msg,
+	return rte_vmbus_chan_send_sglist(hn_nvs_get_vmbus_device(hv), chan, sg, sglen, nvs_msg,
 					  nvs_msglen, (uint64_t)sndc, need_sig);
 }
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 0764d5b319..72dab26ede 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -1176,7 +1176,7 @@ uint32_t hn_process_events(struct hn_data *hv, uint16_t queue_id,
 	}
 
 	if (bytes_read > 0)
-		rte_vmbus_chan_signal_read(get_vmbus_device(hv), rxq->chan, bytes_read);
+		rte_vmbus_chan_signal_read(hn_nvs_get_vmbus_device(hv), rxq->chan, bytes_read);
 
 	rte_spinlock_unlock(&rxq->ring_lock);
 
@@ -1641,7 +1641,7 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 fail:
 	if (need_sig)
-		rte_vmbus_chan_signal_tx(get_vmbus_device(hv), txq->chan);
+		rte_vmbus_chan_signal_tx(hn_nvs_get_vmbus_device(hv), txq->chan);
 
 	return nb_tx;
 }
-- 
2.47.3

