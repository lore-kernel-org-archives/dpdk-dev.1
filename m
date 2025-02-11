Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35EEC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB47A40E3B;
	Tue, 11 Feb 2025 18:37:46 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 662C740E03
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:41 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2fa1a3c88c5so7687586a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295460;
 x=1739900260; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=IGVH0az+NVf7f77ALcAcbDFElPZPgUxx7CS4lty/Frv0aW1O2Fmu+3NuG+A/oP2iLm
 vx107WIJ25GoG0V+qS+0vrBnIaG+AV3WPqpKjEgqDIlBfqj96lxliUV9NX7i83VDz4Lw
 1iFmrSoXvH6nzqWjEKJMQZIPuX1WSqWkmTLYt+g62N157auQNCQWWJJvY5hqMpp1maUR
 G/ytfqq9zAzCHgk++uY3RV2m7gwaB7Hta1OEi7eX5XG0+wfkXfzprA2NjQEAAAJMzuiF
 dh6BQvUksdqYoydCtMnELa34F8MjF0uC41ZYlckBoKfBF+87W9hRQzYh5PzOqPsiGjNi
 gaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295460; x=1739900260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BWlABOBDjT+D93lC4xk3UAjMk4KNQQKjBPILflrvYnM=;
 b=SWopIK9kNOraJlt6q9hvgnpq87gNGimfvf0Vqc784LI/hsaUTbteDApiqsvI+OHytb
 99xhbR0ZM1g0LBK3EF7zxk2yrK8bwTR1khdw7J9vhwaCKDRs4SYMNGCPqqtJSrTAFn3u
 DcLlJKsczT4FsxmSuZU73pWYLIfstW3r846q+9E3wULRbezVCZMaU2fynyVv5HGGwEQT
 maHgk3iAlw9r936evL3F3D0VFmq5AS+9VT9pLPJGjyvOVdrqppp6WVjv4e1x/7v2/tcV
 6FOeM1dD/EKIIlKFI9QgOiyk4DzxgvGKXLVYOmPkwGYDbtwNgVLCcxwU27mmTQQLaTfJ
 L9jA==
X-Gm-Message-State: AOJu0Yxz0HU2MWpc+MUwL61LsP0LKihI8SRXqI5In9gBohe6yBGMQzuE
 4LaHzfKCUGeSI/+QEYv4MKrZEf0c5Jht0aq3Ew4fOyEb49SwAhW37gn4a2dcXUkDRlAYeNeEOop
 j
X-Gm-Gg: ASbGncvWv48hqudC0flgdWo05guiO/BVtD95pKUsMkoVxj+VWYDl+8OSj3eETIi6ksP
 gtYdMGLirJjdq3ALyC6LK1KCBLoQLB8T3qtdCP7O3tweLpY5JtfSFoAM5maUKRkDRbwofdsmOew
 CLlHdemCA6gCMn6vP/azI25Dq2Ct0MHYTFkNk9MCG14P7MM2renutXW/kHx4AJ89b6jhFCtyMaq
 iSGZUGGcoIXzONM1bcZzTqJyudA3/56iwjaaeQk+6/1a0U5/VXulJro0BLfuQBtxPLThet97Lfy
 ilgRfqqxLmbwrg0t9p456a4ygHk29yFHyV/ejHOXUp2/dYHM9bDIUXs5S+bY9Z16nfA3
X-Google-Smtp-Source: AGHT+IE3zjd0mPBMInZ5274lcxBI11igQClj67OyA+4KaeYrF/PCUT88lcvZRY0pksURTvi3k0syjg==
X-Received: by 2002:a17:90b:368c:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-2fa9ee192c9mr6091748a91.27.1739295460615; 
 Tue, 11 Feb 2025 09:37:40 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v5 09/11] net/ntnic: check result of malloc
Date: Tue, 11 Feb 2025 09:35:29 -0800
Message-ID: <20250211173720.1188517-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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

Need to check the result of malloc() before calling memset.
This is only place in this driver that forgot, other code
does check.

Fixes: 0d9bca480e26 ("net/ntnic: add FPGA modules for initialization")
cc: stable@dpdk.org
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ntnic/nthw/nthw_rac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index ca6aba6db2..f275e64da3 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -31,7 +31,9 @@
 nthw_rac_t *nthw_rac_new(void)
 {
 	nthw_rac_t *p = malloc(sizeof(nthw_rac_t));
-	memset(p, 0, sizeof(nthw_rac_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_rac_t));
 	return p;
 }
 
-- 
2.47.2

