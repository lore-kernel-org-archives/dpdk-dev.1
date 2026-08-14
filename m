Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32045C5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADE324068E;
	Fri, 14 Aug 2026 22:20:28 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id ABC0040664
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:27 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ccf2360620so15452995ad.3
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738827;
 x=1787343627; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0A6wKhAItRVyt2JKCq8FkljAYBGzl+qGWc/HNBU8j4=;
 b=fg6BvMeRqW3Wyv/g+c9UoZkUaGjCSbhOUgzXSiHrBzYTlFlLf96TXRa9guZ1X4Zqhf
 lphKxX3mz4YZMMMA7VQJVidhKuWIgyekz37qTtdigkv+xOp4nLNscGP84AoSmwOgVku7
 DWM8t3jmpq5WnAiMs9L5QX4NDpsp5NqiGO81BsycVlYWQUiADg6auKiKGdcFp+3nFB8u
 0YjV3G1vUufQUPBGVTMDkz+4UmQuBfd7QUF138g/qbbvDNwJcmODbOz7bBdisgh0P2Ho
 Mqlahs6hzx18OSHdRNmXmfnGaiRVeIXZj6ON0LjBTLo66kLOPw41nb6aLctD5i40sOL2
 qsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738827; x=1787343627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C0A6wKhAItRVyt2JKCq8FkljAYBGzl+qGWc/HNBU8j4=;
 b=Wct+G63YSNogYPQmMgbfVNYShCDEv8qefnl+1tlFdbFkcMTs8B1TkUUyxV9vZrC5ST
 U2briOyNq8GnQAWYFOf5poo0skaYrzXCUSv1O6vSCxynbnwPA5ihmqHydWwEdc/3EECB
 L5tJCeRpuavhxpN6tmJKv9LqufMqNKgUE5v5A94TcD4v/8bL5+PWmm8Rrlfei/jrC73y
 9cym9UuIpoNoqDQI79H8DYVQaM04MF9V3tccZrPhnTi8UnG8VVq76WOpNU0hrN9Fbzs/
 aV30vt7peqcxMo1TsGbo/fOhYz4oLwU1RM9VhFJcwXs0d0owqTas+mfKXKz+aGbJgLMW
 PfNw==
X-Gm-Message-State: AOJu0YxBokQAUVZED3m91SvrDrREX0jgoX4r6C+8QsMCcuzezmLu51Gn
 k4GJn/ZEG/zAA/iMT/0AhDTxN16Wj9ugValaaB5mdI8fLPyYse/zI6ndF568yNugScFtmBh+4c6
 ILTmX
X-Gm-Gg: AR+sD11qe3zbNMohgikpj9k7o9HvHt8p1svHVj3inIgMv/gup00zuqRCmKbboIIbW1P
 wTs10E2ZTjBeVTfWRIiyUsCS2xMGQR6W01vn5OJCEtHm4OrNOgz7p/081sHkyrgGpItTcKC6dil
 Zo8JBQ4vtBeCRhnpepB7v6zy96kG9tOa9+qdeJaped+b/LQJ5p3sXcxI9uWYCvCADTXU4tlmjzb
 Qhf0ZI3GW6SYmL+4MvX345w4HXvNYLX5BwjzoHF9K2VT0634Z6p+jBS/KSwXPuhH0TrxBbOVT7P
 McXcoyXoOcIjiGTvbNFNJ2KKiLugEvi/WW3gbErHGjCpJgHOeWHcLai3AqQ4WWo/4A/6LR2m+V2
 tERv6R5KSYbasC/wCvjrbzKA/hDjyES3dRaNtZ0fUWN0/VBLHIo3agA/fCbv7jAeNEATIpCqQXJ
 j5OeqG6xqQ2smPN+hBjL2IvRK7yCxO2MgcZuoubbBvTsunqF1BCshGQA9J/u9vBJlDfAI3tcUW8
 +XAQlmyl+xmbYSf0iwGoccG/kg=
X-Received: by 2002:a05:6a20:cd90:b0:3bf:c28f:8afc with SMTP id
 adf61e73a8af0-3cc71707793mr10596828637.0.1786738826731; 
 Fri, 14 Aug 2026 13:20:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v4 09/16] net/sxe2: fix null dereference in stats get
Date: Fri, 14 Aug 2026 12:46:05 -0700
Message-ID: <20260814194757.329424-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

The qstats argument is NULL when the application calls
rte_eth_stats_get(), which only asks for the port level statistics.
Both the primary and the secondary path dereference it unconditionally,
so plain statistics retrieval crashes.

Only fetch and copy the per queue statistics when qstats is given.

Fixes: 5db446ba97b0 ("net/sxe2: support statistics and multi-process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sxe2/sxe2_mp.c    | 3 ++-
 drivers/net/sxe2/sxe2_stats.c | 8 +++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_mp.c b/drivers/net/sxe2/sxe2_mp.c
index a4a5c76495..a9598b6dd6 100644
--- a/drivers/net/sxe2/sxe2_mp.c
+++ b/drivers/net/sxe2/sxe2_mp.c
@@ -325,7 +325,8 @@ int32_t sxe2_mp_req_get_stats(struct rte_eth_dev *dev,
 
 	mz_data = (struct sxe2_mp_shared_data *)sxe2_mp_mz->addr;
 	memcpy(stats, &mz_data->payload.stats_blk.stats, sizeof(*stats));
-	memcpy(qstats, &mz_data->payload.stats_blk.qstats, sizeof(*qstats));
+	if (qstats != NULL)
+		memcpy(qstats, &mz_data->payload.stats_blk.qstats, sizeof(*qstats));
 	PMD_LOG_DEBUG(DRV, "sxe2_mp: stats received via IPC for port %u",
 			  dev->data->port_id);
 	ret = 0;
diff --git a/drivers/net/sxe2/sxe2_stats.c b/drivers/net/sxe2/sxe2_stats.c
index 3ad8fe2fe9..0e4857a906 100644
--- a/drivers/net/sxe2/sxe2_stats.c
+++ b/drivers/net/sxe2/sxe2_stats.c
@@ -328,9 +328,11 @@ int32_t sxe2_stats_info_get(struct rte_eth_dev *dev,
 	if (ret)
 		goto end;
 
-	ret = sxe2_drv_queue_info_get_update(adapter, qstats);
-	if (ret)
-		goto end;
+	if (qstats != NULL) {
+		ret = sxe2_drv_queue_info_get_update(adapter, qstats);
+		if (ret)
+			goto end;
+	}
 
 	sxe2_stats_update(adapter);
 
-- 
2.53.0

