Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEAAFD4F05
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:16:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7D8B40F1A;
	Tue, 10 Mar 2026 17:14:22 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 173D040E7C
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:19 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d744d9abdaso2235539a34.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159258;
 x=1773764058; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+04IHz3XWll5F1/78hPHPzhpWNzA2iLPL7BJ8uLA6A=;
 b=ocBhb3anT/0ZC5xkNntokdY3XrzdYKgkTHKM2HAuER4IOc8qf7SpmvOAs7+eDUrmBB
 Qutyxdp6sXRGo5MNLCIu1NziMfcTkrhPDWYaDiEwpzcYgwUDjJQ3kLTxGIvz1tJR/Hfx
 tiacuij0stlRQZU5xUrLkg9Y15/2zbB0Vgsz8hYh1RmQeiBBOvMGtyG1lEg8BRSEg4rT
 Q+6+PrxCrcAC6CBLsWjWUa3c0L17wD7oxawlbD2BGN+UShoIpIsWsCNcPIZETJDVHlyF
 A3+yXhkrrQB8JFj2Kt/4G//Lx6lAQo2zCQe63YfiakNdZe++06h0A/dRBCaBODxzxpDM
 EUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159258; x=1773764058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+04IHz3XWll5F1/78hPHPzhpWNzA2iLPL7BJ8uLA6A=;
 b=C9dUnQc89j4kBp6sDW0JiPbEdrUBlkHhIj11uGTYc+f12NN2w9QZG6uobov7w+xSiP
 m5PNaZVfyrMzZ7gLiZs1rYMIU6nB8EP/l/YqcFceXwZDAzAK34w4DzmoESJIofgK8zy6
 u0VCOnXhptQp5YAsv9pa4fXW+I5sTaijHunl8gusvymOBpKILJvATDXE08/fxuG/Q+hB
 S0T5FGzmeUDqMhuBG6NxVhclq1eyWT1UEBcOfhI3gbI2eNMsAI5ER3KDLf52rS5G3zh0
 J0Rdp6vb/bfkC2X2GjxvfxMy2prRJahbWCcO2Fd8wTHGhGF+FiCirvAvwJMKX7ipPkp7
 GiAg==
X-Gm-Message-State: AOJu0Yz7YR40i9ePeMp12uEqgMq2I0H+ZGYv+DSp/y6syw397YYM+S13
 vdGhf+SbFmzLUBVy5cGRH3jLy1iHSAr5iFrC4jqbsoedqRt/wjiLXylCeSyUgaqC8nsFc0l+vC8
 8ke/KKwY=
X-Gm-Gg: ATEYQzyh6VWceTQ+8U3D53agifU3vJ3pt/zSDb9GXi6PQaYkLzLNXqXQd7THDuH1/n7
 13ULv0k00Z9ejB8zdLuBK1dbGZibe6RWhK7VvGdDXlz7xSk39zIPnUuKARQ6fqADADemEhnlSCb
 zAugT3ZidLMZ9I2uW6VyD8Ec6N0qBD4zbueqJBSH4XrCmrWD9T8Qn00eaNFDxwJfMjvpjhmbteK
 Gya7kiyyowb3EjwUe8nG4aEt4n0Sz2+HeV6ZOMljJfo86MrXZyvofQEbYJM4kPkYYjJrnycHqYt
 y2g07KyBilGvgqb1aliFt/AN7lVTnjs1SyEe3IMTpbQsOb/9v9FGFFIQt9FKtz9VT+k9rW7B6ZH
 /ytUZfLdWDkVVqVPi03ms/R26lUX8en5GkCKJmntTi+0g9tY3WK2OKnoPrl3UKAmvvB8Iy+8n+1
 QUgFUXcO0boj3BkC052hoiK9n4bj/4hPnT
X-Received: by 2002:a05:6830:43a4:b0:7d7:5aa2:4461 with SMTP id
 46e09a7af769-7d75aa24cbemr2166392a34.5.1773159258388; 
 Tue, 10 Mar 2026 09:14:18 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v20 16/25] net/pcap: reduce scope of file-level variables
Date: Tue, 10 Mar 2026 09:09:54 -0700
Message-ID: <20260310161356.194553-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

Move errbuf from file scope to local variables in the two functions that
use it (open_iface_live and open_single_rx_pcap). This avoids potential
issues if these functions were called concurrently, since each call now
has its own error buffer.  Move iface_idx to a static local variable
within pmd_init_internals(), the only function that uses it. The
variable remains static to preserve the MAC address uniqueness counter
across calls.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/net/pcap/pcap_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index b9e828f5a4..8be3a59690 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -46,11 +46,9 @@
 
 #define RTE_PMD_PCAP_MAX_QUEUES 16
 
-static char errbuf[PCAP_ERRBUF_SIZE];
 static struct timespec start_time;
 static uint64_t start_cycles;
 static uint64_t hz;
-static uint8_t iface_idx;
 
 static uint64_t timestamp_rx_dynflag;
 static int timestamp_dynfield_offset = -1;
@@ -600,6 +598,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static inline int
 open_iface_live(const char *iface, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
 	int status;
 
@@ -711,6 +710,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
+	char errbuf[PCAP_ERRBUF_SIZE];
+
 	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
 							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
@@ -1459,6 +1460,7 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	 * derived from: 'locally administered':'p':'c':'a':'p':'iface_idx'
 	 * where the middle 4 characters are converted to hex.
 	 */
+	static uint8_t iface_idx;
 	(*internals)->eth_addr = (struct rte_ether_addr) {
 		.addr_bytes = { 0x02, 0x70, 0x63, 0x61, 0x70, iface_idx++ }
 	};
-- 
2.51.0

