Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D8CC5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:28:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86A2F40E22;
	Thu, 20 Aug 2026 07:26:36 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 6293640EE5
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:26:34 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1478350a91.0
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203593;
 x=1787808393; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQO5rA+xhzMkvq/qAnJO35mXbs+SUNSrql7p77lPgrs=;
 b=UMadwXRkaj+pzkoCdbUm9yo3F530q/mcooGUObIAkkTcgCDBhMO3r7oabHmC4F8eMI
 2cpGwyB6SZa9V6CIBtW2AHO4Zc+M+YHm+b5DaaTbZ0TyumOsTMLrnmdUZeu4YS8xCYA3
 SnGW4rcMV+LC7ta8NZ9irxMsgyUbJs35ebl7qBVe2GJ68H2YEmFYQwqyNSUFMZi2skuw
 dQmKxXPutwnOEGUUXjzT/x0a2zz0+rULMIXQWfbn+NF/CbU7oG6luuFznjyLaotFJRB3
 MCr4j0jy+eOsFtFOoMQi8Kz3RTewncrx81TJt0LsGfIsrZGDRmLSrD1iacgjTnKH3NSV
 pQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203593; x=1787808393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQO5rA+xhzMkvq/qAnJO35mXbs+SUNSrql7p77lPgrs=;
 b=QgvxO0UTxgfc5yWs7zLv/PUroWzvwlGEbwcyOgB0yuZT4OxCmwvVyZcfkzSJWjJmts
 SfuA7WSp9e3Sz8+6RkJG36ngCMdegwvU5ySU/0PhqKdDn4+atReEASsx/nPWVEXtZslb
 Okysh9DYu8gzKXUUpI4iNM+YME+t0ZYTjtVq+s+9k2FzOMolWiLejBbZwn/dOyZh4z6z
 p3lSLWJgPdHz2sFsezB7dYET+jzqUxoe31VKcxclioF/SfKGthiSlOGlswudTRV4tccb
 LQtOBxTrIOm7UyEspKiRI3uRGtr8xM04t8XWcdYgEPpEcGubEaLLIG8lHmwBh1sGwoT3
 lNwQ==
X-Gm-Message-State: AFuF++kAQ7otEF/KoQXjThlj3E3xGZFO1nblLQ7pxzgO4atLyKidLRyw
 iJXWYojJ5d0wlocZKlK7iEus4pTac6VXTwWeIZ2sIDGVpvr+ri/PROqn5IyPrZndVx8GEBG3Gf/
 9y7OA
X-Gm-Gg: AR+sD11dtTG2TjLava95OmfflW1WzcFcTTaFaLpMkLyJxf6kf2T+40kIazPsQ9s5vTQ
 ONznNdrDfNJ0PlOlaqgAgshSroHlw+uJ10VGf6MEQRK4WDFY2xvrqEfy44QZitHH5zvRJklXIMm
 Y3JlTCyOAMrrvIR0LU6ytpKHZPRy7QEuOYl7tZQ11qcedZ/6HA+FcgEE2XA7BxkFhv/OMPjsjnS
 C+vHKzc10ZnBMxw8S2669mQU9LKmK5KgrGiDf9E3hsMfp1ZbISPrVEeJVGmkD6yZOEzX1cgUVyW
 5vEhfa4V6rNhfJS20Dnu0XHPtDfE4r+wgnqEuxjab6YY5pcCDqT52lANHq5T2Z05mA6iPeI8aXd
 wOm1CUkL+iLtQaXcyK8JTIccZeeAo1Y9JGViZWeQgiplso/I+0Ve0jKfIvDHDI6TA/01RuJ5kIz
 AvhzeNHMx+JPW22Uuer89WtHw+ZG4OEZa4sZcAeHMJYBmBvgnAdy7JGjwQyXxiLc7wbi373WdpV
 ADCt4PcO8Re/qB9m873YOC3HFU=
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-39580a4d031mr19097507a91.3.1787203593456; 
 Wed, 19 Aug 2026 22:26:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:26:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Yipeng Wang <yipeng1.wang@intel.com>
Subject: [PATCH 58/61] efd: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:48 -0700
Message-ID: <20260820052251.1453273-59-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Copying small key with rte_memcpy is better done with memcpy
which enables more analysis checks.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/efd/rte_efd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 4dfc0ec9a4..09b0b01d90 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -18,7 +18,6 @@
 #include <rte_malloc.h>
 #include <rte_prefetch.h>
 #include <rte_branch_prediction.h>
-#include <rte_memcpy.h>
 #include <rte_ring.h>
 #include <rte_jhash.h>
 #include <rte_hash_crc.h>
@@ -1060,7 +1059,7 @@ efd_compute_update(struct rte_efd_table * const table,
 		rte_prefetch0(new_k);
 		new_idx = (uint32_t) ((uintptr_t) slot_id);
 
-		rte_memcpy(EFD_KEY(new_idx, table), key, table->key_len);
+		memcpy(EFD_KEY(new_idx, table), key, table->key_len);
 		current_group->key_idx[current_group->num_rules] = new_idx;
 		current_group->value[current_group->num_rules] = value;
 		current_group->bin_id[current_group->num_rules] = *bin_id;
-- 
2.53.0

