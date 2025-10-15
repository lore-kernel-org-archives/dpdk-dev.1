Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9421CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A8F742670;
	Wed, 15 Oct 2025 11:05:41 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 6BEA54270A
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:39 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso4069635a12.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519138; x=1761123938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=Smgjfrmq8wU7DdF51NC5BiAimk53atkdQzUZuwQwXfKM4CEss/937euOX4/6vPw+Gw
 eNmwEYxkgAVg1Sg9O1Cv6TwgazAU9RoC229aykFXHOm03d3OVeLZotMtbelNDk9d2Mpn
 BWdI0LtTig4fpNZvB8iGtlIrK0nSjWElCgBoamE39SfMAW84rqN2qKwA+xGQOew1k5tT
 23t4fe3rbw4sFh19z1G9/O147rvKn3YPafKrLLdUCN7jeWZAmsNbCdztgDZDD4DC6eNL
 H0R2I646KtlJ/O4MbUYvS0FScWc1TVceynd2Q0Zu83w4fx9ArERL5kKwXRrqFz6ZswYa
 l/1g==
X-Gm-Message-State: AOJu0Yz+sZykn2wOkTF5HRaOwkbmcapTHtA0Z37HKVzIGhj6zOeKbfaF
 MmeWW3ok9WrvMjHeD+2syVJwnZzJtj6RGSbpkoPiKWbDzXrU1T7UEWc8LCqsAM0L0E0moss9RE6
 ESw/Q8E1PnvY0j6MVhOs5L/OkSQcSRcYzVXVmJtpGvY5jbHLK0Bn2Apqq6A2vf4eS29c93BnAkg
 dd3/dgOrJ0zZGL8kLshPbssLNGlkER3VpHiU6djI4UpynhD3EoRbNSfNOG21okvsi/M2OcZA==
X-Gm-Gg: ASbGnct5v6DMwMtPweUlIDOUGn+Paq97TDCQHpBWN9HXv8zyNVHq17ONlqv4aPGgCKx
 Iu00k2+9/ioRYZG0a4BOOHLiArhIc7Af2x0zICwhuCmO88Hu6KdRENvhI/8INK0DvoyqMcHfQZu
 bAXrjZRKZyiRuHK1f2S7jXLewkRzcAaPh9aMVMqTeyofx7DUKkl7KNIQcRp+2N1zXJ7NxeWiVbF
 /ZjXYrN2Y3zfw0GVm/dOub/V7zsUy+A0xk6tkwrViaogH9z7WInQwi7UTIZUHFgpLWeKGyKtmYx
 S6ZpXG6k4nIyqWdl5Q347ei/uDVPrWl4o1WPaViBvFnyslfc4SgPJPuK1eMTWmqf9ry8MMBWBmg
 sq16y0A6ihaIYhyrqZK2Z5q43AgUq4yo0tIExoxmpzT+SSw/mMDqOV/e2pueC4KjrfFwu5WU2oB
 7MQQ==
X-Google-Smtp-Source: AGHT+IGKcLt1IWtuwEvB3qMuU7ToTuhZxEq3juxH+fBc5z1fj95weUOE6KfQTxP+BXMLYkiP/UeHs2tDPpoS
X-Received: by 2002:a17:902:f64f:b0:28e:a70f:e882 with SMTP id
 d9443c01a7336-29027215bc9mr356383695ad.11.1760519138352; 
 Wed, 15 Oct 2025 02:05:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29034df0d8dsm16005085ad.12.2025.10.15.02.05.37
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-780fdbbdd20so9161804b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519136; x=1761123936; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=KFlo5ez1xyiQMRLzgTIUtbcX8R/Lkcg2MLiVj0u5jV4zTuwqWbq5ECL1EE9qayAfCX
 D3tXgwDPFAfSME9E6wSHf7X5BCyVF4z/9mDCmzaW5crP6JkDOGfyCP5v8QAb+ryqkzHN
 EPMIq+MiQPPCK2AZ33Z3KB5wIakyP1g2jjoQA=
X-Received: by 2002:a05:6a00:b4b:b0:78a:f788:419c with SMTP id
 d2e1a72fcca58-793881ec95emr32838068b3a.30.1760519135978; 
 Wed, 15 Oct 2025 02:05:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:b4b:b0:78a:f788:419c with SMTP id
 d2e1a72fcca58-793881ec95emr32838037b3a.30.1760519135239; 
 Wed, 15 Oct 2025 02:05:35 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v3 51/54] net/bnxt/tf_ulp: fixes to enable TF functionality
Date: Wed, 15 Oct 2025 05:00:21 -0400
Message-Id: <20251015090024.32250-52-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

