Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B1606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bch8zUSG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C35340679;
	Tue, 20 Oct 2026 08:59:56 +0200 (CEST)
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com
 [209.85.222.97]) by mails.dpdk.org (Postfix) with ESMTP id 4A1264060A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:59:52 +0200 (CEST)
Received: by mail-ua1-f97.google.com with SMTP id
 a1e0cc1a2514c-98febe968deso2043071241.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479591; x=1793084391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l4dPy0MRRo8cYHTupSl7aCthrr3tWz/ZDAbtw9GRm4U=;
 b=YNlBXx/LlGTqqLStA8XRN0pdJkgskwiJvdndSN5yGtSY+AIy0HM1QuARnGLAEOW/2j
 DEDyTKJFYyCDld5pQRm/sTH8l8mQLEy/x0ntvHaWUu0pwrVHOCZ6UthtLWCZpgCXzk5N
 cRHksZEF5fvFfOdCTTcXeQnNSjuNr8lKm+psf89akulRk7wWHXuc0qiy1MlZAoV75bm1
 NV5+BibDgancri0V4bglUAtMGFg7E8LMm1fCBgQ2EqKE7wIETv5Aqny0d7vKG4F9OUTJ
 PSBkCp0keye3OqPyOXjb0aC7FvirBJEtu89r5Zm+j5LxhR44aQc0qY9D8hEnVEjLUh1K
 tSww==
X-Gm-Message-State: AFq9FYJewDisUHKVudpA8m8RncUuYL+0l3StN/tFd28w0E4Wtduu/W72
 Z8lQPMj2L+w5xvQl6dnbjNy9LtFpdrfMA3uT7VtQDvvrkP3Bx2wjXjEbjSL+k8weuSDri1hK+Xh
 ZikKUbZhdKDQOcLztEhvQtoGiwUCtBzdSy1g9vF6h/6mskWDz/+Gfzbp/6J21Tg24ApULx8gvDs
 p2Jg83LJZTaymKsf5OWwtt10uW8x8Sy9ynt9+nxBbcuNtFdN8VV9m3fq4VA4fdLaOBoFJaaA==
X-Gm-Gg: AYBFou11Uqalw03bocXKesV9IxnAeNxFf5frKxBSIO0eC3+kXRnkck4AnDlYR1GtYeT
 Shju9nSuc017CSrR6dKFIF4qP95p54nom1DrblXdUVrBXwiwazy9H6L7YnIkqFXYgOuLjpquOgx
 nSlJ6brhg6SuOsS75Kh5pzG5rGII16mCjtLyqXcI5sTtZSDx2dnFlOyA0765z4XXNODqxUVXX8d
 V9zVvEW+dq9ETKY6fUjukHXeP7Eq7LuneQoPZRlxxH0POsMetzhYjitzJj+fdDp3uFVBk6Ef444
 WupHwIefM3+Tv4Wsd2fByeyqyg3r/PWSP6h3ygv38hXZTL9pLxs59pwJWE04GbWTUbzkq8h8Hxp
 FIY+XYrBoRN5/bLxgOvzOL1Q40t1kllo2PDxnlSIgeoTStsmA4jNi+nXyVOSuGQlXd4UjVhcQPx
 h3DUjXqh6Xaxz4xcZtWfwaCzwqF0+d5kHhQf3MAg==
X-Received: by 2002:a05:6102:f9b:b0:7c3:7286:c28a with SMTP id
 ada2fe7eead31-7cc369a5511mr2861594137.19.1792479591399; 
 Mon, 19 Oct 2026 23:59:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-7cc85508bd5sm2413137.5.2026.10.19.23.59.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:59:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179a556c43so66530706d6.3
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479590; x=1793084390; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l4dPy0MRRo8cYHTupSl7aCthrr3tWz/ZDAbtw9GRm4U=;
 b=bch8zUSGwg8ODhKArbYtbTXxAvPfOjEp1XaGblxwOlsahaFIsoWR8hebXiraEAEkIT
 jROqTW1JFB5cxgAqMepJ3wG0/rlEMhcibvMUVyz09MZQY3UobkWzSFMIFq20674Be6qX
 EiqONPTZoDFaeNdFYKjL5x4hGSfveT1u3d4QY=
X-Received: by 2002:a05:6214:2f8b:b0:915:e5c8:5663 with SMTP id
 6a1803df08f44-91bdec2e5d0mr149914916d6.4.1792479589967; 
 Mon, 19 Oct 2026 23:59:49 -0700 (PDT)
X-Received: by 2002:a05:6214:2f8b:b0:915:e5c8:5663 with SMTP id
 6a1803df08f44-91bdec2e5d0mr149914696d6.4.1792479589487; 
 Mon, 19 Oct 2026 23:59:49 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c04f42afcsm15848096d6.18.2026.10.19.23.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:59:48 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH v2] net/bnxt/tf_core: fix SRAM block allocation failure
 handling
Date: Tue, 20 Oct 2026 01:59:47 -0500
Message-Id: <20261020065947.1067997-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005151720.1706054-1-manish.kurup@broadcom.com>
References: <20261005151720.1706054-1-manish.kurup@broadcom.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In tf_sram_mgr_alloc(), two sequential 64B blocks are allocated from
the resource manager before the tf_sram_block tracking structure is
created with tf_sram_alloc_block(). If that allocation fails it
returns NULL, but the NULL result was not checked: the RM indices
stayed marked in use and could never be reused, and the NULL block
was then dereferenced via block->block_id.

Release both RM indices and return -ENOMEM when the block structure
cannot be allocated, as is already done when the two indices are not
sequential.

Fixes: 37ff91c158a3 ("net/bnxt: add SRAM manager model")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Split out of "net/bnxt: fix multiple truflow defects" (one fix per
  patch); this is the tf_sram_mgr_alloc() fix.
* New subject and commit message (also notes the NULL dereference);
  single Fixes: tag.

 drivers/net/bnxt/tf_core/tf_sram_mgr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/bnxt/tf_core/tf_sram_mgr.c b/drivers/net/bnxt/tf_core/tf_sram_mgr.c
index 0dffd74cd5..70bdb0ba1b 100644
--- a/drivers/net/bnxt/tf_core/tf_sram_mgr.c
+++ b/drivers/net/bnxt/tf_core/tf_sram_mgr.c
@@ -710,6 +710,15 @@ int tf_sram_mgr_alloc(void *sram_handle,
 		}
 		block_id = index;
 		block = tf_sram_alloc_block(slice_list, block_id);
+		if (unlikely(!block)) {
+			fparms.index = index;
+			fparms.subtype = parms->tbl_type;
+			fparms.rm_db = parms->rm_db;
+			tf_rm_free(&fparms);
+			fparms.index = next_index;
+			tf_rm_free(&fparms);
+			return -ENOMEM;
+		}
 
 	} else {
 		/* Block exists
-- 
2.31.1

