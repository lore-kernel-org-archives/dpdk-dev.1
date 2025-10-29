Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC78CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:22:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB83040669;
	Wed, 29 Oct 2025 17:22:49 +0100 (CET)
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com
 [209.85.128.227])
 by mails.dpdk.org (Postfix) with ESMTP id 8C741402A6
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:22:48 +0100 (CET)
Received: by mail-yw1-f227.google.com with SMTP id
 00721157ae682-71d71bcac45so1178167b3.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754968; x=1762359768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=BaDTuQRxYhcBk2xJsGctlnmtBDPc+zwPQE6apy/zBMbAEL4CO+65nb7Pwq/19PvF88
 Sv7Jbc8YZBXA5BUaz8K2fgmIJmw2Cv05vwXbjRFqHxR6oJhfUlMvoP9yFjgOKS0zTVtV
 agPe8/ULuw1PfsAlh/NVQ6SNT/onCPi1FVLxr7l3Dhu2NoKXzlfSNvov/V6bs1Aibsuw
 KaB1X4/Sq8K54AEltG4j1RJAB9LSSO1faAWZYciZKd5oPW/HOjMgHQR8aOaD99OA3swb
 rxTlbBrTPbnBhxbJqWo2/6qoBn/6x91xBNZdxAqODU63ruKQwXmcrQAROrS0gg+5pdS9
 qp1g==
X-Gm-Message-State: AOJu0YxSxtJdL4ZYFxkvZXf0xbk8exOls60MH6pRZGI5L5L52WszwF6D
 y1NUnOys4vfDuGRlxj9HQZlcHZskVY0nIiMX2M+vYVgLJuo8fZkAxX1lPP/8qtziO4KTJKlvXak
 uyqp0vpP5v8qh3G4BfFiUOvl8QzWmNTX38xZRK8mCp1jov+4HTKbQHBRZDMsP7y0Utl6LGH0CRr
 fW8+7Xw2WZlPMHC6ezzwmeSZDtXllKAXpvNwPuMWwIQcbPlE6FDVaUfYi05gepX6qS8BaHPw==
X-Gm-Gg: ASbGnct51ipDrUcgGuIQGRZAmp8gR+CGwoDH9OP57fJIB8ZayJQnghTKE+7NRWiQ/1L
 MyEBLRUhirV0Wox9Bj6wDhrdY6hGaFcdApV0GWj2T4F/nkydyQ7W8VIoDfTElfYioaEXaA5LSw5
 U9hxYXzooJx8aQdqJR8akNri3LJgk4bd0MoahnrpDdbHVv7ZzD/bOPl56VX6sl++qNFGya9Q/UW
 AfMWkfV0jO7bsOnaY77lSBM/+5w4fHGms/ltY0KN3PQcZqjtbcEN/qVt6TL1YoBE7+1YdXwYhi8
 tw/sYAQJLAiPEy4r/QR9OJKjJFWwtVbGHkkfRgT2K8EqKj6hOT/pVfob2yTS2EgbL5hhgXrUQrH
 bwqjBYctkctFVZPyiWh4sU7kD4MKBkY2r4mvTJdf6d3jlOcEpZM81I4PJ7jWMEdd6Dc51d3V5g+
 CnOf5A26PkWNYPQSQx8l3UrfKENza3jzk=
X-Google-Smtp-Source: AGHT+IE03Xz/wL946VAGu91MkOxWchCMhePfIBA7fOUxFAkDN4JUu964L+zHVUgOiRNEnnQ1zK3fjWHurrx0
X-Received: by 2002:a05:690c:2c8f:b0:786:38b6:f4f7 with SMTP id
 00721157ae682-78638b6f694mr2341127b3.40.1761754967639; 
 Wed, 29 Oct 2025 09:22:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-785ed1d05e9sm9747627b3.25.2025.10.29.09.22.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:22:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-891504015e5so2160993885a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754967; x=1762359767; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=CLw2B7r0m0kQwPdR/ETrZcUANqyj5HiCq7n3EZF7T/xtVAZpZk2g6AqbFZlYHzGIvH
 AXY/nuVh93Q9arDUP+AxU2VYjOkXYKJdEaK1hE3avfSD4VMuEMgbIUV1JLLvgAlOTC8N
 n9EqdKTNtTIiNEWuwZ3adByOhwuRxmRgNAlUk=
X-Received: by 2002:a05:620a:7104:b0:892:4858:11a5 with SMTP id
 af79cd13be357-8a8e426cd9emr436293685a.38.1761754966716; 
 Wed, 29 Oct 2025 09:22:46 -0700 (PDT)
X-Received: by 2002:a05:620a:7104:b0:892:4858:11a5 with SMTP id
 af79cd13be357-8a8e426cd9emr436289085a.38.1761754966116; 
 Wed, 29 Oct 2025 09:22:46 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.22.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:22:45 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v5 46/57] net/bnxt/tf_core: backing store cleanup
Date: Wed, 29 Oct 2025 12:07:01 -0400
Message-Id: <20251029160712.58519-47-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

