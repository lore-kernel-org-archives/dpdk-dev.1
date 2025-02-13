Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371F6C021A4
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 21:22:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 040D940279;
	Thu, 13 Feb 2025 22:22:05 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3033A40263
 for <dev@dpdk.org>; Thu, 13 Feb 2025 22:22:03 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220ec47991aso2791655ad.1
 for <dev@dpdk.org>; Thu, 13 Feb 2025 13:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739481722;
 x=1740086522; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgv5PkWrl7GdVTFksSsf8BpVe6AsslQOYHtgBXbt9A4=;
 b=LyTDPN+pRrpctmQQcx4ZKso+zFjaq4xcPJw3bj5D1nusQmvTmMYeJjYAFMDK/nr3W0
 TLC9LeuUP7R5GL2myNdylNqNAT11kGivK7x+MfsBIj9mOQf8CxbuTGYIfJfkRxFq3Qyz
 qqRvouklnUbow/q6DLHvJ+j9G31WHFM5AheS5fTQYA/7jOtq3gadgRA/tM0zz+Aa01/n
 /Xjte63Sw7G75ve1nAir07EmBV7uIYoTkVFJ+EiKFlrgpb5Eb4dyg4RD7a8hqleN/KfY
 j9WpxjTYnvy4svUERJSDiS4Kbaw3vCZGonsXaAoth2eoSJsgEEPQfA09s33IW2md4r+1
 AUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739481722; x=1740086522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgv5PkWrl7GdVTFksSsf8BpVe6AsslQOYHtgBXbt9A4=;
 b=AHQpBhovlQFM137APkph7EO4DR2gmTqC+rkRVptGojx7eUBNTPR7w+DU01PKR4sL+6
 3IJLPVp3nECT6qLeWl+GbtJ9GoUXkUBCEEwteT1LEAaJn576XTnIY0RWaIS4LyVbfjcl
 9xoChx57FEMl+mAcYuZ/O9AsFu/nV7C4Hv5tPgYpWhZPhqliizopikt5cmT7u0oNJQcC
 0acqv/C3Sv3K8u/Ivqei+uOSGlGEMXE+nUXBY/bcFo9AmjVbaMuySvBkBJjz6BAFwPNa
 bxzaadvlg5TCu7m5OtB6klsAvg+5X4vqpE1RikRV1eG7g25touIr4Mkh1w9nJQG0ykbe
 jTjg==
X-Gm-Message-State: AOJu0YzWTSfI+dmDtBrxGYZUYlqyn5ML1nfLsOeTsQdYhGrlD8pdC/qM
 IVxfkNhc41KPRRYAN/EogIdbllp+0wqQm6dYoXBRCXG2rUv8C2SClGQBD/lJmgUKNjDD9XgffKK
 c
X-Gm-Gg: ASbGncup9i6prFmOFzZFcZ6a/hB2xL+lh2UKQccKDcDPaVNwOfjAMJJAw03lrtVUxSj
 pVgDiXjPTmkpQrtmyNpTzVNnXkrom6232oz1VJvqLzNE6yUAPqTtcvM+GmVm3RVFm5w2ccTmK5E
 VErZkQLteZqtXlBGEAsd4LMVEORseSzaZ+cEq07rWP0DdsCl2TELvPk4Aa1ZLbx/tyrNJkQSzwY
 fde6BgxqTTQ22cDTbLgsyuRQeJEPW22di+USgRFUK25gEUjMxKnSw8+vsFIDalCfRDoYO2PZOs1
 QkUxC3hzZu3RHSzvCKSMkoYjeHVL9iD/nqS9M8nFv42UoCzk147u4OknJcuvMyJC0026
X-Google-Smtp-Source: AGHT+IGjd66pVbyKxMOm0r0YHUisTIVhrIaJ1sEMSZzvT3oRFm+HhoNZ8b9jti/KSm9BY5bPf5oH3A==
X-Received: by 2002:a05:6a21:700d:b0:1ee:68e2:8d7c with SMTP id
 adf61e73a8af0-1ee68e28ec5mr11949670637.25.1739481722133; 
 Thu, 13 Feb 2025 13:22:02 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5de85sm1615822a12.10.2025.02.13.13.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 13:22:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 0/7] latencystats: cleanup
Date: Thu, 13 Feb 2025 13:20:29 -0800
Message-ID: <20250213212151.1693506-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20240408195036.182545-1-stephen@networkplumber.org>
References: <20240408195036.182545-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Latencystats uses unnecessary floating point and is inaccurate if the number
of cycles per ns is not an integral value. Cleanup the code and add
more tests as well.

v7 - rebase and drop already merged VLA patch

Stephen Hemminger (7):
  latencystats: handle fractional cycles per ns
  latencystats: do not use floating point
  latencystats: fix log messages
  latencystats: update include files
  latencystats: enforce that unused callback function is NULL
  latencystats: add metric for number of samples
  test: update to latencystats tests

 app/test/test_latencystats.c        |  84 +++++++----
 lib/latencystats/rte_latencystats.c | 213 ++++++++++++++++------------
 2 files changed, 178 insertions(+), 119 deletions(-)

-- 
2.47.2

