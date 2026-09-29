Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D402FCA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C6C942E4B;
	Tue, 29 Sep 2026 18:38:36 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 3949D42DD6
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:17 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-880483985aeso1981872b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699896;
 x=1791304696; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IhRq59k12zTMRFLNUpvq0zS183zGa3EeTpW/mN/RCwg=;
 b=y89N8G2umnI2YFw/xuSg8E21PijXIbSTQBbvzCsKPoqikLNtk3jFAeCMWDzC45Tl6m
 ajk1Qv4zYcb6ErwI5BIjSL5vgkuCgbssRyRr6D8I22UDe7TGTVmigM+uXK7H217ioBmM
 2JZ2P2jjRlXtNVItvgsYIWutcDq5waC6DXAGbUOYNUl1MKt2x739AOeQU7nQFdDbrUey
 /Y3qRSwUx/7/Ox6YxnZVJisdtT6lghs140cqRirg6Er09wvt6QVkhuB5QK2sNTN+OZzX
 4ohE7bSguyfjMLmzMzFqOWuZPIYqvIgSPz3BKFF0rjyEP4v5uDA4Cvb6yxieZyd99xXY
 mI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699896; x=1791304696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IhRq59k12zTMRFLNUpvq0zS183zGa3EeTpW/mN/RCwg=;
 b=2po+RjCGB7+Eo/w0qn94AxyiRb3a7jJ6awSBctKby5DUVq6ywR6X9rn2rK12UpUzGs
 uMI7swfJSLJdaCjccureauxSzxwbJRYSvU/1cFQdd9tTpkwqZgD7xCQHmRFOcLEkccGg
 IfYkik+x0CaarZ7O6v59giuYqODNg5xooayvFjEwH2bP0P7oSXSlAHBmYnkTCLLVV+yd
 +P1VWFvrL8rNCUXw3fPQDp8xtpqT9NqA0h7uyPMyS1QwJMWfhira2Ov4GNQBIRMu2wJS
 T2IH2FpzL3VOQI1Li/bAKRDNDqxJnL08QSKDqZ8R3xd7maF9rZsVX1dYB7UFiklgAUnx
 HUPA==
X-Gm-Message-State: AFuF++mJkW5qi2SL0cFpt5YX+RtzFhdxeW4OgnoDPpBuffF4C5Ua9Y1K
 xel8y/Pm42UvAV2c3+d6sNqX+R6zJ6oVKyR1Yvg3AqSsU8DlZr/6mzACCQbYiQNQu28TGadmlS3
 rQvxaEtI=
X-Gm-Gg: AYBFou1aebbD+NfSu0sVUbfbZvpEQDczGcloNvl0Pz3aqWN7Rz0xzgdrAnW+Foi30fI
 BbHg95DwTtkb498JxOz09CyXy4Tymj2bwWMP8D+ZDKBAEcYNJ+KfV3r8Ch6W1B6+SacnWMxdqFC
 m5J7ajXWs2TSEdj5GkDY1ZblReF0sz3IN19jQKJTjuVipntXoptlXjiwR97wBsujn2kHwcsyFG+
 kAugDZPq389IzlTUcCiArOHyaXtehd9T6tMkDYsb1wz6LBADkAGSYl9xvp4Z88s2cGNYOSLsbHx
 1DBqst8y5+s3gQJDIYFaJinMJn2L+EeWGWAg0jCpFHJGM09sXJTEZTst/qYlgI7hWHK/ZuuSmR4
 ah+ifaZF9aTLEttx6DMfM9bb4/i155dYRahtxTuX9J71xh/eiuAo1CurfTWv993wSCkWcz+jVBL
 dnSBUyAel5//qG8rwg/eGpIg0g5v022KKv5AiC7wB+jbQ7jHzA62neqdg0TpQTyv+CpgFTWo9x3
 dtLr6Lx3BJwzl7LMEce3yw4BUCjOMR5XRDJTw==
X-Received: by 2002:a05:6a00:813:b0:886:46c:8a1f with SMTP id
 d2e1a72fcca58-886046c8ad7mr1651533b3a.35.1790699896385; 
 Tue, 29 Sep 2026 09:38:16 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Kevin Laatz <kevin.laatz@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 09/61] dma/skeleton: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:12 -0700
Message-ID: <20260929163800.1108305-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

The lcore argument is converted with atoi(), which validates nothing:
a malformed value such as "abc" becomes zero, and the range check that
follows only catches a value which happens to land outside it.

Use rte_kvargs_to_int() with the lcore range, and log the key and the
range when it does not fit.

The parsing function returns void and probe does not fail on a bad
argument, which is left alone here: an unusable lcore still falls back
to the default. Only the "Parse lcore_id" message is now skipped when
the conversion failed, since it reported a value which had not been
parsed at all.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/skeleton/skeleton_dmadev.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
index e287802eb9..44158d5a7f 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.c
+++ b/drivers/dma/skeleton/skeleton_dmadev.c
@@ -638,19 +638,24 @@ skeldma_destroy(const char *name)
 }
 
 static int
-skeldma_parse_lcore(const char *key __rte_unused,
+skeldma_parse_lcore(const char *key,
 		    const char *value,
 		    void *opaque)
 {
-	int lcore_id;
+	int64_t lcore_id;
+	int ret;
 
-	if (value == NULL || opaque == NULL)
+	if (opaque == NULL)
 		return -EINVAL;
 
-	lcore_id = atoi(value);
-	if (lcore_id >= 0 && lcore_id < RTE_MAX_LCORE)
-		*(int *)opaque = lcore_id;
+	ret = rte_kvargs_to_int(value, 0, RTE_MAX_LCORE - 1, &lcore_id);
+	if (ret < 0) {
+		SKELDMA_LOG(ERR, "Invalid %s, must be 0..%u", key,
+			    RTE_MAX_LCORE - 1);
+		return ret;
+	}
 
+	*(int *)opaque = lcore_id;
 	return 0;
 }
 
@@ -673,9 +678,9 @@ skeldma_parse_vdev_args(struct rte_vdev_device *vdev, int *lcore_id)
 	if (!kvlist)
 		return;
 
-	(void)rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
-				 skeldma_parse_lcore, lcore_id);
-	SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
+	if (rte_kvargs_process(kvlist, SKELDMA_ARG_LCORE,
+			       skeldma_parse_lcore, lcore_id) == 0)
+		SKELDMA_LOG(INFO, "Parse lcore_id = %d", *lcore_id);
 
 	rte_kvargs_free(kvlist);
 }
-- 
2.53.0

