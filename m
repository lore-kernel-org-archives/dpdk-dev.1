Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D2CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57E5940EE7;
	Tue, 30 Sep 2025 09:06:20 +0200 (CEST)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id BA822402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:38 +0200 (CEST)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso3626410fac.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192658; x=1759797458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=kKRGEZP3CbBGIB8Jh7w6XDIRV84pNK7ezhjHqu0N1qS2Pz6CjJslODCRFfiApSKPuP
 ukl8GIblaQnxz+BcnZFWxsl5M0RP7Jl+5J/KD2dnhxx94/ijpwcPt7Co6og/5v1HRQN1
 kJzMCsVvxlaOjXh7rhcr6mhcRSEYDdohJYZImN4LTfUXBzs6vv39FDIcsFYvXkC5RqPl
 x8EVGNkGtMeyo3knd9oqdd4zUW7Suy0jBwHgeOtS3hCbSRJo/1vbJQQCXrxsQNUiTPMT
 rv1421sW4I5o2xL84VXCsDEk2CwRhhNtxpNzao1rTRAxG+LX5zpHwBGMEkv7JQkdLMwf
 FkKw==
X-Gm-Message-State: AOJu0Yx7iYICl6346/uwm9NHExhcLfTLwhkfx/0OgPIvLOBn9YzrCGBp
 HKAkefat/VgCkMRz7nHeX38F/6M0UvYxeS1adHSb/6tSap3Ol3LfwrWkNdrqoRux4pS4Gb4eNlz
 cEqYVuhNDl82Om515v02lMecczInO6Fc3fKoFJTY9mkr8OxL9FVC8UyaO8OFjTz/oJDiGg5UCx7
 08ihZVhpgqQkoChCjdqGUKMe0xGL454HHT91fqoBKzKjGTjy7MSCynJ+Fpdru2T9vuoh2w2A==
X-Gm-Gg: ASbGncu8z4jv4SoQIVLyTiPE7R3ZTsS6lh39pn7pQuGTZH2e0M7mKBA/szOUL1Wwd0N
 AJCFnuzu+6exu/PpRp3twHOXHNL5k4dq7kreDtlCK2O+okY3M2r+EfR8hI5G12YdWnSNlybvYjn
 8aSp5CjxrnY70hdR3qksi9oglsZoCBe59LJu6QDNbpWorCNYZDt+on2mcW6jrwidO9hgc1cV7bs
 jvMNa12B7oEDZpdQzCE98Z0JJnzfiqWjf+6wmTML6pvFLewZQ5Xb8+htf8KXz0vVIZ31Z5ktT5s
 Lq0uP5yzkEhYrhUeHHfOsuNmUtjF5d+rgAlloSAJdC8CK3rwd9VVQ4P5O7GR346RvhDQlmeWhDd
 674NIZv4NjIg+KIaxxwDs3cDSixgUEA2Md8bWrSrYZzf7UeMtJRcCQQi+NulPD/iciY03UHlotc
 CEbA==
X-Google-Smtp-Source: AGHT+IH6wjyk4cEUpztj4y5p+st3WAOoz6TzVIxcdsK/40j2uyaVBHAwnjCIqiW2S4b8TKz0bdtNH0ByB0Dv
X-Received: by 2002:a05:6870:a118:b0:322:c3:960d with SMTP id
 586e51a60fabf-35eec273aebmr9563420fac.43.1759192657876; 
 Mon, 29 Sep 2025 17:37:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-363b49ab6b8sm1114518fac.18.2025.09.29.17.37.36
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b550fab38e9so3625983a12.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192655; x=1759797455; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=cc6aCq8bHsISHT01nhkoBF5Qhn2q8Le2z2nT5ppQ2PiomQ5esN6YWaIWrbnRIPhP/d
 NrKM2M+Pw3o2z7W24WTp4EtQLqWdW3ADy792uvTY7Tq/3rbXmhR7fMylnJQ+/ex3ngNa
 es+PUSKN9xNa0KU5NGlM0I0j0u+EdnqB3vXAE=
X-Received: by 2002:a05:6a21:6d9d:b0:250:9175:96e3 with SMTP id
 adf61e73a8af0-2e7d474b937mr20817930637.30.1759192655368; 
 Mon, 29 Sep 2025 17:37:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9d:b0:250:9175:96e3 with SMTP id
 adf61e73a8af0-2e7d474b937mr20817906637.30.1759192654865; 
 Mon, 29 Sep 2025 17:37:34 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 43/54] net/bnxt/tf_core: fix truflow crash on memory
 allocation failure
Date: Mon, 29 Sep 2025 20:35:53 -0400
Message-Id: <20250930003604.87108-44-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

