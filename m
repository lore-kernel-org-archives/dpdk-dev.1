Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0FC982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:15:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24FA840DDC;
	Mon, 21 Sep 2026 04:15:20 +0200 (CEST)
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com
 [209.85.221.228])
 by mails.dpdk.org (Postfix) with ESMTP id A2DD7409FA
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:15:18 +0200 (CEST)
Received: by mail-vk1-f228.google.com with SMTP id
 71dfb90a1353d-5c985f055b9so3084726e0c.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789956918; x=1790561718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AEfDZoES2qgVNa+VF9AdJH+uzSZww/K0CHFA29/IQJY=;
 b=ggRD6RHlhu1DvfPR97xvrYJr//PQIlJaJ+0mBfswGsqVkKuAyB3nStBWVcsuzhZohe
 JftXfqqXvBPttVXVjbAbJVLeEcIlViDsU55Czva3SnlkkOIrda9RylyvXb32p3DauLpX
 BQ39vaqBcafYrNhiaW3ppPuJkIwJbIOW1q40bGviOhZ/wqiexOzEbW93Hp9slnpratY7
 Q/Pr24wz25tvoAGI2Lc2ZFFEs6LUhW8MjX1JXKb4V4t7xkxN2XNxhMWsw4dNYTB1zBc6
 D8nYhUNS8NOkQE9Yyi2TTuOUfDtWKN7M9saO3ho7XocsvxygAzaUCCOIdpP9g+KkoMxG
 tOFw==
X-Gm-Message-State: AFuF++li98BkERq8/lyY+S3p/sqATZI2xmXkrcJHYB527Ewi/2q3G0PT
 ioAegM959MXB6JYHsgQEhlfPQeRB9WtVUNnPUjQnj6kH1DNMSfZADVxFUdHlSEpRghjahrtYkXY
 cIJbErI0BnuDivit6Xuv61eU3H+6iLXkqRIt5o4aByXtgoKdg4EI0fN0uP6UVK52+JiIAchf9nK
 Xp39yKU9d2dqTU1RkdMQPyFTHB89JxB9fvKulJ5Psd/JRtTQF5dedBjsuwhoYybYGFyBa0UNGQy
 iYMcl0/XNxE
X-Gm-Gg: AYBFou3kSadKbyEr655bKft9KAY9Px4P3Y/BrBFcAHCWVWSmbJESIsA28uAOMVb+H77
 6ZWPK3unEsMKRROF9j/NYNe0XxzhnLql5EjMfWtuG/T3LzMjrSFMyBO6obMTthdL/NwL5Fv0W8m
 alFW+hPMlZeIBJsx0U6kU4uYYYjejYqkYqqVQcpLmiTZVm2PBX2JTFdOpr1K9/3RvmZpARfiQvX
 9zGNuUSR5C1MUHe9jjR8Ts+HVu71OOtq2VKinoYwSNc3csEMdVLHgSUn9wVLfhStUsUrCDa7Y8C
 I5zxQH9mnxLb470763d8bAse2jY6O2MrcPwxLE5O1f2Bg00Qv8L+ugw7zWwuHRIVpucgHGtJWSp
 1cblGEYFQxWxuha278wdxm1K1aIAuxfTi7uV1KC4oQeBfGfnr2NBtjB79AdB7l6tdz5K8LlF/c6
 BOfYfMbuO9WXU9ixbEUF9TPh36HCNWhmlNJeR5pzxTjVIzIm7YRfnM
X-Received: by 2002:a05:6122:2882:b0:5c7:f1ba:aa12 with SMTP id
 71dfb90a1353d-5c9b58d89bcmr3174071e0c.4.1789956917674; 
 Sun, 20 Sep 2026 19:15:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c9c18cbdd5sm1990799e0c.6.2026.09.20.19.15.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:15:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e18af9f48so3860796a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789956916; x=1790561716; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEfDZoES2qgVNa+VF9AdJH+uzSZww/K0CHFA29/IQJY=;
 b=MqxyFI+7GNXmmWEcp4Y/fec+QmhYUt3tiudpVU2DueJmG2c+Ejes43iHcG+YkJo4Oz
 VDVercZqVJE/Q6iHzL5rmEPwRkR5H6UUJU0s0iXjRZKEPJLiVp0cST4dsJP2N2qCbRvW
 VasarezmuHzOq7V4IrP7gQBLAxJk1zFWJ2Z/A=
X-Received: by 2002:a17:90b:1e0c:b0:39d:fd21:75cf with SMTP id
 98e67ed59e1d1-39e3615cb5amr17438831a91.26.1789956916050; 
 Sun, 20 Sep 2026 19:15:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1e0c:b0:39d:fd21:75cf with SMTP id
 98e67ed59e1d1-39e3615cb5amr17438804a91.26.1789956915425; 
 Sun, 20 Sep 2026 19:15:15 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d54af4d5sm15799400c88.2.2026.09.20.19.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:15:15 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org, Dakota Sicher <dakota.sicher@broadcom.com>
Subject: [PATCH v2] net/bnxt: fix flow create segfault
Date: Sun, 20 Sep 2026 20:18:17 -0600
Message-ID: <20260921021817.1033783-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032701.763364-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032701.763364-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

When creating a flow that requires a destination queue but none is
specified in the flow create command, find_matching_vnic() returns
NULL and the code falls through to insert the new filter into
vnic->filter, dereferencing the NULL vnic and causing a segfault.

Check for a NULL vnic and reject the flow create with a clear error
instead of crashing.

Fixes: 59119d49529e ("net/bnxt: fix flow create when RSS is disabled")
Cc: stable@dpdk.org

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* Changed the new NULL check from "if (!vnic)" to "if (vnic == NULL)"
  to match this file's established convention for pointer NULL checks
  (e.g. the existing "if (vnic == NULL)" a few hundred lines above).
* Kept RTE_FLOW_ERROR_TYPE_HANDLE rather than RTE_FLOW_ERROR_TYPE_ACTION
  as one reviewer suggested: every other rte_flow_error_set() call in
  this same function (bnxt_flow_create()) uses
  RTE_FLOW_ERROR_TYPE_HANDLE regardless of the underlying cause, so
  switching just this one would be inconsistent with its neighbors.
* Real bug found during v2 review: the new branch didn't reset "ret"
  before "goto free_filter". If bnxt_match_filter() had already set
  update_flow (ret == -EXDEV) and the filter is a plain L2 filter, the
  stale -EXDEV survived to the free_flow label and reported the
  misleading "pattern exists, updating destination queue" success-like
  error instead of the real failure. Now sets ret = -EINVAL on this
  path, same as every other error branch in this function.

 drivers/net/bnxt/bnxt_flow.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..0a2899fbbd 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -2148,6 +2148,14 @@ bnxt_flow_create(struct rte_eth_dev *dev,
 	}

 	vnic = find_matching_vnic(bp, filter);
+	if (vnic == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Missing destination action for flow.");
+		bnxt_clear_one_vnic_filter(bp, filter);
+		ret = -EINVAL;
+		goto free_filter;
+	}
 done:
 	if (!ret || update_flow) {
 		flow->filter = filter;
-- 
2.47.3

