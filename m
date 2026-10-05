Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4407CA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 20:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0992440E2F;
	Mon,  5 Oct 2026 22:25:55 +0200 (CEST)
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97]) by mails.dpdk.org (Postfix) with ESMTP id DDAAA40ECF
 for <dev@dpdk.org>; Mon,  5 Oct 2026 22:25:52 +0200 (CEST)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-483a66818edso981637fac.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231952; x=1791836752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C0ElXiPmIpv9qzXsxYxITcRBwguPHftnvjDp6Wzky1I=;
 b=gei71rbSQGbc34QJ0wi4VBE4vRqgEnBqg54adDYFa4zAfWee6UqatLMrfRTpA90ZSd
 tyaIJc+EOAIo9UtkKoCu8ebbpfc6HHsK+SBVbLgqr5vqWCQ3RqM9vlA8KUtgs9a5io9g
 poXpp7AJciM4V6qQH5iH5dOecmNspf+lf7L9LbH1BOfPBpq2W8IOpkHktFq3XaO3u1di
 fc2k8m8WkF1H0M7LtyKi7ClSCBnn+C0BnuHpccS6unvD6r298XTr9x0QXHRIL+1mMoeJ
 1FeZsqJXFQHneKFD4mVs+KTz4rkyRwDrobjuWhV8KNeA14wlyl0hA6xsTUxHvGT2kuQ5
 pr5w==
X-Gm-Message-State: AFuF++npzVN4aA08NFtWl+pM3j/f/Xcbw3vB3rdc2nQe+CQg6XV8HbJy
 tzmQ9BkyosyjRJXG9oSBDTp8mSzrcs3rEqXqCEHxDRxpIBMFz2yH2z1/qTHaNCapG7RNIIxn1sN
 enG4CCtZ7brkN/H1CgIiYIZRSg+yUxeLTK+f0hSOjdBkrc4paXV9NX7Cvn311lZMuqF3hBwCKuS
 NojKeuxjGa7CQg4su1PJ7Bg0EpoX+HIMMrY2QpTp10xRr8nlBR8ll/nNaz0dcqQFTBjL4EoQ==
X-Gm-Gg: AYBFou0xXUal1xVxNtIFU+Er/g42YOIz4ltGcFCorzY3z4YmlJPOJVbgpAzpSvzEfOX
 LsnTcx6mdoalvVJAQoIbKsUdckpYWArBMYu5GlHKH2anruPfNF7MoWEVyVQtTzDbeFqGtOsfmpn
 EmTZMLURStXZCzFlajKaP+zm+a9n8kzi898v6szoZn90HZFrgs/qtuqEAC+RtM2zRCKeoaToOGi
 PV/j8Ff37j0kAmb6KM5w2OWaGjgfK4/p5ZgPRjSNg/dH+yfo84f6h+BPd/FT4HNXxc9n4jMAFkn
 +seJ7sOnlsO2Sub5JFyxmPfLc2CXipy38aab1GQNE5FpsdjqH5XWaCctGszinvY4f+uJQGzpm14
 16MzwhGPqDNNOobtgpJPjlPKFxO/YKILVQUA2inWemMBFkaYn6zgW1pa5NlqEPNQDfOBlBYOnTQ
 oNmuDXmLX54dk1Q7gKcphSVoivNougSJnpOv6KGA==
X-Received: by 2002:a05:6870:6588:b0:494:8d38:437b with SMTP id
 586e51a60fabf-49e3a90fd8dmr6548539fac.37.1791231952010; 
 Mon, 05 Oct 2026 13:25:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-49e1708a685sm1373450fac.19.2026.10.05.13.25.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 13:25:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso249220285a.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791231951; x=1791836751; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C0ElXiPmIpv9qzXsxYxITcRBwguPHftnvjDp6Wzky1I=;
 b=SVOITzS+shbO6LLL7ak9qstoKa+NGOsOKUyoNgACC4YUsin6/PyO7rNklIk8+bsHVV
 NZH+RdaRTtnshVHactZH0L45u6NHoMniccGhbtD4XrDR5RceHmE1/R/zA/ZMxhXB3daL
 fBExzJRktG55DcM8kBZWs4CVoY5bU6WZ7HHZk=
X-Received: by 2002:a05:620a:6314:10b0:93e:7540:7a24 with SMTP id
 af79cd13be357-93e75407bdemr484783485a.48.1791231951049; 
 Mon, 05 Oct 2026 13:25:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6314:10b0:93e:7540:7a24 with SMTP id
 af79cd13be357-93e75407bdemr484778985a.48.1791231950304; 
 Mon, 05 Oct 2026 13:25:50 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-919861c7b62sm4006426d6.13.2026.10.05.13.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:25:49 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: fix memory corruption in tunnel entry list
Date: Mon,  5 Oct 2026 15:25:47 -0500
Message-Id: <20261005202547.18322-1-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

When the app tunnel table is full, ref_cnt is never zero, so
free_entry ends up as -1 and the wrong tunnel slot gets updated.
Use the correct index instead of free_entry.

Fixes: bdf4a3c6316b ("net/bnxt: support tunnel offload")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_tun.c b/drivers/net/bnxt/tf_ulp/ulp_tun.c
index b90b4bf252..8ecdac0dcc 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_tun.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_tun.c
@@ -33,7 +33,7 @@ ulp_app_tun_search_entry(struct bnxt_ulp_context *ulp_ctx,
 				    app_tunnel,
 				    sizeof(struct rte_flow_tunnel))) {
 				*tun_entry =  &tun_ent_list[i];
-				tun_ent_list[free_entry].ref_cnt++;
+				tun_ent_list[i].ref_cnt++;
 				return rc;
 			}
 		}
-- 
2.31.1

