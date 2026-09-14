Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E0DC88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:52:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B91A740E42;
	Mon, 14 Sep 2026 07:51:09 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id F181D40E18
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:07 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1768623a91.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365067;
 x=1789969867; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=apwhLJ32drFL8qKYRVIJOeVb/PYvyotSN8GvkDwERmw=;
 b=ojTPk2nuFhh4okqydgP052BYg2HCGnDYeFZrV+eAjv1bPni8rfwM/F43qQL0mKpLAv
 borFBq64LE4Cwj7dszhI5gVAxIiPWMvwWyEoR6nPXMmXnGFJG1a6epYYsK2JRqrwFgvF
 DPBsgtRJ+FfgGorQjQLPy0C//KY1McWVR6mp2FZod83yPivtVJpDGcdSxVryizrivIA/
 UygsIsjYztnU6REfYLQzRcsNOS8QSpaufXzYO5Vlfvv4B/CRJKgApQv1ZY8kRDhUBoql
 uriewUWxOUyNPMBldSc4lBVX0ArQadMDCPt7J1iU2qcYUccL88/DIU8U1MHIKZR0x5D+
 ECLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365067; x=1789969867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=apwhLJ32drFL8qKYRVIJOeVb/PYvyotSN8GvkDwERmw=;
 b=Cvw9hqTfXC3G5rK/aGsFamLkhi4nEwxwI+hmi09isqzyrFNrTW398YtnEbuXYvIl47
 iIc1NGA+4XFkcEG5R2SgDkIOchnWSCpwMWxPdMnJ9mJnLDV4yROomG+Yo8wgH8Ke3j8p
 WPGtI0FqWOq0/NoBJHOo+/P1rxce4bRZgqPKLpLxiKttk9iumm2x4KSw2NR6ARA1dkc5
 h0sjDn7RAN+ZlO97ZNuszxV5tFmQvyT1+aLiiz9Qeo70VbOsxOXmZSHurFVDDob8UBCY
 BHJG8KybL/ycpDx7gIthJAYJptW5S2W3VHPMi5LlA1Ym79ysCTqzt6LtLHqXEbO7rxEc
 Ungw==
X-Gm-Message-State: AFuF++ntMGIHRdXKQS3UMsyYq2YA8rAZBKzwOVbXP+kexgmSjvybRBPx
 2gkrXUxnEqNaOXp4GU1Xgc2TeTLRgcyVSNNIDYnU4h8/k2FhdMCnGVuyuOk/WlQwX4H0AaYRPAR
 BWTw/Wqc=
X-Gm-Gg: AYBFou3TfUhiJ5TpwkIgbv4+KdSKHWcR6G8No5lSVmfw5xfo4QUxLcSgMZDlb41X4QT
 FahQbHzMNTAdGqHkbEb3ekdCL9W0XjA6nd20sz34685w35MidssCM5oHuWJR3lPtSgqTZPjWpzV
 26Tp1ju3dN/Lh8oAA7sb+CyW264L1oJUdLzxfwwldgl/tPz0qwRBBnPxPwKmR8Xv1PFYDY0xlLL
 qC4Z+KOyLMbaS+lowDzCyXBr9t5trYrprHXsjBPKOIdly95E5BKCla6UnUWrWQ5xUZpD4++7KRK
 zusuWi9ydGeu52FA4uSbmVyjnYO4ny/0QtNUlEqeO0Fr7iD72qQKUvo6HaJuMS4xKTLddQ99lro
 g1DtdleKjzxnsdsf5RBsWN6ZwW6/2KW8oGUHjknPJQIz1NVVyW2M0UjagSIEHLxWP630UY+k3pu
 FwqZWE2jg1d906YzPERh7VhzLY1EbyB3ZvhBPQQe0y2X3+hjwZbVromdvjJqTARl6tAlbaOJ5dx
 1qSBpw+jSLxGtla2aYTsEr2/HRVHabOaW0QWw==
X-Received: by 2002:a17:90b:1641:b0:39d:e54c:8643 with SMTP id
 98e67ed59e1d1-39debfc9d8fmr2495108a91.11.1789365067145; 
 Sun, 13 Sep 2026 22:51:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Harman Kalra <hkalra@marvell.com>,
 Santosh Shukla <santosh.shukla@caviumnetworks.com>,
 Jerin Jacob <jerinj@marvell.com>
Subject: [PATCH 31/62] net/octeontx: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:02 -0700
Message-ID: <20260914054912.755403-32-stephen@networkplumber.org>
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

parse_integer_arg() uses atoi(), which cannot report an error, so a
malformed value such as "abc" becomes zero and the negative check never
fires.

It also stores through an int pointer, while the caller passes
&params->nr_port, which is a uint8_t and the only member of a
struct octeontx_vdev_init_params on the stack. Parsing nr_port
therefore wrote three bytes past the field.

Use rte_kvargs_handle_u8(), which both validates the value and matches
the width of the field.

Bugzilla ID: 2036
Fixes: f7be70e5130e ("net/octeontx: add net device probe and remove")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/octeontx/octeontx_ethdev.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index e4dca30d9d..d2ad9a7d04 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -65,22 +65,6 @@ RTE_LOG_REGISTER_SUFFIX(otx_net_logtype_mbox, mbox, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(otx_net_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(otx_net_logtype_driver, driver, NOTICE);
 
-/* Parse integer from integer argument */
-static int
-parse_integer_arg(const char *key __rte_unused,
-		const char *value, void *extra_args)
-{
-	int *i = (int *)extra_args;
-
-	*i = atoi(value);
-	if (*i < 0) {
-		octeontx_log_err("argument has to be positive.");
-		return -1;
-	}
-
-	return 0;
-}
-
 static int
 octeontx_parse_vdev_init_params(struct octeontx_vdev_init_params *params,
 				struct rte_vdev_device *dev)
@@ -106,7 +90,7 @@ octeontx_parse_vdev_init_params(struct octeontx_vdev_init_params *params,
 
 		ret = rte_kvargs_process(kvlist,
 					OCTEONTX_VDEV_NR_PORT_ARG,
-					&parse_integer_arg,
+					rte_kvargs_handle_u8,
 					&params->nr_port);
 		if (ret < 0)
 			goto free_kvlist;
-- 
2.53.0

