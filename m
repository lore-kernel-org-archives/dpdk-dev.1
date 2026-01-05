Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB48CD040D
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 21:31:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3575C40695;
	Mon,  5 Jan 2026 22:31:15 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id AF5FC4065B
 for <dev@dpdk.org>; Mon,  5 Jan 2026 22:31:07 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso2229445e9.2
 for <dev@dpdk.org>; Mon, 05 Jan 2026 13:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1767648667; x=1768253467; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0lPaiE1cK+FPH1J/F9zPRKqezm/9YJZ2SY0QyA20Kw=;
 b=bF+AVI5Xc5aMxIrMExkeP6iqQQbu8AuQOlqFTnpx3Tyn0QuUrLnVzMX3UVOg3wKl7h
 bWr3aBMIOZ43tGM+AZmKG1y2ixDM0sfNwAq2+AHqcb6JB5YDV3tI1fajySXyUXVN2hZj
 pvmbG4F8/H7CVwIGzz6y4H5H5pFM9KielK9MfmDXsNg5aVJ0BScVLJYDB/FCllQomrer
 RfRHGuiAZqqQxnqEPKiiftpMHJI+Y7lwYqCELHviqTCwgCPGNmSnMiW/FRg53clnWtay
 2vWuCJ25k7WP+++Ue4AHRa/wQRBCAAcQpTlUWjWD+agwB632F4Cw/sAVPuyGDUcI23lq
 NDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767648667; x=1768253467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m0lPaiE1cK+FPH1J/F9zPRKqezm/9YJZ2SY0QyA20Kw=;
 b=lmOclaTJ1SPjEBaiiNS0MD+RZ33q/5MEYel5k4VNjmzJvhBJiNjhSdV0E+ny3T+SE5
 9NguiRAw578aBmMjowoB/xs3m0C/qsozVzO3H41jCbZYQVfQEOij9LMSJTbt2knXskGe
 yvxw1uNXyH1aY4HLA4PmqkRYAqGlXTEpDwZLlLkeSElWCWePyy9hqzUk1vQk5LP2fMuy
 Llvh8eIVmex+TNFd/RMwCVPtQirK3cp3A8HhN3ArTiDspZ1m5m4iO75sT3g9vki1xrgd
 S+tyU7hF6UbpHRW66nAUvWzVvsKkvPegXdv31q1Njvpud7pJiDYfqIKI7hnGzafPpgri
 TNsQ==
X-Gm-Message-State: AOJu0YxPjO2Qc7OKR9pBdEokuSTNmZt6Sj+osgQjBbf448lsT3rnKqOV
 ZE6Mp/ZXGL1A9ZWfzg8dfphV3XpxHldZ/04h+VnFuJBrDap+jQuu9Nefo8uTbM/jNydh177UYal
 9WOMlPlQ=
X-Gm-Gg: AY/fxX779V2je3yS/dwONeLs6odnSL6VDoORLf3WjNQYfV/7c5AF3HMU0GxP1o8Xj3S
 5yyEyRFsK1KXpur+sYcazUaSU5hnR87nZvwS7DmUaRawspDV1Hp2otlpdSDbwzGjSEz56pBxsN/
 cS7uO7TjmDssNAwERSd/LRYXY6UltiddC9e9AEkOTrB3HXzOmgeudVnWqfStsxbgHM27VSf7+JA
 NVWIa84kNTfCTe6CY1HBMDFz/SUmAMAS+cGk4fvtZUw0fiqGyu8YogGwCbYpClgvhytuwsdcaTX
 bkznwRUiUc7ylaWOckorV5xHJYzoXEtMi6LHVc2eePkPgLLVSuyxfkYBWMLp8OHGKo2iLR+pcFn
 vM1cIpHe4Y6+yq49bPVvBB18ZrqIuYjNvTF/dB227vkd85iyMpMz25RMrU4LY8QVMEWccG8IjoR
 F3CC5zMujFtGDg6Wl6V4FEh0dxlThhjhYDnw9yYBkeFanB2g==
X-Google-Smtp-Source: AGHT+IH60yzux76aaOXnBowkGj/mDOYwJOVfuxtjAC8ljdLtSQfCRbpf26WYTcM/TuiYwjNK2SQz9Q==
X-Received: by 2002:a05:600c:4713:b0:477:af74:ed64 with SMTP id
 5b1f17b1804b1-47d7f0a1898mr9735465e9.27.1767648666986; 
 Mon, 05 Jan 2026 13:31:06 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f4184cbsm8796285e9.6.2026.01.05.13.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:31:06 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v1 5/5] doc: add flow parser library maintainers
Date: Mon,  5 Jan 2026 22:30:23 +0100
Message-ID: <20260105213025.749383-6-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260105213025.749383-1-sismis@dyna-nic.com>
References: <20260105213025.749383-1-sismis@dyna-nic.com>
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

Add maintainer entries for the new flow parser library.
Update .mailmap with new contributor email.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..28ffd53db1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -933,7 +933,8 @@ Luca Boccassi <luca.boccassi@microsoft.com> <lboccass@brocade.com>
 Luca Boccassi <luca.boccassi@microsoft.com> <luca.boccassi@intl.att.com>
 Luca Vizzarro <luca.vizzarro@arm.com>
 Luka Jankovic <luka.jankovic@ericsson.com>
-Lukas Sismis <sismis@cesnet.cz>
+Lukas Sismis <sismis@dyna-nic.com>
+Lukas Sismis <sismis@dyna-nic.com> <sismis@cesnet.cz>
 Lukasz Bartosik <lbartosik@marvell.com>
 Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
 Lukasz Czapnik <lukasz.czapnik@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index d7d8dbdb25..580a499f7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,9 @@ T: git://dpdk.org/next/dpdk-next-net
 F: app/test-pmd/cmdline_flow.c
 F: doc/guides/prog_guide/ethdev/flow_offload.rst
 F: lib/ethdev/rte_flow*
+F: lib/flow_parser/
+F: app/test-pmd/flow_parser.c
+F: doc/guides/prog_guide/flow_parser_lib.rst
 
 Traffic Management API
 M: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
-- 
2.43.7

