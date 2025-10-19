Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A810CCD195
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Oct 2025 16:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5266942D90;
	Sun, 19 Oct 2025 18:57:36 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id EB5A1410F1
 for <dev@dpdk.org>; Sun, 19 Oct 2025 18:57:33 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-28e7cd6dbc0so44935665ad.0
 for <dev@dpdk.org>; Sun, 19 Oct 2025 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760893053;
 x=1761497853; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40lnV69UwbIVxryHObxRQHARRLz50lT+fAtg323Hyng=;
 b=C3wIx6IBhr7JPMIp5A0COI6yZ0jv39EYdiPWeexE1VAZ/5m41xi+lRp6Hw9B8syMQf
 DkqmTaFVqM6DrPxCbIcIeC4KF/jhm23s1kcXdzPlN8yXeivQsw2rRtLSn2uMvHDbJwa3
 s2deDC3HjaB045b3Xt8K4WjL9vmzXl2y09RWH6BhMREynrt8wR5/1g9x4WUnSEnlA06j
 Gr/fb/QUDxP+lV6I6JYoJTvdupPyfccUoufI2bD0UI2Mn7Ad0hbUmHdzZt0GtOZQsC7H
 +5uc1WP/54kZJHK0M0lq8UiQS6+O3xw2ssBCh7fYZVsge66DaiLH7kFEn7jEDR4p4oBu
 ya4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760893053; x=1761497853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40lnV69UwbIVxryHObxRQHARRLz50lT+fAtg323Hyng=;
 b=UjdeW8gfrehLkx+4/IuU2sB4HcXhb0JTkGNghIfdGoB7kDPTKe8TM6ApbOWFzlHlGa
 aKI6Rsrg80U8ZdZEvRUA87gEgYnH3NaGOJ8f3BFFvV1kXgNNQ3OSod4Rx4kcdfnrflyR
 Qiu+QiJSI4lu5GZAg/IHP0VCkCBNmpncQZ67id3Qyp15Eti4zHdn35/l7Y5A6RDKOniv
 ycdDezylpCOdW9jxZmTMu8nu9J0n0Fq54On+uK4QeK4kps/TQYItGjth1BSz/7MltyN/
 mMc+4rmk8KWkmD1p2qVz/Yq4fd1cf0f+s78Qnj3KckWb/UK82pwmePvwQzykKqOQcRRQ
 ilzA==
X-Gm-Message-State: AOJu0Yw0yeIKMTmT1qU/9uC8MrhQx+CkKOdV0lFIEN4Bob3g/jRYOyqy
 MPEkbOlDtvHJiIQGNh2srXRJGRm351ANpDawzWXP6eWu2mGXo6z9p9gnM5hod9BZhS2/FSN1Zdg
 Y/gukJD0=
X-Gm-Gg: ASbGncthiGcHi2mauC5jfD3bCAyYmJ0uZkLJ8+fS8GUIIKlUwth7GYLMN1Rz3WVH0WQ
 Gj5KFGecK9pkMfp4yDHvYwfforrplbCF2nX+QqFHVnMHQJ0vmdJr9gZIwrMm5KV6WPZm5rVowNI
 RmFZ14w021uNFn1j04W12o0Bmj6bg8gVjo2IirGX1PDZJhYh9MRRLRavQHMFR+99dFABXPd0QCH
 Wi0vapkZYGl9vzSM1srk0kCkIj9Wnd/kwzhNKYL3SvnbuFc4x0sZ3G2cVfLyMMKt+jy0sYUERCt
 ma1tpBH1GG9/BwBU84x9Keww2hEY5ZaqH1P3guREoDwr8AGfpOmRz+BYaalPvB2O9+PptA2RMZi
 FkO+U6oeTIuF36y3ihMTmqjYI6eRdudx+J4ELd46GfwaBDJromx4zX8jBjrcpS/B/LaR/SMd51l
 Y5Z49Funa1zDvG72BWernqTpFGU6yWVokRGyZIuMu+tJODIoyZ4Q==
X-Google-Smtp-Source: AGHT+IHWwRRp4X4fFPZP9L4XTHbDrJvqi/fyEzBUlVpRob5QIkw04Fvh1kpnMpDUwK7gniL0jtTSTQ==
X-Received: by 2002:a17:903:2b0d:b0:272:f9c3:31f7 with SMTP id
 d9443c01a7336-290cbe2ae83mr122545415ad.50.1760893053116; 
 Sun, 19 Oct 2025 09:57:33 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2924721b6fdsm56940455ad.118.2025.10.19.09.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 09:57:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Suanming Mou <suanmingm@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 2/8] pdump: handle primary process exit
Date: Sun, 19 Oct 2025 09:56:09 -0700
Message-ID: <20251019165728.164929-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
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

If primary process exits, then it is not possible (or needed)
to cleanup resources. Instead just exit after closing the
capture file.

Bugzilla ID: 1760
Fixes: a99a311ba101 ("app/pdump: exit with primary process")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..1741d7e709 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -1028,13 +1028,15 @@ main(int argc, char **argv)
 	dump_packets();
 
 	disable_primary_monitor();
-	cleanup_pdump_resources();
+
 	/* dump debug stats */
 	print_pdump_stats();
 
-	ret = rte_eal_cleanup();
-	if (ret)
-		printf("Error from rte_eal_cleanup(), %d\n", ret);
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
 
-	return 0;
+	cleanup_pdump_resources();
+
+	return rte_eal_cleanup() ? EXIT_FAILURE : 0;
 }
-- 
2.51.0

