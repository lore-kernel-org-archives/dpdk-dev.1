Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0617CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 21:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C979C402EF;
	Mon, 11 Aug 2025 23:36:43 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id DB99C402D6
 for <dev@dpdk.org>; Mon, 11 Aug 2025 23:36:41 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3b7848df30cso3253072f8f.0
 for <dev@dpdk.org>; Mon, 11 Aug 2025 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754948201;
 x=1755553001; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sA/EpXKlhQzBl31sFngWbdTwJUI3gmNFarNwZwwyqls=;
 b=jB7sbD3k1nidbjIuqTBFVw4quAISVzUhOQZrmHequSb2tti+d7Wyjfk5z2Zut9Ki1m
 rIQbL/PI6wur2V6/mhnfjUbkQ+WEEOxw2nut96OM2mUf13h2Qq76VyY/v8iUj2gNEjRm
 A8oGnU/daSYiGbYyhVuRgSiRsO1Fd0dcWzToKWJxti6sdVzrJofVriq3f4rkPYR/J/Zj
 FlOQSwG+eejNIWelU9908PUDTLhFY1oTJAAgBPIDlx3V2TMPxzLaYMwD0dy7dN1TVDlc
 LS+9b/owgrsQkgSvv81zLJumHQUf/1g+C8YOG4giMNjApCl5iplTck1uoVDGcsJdDTeb
 MDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754948201; x=1755553001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sA/EpXKlhQzBl31sFngWbdTwJUI3gmNFarNwZwwyqls=;
 b=ndIvz4pVHKS5G1DC6C84TVYP577nftrdySYSWkrv7Z3Qtzpg7ZJtZw+M7HrV1BBI1D
 3yvd0bc4IbUk30aSP191ULGWGgD/Y3I62oK8uc+e9BNqi3oviTifJfKKpV4pCQjD2I5C
 c+OEvTKvnSo0OSKc/0CC8PzcvdWX5Jpuihw/NvWz6vNiypm4Jh8xLsiO2JiAB3ZqYRcK
 fhHRTJ4FHH3sjEZGeJC1UG7qzJ17rSf3nskwKupSrV7K/++jTiJo248pUzFTrdwvaCy+
 USC0GOxhAM0kyKbqmWW79L3LIMITK2hh97Y9uwBbXmJ74Vi4ts0iYHxnPFtznTHwBMqv
 U5KA==
X-Gm-Message-State: AOJu0Ywz+y2K9fO6dr3qF8+iPhI25FdrRhrRDosFAhbN6er1i0ZpIEXE
 +JQybkOdFRPMJ2OAb9iKHS1YQRsxiRucshdWH6x08lksSLQrd1alA8zcUoH4sw3p9IB61e52JjT
 fdwZW
X-Gm-Gg: ASbGnctzfH4iwi0ENHjbMaaLApqrCAzqeOO1hHD/LfTN4ion5RyjZb3ljkjyPXLoC8Q
 OAUneHKP5p+xIPqhxmVp6nlnvBbMVWwcI5Hxc1cjDN8ZeiY/bhrmnMxk/npQRMK+pqMnMmkfvgI
 nJF9QeqS0NOqoQHYGPebHTqDb95nSJbu9XFqAcQsNL2yOFdHwhR77gTdQKdE5JeYoKqQ3CjoVPI
 +xau0OTCCreNm+v5M087lxXOtZ/JyKq3YExibVqcA0N0y/yUeyCOc023lKrjsUU3mfb1WQ1gwpy
 mCe7/howWaIJrw49HFF2GipndI9GeFHu81dxcLzVTFIMuTQAqrv3EvtaX06pM0v6/ADe6g03+ix
 /QU5z+F1zvexbIRqVaODCNgbb649DAxHHfVbWMlCRj99htF9qXVbuyeY+OKox59FVMDeRAwiK
X-Google-Smtp-Source: AGHT+IGIDVoep/tNCV5Z41a9CggvI3GcYkeh30qa+NvN4oFMqT/hnapcB+2yDX6lC81DlbNsUugzxA==
X-Received: by 2002:a05:6000:2507:b0:3b7:8aa2:9fcb with SMTP id
 ffacd0b85a97d-3b9111c5874mr778341f8f.14.1754948201468; 
 Mon, 11 Aug 2025 14:36:41 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a053a9019sm84661445e9.21.2025.08.11.14.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 14:36:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	stable@dpdk.org
Subject: [RFC 2/6] pdump: handle primary process exit
Date: Mon, 11 Aug 2025 14:35:00 -0700
Message-ID: <20250811213632.16023-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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
2.47.2

