Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BA606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bE1dx9GM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFFCF40613;
	Tue, 20 Oct 2026 08:59:54 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 64DA74060A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:59:50 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-9178aabd30dso26664886d6.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792479590; x=1793084390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qW3apRMNEN0cfcD9ziqESlj/subn7kl3i5Q279uCLLE=;
 b=y33m6fPd/Oa/yEafPf+8nwolXrgzg0l4MFdN2yZ/ZOcQOJ2g0izbJJcSOJwljoqDu/
 w6QrL0xn9AvwdJXqVJC8mXtdsPFlYwe9XSsc68UnL10phtMRhIZ471G9zHaLKo7Q/x4I
 TJwEo1DwQrwkl9yEY3hyOIe/Bj43hgSoviGwEAFSBeZDTg3kjM1MXr+288RT5MS5ufpa
 xxK2K7iRt5mgsAcJi7EuUTGZvMRP7LlZmZk1xD/ydg6O7XB/sGEh4jmQ3JZZBDjYOYjE
 mTMmlvBFgpWN1feqrHGsBLoDjJ8OAWonIr/8MibeW01U3ChanqFCErjCeNj9yX8kZhu8
 EF1Q==
X-Gm-Message-State: AFq9FYL8nwqaXAb2J2z+sDqL4a9VWRFwXhMORv4ggGs4taUMvezkDWJy
 DxHX7iSG0YeQ77E6twgtOxPEWobRTRjEEdKhsl4sn0h5auqroqCn0lyW3ex5eZ1Z+Gr2ZgdDb5z
 WfWtsnvJWXAly9UOOlf+I91c+dv6k4jP7fZ0Dn4IiLPwAcdgHgFpmemHlhtvwZ5CSigpzhfLb+C
 +CE4Yy33I7ZvKdZhtQdeZ2eLgIhJyX7ojRerhxpqvAGuMGcQy9pEYxPmyL0Kb4XQS+ELLjSQ==
X-Gm-Gg: AYBFou3rAcCO/1nz8algWRiqTWpi7ItX0aI4WBaB49f1q1E3R+a6AGVmeOtc0LwjY2d
 rT6XuiZv2MX8i6mTFYflN5VlOervZwlueqs49J0VyZQULUKattPrE0H3KmF2OLEi6ai30lTptEu
 LN8b7QKaIUM6eCmfqGwA5ge+Uz8EMNuhltJHJH9qVABhnt0n3gXdjbstsc+pUKAmmmbtfkPxZss
 PrTUBza9DBzMUBmeb2yIY/Cs00cAlHToQy6jvq7Mo2KB7NGapQwOT2VjK/68EomHq5fg90db3vl
 FCORX4y5QzTO0Z0xmcM9J6ts+tFIkI8AttscbvU2/70o62zfUhkzE7i6/6g0sm/j6FJ0dt5lxAO
 ylvWyqhY8zpCVE+5D4cBYYnZMzFZ6tQAqPeyI8wduDleY8LWg0NdgUWyTgk85RtlQb2zDi8nBUP
 RIy1G0IJG9jtl36yqOKiyCJcizLPPUBl2V5ASLBA==
X-Received: by 2002:a05:620a:3196:b0:93e:4e27:359b with SMTP id
 af79cd13be357-93f29c97a80mr1673740885a.24.1792479589567; 
 Mon, 19 Oct 2026 23:59:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93f4b02dc19sm21605285a.16.2026.10.19.23.59.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:59:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso6029865eec.1
 for <dev@dpdk.org>; Mon, 19 Oct 2026 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792479588; x=1793084388; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qW3apRMNEN0cfcD9ziqESlj/subn7kl3i5Q279uCLLE=;
 b=bE1dx9GM4KZv5QPXH2QFTCxpWEDy2809Ql/Re2RAYsOlq0tq8fE6I8xS0bDKZWp2IA
 8VM1+zs68ULSsVVsxBMje+0ENygCRj2c0tYcbs2m3qDSN4yPWSeiyU7Vstk10HdePE+u
 mW3w/PKJ/BUWj4H/rgSuO/zcmLvIkGIBRBDJU=
X-Received: by 2002:a05:693c:8946:10b0:35f:8c5d:5928 with SMTP id
 5a478bee46e88-361a1f567a5mr12772120eec.30.1792479588225; 
 Mon, 19 Oct 2026 23:59:48 -0700 (PDT)
X-Received: by 2002:a05:693c:8946:10b0:35f:8c5d:5928 with SMTP id
 5a478bee46e88-361a1f567a5mr12772084eec.30.1792479587300; 
 Mon, 19 Oct 2026 23:59:47 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082a7b33bsm70169294eec.24.2026.10.19.23.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 23:59:46 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH v2] net/bnxt/tf_core: fix TCAM alloc-set key copy
Date: Tue, 20 Oct 2026 01:59:44 -0500
Message-Id: <20261020065944.1067945-1-manish.kurup@broadcom.com>
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

In tfc_msg_tcam_alloc_set(), the key, mask and remap are copied into
the HWRM request with memcpy() using the address of the local
pointer variables (&key, &mask, &remap) as the source instead of the
data they point to. The copy lengths are also computed as
size * sizeof(uint32_t), although key_size and remap_size are
already byte counts, so each copy is four times too long and can run
past the 2 * key_size + remap_size bytes reserved in the request.

Copy from the key, mask and remap buffers themselves, and use the
byte sizes directly.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
v2:
* Split out of "net/bnxt: fix multiple truflow defects" (one fix per
  patch); this is the tfc_msg_tcam_alloc_set() fix.
* New subject and commit message; single Fixes: tag.

 drivers/net/bnxt/tf_core/v3/tfc_msg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_msg.c b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
index 89c256b810..af74007747 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_msg.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_msg.c
@@ -1088,9 +1088,9 @@ tfc_msg_tcam_alloc_set(struct tfc *tfcp, uint16_t fid, uint16_t sid,
 		data = &req.dev_data[0];
 	}
 
-	memcpy(&data[0], &key, key_size * sizeof(uint32_t));
-	memcpy(&data[key_size], &mask, key_size * sizeof(uint32_t));
-	memcpy(&data[key_size * 2], &remap, remap_size * sizeof(uint32_t));
+	memcpy(&data[0], key, key_size);
+	memcpy(&data[key_size], mask, key_size);
+	memcpy(&data[key_size * 2], remap, remap_size);
 	rc = bnxt_hwrm_tf_message_direct(bp, false, HWRM_TFC_TCAM_ALLOC_SET,
 					 &req, sizeof(req), &resp, sizeof(resp));
 
-- 
2.31.1

