Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8825C4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B7DD40695;
	Wed, 22 Jul 2026 20:34:09 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id D2C3740A84
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:34:05 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cf452def93so35282985ad.1
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745245;
 x=1785350045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlYWfbAn806PmNfaMKfaTSVa0OnyclcB8j/9oyPOr/k=;
 b=DFVl7lHzo0uqWlwE64COOjOzRnmq3Mv+VaCpbVwAqO23RqdKfe51MiD1NdOOG90XNT
 Zq9v6umKP9OgeJc7jQEZTjEX/Z3jiDxwrhf691EFz8Y9s7n6lSXzNdDQWgMx0FGV4n9l
 M2+CfGL6GKEkfbufjuZY08dMq9BEDcnzfMSLkMs/qES5QFUxKG64/inmZ7YuXPA5x92B
 iUW6k6lwYCAbf751AUnQHQG3HnffgFNqnN8nzsdf7ZgRiirP4y3Y3iqx/4ki9WOaDgPY
 TZxR+ibiWqlCQjkKuexhYCCgZAOJXCNQLd4i6bCQ2d7mnxIfcp7a4y617djq4FWw3gIa
 CMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745245; x=1785350045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HlYWfbAn806PmNfaMKfaTSVa0OnyclcB8j/9oyPOr/k=;
 b=UVnyMclACbHOyktXALvkgg5So/wfPssBsRUMngTvi1XuUZ42cEKZ+7j7ks4m+qMelB
 66owEJzBja7ngz70X/jNKpuSAweHHFTtSFIUdMot4H2FqGnaaNpKbjJFHgIeGlEyIZgz
 5zizezzK3HkwI0QmwGJuCWM9Jn+w0HPmrciiSEpNkhbbQSa4FGNK7AG51bj+lxEKj0ZI
 Z7J+eEmJU4njxDz8POA4yDfyV8g2Y2cJaKm21GHPqzI/p5mMMpDaJxEKrChNR3YlYl6Y
 MO/pgUOWmN0/n9hmJ4jUG83iIhBBUicBTiXPkM+N7Rh+X4hubRTCHOZiOphoIzNomx3b
 jiQA==
X-Gm-Message-State: AOJu0Yx7WnLVdI2Z2liIhI3UOtTOIXRKamA++I7rti8cJIxXF63AywB8
 CwLmdS5aGSMHWoEakXHRhDXERt0VfCzGZgRymgpoYx1WKUyPZbmmQXI75iaiX2ypzSou8tzVxmr
 Hk7fK
X-Gm-Gg: AR+sD10DokVE3L0Lw9ou0n3gZqoHb+7u9nekQt0dCm1/ReoZsjPvV4hFoYaUbSlYZoS
 dBEbwxOE0JCUuTZ0WvBCI5HlGe+RBRmGf0VaiDu3hYXdoMr09hx29JezoCriO272f3pdrOYD4FF
 vfhdQZnhzZ4uhJT75cd0gDj+71Y2q4xAP8HDU+nXV5hBXoN5zUm8Rs/1RqJc12EV/7bzdM7Ohr0
 rOm2u/n7ix69HjfRlUVHmQ3pNTeLbodKlAb1NrIwAEssYKLD1a1oXQOHlBWAG1G4O123sfJDuxF
 3sqRSZs5PNAtunwKMwWdLDLcZZ/TJLF+c3n+gqm5EuNOyZP74Bqsg4ydXvknAiJxHMwQY4m3Z86
 YpOzhix5+B7qUG/0ycQ5iPQyffJ4jPo5Wf2xae0rx7ECnYMommZNEHkzOg7woAvzPxvQfa2+Jin
 wLnGlQiYTAw5W2IeSHapHTmEbjf5hTlSMTJPMFYnxV
X-Received: by 2002:a17:903:2441:b0:2c0:d94f:50c7 with SMTP id
 d9443c01a7336-2cf8dc98ab8mr56524805ad.7.1784745244738; 
 Wed, 22 Jul 2026 11:34:04 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:34:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v7 10/10] bpf: fix uninitialized warning
Date: Wed, 22 Jul 2026 09:05:22 -0700
Message-ID: <20260722183351.633025-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722183351.633025-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
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

Coverity complains uninitialized use of structure.

Coverity issue: 504611
Fixes: 17509d474226 ("bpf/validate: fix BPF_ADD of pointer to a scalar")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a2..44db85a5a3 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -659,7 +659,7 @@ eval_apply_mask(struct bpf_reg_val *rv, uint64_t mask)
 static void
 eval_add(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
-	struct bpf_reg_val rs_buf;
+	struct bpf_reg_val rs_buf = { 0 };
 	struct bpf_reg_val rv;
 
 	if (RTE_BPF_ARG_PTR_TYPE(rs->v.type) != 0) {
-- 
2.53.0

