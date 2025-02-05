Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C34C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:26:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC9640B8F;
	Wed,  5 Feb 2025 17:25:19 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8D22A4067E
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:12 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21f237fb0eeso11028645ad.2
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772712;
 x=1739377512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNkdoLj4B8mPp3n7IkOHdHg+h9cQ/8I0Zq91BGC8mVk=;
 b=WZzxBJKEhW22VglDKINziLlJiq1bYDc7QXjQtaYRdZeahC94tZxiqpObANR0FfUSBa
 As7YUZ4Gk2SZerZBy99KRNNwt8CXCLj8GedkEIVy2dbErCZp4eMcDJ0jf8AaGZYmuDee
 SVZm1/sCx8hpJos26TDh9J887EkSB2kI4sd2OHZ4PfrrlNjb+xCuFwiqkIBDIzgHkplK
 gX9vh4AG70vYC8zb91V1AJpZ0BPkCxqbtz9K3ZobkaDNV+iFRasCK34+qpGAGCjkSNRE
 RoqtFsQXZhVZgnMsseVRwwrbyeFvbF4KhNy5WbtBO4DCNoEAsoqqomdf9otD0X4UiF8i
 2n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772712; x=1739377512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNkdoLj4B8mPp3n7IkOHdHg+h9cQ/8I0Zq91BGC8mVk=;
 b=aFC2yFG3+uYxdhaQfbGbQ7iBXrG7xm9Wgsfe8AYRmd5HD6jKXgu747UpKTbNT/OWIt
 aM8KVxW/DY0N9g720ENlL2+9kSqoLb3hpltov6KXlY3RWHi5dWlR+1HVQIHOWtZKUFH+
 aSmiN6+PQGx9qcBCnN0LnWAokcyZJnLtYlq8DLGADV0VyRAGzgzSMg/djNLfLgaFZo+i
 yeb23PvK2YLbYBdGBtAQ09vPuwA+IDREGvNbwVLp5JsqRoaAdpQhBPdgmgt7rjayQoSt
 cWihzqktebnaStoidX8A9RUo3kFqcl99729EEEIvHVra5hQNo18mKB4EAE8GqWSI8tkU
 7J2g==
X-Gm-Message-State: AOJu0YxcQH0c6mX7D5DH5xkP5GtLBEnyVSayFiDoeG9Ecyq2eV9iTIl2
 KrAk+4yor9FFQ37CeNSCKUs1GovhpUyv8uUcspcJ7h+IVE1P4ty+Kt+YxLf6BgHn8bmxWTFxS+0
 e
X-Gm-Gg: ASbGnctZ7/z7YuhBJT57K9Ph4ug93n7/3YJ8tFi0MyQJtAwBe7vquAhLtt3p4qbxknD
 eMoJeVFtnZpLy+nLKPQVNhU+6IBKuyxvpW50/SnjwShEaRqxxvYXOVtKiEktdft7Od5PtBOKmNk
 GldDUZyrU0uWEWB212ysTDRs+cIGPmt8wz8WSGJRWrxuP+jLtuAPcpY90/l0EEk+1mIEeoIjlHR
 Ki8fKdpC6nmpqyWBnMVd7TVpd09trj9Yh67jjxbqzZkqzZU0eNVMUroTX8dkLAdLhvSsFWEmb/t
 pUDKUWpr4MbLhFYcstrOsNXixZnn06xD1zCufzRbur1Uwl0GgU4XIpZnfGVqhPWFraoL
X-Google-Smtp-Source: AGHT+IGDYpsen3a8910zqbxv0PaNbEoQoY/htRWCIkJFoV0dwWdfO5rvqGZOqI6umi33f9yVRg/K+g==
X-Received: by 2002:a17:902:d4d1:b0:216:3297:92a4 with SMTP id
 d9443c01a7336-21f17ed4b41mr62716275ad.46.1738772711735; 
 Wed, 05 Feb 2025 08:25:11 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, akhil.goyal@nxp.com,
 stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [PATCH v3 13/19] crypto/dpaa_sec: fix bitmask truncation
Date: Wed,  5 Feb 2025 08:23:14 -0800
Message-ID: <20250205162448.161161-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

The dqrr_held mask is 64 bit but updates were getting truncated
because 1 is of type int (32 bit) and the result shift of int is of
type int (32 bit); therefore any value >= 32 would get truncated.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/

Fixes: fe3688ba7950 ("crypto/dpaa_sec: support event crypto adapter")
Cc: akhil.goyal@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/crypto/dpaa_sec/dpaa_sec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index 3fa88ca968..e117cd77a6 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -1907,13 +1907,12 @@ dpaa_sec_enqueue_burst(void *qp, struct rte_crypto_op **ops,
 			op = *(ops++);
 			if (*dpaa_seqn(op->sym->m_src) != 0) {
 				index = *dpaa_seqn(op->sym->m_src) - 1;
-				if (DPAA_PER_LCORE_DQRR_HELD & (1 << index)) {
+				if (DPAA_PER_LCORE_DQRR_HELD & (UINT64_C(1) << index)) {
 					/* QM_EQCR_DCA_IDXMASK = 0x0f */
 					flags[loop] = ((index & 0x0f) << 8);
 					flags[loop] |= QMAN_ENQUEUE_FLAG_DCA;
 					DPAA_PER_LCORE_DQRR_SIZE--;
-					DPAA_PER_LCORE_DQRR_HELD &=
-								~(1 << index);
+					DPAA_PER_LCORE_DQRR_HELD &= ~(UINT64_C(1) << index);
 				}
 			}
 
@@ -3500,7 +3499,7 @@ dpaa_sec_process_atomic_event(void *event,
 	/* Save active dqrr entries */
 	index = ((uintptr_t)dqrr >> 6) & (16/*QM_DQRR_SIZE*/ - 1);
 	DPAA_PER_LCORE_DQRR_SIZE++;
-	DPAA_PER_LCORE_DQRR_HELD |= 1 << index;
+	DPAA_PER_LCORE_DQRR_HELD |= UINT64_C(1) << index;
 	DPAA_PER_LCORE_DQRR_MBUF(index) = ctx->op->sym->m_src;
 	ev->impl_opaque = index + 1;
 	*dpaa_seqn(ctx->op->sym->m_src) = (uint32_t)index + 1;
-- 
2.47.2

