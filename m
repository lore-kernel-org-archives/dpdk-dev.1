Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588B1CAC5AE
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 16:56:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1099540DFD;
	Wed, 24 Sep 2025 18:55:41 +0200 (CEST)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9FE4640695
 for <dev@dpdk.org>; Wed, 24 Sep 2025 18:55:37 +0200 (CEST)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4c794491480so699911cf.3
 for <dev@dpdk.org>; Wed, 24 Sep 2025 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758732937;
 x=1759337737; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7HeAQ0k/uS0aLDgZgNH2yordxNv1Wpz7G3JDMyHH4M=;
 b=kjCF/BFhmPYLnipNYUkuDOYwoneXbDjUqzHpDjvFel5dN0yoZWrc2BvXdshYUltuXO
 Kr/hUwFs4+bwth9wqvJNlgLH7fN+2KUQ2PRYdozQmQ98IqSnfCQ0QRzBG3NLclXODQNL
 DI41e8pVTEqZjksThNlH0MorUDdJjdygTFYCf+PWwiUyXS/Xp10a8hhfaD0r1+P8Rq/o
 Cl/dRGHUystuac5xkv0hTM1cmnWzFhLZeXADeKAt0wqkVB9ugtOksyYlO1VPKUXuPsWQ
 8oTiOzyZqiGbLqpjRetNj9KnuVuQa+ttxK7NvyRgQ0YWKn7OSqoqkg2LZw6+hp64GIBZ
 p+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758732937; x=1759337737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7HeAQ0k/uS0aLDgZgNH2yordxNv1Wpz7G3JDMyHH4M=;
 b=iFJVNOjgC5aJ6JadGPVdblbvKEQQuPVFaIbl9SIk7J7p6awNFs5EQ4KGCKsDCXtdXx
 FYVEXHkI8kL+5PgHk2FyP/kUryN3XarurN9LUEjYtQdP6nPqpfjSY/jZyfG75Y6k8rWT
 /kvJw356BGs79T6Fciym/7igMHrNa8B8tK4PmOH6vvn7xcgZlwqKBIvXhJ2rNZVLOAw1
 r9+3pp9LmgNVnQdeFJWYnqgbvtdf3xsyagyAwsLiZLRLt0lX1LV1RFYy9x3YNQxzUsKC
 gpuNZ8tf87q6JIwXVgTKiUIr+20qr4hiBRcJGEBBjsFqffQrQyhh5ciWmLQix6d9Ce2U
 Qnjw==
X-Gm-Message-State: AOJu0YzK5667n3oW7ZJ346sRc1MflBn8I8TWUs8kMgbXnTnwRcwa3SkJ
 pfAJH2vSf1iEqcZx7WLXc+OxKh6hde8LX0aFgf95dh/mj1OFL0Sc8NiMwEcD0h7FrLiq+FvHk+S
 NqpEw
X-Gm-Gg: ASbGncu60uv38+pA/JGQJ7ob2tK0GJBoZ2y95jhgj4ot7y6QZre2W1wII61A3wE7o0o
 UqYiGaGkoPdsSpmcu4Z5fKpJtWBgmEyj+R8H3uLnQjOZYJwp3Snz7/U2i/z0S6btRKPApmJ6f4N
 8zD92X0qCVmtjSwTpsRfdvCSbg1hW8wnyvHnySmI2+/0VMDopQw/Sko2EXBCF6z72C6oUy+iCg5
 15iiL136/PkOExfbLlm2b4fGHVrI4PpkGDV40Eq5NHNmjrvAakU3Is9I1QB/Mq2PKa9T9wIA9bT
 0x4nc1CsT7n+OwILH3YBlRy+r647WnErr0pziY7uCktvukrkI1cN5fXf+KG1nGP2Tq7Br7TVcXP
 TsXHIeByzWNgudhZ0aFnQ19f0o+htbXM+cJqWMukfKPjMT47w2egTRJOah/pEdGsWne/bvaTP
X-Google-Smtp-Source: AGHT+IEg3BuCQeUXXvSNID2bu2dgOcqrz5oxQ6cUpnZpsrVz6fgvukcD3V0RxOxptMvoTzxv3x9uTQ==
X-Received: by 2002:ac8:57c9:0:b0:4b5:eb27:c241 with SMTP id
 d75a77b69052e-4da47c058eamr6903031cf.3.1758732936785; 
 Wed, 24 Sep 2025 09:55:36 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda15f91a0sm106052751cf.1.2025.09.24.09.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:55:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [RFC 5/6] intel/ipn3ke: avoid use of pthread_cancel
Date: Wed, 24 Sep 2025 09:51:12 -0700
Message-ID: <20250924165527.268645-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924165527.268645-1-stephen@networkplumber.org>
References: <20250924165527.268645-1-stephen@networkplumber.org>
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

Can use the existing reference count (scan_num) to control
the thread without using pthread_cancel.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/ipn3ke/ipn3ke_representor.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ipn3ke/ipn3ke_representor.c b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
index feb57420c3..4e831c6924 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_representor.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_representor.c
@@ -26,7 +26,7 @@
 #include "ipn3ke_logs.h"
 #include "ipn3ke_ethdev.h"
 
-static int ipn3ke_rpst_scan_num;
+static volatile int ipn3ke_rpst_scan_num;
 static rte_thread_t ipn3ke_rpst_scan_thread;
 
 /** Double linked list of representor port. */
@@ -2578,7 +2578,7 @@ ipn3ke_rpst_scan_handle_request(__rte_unused void *param)
 #define MS 1000
 #define SCAN_NUM 32
 
-	for (;;) {
+	while (ipn3ke_rpst_scan_num > 0) {
 		num = 0;
 		TAILQ_FOREACH(rpst, &ipn3ke_rpst_list, next) {
 			if (rpst->i40e_pf_eth &&
@@ -2612,10 +2612,6 @@ ipn3ke_rpst_scan_check(void)
 			return -1;
 		}
 	} else if (ipn3ke_rpst_scan_num == 0) {
-		ret = pthread_cancel((pthread_t)ipn3ke_rpst_scan_thread.opaque_id);
-		if (ret)
-			IPN3KE_AFU_PMD_ERR("Can't cancel the thread");
-
 		ret = rte_thread_join(ipn3ke_rpst_scan_thread, NULL);
 		if (ret)
 			IPN3KE_AFU_PMD_ERR("Can't join the thread");
-- 
2.47.3

