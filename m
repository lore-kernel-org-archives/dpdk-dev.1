Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A73C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 183F740A6C;
	Mon, 14 Sep 2026 07:50:03 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 1C43540B9D
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:02 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398c066106cso1273887a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365001;
 x=1789969801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CmTPFHnSyhzxJ57Fz/492boTQpob9X7I9uaVcIVOUuY=;
 b=mWjwbYhVxuB7CJGYcztx/Oceepq76vF10AG3vWnIh4u8OKgJB2nX/A8inhgfxYYtBs
 y8tPUbhM6h5ORohm1ggy/lemJIfDM7aaNjbwWvtS8cw9Q95hcyFLWE3NCYogwM4opPip
 DRLENEfx3az5EWFbm5xpSEKxrBz1g7V5uVvN5EamuWvox9z4pQXVKJ6/l68qAFe4Kwkn
 fG7HORZyq/ebcsnLWMxs6PFb8U40C45ruaVjnxD4DLt65MrIqmHvmd+MqdDFb8hrucRu
 7HV+7TjslbEZ84gmWrvei37KuxB6+ROsX4quhgSB7EB1EiR7DmpJV7t5jbV5HH/5Y98f
 1qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365001; x=1789969801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CmTPFHnSyhzxJ57Fz/492boTQpob9X7I9uaVcIVOUuY=;
 b=sxMxsvg+jUcUgqQq4JB9r1oweyzLpPWQKOY8ZbzqRBsJx2DSmoyv9/foQrMysiBAeW
 DgMk6D/qkwMOmsHb+0wgKjZtqRfuKLNjJUEafPvHf92wfjN/pvS3QR6O8pNsqWDd6TEF
 7JpFNh0dGr6YiWSDExtqD5GlULaFOkqqLXtH65Yykg/A8879ExC58gUCX+u2K2j3KfEk
 4qd1uTXwcenhhpn3AX+NhtmkFpgm+VRbgd91Y/z9T0DGOvj/BLZyQyqv9lLgmXUI+UHq
 xv21lgXYJ/7g3vgs/84y0FkWsjmQWXdyRo0gXDONQh1tC+o2npxtSPGTCHWWmejs0ryS
 b2CA==
X-Gm-Message-State: AFuF++lbIcs9y+4B5z4Uucq5umMeYldjGNre5aNV0+XpiccHZ5kYb7rV
 W9cPANkLOwYcu8znQKA4mXKzOd1s3wfgYV42S/cQNMofqofgFuYd3GyADaxY8yDBCpnVOoPbylp
 Jus96
X-Gm-Gg: AYBFou0ghoVNirv2SlGBRo0zR+g+4bMpTWYyvMP2fbIhqOVENl0tjnp2RbRuSOeyONL
 PLozIxb54+Y+v8li1Gez46tFJxaAgEsYHgiG9iAN2Gc5gWO2o1NaZ2p3vmigO6NmBSV1QXX0Vlu
 av1NhvEgditlYlYrvzkVWKAKppDjz13KZjir1zPJIAbXad9En1eaoGgEDCkaWvDk6+qtel3kXUB
 MTB/sY6DblU0CB7XkC76GOu1hTi+x/vcZP/KbPRoRlAcNeUQg8WA4XwB7KFs9J4OoZbwKgIyWr+
 B8WiToU0DxhjhTgfe+y+yl/x/n1pKfB/+g8Zqt/wJfx/tFUirv3cxPk0TT0jiPH/M1SrcOdky/p
 BfNn+sqIB3uOMyD8uk9wDbpCpFbMHQ1gG29/p8Ie99TKyqkW3SGbQg36vddfjund/pyvDDdZqC9
 /XdCpY1LwxnBfAu3SA66CqxaR/tym1+yfEVTIgrjfcdDzYmOYsaztQkLBP/FX0H5g5ljn3UB8vG
 g+N0jSSnXkH9nCfpZZob7zHw9wt1suSESbklGoSIwvBIYRI
X-Received: by 2002:a17:90b:4ac6:b0:39d:efef:9b21 with SMTP id
 98e67ed59e1d1-39defefd842mr1015566a91.3.1789365001205; 
 Sun, 13 Sep 2026 22:50:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Amr Mokhtar <amr.mokhtar@intel.com>
Subject: [PATCH 12/62] baseband/null: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:43 -0700
Message-ID: <20260914054912.755403-13-stephen@networkplumber.org>
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

parse_u16_arg() does not check the end pointer, so "max_nb_queues=foo"
is silently taken as zero.

It was used for socket_id as well, which is an int rather than a
uint16_t, so parsing it wrote only two of the four bytes. Use
rte_kvargs_handle_socket_id() for that argument.

As in turbo_sw, the open coded range check only tested the upper bound,
so a negative socket id was accepted. The helper checks both ends, so
the check is removed.

Bugzilla ID: 2041
Fixes: 7dc2b1589440 ("bb/null: add null base band device driver")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/baseband/null/bbdev_null.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index cfa1790126..fc23a84f32 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -202,25 +202,6 @@ dequeue_enc_ops(struct rte_bbdev_queue_data *q_data,
 	return nb_dequeued;
 }
 
-/* Parse 16bit integer from string argument */
-static inline int
-parse_u16_arg(const char *key, const char *value, void *extra_args)
-{
-	uint16_t *u16 = extra_args;
-	unsigned int long result;
-
-	if ((value == NULL) || (extra_args == NULL))
-		return -EINVAL;
-	errno = 0;
-	result = strtoul(value, NULL, 0);
-	if ((result >= (1 << 16)) || (errno != 0)) {
-		rte_bbdev_log(ERR, "Invalid value %lu for %s", result, key);
-		return -ERANGE;
-	}
-	*u16 = (uint16_t)result;
-	return 0;
-}
-
 /* Parse parameters used to create device */
 static int
 parse_bbdev_null_params(struct bbdev_null_params *params,
@@ -237,20 +218,14 @@ parse_bbdev_null_params(struct bbdev_null_params *params,
 			return -EFAULT;
 
 		ret = rte_kvargs_process(kvlist, bbdev_null_valid_params[0],
-					&parse_u16_arg, &params->queues_num);
+					rte_kvargs_handle_u16, &params->queues_num);
 		if (ret < 0)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist, bbdev_null_valid_params[1],
-					&parse_u16_arg, &params->socket_id);
+					rte_kvargs_handle_socket_id, &params->socket_id);
 		if (ret < 0)
 			goto exit;
-
-		if (params->socket_id >= RTE_MAX_NUMA_NODES) {
-			rte_bbdev_log(ERR, "Invalid socket, must be < %u",
-					RTE_MAX_NUMA_NODES);
-			goto exit;
-		}
 	}
 
 exit:
-- 
2.53.0

