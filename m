Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46075CCFA13
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 16:35:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A89740671;
	Fri,  1 May 2026 18:35:42 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 38EF240656
 for <dev@dpdk.org>; Fri,  1 May 2026 18:35:39 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2d868d014a5so2197692eec.1
 for <dev@dpdk.org>; Fri, 01 May 2026 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777653338;
 x=1778258138; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7iRirOyaJDHR2TMCpyopQ/Wifj4rh31jYZTopjTg8Q=;
 b=kn80AZ30uPTIvhLYST/ClAlV5xiCZg16CGKguHoToKrx2riKQVwDfugq025j6AowTY
 LjxeFblpfXf99WXtaeg0yPBSTLbNgDGvjg0PxxNyygaM4qBaUdTEvG2UOxbXnk6y3XQA
 KJYwzcVPF+RPW1SWdr4JISYKJvOAsyQ+xn3/OdQhU3EPMIrL3/U0juOCHAktktigF0w5
 uhuKkQYGBNO4XtNyMefkRlyv42cMkz+h0S7luvXyhyLSgdKJAg3bYIONl5amSvcmrhId
 mihJS6/X7KfXa1bDKU4H68HC3hctqplyIaY2BJ12/salAgAJVtBS0cSFaO61rERMvi4V
 C2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777653338; x=1778258138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d7iRirOyaJDHR2TMCpyopQ/Wifj4rh31jYZTopjTg8Q=;
 b=QFn+hOs4meESCz8kfFfOG8egWK+oEC3iWoyTwJC3JDCTqcZKdAfbsZMOppq9QkrQes
 hQZDivn7tWSNDPoo37m3+EpHEGkV9x/8wrb/b4sS06cFqZ0c5Uw5z748KrKj79rBLvCQ
 WASzSJ/2WMyaZD2Nl1T1fi9GfAojD8qJpohQOI1EmEDJUFP0EiqN2wXSgU7AsPEk5Rfr
 1gNhww0/9ZbZzgQyEjNGd4h1p6q+1zjTwtrE+Lv/sLyUY+qw1mAOv7mSGe7yQef3BOod
 FvcTEkpK2QaSKN7i8VN4eLcCe3Ect/pAs8KU2UxOydbzJUo1C0bTyn8qhYpoMeaBJ/a4
 8lCA==
X-Gm-Message-State: AOJu0YyRx9Zi6bmwjPWQ4yrLZyOYF6AnVHeDDbJrZScYJwtMbN/yJcQu
 0/w501pRMcJypDTlo5BrEPt0qP2uu7W2T3mQP1ISInFn9Kycttp5sPaf7W9umNWZLW2rsOjm1YO
 rjzUv
X-Gm-Gg: AeBDiet23v63HVo9tkk3ZbH7YgWXs/7uNP5PHGpbWFl4zvtcO9D/yFkqtLRQUwrGVm8
 aJToO+cz6bWX3BnEofBKgPUWeNIUBGyvR7qgy7/pvTNa7DkUqVmHmdzKIqQMBbLOkk9GqR0j5ig
 CG3fzX/dePq5UPqwkIQCLH39O7WLNp9JEzLE7eMW2dFw4NscwJdbZaW4yWq3wjDlm0RhKkSIqH+
 iiKnUmU5IZYoFFIRSX/Ix07hwL7mZToUI6xoRu76Imk/vuIsoU2hOPiDgTOCn7H16zeFglEKtct
 Frt2A5gIPbDmn7M+YTfZ0PKXcmm4KG7RpctdHQmGv5i+RalJ6IW8YhzgqDVDvWHWu60AcZUL/fI
 odhTamBkEERCLsfCPtSZk1CTLpooHq+WOBP+m4QIR7aXVJ0X/o6zWXHI9ElsGw3E+vSe+AY6D+E
 UhNHQgtp2Xh5+5121QYcKgTSxndnt6SyJ/KVaNnqIID4M=
X-Received: by 2002:a05:7301:678f:b0:2cf:3de7:22ad with SMTP id
 5a478bee46e88-2efba28ad10mr40421eec.27.1777653338174; 
 Fri, 01 May 2026 09:35:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d5f0sm5196893eec.2.2026.05.01.09.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:35:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Weijun Pan <wpan3636@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 2/2] test: parenthesize assertion macro parameters
Date: Fri,  1 May 2026 09:34:46 -0700
Message-ID: <20260501163533.2689152-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501163533.2689152-1-stephen@networkplumber.org>
References: <20260429144632.164970-1-stephen@networkplumber.org>
 <20260501163533.2689152-1-stephen@networkplumber.org>
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

Signed-off-by: Weijun Pan <wpan3636@gmail.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 .mailmap                   |  1 +
 lib/eal/include/rte_test.h | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/.mailmap b/.mailmap
index 895412e568..3c08fe9aa3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1772,6 +1772,7 @@ Weichun Chen <weichunx.chen@intel.com>
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

