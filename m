Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17ED4CCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 15:48:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D2D3402ED;
	Thu, 23 Oct 2025 17:47:55 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 97D9A40151
 for <dev@dpdk.org>; Thu, 23 Oct 2025 17:47:52 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-290d4d421f6so9408715ad.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761234472;
 x=1761839272; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40lnV69UwbIVxryHObxRQHARRLz50lT+fAtg323Hyng=;
 b=TVrWqBy05fxXMVBprsR5xi7g1X/WzkI82U+d9tlpYMTZ1IcHjx+267K3Nm6G4PeqEz
 B1mCeDrRUuN5VSxflL6+NAS08jo88fBqaf5iQgR1778Pty728VZIaGmSrjqYsFeIjpO1
 MJKyFS0+jR8/q+TSr4LB4IwVAvlpd3fG2+BcuRzURAXFF2wqvbhomWks5xLE10BNKkvz
 KXQGPUXMIF/vIaVTyVnRnCM0TQ5jj5fFBLxdpTV5XaK3EKwb2KykO/nx2FhHXfohZyAn
 ngjEuaWwfoMU5FHVFOs4kaWPoL2MXsPJlY2P82bORGLZaFFYP+qXlMpWQjR6aalCiE/5
 ceZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761234472; x=1761839272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=40lnV69UwbIVxryHObxRQHARRLz50lT+fAtg323Hyng=;
 b=OBOcb9RmTddipkII97hlabnebB4fN7CY8Gq6hjKRhFris7xouSbXQ+No8RhtJMDgyx
 yKP1PUuPMCg7FV4rbJihC6S2/1A6K4mlz2rwbrYMCcA5qiZLZXNGQxT10rVV1OIFgNPU
 JiDf/5W/D7N8V/4L3Hh2PBavFaMX9fRghhFw09b1oWbJBoNIyupfHX5rTUsj218EyjV8
 Mzqv6lHNhOmEw/gix430x6eSQJyIbY3Q3BLoD4F8xqhwHOHH+OFSd5Xxc8J8AFx91726
 3RJ0p+5h7EttQZFANDoe0906gKJwfqauPsvImPlxBkJPuUdq+xJNpn7zbiSizZbIe+4v
 TaHw==
X-Gm-Message-State: AOJu0YxCyJSTdiuSM7j0ZNlY8wX4/DapVMEzappR9O+DKBFDFqIreLaf
 jh6ytAjtkLgySPZx889geGSNP2cqbcR22v0945NfyqgTz4nZalh0/Bn/3CYU8HyeMe7b1DhTdvL
 xhc+6foc=
X-Gm-Gg: ASbGncuMa0XvTC9UVrR+WLWafNuChKNl9xyZvsuSHLeU+1XRX0V0+FihNveYCxYegOK
 9obniX53p1smaDUVHdXY8wb9fjuKFhspGr+vr9dzZw9motJ0O3TuOa/8DRlqzAeVX8SaWZJ0bb4
 hhgNXT/zohiMUdr48+UVZI3IrENAXSdn4j+ceOpeXdVmsy2PsJccAmIlY6roSHZGOpWnXnKKbDn
 U9DDM9kYGWO6QvphIXWNoLIbn418H39ACX7XB+3dtr1wi/GQz3MZWOf8ykOcd0lIOwSSg9n5lWV
 q+TXHy2d+Ghp+bsIginK8SK5udiEjnVjtCHXx71xQ7nu2qWiJwRYYCbcnEp2oESE1S9iy9eKj9l
 MwZLLguS5NAaPQJkwFwaFPDoESR/wSBs1dhSocvMEmey1vcJtMkmbfaKoy9LUk9LcHlaAl+CdlN
 l5qCd73Sz5yiPSqjq3sW7aeChtnCOhAPbqIAwLKaER5eP0qBDT
X-Google-Smtp-Source: AGHT+IE8jKLHA5S6UZGjEC7pG79B8CL55A0E3WNxt6tSVbRU+M32/L6AAyH+hWlLnqxYRHUsKbm4Yg==
X-Received: by 2002:a17:903:8c6:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-290c9cc30b8mr316571405ad.21.1761234471753; 
 Thu, 23 Oct 2025 08:47:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dddc0e4sm27906065ad.8.2025.10.23.08.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 08:47:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Suanming Mou <suanmingm@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 2/8] pdump: handle primary process exit
Date: Thu, 23 Oct 2025 08:46:23 -0700
Message-ID: <20251023154748.38535-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023154748.38535-1-stephen@networkplumber.org>
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251023154748.38535-1-stephen@networkplumber.org>
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

