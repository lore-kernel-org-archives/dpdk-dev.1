Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F8D2CE0B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 02:31:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F8FB40B9F;
	Fri,  5 Dec 2025 03:30:08 +0100 (CET)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 97D5A40A87
 for <dev@dpdk.org>; Fri,  5 Dec 2025 03:30:04 +0100 (CET)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-4eda6a8cc12so16209351cf.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 18:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764901804;
 x=1765506604; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=M/r5/ocLxWNQqz4DPjTQwJWaW2GtZuriySs51xf7u+UrYbFxUrRcukk1AOeVTi1870
 0xjx6FOMptkd82AY+SwnKj2qzZ0r0XwCOjPVGQx6RK+S6zjIX7L0H0lx5v5y/IGJmUOV
 ra1OZHMKjTBpH2cQmvixxaQDiAaBuBsK1U5pRI7Gd20ds0pRcgPt3OaNXMUMNDlYgHT1
 nOYMOcNb3ulZ/xuoMjy4JBMIO5wVlRYW7VMOM3xnq0hxiRZSPAMDO0JmTmz3LDKHVrvF
 ePb1Ap16PSNlzBTTrP13n9s1op8F466cfLQFsDzECEkk2yE1+5HMpfTYsmc9XB1iFDfH
 QgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764901804; x=1765506604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FxsF3XY0l0IbGwp44EoJybmMHW80EKZOrZApeykoPeU=;
 b=Du+zIrOj4ldUHkTVmUI0wS9nyOvtaJsm01ebyn/S9EMy8QCpGaWzEiI1JvZ7LAmxq5
 tGRsYUg0i0M7lfATU/chkZfB/PoJJ9fo+ipvHLUxGYznSnJWhSipyQlfU5W5Tm1QvsDq
 fqfuqnMBKG8/q+4KoRspYfNWB8ImtCTYWWGIrj4zLzCtDZnYDP/jYAyix8l7w/sxqAU3
 W9HAGjjJberD6w9dquXyp4hzuSPt2NAZ881qKvK1vtUmjz7afLN7nUSrhyDhSZl1sRpM
 Nv3vILwOzvB1QYJA85d3Mg507weJULsCby46zK4XcL7mYAIDcjb0FegNhdnM/hBQDu0m
 wS6w==
X-Gm-Message-State: AOJu0YyDie1L1bwUMO4Ycr602sJL9yPlvH+v/0pYp9DmK4HZEix40Jsu
 thf61EQOITWVP5eRQrroCbxc3tqPEQp96qiRhnPH7p+Nsd2sPKPAOhtDalRfSxKZiPflq4ab7kF
 6Gi0B
X-Gm-Gg: ASbGncuoR3X0o7cFt612VSV4lqFMoOkN9aNfAqfqXE9jYPw8R0j9MkRahPCV6Boy7Y6
 Wz+sfC/KafH6LCTXkabOL78tXeo9BXT3v/i9WmPx544LS1PfS6khcM1gRO6gb5wTWJSRlyVrBuP
 qnff4LHwfyeB+Ws82d0BjwBHC4AURBoXCyf4w+riw9Qq9jGWG5QRTjdWp3sapM8lB/9HuZ4FRHS
 IYb5I5P1nzsl5Tn1WE37FHoWnFQ2CNmS4duRvYZRqxh0dDghQjbWRpKIz7eecHkE8Pb0M1b+piE
 hjo78E372XtQhdiobnBsqUEU/54MozXMXkdXJ4C2KUTOWnNRoTQQbuH5oxNdHiyV/i8dZaiyy0a
 PvD0DWhAZ7PoPj42R8G1n5vJOphgcrUImYPL5sFyCpEhkl8rQdDvrjN1uEGV4f5CAhvLoxfuCNT
 Q+w/qmPPmtygfsz64eXABxJLvoTmB/GEerW8yz7+NBkjBVS6G2Mw==
X-Google-Smtp-Source: AGHT+IHeAHWLFTHFnDslFnO8S8xpczEiIiYsfb2l0DY5CTCPwHpBoROJKed9sefFS7lv7Dh9mFpmnw==
X-Received: by 2002:ac8:5906:0:b0:4ee:191e:ade2 with SMTP id
 d75a77b69052e-4f017656800mr123531961cf.67.1764901803563; 
 Thu, 04 Dec 2025 18:30:03 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f02b7bd0b4sm15655861cf.22.2025.12.04.18.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 18:30:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 11/14] eal: add check for sysfs path overflow
Date: Thu,  4 Dec 2025 18:28:20 -0800
Message-ID: <20251205022948.327743-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205022948.327743-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251205022948.327743-1-stephen@networkplumber.org>
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

Shouldn't happen but in theory sysfs socket could overflow.
Add a check for it.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_hugepage_info.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage_info.c
index 7161b1a2fb..fe3351259e 100644
--- a/lib/eal/linux/eal_hugepage_info.c
+++ b/lib/eal/linux/eal_hugepage_info.c
@@ -150,8 +150,12 @@ get_num_hugepages_on_node(const char *subdir, unsigned int socket, size_t sz)
 		return 0;
 	}
 
-	snprintf(path, sizeof(path), "%s/%s/%s",
+	if (snprintf(path, sizeof(path), "%s/%s/%s", socketpath, subdir, nr_hp_file) >= PATH_MAX) {
+		EAL_LOG(NOTICE, "Socket path %s/%s/%s is truncated",
 			socketpath, subdir, nr_hp_file);
+		return 0;
+	}
+
 	if (eal_parse_sysfs_value(path, &num_pages) < 0)
 		return 0;
 
-- 
2.51.0

