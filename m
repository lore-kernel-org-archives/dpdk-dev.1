Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829BBC021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBA504065F;
	Thu, 20 Feb 2025 03:35:33 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id BCE75402DB
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:35:26 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2fc0bd358ccso882987a91.2
 for <dev@dpdk.org>; Wed, 19 Feb 2025 18:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740018926;
 x=1740623726; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofEEZSScqvsIoCR/saAoH1DxNdeCB1dkw8HHAvdWCtw=;
 b=YG/8jrJkxWxEVzDfLRZT2lWPQsge6xNTDS22iLVgAUn9guArRLv5IU0U4Cp4ypw4+f
 waZhPlxGRt9COqn2DFMN2Lt10E2nfpCi7tziAOE97dt5mVHPVRI7QVwHytoAcvj7kwN1
 TtYi9E4NX7Vrb/AttCkCgRkVTOreZuaen7VPWVdAK0ZY67R+wxKDXg1MGJCKbuxa6Syp
 xJQSpoBjz6Sw9fEDYHa+Z2bE3A5tVK4hL9WM6A6JgM1fG1uS2H9RbEMm8o7IJgMZDUcv
 iAYaSJpVYAJxUkRkl5fKvC29PkriM9p9Soso+AVpjEq6Iiba6Tq350l+ybkjr9xU9/Rp
 J3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740018926; x=1740623726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofEEZSScqvsIoCR/saAoH1DxNdeCB1dkw8HHAvdWCtw=;
 b=iS8QUKvVLVLAsKvD5GpwjDi28GJZdMHNpWoleQVydHqy0pZFqQDpudz/9SgsCxmIBy
 0hSOu4cKfo9NA5ymeA5MNaqTB21q/i7wfkf/xx0l1sOogTM2ruMILoBz6woa1/875Q/j
 HESB7gYpta2mwQ3LTQoiD45SoVHRZ1Gpq4WXu/UFF3TSXFVUlf69LqYAeO9cGuqSQxPs
 h075w1HOMRnZEjRNSSC3kHNkPhLaldYNuSNWSvjxy9e/UF+xt9nT7812OLYOljpP7bM6
 WbrjZVWDAA6zEhQ/5KuWh33Ua2hac803RmadVgh85G2NNohcSlgMqvg+X+N5JUgMh1wd
 snKg==
X-Gm-Message-State: AOJu0Yw520U2VX9ya8jZWE/t2TNqc1QY6C3/7m2rrhisJg6+rFDUKAci
 ccSIR4ueW+J7C1ecxJJq2S6wzmDqLpfo0alzA3lAcQ5GVX9t3k1aNHGtoCBH9Ubk4GTzkcmyOWT
 b+w0=
X-Gm-Gg: ASbGncuR9L5f9+Psxt1LVZc1wO5Wnv7ZpbvzFgdprdTGZIfC5bM2GLTQ/gOxlry37Wq
 L8tq/Bw0w0cmajs16dxCJDx464vIu6bpnph9Vn4Dn3VVMSFCbJfd8oCAB0KV/k0TYdImCiDdGhh
 S6qZcN/FxL25X7ZNTKu46p33c6hmG2GaQzqkgDCxOkkMK8lkMLQtO4eoBAuR3cLmxepnVN5TJZn
 aYp+bcVP2g+2P+tldyfpJwmTT610XtuyvkEg7jy2MGDpCn467kweqPT7/Z17RmW8lxVxvoBVdIv
 iK/kfrMQC/Q9f3WBfEyFWIUz1v2qS83LiuYC1bt95ohYC+FY3oRTd3iLbILbWBcyigPh
X-Google-Smtp-Source: AGHT+IGNekcrUpNcngZ4jkq5Q99i4dyXXQ4a9d/yLF6XHdPqj3YMQEsI4eVTE22LYYCDnGyXYVvozQ==
X-Received: by 2002:a17:90b:39cc:b0:2fa:229f:d03a with SMTP id
 98e67ed59e1d1-2fc4104056emr26164835a91.26.1740018925970; 
 Wed, 19 Feb 2025 18:35:25 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53490b6sm111668345ad.16.2025.02.19.18.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 18:35:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH v2 06/14] net/memif: remove unnecessary deref of function
 pointers
Date: Wed, 19 Feb 2025 18:32:10 -0800
Message-ID: <20250220023509.630569-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220023509.630569-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220023509.630569-1-stephen@networkplumber.org>
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

Since queue release functions are local to driver, prefer those
over dereferencing the dev_ops table.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/memif/rte_eth_memif.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index c0bf1e3bbf..f7b04c4f9e 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -70,6 +70,8 @@ static const struct rte_eth_link pmd_link = {
 
 static int memif_region_init_zc(const struct rte_memseg_list *msl,
 				const struct rte_memseg *ms, void *arg);
+static void memif_rx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
+static void memif_tx_queue_release(struct rte_eth_dev *dev, uint16_t qid);
 
 const char *
 memif_version(void)
@@ -1418,9 +1420,9 @@ memif_dev_close(struct rte_eth_dev *dev)
 		memif_msg_enq_disconnect(pmd->cc, "Device closed", 0);
 
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
-			(*dev->dev_ops->rx_queue_release)(dev, i);
+			memif_rx_queue_release(dev, i);
 		for (i = 0; i < dev->data->nb_tx_queues; i++)
-			(*dev->dev_ops->tx_queue_release)(dev, i);
+			memif_tx_queue_release(dev, i);
 
 		memif_socket_remove_device(dev);
 	}
-- 
2.47.2

