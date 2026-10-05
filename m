Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55CFCA5FF5
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 23:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0409F40A81;
	Tue,  6 Oct 2026 01:50:52 +0200 (CEST)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3E9A8406BA
 for <dev@dpdk.org>; Tue,  6 Oct 2026 01:50:51 +0200 (CEST)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-677dbe051d4so1651814d50.0
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791244250; x=1791849050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CJf9mHxSnKoK61xmV1U9WJyB6mH/Ct8lOUVm3EtzS00=;
 b=dQuuC3DI6VpnIJBwFwXAJ6dYZUPA9QAQZTDs/t8B5ZSsUW5Yf2lhJqC7iAqujmmpOh
 UQC9xLzLingBjFJ0MAgbB+qfjVA/ehiv0zPqXB6ejdVk9VvN4/GCVZ6i+g1+cOYrLqRd
 1tGW0rWVRQZ26Xk0ROCvJNPf8MfYTTZxvywuRXhlrzEwB6H0y0TYEVMcCTxBiSm6eIDC
 qtBVbbDNBaI64jwN77w24b1kzHaiLjTzFBuPGU3dN4WCOfzqVmS1KbVPsmaMIJKzf6NJ
 8jzSggKZ5UJMDMYf2QgoXzhXveP6CvIKhFAqdOCd3sLd2PN4w5WJIj0SfDtquMG1Jv+r
 62/A==
X-Gm-Message-State: AFq9FYLuayw4Ae+3L7w3/0KnA6/5T8nV1Kw0ccGjBdlHvMWm4v+dQugT
 JcZEvBR2D0g5uOwEkj9yq51xV8JtUu2nOWMSmneAZNTEFAtQI+wep+v02Hk3xTRNW81pra0VM7c
 mfKc2sC8eZtejChE/L/2Rd7dNJT4A/xG1SPmfLXybaBeB/hxURbZF/Qy+64I5mnYLsbhgIyIA9P
 Pwfh+Z1MIHbdMSgD20imiriO7thcYHFNx8HlqPRbcql9/1D21ZAK8Xge6qt3up+NXGf9y6TQ==
X-Gm-Gg: AYBFou3XBUx1skm07HqRF7mCOQuFCLQMDklROj3qSByuFzrAo1Cq278E2r3vpHxLPNB
 vnkF/1nTGGH3MvGP4LEk2fOwueAOhf23p1huC2lkDgiu3L20leKOSvENPqS/bX0pNnMx1q/w7i4
 LMSfEfKb25i9sscMpOm4HYD9cKMIqapEFrYBDz+vb8rLSneU5cgBEX8gYWb3zicmfrvHowzwKw3
 m9/w3Xm6AMwyDrguk0cFe6ZiFCi4gRAFCCl90KXjr2XY2S9Yx9IeRBAtoZxipLngfuJEfIj38mY
 iT3USDjEOXP9oiWVL93PFCOsiTIuCOaJP8EHoQCQ9YPiV45A9gQ0kipkunbo8G+mIRavJe8T/M/
 sezzm+dcWFHuylnlqaDtUEc0EsGAIlCyk9qJMSu1fGUbx404F/F6FuAtUAmAxDTMJASnv7tYUG9
 2K/Whe8BETHYtXtP1uIRZvBSqko3HGs1O34yU=
X-Received: by 2002:a05:690e:130b:b0:676:88ca:2795 with SMTP id
 956f58d0204a3-677bd4215a6mr2967082d50.98.1791244250454; 
 Mon, 05 Oct 2026 16:50:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-677c1bc375csm1463459d50.30.2026.10.05.16.50.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 16:50:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso493316585a.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791244250; x=1791849050; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CJf9mHxSnKoK61xmV1U9WJyB6mH/Ct8lOUVm3EtzS00=;
 b=gKwHVKZDDcLTCxlC0Gb18MCaaC5Rz95O+Q5iIjgE17xAbpRHNEadyJBpbvWlfDalyz
 LXWsqTjhMVODJ0S5XStF16tg8Mgc7DgSVa7mK8+SceW5oZ3LMoMHrerrmUHGfVyFrN2e
 nF5lO7SXNCuYEz0spqrH/C9TdlSYTRs7XRpQE=
