Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F01ACAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:06:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1187740DCF;
	Tue, 30 Sep 2025 09:05:41 +0200 (CEST)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id B381F402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:36:48 +0200 (CEST)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-27eed7bdfeeso50767715ad.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192608; x=1759797408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1Uh7Wae7TW/Ddusw58PcgcACvrtXsq249YyK8rEe30=;
 b=AtvaOdjN+5GKUIW4Th/mY75OXdS4t8PEc10VmFJILx8GRbVMgsaS4hC1BiDDTal+BP
 TOJpnedFWybT71+TqYyC9ngEBydw/VVUL0NDAcxKBFbFOY7dXcDlycnzRhI5heoEsXhq
 2gb5tyB1gPwTJw7DGuUyfLpa9PnH2asf9sHHEx1+mI92NduCgvqgghUiUtyaqM/N784A
 Oe7GZ6/WcTWIjO3JK1TS93KAdKYbgVevKkNDtnOutwvYLVJ/62fq9uVRxnFx97bCK4Re
 r1kUjtu7FMDRC3/q2b2oDToYZ90zxyEroNa4+Ok9ABkzhVodKM/BHfO1lL+RFp/mhC11
 T7Kg==
X-Gm-Message-State: AOJu0YxRwkTOO6fesBhGJfYKvLS0ko9RagB1OJpwpQOywEIq4eJlApfY
 C1AIOapoJXiv5mnKevi7wAjnBnMyu9bqGNt39jBtHtoKdXgURYoBaRfXsRsLz1fWQmHnDq1m+NV
 2THcRPFJ5RGFdYViYGaPIvDliZsC7+HihlFOb3XHfOl1fRhsbDBXikwtqLeqO4W9f0ppxIv0GT5
 AX1Ia95xdvMU2e2i0d1JuIhwoA9kD7P0EEFsLldVlTc5Y/EF5lc2oxHK8vRwArB4tk5/WTXA==
X-Gm-Gg: ASbGnctSr/Wnrfyz6LfJN5C2XxcUOoHdyWLjVPnp49n5AFWcoz2KrXINcOZWN/ePnBh
 R1bGPMftVZ7UqiN+YBYhNAv0yRD/AGkNkLY4ri+hJb2g5pWKAs0wI81PeGRiBsM1mEpT1IRgww2
 NB/LcBz0omm/Va1lfLo7BEOvuet15jH7zfIQq1MAlButJGI3yzf+VyZgWNiJ1Hl1QAO2ZV8NGmp
 OHz+Hbe4y1Dfm+R3whz/ugBYQEDO40rEhBErmTuuaXHsuoudxI+eiCCiMmV8JOZYGk0tzRChMOE
 soh2jyAcXiRJVfnKbv9fO5gcmT9p6Dkns7rqwsnjrslF3Z3dBVfYmN5f/N3n9AOPfbFqtC/pAvG
 jENbZ9ZfAOgoMIWxRsRwB9NgEasLeC6qPCTgs8JLMVHG91evZmGyOq2gaQMmSGZu85tB74LUgCm
 kisn4MQZE=
X-Google-Smtp-Source: AGHT+IEgtVZktDuHrOEOI5WgEUPpGNGOGCLBD/FMaLkOWAGb6KJkaWoaXfFmNOaOB/B+HR+a1PLK83yBlNbP
X-Received: by 2002:a17:902:d54c:b0:25b:e5a2:fb29 with SMTP id
 d9443c01a7336-28d171384e8mr27210695ad.12.1759192607888; 
 Mon, 29 Sep 2025 17:36:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed67e6639sm10259235ad.34.2025.09.29.17.36.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:36:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b5b3715102fso1512575a12.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192606; x=1759797406; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1Uh7Wae7TW/Ddusw58PcgcACvrtXsq249YyK8rEe30=;
 b=B1VKHaCSPIVq8blURoQG7D2PlsVfemsKl2if2/B5JX1wc0Mkg4Qrkx3hwgtjzSe+/w
 kvgS1rCrigmqVCzYQEfyuKqAPsV01Jabx6kFQ8DVZT9NejO+TJZmHimpNkuVwPzTXJuR
 GIhFm4UdzV3pMUhmQJnwS49afVFb9qQ/XzidE=
X-Received: by 2002:a05:6a20:9f8c:b0:25b:b4d0:1090 with SMTP id
 adf61e73a8af0-3176e51d174mr3590680637.17.1759192605665; 
 Mon, 29 Sep 2025 17:36:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f8c:b0:25b:b4d0:1090 with SMTP id
 adf61e73a8af0-3176e51d174mr3590641637.17.1759192604989; 
 Mon, 29 Sep 2025 17:36:44 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.36.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:36:44 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Smitha Pisupati <smitha.pisupati@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 12/54] net/bnxt/tf_ulp: add support for special vxlan
Date: Mon, 29 Sep 2025 20:35:22 -0400
Message-Id: <20250930003604.87108-13-manish.kurup@broadcom.com>
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

From: Smitha Pisupati <smitha.pisupati@broadcom.com>

Some special vxlan packets have extra padding bytes between
the vxlan header and inner eth header. Thor2 is required to
forward those packets as is, and not drop them.

To make this possible, following changes were made:
1. Don't check on the l2 header type in the default template
2. Based on a feature bit called special_vxlan, enable the support
to pass the special packets. With feature bits disabled, normal vxlan
should still pass.

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index c8b6f544ca..08934eac3f 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1069,7 +1069,6 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 #else
 	uint64_t bit = 0;
 #endif
-
 	*out_bits = 0;
 	if ((feat_bits | bit) != feat_bits) {
 		BNXT_DRV_DBG(ERR, "Invalid TF feature bit is set %" PRIu64 "\n",
@@ -1090,6 +1089,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Multi Tunnel Flow Feature is enabled\n");
 	if (bit & BNXT_ULP_FEATURE_BIT_MULTI_INSTANCE)
 		BNXT_DRV_DBG(ERR, "Multi Instance Feature is enabled\n");
+	if (bit & BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN)
+		BNXT_DRV_DBG(ERR, "Special VXLAN Feature is enabled\n");
+
 
 	*out_bits =  bit;
 	return 0;
-- 
2.39.5 (Apple Git-154)

