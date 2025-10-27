Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD89CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 16:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05EBE402E0;
	Mon, 27 Oct 2025 17:46:27 +0100 (CET)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 863754028C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 17:46:25 +0100 (CET)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b6cf1a95274so3368249a12.1
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761583584;
 x=1762188384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1gU1PDBo6hme9Dy3CPrwxNFN0y876bpMeyd6hDmHZUI=;
 b=Dagi+bNmfKXauUrFzJcS7+SyDAQFGgbxH7GPfniQgOKG0XzZtD5KZ9Woqzdr4723BE
 dRPkrUjjsHU1Yjs7SGedhtZC1/7eujVckQl9+qn5zwDcU+At+bvPweD0bwsiZ7KHafuC
 taXkCp4Xsfc3ahbz7ooSi+zYU2O5tHBEoDxh6nMz0Vozn5cFF04ktYmjimRDp9RqxsRq
 HExsfEaZ0+EB3atjrmb/htQC+jEeqN2OGjn7hAh+8Kww6XofTiq72RPq2Sv4ySPD00de
 DGHM9qz2oO81WriTE6HXR41kGRm7p/96IlIWMAzUO1gpBD9UpZ2z6mhjx5tUfXs3C4BY
 WjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761583584; x=1762188384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1gU1PDBo6hme9Dy3CPrwxNFN0y876bpMeyd6hDmHZUI=;
 b=EuC1aotxy9mgJ3yR+lGXEKFLxE/5FB196ftOEYULGmoLJoFAl3Z210BI7VcKNRAZ5o
 FVTH0Fuv05pgmL5Zq2jTlDJTzV+QJfxK9bavbMHeCX8yvCSXYT/R0sGr76y0+jHCWRsi
 loE+MMH6+pNUYLi2u0ub+pTCqibA5YO1aHTxhBmnybUC1wFGhOFe2gtXqmbLBO8hNy9c
 MW4MokRtibPkYGnzIpHaNFxqX2frnHIN+8/TWgPR3/KFbb3z1qWieq0zy//Gkh7e0CQ5
 C95YVT2bdJuK9JJK1GyVXwBNUqqiLpzAT8QXIELixCCnk24jkekU+gpaoxfnJsyBgkcC
 qvOw==
X-Gm-Message-State: AOJu0YxdWzh+TKXlKFiDh44NlCKNw5Bl0iRBO0tgi8Qx7r0USqwJF6XE
 856+EYj4PKMJcghirzLf+Jv0QYxg2sOX2ZgEaKh0flHLff+3B6Qh9f5G6l9KS1BaYJkQHgspS0M
 +axQdK44=
X-Gm-Gg: ASbGncveXMitG2UooUh/deuEhgoYetPla9gGH3S6WCugwj7S0YcCe5w0es8fGz1Ity3
 s8QNEWmRC6D3bY1fOHYFY7SaIlrxhr6i1BQZrS9ko1VJInN4+Uo63wWju3nK3cC97h14K4ilVyq
 9pAYbar2t4b4qo6dGXhNZXN0JEu8VmLdJzNiYDG5OnyVCRYBlHI5CxVEGSZTYhz7DujoV0aErx/
 HZIfx1h391zY9ltjAE5Ef1FYAmWx7SMtrA6zU1vbM0ZIS6MYZJNOKlJVXVeb3tcsHQ0WfjyqdhI
 /QBonOzbUSJ3aVL9dHA3YgQt8lS0+INnXd/Ee8KNjM0WkBh+y6O3CcoxDZYOKET2IabzI+GemTZ
 /3GQB48QiJ3KuPlfdw+kYYXQVZI64fzfRrBdYgAQcwStd52MyVqZ2vAnLWUkDvdf6pfOq6Q1nB0
 6WtsCvUYKlNfuz3xGV46IHP5mU41O8jjZ/jNyAyDQmX45f4kIl7g==
X-Google-Smtp-Source: AGHT+IGVA4tQ7Tm6W0n68Mb+5++u3K0qBL0Zncmxd9D03OsRNv3XgcTjb/u4wx9PL0fRjTEsWzQelA==
X-Received: by 2002:a17:903:41c2:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-294cb3b3742mr6052385ad.22.1761583584407; 
 Mon, 27 Oct 2025 09:46:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498e3d2aasm89314735ad.88.2025.10.27.09.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 09:46:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 david.marchand@redhat.com, Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] dmadev: fix build if RTE_DMADEV_DEBUG enabled
Date: Mon, 27 Oct 2025 09:46:20 -0700
Message-ID: <20251027164621.175861-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Missing definition of errnos causes build failure:

In file included from ../lib/dmadev/rte_dmadev_trace.h:16,
                 from ../lib/dmadev/rte_dmadev_trace_points.c:8:
../lib/dmadev/rte_dmadev.h: In function ‘rte_dma_copy’:
../lib/dmadev/rte_dmadev.h:1183:25: error: ‘EINVAL’ undeclared (first use in this function)
 1183 |                 return -EINVAL;
      |                         ^~~~~~

Bugzilla ID: 1814
Fixes: 8f1d23ece06a ("eal: deprecate RTE_FUNC_PTR_* macros")
Cc: david.marchand@redhat.com

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/dmadev/rte_dmadev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 0f4f10ec12..e3d7c9d0ca 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -145,6 +145,7 @@
  */
 
 #include <stdint.h>
+#include <errno.h>
 
 #include <rte_bitops.h>
 #include <rte_common.h>
-- 
2.51.0

