Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0369ECCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 18:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D11840662;
	Wed, 29 Apr 2026 20:47:48 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id 18DEA40668
 for <dev@dpdk.org>; Wed, 29 Apr 2026 20:47:46 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2ed0a45e970so155633eec.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777488465;
 x=1778093265; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuy788aOdFARzouujqA6ny/LQ7HkgncWPo7VgBva+64=;
 b=DlbSxQA38+uhEdKVokvvP279hfDPFyaT8eV9EER+c0wE1CWVCSzgNEwdyO1VJQ2NOO
 egkzKMfmwEdMkK3KmBdw/MJ84KsxXaOvdM6RB5zI2pUEQY82z4Ohdc0hg2KRDqIWPE9i
 InMOoWuOwaeZMT2y2IOOnwDFHc3t9oKIExHsvVy0nGmeU6sroQZTkuqCbRbXoTDnFOTS
 ziCNrl+qhuwA8W2Iw/Nh3t90EJQLEXEg5aOq8KtrEctVhsNSsfoKO03WR9/5/ofJUoIn
 +HuqJjTC6NrTOaT161amzthYR/MKnbAdX0NzCZ7QkXvTcyDWFYU+1J758VhRxakLyRZJ
 eVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488465; x=1778093265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yuy788aOdFARzouujqA6ny/LQ7HkgncWPo7VgBva+64=;
 b=I7rSToyImIx6nsFTn+stf+eftd6VjWcvvXKAvaxn0niPXtIN6UF6TvNHppgJBm4SoO
 Kjxay8UrA1+1U92BqlAJIYKsgbCH+pUEqMSxzu7eHYmjym67TBQ3MJTxhUFdwGYAOcwE
 tjGov0fez8M9hWtzx/a845ayQO9ENPEyKD693V7/TzhR4ukWD7hKg7J2Sl8mhbAypOxU
 /wkKURgoTcnUjc2RhcHQ3DaAzseJzrLWM3E2QhZRvGAwNdq3qPlR049qHdoRiBx5CMY4
 t8beJQxeIzmIQiWuQq+H5oooFB5eL3gziU/Fx/GlR21phLiq1P059SICEub8GTgbY+aZ
 Vvhg==
X-Gm-Message-State: AOJu0YzIJqqppT1qgZ4NUuYQEgRtRshwHRJAgktFgLgJksMFYSMgDbt/
 7LMITGhbp7VsJv9Agr8DjGMa0IXi7t6oI8uTu6Z5xKE19b4KvHS6c+/HBWSIgkr6whbU1YkjX/C
 UIJx9
X-Gm-Gg: AeBDieu0yKJtQD55L/l58MBsOxSpb4T/BGTv66+AxOtsUsXIpOesrDMszPZ4ni7eLCV
 oH9k9xLvp3tQbczWyl/S4ysMOt3oRdaFGP+R4cEiEYC1W3GAaZLw3PxyHvJSIwWRR5RanQ26AAi
 LjUapTc9ZvH9svSZfJgBdhugJP5/hC4FvPgNrmDKKeuvJvirNGbkrAveewz10UILbdFavcItoDO
 xI5F2Ej14nNX/Q/+tUPVGjuQ0nzsTxeg5JH4yCBPMt9k437e7mQpPVFnkGlLe1Mn0axAUIKFrlK
 tPXyEYbVTnLvzJxYfv/Yoyu8wJtdsjOHX54xqsGtXMxKkqfdJ5UhPy2DN+KxC1vasDnD5r3Eudq
 qq2I/Apk5qBvI5l2u25FlqO5+W4IJuS0Q/Hy1OI9Pi9l+WKgwqJ6MvD5phArWaCaL8nPToVw4af
 leK+FYnWrNRPLQwO54NVA8yVwHmFrchT5HqxSo2887hkY=
X-Received: by 2002:a05:7300:bb8a:b0:2c1:6cfd:73ee with SMTP id
 5a478bee46e88-2ed0a0a99d1mr4002598eec.24.1777488465165; 
 Wed, 29 Apr 2026 11:47:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09ca30sm3271027eec.24.2026.04.29.11.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 11:47:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 2/7] ethdev: fix flow_ops_mutex for multi-process
Date: Wed, 29 Apr 2026 11:46:39 -0700
Message-ID: <20260429184739.706250-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429184739.706250-1-stephen@networkplumber.org>
References: <20260413171836.123467-1-stephen@networkplumber.org>
 <20260429184739.706250-1-stephen@networkplumber.org>
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

The flow_ops_mutex in rte_eth_dev_data lives in shared memory and is
accessed by both primary and secondary processes. It must be
initialized with PTHREAD_PROCESS_SHARED.

Bugzilla ID: 662
Fixes: 80d1a9aff7f6 ("ethdev: make flow API thread safe")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 2ec665be0f..70ddce5bfc 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -135,7 +135,7 @@ rte_eth_dev_allocate(const char *name)
 	eth_dev->data->port_id = port_id;
 	eth_dev->data->backer_port_id = RTE_MAX_ETHPORTS;
 	eth_dev->data->mtu = RTE_ETHER_MTU;
-	pthread_mutex_init(&eth_dev->data->flow_ops_mutex, NULL);
+	rte_thread_mutex_init_shared(&eth_dev->data->flow_ops_mutex);
 	RTE_ASSERT(rte_eal_process_type() == RTE_PROC_PRIMARY);
 	eth_dev_shared_data->allocated_ports++;
 
-- 
2.53.0

