Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F11CD4F21
	for <dpdk-dev@archiver.kernel.org>; Sat, 16 May 2026 09:20:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A89104026C;
	Sat, 16 May 2026 11:20:20 +0200 (CEST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52]) by mails.dpdk.org (Postfix) with ESMTP id 1FA434025E
 for <dev@dpdk.org>; Wed, 13 May 2026 22:37:30 +0200 (CEST)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5a85b30dd54so7269688e87.2
 for <dev@dpdk.org>; Wed, 13 May 2026 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778704649; x=1779309449; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FBAatox0t9Gbm7RseBRKGsWqJ0TtLPwRduv+SRzK4Pw=;
 b=Mbzuai0sdORpAwX/R/Kxots6KeP1Z4BjxM6tVYxBdI9sqk0zktlGX9uVg8CQSwFq/t
 MtFrC/x9cCyDakgE389Dh97ETl2+lBLn3fABSUF+rHJW7O8zxVE0SsKk3ol8DQCHaUEP
 fO8gLWFnsZnLtN2wq86UF0DABEGndc1RL/sYFIESU2joBeiyDCvyLhxEuhmcgi6gAch+
 ZPqVAHUze/AAfwjhxXOsSkuuiKEx9V8Ieb3Kq0wXFCLZFIEd13F4xItfcg7bJW+WlAhb
 1AEompjxmFIGUrqL7UTIokoHqTt97yvVPumtjgAU9H0BFPtUu8MEhQl9QdWZzD/cFDep
 oycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704649; x=1779309449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBAatox0t9Gbm7RseBRKGsWqJ0TtLPwRduv+SRzK4Pw=;
 b=ArFJK65TeqCYoLJsz/eSqz2PL2Tu1gfI/ynbuIWhKqHz4Oj3MI1Q+6EtY3O70FXuPF
 t6Hnn/Y0p3H+zEQg+guSHUpp4W9ZufDmqMu+lywmv6EhayX2DMDebcNi0rZDHWqx+hqS
 WfF2fVqZFcIEuyAbGF1UwDtuwcM+Yy+MJin1A8hw62oahdOc63saQkt6e2+XylDtxbDw
 mIYdGoMHyFR9+XuDi95XGFtNr7zSh7TFZRsGt46ywzLx+AibbT7KWUl8fvBREhd3XRPk
 kTm4Mse7qWzQfCxz1FpHHIGcnlQEUOZURLXN8q9jhUSVGDYRmNtdaPIolgtRJgqcJJO0
 3BSA==
X-Gm-Message-State: AOJu0Yxcm5iuxlWyasV7aN5iPnTbgRQX90eFnf/mcdQkmmQQyWuV7eFH
 2yQLCydbhL882nAzoPPT9/FT5zN4aSWUk6hiSbA9F0+fwdTTAzL2bCElgTFOxK/f
X-Gm-Gg: Acq92OEBsBtQfR9tOzfasnLcYA22sjskV/v8z1dzHllteSqR8O9LN18J0rf3wbhoSp1
 jV9AsHE5JjhQVCix4Cblxf1MncgksKIj9DBXbi8HOKnea59FIrhk/NL2UapSYF39gcZrgLS5oid
 gEZ7zs/M+loqdgPToCdAqzn6JNzEXgwRuqrb7RyKkIDFFTKUwLt/wmadSMhN2+E4330ZsIFPDXZ
 vn/NIq+9RDcimP10Q6c1/CwqdOCd/EbN+lL9qo7IvRlGU4jdWMX2O/XoE57n5qWaNPa69UHj+gx
 cf9ctHU4p5vCwmNCJcQrJEFyFRtOznncpzU2sxd5opyx5v9Q4hwV+IdJPBMfEGxbO+PJlbMn/Si
 at3omTgdupU5wva++5vxIYLpYLeqSnpMUj0K+wqnopqIl1fvIsvXwSZThb/eduFg7fQTrqz6M2D
 V4PBMLcl9PmiKLgLqESQi1ULaiIJME8KJdeUxtogwA9IIh+lw3O/J86t8yDpgDRvvKaH+ATxzvZ
 cQ=
X-Received: by 2002:a05:6512:693:b0:5a6:31e9:1e56 with SMTP id
 2adb3069b0e04-5a8f37cb36fmr1528901e87.18.1778704649087; 
 Wed, 13 May 2026 13:37:29 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164ccd16sm31765e87.66.2026.05.13.13.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:37:28 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, sachin.saxena@oss.nxp.com, g.singh@nxp.com,
 stable@dpdk.org
Subject: [PATCH 0/2] bus/fslmc,
 dma/dpaa2: fix remove callback error propagation
Date: Wed, 13 May 2026 23:37:23 +0300
Message-ID: <20260513203725.1905-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 May 2026 11:20:19 +0200
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

Two dpaa2 drivers silently discard errors from their remove callbacks,
making it impossible for callers to detect cleanup failures:

- fslmc_bus_unplug() (bus/fslmc) calls drv->remove() and throws away
  the return value, reporting success regardless of outcome.

- dpaa2_qdma_remove() (dma/dpaa2) logs a cleanup error but always
  returns 0, hiding the failure from its caller.

This series fixes both by propagating the actual return values.

Bugzilla ID: 1914

Md Shofiqul Islam (2):
  bus/fslmc: fix ignored return value in fslmc_bus_unplug
  dma/dpaa2: fix dpaa2_qdma_remove always returning success

 drivers/bus/fslmc/fslmc_bus.c  | 4 +++-
 drivers/dma/dpaa2/dpaa2_qdma.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.54.0.windows.1

