Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223DF10F995A
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 16:19:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A76F40654;
	Wed,  8 Apr 2026 18:19:54 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id 4E8D74013F
 for <dev@dpdk.org>; Wed,  8 Apr 2026 18:19:53 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso6408207eec.1
 for <dev@dpdk.org>; Wed, 08 Apr 2026 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775665192;
 x=1776269992; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeHR90fv606RDHOY/snQJnZMVJX1xDCiZWmck6OW9Ao=;
 b=bQZa6DG6X9B+gnNdJpvQE+tIipcjj1I1R3C1WYsOreso1vIhgmSCl4xxSojuHsNOdu
 YFYc9ZvH5q1WtXYnbMy4qIrGzwHDXKp0UXVu4J6a23qjZWg/a/W6BOirNfNh9lGH+7sG
 K/Vzj4lRhkImcectYTIA9T1sScj6xv6Rs3Brenw0B0Y1OI3eSvCopbIIC6wDtDiva445
 2obYFP/Nvrx5ke0QT57V7UajQGcdgZqqwl3vmQ48vPGegqAHRdmJHycoPad823Oaj1kk
 7fOIMsIBc1i0YvmuKCrAqgkuwrKKH/L65W2ThUv2ok4wNIz37PKPwkCzLIT75cPlr9s9
 kAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665192; x=1776269992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeHR90fv606RDHOY/snQJnZMVJX1xDCiZWmck6OW9Ao=;
 b=dB4gpFwZtR+kW2MJ1o+C85XVXOI9L0IAMETnfI+R+k9nCiyG6QuksSYdj18KmYv+E7
 U9bBKC9kmbTvEhv6t8PCnt+42nD3hBibB0370ox4ADQO8x4FYTTpY7lUejViqiFALz2o
 Mw5t0l5YqvQXh1FZTlXBlLRsqzaYqRUGWIcFcOEzbNGVL/91KUOA8Cjin5+IJWX/LtMC
 d39pqOeXZhBtDY9fSlE1W2pEa6iCz6TA4eIOVDsoVeO5yEk/0y/IN1GXNY9mgRNojvhB
 pbboZ6Hmqr+YsODQ7kZg4sRPZk9BFC9Oha1PcWai8YOzjN4Bl7HwQSz8YdPjTqr89Ygu
 M2Bw==
X-Gm-Message-State: AOJu0YwbnS7dgGzIj2kISVrbRbg9kJ9GT8woENRJPioAfU3W4l1weExH
 mLm4Msu+y6kFoBAltkEfAEm3d61fzm1vE7jS8A44bO+rkxC6VmsNaziYiwZkuAVP2d0v5vEwJeo
 09uEh
X-Gm-Gg: AeBDievMR63qOp4TFb69NfQ1xo1cmpDfe5lmANSdKcMLMUAFj5bwpCpxvnmqEjfBHmG
 C5OijrXj9bYB5G5JP5b2FyK7ZOo2DFL28Wshc05kSHF3KszTwpK7htEEDXAiv7WauDUJBNG3BjS
 EvIPwe/6w5O7QjQPbqcerbxtCD8vwEYHXQ4K2XmGW05n2joH95vUgW6dE4lnbpCBCMi7j8xdVyA
 LU31tqFt/j4mJvCP9cO5INAfmegkDbrogadQRy/PCbIulkWpwR1bd+q0O40TEViy3FHJKI8cmEE
 z0fd5OiOb2fO/jSo8CfraM7SRXNzAsiXEMPKWQSfZ16CSq7b3OrUGVbQEWdLLMyEc6YgymFw4if
 MlKW4+5P03VB9r34SIHmrVowJmvUQRngGvizbz9/6r7PT3HcMpv55Q0pZzuXwkqSppOSdbQfol0
 Nbn9wrPoSYAduy58Lc3Z7k+HYuAMleOAUi
X-Received: by 2002:a05:7300:a40e:b0:2c8:fe46:eeb6 with SMTP id
 5a478bee46e88-2d40e0f61ccmr76537eec.16.1775665192310; 
 Wed, 08 Apr 2026 09:19:52 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df5ed3sm21080062eec.6.2026.04.08.09.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:19:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Allain Legacy <allain.legacy@windriver.com>
Subject: [PATCH 1/2] ip_frag: fix unsafe TAILQ usage
Date: Wed,  8 Apr 2026 09:16:16 -0700
Message-ID: <20260408161947.285185-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408161947.285185-1-stephen@networkplumber.org>
References: <20260408161947.285185-1-stephen@networkplumber.org>
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

The frag table next pointer was being access after TAILQ_REMOVE().
This is not safe since it depends on TAILQ_REMOVE() not changing
next pointer. Fix by using RTE_TAILQ_FOREACH_SAFE().

Fixes: 95908f52393d ("ip_frag: free mbufs on reassembly table destroy")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ip_frag/ip_frag_common.h     |  1 +
 lib/ip_frag/rte_ip_frag_common.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/ip_frag/ip_frag_common.h b/lib/ip_frag/ip_frag_common.h
index 51fc9d47fb..34be5bb6ab 100644
--- a/lib/ip_frag/ip_frag_common.h
+++ b/lib/ip_frag/ip_frag_common.h
@@ -8,6 +8,7 @@
 #include <sys/queue.h>
 
 #include <rte_common.h>
+#include <rte_tailq.h>
 
 #if defined(RTE_ARCH_ARM64)
 #include <rte_cmp_arm64.h>
diff --git a/lib/ip_frag/rte_ip_frag_common.c b/lib/ip_frag/rte_ip_frag_common.c
index ee9aa93027..79ac45289b 100644
--- a/lib/ip_frag/rte_ip_frag_common.c
+++ b/lib/ip_frag/rte_ip_frag_common.c
@@ -135,18 +135,18 @@ rte_ip_frag_table_del_expired_entries(struct rte_ip_frag_tbl *tbl,
 	struct rte_ip_frag_death_row *dr, uint64_t tms)
 {
 	uint64_t max_cycles;
-	struct ip_frag_pkt *fp;
+	struct ip_frag_pkt *fp, *tmp;
 
 	max_cycles = tbl->max_cycles;
 
-	TAILQ_FOREACH(fp, &tbl->lru, lru)
-		if (max_cycles + fp->start < tms) {
-			/* check that death row has enough space */
-			if (RTE_IP_FRAG_DEATH_ROW_MBUF_LEN - dr->cnt >=
-					fp->last_idx)
-				ip_frag_tbl_del(tbl, dr, fp);
-			else
-				return;
-		} else
+	RTE_TAILQ_FOREACH_SAFE(fp, &tbl->lru, lru, tmp) {
+		if (max_cycles + fp->start >= tms)
+			return;
+
+		/* check that death row has enough space */
+		if (RTE_IP_FRAG_DEATH_ROW_MBUF_LEN - dr->cnt < fp->last_idx)
 			return;
+
+		ip_frag_tbl_del(tbl, dr, fp);
+	}
 }
-- 
2.53.0

