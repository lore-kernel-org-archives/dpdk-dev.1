Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F90C982D7
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:30:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD74E40285;
	Fri, 18 Sep 2026 20:30:26 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 0DF894026A
 for <dev@dpdk.org>; Fri, 18 Sep 2026 20:30:25 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so773452a12.2
 for <dev@dpdk.org>; Fri, 18 Sep 2026 11:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789756224; x=1790361024; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jhFdLV6JGgdO5LRMnY/KeCdNN+qGWKJqDplLglGYBs4=;
 b=HSZnCdxrzxQHxc4gbCG9Sc4x8SZJtT7a6P0nFN/u7AKCrUt/O2zUvbKrS5j50HPSGY
 9grg/W+HZO7Z3g0aK2895VkyTCMo/NotGLE/H3jRcIgmRDcjD3rXDfnLDcoYjNQtCJA+
 yZ2d+rOOjqtLPYDZDI/TOrINLn/u9feSPm1zsA7AK+ErG21fHmIjF05okKVUPTz0yD0V
 4K+2SFjfWwfA1UyyzZFyp9zrL6ryL9thaYXTe7s10b1ThZ3XR7+7ukkj8j7ce+WZWd6f
 B0DjxHTSWvU3RpWwE8oPGlDWomdLma+fqIVrT9ZX6pjaOK7XF6Cp2A0KEQsidR+TNuoC
 crpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756224; x=1790361024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jhFdLV6JGgdO5LRMnY/KeCdNN+qGWKJqDplLglGYBs4=;
 b=jOUNu4BBBVVVmV7uAvLBFWi2sSsj7vWyLZ+MOIvm+QmPxqspgUD394DvJ0erl9dcHF
 4k0bLH0Rdnx+C0VW5uCMWApBtIQ/ry/2F7xD3aE5Hsmiwwp1OvaFaS9GBvGWT6rLsSIB
 RC+PxLBmyZSttgh53tHJlCvowGl8b1Epp7bxFjAkj9JN3qJFwpAWxrjKtV7jPMfRz9bD
 se9v8VQGKPEjmVBHkES9F/6gshsdtJDrjX3fHPiZnJIIAGBQ25ugInXLAxaXt/mJ9mJ7
 fmda0RCihbQ+RvR8t+vIfxw0efMHhJWC697SCISQrZp4BofnNaJXow/SnBDt4VlNGXhx
 S9pw==
X-Gm-Message-State: AFuF++nodMKQTsQv3llTlT/1ltFhKvKqAhyPBFB0sOzOf/ku8REsT/tY
 OgGFJQK4z00p60AIRHQRWzpmnIP8NXjzmrWSZBKn9FYPnz9OjNuZb/CKaIbQsUZ6
X-Gm-Gg: AYBFou0znqc600yeGXCqi9CnHOrRl8M4iACPwL6C6/j5L/zpdtjkvnHjmNqP2ykkMNl
 L1gj3q09dCM3sHG2Nqj7a92swz4r5T3imLz+1ggWkmrqb7GMtvDP+O00yiF+zAMsmJGSRPHWHCX
 pjtJ/GcJ/9JXs61QgBNR5ATiWgPKqgZJwO4gS3iNYBFcpy2bQlJYiXjUK1HgjGaCNTDRC+y/U98
 b8q6DpTZO5zFyLU1m5PvJ0dPY2NXhvvmC6EekMuS61fEmvgfa+oKibHsXYQvKHiGY+70VWhg6nQ
 BA/p0bNQLCcOp0FZAKZK5U3JzruOTDXdby/j96DVsi6gJmxpLvAnnzRvDIjQ7l16rDmK32K44sL
 CDdabtvPHWROrGNO6AxPqFKR+i1Aa1JzfPfKovZgS1v7/tBDdAyqYMfUp5Rmk+cuCdUpZrkGvAv
 gN4pjJQJEfHqGEAXOkrqR3xBfwr1G/mnl5g4yvVZGZat7uur6OZ/yys6cfNxLD4jMynAp7cGsOq
 W2GxJo=
X-Received: by 2002:a17:90a:f947:b0:39e:6c69:34ce with SMTP id
 98e67ed59e1d1-39e6c693606mr695022a91.50.1789756223561; 
 Fri, 18 Sep 2026 11:30:23 -0700 (PDT)
Received: from OptiPlex (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d4c0dsm397209eec.29.2026.09.18.11.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:30:23 -0700 (PDT)
From: Zhang Tengfei <zhtfdev@gmail.com>
To: 
Cc: dev@dpdk.org, stephen@networkplumber.org, Zhang Tengfei <zhtfdev@gmail.com>
Subject: [PATCH v4 0/3] net/txgbe: fix flow create errors
Date: Sat, 19 Sep 2026 02:30:08 +0800
Message-ID: <20260918183012.42520-1-zhtfdev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917153242.29315-1-zhtfdev@gmail.com>
References: <20260917153242.29315-1-zhtfdev@gmail.com>
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

v4:
- reject mask-only FDIR before allocating the software object

v3:
- reject mask-only FDIR before programming the global mask
- log flex offset mismatch

v2:
- split L2 tunnel add-failure goto out into its own patch
- allocate FDIR object before installing the global mask
- add Fixes tag for the VF FDIR path
- set -EINVAL on remaining FDIR goto out paths with bad ret

1/3 fix L2 tunnel error on flow create
2/3 fix leak of filters on flow create
3/3 fix FDIR error handling on flow create

Zhang Tengfei (3):
  net/txgbe: fix L2 tunnel error on flow create
  net/txgbe: fix leak of filters on flow create
  net/txgbe: fix FDIR error handling on flow create

 drivers/net/txgbe/txgbe_flow.c | 265 +++++++++++++++++----------------
 1 file changed, 139 insertions(+), 126 deletions(-)

-- 
2.53.0

