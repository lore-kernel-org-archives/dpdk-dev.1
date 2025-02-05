Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6ABC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:25:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C64304067A;
	Wed,  5 Feb 2025 17:25:11 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 9FDA14060F
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:25:06 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f9da2a7004so2106317a91.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738772706;
 x=1739377506; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfXiE2LtADCfDkW4/FzronF6b6+6e4EqLUV8etfbTU4=;
 b=rPfDFc0epn5+oJJ8n6qIRDCDVjVd0mj+LG+zrFrRBEPJrDsY61c73gsbQZnLbSOpvi
 8zo2SBZzHtNM1ieoI/zA0fZe08Vc+uHuwlIcQekqIZvSeHDcfe74Hs1/7RGgiKY72I/g
 /OIURGTmNu1/SwVJYKuBzXt0Uu2azZgD2GrppEYPhmoUCf1s2SwrXjaa1qWSwqps2YeY
 9LJvYQ1s3io7Okm0LSOQAJznxQAiyb/aupxfY1Mn6SCj+WDqj8heNc8RM4imocBhS4Fu
 wxjK1hVIBeKTENk+i8BmAQ6yhY/eTIatq/XonwCREncAicHQoq6j8YCpETzCdAehG4dy
 EVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738772706; x=1739377506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TfXiE2LtADCfDkW4/FzronF6b6+6e4EqLUV8etfbTU4=;
 b=bpF9ZxYNx4GG42wLzDfttIE69qDBr3y79VP3biSpCbMl7LkKFOpueifdnF1V2ouQaf
 z5HitjXjam7vitXzyNFwfEVxXlfP2u9S3TOJ/9iQYXfTNf4UQfreYk8blSmBpJPNhBX7
 CGkDpqITL3PJDIZI/qoCA9nYpF9NQAydsnn8TmfKcIHoIfhds6hfL0wNKX+yOpfw63cb
 lBlV5uQn/gkW+Izqb+ziArpIWgEnPYIujYn6wT8q9F8279e0Qx1ATqEki1fkQEhAV2bL
 rKPR2M6JssfqfaPjKLGUW5kIiOIzPIMtL9eoMZ8FooZqSewZO/aT6/DV/7Ms9VGdnhtn
 EGBw==
X-Gm-Message-State: AOJu0Yyb/H0+9tGBt/67E/c0oXb/n951Hz7o2XFauSeT9NFDcFiffeYw
 Kgyxfe41HjqlLrf/4jSRexbicZAc5WJC+/KMTc5SZDgx+oEc6q7//0HIqwuBbj+3FOAb9zodpwk
 S
X-Gm-Gg: ASbGnculSw/8HVooNsPiVuM3O56qfKFcxiPaLke+qZpjWfWf5FpdY9EbDlOGAIZdao0
 7oEFHliSZJWNtKU08HD33+aN6m7R8yBSPp0/qU+5H8hks/Kn1Z+PRVASfxQisKlYrMY71io/fep
 furGnCb46uLztue65xip0HmOp0XnT1OXDnyu0XIoo7X7zqRY0h9DuTklyAlckH5+AfbyypURF90
 49e2LhaMYKnJMmCo2taT60VCcLo4LE+9wWPppKjUXm6I+3eFLz8IHP3AvrhTC9R0aQ0poN5m3qE
 psSkfSfwvBdYVu9rog/riG5fUb8QJLaipdrdEUWBBV7ysKCMuDkpCcZ9IRKJ5D03V12V
X-Google-Smtp-Source: AGHT+IHGNHV/+8i9af6XKFJ6C4foocqANPp8cwlRy7kWjNyYVKQpfPgEhlwCGt6QUyw81+H8HH73ow==
X-Received: by 2002:a17:90a:d604:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f9e07627a6mr5377243a91.8.1738772704207; 
 Wed, 05 Feb 2025 08:25:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9c314b64fsm2138965a91.1.2025.02.05.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:25:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>,
 Rory Sexton <rory.sexton@intel.com>
Subject: [PATCH v3 05/19] net/i40e: remove duplicate code
Date: Wed,  5 Feb 2025 08:23:06 -0800
Message-ID: <20250205162448.161161-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205162448.161161-1-stephen@networkplumber.org>
References: <20241115060738.313190-1-stephen@networkplumber.org>
 <20250205162448.161161-1-stephen@networkplumber.org>
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

There are two branches in the cascading if/else that have same
condition and code; remove one. Update the code to follow DPDK
style where all statements in if should have brackets if any
leg requires them.

Link: https://pvs-studio.com/en/blog/posts/cpp/1183/
Fixes: 2ab5c84605f0 ("net/i40e: fix ESP flow creation")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_fdir.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_fdir.c b/drivers/net/intel/i40e/i40e_fdir.c
index 349627a2ed..94e3ab44e3 100644
--- a/drivers/net/intel/i40e/i40e_fdir.c
+++ b/drivers/net/intel/i40e/i40e_fdir.c
@@ -599,18 +599,16 @@ i40e_flow_fdir_fill_eth_ip_head(struct i40e_pf *pf,
 		} else if (cus_pctype->index == I40E_CUSTOMIZED_ESP_IPV4_UDP) {
 			len = fill_ip4_head(fdir_input, raw_pkt, IPPROTO_UDP,
 					len, ether_type);
-		} else if (cus_pctype->index == I40E_CUSTOMIZED_ESP_IPV4_UDP) {
-			len = fill_ip4_head(fdir_input, raw_pkt, IPPROTO_UDP,
-					len, ether_type);
-		} else if (cus_pctype->index == I40E_CUSTOMIZED_ESP_IPV6)
+		} else if (cus_pctype->index == I40E_CUSTOMIZED_ESP_IPV6) {
 			len = fill_ip6_head(fdir_input, raw_pkt, IPPROTO_ESP,
 					len, ether_type);
-		else if (cus_pctype->index == I40E_CUSTOMIZED_ESP_IPV6_UDP)
+		} else if (cus_pctype->index == I40E_CUSTOMIZED_ESP_IPV6_UDP) {
 			len = fill_ip6_head(fdir_input, raw_pkt, IPPROTO_UDP,
 					len, ether_type);
-		else if (cus_pctype->index == I40E_CUSTOMIZED_IPV6_L2TPV3)
+		} else if (cus_pctype->index == I40E_CUSTOMIZED_IPV6_L2TPV3) {
 			len = fill_ip6_head(fdir_input, raw_pkt, IPPROTO_L2TP,
 					len, ether_type);
+		}
 	} else {
 		PMD_DRV_LOG(ERR, "unknown pctype %u.", fdir_input->pctype);
 		return -1;
-- 
2.47.2

