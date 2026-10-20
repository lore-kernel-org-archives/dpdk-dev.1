Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F3606A31D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=XWLr1NWX
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B319040696;
	Tue, 20 Oct 2026 09:00:05 +0200 (CEST)
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com
 [209.85.219.98]) by mails.dpdk.org (Postfix) with ESMTP id 640724060F
 for <dev@dpdk.org>; Tue, 20 Oct 2026 09:00:00 +0200 (CEST)
Received: by mail-qv1-f98.google.com with SMTP id
 6a1803df08f44-917b78dfe30so43691626d6.0
 for <dev@dpdk.org>; Tue, 20 Oct 2026 00:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479600; x=1793084400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJ2/tHfme8MeTC6AESerJTFTmzEdDcKB2axg5kn+0dA=;
 b=VIzhAf8ToI1zE2+7d8ULpD49VRGbcazdSTNukoTiwLrzS0EoV0s/97Bweis7pNE15G
 /4kbWp9fVxUnvxY0jMQZiEBb2zISfgJUNLVla9wW21QRR90GoVPy8HPMY6ou37verunA
 3zrnh9rq7F6PJTocTY2+cgY8fOoSLYBgOY/Szkz0CwyB93F4pwpmn34P6cxdC0ArJKQ1
 3fQJxfJbLLfjjMaONHBgv1oxbUcQzsI9gA9ai1GkX4AeZLZA9l6dezPanLDgHInqG2qM
 1jX6/bppPLUhRdNfANWMtGmPhgWIC6zmRjZWLkPOf+9o8cGo4qYoU4T07U9R4j2EGFzQ
 Fhvw==
X-Gm-Message-State: AFq9FYLXyo3buOw7utkLe28aet7ODHXvgvS1ygcSPDtr3EMlU2vs6HSq
 NgjoI1Y8iWmiSn0maj2+wHQ83qWh3tlr+PNZY0BurH1AiPu+MjJ8WZqXh2m6e+fB7skV89x21UG
 SmBe4hg5+EVACI7U2lYQiyZZecg0irPMDudOhfrkO9Db/sKtWF8K88XhhOhsfwOTUg2wQMFxen2
 Cx+QFSE8EfDhikPjw8ghJyZTwuX6L++YU5hGyxdK/efKCF8HHGlhMQlTY2SIUsAzMiFHfygQ==
X-Gm-Gg: AYBFou1eE60ZOjoGzuKnXYp1Kkagt+8zN5clYwmjWzblOcSMvhTJLcf4XtSygGGa4p6
 Dozgg29oT9+6vvKP9esZ3nwasetShV6zThnqrlkw4Od2jLXLo3nB/Z6v02DRMRA9nzDeaLPP/af
 gznnKm9VgBU1ahJC98f47yex5Htb25JBkHzHi1qTOi6HkA1CO17IgF+MBqmZYpLJA04wG6cJbHS
 rDtwOOWq3/AqZ9zihUR7lW/TKv0Vl8uKPftM3QnEBgG8MgZPdNHO6KMEF2WTgNMJ+LSUA38L4Tt
 7cwBL5s1a/SMjC3Uvk/jbo8zTdbvAE/l/UE2MfvyOVzqDcwIaA2sWdFEACp3nmuZ28hRg12ey6o
 6cLcJhUYOhNWeKY96dDl8sArsKgEciQwdUEtOOvoMvX9jDiAzV6P6LytoiZOERnlNkuyxl0pxoC
 Vo2MNN059PPPi+8MAM+IHTmTgbWYQc6OQ7mN6qwg==
X-Received: by 2002:a05:620a:468f:b0:93e:9171:b83 with SMTP id
 af79cd13be357-93f29d4d599mr1691293285a.43.1792479599727; 
 Mon, 19 Oct 2026 23:59:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93f4b052815sm22144385a.19.2026.10.19.23.59.59
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:59:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so1944739c88.0
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479598; x=1793084398; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJ2/tHfme8MeTC6AESerJTFTmzEdDcKB2axg5kn+0dA=;
 b=XWLr1NWX/MTLj6UNS6qTJrMt292Uy4TUaqv8RhAYegv9lXs6B9FVPH1X7DFZuzqf6T
 3Vcr3pKhlOoeyf/2NLj/jlnOaJuv2EdAKwCuJAmMWhm4uw++bYqQHTKLouiBnWUtB1OI
 y9ssJzC3ve0Xg/5no8Sla3VFwZ5lDSYX3goPQ=
X-Received: by 2002:a05:7023:905:b0:148:722b:7cbc with SMTP id
 a92af1059eb24-18511eb629bmr16574744c88.14.1792479598270; 
 Mon, 19 Oct 2026 23:59:58 -0700 (PDT)
X-Received: by 2002:a05:7023:905:b0:148:722b:7cbc with SMTP id
 a92af1059eb24-18511eb629bmr16574698c88.14.1792479597360; 
 Mon, 19 Oct 2026 23:59:57 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm35802342c88.1.2026.10.19.23.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:59:56 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH v2] net/bnxt/tf_core: fix buffer leaks in RM create DB
Date: Tue, 20 Oct 2026 01:59:54 -0500
Message-Id: <20261020065954.1068154-1-manish.kurup@broadcom.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tf_rm_create_db() allocates a capabilities query buffer, a copy of
the requested counts, and the request and reservation arrays.
The query buffer is never freed: not on success, not on the common
error exit, and not on the early error returns. The early returns
also leak whichever of the other buffers had been allocated by that
point, and the rm_db structure when the element array allocation
fails.

Free the query buffer on success and on the existing error path, and
send the early error returns through a common label that frees the
temporary buffers and returns the original error code.

