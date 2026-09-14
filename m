Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFA8C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D04D340A75;
	Mon, 14 Sep 2026 07:49:48 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id E928940691
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:47 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so2609474a12.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364987;
 x=1789969787; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PWCxBJsidyWJCKf4Q+oX1YIwY3/qHy732Lb2HNNQASc=;
 b=D6x6aqftlzDGHWE07+cXV2QJ4C6NBu0Mto0nnHRyQYTqpkubApNwUviDF7RIOanxcJ
 1pBV+VNzfMf3uMFz2/3zilYhNA+KVL4Bby0hAEQFqHJdscYGPmVwMDyPB3eKcgQ1ht6m
 duZD7Z9OhsKgs9zeBXcSDaC9ac3DIgYdxZzk5IDbfyC1rx+sJEmI62pllnri3zdxD4hN
 8TjZVfeX0Snyb4TpMxIcav3ezKP5kyxPwHZpPqc3aPtwd0SHqaaVFedGlz7iNMAb8E6Z
 7so1SjFrgjQfOIMB6GrEMJnKt5mTI9exsuSNIv4GGBknOscb7JHCRSWYgLX3YXX8pKbb
 rELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364987; x=1789969787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PWCxBJsidyWJCKf4Q+oX1YIwY3/qHy732Lb2HNNQASc=;
 b=NCc13uL6cwSecQl4zSqLacb9b9s3y6FQCD7BTiElWl2b3frTvhOt/v3Q+WDzyANr7U
 fBoHq+U98lp2/cgrtvS1vaYjofYqrijkP5wbsaZY0DbZVzKw1hZC/ORI0lzCEJJnRETk
 P1HSYdAbBzD7Xzil0+8JY/zl4NJ4tqseGeSk6B7H9LSXjmSs0K2GT+nsk90UgVksETvi
 F++jlJxKLryu1s4X5aW657+iLSJq/JTVmyvquVZzYEQPipZitMWG9f59rBG9nExbmB6W
 /t+eQdqjyUqYIsKZ7RG4oGTr6NwqoZ3nlN9RS4a8q6Hja2UxRrvF2HzD+VLocK0M06Pr
 xyGg==
X-Gm-Message-State: AFuF++n1Bna4sY7C65isZD60md0i2nV5q2iV2w3lLKupOMfT1m68mPzF
 YISVZ0rudBqWxdqmsKtyb3SfuAslatlYTE+W4ZaxDZpxxo7lHDH4VBjbswBLeeku/rWMTu/MpEJ
 wP1gY1zI=
X-Gm-Gg: AYBFou2e20C6Mn63d68/Ti3smN2Yl/+ZG1ZafXgFEtPEohdvRzq51R/EzZkvLhhcjcz
 qERHEQ79k5ILlz7EuEnnqBBpl05398/9zeCfP1Eyca+F7Pv0kcH2NygKxcz+jMIceSwJ0P/Ztui
 U9WOBEV5G04dP/b/vFkV5HTsEPP/+bBua9UHispgmOCEoYZ721p2TNRJXoxCnOnhxqsd61BqRtX
 OJQG78qovcJ21sZSm2j5QIQ5YcO2MzFV3GxHiwzielC3YA1mj7OkdYQFLnlDddRE+igmi+aN0R9
 ZEltwfrOy/ZbnofoJ7a+Cxj8JFAUNldr/cEffVga9bqvcW+d5QbKpe9/65onUST1n3ZJnyWQdcF
 KYnnwyHXeqLwqhb2AGzeQtSVR/INsFUQK95xfrI21C2RAfOVvmj7pDQ4CwRNbdBCpgF5KvcFIdq
 tuqbV4x6E9GD6wl9WrVeTa+BNAGLPzasTrWS5rhhdXB6GSKiSPIVUTbQ3SZqr0FJlIVEehQgQ6M
 VP8pA2/dD5MjfuzZ36QxHX0+I1+kwnuVQ4wKw==
X-Received: by 2002:a17:90b:380f:b0:39d:ba21:cc5a with SMTP id
 98e67ed59e1d1-39dd54ab676mr6774242a91.10.1789364986972; 
 Sun, 13 Sep 2026 22:49:46 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Xiao Wang <xiao.w.wang@intel.com>
Subject: [PATCH 08/62] vdpa/ifc: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:39 -0700
Message-ID: <20260914054912.755403-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

