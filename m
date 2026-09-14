Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A6C88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:54:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA6D141109;
	Mon, 14 Sep 2026 07:52:31 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id A351742E45
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:52:29 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-398c066106cso1275422a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365149;
 x=1789969949; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3qyCdqIWL/PVCNyHFpXdONh3fm8Sb5qZOA0FHeH9Lk=;
 b=qkcqWzIm1bnOOBBksFAcBFGYHC/Hw4GJ5X/1HZqGa3qmi/UU9qWa+BGonUdQJnLvCz
 yvk9F+mPUbDEJ78oEdD+oTMwnsOJEslwS/zWyDh9VgGUZ+4M0oL1qNE3hVrRf6KlF/UI
 60hhIg5DfJFCfmTf3Fz82sCbsNZZflGh3GbAK/EdlEJRjEIGRpLzHdlQuzsLEazviHQ9
 UtRhSOew4lEJMG1S86adnhBSk8tfBpyaScVevekKGbbOWBNgU7ENdUEJVscBjdao0EwX
 k/auA1cbOkkhUYrTcMIppkjVnzTG1D2qrkMhHBwMb+VEjOM4CIpSz+mRgOElJ09XGjEk
 1tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365149; x=1789969949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+3qyCdqIWL/PVCNyHFpXdONh3fm8Sb5qZOA0FHeH9Lk=;
 b=rMjPvLnVdWgtUh3n2tZn9JOfFq+8DLosDh+u8Hkt+whywAtlA7rCXrnqOnD8u7Fye3
 bsbQQlLogf13WLdvEXPrSr+f3Bk7Gou0iajzezY2miZw089+osR8QZ2u7EWyQn5iQiQS
 G+j//GK8RTKxk0NvbfUwYPlh3J7d3Lq69ZEOEJlFsre5272ArdRLhkfSuRPCTrxSrXF2
 wQiWg219Z1HbGEP1T2jOVFGjNwGbB+0B1RAJP+NtGHbA4TKj8JPa4OKqZ2G+2IKpelxd
 J8Q2irFQP+h6HC7fFXRf2eLongdPcGs9LFU0aEkwPE0+/4erx44hNomok8rf6e0Yg/kk
 WakQ==
X-Gm-Message-State: AFuF++kQSRnUTOlWfkCFIbfEKYL3lB/bNDSpqNoATf/1xCDuj7Y2MfJ4
 17c1MQHV9lyN5ELp5u3x/xhKjzkeJcyCXwfFu/QVPYwSz1EMly2Z6MOcs4uj1gUxxo85PmDQILz
 hVpmV0PI=
X-Gm-Gg: AYBFou3ncjFXrlH9kT215or2EgMNbboe48F4oGzwsvjUi33tT+4R4RskWf222dwWj52
 lREuxO79xggWusPaPvUcPcHshfYkKl0hBaoIpWEooMQqOdalETeSX3hHz/5wJyBj/KM5Mi7CJiH
 EJyc3dMfMa4PBkNlpsi8bN27K4qapSFi9Tu53MDxg8wemqYhoiakBFHfCug3bb9RAzCrDzLEj+q
 8RBnxyzi2jZpc8I9Lb48PvFNeqW+bG0DqUuApggvDrHw59jVjBEn9qzpGY904/QZaCfviJCnzEG
 4kPHUHj2SgWsira9pwKShP5c3KI7b6HACxYoggO8klJptd/NNSji0j6IX0DyHDGGiKM/Vn6Ey7B
 AWdHpoi2wg+9o7Ggdoc5XnvV/wp9MGF5iWFlgBvmLv/PatbnkhbNF72ic4iptxuFr6ffBps5Z7r
 BECyQ/iBUhFIGC+QgD0UGmWG8PYhOGsP09ge6Zx7YeUewjSauxf+vJhCUqML2wT/qtKmuDGR24I
 pgP7aKbTH2lN9J/lYjl1JehN5b7AUGbqTapaA==
X-Received: by 2002:a17:90b:3ecd:b0:39d:ba21:fd90 with SMTP id
 98e67ed59e1d1-39dec04f01emr2222153a91.16.1789365148772; 
 Sun, 13 Sep 2026 22:52:28 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:52:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH 55/62] baseband/turbo_sw: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:26 -0700
Message-ID: <20260914054912.755403-56-stephen@networkplumber.org>
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

