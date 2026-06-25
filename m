Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC6ECDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152CD40616;
	Thu, 25 Jun 2026 19:49:13 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id F2B8240299
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:49:11 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso189644eec.1
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782409751;
 x=1783014551; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5l3IEGZ8VsTFZ63WSHa+p1P8KTNvC2nKdMGaoeinVI=;
 b=j5nA6zs5g1XYhPkAYKrj/fi6UsunEqLkloJxxwA4uHKxQEBmnfJb1yNeAYsmGFe4L0
 rZjsBHo0DLnq1qN4hkWyaOq4fTrP75Dwag7+yOquz/8Adv64uWcGmv38x7UzF/Xa5KgL
 CwiB/df9wJz5NSSiv6WJyJlsSB968rKG9TYpBFX4xx9nlkbWYee6PL78SD7sx1R5hbJW
 +g65lju6tcMsFAGQ9J/q15kYk2dkLfeg5+xLzmAH2fyT5I9rdKUuSRRQazYke93lZ67R
 CnB3eGq8l0Z5RsErC5husZTdm+MGG9ESAEufVDwVfaw0gfSCXaM5QVejvDoE7AHtJLs/
 vORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409751; x=1783014551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5l3IEGZ8VsTFZ63WSHa+p1P8KTNvC2nKdMGaoeinVI=;
 b=VQmqn5UNLcttCOLixpEgmjpf/MiY+ALGNW0hr1iwIUA5KvIADCeS4a9zSShuYu8R7X
 /MVQkt/KKvyM2JLX4P41Pt1N8yoSh0rUxdHm0oo5ryx8z8GY9XYRexQw2V+q504npMQl
 aoIJV515OMV02q33w6zYYv1SvwGGoCh+ItNSP5pklv/FD9PKsORenjTchfZwORA7yBPx
 otP1Oh2sYE8a/iHLRymjibAbbV06iMKOfYp/XWCVveAqLW/bn/K889H2uX+AGunvfOEl
 yFZrRBDncXxPtjrAaKcKGdfGnT8O2wXkf678XgY1ChE2rS0OtNjSoL08OqF3bP8sUdIr
 FzYA==
X-Gm-Message-State: AOJu0YzNQRfOAynhkxlxGqzOrw5pvvGSD5IZmEu3PU8XE+CAlJ+jnLTk
 9jkw0zQ3RLewSA0MlY6QPr41JgSAvs1nicnKFjGOvjcI6UJ/WlYQadmvg7DCtwppOJv56dWe3Mi
 HzDJx
X-Gm-Gg: AfdE7cmfhjNCEpU601O0UQ/ME5wu5ZGJe2gbGZiKjFLU7xm2SZDw3U4Z06s8ysViBr6
 F24B0kruArrcd8rid9Ez3R5vJymsSwBcDd7pnyqaCox9hr5V5xjbttQGHLLloxdro/dIpVLwN6w
 0664tuV9zswMaehY5ippzFa2D4ulD/Ix0frYj+34nWhq1fAducQvfkWpnMa/LceZpMx6e3nTcXN
 JkwCBW+k0uR0cZRF0UngIGV14snji5X54WUPMKjq2K1aGN1RBSur9lwrtmDP1qU935oI61IDoMf
 ycErM8mKE1Xzc8hQnsObLtBGKaE5b4SVfTD2b65Be3VoVneWi3Sl8sImeJOVMP4sUSdEVv22MuJ
 5RHeqvygGfEXfvUh7Hzfz4I1bDodU/M/Hr3jp7421Wzgxfk3IxctXxRC7fD7IhFINFwzRvInkcI
 ZHZkCPivH4RESds3SLqUjtX11a3Lvv15FYjOCwoViIwiyf3bahPK4=
X-Received: by 2002:a05:7300:a145:b0:304:29dd:70b6 with SMTP id
 5a478bee46e88-30c84d6c84amr2294410eec.13.1782409750814; 
 Thu, 25 Jun 2026 10:49:10 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4ca240sm10594472eec.4.2026.06.25.10.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:49:10 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/6] examples: remove MAX_TX_QUEUE_PER_PORT
Date: Thu, 25 Jun 2026 10:46:50 -0700
Message-ID: <20260625174908.278408-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
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

This is an old set of patches that removes the use of MAX_TX_QUEUE_PER_PORT
in all the examples.

Sivaprasad Tummala (5):
  examples/l3fwd-graph: remove redundant Tx queue limit
  examples/l3fwd: remove redundant Tx queue limit
  examples/ip_fragmentation: remove redundant Tx queue limit
  examples/ip_reassembly: remove redundant Tx queue limit
  examples/ipv4_multicast: remove redundant Tx queue limit

Stephen Hemminger (1):
  examples: remove unused define

 examples/ip_fragmentation/main.c      | 3 ---
 examples/ip_reassembly/main.c         | 3 ---
 examples/ipv4_multicast/main.c        | 3 ---
 examples/l2fwd-crypto/main.c          | 1 -
 examples/l2fwd-event/l2fwd_common.h   | 1 -
 examples/l2fwd-jobstats/main.c        | 1 -
 examples/l2fwd-keepalive/main.c       | 1 -
 examples/l2fwd-macsec/main.c          | 1 -
 examples/l2fwd/main.c                 | 2 +-
 examples/l3fwd-graph/main.c           | 3 ---
 examples/l3fwd-power/main.c           | 1 -
 examples/l3fwd/main.c                 | 3 ---
 examples/link_status_interrupt/main.c | 1 -
 13 files changed, 1 insertion(+), 23 deletions(-)

-- 
2.53.0

