Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E0CFEC0FC
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 20:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E464042C;
	Tue, 24 Mar 2026 21:46:47 +0100 (CET)
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98]) by mails.dpdk.org (Postfix) with ESMTP id 43D32402CC
 for <dev@dpdk.org>; Tue, 24 Mar 2026 21:46:46 +0100 (CET)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-94ac8cbf3feso883986241.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774385205; x=1774990005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FLO5VyYzZCArVVO+nZbddNE5wrXUmVJskO0W+gGiFEo=;
 b=HNEiuH0wJwRtqhWYMY7OXFCZs41sSugzNiMwRAjXIhYA3RXP9RO9m3dF64fdir4EUR
 J/HMbsNFMYA8FZrTdIbZzg0mSZ0ogy9ptftucDEeFSnnLPjJAXAy8Eo1xMOBaQDHL7nn
 gLGkzfkOuAd+tgP3DolVplLwfb1JDJWCLiIN2BUmSU2Q2+4HZrQ9lDXug1JHW5v84gdk
 Dm5kLWAcBBB3avE5GVQ0biEbyDgfuls9nLV0R9AKV87eEfYaykBMzda801YDSea8BZH4
 KQ8FoNZBsLKL7fE+nyVJOct+K3uqBayp83qhkRs19tc7lcgm0yjP9WuH0rz41ohYsZmu
 sUNg==
X-Gm-Message-State: AOJu0YyL/cC/G6y+zDKu2gPuHCjrZM/Dfnyt8aN4VbLdN5hI9Bx6Fnd2
 5nxu6mHqCl8k1HZnetiigfhF+tt1Mdfit5B3WdbEs8H1HiHsk/a9/2Tr09T1Sel4Y0xBdYrg7By
 uVag3Hk5sw/EeV/+YX/TJUMotBknh8sOXzHSU6xL5+e3q5mDMhYTNB3W2ZGCMFHHlbF49wNmKDP
 9uE5Gu8QdbjqBxrXHGUGds2nFSMMOVBzmSKvgLeOucQpar+6+5O39ieox3ZBlBsOea9VGPB81ZS
 3pa1+qwWu/G
X-Gm-Gg: ATEYQzwd1C7B/SYtROdjRKNBSZ5DyhCViWJu4ZWMZF3sxqmDBniR0P4tLUU3sMsm13L
 F1i+43vNTuxa+qODMFefwWnrDKgZJfPBhk8lW3R4PUoJCMEqmb1zeMfQ/lr/RVhQCy7hx4H1R0Z
 DiKQOgBn2ur2lzEuBGaVUgIxxUVRxiIrwXLryjwd0F4m8fVFGss1BX8Z8xoAs0z9vSYzN1NONxu
 soERK0MAW4TGQEscav6P735QvrK/vFE4x8Hrpe3ViMvHeM4QslujltHTxpv8OCMK9pDXY8OM+nN
 PX/osIKzvCsy7S8+vmXArsdjwfbPgH+kICW+N7OmtrtldCm7zZbhDmiuNcePpApxdEw4ZneKg5v
 UfYNCHFS9tWGQxIlDOLd2gacvd76IkokliYhSSD+6Zc1kY0svyVIiYccEGK+HFiNNxcWT34Qv1w
 5/ZxBLW5l/XwaYlmykAc8TtP5iijRUY39z9cTWZrZheKZThv3JPI0QsS92G2wzXs66DnF0ksVtm
 w==
X-Received: by 2002:a05:6102:6b02:b0:5ff:e58d:4dd8 with SMTP id
 ada2fe7eead31-603949e0868mr611491137.37.1774385205330; 
 Tue, 24 Mar 2026 13:46:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6032c6d406csm140572137.2.2026.03.24.13.46.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Mar 2026 13:46:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5094ba09affso104278861cf.2
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1774385204; x=1774990004; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FLO5VyYzZCArVVO+nZbddNE5wrXUmVJskO0W+gGiFEo=;
 b=OHum3cSmJUm2CrMarezCmkvCgyZ/BUk6DBj2IKVyvmkGxt7w74oVujFFMWoJ/uTxFW
 bTV3vm5TOVKbcmyaUgpxeBnvYf1sK+0YFjmZfzWJIUf6I7WzoTsTPZYyRAIoH1kKT9i5
 p0offcKpk5XV07F4atkedtmBY4LD6BsRYXVA0=
X-Received: by 2002:a05:620a:2684:b0:8c7:f61:fd7b with SMTP id
 af79cd13be357-8d001039302mr133667085a.57.1774385204385; 
 Tue, 24 Mar 2026 13:46:44 -0700 (PDT)
X-Received: by 2002:a05:620a:2684:b0:8c7:f61:fd7b with SMTP id
 af79cd13be357-8d001039302mr133662885a.57.1774385203730; 
 Tue, 24 Mar 2026 13:46:43 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cfc90e776dsm1314032585a.47.2026.03.24.13.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 13:46:43 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix l2_db_multi_page_size_kb position in func_qcfg
 output
Date: Tue, 24 Mar 2026 14:48:06 -0600
Message-ID: <20260324204815.54465-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

The field was placed at incorrect offset in hwrm_func_qcfg_output causing
legacy_l2_db_size_kb to read svif_info instead, producing a doorbell offset
exceeding BAR2 and resulting in SIGSEGV on BCM57608.

Move l2_db_multi_page_size_kb after mirror_vnic_id to match firmware
response layout.

Fixes: 04102f2ffc8c ("net/bnxt: update HWRM API to version 1.10.1.6")
Fixes: 7a1f9c782b50 ("net/bnxt: add multi-doorbell support")

Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/hsi_struct_def_dpdk.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index 26d5e9ca78..1a8874f5b6 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -16277,12 +16277,6 @@ struct __rte_packed_begin hwrm_func_qcfg_output {
 	 * of the doorbell BAR between L2 and RoCE is required.
 	 */
 	uint16_t	l2_doorbell_bar_size_kb;
-	/*
-	 * The size of the doorbell BAR in KBytes reserved for multi-L2
-	 * doorbell pages. This area is a subset of l2_doorbell_bar_size_kb,
-	 * which is size of the total doorbell BAR space reserved for L2.
-	 */
-	uint16_t	l2_db_multi_page_size_kb;
 	/*
 	 * A bitmask indicating the active endpoints. Each bit represents a
 	 * specific endpoint, with bit 0 indicating EP 0 and bit 3 indicating
@@ -16605,6 +16599,12 @@ struct __rte_packed_begin hwrm_func_qcfg_output {
 	 * or a raw QP.
 	 */
 	uint16_t	mirror_vnic_id;
+	/*
+	 * The size of the doorbell BAR in KBytes reserved for multi-L2
+	 * doorbell pages. This area is a subset of l2_doorbell_bar_size_kb,
+	 * which is size of the total doorbell BAR space reserved for L2.
+	 */
+	uint16_t	l2_db_multi_page_size_kb;
 	uint8_t	unused_7[7];
 	/*
 	 * This field is used in Output records to indicate that the output
-- 
2.47.3

