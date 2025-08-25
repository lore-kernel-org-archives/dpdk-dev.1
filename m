Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B34CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B7BC40E09;
	Mon, 25 Aug 2025 05:43:03 +0200 (CEST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 1BFAF40653
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:43:01 +0200 (CEST)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c854b6459fso657945f8f.3
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093381;
 x=1756698181; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijYrWox660IRBj3wuPKPoly5XwpyzLKyFPs7j7XW8MI=;
 b=uqFxWmlWMnerXjOET3cIQFo1KujZyrjFx7gaymZu1+X1yOFmYHpbcJKHjLrDT5A0tm
 +45bQBwwyLb/CF2TTtW3PztiB/xXkhM54bfLFlnv6QxHs5RkO0c3OVeMg75nmhaIDLm0
 otDI/fbsv9GON2pZxnBfyAOE9ayecvu92bZVSnzl87yvKto+XHvfzfYG6Vr67tb+H0aG
 azkl+XHYRO4sLFS78Pd7BoUtrDIdw0gjiLpY0BP4vLJhHJbaGk6Tdv6zWqv1+yLx/qlx
 CCINSFnNMgLDJ3D6GzNJy8ta8dbZL7WHzePFUiJe78Xjlql4Rt29RytgJSw+eVZxwvgs
 jkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093381; x=1756698181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijYrWox660IRBj3wuPKPoly5XwpyzLKyFPs7j7XW8MI=;
 b=uJe5zd2e2QOSdo4NdzOGErRSm6qyJ3AMZG9ashfwiV0aElzW2o/2b5fdGNyKbjd/G0
 zHqEjvoWtzxIWgc6rM15S4PuA4NcI4WU89dfSEzOlCXH8UXFcv6VsXyL9wX8djdCpD3m
 /CB55L3+zKyC0m4ZGejtiqt6828izPk126PlDeskvFKLpa1qyHEvhI+ayZCqR5G54D9S
 bUaPHB3ezx0XWaCa7R/XTBgPWw2RNX1OytL96o6NlcjNmAKYzSwTSVWq6fGUCYj3UB0x
 CBetydgRWw1lkiMGX/bzf2ZOGsq/tBpl/tZvKuK8sDSsTcUDN7CnGYSWYxiHod8ia8AY
 uxPQ==
X-Gm-Message-State: AOJu0YyCcogbA6kxkwUKbVsQRn0vALw/WpUeebQ6A9FB/XDQvzLreQ0B
 1YFzQQjEBoeYedolMhdj1eo0kM3PEaMdTDI00QwKrammYYE9dMAP55XQF8h7ygsr7bhU/tBXBty
 /WkDY
X-Gm-Gg: ASbGnct/XnZSf7xMS3+fDcNbVlEP/CVUzn+Mxv9UfEjUO0S5ISIep+tUSgip4nInjfj
 xIiq/JOoeEGwkePLNA/S2CTY7j5CviL0DN8bOziiSKGXMGf7P1B5nV0Zed7fczjjvCO1doao2vp
 e/yC5KYvSB/ONX8AtgDMjWJ+xMVyBuqBBwn5iB6BChoXBUKGWAjXs/1Ecr+LnCEwTvjSSeMWsgq
 FzPLNV4+r2NAJ5nIf3/868AN+izI2MZ/XN5M8o7S/+kEQVEZPVeEV9gGfjFwngPSiIezujZiEC4
 rxmwW10WDEykibQNqkbsKXXJDfN7tS9YCOebYWB8Aomy5wOALL9SRHxnw1iivKDjeQwPDZqb08t
 qldN9xM5FKnnx02SO0nS+G8v/zL9in9u0dxUelbCn42SoUoDkePAMKy2Txhy4F9vjZWnyNnHx
X-Google-Smtp-Source: AGHT+IGQJqJlYN/VZp5YkjgkgkIOxmahSmp1W5bVyqkiWUONGvYl7cV8ruEPFA46kzFA495kELPTKg==
X-Received: by 2002:a5d:5887:0:b0:3b7:88f5:eaae with SMTP id
 ffacd0b85a97d-3c5dc542ac7mr7740905f8f.39.1756093380761; 
 Sun, 24 Aug 2025 20:43:00 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:43:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Junlong Wang <wang.junlong1@zte.com.cn>, Lijie Shan <shan.lijie@zte.com.cn>
Subject: [PATCH v2 35/43] net/zxdh: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:48 -0700
Message-ID: <20250825034126.12046-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/zxdh/zxdh_mtr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/zxdh/zxdh_mtr.h b/drivers/net/zxdh/zxdh_mtr.h
index 3efcb6b591..4b9b409025 100644
--- a/drivers/net/zxdh/zxdh_mtr.h
+++ b/drivers/net/zxdh/zxdh_mtr.h
@@ -7,7 +7,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 #include <rte_mtr.h>
 
 #include "zxdh_np.h"
-- 
2.47.2

