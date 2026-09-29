Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E60CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:39:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A48C42E84;
	Tue, 29 Sep 2026 18:38:38 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 0CF6242D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:19 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469f204f6so2147431b3a.2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699898;
 x=1791304698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CmTPFHnSyhzxJ57Fz/492boTQpob9X7I9uaVcIVOUuY=;
 b=EII172xzLB5ET39c+7w9v7pCKn4n00kJ/jrW0bgYLeG1Tj5vMEL4JXlTBCMWj2gxu+
 u5Lo/UvAgz0FQGMGh0wszqS7S7MjMhSjpobAiGSXLCeeEJugSX0IfnGYj8P879M64Pkd
 dVjrCceR64yJnUlB2r8xmPY2k54u77tINs7SDEpI1lSjPtjNAlV7esBbCf78hTq6fHx6
 sj/gg284NmONjjp2J54/jPqeNalthsgCWQS6aJSWks8gCe0EsZcC8qzKGAXUH2HeXGmv
 E7sbG+sWUEkz2F5W9A4oKzS3+nHLRAqRjVUVQEx8NUfpfmvln+mcVrJDLqCU5e0t4tba
 I1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699898; x=1791304698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CmTPFHnSyhzxJ57Fz/492boTQpob9X7I9uaVcIVOUuY=;
 b=uiqHsVdT/g1ztjtVCZH1vV4IIpAkz4zvv89Agxnm96Uy/avq8nFdZh4mnsxTqGfYvN
 B+oi87G/6Es178AJP8wCcHSnOQzMTMjLn4SmIDSt+NWiInLSzQhX4VqHMsvEo8WAzYQP
 TU9F+KwPesI/dTKsuPYvva/pP1EF8Xqola1C4Fkds22fCD13geqMtqNpYDvthxVHehe8
 mCA7VTJzViANmR6FmVUyR9bAKBZsajvEwNWOqWqsIaiE0hTSpdvYMtOIZPvNKkD7fynl
 5KB3YEqYmzQou8DZ1Nr26GMEqE1sO9Bxs/5k9IcM0TLz2+Nt3JMQoc4EX03MWyaxR6CQ
 1C2Q==
X-Gm-Message-State: AFuF++l/8G8ItTDcY26UasBBQluuHpdDHi175MTpdly4Aw5W32bl3GrT
 hdieQnKVlvZWz2f9U2FLxi3zqdVQwjSz88fnrkJxxLgFvnwSkuWM10pMeDFDYy5qTjdm9TLnwrt
 s3q24Vsk=
X-Gm-Gg: AYBFou1cONl0bgF1na1msWADvqH9FNBMBsSi1BHyYwUNgAYz2zjYhh2Ugb/2lbX8I3I
 VMIPYQ6W0rdE5nONJ/GgCU6SNDBKksnQEEfr21Sswzu9bTXxSdT5eqwGks9a8/oPzc7fOsqsdQu
 O8wWqfRmjrA0JuR6kVppAAxuEzU0t/HDuN+WTWl3ejk0k8I2UyA09uoEoARZp21iPWCx3TJPcfv
 G1iLbO+mjWvs08qDMd35UZjtNFhcSjD+GTu6ov/gCIvd/mb1XOuITHGMxfEK9lNGY3Ttwr8Td82
 gKn/2gUXqHaeTKGnssp+ZuUYsR0+tr7b0lY5VnuEssPiIyvpTqJAx6UyznGhZ7xg2RDdCwCR4Y3
 QCtzvAFixn0loureDiy6vM1XmTHheT5d0O/9evXugAcdAp/bIOaXm+XdX3PIuk3LdjTI3Zz8N9J
 CNoyCwCdHMtCIw0V4OuO5X3rOhJ2Egj4KyESOEDcVdN0GRKFjxBlMoiFNxHnYr+ueFrqYIq9rPl
 aviUuAFkCc16bGgdjNGgf1O3JpylI3mFiZAFoJGvSUR2tA2
X-Received: by 2002:a05:6a00:3d10:b0:886:77eb:38fb with SMTP id
 d2e1a72fcca58-88677eb39a8mr601058b3a.25.1790699898174; 
 Tue, 29 Sep 2026 09:38:18 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Amr Mokhtar <amr.mokhtar@intel.com>
Subject: [PATCH v2 11/61] baseband/null: use kvargs numeric helpers
Date: Tue, 29 Sep 2026 09:36:14 -0700
Message-ID: <20260929163800.1108305-12-stephen@networkplumber.org>
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

