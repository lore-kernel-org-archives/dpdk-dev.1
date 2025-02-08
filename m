Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C75AC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 20:33:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C10C440677;
	Sat,  8 Feb 2025 21:32:13 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 96C1F4065E
 for <dev@dpdk.org>; Sat,  8 Feb 2025 21:32:10 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa3e20952fso2234131a91.1
 for <dev@dpdk.org>; Sat, 08 Feb 2025 12:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739046730;
 x=1739651530; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5ipZ1fbyQXacCpVXmtr1owK0XNqdo1d/c96i3/7ryw=;
 b=MMKFCNFQkFsI4QqnGwq1xOkYEA20j4dPX+WDyZ2bff6rMJxU0Ti/5inU+itNWb1mmN
 3xwl1B/wV0ecH+WZl5pPQ0/JR+r8ETAKQ16iZDUtAeMnkpFShG94Djh9FcAU0vLXT4Xs
 QrKhw38h/ShjHUNqwkNJfsMt0yfJlzWoAn4L09ZiE1zEGJEHbMDHuZIz4shzetLFz5zM
 JsDyKK0NKAUu1zHy3Rlclg7sqpcC4cQu6KCbZYxaWSuXr0ufweZw/wafvfmnPR5wSvNd
 1SRBr169/lAau4sOapFAszM2BLQS7kz7hOGODIPpBsYl0g4h4B3u7qvGAdkl0O/XoEVu
 TZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739046730; x=1739651530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5ipZ1fbyQXacCpVXmtr1owK0XNqdo1d/c96i3/7ryw=;
 b=fQnylYe1u6VPcb09PLfyfYCH1SgxJxEa5h1IZ+32PVMX1U0dDfRQJ4y1Zu3Lx5+XBc
 0I0n0LQdg0noQu6BlnbpnARFZTJygRIsBj3MlZ4L14UlCUolYtSlUqp39vOg/dO/b6/E
 f6tF5lNorcHPfydeNQiymGrnj7GEk0rcOo7sPrGXMfFBAxZpkMKJcp4FzOCThmtaSsgt
 f6sr9Yd010CJaUfcuYIy0MXzmTkcYnC9uWhbTvVXNUcBP+Ud26NiArozyK4WfwR0wyb5
 y7BQT0zYCmOAn+661MspczAYSXE8jDrzEOrajUloAgbgA5Bo+gd8WFnmnI7wWqfXphLT
 7bWQ==
X-Gm-Message-State: AOJu0YzMd7+MUIfCuZMLyNqS6WuptHXyMnESgL5Nq2z2ervscQjLWE0D
 PNK3+pI2vgD5n79XfVTsKyBWG8cnLOQR4SkorubGU5zoIkb17+6ykFzGphB10tJl2XujpBhawp8
 esX0=
X-Gm-Gg: ASbGncspc0/FfaocKcdRCXl9h9NadhGt462NCNBIu4EOP1AOLag7L4BbX+MQbcDf/f2
 5nU87kvERSAk5CLV1Wwvzt9QcSidzQVB77Rp89rfgUkAg3e+71ll+nEOUxM6CY+2BRekc0EkciL
 R7kuENP56jn3EaipPnahkN6okGr4ItJ5kwj+WowEc4ikbZXdGbaVy573XJtwH4uoAzJgVIahqfv
 LSagk9ej69YnWMZe5n/SiU2GYT1x12DnQtGvB7lgG2SRVpxTqED3guCvqweCTKG0OGtozgnISCL
 6ZjG99D0+J19cZBhs1VZhTxz9us6p05h8hotBGD3CpTXbhhLa4gHAjdEJrGCGkeh/Tlz
X-Google-Smtp-Source: AGHT+IEfm4XeFLS1K2ZBwkt9pqi8aFAdMuNB904l9HpBIBM/d3TnjOHVP5EVfJFaFbPu4FrppAujPQ==
X-Received: by 2002:a05:6a00:3016:b0:725:e499:5b86 with SMTP id
 d2e1a72fcca58-7305d546034mr14241880b3a.20.1739046729863; 
 Sat, 08 Feb 2025 12:32:09 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7304c780da5sm4882019b3a.69.2025.02.08.12.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:32:09 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Subject: [PATCH 12/32] pipeline: replace memcpy with assignment
Date: Sat,  8 Feb 2025 12:22:04 -0800
Message-ID: <20250208203142.242284-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250208203142.242284-1-stephen@networkplumber.org>
References: <20250208203142.242284-1-stephen@networkplumber.org>
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

