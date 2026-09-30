Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA851CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 063FB42F41;
	Thu,  1 Oct 2026 00:44:23 +0200 (CEST)
Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com
 [74.125.227.167])
 by mails.dpdk.org (Postfix) with ESMTP id 38B2D42F35
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:22 +0200 (CEST)
Received: by mail-pj2-f39.google.com with SMTP id
 98e67ed59e1d1-3a498cb99b3so1324339a91.0
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808261;
 x=1791413061; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y6GnF29wGs5kq37uX8acSSEkksNimQ7Na4wWcXwJFLE=;
 b=YsKyYPL7xs+tP9MZ8dHg4OwHZJGJAnxEAdSf3k2xFoFXWjkPPgjVkBnh1jfZ+8vyvk
 yN2JlWWZprH+Ae5+EN67HAUrW+6yXIHhN/Ht1t+mN2ThjkgBjA2nzbEgzyPKRfKR/cVL
 m53Km8tP5zpplseud2MuJts5WdD69a8Hew/i1JjbxC5gdNu8xoElIVJlTUileHMhXeGs
 ag3LEGHoAHsjUuKDql+mdvt3/RKg1dt9xMGbHaHpkLszWznFXOklRct34srB9EQryJYd
 n63vpjvJht7mLzbHpQ9GoVaDxk6ueTDhoElMzupJ+wIecxsYTD9CQ5U9f2WO03b79U4P
 x6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808261; x=1791413061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y6GnF29wGs5kq37uX8acSSEkksNimQ7Na4wWcXwJFLE=;
 b=N1jb4lotZQGTAxyA/67OoZxrAF6ZuDMTXWjHSWL4QsjzRjJJmW647Rc/uMttKsC3yb
 GaPZkDZzrFoOaxQiaZzoqDmSHhA6q1Kp3lxjOnob4R0sINJUJk5i2w6zo3YONWHbpQkI
 xZlFWEG5LPrEvhGARi2ZZF3TgV80VnA99A/NyKdSHkDmndLksFtjHyEykzbVC4JjOrYA
 t3CYIMXOxKNzNm6lr9tFM2FzWF7cKA2uciizdT1PiyzXRau36cNDmcxO++JRfL5lkYcg
 hLPdRfJhfCjtYq3kMPeyOFGMjIUy4llHb4pgWDNOgJEiIV4cCJ8gHhF5IWMR/Fa5JRlb
 GOSA==
X-Gm-Message-State: AFq9FYIloZfqXOZ3ykVICZKehckBIXoKAgarrF9i7TbLk9xSqoh39HC6
 6KCHsrtCVqvXJ10TvWi/DY7GW7VllY5NUMWerYd6Gr7PTS6LEooOpTx6Uyx2QTj4sNywAnG2i0y
 CAZEsthw=
X-Gm-Gg: AYBFou1oCLod6cQSw0GXlHZaiMNJs/WNNTXjRLOQYUJoI7LvC+VqxzWENGRaeZFQcrI
 YX9U50Dn6KlPfzo7H8JkKXfXSeHzqIaNFYani9Ya32EyK+a8PwIT5aUlPFRNmxGGB/tJ7Wx8Nc8
 ZFTlxFOvt2/XMTDk75kylxTWltt5WMXipx5vWF6WPOt+dJq6PAGyIA8ZlYFoX2Rsu50kEazTnoU
 jsxHhYXB8m3zDN+NMF7rinPoyqjX3e+5m01sQrvgha+QVEEzAYadqnIVtJYBwenQGlAA7cRqmWA
 mwWngNVf3t4uuy7+PrScsoruYR5K7fqVdSpCq2fZi38Kt7FmSMdbPBToGI3ecB3YaIdMJqOVQmU
 PtPIwP7fjVtV5tLViDWRmn1p2AiqeTIo8LEHR6m/Fr2T/nMQy1Lcz3ul0alFFkmlCtuc5Xuyl8H
 RuQVKvawSKI7S3xXGBtWu3BDf0RG631V5AKWRII3FDQ/LKj0z/c4a0ELoPtwI0FMHtUT9EnEi4I
 z26uAw7xvGdzU9MjKol4x43bpqRYHqyg9a8YG9YGDxMXeMs
X-Received: by 2002:a17:90b:3ec2:b0:39e:423:bb8f with SMTP id
 98e67ed59e1d1-3a4d0f02bcemr1583310a91.1.1790808261261; 
 Wed, 30 Sep 2026 15:44:21 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jerin Jacob <jerinj@marvell.com>, Maciej Czekaj <mczekaj@marvell.com>
Subject: [PATCH v3 35/65] net/thunderx: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:53 -0700
Message-ID: <20260930224340.58580-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

nicvf_parse_devargs() uses atoi() on the skip_data_bytes value, which
cannot report an error, so a malformed value is silently taken as zero
and the argument is quietly ignored rather than rejected.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/thunderx/nicvf_ethdev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 30d03f4db9..aa45bd96b1 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -3,6 +3,7 @@
  */
 
 #include <assert.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -2161,9 +2162,17 @@ nicvf_set_first_skip(struct rte_eth_dev *dev)
 
 	for (i = 0; i != kvlist->count; ++i) {
 		const struct rte_kvargs_pair *pair = &kvlist->pairs[i];
+		uint64_t val;
 
-		if (!strcmp(pair->key, SKIP_DATA_BYTES))
-			bytes_to_skip = atoi(pair->value);
+		if (strcmp(pair->key, SKIP_DATA_BYTES))
+			continue;
+
+		if (rte_kvargs_to_uint(pair->value, 0, INT_MAX, &val) < 0) {
+			PMD_INIT_LOG(ERR, "skip_data_bytes is not a valid number");
+			ret = -EINVAL;
+			goto exit;
+		}
+		bytes_to_skip = val;
 	}
 
 	/*128 bytes amounts to one cache line*/
-- 
2.53.0

