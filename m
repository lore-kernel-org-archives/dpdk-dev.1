Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C629C531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 17:45:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D310A40658;
	Thu, 23 Jul 2026 19:45:26 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3B91640658
 for <dev@dpdk.org>; Thu, 23 Jul 2026 19:45:25 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c999f162c9aso741253a12.3
 for <dev@dpdk.org>; Thu, 23 Jul 2026 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784828724;
 x=1785433524; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xMlrDmPqrDQAaQ78RI5MfLi6RHduOLgn3vivF5KWRoc=;
 b=OzSjwv4NaCCREcRECeO94kW+uCTfPK5bR0FoDH/Vjl3udZXI2jPxSU7uwvOkBzT/92
 2fvIMTp+9UlX7bNpMmxwBaZbXAqBhvJJeRj2xCOHrtlbn+QH/AoqdzpVJwENJWmviD6G
 EzQhPCuZ93saSPymgMOtitvJ9Rr4uiTxlnE3dyvl6BSblkFixHRqxcDO6eQiifTIUfRV
 lKQwBxaYrTvEsDpp+xO9xyWvQvr/IXS6ZWiS6yqB4BO1/8/hRsP+4CRgcIG2vEB2UZuZ
 iTMjl2QSilKGuTYBhwEpG7WlredO2g+7nOEUh8pz/lYiJw7I+nxccjQ0f8FZwS9p6LkM
 J99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784828724; x=1785433524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMlrDmPqrDQAaQ78RI5MfLi6RHduOLgn3vivF5KWRoc=;
 b=Ims/+1sUJHVMelRH/cXZsMeSOzLueZaTSpJUDehBwneFL0JfC6qfHedu1WieGXBNZ4
 lIfoDayihq406MMH31hpCu+73MwS2wuE5tDgYZRd9XZE6N/PDEB+/R3zUdlkeLfOFjUw
 KUtHext0Y6cRJXiaM8KXEJU85+3fuQgcWquA+BAffOfGPUI3s3sG8rGIZ7vdG50pcFLl
 q3h87tNQdNDbyCffCyNsaSAtweEVfLosx8LrR8HEuiqWAVDV5WjWMxxM7X6e9uxGJEoA
 P05HcrkunhZ8LxK2IdIY/2vYWsvHS6Zmw3QD/MzwJ4EtcPCWAaUzyf5tFq4+VXCruuCb
 G09g==
X-Gm-Message-State: AOJu0Yxy2Gec+94KY52PavWq8aYYq1j6xZva1qHqTRDFZnmNH0rIocx0
 X2G+dGv9d8Sv/XumE/j+OiBWn+qLf4C/NfWbM36bXoX7CueZ1mnDQ7R0utjUnKdXDkndiryI0IF
 UlWok
X-Gm-Gg: AR+sD13plEasSbElQLJjTpXSdpDtMzYquImrUy3dbkFqDWDOr6WIPc8p5UsmNyrAgAu
 h9fnRUITmzoX74c95Ttcrnvr1FNINUHEMYHLksSZBu9yq+ENmr9Ty/jzQjrDFdpxTXAUa76dQPi
 bvwgCrUof5XVgqNV87UCS4WgRieA1kSLGTVO7mDRUyzc0ImZPzYUxa3QKtqoV34LQPuLcFRBGXe
 2F8TMFjVWkbsf4n2z3mlM/Tr8s/yg21FiA8skbTSvieXVH+B3fl9TkeUPH0Ek/PyEK8eOsRJdml
 Yb2Eg6HjddubOsaNAn8x9GbwpOnksskG8V5dbDju9C0DNjkeR81gfjexzzqyHYxIdZzdbxdIGlu
 bU4XgO4trs7p+aI5K2BfPMKDl6o4qmjhajBXIccsk4YgZATrZbfBxH/17kCt+jimYOG17WG5ZtK
 Va5FqbQqLRRiaNIigUONkT/8t3OP7fYhwC6ujLj+ar
X-Received: by 2002:a05:6a20:b090:b0:3c4:397a:69be with SMTP id
 adf61e73a8af0-3c44afde4b3mr4628734637.19.1784828724075; 
 Thu, 23 Jul 2026 10:45:24 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm22579754eec.25.2026.07.23.10.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 10:45:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] eal: check for invalid memory parameters
Date: Thu, 23 Jul 2026 10:45:21 -0700
Message-ID: <20260723174521.176147-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The code to parse arguments like memory size, channels and rank
was using atoi() which has no check for garbage after the number.
Switch to using a helper that uses strtoul().

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_options.c | 44 +++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index 42cdef632f..bda60e6394 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -2067,6 +2067,29 @@ eal_parse_huge_worker_stack(const char *arg)
 	return 0;
 }
 
+static int
+eal_parse_num(const char *str, unsigned int *val)
+{
+	char *endptr;
+	unsigned long n;
+
+	while (isspace((unsigned char)*str))
+		str++;
+
+	if (*str == '-')
+		return -1;
+
+	errno = 0;
+	n = strtoul(str, &endptr, 10);
+
+	/* Error if string is empty or has trailing characters */
+	if (*str == '\0' || *endptr != '\0' || errno != 0 || n > UINT_MAX)
+		return -1;
+
+	*val = n;
+	return 0;
+}
+
 /* Parse the arguments given in the command line of the application */
 int
 eal_parse_args(void)
@@ -2210,23 +2233,34 @@ eal_parse_args(void)
 
 	/* memory options */
 	if (args.memory_size != NULL) {
-		int_cfg->memory = atoi(args.memory_size);
+		unsigned int mb;
+		if (eal_parse_num(args.memory_size, &mb) < 0) {
+			EAL_LOG(ERR, "invalid memory size parameter");
+			return -1;
+		}
+
+		int_cfg->memory = mb;
 		int_cfg->memory *= 1024ULL;
 		int_cfg->memory *= 1024ULL;
 	}
 	if (args.memory_channels != NULL) {
-		int_cfg->force_nchannel = atoi(args.memory_channels);
-		if (int_cfg->force_nchannel == 0) {
+		unsigned int n;
+		if (eal_parse_num(args.memory_channels, &n) < 0 ||
+		    	n == 0 || n > 32) {
 			EAL_LOG(ERR, "invalid memory channel parameter");
 			return -1;
 		}
+		int_cfg->force_nchannel = n;
 	}
 	if (args.memory_ranks != NULL) {
-		int_cfg->force_nrank = atoi(args.memory_ranks);
-		if (int_cfg->force_nrank == 0 || int_cfg->force_nrank > 16) {
+		unsigned int n;
+
+		if (eal_parse_num(args.memory_ranks, &n) < 0 ||
+			n == 0 || n > 16) {
 			EAL_LOG(ERR, "invalid memory rank parameter");
 			return -1;
 		}
+		int_cfg->force_nrank = n;
 	}
 	if (args.no_huge) {
 		int_cfg->no_hugetlbfs = 1;
-- 
2.53.0

