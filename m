Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D12CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B160E40DD7;
	Mon,  5 Oct 2026 17:17:38 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 11DE440DD2
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:37 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3a4a7eb86a4so240411a91.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213456; x=1791818256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yeFYRIJYkjJCIkfNuYlGXgaRJax4fZNrAtDRA27D4g0=;
 b=QqAcaHddh8G2cCYqA2ZLl2FXg6W1Y15OBZGalYvS8eFTv8pn1NW0okJNqK30VilLpp
 BWfUtQYxeMtqZNLCKoNarNec5gbozYSwtuGdf5ofwjSDL9/lFVxrw/V4qet4OEjndLtc
 eF/QQjs+OMRGZYo9ZWu0pVH1ktCO9P+I+ikhFi1XuTNNcuC2Ylc1Llv80hUd+1pdP7t/
 twqWIqBx4FEU45Hfxd1y11gTjqs6p3Z8nOjdwup+Csg5yU2AbU8bDK0SZ4QUVfgICNC1
 dkqb2EQ4gqHhr2uUX4gXw4Y+HVghr5y6cjJtnJPuaPpwBfT5MtxWnh9CkFxfonteLWyF
 IIpQ==
X-Gm-Message-State: AFq9FYKODXsOZ4B1y+S0RSrWIOnaLuVkUpZ5rf1Pzix6MaUPDi2js+ao
 WOuFdiZvSBNb3jMQW1jIbKzkzZk3LvylPMaxgxCJ4Ks3OAj7J+4XuUbnTQTomzF+q7SuKtkQDdr
 8CEy5kskHt/E8T89oL/WyP1E+IIgth5zVb0eutYb01LfXZvofLSz0RUOrr5kepNpXOHRwKcv36D
 7tFi+ivN1mA4FVNKDBL3tdSLfxdIZTw9Mz92pOuDCO68jhebqXzgzE5xwpFq4Pigg2i5wICg==
X-Gm-Gg: AYBFou0FHYqA2zfmCF8WVZ4fiA3kJ2uSVEk6eZYvQNirTYmVHQiBP7xn+xRMaS9nyM+
 nzGKdvO4iiI4BiBooBaZE82UInyFhRS/eOvaijhsKtJto/SE0PpIZ2EKkhMgvgigGYoAaJy81wD
 EGBInGEHQRJrwTvmgqjSyW3cF2J0on0BWP9pIJC4rUDTNp9dSLMVRvATVFvlR3GW8CSQ/kaDDKC
 1hdu+qHVITmwWXet7F+7Z4bCaapd4bMwYBy3Uqn+QtJMFSMRWKMkEQnA9v2T6m8CjHziZAQrJGt
 QXjVKDee1NONP1jDy0EiOhsDDUB17AVIgXWmujXyaPaEvmVIiFEiYeDqqJzhjDCnqfMo8vHx4uj
 G8ZT6C4vK2ENAYTsp7UJCLN2ueKvZmMio5wVfx9fQtrInwSnw/OYX5+E2oGD7NTQp+OM+tt29OQ
 /Gl7ZPhS7mJM5QT0u2O/LvLgcis8ueOSb2qedx8g==
X-Received: by 2002:a17:90b:544e:b0:3a5:de8:2c4f with SMTP id
 98e67ed59e1d1-3a6ce9856b2mr7596018a91.65.1791213455847; 
 Mon, 05 Oct 2026 08:17:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a7a15e13f1sm3976804a91.7.2026.10.05.08.17.35
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-81eddfe28b4so28665797b3.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213454; x=1791818254; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yeFYRIJYkjJCIkfNuYlGXgaRJax4fZNrAtDRA27D4g0=;
 b=dxc3JqD2g6Su4x62BoPr5/zdJELq3ufzRMAZIpIsXmF9goUIKtQTQoLyQIC6A29D6t
 9WF8OnJEwEKoFUPzB9Z2lPXOwh2o9q8aBFz6y8xEn6Yu4uf9XjDmUFeKhadUlz5momlB
 QFwBPIE9MHwYGlBPNDkyD3eLEe8Hccq3k0MRo=
X-Received: by 2002:a05:690c:ec3:b0:8a8:8d53:bb44 with SMTP id
 00721157ae682-8ae39bc692cmr44983607b3.44.1791213454500; 
 Mon, 05 Oct 2026 08:17:34 -0700 (PDT)
X-Received: by 2002:a05:690c:ec3:b0:8a8:8d53:bb44 with SMTP id
 00721157ae682-8ae39bc692cmr44983307b3.44.1791213453954; 
 Mon, 05 Oct 2026 08:17:33 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0b19decsm89364566d6.14.2026.10.05.08.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:33 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>, stable@dpdk.org
Subject: [PATCH 1/2] net/bnxt: cap memcpy at field size
Date: Mon,  5 Oct 2026 10:17:26 -0500
Message-Id: <20261005151727.1706155-2-manish.kurup@broadcom.com>
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

The memcpy() copying a header field's value in the parser does not
check whether the source size exceeds the field's spec size, so an
oversized value overflows the destination field.

Fixes: f63aa27db634 ("net/bnxt: support dynamic encap action")
Fixes: 741172be52de ("net/bnxt: refactor flow parser in ULP")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index 442a795430..12f9cb80e9 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -66,6 +66,11 @@ ulp_rte_parser_fld_copy(struct ulp_rte_hdr_field *field,
 			const void *buffer,
 			uint32_t size)
 {
+	if (unlikely(size > RTE_PARSER_FLOW_HDR_FIELD_SIZE)) {
+		BNXT_DRV_DBG(ERR, "Field size %u exceeds max of %u, clamping",
+			     size, RTE_PARSER_FLOW_HDR_FIELD_SIZE);
+		size = RTE_PARSER_FLOW_HDR_FIELD_SIZE;
+	}
 	field->size = size;
 	memcpy(field->spec, buffer, field->size);
 	field++;
@@ -106,6 +111,11 @@ ulp_rte_prsr_fld_mask(struct ulp_rte_parser_params *params,
 {
 	struct ulp_rte_hdr_field *field = &params->hdr_field[*idx];
 
+	if (unlikely(size > RTE_PARSER_FLOW_HDR_FIELD_SIZE)) {
+		BNXT_DRV_DBG(ERR, "Field size %u exceeds max of %u, clamping",
+			     size, RTE_PARSER_FLOW_HDR_FIELD_SIZE);
+		size = RTE_PARSER_FLOW_HDR_FIELD_SIZE;
+	}
 	/* update the field size */
 	field->size = size;
 
-- 
2.31.1

