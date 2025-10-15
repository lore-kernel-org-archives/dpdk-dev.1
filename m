Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6383CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02C0540DCA;
	Wed, 15 Oct 2025 11:03:54 +0200 (CEST)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id 62B5E40B94
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:03:53 +0200 (CEST)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-35ba7c71bfdso2921432fac.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519032; x=1761123832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tG5Na/fogn9Ok5ZrBXJdy+bDvZYRR8UTEo3Vhj9VXlU=;
 b=tRZessa6lqZR+PWtQQDKqZROT6JNxcspJTc+yM366rj8NJdsi2JnrdjrbJIgIvByO8
 HVwloF8v31NQ97O6nvV2jVtmAiVRVCLcT/vMCu4FlSXgnr2RVGIkEA6JogaAulJ9VYC5
 IEU+x+PN7L3C4PIBP/jwuEK8XxIKmF7cAWbSYZItejfiFcUPZrhHK/1NnQLx8UhRaYBm
 G1fw3yaj+ULlHaHENz3JZDHGYascBpIoM9HHPpYI4g3JazynN8ntMPmG5FePR50YfdNG
 CQ2H2kOzf4YaSWUWTfFbf4x4h1XoFwhrwEWS94VUgDJnyq+b7uYSS6b1o5E1ydKXSZ6k
 Y+0A==
X-Gm-Message-State: AOJu0YygBmZrMzyaDjSAx6HL5w5CzQV6mNOJixHW1z5O/L2/CTr06pk4
 mJW8SuTQev4hhemSHyj+tGTv87zHCQsU4Xv9sqM5/6cMFeYpF4WTvszz5uIB7ye1z88VwelFmo9
 uU/GcR1yZB/zGERO6ht9CGmTGgJQK/RaBWS/dHDWTgmZnhn0K8DO7q9dGE/Yd5VmQhdexWLIoIT
 rEZIjfJxU37cWYlGFDRf3GZuMViYVndRd6uFfmKVcAMMjUh21ebyC6cDBZYq9Q69W88EeRVQ==
X-Gm-Gg: ASbGncspePha0vV5Siv11f39/cJMK7gceGyQdRkXJ6MVSQfFRRWtRXDQ5T09LAIbC9Z
 b8V/7ObnXbvzCdWsXJkhv/zkY0KJYKajy2tmxoAxmXqM4UeHgppRvtYXAB30ZRQou0XcBA8sCgK
 sqWF+Dusv0TSf7Z0lW1rsBG7zYPsxPN2Gx2fORwsqFWNLtSF04/ZtKeusrJCNsyiM6qCp+u/qHZ
 KMYeR2b2zN7aEI/ySH8cbm0QpY5vJneKLjsxr2glRnKWQTmXyvkU6PnPKeiocvn/RdShlnjK7Ap
 1HzArELMTEqFKlYO2OUYp28zPbuvIrATaMqRwcbxJWRqBR4IcCMLjXm8Ldq8FquZvtowRO8JdBY
 RuUUw3au5kovXYf0v9agKTw+FuPBh5TeIMepuSDD3yPmQ0ivf+UXp5sDj6UARRD0VBgcXs5v2
X-Google-Smtp-Source: AGHT+IE/uS+23xAv0VEFG4S2R+dPUlQNfFWd4Ip2NYbEByuISoMqc2iZUtUYTMO4qTUMc9qBTyEkyiU2gEcQ
X-Received: by 2002:a05:6870:d298:b0:345:b0cb:d097 with SMTP id
 586e51a60fabf-3c0f5d12deemr13621494fac.4.1760519032561; 
 Wed, 15 Oct 2025 02:03:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8b7eda7sm1399872fac.7.2025.10.15.02.03.51
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:03:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-782063922ceso8846423b3a.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519030; x=1761123830; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG5Na/fogn9Ok5ZrBXJdy+bDvZYRR8UTEo3Vhj9VXlU=;
 b=g4tXf2t4jnDTBZ3o/zvwbSoprKGYbSZM1ErAEviSl2sIx+Knx0KNi7u+fT3uV2N8da
 py5fCSeR548nv4UKKubNKO6Yao2Y42vYVZnwMW6ordoCuDf19wlxkHjqTZDpnUtnchLD
 AH7YDlNurIggCTaynAz+upC5Hjr+1kaEi0UFU=
X-Received: by 2002:aa7:8881:0:b0:781:171c:54e3 with SMTP id
 d2e1a72fcca58-79385136265mr34707629b3a.2.1760519029856; 
 Wed, 15 Oct 2025 02:03:49 -0700 (PDT)
X-Received: by 2002:aa7:8881:0:b0:781:171c:54e3 with SMTP id
 d2e1a72fcca58-79385136265mr34707600b3a.2.1760519029296; 
 Wed, 15 Oct 2025 02:03:49 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.03.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:03:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v3 13/54] net/bnxt/tf_ulp: increase shared pool size to 32
Date: Wed, 15 Oct 2025 04:59:43 -0400
Message-Id: <20251015090024.32250-14-manish.kurup@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Increased the shared pool size for table scopes from 8 to 32.
So that 32 instances of application can be created.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 55adceb59f..af3e82a6a7 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -373,7 +373,7 @@ ulp_tfc_tbl_scope_init(struct bnxt *bp)
 	if ((feat_bits & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)) {
 		if (!BNXT_PF(bp)) {
 			shared = true;
-			max_pools = 8;
+			max_pools = 32;
 		}
 	}
 
-- 
2.39.5 (Apple Git-154)

