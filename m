Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA4CCD18A
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:19:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 693B340E78;
	Fri, 10 Oct 2025 00:16:53 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 00E4040B8D
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:51 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so20623215ad.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048211; x=1760653011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=eCUWpFKQGeKOlk+DFfRRWu5Jh4VgwlrNmvQKQ+esaEXHSl4o9YCgvCe6D6MBtLjylC
 Ot0txt+9vE8Y4kZNp7gOuSi8Z7nl7QATr55AMXIbepu19wuxCmZP5BhK8tU1Eq2Z24tY
 0O7EJ0viixuveC5UYZw+lVWIFfyFBF4BjjGPqIQ03pD2/WuhGstmhTK2WH64nmlyzAIH
 JaGGf++P4THXGy5nX72lKiUAvcUjLNsLj+/XriK1F9v/jHss0uetgqia5VK4tq+Jp/lR
 osEJaOVK/2iWvY4cZBtZ+qoKAushDZf2e0Lg8/LUewu17b8+/Sy4wO9O56CFhDAdBIlZ
 kzvA==
X-Gm-Message-State: AOJu0YzEPOSIlFcdg/+/dyc2RjUf9rKErb2J69JspNIzMzKVh+f1oU/Z
 fvGcbUOuqgeNeJFqhnBFwFwcgfCIMWEFIzB7jdH86QGwFuCA/J2vQIgTwg6iohdHiMlmw3vWgOi
 tTHOGs/3Jya/mhoort5JvZJX2f36iJdobUpiH4c29sdFn4Tzx5c91cmTsl5QDf9jI6xiWWzecI3
 E5VQAi2NgbKd/vSRG8uBpx2ZxqpAvG0OlN6S6P63hDHsMeKrGq1dSS+Hg8YqQtVBNMxnPxUg==
X-Gm-Gg: ASbGncvBv+GxanPLWF43F2zT8iGYQH7ZyWcb/iR7wsfek5h2FbA8om7ARP7pdAu4yHB
 oTjuVOh12Drhk+PWuharOJAOGaspj35pKJH1lNgB5GG9Fx6MLj14Y9pEf2Rj8ZRC/zSkK3ZyNmR
 ZPCBnxhs9gq6PdS/oa3TZTL5TBk7sl5xQ7DiMh4uGc2OjiynAXwkogg8bAgl8Jzv11mai0QsrPJ
 OVpb4JHCo1fwctKq4JlmkSSAhD/fBAYPIsTR62/c1n83EIDUMrJ4WBDIj9AWBZEmJaYfbL/+gFk
 nm4y4q9+ptLde6f0MMmJTU/qfYr+qwjnaTGTkTalF01NNsOtG+lj9T3D2LV+m8/JzYLlkhG3bp5
 JQwXNmQNQB1IKI0NAdbMAvw2SJHQqiI9Jo/I2ffgl8qv4GA4EEYf5/iYpklF1WUBpSmSYA+OK1M
 7g/tUG
X-Google-Smtp-Source: AGHT+IH8tGRfvdwidQ+QtwAu1m+q6mu9rLghvNi68w2t5VyuBtpxb5S1F+9Pq6bS7jja8rDATevStAvRFGs/
X-Received: by 2002:a17:902:e54f:b0:28d:18d3:46bc with SMTP id
 d9443c01a7336-2902723d619mr135791395ad.19.1760048211139; 
 Thu, 09 Oct 2025 15:16:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034efa8f5sm3191555ad.48.2025.10.09.15.16.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4d91b91b6f8so30557581cf.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048210; x=1760653010; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=hThUBekMb9LlhiuSgezao1CDaCstdkebFnaOW/SdhyXHWGe7TyjWZKoJdSSsFezc/e
 uQyzzqhhFSuSVjS4o879UhgPuIbNtcw7Ckc0CTHH17979PJUyPXZ3FX/kErnN6L62RC+
 jMUiFIglM/h4rYhCBveo7sntcJytUyeWJQoYo=
X-Received: by 2002:a05:622a:4684:b0:4e6:ef26:3152 with SMTP id
 d75a77b69052e-4e6ef263a32mr70504331cf.80.1760048209605; 
 Thu, 09 Oct 2025 15:16:49 -0700 (PDT)
X-Received: by 2002:a05:622a:4684:b0:4e6:ef26:3152 with SMTP id
 d75a77b69052e-4e6ef263a32mr70503981cf.80.1760048208893; 
 Thu, 09 Oct 2025 15:16:48 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v2 51/54] net/bnxt/tf_ulp: fixes to enable TF functionality
Date: Thu,  9 Oct 2025 18:11:26 -0400
Message-Id: <20251009221129.28256-52-manish.kurup@broadcom.com>
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

1. Fix RTE_ACTION last item

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index 82baf722cd..26823858b5 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -211,7 +211,7 @@ bnxt_ulp_rte_parser_act_parse(const struct rte_flow_action actions[],
 			hdr_info = &ulp_vendor_act_info[action_item->type -
 				BNXT_RTE_FLOW_ACTION_TYPE_END];
 		} else {
-			if (action_item->type > RTE_FLOW_ACTION_TYPE_INDIRECT)
+			if (action_item->type > RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT)
 				goto act_parser_error;
 			/* get the header information from the act info table */
 			hdr_info = &ulp_act_info[action_item->type];
-- 
2.39.5 (Apple Git-154)

