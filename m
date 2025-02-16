Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E19C021A4
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Feb 2025 17:02:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E89F440EDF;
	Sun, 16 Feb 2025 18:01:39 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 6867B40E44
 for <dev@dpdk.org>; Sun, 16 Feb 2025 18:01:32 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-221206dbd7eso6875565ad.2
 for <dev@dpdk.org>; Sun, 16 Feb 2025 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739725291;
 x=1740330091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=sivJlImJ6xg68O9gkfH8B8zEZJvNGynzm4XsD8bKY9fh3mqRYqmDjGV6J3nO2X6KQn
 TJqvYy1QEErQHXGKAj1CRbbPIzO9AHrKqVRymUwJNMUkX5yFHtvcSRhG7sZ7DF6QjT1C
 3kCA10AG1Xbx/v/FUjitFVi92HFWNxz/N9OtlJJeSlR0f1A1HQcEx3wHtRM6SNe0YXEJ
 RhLvrOGoir8Ms7zdOKygKlPAMIJRlp1uYkveF+ZIn4OyYKWhmDlGuzUQ7X1/yCV22Oid
 LBUEjTTQO17yK9xmTBVJfiUI+0vvUsR0QNzDZ/ZHG0bmXAJSjxvMIZKMpsYkhoTCIOeI
 6XHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739725291; x=1740330091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZmRfVHuNAu8WwJa8G2gVzrRUKoolZ9gQmZARtWp9Nw=;
 b=JRDNxvMRvWLCF8e2/HvUzgW6xV4sNGXZ/48YPa0Kpue03K9hWk9EoFsRVdOkOszY3W
 n1pmK+Jwgs/s6h+NnJXLg8xGxvX6HzlwOvdiw2dP+GEcUFA5CEelRupiWK+jsIxXUhwL
 M1HcBILw43WrRC399qVfB/kjr8/FxHzXjcCM6ysMenvOBVbc/YKiV52A3vdA5uox7Qwo
 5QEm7TnKKpNJ6Xt44tI/fMRp4eyJjsnnFTOJEVFgfz3t/3ya2xEAgz/f+Wr7QGJ81Wo/
 HYjxB+fWU3Lb7VwA/shkG2+rLBNI2NT02vr9fybiONBHrgBLSNGjtcoKrimQ2l6+U42J
 zj3g==
X-Gm-Message-State: AOJu0YxQBtjf8LznQ8b8D3g+OU046f7K2WiT5Ic23MP3rJSdpTvhhkqt
 HVLsQNbhKrsXUV7KzNpd+a8tS547pfPOVouL6648W9iDDVq4CyYH8z4KGkmEwNyVyPpyDrk7Mpd
 1
X-Gm-Gg: ASbGncsdTgYKY6OY9yJGkl0gq73xpH14OYikyu1MtQEBBZKeWO1iWnEwkKlrdQhPWnu
 nKsDCMvdC2KRTeOmSZu+68G2+yf4rqxSOENmrvs/DeiG+Gt90g/bF0JiMo8799aSpuX1JVn++wC
 mcYjyvEQqo+pTjBmMQvCfB+njCfzqfXZu9UT12tFApITXuL9GHci8/T1F37Uf0cjkgZ0XF2NGBO
 UeylDnDP0KSpWlCCUOO7VK6foqawNUcHsh6rP80rOHVn0/iBUSfbDskU2HBjpxaiwILq8vUyQy2
 7CJZGH8V2h/Tz+2K42raBta16AfoLhHeSWtgBN8PU6aRqbc4P86oNC+TW2YErcbulVu9
X-Google-Smtp-Source: AGHT+IFKzX4mSB9JDz2Z6d4E3BehXAsE3y+QWbYaLEMYVXk6GAyGHqPZGcRFX0+hV0zwUHog4mSeVg==
X-Received: by 2002:a17:903:2cb:b0:216:3436:b85a with SMTP id
 d9443c01a7336-221040aa273mr106209535ad.52.1739725291643; 
 Sun, 16 Feb 2025 09:01:31 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2211eafd20dsm11196805ad.182.2025.02.16.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 09:01:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v8 13/17] compress/octeontx: remove unnecessary memset
Date: Sun, 16 Feb 2025 08:53:12 -0800
Message-ID: <20250216170110.7230-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250216170110.7230-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250216170110.7230-1-stephen@networkplumber.org>
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

Calling memset before rte_free not necessary, and could be
removed by the compiler. In this case, the data is not security
sensitive so the memset can be removed. Some security scanning
tools will flag this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/compress/octeontx/otx_zip.c     | 1 -
 drivers/compress/octeontx/otx_zip_pmd.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/compress/octeontx/otx_zip.c b/drivers/compress/octeontx/otx_zip.c
index 11471dcbb4..331d2d9475 100644
--- a/drivers/compress/octeontx/otx_zip.c
+++ b/drivers/compress/octeontx/otx_zip.c
@@ -81,7 +81,6 @@ zipvf_q_term(struct zipvf_qp *qp)
 	struct zip_vf *vf = qp->vf;
 
 	if (cmdq->va != NULL) {
-		memset(cmdq->va, 0, ZIP_MAX_CMDQ_SIZE);
 		rte_free(cmdq->va);
 	}
 
diff --git a/drivers/compress/octeontx/otx_zip_pmd.c b/drivers/compress/octeontx/otx_zip_pmd.c
index c8f456b319..74e3e942ad 100644
--- a/drivers/compress/octeontx/otx_zip_pmd.c
+++ b/drivers/compress/octeontx/otx_zip_pmd.c
@@ -479,8 +479,6 @@ zip_pmd_stream_free(struct rte_compressdev *dev, void *stream)
 				(void *)&(z_stream->bufs[0]),
 				(MAX_BUFS_PER_STREAM * ZIP_BURST_SIZE));
 
-	/* Zero out the whole structure */
-	memset(stream, 0, sizeof(struct zip_stream));
 	rte_free(stream);
 
 	return 0;
-- 
2.47.2

