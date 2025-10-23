Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF715CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:48:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B085402E3;
	Thu, 23 Oct 2025 17:47:59 +0200 (CEST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id D3084402DE
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:54 +0200 (CEST)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b62e7221351so851669a12.1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234474;
 x=1761839274; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6xPyzbUG5UjnmpsRz5YG4ME+8zYRx9mBZSPXn4krcus=;
 b=yHZiyhLO+2ZYeKvDZkrWrONc8048SZu1mVGdEQtoXw4LFxNubqhYKljHdcQ070y3da
 xpSvVB557i3oA0nHbhVzaCfyc6IIdPGra7fRo2PKAotTcwhhgMd1q8dkW3i0ZXBzcCUx
 Vdf8JQBOaKGrdhe2dC0n4aobC1jr6Rc2PXtijckMhkPgQ4RGPxDoQx/i7O+Q9dbXG8Pv
 l6VPDbPyuHl5LmdP38dQiQl6CdQJ0FLbyJh3Jts+SZ1T3PVmBVGNMk2lhyGiXD5HMzFG
 AmlxRRWvNuKRaDNullyyZHTrU5nS5FMjbV3jXHMKtE1LYLNWKZtvykSAewOxNHJDjRRj
 V1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234474; x=1761839274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6xPyzbUG5UjnmpsRz5YG4ME+8zYRx9mBZSPXn4krcus=;
 b=nw6z7snHeKlzJdYo0yFaLTtjsYdCBQ2nVpwPdGn1iF6xUPsC8+innSauC9mzz5XK8o
 ZqDTjc4W1cZ/o/lWOVX//7of06HIK7UMEGzpeg0mSqD2XkrUaqGeXAf/gUmCbaScXTwM
 sDYLjcxEuUe2tnlxowBeCJIc2WIRsx/TZbXZ2Hc9cpRZwTZMmf3RdMtGgyZkipXKX2cu
 Lgzwl95FZs1ZSnvK6KIqIOpml+EsJ30QXzB0VcXAa8DqVW5VvFkDVdBqZpjKAg0c23JX
 pChX+Txw8jbBKq85NrsatTAtx/r4pMVJ0ul5J3ty24FAYQS1NEJnFpHEDlhQWMTen+TJ
 xmKQ==
X-Gm-Message-State: AOJu0Yw2AdmrJFEyBQKIvKytq4JUdeq489K6Q0I+3TG55ug40kvDU8qj
 6keV4Z33zMLv/Aidqh9V+KaHhCNbcsoQBZsVRmROWzH6rK2AWg/y3tq+CnEAjZwgjEGSFzU+r2N
 rzyZAfDU=
X-Gm-Gg: ASbGncvjoCv/vNtimAduq9QrIFEJvccVMSCdpL+TJFuQszAeooNgwXd0qtjHYJvsKEn
 U41fmOaYEMKTU+z3blTG6VsZORZmW73dSmbD+0F7zLCDUZ/t841jhgIiwon5gHSGGavhS3nmLhv
 O2XNZCheMJOnFLggUjIWwd4N6tdennMNA9ddyEmrimRK/Fim24Dq8sfGRH/Ke42APaVyIB+Rj2i
 nwnmbXP7jZO2ZbtRa8HqWsGtb1bQAMZ+z4uVNoQGpe1pU6l2BQVZO9a2x9OtDZWlZiMUk4JdQLd
 BnWLs/y4Zxm0dfij5NW6XniviWfKGQxuSc5bKIU0XEuDd3P04cnQYusrFPs4HvoqlZGjW3vGyfg
 qzrhjOQvsNjx2W510IxVwbZmirzM0uArTY0CDj2PXB/5yr2eR6IoAS4ecCQUXSQH6Q3K+BfG8dN
 fygotuwpG3V6ThPnumtczKn5EjDxGfpr3s920thw==
X-Google-Smtp-Source: AGHT+IFspfvbX7/BkdO8E5gVV9yN7HtqueXrhgpYfNwp6cwiYH83LjmZqB/Fgsqyvq2ixoqYzmpxvQ==
X-Received: by 2002:a17:902:e849:b0:269:63ea:6d4e with SMTP id
 d9443c01a7336-290ca121e0amr295890595ad.37.1761234474013; 
 Thu, 23 Oct 2025 08:47:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v4 5/8] pdump: handle pdump requests from primary
Date: Thu, 23 Oct 2025 08:46:26 -0700
Message-ID: <20251023154748.38535-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
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
about pdump changes. The pdump secondary process can just call
rte_pdump_init() and it take care of that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 1741d7e709..626ba0ce93 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -552,6 +552,7 @@ cleanup_pdump_resources(void)
 		}
 
 	}
+	rte_pdump_uninit();
 	cleanup_rings();
 }
 
@@ -822,6 +823,9 @@ enable_pdump(void)
 	struct pdump_tuples *pt;
 	int ret = 0, ret1 = 0;
 
+	if (rte_pdump_init() < 0)
+		rte_exit(EXIT_FAILURE, "pdump init failed\n");
+
 	for (i = 0; i < num_tuples; i++) {
 		pt = &pdump_t[i];
 		if (pt->dir == RTE_PDUMP_FLAG_RXTX) {
-- 
2.51.0

