Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52954CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4848542D0C;
	Thu,  1 Oct 2026 00:43:51 +0200 (CEST)
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by mails.dpdk.org (Postfix) with ESMTP id 2B94E40EE7
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:48 +0200 (CEST)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0d31bda43so3719875a91.1
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808227;
 x=1791413027; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2m/hqeh1sZBK8cMf0fJSMKGgjxAtZKr6n5MxOD2Fq68=;
 b=E7nkFJ9peRT79UCMw4y2AV0gvkZGQlIlWjJHbZqGEYS11mdS9YcFxdBN9RGRemTXRM
 R7AK8QuKML6BXc369+PXdnMlG3JCB1PmPwM+GtRhgSRbY4mJ4VYdciEmh33ZfHjJeXLc
 XxLB3ANZq5b6Arx2NwO7FtU6cxNW+YgbRN2mAtCjr0+XlyxXBoF+9V03BwpOonWY3xRv
 SMBrcZE+fdtq9XWBqNyitHqHfk5rH70dQagmd5AOfmA+/vuqXaqm8MBS/k4AcXf5wpvj
 BPAADvewN8x3DYTavqEi89smJ69ylPFu6faG/9uMo7FGEzLd+0ZkWc/DMqmBkvvX+u1i
 eeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808227; x=1791413027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2m/hqeh1sZBK8cMf0fJSMKGgjxAtZKr6n5MxOD2Fq68=;
 b=v7VU/XfvlLRy9WVnGyMgJNDJQuT3539EmU91mmKFdjNwg/cVtFwujPiaLEnh6uDsUd
 AOfyXmw9ZxdeN111mU44mYvGrdhzs1Gc/PDfZGCisoK6UjzLFCtj8XLYGzNaD48Mcl+W
 HJBeuSzZNASRYh+KDaq/yf402Ub0CXJ2yzgL7IEs8qqvxIoK8ZfH49jbFGVLKml864Ip
 QqXRIp/hDBFd1KaJk91K2/dXncDAQpsqlA2FoCjn9l5RrNBXPd7pDsLrLvvSSTfMDjlf
 Gt7j8XEJkqvDCdwSYfXerKBe8igU+laWHaedpfn79Xh6WhxtkFjovE99FuwA8pxBZA4b
 TnRQ==
X-Gm-Message-State: AFq9FYKR2Hw8oHdlxnjigL68Qe3wGdhhcgdiLqd5bOKKDbDyBeOaU829
 djCM8P/8y4yCgia+uC+0E7y22vr9mzHiT5aUbsf2sahRh+Fm2Gbfs4l3NUXeU/2C4qA3bahxdOM
 Yf0WbB8k=
X-Gm-Gg: AYBFou0O9dDQTXvru62HiHZ1ydS706JaUpsF3A7qfXX/570U2NtLZNCXQ9LPRuv0mtZ
 1ltSAb3Qwho006CsTTMs5bQVmlM34jH9p1qNOwGu6NqvcCGBgJOdFfRTipZ50nGR8hjCpY/SA9c
 1MfdimeLCuqXTqHv1mYEyVrEoTPRWO0EApN5BveYKYInsDSEmAbcS5hQDp7Itn79ggrI/mftGTJ
 Y7HSYBwbGmizhQurtX0gdPGbgKVAvaSKIha6Re6Z00Jv1dpRO3rZpKe6516p0IfZPpF0DbTfVQE
 TfZSDKzeRGJK4Bsv0a5VogU6Ufy3WShmcJYm/acyS908JlZDtyyS7q29qg1TnRm3Wiytatdncg3
 QMcFz23Y8W0iMAc6FCwfdTLO8P0p8YMtfxy6kpPEy9XskiqvdG7Id/4CEWykLObedHXRMWuWj5b
 fUsIYeHGaXM5cQThoa+yngiDcPXvcjdDXw9eGOkOwBAPySL8XFm2VA/s/PDW2Ed7UUpZWw+TPMa
 DYqohB9P2HMyylX37aN2+qmycs+KlIucLPjUBwOmNPqYCMo
X-Received: by 2002:a17:90b:35cf:b0:39e:1692:34bc with SMTP id
 98e67ed59e1d1-3a4d11dee64mr2004579a91.1.1790808226855; 
 Wed, 30 Sep 2026 15:43:46 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 05/65] eal: validate memory size arguments
Date: Wed, 30 Sep 2026 15:40:23 -0700
Message-ID: <20260930224340.58580-6-stephen@networkplumber.org>
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

The -m, -n and -r options are converted with atoi(), which does not
detect any error: it returns zero for a string that is not a number at
all, and its behaviour on overflow is undefined.

So "-m foo" is silently taken as zero rather than rejected, and
"-m 99999999999999999999" is undefined. The -n and -r cases are partly
covered by their existing checks for zero, but only because a garbage
value happens to convert to zero; "-n 4x" is accepted as four.

The -m value is also scaled by 1024 * 1024 with no check, so a large
enough value wraps around and asks for a small amount of memory.

Use rte_kvargs_to_uint() for the three options, which converts the
whole string and checks it against a range. EAL already depends on
kvargs, so no new dependency is introduced. Note that this now bounds
-m so that the scaled value cannot overflow size_t, which on a 32-bit
build limits it to just under 4G; previously such a value was accepted
and wrapped.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..519307bdc3 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -9,6 +9,7 @@
 #include <ctype.h>
 #include <limits.h>
 #include <errno.h>
+#include <stdint.h>
 #include <getopt.h>
 #include <sys/queue.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
@@ -29,6 +30,7 @@
 #include <rte_tailq.h>
 #include <rte_version.h>
 #include <rte_devargs.h>
+#include <rte_kvargs.h>
 #include <rte_memcpy.h>
 #ifndef RTE_EXEC_ENV_WINDOWS
 #include <rte_telemetry.h>
@@ -2210,23 +2212,34 @@ eal_parse_args(void)
 
 	/* memory options */
 	if (args.memory_size != NULL) {
-		int_cfg->memory = atoi(args.memory_size);
-		int_cfg->memory *= 1024ULL;
-		int_cfg->memory *= 1024ULL;
+		uint64_t mem;
+
+		/* value is in megabytes, and must not overflow when scaled */
+		if (rte_kvargs_to_uint(args.memory_size, 0,
+				       SIZE_MAX / (1024 * 1024), &mem) < 0) {
+			EAL_LOG(ERR, "invalid memory size parameter");
+			return -1;
+		}
+		int_cfg->memory = (size_t)mem * 1024 * 1024;
 	}
 	if (args.memory_channels != NULL) {
-		int_cfg->force_nchannel = atoi(args.memory_channels);
-		if (int_cfg->force_nchannel == 0) {
+		uint64_t channels;
+
+		if (rte_kvargs_to_uint(args.memory_channels, 1, UINT_MAX,
+				       &channels) < 0) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
+		int_cfg->force_nchannel = channels;
 	}
 	if (args.memory_ranks != NULL) {
-		int_cfg->force_nrank = atoi(args.memory_ranks);
-		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+		uint64_t ranks;
+
+		if (rte_kvargs_to_uint(args.memory_ranks, 1, 16, &ranks) < 0) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
+		int_cfg->force_nrank = ranks;
 	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
-- 
2.53.0