X-Received: by 2002:a05:620a:460b:b0:93c:69ac:bbec with SMTP id
 af79cd13be357-93e510389b6mr1690633685a.38.1791244249503; 
 Mon, 05 Oct 2026 16:50:49 -0700 (PDT)
X-Received: by 2002:a05:620a:460b:b0:93c:69ac:bbec with SMTP id
 af79cd13be357-93e510389b6mr1690628985a.38.1791244248907; 
 Mon, 05 Oct 2026 16:50:48 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca0395dbsm995492885a.5.2026.10.05.16.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 16:50:47 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joey Zhong <xiaozhen.zhong@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH] net/bnxt: fix truflow out-of-bounds accesses
Date: Mon,  5 Oct 2026 18:50:40 -0500
Message-Id: <20261005235040.26973-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

From: Joey Zhong <xiaozhen.zhong@broadcom.com>

Harden several TruFlow paths that trusted unvalidated indices or input.

dpool_free() and dpool_set_entry_data() checked only the lower bound
(start < 0) of the computed pool index before dereferencing
dpool->entry[start] and, in dpool_free(), running a zero-write loop.
The EM index originates from the HWRM EM-delete/move response
(tf_msg_delete_em_entry() stores resp.em_index into parms->index) and
is handed to dpool_free() by tf_em_hash_delete_int_entry(). Firmware
that returns an out-of-range em_index could drive a read and
conditional zero-write up to ~1 MB past the EM dpool allocation on
every flow delete. Add an upper-bound check ((uint32_t)start >=
dpool->size) to both functions. dpool_free() also needs the write
loop itself bounded: start + size can still exceed dpool->size when
the stale flags byte at a corrupted start encodes a nonzero size, so
reject that case too instead of only validating start in isolation.

tf_em_hash_delete_int_entry() also indexed pool->entry[] directly in
the TF_FLOW_SCALE_QUERY usage-update path using the same untrusted
index with no bound check. Guard that read with the same range test.

tf_attach_session() required the control and attach channel names to
match a strict 4-field PCI form ("%x:%x:%x.%u") and returned -EINVAL
otherwise, unlike tf_open_session() which falls back to the
domain-omitted 3-field form ("%x:%x.%u", domain forced to 0) that DPDK
permits. Names without the domain prefix therefore failed to attach
even though the same name opened successfully. Add the same fallback
to both channel parses.

Fixes: 05b405d58148 ("net/bnxt: add dpool allocator for EM allocation")
Fixes: 19f3ac618ab2 ("net/bnxt/tf_core: support flow scale query")
Fixes: a46bbb57605b ("net/bnxt: update multi device design")
Cc: stable@dpdk.org

Signed-off-by: Joey Zhong <xiaozhen.zhong@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/dpool.c              |  7 ++--
 drivers/net/bnxt/tf_core/tf_core.c            | 38 ++++++++++++++++---
 .../net/bnxt/tf_core/tf_em_hash_internal.c    | 17 ++++++---
 3 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/dpool.c b/drivers/net/bnxt/tf_core/dpool.c
