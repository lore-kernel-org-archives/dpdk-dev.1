Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350DDCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90F7F42E54;
	Fri, 17 Oct 2025 17:02:58 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 37D9142E46
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:57 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b55517e74e3so2211917a12.2
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713376;
 x=1761318176; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jc05zAerwVRrzHI69LZROkJapsELoHOWXj1PTdmUjBM=;
 b=F0nj4NyhrQqmVlU1tXOh2EXmBDm894lAsBkrfkpt5PZ/kkBzZcLbcvKXN6rqOp1F2n
 Wlgz9mmQxQ9wormTzp5n9tP6sKXzxReyBd8Ojid3FIQMJpqn8MmBZ8OrSxOLN02vf53J
 uUG04XI8o9oh2zkly4kQoQZmTnSiQ5B0g20YVR37OKeHTkI0jM50srbjWqw/OlqjL/TZ
 Us4dxkm136WWxoIlMXtCcDltBkBnYrRMXSPhrTzXV5/H3ou9abc+P0cP7gCPlFDvxHuN
 lah69W1nNBIB7ppNAJgd5KMOsc/0czWJPoAhKHt2GH2/L4BxQNmvgG/tzQuNmy5NxsBF
 W3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713376; x=1761318176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jc05zAerwVRrzHI69LZROkJapsELoHOWXj1PTdmUjBM=;
 b=w8V9FT3UcOjXo9JcajPETveD2dCGSQ8ET+k26JaySnNZ9iPd1lBBjBd61pu1LiouqL
 d3y1qrrCNr2CPE2dBtbkUQuesRFkH6fHFEXv8QnTunaWrWs74kA6lDuaQ12K8Z9FZYcq
 2Sjk5PqhK8fD4qu4arURTYyrs+gUVYfkmCzr1Ix3Em9d89VLSEdUJhietE7qGyXp3d0N
 bKTf60s5u+OqaD45xN1GKYbhuMkIxzrqy5FmtxLEukWMjIJjGxYHDXxVZ8EsLF+35q+o
 PudF45F3YtwpT4ZdKqTcZ51R0P5YJwRglvwha02rxDx/MU3zKeIfyQW8wciMHtyUMF3Q
 VRJg==
X-Gm-Message-State: AOJu0Ywa3g8e0MnUkAG6UM/dlld2jAVtOpz4NVXsc0EcOhxiLa9I/+y2
 PmZtkMYIavfxyDsnS45bouq7SQoXWvi3jpAZejHrwFD9i1AuS+7YJHOjjrfS0yEZWjM5nTnko4c
 gzOkxqTk=
X-Gm-Gg: ASbGnct7A18AAcd37HCsrGbFoqLpqcZxj5O9jeuLT7dyuHcBkJmWjFPlXyFf1Sle1wN
 TB0H/h7mszUoyGuL+wqHESwxbPKS25fiIfoVsRdQkAm0Bh+OZA2jhjeo/XQl1Tg4h+A9i+2OsUK
 JqR94FqJiWci4tya5+kuk+TzorHQG9S9kEwo+/tbtol6TkG/jqncZwCWu++GQk0ODT4sPrHQxVe
 sXeXx1mZGNNqmBMqPX0JmKs9z36Dy1y1H+2FIrdw7xE6Ym87DQrAkdJsSCPIkMje3h7+J4nMRCR
 C5sCa7G4EZkr6zwtQ2SpgiJF6+ECd6vjQ8fbEpevKR7xVNH6B9hW7/7XzaokYldawoQkQt2BHYW
 aMP9bNEZblUVFt2+fKRHRz+6kXmCaEBPlEHBRL5pL4JuVBhpXFtD3IHs12dz1MInZHrtYtL810c
 WR4dy5SxyUtV5CmbyC9YhdovJL3WHQtJ4BVK+5BAiUDiiGuhtk1vH0A9m6mxodSxf4iSVNmdE=
X-Google-Smtp-Source: AGHT+IGp9f57WoA+B0SUQx1rkbsThmPToO76UwztvqctHp3gpLlqfeXkY+8Xrdml5QfqlgDFo/xnrg==
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id
 d9443c01a7336-290c99a9669mr48050055ad.0.1760713375609; 
 Fri, 17 Oct 2025 08:02:55 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH v5 7/8] net/bnxt: remove unnecessary use of comma operator
Date: Fri, 17 Oct 2025 08:02:08 -0700
Message-ID: <20251017150241.28511-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
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

Should use semicolon here.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_core/tf_msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_msg.c b/drivers/net/bnxt/tf_core/tf_msg.c
index f2d2de859c..645a4b1e66 100644
--- a/drivers/net/bnxt/tf_core/tf_msg.c
+++ b/drivers/net/bnxt/tf_core/tf_msg.c
@@ -385,7 +385,7 @@ tf_msg_session_qcfg(struct tf *tfp)
 	/* Populate the request */
 	req.fw_session_id = tfp_cpu_to_le_32(fw_session_id);
 
-	parms.tf_type = HWRM_TF_SESSION_QCFG,
+	parms.tf_type = HWRM_TF_SESSION_QCFG;
 	parms.req_data = (uint32_t *)&req;
 	parms.req_size = sizeof(req);
 	parms.resp_data = (uint32_t *)&resp;
@@ -1862,7 +1862,7 @@ tf_msg_get_version(struct bnxt *bp,
 	struct tfp_send_msg_parms parms = { 0 };
 
 	/* Populate the request */
-	parms.tf_type = HWRM_TF_VERSION_GET,
+	parms.tf_type = HWRM_TF_VERSION_GET;
 	parms.req_data = (uint32_t *)&req;
 	parms.req_size = sizeof(req);
 	parms.resp_data = (uint32_t *)&resp;
-- 
2.47.3

