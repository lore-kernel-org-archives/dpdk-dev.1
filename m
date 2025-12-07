Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C8D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D56540669;
	Sun,  7 Dec 2025 20:13:09 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 7873E402D0
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:07 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so39070025e9.1
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134787;
 x=1765739587; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=iY5FsWLvX4SzyQeeSTCHPg0TUixBIxpSCqnqmLruUbHWDNpOOBGJt4r2+KHd9gODb7
 Jd5/6kM7DoPcSahORuHct1NhL8EYQJKYMTUw+gcs3T7/o/naUJ4F6vbdm/UXXnWTT+iO
 Qwsul5XKNQmvQGizoUAam7qHDb9TdwDbL+YiPO3dhx/j4tcLKd6ZKKmNKu9pD1T4NLsR
 hgGt+knK8svkboXQnuSBhhoETjZNCvD5gs9uUWH432KlPLLto7x0uF+AfxheSS34hNkd
 ClOIXsuRHwGT/BDS7ChtKUPdN+OTXp7oMhkqZCjb6WD1rOpha93ljharA6ezxKCh1bDn
 PQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134787; x=1765739587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=vKPrVUpiEULzCn/vJNwymCEYSJWhtwAtTV489N2wy/+ur850zM4et3MwPQdDi40PJu
 nYhu3BIBn7BE0gvE7zt+Fzs2Sr+1DK/wEzn8gkX8bb3NoV3NO10QL4BSWgBfQn40YhNA
 DMa0sUjUYC5NeW7S3ovSEQoQk15GE4EFekZmw0f0F4ksUZs5bD1G3grU1Qps3mfHbto1
 SmBouQmTRZBSaNFAbJzYY9msXaZaBa5bH8tKDp4IbCDjx/UzV4u19Z813JpjlgLAeWLi
 59ALMIgUkG/KxIa3PQBPdwQ4YwkNBGPNCmvnAXSljgi2CtqP8vDHUe/2nDI91FcwrBQ5
 BrCQ==
X-Gm-Message-State: AOJu0YztTmGAd6gP0R1KPPm+JBEb8UZPEjEyKFHqAU4XTRMbUyylpyy/
 HeTA8qYiaFLpjlMt3T8aZHa5DaIQKNASR7hmY0A9PawGj+auNkznW8nWu3I5e2UM+pISKW0hwsf
 FxNoJ
X-Gm-Gg: ASbGncuNO7zPoQiGXUGX1HWes7p1SlogfYxi6ItL1HKtdxzAUDtlKwwZFeFlwGqDdlO
 UnYUpNMuLiB/6uhI/dqnMF6FQBca9LF1EbxOpAFzfoCBDF1d+PjtATE5JJrnNGl7KMphcmF4vHc
 1bC9+51TOgnNf6/q9NjWmZjsKoAxjZtCR8zeOcRfgtp9XiEQcWye2lJ5HSD67EseeHCj6VWxxh2
 zf396rKdyTpFSd9ToAT/plPXfFrLLUyBNlOAExZAn+Mb/RF7Ii7x2jvl13UXgg6nvRomD3TLssx
 ln7U3fk0YW64fft41MgmZ4ca71sCp2r0cRIuKsW7lIZhYzVFKjXvf4Ob2VujsXNPSfy1z+0H5mY
 P+GObaUYQ1L6ZXBRBKOS70SMZfHxko6IiQpU0fBhiCGctJ+DYDohCmJbMxSw6nEh2nWAm9Ifre5
 xxiSjIU0HQouiIdB+2zClewEFsb62EKTswz09BUo2m0pnPBPPf3g==
X-Google-Smtp-Source: AGHT+IFzWbvXxobuioPhlqdt8Vmn+zlYorA/hvJBOaZA6Kx5XQVN1nZWpuIrt0FKUXYPwyVSsABSoA==
X-Received: by 2002:a05:600c:8b34:b0:477:7f4a:44b0 with SMTP id
 5b1f17b1804b1-47939e49385mr55753265e9.33.1765134787054; 
 Sun, 07 Dec 2025 11:13:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 10/17] eal: add check for sysfs path overflow
Date: Sun,  7 Dec 2025 11:12:01 -0800
Message-ID: <20251207191242.165619-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

