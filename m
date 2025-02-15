Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777A0C021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30E7D40DD6;
	Sat, 15 Feb 2025 20:06:11 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id BCB1340DC9
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:05 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2211cd4463cso2080825ad.2
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646365;
 x=1740251165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=Yfti7L3ZXlRTdadTviqOlfWJqqL0eFJWeQmUw17AA1x59kGwbVUduB9gLofS6/4+Pj
 6Fk7QNZjETgYo0z4D4teeID5wvOg4GrDnKTyYS1yhtOqfvfbXxHaG0yUofnmesoPkz/D
 5uJaXcESsCKEzvE++B9EUJs5KrNcA1mOKovwjq0AMQbbqtIrkZpAsxglvZw4EN0XL729
 Y9BtZutRNLudl9cixY3nM7nzZ2daAuxWUSAJtwrZdb+z/fi1hyqEU22V71x0fDXDufA+
 zZHP/3SSIv9V+RPgmFXl/JeB78j4d9uRd4KAeKZzDXJoouloDLNa6igk5gHLycMXQGuS
 Pfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646365; x=1740251165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4eCQHxeqtnmJwnbM+apidP+XqcqCydmDyWVcC/qwE90=;
 b=VGb75rf9Sl3IU4GJqRt+UKj8vPIKzlDoq/WMoS0N4DytkHjWFerTLLAgfrprRPtcqV
 PQmjlS0kb78FU285LqF59L4dIkzSzH7bvCLE4z/JRKGcroOgV8BRBa4Quf0N0pmN7KWN
 8CGCzkiH6gYlMJOl6StBWUkIjyZrXC2mIigLPxtWo2V8HZ1riv8rhlG3xMKHeZiHEFCs
 YsKxTayVjYm0fACZYPX3RLc57iiOvlPleAkhg7r4+L1BXV7aJ5j2FTedL6UcjlBbRAz+
 EszfxAkG0+AfsbbipXGyE1yuO3V5+Qwcrc+QVlPHVHM3fELRUWd2E1RZhxJnnNW7tCgs
 vVow==
X-Gm-Message-State: AOJu0YxAmfdDT7mDauMYaVw6km69iIp1cLuCbmcEl0Vm4Jt3z2GnVj+u
 L7AgjPu/oItOjPPUDGIw9VNrTZYHVTaKs+6LgAwXEMxqEJfpxIX4Un7eiXY2eamnYQ5vcXP1Jay
 I
X-Gm-Gg: ASbGnctXmPC1ZcR7aLLKfVFRZ+7Vn1Gkdzmd5TL9zt01ATDzccGJyIA5ECUuBWbC4iH
 BORJ5J9eNjeIrRLqkjzmREv/SxHYJbduzIpCtqcD8MMvpXh8jktImaw5zVI2MH/f3hXonT3YvpF
 /2MRL2LUC5iSWGKkEPQus/HW7RAqnNElK/vSxjDO33AXBuOAJkrwEo1XMkxaM4ZOtACSJ7NlT8o
 B/htSSjbEs0Z1MB5nYNvCw89MeIMysyod9lru2aFUXZ08Z5Rvf+Yzy9Qc/SVSr4HBMWXW2Zku6o
 aTPeotIjxeeY1Hm8x5GkyUmEMTv6lF6p0uOlzSkisfykbTcdYtXUC0Nkhr5aILZQn/LE
X-Google-Smtp-Source: AGHT+IGZSf4pX2QPKizUBLNbCJFg09aVkd/iILt0NWlmMbzfXQhJK6pjxP7hSYiODrmA7fnbFAHpuw==
X-Received: by 2002:a05:6a00:124f:b0:732:5935:c219 with SMTP id
 d2e1a72fcca58-7326177d652mr7433581b3a.3.1739646364942; 
 Sat, 15 Feb 2025 11:06:04 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v7 11/16] bus/uacce: remove memset before free
Date: Sat, 15 Feb 2025 11:04:39 -0800
Message-ID: <20250215190544.988310-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

