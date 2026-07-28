Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5111C53219
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Jul 2026 14:38:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF33340297;
	Tue, 28 Jul 2026 16:38:06 +0200 (CEST)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mails.dpdk.org (Postfix) with ESMTP id 553F540269
 for <dev@dpdk.org>; Tue, 28 Jul 2026 16:38:05 +0200 (CEST)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso2842996a12.1
 for <dev@dpdk.org>; Tue, 28 Jul 2026 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785249484;
 x=1785854284; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+rpTuAFnEX0r6tnapx9f3/h24BIC7xRoBuN6ZeEnOCg=;
 b=wgP0IU1vCmlbqQoqew+IoSjB1dLNY4mUmpzdw7VV94B+iyaCkc7mWd1sdWMWCEdHKC
 5dH2sP28v3m4OspTHBGWgKGx00bGI0hkCvg/4zVm//bocj4Qrn18yeaAkyO5uKPPc5Ct
 wuZ70XJbmSLmPSdwc+vyMLUOWMvsmZuDkIOvnxdlsWQ5ZmKRgs9/es5kH1DY4xFXXdAz
 9g69uGvUM5AQS9hrk09O2zobnCYhDou7nJjIwf/Dz/jjA2CbsZ9CeOqjsC7/kmcg47/g
 dhm8vzHt8Tvu6nX0BMWK/XMzBuxriMl4ayZKfXOAdoQVwA50lSki/zi8098oXMj4mhqP
 sHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249484; x=1785854284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+rpTuAFnEX0r6tnapx9f3/h24BIC7xRoBuN6ZeEnOCg=;
 b=duDHyfekT251pKhAAiYaL38SXj71uEwL05TNO2jYnARlDhAtsa/lmIj/CiZNet+4Un
 4lc6jL/NDbX6JHVrI6y+PFs9aNu30dZ0zIuVBHCuUKibgDe0c0eRvLnfohvf+GOSG70F
 tRnfo5B/ABNIe7NCeiLxgcJyWvMe+Fasrc9C4vA842ugVPSl8gerO6NgC80m2pX06rSb
 Qdbi+VwJi3oCDJ+LaegeC2iBXtbI5rRnkXEmw3Sf1IxQJUlXFQbrG/ru1ds7qfoHFRLD
 gP2enYBsNIjtdzjyMWm1eXYTlwEvEHsVviHKDIHQl1THTbqjPg7x/9DuRMOHJ9bsK4CJ
 Eqbg==
X-Gm-Message-State: AOJu0YwUQAmUz9hZionPlR4h/nQ0MHpvvzSjufk9QjJjYKYzQxXl8yUg
 BjCrqmLTgCgHkdQiPM9dloGQoWQ2Jm0H6rNF15dp7Whp30FEkpYtximfhvAEsCQwXqSW63/+ezv
 kkJax
X-Gm-Gg: AR+sD100dOUZ3+nRqC2kjwQhIb6B2PzIdaV7iYUpRedRFWgm8DV+yC7TdNS3enN7osx
 vLMuaYofg8vCseacIh37uwG5gB6ssosbT5i65bEx9BtrnVwPAP6m6qBCrbuSNtqrzjDD++zjq1n
 xmxQp9q4TrE93S8w7knwWWE/R7cKAiRd0Iq13/QGbIyGS15/n2xD9/CicdJyGgQaTrnUFNgvVC8
 SG7MUk8MqMdwphzd4OnwQdbh6bBGQztZv6d4JETswUKr38LyEJ0jBIfR5qX6wOz0zQDSZ7lBqrl
 c5moi1+70cNea+mpEN37F8h4YFFrEXFAgmrFFA/9Boxej48XAJcZsEkde1LtsNt5hmEltRy2ijt
 m0cqaMIRjP8+B9CNgTO6Ca62YREd1olSqLdR1VE6HMembHNQxSofjN+E8PeVjwNwyUvlwnLL2ix
 gDMvRqM8zLkus/m7DtGC/ZMcyOzWSrBHD6o5j/BcI7DlC8uZuyXTI=
X-Received: by 2002:a05:6a21:a90:b0:3b4:7e2d:a3c2 with SMTP id
 adf61e73a8af0-3c8aaf8d309mr3540433637.18.1785249484472; 
 Tue, 28 Jul 2026 07:38:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc415eafsm46108985eec.7.2026.07.28.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:38:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH 1/2] net/sxe2: replace memcpy with structure assignment
Date: Tue, 28 Jul 2026 07:37:59 -0700
Message-ID: <20260728143800.148509-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

When possible prefer structure assigment over untyped memcpy.
Found by cocci/struct-assign.cocci script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/sxe2_flow.c  | 7 +++----
 drivers/net/sxe2/sxe2_ipsec.c | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_flow.c b/drivers/net/sxe2/sxe2_flow.c
index 63cfc36968..6c2e743f30 100644
--- a/drivers/net/sxe2/sxe2_flow.c
+++ b/drivers/net/sxe2/sxe2_flow.c
@@ -416,7 +416,7 @@ static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
 					ret = -ENOMEM;
 					goto l_end;
 				}
-				rte_memcpy(flow_new, flow, sizeof(struct sxe2_flow));
+				*flow_new = *flow;
 				TAILQ_INSERT_TAIL(sxe2_flow_list, flow_new, next);
 				flow_new->meta.flow_src_vsi =
 						flow_src_vsi[SXE2_MAX_DRV_TYPE_DPDK][idx];
@@ -437,7 +437,7 @@ static int32_t sxe2_flow_src_split_proc(struct rte_eth_dev *dev,
 					ret = -ENOMEM;
 					goto l_end;
 				}
-				rte_memcpy(flow_new, flow, sizeof(struct sxe2_flow));
+				*flow_new = *flow;
 				TAILQ_INSERT_TAIL(sxe2_flow_list, flow_new, next);
 				flow_new->meta.flow_src_vsi =
 					flow_src_vsi[SXE2_MAX_DRV_TYPE_KERNEL][idx];
@@ -697,8 +697,7 @@ static int32_t sxe2_flow_tunnel_split_proc(struct rte_eth_dev *dev __rte_unused,
 					ret = -ENOMEM;
 					goto l_end;
 				}
-				rte_memcpy(sxe2_flow_new, sxe2_flow_exist,
-					sizeof(struct sxe2_flow));
+				*sxe2_flow_new = *sxe2_flow_exist;
 				pattern = &sxe2_flow_new->pattern_outer;
 				sxe2_flow_new->meta.tunnel_type =
 					SXE2_FLOW_TUNNEL_TYPE_GRE;
diff --git a/drivers/net/sxe2/sxe2_ipsec.c b/drivers/net/sxe2/sxe2_ipsec.c
index e783a51b85..81cf250fd2 100644
--- a/drivers/net/sxe2/sxe2_ipsec.c
+++ b/drivers/net/sxe2/sxe2_ipsec.c
@@ -1159,7 +1159,7 @@ int sxe2_ipsec_pkt_metadata_set(void *device, struct rte_security_session *sessi
 
 	md = RTE_MBUF_DYNFIELD(m, sxe2_sctx->ipsec_ctx.md_offset, struct sxe2_ipsec_pkt_metadata *);
 
-	memcpy(md, &sxe2_sess->pkt_metadata_template, sizeof(struct sxe2_ipsec_pkt_metadata));
+	*md = sxe2_sess->pkt_metadata_template;
 	md->esp_head_offset = offset;
 
 	PMD_LOG_INFO(DRV, "ipsec metadata set, offset:%u, said:%u, mode:%u, algo:%u.", offset,
-- 
2.53.0

