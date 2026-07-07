Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA75EC43602
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Jul 2026 11:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89C5B4067B;
	Tue,  7 Jul 2026 13:44:44 +0200 (CEST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by mails.dpdk.org (Postfix) with ESMTP id B4A3740264
 for <dev@dpdk.org>; Tue,  7 Jul 2026 13:44:42 +0200 (CEST)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39b315585a4so28281081fa.0
 for <dev@dpdk.org>; Tue, 07 Jul 2026 04:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783424682; x=1784029482; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TYrUs7kNN6vdlBhJYWjUkgdtLCM4dlH2VqgbTXuKR9g=;
 b=Mn/2hf2qSuwcQ5blFdeg8UXUtgC6EZPJ350MWIM/x0n61YrnQw2hJv/VTqxmzuK+BX
 eC1l7OnSi7Y54pEnAN3Ns1Vj4awfiLc1LRZwrl6mDMpmw3YBRHQOwf7663mlj1HQ3SNC
 rl57ajerFuagHwGAVm3PzGhdIqBg9yBaAiXmKP799b/DS7ozIkQfMSSv/5QDgB5+w9cG
 fwEsUZhV9ImZQruKZkna8uz6yVPN/9N6uz6PS9hqNbHi5qhfjaGsFHt5C6CpiKBoIIkJ
 AykqnWU7zMbevcoE5lDS5krFHEzQ0sfvng/mFwY1kDyfyndXV54WU5HWBo5c0LJjLUXX
 9LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424682; x=1784029482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYrUs7kNN6vdlBhJYWjUkgdtLCM4dlH2VqgbTXuKR9g=;
 b=rhKRroe9UX8EVkxiQ/8xWs3ePYlqJnl7EXz2p9ym7OGZo28Q/cN///ZYc7+EI5rN0c
 hRtVghpfQ9UyXqrfhG3LedPCVlth51nla/kd11jX7kD0ssR/Vrkfn6D7gFagkRYf66Uz
 ULDbkxhzxT46JWx5G2qoBcd5eYY7TPJ4R83xGhTuNNH15kTKdfVyZNwM5VFmx9uWEVpI
 mR2vE5HWQ4RVUFXzJgXhDU0UbgBT+hAsnz3PzofsANNHOtXdMMjY1mSdmY7gMvrTuW+J
 2ssCWMRuqzLcbgoBOKagMU5d5DFHfqAQwxaKQRJNW8+z7TzBjqbkKW9cpIv5ZG/2b8dz
 CXqw==
X-Gm-Message-State: AOJu0YytcVc5ufEE7KEBNvhM1pdOVvEv581kiyVgch1fKDQP4Mgg9JFa
 aXv8gsmVnOd95iBGH1PZVVrnhKp/6VmrJXUwxJzTY1XoF5POPPXOQuzO
X-Gm-Gg: AfdE7cmE6bHVUhTTSsP6GJrxdkEIWj8ldYDc3tpLDYn+VTW5xztd6ZJlgAdrsN+174Z
 P3n+893O3yCcAwK2lwIppPumKsXZE6faEUJuNLGpdmu4BNPdWyPa/nybnsxUu3iRySNb4aJlajW
 EMLZibZYXcrPHP24NmDCEVXAkC1xMiCSM3gQD07bRjDPUT71NDzB/aNVezHfeltLbzdNd2r+q3X
 +CvNNcX5NXgpjb+S71oKzgMO0Ef9gzijCqq6mXkY8begJrh4nsEnrcAFTxCIsEb7e+2fepFY9rN
 Q5piYryY46cPR4Ki6zIliVYi/hmGfHPZZPVlmc7BS1NeA8xPK8Q2wpoI16q10ZHDyd9L9vonm8o
 87jzZYl6eEmaO7q9cbkhoP+zG0+kH00rilVe/uLQzu/fVTFON64hrbbu9/D72K4YK/+vg18ewEP
 1GWJx2mVd5dRA0n+ZI1Sf+zwX29sWMW3itm4P7cQc6GwcJzrou
X-Received: by 2002:a2e:a99d:0:b0:393:5c4c:c482 with SMTP id
 38308e7fff4ca-39c5fffa085mr11336291fa.29.1783424681652; 
 Tue, 07 Jul 2026 04:44:41 -0700 (PDT)
Received: from home-server.lan ([31.204.104.167])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39c6cb8a5bbsm2136421fa.8.2026.07.07.04.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:44:41 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: John Daley <johndale@cisco.com>,
	Hyong Youb Kim <hyonkim@cisco.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH] net/enic: fix null dereference in flow query count
Date: Tue,  7 Jul 2026 14:44:36 +0300
Message-Id: <20260707114437.94425-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
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

begin_fm() can return NULL when the flow manager is not initialized.
enic_fm_flow_query_count() did not check the return value, leading
to a NULL pointer dereference on flowman_cmd() and end_fm().

Add NULL check that returns -ENOTSUP with a descriptive error
message via rte_flow_error_set().

Fixes: ea7768b5bba8 ("net/enic: add flow implementation based on Flow Manager API")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/net/enic/enic_fm_flow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/enic/enic_fm_flow.c b/drivers/net/enic/enic_fm_flow.c
index 4b0a513977..28e2a9c1e4 100644
--- a/drivers/net/enic/enic_fm_flow.c
+++ b/drivers/net/enic/enic_fm_flow.c
@@ -2904,6 +2904,13 @@ enic_fm_flow_query_count(struct rte_eth_dev *dev,
 
 	ENICPMD_FUNC_TRACE();
 	fm = begin_fm(pmd_priv(dev));
+
+	if (!fm) {
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			"enic: flowman is not initialized");
+	}
+
 	query = data;
 	fm_flow = flow->fm;
 	if (!fm_flow->counter_valid) {
-- 
2.34.1

