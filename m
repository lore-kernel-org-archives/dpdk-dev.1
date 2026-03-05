Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BACF47CA4
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:54:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 720C24270A;
	Thu,  5 Mar 2026 18:53:45 +0100 (CET)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 90456427A3
 for <dev@dpdk.org>; Thu,  5 Mar 2026 18:53:41 +0100 (CET)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-899f27df3d1so49953456d6.3
 for <dev@dpdk.org>; Thu, 05 Mar 2026 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772733221;
 x=1773338021; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWpL46rQm/yUDM2YKhRF197Z1peuIY5g1L2zZ2gKFNg=;
 b=tQ5OVWa6cH0i+42V0tY3atKhW6tC4vkEXQvo7El0oYJFRiu4HjuGxdRl1drVREIhnF
 1s1ZH80eO16aDhot+ZBmIskj1GUDwHLEatpbLHKiXBjc1+AaLBhMaQbZl34IC7Cc8Kt2
 8Vv909xXL4Z+HwpDCBHMbxHfwPdAxfzQiG8I33oHm1kOfVLSIYWxhl6zydG6dZjJlt+Z
 +ZPmbq2ZfTsC1n8vpWhCxCVcuH/j0Akq/0t1+jW1QMuVNG1XmZneyGAGkgUn58hRjZmA
 ryRf0bprK0X9prFXqV5FGgvtbYx6c1wJBW7OWXG9KBUKGF5ZZqssLU/bxJ/wjYpJ/p3L
 29qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772733221; x=1773338021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWpL46rQm/yUDM2YKhRF197Z1peuIY5g1L2zZ2gKFNg=;
 b=c1VoOLPbOGZLnwFScwXoYFNVs48b8DXW2hlIgdGNacz9zSC/gol/womN6RKLM53imo
 Ymd5CJcSVx3qjpm3oIDKUpvFI2wa95pMzocmSPpBMBCMotW945baVBiwfTO+FaJGxEzr
 v6tjEuoSkDBGwu03QxtHBPd+gCkyRcsryxmnScoi1pgoVsqAJLU+/WUGtM736ar1tIni
 53Y7jeuQ549SBAdmynyOWtfSA6V4TR62kDfBbXP8t6U2GeEhtC1Xk+69vPOwVk9720jJ
 GkPBo8PXuxFzAH7DdKGG9j9bnXczW/coZYm9EvssBghJ3RpzFggItRIYsTIKYqhoI6Tu
 qaAA==
X-Gm-Message-State: AOJu0Ywh6i+fRf0zX2qDhA/9fSoTQW16TQaHrcuZsYHCGt1gH+pE+92B
 Z/omwpntXXKhX7chJ8id5o78o9CnUnEMW9Y1wJqpmW3lqDSzFiV5VFU3l2GboI6Ii73laq/Y3BN
 9DGGl
X-Gm-Gg: ATEYQzxxvQurBAqXXUymQ9kY0WO37mcLRkLTNTZmYmGyfzmt5Fby9XfTOwL1ecvF2t2
 oIMs34SjCKoiRt361rVPeAYSm4v5PVlxOUNzqy80aLq1WYQN/KDewYpsXqES8bMH2cBywJ4eeco
 g+Rs5fRWLuKLEhbdfSt76P+tZrLNB/M7dSad40lqziBKZvQt2T2DbgI9i/TEXQknR7qqo1VJPmI
 Rnyz65qFSBFWq1eY75xNqitIDGAkYCuOxbWY0zGlHGGMYGf4cfEUtZY/CK91ro4a9kQ77lirM0A
 8AKLRRiN8Q6pO+zoMw21dJ+GS3ON13+9rTdQcWpoHUnkVaxovoP1+9noURjt0B4pP6X+hqnkZtU
 OV4QzhDqglEsIKIuxq0DOljhknldWqIxL3wq9rJRBUDF/So9kFtQGmUNnDsOnaVFBUQqkm8Qwnu
 BCynEnLra6TXV6HxbJtCkq/VSjmml1fMmCJ8rs530I/r2yqMMeLTGoMFi/nm8OMg==
X-Received: by 2002:ad4:5946:0:b0:89a:149:bef7 with SMTP id
 6a1803df08f44-89a19aeeba0mr99446016d6.35.1772733220868; 
 Thu, 05 Mar 2026 09:53:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a05b72186sm80667766d6.50.2026.03.05.09.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 09:53:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 09/11] test/bpf: fix error handling in ELF load tests
Date: Thu,  5 Mar 2026 09:51:03 -0800
Message-ID: <20260305175326.279891-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305175326.279891-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260305175326.279891-1-stephen@networkplumber.org>
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

Address related issues found during review
- Add missing TEST_ASSERT for mempool creation in test_bpf_elf_tx_load
- Initialize port variable in test_bpf_elf_rx_load to avoid undefined
  behavior in cleanup path if null_vdev_setup fails early

Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 093cf5fe1d..144121ac79 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -4231,6 +4231,7 @@ test_bpf_elf_tx_load(void)
 	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
 					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
 					  SOCKET_ID_ANY);
+	TEST_ASSERT(mb_pool != NULL, "failed to create mempool");
 
 	ret = null_vdev_setup(null_dev, &port, mb_pool);
 	if (ret != 0)
@@ -4315,7 +4316,7 @@ test_bpf_elf_rx_load(void)
 	static const char null_dev[] = "net_null_bpf0";
 	struct rte_mempool *pool = NULL;
 	char *tmpfile = NULL;
-	uint16_t port;
+	uint16_t port = UINT16_MAX;
 	int ret;
 
 	printf("%s start\n", __func__);
-- 
2.51.0

