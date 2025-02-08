Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF8AC02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE96240695;
	Sat,  8 Feb 2025 21:32:17 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 922B24066D
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:14 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so4822063a91.0
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046734;
 x=1739651534; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCJPFILj3Md5HFtnzDLz1Y0XfpqaLYgctdooy5SB3ek=;
 b=R06Oi2Mq0vKsxY0lmw9pelNtHz6rNRni48DBgM07o+YEnLg4r9z18NCGnqG4vDYxLK
 m/MS+C1uGdEGYyiW++cstJWL3U2RJe/67yk+/2hHOapuL35ZDLnFys8eV6J3dPTLUpUe
 NTwoM8ZYuB850S81dO8+iDByVO5Xmi8GoEFGeZtGsq3z5qrArBGfLqjJH/wDE8wWi+6+
 PS9LRAHnCfUtrI+PDxpZQtHD9bdmqFSfVJBvIWMVLUjzs55peZ7LilxtzADATVKs0iow
 EA7N2J7OUY4V4X/ZKSkpc0H3zfmsM3i8s1deYqXvcz1775X2KXNG9IP1GJfgpxNq0Bk+
 nHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046734; x=1739651534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCJPFILj3Md5HFtnzDLz1Y0XfpqaLYgctdooy5SB3ek=;
 b=CkM1H47qm1TvC/NHrSa82vstwWwnMZHKV3IIb5/dtqa+AXuZuJ50GQo2WgixTWPCOl
 Va41DYWEsaD5xlu5U4UX9OHF5iFqMhfP6yFSkSlPJRhAyjbx3ocezx6at94Gqim6riBK
 8fSD+2xKp1HKz79WKYV1+olE04VmZRUFZhKVo3n3SUihRf/D1p55Bn4OiVWsePUyQfBj
 R1m2/DRMn/dYl02bCDjP11mLsHZBuP0aZvawOY8KFoC0CX92cEAEKmoWJnMov2RdPt8g
 iolQ6u/8oW/BNG7ltvJTfxBqXcBjKB6c9hNWFxJYUh5Ur6ExX7w35fPwSetO2/37WoO+
 E3qA==
X-Gm-Message-State: AOJu0YxciZTxcKGQnpsn3FSw/fa8wqaUjssNppzBYRbty78k6n6VQ1v1
 ki+OLIhoKyzAVmYj61ZDCf3W+mI3sKkBA8zxu6rFCWtXZFNjgxOSRtpBlCgtK9lWygD32iuYJF1
 qfoo=
X-Gm-Gg: ASbGnctmBaIGwSU+1OV9JeSH+WbAz9Bpx08aIyCL69k4gSQfHm3xmp5oN5YhRIIHwab
 YsFMmfReKEmdCKUP6FceIn7PTJefgLNrRsb4iGC9W4ffC65H2vJOZBvtcCM1lK+uprFBMV4UO2w
 rOzQQ69vSIzjOiXcwYmopQ/VFZilDP5IY6kt3FyuGu5IwziptGZPrYEpz7k6IwAe6rBN8am9u6S
 vbHH4f7gVH334EGRYbBEOrCjDVaqVcE6LSMeYlrjnw++YEjedq188w5f5R8SOcMeIE9vu26cR0E
 tI2mzgHY/sxc/eHLhvm+Xmmq9+nbMzefp19/olwhXauA9wJp1wIcq5fIonLbtYhiw0OT
X-Google-Smtp-Source: AGHT+IFLu9YMjsSFAOohDmrzdE2ZWzD1hkacGP7WMthzW8/kJB3KN6IKE+cTtk1Dbvyh9KpqvICxmw==
X-Received: by 2002:a05:6a00:3488:b0:725:b347:c3cc with SMTP id
 d2e1a72fcca58-7305d529a92mr13443106b3a.23.1739046733784; 
 Sat, 08 Feb 2025 12:32:13 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH 16/32] net/bnxt: replace memcpy with structure assignment
Date: Sat,  8 Feb 2025 12:22:08 -0800
Message-ID: <20250208203142.242284-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by struct-assign.cocci.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/bnxt_hwrm.c      | 3 +--
 drivers/net/bnxt/tf_core/tf_rm.c  | 8 ++------
 drivers/net/bnxt/tf_ulp/ulp_tun.c | 3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index d015ba2b9c..b2f73207ae 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -3266,8 +3266,7 @@ int bnxt_hwrm_func_qstats(struct bnxt *bp, uint16_t fid,
 
 	HWRM_CHECK_RESULT();
 	if (func_qstats)
-		memcpy(func_qstats, resp,
-		       sizeof(struct hwrm_func_qstats_output));
+		*func_qstats = *resp;
 
 	if (!stats)
 		goto exit;
diff --git a/drivers/net/bnxt/tf_core/tf_rm.c b/drivers/net/bnxt/tf_core/tf_rm.c
index e9a2fbd851..18f46c0a0a 100644
--- a/drivers/net/bnxt/tf_core/tf_rm.c
+++ b/drivers/net/bnxt/tf_core/tf_rm.c
@@ -1265,9 +1265,7 @@ tf_rm_get_info(struct tf_rm_get_alloc_info_parms *parms)
 	if (cfg_type == TF_RM_ELEM_CFG_NULL)
 		return -ENOTSUP;
 
-	memcpy(parms->info,
-	       &rm_db->db[parms->subtype].alloc,
-	       sizeof(struct tf_rm_alloc_info));
+	*parms->info = rm_db->db[parms->subtype].alloc;
 
 	return 0;
 }
@@ -1299,9 +1297,7 @@ tf_rm_get_all_info(struct tf_rm_get_alloc_info_parms *parms, int size)
 			continue;
 		}
 
-		memcpy(info,
-		       &rm_db->db[i].alloc,
-		       sizeof(struct tf_rm_alloc_info));
+		*info = rm_db->db[i].alloc;
 		info++;
 	}
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_tun.c b/drivers/net/bnxt/tf_ulp/ulp_tun.c
index 7ebe81c4ea..b90b4bf252 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_tun.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_tun.c
@@ -40,8 +40,7 @@ ulp_app_tun_search_entry(struct bnxt_ulp_context *ulp_ctx,
 	}
 	if (free_entry >= 0) {
 		*tun_entry =  &tun_ent_list[free_entry];
-		memcpy(&tun_ent_list[free_entry].app_tunnel, app_tunnel,
-		       sizeof(struct rte_flow_tunnel));
+		tun_ent_list[free_entry].app_tunnel = *app_tunnel;
 		tun_ent_list[free_entry].ref_cnt = 1;
 		rc = 1;
 	} else {
-- 
2.47.2

