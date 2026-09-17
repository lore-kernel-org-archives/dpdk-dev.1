Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64142C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 15:33:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBEBE42EC6;
	Thu, 17 Sep 2026 17:33:04 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 9F31D42EC6
 for <dev@dpdk.org>; Thu, 17 Sep 2026 17:33:03 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso1052550a91.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789659183; x=1790263983; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHQV8WKj7MTc59ROXa6jyF4Xd2W4BHY2UZh20CI58uc=;
 b=FzNYQBhk0zxgc0v4HOh1bG9EG2yveGYklPPqiXWbqmhjy2lZk+qAhKVns5QMkg0QXy
 eX/ZnMe4ZEV6fVOZGrl3yLNxyFJ8wIZB4M5Mbl7rnPRGcjhxu1l2n2IUfa7R+Cufigg8
 +N+++j/clOQvp+sL5qHy+OCYPf08I5heLpo7ubmfgkp+ISB8XVEgQcSUf1CI+dc+DUyS
 WJbeYmCJySm2rHNfEhacYTLDbdPIoSj0vmb60VC6FzzBGuhoFaP8npkIH4AXft/16Whh
 PHpU6ha7dcE62IKUMcqM1gLDn80NkxziB6R/dtd3mWni9CN22ir5kiMdIvZZ1krdUDLn
 SNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789659183; x=1790263983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHQV8WKj7MTc59ROXa6jyF4Xd2W4BHY2UZh20CI58uc=;
 b=tXF7eDw+HzbN/mJRu3gW1mdrJhIwkmc7BLqqZNjW3ZyN6I+osKJnIa1QgTopo0OLPH
 fN3BOPCYHKyRO6EjK4IqDqa5B96FgbwHDgkjHgumSv2KQ0nVaa8nGOrmYUC72j2xTDjI
 HoR1zYrHzcqqCvUPLFtPQToLHnvitHA7qfUpN9XeC1VdIIIIJVFsjDoKw2zO6t05qWOu
 0cugCDFGr+nqXaSzf8kt/4B0aM5pWOuV/ujbeqU+gjPwl15DL6fVzsmbtJBIzULvUB39
 /zIn3N3Zem6z51OCL9I8FZwbewtD5rhB1lnxL3CeGKqv9v6ekFwU20xqhX4/LQP6fTyW
 45eg==
X-Gm-Message-State: AFuF++mnTvFAwkisOuno5RuOzBarBEfoU82OHOubQyfNEMORCYpcEOoy
 v0+vtQI+wFvCcbj1Cl1Wg7SY+yV5ESLHgPF8MBjL8yBX1Sg3ZfU6tngi
X-Gm-Gg: AYBFou2bvVxwmW51eUbGqwyZ3BlNXoHK5wZYVfuGKBzGCjlhCcofINbKU+8VrcPnonS
 P+B0Mg5tuRK1r/v8VTqty7BBwSumuTSy9mtFJmUoSLDVlhdpPwp7Z08RZpczMBEkOR0Q2jFuzMT
 nPprrgPw4dAQp7B8wNFkk4L1SCu/J0DhYB0yiSPQR2LhplR2FfqIaY4mNLure0DWcP3LhFrOZld
 b63nV8B4WL1FtVICs0Xw93zAYSf8zzffcHHT1ywosxxhsF1mf/TEgEHGsr0Lcp7c0RenpdbrrF7
 PFmScq1BC6XeoRjV2b/5H0zg47BiTwtTMTGkXryaPfsgnEYj/BrOuc6FCT28u9aI1d8UvU2Kwa2
 KtbmtZPiOAGOwfn6sRk0HpUHQl4LEel1olRznTxS+qJi4BX1GDzX3hdaMqdiOqC128vhsShRS4d
 BemRulw+wcqH54YVc0XqPhIQ0WPuTmc0IZL45V4zr1DniuytdkJHEAZ8+bVqPvNS2NzxEISXAu+
 e/eCcM=
X-Received: by 2002:a17:90b:4a81:b0:39d:f773:37b5 with SMTP id
 98e67ed59e1d1-39e1df6193cmr21504326a91.0.1789659182644; 
 Thu, 17 Sep 2026 08:33:02 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e35df6112sm5730350a91.7.2026.09.17.08.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 08:33:02 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v3 1/3] net/txgbe: fix L2 tunnel error on flow create
Date: Thu, 17 Sep 2026 23:32:40 +0800
Message-ID: <20260917153242.29315-2-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917153242.29315-1-zhtfdev@gmail.com>
References: <20260916131106.105667-1-zhtfdev@gmail.com>
 <20260917153242.29315-1-zhtfdev@gmail.com>
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

txgbe_flow_create() continues to RSS parsing when L2 tunnel filter
add fails. An E-tag VF/PF rule cannot match RSS, so the original
error is overwritten.

Fail the create on L2 add failure, same as ethertype and SYN.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index eaeb973c91..76191a7c2d 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3449,6 +3449,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 			flow->filter_type = RTE_ETH_FILTER_L2_TUNNEL;
 			return flow;
 		}
+		goto out;
 	}
 
 	memset(&rss_conf, 0, sizeof(struct txgbe_rte_flow_rss_conf));
-- 
2.53.0

