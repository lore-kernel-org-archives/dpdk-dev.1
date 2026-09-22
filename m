Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01398C982FA
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:53:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CAF3B42E5E;
	Tue, 22 Sep 2026 17:52:54 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id D5556400D5
 for <dev@dpdk.org>; Tue, 22 Sep 2026 17:52:52 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85f0fc1fd8eso43091b3a.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790092372;
 x=1790697172; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6BIDqLYP8xUDQLMvFG00cdsE9ti8SR0I9ILjwAH/lrw=;
 b=wMQ+ZOqsNl6CelfLNgNaiAy94B96xoS7Bv3/1q0LZiJsLX84K6sxetcxZ/znNpb+j+
 9r6W3r+Mj6r5Vv+fdVQf+KXtuVB/CW0R09nX/sHjDPz5z9RMRizLPHaqOT8K/+xopHOg
 j0zRQ5rS+gfQBEMsc02pT0XcY2ubMUsIDjf2WbalHk7o+LtXIUiLt3zSXb7XotDmI8zY
 CiPkdPyWj1+nJj7djMkiAs50KtA4DFndjiJnmf8UOX9jdqDuTVc2U9FlEH0zqRWKP0Ei
 g0XUuql6x3ElUz+OElTPyzohLLeRIDFbxDHPkTYxSQP6WvaWe/Jz6nX971SLVKT3jFrd
 oL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092372; x=1790697172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6BIDqLYP8xUDQLMvFG00cdsE9ti8SR0I9ILjwAH/lrw=;
 b=VT1OpHeUMcAbtbNtKo3tAsVRuhYVco6rxtZuixo5IA04WWI6H4llbBQKPSOSxoun/A
 IPrfBduWRzPDhvpTZGUqC5IIvn5tSqQHOmI9qwKKLc7wAa2l+MLQ+zbE0qbkI/n2H3WW
 idMwW7fgRkX2DQKBMunge1t8O9pJILz+RkwQ3VrqxtnMeV2llTrsKA3RMLRZ7zSz0Y8w
 OEvwT9Ni+ay1OhjBpJaOZIzorWsHHJKZUJjSoldiPO9poAWKeXb8rs/EFLzT2I/7sxHJ
 SgGntVR56pC0vXB049ZQb9bmtvngyZ3dJHZFcBm40vc9LfUVEm4RqD2D5TO+IF5B2kxW
 X6PQ==
X-Gm-Message-State: AFuF++nEC0iWyNfjAnSTxq6RlgL1Ofmwlc8JGC3sSRZjkPjM2mHpceM8
 hUbyKP8e0oaiacOTjieRbHJikwgWvyracf6+7GeKPtRTSQxthnALteYwqcX/HwGnG+j69ZJnd7T
 y3Vw7
X-Gm-Gg: AYBFou0w6hXq3Q1ATNL0K48lo4dg84nktHcrDu+MIcla4wqNyAt+Lr/Mbqv+PPfnL/h
 YxiUorc9bdFOQuc/s70yuE7Blhk9kzVDKhY7gHjHEgMuyaQB/kTh5WNEeXC8e8YnVRNCtREflGa
 WWaZBw7xlHBpt5bzZQdozwTE5PEjC1HV0BJuCYcmiRlzosO00U5wQHfs6j8zby5Pq6/DCUHiidX
 o5/G3Nky+/hXZe/IlGqWB4PK/DSbvBrUSWev460rc9Y/+BmWRxCR+zfq8rcWC/SddUZPu113/yn
 gRMiN/TkMfXAs9Lklmpft0DOjpOnJooUZ6RgFe3Vlv31hyKtt9SLTGibdBOzcN805mWWdCxoyFp
 QHngl/neL0HhpSaBg/zqMMUYYi3a+ugSvO7DqUQ4S/OmNmSEyWUlVaCthZgeBNudEvaWcCPfYq9
 VPyING/ausnM9+JnRYezSp7kGxy+ZpG3Gf5Wj87QrJI18rzYYB4WjAxigepFl7Ah+oVgdqNyexM
 ywZN5xCqdoKJ49tRVXbJh/kzGa+fcHnxUROHg==
X-Received: by 2002:a05:6a20:728e:b0:3dd:a00a:c5bc with SMTP id
 adf61e73a8af0-3ddec7c0c5amr2066616637.47.1790092371839; 
 Tue, 22 Sep 2026 08:52:51 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756b5c2e7sm1219347a12.27.2026.09.22.08.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:52:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Kai Ji <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>
Subject: [PATCH v2 1/3] app/crypto-perf: fix asymmetric op pool name size
Date: Tue, 22 Sep 2026 08:52:08 -0700
Message-ID: <20260922155249.3115271-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922155249.3115271-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20260922155249.3115271-1-stephen@networkplumber.org>
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

The asymmetric op pool name buffer is 32 bytes but snprintf is given
RTE_MEMPOOL_NAMESIZE as the size. This is harmless only as long as
RTE_MEMPOOL_NAMESIZE is not larger than 32.

Size the buffer with RTE_MEMPOOL_NAMESIZE and use sizeof() for the
snprintf limit, as the symmetric path already does.

Fixes: ba588ce3f933 ("test/crypto-perf: test asymmetric crypto throughput")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-crypto-perf/cperf_test_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index 0bcaa6dfd8..b2eabf470e 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -145,7 +145,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 			struct rte_mempool **pool)
 {
 	const char *mp_ops_name;
-	char pool_name[32] = "";
+	char pool_name[RTE_MEMPOOL_NAMESIZE] = "";
 	int ret;
 
 	/* Calculate the object size */
@@ -154,7 +154,7 @@ cperf_alloc_common_memory(const struct cperf_options *options,
 
 	if (cperf_is_asym_test(options)) {
 		crypto_op_size += sizeof(struct rte_crypto_asym_op);
-		snprintf(pool_name, RTE_MEMPOOL_NAMESIZE, "perf_asym_op_pool%u",
+		snprintf(pool_name, sizeof(pool_name), "perf_asym_op_pool%u",
 			 rte_socket_id());
 		*pool = rte_crypto_op_pool_create(
 			pool_name, RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
-- 
2.53.0

