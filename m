Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3241BC61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D101140A6D;
	Thu, 27 Aug 2026 23:43:26 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 15DC940A75
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:43:26 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d7195706f1so3959085ad.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787867005;
 x=1788471805; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M4Qe4kh9mwF/R2Ru9DFQELLoHMbR494Wpmvz5s8nJcU=;
 b=I0u1M+VHgeWeZMbdtJXOEtjtHWlYQ/h0or/8CMLv0/RwWHXQrphz+JXJiNWhQVcU5i
 z8wc1Nj9FPJqMkHvFNRlJcdsjcjVbWXjgbpoy254DgvJRf7BocowPZhPH5IsGFNZmH2L
 dQ0VkY4w9cFiic9QS9vlDWYxgwHYisieiADgf4ICDFAWotJQOzLNtUr9gQiXCib+Ga1C
 hzK5MgZs9ppd1+w+dI59kmvP2kYh0uT2zw8NapT6A4hTjxedgfzZiNULiqDsnyccka5F
 F7bKG2jxcJvUvRXFQy3B0EDcHXEtv9Dn/YrqOg8TjctO5mtFlgXgADh16X5mztoDopU4
 0CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787867005; x=1788471805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M4Qe4kh9mwF/R2Ru9DFQELLoHMbR494Wpmvz5s8nJcU=;
 b=CpqkjrCALmG8CjJYp+V39Nl8ibmOuX5W32ZUdOBkdU/HFBK11kQdBHZ5vM8pvYaeLB
 Sb5fr2D80r0qo2O/v/zjXqATJ67vAdGlSB0YihWqtSWs+ygl31LMPcYKGpvF/5+ckNJ4
 KIB/mYq3vfp145NkJa1bNNGkifAEU0/z08dXDM295b2jrKmwOwHGPbmMLq0388Lr7pqD
 11/kZ0GxupgNU/JQeeaZwAXq2OuTpZ+q6gK6sNhT9ada+R31rZCGOD9TbOy4xOjFZY/n
 nQHv0BWdMbuRoFnMbGGm4/8lm7lo/v/iCu2v3wJXV+8EZrLa59A1nXryjuE8n/caQrG3
 ZwFQ==
X-Gm-Message-State: AFuF++lRMe6piPlzelDoLSowpGrMdElmw2MizzcDRBIzy6DNNjfuLIQm
 jAyq3WZ//en2GLH5E7ykFcuxanbhJb5EDdwgVGzV7wI717B0U7E3v8jEGpVYo6XNxlYO9AWnAdI
 LQdly
X-Gm-Gg: AR+sD10hCP5aEHX6jzG/WTE8psh6YACswR914nl/jkrSO4z0hfTlYmutXiu+5FUCLu7
 s6OFuEhXuQOp05mDgCXzEMiwry3COF6e0SRgjBuYbfzRMI1/Ai5AS6JouhesBOOw1sG1U45Cg0E
 tMkIRnrUyF6JE9ULY3H+cOXkmkGllI/JiDA1o2Mw0A0KaqgNwBdZTkrbdx0x6QCoHUgSk0KJ/Lr
 IQiqxh7ZpNnmnxR8HAOueX1QwEzkoU2apYpt/8Jgc30i5IIbCXT5dauXSkpfG4aCehAuG5BxBnz
 73QyrRO14r08wRBp2p/1uFZY8aRvRTTLoUXMCUsaUZEk4hr9dTFmTUhM6ks2UpuWmwlrq4CRJzs
 3X5J3ruZBmv19vIyNkq5OE8angOX/nxv1ftrB35YtGAa2Kr3OT9YkgdJqmQlRtxO4MBcoPpch66
 p+vr8nF0ajtCSbat8LWkXlAZy7MGZhTMzprKhQ154gYSMwM3xXTmpKLVkahjOjeHIYmC9ZcOqw9
 ONNb0QeZtL1HoVn4AEy/kjgn14=
X-Received: by 2002:a17:903:350f:b0:2d6:d3f9:d394 with SMTP id
 d9443c01a7336-2d74ce2d81dmr37213605ad.0.1787867005235; 
 Thu, 27 Aug 2026 14:43:25 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:43:24 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v8 10/10] bpf: fix uninitialized warning
Date: Thu, 27 Aug 2026 14:41:49 -0700
Message-ID: <20260827214236.1415047-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827214236.1415047-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260827214236.1415047-1-stephen@networkplumber.org>
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
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a2..4641ef2fc9 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -659,7 +659,7 @@ eval_apply_mask(struct bpf_reg_val *rv, uint64_t mask)
 static void
 eval_add(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 {
-	struct bpf_reg_val rs_buf;
+	struct bpf_reg_val rs_buf = { .v.type = RTE_BPF_ARG_RAW };
 	struct bpf_reg_val rv;
 
 	if (RTE_BPF_ARG_PTR_TYPE(rs->v.type) != 0) {
-- 
2.53.0

