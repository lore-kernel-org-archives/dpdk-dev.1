Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EBC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 585A140E0B;
	Tue, 11 Feb 2025 18:37:42 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 937F040DCB
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:38 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa48404207so6467324a91.1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295458;
 x=1739900258; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=dmYXC3YBgmugDjSr+Kqmp7RliPz0QCdEtNW9MymtfnTyu499F8fwhQGCN+3djgVHXl
 Z23IUwp/WRBb4jr/0jhpceeDb3aSl9YHlv3cVN8yIlvgK+xn8fwWKgSnCuDDhwcGuw+r
 vRAO0hFNqixtqpPTgyfWrUyQoenWxSmpGDknBSCXo6K4EiAelPAHLSIncmHODYWg0udI
 Tqeh2wdC2YnDkqNscwdH10hpegXzRdHSVQ3We/tfX9Att22e190WPgQccpx5averRg5e
 Ea0xgE9r2ymkGN36f7er0py+/tPQ2mY5anc1FuyNQOSJEtj0UVVw5ZEv6MNbOscqp3L3
 0D7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295458; x=1739900258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=AFrVDle7FblkljWp69Xo6hRQxCPO8HjXPsQ/TeieHWhIUkHEWJbX4gRlaGXXgtcvXZ
 SVvkESqD94pmiPG4Lp6t6rckBUcMYup3UwMmT8TmpikmKFfF2q5qKvwKg8ThzN+gqri2
 84iaDAFmfpsPO7YduhYx1eizuxI+itUixu4ObUkbDskqdG3qrhp9it/BPJEXX5TAYgu9
 TDaTdDHZ5usl3Uo3mJBIDOwGPYAmE685MNz5zqldRpvMJn5/tCNF3+NTd5WlG7oHf0ce
 eXGBK0SkOebvpR0MTjAYq4B4mGe0i39lblQv9ofWORW6vx53krjLWEyhPfj/bZlzIMQ0
 aUuw==
X-Gm-Message-State: AOJu0YwmNQ8KmLKkUYgkLgzVUQTIjDSK4YEAddqHLkT7SsljxLA8iKE/
 RgbAsjo02l9kNLufEPU9FT4NO6/+dEO8uvl9ZCAuxursu/8gPQM7fIlN2ioxc/K3BE9Jyma837i
 6
X-Gm-Gg: ASbGncvj/CfMsDAt8nw5nPLYv/fXoKt5ewCEWrp7nAgW8Ny8eU3PoeydZs9a/WqgTNQ
 t4LxjuNMABf+bgxqkIZVkZA/bwU3Rx1FZ+o9uBp1TARAyY1SIihSQjtLSxO5OtbQ71Bl7NBA6Dq
 1PwyVzVHArdQEQaXDZhawhnK5FJxfrFlY49XPog4L0phH++09gBSahwJbDhM9qz7w6yE7Acpu1Q
 xHWVLE1Fl9V2qhjbD0/QXnlHQLJDXTYxm7xd2o2WrPYPtW+/L8aYvZLTogRuwOPAfV7nYQ4G2q5
 ZbomrGwUyT5WNwb5BJ7FeEWxGnhbpFEGHYw1+PNgYViM0GxRyCZb/Zk3ivEFXdUy0hiB
X-Google-Smtp-Source: AGHT+IF5REX5vIH/jwbqoVJiCoI0Y+insi3NXduMZuYE9PXEC6qSqeCdrZxxXOvUl5ttjfA6nyOLFg==
X-Received: by 2002:a17:90b:3596:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-2fa243e9aaamr26491130a91.27.1739295457781; 
 Tue, 11 Feb 2025 09:37:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v5 06/11] bus/uacce: remove memset before free
Date: Tue, 11 Feb 2025 09:35:26 -0800
Message-ID: <20250211173720.1188517-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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

Doing memset before free maybe removed by compiler, and
is flagged by security scanning tools as potential problem.
In this case the memset is unnecessary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/bus/uacce/uacce.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 9ca048122d..cc1e42d56a 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -454,7 +454,6 @@ uacce_cleanup(void)
 		dev->device.driver = NULL;
 
 free:
-		memset(dev, 0, sizeof(*dev));
 		free(dev);
 	}
 
-- 
2.47.2

