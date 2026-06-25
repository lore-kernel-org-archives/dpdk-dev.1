Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC47BCDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A89640C35;
	Thu, 25 Jun 2026 18:02:09 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 5F74940685
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:02:07 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1397e093f90so77685c88.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782403326;
 x=1783008126; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXkMeUmmpUUNsIOyIJh6Io/zleJ92eRwzCXK/HH7OEY=;
 b=e/3vyRVoGbyjRrehcFVPZfG5MZObwK0/PrummuEYUfNdk8RxxM6rKVMhEz3fpOGFKo
 LEALPRmWq07PLP/XqleBc+d3D91o23jwee0CpZ6r86UJqvIxwI+zXVCexO2JBK4X3StF
 5u9RTb4IuggdyyDTuAeSCNR6jIF8LeThFUqr0erZx+Qs+8iFv6daL2BuPKEp62aB9LoL
 XfPyV6LRcXyw4UF/iGwCNrrMf+IGrAAjNYpXMj3PxJxUOUBGAOlQqL1G7g06qZWT4DT+
 7O1IgF5SQASFt1SRO9sRsWTNKS73Ns8zWAlGKANM8aLtozMkfC8ZEO9tZsrHldOmPo0G
 I7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403326; x=1783008126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXkMeUmmpUUNsIOyIJh6Io/zleJ92eRwzCXK/HH7OEY=;
 b=M/qds3DfXeEzG9Fnpv4XFV7turqemw4oDKbk7iQ+qTSHrLzqBhBwLTabVvuUkLSAUK
 aqT2iYlsktZEeFGdChjQwbNvNmsIzGatQBrUWRPCCjYmw0A9a2OWMu/D+NjyQJxelXJC
 0unoYhPjbaUAH05KZByfDrhtkncbCShup3d7sgBOoyq3E4pXJsmZBl0e6GwW6ysdP2cy
 2tlXfCv/iMkwev4vjM3JV9iROTYlo7WGcuLW+nL2Ewr2uRFA/IQUt20u/AbWIXDXVeiI
 LXL3vA6O3Wezbvfa8jEOwWy9BGpuzO0bvM8E3oLUgsTXEvdCmuryXEWqWfgRt+MtP4HO
 MdLA==
X-Gm-Message-State: AOJu0YxRRiyWkZ/9RRx8WKtzUSsGtHa6HWTAabsdL/rUSoWAsTkmEEHH
 KFApjLnB7Ldix0Feh0nzEBt0+ZpN8J9kKwEoB3X0AB30Yqv3Ycy9F45KVZ10/lV64mL67pX47Wl
 kKaAm
X-Gm-Gg: AfdE7clZWJ6v4JGfDaGkfG1ggcrkY+YKsrRr+BzOomPckiFLnH61wlYj2VfUis3MxQ0
 ieVOrlvzRFy6ziMt67U40d2heRcpNvvOUXpnI7zzuZsbS8BioCj9E9MK547e1v10QtQVl/7ly2Q
 OeSXaLi8nLlvHOum0Foaz6jORk7+D8NoFxG/2HPfRB/E0LUqYAhW08T3iRXTWL+oOYXyOAoi6pK
 yFId0ba2k0k0gqIu45VmobSVevXn66al9AonTICjyx9dwecn115teWzR5AfEJQ24Ou+UMsPSGt2
 rDyXrKbbkVIlJiDgJFemBKKlK2chNM80avdJhUDMQkL4MfsC4H/lccBpFwBIG2Iawt8/jEfH8L9
 aszLyi/+tgl/TY2Na0KY4K27RqgpT7CE7y8jR6BHUDTcndOK8PSThm1IvloemmO2oLA/Z0JbhJS
 XX8Wjtkw4iPHlSRlIzSGyLL09TFTfrg87D+Y/4/o/AVuyu9aXeYBg=
X-Received: by 2002:a05:7022:fa4:b0:138:22f:9a42 with SMTP id
 a92af1059eb24-139dba1da6dmr3799589c88.9.1782403325977; 
 Thu, 25 Jun 2026 09:02:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm9121569c88.9.2026.06.25.09.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:02:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>
Subject: [PATCH 2/5] crypto/uadk: use timing-safe digest comparison
Date: Thu, 25 Jun 2026 08:56:35 -0700
Message-ID: <20260625160200.24170-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625160200.24170-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
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

Digest verification used memcmp() to compare the computed and
expected MAC. memcmp() returns as soon as the first differing byte
is found, so its run time depends on how many leading bytes match.
An attacker submitting forged digests can use that timing signal to
recover the correct value one byte at a time.

Use rte_memeq_timingsafe(), whose run time depends only on the
length, for the verify comparison.

Bugzilla ID: 1773
Fixes: aba5b230ca04 ("crypto/uadk: use async mode")
Cc: stable@dpdk.org

Reported-by: Siraj Luthfi Ananda <sirajluthfi@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/uadk/uadk_crypto_pmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/uadk/uadk_crypto_pmd.c b/drivers/crypto/uadk/uadk_crypto_pmd.c
index 3c4e83e56f..221ad546da 100644
--- a/drivers/crypto/uadk/uadk_crypto_pmd.c
+++ b/drivers/crypto/uadk/uadk_crypto_pmd.c
@@ -1111,8 +1111,8 @@ uadk_crypto_dequeue_burst(void *queue_pair, struct rte_crypto_op **ops,
 		if (sess->auth.operation == RTE_CRYPTO_AUTH_OP_VERIFY) {
 			uint8_t *dst = qp->temp_digest[i % BURST_MAX];
 
-			if (memcmp(dst, op->sym->auth.digest.data,
-				   sess->auth.digest_length) != 0)
+			if (!rte_memeq_timingsafe(dst, op->sym->auth.digest.data,
+						  sess->auth.digest_length))
 				op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 		}
 
-- 
2.53.0

