Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184E1CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:49:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1E5F43254;
	Thu,  1 Oct 2026 00:44:45 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id E7AAE42FF5
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:41 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so3391564a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808281;
 x=1791413081; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3qyCdqIWL/PVCNyHFpXdONh3fm8Sb5qZOA0FHeH9Lk=;
 b=Y1gNywjS4eDSDbpiNNiezDoAAzNG3+T9c0gf3vC23O7cZHLzTtcfYHVvS9XFdC7pMT
 BkqlVNhgVMUCj7WSVXNSAerkU6aMAOaRb3daVEzDE+oC/ECIJm2bGQ7DPKmSmCc/Z47x
 /W7+JSkTLFeneVDGdVMj7+MmEReTA5DWKRHGUonNAHbshYAtZx5bMuK5ao8i6/XzcQPr
 DP0fRrVhgHURnWFkFeJwJYpcKIb0UQWmt46p/qycztr0Am2APGgpOOkp6nz56ChnWvCD
 a9W3Lk48atXjaGIqX+Dl7l+6sFS0wn/HFLZKv5uKLV7DmkCHdiQmsrd5kax99KATqcYC
 hhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808281; x=1791413081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+3qyCdqIWL/PVCNyHFpXdONh3fm8Sb5qZOA0FHeH9Lk=;
 b=J2bRHuaplxGQ3YxEQPa7rQUqb772t1dzPlwQDnCRnpDLxS7GA+U05yMCvr2ea2yWyY
 wl1LTJ/C6tMRunIS83Kr1N0hCGXMI4OL1s2F+Mz8SBG+GxZ7xU5S1Dyl08EmSz03OhyA
 6RmOpdTYt3X4xZL/Uv6Urtyio9x2j7KJ6bBErWqlDFqS0SoWhT+WdKOwoy7LtHKvG0Ar
 rbS235B/jJDNCOaffzykkXvg4qNYT2WpYiUKZbSCkYTkMD10Qv86kM5UWQPygoexNTkw
 1Rdz+pvtQ1n1cRXRKlIUnpEym7P86u5U+ZNf4QFHA119fJ+8YvX6zWQLntp4BHGt4rfS
 6qeA==
X-Gm-Message-State: AFq9FYKdf3uz2UcmM2/s1nHzCpYWQpJpABcml5SW1T70i3xPpnswihmC
 80E4iKtWjNYy8rSNHtbOU7WX53uwEeF3L0GqOzMcUmVK/C3rvSkGdDMDRNAzVUGu5C7thgaMFkW
 mgI2IzZM=
X-Gm-Gg: AYBFou2TcVxs4pnLw9FptlPJRXqYiNJZwOnOsnApVKBeBgjeWjuyfuKuybS45mUi+s6
 ZHPNUXeLnhMEIX4rqJAG9XDmtj0fU3HXDwXZyy1EgmjVxdXxx51uFUBpvEYtvnPK6vmR8iGfF/o
 aPbyO2LMAR4IQpi+GMKMsGskXD6tZcnOuOvJzFDVuCA3K4PHtyWB9oziw9VgCEBA3Dy+O63LfL6
 /4s5oMfufVCOR74/MTwrPWHyKrMwJI93hx4d1mZcUFbEm1FnyobwyQAHUzYdzPRmPpostS27MyK
 9JWmRtJ/MGSAagZMUlikzbEYpB98+jcRYP4j5Yn8l8FMmy6Ndvyc+sAmpnAcUWm83p/1pf0dnvU
 Z5CxRy5kT+aaa9W8ptjun/Qp5l7A1QW50bDakO4/Qdj7c1WG/sRPdil21F5ejcridG80Z994gqh
 lldIgBiIOlQKIBymMx0f8hYsq9+bwYA0k6D9EZRHy1t2SG1RyLTi7OnROzq8lQyPBHOlsPshyXh
 1BTzYMze1cPOgC0AAkzC+CwcYmwONYB+FxIGA==
X-Received: by 2002:a17:90b:254b:b0:3a4:97ea:f0fd with SMTP id
 98e67ed59e1d1-3a4d18f7844mr2195575a91.54.1790808281055; 
 Wed, 30 Sep 2026 15:44:41 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v3 55/65] baseband/turbo_sw: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:41:13 -0700
Message-ID: <20260930224340.58580-56-stephen@networkplumber.org>
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

parse_u16_arg() never checked the end pointer, so a value such as "8junk"
was accepted, and it used base 0, so a leading zero silently selected
octal.

It was also used for both device arguments, but only queues_num is a
uint16_t; socket_id is an int, so parsing it wrote two bytes into a four
byte object and left the rest uninitialised.

The handler did nothing beyond a range checked store, so drop it and pass
rte_kvargs_handle_u16() and rte_kvargs_handle_socket_id() directly, each
matching the width of the field it fills.

The open coded range check only tested the upper bound, so a negative
socket id such as -5 was accepted and used. The helper checks both ends,
accepting -1, which is SOCKET_ID_ANY, through RTE_MAX_NUMA_NODES - 1, so
the check is now redundant and is removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .../baseband/turbo_sw/bbdev_turbo_software.c  | 29 ++-----------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index 2cab495294..d6801d9123 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -1835,25 +1835,6 @@ dequeue_enc_ops(struct rte_bbdev_queue_data *q_data,
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
 parse_turbo_sw_params(struct turbo_sw_params *params, const char *input_args)
@@ -1869,20 +1850,14 @@ parse_turbo_sw_params(struct turbo_sw_params *params, const char *input_args)
 			return -EFAULT;
 
 		ret = rte_kvargs_process(kvlist, turbo_sw_valid_params[0],
-					&parse_u16_arg, &params->queues_num);
+					rte_kvargs_handle_u16, &params->queues_num);
 		if (ret < 0)
 			goto exit;
 
 		ret = rte_kvargs_process(kvlist, turbo_sw_valid_params[1],
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

