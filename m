Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA1C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2429242F3F;
	Wed, 16 Sep 2026 15:12:31 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 8812842F4D
 for <dev@dpdk.org>; Wed, 16 Sep 2026 15:12:29 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469a34907so929446b3a.1
 for <dev@dpdk.org>; Wed, 16 Sep 2026 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789564349; x=1790169149; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2OSNo7TWTu/sdV6g0yB0xG/VzScKU06Lf99D9Ju4qh0=;
 b=jNuk8ty7wQnhvmKngw/dTmfvq4UGG9WiGD3iBQblQ8nCTnXWZuErs+LwBiuxI8xtqg
 /Hq8sxfYn6PNAOKZsiNBcb4jibxcNKxBxp7eDoUC+GssClJ8P1Sal8ZzsL41CncLx49X
 jjVdMeXLdgsnoLCmNuEr8TsytBvfglNgr0RZ9gfvFYWK28H2vjXrz2gYITfecHuTPhnr
 5a3RqpakBi9wBJD42/NRilWUjEIvAYqh3S7j1DUvcFFWnBKjkW9oCDk2KbDbXHsjcsLK
 LORxmb0Ec39pSyaObiGNABb5Yy7Dt8xfC6GAREsByPJzFJtBZVlhjtP6HyevnKIirfln
 XbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564349; x=1790169149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2OSNo7TWTu/sdV6g0yB0xG/VzScKU06Lf99D9Ju4qh0=;
 b=mRyzobOXQRjMbS4m8EC+7Pzb/41w1SW+sr5gGOjaRTWfJq73FQ3BoQwYtbXZghR/Gr
 UOfIMKgw6CqMeWqDHB/eGnCPay5WSI31kUSRj+gICoDHStMVpxp/b3ceiA52ZxKew/1m
 9tt/y/mh2LA85VDjOgiOM0QBg4yPvIfHIeQgtk126qMkTXwXAUJKGsrOH/C8DCw3wDtv
 AbHhOkIDDCpAOLmp/XbmPoeTeFMDtkcpf4QLAOYGv8+ehYyo8XoO7DVEkfIT7chCFU3c
 rMevsfgUXOa6sDWNZ6Hnk0VaPT7AEpU+O9vMJCc0kam4QZuq0q+yFBUCIQaS4C3kjCHh
 ipRw==
X-Gm-Message-State: AFuF++mb7FnzqbTXv2dS7iqLB6hgXb2pnWszopNwAjTbvwux2AwSHr6N
 J6CjX3vII/TiuPK1bedHLUzkmX5ed3KNlwyFlSbG9KVbu7haeNcnDdg3
X-Gm-Gg: AYBFou2mhFEwFSwTnd/JcDVizMecmvOeRUfKn2s3G9luJLOW51vlfstHOTcnNnEuVhY
 bytnvQrXcGbRV8cYbtMHk0Fx7czDjvVF/YnsyxX3y2ntPDRprsi2TI8q5wRY+5GA+QvBym81etc
 VccGlHmTHxCTE0NLNqXJCX3b6u8LtNozcjloWTOKvoOi3gw1EqofC0sl1aLhqqUDSwwd7Q6sBo/
 yH1oKTLlrLteod0Gj1OUEb1h3SmoSBVMfgCgjCWRug+DSkD81yUuNek+/hVf/hZXtTqYIWRI9fa
 KFOJLWRmUHjoiEvdjruK6cHIT4fiIcsQgM+AOpz0Oz5ib+hPf7KwTPREJ+GxAc8uIGZ1wdMAYUb
 vViI6JDxJIvImBlHJu/wl97YmDFnGxQGi+d8Zsg0yXu5Mml/G0DZQJrkL/zd5UyNO9PhjnPq7jO
 efWKMDpnQIZy7gFym5GUNd50Zb+6np2PNN41MfiOM4gcj4hn/qk2nfkjoDYBdDgbBMLf7xsqr27
 IxLiog=
X-Received: by 2002:a05:6a00:a229:b0:857:7337:5db4 with SMTP id
 d2e1a72fcca58-8723cc3aa61mr4692384b3a.18.1789564348520; 
 Wed, 16 Sep 2026 06:12:28 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-872025dd04csm1224882b3a.60.2026.09.16.06.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:28 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stephen@networkplumber.org,
 Zhang Tengfei <zhtfdev@gmail.com>, stable@dpdk.org
Subject: [PATCH v2 3/3] net/txgbe: fix flow create error codes
Date: Wed, 16 Sep 2026 21:11:05 +0800
Message-ID: <20260916131106.105667-4-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916131106.105667-1-zhtfdev@gmail.com>
References: <20260915152436.67378-1-zhtfdev@gmail.com>
 <20260916131106.105667-1-zhtfdev@gmail.com>
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

txgbe_flow_create() reports failures with rte_flow_error_set(error, -ret).
The FDIR flex offset mismatch and mask-only paths jump to that handler
with ret == 0, so the application sees a failed create and errno 0. The
global mask memcmp path stores memcmp's positive result in ret, so -ret
is negative.

Set -EINVAL on these paths.

Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
Cc: stable@dpdk.org

Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
---
 drivers/net/txgbe/txgbe_flow.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index a1a497fa22..084b1eec1d 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -3388,12 +3388,12 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				 * Only support one global mask,
 				 * all the masks should be the same.
 				 */
-				ret = memcmp(&fdir_info->mask,
+				if (memcmp(&fdir_info->mask,
 					&fdir_rule.mask,
-					sizeof(struct txgbe_hw_fdir_mask));
-				if (ret) {
+					sizeof(struct txgbe_hw_fdir_mask)) != 0) {
 					PMD_DRV_LOG(ERR, "only support one global mask");
 					rte_free(fdir_rule_ptr);
+					ret = -EINVAL;
 					goto out;
 				}
 
@@ -3402,6 +3402,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 				    fdir_info->flex_relative !=
 				    fdir_rule.flex_relative) {
 					rte_free(fdir_rule_ptr);
+					ret = -EINVAL;
 					goto out;
 				}
 			}
@@ -3431,6 +3432,7 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		}
 
 		rte_free(fdir_rule_ptr);
+		ret = -EINVAL;
 		goto out;
 	}
 
-- 
2.53.0

