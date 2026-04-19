Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1706BEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 854984065F;
	Sun, 19 Apr 2026 18:11:09 +0200 (CEST)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49]) by mails.dpdk.org (Postfix) with ESMTP id 296FF402EB
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:08 +0200 (CEST)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-4042905015cso1423052fac.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615067;
 x=1777219867; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=HnzZ0p4eaJRjnxAoGq0rD6mN9yA04/klnAa5Wt7TkShImg/1ypMpGsbu1fvH9/0wjE
 bN/g/wynvfiBKKUr7gOPsxugBPt2OspCs8WYNwEikDA6kAhi34L2IB7FWEn8+aHU6b5+
 9/UTe7dnEVv1aFMK4Loizd4cIhLVOwTTdWu5N0hJBeb2TnjBE/ZEF5Vl6nUY5YeIcGVo
 J34+xao9HwZ0gub/BVNZAEBzsaz4SZBhGOHlnuGTmN4lAKcGvQt75ohdkcNoBcCys9y6
 NjOmy0M55DZGq0CHFsHO+EFhyd430i6IgB1Smd7Q82wcBw4WxCUiJU9Kt9ugh5PrS7vO
 riqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615067; x=1777219867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oziFIePaGAtnlP6qcWP6qzC3ifZoFwAoS63sMQuE14=;
 b=eNI8fi5JHSmjU6uLNs9phZV7PXGPLI7uPI5HCqOT3E7wNOAmsaLeJw4aPOyVIcP/1e
 ul8DZtOc5CwuK0fsxQuIq1bdtkr6npseKzow1/gpfzu1KMON+2WnVAznzhkkb//82/fb
 jtEDfc2qy1GAqwx9+/QbikD1PnX47zTe8FJl7lhqVvUxr/rRszqup9Eu9RGlRSMZDEnw
 FLUA6eANE9tMRUtO6xKP5LhTtqYzi3JBWzsIpfQ8y+I9nBRGanT2QilswArOAJ5QY4+/
 GOGg1LZA88UKe0eMMgpsHEYvbWyKF6mC2aOXPJ3idBcFN8FpRrSiVzql7jwMOv9Ch9L9
 srJw==
X-Gm-Message-State: AOJu0Yx3yMLGLjxUTx1Ugw5VmgsDdlpOHJ4Mkuq9sEASycDUsT2BWBFG
 x4M/Zv/9CDikWnov2KUIYmPxixMlRiT/ZN//2hZidMVnz8MhOEmvgmI7Ly4qxCg7+qabDo+1yY6
 lYRgz
X-Gm-Gg: AeBDievkZotYT/kQTWEs4F1WdFvNxXExt11WOmxNMV/dNmkcQYLkAnLdu/WLIAf3GAS
 U5jIsgXpjRXbKtfY3g20uvGLjcyL8EXJ05q+zlDsGY6Djg3HHf44Pd+lD4K2dZ2x1Mne5mIcNvD
 5zH+CxQPESPzAkZTLeQjgI2p89BjftyfrybdpWlw8599W7bNQr4H0E/hgNEZWQLkGEbrAx2cvEu
 Gg7IHBbLvSMRUQAe9B+RF1HV7Uc8gaRIAjLpWsf8m0YelES7l3kHlxvO8t6Aba4ZBJ9YX5bhkHd
 3X1OWFBXCo10l8llTq5QzR5mm/gOLPVK5p+xzdpWV49ZuVvF8OiGjNz07zK1USPYXq0raY62iQM
 o5wiAe171P5PJTUYA9HvoNY9iNXZZn9nMsymwZdumSQs3+bw64CO8I/jCn/9xwbLyAmFCsklxQY
 WJaMlNWsPGdfM61ntF7Kl/X4v461tYa58PqcvuM/S4YTQ=
X-Received: by 2002:a05:6870:6390:b0:417:23f2:6d77 with SMTP id
 586e51a60fabf-42abf2ecb41mr5707592fac.16.1776615067404; 
 Sun, 19 Apr 2026 09:11:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v25 03/24] doc: update features for PCAP PMD
Date: Sun, 19 Apr 2026 09:09:36 -0700
Message-ID: <20260419161059.205954-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

The PCAP PMD supports more features that were not flagged
in the feature matrix.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/features/pcap.ini | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index 7fd22b190e..99ba3b8e1f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -4,8 +4,15 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status          = Y
+Queue start/stop     = Y
+Timestamp offload    = P
 Basic stats          = Y
+Stats per queue      = Y
 Multiprocess aware   = Y
+FreeBSD              = Y
+Linux                = Y
+Windows              = Y
 ARMv7                = Y
 ARMv8                = Y
 Power8               = Y
-- 
2.53.0

