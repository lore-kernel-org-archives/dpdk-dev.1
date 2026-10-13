Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B823CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F398E40609;
	Tue, 13 Oct 2026 19:15:59 +0200 (CEST)
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com
 [209.85.128.225])
 by mails.dpdk.org (Postfix) with ESMTP id 2435D40279
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:15:57 +0200 (CEST)
Received: by mail-yw1-f225.google.com with SMTP id
 00721157ae682-8ac9d666d4eso1422297b3.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911756; x=1792516556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=maHV40IKsKKKtMplkiyjUmtH9Pdt+RLjIOTdKKQtl5g=;
 b=AgMRa18TQ7vCqGXoApKXhNm4BxKJgC5SNHQK3/kLg0cYhDlWnbsHYnNJjsrIc9uDaZ
 6nQ9YXKjLGTR1xnqV0+hElCy/1mueGDTyC0dkBF3Y0iJ+VTHk1XT0PsK3KCiRS3SLYf3
 Wc9wBXQLsU85B9jVAr629HPw2gw0mu9Sb+L73zA66umtQSPa3M0rkvD9ZO95hr37NbX4
 UrFQrAA0B6wZz3eMbWOwIgBi9EGNEjmpqjeKbS3pYVF2rUS7/CnKr4PkRskgwgSxIGQ3
 /3BR/SssVNVn3bk2vQLdxHjk4IO3LUrMYnU3UnZ6l/zdB3gshEme+P6H1GLjgPFA2/hn
 sGjg==
X-Gm-Message-State: AFq9FYIPrX67jDUzMWhshtEZ9vpRguZt7Ss+u1iGLmGQDXlwS8QyF2Gm
 bDN5kEiHBGuthymjgi1UNq+rh6han4PT9SBAYjcdlrtsPLV8bcoTpwGvF9Iobp9S8WL0yayBBX1
 gjSDRRRGSD5Pf4a58GW2cztKk3+AZ3ZyvLhBaKIm9xTorv5aIBpJOHpvRuoogj7VmJfa4C6GAX8
 PPqPgRsnK/xhs3QEpFo727NiTZEXGaCiMoHkHAyRdJeJ+9vwIte6tnKd66RMIp9OxgLw1uluOAR
 7UJBDjjQGcC
X-Gm-Gg: AYBFou3cC92oij9Yh13IksrDkC+Q+IlJE6EXIOk8rZssL+Gf+sHiEq6hIGTtRA8BYfz
 G6VpzZa2xZ1/+sCpMFLRr64x+1vgInep516HwHj7U5glR8voA6sY47VA32UGtc32kgSdmQmVYNF
 3/5ZcR4zqYH0nmNHcaJiTSmSEBnQ0JPifNVdyjnU5U9KMCpGzU4dD8Boj5/X0rnl8ln/K89FabM
 7/qNiANbz5rfVBL7x6ztYbeRh25WbDkZktit1MG0qV/JRb2Kk1taxCNgYx+BAq/P5E16G3ASZ7G
 sBu69zhE39xc4It8R1HC/6dPrF5cMwfWYCvxMpRndUkySI8oFP/Civ49o/jVUnAyD5tzVKDY+Nt
 JNu2ITZAe9Wa4ObmkvCKdmevczQRX0AQMUaRHrdstfEQLBNEj6/57lpprJb+XO9zoIPLfvXAydW
 jGTnKtvVgfwudZMldf+MdLY9bXVPmHoF6b4/DhF6CADgYUgDdXfBOU
X-Received: by 2002:a05:690c:18:b0:8b0:8e9a:a4d4 with SMTP id
 00721157ae682-8b08e9aa983mr35064417b3.6.1791911756242; 
 Tue, 13 Oct 2026 10:15:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-67986ab3531sm13928d50.48.2026.10.13.10.15.56
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:15:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5338cfe567eso68152911cf.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911755; x=1792516555; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=maHV40IKsKKKtMplkiyjUmtH9Pdt+RLjIOTdKKQtl5g=;
 b=TrYbebFIsXiNEEPk2J48zbkj8gzKZ7tpXhka/x6HXqwILGIS8NNGx5I7d7HyBsMAmc
 E4xyO9PszLOtLaQ5XiJPgMnLh4GFlpTkMSxA1rWfArkk+sPMTN9KlTFDB+4oIYI7ySoF
 rCqI4QIwYZ8WfXM/N8zUvOmtChg/E5Ft/HbLA=
X-Received: by 2002:a05:622a:511:b0:533:3ec8:a834 with SMTP id
 d75a77b69052e-5359fb3dce3mr224433721cf.40.1791911755600; 
 Tue, 13 Oct 2026 10:15:55 -0700 (PDT)
X-Received: by 2002:a05:622a:511:b0:533:3ec8:a834 with SMTP id
 d75a77b69052e-5359fb3dce3mr224433171cf.40.1791911755065; 
 Tue, 13 Oct 2026 10:15:55 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b6fa173sm106035531cf.7.2026.10.13.10.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:15:54 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: validate direction index in tpm tbl
Date: Tue, 13 Oct 2026 11:19:38 -0600
Message-ID: <20261013171938.452350-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005202539.18133-1-manish.kurup@broadcom.com>
References: <20261005202539.18133-1-manish.kurup@broadcom.com>
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

Validate the direction in cfa_tim_tpm_inst_set() and
cfa_tim_tpm_inst_get() so that a direction taken from a VF2PF
message cannot index past the table scope instance manager's TPM
table. The tsid and region inputs were already range checked.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
 - Reword the commit message to describe the change: the direction argument of cfa_tim_tpm_inst_set() and cfa_tim_tpm_inst_get() is validated
 - No code change

 drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c b/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c
index 72302ac73be..6abed2ed2ca 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/tim/cfa_tim.c
@@ -83,6 +83,11 @@ int cfa_tim_tpm_inst_set(void *tim, uint8_t tsid, uint8_t region_id,
 		return -EINVAL;
 	}
 
+	if (dir < 0 || dir >= CFA_DIR_MAX) {
+		CFA_LOG_ERR("dir = %d\n", dir);
+		return -EINVAL;
+	}
+
 	if (!(CFA_CHECK_UPPER_BOUNDS(tsid, ctx->max_tsid - 1) &&
 	      CFA_CHECK_UPPER_BOUNDS(region_id, ctx->max_regions - 1))) {
 		CFA_LOG_ERR("tsid = %d, region_id = %d\n", tsid, region_id);
@@ -105,6 +110,11 @@ int cfa_tim_tpm_inst_get(void *tim, uint8_t tsid, uint8_t region_id,
 		return -EINVAL;
 	}
 
+	if (dir < 0 || dir >= CFA_DIR_MAX) {
+		CFA_LOG_ERR("dir = %d\n", dir);
+		return -EINVAL;
+	}
+
 	if (!(CFA_CHECK_UPPER_BOUNDS(tsid, ctx->max_tsid - 1) &&
 	      CFA_CHECK_UPPER_BOUNDS(region_id, ctx->max_regions - 1))) {
 		CFA_LOG_ERR("tsid = %d, region_id = %d\n", tsid, region_id);
-- 
2.47.3

