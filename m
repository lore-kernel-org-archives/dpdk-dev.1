Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B77C02198
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 17:20:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA3640A87;
	Wed,  5 Feb 2025 18:20:21 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48]) by mails.dpdk.org (Postfix) with ESMTP id 9CB81402E4
 for <dev@dpdk.org>; Wed,  5 Feb 2025 18:20:18 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-71e2766994bso25488a34.3
 for <dev@dpdk.org>; Wed, 05 Feb 2025 09:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1738776018; x=1739380818; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLB4CC3ArJ9hP+1eRA9RDOx2WztzB52Bo0Il4K2Puik=;
 b=ZDT4cfFWtgh+XW3HO9gB98yWuhfuuyCH0QTKPKCeqke8dr3l+9Op9rX62wLwXma/a9
 Yux6XjyFpdchTDAXBbkh+CikDft7LHKJrIyjnxnz3LDFyYm34ZE1cf/qhChjYE8dfqeY
 LWQzHfOPVI/DPd4AyrQqBlWAut8Y8DCICMlgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776018; x=1739380818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLB4CC3ArJ9hP+1eRA9RDOx2WztzB52Bo0Il4K2Puik=;
 b=emMc0NPzW2Iw2enDdrSu1nDAf8h6AOz1AnuSYOAhGDXMWTHAENk7fLUsKFq/ExJB/s
 4ZKg0h/IqvwMoBHUlhKx3Cq4UBT3fwGfEbbzZzEuoe1STxKo7SRrzANgD9z5WM2eg8+5
 WRGzeMaOQu3iVlExDKJmfvOqJupfsPrA8+loBBrfYljbQCZ72374rVZrv9bl2vE+xOgn
 BPQwxFo2E8qFM8ST3r0j0dstRxJ6eK6ZyT3EoCbuFD+IxpRB6kMs9H28H4GLNzrBnNAs
 vv5Fydktp//K/DDxTuqv9y83zbF3onf4T939BEF0KodnG2HooQ2u/oDN41ESP69AoIG/
 YsNw==
X-Gm-Message-State: AOJu0YwZ+cmRu+g3/tbUNCDuTMCROepNsnBuPXoKAXYV46IrdDFKtDQb
 6OgFNxFXzkobFa0KTRJBKrYlIHSsfOh5onUVysiyIA/6FcqlBvMJIdj9cFduuyCu0Iq8VaPMnCA
 sj8gFYnL8JIOj1JsmQj2WtycQRT4Uhq87I2Wp7Cts1ElkBYpkhm5MBxDTKKVhU+X0TxKT9ITQL5
 /7rCziY54oz1tRGfrPj1auCEd317AP
X-Gm-Gg: ASbGncvQy9pzxKSzAcWgLWBhM01zuf/ekTwNLFtYfAwPq1H2lO8SmO7WGOl9gVMBg6I
 Xz79ct8mkOzQiEV4PcjlFQDvYkurBHs305tb2Ata58fA/Yq7Wikyv+pHYbXxeABfAQyk7ko/4oV
 ffqquc8mbKYRCOCOxf38AVR1O6HDD+z6Sqsg2Sn1WK/AuvacMfmCAz1IP8gUJzX6gYRhiBW0w9x
 2G20NDBusfrpiXQEg2Gtqsx6lUlT3AaSUwbboaWtXauw+VO8bBX7vDFNJxD1OYUWSsZuVJ3MXDe
 6oMYijRige+7GncmdCq3SocqaRCJPrE4GXBEtdBxrb7c05MQxTwgtiiUIoV+3nHao3d/x+eQGUI
 QMjOKK/G8
X-Google-Smtp-Source: AGHT+IEOqnDQRjOhX+3Z5lrKx5fGXKMQQ3ZqBWmO+HtzwbPMwn2CYHvqvgpOLEcZI8S1vekNzsKnGQ==
X-Received: by 2002:a05:6830:d16:b0:718:105b:1185 with SMTP id
 46e09a7af769-726a41ba991mr2466863a34.14.1738776017557; 
 Wed, 05 Feb 2025 09:20:17 -0800 (PST)
Received: from C02GC2QQMD6T.wifi.broadcom.net ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726617cde49sm4004016a34.27.2025.02.05.09.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:20:17 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH 07/11] net/bnxt: address coverity checked return issues
Date: Wed,  5 Feb 2025 09:20:00 -0800
Message-Id: <20250205172004.50395-8-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
References: <20250205172004.50395-1-ajit.khaparde@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change addresses the CID 449056:  Error handling issues (CHECKED_RETURN)
reported by coverity. The changes add return code handling to
address the issue.

Coverity issue: 449056
Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     | 10 +++++++---
 drivers/net/bnxt/tf_ulp/ulp_rte_parser.c |  8 +++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 2429ac2f1a..1a68cf5dfd 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -3612,9 +3612,13 @@ ulp_mapper_func_cond_list_process(struct bnxt_ulp_mapper_parms *parms,
 		}
 	}
 	/* write the value into result */
-	ulp_operand_read(val, res_local + res_size -
-			 ULP_BITS_2_BYTE_NR(oper_size),
-			 ULP_BITS_2_BYTE_NR(val_len));
+	if (unlikely(ulp_operand_read(val, res_local + res_size -
+				      ULP_BITS_2_BYTE_NR(oper_size),
+				      ULP_BITS_2_BYTE_NR(val_len)))) {
+		BNXT_DRV_DBG(ERR,
+			     "field idx operand read failed\n");
+		return -EINVAL;
+	}
 
 	/* convert the data to cpu format */
 	*res = tfp_be_to_cpu_64(*res);
diff --git a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
index dd5985cd7b..bf3a3deb18 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_rte_parser.c
@@ -517,7 +517,13 @@ ulp_rte_parser_svif_set(struct ulp_rte_parser_params *params,
 		else
 			svif_type = BNXT_ULP_DRV_FUNC_SVIF;
 	}
-	ulp_port_db_svif_get(params->ulp_ctx, ifindex, svif_type, &svif);
+
+	if (ulp_port_db_svif_get(params->ulp_ctx, ifindex,
+				 svif_type, &svif)) {
+			BNXT_DRV_DBG(ERR, "ParseErr:ifindex is not valid\n");
+			return BNXT_TF_RC_ERROR;
+	}
+
 	svif = rte_cpu_to_be_16(svif);
 	mask = rte_cpu_to_be_16(mask);
 	hdr_field = &params->hdr_field[BNXT_ULP_PROTO_HDR_FIELD_SVIF_IDX];
-- 
2.39.5 (Apple Git-154)

