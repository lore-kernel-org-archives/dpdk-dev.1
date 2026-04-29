Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A03FF887E
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:46:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B501D4067B;
	Wed, 29 Apr 2026 16:46:41 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id C2FFE4065A
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:46:38 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso6730791c88.1
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777473998;
 x=1778078798; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIs9BzRqNAfp4eYzUKcD8mCSnBQbspJ+WV768xtCbt8=;
 b=p+I8bHXnzMi8atVpSNl7/jyTJmDSxrZLzBFk95zQYJiW6r9lzjp/i6Dc3aM8BDaP5o
 2EYBv2dYpaxQYFWbBUFSN9X8EFe6sTLm8Puq+HmKnGgcpAAzLrdlUIzSQ1+aHyNYEWso
 Cwaon9GBd2ELku14hEY0eVrfErAk2O7aUka5znVWW4Rt9e98K7P6rghiZU9nLobMtiSo
 GFTOIQE6zq8wspStUFECZ+lodp2X5mj0KgqxN/kCIG9TL8+4v6AGUzbX7RvKLeYmRBnH
 8cNY1DN7HWbyDcl49B/3neiLZeGpUPBi7dj4nDs9UKIhq6jn0Yi4SGDwRreYPrGbKejP
 Rfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473998; x=1778078798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZIs9BzRqNAfp4eYzUKcD8mCSnBQbspJ+WV768xtCbt8=;
 b=NE4gtVevnIBOc3Kd8/hmN3rdyvomaFypDrfytCxynojK54OKIohtwpAGgsuRJMkcd8
 5FsaTsEAfHRclHys9Y9s2y/KLHWYNOdxzzAn3snZwOp9+UCLLJaWJAFwL4I6evyTj5h3
 MW/RAWnQ7EpnRUA2f9DilkDS7c3yCqeERymG+j8TxMmGHfe2klZ6qYN9Bvq+5gsFPRPN
 GS1ekd8kF/2mPD6KWTnXQKoycO3a+ryM7yF8JWsUrcH/ckJMcgEk3ytxTc1M5xlutYJ3
 /ixNNbcJ/rpGRf8ZsnLAfQryRlkGpP4l8Jbbd/0v4xK0ZpPX9wd6+M1ZFtTIedSGwYzZ
 3hzQ==
X-Gm-Message-State: AOJu0YwoJduoGNX0eke02Dvqoe6b/LACxQ0nw0opwuHOCSNWfXOwqseR
 tDHWqUT39f7C5/v617ckTjfY5luepGD6L/bosIW6O1XImgzrUCAmy9lu5i7iZ45j2Ix3aW1fYj3
 V7s9S
X-Gm-Gg: AeBDieui8Y4TBWhhees8PbbEuxN4/6iU8DfzQTB3SO/vvat2QOfU0JxsXP2y8JbImcN
 eZYIbpEyRsi0llYCDXH+MXNRUc27ydipXN7y0zznK5VJp2/UndCWIwn4G/lV7WOz4IXmDSaJl1X
 2TEiTMfDzLtOuw116isBm2BJ4A0ouzZ8DHgoI8S+6KAUqt5GummgvRypC07kqQvBsHH2/vrGyvl
 99GHdqxzGRwXRFPLV5ofVLqPtVcdazUmQUa6DDXEMmxqxu7KkXyAHiPV05MJmL680kjmmQU0NLn
 3CsKdbr4QaeXOe9nq6cMpL815JtkPnBj8iFC1Cajmlk31SP9rdTJ9X3dYjqUcaNMchbbQgzsPRX
 TtmJS7LhDDwj2T0a6K331mboTozQDtfz+CKG4qBYfG09q0045bwdpIScHCCzmaaNqQaGTpFn6kr
 OBif9vhpGmoKyurr4SnW3EEqiBQ/V+msN0Clm6epftdMQ=
X-Received: by 2002:a05:7022:43a4:b0:12d:b7e5:a67b with SMTP id
 a92af1059eb24-12ddd992d85mr3845185c88.14.1777473997740; 
 Wed, 29 Apr 2026 07:46:37 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3269b41sm2631166c88.13.2026.04.29.07.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:46:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Weijun Pan <wpan3636@gmail.com>, stable@dpdk.org,
 Thomas Monjalon <thomas@monjalon.net>, Jerin Jacob <jerinj@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 2/2] test: parenthesize assertion macro parameters
Date: Wed, 29 Apr 2026 07:42:29 -0700
Message-ID: <20260429144632.164970-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429144632.164970-1-stephen@networkplumber.org>
References: <20260419164818.20609-1-wpan36@wisc.edu>
 <20260429144632.164970-1-stephen@networkplumber.org>
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

From: Weijun Pan <wpan3636@gmail.com>

Some test assertion macros use parameters directly in expressions,
which can lead to unexpected evaluation due to operator precedence
after macro substitution.

Fix this by parenthesizing macro parameters and the resulting
expressions in rte_test.h

Bugzilla ID: 1925
Fixes: 5afc521eac6a ("eal: add test assert macros")
Cc: stable@dpdk.org

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
---
 .mailmap                   |  1 +
 lib/eal/include/rte_test.h | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 0e0d83e1c6..a72bba5fb8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1771,6 +1771,7 @@ Weichun Chen <weichunx.chen@intel.com>
 Weifeng Li <liweifeng96@126.com>
 Weiguo Li <liweiguo@xencore.cn> <liwg06@foxmail.com>
 WeiJie Zhuang <zhuangwj@gmail.com>
+Weijun Pan <wpan3636@gmail.com> <wpan36@wisc.edu>
 Weiliang Luo <droidluo@gmail.com>
 Weiyuan Li <weiyuanx.li@intel.com>
 Wen Chiu <wchiu@brocade.com>
diff --git a/lib/eal/include/rte_test.h b/lib/eal/include/rte_test.h
index 62c8f165af..d132d3156b 100644
--- a/lib/eal/include/rte_test.h
+++ b/lib/eal/include/rte_test.h
@@ -26,21 +26,21 @@
 } while (0)
 
 #define RTE_TEST_ASSERT_EQUAL(a, b, msg, ...) \
-	RTE_TEST_ASSERT(a == b, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((a) == (b), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NOT_EQUAL(a, b, msg, ...) \
-	RTE_TEST_ASSERT(a != b, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((a) != (b), msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_SUCCESS(val, msg, ...) \
-	RTE_TEST_ASSERT(val == 0, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) == 0, msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_FAIL(val, msg, ...) \
-	RTE_TEST_ASSERT(val != 0, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) != 0, msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NULL(val, msg, ...) \
-	RTE_TEST_ASSERT(val == NULL, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) == NULL, msg, ##__VA_ARGS__)
 
 #define RTE_TEST_ASSERT_NOT_NULL(val, msg, ...) \
-	RTE_TEST_ASSERT(val != NULL, msg, ##__VA_ARGS__)
+	RTE_TEST_ASSERT((val) != NULL, msg, ##__VA_ARGS__)
 
 #endif /* _RTE_TEST_H_ */
-- 
2.53.0

