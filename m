Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CF4CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1765740685;
	Mon, 25 Aug 2025 05:42:45 +0200 (CEST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 0DCA34021E
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:33 +0200 (CEST)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5c5fso1012421f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093353;
 x=1756698153; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRwgysivKy3kRAeqkZu1W+p9liXSVnLCn3b9+GuwOJ4=;
 b=gKK/u3zcnQ7n9pifwfvDj8Zs6KW8CPTFXotfalDnPp29d3soWBf/+821979IqxLfVL
 qTXIq62bllHGE7e2PSGpvHYFkrcxwGtNK35UCFQ0Ru68MW5+9eh4bpIFmnJf9oT9T89a
 WCV8U/XVCoaq3bFknK1gBsAnqF7SuOiyZubF0SXMJ0KNmhOgSHQvikNiC1geOci6iGZX
 YWhCG+qHxTJpkvhvPBiUAcBh75QtOp3VveCbCkQbPkljn6W3C6+NP+COuVC+X5D3HIDg
 sLLrkFXykFv5VBFCxXM9MS3gU1oFoa9CbbEtOScLjHTxgBEpJACr8nbrrkSt4+PHUufi
 jN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093353; x=1756698153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRwgysivKy3kRAeqkZu1W+p9liXSVnLCn3b9+GuwOJ4=;
 b=ny7lDZ78soc5+ld6OQqScSUJFOxmNEbcnYq+s1G76Qfdm0gQkEShBrAG0CEwVUsM1l
 eCpgeKZCaWhhZKczLPCpV/8O4pL3QnY8hSr29fkpjvkv4lBwv0XHk+uZkhCnmspWo6wD
 XKPBZYxCAPox+plTpzYdpT+Eer/Gw3aDb9ozgc76KdZK2zrRSBjdAL1h3o4O6ZZETOel
 trwGlNrvHHNgdu2SM/FJrjFyVhvK6bofMQNOl7RDCiT8M5rjP8FERZj+bZuWpkUORT4k
 JXByLXgV0/HdgNGWvDpoySOF3b1SLSDazenx5uxZHTVjbYy4qk4lFvlhNDC+9mXoL+C1
 59HA==
X-Gm-Message-State: AOJu0YzR27SjjPwfByPgHye8ya5h5PQ4cg7vEBm+h2fJdO/M8dVak+nR
 b+8RjBWBaullLy67h2aVVBRknfnYiVAde6cDqP6o5HHQ+Re+a8kV4okwYNxKMFYFaO1bJRp2e5Z
 6m9oO
X-Gm-Gg: ASbGncvgrL9GO0cwrkmUGlkwR3KV+/n3iPOOQ28KvQ8hIXLzcAHSQSuafcy+AekjNUk
 uHIOQ69Z9Ymq7uk8g1/UwSldMvuTTiZ3s7GexA5w5keIicT3CBiW4kEaTKSPuIIc3rf3SbH34g7
 BTcBGcre6d9eX3HPUYdxRQY2mM81vyQuEiQee7gMUkNALDCauWw+M1k+N9T4ALCwxR3aJ1qqkgu
 N2eyiVOEw2Gmt40YYY9OY8L1s/d5Ro4c8gRaqvHSIgZDssIG1v9o6I4lq8FPaCb9JmLvRr4FdOM
 kEQfHvqqkBdHWVoDq4YYvede2USjH/0XxgBlnxaNhBM7QrpniDQcF1iTtnE0Ip7fIFldOwRq1nr
 7W/HOcFZQwrumtzCG+70eVWZQ3XI63t2eetWL1LrmIsISk9NP7zEXMGLlWl+ftYRSPjw27n+x
X-Google-Smtp-Source: AGHT+IEE33b3pdkLokmxklmUpOYMC0nDxQ33JTs8UpqlQd4UWR2+W4qApiVBeED0IOoIxEEBsWAsvg==
X-Received: by 2002:a05:6000:24c1:b0:3c8:4d98:7402 with SMTP id
 ffacd0b85a97d-3c84d987994mr3565880f8f.39.1756093352669; 
 Sun, 24 Aug 2025 20:42:32 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v2 21/43] net/bnx2x: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:34 -0700
Message-ID: <20250825034126.12046-22-stephen@networkplumber.org>
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
 drivers/net/bnx2x/bnx2x_ethdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bnx2x/bnx2x_ethdev.h b/drivers/net/bnx2x/bnx2x_ethdev.h
index fa1c3ba955..3434aa0c9f 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.h
+++ b/drivers/net/bnx2x/bnx2x_ethdev.h
@@ -8,7 +8,6 @@
 #ifndef PMD_BNX2X_ETHDEV_H
 #define PMD_BNX2X_ETHDEV_H
 
-#include <sys/queue.h>
 #include <sys/param.h>
 #include <sys/user.h>
 #include <sys/stat.h>
-- 
2.47.2

