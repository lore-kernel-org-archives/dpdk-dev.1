Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A355FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD2F402BE;
	Tue,  7 Apr 2026 05:52:18 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id E065D40293
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:15 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12732e6a123so2427442c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533935;
 x=1776138735; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgLNK0dN9m3zJCqHGAAq0Ph5NnotfnhoBprAb2pCQJc=;
 b=Eo2ZU2BtJuhALKZAmDLPDTL5KvtLmbmvCzKwZO4zrygzyt+Wo/BgBbQRFJazTh4Xjd
 6It7G9uvlDY3vrvHo1+PUXh1ZpDhAU4UNuie0Bi/GV4ZdGg3raJ3N77PaDnS3BSus9QF
 RiXGsamX5Rh0HywmPgIGt7DAyeAz6qTWPu+BB2cjguX+UmrHe++uHRfOP6KVKPABvJ9F
 0In1JNUevp3elh1ZKJ8vo5ag3UsDq11zrxAE7Ny4yMg5wCCRcKz55p9LDi7Ndl6L/JCx
 rCIDsXG6DwwZP8Sm9ZKabebcYpQAcMoAUihRXqvRo1Htr2zr+piX3YFiJyiMUvtqYpfv
 cMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533935; x=1776138735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vgLNK0dN9m3zJCqHGAAq0Ph5NnotfnhoBprAb2pCQJc=;
 b=X3X4qP6d6HD+wswsqKS8hO/Tjq89JtiSu7ZmmTQ0eeQ3QYYgmCzsltBYUC1ZPu0k7h
 q9WT8wRDHbvzUUcJAKzw/41Ha4JuqL0lbWI4a3MEJUt2INsYQKS3XvA1H52dxxLg3G44
 lmZAqy9VEbXSs4fDcwww8jdJZoA3rzJsGkJlKUb3mXvh9efKcnexSfnnpP6ENmygxpgL
 e6emw+WS7XNFmIbPJJzKMq6dGikkbXfbTePdcUP6u+ighCbjEpLWjhzh7ZXh2RK/zEZ0
 uPm9qenuvw7kResK+hTAVGllF4lgeni+rRaqM1gMpEVECtinD/xJGPhZ+PWVXKwNJjH0
 g+9A==
X-Gm-Message-State: AOJu0YxiD4upT12wDfuCooyYUJgVqWNoiLR1zSrulwQdTc0AN9RDAEQy
 zt8C6aEqso9JRROesZpvXojZm2EyLXOHm2j1bZKD627Co7bLE9IZDFzHZlHCYnTxmLftCvzF5+G
 o/9Sv
X-Gm-Gg: AeBDieu9ZjdbCjA2LxTn0F1OLbkBSK9FDLXqJADJs+ZVb4E+gUsztxE4/lXbv9yxjww
 WyELRcs35+yA+NwicsOQzvmSIKM/GQs73tN65XoJZDc7CkaVGbqRWKt9TnEIVJ4B4Kiayq7eDPO
 RTzg74hC6T/CjkoVQi7E1VPYKaHs0fE8gvNEUzjNjxYbAaLa9xYumlPRMlF6qDtONkbhsKMyfKp
 UhJWJWu4rgBNS9cYT9r9i/xR/UPJlG11ajW8PA2Zcp+6xd4Bimm+2elBeYTi3uUG8Ftv3XX37rQ
 6mu0rFNXly+T3bWShl4+rNJbxk6UFkVN9Zn+KPHFPnvG+fTKhBSrwb7T3qtSuaycHbalvK+Coa4
 IuePIeCB0iPGpuZ180zF1IbZlBADXpBoz3/TOwZp/vpAc1hApnGVxYYGGUUI8+ENkRxvCjEMqvs
 zMk0o5mn79g9Atemo8juNNZCeSjFBp1BwR
X-Received: by 2002:a05:7022:fe04:b0:128:d24a:a5c1 with SMTP id
 a92af1059eb24-12bfb75f067mr8258716c88.28.1775533934932; 
 Mon, 06 Apr 2026 20:52:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 03/23] examples/dma: fix shadow variable warnings
Date: Mon,  6 Apr 2026 20:49:29 -0700
Message-ID: <20260407035209.650419-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

Fix shadow variable warnings by:
- Renaming 'copy_mode' parameter to 'mode' in dma_parse_copy_mode()
- Removing 'nb_queues' parameter from port_init() and using the
  global variable directly, since it's always called with the
  global nb_queues value

../examples/dma/dmafwd.c:593:33: warning: declaration of 'copy_mode'
shadows a global declaration [-Wshadow]
../examples/dma/dmafwd.c:881:68: warning: declaration of 'nb_queues'
shadows a global declaration [-Wshadow]

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/dma/dmafwd.c    | 10 +++++-----
 examples/dma/meson.build |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/examples/dma/dmafwd.c b/examples/dma/dmafwd.c
index 5ba0aaa40b..a8ed09e6ae 100644
--- a/examples/dma/dmafwd.c
+++ b/examples/dma/dmafwd.c
@@ -590,11 +590,11 @@ dma_parse_portmask(const char *portmask)
 }
 
 static copy_mode_t
-dma_parse_copy_mode(const char *copy_mode)
+dma_parse_copy_mode(const char *mode)
 {
-	if (strcmp(copy_mode, COPY_MODE_SW) == 0)
+	if (strcmp(mode, COPY_MODE_SW) == 0)
 		return COPY_MODE_SW_NUM;
-	else if (strcmp(copy_mode, COPY_MODE_DMA) == 0)
+	else if (strcmp(mode, COPY_MODE_DMA) == 0)
 		return COPY_MODE_DMA_NUM;
 
 	return COPY_MODE_INVALID_NUM;
@@ -878,7 +878,7 @@ config_port_max_pkt_len(struct rte_eth_conf *conf,
  * coming from the mbuf_pool passed as a parameter.
  */
 static inline void
-port_init(uint16_t portid, struct rte_mempool *mbuf_pool, uint16_t nb_queues)
+port_init(uint16_t portid, struct rte_mempool *mbuf_pool)
 {
 	/* Configuring port to use RSS for multiple RX queues. 8< */
 	static const struct rte_eth_conf port_conf = {
@@ -1061,7 +1061,7 @@ main(int argc, char **argv)
 	/* Initialize each port. 8< */
 	cfg.nb_ports = 0;
 	RTE_ETH_FOREACH_DEV(portid)
-		port_init(portid, dma_pktmbuf_pool, nb_queues);
+		port_init(portid, dma_pktmbuf_pool);
 	/* >8 End of initializing each port. */
 
 	/* Initialize port xstats */
diff --git a/examples/dma/meson.build b/examples/dma/meson.build
index 6a65de127e..124f9476fc 100644
--- a/examples/dma/meson.build
+++ b/examples/dma/meson.build
@@ -13,4 +13,3 @@ deps += ['argparse', 'dmadev']
 sources = files(
         'dmafwd.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

