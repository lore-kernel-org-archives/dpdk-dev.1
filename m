Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48629CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C3AE41132;
	Wed, 15 Oct 2025 11:05:20 +0200 (CEST)
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com
 [209.85.166.226])
 by mails.dpdk.org (Postfix) with ESMTP id 137DA41132
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:19 +0200 (CEST)
Received: by mail-il1-f226.google.com with SMTP id
 e9e14a558f8ab-42f95010871so24037215ab.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519118; x=1761123918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=k43B8sDuPzEYAxGWRfN9110Y4uFcQd/onDSdrvSkPtlwM6Zmlxnv8/eNIijEA26ua/
 zVfmG15iQnDCpBLsRwQ4lAEt3Puxcy1k/bCMPUBPQbiUQZuDUMgWelt1y3bn0udL88Xz
 7fFZPoDYbPacMZhe06EaKQWgf6yLLsVP7NDjAY9tKyA772uIXmF7kZGP8h+dIQCZK7TE
 U5kvdsU8KLqEEum60ll7w7pgU5UVDi2ErKlcB8aJMeE6qS6eR94nOgfjNeE/EfekrsMZ
 3WES1mH8xRJmHw31kjVdEocRVxu4w9cEvW0zDBNJzBgviA73WBdXU7YNfpi3v4r85a9h
 w/dw==
X-Gm-Message-State: AOJu0YxKR/rT/PS3QWZkdukW0S3Isy7RCcmzlhdHM4O9FEKhYSrXNTWi
 kLdsTA5GScgKXVGUP3k2B0vrlPzKG9KOo3mNhpltAPR/Hn4XWkLzBu9Z3Niyd5D7JC13WcsyseP
 MwxsylOfvmkug58xH5q4yXxUlg4+iGr+GiqECsxybpTR5aRnQXbSGAp9zYYHV0AdpRKKWm0Zpb+
 Dh+0BEC49yCRBDaw462EU+Hn5jeJV5BmqD+RW035vgA/ayLngeKGLu7dC+6SPiNCvWYXnadA==
X-Gm-Gg: ASbGncvnp9GhhiAWIjAWVOnSobH6H6V8DX9Uq6fwNOALyPvzbjpoeykqxkWZd7FHN9A
 Vxp2JYpQZ09g9reneRI5NupH9nlhanXjfvwUJ55cYZ5kABD31HFTgnAtUgjEJph1NnlDpR22G/7
 ckDIW3Hz0FdOdWodzVUgybcBess5dqgQm3wgWNR6dDVEN7GL/+ANCCRta4uZTJEpEJl7JNl+FtL
 juZdKPmvnz9kR09maiqz8svCZh560GrBdE7wR56BXUp6W4cR0XGPlniCLhEEXtvqwfjtISdn9Nj
 JNw3641BlH2c6lbE7vtoholbPtIE4rnU30JahCMbIRMhg9RtJXTS6WvTxKnce9vzerlo0rC0n9S
 zxoKN9gaHkdXD1HqKM9++uAx8A9oFiOAfEp+AYf1V7keDQQtz+HKFZ1kg2cQ/ADLCwBfkyPW3OB
 A=
X-Google-Smtp-Source: AGHT+IFluqCSP6BQJbyZQ0qLjWX9UAK2htXORMPL++SaW13bRA+0UrVZyVij6rouwxDu9WnG2WHIihuCazeI
X-Received: by 2002:a05:6e02:19ca:b0:42a:dd1d:c3e4 with SMTP id
 e9e14a558f8ab-42f873dd084mr282915125ab.15.1760519118298; 
 Wed, 15 Oct 2025 02:05:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-42f9031307esm12158205ab.17.2025.10.15.02.05.17
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b5a013bc46dso9298821a12.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519115; x=1761123915; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUMCy9vUsf2u1cQUB1qdeOGfxUAAfafRJuPx7RcgqUk=;
 b=KWw9Y+z3Y0ouQ9+exITtHMaMj9fJqFszyzRlXx+TOgiSvfM1YxW6StOgAZARlQ8MZa
 7Fp3+R/jtCS2Txtp88l5B05FnFLogKlMwW09qH8nwCelAQyoDBI43o3nAB070+DPbSEi
 BU+rTCF2/ljDA8IEbzuI2aYba1LOLG6QU35ZY=
X-Received: by 2002:a05:6a21:7794:b0:334:912f:acfa with SMTP id
 adf61e73a8af0-334912fcd16mr301152637.56.1760519115591; 
 Wed, 15 Oct 2025 02:05:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:7794:b0:334:912f:acfa with SMTP id
 adf61e73a8af0-334912fcd16mr301088637.56.1760519114845; 
 Wed, 15 Oct 2025 02:05:14 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:14 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v3 43/54] net/bnxt/tf_core: fix truflow crash on memory
 allocation failure
Date: Wed, 15 Oct 2025 05:00:13 -0400
Message-Id: <20251015090024.32250-44-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

A backing store table allocation failed due to lack of memory and
resulted in a crash because the result of the allocation was not
checked for validity.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index b229f07596..878f62c115 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -505,6 +505,8 @@ static int alloc_link_pbl(struct tfc_ts_mem_cfg *mem_cfg, uint32_t page_size,
 								RTE_MEMZONE_SIZE_HINT_ONLY |
 								RTE_MEMZONE_IOVA_CONTIG,
 								page_size);
+		if (!mem_cfg->ts_mz.mz)
+			return -ENOMEM;
 	}
 	memset(mem_cfg->ts_mz.mz->addr, 0, mem_cfg->ts_mz.mz->len);
 	mem_cfg->ts_mz.page_count = total_pages;
-- 
2.39.5 (Apple Git-154)

