Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E1CA0EFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 12:08:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91BAA402A2;
	Mon, 25 Aug 2025 14:08:34 +0200 (CEST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id C274B40297
 for <dev@dpdk.org>; Fri, 22 Aug 2025 13:51:21 +0200 (CEST)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-76e2e8e2d2dso1452951b3a.1
 for <dev@dpdk.org>; Fri, 22 Aug 2025 04:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wisig-com.20230601.gappssmtp.com; s=20230601; t=1755863480; x=1756468280;
 darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2QxmzSnIFy+2OzOxcXmAzAFr7Oxn59IWE4tm3/3BRpI=;
 b=dEA3yOXIv4SR+HiqVT3WMdU0B40b8J1dCw8LGVOE4ZMm9uAr0+jM0bqypDoR/juqlU
 WUPpvBIrsQcBTvIxFP6Qzddjuezy9GFQz9V/1903rSoU/AGOocaxLfMwcZPK2f3NOXaD
 pzICY87DU2boNkaRdgVIVBUp27DsFRhgCQ8AqfF4++x+i4qFPyUppFedlwPL1X1B/T5d
 RHCqukiKgJ6QQrYUG2A4NNo11rtcmNcYK4cYomTJv3VInVRxYSZWaDtXH3Ry/Xy3rX+g
 AOag4rDUNGTHY1Rz8ZJUkMGvs2ZQ/qSjP/uLPGkvFArzDJdZCPhyCRKzs2kV/G5VxfpT
 3nfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755863480; x=1756468280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QxmzSnIFy+2OzOxcXmAzAFr7Oxn59IWE4tm3/3BRpI=;
 b=voZ7ReNQaKpYk36b/TKMeSrf/KJtbOw+Owiu5LXXQKeTikVNGGcYwDqNbPAIDPFBM0
 bc+w+JnQqimKu8ur6RhBPhmYo2/aC/96Nm0/UIJlWg5AwNQl9aTx53jtNcHzISeBBBZm
 Ire68Jg3wzDlBh/ot3ULopqTDRCKP3+cprZfW7LgsJwlgkxgxVzS6sxN8VPOL0dzVVOH
 jDmxVHNQN70rnzTM13LX5gSm5cOcXwIzugha1WuEsGIQj8XO6miy45kav/85qn2J+tAe
 +UYt8KvU8eXbnbxkD8rcK5RrMbCXQqk2UwwCdpNqSb0T16YxK2Jfko8cBbgmrSQ/hbab
 oDhw==
X-Gm-Message-State: AOJu0Yzlzd5u8DQfYVmog3ZwGoawB7pqePC3GtqaPDk6VlCqy5P+jF3i
 6YZd+3xP/I2gaoOthN2Ly/VqLw7+/UNMudtmOV1iIhLyJmFSNTGj0LyJyrz1M6n7VupZ6GIU8t5
 SWXw5FQ==
X-Gm-Gg: ASbGncuAkrJB1v0eXpNyuRzRwoWciPicoz0IvwLPBiNjHpHnxeUWO401/6DEEBCO2fJ
 1RxwtXgNwmykyDmgTyYzZA37Jbx4jCLi0NZHyUaXUyIz+zFCfIyVBCCbzG3rC4bGSoC6Z9s8coa
 sEveK+1V3166IA+WUcP2hXIfzMxBBfxezSY/oP11Db18s27bvXNaO5FeV7JLBNlXy1rZB0bJVMw
 H+rrhk50g+o6xy3sFzPVC4MPTv92qXa67xKGa16yZaUdLK24zc5vRIgTZFAqebOydKl3XQcrM5X
 xbs4N9zIg9fN6hsW7TszInpxZ3R3LIUTz3llW5b5iw7R+mC7dXrwr48M36S6gyxAQYXmojSswMY
 GQbAr/um4/V6eWQ==
X-Google-Smtp-Source: AGHT+IHxo8+gOO0rQMYjkaMSBdjHVEhlyM0IF3teuVSzSk7bSpooxWl0XyhWNMAjiiNdu8p6ivK+wA==
X-Received: by 2002:a05:6a00:4614:b0:770:3dfe:89ab with SMTP id
 d2e1a72fcca58-7703dfe9d12mr35940b3a.5.1755863480424; 
 Fri, 22 Aug 2025 04:51:20 -0700 (PDT)
Received: from ash-wisig ([14.195.146.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e951da867sm6852280b3a.102.2025.08.22.04.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 04:51:20 -0700 (PDT)
From: Ashwini Sahu <ashwini@wisig.com>
To: dev@dpdk.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH] vduse: fix typo in struct vduse_iova_info comment
Date: Fri, 22 Aug 2025 17:21:11 +0530
Message-ID: <20250822115113.1313226-1-ashwini@wisig.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 Aug 2025 14:08:33 +0200
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

Fixes a typo in the kernel header comment for struct vduse_iova_info
where "IOVA region" was incorrectly repeated.

Signed-off-by: Ashwini Sahu <ashwini@wisig.com>
---
 kernel/linux/uapi/linux/vduse.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/linux/uapi/linux/vduse.h b/kernel/linux/uapi/linux/vduse.h
index 68a627d04a..10ad71aa00 100644
--- a/kernel/linux/uapi/linux/vduse.h
+++ b/kernel/linux/uapi/linux/vduse.h
@@ -237,7 +237,7 @@ struct vduse_iova_umem {
  * struct vduse_iova_info - information of one IOVA region
  * @start: start of the IOVA region
  * @last: last of the IOVA region
- * @capability: capability of the IOVA regsion
+ * @capability: capability of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
-- 
2.50.1

