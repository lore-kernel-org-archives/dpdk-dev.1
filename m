Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EAEF99CF
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 19:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98D8C40653;
	Fri, 13 Feb 2026 20:21:00 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 9D91340677
 for <dev@dpdk.org>; Fri, 13 Feb 2026 20:20:58 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4362197d174so870770f8f.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771010458;
 x=1771615258; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2znjy+YNnzKqlWl7RZMdVXJaPQsQ36K5jPLerxUZ16g=;
 b=FM+7lsHVMth7Illov2jvTGriXGZG9iPwZXKWhc1vPkHOZnIvYo1I1CpnNX3ZxlitpO
 wOZ4Kt9TuEcXnjlDYdePFbvq51Pr2R3+qHlX5AfpwcZbndKFGHHbR9AgsLqB6v5LGm8F
 vx3OLy2lllYn6EPuDXp1y+nqgeaky1ME1lo2n80L1FBgzUGZBNnTdCeUJzxBM2MfufNP
 DNWSGnbvbD+kWqXKYea9HW/D02Dq1qL5N7oPjXqjyF+m2RTYAZhiVOiNt0loVK2NRd+T
 f3SGGd3RLtjR6gEsnyiEkp5TY/M3Cm1ilC+cw4hG8J6Xlm2a5lZhPMpjQ5s9ir4PuM5P
 /pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771010458; x=1771615258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2znjy+YNnzKqlWl7RZMdVXJaPQsQ36K5jPLerxUZ16g=;
 b=Yc4q8V5WRALI7ygaMRdI55loywkDpDQ2xLIiuYLIhnQmkMc4YhbncVidnAH9nFoeDf
 XiDIp32BEMk9rlsFBttAjl/rlPAoF82/v2PirfytO3RAhxPLQPjJ6+J4jaCQ6PUjagTy
 bXKIQjyxYDYDYzw3AS2OmTg++HNfEbBNer6wLnhmK22czhEpZeyt0xslGgiInRldk5V/
 H/X4h0nqaK+DCdFMfDbcIlCzOrIpMKjwWMDR2v3DkkG2sARHR8pnJdYtwOfavdK/bLmE
 e6HYVS+2kWfUg/31cyMrG+YVZcrn/fqDfypAWQryRCWw198qvkh05jZiDKegYsx0k2N2
 zhGA==
X-Gm-Message-State: AOJu0YwRncMmwuz7pdcs4vj/N0NDwvbuct7ePBjUIEMe8boluphSNORk
 fC1znj1RPtsu0BXEQwaeEXhzPyBMyAuGTQf2vR7+L3maXZBG1tZJ3EPk4eW/zK5w//ySCfoysSr
 E5U9w
X-Gm-Gg: AZuq6aLaNL0F8Vu23T6zeCS4tzBZi8YpxwSHu+h5s5zydW25C5EVv2mjXslOGDTk94d
 3c9B44s1AwTxyu5KTi6d+26WrK/o7CGIECvunmRW+mq7SnxphX0+dg2M6ybUC07Ij1l8eE3JhG7
 6eij5xoczQchsXPl2GA5btPfj8F9l+dx/8/oRAaWNzER/YptOYLSLXKtMurrRvPI1DKtA5MKoat
 ybx5g8DygbO+EnGHAtqzepQGAM7QEEIrqCNqNPSc3vRKCWooq0+5cTnit8SyEIdVmpferBWwglf
 LoN4omO2QXE9OXxBZQXpDhfZuI9ZEEYoHioTSprzrSSioI3DLcSKeMNwFQ2TQr3M+T48zvCbD5m
 pGAPUGMPomLGy2W0ixXm4K2JATUaNxLf71x2Z+ljEsixjpmWpzX3i7/vOaDRBKD2m+To7hOBY80
 ICzh430qlfoFVM36kH6pv0b4AOo6TmVik5dVsIaBfofFULN8QejuPgj6RnBABSClLEK1rZDs+o
