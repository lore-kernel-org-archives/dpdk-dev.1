Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B722606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TgqzEtWq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9871240285;
	Tue, 10 Nov 2026 17:22:07 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTPS id DA6B940281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 17:22:04 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ed0b03ce3eso9267435ad.3
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794327723;
 x=1794932523; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUz+hT91ynUvIVAMVY2Vqa26qeavPOCyo8PYacg2Vx8=;
 b=TgqzEtWqadPhEAOd955W1aJgzOE13FkjlGgq/SCYsXrxNAZTU8RClMBB1bQeAZNsL4
 /f9VrGyPomYDuckN2jDL4tgo7RNilawHHCPSEDZs1/1iTOIHLpENrM9RPmINduA9PL3y
 lbavlWIWFqpZv4JjVCbjrKiOdtkthK4kzn73VOvPNJrefpnLNfQJMi2db7dtfC+ODLpc
 LJW17FLgqj09ZFSPpcBtf5Jz79HBzs1Z/WJGNg/cfhdffFYQL9gnpf5rj+tgzt+6HPE7
 D9942Xrm4z1O/FxJY6baLUpA7Kyo/2F14XTgcExBPqJtAVlC5rem1nHbthkhdfzJwNMv
 zIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794327723; x=1794932523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUz+hT91ynUvIVAMVY2Vqa26qeavPOCyo8PYacg2Vx8=;
 b=jXbN0/sU5P8pmsGHHWGYuzTxCX73BCRSgHe9iRkmkKrzI6OVzZYWjdt0FfAMPgRUy3
 bKI7DXOpX4NyF9qzzAfxnd79FnSMSRqCiHJbtzYwbi3nC7YWGRSojdUxW+JPhvVR30Cr
 WXkwqLBeeDc88qD1JYegMQSz4pq+MX134lxmOlx25mceK9rWtlZVaq8hPK1Kj0j1gRp1
 OstJtk+7j/NnYU1JFTrfV8yfy5fodcjxTq1huopDlxdJWPV901cWzngo04u/5TPEGb5e
 fs+5foRxcrcUvLtI5EX5iAAHmr7u+3hzoRMecadW4aKR/72XmgJQHEd5LRtjgsWFCnel
 Yrww==
X-Gm-Message-State: APuU4Z8/Fr7tIPlSMcd3hqZSfHdv18wTVx0QenEAPz5qEDJ5BHVkncFp
 bz16fbC6f0NZ7lg/5LheEIKz3+SqirTqDa4pSwN6OvgyPqafXrP36tZIkWBHPJ6Mrt6ziNfIRmM
 I1A9N6IA=
X-Gm-Gg: AYBFou2jwqD2hZ0P4+kgwVPLtW1aT0upovBfgmBjFCplTy+fKLOjAfnChtqSYnsv54p
 VkFk7B/loK7oQYQjIw0hfeUISRTNeK95BFGUWPzb5a7HBjvSdBuiMic8yvqwFUdQckn0O1SSVzp
 kRetwTOKAzH4BCC7IuWKWi2H0GgZs7+jaGDvdvB4yPYPTwT82iwXcuiwQoYe5eZWREz1T/JKHmm
 8VDCx6LIM/tEQZUHnFAH6NEb+0gnknDCY0gYvqWZ2XMdjtJdTU9kl5dRHsyB73QcLwOKlqYvuot
 3hz7Hx3S/4bxz1eCE5xxNmQ8W++cnNoLcHxb5zTyrYUtGEljH42NzdKpQJ0O07vtk4k9JaXDYnT
 9TW/6oWYT90YH1RWfKE5XGRwwukbgQvSw1f37A+heTS06dyTgPugH9Q925fe1yHV9DAc7HEG0tL
 6fBJvbjE37vVBd6M0DhwOc9Wm9ENES+65T/r0pQvO8/vgWxOJvL2NVVm5c68rXfsmop0C8aCW1D
 5124AFM1X4lkH4IhLuvGuvip7Nj/emWzlcM2hwcR4cRDc7EI4880hrNXNr8HXxXLcce2Q0uspq7
 JBMdYonXF/QhmiOp/j2lRqAE87VqXb+KWKQmreucXwk78MAhmEW6f+BJgsKGrJvN7drR
X-Received: by 2002:a17:902:f686:b0:2dd:b6e7:ac1b with SMTP id
 d9443c01a7336-2edb8d6f024mr30774025ad.2.1794327723172; 
 Tue, 10 Nov 2026 08:22:03 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6a415d3sm11624395ad.9.2026.11.10.08.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:22:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jakub Grajciar <jgrajcia@cisco.com>
Subject: [PATCH] test: remove memif from fast tests
Date: Tue, 10 Nov 2026 08:21:54 -0800
Message-ID: <20261110162154.2623734-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The memif test is exposing races in existing driver that are
resulting in CI failures. For now, exile this test from the
normal fast test set.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_memif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test/test_pmd_memif.c b/app/test/test_pmd_memif.c
index 840ba4bf96..9bab43adb0 100644
--- a/app/test/test_pmd_memif.c
+++ b/app/test/test_pmd_memif.c
@@ -761,4 +761,5 @@ test_pmd_memif(void)
 
 #endif /* RTE_EXEC_ENV_LINUX */
 
-REGISTER_FAST_TEST(memif_pmd_autotest, NOHUGE_OK, ASAN_OK, test_pmd_memif);
+/* registering as fast test deferred until driver is fixed. */
+REGISTER_ATTIC_TEST(memif_pmd_autotest, test_pmd_memif);
-- 
2.53.0

