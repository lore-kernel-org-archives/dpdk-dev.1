Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B30C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38F6740612;
	Thu,  6 Mar 2025 04:04:53 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 47ED2402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:04:51 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2feae794508so343311a91.0
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230290; x=1741835090; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sA6Bur3pk6R0V5rEggBE20v5E/7xBg6ilDRV9KTRflU=;
 b=SmSCsPqcmdoJ9b+kMd2dUceUG3GVEW5S19Oj4Z6LlpNZm0ozaPnTK7wq2WU0gYSTku
 GM1krHoCshIByBX9uentV3BVYGLSgNeXwxp+T5RjLwZ0LxPIMDmAWS7fsnYjlR1y0HDj
 nM+2FV04T1YWDRhEMNHYmGikb2mY58lY7MJEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230290; x=1741835090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sA6Bur3pk6R0V5rEggBE20v5E/7xBg6ilDRV9KTRflU=;
 b=CCS0BvtJG1bB9PpRyeysqf7yLqeBMCmEb7FwCkm/o3UF8o0yORnrBxl8fQkUWJAOPx
 op9yfH2lw4kH07sXTtgXY3Kqq4a0qR1mfgMbkuQv/vB0Pguh43ci2WXxFN4YU4t0S4zm
 OeMumdXv/mwCVLfQNuBiw6uklm8U+5Nr9X+rJ7deE2d5358p6/5Lls8bK+kB9xLJBx87
 HmpwYiKuWjZP7ipwv9pWuGkzesfwfSHd5HMFRxWN/1c0mfggHH0/qRVhmnujRPjTU9+H
 3b8mo5/8FRPUhVMDs0i1+jJr/LK0WJU6fWhSXLGxLHW48AN6xpQr7Kl7SyUWKuefQjWM
 TTBg==
X-Gm-Message-State: AOJu0Yz1QUvqkYgM4hoE0VhZehRcn2NCZdafDR6HeeEO9wmxsK54MpKs
 HT0HV1XfjJrL9xJYHvxM4N609/Poc5f3s3zSCogQ9vN3jFiihccpwS3IxMp9T7uSBeqfofPQz6m
 dbDEPwMJE9autEEmExjtqZZgIaLMKhiJ2tfSXhA==
X-Gm-Gg: ASbGncvXrxM/Hsd8Z2hY4B5fp12mmpm5zNmkgvHDNX5MpRmR2wVQAJW9n5WTg1FPzKK
 zRtRL0EeYG6URknhy3GdxPRyvRtnLS3x1a5l+gfTsVL9m0pDIkBmOuycJ0huUtG5F/vhLMy0baS
 YVYORFiQga1j9VnV68t9akcdHhKyf2GG3jiQzU2SSVzA==
X-Google-Smtp-Source: AGHT+IGR5WcTnxt7lbXH/jSD7xcJCKpEVCM8xQ0UKAtGSjizXTWW1U/7+wqL+5Wjuo0QTtKN+/HuOSxOkmeNiOSXNkY=
X-Received: by 2002:a17:90b:5688:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-2ff4978e91fmr8025536a91.5.1741230290329; Wed, 05 Mar 2025
 19:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20250305125215.2870237-1-luka.jankovic@ericsson.com>
 <20250305141255.3031686-1-luka.jankovic@ericsson.com>
 <20250305141255.3031686-4-luka.jankovic@ericsson.com>
In-Reply-To: <20250305141255.3031686-4-luka.jankovic@ericsson.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 22:01:15 -0500
X-Gm-Features: AQ5f1JpUHs7pK-uRppZJhEcJ-40okfKVRaaaAgGIp8LTtCU-as91lQbZNMgeb9U
Message-ID: <CAJvnSUCtrFrah8-w4U1iP8sQR2Pc0wmt0cjwbEjXozBMT2szUQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] eventdev: add atomic atq to test-eventdev app
To: ejnulak <luka.jankovic@ericsson.com>
Cc: dev@dpdk.org, jerinj@marvell.com, mattias.ronnblom@ericsson.com, 
 pbhagavatula@marvell.com
Content-Type: multipart/alternative; boundary="000000000000ed7fda062fa3c419"
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

--000000000000ed7fda062fa3c419
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--000000000000ed7fda062fa3c419
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--000000000000ed7fda062fa3c419--
