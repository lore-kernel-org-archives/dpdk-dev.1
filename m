Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACDDC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 01:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 24CF7402C2;
	Mon,  9 Jun 2025 03:41:12 +0200 (CEST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com
 [209.85.222.169])
 by mails.dpdk.org (Postfix) with ESMTP id 95ACC402BB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 03:41:10 +0200 (CEST)
Received: by mail-qk1-f169.google.com with SMTP id
 af79cd13be357-7cadd46ea9aso582664285a.1
 for <dev@dpdk.org>; Sun, 08 Jun 2025 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749433270;
 x=1750038070; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wm0TapC/7s9bY24tWZncMDFRtFhoOw2xkrDnrExZcMY=;
 b=onULBMCzHoGFAWT8KH41MW/qiT09ekd66/YErg85Ed52wbJ2lr2TBP0WYWe0IJGi2M
 YKpR5474/1edTMR8IJnC/f9RKiKnX+vuZrn3IFVEuC0pCt/CZLXjlCMRQ8ILwrz6tXsN
 6CI/tx3vH32/SvdsjnhuJ0u9uKm780oaSB8P/RixfTi1OaJUQ7jwy4Z0zwk658f4GJHe
 4PbEtNvzqNBsqpbstfZX3upfdYoWWUPNRR1SlJsQq1muTTK/T4UnvYAPO7BR/17s8Nf4
 Vc4YjaOTdqInB4dZ2E72Yb5duMqPHVdmIqQ3fwGXIamUoL/dPhLaqy2b7uwqwOJb+BJQ
 9k3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749433270; x=1750038070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wm0TapC/7s9bY24tWZncMDFRtFhoOw2xkrDnrExZcMY=;
 b=nusRQInsm8+7iWzRkkuXSgsijZJa2X/cL4ozdY1mulHxlLV+b7Z/Vmhtf7Swz8Qblr
 N26j6SdnHn/G4hK9QCqekcvxThr2K3kGHcusCRpsgHTwb0qY4askongqLTY0jkUNFYLN
 iubLnkUu2J3996ozWLXbFJ4Zbwp/rog9k8evzCNTc8UTn6raJ9Gu9qhQ6XEcKGJtNmu8
 UREIJ+gwbccQqP6acXY8WPbOOmu1daNkvzsaF2U1kQoDEui9bpdvXtZwyiqtUThwZqHj
 l/wRZgKsIzC6EpAKOKNKuEkWrYAseTIjpxKrUmY336Iy1G37oZKZko2tjCmNKIRxPsBJ
 Mhtw==
X-Gm-Message-State: AOJu0YwLWS5l/QneeVXBXqStkt4yoG2nleyYtdPSbgDdF7yYngCg0Hm8
 38UNBUHYF2r8wqzX54Ipr7XlFKNUeFE4fLgDe4bATY9cslAjvzcRpZEsIgcxmQkF4DvMMtcM/nf
 OaFij
X-Gm-Gg: ASbGnct1EfVSuXlL2mEAWCviCqmnGnmI5CdZsGgXIYdW1NoZUAKzReK9/siMsODa5vG
 Ffy8XbfTNx6TfNF5iJZyktDUkzIf4lRVEBdiKjYii5aKD9/6JaUb45SZBqwZq+G0rFjKCoLU/BZ
 W8Ef8JddnVDEGybBbBfgHmOfz22Ww9fwup10xcRNFZCJxp+WnprKZJi4nbXDyJjd/BUQiked7S2
 /02hZ36gFOVyTf3ngTb2KYoRJamvaXK0Fgz2BTveJ/SKqxuj6DwrPNJoQYzNThmu35cMRDwg/YY
 A5WhQaisg84btcg7669CMe0/05sQ1ETEAFAlGGEIttgnC0qx016u25i9f+YRzblBU4xafw7gBxL
 jwmIXQ6AnCorNJOsPUryRV8lu1Rz+irWzgq5p
X-Google-Smtp-Source: AGHT+IEt4mbMfZaHEmKXvM+aVyVC5MH5pZ8UcaUWyWIjzLCx1OR8cV7JNVAkDDMvcdPUqjUl7Xe5vA==
X-Received: by 2002:a05:620a:2683:b0:7c5:47c6:b888 with SMTP id
 af79cd13be357-7d2298d91d1mr1793139585a.40.1749433269619; 
 Sun, 08 Jun 2025 18:41:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a619852db5sm49498331cf.38.2025.06.08.18.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 18:41:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] uapi: update to 6.15 for vduse.h
Date: Sun,  8 Jun 2025 18:41:06 -0700
Message-ID: <20250609014106.11568-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

Use the header as produced by the kernel:
 $ make headers_install
So that it exact match to what would be in distros and other tools.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 kernel/linux/uapi/linux/vduse.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 68a627d04a..f46269af34 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
-#ifndef _UAPI_VDUSE_H_
-#define _UAPI_VDUSE_H_
+#ifndef _VDUSE_H_
+#define _VDUSE_H_
 
 #include <linux/types.h>
 
@@ -350,4 +350,4 @@ struct vduse_dev_response {
 	};
 };
 
-#endif /* _UAPI_VDUSE_H_ */
+#endif /* _VDUSE_H_ */
-- 
2.47.2

