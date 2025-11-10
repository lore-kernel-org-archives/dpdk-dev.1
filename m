Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3801CCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 22:29:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB9964026D;
	Mon, 10 Nov 2025 23:29:12 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 1946E4026A
 for <dev@dpdk.org>; Mon, 10 Nov 2025 23:29:12 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47758595eecso18687985e9.0
 for <dev@dpdk.org>; Mon, 10 Nov 2025 14:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762813751; x=1763418551; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=InnLTieguvd+w3vepa5IZLoe0wkQS5t4p9QGU9dT48k=;
 b=TFQgA8IXyk8EF2Vogb6J3hUiHQ1VC9UcrdqpQOsvSy+vOyY4N3jLwNZGl5ccTnYWgg
 npe9e5xos6hzKXTD3I6dxvaxfgM1Nr00D+hSLBL376emopqF5uLgUODzaQQJJiSke+Bl
 NDRQApYpnYiKDv8VkKW01Nko/jSE7AdK/2yqfSnhup/70PsaH3IM63lpYvue8cnWZ+bU
 +fs9TU9QQUs7mpDfRkXN5HlniwNv9Koramss3zH5tpGcM80YfSNz/6c9GYjIsHEpntO7
 1KK35+wmmtD0DoY+VQDFi3ZgN1fU5aWyy5hGKQ0QyOP2MQaXnR2Pg+IEm4lK32qe5MTt
 6wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762813751; x=1763418551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InnLTieguvd+w3vepa5IZLoe0wkQS5t4p9QGU9dT48k=;
 b=WcMXp+7nOheFf1de+3eGSTPlZgJR0t318rSweXRI9sm1B+3d0X1kzhwt6W4gaysxCB
 vBpAasPUgL/07PzV8J8YoUe8XK17pMRzWwJJ37Fsse21lBEooL6S433PpfLkadxgJAw0
 hVoFRlogdeWvcAVIzLxr5gYZPhap8HPyw2PvksGi4EAcsDkP8hkUipRwRNam+ZhtgLPa
 fGMjC7mTXb5dpa49ZeL54ManMzDMq7BOH2o3MqC2sdZlqbeFgQLO0QvEugagA2c99b4r
 aQ9EM4N3SZuDutC4WFYcpcZpMIxRZ5R9Ri1UAnsDIvqf6flkJSE6GmdYySkfDGhB3PrS
 r57w==
X-Gm-Message-State: AOJu0YzxpHk2dr1wibZbGdNRbLn/M+PP6mEYJl3zlWDMJNNLqhUGz7dn
 b2Sw6KsSgzOcUeAMPl8ho/xJmeUMSMR40ogkMqLYAV4jCWkvlugFiwpq
X-Gm-Gg: ASbGncvyH/2TOk4UgxhvR1JGqIEhcLWqGq0GRc09PtR4sUre15djSwcLCu3FI0pEyvD
 Kj667ivt1sCiJsrzC/1BscFhkH2srHodOS0jUAOu6yOIJCuEZ4G/AAmXGZy0rx9G5ImGTnWm8ps
 Syrsqo3NQDhhlxhpLtzBunJhY52YLQc9Po9UG0u1xXpBlt7rV60DKDkNcaCl2RQ2IBMEXX94jG3
 Gz+cuCIOTL0VOZZ6aTxmKWi4oK5j2SHZqZLmrhjDPCbFbDhcRJY+zxqTs5ZBWWeMpKvYZluGIQf
 zr7mOkuWDq+wxASIY4TT/U2FYMKRlTuQiWz9Wbdv0RRvKy2iGFQIzWcl9DDTEY11bfv9bgZFNe2
 dXwj0x5S4pK6c+s5JkjEevYKFBvLgbxz+kM8Eg82BN8I+4g7Yt3L/dZ6i5FFTIbC6OZAynPdcqr
 sd5rEFFp2vW+BIfsjZjVtJ
X-Google-Smtp-Source: AGHT+IHbYxCHFDheBsKj3PWzrMssLEmyOfdHo9ehXyPqRzq23Q2shepJmndNiPMnHDhUyAPh1OwYHw==
X-Received: by 2002:a05:600c:3512:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-4777323f075mr76410865e9.17.1762813751112; 
 Mon, 10 Nov 2025 14:29:11 -0800 (PST)
Received: from localhost.localdomain ([46.210.196.60])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4777838199bsm127765525e9.9.2025.11.10.14.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 14:29:10 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH] lib/ring: do not allow zero size ring
Date: Tue, 11 Nov 2025 00:28:27 +0200
Message-ID: <20251110222827.575488-1-iboukris@gmail.com>
X-Mailer: git-send-email 2.49.0
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

this might happen when for instance the ring size is read from
config, and would cause runtime crash.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
 app/test/test_ring.c | 7 +++++++
 lib/ring/rte_ring.c  | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/app/test/test_ring.c b/app/test/test_ring.c
index ba1fec1de3..81231ecfc2 100644
--- a/app/test/test_ring.c
+++ b/app/test/test_ring.c
@@ -505,6 +505,13 @@ test_ring_negative_tests(void)
 	struct rte_ring *rt = NULL;
 	unsigned int i;
 
+        /* Test zero size ring */
+	rp = test_ring_create("test_zero_size_ring", -1, 0, SOCKET_ID_ANY, 0);
+	if (rp != NULL) {
+		printf("Test failed to detect zero size ring\n");
+		goto test_fail;
+	}
+
 	/* Test with esize not a multiple of 4 */
 	rp = test_ring_create("test_bad_element_size", 23,
 				RING_SIZE + 1, SOCKET_ID_ANY, 0);
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index edd63aa535..f9434de536 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -67,7 +67,7 @@ rte_ring_get_memsize_elem(unsigned int esize, unsigned int count)
 	}
 
 	/* count must be a power of 2 */
-	if ((!POWEROF2(count)) || (count > RTE_RING_SZ_MASK )) {
+	if ((count == 0) || (!POWEROF2(count)) || (count > RTE_RING_SZ_MASK )) {
 		RING_LOG(ERR,
 			"Requested number of elements is invalid, must be power of 2, and not exceed %u",
 			RTE_RING_SZ_MASK);
@@ -227,7 +227,7 @@ rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 		r->mask = r->size - 1;
 		r->capacity = count;
 	} else {
-		if ((!POWEROF2(count)) || (count > RTE_RING_SZ_MASK)) {
+		if ((count == 0) || (!POWEROF2(count)) || (count > RTE_RING_SZ_MASK)) {
 			RING_LOG(ERR,
 				"Requested size is invalid, must be power of 2, and not exceed the size limit %u",
 				RTE_RING_SZ_MASK);
-- 
2.49.0

