Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C48DCCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91E7641109;
	Tue, 21 Oct 2025 20:58:19 +0200 (CEST)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by mails.dpdk.org (Postfix) with ESMTP id BB533410F9
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:17 +0200 (CEST)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-290deb0e643so45464965ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073097; x=1761677897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=p4odOTGmZnwESlTtar7cm9uBWaszS+OlijEzq1lbVTPvcQiHqJuj8nBAtTXoFLZ/si
 YC+MiEYEvKr/+7MTrS9CkSImEj9/7M7uCrQm61HnFf9gF0BX1mEMr+5im6OBtfkH2q9l
 YE+Y/AQIHxYipN0TFbID4kLPOWmWpZjGmEh2uKqPn8aRyMEU5mzTbMX/XCJAG6VAEcKI
 Gg7JJ1bmpO8mM2zzbekGPIvmmCXbXURKry+AdnuaWwa9+M6FpqdOLEjO6uxspEFG+5c9
 xi8qEtwjUwUNONK0iSIWQh8OulP1ZvBJo2cwm9PrzTLU9Zq9pJqYpU4tnkN8MNkGS/KD
 UZYQ==
X-Gm-Message-State: AOJu0YwSMiNSNTV62v/ocbg9wuyhGp4zd3VQNzPoedoqufnOxj4VzMZ7
 tA8w6PPfm4LkxhuTAUi89acPbxYzy4tS3enQMud+wckhC+8S3w6ozZlkhJMqHYBDGUF2ueSEnks
 LkC6riUyd7Yl3T6DC7Iqc519otMZInQttVuPm7khQzlXMtqevYaCfODLuiDhtHoVGs5S7Il4Eko
 PHQa8Zqn1f95xmZhmWsdrypNl37LizAQVwnJdn4SUw5IlA4MjAp6FIh8LgUDtWLU8qZbFz2A==
X-Gm-Gg: ASbGncu4XI7xYijtTVGUktwwjWH0+a/fbsndzafi7tIZWtiEJtoaO4Ujod5sq8fnufL
 1Di4U9ZQedp1ArVu0wCT2OSz510MdqUx60BM0pIObjrEct1bSfuK/eGXUm9r7NuxZTXrLpCXcz0
 Uxmv82es+Do6B6PJBgSSFNPV4TpjRo5FdYB0auR/Kzi+pJDon2a6bfPDUnw/iHJnt5cKXPrIuUg
 MuUzu9ZRlGHZT2LtvRKKOYgQz3VbV580JNknA/DQk9bzKR23epXoE92pYSO1enCAaZCzEpa2+bi
 p22BULX8UkzfbD/B/Q3hGx2dVAgJKll9LgS9IzZcgMrAfaKuJbqn+Us14RBvl3ceG5WwhF4VEjh
 BzpUFG8jYQN/Jrheg5Qa2aFjyCehB1JKvb6pZZWAlXwMxEW3qHrNx4kX+3Q3VwBz07VcKEmoCrC
 zr3iF8D+AnuU0c12r6661OELee7sDfmQYzmg==
X-Google-Smtp-Source: AGHT+IEMhUob0w505Am1gxadBKlPuM/HLb8llb58GjVpv3b+65jcjAt2GOvbj5c4DELvShQc3Nie6HgUfChT
X-Received: by 2002:a17:902:cf0b:b0:28e:7f50:5d80 with SMTP id
 d9443c01a7336-290c9c8ae6emr258364965ad.7.1761073096789; 
 Tue, 21 Oct 2025 11:58:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-292471ddb6csm12940995ad.58.2025.10.21.11.58.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-290c07feb72so46685855ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073095; x=1761677895; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=g7XJD2knOhN0LImhtNuZItauGuZeW3VQ4052fIP6ux+waXW1ZlsWCGqhVivN+qpGUU
 YByZqekJ7DZcUxFs/YyTMge4CxE/sQm0ABr3cBe0j/7Ie9PGnwktu3i21LLBa720Gz2l
 1z0gwMxj80LghkxuVskZWymdV7QUANLnVIW4A=
X-Received: by 2002:a17:902:ce8d:b0:27e:dc53:d239 with SMTP id
 d9443c01a7336-290caf84628mr225213725ad.35.1761073094999; 
 Tue, 21 Oct 2025 11:58:14 -0700 (PDT)
X-Received: by 2002:a17:902:ce8d:b0:27e:dc53:d239 with SMTP id
 d9443c01a7336-290caf84628mr225213415ad.35.1761073094553; 
 Tue, 21 Oct 2025 11:58:14 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:14 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 46/57] net/bnxt/tf_core: fix truflow crash on memory
 allocation failure
Date: Tue, 21 Oct 2025 14:56:50 -0400
Message-Id: <20251021185701.71881-15-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

A backing store table allocation failed due to lack of memory and
resulted in a crash because the result of the allocation was not
checked for validity.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index b229f07596..878f62c115 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -505,6 +505,8 @@ static int alloc_link_pbl(struct tfc_ts_mem_cfg *mem_cfg, uint32_t page_size,
 								RTE_MEMZONE_SIZE_HINT_ONLY |
 								RTE_MEMZONE_IOVA_CONTIG,
 								page_size);
+		if (!mem_cfg->ts_mz.mz)
+			return -ENOMEM;
 	}
 	memset(mem_cfg->ts_mz.mz->addr, 0, mem_cfg->ts_mz.mz->len);
 	mem_cfg->ts_mz.page_count = total_pages;
-- 
2.39.5 (Apple Git-154)

