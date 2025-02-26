Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56202C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 20:08:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 404F14029A;
	Wed, 26 Feb 2025 21:08:47 +0100 (CET)
Received: from mail-wr1-f100.google.com (mail-wr1-f100.google.com
 [209.85.221.100])
 by mails.dpdk.org (Postfix) with ESMTP id 809714029F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 21:08:45 +0100 (CET)
Received: by mail-wr1-f100.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3bcso34808f8f.3
 for <dev@dpdk.org>; Wed, 26 Feb 2025 12:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1740600525; x=1741205325; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPrnM5/haesSl7tUVtffeFGjPBlbKhcCx/FRgufI8tU=;
 b=OYTfkrxZUl+orm/hVDvwAtFhQsSRPDWGin4gjLUwP5RNafzcbF6wUazrGa0JBueOpe
 YlkdY21H5gb1gwcZ5Oomt3+pQRv63fuGi7W0p1dOzK6ZgPyZgNUMmmAbmdR0k2QZiEfw
 j7TPaRSzX3beGbP8DTuRfyOEHuAveiN3AzdOz7GGS0e+2C7f6vfWCjreGheUyERZHgZe
 mtUN84CINKp5NyAlbaNJYSpv991UBrOMNlp7LNaOZ+UmQYFlBWR/OIjnTspmxPED+t+f
 mx2QbTVdaj7AQC37ZWoatp8XajU24VdyrK8qN9Vyj+avMKPqnLW/8uQNSxOZD1glLlJx
 Y8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740600525; x=1741205325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FPrnM5/haesSl7tUVtffeFGjPBlbKhcCx/FRgufI8tU=;
 b=FjSLaWqIUO3Nw0MFUGeKAfwjw4Iizz9IF8K+0FSccA40zLSf7R6AWq6wgh1lFJT27l
 oENoJ+TQb07tAAVvDzXN81v5JP9FIfYpIIrXy0z5mFKkxNp72a3nYnmFeTENdjLw54pG
 4sUQsifsh69LbH5z79W78dR6IA2OgsNKDbBtRRgo85qy8pnbv+sbq/gAaiKKRoEHhpNR
 3ONUJvdQJfAVOKSfn2w6HCuf7EfKLD54dDTDozcjGzTqONlh/7VniJ6Ekn+wIHc9Z420
 hBwRlWk4rZ/CxrHNimSEUy7g8waeEUDrhy1Ds0oVACk/zzZsMi+w9U0k5gMV6GbHlIpN
 gxsw==
X-Gm-Message-State: AOJu0YwdgfiqY8Fnxf7+jRdIgO2VGvr3K0DirINGtnFPt1EhqhuWM2qw
 r7L86MLJdWgGvzWyvUKWcow9J1O1XohvPNJ5Lr+v87dxtHNuBweb/5Kbo4FL4xEYMDDjDYi7ad9
 MgXWAm2zp8T7IsIaQQZ+aVvK6C6b/DuKf6OYeeMeq
X-Gm-Gg: ASbGncuJsPZwlo0upZg5C6wE7nsX3gU+rcR0ZbwhqsX+tI1fnEx7cxVBqY+8nH0WUCh
 wDaQ2OhJ83s4RX7NMlxTLeg0zRCxPsOfuj6zlz0W+6J0VGXEjI64M8UpvFPuovMnOw9E9auRnvr
 +86V+pzrZzuGp2XoxbBoEfORL1dss6V6WLBnLkh4BEM2RLdehKzj1B6ZtkQavStQL3jnb8xFV6g
 DqM+eNMs6lzjqCkRI/n1YL69GpJJYkli+i9Y2ldR8JkOWwD6+oaQauL/XqyjTyCNKiWL91skngw
 uQ1TcvMe2LX8xiZhlPP7owQjWJsXP/SeNps8E++A4D/1IixlrWPVZKyP/0Mb
X-Google-Smtp-Source: AGHT+IEUSqeSYnMvhWx43ZJwXlfab0aFndiLnWCSaaWTpDqKgHBZ87mFp8IUB2/vx45CLFlYGuIvguhA9ifP
X-Received: by 2002:adf:e58b:0:b0:38f:4f62:7e29 with SMTP id
 ffacd0b85a97d-390cc60a80bmr7350661f8f.26.1740600524931; 
 Wed, 26 Feb 2025 12:08:44 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 a640c23a62f3a-abed1e33ae3sm25567866b.214.2025.02.26.12.08.44; 
 Wed, 26 Feb 2025 12:08:44 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id BCF80175FF;
 Wed, 26 Feb 2025 21:08:44 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Ciara Loftus <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v12 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Wed, 26 Feb 2025 21:08:39 +0100
Message-Id: <20250226200841.2342632-1-ariel.otilibili@6wind.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116195640.68885-1-ariel.otilibili@6wind.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
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

Hello,

The series addresses Bugzilla ID 1440 in two steps;

1. Fix use after free.
2. Refactor af_xdp_tx_zc().

Thank you,
---
v12
* fixed style issues (http://mails.dpdk.org/archives/test-report/2025-February/857083.html)

v11
* removed assignments in if statements (Stephen Hemminger)

v10 (https://inbox.dpdk.org/dev/20250223215259.448723-1-ariel.otilibili@6wind.com/)
* no change

v9 (https://inbox.dpdk.org/dev/20250207104552.1663519-1-ariel.otilibili@6wind.com/)
* desc->len takes its value from mbuf (Maryam Tahhan)

v8 (https://inbox.dpdk.org/dev/20250206204645.1564535-1-ariel.otilibili@6wind.com/)
* fixed seg fault (https://inbox.dpdk.org/dev/CAFdtZitaNGhC5Q10ATNa7xXX1JbuWob=YzrcWmq8LTz+qjiu4A@mail.gmail.com/)
* addressed feedback from Maryam Tahhan

v7 (https://inbox.dpdk.org/dev/20250201100300.2194018-1-ariel.otilibili@6wind.com/)
* no change
* resent because CI didn't take patch-2 into the series

v6 (https://inbox.dpdk.org/dev/20250131231018.2163893-1-ariel.otilibili@6wind.com/)
* added missing credits to Maryam Tahhan in v5 

v5 (https://inbox.dpdk.org/dev/20250131183439.909831-1-ariel.otilibili@6wind.com/)
* fix style issues in the signature of reserve_and_fill() (Stephen Hemminger)

v4 (https://inbox.dpdk.org/dev/20250130221853.789366-1-ariel.otilibili@6wind.com/)
* redid the refactor (Maryam Tahhan)
* marked the fix as acked (Stephen Hemminger)
* updated .mailmap, my main e-mail is @6wind.com (https://inbox.dpdk.org/dev/20250115121152.487360-4-otilibil@eurecom.fr/)

v3 (https://inbox.dpdk.org/dev/20250128231152.249497-1-ariel.otilibili@6wind.com/)
* reworded commit message of patch-1
* addressed feedback of Maryam Tahhan

v2 (https://inbox.dpdk.org/dev/20250116225151.188214-1-ariel.otilibili@6wind.com/)
* reworded commit messages
* addressed feedback from Stephen Hemminger

v1 (http://inbox.dpdk.org/dev/20250116195640.68885-1-ariel.otilibili@6wind.com/)

Ariel Otilibili (2):
  net/af_xdp: Fix use after free in af_xdp_tx_zc
  net/af_xdp: Refactor af_xdp_tx_zc

 .mailmap                            |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c | 77 ++++++++++++++++-------------
 2 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.30.2

