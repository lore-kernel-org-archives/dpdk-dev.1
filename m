Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEB1CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96B0242670;
	Tue, 30 Sep 2025 09:06:34 +0200 (CEST)
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com
 [209.85.160.99]) by mails.dpdk.org (Postfix) with ESMTP id 2E097402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:49 +0200 (CEST)
Received: by mail-oa1-f99.google.com with SMTP id
 586e51a60fabf-30cce86052cso3850330fac.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192668; x=1759797468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=xPUMdUSWk2440PM4Li83e+ZgKMKOrpyG+CF3+MLtUt3FEY07lKpe61jSHhmVKnooXf
 sOcP8cL54cG1SYV0b/a7IDE0m0oMZfEkkzZ6rzKb0vjG3Pnb97STOeKGebc/3Go7JP73
 oPxBC740ZikhbGP6sLKBVlBV6FpoFcsMR80MWhkjiAIFExh6EPs+IkGuXTus8FMGCEDY
 Xm0nJjvqkpctH5HrdeCjHy/JCLnpRS73BKFeDo78byTRFIZdYmOcwYdqeAKYbPvxYo3B
 arOx/kRS8WRyfUOgMHnEMAWtIneueoFM8VBd0d6CNNLm3tNUL74RHTnPNsuQ2LHdyP1y
 s3JQ==
X-Gm-Message-State: AOJu0Yyp9yhywLiiu7UsPNp9Mi6ApxJldHP8fiCjx9G4zHO86dayyG9Z
 MkrOsO7jTWIx57tbfhwdz9G2W8OEna93HyA5A6lJUeeo55dWJxlKrypaeVgeedyjOZerbGKz7Fa
 G6Tavj+8s4vtgGn3Zc6an7mtYxb4I4cA/MXIadZ5M10XD1DxCfA218+HpnFMZAW5v4hSQ4UAm+x
 MZR6b0nzHF3+7s/KVy5JdIqfAQC7PUltr7Mi/Lp4YyVdDGzdnrUhLUog6LisuGgp1fjAkcmQ==
X-Gm-Gg: ASbGncsOrNS7WZBuAHg/FKOeOW4JylUSgymENaOKiOcNo5ztaNh8g5e4dryQcjcKweC
 SdcGPhs8UdfUDZcPtN7jJhwKk6+sq4Jz4Ze1cmOrpLcP0si4S6fK+bYcoPP2elBlpJlqQPELKkE
 FrvazehGPLKqHNbReHlYP/Lljbbg6/Ib5id/BweXggaIUk9BxYMEOoju/kFCb/p7fx1KChN8pGA
 L7eC5a+hvzoRfmAxmc3zYgYmX/NE3NwSY4uJ4BKwxNuSYRk+fnxinWQ13NwefRFu8ezV2aweRiy
 cFgC5SaZYq8Kc1igTisYAtxcCZh8x4AnFrbhSEQQufs18fEbu5EF/YJfrclz/WGmHHXoS0g9qLd
 sSPm+1YxJTHQd5hDSYaBZOm1jJlP3cbh66Mo2kRT4O9eCkfq9bfwfOtUxeZXlancd+DzJIth8IC
 IjSw==
X-Google-Smtp-Source: AGHT+IErtwWHL01cKXNxXXdByIsM5ePU96UKr1v5tg+fR5egyGnfC/YHS/6GGz1lox+YinxWCcaqt6QBhrLl
X-Received: by 2002:a05:6870:32d5:b0:2ff:8c8e:c222 with SMTP id
 586e51a60fabf-35ec61690a2mr9799012fac.14.1759192668453; 
 Mon, 29 Sep 2025 17:37:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-363a2ce97f1sm1059952fac.3.2025.09.29.17.37.48
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-32ea7fcddd8so10648004a91.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192667; x=1759797467; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=buxUqLDlWNJ1gWb++Woa1j93ZJ1AJa2X1KE72Gqy/izUx5BNuxtgmQ+P7cEg0gjBB4
 rrRLMrD18OX1DccNG30nEpZoFAp7kEE1JCCTUWzrHTa0kv3oJ6xNSkncPBX5QTHxUr7N
 O7eVKTlAA6PNvNSU3XvTNtFGnnuBirM2sqzi0=
X-Received: by 2002:a17:90b:384d:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-3342a2436b8mr23286174a91.12.1759192666703; 
 Mon, 29 Sep 2025 17:37:46 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:32e:64ca:e84a with SMTP id
 98e67ed59e1d1-3342a2436b8mr23286146a91.12.1759192666120; 
 Mon, 29 Sep 2025 17:37:46 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:45 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH 51/54] net/bnxt/tf_ulp: fixes to enable TF functionality
Date: Mon, 29 Sep 2025 20:36:01 -0400
Message-Id: <20250930003604.87108-52-manish.kurup@broadcom.com>
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

