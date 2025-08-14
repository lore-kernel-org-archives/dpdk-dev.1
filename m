Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A889CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB6F7402CA;
	Thu, 14 Aug 2025 23:29:25 +0200 (CEST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 6ECEC402E9
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:24 +0200 (CEST)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso6889165e9.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206964;
 x=1755811764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yilHh+PnLF0dUvMsFXsBE6BVlorrqmUkty7WQKe5Aos=;
 b=IwzilalkayJQdV7tG3blJJR37j4p3meo0mBp0uhpKvoUtqHiCPLAvViqjvlN1hgr72
 klR+ml8M5lNALZAmPiDfUk8m0i5PWSqKm6jZXq+PPIcjciJB8QcvgVkGocT3/BmPAH+k
 p4bzb9E1Dswr46448PoNxdwCqpwh98mTBP6RMvd315Nxu4/4P9GEHvSfXM1PKGgeW8Jt
 bTz+D9WsXdzurfrE/HRg1m7YHmFYVxRPULJMhIwLieEmcj40nvZ+050SCluQ3iLIRTL4
 EbQgcJh1B7KQUTrmzAxLcDGCJb8e/8UVTMBaGs6txHXUjS4VuepGn3A0PhsWbwJGYifG
 AF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206964; x=1755811764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yilHh+PnLF0dUvMsFXsBE6BVlorrqmUkty7WQKe5Aos=;
 b=rUGXLNB0SsfdEmZNwsQXrZklOBP8V8Gq/LztiAuY3PQ0SgXWOBESL9Vx+NkESXlhJ+
 9koQ/00HRLv6EXc7AWi4rkGuHj/zwFZa0BL+h+mWsyjfNW+WXNO0Yg7J3/LGWrzk1yTw
 mUsQZJqNWVFWS17jXkSO8x1cxWqe8/LRclCN3W7+F0ed0lahJG1F9LU3bu2+OlYG9+oV
 UE9r/NKCC4ZcNVldgm35m160DMztupEyJmzNQHYz5HzvacXVY8wwyoipEP1+sPyzJBX9
 I4hZD+BMendr9sZ2os3ZnkzxIg2AhFJ+rRjAmHZVQwro08zEVlDBh6NBHtgVETMrn8vx
 so2A==
X-Gm-Message-State: AOJu0YzAbS5knzyOqn6y15Arx6YLyDEYBfzxU15r7CxzkCzDP+GI8qhC
 elXXv5uIzRBHU3f1ajSPXxGR8dChyZYOnlCru91+FV1mFeOj+meiKNKrXxyrTae0FEh3t38QA47
 0z076
X-Gm-Gg: ASbGncsjlhKeDiS60OpOB4amuSHKmfXEo0OKenFGmef2JQeFdX5fmDvhoq7OdLuUbm1
 Lc965v6q6jgz5vyzLLOdZScYchkPovWT2x4i1ssnj54lymfqz38DgPYwz5RbnXQIcFwAlEzo19M
 f0q0Fp9KJYp8cIKzyHEXhISq6iPodMtCCxsJZ3+3uA6//EuVIWl9m/e6igVvy3gj18Yq9n6VBi1
 sNeN5hFxwEfdCYbAdHdTg6VeyTwD/e/1pm8mFlLA2vSQSuEgMELMQ21jffMnB38G+HoPFsqvcL/
 rNt9nEgQbPpSdCYpGKvPkXY/xn5dVMByUBYeeA5k/Bm5h4ajMGx7Ho1IIF+mYB7LM4ku2wRMblL
 M2TLB/DAcb5f5I64f714fTMNgOzsGGhDhfForIdPOF4ebTLU7zpPu3NmTQhHYEDvYZT/9lAt7IR
 Px9UF/g9o=
X-Google-Smtp-Source: AGHT+IFbFvd/+gIcj13VF5lkTGIzfgc39WJEo/gMXkeYmda7WH+T2KM5wd9GLmEv8qs1fQVjIwMDwA==
X-Received: by 2002:a05:600c:444b:b0:459:e025:8c5b with SMTP id
 5b1f17b1804b1-45a20c27beemr4158555e9.30.1755206963883; 
 Thu, 14 Aug 2025 14:29:23 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 5/6] app/testpmd: replace comma operator with bracket
Date: Thu, 14 Aug 2025 14:28:51 -0700
Message-ID: <20250814212901.88863-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
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

Use while with brackets in favor of comma operator.

In flow print replace with temporary variable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline_flow.c |  6 ++++--
 app/test-pmd/config.c       | 10 ++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
index 83d398f8ee..a54463f718 100644
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
index 0fda8e99f8..14af69bce5 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -1497,7 +1497,7 @@ port_flow_complain(struct rte_flow_error *error)
 		[RTE_FLOW_ERROR_TYPE_ACTION] = "specific action",
 	};
 	const char *errstr;
-	char buf[32];
+	char cause_buf[32] = "";
 	int err = rte_errno;
 
 	if ((unsigned int)error->type >= RTE_DIM(errstrlist) ||
@@ -1505,10 +1505,12 @@ port_flow_complain(struct rte_flow_error *error)
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
2.47.2

