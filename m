Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4784CDE001
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 16:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F310E40DDE;
	Thu, 25 Jun 2026 18:02:14 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id 6F6C740E16
 for <dev@dpdk.org>; Thu, 25 Jun 2026 18:02:12 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-139986373b8so61486c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782403331;
 x=1783008131; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncMm1P+t1GsWMHE4LVGcIqu3SJrxuq1oKCpWfIGD3Cs=;
 b=hWw/v2LvsLWIpIBZrhdYMsi+EVvKaNJio6JmAeivwSV183OX4Ahj1nTYsTBGKIFeI2
 Sts6JtANPy3EY1GegeyM/Ln+7yeyOZMmw4MeawxfyyWzolxqFBCsXkt8Akn0TP641n7W
 CAd8QmJLpl+rJs9RLD9iP/gpIIC8I96w3vOFZFunTXsEG8GKpgfdwFCN1XCaslaip89R
 nQ8gsUfVDPxN9gTBLlJZmSo1FqrT84Ty+ErJRKSq0ZuxiasiC6gX7YzuurOmP1PyeEaT
 +PDtBxFXOvpjau4CnNOEuYGChqoivn+PYQz9JIN9NBqqgCKKCAIKFCYxlpaRSx1Om+YB
 d69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403331; x=1783008131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ncMm1P+t1GsWMHE4LVGcIqu3SJrxuq1oKCpWfIGD3Cs=;
 b=mowZVQxxByRPRKIuaUWrm2uv7lfliX7EBMaQo9WxxKwxaij8PQoDnm+mM3kRpyLZ8E
 8f0fZQAoR+v7Qxi5KjfoS2+UcPlLvo7Syi+QtGzxDnaNHAlTgj6Ixrd2raRRYWo+V1lq
 DVk/SLtLXbHtyYKNvs0+DQ8NNd4vnAFmJTO4x60TfHef719ira8NPpR3lVV2qJj1f4CF
 xXT2AVuTTIeOsWGd2HkRXpumAohgIb71CeQC1fn8OsFMWXjtwTw5mSiU76B6PO+Ctm+O
 8NxQlsOrh6jG4jOe5IyweSVI3ALnbazv5c9gp9Sd9adwFxJLrVlBM2S+gH12devcNeit
 6Q8g==
X-Gm-Message-State: AOJu0YyZcOU/bs/Qt0DbZIHkSNi0DAiGlY3fROL6PuFyhKnPnvL0wBbo
 b/sTH/clDOh1QD3iQ1rLDVoxT9aptTdCzPWH/3E9b3IEcyRrB6HupVmV3nUNk0Irxdi2Bg5DFV6
 l0/iY
X-Gm-Gg: AfdE7cllq/keyACtlOVdryl3EqEESMQRzhE9uj6K3nJMFBrj07PPIJPCSCttDOJVRN4
 eYdxVS7ROp0h3O7s5yqTKaFKNp3aQMLtzIK+T8jUeM3QbGLHDMyaEMP1rMy/6AL0/Zbo+4zjjz3
 e7mvt6jw3bruYr2+oiVwcOsGHa/j5EiUhpQagw5okKxlk9MohZCYFExpXns/Hthueq1rthZ/NE5
 eus+P8uuxgcIcAYI0ArWeRae5nj0GQy5DL+1IdxP2nDQWhw+2f7jI6SvRx1Uq7A/BF6pDZC5mmn
 7JA3sqMjIFYbSFz5vl5OsEsVR8FVQOra29cpt3CDC3LO3AyLIoikwkBYkxK/2YcRMFKNpqCcN6S
 yMhmCOU7sTwz9USgRzHre42lfnPI/y8fllANq+UzZVGHRzIuGXQpgEpxgFpH2XybAiaho/daJtx
 cJrpWShnmQWfowvL+mA0VMOF8NbTq4+8rGVd5qlFHcwH/O5QfuNa8=
X-Received: by 2002:a05:7022:fd07:b0:139:ba7d:84a2 with SMTP id
 a92af1059eb24-139dbb8ff27mr2894172c88.21.1782403331300; 
 Thu, 25 Jun 2026 09:02:11 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm9121569c88.9.2026.06.25.09.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 09:02:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [PATCH 5/5] crypto/cnxk: use timing-safe digest comparison
Date: Thu, 25 Jun 2026 08:56:38 -0700
Message-ID: <20260625160200.24170-6-stephen@networkplumber.org>
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

compl_auth_verify() compared the generated and received MAC with
memcmp(), which returns early on the first differing byte and leaks
the number of matching leading bytes through timing.

Use rte_memeq_timingsafe() for the verify comparison.

Bugzilla ID: 1773
Fixes: 786963fdcf3e ("crypto/cnxk: add digest support")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/cnxk/cnxk_se.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 8dbf3e73c7..d2306a9daf 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -3282,7 +3282,7 @@ compl_auth_verify(struct rte_crypto_op *op, uint8_t *gen_mac, uint64_t mac_len)
 		return;
 	}
 
-	if (memcmp(mac, gen_mac, mac_len))
+	if (!rte_memeq_timingsafe(mac, gen_mac, mac_len))
 		op->status = RTE_CRYPTO_OP_STATUS_AUTH_FAILED;
 	else
 		op->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
-- 
2.53.0

