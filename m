Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B23C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:27:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95F2140A8B;
	Mon,  6 Jul 2026 12:27:32 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 866DA4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:27:31 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493c486f012so11669795e9.3
 for <dev@dpdk.org>; Mon, 06 Jul 2026 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783333651; x=1783938451; darn=dpdk.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bzcSThDjp2ez+J5U/U3WkYVv8CMu6lMMhVMAD+EJU/Q=;
 b=N0lV00820bLtclfTUy8Bel4W+VEr5490KcyPUhOi1+/B11Bj6GYFzxQJaj/oehHm/L
 nChHQVzi0qwm1Jbq0tHdjvcS8hsLjD++qIJdvwCE/eh98IL9IAh/4dX+KSszf8cLxMgu
 AzzcirOhY4N8iFSzmyQ+VxqLTmM+huzdbuoAbHgd5QVXcgHc6ABKXGHsdtaKdIJ9Zjpk
 1Dd/jUXloMdCCaTlXDRaJ6sB4t0Nf0cyFv5q/ca/r0laUxQdMYa0QIH7lymfCVvCwY1B
 NmJPiJrCzff8tRdD3y5cvyRkPz0nYg2uaPiSCCfjyb+q3yPxLYD+eYYCoi63oE+1xXnq
 Wwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783333651; x=1783938451;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bzcSThDjp2ez+J5U/U3WkYVv8CMu6lMMhVMAD+EJU/Q=;
 b=akJElqPf1vYMLccB27+R5JQsUmI32CSXD05CrJTLcWLxC/sM5qEYyzO4c8q+HdS9Xb
 qqYrg8xGmj4fcfJLOc4eRS2ebehNszWDwYfjhWPg+N3O9k37EkEsmFF1VpmzRqCv1GN6
 mD4xMk0SyQEpBNLbQrzcAN47/X2v1UtDrAis3MGjYqW7lWW9kx/9t+ZqMadZiFQd8S3I
 VjKRR+yeVXLlLMiK4DnQLVS3TO9Wmw0S/+2T6gbEr1Hvoqzt+iUMGejTvV9e8kZUWbCt
 BCcsiKzgSxrSVDXjL2LCxC5mXycyJJK9mXOOUB1PbI4piFmGHOmRHQWJ9mw9FLXcya1V
 Iihg==
X-Gm-Message-State: AOJu0YxT8sfm+PTwSQoJbBvYPeqsUbIkL6VVrcxNEE6Am+icbglAZxem
 umupxW4hHmAE6n87FZkpbREQQIuQmBWIdFE7XpqWwr7+6JlOU0x6s6j7pk4E9Ye/
X-Gm-Gg: AfdE7cmen1fg6BNA6txP68R0BrVTSwRZWn0Gw0aAd+vq2tTMuOG1ST2Fd2CaUOCHaUw
 2m3q6ugMhT23HEJrVaSSuJ2JkSK5t6UUXvGOVst1uA34jLHKZtWV8I9zopKrDB266HC2hjyTHq0
 Xz35kVVxN4vfULDgCPdGpJE5ETrSO0RR5uPUChii6erFO6l11vDYOGeXpfMZdQ2VUcLpIzswyH8
 C9IHRIesAXMXMB6XVhCyMf62wQmsjg64f8YKI/SwQqM1SunfBQJBxIqsZIE492ndPeT73sCtHsu
 AeFnQn+GMEb7k5WAc4uB2RMz4y5yeH/K0ZVY4YBftGxDQpWIcs7IfM2tz1uEggTUo6dJC0Jgy+w
 dkot3+g9jLFdjFZxAiX1SLuqpwiuKzkEz6RlUufOOk9NL7UmNK6HOJhcOnqNxkBDIsn5m57+oUT
 kssWD6qJY8PLWEqdBIag==
X-Received: by 2002:a05:600c:474a:b0:490:be14:bfda with SMTP id
 5b1f17b1804b1-493d11d3ce7mr109452875e9.6.1783333650873; 
 Mon, 06 Jul 2026 03:27:30 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:ac6f:a321:bd0d:19f3])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493cce0a7cfsm271400025e9.9.2026.07.06.03.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:27:30 -0700 (PDT)
From: luca.boccassi@gmail.com
To: dpdk dev <dev@dpdk.org>
Cc: dpdk stable <stable@dpdk.org>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anurag Mandal <anurag.mandal@intel.com>,
 Beilei Xing <beilei.xing@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>,
 Claudia Cauli <claudiacauli@gmail.com>,
 Dakota Sicher <dakota.sicher@broadcom.com>,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>, Jian Wang <jianwang@trustnetic.com>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Junfeng Guo <junfengg@nvidia.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Marat Khalili <marat.khalili@huawei.com>,
 Maxime Peim <maxime.peim@gmail.com>, Mingjin Ye <mingjinx.ye@intel.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Qi Zhang <qi.z.zhang@intel.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ting Xu <ting.xu@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Xiaoyun Li <xiaoyun.li@intel.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: please help backporting some patches to stable release 24.11.7
Date: Mon,  6 Jul 2026 11:27:26 +0100
Message-ID: <20260706102728.29680-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Reply-To: dpdk stable <stable@dpdk.org>
Errors-To: dev-bounces@dpdk.org

Hi commit authors (and maintainers),

Despite being selected by the DPDK maintenance tool ./devtools/git-log-fixes.sh
I didn't apply following commits from DPDK main to 24.11
stable branch, as conflicts or build errors occur.

Can authors check your patches in the following list and either:
    - Backport your patches to the 24.11 branch, or
    - Indicate that the patch should not be backported

Please do either of the above by 2026/07/10.

You can find the a temporary work-in-progress branch of the coming 24.11.7
release at:
    https://github.com/bluca/dpdk-stable
It is recommended to backport on top of that to minimize further conflicts or
misunderstandings.

Some notes on stable backports:

A backport should contain a reference to the DPDK main branch commit
in it's commit message in the following fashion:
    [ upstream commit <commit's dpdk main branch SHA-1 checksum> ]

For example:
    https://git.dpdk.org/dpdk-stable/commit/?h=18.11&id=d90e6ae6f936ecdc2fd3811ff9f26aec7f3c06eb

When sending the backported patch, please indicate the target branch in the
subject line, as we have multiple branches, for example:
    [PATCH 24.11] foo/bar: fix baz

With git format-patch, this can be achieved by appending the parameter:
    --subject-prefix='PATCH 24.11'

Send the backported patch to "stable@dpdk.org" but not "dev@dpdk.org".

FYI, branch 24.11 is located at tree:
   https://git.dpdk.org/dpdk-stable

Thanks.

Luca Boccassi

---
ece7d7eef0  Anurag Mandal    net/iavf: fix duplicate VF reset during PF reset recovery
8e038dee42  Bruce Richardson net/idpf: fix Tx of large mbuf segments
edff93f638  Dakota Sicher    net/bnxt: skip timed Tx pacing setup when unsupported
1c39f3f240  Marat Khalili    bpf/validate: fix BPF_JMP empty range handling
7f8ce8d13f  Marat Khalili    bpf/validate: fix EBPF_JSLT | BPF_X evaluation
b482a764c6  Maxime Peim      eal: fix index for non-EAL lcores
26e7538e00  Zaiyu Wang       net/txgbe: fix link flow control config for Sapphire
e586adbac0  Zaiyu Wang       net/txgbe: fix mass of unknown interrupts
