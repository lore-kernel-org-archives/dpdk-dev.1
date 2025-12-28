Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4917E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:17:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D144A402ED;
	Sun, 28 Dec 2025 21:17:00 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 454EB402F0
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:16:58 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so64568035e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953018;
 x=1767557818; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJBFtLCENhEKaunw8m2+fsDlyNfoVZgcNlb4tXSOROI=;
 b=GUgaJcYgATKoOOuoK1uQsmP3M3MPwE9BpD/1Tkj89oRRGzEQ4zIY/yvuzlgzxnGjGw
 Rp7IT2haOsdaAZ7NHhzm0tq/ErgBjqERhj9D9RX+82KnuMPhsl3DjlRYIVLSxLm4Jsx+
 LqwcSi5OBnN4Zfwg5Nnw2lASxyTIWzzVlTHD7UVipTyoEdJ7fGM3NvYB15sIKdC6z6yl
 oUMWdIBGxUh0mDjVRBpntAQu8szoJ+O6qlDF+k2bspWbdZjC+YVQ9/3Sog3gLKTMRTdQ
 FLuY9DCeNYRZ609wdqJV1we1HQKSzjLvwTVUU8ToHCaKl0Ntn3bC2dwB77nVrIYmi01k
 85VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953018; x=1767557818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rJBFtLCENhEKaunw8m2+fsDlyNfoVZgcNlb4tXSOROI=;
 b=N30e1SUBfbc1b2UJIkXwKMTNzm6rkwceiwg2XdPTKUqboI2LonDhIG1TFZ2a43y2HO
 VDJ6E/QjM8sGx5LVvg2By21LcXfBjBfJVpn7ykmHhoCzY18JlHFTm1BCm6uIj98qcpp7
 CBmJ6SMgjV40+wZEkPmQFqG3wt9awxjJMAnMWe5W6W85yxizlmjKAMg5q3AbUooCs6py
 p+JSeXtghrdPnBobsVIM0w1sHEKouUCkcHTqjHhtyFzBZXMgA0LTOxpUx4DZHNPxd2tn
 q2OwFw+VMfNtfjee/kNw1YNk071MwlbsLqB2W0jHynTBuZ/++w0QJATvUL5Q5KRW7Oge
 scdw==
X-Gm-Message-State: AOJu0YyseZSWoWhImnlNma+Lw5l0GQKCjUuEcG5neoiAkeLD4YjacBO3
 0T1KAY3Mv8iwLA/STTW4Zkss4BmaWd3x3CHTmci3lZTEm8Z3KlKz961DECCc7vH+I1s2QKgaekK
 hgf87b6I=
X-Gm-Gg: AY/fxX7kKhd1L+2o81Pefl4b5wnrEUE8zd414S9pBnyPFdQnApQj3V6uxmk5AVRetGp
 WfThvd+kUlGXM/ULxyXjvM3dB/jewc6rHxtpVcQaLTSG/r2cr7OHY2cg0BMsGOmZ70JTzw1bTb9
 E42t4SLnmm/WCp/8K6i1J083nv3xZMg0xaEfnV4ahPGxxaWsGmvfnkn/XkkVN9Ke8c6IWaP3Wgg
 1SZ0ySi/+xKztE0lAVsrnRRYp2yUFK4VeHTu5E7oUx+EIl4znuQK8iDH+93t8eDHsnLYqpmnm0f
 nU9XF7S64wtbaSuc9lx2BehDLG1H0G2B0RyOBJ6pwIAnwsS3hDYXrXDH9PiQutFRPAoRvvViWtM
 Q+rYd9uiObSHMW/3lax/WVwdCf3EjR5rXS7+dcIpTMZ9yPCrnoZdW00kFZMSX6fCstZ+N/W7iBq
 wK/H72QKd5rfPM86MgAIAKmLx8fhA5TTgxzsFxTIl7VO5oNw6ioQ==
X-Google-Smtp-Source: AGHT+IFzuK0WvqBbwhmfJ962R2AFOtkMyGMgK95zGIe9PJ8klk/D5G8AkRYhGccAnuR0faRBQ+nOQg==
X-Received: by 2002:a05:600c:348b:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-47d276f8aeemr276169375e9.3.1766953017808; 
 Sun, 28 Dec 2025 12:16:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a6c9d4sm226286005e9.3.2025.12.28.12.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:16:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 2/4] bus/dpaa: replace perror with log
Date: Sun, 28 Dec 2025 12:10:51 -0800
Message-ID: <20251228201649.555898-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201649.555898-1-stephen@networkplumber.org>
References: <20251228201649.555898-1-stephen@networkplumber.org>
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

Use existing logging instead of calling perror.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/dpaa/base/qbman/process.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/process.c b/drivers/bus/dpaa/base/qbman/process.c
index 2d805c5bd9..77362cd6e5 100644
--- a/drivers/bus/dpaa/base/qbman/process.c
+++ b/drivers/bus/dpaa/base/qbman/process.c
@@ -142,7 +142,7 @@ int process_portal_map(struct dpaa_ioctl_portal_map *params)
 
 	ret = ioctl(fd, DPAA_IOCTL_PORTAL_MAP, params);
 	if (ret) {
-		perror("ioctl(DPAA_IOCTL_PORTAL_MAP)");
+		DPAA_BUS_ERR("Failed ioctl DPAA_IOCTL_PORTAL_MAP: %s", strerror(errno));
 		return ret;
 	}
 	return 0;
@@ -157,7 +157,7 @@ int process_portal_unmap(struct dpaa_portal_map *map)
 
 	ret = ioctl(fd, DPAA_IOCTL_PORTAL_UNMAP, map);
 	if (ret) {
-		perror("ioctl(DPAA_IOCTL_PORTAL_UNMAP)");
+		DPAA_BUS_ERR("Failed ioctl DPAA_IOCTL_PORTAL_UNMAP: %s", strerror(errno));
 		return ret;
 	}
 	return 0;
@@ -215,7 +215,7 @@ static int process_portal_allocate(struct dpaa_ioctl_raw_portal *portal)
 
 	ret = ioctl(fd, DPAA_IOCTL_ALLOC_RAW_PORTAL, portal);
 	if (ret) {
-		perror("ioctl(DPAA_IOCTL_ALLOC_RAW_PORTAL)");
+		DPAA_BUS_ERR("Failed ioctl DPAA_IOCTL_ALLOC_RAW_PORTAL: %s", strerror(errno));
 		return ret;
 	}
 	return 0;
@@ -230,7 +230,7 @@ static int process_portal_free(struct dpaa_ioctl_raw_portal *portal)
 
 	ret = ioctl(fd, DPAA_IOCTL_FREE_RAW_PORTAL, portal);
 	if (ret) {
-		perror("ioctl(DPAA_IOCTL_FREE_RAW_PORTAL)");
+		DPAA_BUS_ERR("Failed ioctl DPAA_IOCTL_FREE_RAW_PORTAL: %s", strerror(errno));
 		return ret;
 	}
 	return 0;
-- 
2.51.0

