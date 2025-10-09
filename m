Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40667CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 427EF40E42;
	Fri, 10 Oct 2025 00:16:34 +0200 (CEST)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id 2B1C440E31
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:33 +0200 (CEST)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-781251eec51so1270991b3a.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048192; x=1760652992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=JhGMR8JD8L8AMqRrS8svacNokn0rZy2kwwzMy6DtohYnbH4PiAr4BEHcNeBajuU4IT
 IDN5pbSuRZ3TdntZgPPx+Y0zUTCoMVHijQx0xkkqDqHDnupHEqTObtw8qDL9UTb55f+8
 +S8vnLJsnu+arvaUFjSUu3d+i7mSW/yz/uICJRRc7Lb96yTP0olOMCcaOpKBmCty9Isv
 zPHuz9CRrjfry8w4XMw6vyGTJeRDspSNB8Sw5E2U6RsbeyueszYBREddKQ+Y7Bda6yWF
 lAp8tuoPHMCmKOcR1wiJ5T/HWNdYW+IixuG4pRx3/fHcY5Rc2p73tpMysU8MA8GxdvpR
 KrUA==
X-Gm-Message-State: AOJu0YxueVZhRkrnI23SmuKib3TlteFLg4qw4tN8iW21XTI6zYkxI5O6
 O1WgXYNl464G/vIwpR+26jwkULVmOqjzmXvTphdbx5lyaK+gTZWmCCgA1kLC3glGYHt0GVA5lCQ
 gUZoFzIkjMaClmegFLMHgfrTHVfgjFuf2O76oNeL4ObyUDXSuOPm1g6/t0Em4pzkcV8FMnSe47Q
 s8YuBP8PSYUhT11wptzZnTVVCWPPnybEYNUBd3aW/ssLKGu8XVHThgR71mXB0XPmzXvZvsyw==
X-Gm-Gg: ASbGnctmNNQ/1hUN9DVzmLLKCcjZ95WLumJhpaglHKqMCWcVYVZKGlcONIajIM4ghDm
 bhB0epsvEcqUf3l5KFpJhlT1aUX3VVDz7Nz8kCbpFhD9s3sf/j1yU6ihnhHyOF+1TaGOatBA1jC
 JHJpH+WdiQHtqDyd+fS8NXcdcHjg8+HMexUMvaK6l0BzUEgxFEm5l6ogJpFRxITIKkTap6tVGcI
 R54IQAk3EIFeXg5Adsz83dz1+RCOC70u+7mcrpa+F9/mzqrh/xp/7CHPY16MjKz2mNBqY9CXcNX
 iQ7E4Ok/HsQjVYW8w6pgPTTeHg8IxVpv8qIT9myIhbXZbJfX+hPHKtDV6+Ad7qKz/vElOyOfcf0
 5l7XtjDqQI6mYNOJ01Ft+SOiqX9Cozux57oOB3WzyrT7Q6DanoPl5J+1ZZ0BPxyMcO2EL92s0qc
 JQ4vFc
X-Google-Smtp-Source: AGHT+IHu0oH2xHrzuIHq3Uin2PqZWUBBs0w4hlf5aboyRRxXUOfbX7jhQQ45oFu1QzFgw37pf3wizUY2rHwA
X-Received: by 2002:a05:6a20:3c8e:b0:2ea:f131:e25e with SMTP id
 adf61e73a8af0-32da83e54b6mr11685194637.47.1760048192152; 
 Thu, 09 Oct 2025 15:16:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-b678de04d5bsm42068a12.7.2025.10.09.15.16.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4df60ea7a1bso51922331cf.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048190; x=1760652990; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=Jf4ENQEVv2+RTymA5avVv00ySYh5/X99E9F250pVZD+Hyy7BHuO9SSL3rcCdqwvADQ
 OD8attZ4UxGQIVZ3wkljVKbehnIgPweEwT3wQYD9ZLV0Qn6DbMfRyU9t1IPprxyffE6N
 gvMwqhIfwUM9yao84RhNvHl/IEi4PDAIifxQY=
X-Received: by 2002:a05:622a:5914:b0:4b7:9add:76cd with SMTP id
 d75a77b69052e-4e6ead4bdadmr133118001cf.42.1760048190619; 
 Thu, 09 Oct 2025 15:16:30 -0700 (PDT)
X-Received: by 2002:a05:622a:5914:b0:4b7:9add:76cd with SMTP id
 d75a77b69052e-4e6ead4bdadmr133117551cf.42.1760048190158; 
 Thu, 09 Oct 2025 15:16:30 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:29 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 43/54] net/bnxt/tf_core: fix truflow crash on memory
 allocation failure
Date: Thu,  9 Oct 2025 18:11:18 -0400
Message-Id: <20251009221129.28256-44-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

