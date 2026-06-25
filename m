Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49761CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D0B140DDB;
	Thu, 25 Jun 2026 18:02:10 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 3BC8A40685
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:02:08 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-13986d61b4eso129863c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782403327;
 x=1783008127; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZIWio0g7WMfdlvq7gyOJe/gw3uf6N549Z/CPUTels0=;
 b=f9fdyKUlaGJtRrqL0l9odVB+7S9rT15b5RfysgBqAcvTKzV0PS2I4sPuSJkMhx1Ysj
 B0jjcx7cKbF3brl4uj7Qq/9+ZHdwSlaOemt7dbRMZioucBdujJDcAXD0iCaOAj+o4xzb
 39+mFMS3k+aLdnLb3G0CkmqtYV2iPP/kjd6JgcS5ptnrFFnJqUFGX/vouGMedtTN1MzU
 bHAlut22UcmDKTOVh4QFHWhWWs8R9GZz2bsGVGwcc9MnpPGCS16RtVXaTEMFfXxbqauC
 vhCzy1I6EJxrZ8VPERmBEnpNnSWxSPM/flqIuF+deI0S/xuec6B65sGAO75AfPwAt9iZ
 8dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403327; x=1783008127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZIWio0g7WMfdlvq7gyOJe/gw3uf6N549Z/CPUTels0=;
 b=g/Jx1+6lSbWN4ciSFtNvAcIT+/TCV4S3sNc5T4FTZ9QXZki4cXPT9+TWsS/AqQQdLJ
 ce+nHokxHQXeLwfg1iSTj9nqlmnjmDE1T3ijMzIgKtm9mX0D9wq25oG43MtyPxq5VWZq
 m+LnWp9q1bs2gtQjV1kM67maJQoSnPbR7UmMa1vKf0mWNVmCBLFsvrfB6YZNMogmJal+
 R8grNXWkZA+cj3LCRxnKWc9T4J2EQ3GmED+pIQ5EOc8+yb6dGFlDKjyvPbQRgtAqlh8c
 xHVmPJXjJFcKSzYFuxu9bGyF3EzNgGoZ/kx4cQ+3QGuJJ4IgpMIbIUgBq/eGhjO1rZcj
 BcNg==
X-Gm-Message-State: AOJu0YzYpnlleMbskx4uZhqCMVvsZ2DeCiF5joK9LcuZY5ZNsQSUy/qz
 g+lXlMz9+gQ8f/GaKdhe00X/NNpKh1qXJWR+Bi7h+Z7P9OHB6QZOIX00e/re14d2mPNKaVvE1Z3
 pdCK6
X-Gm-Gg: AfdE7ckvpFeks1+1MrlxuFqa7RYHGy5EFDwEjjhn3mjQ7cGrgVVS4lnVLTepr3egiwM
 To6r9ngBRk3vUwA+hSK+XmrxtXcZG/iOgj2B9QvWY3NRLP6qvp+9KdpaXWi5T56kb2t9qjQacuU
 9dNjbXy41UAbSsXBhYCiIg+ZHR9zSqKwqC8N99Vblns/agMux3xqHpHOZPFJvfGZb730p4HnrFp
 vEXlmLNLnoru1qNyOKQ2qq0+awBRD6OEzbDbNK42Vpx9c2nG4RCP9vvG4IB9uCblglcLdQZrLWR
 Toilit7xqSKf04KnvQMzrWCF9J5+m84AoMz0MD6z1XZRipC4/sL6g2SBOA7OTAd/0gLf87j1Ef+
 KvupqyBEGhk+q9UZ+jKhPk2XsBbIBUDZtBxuu1F19fjftSsvwRiB/kwHC9tPf8cHSv1VT4wWzJZ
 HnvDhRRHgx2hNn+vn+aOH9uDyWRbirRWvupJp2iFIWX7/uI7JZkDg=
X-Received: by 2002:a05:7022:ff47:b0:138:5ae:3eaa with SMTP id
 a92af1059eb24-139dbac0173mr2968254c88.9.1782403327007; 
 Thu, 25 Jun 2026 09:02:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm9121569c88.9.2026.06.25.09.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:02:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Siraj Luthfi Ananda <sirajluthfi@gmail.com>
Subject: [PATCH 3/5] crypto/ccp: use timing-safe digest comparison
Date: Thu, 25 Jun 2026 08:56:36 -0700
Message-ID: <20260625160200.24170-4-stephen@networkplumber.org>
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

