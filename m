Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2056CCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:18:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D04F040DF5;
	Mon,  5 Oct 2026 17:17:41 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 4018040DDC
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:41 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-8ad98c3fb15so1025647b3.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213460; x=1791818260;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hRD6bqNgxFlJY0205fFLS1D7/w0QZ0MmiR9BfTSl3/4=;
 b=IkbpBooB+TMsdmBj3YIhTXXGTSDsIa6GGsamDKyLAiYv3LgaYLhTIz718ebQfsIv+P
 3hwOEhBOswuQ7uDpOsU8cwSEfvRmgyK+F2XtwSEIHkc8qOqdnrntb/iJIqEHkVkGTI3c
 0CFNk7VT5Ut9jWusMoSMmoRpUjD7XWEdZG6G2PWduJkAEtro5bsz3gU/3F3Tvdi5YZmC
 66N7aPMvx06LpzFQyoGtM7cZW+Nqw49LAjx25YLJ54KjU3hFJVjqdAm7YHbKg33PXAPa
 mK38jqzN8HlZ/WaESotP52l6bONIblCqKzoyFqLZFpxnPFyBiX0TVNFi2D1u8rnyXiOy
 hVEw==
X-Gm-Message-State: AFq9FYJhN4Pm+/HnOeiIW+CXCcoXY7hOPpPa13uHCMhzC/kYzfmj3CkG
 A3n06vn0XoiJ42KGLACMBlCOH/YWLXV5SZ2N+38czYbYXAn4apjIrA9wq9vOyqGpqCGFIxIBGI1
 ym8PTeejquTqZ0G55VGTFrRflmrB3l8Z1H4TM7qaJ8E5qlaGNtE6lBBSNcS+Hscpqp95ludciYF
 yXSR5gMUaPI0trP64oFPZFlMWE1OeE7HVXi2d7MGKXOLFWpEvdfCQLcTopZLF2xfvTUuS9PA==
X-Gm-Gg: AYBFou0u8Pw0PmcQiQepU3qe7N3uf+ua0zhhnsYNXySooIJZ+dEFoK3+puFXF0lzgr2
 KDXG9mWD4hNNJ4PLU0jNyFE69Gwsz5gJS5VNOeNdAY796A9baVcBUiqnwgGzTnB5MEgIhlc7W7S
 gPp97W7ML4Wx6mCb/cZO24aFHoyxs0Q3muc8nWezP5qIO7sRSyh9mFnfKjs/eQmNPDmQmyJjtat
 L9aAmKI0R94Ylu8hZKlGgJllBvlVSXMpfwGhPDU33zNXaxYc8s9GL3LCuoNyM7WsL5pku0fx2sl
 lQb3mD4kOMR+m2HThm5p/fNe8Hjxi2i1LnMC/iHPAxwOkCIfR0Su2bgBeaUZiDl6haPw8MRn5Ct
 rnJ+Q8mdHXswvm+fqDjVn/e3688cE275oUWkbsX6+ieU8grRYTQNjM2gBC2UMt672LxUWC3VMSl
 hKcGh86sLDZbVVKOGPJyfB4T8qE51bkydpaeGFNg==
X-Received: by 2002:a05:690e:189:b0:671:548e:f14c with SMTP id
 956f58d0204a3-677abfffe41mr3286098d50.26.1791213460424; 
 Mon, 05 Oct 2026 08:17:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c1bd7c26sm1367679d50.34.2026.10.05.08.17.40
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso283930785a.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213460; x=1791818260; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hRD6bqNgxFlJY0205fFLS1D7/w0QZ0MmiR9BfTSl3/4=;
 b=cLK9+AFxQ7C7fZHas1S8Cip6Q37hab2PCtGxZZXc9I75VgvVQ3YMJ8BHrFIl0y3XW+
 yMWrugF6CWcda0fN1jCQzyXsHX9+/cxXpFqdFiTg/qt2REvtsPyOTGYx6OollXp24Lre
 XPHyDeqR5BzGzzDvB5yVdi2jDj8dEE/oTwwjI=
X-Received: by 2002:a05:620a:648a:b0:93c:64e5:f6c8 with SMTP id
 af79cd13be357-93cf17862efmr1780165585a.49.1791213459694; 
 Mon, 05 Oct 2026 08:17:39 -0700 (PDT)
X-Received: by 2002:a05:620a:648a:b0:93c:64e5:f6c8 with SMTP id
 af79cd13be357-93cf17862efmr1780161085a.49.1791213459161; 
 Mon, 05 Oct 2026 08:17:39 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e4e7b2cb2sm684060585a.17.2026.10.05.08.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:38 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>, stable@dpdk.org
Subject: [PATCH] net/bnxt: fix ICMP v4/v6 L3 proto match
Date: Mon,  5 Oct 2026 10:17:36 -0500
Message-Id: <20261005151736.1706210-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Shahaji Bhosle <shahaji.bhosle@broadcom.com>

Update the L3 protocol computed field for ICMPv4/ICMPv6 as well,
for the case where the flow rule matches on the ICMP header but not
on an explicit IP protocol field.

