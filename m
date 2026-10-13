Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F889CC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 17:16:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6A0C40609;
	Tue, 13 Oct 2026 19:16:18 +0200 (CEST)
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com
 [209.85.222.226])
 by mails.dpdk.org (Postfix) with ESMTP id B11EB40697
 for <dev@dpdk.org>; Tue, 13 Oct 2026 19:16:15 +0200 (CEST)
Received: by mail-qk1-f226.google.com with SMTP id
 af79cd13be357-93e56c287b3so255292385a.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791911775; x=1792516575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A6XSoKLwXTMejoC3grrMoZGl3OI8pvgXneGHwWUC3Ag=;
 b=IRQHULfQ3gTWuyibrBi2OPoemG0FOgvFDxlzV0z6q/WcJZXwn5dszN4qdwUPZ+Z7Gn
 2xL+Y8flT4gfD2XydSHGVQEYsfjgyR+3WqWyD/Hm67ZW5bD1F0+GfszxzwLogbMnoRzm
 s7aL2u7bZJ90bm0fkqnXDH3Q7LHdAM8wGnF2PjKv/SwE43swc3+GG6r/x6Zhyyc0kO6v
 qZLWC8G5j9+PUbU25ZyZkrCCZefYRbzwcAO5NL1NVTdQ2MqyZrBT3lrWvEff3/5fLsN9
 O6hDGVo9wMdfvPv7GGEZdUY9FzzXeMGNBSEW3O7OVYVCqurTLCDZteNjrdmpodMWmTnG
 NoEA==
X-Gm-Message-State: AFq9FYL6nfBmRZxf2ni6/ttX0Q+rBJHfT94RLwJPwkBI+8ueUcHMmRJ5
 2FGGzez0gmgTbkKv/RNijmH4ZDFFQMFSPSdRfVxnr8d4qsCQx0qKNEUb7ePCUX4VshHFtT/7yV8
 VP0Hi6v2O8OKZhy4GD8+HMUZf8CNi7LTKn6zSY7LZHKFbA4obmJCewhwaKFLIo2kFnO5aqDPxNw
 ypGJ3vZFJ9KH7FH57ObYbPL+I1dhQFUUs7QYEziuVDo7KYOacYNqbZC8RGudXKBdZDyLPUotNvj
 aSUNL4pJpbT
X-Gm-Gg: AYBFou0GAmGElJIDNg73L7yuNo54r4D7ouD5RTAHP1mPbDjsLxsIQ/4AWvdqyISBIS5
 wnD5bkIYMpGeDzxu8V9KvuGk3K9dF4z59vQAqpxU8/sGtYSfDkifmweNd9Qk+iquf6ejx9mLXWF
 bLmHsfcJc80jbUg276e+vlAHgo8/9R/EbzpOidSCZQRbmjFYIjCgGR91vEt6NHAs0XP/pBwR8MT
 9dXL+76kU7xnEFenPWHIHTfUaYzUz2Sh3aBkH+8pyetOs4jHE5lbveUzSL4j0Idk3j4NZD39J2d
 Q1gQ6GIeieq7wxmo3pr87ZKImmyO6ZlCcB29m2PFMUC6LNQeXc6BXSAl29rAtwtGbbvJkcE6mRq
 j5N04ClqZ773HjBOagwLRTkKG0GyixIjcISsJfwRQqPfrYeKTlQ5k7WLRir882ndeFkHESTW6+p
 aCOFdibeaBZP4f75eJujWeUfST+V+kmouxGOHpsqrDxgnvoPpAEouZ
X-Received: by 2002:a05:620a:45ac:b0:93a:2bdc:cd57 with SMTP id
 af79cd13be357-93ebd0c321amr2246319785a.2.1791911774498; 
 Tue, 13 Oct 2026 10:16:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-93ef50769d7sm74916085a.11.2026.10.13.10.16.13
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2026 10:16:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93dd3c3badbso724317385a.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791911773; x=1792516573; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A6XSoKLwXTMejoC3grrMoZGl3OI8pvgXneGHwWUC3Ag=;
 b=Awocj3Po6POVpJvknLu0zN5Dw38Vka7yL0AhNw0LNLsRc1mwpe52To/PzqJmYgMEAf
 RdcPfYUJylNPOZEsfx3a5ljZ7ABEEZA6oEG9pUVFvYFUtAIT9LiErQTXL4X0Mwad4yoq
 s73uuajNExpcMWcsTytkXFKV3jiP615MlKs5E=
X-Received: by 2002:a05:620a:4089:b0:93e:4e96:47e9 with SMTP id
 af79cd13be357-93ebd1b737bmr2200953685a.18.1791911773408; 
 Tue, 13 Oct 2026 10:16:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4089:b0:93e:4e96:47e9 with SMTP id
 af79cd13be357-93ebd1b737bmr2200945785a.18.1791911772709; 
 Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ef5028051sm283063785a.18.2026.10.13.10.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 10:16:12 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, manish.kurup@broadcom.com,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 1/2] net/bnxt: cap memcpy at field size
Date: Tue, 13 Oct 2026 11:19:54 -0600
Message-ID: <20261013171955.452416-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013171955.452416-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261005151727.1706155-1-manish.kurup@broadcom.com>
 <20261013171955.452416-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Dakota Sicher <dakota.sicher@broadcom.com>

ulp_rte_parser_fld_copy() and ulp_rte_prsr_fld_mask() copy a
caller-supplied size into fixed 16-byte spec and mask arrays without
checking it. All current callers pass sizeof() of a protocol field,
but nothing enforces that. Clamp the size to the field storage and
log an error.

Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index fb1dc3f60a8..b68d86fe5ba 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -66,6 +66,11 @@ ulp_rte_parser_fld_copy(struct ulp_rte_hdr_field *field,
 			const void *buffer,
 			uint32_t size)
 {
+	if (unlikely(size > RTE_PARSER_FLOW_HDR_FIELD_SIZE)) {
+		BNXT_DRV_DBG(ERR, "Field size %u exceeds max of %u, clamping",
+			     size, RTE_PARSER_FLOW_HDR_FIELD_SIZE);
+		size = RTE_PARSER_FLOW_HDR_FIELD_SIZE;
+	}
 	field->size = size;
 	memcpy(field->spec, buffer, field->size);
 	field++;
@@ -106,6 +111,11 @@ ulp_rte_prsr_fld_mask(struct ulp_rte_parser_params *params,
 {
 	struct ulp_rte_hdr_field *field = &params->hdr_field[*idx];
 
+	if (unlikely(size > RTE_PARSER_FLOW_HDR_FIELD_SIZE)) {
+		BNXT_DRV_DBG(ERR, "Field size %u exceeds max of %u, clamping",
+			     size, RTE_PARSER_FLOW_HDR_FIELD_SIZE);
+		size = RTE_PARSER_FLOW_HDR_FIELD_SIZE;
+	}
 	/* update the field size */
 	field->size = size;
 
-- 
2.47.3

