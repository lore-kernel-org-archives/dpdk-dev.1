Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07EC44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:54:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA6D840DD1;
	Thu, 22 Jan 2026 01:54:18 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 9FB20406BC
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:54:16 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso4085195e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043256;
 x=1769648056; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ct14Ku3GGBEC2E3nsJNRPwL2SMBcoV9lXgkqzA0SEUQ=;
 b=We77L7urRmSutBtWcouHZttoCikHB9u/WjM7JU9IVuLeNI70HAmOjD8G32S3INXacW
 t5H0hZ9Tcr+TLnjhzWaunguHA4e9mHuuadk77BPD2mc622Gi9vZsVeJXseGqYfAF65f6
 f0faY+d1z0y4Z35Qv0VrbkEMp4p49PdN7JamiViv9qS/J/xwJVrKwtC5up3xuEgxXv32
 dLX8aDhArHDbcFVtGUx/bbbnvg3zpfCfKIgH0zZgYsxpxonsE5COtdCZgMO8bP6UjJjB
 SP/uJvk1KeUQknRyf0ZVEZWy81yFr1TLEQWUKX3/eQsB+C12vaJ1bDWzzTXJ7poUEHOI
 9ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043256; x=1769648056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ct14Ku3GGBEC2E3nsJNRPwL2SMBcoV9lXgkqzA0SEUQ=;
 b=s+Q4AESx3g7rRaIsHU1dUycuvoow9M0WqT1zJGo6+udvGf28atLmFfT54juR27GqlZ
 9RVT7GroE6gerehb8NqKCB/An5/emb4zcHIKZb0iBFHIIFz9Tyup/depmb5nAKMP6ZQQ
 3Z5UMkIQCu3nLxTi9qsltB/DqrAtmyQX16Z3ZJ1k67NWCzf1gnyzdpt7fmglRJct+MGP
 jO1fp2mN43URVbERnbW9/lrU+NwMKgzTwdfiLVkRUyOPlr/GMZjAKGqwBlAgo+aGONyd
 F6ObcDmjdQNnCilXwBGhCHagDUkFtN1S1bGivs6sI9xbE8c3yv3uvhoPqhcKAq9+pHXD
 6/2Q==
X-Gm-Message-State: AOJu0YxJ+y60F+CZxoyqoNV/v8yrjOmvaHMOqlo01WY9EOpPrSHoNEpB
 9OHDclOXxpej16Asjqj/XV9Vku7ZLCz7idJ273cnG/CvyjornRsVPIoN1zFq74gjWSKG9ZqQswI
 oMOEG
X-Gm-Gg: AZuq6aK0fEnWS5h62qdHFMBEHJ2ANj0f7S3VWsupfxtqOKKfb2NJLBBBbLXiycbXsoz
 iv1BkoUTF+96w0O+uoujBpTdhpKgwCx1ZAKBi/ynbIZUVlKIiJhuu8mKH2rwVPmn62h8hnCXhZU
 ICfCFCHPwz16+3ecLkxvk/EHzLv8quTRKDnr0UgWHFvx9r3wnUO267Cj6SWyVV5kzJYB5DCj3jL
 2L1bvWVVNAKBv/SM9chKOXWiQX4HWjLtSnSwSXY4By0zAiN+MXKFUPamYZ6nK28SYSx3Mgn8MFl
 wnbABOPk7lxSefZJhng97mDpJFc8YR4hl3YpYovxrnQ0QsKvlL8VtamndKtgEq2zOSK+iZg0jGU
 lKacyqlADbXE16oZUWendzWahgz7zT4/hsCrsw3vlaqD0OHf/izmxfzyI0mxepfwmL/STHPc145
 2ZX1eoYk5kNitHOhktxUomSpHyOJsckRUdjuh7MV9tlSM9r7Wtrg==
X-Received: by 2002:a05:600c:8b75:b0:477:9574:d641 with SMTP id
 5b1f17b1804b1-4803e7e8531mr99668775e9.22.1769043256191; 
 Wed, 21 Jan 2026 16:54:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e6dasm41695104f8f.32.2026.01.21.16.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:54:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 06/14] test/bpf: fix error handling in ELF load tests
Date: Wed, 21 Jan 2026 16:50:22 -0800
Message-ID: <20260122005356.1168221-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122005356.1168221-1-stephen@networkplumber.org>
References: <20260118201223.323024-1-stephen@networkplumber.org>
 <20260122005356.1168221-1-stephen@networkplumber.org>
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

Address related issues found during review
- Add missing TEST_ASSERT for mempool creation in test_bpf_elf_tx_load
- Initialize port variable in test_bpf_elf_rx_load to avoid undefined
  behavior in cleanup path if null_vdev_setup fails early

Fixes: cf1e03f881af ("test/bpf: add ELF loading")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index a7d56f8d86..0e969f9f13 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3580,6 +3580,7 @@ test_bpf_elf_tx_load(void)
 	mb_pool = rte_pktmbuf_pool_create("bpf_tx_test_pool", BPF_TEST_POOLSIZE,
 					  0, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
 					  SOCKET_ID_ANY);
+	TEST_ASSERT(mb_pool != NULL, "failed to create mempool");
 
 	ret = null_vdev_setup(null_dev, &port, mb_pool);
 	if (ret != 0)
@@ -3664,7 +3665,7 @@ test_bpf_elf_rx_load(void)
 	static const char null_dev[] = "net_null_bpf0";
 	struct rte_mempool *pool = NULL;
 	char *tmpfile = NULL;
-	uint16_t port;
+	uint16_t port = UINT16_MAX;
 	int ret;
 
 	printf("%s start\n", __func__);
-- 
2.51.0