Fixes: a4d4308ef105 ("net/bnxt: add ICMPv6 parser to ULP")
Cc: stable@dpdk.org

Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 50 +++++++++++++++++++-----
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index 442a795430..fb1dc3f60a 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -1976,6 +1976,35 @@ ulp_rte_item_any_handler(const struct rte_flow_item *item __rte_unused,
 	return BNXT_TF_RC_SUCCESS;
 }
 
+/* Function to handle the update of proto header based on field values */
+static void
+ulp_rte_icmp_proto_type_update(struct ulp_rte_parser_params *params,
+			       enum bnxt_ulp_hdr_bit hdr_bit, uint8_t l3_proto)
+{
+	switch (hdr_bit) {
+	case BNXT_ULP_HDR_BIT_I_ICMP:
+		ULP_BITMAP_SET(params->hdr_bitmap.bits, hdr_bit);
+		ULP_COMP_FLD_IDX_WR(params,
+				    BNXT_ULP_CF_IDX_I_L3_FB_PROTO_ID,
+				    1);
+		ULP_COMP_FLD_IDX_WR(params,
+				    BNXT_ULP_CF_IDX_I_L3_PROTO_ID,
+				    l3_proto);
+		break;
+	case BNXT_ULP_HDR_BIT_O_ICMP:
+		ULP_BITMAP_SET(params->hdr_bitmap.bits, hdr_bit);
+		ULP_COMP_FLD_IDX_WR(params,
+				    BNXT_ULP_CF_IDX_O_L3_FB_PROTO_ID,
+				    1);
+		ULP_COMP_FLD_IDX_WR(params,
+				    BNXT_ULP_CF_IDX_O_L3_PROTO_ID,
+				    l3_proto);
+		break;
+	default:
+		break;
+	}
+}
+
 /* Function to handle the parsing of RTE Flow item ICMP Header. */
 int32_t
 ulp_rte_icmp_hdr_handler(const struct rte_flow_item *item,
@@ -1983,7 +2012,7 @@ ulp_rte_icmp_hdr_handler(const struct rte_flow_item *item,
 {
 	const struct rte_flow_item_icmp *icmp_spec = item->spec;
 	const struct rte_flow_item_icmp *icmp_mask = item->mask;
-	struct ulp_rte_hdr_bitmap *hdr_bitmap = &params->hdr_bitmap;
+	enum bnxt_ulp_hdr_bit out_l4 = BNXT_ULP_HDR_BIT_O_ICMP;
 	uint32_t idx = 0;
 	uint32_t size;
 
@@ -2026,11 +2055,12 @@ ulp_rte_icmp_hdr_handler(const struct rte_flow_item *item,
 			      ulp_deference_struct(icmp_mask, hdr.icmp_seq_nb),
 			      ULP_PRSR_ACT_DEFAULT);
 
-	/* Update the hdr_bitmap with ICMP */
 	if (ULP_BITMAP_ISSET(params->cf_bitmap, BNXT_ULP_CF_BIT_IS_TUNNEL))
-		ULP_BITMAP_SET(hdr_bitmap->bits, BNXT_ULP_HDR_BIT_I_ICMP);
-	else
-		ULP_BITMAP_SET(hdr_bitmap->bits, BNXT_ULP_HDR_BIT_O_ICMP);
+		out_l4 = BNXT_ULP_HDR_BIT_I_ICMP;
+
+	/* Update the hdr_bitmap with ICMP */
+	ulp_rte_icmp_proto_type_update(params, out_l4, IPPROTO_ICMP);
+
 	return BNXT_TF_RC_SUCCESS;
 }
 
@@ -2042,6 +2072,7 @@ ulp_rte_icmp6_hdr_handler(const struct rte_flow_item *item,
 	const struct rte_flow_item_icmp6 *icmp_spec = item->spec;
 	const struct rte_flow_item_icmp6 *icmp_mask = item->mask;
 	struct ulp_rte_hdr_bitmap *hdr_bitmap = &params->hdr_bitmap;
+	enum bnxt_ulp_hdr_bit out_l4 = BNXT_ULP_HDR_BIT_O_ICMP;
 	uint32_t idx = 0;
 	uint32_t size;
 
@@ -2077,11 +2108,12 @@ ulp_rte_icmp6_hdr_handler(const struct rte_flow_item *item,
 		return BNXT_TF_RC_ERROR;
 	}
 
-	/* Update the hdr_bitmap with ICMP */
 	if (ULP_BITMAP_ISSET(params->cf_bitmap, BNXT_ULP_CF_BIT_IS_TUNNEL))
-		ULP_BITMAP_SET(hdr_bitmap->bits, BNXT_ULP_HDR_BIT_I_ICMP);
-	else
-		ULP_BITMAP_SET(hdr_bitmap->bits, BNXT_ULP_HDR_BIT_O_ICMP);
+		out_l4 = BNXT_ULP_HDR_BIT_I_ICMP;
+
+	/* Update the hdr_bitmap with ICMP */
+	ulp_rte_icmp_proto_type_update(params, out_l4, IPPROTO_ICMPV6);
+
 	return BNXT_TF_RC_SUCCESS;
 }
 
-- 
2.31.1

