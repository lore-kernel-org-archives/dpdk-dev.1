Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0035910F2846
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 15:44:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6C2942E70;
	Fri, 27 Mar 2026 16:43:47 +0100 (CET)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mails.dpdk.org (Postfix) with ESMTP id 47E3A42E60
 for <dev@dpdk.org>; Fri, 27 Mar 2026 16:43:46 +0100 (CET)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-82a893d289bso1033841b3a.0
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774626225;
 x=1775231025; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuFxiuFO5iEPwIA+HlQGeXxSolc5bAeP8xbmCtx2IJA=;
 b=wcf5dxFMBmhQkzCnzMz3jAVO6qJUha75Zj6SC5F9AgLqjT+SeFDEerkjUqS95q6LgS
 z1Snh3r8bnlLqoS9h93ddHOsCxvtN8i12ob/GUqUbfgJoDQa/cGeL7Bxky7wh697uGhk
 VzszVLC7PEukKxNdmOMJqNdbkCVbiuf0j+WSw2lzJ7iPrqPqUX3vl6o26GDHEaSPuWxj
 6kB3D3LXvb+HL/I29P2WFy/1+hs0Rmuuh6ULn6WViKOZLQXK54kj4rr06ApVj9s1ktk0
 XHdSrInThn+mdZp254/x70vS2Q0+3ZzJ/RHkwGXHpfZso+UX7/OLozsuiaWguWz26gLi
 5l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626225; x=1775231025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuFxiuFO5iEPwIA+HlQGeXxSolc5bAeP8xbmCtx2IJA=;
 b=Vx4t8MQL9bJwTzAc/G900unJvXXQSxTy9nyIMxYQK1Yg2WDvG8IIVfjAnr70abnaLo
 To/VMen+NqVb52EX90fP3epkLG1C57wh+JkBECOrBSQWRVEKWmTGB25xIXQHD9DfYguA
 Z80AOfyQRqbq9MsUpJ7L8/nkwYfnBawjtq9hLrJHTFjyez2OS+G3kTe93kZP7dNm2M7v
 rjyDYDFky7lvidsmN4oKEzD/vL7QBT4uW5w/xeGNnZ7y4yseGh4utE+yjdiDJSB7tj4g
 4bJrg8yYuNJKcU8UNli544VY8xvxSKiByScQzvcVXFIMTvpmsyLusI52zR0vwRFwItvP
 IlxA==
X-Gm-Message-State: AOJu0YyAkxgBcHb/R5rwPgnZprbK+aN/FdZjZFqoGATX+mZmgyuEKg9E
 EHYS0UlBU71ArObEbZ744A/wAzZQToIONzDk+zDcY/qENTYUgqFOwc0gzr982zxyIrFYWAn/2VS
 tPth/
X-Gm-Gg: ATEYQzyx3dQrtP149/ly9BSx7Th5xWaAHa82fNzMd7bpyiBGE/y1iPhAfgX5b5kCwod
 Hh89YsRLYN6hzahdQnCAF37yQEaxMMVOeYsIQLsbMW5Vx8WCERvF6LmRs/f+gCwtpW1F+ykKNIY
 xyuUd5DBqW20vwc2cHfi/MaCSM+JpDsC8arposWTrnTELqtIo/xSd26zhyVTxkOqHP4mpFaeXEU
 lpyXDAeFBr/LxJyrGqGa0FieMAK2odLV0OPAHmnrZcqtU4r/NkR8kPhiUl5n5ow0e+UM1i74Dwt
 dh8X0MbAnV88F+RIi5rFIHQt+nYIW0m8kVpnZ5y3JRpXl1syTTW/McpMtES5wGaMAj7Bctc8Os9
 686JR9U8loHkg+C76p4n0ucf0CV0Hkxtu/GlbboQ/kmN87SQT8q0yEQjslqDWE1Sj+xpxL8CkUH
 Xq+9c08EecaSrFYi7jTe+XXLy3ghvVPRwb
X-Received: by 2002:aa7:9883:0:b0:82c:9c47:fee7 with SMTP id
 d2e1a72fcca58-82c9c4804b6mr1378974b3a.10.1774626225397; 
 Fri, 27 Mar 2026 08:43:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d390a4csm7508304b3a.31.2026.03.27.08.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:43:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 6/6] MAINTAINERS: add section for AI review tools
Date: Fri, 27 Mar 2026 08:41:57 -0700
Message-ID: <20260327154321.25800-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327154321.25800-1-stephen@networkplumber.org>
References: <20260126184205.104629-1-stephen@networkplumber.org>
 <20260327154321.25800-1-stephen@networkplumber.org>
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

Add maintainer entries for the AI-assisted code review tooling:
AGENTS.md, analyze-patch.py, compare-reviews.sh, and
review-doc.py.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..c052b6c203 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -109,6 +109,14 @@ F: license/
 F: .editorconfig
 F: .mailmap
 
+AI review tools
+M: Stephen Hemminger <stephen@networkplumber.org>
+M: Aaron Conole <aconole@redhat.com>
+F: AGENTS.md
+F: devtools/analyze-patch.py
+F: devtools/compare-reviews.sh
+F: devtools/review-doc.py
+
 Linux kernel uAPI headers
 M: Maxime Coquelin <maxime.coquelin@redhat.com>
 F: devtools/linux-uapi.sh
-- 
2.53.0