X-Received: by 2002:a05:6000:2dc7:b0:435:9770:9eb8 with SMTP id
 ffacd0b85a97d-437978dc6famr5627439f8f.25.1771010458120; 
 Fri, 13 Feb 2026 11:20:58 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm7758723f8f.31.2026.02.13.11.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 11:20:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v7 7/7] dumpcap: improve pcapng error reporting
Date: Fri, 13 Feb 2026 11:18:24 -0800
Message-ID: <20260213192039.221213-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213192039.221213-1-stephen@networkplumber.org>
References: <20260126210615.175816-1-stephen@networkplumber.org>
 <20260213192039.221213-1-stephen@networkplumber.org>
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

Print meaningful error messages when rte_pcapng_add_interface()
or rte_pcapng_write_stats() fails instead of silently ignoring
the error or printing a generic message.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 46a6cb251e..f105ee92c2 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -587,9 +587,16 @@ report_packet_stats(dumpcap_out_t out)
 		ifrecv = pdump_stats.accepted + pdump_stats.filtered;
 		ifdrop = pdump_stats.nombuf + pdump_stats.ringfull;
 
-		if (use_pcapng)
-			rte_pcapng_write_stats(out.pcapng, intf->port,
-					       ifrecv, ifdrop, NULL);
+		if (use_pcapng) {
+			ssize_t written;
+
+			written = rte_pcapng_write_stats(out.pcapng, intf->port,
+							 ifrecv, ifdrop, NULL);
+			if (written < 0) {
+				fprintf(stderr, "Failed to write stats for %s: %s\n",
+					intf->name, rte_strerror(-written));
+			}
+		}
 
 		if (ifrecv == 0)
 			percent = 0;
@@ -760,7 +767,7 @@ static char *get_os_info(void)
 
 static dumpcap_out_t create_output(void)
 {
-	dumpcap_out_t ret;
+	dumpcap_out_t out;
 	static char tmp_path[PATH_MAX];
 	int fd;
 
@@ -802,19 +809,20 @@ static dumpcap_out_t create_output(void)
 		struct interface *intf;
 		char *os = get_os_info();
 
-		ret.pcapng = rte_pcapng_fdopen(fd, os, NULL,
+		out.pcapng = rte_pcapng_fdopen(fd, os, NULL,
 					   version(), capture_comment);
-		if (ret.pcapng == NULL)
+		if (out.pcapng == NULL)
 			rte_exit(EXIT_FAILURE, "pcapng_fdopen failed: %s\n",
 				 strerror(rte_errno));
 		free(os);
 
 		TAILQ_FOREACH(intf, &interfaces, next) {
-			if (rte_pcapng_add_interface(ret.pcapng, intf->port, DLT_EN10MB,
-						     intf->ifname, intf->ifdescr,
-						     intf->opts.filter) < 0)
-				rte_exit(EXIT_FAILURE, "rte_pcapng_add_interface %u failed\n",
-					intf->port);
+			int ret = rte_pcapng_add_interface(out.pcapng, intf->port, DLT_EN10MB,
+						       intf->ifname, intf->ifdescr,
+						       intf->opts.filter);
+			if (ret < 0)
+				rte_exit(EXIT_FAILURE, "rte_pcapng_add_interface %u failed: %s\n",
+					 intf->port, rte_strerror(-ret));
 		}
 	} else {
 		pcap_t *pcap;
@@ -825,13 +833,13 @@ static dumpcap_out_t create_output(void)
 		if (pcap == NULL)
 			rte_exit(EXIT_FAILURE, "pcap_open_dead failed\n");
 
-		ret.dumper = pcap_dump_fopen(pcap, fdopen(fd, "w"));
-		if (ret.dumper == NULL)
+		out.dumper = pcap_dump_fopen(pcap, fdopen(fd, "w"));
+		if (out.dumper == NULL)
 			rte_exit(EXIT_FAILURE, "pcap_dump_fopen failed: %s\n",
 				 pcap_geterr(pcap));
 	}
 
-	return ret;
+	return out;
 }
 
 static void enable_pdump(struct rte_ring *r, struct rte_mempool *mp)
-- 
2.51.0

