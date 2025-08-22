Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66306CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 12:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0820402E9;
	Mon, 25 Aug 2025 14:08:36 +0200 (CEST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48]) by mails.dpdk.org (Postfix) with ESMTP id C327940297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 13:51:27 +0200 (CEST)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-32326bd4f4dso1658019a91.1
 for <dev@dpdk.org>; Fri, 22 Aug 2025 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wisig-com.20230601.gappssmtp.com; s=20230601; t=1755863487; x=1756468287;
 darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QxmzSnIFy+2OzOxcXmAzAFr7Oxn59IWE4tm3/3BRpI=;
 b=pDHIFIRqusvHuWAxYCjoSC4iPoVuOhDKFec18QkSKBSao7nFTsskRHAQIPGNwi/6Vu
 PVBOneYlnmSiD/bBBwevavKJFkPW3ApvxTeE43nu/A1/BB6CYFt89l9Jel19IjlFUH2x
 j9PSZSD1H/ZGiA8zmGLuQdrMQit9OIb8TVdb0g1exlCxvtZt7+dyT8saBu93CRO+q9Q5
 CCJKbixK5AuCLCEoDye0p+FQMKRJg2n+V5Qg5jO0Cxt3Jkb87qv8j6kiGDKmXErVc7LQ
 xmzVfccAeRh8fSn7N7/gGai1yyLh5AjWac6aq5FfYFcijEYoMNMPEbhrAFcA8fb97oFX
 ErrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755863487; x=1756468287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QxmzSnIFy+2OzOxcXmAzAFr7Oxn59IWE4tm3/3BRpI=;
 b=L6iJOm2/P/kKTCX1Jj4cyoXy/v/pShTn17iBej4CHU39wR8kjmKLZOEC8FRTNce5t2
 YfjkvuVtD2s2VuGjjvzdr0XuIE5PgGSE2q5C/J0m6tl7KSA+/OTm67vE4tPYB0oIZ+RG
 Bo3jz3c0weLPN+KdMMwAfB+Ph7+4IjeHjwPIEViIc3KKlDs9AVSTvFE7BK/0IPgC8Gea
 WybjTtRFPhTANSucrdmrJ7+r67Bojte3uCX++BRwtsgQXijupywrkTboXNJgSvHTaupe
 Fn2dupvH9+anJ31OwhShn2Y73hO6Ixn6b/Q+M/eqnODxb6+A6fHXHZXxVLKE9oAFOzRR
 wirA==
X-Gm-Message-State: AOJu0YxLX7M7pN80Kg2sdLA5+up9ZcPZl6Z9p/jwK8W8kjNNuoq6cN+e
 Iz9DuGEaQl/SzDuKYdeJ1dVrmZkP9ETA1obng3er1xNmlDsk/Tmu/RCdthk2nK/kAZLoiQBpFBY
 1j/I1iw==
X-Gm-Gg: ASbGnctE37iYsJtZcU25LozZhdbJx3BPIU4ePZSn+d1iuoV/jYIzaa3CDmJ7HhylbIU
 LhOnET51AI8x66llT+fjnPMH3dVciK7MA22k2MEQ1V/vFon+jnk4T+0nF5jOlC5Ept/e8MBqf1i
 JpEh7T3c/hFWPoNNbbIY9UHSHUu9xJMyVQGa6sy1IcYvXlSSxGCFUpUzLLG2BLO/gduKAla35uN
 yFxCV5VayhMF9x4X6YcfskzTkQBsC53/AZ4V05/6fQ/Sg80VJWIKtfxp52Bgz4N2hhdDisbjUyv
 ilS5uIXpmgAMHxqaiw7WW3vNztKnH0fgiTN5PBBujPGQw+7piaC2xJxJ3epXBqDnGZIOZjkk0NV
 BeomO1qIlQvC3HA==
X-Google-Smtp-Source: AGHT+IHE/7jSTx3DhFEwoVEcqwu8fTCxYfpM420bf6V0OeFJAb/o4KHWBXQpbsmFysCQjxCjlmsBOw==
X-Received: by 2002:a17:90b:58c5:b0:31e:7417:9e86 with SMTP id
 98e67ed59e1d1-324eedf1faemr8276795a91.9.1755863485977; 
 Fri, 22 Aug 2025 04:51:25 -0700 (PDT)
Received: from ash-wisig ([14.195.146.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e951da867sm6852280b3a.102.2025.08.22.04.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 04:51:25 -0700 (PDT)
From: Ashwini Sahu <ashwini@wisig.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: fix typo in struct vduse_iova_info comment
Date: Fri, 22 Aug 2025 17:21:12 +0530
Message-ID: <20250822115113.1313226-2-ashwini@wisig.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822115113.1313226-1-ashwini@wisig.com>
References: <20250822115113.1313226-1-ashwini@wisig.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Aug 2025 14:08:33 +0200
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

Fixes a typo in the kernel header comment for struct vduse_iova_info
where "IOVA region" was incorrectly repeated.

Signed-off-by: Ashwini Sahu <ashwini@wisig.com>
---
 kernel/linux/uapi/linux/vduse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 68a627d04a..10ad71aa00 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -237,7 +237,7 @@ struct vduse_iova_umem {
  * struct vduse_iova_info - information of one IOVA region
  * @start: start of the IOVA region
  * @last: last of the IOVA region
- * @capability: capability of the IOVA regsion
+ * @capability: capability of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
-- 
2.50.1

