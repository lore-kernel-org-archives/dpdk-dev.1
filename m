Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89518CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 08:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA2CB4025A;
	Mon, 25 Aug 2025 10:33:19 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id D4B3340151
 for <dev@dpdk.org>; Mon, 25 Aug 2025 10:33:17 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-770522b34d1so948927b3a.1
 for <dev@dpdk.org>; Mon, 25 Aug 2025 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wisig-com.20230601.gappssmtp.com; s=20230601; t=1756110797; x=1756715597;
 darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7djOBw66Byt9BUWrpJdY2ZxumhJtpLUiN/8UB4tVvA=;
 b=wGbHlMhNy7yjTy3r70uW/olV3lYkF0VIkHMlUDNU0R29OdBsGu9GgjcNneOAEBPpcg
 wHZ6sA9/pMHRhzCnt++sU4CqhRD7gmC/fxfWqv/njbJGMEm18DKS2FuH0hPRn8XUKk0b
 jQlRjMvrZ6Mm9+xDyWrP+01lUAsCL7Ojoer3E0ML+qdXOkP0vSJuTxrobruhq76wHV6M
 rhAHPYAAC/fiWuidyaHxIrY9SyInUvKbETBU4h+j1z0BKJmrneRQHJHXDw14QqcSedvM
 QP+56GL8ihFMkTKZVKoctMMwTCGSKFd/U2siuP98T0XYHsSIzwpQvJa82JPK3WWM86Jl
 LfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756110797; x=1756715597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7djOBw66Byt9BUWrpJdY2ZxumhJtpLUiN/8UB4tVvA=;
 b=BUYH/HP0cBgErhWyuy0PHeOj/m5RIgR22n3NuPCGsgEQVNo+K/GaZR6ctacsjN9Dby
 ksLgDeasVDVXW5gN9agAyxfTuZlIeSLTBnRroHKTWe8xM4KezvO7Jd77ZPX462q7X0RZ
 CkmXULC+mIM+8Vz02ODhpp8XRBa7q2IMxbK0F89mWobuXZoEjbwGtha9jgwEiONR1gln
 qOeyXwz4nwUixxpEIa8IMcP1k+w3/vIKE5+7IkmGTcATIDjT4yiHq0IdLNGKpORoIOIs
 YHlj84Hnx5EpQlm71ahMloXRtRiauI3Livs51vXNGWd/2Q73yF+/srSop/lkHTED2ktT
 77tA==
X-Gm-Message-State: AOJu0Yw3PTpGfzbl+BY8ur83OG3ewICC64LhClVWWNGjhYgoZ3psPASx
 +9KlsqsyBl47f7VqPwGrvdd/h38j4Wo6L8s37UGBmFdKHMlfCVBnwibr8go3jP/RvDrxyPArU88
 8W3Kj+A==
X-Gm-Gg: ASbGncuVbZOsq3YjUPsqVlbNxTnhbiurCkCpRfAWU+PAzY5bW2asKi1b399kRIQunmI
 S1HNetYOPIYO6IHqUNXGJKugDI0QpFr5cvsrzbCcmxTPoZn7n2Q9YxNXDzyWz4EdCU9EA8sviGL
 75d9wSEeURTnf6XSQJ5pG7X5LE5bmtEiNsuSlNm9so9khKd9PK8WF+bzZWN7C6PuAiwZzcHRXYH
 xuNyGPYZW274QEpPgkWCxXMABLjxKcCUoTz0TKy8chqtvZx9pJlVvOrj9Z9b7Fdu0MSnKAhyXGT
 GRg46VbWxlcE+FMDic2JZj8QnQCHH+nj8FyFyZohWCzcDyx19DhhMy/ymtlElkvTSkRCWrNYsy5
 yKLxEjUYlVwPYsLXVwX79Oe6Neuc=
X-Google-Smtp-Source: AGHT+IEn9fpGIXKA/CTXZMQsQj4syR1TiBAWOsdePh4xGYO1i8L4+X7EkUk6D+SB5f2f3N5Mm6CLkw==
X-Received: by 2002:a05:6a20:9149:b0:243:78a:82d1 with SMTP id
 adf61e73a8af0-24340e2aec7mr16415568637.30.1756110796761; 
 Mon, 25 Aug 2025 01:33:16 -0700 (PDT)
Received: from ash-wisig.wisig.com ([14.195.146.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3254b809c9asm6306449a91.26.2025.08.25.01.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 01:33:16 -0700 (PDT)
From: Ashwini Sahu <ashwini@wisig.com>
To: dev@dpdk.org
Cc: Luca Vizzarro <luca.vizzarro@arm.com>,
 Paul Szczepanek <paul.szczepanek@arm.com>,
 Patrick Robb <probb@iol.unh.edu>, Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH] maintainers: update for DTS
Date: Mon, 25 Aug 2025 14:02:29 +0530
Message-ID: <20250825083229.919586-2-ashwini@wisig.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825083229.919586-1-ashwini@wisig.com>
References: <20250825083229.919586-1-ashwini@wisig.com>
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

From: Luca Vizzarro <luca.vizzarro@arm.com>

Paul is giving up his role of co-maintainer of DTS,
electing Luca Vizzarro in his place.

Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>
Acked-by: Paul Szczepanek <paul.szczepanek@arm.com>
Acked-by: Patrick Robb <probb@iol.unh.edu>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cc08f5aaf..7aca98c537 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -65,7 +65,7 @@ M: Maxime Coquelin <maxime.coquelin@redhat.com>
 T: git://dpdk.org/next/dpdk-next-baseband
 
 Next-dts Tree
-M: Paul Szczepanek <paul.szczepanek@arm.com>
+M: Luca Vizzarro <luca.vizzarro@arm.com>
 M: Patrick Robb <probb@iol.unh.edu>
 T: git://dpdk.org/next/dpdk-next-dts
 
-- 
2.50.1

