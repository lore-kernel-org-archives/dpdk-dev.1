Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE85C021A0
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B9440ED3;
	Tue, 11 Feb 2025 23:02:53 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 056D840E2F
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:02:42 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 66704210D0DA; Tue, 11 Feb 2025 14:02:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66704210D0DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739311361;
 bh=0WgkG7k63XXdBJMz4QSXW/yWHJneEX5U6l1DXvmvsJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P0LyhPRwQgM2nlMCrajyZWyq6kpmBf8OZBvyqXMPjsABi2qQXqhLgQB6THFbbIT7n
 Gy7yhO+COBa6002kcxSMZou6+LhQYVWzV4/2XyGQBIfJcAHZx6TDJfnrKvD3GS0usb
 cRr9y5gk6B7Esfk70GLyf+ObEiPpehLoLmCNsnUU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 08/10] test-pmd: declare lcore_count atomic when using C11
 memory model
Date: Tue, 11 Feb 2025 14:02:04 -0800
Message-Id: <1739311325-14425-9-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
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

Compiling with MSVC results in the error below:

app/test/test_ring_perf.c(197): error C7712: address argument to atomic
    operation must be a pointer to an atomic integer,
    'volatile unsigned int *' is not valid

The fix is to mark lcore_count as atomic when using C11 memory model.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_ring_perf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/app/test/test_ring_perf.c b/app/test/test_ring_perf.c
index 57cd04a124..3bb7577629 100644
--- a/app/test/test_ring_perf.c
+++ b/app/test/test_ring_perf.c
@@ -34,7 +34,11 @@ struct lcore_pair {
 	unsigned c1, c2;
 };
 
-static volatile unsigned lcore_count = 0;
+#ifdef RTE_USE_C11_MEM_MODEL
+static RTE_ATOMIC(unsigned int) lcore_count;
+#else
+static volatile unsigned int lcore_count;
+#endif
 
 static void
 test_ring_print_test_string(unsigned int api_type, int esize,
-- 
2.47.2.vfs.0.1

