Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977F606A321
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=PiqBL5uW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08A0E4027E;
	Mon, 23 Nov 2026 22:15:25 +0100 (CET)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by mails.dpdk.org (Postfix) with ESMTPS id AECFA4027A
 for <dev@dpdk.org>; Mon, 23 Nov 2026 22:15:23 +0100 (CET)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3b44bdcea8aso1618933a91.1
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795468522; x=1796073322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+fiMM3T9qUABhaxV8mW33YnPsXTyi2ZzJEkpXMtWU3k=;
 b=ypSEtCEHoSkdo5rNLEWqge0NaeVy13Pff7zQJtkdeolQCx20USwXgGg1R6NVxNSMVV
 S0yIVUzFu8vk5rCeyo9qtPCdKMHEQmJtn2YHf9k5lIXp1ez4V7IOQk2NKQ+rtSz/E/t4
 FcG2l86AB4Ncf/hsDYCzt8nN9qKd0++Je5QDzKnfmwVvsLq/aQvNVAZgxvHo0PgbF6ny
 vCF3IEpFPjELGyDsxPeYO3gJBpR7tIV0Y8nzu1+yomRRWpTf+261zC+TQG00pdqCWlUQ
 0O8ur1+Ih00X0m2BT+YniIM23EBS6no+YY9VlFwKUTV9iuxFph/iFl576gTx5IEQbhCn
 3Q1g==
X-Gm-Message-State: APuU4Z+jzRTK1MovjEXYf/bpC5U9zrRMhGNsNl1Pw/2eOnMhKiaSekxF
 yIsbPP6YC0E/3pyAzJiprXVLEHPluXiqEZsTotV9f56yyVGfVonQ74dgioufcj97XPCJoYq5JP3
 WtTC7HabyzJuz5NK/fkFyL3MYOzzjsqaIhSfWt3r/52KA5W+as/CBwzsPImzlng43WrDgMQdCff
 L2ZxXkizNmb1uE+M/Nl0Q/Qx2MOtKHBF0HBLxDyPzoFaUTFB2kozm7JXMnuq5nyN0sp3cN1unXl
 YnIBVWlZYDt
X-Gm-Gg: AZFdTZdnpvG8CHUDdpArHAxzvc21etpRIyBgG0Y4Vju1gIGovIyBCKcy4p+dmPDO6e1
 XGTs0OfUhLlrnIH+UWEPBSu9G6he0LaGlW3Fk0YJ6m0s7yaSuytxoLCKFVnJvfkV72qMMjcxOrd
 9IaqWnDOhqaX7hq14iUQBB8h6pyvG3zLzDLkNX9BO59mszhvOiU8XlUWTJO3yjMcfHK+iS7DkZW
 TR2lHpkq13gTRw8jEdAB26epvF/Pi1LkjBlcP106J9VTYu1aAkCT80ioJJfSo9J3q4JH+ogvcrw
 ++7dnl6VtBjx7F/mIRsTFYbwBGvskmRu2dLB3lvdWoKeAOD3NKezRRnWQfP1m0/CiKAjFWEmLgt
 /CoQaazIsMqzoTAK5Wy/s8pyyO7+tK2nM061uRz4lSGD8ca0Qabcln3k9zjmqtl3NhvOz5hDpkR
 Gp+IZzmID5zuZ1PQ31sSP24h4vd/TxGQFCjU1HLerho1So4vKIdg==
X-Received: by 2002:a17:90b:4d86:b0:3ae:3b3d:c617 with SMTP id
 98e67ed59e1d1-3b41c93cdbdmr7783000a91.29.1795468521788; 
 Mon, 23 Nov 2026 13:15:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b41ab582a3sm9121139a91.0.2026.11.23.13.15.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Nov 2026 13:15:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso4789798eec.0
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1795468520; x=1796073320; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+fiMM3T9qUABhaxV8mW33YnPsXTyi2ZzJEkpXMtWU3k=;
 b=PiqBL5uWM0hGTIGms/faGEKRQscKPmD1JQSlT3oPhtgRkES2PC2xjtJiQYJHqDGf4U
 qVPU7Pu/zw11yBqDgAkT83nY4/5c6fjI0BcvFrOh6k1yINUFMy4jUP60WPbgq88AcyCE
 457nRtsC4W81xeXYja0YjeObrp0I291WBadCY=
X-Received: by 2002:a05:701b:4583:20b0:1ab:cbd0:1c96 with SMTP id
 a92af1059eb24-1b55247f0e4mr12713380c88.4.1795468519945; 
 Mon, 23 Nov 2026 13:15:19 -0800 (PST)
X-Received: by 2002:a05:701b:4583:20b0:1ab:cbd0:1c96 with SMTP id
 a92af1059eb24-1b55247f0e4mr12713331c88.4.1795468518624; 
 Mon, 23 Nov 2026 13:15:18 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm29495218c88.2.2026.11.23.13.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 13:15:18 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <shuab.siddique@broadcom.com>
Subject: [PATCH 0/2] net/bnxt: harden ring stats against flipped bits
Date: Mon, 23 Nov 2026 14:19:25 -0700
Message-ID: <20261123211927.261389-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Shuab Siddique <shuab.siddique@broadcom.com>

Under heavy traffic and a high stats polling rate, firmware can return a
STAT_CTX_QUERY value with a flipped bit, which shows up as a spurious
jump in the reported counters.

Patch 1 applies the firmware-reported counter widths, has firmware DMA
the counters periodically, and takes a bitwise majority of three samples
on every read. Patch 2 enables the extended ring stats path on P5 so the
same handling covers the TPA counters there.

Keegan Freyhof (2):
  net/bnxt: harden ring stats against flipped bits
  net/bnxt: use extended ring stats on P5

 doc/guides/rel_notes/release_26_11.rst |   2 +
 drivers/net/bnxt/bnxt.h                |  90 -------
 drivers/net/bnxt/bnxt_cpr.h            |   7 +-
 drivers/net/bnxt/bnxt_ethdev.c         |  24 +-
 drivers/net/bnxt/bnxt_hwrm.c           | 337 +++++------------------
 drivers/net/bnxt/bnxt_hwrm.h           |  21 +-
 drivers/net/bnxt/bnxt_ring.c           |   9 +
 drivers/net/bnxt/bnxt_rxq.c            |   3 +-
 drivers/net/bnxt/bnxt_stats.c          | 354 +++++++++++++++++++++++--
 drivers/net/bnxt/bnxt_stats.h          | 168 ++++++++++++
 drivers/net/bnxt/bnxt_txr.c            |   3 +-
 11 files changed, 622 insertions(+), 396 deletions(-)

-- 
2.47.3

