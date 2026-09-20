Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2979C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1EE042797;
	Sun, 20 Sep 2026 20:14:35 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 20F5040E20
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:25 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so976165a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928064;
 x=1790532864; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uhlBVr7LvIUuwGqvE3jFh7veqJ/02zCN791CtXiegBs=;
 b=gl6ouFHp5g7hmKdWb1ag5JdAdimQ/zW2jowjEQkkInl62B7AqMWy9ltF8OZB6yMAIV
 hzokT83Y5k2D5KwsOP0nSsGHge3c/OHa+Sy2eLGB/8BHmZZOk7dv40Dx1N+Q7PM9xLSD
 uOHooZvgYM8m54HJX45pBiY/rdKfMzPwHcdbdT/+4d+0ZPKyCaQ7pZjMPqcX22ujZtSv
 o6ITFmcjm8lPm/qHpfNAv5gaSMDbuw+fCOQdOrxsFUPL9a7C4zGJcfv2E5m3dJfQ18wI
 0PxflFy8QmuiX7dA0G6AGoAM7XGzsc54dobriKlsoCuYmooasGiYHwiVNdmzN+GhN264
 5HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928064; x=1790532864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uhlBVr7LvIUuwGqvE3jFh7veqJ/02zCN791CtXiegBs=;
 b=b2MDovilfYlXddITnAQ1mkH+Sm6+BGQwHOPQo2LxlIxAsTIuC8W3WsbL1jCvLm2PwE
 ++lrON0AfM8kxMK7EQsny3mw4jhopZkCnZdL6btV/KvGlag0xN4bOILuxd5S5yG8wUqK
 kqGmwPPuGo5BYWUpaq73PUjcYeBEdRI1kAZZUP8kmQYqNHkg9ejE19DEYDkg8tepNTVx
 pxXsPZQ9cUXqZ7/CSt2korM2Ot6uzDeW8co2yFT5Hqqw9LMVEUjp857IOuA1z+zsFm4B
 Znp8RgYwsO8AX6CuxjdliHbCxgikDImdc2F+qo4bwhfaeHwTjwYF62bNRQQj0V+TwK7A
 RRug==
X-Gm-Message-State: AFuF++npECf9lTQhVbvzKmH1NMnJLgeVF1mo4YnMmJbUhDrefdI37FYu
 sqvFwgqxIoXpbwjddWZL2y/v16N5eGFkzltDR0vMiRgpoGAk0rRUUtHv3VY/wIvuWyz0FzJUuWg
 06aTV
X-Gm-Gg: AYBFou37Y338jZ/lwzCi5xtk8AAJgS0XhHHT9QvxUgCdYpv1KO0JP85ULoQbVt87Eew
 QFUnzjj3H+reXSnSQUJ7z2gVMvkcS9Ru8Q+xcp8xMZwLkcodrAf33wbR56RJIpBOfqwfG902XNP
 lgg0ObXkmYGNCBYFUkKEjiPDAD9+hdpFDTnhOFl9Yo4pPuXV7+JU7WjAynHLakBrzyN/it5M5jf
 gn141VZcm4en7cvsysSjHCn9H+NZ4iwW/2tzAdjdxINow2Ft4/xVBXsWUBmPEqlvgRT/V7TcrAA
 7VRa/TNfjaojem+OBjea3fCqg+SWXda0pXvedOZVOhSk8W7zv4ipcwn8RxygyR/Yom/+WFmmG/X
 wz2+9q3aAAfK2CU5EuehadaMLP/8Cj6JFQ4Jz1/EMgPojENfGyUmkfs9BtLE8J400MzvcvKKt/p
 1R99TW/LVuw0W1Fy0hYPdsp+pLoxPhSoF89eaFspi+eG5wicI2aM1p6uTPfwVOvB7ADXuX09qmr
 EUkyV1bk64FjP4vOHvl+shG1Xneq7EjmxmeLwXk5g9cuBJW
X-Received: by 2002:a17:90b:164e:b0:39e:21c4:210c with SMTP id
 98e67ed59e1d1-39e556513f4mr7869266a91.13.1789928064034; 
 Sun, 20 Sep 2026 11:14:24 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 30/33] eal: remove stale SMP barrier in rte_service
Date: Sun, 20 Sep 2026 11:10:22 -0700
Message-ID: <20260920181347.747210-31-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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
index d2ac9d3f14..0c6467285b 100644
--- a/lib/eal/common/rte_service.c
+++ b/lib/eal/common/rte_service.c
@@ -795,7 +795,6 @@ rte_service_lcore_del(uint32_t lcore)
 
 	set_lcore_state(lcore, ROLE_RTE);
 
-	rte_smp_wmb();
 	return 0;
 }
 
-- 
2.53.0

