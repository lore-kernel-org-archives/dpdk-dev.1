Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56FFD5F87
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 08:25:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 292154060A;
	Wed,  8 Apr 2026 10:25:42 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 2E7DB4025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 13:47:34 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-3870778358aso41200111fa.1
 for <dev@dpdk.org>; Tue, 07 Apr 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775562453; x=1776167253; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sC0938m/KXZmLe560SWoY/bQXn8cgdg0AUmSOpnPLIA=;
 b=O406Qtxk6xohS1Eih5L87mBf+42ltPrbGfI6Wgrz8dJApVousWofWtjaY10xJwNWXA
 Ef4jslCP4nT6iLzZQZbI+RPlhTiNLAt1pUrgv9IpmviKuTnUMoYgQva38mVWQsZS0qdg
 WDR2Lsjkxy4qkSxQ0INUnpzHhGCOGHWgH+kuXyHDp6L5tE/9D+JB63byecnRwBGmDf0a
 8KAwHHfo+gwawxizCMpPCKBOP1XC64jZ20KadtdVY4xbJ2tGIzBCbyarJLhB8/DGY1zr
 V/u3prowwy28yUNTCWGTaUvc18nKi9VcFFtizkayGRYi9gkvEg+CnNCTc5S1XBehs7iO
 subA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775562453; x=1776167253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sC0938m/KXZmLe560SWoY/bQXn8cgdg0AUmSOpnPLIA=;
 b=aFytLlq3GXauOPEabtd/1WlLQLB9yy9eKAqJ1yHg76nn5eIRjBVoe8IdUvGxd79DQU
 LIjwaHqr79/yR1c0NZ5dE1KOmNgVwplcl0K5O9MvOC1DLyU87guql66Li3+LBWC56Kig
 dLMwSWCInpbsTVvVZGyTEXufFY23lt/1c0f+uFbb06fm0tBfPxy6UF+e0hznAEf9qKdQ
 WteAEGvPG2fPl4p4eiOTwy2r/J3lF3WqfTDdSHBhP1prUnc+fA00vAgwYP3AJvUdcXHo
 5DKeuvmAlRP8v5s9IK1godDxoaXIv/uy5jQijWOcMctTBAJQrkN8gTj0OeDlaBMrB91O
 EiEw==
X-Gm-Message-State: AOJu0Yz9ytGCObBhXLFnqfsa/Qjt6IoHhKy77dwNowblsPi+LAq3LZGw
 kRfPHvCKdt8sPWV0sgH7yd58ALJty1wh/riQc060nbDDkVqsCGWvhWI=
X-Gm-Gg: AeBDieuSHAIM4VDX0zf+v4Cl9usGFHkl8JVAOQdNL8Ov5nwUmhnzVGIvma7DB9dvWfC
 Sq4HJM/QqBLxhcl6ocXCTDi731z5xFgirlupuCuXB+kUD3egpJnOoWDSWtD/6i2cKpGKppVMqAS
 Z/93z0vFckNKZltsxFhU3d+y6kIVubzM6s0WlJyfm5n0W3E6gWT860QPlstjb5iimTa16qUvO3y
 w85zLEK73NAZwFTb776V/vUAmigat89bMOrtO7Eb8w1SPNgkbfat/4xhNnJv0SKRcych0QOi6HT
 LnJB3HirH+2xDGxTtKkElLlWfHKf4iqUlbPx1FRydtyc4qmO8Zn4OEAuEatYdpTVMH1NWSoBZNP
 jcj7hT4tYSwUeBmabUn5F2Ut/e1COYvHoLL171P0o9sBPq/Buhti5JPC/8Nf2KUlOaOc6Hn6+za
 391hV1YCVRiqlD4JBUZDOM3hAB6u88/klj
X-Received: by 2002:a05:651c:2114:b0:38a:d532:47c6 with SMTP id
 38308e7fff4ca-38d91bf7404mr55858601fa.17.1775562453173; 
 Tue, 07 Apr 2026 04:47:33 -0700 (PDT)
Received: from dev-debian-1.home ([81.94.128.221])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd2108cb3sm35274681fa.25.2026.04.07.04.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 04:47:32 -0700 (PDT)
From: Sergei Iashin <yashin.sergey@gmail.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Ting Xu <ting.xu@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Cc: dev@dpdk.org,
	stable@dpdk.org,
	Sergei Iashin <yashin.sergey@gmail.com>
Subject: [PATCH] net/iavf: remove dead code in TM node parameter check
Date: Tue,  7 Apr 2026 14:47:30 +0300
Message-Id: <20260407114730.1222526-1-yashin.sergey@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 10:25:39 +0200
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

The non-leaf validation in iavf_node_param_check() unconditionally
rejects a non-NULL wfq_weight_mode pointer at the top of the block.
The else-if clause below re-tests the same pointer, which is guaranteed
NULL at that point, making the branch unreachable dead code.

Remove the dead else-if block. No functional change.

Fixes: 44d0a720a538 ("net/iavf: query QoS capabilities and set queue TC mapping")
Cc: ting.xu@intel.com
Cc: stable@dpdk.org

Signed-off-by: Sergei Iashin <yashin.sergey@gmail.com>
---
 drivers/net/intel/iavf/iavf_tm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_tm.c b/drivers/net/intel/iavf/iavf_tm.c
index 1d12196ba6..efdbb45b62 100644
--- a/drivers/net/intel/iavf/iavf_tm.c
+++ b/drivers/net/intel/iavf/iavf_tm.c
@@ -178,12 +178,6 @@ iavf_node_param_check(struct iavf_info *vf, uint32_t node_id,
 				RTE_TM_ERROR_TYPE_NODE_PARAMS_N_SP_PRIORITIES;
 			error->message = "SP priority not supported";
 			return -EINVAL;
-		} else if (params->nonleaf.wfq_weight_mode &&
-			   !(*params->nonleaf.wfq_weight_mode)) {
-			error->type =
-				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
-			error->message = "WFP should be byte mode";
-			return -EINVAL;
 		}
 
 		return 0;
-- 
2.39.5

