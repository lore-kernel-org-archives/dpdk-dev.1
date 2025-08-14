Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B7BCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 16:53:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B315427CA;
	Thu, 14 Aug 2025 18:53:22 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 450E5427B4
 for <dev@dpdk.org>; Thu, 14 Aug 2025 18:53:21 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b9e415a68eso638352f8f.2
 for <dev@dpdk.org>; Thu, 14 Aug 2025 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755190401;
 x=1755795201; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGyukfi9kUcYHBak2qXLHR2j8E4WLyo1o5cGnOn/cTs=;
 b=XC+leabpNdpqhSYPZtZNiR/NMVOGwcpFr5vxn8nmBBybUQbbQpLUFnOchQ8u3hlUwX
 j3T9ywJRjMBJ6p+kSnJGEBgAvulKUtVJjeSAhnCGMDOY2FyHR+W3MBEc7rrVIUc9HoPl
 EucJmO/86fva43FSwzC90kx5vRNg7+ZpMiEBFe4k1tsm76r9gEa7GpEWrK+BAqy/Et4A
 8QLa/8lozPJRvYLx7RwEX2s20/IxIt2G1VONRguwJGCwf5dTBLEt4CdtiuPhauLFIwLp
 BEjxuUOdQj6sKmMpaVhRGe7MWQdTmiIFT/HVtl/nKPMPGalp73zfuvBiQWLO1qBR6p7l
 zeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755190401; x=1755795201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GGyukfi9kUcYHBak2qXLHR2j8E4WLyo1o5cGnOn/cTs=;
 b=StqYqaHBe1i86i6nNeG9mCZVWUkwfsV1VGQKDY5fj9ZjfioN4rRRN7IbkxX9AZHpyl
 Qni0mnU90rkGRd1adUev71kOxS629zfqRXAfmeX61Bmv6SDCwx8TvyCDlBdgZpBlmtZw
 2l1kM+5k0CGpfOival8hgR7Z1eqAKBiC5zVlFhKfRcfgKIpiVn69iCWUrmfB3yJbc8DU
 9H/yMSEtA3DcFROF9jNcpsN9U9vqdW+iTLdvWTvWbt/ir9uwQ5Mft4YJS7+asCIAzeJt
 HHq1ADNr/2nxk/5GUyujmqjqdN5nHMJDz1C7lrIiCSe2wGV3+aHErlzA9jME/59FqIee
 iYbw==
X-Gm-Message-State: AOJu0Yz0xkGltWzxvne7JYptOXQ/fARc6CMssim21JuSPR2QMjy0pKAv
 QVaUlHR1GNyNEIsiVbPxS08xJJL16nCNkl6N3UrqbQm9wntGu8yUVJsk11/rDGzlwGKGivKQ0r/
 umGoA
X-Gm-Gg: ASbGncu5zyi0SICX+sC8MTy36c3C6XtaSHAXUMy+TlI2bpsKWYOTc+it166R3tm4kVo
 ZAb7IjONVJ4JwfmCDCZvBHqRGs6sn8kDfplu1wsIJiL0o/mT/M9jntdgu8FAkhc7+xTcWZKBjVb
 TPTJ6LKZSopAn/4QdoHG2tmkgFjv/YQPtBBX1kQW4lO9xwDcburVmCH5mQKG/jsSLK/hqptuRjd
 +8cMIWFx/d9wynsLcCt9CYRnoWgeW+d72rrpsHhok/fzqBbwuzbWH8An+lAkqiCuC7TQn9b7iXn
 DHIxreMSpTTZFjhgdjoAP8KoB6OpZg+NmFUAWN/nSIXTA1QoRRtCocHcYtik+njq7kTFX2KK4Iz
 Jrr4ApoyzFLZguo0HTNPAFTyZoZxCvTggdZqwaQCLQkFAVldLByNU8BwZaX0tCS4zvvPsBFlA
X-Google-Smtp-Source: AGHT+IHCc3yc93kgWXUJwU2G0aRPK4Y0sm5bsLaJJkHaRlovna7v0Hw9GZ2vFLTmBse1BSjD5uSl4Q==
X-Received: by 2002:a05:6000:26c8:b0:3b8:f8e6:867b with SMTP id
 ffacd0b85a97d-3b9edf360cbmr3126674f8f.31.1755190400825; 
 Thu, 14 Aug 2025 09:53:20 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ba54f87e17sm1748197f8f.23.2025.08.14.09.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 09:53:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v2 4/8] dumpcap: handle pdump requests from primary
Date: Thu, 14 Aug 2025 09:53:00 -0700
Message-ID: <20250814165307.12786-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814165307.12786-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20250814165307.12786-1-stephen@networkplumber.org>
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

The primary process will start to notify all secondary processes
about pdump changes. The dumpcap secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/dumpcap/main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index 7b19c830b5..c734fc7b9d 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -528,6 +528,8 @@ cleanup_pdump_resources(void)
 		if (intf->opts.promisc_mode)
 			rte_eth_promiscuous_disable(intf->port);
 	}
+
+	rte_pdump_uninit();
 }
 
 /* Alarm signal handler, used to check that primary process */
@@ -659,6 +661,14 @@ static void dpdk_init(void)
 	if (rte_eal_init(eal_argc, eal_argv) < 0)
 		rte_exit(EXIT_FAILURE, "EAL init failed: is primary process running?\n");
 
+	/*
+	 * Register pdump callback handler.
+	 * Primary will notify all secondary processes of change.
+	 * No impact for this application, but need to reply.
+	 */
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "EAL pdump init failed\n");
+
 	/*
 	 * If no lcore argument was specified, then run this program as a normal process
 	 * which can be scheduled on any non-isolated CPU.
-- 
2.47.2

