Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F856C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:18:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 429EF43278;
	Thu, 24 Sep 2026 18:15:01 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 20C9A43270
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:59 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-868b2e5be4eso32219b3a.3
 for <dev@dpdk.org>; Thu, 24 Sep 2026 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790266498;
 x=1790871298; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VRsXzTSwXnbwsywYhmkee8eIdw8cJoic9SzQyr0bSqY=;
 b=Mov/OvQOSXRUXkMO7C7tBBnFym/jWmjdIuXqk2KQAfJkPe4U+v88FyYrN46lroMCIV
 unA7f0DEXogayB+S+0DcSvdPJaUYanlVvxPRti2Z76KqUNJoh4AUM8rmvOYg6BZjZ9BW
 BypfOUUHCwtMvGpW6T96s79edxSRBOm6u8NdWc7CpUXn2W1qSBf5VhG3qx3tOu7claR9
 W36kr6tREPNHz5H7B9PNeErSG5lsvuzw0pWPlSpNXD4siDePj9Rcl6jIXxxwk76RBFhp
 zVc5JQS5hVXG071k+2L/xhSefJDp/Zz2YyL2LatSqwRqcEX5oOYtg1cXO1v21x2XCMrt
 PlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790266498; x=1790871298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VRsXzTSwXnbwsywYhmkee8eIdw8cJoic9SzQyr0bSqY=;
 b=PPFjHX+DL+MfMGB+hWyiMo8miF8OJ1bpqtwHzghDyauUxULCiuP6uW6H8WV+kfDlP2
 bc6BNHVpPkbDOJ9nCW7klMMxmtznL+Ry6JlZDLj5bo4WcJPf7xCNahhyE4vcnkISGKcm
 07aBP06V6soRrcP/35Dg2IDxAc+pJbgzAiBdWwUEt2v+AIXmYt3qU+U6ZhI1KvoeLQ5J
 x8PGGFpXJ/5YqVtA/7amNx48RKYv6dxVqK9Q/ietKURvoCVLrGR51mT+E5muBUWWdIFO
 97HtFgPFKuvHCBA3LnO8WkNvtu/MPekvYG/lmNLyELcNaAf1fsW33r9TC9p1QQo5O8sF
 MIgg==
X-Gm-Message-State: AFuF++kokktlqPNnI356meY5EiAILPgQ/Of588zRKEMDpqlaQOu2H1aj
 dJyVQJY+LdyZ3K1rtmqd3eH5WDJxNsM4srA7VwNOrTBTNWnk8BHCVjAGOwRSi0HU48SK1iA4uGk
 AfvG5h0Y=
X-Gm-Gg: AYBFou2fcWHdJyR4IgDEr7AMMeIq8lrdgqQHDFMAlTFJP2F8TIwqJfOZmlQmXpn7ssM
 FQ9BkIXJfMHMNpx1Gv9cLhcRN+u89tts3dy6plskrDZHlb4XvW/5GdJtKHB1QsuIVDaHyXMWygm
 uCjvXI6lO329vVJeH5/5HmmNscr8gDDu81LnKL/7ZlVUV1yROhSP2da/2OJVR7eDpjg8nZHQYyo
 iBXY0nQHZK63Z5rq8QyTSJrZ14kKM2Pu+4Q3OouFmrCk9/c32+ULMw1nMWZuu/BPWd9HpRe9Hu+
 t5WqVbiq/7tICjN/ZDpwGuyS9u2zkIMWpaxwoANYHkFOO68VWrNIg8FOoEpU+6TcfpzVogiuz2M
 9o4F0PJnd2CRWvJl7pnkbrmAKs1CtLnGvnvv+nNEOD59JUG2Tb1/9dW5s/HOmojwm6jsHXIp/TZ
 fbzeQlKohjSffd3gg7+4DWUXbR7LDCXzQMZHoxXKxUVH5Fm7XtEjXVpjlP0J1cTpGuTnhbFNHb2
 y7qusr7obcRkET0vNi+A3lurrUkCdbHMGrQQw==
X-Received: by 2002:a05:6a00:1bc7:b0:857:727c:a1f4 with SMTP id
 d2e1a72fcca58-87e9b798c35mr2539671b3a.22.1790266498086; 
 Thu, 24 Sep 2026 09:14:58 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1d5c163bsm3367534b3a.28.2026.09.24.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 09:14:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] remove redundant stubs
Date: Thu, 24 Sep 2026 09:09:22 -0700
Message-ID: <20260924161104.335111-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

Work on automating driver features matrix uncovered drivers that
were using stub functions with -ENOTSUP. It is better to let ethdev
layer do that. The future driver scan script will get confused
if drivers do there own not supported stubs.

Stephen Hemminger (2):
  net/nfp: remove redundant link up/down stubs
  net/cnxk: remove redundant IP reassembly conf get stubs

 drivers/net/cnxk/cn10k_ethdev.c | 10 ----------
 drivers/net/cnxk/cn20k_ethdev.c | 10 ----------
 drivers/net/nfp/nfp_ethdev_vf.c | 15 ---------------
 3 files changed, 35 deletions(-)

-- 
2.53.0

