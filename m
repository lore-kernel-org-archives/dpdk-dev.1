Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C63F34C74
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Apr 2026 17:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8A1D402EF;
	Mon, 13 Apr 2026 19:18:41 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id 78BA3402CA
 for <dev@dpdk.org>; Mon, 13 Apr 2026 19:18:40 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2d3eb307324so2315009eec.0
 for <dev@dpdk.org>; Mon, 13 Apr 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776100719;
 x=1776705519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rTdMvycu925cmnco0sqrYd43rH2qm3/QMBZf24wjKsc=;
 b=Pc04lrGebWNsxmGskutJP0vAN04DSPpGaHq0Or1ayOo4g8/VzcnfO8K7JpAqt2n1uR
 XyvynilMh7VNx0KGh98Xg6t0iTTeCz9ydRVI26FaCGgH+Rh8h8pRi6Cua/JiYAD/kusZ
 u6bsSUItjRGds74oSNx+HJ2F9RYKh+bWs8MKRLaV84WZxF9Xp7j02Wf1c+f90YqblDKc
 C4pbb/LOMqSmDSjmzpSkB6Bz36m3sMe8NLJ3HCQ5uyMHD+nQpT6b9A0B0MPtDHoWs3XF
 czCqnQdkm3xIoiyFQcKn31uRbSiTsYpxv7j98DKaDxE4qmInBe7Khkejf5deHNc3BC32
 35KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776100719; x=1776705519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTdMvycu925cmnco0sqrYd43rH2qm3/QMBZf24wjKsc=;
 b=pXi/Okfb/K6ITuKO6IIDX2M//7ubuf2LWmN0DZCM+BRRbHr7uefnu6yQzRcwksVyl3
 eE9odPphRKM3t8Tojr4qA8X9urz1gt1oeu0ErvUOP6H6aAw0OfTYFV9cZBTRm0AUnii0
 uUdeiYxeNCVNRS0KY0MK3hyKE8wCwTWow7FOvApVVAo0khFR8/b9y3HzhalHDc5VCnU+
 LinCmlQlfcUDQfOfSth/cBmQ66n8voTSAEAgiBLJYsVIS4beSahRJLSbTNeGvNB3I6cc
 KahvdOct2oy+xhetExPCsaycBbCYWDl5S9VBTZhaWUxJmjnGqehlZpA+HfnWXf7wnKAT
 U29A==
X-Gm-Message-State: AOJu0YzmRxlOxX8BG8iSOSDIfX35/QGTZCQRGK9mdtUspMGY5sfjmJZ5
 +VxENl3YGTfYDo+osJ8p1G2UTRu0hYlqYEwdR536Wc/W8h3b+1f8NEJ20W45OpE58HnwlCCaP5q
 G6vq1
X-Gm-Gg: AeBDiev0cjLy4ccCFF2I6mGN8VW0DK5CepuUoQq9lTO888ablCMgQlunf4tkFVD7Fr+
 odIKcWcPZ196urhLH6Cf4MonQozYFpc4MutKuE/jkxyGasCR4ybKQmy2BBwVXO4NejMQtVl2WnI
 Qoyj92G5pqHcz5O7v9Cd0oCPXq0WUSiowcfPlFoLwLxBHW2L5kyD7CaFYiC8aXjYGku/yGTvxVa
 c0uuyUlQY9DrBHZHUfCwypRq1xFmI9ESNkO6D1ToHvjW4EMoHjsWsF0lUXyRXB/AyqocCDP6ux3
 8+9E04ndvNi7ObkbEHQcyY3KxkkszQKwUwC5MbqHoFBOCOXxnYQdQxUhFjo47ZeyADFsY1qi1+2
 L+9ttr7fYMa7/8sX9I6GAmPZ6lnCcQN0eg0xScvTJx0dbtM8P8qlenm+vjLl5jD5dAsMr3susIC
 vDrc533IyjePaK1K27PA62SM+HIswC8fH09TWdy2pnDvg=
X-Received: by 2002:a05:7300:7313:b0:2d8:b2e1:20da with SMTP id
 5a478bee46e88-2d8b2e12375mr2697359eec.2.1776100719245; 
 Mon, 13 Apr 2026 10:18:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55f5c69d5sm20258602eec.3.2026.04.13.10.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:18:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/6] fix pthread mutexes for multi-process
Date: Mon, 13 Apr 2026 10:14:44 -0700
Message-ID: <20260413171836.123467-1-stephen@networkplumber.org>
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

Several drivers and the ethdev layer initialize pthread mutexes
in shared memory with default (process-private) attributes.
This is undefined behavior when secondary processes use them.

This series adds PTHREAD_PROCESS_SHARED to all affected mutexes.
All are on control paths (firmware mailbox, hotplug, flow ops,
PHY negotiation) where sleeping is acceptable.

See POSIX spec:
https://pubs.opengroup.org/onlinepubs/009696899/functions/pthread_mutexattr_getpshared.html

Bugzilla ID: 662

Stephen Hemminger (6):
  ethdev: fix flow_ops_mutex for multi-process
  net/failsafe: fix hotplug_mutex for multi-process
  net/atlantic: fix mbox_mutex for multi-process
  net/axgbe: fix mutexes for multi-process
  net/bnxt: fix mutexes for multi-process
  net/hinic: fix mutexes for multi-process

 drivers/net/atlantic/atl_ethdev.c      | 14 +++++++++++++-
 drivers/net/axgbe/axgbe_ethdev.c       | 19 +++++++++++++++----
 drivers/net/bnxt/bnxt_ethdev.c         | 11 ++++++-----
 drivers/net/bnxt/bnxt_txq.c            |  3 ++-
 drivers/net/bnxt/bnxt_util.c           | 13 +++++++++++++
 drivers/net/bnxt/bnxt_util.h           |  2 ++
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c     |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c  |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c |  2 +-
 drivers/net/failsafe/failsafe.c        | 15 ++++++++++++---
 drivers/net/hinic/base/hinic_compat.h  | 13 ++++++++++++-
 lib/ethdev/ethdev_driver.c             | 18 +++++++++++++++++-
 12 files changed, 95 insertions(+), 19 deletions(-)

-- 
2.53.0

