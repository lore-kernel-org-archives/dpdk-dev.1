Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB203CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 14:01:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11AE14028B;
	Tue, 13 Oct 2026 16:01:13 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 927A140279
 for <dev@dpdk.org>; Tue, 13 Oct 2026 16:01:11 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3a4cdc9025bso1492443a91.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791900071; x=1792504871; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgUgbzmpSlJB/I/VwpFJ3+UysHAxWK8wpWg+0HRZKms=;
 b=axNde4HPbKOm0F47GEdMkt8SHhPHbOVHdWASRunfS1MHV6R/O7HKQXDQ8PVTF/2CN7
 BOaJ27vtKOL1Gt7i144Tlmq8XwHSlZntWiwoj2GvWKXEYbcFUgs7QQI7XHyG+65EHUHE
 nzbruMbfJ492gAWF464JTjPGEQoCniTidGKkAl3mqEsnhDHHcPmVtS8RuyS/LK6TzYSR
 9ZbLjdgm/ez+uoCHxJGUWjlVPizbZM35FhCWE8ZajOUs644XOnPUfCwfwvhnG/x4neS7
 OkmPWMhdkHiIX033IELyuO/xhnfU5vUzAaL0zieAlL54MIXWt499uwWJNX98Vlmrx+xz
 B7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791900071; x=1792504871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgUgbzmpSlJB/I/VwpFJ3+UysHAxWK8wpWg+0HRZKms=;
 b=Kkc6KjI1O36nwayA0Ig0zEYjXA06k0B2a+JHRWAQtxHdfmH/ZClgm9BGXLvqhkjewt
 u1ATZKejCsdDvCm8aMWMrJQz/qpyacoa9OP6dFofA4xHRAVc2kPgqM/xPpiszABsrEpZ
 sqjrf8iQFL4UySdDwdvjCiWKZ0FXSV+WAIStCtY2O1ww7nk/pfOCmIiSzh6hoAB00MRu
 WkwsUUqm2pawoKOoHAFcSwXn2BrGmSQXS72J9jeiG+zhomBB8hfmvveDmGpwvELT1n4y
 Ataq9pHmhloJjKf6Bbh+aQX1nh1tqNzSG2116Sr4m7XroDLhYSeShmb5nxyutrMpscuJ
 GdDg==
X-Gm-Message-State: AFq9FYIgUtJx+ZHs4F/cUDn1coX/4YIYSesjV9m2fqzxpFFoJGUsabKp
 nMGSWH89nw/s7bDmRIM6LAC50dz6x9aDe9gemuHJNLNSOk3whem1ZxVPzS9HtPoy
X-Gm-Gg: AYBFou37Cm2rvN11TeV+ZDUSqAv2QlQb9vGr5J9uEupliZiPxy4rPKnneaECGqC7Urk
 H7547ITgHn7VUbF50/4BBAKMyVgTBRYP3cfDlMWX94IOyUoE1cAisjStLi/EUChiqyxahrD3aga
 rI61+licYW58I4J05g5XjUv01JHrK1nBgVLi4WGjaOvOkohcU6t9rYY6HrYUa90VavHe13OG20k
 /PrDd4CoyF/60gLkcm0qXSDoUdI3tK0MHNRWESmT6HGIK47ENvvnP7+0bzLPQFQd678bSFM7eit
 pSS/YJ8LfAJwBLLHXu7J7oylH0iKuFaDNg9ChesO8/hKyh2C1oxqm3yJ5s/+A5oBwLvMXgz/ZA8
 9fzhKVtYIKA+Ya+lzb3u1c6z7uJrlIA8y81+KXPL6BFAdJumnOwHRNVvFPld4WUwoDl59lVKZPv
 BKpAg3cbilCkJS+qO+habpgGW0K5y7hUZggfC7VX132P0+JkCFZoRXT6/AMX+I28DXXpJEjv6ze
 BvkR8UvXkUIVg2B3w==
X-Received: by 2002:a17:90b:35d0:b0:3ac:450a:fa46 with SMTP id
 98e67ed59e1d1-3ac450b7738mr1560922a91.10.1791900069722; 
 Tue, 13 Oct 2026 07:01:09 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm20733947a91.16.2026.10.13.07.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:01:08 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>,
 jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
Subject: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
Date: Tue, 13 Oct 2026 22:00:16 +0800
Message-ID: <cover.1791898970.git.zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Enabling Flow Director reduces the Rx packet buffer 0 to reserve memory
for the filter table, but the size was computed from the current
register value and never restored when FDIR was no longer used. Since
the FDIR mode is reset when the last rule is removed, on flush, or when
enabling FDIR fails, the next rule enabled FDIR again and shrank the
buffer once more, until it underflowed. Validating a rule also enabled
FDIR.

Patch 1 computes the buffer size from the default packet buffer size,
which alone stops the repeated reduction.
Patch 2 stops enabling FDIR from flow validate and rolls back the mode
when the first rule fails.
Patch 3 disables FDIR and restores the buffer when no rule is left.

The same issue was fixed in ixgbe:
<https://patches.dpdk.org/project/dpdk/patch/20260927042545.45152-1-zhtfdev@gmail.com>

Compile tested only.

Zhang Tengfei (3):
  net/txgbe: fix Rx packet buffer size with flow director
  net/txgbe: do not enable flow director on flow validate
  net/txgbe: disable flow director when no rule is left

 drivers/net/txgbe/txgbe_ethdev.h |  1 +
 drivers/net/txgbe/txgbe_fdir.c   | 36 +++++++++++++++----
 drivers/net/txgbe/txgbe_flow.c   | 60 +++++++++++++++++---------------
 3 files changed, 62 insertions(+), 35 deletions(-)

-- 
2.53.0

