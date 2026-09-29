Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68A4CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D297242E71;
	Tue, 29 Sep 2026 18:38:21 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 8855242D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:15 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8804b59404aso2146692b3a.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699895;
 x=1791304695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PWCxBJsidyWJCKf4Q+oX1YIwY3/qHy732Lb2HNNQASc=;
 b=I9X76SBqAa0vWosPe6IX6O4TSa27pw8rBMdCTLlecflU8x7c/wXLqd1ZJ4qidMt2ES
 Aa/YC0p2Ogfmcu+CovQOEpME4OImAvKki+rctwxXqLiL0ZXJeSo/OrWnG4ddLXHSwOJw
 cgRaH3S2NuGZEENgiY25vvicunqc6xI1tY/knfNEmuf9arjEoS3oZDO77vvrquxWLNly
 fFXbmM6hgBlkLd+3F9u+Zt09s73e3fNlg9OiwkLsg7qAHcFNjaLRMlkkGtOph4E5yX7R
 BfQVoC9vQ2eEndKxSqWDM+7MIxCF54kAj9P7HdQxCZ9jmQfjr8ycbsfDz/RahPLYQ3na
 grUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699895; x=1791304695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PWCxBJsidyWJCKf4Q+oX1YIwY3/qHy732Lb2HNNQASc=;
 b=eIJ+xEmcYiRKdHLyO6gv7UsLc4M+RJRlb8P4dw/rFVY+Xa0btvQ5cuhdA2cwZlSn/V
 u0oy/vxnPd8X0a/Gg3zYjOAxUrZvBUCUEwEh6VUsgVamM6X+TigLdqhjoyBSh0OMxI0+
 GLcmFe7YLV2teKqlVpkm/mM7JY1c8TotWElxdPU/ztMRNMn2QJEzQbUNG5b5LTBKGHsy
 qnFYHPYGzD6zNhhFlhnP4dhqL/Z3XbwTw81o0YQI/hkKxDXtdlmaOrGaP4X+iI/hiYPt
 Zgj+cvANS2ialMjo8meC21CEov0fIbhkg5iRXbeuvIgs9H1w53BWUMTAnCofVH4nsfCf
 lcxQ==
X-Gm-Message-State: AFuF++m/3vTrQ9tFkzYMAFvcFhFWuHysBZ4GyUBfx//fnJvaEZHjj5PJ
 O+BYvm3S80sjLHCEMmtqrF66TNj4irTuR9hky91hbxqULaWpoJVufSHCi7uSq+sEqGQ5zHxu6Bj
 JV5KKD2w=
X-Gm-Gg: AYBFou36nIY55+XuzXwYQL/f+GhNrnxRKMEeesCHxDLJF1hy9UtNGeCMudOF/QCj6TN
 HUHz3AllQPXFaSM783kNVCCimwkt+bhl1lkOwV1CyBXOAtHnzd01TEj3LoH9p+3XRLXQQOokizi
 bOGC4qs5IC1YtRsRJLHOBGvSfWyJMb2BIBy1NCDjHvdRSlGj7uDJT1pffYjgtH2+he0yIX/daeK
 h9V6ZtT9S6lu9XOgBMIbftX03NkT/m8sBsPPe878Gh+wVJIHpLtcJY0dRCKlIWON2lb5WCvBk/j
 X8ju4v70phUCUQI6ZSmoYxY7isdT/mF0XYLOXQsJjYMFd7ZaFaFLVNrTn8veqE7VmSS0v8Nt5Hw
 0+p3XHj0W+JSYcbVZQuV/V1zYF3TquNlFo3RA9A6s3pFu0ht0JvfIcEaMlxjPJrpiwMVTciZX5b
 svqmSBUki2ymEjr/n+VCJpYrWtt5iQrMmWa5si1djx4U8+adADLHX6NBszghjVm0SSrMrKg7Pff
 qLfzFmPrE0HgDxMtBpq4uzjb7NX2ClzI43MXw==
X-Received: by 2002:a05:6a00:853:b0:882:26ea:cd56 with SMTP id
 d2e1a72fcca58-88226eae56emr7274824b3a.35.1790699894644; 
 Tue, 29 Sep 2026 09:38:14 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xiao Wang <xiao.w.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v2 07/61] vdpa/ifc: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:10 -0700
Message-ID: <20260929163800.1108305-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929163800.1108305-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
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

open_int() stores through a uint16_t pointer but both callers pass the
address of an int, so only two bytes of a four byte object are written.
It also checks errno without resetting it first, and never checks the
end pointer, so "vdpa=foo" is silently taken as zero.

Both arguments are used as booleans, so store them as bool and use
rte_kvargs_handle_bool.

The booleans use rte_kvargs_process_opt(), so that a bare key with no
value enables the option.

Bugzilla ID: 2040
Fixes: 40ef35f4a504 ("net/ifc: detect if VDPA mode is specified")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/vdpa/ifc/ifcvf_vdpa.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index f319d455ba..1381f7cc9a 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -1480,21 +1480,6 @@ static struct rte_vdpa_dev_ops ifcvf_net_ops = {
 	.get_dev_type = ifcvf_get_device_type,
 };
 
-static inline int
-open_int(const char *key __rte_unused, const char *value, void *extra_args)
-{
-	uint16_t *n = extra_args;
-
-	if (value == NULL || extra_args == NULL)
-		return -EINVAL;
-
-	*n = (uint16_t)strtoul(value, NULL, 0);
-	if (*n == USHRT_MAX && errno == ERANGE)
-		return -1;
-
-	return 0;
-}
-
 static int16_t
 ifcvf_pci_get_device_type(struct rte_pci_device *pci_dev)
 {
@@ -1635,8 +1620,8 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	uint64_t features;
 	struct ifcvf_internal *internal = NULL;
 	struct internal_list *list = NULL;
-	int vdpa_mode = 0;
-	int sw_fallback_lm = 0;
+	bool vdpa_mode = false;
+	bool sw_fallback_lm = false;
 	struct rte_kvargs *kvlist = NULL;
 	int ret = 0;
 	int16_t device_id;
@@ -1662,9 +1647,9 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		return 1;
 	}
 
-	ret = rte_kvargs_process(kvlist, IFCVF_VDPA_MODE, &open_int,
-			&vdpa_mode);
-	if (ret < 0 || vdpa_mode == 0) {
+	ret = rte_kvargs_process_opt(kvlist, IFCVF_VDPA_MODE,
+			rte_kvargs_handle_bool, &vdpa_mode);
+	if (ret < 0 || !vdpa_mode) {
 		rte_kvargs_free(kvlist);
 		return 1;
 	}
@@ -1756,8 +1741,8 @@ ifcvf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 	list->internal = internal;
 
 	if (rte_kvargs_count(kvlist, IFCVF_SW_FALLBACK_LM)) {
-		ret = rte_kvargs_process(kvlist, IFCVF_SW_FALLBACK_LM,
-				&open_int, &sw_fallback_lm);
+		ret = rte_kvargs_process_opt(kvlist, IFCVF_SW_FALLBACK_LM,
+				rte_kvargs_handle_bool, &sw_fallback_lm);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.53.0

