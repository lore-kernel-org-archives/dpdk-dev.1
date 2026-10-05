Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B06CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C41E040DDB;
	Mon,  5 Oct 2026 17:17:39 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 2C4E740B92
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:39 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-3a4cdc9025bso134759a91.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213458; x=1791818258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zixmNs8BIrFi5zXqo0/s20ehysLeC4FfFHJhc3VlFF0=;
 b=FC2NqGEXJVGAKxu0JFmQLRZZ6tBcZ2Lr/s6wnyNuCG5ZqfQZmwEMmIDOwmWBsiwB/L
 gPH8KRUfqEkvkFkH1NQkW4fM74DRIo1jC1uudH8ssSt8/WxWjefg0wNckcKQ4VCVat2J
 eL+18MuByXc4YcvrhBuDooloyDtQZ9SDjNV1+zSvva8/Eh5+nr82AJGXsqeRBhrprUGc
 sg/OIMtupPrYCdZgGKn7IaVEuvDEYkIbHcmdwJ5aMR5eCiFhNVdIiD2LZKZzQVV4vV8f
 oCFeG9mnY6IXxbKIHXTseejw6Y1/wocWF43eFHTJs9dW42ftP4ihBFZ/F7EnUBcOhE0w
 E2sA==
X-Gm-Message-State: AFq9FYKYnIuNHEJVKf6RykTg+pNKXhivPBqrnFeNGy6FQpX33UMn/II7
 6Ml8cBPifOx4qvEekr951s+ktQ/10A1hR/CctF+cLTJ8QxJjBcqrGx/NboZYSNqVNsBrEBqhjZ8
 vNxICh6Y4p1QYyNfOR9cHkjIHaxxk+h86mq6nksUjP3JDCltXguAlcV9D4oF3ee5werNurFUCSu
 blHOs5tUqdSQUDP/08kOV3wgIU45erxyDWsqKyBAqTtn12JSMe2lSsvQhyd6Xq7LdN7VwdoQ==
X-Gm-Gg: AYBFou1D9yHvMoNtPnegZY9BDY5cmjW8TrP/tMdZ4VP/HH/l9aVBNpKqtuCmsE+SDZV
 mYAisz01d/BxQiOYXeAYTqhKec9WjTWpKwEbRmy06TDPwxc9gh56u3hBfJz995uupnRIyd+XUCe
 HX/z09JwtkpP3jZduwTAJA5sQVIuT5rmTEMI+EJXDXNaIwmqC/LgbygIb2BMNMoVaGRefMpGsBk
 ulqL9rwMizuj85hc56JOQzc25wuJj9rjf/CAdnkiuA1zH5pOQFpozT/wlS8MlVX1kicAi7HmykN
 aSzT49iMtVtPf8KsTs/TD5rVU88sPXR/IrH/ngJQom4OZwEZoJqY4cl0CZ9GYok3+vdosMZHqqq
 tn3jJ5+hnoEceHHtiJ1zitp5ZGZeagZ2SSlkJ98mfQ77nMk4u3QN5dqvwuZbrfnNfsqGi+HXJGZ
 SIrQtUjp1OOC2A30X9u293xpA69qzNvJ5xMFb0LQ==
X-Received: by 2002:a17:90b:3809:b0:3a8:181a:2bfb with SMTP id
 98e67ed59e1d1-3a8181a3cefmr1183802a91.23.1791213458139; 
 Mon, 05 Oct 2026 08:17:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a81a076bb8sm1219864a91.2.2026.10.05.08.17.37
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53395d51187so30387711cf.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213457; x=1791818257; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zixmNs8BIrFi5zXqo0/s20ehysLeC4FfFHJhc3VlFF0=;
 b=hWOqKYJdEspYihcqmIoQn6xBdbJxsz0t2WTufMHds3NYclk7Z00C9SmD3VEUOYg70/
 bY19LQGotAnQD0sIeJ0ctiOMWqkxwl0h+Pnyy39fhlHE7Ne1L2XSxnFgawt1mFnC6Pm+
 XyAxftKwun2Wa66r8zRA5UPbjruj/oz2dgF/Q=
X-Received: by 2002:a05:622a:4205:b0:533:908c:408a with SMTP id
 d75a77b69052e-533cbcad4c8mr202503751cf.32.1791213456891; 
 Mon, 05 Oct 2026 08:17:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4205:b0:533:908c:408a with SMTP id
 d75a77b69052e-533cbcad4c8mr202502651cf.32.1791213456066; 
 Mon, 05 Oct 2026 08:17:36 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0b19decsm89364566d6.14.2026.10.05.08.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:35 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>, stable@dpdk.org
Subject: [PATCH 2/2] net/bnxt: replace VLA with heap allocation
Date: Mon,  5 Oct 2026 10:17:27 -0500
Message-Id: <20261005151727.1706155-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005151727.1706155-1-manish.kurup@broadcom.com>
References: <20261005151727.1706155-1-manish.kurup@broadcom.com>
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

From: Dakota Sicher <dakota.sicher@broadcom.com>

ulp_mapper_blob_block_swap() used a variable-length array on the
stack sized by caller input for swap memory. Use a heap allocation
instead to avoid unbounded stack growth.

Fixes: dd0191d5e70d ("net/bnxt/tf_ulp: support Thor2 ULP layer")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index 2d89f10d5e..934634c606 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -388,9 +388,8 @@ static const char * const mpc_error_str[] = {
 static int32_t
 ulp_mapper_blob_block_swap(struct ulp_blob *blob, uint32_t block_sz)
 {
-	uint8_t data[block_sz]; /* size of a block for temp storage */
 	uint16_t num_words, data_sz;
-	uint8_t *pdata;
+	uint8_t *pdata, *data;
 	int i;
 
 	/* Shouldn't happen since it is internal function, but check anyway */
@@ -407,6 +406,12 @@ ulp_mapper_blob_block_swap(struct ulp_blob *blob, uint32_t block_sz)
 		return -EINVAL;
 	}
 
+	data = rte_zmalloc(NULL, block_sz, 0);
+	if (unlikely(!data)) {
+		BNXT_DRV_DBG(ERR, "Failed to allocate swap buffer");
+		return -ENOMEM;
+	}
+
 	num_words = data_sz / block_sz;
 	for (i = 0; i < num_words / 2; i++) {
 		memcpy(data, &pdata[i * block_sz], block_sz);
@@ -415,6 +420,7 @@ ulp_mapper_blob_block_swap(struct ulp_blob *blob, uint32_t block_sz)
 		memcpy(&pdata[(num_words - 1 - i) * block_sz],
 		       data, block_sz);
 	}
+	rte_free(data);
 	return 0;
 }
 
-- 
2.31.1