Prefer structure assignment over memcpy.
Found by cocci/struct_assign.cocci

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/ip_pipeline/parser.c        |  2 +-
 lib/pipeline/rte_pipeline.c          |  6 ++---
 lib/pipeline/rte_swx_ctl.c           |  2 +-
 lib/pipeline/rte_swx_ipsec.c         |  2 +-
 lib/pipeline/rte_swx_pipeline_spec.c | 36 ++++++++++------------------
 5 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/examples/ip_pipeline/parser.c b/examples/ip_pipeline/parser.c
index dfca026be5..8baa70e1f4 100644
--- a/examples/ip_pipeline/parser.c
+++ b/examples/ip_pipeline/parser.c
@@ -407,7 +407,7 @@ parse_mac_addr(const char *token, struct rte_ether_addr *addr)
 	if (tmp == NULL)
 		return -1;
 
-	memcpy(addr, tmp, sizeof(struct rte_ether_addr));
+	*addr = *tmp;
 	return 0;
 }
 
diff --git a/lib/pipeline/rte_pipeline.c b/lib/pipeline/rte_pipeline.c
index a09a89f746..bad85341c9 100644
--- a/lib/pipeline/rte_pipeline.c
+++ b/lib/pipeline/rte_pipeline.c
@@ -368,7 +368,7 @@ rte_pipeline_table_create(struct rte_pipeline *p,
 	*table_id = id;
 
 	/* Save input parameters */
-	memcpy(&table->ops, params->ops, sizeof(struct rte_table_ops));
+	table->ops = *params->ops;
 	table->f_action_hit = params->f_action_hit;
 	table->f_action_miss = params->f_action_miss;
 	table->arg_ah = params->arg_ah;
@@ -831,7 +831,7 @@ rte_pipeline_port_in_create(struct rte_pipeline *p,
 	*port_id = id;
 
 	/* Save input parameters */
-	memcpy(&port->ops, params->ops, sizeof(struct rte_port_in_ops));
+	port->ops = *params->ops;
 	port->f_action = params->f_action;
 	port->arg_ah = params->arg_ah;
 	port->burst_size = params->burst_size;
@@ -881,7 +881,7 @@ rte_pipeline_port_out_create(struct rte_pipeline *p,
 	*port_id = id;
 
 	/* Save input parameters */
-	memcpy(&port->ops, params->ops, sizeof(struct rte_port_out_ops));
+	port->ops = *params->ops;
 	port->f_action = params->f_action;
 	port->arg_ah = params->arg_ah;
 
diff --git a/lib/pipeline/rte_swx_ctl.c b/lib/pipeline/rte_swx_ctl.c
index 857770d297..db83c31c7c 100644
--- a/lib/pipeline/rte_swx_ctl.c
+++ b/lib/pipeline/rte_swx_ctl.c
@@ -832,7 +832,7 @@ selector_group_duplicate_to_pending(struct selector *s, uint32_t group_id)
 		if (!mp)
 			goto error;
 
-		memcpy(mp, m, sizeof(struct rte_swx_table_selector_member));
+		*mp = *m;
 
 		TAILQ_INSERT_TAIL(&gp->members, mp, node);
 	}
diff --git a/lib/pipeline/rte_swx_ipsec.c b/lib/pipeline/rte_swx_ipsec.c
index 17a9d2b98b..e710ba2f9d 100644
--- a/lib/pipeline/rte_swx_ipsec.c
+++ b/lib/pipeline/rte_swx_ipsec.c
@@ -366,7 +366,7 @@ rte_swx_ipsec_create(struct rte_swx_ipsec **ipsec_out,
 	ipsec->ring_out = ring_out;
 	ipsec->dev_id = (uint8_t)dev_id;
 	ipsec->qp_id = params->crypto_dev_queue_pair_id;
-	memcpy(&ipsec->bsz, &params->bsz, sizeof(struct rte_swx_ipsec_burst_size));
+	ipsec->bsz = params->bsz;
 	ipsec->n_sa_max = n_sa_max;
 
 	ipsec->crypto_wr_threshold = params->bsz.crypto_wr * 3 / 4;
diff --git a/lib/pipeline/rte_swx_pipeline_spec.c b/lib/pipeline/rte_swx_pipeline_spec.c
index 17419e7b85..986bbe5fd4 100644
--- a/lib/pipeline/rte_swx_pipeline_spec.c
+++ b/lib/pipeline/rte_swx_pipeline_spec.c
@@ -2985,7 +2985,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->structs = new_structs;
-			memcpy(&s->structs[s->n_structs], &struct_spec, sizeof(struct struct_spec));
+			s->structs[s->n_structs] = struct_spec;
 			s->n_structs++;
 			memset(&struct_spec, 0, sizeof(struct struct_spec));
 
@@ -3022,7 +3022,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->actions = new_actions;
-			memcpy(&s->actions[s->n_actions], &action_spec, sizeof(struct action_spec));
+			s->actions[s->n_actions] = action_spec;
 			s->n_actions++;
 			memset(&action_spec, 0, sizeof(struct action_spec));
 
@@ -3059,7 +3059,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->tables = new_tables;
-			memcpy(&s->tables[s->n_tables], &table_spec, sizeof(struct table_spec));
+			s->tables[s->n_tables] = table_spec;
 			s->n_tables++;
 			memset(&table_spec, 0, sizeof(struct table_spec));
 
@@ -3096,9 +3096,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->selectors = new_selectors;
-			memcpy(&s->selectors[s->n_selectors],
-			       &selector_spec,
-			       sizeof(struct selector_spec));
+			s->selectors[s->n_selectors] = selector_spec;
 			s->n_selectors++;
 			memset(&selector_spec, 0, sizeof(struct selector_spec));
 
@@ -3135,9 +3133,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->learners = new_learners;
-			memcpy(&s->learners[s->n_learners],
-			       &learner_spec,
-			       sizeof(struct learner_spec));
+			s->learners[s->n_learners] = learner_spec;
 			s->n_learners++;
 			memset(&learner_spec, 0, sizeof(struct learner_spec));
 
@@ -3173,7 +3169,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->apply = new_apply;
-			memcpy(&s->apply[s->n_apply], &apply_spec, sizeof(struct apply_spec));
+			s->apply[s->n_apply] = apply_spec;
 			s->n_apply++;
 			memset(&apply_spec, 0, sizeof(struct apply_spec));
 
@@ -3205,7 +3201,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->extobjs = new_extobjs;
-			memcpy(&s->extobjs[s->n_extobjs], &extobj_spec, sizeof(struct extobj_spec));
+			s->extobjs[s->n_extobjs] = extobj_spec;
 			s->n_extobjs++;
 			memset(&extobj_spec, 0, sizeof(struct extobj_spec));
 
@@ -3252,7 +3248,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->headers = new_headers;
-			memcpy(&s->headers[s->n_headers], &header_spec, sizeof(struct header_spec));
+			s->headers[s->n_headers] = header_spec;
 			s->n_headers++;
 			memset(&header_spec, 0, sizeof(struct header_spec));
 
@@ -3284,9 +3280,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->metadata = new_metadata;
-			memcpy(&s->metadata[s->n_metadata],
-			       &metadata_spec,
-			       sizeof(struct metadata_spec));
+			s->metadata[s->n_metadata] = metadata_spec;
 			s->n_metadata++;
 			memset(&metadata_spec, 0, sizeof(struct metadata_spec));
 
@@ -3378,9 +3372,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->regarrays = new_regarrays;
-			memcpy(&s->regarrays[s->n_regarrays],
-			       &regarray_spec,
-			       sizeof(struct regarray_spec));
+			s->regarrays[s->n_regarrays] = regarray_spec;
 			s->n_regarrays++;
 			memset(&regarray_spec, 0, sizeof(struct regarray_spec));
 
@@ -3412,9 +3404,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->metarrays = new_metarrays;
-			memcpy(&s->metarrays[s->n_metarrays],
-			       &metarray_spec,
-			       sizeof(struct metarray_spec));
+			s->metarrays[s->n_metarrays] = metarray_spec;
 			s->n_metarrays++;
 			memset(&metarray_spec, 0, sizeof(struct metarray_spec));
 
@@ -3446,9 +3436,7 @@ pipeline_spec_parse(FILE *spec,
 			}
 
 			s->rss = new_rss;
-			memcpy(&s->rss[s->n_rss],
-			       &rss_spec,
-			       sizeof(struct rss_spec));
+			s->rss[s->n_rss] = rss_spec;
 			s->n_rss++;
 			memset(&rss_spec, 0, sizeof(struct rss_spec));
 
-- 
2.47.2

