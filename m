Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674BBCA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:46:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCCD642EBA;
	Thu,  1 Oct 2026 00:44:06 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id A111B42EA3
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:04 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so2515773a12.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808244;
 x=1791413044; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=coOkkg8n6nLOJYvGlI695zgjM+lG21SWysfmcLhYbsI=;
 b=eCunNGLAC7FbIjMULbnX8BEs2Rb0lwCpTVGHjvBM0nboi/0gLX36qoLWkgmgEZvpMN
 w2oRr7HIaam8bwniuYY0Eb0ekAzV0NO+i0VLcDxib4+4ZphAdzS9RJYzW7B7Np5GI1a6
 5hyEvTBCObpTFC54IYR4VsnmU5Uw/lD1hvMQCzXAs6ZTuJxEivdUW1u26kUMUoIigvZP
 zOg+SbzYtqOMvvmtCDW8qHS2d1DvNJxRjUuy63bxFqq9dsU4vE5aAx9ELP6kwNK6NSyF
 mvZCwnHvo4BbbLIFBhF06FeZvtE8tLYwa4QdQl3Uo/Q9lnLTc7Xmub1zfBboD3fWYvAZ
 omfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808244; x=1791413044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=coOkkg8n6nLOJYvGlI695zgjM+lG21SWysfmcLhYbsI=;
 b=Vtl5H75lBPRNcivavehMQZBwcSMU69SDEtL++lftMHm7Y/mM4a9oslrC3x7f63ea7x
 j4l/9SjBiLdiUSmQA56HD/QNW08v+0pVch57RMWvNFxGKqvnHbWU8gLxu+bkJrtnmYTb
 KtCNy7xlYnjhdUBTdFjcJMK7vHtLA6XLWEYAyvL5kJnL/CoRi98Cj2Cl/O/8KIWDlDvY
 i4gXoVGyxj4x10mrelOcMDMi8UaS4enFvJlP06ILjranU4KKSF9kNARrBBqNy3OnmECE
 hIl0lEL07ngdG02VXKvg3cLUOPTtQEEx5BeFt7Z6nlWxk+f5Dgm33iJelBDXvTQZ09sk
 n5qA==
X-Gm-Message-State: AFq9FYLJfIwMvRxy5+yMOSSiAYmFt/ETZzCRMkvo1KX9hS4WM7bPOALJ
 L5Z1h5zOx3Ow7blvYMnyzD4ex9ATX3+AJaMwCsxzNtWz35VMXqdp8Hjm8hDizssQSTPa1dkqxZq
 rKSm8Kfs=
X-Gm-Gg: AYBFou2Hm1hRLWU2Y+IV0dAnaTZw33cjVELOUpTwUlQdZ4vLndAxKmsN1MVXZcBmO4c
 cTUkmZjZPAuy/Sb92nMAi+w1EL6kV3VHSKBmrG4FBdx96QZgX1fll8dPq8kZpDhE2toHe5BDUxT
 ea5rEv6BgaPCt9GhsAXPHNh0kYNCXWfRyqEY0NfG5kOSEAZ1DK8eSjdNVGyweFWLS6sXVB686Ur
 T2RcEIGd4H/LzU5xBCQJdfnHtdn8sC8PhBC3kiSPiG2u3bw7vz8lQ+LRvSsLISc4e5m60df7EBc
 dpT326hG+Uy0wgodNdHJ7x0E37+vq/wmVucMG+Fkva5J38tdfWBTyUPsKDOUNr/nMd2EJIZyKPB
 Hh8/8gFyYENHY7AgVkgdKCyXBDa1OZsKDL5+xJCtHzpht7kOQ8eL8VRi1plM4oJzV3JuN81o2El
 PmTPZhHw/0sQ57J2qLmqaEQ/rruWyHZjJMmQIrP25SMfSsh5Iqs5SSCnQaoAdtW1WU5W0mJpTw8
 sckLaXFyMbFmw/ImQJBzzjoZFse92dE2tMTpQ==
X-Received: by 2002:a17:90a:dfc8:b0:3a4:a4d1:a987 with SMTP id
 98e67ed59e1d1-3a4d1774416mr2132601a91.32.1790808243764; 
 Wed, 30 Sep 2026 15:44:03 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH v3 19/65] net/failsafe: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:37 -0700
Message-ID: <20260930224340.58580-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

fs_get_u64_arg() returns -errno on failure, but errno is not reset
before strtoull(), so an unrelated earlier failure is reported. It also
accepts a value with trailing garbage, and base 0 means a leading zero
selects octal.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/failsafe/failsafe_args.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/failsafe/failsafe_args.c b/drivers/net/failsafe/failsafe_args.c
index 1b8f1d3050..f256a9f6a0 100644
--- a/drivers/net/failsafe/failsafe_args.c
+++ b/drivers/net/failsafe/failsafe_args.c
@@ -345,24 +345,6 @@ fs_remove_sub_devices_definition(char params[DEVARGS_MAXLEN])
 	return 0;
 }
 
-static int
-fs_get_u64_arg(const char *key __rte_unused,
-		const char *value, void *out)
-{
-	uint64_t *u64 = out;
-	char *endptr = NULL;
-
-	if ((value == NULL) || (out == NULL))
-		return -EINVAL;
-	errno = 0;
-	*u64 = strtoull(value, &endptr, 0);
-	if (errno != 0)
-		return -errno;
-	if (endptr == value)
-		return -1;
-	return 0;
-}
-
 static int
 fs_get_mac_addr_arg(const char *key __rte_unused,
 		const char *value, void *out)
@@ -416,7 +398,7 @@ failsafe_args_parse(struct rte_eth_dev *dev, const char *params)
 		if (arg_count == 1) {
 			ret = rte_kvargs_process(kvlist,
 					PMD_FAILSAFE_HOTPLUG_POLL_KVARG,
-					&fs_get_u64_arg, &failsafe_hotplug_poll);
+					rte_kvargs_handle_u64, &failsafe_hotplug_poll);
 			if (ret < 0)
 				goto free_kvlist;
 		}
-- 
2.53.0

