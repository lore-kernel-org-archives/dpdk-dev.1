Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5B8C3ABC0
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 May 2025 07:41:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 216224027C;
	Thu,  8 May 2025 09:41:38 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 2F22A4025A
 for <dev@dpdk.org>; Thu,  8 May 2025 09:41:36 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-30aa79ee726so752079a91.2
 for <dev@dpdk.org>; Thu, 08 May 2025 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746690095; x=1747294895; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dMCbK87UIFeupHIbm4jU/4fLZt3S9ufEthLmnhRWUmc=;
 b=f/+iaw6do5mp2zP+bg2XZInVJ7l1tdE61Hbws4yzVSmvAHXBe9CD7AfAjfkT1h2ODs
 ZSLw/6BrrZwB+75D/jfa1LHxFb5IN6L6g6qV0WYglLGdvi7XiJGfJdC/JWNOWsmKL3Qs
 ANA6jlw9EJQ7LMxF/zZ6QIgcNO8GAR8zV8WFDqkSL5JZcN3hBTZCwtHqGTZSS2eYCOKy
 P7FFyYCx9G/rFGEuIJNv7MumitcyHbFM9zSz/u8tTioQPzKW9iXj9Da6mvwAQybv+hBQ
 pafFk315Ma1C0QNUYyVZM786fI+vpfP0ay/MeL/xvJkGUy3MckbcAfRz7VNKcK0p9dVu
 50BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746690095; x=1747294895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dMCbK87UIFeupHIbm4jU/4fLZt3S9ufEthLmnhRWUmc=;
 b=W7Tw0r409zIfaEkn30w1kqQ721rUrWPa9ey6N7RG3LiGdYBTEzHaqLoYtYrKDW+Jwj
 zaF8qXjcnPz+neOU2OXmQmFY9E/4XWa6OYXITBlhlUxgOBN1mLZjgX41R/jZeLnSixaJ
 kuUrf8iQSk5+uEjTvFiI80S2TZu2ezDihgPvJYtVE7YLzF4mNrD+pEExQoa4TZEWPQAB
 qh5B6ZoX7haWmx4TQVFe1LsGtUFW0mQc/ALLJny+41Gbni7OOPzxcN7Bp81BG0OKuAas
 /DDIFG4BrareaTX5GnVTaFuHqKf6E5Lo1LiCH5jbhNK1aEgdBH4VQpyfVvMxD7ubh1on
 tjWg==
X-Gm-Message-State: AOJu0Yyqe+iUi74xS7wylWIXo6CPEUDM5/xgZPkaUk6dapBwkb1Ramx+
 X197vpOaJDyhBk270dvV49W3a/5CMB3eW5aE218TJx0HzllVMepATlt/jIhHJo0=
X-Gm-Gg: ASbGnct4BTdymN1jhmvgorgNpHsh/o9NNw9etknWFuxnMkKxqzcHIM3SnJirXzD22h7
 jplLerPpWxbjWoHmAgMtgGGu1qBpcwcHTTRvbYrZ0FyHMV55Q39k/E7vm2j5X5ONWU3QGS/d2xL
 lJK9vo9rJF66yNWB1R3DwgyYmumlSOQervPgpY4peS0DDROVh4p4eBSnHflFuKPwpjJBa9GKCj8
 47Vr5SJbuSbjAyoti/pmsSYF9YWc8NwGw7JSDpcehzX38WDB7oXCxKcf+Uw1tdt/ZqrtQ9ryfMw
 NK0kP61ee/J8C+ToVSRJ4ZHjG43EBO8SnhvgD7AlOQ==
X-Google-Smtp-Source: AGHT+IGoH/TEos1Y3Bd1bYM+TdI/BicljSaIffTl3FeVpdfroI71KXhRUIOrLid9DGbtLEz3WuVdJg==
X-Received: by 2002:a17:90b:48d0:b0:30a:9025:84d1 with SMTP id
 98e67ed59e1d1-30b3a6749d5mr3796897a91.16.1746690094991; 
 Thu, 08 May 2025 00:41:34 -0700 (PDT)
Received: from gmail.com ([121.37.54.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4f55825sm1504542a91.31.2025.05.08.00.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:41:34 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] uadk: realize async mode
Date: Thu,  8 May 2025 07:41:17 +0000
Message-Id: <20250508074119.356011-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Realize async mode to replace sync mode for better performance

Zhangfei Gao (2):
  compress/uadk: use async mode to replace sync mode
  crypto/uadk: use async mode to replace sync mode

 drivers/compress/uadk/uadk_compress_pmd.c     | 107 ++++--
 .../compress/uadk/uadk_compress_pmd_private.h |   2 +-
 drivers/crypto/uadk/uadk_crypto_pmd.c         | 321 +++++++++++++-----
 drivers/crypto/uadk/uadk_crypto_pmd_private.h |   8 +-
 4 files changed, 318 insertions(+), 120 deletions(-)

-- 
2.25.1

