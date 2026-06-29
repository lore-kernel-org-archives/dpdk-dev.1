Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59ABC43602
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DBA540650;
	Mon, 29 Jun 2026 21:00:37 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3988B402D7
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:34 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-80bd5b5b3afso30901777b3.3
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759633;
 x=1783364433; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXkMeUmmpUUNsIOyIJh6Io/zleJ92eRwzCXK/HH7OEY=;
 b=juRra91t5ymyZuXUy8pDUsZ5XkQ2tMuDrS9jjY/ZyIUYrzB2w1rIgRzrokxDZ+7jmZ
 RGChrVqw8Dn2oIC3uBXuTMbL7qNg85VUOeT09iBW0vZgi5vwLZN2pIM3KXy5TVUHNSfx
 pueaq2knrWdWONwxBYqPn+2mQ8q5/6AIB98V5GepjPEZrR18E27EGiRGl0glg+eACUjO
 B80+43ffbYyD6gH5txkid0JycSq76JSAIJymgRDwBAH6cr3PHM91CdKIlxyOlgusz+8D
 +VzgYq4yT7ulf5EmDLcDVjpB/McN6J+RUzSRaTJMBC5BnAJpCCFddOQjei/bh5K4y82Q
 V/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759633; x=1783364433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DXkMeUmmpUUNsIOyIJh6Io/zleJ92eRwzCXK/HH7OEY=;
 b=rsL2fkUGF0gKDFie5YVJ/HnU63hQacaTnx9lxUtZxWcA/H0eY9C71/OO0dao2Aiq9v
 gmSE/uzVpt5/FaOyrTomTphdD/OnOC8eayj5Wc049YTgt0nfGRoknLy2HH8s9kl1LMZj
 mO/GTedI70iSTUo4pYduU4LktMA+UBAwgl90I9Hmqh3KhV4OiirQXpXMSxVScg0IFumK
 yL6vrk5wjf8FimPstao+3gGWfgHJfP/K4Wr5dMjENySE1vhRxhoNeKYhr9bTzLsKHo0Q
 a0vGzE/upinvmcCq61+Y8iFtuRwc0F/EKvlepGcNkpdTu7I/os4W8AGDe1uVVyQiNcNq
 YWSA==
X-Gm-Message-State: AOJu0Yws4zp5sL/NNxCpI+9d+WEC15PVHpKJ5LJXzla1ULPfDdDPHhWs
 I+4EVvravk57cPjJ/oHcu2HqLUpD+IJGPmXjA7bgfKwhEP7I+RK7x6NDoKfYB3h0C7iOTW5WQZA
 gad0z
X-Gm-Gg: AfdE7cmJqwIMu2THPSoY2Zgnn5zLHzoBZBHHsjAan86rZpYzfXZYl/b7BmbmUU26USp
 SBhUbBvQYlif4LhLDXu0KnhGwhTmVDp9au76Rcjk3kJeo/OyQwInXMl0bktLXqdzX/G5aql1o2R
 mExpZK2ephysAarIrtG9VxwkU++WBbynNFKt31/NiRrxS8+1M6aWM8J+P2E3adRJNeYBsI+Tw9K
 lUDD2s9FVeu5SzrJgjWe1iMZlBC+jcsmaI/ljo3gZP3b9kqKU08IjMglwlbTzomBF+hhLGofiuJ
 6X1CV/iTGriQ3t/u+h0U4ZIOp6NAGg6STspwD3H/Qxze0caccyutjl/L+OdXxKbDX464ebLfAhS
 kwFH211Qdd2L4G5crhMkIE91yRi04Lk/CnLoz9FdQTmNCfNsaZtR6girK+wDwHCmERV943Ycw5R
 zPu/tpVTAP2kOyxZBVqiRYwKOWOtHkNRB/ZUQl4gQXlxWWjRGIclg=
X-Received: by 2002:a05:690c:c0f:b0:809:eba7:9f1a with SMTP id
 00721157ae682-810d85e1f41mr8725187b3.28.1782759633462; 
 Mon, 29 Jun 2026 12:00:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>,
 Zongyu Wu <wuzongyu1@huawei.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 2/6] crypto/uadk: use timing-safe digest comparison
Date: Mon, 29 Jun 2026 11:59:25 -0700
Message-ID: <20260629190027.2071745-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629190027.2071745-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
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

