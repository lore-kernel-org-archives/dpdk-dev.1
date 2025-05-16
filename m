Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6FC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 03:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC791400EF;
	Fri, 16 May 2025 05:15:19 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 553E340041
 for <dev@dpdk.org>; Fri, 16 May 2025 05:15:18 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-30e390ec275so1567316a91.2
 for <dev@dpdk.org>; Thu, 15 May 2025 20:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747365317; x=1747970117; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B/HdcTAqc435Df2SsFe2QjClNrPPbwr4LBoHh8iHOLk=;
 b=B7zb52QE5QHo6cuZhMUMgaD7kRCrqthiLW2NW9sdmT22EYXimqkXFecoOhlGso52ZV
 S/JEevIqxpVJI6xkFDmZMwFJI76i95QT/GoD+64RDJceNONqvuEB9C+UyiupEDxRMcDq
 em3WH02GbSsplo+CGlHGYfjcggj4IwoYPbde50Kj95ic6dcMruXsrRTbC7rnr092BKfR
 mRRu58Os/uFLhjVJMZsU+VCjP5GqEcNp1/uCXUz83G+PmWyJR24kaV23Vko4e0voX5dh
 jg+nLzIPJ33GACJyldF7tu3SRmQtfwuABoS9NSqXv6Fd+3G5XpYX6ti6EXLkSWNK0XTZ
 fzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747365317; x=1747970117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/HdcTAqc435Df2SsFe2QjClNrPPbwr4LBoHh8iHOLk=;
 b=EVy7TB6BUBQy6+Ij4PK7zEUNAXd2CaZ0GZLljImekaBOVbaeRMaYhFpcvKT6BNmgB3
 d4qZAuGNauDzpNwyJ3GehWmTVYGUbSpoUrb6sJrRTr1Wpq3P39GUf3iNCSBvzGnQrBWq
 lfvD24Ezc0Sf9RkkfXkFD5caXDnDBTTzoGm+8NglAAP0+9HUH3fi0/S+ZCOGfh6GpR1/
 pyPFDaWWgjDJgOuzoP7A++iU8AJlvn1mjbvzE0oinBAAxQNYHprIaFJ6x4eNdQNm1eBp
 C2yBCQh9JTeMVFZaaKt/GvJ/1BNx994A1P0pcDUd4iO5q4Hnwe9d/V0mO7sHkaYW24M3
 00XA==
X-Gm-Message-State: AOJu0YxPUNpCcHf1ZOPjWzfc8ftynCWDq9kICklmCL6pkspviK2omMjb
 orqX8ru15w3tp2owiI+WXh8C6QfNBLVeMuixh//lJrJ2tos+nsIxiXk9exunYYps
X-Gm-Gg: ASbGncvo/KFdIYQF+jlrlC9Mog4oyn0WwhJK1mvnJy9B1hPFIRidR/kqshbmOHL83zZ
 JvKEnsh1CBh34Zo/v5ojPUSfA1eFmvJeBJZRx+obkxuUeKxLgkmdYvPEzaDSAn4YA96A/+ODBgo
 OtOtah2KdVADlndlApgDN6DDIKQspCTul0MtV9iNxkVaGavJWeNapvSmGsdGN/2hYDhvn5FTZji
 V2c68y+Dmg0ZR2LDTTHyXE5EZR79ziDUMTAhdWpDaYlFwfpq//TQJeHjlxzr/2hv8iWGI1+9ZRz
 vy4nwatQqh+78s6usuCX3tl4qcKqnGo8E67AHNiQlnHzuG7EikT7vZt7NgtuGcbRtLtKPOgYWKf
 c7Q3d
X-Google-Smtp-Source: AGHT+IFJrLOpT3qBmeZxeP6+kkIOTHjPzvr+gfbhPJgKnf5MEGQ5A6HRjodx+OyLjHhLIakPY25uqw==
X-Received: by 2002:a17:90b:184d:b0:2ee:e317:69ab with SMTP id
 98e67ed59e1d1-30e7d2fda18mr3058013a91.0.1747365316676; 
 Thu, 15 May 2025 20:15:16 -0700 (PDT)
Received: from localhost.localdomain ([60.186.106.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e7d575cffsm563542a91.32.2025.05.15.20.15.15
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 20:15:16 -0700 (PDT)
From: Yang Ming <mosesyyoung@gmail.com>
To: 
Cc: dev@dpdk.org
Subject: [PATCH] mailmap: update contributor entry
Date: Fri, 16 May 2025 11:15:01 +0800
Message-ID: <20250516031502.1972-1-mosesyyoung@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
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

Signed-off-by: Yang Ming <mosesyyoung@gmail.com>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d8439b79ce..e63e1af4fa 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1734,7 +1734,7 @@ Yahui Cao <yahui.cao@intel.com>
 Yajun Wu <yajunw@nvidia.com>
 Yangchao Zhou <zhouyates@gmail.com>
 Yanglong Wu <yanglong.wu@intel.com>
-Yang Ming <ming.1.yang@nokia-sbell.com>
+Yang Ming <mosesyyoung@gmail.com> <ming.1.yang@nokia-sbell.com>
 Yang Zhang <zy107165@alibaba-inc.com>
 Yanjie Xu <yanjie.xu@intel.com>
 Yan Xia <yanx.xia@intel.com>
-- 
2.49.0.windows.1

