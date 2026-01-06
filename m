Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E236CE9D41
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 15:00:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D242A4069F;
	Tue,  6 Jan 2026 16:00:32 +0100 (CET)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id 6C2AE402DC
 for <dev@dpdk.org>; Tue,  6 Jan 2026 16:00:31 +0100 (CET)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-7b6dd81e2d4so1048777b3a.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767711630; x=1768316430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efX1xNkp+x8/QgTfUCAnHcqauvrlPPTQ+yP9sFK7WOU=;
 b=ftWlg08wCJYQ+LFnj/RQpvgKkdzr4vsP+qUHmfAt3T9QSAstjfBvj+2V6nHyxWH323
 3A6JclU1nwk6lPPEvoCIGK75RS8GyMP6GahxE6U4Ovs+NuHXmTHQ2ozAIt8JKU3QC3E5
 gVIHHqMpxIeF2v9GehTtK+kSDJ5l1FjxV9cTi5lwrQ2F1k3FB/T4UvZ5TG9nvz2nmh0W
 kJJby/TpYUpNabMrA0+TPFTVIUQgr8ftxop6w2RDUDwUiZD9TxCgFG6V5IPt1iH1dTPR
 ixccI6kAwDbiF9OnoaGD1igTHR+CQtRzKt9cvoTEwtE0PMILTjrDzZ71FrmvwefzqoIV
 iVOQ==
X-Gm-Message-State: AOJu0YyOX2rGNcjlGCYRCd6+a2N+kPwnLO3wRzLLqLafoxo+cR0nj51N
 azYa4WGc92QyWrOuqV4QgDz1F0PwfR36JXAtVjgSWqcT4a2XSZwJrywAD85yTJoG2XUSu8Rksw0
 8rnmOglb+6vmPqAjDcY9pBbgL1cKhVCyKt8RRTspyjHZqc8DRwzxh4n86H8+RE1uKnacq9epibd
 QOFckv0ts7stVlvsf+zRRD+LEdQGBaOcy/OBetgLhS8m0AQBHX2Qow1EeQLztd4iUgYSwYv3M=
X-Gm-Gg: AY/fxX78RpKStWZ9vLKX1TArsunf74eRmYHuMx7R5hV7pPnHJhw8zTfIiWmTbDlyi+w
 TJ5XqxLponsfLv7L0pA+Y5LMABBysLQpCiHLAvduDzSbldCn6wtNW+sZFaVZ+M3rZL4gDThTaF9
 4O4bZaSJM9ocXEGQeoCk8R1Bxl4ZoZL2JXet3sAPd6e0u5eU4a6PJ1fP+XMuJzx12euFWZjvBmj
 +IShsOhcBCNVE8exhg9sBDECX3vsCcZ6aRc9B5GUnD6shQVCq0rYvyrO+lIBUzG3Erj1UZmdti9
 Jv/CNNKV9sZtsUyWyltq9TRnTyDyy4mXHApMOCr1ZA2TyW4jhH4icOzGg+fJve+EsucYTtMsxMJ
 Ie1QfaX0KnpuRnW4mcOYVX49N70/7Sfrgk7mwUFNEwQMcvQE857vMHU+44yzq1anA+uVpZJGfim
 DgApqTJJr64Y0VelpjBiOujwMNzDt73oqUARmNHohm/J4=
X-Google-Smtp-Source: AGHT+IH5CpxNypJoPJMZzKFTihQTqnN6P1fHDBgRPCRTftcspE53U+NIRRlynPbsKrHgQz5kYyVswyz29l4H
X-Received: by 2002:a05:6a20:3d1f:b0:35d:8881:e6ba with SMTP id
 adf61e73a8af0-389823aa8d3mr2899317637.49.1767711628550; 
 Tue, 06 Jan 2026 07:00:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2a3e3caea08sm2677635ad.32.2026.01.06.07.00.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Jan 2026 07:00:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a0f47c0e60so25426315ad.3
 for <dev@dpdk.org>; Tue, 06 Jan 2026 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1767711626; x=1768316426; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=efX1xNkp+x8/QgTfUCAnHcqauvrlPPTQ+yP9sFK7WOU=;
 b=Fef5YdgAbneNrDv6gWDx5eNgMpafpFCSIu2UzpJYyOaST7HwGBSoJslrwFsI6w3PGB
 mquEBx6eudT19uFCD44VZ6lqBMaxTyhn/7PzW1lTKG5+v0S7wkoXrXvyAiVzqp12SzEr
 NeJkdxyA2viLf1qlsgx8Sz3fYgvY756bZADYo=
X-Received: by 2002:a17:903:3b86:b0:2a1:deb:c460 with SMTP id
 d9443c01a7336-2a3e2dc817amr29186985ad.33.1767711624194; 
 Tue, 06 Jan 2026 07:00:24 -0800 (PST)
X-Received: by 2002:a17:903:3b86:b0:2a1:deb:c460 with SMTP id
 d9443c01a7336-2a3e2dc817amr29185475ad.33.1767711621989; 
 Tue, 06 Jan 2026 07:00:21 -0800 (PST)
Received: from localhost.localdomain ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc88fcsm25194295ad.83.2026.01.06.07.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 07:00:21 -0800 (PST)
From: Ajit Khaparde <ajit.khaparde@broadcom.com>
To: dev@dpdk.org
Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH] maintainers: update for bnxt driver
Date: Tue,  6 Jan 2026 07:00:11 -0800
Message-Id: <20260106150012.49022-1-ajit.khaparde@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Kishore is taking over the maintainer role of the bnxt driver.
Updating the file accordingly.

Cc: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7d8dbdb25..e6b8281460 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -721,8 +721,8 @@ F: doc/guides/nics/ark.rst
 F: doc/guides/nics/features/ark.ini
 
 Broadcom bnxt
+M: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
 M: Ajit Khaparde <ajit.khaparde@broadcom.com>
-M: Somnath Kotur <somnath.kotur@broadcom.com>
 T: git://dpdk.org/next/dpdk-next-net-brcm
 F: drivers/net/bnxt/
 F: doc/guides/nics/bnxt.rst
-- 
2.39.5 (Apple Git-154)

