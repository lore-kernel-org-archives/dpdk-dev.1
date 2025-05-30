Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA4C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 08:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 166BF40267;
	Fri, 30 May 2025 10:19:09 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 9D8994021E;
 Fri, 30 May 2025 10:19:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7x1l6rMrz6L4rs;
 Fri, 30 May 2025 16:17:47 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id C85F01402FC;
 Fri, 30 May 2025 16:19:05 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 May 2025 10:19:05 +0200
From: Rui Ferreira <rui.ferreira1@h-partners.com>
To: 
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 0/2] fix eal: unregister alarm callback before free
Date: Fri, 30 May 2025 09:18:42 +0100
Message-ID: <20250530081845.64297-1-rui.ferreira1@h-partners.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dcbff1c1ee8c48598294306fe80167ef@h-partners.com>
References: <dcbff1c1ee8c48598294306fe80167ef@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml500003.china.huawei.com (7.182.85.28) To
 frapeml500007.china.huawei.com (7.182.85.172)
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

This was flagged by Address sanitizer as a use after free in Linux. A
pointer is freed in the main thread but used by a callback in another thread.
It can be reliably reproduced in Linux with ASAN but I could not trigger the
same issue in FreeBSD.

I've included nearly identical patches for Linux and FreeBSD. I did not
include any changes for Windows since the same issue does not seem to apply
there (thread is actually cancelled, no shared ptr).

Bugzilla ID: 1683

Rui Ferreira (2):
  fix eal/linux: unregister alarm callback before free
  fix eal/freebsd: unregister alarm callback before free

 .mailmap                    | 1 +
 lib/eal/freebsd/eal.c       | 3 ++-
 lib/eal/freebsd/eal_alarm.c | 8 +++++++-
 lib/eal/linux/eal.c         | 3 ++-
 lib/eal/linux/eal_alarm.c   | 9 ++++++++-
 5 files changed, 20 insertions(+), 4 deletions(-)

--
2.43.0

