Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4333ECCFA13
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 18:22:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ACF24065B;
	Mon, 10 Nov 2025 19:22:17 +0100 (CET)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6D10040649
 for <dev@dpdk.org>; Mon, 10 Nov 2025 19:22:16 +0100 (CET)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b6ceb3b68eeso2084728a12.2
 for <dev@dpdk.org>; Mon, 10 Nov 2025 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762798935;
 x=1763403735; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QQeN96MK4AERxlD1kZ8+NVaFECjqeRGah07+zWPHbI=;
 b=2TSdbyo2FhHZLE4Fb8VTslxNvyNaRzmiZ9jhToY414a6CTdUjbFkAHt6mjAMBzalfl
 cbEnAThohM3uwPW5ZbuTfNAOigylpZSet5V+/OFm1I9GWNx+7k6qCDYUagPXhyT/ib5p
 A3K1hNj7J5wMvJJaYPcZMr81FO+gQNAWskCezv/K/0sylxuh+mOASV/bm2qSah7Xik2J
 ueyKqQ6MEDsiRfEfZtpMsiWL/kOaq/fPWh7S6Np7t+f2Zn65um65AnehMcSjGnKWIyhM
 LAqQg1HwOcFvBT8ZSZW5u7ZV194+2+k8u3jqyxYolGL139EsbghLIG+8cszbcgJF0VfQ
 209g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762798935; x=1763403735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QQeN96MK4AERxlD1kZ8+NVaFECjqeRGah07+zWPHbI=;
 b=fsWApGFj3hoDurVhu1XWSTPFiCt6WYr7i9t3QAzBvwcA8bcoaOpJrDrYUwSB3pT1XM
 WncBuDOBWRYi9bp0ZHwgHYO994m+BgM7FuZrAPY5O6LwLshtRiuGoIK1cQSwJH2n3EuG
 eax2+kITLvL3mJhGVFQ4Oi+eEcKuy7Rty9yjphwWIZyuHvqYTv1IqeecuT54jaQDkgkM
 9AKEGnSDpAFpbBg6MSznd28kRLn7Suhkgp7Cf+QBUBBTF4QWvxLLjZ9hJvkBR3j1ij99
 6yRabBJU9S2kjRE/fs7Wj3TMbPcwgA6hm+2QVCTnNuqvdX+ZPmLMx0mO/ovxge7XfnEz
 ++aQ==
X-Gm-Message-State: AOJu0YzYckPWomyE7DqDWruKbUeQ8RQM8zbWLJARFc+NNEreZLvVL0Wn
 xq9NfzfdB8SAajCx33D2v4Wn+/fWPccNAoLbOU/axLbja1EUOWfyHJ/zY2RkmREU3cr3m2Ue3U1
 LkMjS
X-Gm-Gg: ASbGncvCEP1Jkydt7TSBDEpZUzKRBou9NildvPMKeSpNhN9mtQAhGBVKnuM5wDsaALW
 S9mlJVDSjbduXrkSx7uYM44G7Ag87/YjWlAlKbh05GZLmAVVtfzjegxrkuCMHsQZ9li14Q8dXkp
 KPrv2uxQv9I7q+tnHQ00TQu80TqLMrWLSku/DpKUKHFOU7rrEXp0iX3g0b+NKgHEaaNPf3yWgpY
 Pm5BFNGYIPJHJmAejGRGLpk+1T15CBoOlIuchn/jROsUhq8hvkoHrQdDDcFri3jZegHvZF+koco
 V4k6LP2tzfwDB9uFLWisTyO5Mc00oLj1sv3PLGwSbHovZdASgpsBpY57thGQQqlmsZnHScl5k/9
 AWncnEXHM0Sul8k8+SYZKd34yvmM4wKInofB3/USpM82B2cTUokn1cAwULQ8NxRY9lJsTz1na5N
 Bz76Wdi2V8iSAuKmG7m3ZzzeK5tfgAEwl7UIRbIKo=
X-Google-Smtp-Source: AGHT+IFt8fSQuFbYvaqYwGwbkvbSRxEAcoOtwjnxD8iCX4oMUdbLhO/XWtkI7gDLDXtCO+Nu4vs+Iw==
X-Received: by 2002:a17:903:17c5:b0:295:4d97:84dd with SMTP id
 d9443c01a7336-297e56f9d37mr111815045ad.51.1762798935190; 
 Mon, 10 Nov 2025 10:22:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650968298sm156290405ad.6.2025.11.10.10.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 10:22:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, maxime.coquelin@redhat.com,
 stable@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Adrian Moreno <amorenoz@redhat.com>
Subject: [PATCH 2/3] examples/vdpa: fix format overflow warning
Date: Mon, 10 Nov 2025 10:19:34 -0800
Message-ID: <20251110182209.104087-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110182209.104087-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
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

The ifname is limited to 128 characters, but it would allow up
to 128 characters as prefix then could overflow creating ifname.

Change to limit path prefix to 124 (128 - sizeof("1024"))
to avoid possible format overflow

Fixes: 38f8ab0bbc8d ("vhost: make vDPA framework bus agnostic")
Cc: maxime.coquelin@redhat.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/vdpa/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/examples/vdpa/main.c b/examples/vdpa/main.c
index 289db26498..bdf751ad63 100644
--- a/examples/vdpa/main.c
+++ b/examples/vdpa/main.c
@@ -22,6 +22,8 @@
 
 #define MAX_PATH_LEN 128
 #define MAX_VDPA_SAMPLE_PORTS 1024
+#define stringify(x) (#x)
+#define MAX_VDPA_STR_LEN sizeof(stringify(MAX_VDPA_SAMPLE_PORTS))
 #define RTE_LOGTYPE_VDPA RTE_LOGTYPE_USER1
 
 struct vdpa_port {
@@ -36,7 +38,7 @@ struct vdpa_port {
 
 static struct vdpa_port vports[MAX_VDPA_SAMPLE_PORTS];
 
-static char iface[MAX_PATH_LEN];
+static char iface[MAX_PATH_LEN - MAX_VDPA_STR_LEN];
 static int devcnt;
 static int interactive;
 static int client_mode;
@@ -74,9 +76,8 @@ parse_args(int argc, char **argv)
 			break;
 		/* long options */
 		case 0:
-			if (strncmp(long_option[idx].name, "iface",
-						MAX_PATH_LEN) == 0) {
-				rte_strscpy(iface, optarg, MAX_PATH_LEN);
+			if (!strcmp(long_option[idx].name, "iface")) {
+				rte_strscpy(iface, optarg, sizeof(iface));
 				printf("iface %s\n", iface);
 			}
 			if (!strcmp(long_option[idx].name, "interactive")) {
-- 
2.51.0

