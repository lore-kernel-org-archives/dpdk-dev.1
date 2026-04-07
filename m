Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8904FF5106
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:17:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E0B040671;
	Tue,  7 Apr 2026 17:17:51 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 3870D40666
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:17:50 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c648bc907ebso3605727a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575069;
 x=1776179869; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTe3pT0sXdeHVWbh3M34R8a231Xc3Fn4lqPDQFQjgdQ=;
 b=YD8OxEsryE140LlQv1a9aBP4P7X1pd5kSiFGUFeixmWhsPofPfHco133LKD0kbv3Nv
 QVDWRM+7o3uHUV61OhkKa5xCX+i36xG8UZrTMhV3BfIW7GWzjtZu27D2Rbf8cwt8kevX
 TQb45Cu/TnbuTRzz40O3+Ej9YHK2ecRUhoWtkIuzdaXnlwjuNTuK0V1PLQArEA+HCgQN
 3UN4T2vLgzlYcrMJZb+K9OF7n/PjNmEu5pghrZ7ejZzy2fsxBo95aI9UrkNbi4evgJbH
 sFTub8NdeHPaaTCOnAXE5NVDO4U1ozoonGJ6ZN8hx4rMWx7rL4oxq00I2z2tCdAk1SF7
 rMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575069; x=1776179869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dTe3pT0sXdeHVWbh3M34R8a231Xc3Fn4lqPDQFQjgdQ=;
 b=Vf6BZtKy/bZEA/1eYsIZkN5zJancVqOwAKxUsve+oVipqFmKfjp9hPMPoswBZwidT5
 SOM1sz1WJ9hiQv0CpLvDdmO945wafzPnWJtjIjEonpWFKbiC3aSztJh4/gbb68Wfe7uN
 cDH0RjFBy4GJROQcJ+RPKOh/nkE1q75DOJ5eBWoMPe0Zksv3hl3kSDRVpd8A0+MFaTdw
 04d1TH7kEfyHPC4mLB2R+GRUd1v+vf5pK9V3jjkMUhL1wzkQInUIohxduAmI3y9tB6Vt
 D7FpjNkfkjbeB54ehQ4HCPLmrIe9JPvvMqSXdPNpiPX1C2+1r7swQIUIwHCSMyQJ8DSU
 54OQ==
X-Gm-Message-State: AOJu0Yzg/LjwOjgZOgncIxX205efoQ2AGuC7s5j1wbAzpDLsfEap1Ksf
 cNXFgKWK++qU1J4l8GUjEXN0Z3FGH7W2FjSPe4+wzF/qXRE9QgFoaGf/QR4sbcLKwBboF7ce+Ub
 3AwXP
X-Gm-Gg: AeBDievZXvIsDiY1lsdI5Mzyu/MoaiusJRm/gQXSCHvPlitmcWAA8e0DR9RqsJrsvfv
 9PK2JouJvT2ZFe6DL5jQ1QEys+Hd0wtTL36BFdKZduNaCMLm23i0q68ZAzdVzWJNYVRkxkhM6Xl
 qvDePuD8ojDHxPi2r5731EMZEMWNu7m4oFLLDogn6jBBnYKk1bblR9kTKCzeAavj7bX/k4gZvvP
 m5VQ/mOLUA3B6QV2/ZotzqHt+6espGaAooilKbM64y3Q4fTfFh3GB3gw6gSzGj8Io4oTZiMwkNW
 xi9nmISTfF0vqsoV8bXG3T5P2Kfx4REdH8HWXK97YCA2RQcpaNpmGXPY8mNT6Ufa9rpQnECSprH
 gfzdSkK0csWzJbO6UU8gD6HIz779gGFOVRvynNAay4qEJ27d5a35X44oQa+AIV+Tmt9vMF+GBF8
 vI6icTH5ruXlBXY8FjNc5im92vHHBqvK1XTKlsL03y9FE=
X-Received: by 2002:a05:6a21:6d96:b0:39c:187f:6f91 with SMTP id
 adf61e73a8af0-39f2ee01085mr18662522637.18.1775575069311; 
 Tue, 07 Apr 2026 08:17:49 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:17:48 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH v2 03/23] examples/dma: resolve shadow variable warnings
Date: Tue,  7 Apr 2026 08:15:59 -0700
Message-ID: <20260407151732.272195-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

