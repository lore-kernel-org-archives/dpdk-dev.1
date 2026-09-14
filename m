Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB121C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C78642E53;
	Mon, 14 Sep 2026 07:52:39 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 4B72742E53
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:37 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so1188584a12.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365156;
 x=1789969956; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RrebAgMqDOr/jVMFCuTxgMbH6qmTQldzzkvHNgCrhKA=;
 b=e4MwWGNYvEY8P+UFXQG1N6AU8H8qH3q0YdvvhvfN9g/7T8MLGLt6QisgUN5asj7Ay2
 I30k+Up0UejAQCMNT1VXwY3mmjjDxAKP6GvMrAblIwBjXGnrCZCD4GAwcXfhOeSjlSlL
 rxaSRNQwRnBe+0N8aYNw1zjgkoOAnutt02xM4zwKYxv/e/0gC94KIuJ9GZ6DWWzJMr8n
 CmyQ5L/DUqzjW2tA5adFH5hLOtTKHqPKB8aFKa2FRTw4eV2m/9D8D/GNwGGB/m4NVN/i
 IcIqspsO8GM58EeqJE8NWgGbXVtFa3UjCEidx0GXOxXqOxYkn12DiIpW2weExivUmcgW
 uliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365156; x=1789969956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RrebAgMqDOr/jVMFCuTxgMbH6qmTQldzzkvHNgCrhKA=;
 b=EVPGjX0xnx9WwOvgjoanPE5NW0q1ypSt1UEhcdQmsYVy7jwOajKrEYeVghOi0xC3Qh
 2SqZ6jW888Sh5ub/aR4hQvzFj8MWKs4byDAUXTGNWE7YfzoKmXx/IUN+Df2cv8RcubhH
 qRBvUNN4BDcrWyqekBKX+sR1hOo1VHLSjqBGxHSt/myR6KIaM1tFSPlQVbZ1135wpdz/
 VN+2348WL+NkT8ur+XOjiSFBqcmubKScZBk8TN4X7BLFX8iuGBdKxyb6VyLCrlbx3ZpZ
 vAAVCx2cp9Fu4yIMNpvMmucC97W2b9BMCdUb/RFGRF7RIhLZT8u1TzRJPbz++xBTXwdL
 Dn0Q==
X-Gm-Message-State: AFuF++mM57RV0eQQTgsYOF/tFNbQDQjz+B8AcNCV6zbKHqHGVX/k0zYG
 YLekETzQs/2dFchNco4p2csSkOEhmRoCxzpVz6yU19J8wheM6rU+uGVQi2Sg1iUQrz5WhhU8RZD
 GoOlUAwA=
X-Gm-Gg: AYBFou12v6YGDwNcVkcvkigY0p8S1SWxHDOJVs0e9oJtDgF0xNKd8iC/RSE+4YKeQCY
 r7AonHz40qFnpk54xuoo+gaF9yBkAGWgTTp/yWjswDP/GylqO3M5F0yRlXvCUSqWKywdqM1oO9s
 UI4nLvapf4zg4uhnJm/PZlgb7C0mkKnFZ1c5APQLE1ngJuq6zA7Fu4+8N/21gNRHmGlp+vxNy4x
 QyRCksesp+GQmqzQzJsFEYeOEV9gviUp0EZqWdEyYiahDh9hu9Xhuhxie/7uqfxDfdnyNBtJmdK
 P+W8ACWNGXNp/RwhfzTXgVpEvn4h+fDiJB3l1PM97Zl38w4Fsajn4GTKTBlNBkiDhKR8fvDqIBn
 5k2MtrCiHbdqr9eb8hSpqY5fEPgOnHkOsyTLhzPFmsy7oNqDJuJjdaEj826tKdPqv4fwN35iyu8
 odf+GVdkban6DudJ7PuQ9k7i0JgcOx83nC4Oe9CK0QKZF+4PnfJLegcom/sHCdjrcZjt7dIfX0B
 mt98At1/62Fm/ETW1Uqig1fYj4qmyH9HJHM5Q==
X-Received: by 2002:a17:90b:2885:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39dec0849e5mr2858255a91.18.1789365156469; 
 Sun, 13 Sep 2026 22:52:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 57/62] dma/hisi_acc: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:28 -0700
Message-ID: <20260914054912.755403-58-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

hacc_dma_parse_queues() open codes the errno and end pointer checks the
helper performs. A queue count of zero is rejected by making one the
minimum of the accepted range, as before.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/dma/hisi_acc/hisi_acc_dmadev.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_acc/hisi_acc_dmadev.c b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
index 196aaadc05..7db93852a3 100644
--- a/drivers/dma/hisi_acc/hisi_acc_dmadev.c
+++ b/drivers/dma/hisi_acc/hisi_acc_dmadev.c
@@ -660,13 +660,10 @@ hacc_dma_parse_queues(const char *key, const char *value, void *extra_args)
 {
 	struct hacc_dma_config *config = extra_args;
 	uint64_t val;
-	char *end;
 
 	RTE_SET_USED(key);
 
-	errno = 0;
-	val = strtoull(value, &end, 0);
-	if (errno == ERANGE || value == end || *end != '\0' || val == 0) {
+	if (rte_kvargs_to_uint(value, 1, UINT64_MAX, &val) < 0) {
 		HACC_DMA_LOG(ERR, "%s invalid queues! set to default one queue!",
 			    config->dev->name);
 		config->queues = HACC_DMA_DEFAULT_QUEUES;
-- 
2.53.0

