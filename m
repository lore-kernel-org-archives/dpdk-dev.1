Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EACCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 19:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52D3940E2B;
	Tue, 21 Oct 2025 21:02:48 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id 05DD140E2B
 for <dev@dpdk.org>; Tue, 21 Oct 2025 21:02:47 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-92aee734585so263125939f.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073366; x=1761678166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=Z81TbpXebi1g8KJtgWN69Z1syyrIyhznr5GtHH09RVzGMjmQ7eSIFlB4591y3NizS7
 BiP69sHmcTJxP1FJxmdN+ihCNpBmtDOUYjb8VGVHVWTLH1j9c5owPIdt627nNRehx0F4
 9TlsR/VcHZFSnBY8oFHrtPlKZK8BlZHvQl+sR1V/1DprwB2Rwiu7/hI+Q4tnj3HAJ71/
 WHlUk9gjGWB2Q+GYisVMQEV/PuTidTgLAAfmUGlbbSAt+VdhEFBAqEFgzMze+XKC/kAu
 Nj02CuuBXlzT6naxIaDm7DhBBTa92K9v+1FsHHNgXGRuYMCBuEACbE6is4Y5aIjApj2j
 6ITg==
X-Gm-Message-State: AOJu0Yw+KLRVolLs+BiuH+jo4qHgIfBjbOecEJRcbw7lbOfaaC/vXc+W
 x3bokNZFq9+StNWRimlxg3YiBmVhG2uVynKeG7cKzB6IslvSBnPeUmnkacS9hbojI1+Cng3NQNJ
 W3mPzYNlvO+wbcKukSREz5q0ja7Ly1MWM/+sKFkbJlprDMODzC6AsEed2ZyBRUdmu/Qc3sI2JfB
 pTKfq/WGJDCUCZShbgPiGpAaRwJziERPsfUK/1V415ScTi7Ugtn6p+DQoXHH8Jgjl6YswRUg==
X-Gm-Gg: ASbGncuQS+jR5JxEFXie9n1mxwMGES+FXTfUUbZL6zAePnkHfQwe//Itly32l8e7vpu
 cBJWInlz4VWGTWOiR31kQ9JzFo/DVNGGDxsYs0thIVPYz4QchMU7KQ92tkqri0uhryQC9A/wLKW
 oWh3YSYiXVag1mj0YOVrXnZGx3HaePe1nzmJkrSVWSgxld2rwG2arG6Hx/wPdZ32ceEiUbg1CNZ
 qho1HWEeNUDxg8nO1k3u5DhXC1P5jl87lgVW/tAaWNFLw7J0onDxDyjZjvPZdyJrxQwDlsLo+DC
 Cx0orkSAFaijHBo0h6101b4wkJ9zRSwDbl0jx3bZD5cGL/HAn639mM8lPFmRCxoq7m/N2wz4sb6
 SpL8ZzxWs+ckowLkfBL3gwRz2MjYN6n22vei2Ge6CC7Z/6SDww7kkm1pPgnDzx7iteg7seM3hfc
 xQ3/sxIIzueCSbMORU607IyX6bMbu0ietocg==
X-Google-Smtp-Source: AGHT+IEotRtbOhOzAvEGQOzEoeZmwS1eeR09mMq1gDxpYwN24Z5xnNfsR150wlMEy8q9camNSP1xh34fvmec
X-Received: by 2002:a05:6602:15d2:b0:93f:eecb:83e2 with SMTP id
 ca18e2360f4ac-93feecb8bedmr1719300339f.17.1761073366078; 
 Tue, 21 Oct 2025 12:02:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-93e8661ca5asm92421239f.2.2025.10.21.12.02.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:02:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-7a264d65dbeso116276b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073363; x=1761678163; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ov8beNlK5EI4qA1kIC7e5YAQlPOWpddnAdZ+HmM/MI=;
 b=VVdfQ2DQLUVWT9EGVyEuiKSpaAUA/M7DpTcVp5IRQkVAI0koHbB+KCqSGlaUOIDLPG
 jDMYwNvSD0cJ3M90T3O6ShwdOtmTgY2IgguAzhF7VXFi2V4Rt5imOu0ZBX7qQUJPT/8K
 NKc8KiGPFfvqggFI6sbKaELycXakaupvj8Gzw=
X-Received: by 2002:a05:6a00:c95:b0:776:138a:ec97 with SMTP id
 d2e1a72fcca58-7a220ab1c72mr23485791b3a.28.1761073363275; 
 Tue, 21 Oct 2025 12:02:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:776:138a:ec97 with SMTP id
 d2e1a72fcca58-7a220ab1c72mr23485733b3a.28.1761073362621; 
 Tue, 21 Oct 2025 12:02:42 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f256dsm12011019b3a.50.2025.10.21.12.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 12:02:42 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com
Subject: [PATCH v4 54/57] net/bnxt/tf_ulp: fixes to enable TF functionality
Date: Tue, 21 Oct 2025 15:01:55 -0400
Message-Id: <20251021190158.74064-2-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021190158.74064-1-manish.kurup@broadcom.com>
References: <20251021190158.74064-1-manish.kurup@broadcom.com>
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

