Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72A8CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:55:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5EE40DDE;
	Mon,  5 Oct 2026 18:55:17 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 6BBFE409FA
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:55:16 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 41be03b00d2f7-cc79a5bdf9fso450381a12.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791219315;
 x=1791824115; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJdNp3yrTyswcWeWZADxvPgqb+YxpmqlLRDOsLehh5k=;
 b=Yk7Uxlg4rFw/wtxEoDKf+8Tyu/XI/Zd1GXWAULCA7TBhIWbqXeAv4IfTfl0+qj0wIa
 0bH1kgkqnSotu2lhbGGzyNxLeqL3TQ+MnfgYxIdWQbN5hDQcRxC2L/RUtxmq4p8njGsI
 H9mH7LtxCwWpYRaWddOIab+bR3FVCQH3GOSzX4/sgz9nHPKDLVEkopVu6oYFpiOr40SP
 ZyG1PJclvmDQVrnNr4ZFMhRo/BzwCgtf8C/u5ZaKgEz5rkEvPZY/jchHX6tVpxKuKENS
 rhO9YSb2iA7qE01Gq91QRJfCihJVxpw/522IQnXSXwbSpSEz45q4ZuVOtRak1KSavckk
 CCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791219315; x=1791824115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZJdNp3yrTyswcWeWZADxvPgqb+YxpmqlLRDOsLehh5k=;
 b=nMermv56mb1BdRyY2QEcs4cUECRPcTfvEsQOj47MgjEOlr5N1thW17cVMmr9Iojs3j
 B49KIzYzYYlXe943Wj2skKHVTzhX4hsaI5KS4eE6Ek9No7fzmNoa4BV/+K3fW981YdDW
 A1FIDz5NjMGkdrQXBZFPrSHbALyQtG8y4E1pr+oto3uq30Y78RVKsBTDlUSzC74S2yS3
 POGPyG+DchqxAPI/WTVzzCq7kJVmGK7HNJ3eb5iMCvp75XsPVZPufFMn/cL1KoOg9LgB
 8cuPY+TWJGRKm+m3IdkBs2MiTC+krYiN4lHGG8o3v2vp/0gzLwXQj10PPdovs4EqManf
 FNuw==
X-Gm-Message-State: AFq9FYLwRExa7Yqd+kuM7sxmYHGFRqt1sae8i23N5UnL1ohU0mQwUP8t
 V5tlqDIWzvBrKZ4ReZuwCqsD8t0bFOJ6sYwBFbt/2pWMaAgf5IZjFQGrBccP0tGcNdqw8O+kgWh
 JUXRGpxA=
X-Gm-Gg: AYBFou17tFa7yDqcPcfwT2XERSxesoiFhUazsP53pBRgiwjXH7UJJOXs8LDG6+Z5d4Z
 G7jAEhxaZoObUZnPMsWOKDlvbnJTOHhTk0AKFjhowIflCjfzpAhSlL2bdknbsx6XpS1eFI/p7E/
 B72dSIkDukzLGc491uX7bemhG44jl/cMr57X3/UePnLW45bhhqq8pxqWQysj4YUuCYU/msSkalG
 CpU+eWdL8JNqLwAZVJvD4OCOBTqnPbTrWzH3tfLleeStRm7wZM94Y5KXkWSNUY0EsHav8HkjH7C
 Yf+vcAONTuJLzZGsxgonC52J4ySdk+dcBAynypMPLmRMBvnqPCn05jNsshZWZsUiv23j6cIFnT8
 Wy2dAIwsW+hsMHhqp4RVcXD/zAxCojJAwOmtKUT0juFraaKMe1GlK6Y9xrsb3uX7e24j6p2Mc/C
 ZL8zwkeY7EEuLx3BoDTTpHKy9hxLOiKvAtZAvpKsf9cwRdJ8muQq4p6eHfKu2fwES+FyAPItTC9
 hocldaDUexgwdBsPU2pOQMpTm2QuTESLW1b0Q==
X-Received: by 2002:a17:90b:5388:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3a853cdacfamr117654a91.7.1791219315381; 
 Mon, 05 Oct 2026 09:55:15 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a8533aba95sm289414a91.2.2026.10.05.09.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:55:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Gaetan Rivet <grive@u256.net>, Xueming Li <xuemingl@nvidia.com>
Subject: [PATCH 1/4] devargs: fix NULL args with global device syntax
Date: Mon,  5 Oct 2026 09:53:47 -0700
Message-ID: <20261005165512.334085-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005165512.334085-1-stephen@networkplumber.org>
References: <20261005165512.334085-1-stephen@networkplumber.org>
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

A device given in the global syntax without a driver layer,
e.g. "bus=vdev,name=net_af_packet0", leaves drv_str,
and so args which shares its union, set to NULL.
The legacy syntax always sets args, to an empty string when there
are no options, and drivers rely on that.
Passing NULL to rte_kvargs_parse() crashes in strdup().

Default drv_str to an empty string when there is no driver layer.

Bugzilla ID: 2049
Fixes: b344eb5d941a ("devargs: parse global device syntax")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_devargs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/eal/common/eal_common_devargs.c b/lib/eal/common/eal_common_devargs.c
index c523429d67..8bbff9cd15 100644
--- a/lib/eal/common/eal_common_devargs.c
+++ b/lib/eal/common/eal_common_devargs.c
@@ -154,6 +154,10 @@ rte_devargs_layers_parse(struct rte_devargs *devargs,
 		}
 	}
 
+	/* No driver layer: match the legacy syntax, empty args. */
+	if (devargs->drv_str == NULL)
+		devargs->drv_str = "";
+
 	/* Resolve devargs name. */
 	if (devargs->bus != NULL && devargs->bus->devargs_parse != NULL)
 		ret = devargs->bus->devargs_parse(devargs);
-- 
2.53.0