Fixes: ced3cded4492 ("net/bnxt: update table get to use new design")
Fixes: 7052999153f2 ("net/bnxt: add action SRAM translation")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Split out of "net/bnxt: fix multiple truflow defects" (one fix per
  patch); this is the tf_rm_create_db() leak fix.
* Rewrote the commit message and the fix: the query buffer was also
  leaked on the existing error path and on the early error returns,
  which also leaked the other temporary buffers; they now all exit
  through a common label.
* Two Fixes: tags, one for each commit that introduced a leaked buffer.

 drivers/net/bnxt/tf_core/tf_rm.c | 44 +++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_rm.c b/drivers/net/bnxt/tf_core/tf_rm.c
index 18f46c0a0a..76ef122204 100644
--- a/drivers/net/bnxt/tf_core/tf_rm.c
+++ b/drivers/net/bnxt/tf_core/tf_rm.c
@@ -450,13 +450,13 @@ tf_rm_create_db(struct tf *tfp,
 	struct tf_session *tfs;
 	struct tf_dev_info *dev;
 	int i, j;
-	uint16_t max_types, hcapi_items, *req_cnt;
+	uint16_t max_types, hcapi_items, *req_cnt = NULL;
 	struct tfp_calloc_parms cparms;
-	struct tf_rm_resc_req_entry *query;
+	struct tf_rm_resc_req_entry *query = NULL;
 	enum tf_rm_resc_resv_strategy resv_strategy;
-	struct tf_rm_resc_req_entry *req;
-	struct tf_rm_resc_entry *resv;
-	struct tf_rm_new_db *rm_db;
+	struct tf_rm_resc_req_entry *req = NULL;
+	struct tf_rm_resc_entry *resv = NULL;
+	struct tf_rm_new_db *rm_db = NULL;
 	struct tf_rm_element *db;
 	uint32_t pool_size;
 
@@ -494,7 +494,7 @@ tf_rm_create_db(struct tf *tfp,
 				       &resv_strategy,
 				       NULL);
 	if (rc)
-		return rc;
+		goto free_bufs;
 
 	/* Copy requested counts (alloc_cnt) from tf_open_session() to local
 	 * copy (req_cnt) so that it can be updated if required.
@@ -504,7 +504,7 @@ tf_rm_create_db(struct tf *tfp,
 	cparms.size = sizeof(uint16_t);
 	rc = tfp_calloc(&cparms);
 	if (rc)
-		return rc;
+		goto free_bufs;
 
 	req_cnt = (uint16_t *)cparms.mem_va;
 
@@ -534,7 +534,8 @@ tf_rm_create_db(struct tf *tfp,
 
 	if (hcapi_items == 0) {
 		parms->rm_db = NULL;
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto free_bufs;
 	}
 
 	/* Alloc request, alignment already set */
@@ -542,14 +543,14 @@ tf_rm_create_db(struct tf *tfp,
 	cparms.size = sizeof(struct tf_rm_resc_req_entry);
 	rc = tfp_calloc(&cparms);
 	if (rc)
-		return rc;
+		goto free_bufs;
 	req = (struct tf_rm_resc_req_entry *)cparms.mem_va;
 
 	/* Alloc reservation, alignment and nitems already set */
 	cparms.size = sizeof(struct tf_rm_resc_entry);
 	rc = tfp_calloc(&cparms);
 	if (rc)
-		return rc;
+		goto free_bufs;
 	resv = (struct tf_rm_resc_entry *)cparms.mem_va;
 
 	/* Build the request */
@@ -586,7 +587,8 @@ tf_rm_create_db(struct tf *tfp,
 					hcapi_type, type_str,
 					req_cnt[i],
 					query[hcapi_type].max);
-				return -EINVAL;
+				rc = -EINVAL;
+				goto free_bufs;
 			}
 		}
 	}
@@ -600,22 +602,24 @@ tf_rm_create_db(struct tf *tfp,
 				       req,
 				       resv);
 	if (rc)
-		return rc;
+		goto free_bufs;
 
 	/* Build the RM DB per the request */
 	cparms.nitems = 1;
 	cparms.size = sizeof(struct tf_rm_new_db);
 	rc = tfp_calloc(&cparms);
 	if (rc)
-		return rc;
+		goto free_bufs;
 	rm_db = (void *)cparms.mem_va;
 
 	/* Build the DB within RM DB */
 	cparms.nitems = parms->num_elements;
 	cparms.size = sizeof(struct tf_rm_element);
 	rc = tfp_calloc(&cparms);
-	if (rc)
-		return rc;
+	if (rc) {
+		tfp_free((void *)rm_db);
+		goto free_bufs;
+	}
 	rm_db->db = (struct tf_rm_element *)cparms.mem_va;
 
 	db = rm_db->db;
@@ -721,12 +725,14 @@ tf_rm_create_db(struct tf *tfp,
 	rm_db->module = parms->module;
 	*parms->rm_db = (void *)rm_db;
 
+	tfp_free((void *)query);
 	tfp_free((void *)req);
 	tfp_free((void *)resv);
 	tfp_free((void *)req_cnt);
 	return 0;
 
  fail:
+	tfp_free((void *)query);
 	tfp_free((void *)req);
 	tfp_free((void *)resv);
 	tfp_free((void *)db->pool);
@@ -736,6 +742,14 @@ tf_rm_create_db(struct tf *tfp,
 	parms->rm_db = NULL;
 
 	return -EINVAL;
+
+ free_bufs:
+	tfp_free((void *)query);
+	tfp_free((void *)req);
+	tfp_free((void *)resv);
+	tfp_free((void *)req_cnt);
+
+	return rc;
 }
 
 int
-- 
2.31.1

