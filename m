Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA3CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 454DB40A84;
	Mon,  5 Oct 2026 17:17:25 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id A374240A6F
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:17:23 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso991994a91.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213443; x=1791818243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OW/5BtQ0UkOsGL6nV/S7OrhuKJ0OtRWWm1KkGU1xae0=;
 b=VL5tMQvIDbGyvS8yBD4/h7WDaG86e2BF+S+2UmRrqrs5QdDLG1c+PnD8H6HQZtP3PJ
 CnYWR5OrkpqZWO89tYL8jDeynBRkl7RO28vZvv1bXfke7s0vYOmn8+TaZTvdg5ZzCfPL
 g+/8H2AFEuyeTwvla9w55ZtZIluo2Lv7hb+Ybf58s/6OpKc/hA8x2abtVfQ47h6inoni
 matVV1/fb90fyhxLWrMju7y7yhz2au5E+sWPg7Inze5O39q2CkBg8g/MCVr0As74Vubh
 1gY7WAJRZ9tXn95LVFcEMfbYKYMTzlSgFi6/xjnEHG/KK8WOCK5bzzlCWCVSPILxbMPK
 bicA==
X-Gm-Message-State: AFq9FYI6/pyU8IRNoVY+V8W29CZPv3i1DDBmjsmmZoU2qoX8xH4v7qOd
 8PO3DNH+USZuU8UciX8mwQwT74syiTCADQVacsHdj3ZH+QhLUaITqarVxwcumZ5pHjGvP3VRx9B
 CiZ4TZYCHw2Cd3mJJvQnsk1sSzw9KZmhQ05hi0AyHrdTst6RJah9Mk9NxnWi4Y0KACc+V+JoxA8
 7baN+Hhvtxo3yxDsDPhMNBwn3fS01YmiIyJLn02JAXD4fV8lfWRbvljPvzioBFybiFxWne/w==
X-Gm-Gg: AYBFou1IyL0TVcu9kLOo5hDq/AWjmXIFEx2WfUABxF48wu3z+QDm4CKkQaeec6GARuT
 vrxRpIm8yx99kcGUpB8m0pwFIB+3if0whS+kqw4z9urWuUAjHJQoHDIBmW8Qe1REKj2WTnejVxR
 Ndin3/L+S/+sLjImh+GvKBvgknt9JOnc6HP+J1/is3tS2uGvYvVh/jVRrka62B6kbVEOeqT8aiV
 cS3z2Ug3gWzpluiKTeDXHuf6xAKWfsE3DTHm1mb73ywsmgUnc2AW3803qFf8SWkmPJPO5ksneRU
 h9KmxxOa9SGWvQa2/zyBWlAIHn94CgqmDpBrIJEsqvqtZtL4PzbsR4Xt21M/BF0PiHBPkZzEOBB
 kRI6ZXsKHBz6TI4R7c6TvSktf+8QmZ8F9OCa0F1WR0BB/o7ep+sfp//l9icLdJmKIBR70E2/vN+
 cKKvVb9g8hsC0CsH4kylwuqyVKyJFS3mNYL0E=
X-Received: by 2002:a17:90b:4f:b0:3a0:deda:3d07 with SMTP id
 98e67ed59e1d1-3a787181df6mr6019700a91.14.1791213442634; 
 Mon, 05 Oct 2026 08:17:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a7bf399692sm919022a91.4.2026.10.05.08.17.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:17:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93dd3c3badbso387717185a.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213441; x=1791818241; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OW/5BtQ0UkOsGL6nV/S7OrhuKJ0OtRWWm1KkGU1xae0=;
 b=hOUac5iVfZMk4rfqdz3OI0zHgZLvS6KbyBn3PCrbTOP91aGcFXyoMUkbjoKW0QNg1U
 x5izks/RZL+lmLsiNnpVkXvyM80MsYWqVyBhNQKNTNP4QZINhNR9YD5VOA1nirwHjiTg
 uHMw+/Lhxj0C6luaxpvTcpYpXcMUTzjl0MNkE=
X-Received: by 2002:a05:620a:27c4:b0:93c:6028:6d2b with SMTP id
 af79cd13be357-93e5103b923mr1204732985a.43.1791213441133; 
 Mon, 05 Oct 2026 08:17:21 -0700 (PDT)
X-Received: by 2002:a05:620a:27c4:b0:93c:6028:6d2b with SMTP id
 af79cd13be357-93e5103b923mr1204728485a.43.1791213440512; 
 Mon, 05 Oct 2026 08:17:20 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e7ec53cd0sm110432285a.14.2026.10.05.08.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:17:19 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH 2/2] net/bnxt: fix hot-upgrade app instance ID limit
Date: Mon,  5 Oct 2026 10:16:59 -0500
Message-Id: <20261005151659.1705967-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20261005151659.1705967-1-manish.kurup@broadcom.com>
References: <20261005151659.1705967-1-manish.kurup@broadcom.com>
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

CFA_HOT_UPGRADE_APP_INSTANCE_MAX (4) represents the max number of
concurrent hot-upgrade instances, not the max valid instance ID.
Valid instance IDs are 1-8, matching the existing devargs
validation, so tfc_hot_upgrade_validate()'s existing
app_inst_id > CFA_HOT_UPGRADE_APP_INSTANCE_MAX check rejects valid
IDs 5-8. Bump the constant to 8; the comparison itself is already
correct against the corrected limit.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
index ada9741dfa..98b96e0a11 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/include/cfa_resources.h
@@ -194,7 +194,7 @@ enum cfa_resource_subtype_gim {
 	 CFA_RSUBTYPE_SM_MAX + CFA_RSUBTYPE_TSM_MAX + CFA_RSUBTYPE_TIM_MAX +   \
 	 CFA_RSUBTYPE_GIM_MAX)
 
-#define CFA_HOT_UPGRADE_APP_INSTANCE_MAX 4
+#define CFA_HOT_UPGRADE_APP_INSTANCE_MAX 8
 enum cfa_hot_upgrade_cmd_op {
 	CFA_HOT_UPGRADE_CMD_ALLOC = 1,
 	CFA_HOT_UPGRADE_CMD_FREE,
-- 
2.31.1

