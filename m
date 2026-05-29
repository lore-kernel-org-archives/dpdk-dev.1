Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA7CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 17:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F24C40262;
	Fri, 29 May 2026 19:14:23 +0200 (CEST)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 741B0400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 19:14:22 +0200 (CEST)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-136b46c3540so7386930c88.1
 for <dev@dpdk.org>; Fri, 29 May 2026 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780074861;
 x=1780679661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CR8TTpBIqlzIcKdUbwsYtGof9JmVWZhj/UWvH2m/0hA=;
 b=tH6BvPP0Uew1hySdRMwuZJwh4NBKB5I0LALe8m1HmkDZJ44PB31x12KyrMCe+OoRyL
 gf/0IJs1DrRHIjBc0O51PJdsmWC/ezntvXj+CawYxL+o7IhTwGdeb9W3qjQfNhIQu63p
 2ZzHyXs/EFfQaROhUCojRx+ctGcsWLFwBZ6XQi8CWVOY+fQiLNlzWxBYgqTA0JnHszB8
 6Bec7q4h28Owus7M4v+SAwibugUFOTKdmYJqq7n1tDqNrjg4ZskjTvEVeoCs7gJgy70J
 mUyYRh0LvESGGILE/+UpBfrx4h1JBCQ5cF/ziWUYGUp/LDPzGQovgGoi9ffW56WkFEXA
 NVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074861; x=1780679661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CR8TTpBIqlzIcKdUbwsYtGof9JmVWZhj/UWvH2m/0hA=;
 b=FIx0Fmlpn56/TpzS9ZO5oyoFHoaBmu2jPvRsVsq8MUbHD5XRvq9QeIqBMSvfQbvpSN
 mjvmg0OmIOObbo1/Fk4IRk0u2ezWXlVncRd4MaTWPvtk4xSi6msgigeFGH2x6SV5ZN+U
 Kcg5irCj/nhFdaxM7HHxBU76CZeUa/kuUDGAvbBYTwa9rtSja9Qy4Mx/jrB/9fOQgLim
 TToP507AqTF93fRYtKaLFVmuiNsxnULnCp6JiWDU2Hqats5UjUNAaJbeNTlrllV73bi4
 qu8ctSZlUu4tZg49/SObJbnvnAjn6Q1t/8jsEHGp/SaGNNg7DYLbsIKt1YAlF39f76kj
 O6kg==
X-Gm-Message-State: AOJu0Yx1oxyf7sYK1pIMamAeEzf7cOyn4pEW7McFEo7tAY2BfCAP1QpE
 hOJ4KX9F7fE7bDTLmYHmmk1wvKJrTk+1SyHTI4D7I8ea8EjqbrApehrA366tvy60P1o7tP27aMa
 ddcGf
X-Gm-Gg: Acq92OHKs4Sbv2JHtok/3si449lvAXFhwSC4ckuXF18PCzzLVOOyiXL+mvGIwfsLLA+
 LvYCSMk3UgaGr4VhIV+QTnfW2ML0eeKJUJDidfoY422qH+3kaQI3wd4cGkDp3ADZ2yHKCFoWcy6
 efam9fWIh/gVx0CL+sUwcmMDlKfzD+E5H2KWlfVlQk4uSceQMKuz9QqxLJg9dxWc1FK26gmfNUA
 QYbVgXvAgaJuiHWX5MTK2Y2szB/MhWaEABm8JEtIX7zvr7JeWuUI7QUrWx7Po55yHIQoBU3p+bg
 ooxVFCY+C720RwHWhlMfOwB+fm6h2bnKQjFOCrlJlKWgnPmb5ARCcnD/6GgIvfKtGv6KDtGOWSq
 CZa742FIUoYNdYayU3QZtEB0Boe1ijbSP1hHwutVQg1OGO/xIgZdwaRqIoZKr4N2ySHpcQ6UDVK
 ulOr5OGoVLKVEnNycAA5XwqRYfLgawz5hVVLJyJHWDFUQMn92RbWcgXboYbd+K10eKn4GPTyjT
X-Received: by 2002:a05:693c:2c86:b0:304:5b65:5971 with SMTP id
 5a478bee46e88-304fa64c86cmr318544eec.20.1780074860837; 
 Fri, 29 May 2026 10:14:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c120csm1880350eec.4.2026.05.29.10.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:14:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/7] app/test: make perf tests usable on wider range of systems
Date: Fri, 29 May 2026 10:10:53 -0700
Message-ID: <20260529171417.526892-1-stephen@networkplumber.org>
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

Today' side quest is fixing the perftests to run on my machines.
Several of the perf/autotests assume server-class machines: they run for
billions of iterations, or size hugepage allocations by total lcore count,
which makes them time out or fail to allocate on smaller systems and on
machines with high core counts but modest memory.

This series trims runtime and memory use without losing meaningful test
coverage, and reports resource shortfalls as skips rather than failures.

Stephen Hemminger (7):
  app/test/reciprocal_division: make it a fast test
  app/test/reciprocal_division_perf: reduce test time
  app/test/mempool_perf: size mempool by tested cores
  app/test/mempool_perf: drop constant-values replay
  app/test/mempool_perf: scale down for high core counts
  app/test/test_rcu_qsbr_perf: call quiescent more often
  app/test/test_pmd_perf: skip if no device available

 app/test/test_mempool_perf.c             |  84 +++----
 app/test/test_pmd_perf.c                 |   2 +-
 app/test/test_rcu_qsbr_perf.c            |   3 +-
 app/test/test_reciprocal_division.c      | 279 +++++++++++++----------
 app/test/test_reciprocal_division_perf.c |   4 +-
 5 files changed, 196 insertions(+), 176 deletions(-)

-- 
2.53.0

