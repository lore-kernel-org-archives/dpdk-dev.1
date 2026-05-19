Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17805CD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 04:44:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A6DD40613;
	Tue, 19 May 2026 06:44:34 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 8AE2540613
 for <dev@dpdk.org>; Tue, 19 May 2026 06:44:33 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so2137489f8f.0
 for <dev@dpdk.org>; Mon, 18 May 2026 21:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165873; x=1779770673; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jn5u+5Hds540tkazZNHbNDSJw1nwLNtkjEiysndB/2Y=;
 b=jwlZpm+g4bSs2PwrSg0+MSlT+D3o6oQifuHrmRDuenNi/CSOY6RjMMFYCCiVznRdlk
 sXYBrzOE8hzpGPFg4fKDyk8XbIvsT5XvCV+jhyNDVHFHS8qXX/IMtqS+wlbpt2mkqvrU
 NKUpwf3sZM+bZoPvmTPRWMPOzI3CUVnuYGyeJtJkpGYDwltJMPE24ydh8AcmKaHKh5qn
 /jp7vEvfZcbvQ97r+2hrANHGPlkozas9aQL6pxiuVaxwG/SHP0eHKi2U+3S44xMt2IN9
 Y5/f81bPU0yS5UdtY1NPzUndV0HveKexxxpyHpiGSjPBbL5nRZzJOW+7OLhi/ju85psv
 O8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165873; x=1779770673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jn5u+5Hds540tkazZNHbNDSJw1nwLNtkjEiysndB/2Y=;
 b=FMBGtcsXgWojvwNWcRdXt7h0Ho12vUPloo9MDrnCGmSI/X3dFMustdUNeFlltTwaXv
 3WWvGvHIUjLi0DW7wWXimtNAE9Hyz1cMQASOFKqj10C+QfrGmMevESKD3udB8tqGmTnL
 JfnoPg5MUrtlvaGMLDEAxsP8IGm/XoiCbTWowNIpRMBK/qeXtXEOAz5OwfkDE1z2K0BM
 MMRWG6AbkwcWI8Rcv+C0aFDL45myDvW2wt6SVPzS1cqYZ/hMbUmIxTwiVonVitt8I/la
 LbH8PrR/MmSwB0OfoNv9T3RV3cQIqT9qCXQR9g1WTlUuEPc8Tt1xab27BsUQFiJ4WtuR
 wXig==
X-Gm-Message-State: AOJu0YwjLw/CBWpw5ZkqxGtwOiHGSqSZFmSbjTesMvQ9FvKCFCqoG6QG
 Cywa2yso8aJHJDIPK/Y5f5MhsS22L5KwA0jqMdQg8dYW316pcHK4Q08QoxPAkHu0
X-Gm-Gg: Acq92OGwSi1yhmgpsdD7xSKchpuvhCfnGQyQ+EuVt1gv7rZsjbFRylXufO3V28xqevl
 EeAj4qmHm7ohuXobIOQ6lXP18eEw6hsQloLN/NiEnh+FXQ2txCfrgYIp9sitF5p6910n/Piq0I+
 7SjI9ee0iIwqgrkBORcVE3O+g6c4KCBXrHgCOf7pTdj3KAbOeVanjQISa9RXABLzAqOx4xc3FpH
 pL94E4ATmRd8hxgl/X3yS+3mSh7g6N5tBAgVIBxRHAChMNj3+6rEJSX8QADF6UTVHBlu/l25f0Z
 tPI6rYVcYuuO7GQf7ocTA6l1hyB9Fc3bq1WwWQCEmYS2QC/f342XmUuXhcGcXgSLCL4g9y0Z7dn
 2rYRWGpybIfXffYn3fRHCNz11fLJAY3UZ73AUA+xxl/GSdZ9JJasLKKWrcEAR3yg53R5mF8K5sC
 KiOkon+eXLKR8qKpzQ9nUln9zcsuZvevDatFGvtyBVnQXSnSdc/zKQwcG2
X-Received: by 2002:a5d:5c84:0:b0:43c:f90b:5668 with SMTP id
 ffacd0b85a97d-45e5c5beb17mr27701106f8f.23.1779165872905; 
 Mon, 18 May 2026 21:44:32 -0700 (PDT)
Received: from happy ([185.229.111.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a5653sm42842861f8f.35.2026.05.18.21.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 21:44:32 -0700 (PDT)
From: Denis Sergeev <denserg.edu@gmail.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, ajit.khaparde@broadcom.com,
 Denis Sergeev <denserg.edu@gmail.com>, stable@dpdk.org
Subject: [PATCH 1/2] net/bnxt/tf_core: fix ignored return of EM delete
Date: Tue, 19 May 2026 07:43:43 +0300
Message-ID: <20260519044344.9544-2-denserg.edu@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260519044344.9544-1-denserg.edu@gmail.com>
References: <20260519044344.9544-1-denserg.edu@gmail.com>
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

The return value of tfc_em_delete_raw() in tfc_em_delete() was
silently discarded: rc was unconditionally overwritten by the
subsequent tfc_cpm_get_cmm_inst() call without any error check.

If tfc_em_delete_raw() fails, the HW EM entry is not removed but
the function continues to free the corresponding SW pool entry,
creating a HW/SW state inconsistency that can lead to stale flow
matches or incorrect pool slot reuse.

Add an error check after the call and return -EINVAL on failure.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_em.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.c b/drivers/net/bnxt/tf_core/v3/tfc_em.c
index 3fe4dbe3fe..4c126dc2f4 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.c
@@ -661,6 +661,11 @@ int tfc_em_delete(struct tfc *tfcp, struct tfc_em_delete_parms *parms)
 			       &db_offset
 #endif
 			       );
+	if (rc != 0) {
+		PMD_DRV_LOG_LINE(ERR, "tfc_em_delete_raw() failed: %s",
+				 strerror(-rc));
+		return -EINVAL;
+	}
 
 	record_offset = REMOVE_POOL_FROM_OFFSET(pi.lkup_pool_sz_exp,
 						record_offset);
-- 
2.50.1

