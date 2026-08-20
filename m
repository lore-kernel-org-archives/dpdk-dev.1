Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C232C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 05:24:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40FDC40693;
	Thu, 20 Aug 2026 07:23:44 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id B6B7940A7D
 for <dev@dpdk.org>; Thu, 20 Aug 2026 07:23:42 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so1004793a12.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787203422;
 x=1787808222; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xUH9CsNCT2AYo/KL1wiCsOtz/uHuiRHqKrMuH1ZeNEg=;
 b=oIznqxw2i8s02TzHYvHCCCE6ceScDZEiaWvNLUKc98qAsEv7hPf8JfWVt2bP0j0Wqv
 noPVuKAKfwhECqWTVo0QxF3sw1Izcoocp7KD4r7oPauL6m0UFKhNBcP/a8xeAULL63gP
 ajupQ91dAwvRJM276fsJJ0cmoHEVEBL9CD7GT0Smo2IrhYgx7Fn/xjpk1Qt23xWQXNRl
 r76b7LFFj7mgWsnGpwfLshyVwY+NgQJpQgbOPteMZr+o4SfrS3nkOREjUnctcFTlSqD5
 wwNK41wSXnlUjjMDH2eORg6ou0LxsH0dUNHsTO+Ekoca/vHMLvytp+D0pmCubsxgSucR
 qpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787203422; x=1787808222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xUH9CsNCT2AYo/KL1wiCsOtz/uHuiRHqKrMuH1ZeNEg=;
 b=Glekp/od6nPEGPtuk0x12HzhfUVDn4GmPya/DeiI/7PW2oMMKGmw+wTiT3gbICvMH6
 veX/7K1oU0tz6Pgq/gckzbjpSZmLdZumYtS6vVzT3DIOLDyiiOsYlKJFn0qVWG9gx6Vl
 g4RtaOWouenAY7CwFhI/K9iZkmI2bjWCmGmYMWPItm7Xqiu3hpPXPNNb0VBx2hCiSqSO
 Q3ZyfLW0aWUQAXC5NHyYCB4aGShxuubGkkflHuIEZRSUAjCO0pwmQk+ZtlhlXkdEi7Fo
 sYOV/MLtzFMp5VlCZgmik8Ojoq7BvVzwyZsDewDbTEsWhvXT49DkUF0ryhntcqAAS1TT
 YAiQ==
X-Gm-Message-State: AOJu0YylvMFvaWrITlCAeZ+CVh6ry9ibGCKzR/JJA0gHzMmzmyIrNmGr
 8pSTrNiEVGNoCLGut+qlD37o5ogU7aCMvSBuqNfPfIT6BGqeaxdLm87AK3M+RmDKuNjgBz6rAhG
 tWegt
X-Gm-Gg: AR+sD11ZtuG4MRPfK1r1b1iIgFXiVUg5EDZFka+YVrkfJ4c+czB0PedIiIbCysaNpEW
 7li6+ArXNW1YatX9or8kcLGX82CQRVIx0mevHLPp1kTCtFPqE+svqM/BuWkiU942E92Nj5cH+97
 l1bHXWYmTuBx8NNPYJVDc6047kh8oC7FzPCzEnZl2T4+zl4LBErNX11EwkoEEwgkZ+WhvroyT3O
 KLUgspLDjs5SeTDiSzo0bh4UFdFFQY4g3ikEydEKhcJyT0KtgdM5zwOWpxBeOthykj7KvAX6ALz
 bxU4AzESznhGT3Jh7xJIDgZRPO5m3WqDp1lZgn49OUSnkjCT0b39RWkxnifSSY0K3C/VFavbQY3
 kStD+8dLNy6ThVfEereCDu7wux7stzIywQWKgXFrDpmG2TOaUNaj36d5ABjov+tloHXHkKdt0PP
 ikgWFlySwdKjqEtuoK69+pGvTyi13SKJBXD86g2tOlWpynYNxaAamnhJXce0fkOaBBgngduvi6N
 nKUV0879px7uyR968AZ1vn2HqM=
X-Received: by 2002:a05:6a21:339c:b0:3c0:b943:f984 with SMTP id
 adf61e73a8af0-3cd00e0e601mr17057929637.3.1787203421794; 
 Wed, 19 Aug 2026 22:23:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3bb5csm13700974eec.2.2026.08.19.22.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 22:23:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 10/61] net: replace use of rte_memcpy
Date: Wed, 19 Aug 2026 22:12:00 -0700
Message-ID: <20260820052251.1453273-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820052251.1453273-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/net/rte_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/net/rte_ether.c b/lib/net/rte_ether.c
index 6703145fc5..83009625c2 100644
--- a/lib/net/rte_ether.c
+++ b/lib/net/rte_ether.c
@@ -15,7 +15,7 @@ rte_eth_random_addr(uint8_t *addr)
 	uint64_t rand = rte_rand();
 	uint8_t *p = (uint8_t *)&rand;
 
-	rte_memcpy(addr, p, RTE_ETHER_ADDR_LEN);
+	memcpy(addr, p, RTE_ETHER_ADDR_LEN);
 	addr[0] &= (uint8_t)~RTE_ETHER_GROUP_ADDR;	/* clear multicast bit */
 	addr[0] |= RTE_ETHER_LOCAL_ADMIN_ADDR;	/* set local assignment bit */
 }
-- 
2.53.0