index f60c04e949..65d5239680 100644
--- a/drivers/net/bnxt/tf_core/dpool.c
+++ b/drivers/net/bnxt/tf_core/dpool.c
@@ -345,12 +345,13 @@ int dpool_free(struct dpool *dpool,
 	int start = (index - dpool->start_index);
 	uint32_t size;
 
-	if (start < 0)
+	if (start < 0 || (uint32_t)start >= dpool->size)
 		return -1;
 
 	if (DP_IS_START(dpool->entry[start].flags)) {
 		size = DP_FLAGS_SIZE(dpool->entry[start].flags);
-		if (size > dpool->max_alloc_size || size == 0)
+		if (size > dpool->max_alloc_size || size == 0 ||
+		    (uint32_t)start + size > dpool->size)
 			return -1;
 
 		for (i = start; i < (start + size); i++)
@@ -376,7 +377,7 @@ int dpool_set_entry_data(struct dpool *dpool,
 {
 	int start = (index - dpool->start_index);
 
-	if (start < 0)
+	if (start < 0 || (uint32_t)start >= dpool->size)
 		return -1;
 
 	if (DP_IS_START(dpool->entry[start].flags)) {
diff --git a/drivers/net/bnxt/tf_core/tf_core.c b/drivers/net/bnxt/tf_core/tf_core.c
index f1b3be48aa..3e60c2aa8c 100644
--- a/drivers/net/bnxt/tf_core/tf_core.c
+++ b/drivers/net/bnxt/tf_core/tf_core.c
@@ -109,9 +109,22 @@ tf_attach_session(struct tf *tfp,
 		    &slot,
 		    &device);
 	if (rc != 4) {
-		TFP_DRV_LOG(ERR,
-			    "Failed to scan device ctrl_chan_name\n");
-		return -EINVAL;
+		/* PCI Domain not provided (optional in DPDK), thus we
+		 * force domain to 0 and recheck.
+		 */
+		domain = 0;
+
+		/* Check parsing of bus/slot/device */
+		rc = sscanf(parms->ctrl_chan_name,
+			    "%x:%x.%u",
+			    &bus,
+			    &slot,
+			    &device);
+		if (rc != 3) {
+			TFP_DRV_LOG(ERR,
+				    "Failed to scan device ctrl_chan_name\n");
+			return -EINVAL;
+		}
 	}
 
 	/* Verify 'attach' channel */
@@ -122,9 +135,22 @@ tf_attach_session(struct tf *tfp,
 		    &slot,
 		    &device);
 	if (rc != 4) {
-		TFP_DRV_LOG(ERR,
-			    "Failed to scan device attach_chan_name\n");
-		return -EINVAL;
+		/* PCI Domain not provided (optional in DPDK), thus we
+		 * force domain to 0 and recheck.
+		 */
+		domain = 0;
+
+		/* Check parsing of bus/slot/device */
+		rc = sscanf(parms->attach_chan_name,
+			    "%x:%x.%u",
+			    &bus,
+			    &slot,
+			    &device);
+		if (rc != 3) {
+			TFP_DRV_LOG(ERR,
+				    "Failed to scan device attach_chan_name\n");
+			return -EINVAL;
+		}
 	}
 
 	/* Prepare return value of session_id, using ctrl_chan_name
diff --git a/drivers/net/bnxt/tf_core/tf_em_hash_internal.c b/drivers/net/bnxt/tf_core/tf_em_hash_internal.c
index 0212abd05d..e83e7c34f8 100644
--- a/drivers/net/bnxt/tf_core/tf_em_hash_internal.c
+++ b/drivers/net/bnxt/tf_core/tf_em_hash_internal.c
@@ -153,12 +153,17 @@ tf_em_hash_delete_int_entry(struct tf *tfp,
 	pool = (struct dpool *)tfs->em_pool[parms->dir];
 
 #ifdef TF_FLOW_SCALE_QUERY
-	/* Update usage state buffer for EM */
-	size = DP_FLAGS_SIZE(pool->entry[parms->index - pool->start_index].flags);
-	tf_em_usage_update(tfp,
-			   parms->dir,
-			   size,
-			   TF_RESC_FREE);
+	/* Update usage state buffer for EM.
+	 * parms->index is populated from the (untrusted) HWRM response by
+	 * tf_msg_delete_em_entry(); validate it before indexing the pool.
+	 */
+	if ((parms->index - pool->start_index) < pool->size) {
+		size = DP_FLAGS_SIZE(pool->entry[parms->index - pool->start_index].flags);
+		tf_em_usage_update(tfp,
+				   parms->dir,
+				   size,
+				   TF_RESC_FREE);
+	}
 #endif /* TF_FLOW_SCALE_QUERY */
 
 	dpool_free(pool, parms->index);
-- 
2.31.1

