Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C425C55171
	for <dpdk-dev@archiver.kernel.org>; Sun,  2 Aug 2026 18:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C4F840A72;
	Sun,  2 Aug 2026 20:19:00 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id AF05C4067C
 for <dev@dpdk.org>; Sun,  2 Aug 2026 20:18:51 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38e3617ba36so2675627a91.3
 for <dev@dpdk.org>; Sun, 02 Aug 2026 11:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785694731;
 x=1786299531; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6JnYXvzn9J62UYtAeoYW3pggUzmhkTKtjfp24WDAJA0=;
 b=Ng1iU6OoFRBasQozb7+SEl1CWoDld4k4ESPzWnGG2AQuxVJXlgZywL9hV1Rg0LhCuM
 fvk4b/VedujR7B1Xw5PFO1jOQ70kdhcQVeYCvZIVniKSZhXYsWvbKQuDVFXdGg+Lx+8B
 BgwDqOVP/tZNRchZx22N3F319Jh/WFFMekwCxrR4v4cRzkP+MjXBow5TzhnBJ1uOP95g
 By80wC8ORllp5E2mCOoM78/RD2CcCgV2aYd9vEzr+PdUrZq1bq0BHPRqElN60fZgVqZi
 d/m9PzbbsjJlRSTtW53Dm76X1W8b+0z1wVE9NUR+wNRJPW9KWMgne2yr8fbW5kOR13Do
 d3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785694731; x=1786299531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6JnYXvzn9J62UYtAeoYW3pggUzmhkTKtjfp24WDAJA0=;
 b=X2iE62dBgIzOWS44b7IHvN7kxGiHKGrqhxKz+776vfTrzs77cEcN1mRS5wzk5Keq5L
 1D8vC8mMsF/w+FbKRus62qH745qRZQ7j8rX9/sdPtQMdYXGnIMeOP+QQmwUlro0SYVIT
 wNTkTh1OaMlauygPvrzbQJD3n8e9uSpVnxrXHCptyFibHvZqc4KV4axIdjmQHSto0uk4
 KJMSS3dbaA6G5HoHFcU0YsojVMBXbBXIrSIrfOZuMsdWdqo8wUplCPE3e2oryoChBZtU
 J4q4WwkEVp6DRe+RZBGnsHz9DnDWzrbgRjI2nBNPXekL5y1dmrR0PYu0MGNnoSyZTpwd
 QUyw==
X-Gm-Message-State: AOJu0YytlVxpeOq8DWr8pV/XIc4hvOySrGz7SoD/KvyxmmeaB4xeLvRX
 7C+Yhep1+Wf+QkMVOTk+hCakqsHG/6ts1WNl7DKGkt6lArXNpHMEUaZl3KOxnviCChbr/gh1jgn
 Nt7Ls
X-Gm-Gg: AR+sD12vZM9BreilYl5GNNS3JL3G/Ud+KCaGYihvgXueR+uFyFV6E+Jtvm3xvMln5JE
 1U5JX2D3IKeJXJXPH3DQaJipjmtwYzIULGnZa/y4V9Mc6vRBLNSgxnLg9ncYYbLXwgfop0jFEYU
 arC4BXFB63mtmLy2yh6qbCqfsAVFMU9/ki0CahYmHROQBaEXzExBX+ixwTkKQ8wPLfKs2dtMgg4
 Oj/Ezhj67GDwTpECjImYg6cT7UKKm4+qg0sq+mProv52MxHcWxXur24wldyUgjHBXUqUL64RTA2
 cORqypbAyXEZgdOkCSftIv+2+COkD6EG2kr1GiIOw6ZgtC4E4OHpBmCJaby5+r4gV0XI+FzpSlr
 O3MJ+PHYc/65u8/2qrPmabwSD2wsTmV0N84/jtQ29AslDe2IMK/fCxixowBrzBJoivQWo86IO54
 wg/gihZZaa8DrZFt23Sjp//xPms90K/UNv4weaV/rWdFamu/CP6IQemp94vq3Ne9xBvhNobmQ1X
 TTNY+5PP1KUkdr1ZQfpKiTA9ak=
X-Received: by 2002:a17:90b:2b45:b0:38e:6bd7:fbbf with SMTP id
 98e67ed59e1d1-38fbc4d5f81mr7023550a91.20.1785694730796; 
 Sun, 02 Aug 2026 11:18:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab050d8csm39682295c88.0.2026.08.02.11.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 11:18:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC 12/21] node: get UDP header
Date: Sun,  2 Aug 2026 11:15:17 -0700
Message-ID: <20260802181835.476887-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802181835.476887-1-stephen@networkplumber.org>
References: <20260802181835.476887-1-stephen@networkplumber.org>
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

This library was getting udp header indirectly via rte_ethdev.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/node/udp4_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/node/udp4_input.c b/lib/node/udp4_input.c
index 5a74e28c85..fb62822b76 100644
--- a/lib/node/udp4_input.c
+++ b/lib/node/udp4_input.c
@@ -11,6 +11,7 @@
 #include <rte_graph.h>
 #include <rte_graph_worker.h>
 #include <rte_ip.h>
+#include <rte_udp.h>
 #include <rte_lpm.h>
 #include <rte_hash.h>
 #include <rte_fbk_hash.h>
-- 
2.53.0

