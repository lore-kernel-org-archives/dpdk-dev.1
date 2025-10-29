Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8903CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:24:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4545A40BA4;
	Wed, 29 Oct 2025 17:24:39 +0100 (CET)
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com
 [209.85.166.227])
 by mails.dpdk.org (Postfix) with ESMTP id B0B9C40657
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:24:20 +0100 (CET)
Received: by mail-il1-f227.google.com with SMTP id
 e9e14a558f8ab-430c17e29d9so31552875ab.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755060; x=1762359860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnpDj5lR4RNJPdID+gl4yS/+GnWYICXNl2DN1eZj5F8=;
 b=bsQz9cH4wUaQGuQc3XGZ9/dRocurb5741mE4XSLc8McckutFmyqkBi4ejwcWcEZduI
 OSvDHeXfwWfAx1hpZO+B3DvYEhn5egox/qYa8y4VmLtrhEwGWvp0E+Q2eyn3QNO4V9UM
 bwY/FXT9pDYj3h96YeWT5I7KkGnuJa/cuskUAKIEZUxl8ZaviKenyB6BbdknozJPtTf0
 CIZu5R8d/cssKYslgX+FL6JhwLIDAGxIubsXhBo8pCNEOjCI+LtYtV98mrtewGG2O9KD
 7yJQ4dBMOckiz9MoUXfIJTV9wCsEwN7U320+PE+DW2tHr3pHJKpcebSnF5fKbtvJWQGy
 Fu4w==
X-Gm-Message-State: AOJu0YxQJdwok60pDfWcB7WEusE1uTNz5KeIBiq5Wh6fl1vNbi6QlGY0
 LbFj+0kliVv04blULI1+HC2PDjepTK12nMr8yGo2+07CTMxLm+YijwcmEWcr0M5+EKuKGHmWNpu
 Hnmp8GtSAl0PkNKrBRosBwaXdiHe0qSzw+gN0zWOyL2kLyIiQ8hhkao+Vwfx0h9JJPFmzGvpg7g
 +9onmF45geIKa9zqii1ZxzfMRdRl4RjOYGf5Rn2JYoqXmYzVdQ/+xqkcE/lNbopwy4+DmcEQ==
X-Gm-Gg: ASbGnct4khsndgac24wPsYrwlLhVR4EWqsLzMuMw89vMZvXPDt9oArkePgYIgeZQfLE
 9gSUtaW1mKS9Nfo8w8UolWARXQLLMhcF1zEMPSJHQiLvJss0mQDS+0SJMkcSP4EmfF99jKH77a7
 eI5MACdfkk8c1WqX+46xlBpWzCoY55v6+gGC1d/IAz7axNVnqYbMzjZWNZAPo6FQRTdRwuK3Y2j
 KQ2FhaOVsTM/xVu0ZQrdV+8Eyat/p1C7bePCcvHWkTmOZyzpZIkw+8or6m8SpO4Jz8PFNomOgcQ
 2rA1pXkpH3VaAdIxjiKgHPYwcW+7OLBMnrroYbQhTSqsX5/QXdt7SH1hS+pD9swJKZoR7xi7z4R
 Q8Zz02dtXnKC0o2djQRYF7V1lvfbJtZNIl0bG6dJqvNEhy0RfOwAL14/Md43otpiwUj/NLB/WMi
 ZK0tyQwrQ9iEDSmHMM9tsIcC/mOPT6mBTIXlOT
X-Google-Smtp-Source: AGHT+IGAsvoFcTyZcpB3AMInA8+Hh2OBvbywsgluYG3lTpyX7ZYPLv6f0umKQ8CxuJml7D9uLsFIKckyuGrS
X-Received: by 2002:a05:6e02:2285:b0:430:9fde:33d3 with SMTP id
 e9e14a558f8ab-432f9044a1bmr41207095ab.27.1761755059932; 
 Wed, 29 Oct 2025 09:24:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-431f688d961sm13996395ab.17.2025.10.29.09.24.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:24:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a9d56c36caso174632385a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755058; x=1762359858; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnpDj5lR4RNJPdID+gl4yS/+GnWYICXNl2DN1eZj5F8=;
 b=bYrnfEHtk4IiFbd1cjMCT1a9KOqvwt9R0tei757TJq5PRDmKqXfxDWHXkZ09fX1CDs
 syqQDeYHPjp321cw8CZqTAxCFPc1uOP2U/Jg7rFplEQWflLl+SiB9G0Hlse8Enj85MWZ
 XlY5rJaQmoIUwhSLesW9GeQy1DOin9tDjWgeA=
X-Received: by 2002:a05:620a:46a4:b0:8a2:234a:17d9 with SMTP id
 af79cd13be357-8a8e36c2977mr441971385a.33.1761755058624; 
 Wed, 29 Oct 2025 09:24:18 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:8a2:234a:17d9 with SMTP id
 af79cd13be357-8a8e36c2977mr441960685a.33.1761755058002; 
 Wed, 29 Oct 2025 09:24:18 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.24.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:24:17 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v5 54/57] net/bnxt/tf_ulp: TF functionality additions
Date: Wed, 29 Oct 2025 12:07:09 -0400
Message-Id: <20251029160712.58519-55-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

1. Correct RTE_ACTION last item

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

