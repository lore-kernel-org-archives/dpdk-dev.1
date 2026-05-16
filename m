Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB38CD4F21
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 May 2026 12:54:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32A9440289;
	Sun, 17 May 2026 14:54:16 +0200 (CEST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53]) by mails.dpdk.org (Postfix) with ESMTP id 630A34026C
 for <dev@dpdk.org>; Sat, 16 May 2026 13:08:31 +0200 (CEST)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a8704dc3a8so851223e87.3
 for <dev@dpdk.org>; Sat, 16 May 2026 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778929710; x=1779534510; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Slk8MaO574tUlwfUGs0VySqHJ5AlRpalOCUnFP6SXgk=;
 b=liuGJaTmzuYSaLR0wslZwBlnOXIlRtuu27RHEOt7h+/DX8M/m3Li8gvL4OGlBkG+zh
 lD12YHFJTBeLMp8HGPKGNVcKYfJASIrKtnFhfGiftuie/9XeorTMMcGom5faKv0eiAZu
 86hc6hWvn2bUnIIojVUDQMU7AaMyNz8dOzwqRCRjxYUDiLCRYr7uLrX4z7fn1WnrSkv1
 hNiZzPGpyD5hJM3dqYj8bLs4S+ALWMJA3/wxxuLsaygvVKi3zaqyrhG0xlrv5GiNvOeF
 yiC1mh3bGUdAWKmcmD/Bsoqaa5jnpqy4tXQrbE7ixbo7TRZwwE79qlpPRnrgO4UgyGrS
 fIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778929710; x=1779534510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Slk8MaO574tUlwfUGs0VySqHJ5AlRpalOCUnFP6SXgk=;
 b=JLBR+sRODiMwduAapRKq3PZ69S+YhABdqtejpJ0rzidLKHuq6o0eVHNSccPXuduHVr
 BZVB8OeW7BSDScyAIXagokqTVJ/XdS8XUw9fF/7CTPqDLNVf2vVV9cCfeqABJpt0yXuQ
 fd8WFdckJjZ/SKplncvwEJrgdNBYfeS3IUcrbWvHo1Q0NxezfnSpKVBoBPamBGXv+gi0
 oWrhKP63lgPoozgF5ou6S2m+g9gWU+6x1I32z7VC4mjB8kLCKsKAt8cW6uh2NebbNqvi
 zZSOrcAVxevzQypPy6HxsE1FI/vmAP1Tov91+qo8IEKumS9yghP2VdmXQtjs7rVTPms9
 6gFA==
X-Gm-Message-State: AOJu0YzyX3cdGdYH4n5sOhF5cuT49Km+mIgdCH9WCWf28pfHJEPBYBAm
 syFHSXbGFLoizoCkdHQ1sJYBjz9B+LdI3DCB+ITKhF8tl0QbSR1um7Xibhb+uQ==
X-Gm-Gg: Acq92OEWnQNHtSoxFM5/d/CHq3WIZenIyCe7RgkvVxqMLY7CBaqnmKW0CcajtDXEjOU
 Hc6mY1lNYro797NVAFVsUXt0kvgSfKibxc+yoDLd7lSqdGSHjzq42rFwV8pmhInSUqJise+Sake
 44G0r8QKeEz5o1CTeD87mDF2+PKMB3uuVqx0OBqSZxaR6qmj18jKp3h1HZCvgfPN1qznYNPvW+6
 CrYiNMSiikTWgBaotwnhaAEi2Sa4A3mIrJGcj27dhf3RgaOnAYfVPqSRG1k+IXVpq2zftvetfa7
 ZRmkWhHwE5EAOY2sicbcbUMmCeC0jUr1K7ixtKemwHHF/kDfM35V27eySV2CKzTur1Zw56yI5u2
 28KTuqog1xtQvi5n76PTPLClOyzX6ppfbtAc3XW1Q8kpshqVGXjZXB6mAKfvHposFG+MfADwG9e
 Swf1IJ73cqkofLIA+o/I7f79CTQnh6DGYBfzYXuKNS3b0awvrjnM//O1i+815iBffFbbM=
X-Received: by 2002:a05:6512:131e:b0:5a8:881c:890c with SMTP id
 2adb3069b0e04-5aa0e73d3e7mr2220185e87.11.1778929710287; 
 Sat, 16 May 2026 04:08:30 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc518sm1954416e87.39.2026.05.16.04.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 04:08:29 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	stable@dpdk.org
Subject: [PATCH v2 0/2] dpaa2: fix error propagation in remove path
Date: Sat, 16 May 2026 14:08:26 +0300
Message-ID: <20260516110828.35701-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 17 May 2026 14:54:15 +0200
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

This series fixes two bugs in the dpaa2/fslmc device removal path where
error codes were silently discarded, making it impossible for callers to
detect removal failures.

Patch 1 fixes fslmc_bus_unplug() to capture and propagate the return
value of drv->remove() instead of ignoring it.

Patch 2 fixes dpaa2_qdma_remove() to return the actual error code from
rte_dma_pmd_release() instead of unconditionally returning 0.

v2:
 - bus/fslmc: use 'if (ret != 0)' style per DPDK coding standard

Md Shofiqul Islam (2):
  bus/fslmc: fix ignored return value in fslmc_bus_unplug
  dma/dpaa2: fix dpaa2_qdma_remove always returning success

 drivers/bus/fslmc/fslmc_bus.c  | 4 +++-
 drivers/dma/dpaa2/dpaa2_qdma.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.51.1
