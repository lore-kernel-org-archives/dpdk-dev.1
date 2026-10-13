Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E86CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3F8A40E27;
	Wed, 14 Oct 2026 00:35:33 +0200 (CEST)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 577E140E25
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:30 +0200 (CEST)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso19000125ad.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930929;
 x=1792535729; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uZ/CcvQi+Vm0t9gd8Nyk4Exn/kkvJeOY/wEf45YADds=;
 b=kUf6iyykdJxZJ9IsAe5LzaLIzCqjeAtsEGgfJjy7xMgzxv/pm9udwZYWTRGAkc5obt
 qx1RyeO+ncYDJxwawx77520DYiJaGWJQiWmGxWFfHAgZcOKkaV8yS1WTKuq2OjiDkv9w
 bhiq2jzkhiUv1XUirh/Mq2MB8JrcXjawC2TOu7ihtUdOyC6c5BbE/Z0lKLpm8uiscNX+
 RraMmWIMWNSBmV1w9So+MEktK3Km4q+H4wT4Gcpd59v3oI/YFtoHZ1EZA7IDp9tmbT7g
 lRaIt+jt8qDPmqeWNm9txWHupKybHV13L4dk1qnra4CzOxoEaRMNyBfysMTzEIpKRSee
 70IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930929; x=1792535729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uZ/CcvQi+Vm0t9gd8Nyk4Exn/kkvJeOY/wEf45YADds=;
 b=gnPAIY+Q5O+hd7A8GDysnBx5wnsbAZdT0tDjs5Lkd/jnijk0WuOHZcMHCIbGcZsWeu
 yGmaS4Xw6BkCcSR9E6mLHibbZL38JBSKSBR23uD9mczVo2xXeIX42ZvxQJ/lr4vhSxhr
 yyjJcjYSRVfL7cjKWulbiyGA4CFfnkBMdJPKnbEhyLYBAOnn2GmoBlofOUCoTlcRmdpc
 05oJsJinRArGyMBejnGIWnJaJfXV/snq/7OgUKFwtInuGqvjz+LY98BGQ1VOCU+a/vA1
 Lvto7zWYrpueNqnNO/NfIjSMcd7tFcxc5y/7zvg6Z7SytT9Wlv2QYmUL1UQ7MFT6VOo5
 PYBw==
X-Gm-Message-State: AFq9FYIVDweHIuIr/6/K/slACqq2+VKUW90uf6zRElyGLSo9z3vNoRnl
 FKpK/VLCKcktf3XNrqFJXFrbfdBXGW3qAA+ZpFL/TQl55k/X/+KBbaNADSluT56oTbowNUGW6LI
 /CeKRZTw=
X-Gm-Gg: AYBFou0+x0Ku/+hrReZFu2A2KdzTDnRXoOepvAKhEFtgDhv35jm+HURk8bU242h8pNy
 RKNaPeeGMGbx8wChRby2o9ogCpYLJfDwUuRlzY1tuODXOQa5zZLVyb8LeXCl/r3b5/Mq5JJwInV
 qP2GLqt3HK8OE1tnQAaoFMoI6TsJRWgtBI0H5NtP+toPHPyhOIVUxslIkYwyKXn1QWBh8Gwutqe
 x18I76sPI7QJJeEkeYA8nOHYPQqUmZlKHGx4SjQgTqeVqi6L9I9X2z6w/65BUCrUyxVcbFJZ4aT
 6zL5e4rc8ovLIAQ8szmb0bSzo9O9j28XvmW+Y0rOSz4oa6EjgCu4LaLVrlg0wkIzZX1CESw6GqM
 Z0eMxxIUUiC0ZBAgfhQA9txHSBIaWVE5VZ+hmTesuEu17N7UMROUZtz8R/hP7dAJarTMMMp/jY2
 iAuy6+hAJjNdM7W5q6OLR4atkFyxPLDLR9QVJUESBo5hixaEaq5y0SOPeI4IdHGW8MnQAfyNkR7
 ua4WQcVRmnY6XazEE9/ulCA5RAaiIjQUGHIxA==
X-Received: by 2002:a17:903:1b68:b0:2dd:c100:4b77 with SMTP id
 d9443c01a7336-2e842ce7f76mr115276575ad.46.1791930929490; 
 Tue, 13 Oct 2026 15:35:29 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:29 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 28/29] eal: remove stale SMP barrier in rte_service
Date: Tue, 13 Oct 2026 15:22:41 -0700
Message-ID: <20261013222410.2257622-29-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

Leftover missed by the C11 atomics conversion of this file. The
barrier pairs with nothing: no store follows it, and the next use
of the lcore is synchronized by remote launch.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/rte_service.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/eal/common/rte_service.c b/lib/eal/common/rte_service.c
index 5c3a350ae8..cb07ce83fe 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -795,7 +795,6 @@ rte_service_lcore_del(uint32_t lcore)
 
 	set_lcore_state(lcore, RTE_LCORE_ROLE_RTE);
 
-	rte_smp_wmb();
 	return 0;
 }
 
-- 
2.53.0

