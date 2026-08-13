Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D8CC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F36442DE4;
	Thu, 13 Aug 2026 20:04:47 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id EC98942DE4
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:45 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cbedf318752so91506a12.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644285;
 x=1787249085; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0A6wKhAItRVyt2JKCq8FkljAYBGzl+qGWc/HNBU8j4=;
 b=Nan+9dUBW4qBWOyBuat5em52ob3g9ERLDtZsMo5y8UZQoQrq5s9kVme7eq4Be0cO+D
 cfVrfOAMkCb626XDKEFc0IE2ConPfJ500XZ1Sj7Auf8Mekwz/2hGxniyMI3s1cMhaItl
 ZqkncCchRE/XNmoXV6/Uxi0QTW2e9glxSBtpAG2hkmU2JjgvMCUK/wUdMl2fD0JOB0Oj
 ELLJ3/u8r6/TbOIyVQhl3zz2UwzGcBywjrqVmjPZhBcZ630+9Dl/fT6utoG+zF6jPNcn
 Y1ir9Jc8V1Zls48Wm+Bt5d6cTEaq8Y4k9XX8Ghzdt0zKpul91wr7LV9TrBXz2rRvKTWy
 aB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644285; x=1787249085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C0A6wKhAItRVyt2JKCq8FkljAYBGzl+qGWc/HNBU8j4=;
 b=BMqKw3qyv5vm4NzShefpDzHYS8SUTBq2RlJSvMjKKvlj6XJPWGz/oiU0DzLReNY0Cn
 OUYr32M6KfwBxSkLz7RJsTAgop+xW/qOIs5gD9LB2baXijgpdeecjVUF11AqyU9VyYkl
 tARWK+EHJ8TydZZax1vqO6zYkarvxMivJS3y/lyj4uppKY+Z7HTahr/g2cGcwPPty8lE
 7UBLd1RyTlvJPKUg22VVmG2+553pOiiFggfNVs58aAICIKdW5MxPJ4+fkWZZFUo8yP1b
 E5dDjVfPX+V7nzA22WgMm9uF/eeyaJ5f8eypT067CfWwDvptWcfNPINOCl9FGYx4sxtj
 2JCw==
X-Gm-Message-State: AOJu0YxNiIBd2nJnGIrY4HyxtlYt4Wk4Ao7zXiqJRhsKIaVerZhW/0ZK
 BWDPmbbFE2xnz/lO/IJ88fTc9AGAYzsidFSPshgZicZ43x9y2RJhdh6ksnNwWsvsn/8tj0lUcjC
 RgxE1
X-Gm-Gg: AR+sD13Ak5tOfQFUWoII0O0PKYcuVWqbzIzdKHdXDeNyOKIg6MzxzJDdhdrwTky64/b
 F8OfEX3NjJUiyY7b/4v7KVFpcJx5jAJzrq9+G5skhAJF+tLS527bps9pPfSv8GXzu3FapZ6bav7
 PSF6uz259BdyvU2+x6DT6fHzMnAqr3LJWkqE45mbi4uXfe/7TB255R9lWGi256sQnBe9XIUv1x2
 easMLvPnsBuq4DntkK0KprUTtFmfmsNkqckP93KEm27giQ9Kk8C/1IrSfs8KZKW/nrS5BJaYYej
 BNPo0N9S2rXP6bjYO62ZzhAZ1OnxCe2Qpv8Dr9wDpUsbYxPezxxB2rBzbS7Wz7anRtQha74d0dC
 Pz+S0tvd3g/sqn1G0jOdCtHFIkvnAnHv1bwWiYIwBqe0Ox5qpwKOOcq5GSaJc9n9jrdO4+jqz1N
 dP86eIHU3iwovOkhe0+IEaRp3nPgx635OKkV2P2a+fwlr4CsvK/y03U+7mhTXOmVF8+lWi5xURx
 FX1BQyf/S65wpbOxSp06rFTx2I=
X-Received: by 2002:a05:6a20:431c:b0:3cb:e8b4:f03b with SMTP id
 adf61e73a8af0-3cc55393140mr9069514637.17.1786644285067; 
 Thu, 13 Aug 2026 11:04:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 09/16] net/sxe2: fix null dereference in stats get
Date: Thu, 13 Aug 2026 10:55:08 -0700
Message-ID: <20260813180402.622784-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

