Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9732C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:00:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 319BC40666;
	Mon, 29 Jun 2026 21:00:39 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id AED0540650
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:36 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-80dd4766206so12358127b3.3
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759636;
 x=1783364436; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZIWio0g7WMfdlvq7gyOJe/gw3uf6N549Z/CPUTels0=;
 b=Isqpfd+8ydAfvHDcghBsTOeAyegAgTBvtgWtjDFUEPUSJW9T9r5+jjGWkBUU417R5n
 uqZDMzMf1f23BXyOrWFRLHFKxB7bPXAgCPQEcZ6yvlqOEzwXhxcoPyz8xq0zlHN5Hjkd
 deMpdNEkgwxztLqKU4j78W5xUzA3o1YcYTiFyMa41XV5+zzxQ+fAUOVLKL6/ZZYLQVpM
 QCmClGJ5fuYpR/owsD2HtdapEBSwXsUcj02wkKEET+ciHPbQyy4VyEyz0uGQIlzaKNaZ
 s2sBW3iRZlMUQFW/VH5pQvF9889V6kx2UJdUCLeWi2JRPbI2obXRk2+s6oxattmUMDQc
 8MuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759636; x=1783364436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZIWio0g7WMfdlvq7gyOJe/gw3uf6N549Z/CPUTels0=;
 b=LAL7XJIut8hl8Yw5JRs4KkHqCpM/zW1KUwZFUwzycG5ZVTX7lkbIJgeBsbcrm3s9uY
 xXvE9uTLxS+uIR9fOJoMWN5AmrXJLjAqLQJRVYuqC0UrbsduIYFt7LKVG+tubm5fJnD7
 xr5CsCnGrt7UZDK8az2OGnLRoEQqOMqZ3o9UBygsMpQ1H60loT5NQx7u34InNzZ8bLU8
 W4xgrH6lbc3/ocLcMC2Vc56qFniCkIJUmPTE0YA1wS3EnPxoemE86grghBUv+L4pPaf9
 wzfe5Cucvq4/dqrapD8XwLHhL/HKDrzQgXTOKBpHQqzxOBlF82kqohc6M1X0aYzNZdOd
 Kgiw==
X-Gm-Message-State: AOJu0YwRXGa6UOZB+W2p4oTUnQ/QTYVon/ZETPxVJRWqvYlz8kQ3GRJ/
 5BD0nOsU7n1lIy30wpjK485oR4FsxqDgVz6SIU0aYvQ8R1lpTlYTV2eI8CKWKK6eAroU3MMVqfL
 OxA6G
X-Gm-Gg: AfdE7cnyKdbFg+bT4we2490DCV+Mq7O3E55ABDTIJusm/MLUFLlEHDyfT3We9B83reJ
 M6s8u2uCX1MGQnihZj0ILhkUo19ahrSHO/M4+hLLj54GWCIqozqD0ByPtzlKpw44944XKiUB3QR
 no7HhrpaSWozIgM7vkrZ0+dXZ+6vfwxcBZLUceFOu+/gA/E11JPAmTMy69pelb6AhybM5pj/Vc3
 oz0gE/BujdYX/VAgjjy+Cl1SOZj56KKksgvdBXFuWB7TPbONvTQGfH+vJpjZ+JmWSmJqHBBL9if
 MMZuKleX1yXXMeGMRriN8FndiNkt1hzFGs0LcEaNLl4inER1b7Bx2cl2ArGaS9OPB2/eO09EXUH
 Ogh6L4/iDEejT5nrGoOf1ZY8hjsQY7ED0hQv+k6gcxXNEivumv4HsoEjQ4Qas0FWtPwRhwkXeUf
 UT6q5/zPUXo6ER2Qk2wipIDyLxmCnbyqwozuC2eOMHeJ67Pu8xUmQ=
X-Received: by 2002:a05:690c:3383:b0:806:b6ab:a410 with SMTP id
 00721157ae682-810d4d79da3mr9263947b3.0.1782759635424; 
 Mon, 29 Jun 2026 12:00:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>,
 Ravi Kumar <ravi1.kumar@amd.com>
Subject: [PATCH v2 3/6] crypto/ccp: use timing-safe digest comparison
Date: Mon, 29 Jun 2026 11:59:26 -0700
Message-ID: <20260629190027.2071745-4-stephen@networkplumber.org>
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

Both the CPU HMAC verify path and the offload digest verify path
compared the computed and expected MAC with memcmp(), which short
circuits on the first mismatching byte and leaks the number of
matching leading bytes through timing.

Use rte_memeq_timingsafe() for both verify comparisons.

Bugzilla ID: 1773
Fixes: 6c561b03b54c ("crypto/ccp: support CPU based MD5 and SHA2 family")
Fixes: 70f0f8a8d78c ("crypto/ccp: support burst enqueue/dequeue")
Cc: stable@dpdk.org

Reported-by: Siraj Luthfi Ananda <sirajluthfi@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/ccp/ccp_crypto.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index 5899d83bae..b07a786d8e 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -1490,8 +1490,8 @@ static int cpu_crypto_auth(struct ccp_qp *qp,
 	}
 
 	if (sess->auth.op == CCP_AUTH_OP_VERIFY) {
-		if (memcmp(dst, op->sym->auth.digest.data,
-			   sess->auth.digest_length) != 0) {
+		if (!rte_memeq_timingsafe(dst, op->sym->auth.digest.data,
+					  sess->auth.digest_length)) {
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 		} else {
 			op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
@@ -2801,8 +2801,8 @@ static inline void ccp_auth_dq_prepare(struct rte_crypto_op *op)
 
 	op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
 	if (session->auth.op == CCP_AUTH_OP_VERIFY) {
-		if (memcmp(addr + offset, digest_data,
-			   session->auth.digest_length) != 0)
+		if (!rte_memeq_timingsafe(addr + offset, digest_data,
+					  session->auth.digest_length))
 			op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 
 	} else {
-- 
2.53.0

