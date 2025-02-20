Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2414C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12EA940609;
	Thu, 20 Feb 2025 23:44:24 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4FEE940430
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:44:22 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so39261505ad.3
 for <dev@dpdk.org>; Thu, 20 Feb 2025 14:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740091461;
 x=1740696261; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YtNtG6SzS2yBqAy9BwTEFzVLbgU5CxTnGypoTxa2KS4=;
 b=OyleNTZPiiZuhLJQ1o0GWMZWoekU8IvJ1eJwjApk9U4DiW4ZMTDbJ335QS1sj2M0S/
 3d7wNsk5qFzfk7fmJauZKY/qkXMNm7JchwufjsNBdx59FX1As5gESz6q5LES7Xk5BqpZ
 VfSs6aUpNCzRQtexJmvyo1i8vH1vTqc1WH2SoYJf5T+vGK8nmW4JO3RalesWnfdYdEoI
 ORXt+yLvjgN2ZFPoiLDkdX7a2CUdNKWikIhPXmAtFlk1owCscH8qpBmvooB2LSQ5BDDd
 3mEnBpqX6C8BV6FCMk70sYcjqyZmzYKIMahj59PTdCk9/V6jdLgWChqMwXWgAayiiMjg
 sBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740091461; x=1740696261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YtNtG6SzS2yBqAy9BwTEFzVLbgU5CxTnGypoTxa2KS4=;
 b=nps8KnQZdHTFN8EMjMxY4cfGYrXOcwRXGdte4huKvN1YUPE4gI+UFjbpktgga6wA2k
 R9wCnNAQyG3cyfaRVHIDlvJ25hJD9yBekf6+UU7Sjrs1JW4XC5bKYKqZ/rWquXA6W/To
 Q0H3f0p7CMIGCqp/hmc84994Xi8CvRhk3yoKm0rGDxTSAitEo2jVZWRypqmsAdpz58o1
 k+Ya3oZj7vY+GCUjK3ViQt6RLWGS8vFtvQ2je4hRM6X583HawB0EHc1Rzb63upeAHmsd
 4u6gRrAUT9HoUciBTTyCB+/SY517+bswoDFBK11H0ATCg3xopNySDLvfxgFVKkFmkNoN
 CH+w==
X-Gm-Message-State: AOJu0YwRPrSHis6JmlwBh0gkUy/tllLUhyGkIblyIMNrv6I6I9Ad2ZUK
 QiP0/wqJbT5zYgvw3PkQmENV1x0Bjg3OzleGCJOk/4gMXdnwWfiiRcVwUEfhaZHGyn78QPT95y6
 p
X-Gm-Gg: ASbGncuMIt3nAWiR8wrKp+wZR5etLL+QU7VXf2krFpytr23GqS7PcD9gRUsr/VpIZ0k
 RWI11vYe/sYkiTQxV32nsHPKwrJ8PU/6NGXLTBx6slTI8wE7rUTKHG79txYTLwdhuWVtHN5bgti
 yHdvDBz8uRoWwTTDjN5s1wPov0046JKp7qZi0RruEAi3ZSnbyEKbVe2NsxKujggaNCWBfy+YqF/
 3WCsQoUUCRO6ChLb4NQdLIXyyhlfafbfeTJwsjUCyoozO4a5VSHx7qaFpWS/PIXKx+d3eM3+wRI
 CU8sNYzGHwPbfekfY5g/x+rup/u0AIKTUq9wPpoURrfM0JSHjV0aMuTwz8DXIl9pmbph
X-Google-Smtp-Source: AGHT+IG6/zG9eI7mNVjadkOPGmRZQbNcAHhn49754u3Hrgo8YsP/R+TOjV4VQ79IzCzdGFU0vSZIwA==
X-Received: by 2002:a17:903:41ca:b0:21a:8d8c:450d with SMTP id
 d9443c01a7336-221a11abd40mr7856845ad.53.1740091461412; 
 Thu, 20 Feb 2025 14:44:21 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556e15esm127628075ad.190.2025.02.20.14.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 14:44:21 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH] net/zxdh: remove unnecessary null free checks
Date: Thu, 20 Feb 2025 14:44:10 -0800
Message-ID: <20250220224411.302807-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Remove unnecessary checks for null pointer.
Found by devtools/cocci/nullfree.cocci script.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_ethdev.c | 3 +--
 drivers/net/zxdh/zxdh_np.c     | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index 858e3c3d47..4617ae3c2c 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -945,8 +945,7 @@ zxdh_np_dtb_data_res_free(struct zxdh_hw *hw)
 		if (ret)
 			PMD_DRV_LOG(ERR, "%s dpp_np_online_uninstall failed", dev->data->name);
 
-		if (g_dtb_data.dtb_table_conf_mz)
-			rte_memzone_free(g_dtb_data.dtb_table_conf_mz);
+		rte_memzone_free(g_dtb_data.dtb_table_conf_mz);
 
 		if (g_dtb_data.dtb_table_dump_mz) {
 			rte_memzone_free(g_dtb_data.dtb_table_dump_mz);
diff --git a/drivers/net/zxdh/zxdh_np.c b/drivers/net/zxdh/zxdh_np.c
index 1e6e8f0e75..06a28e0b04 100644
--- a/drivers/net/zxdh/zxdh_np.c
+++ b/drivers/net/zxdh/zxdh_np.c
@@ -873,8 +873,7 @@ zxdh_np_sdt_mgr_destroy(uint32_t dev_id)
 	p_sdt_tbl_temp = ZXDH_SDT_SOFT_TBL_GET(dev_id);
 	p_sdt_mgr = ZXDH_SDT_MGR_PTR_GET();
 
-	if (p_sdt_tbl_temp != NULL)
-		free(p_sdt_tbl_temp);
+	free(p_sdt_tbl_temp);
 
 	ZXDH_SDT_SOFT_TBL_GET(dev_id) = NULL;
 
-- 
2.47.2

