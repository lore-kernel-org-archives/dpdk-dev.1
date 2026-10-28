Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F6606A31A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Oct 2026 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oizfKAXp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83B0140613;
	Wed, 28 Oct 2026 15:17:58 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by mails.dpdk.org (Postfix) with ESMTPS id 624D7402DC
 for <dev@dpdk.org>; Wed, 28 Oct 2026 15:17:55 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so490882a91.3
 for <dev@dpdk.org>; Wed, 28 Oct 2026 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793197074;
 x=1793801874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcVwfOjx6FTL0QugL5nsGQEMdHw/febxoYqN846zOtA=;
 b=oizfKAXplIPukRjxnSknQewlK2R/psnJyVSBneLVDYl2+K3dq1gJ+5RTxh2V6s63bb
 qVbc4RfWW0d++MoyOa1F0YlxOsb/mdZGtFr1ReCVmifGuuXOEge85d8f5s/lDtZlsd1c
 o+DAJso04BzG2gYLbwt1+35tzox0ylvEU5U1LHIjRg6+HD3WDEn0sTXOXQQpDX/ffo7i
 uekXVIiTQSWWAyU6sXznXqctzwQligdFW1+hNCbCdehBZLMskOjA2XFRPjFp5AYOPGpa
 Tp65UyCZgZO0onTTO2GrX3zUVExuyxDiF3NA+2CJeZYODKXNb/6i1om1uAtrclY7KgD8
 iJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793197074; x=1793801874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcVwfOjx6FTL0QugL5nsGQEMdHw/febxoYqN846zOtA=;
 b=Gmqcqx5bR44lUcZUhfTvXT7UhwxqBR+hyZH4SESvPa53JAZgUuw+v5Za19LBrrSPei
 njvGlJQsQu92hTXQQ3E2mahlKwkEAXd8cv6nfB5HQDfci7X52E/ZfUfyUDwPn5mM1E9r
 vzoQTLUcbT3GzUSAwWxcztZhkDLq3zGopR3yxeyYdfd3t3qH6w5x0iQjxeJW/56LfU+z
 K+cDhFkEgD19lkOnqNT0awO42dVt7yQk2ZbCtte2RHiLjMVK4ZxEB4lD0GGsHEwc25Rf
 tdDzMO5aju5IycCR9EB+meOMKnWhhmsZ8gh2FNzVL0E+2B2m7pJIFJ5US/Dpf4VDigaf
 vitQ==
X-Gm-Message-State: AFq9FYIqJ9V7Ug2K6wcE6467Rr14dJqNCYYL4eVoULdBoLRDlQnwAAAI
 g6h8/WU+PMrEx0sehvGC4XO7VT2tPiR0D7HhO3D/FB5mHCQw/TC+Ebg8rZ2xbdUW92R2F5TFbyC
 PPn0dJYE=
X-Gm-Gg: AYBFou03sqZFKivngSyumRihYAk3M88PBRXDkRIMvjXGO6tg/hnNeO7fpoc+gck8szA
 j+CvyWg4QuTyWN6tZFcRm9xSWtNg6711IDKXZ3HBLnSU8U0YCcjy/vcZZOKksXzedvwQ4znQZd1
 oTNcBBVjgoYL88OwkkxdOY1PwyomsdLrGsUILAY8ub7/BvFlwvYfIRf2o9PYQZgoEGbgRCOjiBZ
 +RJr+F96bukjLbQiIgLYd1TYx91TKxDhawxXkQ6icsK/fKW40TsOR0CGUKeewC8efD1hWr6I35f
 nCfcyUlMahL+76i5dx6G3vqsHTUzNXGo+NxYBgNRTmFjxIOEKGu5+WeBYiQHdvpBv4+zw0kJ+yb
 d+K24CFfCr18L5fYrGLYr4NxB8JgHCXjU9mxZUJPUhKNpLIINPkIB/nRkUZ5FeaL1nmTNZUxzsB
 oQQt4nMj+8g8Pn8qkZVeh95UalSBUxmr5FFl16UIkdXjdbHLTtkDuRpZ3MzCUlHDGRYntqSqziC
 r2yjRrrikx1hDuHTMcnH6Za4/EPtBMtn1UViWtYbrjLV6yMHU4sK+lq4jLoSUv2053v4gYZU3QW
 Er8UX9PfrzkzBn5MJsi3JNyu12rs6mHWgRyezn1sQA12uwqs80GYDYv97D/oEOAcq5x7
X-Received: by 2002:a17:90b:2887:b0:3a8:6045:5a24 with SMTP id
 98e67ed59e1d1-3ae581555dcmr1629662a91.38.1793197073809; 
 Wed, 28 Oct 2026 07:17:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c3b67bsm22182415ad.52.2026.10.28.07.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:17:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH 2/4] pdump: fix error code when adding callback fails
Date: Wed, 28 Oct 2026 07:16:51 -0700
Message-ID: <20261028141750.310963-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141750.310963-1-stephen@networkplumber.org>
References: <20261028141750.310963-1-stephen@networkplumber.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The register functions returned positive rte_errno on failure.
The caller only checks for negative values, so a failed Rx enable
fell through to Tx, and the positive value sent back to the client
was negated into rte_errno, giving messages like "Unknown error -22".

Fixes: 278f945402c5 ("pdump: add new library for packet capture")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/pdump/rte_pdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/pdump/rte_pdump.c b/lib/pdump/rte_pdump.c
index ac94efe7ff..9c368bcfd7 100644
--- a/lib/pdump/rte_pdump.c
+++ b/lib/pdump/rte_pdump.c
@@ -283,7 +283,7 @@ pdump_register_rx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"failed to add rx callback, errno=%d",
 					rte_errno);
-				return rte_errno;
+				return -rte_errno;
 			}
 
 			memset(&pdump_stats->rx[port][qid], 0, sizeof(struct rte_pdump_stats));
@@ -345,7 +345,7 @@ pdump_register_tx_callbacks(enum pdump_version ver,
 				PDUMP_LOG_LINE(ERR,
 					"failed to add tx callback, errno=%d",
 					rte_errno);
-				return rte_errno;
+				return -rte_errno;
 			}
 			memset(&pdump_stats->tx[port][qid], 0, sizeof(struct rte_pdump_stats));
 		} else if (operation == DISABLE) {
-- 
2.53.0

