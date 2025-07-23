Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5AC83F25
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9F340649;
	Wed, 23 Jul 2025 06:50:41 +0200 (CEST)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id ADA61402CA
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:50:40 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-23649faf69fso50967615ad.0
 for <dev@dpdk.org>; Tue, 22 Jul 2025 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753246240;
 x=1753851040; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wWf0k2rOjwRN9rM06Zq0TfeEO/EBv9g7SCSh658YOys=;
 b=AcV7qsm2V6OucM4OssEbS1NrGPvO7ZLJl57GWX4iyJp3qj/HvfzqeS7SLZw7xqy+XP
 VFCDb8//79lxUHU6AxNkSL89Zkh65zD2BmiIG9B38fd5AaBMljJyPH48J255wSH3nt1C
 cHLGx3Nv1w6IXgydn3SJOmpK5yR15ms19Nfr70NkVBPuf6PGN7Gmn8AoAPfflB7khyiT
 Mp5fUKjvvgserq69qqpHiEv/15DYx4gy5IdIf1+ZllDFfp72Dym6A9av9QBt5tciMKBW
 Tu4JnJ+M3GUWz1XYhA7Z2wOrpktm+g47P8DIKKYCmJG9Q51gQCrEFbJgEAyOVpCHZjkn
 +LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753246240; x=1753851040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWf0k2rOjwRN9rM06Zq0TfeEO/EBv9g7SCSh658YOys=;
 b=gN0ZlqABfsptlYA1XYEqJNVVaD504i6Ou3r4cdSHlxnHa4I1JaLdCK4J7QAVburb+l
 ztgVdkZyfFVh/bYFzE4VkrMCqCi/adNpU3ETLhfbmVSBrKkIM1S2GUh6e5VFmn/Oy06l
 IFeme/zIE84ClTQD9GOG8I8wuWY09aVbhWeiXHO9sZJwggbd+1zoqD+J48D4OHHrlUkg
 XSnlYCPG9tCfJS1Vz0GwwJWf4CjFGchzTK716giytDqfTuJmp9RwFrgYSqIaDfs8ngPb
 u4q7j4XKWkHrFQScat4kyF6T1+qzokqpACAsBVOi9u2/klQQPx74drygV1ObF4G8Ddnb
 oZEg==
X-Gm-Message-State: AOJu0YzZlPLPteePTYA4Mh13n39AK0cJnrm8m7WDPA5IaHxyjpUBxzOj
 sa/mrQ6LyxOXFir8WBigZ+1fBRAQA8JRDr9pHoeKijvNf1/xzllfvzfKhzuJuLOr0lo=
X-Gm-Gg: ASbGncvJ/lHJ4T5B5b5tY7dMWiC7jd1Cq6j828vk52SvKsBXr164MMQuZXHjbrYKSef
 1oVhKO/hv+xrPUXEpyQKIWa1a7+ssIY88D2/qvNQcA0aTlTiBLifNqxmork0ZpnXs5pj2RkV4wg
 5O+8oyC/t0JDBN1y0AMTdDmV8KaBKod1Uo8c9r5CySUbj4XryV2rw3W34JIoNjDdz1rGzDNJAo9
 xkS1YVFO9S+iyDy4AEe5hKcyUzQH/06e7P4aGZaIgWXbqx1RLdL/IoW7gTk1xCrX7LWcqS55kZx
 eNXEmXZ4bsQMDVNHXCXtcdV9b4flkAj1g+9KTbSZwpVuCAlIphfO4ZrB9esSWoZ37K6JsxAn/1l
 gYwLzNwbWvYNYsh5gVTINLdMtxVI+DIvIlT17qcvcs0JrxBs5rLqFz7sVZco=
X-Google-Smtp-Source: AGHT+IEKBrF2SOsK2V1Fo4NRVUppA5woYw0FY7tCdphRlc7ip+fqRBqbUsSUR8VWpU99iKHHdQ48kw==
X-Received: by 2002:a17:903:2984:b0:235:779:edfa with SMTP id
 d9443c01a7336-23f981aedabmr23671275ad.32.1753246239734; 
 Tue, 22 Jul 2025 21:50:39 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b611ff5sm87425175ad.75.2025.07.22.21.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 21:50:39 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v2] lib/ethdev: fix segfault in secondary process by
 validating dev_private pointer
Date: Wed, 23 Jul 2025 00:50:22 -0400
Message-ID: <20250723045022.1580829-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250722115439.1353573-1-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, directly accessing 'dev->data->dev_private' can
cause a segmentation fault if the primary process has exited or if the
shared memory is no longer accessible.

This patch adds a safety check using rte_mem_virt2phy(), with an
unlikely() branch hint to minimize performance impact in the fast path.
This ensures 'dev_private' is still valid before accessing it.

Fixes: bdad90d12ec8 ("ethdev: change device info get callback to return int")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 lib/ethdev/rte_ethdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..ef5dc55f2e 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 
 	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
 	if (diag != 0) {
 		/* Cleanup already filled in device information */
-- 
2.43.0

