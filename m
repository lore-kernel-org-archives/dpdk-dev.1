Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C6AC02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 10:46:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BF0F42C24;
	Fri,  7 Feb 2025 11:46:04 +0100 (CET)
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com
 [209.85.128.99]) by mails.dpdk.org (Postfix) with ESMTP id 62FF84281D
 for <dev@dpdk.org>; Fri,  7 Feb 2025 11:46:02 +0100 (CET)
Received: by mail-wm1-f99.google.com with SMTP id
 5b1f17b1804b1-436202dd730so12931395e9.2
 for <dev@dpdk.org>; Fri, 07 Feb 2025 02:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=6wind.com; s=google; t=1738925162; x=1739529962; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vyURwO3+yL6WyaCBLqWEyNYl/znQ+E3Y0MUzq/hvxX8=;
 b=EapW9LRGk+JnrlbaQaI1BlHZl0MCwtKj4lKdcP2/yGJJNGn8p6uDLGDVzsRBPKKg95
 4b+G+am0gTj3Wn4iHsNhYAQTJ2EyG1eVhcRKgnV6PW4O0/F0sUukESgVs0fyL3BHte/f
 jL5hz8vYb/m9qVibt+RvCVYaOLSvE/Hms5Ck9EjnipXOVAdsPhi7FWONFC+ukigLd16H
 FRXZGgiznzR1KRYfTdJD9kyX/xYJdkCrTo/58whM0QCdLOSWPTBfhdUB/ltaEKqgxqAb
 7xFZm34O+mEB7hRfGnyorqClpQPf9+mn/LL91GghqVmB1D42HYpT2V8zVn4ucEfaHtxl
 xOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738925162; x=1739529962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyURwO3+yL6WyaCBLqWEyNYl/znQ+E3Y0MUzq/hvxX8=;
 b=RvQN+yjaM7lWRUZWl1/8e0eXlLaw2TS8r/5jT7BFzF6+8Y6+XvANEH8XbRJu8eLLZ4
 YE71vBjHGKDJLAk2fyMODGHAqlWlk9LQh6i5SMlsLnuW2Zp8i5ahhqpLRpZfSn9nAoz5
 HPK17iZKBjY+BblIZKvtLEgrkH0DPnCSHStlmuJBALPOFjzqI+HBUyJa83EXJPwxIbpt
 nxQfM9qsrao4zgToyjzITE4m8VtNaiL8i9ZrTKbLezVocDHUTMYDjur7aI361bgXOinZ
 3W0O2eFk6hg6M9BFzrq/ZtpF6VXqqR6k6M/h0cfJmEfBlrjwaCXe8Y2t/HIWiq8H1XFm
 4jew==
X-Gm-Message-State: AOJu0Yxj7UwzHWbdnaJS3eut2rNc3knxi3BlNKMuBOT/jVo12QvOS/oe
 BL5hMosxLIU0+uPuQAHRLDRSAY5xOItHwtlNj9nMYFpXemy/ww5ey4W6JM9pOF2X1SG/N8ruaJR
 2Bddl2FSZeTLF+T/zAhY07G+qqhXPMsv1iLNAX8xy
X-Gm-Gg: ASbGnctZttoM6ea7sxBsYNR8ankQoMuD3crtQynutyy8x9KsyB8DzOoVf/pDbd3Ikin
 eD5r+taHNI7SUZ5bXgtbohTmC18YlQJ6PMqfaDgRHcfg+/bU8As34HbECwwx+LS/7mnhn7REUcL
 n9YbnA9/q1aek16pC7FzpRfcJTHc9gip6q1XTUk2FyWeMJJN4JsDLw9rizccY4hgwlXfWkDIwNe
 2+r+Vk3zlGOaAmHJ4rXgblx6uwJhABFb2LI7gdRpJWSJuApO4xM4R+ZLrBjPr4YI3EsdorAWrZJ
 bA5quQM5SJt2cT8FwID51vyQ/pa7KOADG5hVbEIa8JsCHiNeIQ==
X-Google-Smtp-Source: AGHT+IEQ/T37zP16n7mpkzJbZj0pBp1H0ie53ocolhEnuGiSSfuwDzVrZKzjPk5l73uqubKxwcZ0psp2EPmR
X-Received: by 2002:a05:600c:b44:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-43925f3c487mr16826025e9.18.1738925161766; 
 Fri, 07 Feb 2025 02:46:01 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
 by smtp-relay.gmail.com with ESMTP id
 5b1f17b1804b1-4391daa3b98sm3257125e9.9.2025.02.07.02.46.01; 
 Fri, 07 Feb 2025 02:46:01 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
 by smtpservice.6wind.com (Postfix) with ESMTP id 97D421D385;
 Fri,  7 Feb 2025 11:46:01 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili@6wind.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maryam Tahhan <mtahhan@redhat.com>, Ciara Loftus <ciara.loftus@intel.com>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Subject: [PATCH v9 0/2] Fix use after free, and refactor af_xdp_tx_zc
Date: Fri,  7 Feb 2025 11:45:50 +0100
Message-Id: <20250207104552.1663519-1-ariel.otilibili@6wind.com>
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
v9
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
 drivers/net/af_xdp/rte_eth_af_xdp.c | 75 ++++++++++++++++-------------
 2 files changed, 42 insertions(+), 35 deletions(-)

-- 
2.30.2

