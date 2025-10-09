Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125EECCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:19:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D70D40DD1;
	Fri, 10 Oct 2025 00:16:50 +0200 (CEST)
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com
 [209.85.161.99]) by mails.dpdk.org (Postfix) with ESMTP id DBE2740649
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:49 +0200 (CEST)
Received: by mail-oo1-f99.google.com with SMTP id
 006d021491bc7-64a760e5281so471580eaf.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048209; x=1760653009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=Ss/HMiPfnQEciF1wCfNrdRC++E7p5Giz+i0o0RN5ijnQW6SBNHwRAVBfh92ZNuDKRv
 OSblV+xOI0eYouP662Aaj7Ho97Jww1hBUmOdfXLqD2886fe6iJEG4eVBzstOuVFGx1AZ
 qBXuY+Douo3OuIW5DhympDRlRyHK+QkjHP2SdX2CJp/7NQZsRQ7QJTGNUcTM1acwwid0
 c27aXBX8maSluP+q7rkR3nN0Z9FweH9yrXMiGm12RlOYv4Il+JLRs7nAHB2aWMVFvRLE
 5dFmeMK9//C8ZZh9St+9lCc4v7a7Miruk5GTh5FFP2qNpGJa1W9NKBtsrkiWh+xwRVMD
 /ghg==
X-Gm-Message-State: AOJu0YzAq9C7apJ8Q9t8TrMeYJQrWa7lcnOMFukG5VSP41DwK8AcgEpe
 doo+Yno4AHNguEZZc2JdMUw9HNExT28x1OSiCTQgJMW9ZUNNZfrPVwDwxgNSGA47vR96mJC8AK3
 DI9pHLjVm3Ck3y9/jqZYXZeodKy1G3hu3uTJuEfpjPH/iv4RcFM6TdOua83FVwczbEFZKfAuhOY
 eSImY0JUy/HE6+UFRIMxOqvs/e3aH/nTfRENMtgQiPxiLuuL4RYzSlWemSBHAiH5AHg+8gZw==
X-Gm-Gg: ASbGncvW4rbhCuoSBzNGyXuW+528PlVzLfog4uvEYSEH6naJbmvyaJZZr6OT938rT+k
 biij0obnhjKc2WRBUtO9gwLtFcztBrDh0mqpXQYFrwhexITslTX9UKfI8yFUa7FAiC98pWzkQ1X
 zJ2Ib1Bw8n3PA0cLAUmRTamNpiCCPg/XGpDOiXqR6mE6t1KRB66w+aGvvL471SPTMPFwRuxZTrL
 M99VYF29q+2k0z/084xNBjwybh/Wsgb7tMFVxBVlN1lhENNh7PrfG2QatwOkpWX6IDq9+qIPHLI
 AW5bC56QZxKzd7eTlvwLVOgnx3IQv/JuinoYzR5m0oN3P2lFMH/h259xtosaL32cqQQL7x5ka5y
 To6Ia4TkXz2fPAIhZAEHobQI3Zq1NwBiXUizUHReLtZO5n9+LoGHYrgEO87GsuIoDuN8zLHffGD
 aM1MeDGQE=
X-Google-Smtp-Source: AGHT+IHONr0VMv+RTq4Rd73Q5UumnBaTBFfTZJiMB9y/RbLSU4r4nzXgY14oo/YUvI3SyYjJegVgPjGwLLRw
X-Received: by 2002:a05:6820:2916:b0:650:1435:eb57 with SMTP id
 006d021491bc7-6501435ec8bmr1338277eaf.3.1760048208974; 
 Thu, 09 Oct 2025 15:16:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7c0f90b2b4esm53075a34.4.2025.10.09.15.16.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78eb8a9d229so42252336d6.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048206; x=1760653006; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00gnMT/+o3K5TobN2N8K1Xw2sPt5jaafikUUsU/uFsk=;
 b=bY9VY1sGn9CM53q2Wu8g1V2hygHXuh2iHibdHH2Vtdlgnq356c6gqfAfX6+iuPU/G1
 /qG1fakyA8PeWWijiGV/8ThMTD4ZF3gorsxmXHV2RjQvrug56+84fI9kDdB+6PIBmQpM
 XtdZe/D0kSVKuZ7KSDhK4A+8pMdv08l6P0VFA=
X-Received: by 2002:ad4:5d41:0:b0:78e:271a:cc86 with SMTP id
 6a1803df08f44-87b2ef6ca9dmr134888146d6.31.1760048206469; 
 Thu, 09 Oct 2025 15:16:46 -0700 (PDT)
X-Received: by 2002:ad4:5d41:0:b0:78e:271a:cc86 with SMTP id
 6a1803df08f44-87b2ef6ca9dmr134887686d6.31.1760048205849; 
 Thu, 09 Oct 2025 15:16:45 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:45 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v2 50/54] net/bnxt/tf_core: fix truflow PF init failure on
 sriov disabled
Date: Thu,  9 Oct 2025 18:11:25 -0400
Message-Id: <20251009221129.28256-51-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

When sriov is disabled and running DPDK on PFs fix invalid max VF
check during table scope creation.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 878f62c115..c06099af12 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -1210,7 +1210,8 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 				return rc;
 
 			if (fid > max_vf) {
-				PMD_DRV_LOG_LINE(ERR, "fid out of range %d", fid);
+				PMD_DRV_LOG_LINE(ERR, "%s fid out of range %d",
+						 __func__, fid);
 				return -EINVAL;
 			}
 
@@ -1419,16 +1420,7 @@ int tfc_tbl_scope_mem_free(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 	}
 	if (scope_type != CFA_SCOPE_TYPE_NON_SHARED && is_pf) {
 		uint16_t pool_cnt;
-		uint16_t max_vf;
 
-		rc = tfc_bp_vf_max(tfcp, &max_vf);
-		if (rc)
-			return rc;
-
-		if (fid > max_vf) {
-			PMD_DRV_LOG_LINE(ERR, "invalid fid 0x%x", fid);
-			return -EINVAL;
-		}
 		rc = tbl_scope_tpm_fid_rem(tfcp, fid, tsid, &pool_cnt);
 		if (rc) {
 			PMD_DRV_LOG_LINE(ERR, "error getting tsid(%d) pools status %s",
-- 
2.39.5 (Apple Git-154)

