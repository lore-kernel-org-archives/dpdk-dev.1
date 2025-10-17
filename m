Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE62CCD19F
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AB5142E0C;
	Fri, 17 Oct 2025 17:02:54 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 66EC7400D7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:52 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-27ee41e0798so32100665ad.1
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713371;
 x=1761318171; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8GBtdCAKAOQkryxFZabg54DymPpJv/OeW+Wy6oMVCU=;
 b=lRu5e16NpSqFRQoDVLfq854q0ZEF8Me2UpYWn/RfLLHTSUnTW5L/URz4gf8k/reYlt
 ixEaeOyauUIPsxuzm4nam7h6NJ1N1tkCuLLmC3CTNuZwG3rVOvu1YGFLk3EuLOWWryip
 gfZLJe40TDpG7a/M5b0cFRcVoyI7BQqclBKDF7TJ6VH9gQoE82ybwOfMwBZhcmAnsM/S
 rz7OjFw4hDNk2Pym4xzvr2ynFZORTtoy2m4sYlswMPhsgw9bvN2wCI2/OkCbzBDZnJ/S
 kA4wu2xfplgtwbOpdaj7P0dq1UL3ofq+/5b7kdcymSLEdMHE2vafcrofTLeCOob8r1Ld
 sNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713371; x=1761318171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8GBtdCAKAOQkryxFZabg54DymPpJv/OeW+Wy6oMVCU=;
 b=c4SZ5qWuc8q0caDrgn6xfC/iWIk9CJVgIQK3SuhudfKk4yG1+RE5876viE5fr9Sf+7
 p/Q3I0eodWaZewEQJyxwAHzU2rAZOTG+6nbRQT1drAmCCdkS6s1mZyCBbJAXGTsvGvUW
 MZYayk1hQSdH128e36RITJWO4lidlPW48tZ8Kxht4Dh8R1MC1ogMZeK0di44yM/uNlo0
 ZmRqDPzSfGlP78V37XR2cWgj9jp7KzhetUJCu0Fw8N2mLt4tC+2osaH6m61H7kmq2/Vo
 kzBuTQStKalPDpA/GDfoPlNYiSLNmeDM5tvbyg6wXMd+VFjF+fClUOOeIPYW8t9KHGlW
 CpYw==
X-Gm-Message-State: AOJu0Yzc53xvIElFfoKpiGJiDTJmxSbYAy5NBbQA5z8La0ldKmFPGDoN
 GaXEUe/EODjh5Z/MhpRCoxccaYna3nRbjApTovS8yZ+rrVOvXNRbfztSp+RzTORi5mmb2lxTGic
 f9bIEHZE=
X-Gm-Gg: ASbGnctc04DxvvYoceToljEcFDppesp125BvRkyQ0n1p1wjRMBObWg8pVqjF7d5ZHpn
 TTBhqSlVpWZN0+HC1iGzK0R1wZIn50+tAXvTAcG8Dkcns/4sZ5bvky46tXofVK8eZ0csgSp0lXV
 uZptL2YmP5Tlh5HZ3WEJbOgEHAsaL/rAa7Dnly2C78W2UHUPzKwgodI0zuxNqz1mkQfmaISW+UX
 /NkdMn4lDBUoRcVItqElVlsnwqPoygHi7b8YWWCgOogZq+9Aa47luZZJ0GttKErfDN7ImM8j6/9
 SB7a/GIIlB3D4BjLG+zXRPQIg6C880qh84YB7K37P/3HK069FpUTNCw06wtaX2vqnmm5OPUTsbx
 P5om8jc9cWPCTi/bij3ypFRNTQvUZvOEFCRIRbWZe+C92AufcFZxjRd9WfjzeVioT08Y+71rFsI
 dt4zM9EfBCpUrR1EurN8pqd6dq+I4Nvv10nGMP2zblIoMXtcm8KNSbgH/IH0J7
X-Google-Smtp-Source: AGHT+IHhy6vX0OP9rhMZBZFRYdZmafyIDjoxBZH5NJ1RFMsgxJxpbgaTm4HRnxls913yWkv27yjyeQ==
X-Received: by 2002:a17:902:ce12:b0:28e:7fce:6685 with SMTP id
 d9443c01a7336-290cb94792amr47575165ad.32.1760713371244; 
 Fri, 17 Oct 2025 08:02:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v5 4/8] app/testpmd: replace comma operator with bracket
Date: Fri, 17 Oct 2025 08:02:05 -0700
Message-ID: <20251017150241.28511-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use while with brackets in favor of comma operator.

In flow print replace with temporary variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline_flow.c |  6 ++++--
 app/test-pmd/config.c       | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 38e751f3f3..aadb7c20b4 100644
--- a/app/test-pmd/cmdline_flow.c
+++ b/app/test-pmd/cmdline_flow.c
@@ -8333,8 +8333,10 @@ parse_prefix(struct context *ctx, const struct token *token,
 		if (!ctx->object)
 			return len;
 		extra -= u;
-		while (u--)
-			(v <<= 1, v |= 1);
+		while (u--) {
+			v <<= 1;
+			v |= 1;
+		}
 		v <<= extra;
 		if (!arg_entry_bf_fill(ctx->object, v, arg) ||
 		    !arg_entry_bf_fill(ctx->objmask, -1, arg))
diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index c1bd6921ea..5584a9596c 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1501,7 +1501,7 @@ port_flow_complain(struct rte_flow_error *error)
 		[RTE_FLOW_ERROR_TYPE_ACTION] = "specific action",
 	};
 	const char *errstr;
-	char buf[32];
+	char cause_buf[32] = "";
 	int err = rte_errno;
 
 	if ((unsigned int)error->type >= RTE_DIM(errstrlist) ||
@@ -1509,10 +1509,12 @@ port_flow_complain(struct rte_flow_error *error)
 		errstr = "unknown type";
 	else
 		errstr = errstrlist[error->type];
+
+	if (error->cause)
+		snprintf(cause_buf, sizeof(cause_buf), "cause: %p, ", error->cause);
+
 	fprintf(stderr, "%s(): Caught PMD error type %d (%s): %s%s: %s\n",
-		__func__, error->type, errstr,
-		error->cause ? (snprintf(buf, sizeof(buf), "cause: %p, ",
-					 error->cause), buf) : "",
+		__func__, error->type, errstr, cause_buf,
 		error->message ? error->message : "(no stated reason)",
 		rte_strerror(err));
 
-- 
2.47.3

