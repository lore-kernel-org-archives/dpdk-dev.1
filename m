Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C4C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F48442E6F;
	Tue, 29 Sep 2026 16:04:30 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id DC57442D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:22 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88098db8dcdso1756796b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690662;
 x=1791295462; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KM6r2zVG4yj9TYazaXeRVzV3DSEuDfwSAp9skLXZw38=;
 b=dMSQSCAgtsbmurqO7O2LVE1vYAlonJGXavrYLSWIFffSCM+5oPHO4Zh1ATwe98Dmtr
 WzRcsNiGsCL+mz5GArL7qTNjsyU7cPvLYBDqTkv5mqLEQDWkRobMJYgcXQe2LOHQlBxT
 9F/HokvjMqAD7n+V1sDE1G6fSio4pKlYqxip9smn5q9QGGTrwG40WPRnG/GdFL0NeuIS
 miOMi54/cP4xFQgKNgLCvDKzXt8ALJv1AYwSFRd1OEVC8j+9fjo4n7ANsrAVJHDFxj2U
 cFlzF05Bs6ecjGZ0rukCNjCIgVeNAemAIm+l4iEbXdJ62YDRUI7jMfYDmRVjkRw7ytiG
 xNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690662; x=1791295462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KM6r2zVG4yj9TYazaXeRVzV3DSEuDfwSAp9skLXZw38=;
 b=RQ2HyBt1Hl/Ij64WokjjomSvTlyAxnLlx0stSLQM+2eGNdjGAWd7fSg1VKTO7sz53C
 P0QBn9gueaxtFrhHzHrZj3AG1e2couxr7LLVbmNl8V106wGnxc/vq8uuAilHrdx5I3zI
 FMUPxvYZBqAeDA08yOxjidnXFExbJC0/x/fw799lUattQmzBvl9z/4dUjYPKbyf9rikl
 A/n4ApZQn+bvjHU9Hl6IoFHZJXkKE8QQKYeZJvymoE+yJ5AgMOJwA+HjcmuHFTFd0i+i
 gwCrCyXQccUjEC1g+akIr9+sOxhJNfUB6tPzd0sg3B1W8YvhwtKhB3MIirC9r5NqUKV8
 FCWw==
X-Gm-Message-State: AFuF++nM9s7wjzeQJKl5EVqccHlEl5VmCHO0whSpOMUa3PIT9DgBiQeV
 /E0HATERHyiEPy4KSEp1kjpWmp71LbAht84E+nIB39QMRU/STGAOAepLkuhKBr6JgBwjNayMUeB
 kr2UfC7U=
X-Gm-Gg: AYBFou1evRr2RZcpGPzP48MdLbCNTZBK8Ds7wLVn1rUtNmk3eUbGp04HI/CzdXM5ezo
 4y1DtoVpXW6Uc7Y5d6hm1zXWP4FlTAOcRuPE9mljBtQFZSF54TwXSZsbNvSl5JRESV4s1sGpho2
 t+7aR+1CdrATWktoDoBAUm3aF3DVIfPoQWJgDctoXwN5qeca6tTFNYkfvWDLMawjpju4KdZMQ6X
 fkFIihG8BDCTxoRyIbvR092t27aG/BcgoydRDR5UIhAIqVf+tHTNbzohQno/bzjc3tvxDHu0Yij
 uDytvLlQGNMNyHDe+jt9mRUQipyzAqxVx+AHekeuYAQY4xG4NgRfHyRoAqLQpj9gqzGCZEyoEHX
 mCMbu1MBGKaIt4pF6SXaAx0eISXf3XJ3tYHHPB1MlpCDuwY6D8epCSfQH97/tTlTJf8JgxQK75m
 V8MTZnPXRGXP0OBTNt+VyUMi/7cpdEqy1i76i2xZtxqZViLwL9m69SN+clk+rrr98TprIl2DFLt
 lVauHrHv04WutgvAGeFjHQO7nXxIrHL8OSh+M5AA1fm7OluhQ==
X-Received: by 2002:a05:6a00:ae12:b0:882:e366:d99f with SMTP id
 d2e1a72fcca58-882e366de34mr5193285b3a.51.1790690662041; 
 Tue, 29 Sep 2026 07:04:22 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v9 10/25] bus/dpaa: remove unused in_use field
Date: Tue, 29 Sep 2026 07:01:56 -0700
Message-ID: <20260929140409.234453-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
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

The in_use field of struct bman_pool is set once in bman_new_pool()
and never read. It has been that way since the driver was added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index ee4232d0a0..944170528a 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -62,9 +62,6 @@ struct bman_pool {
 	/* Used for hash-table admin when using depletion notifications. */
 	struct bman_portal *portal;
 	struct bman_pool *next;
-#ifdef RTE_LIBRTE_DPAA_HWDEBUG
-	atomic_t in_use;
-#endif
 };
 
 static inline
@@ -224,9 +221,7 @@ struct bman_pool *bman_new_pool(const struct bman_pool_params *params)
 	if (!pool)
 		goto err;
 	pool->params = *params;
-#ifdef RTE_LIBRTE_DPAA_HWDEBUG
-	atomic_set(&pool->in_use, 1);
-#endif
+
 	if (params->flags & BMAN_POOL_FLAG_DYNAMIC_BPID)
 		pool->params.bpid = bpid;
 
-- 
2.53.0

