Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB7C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 17:23:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21B9F4114B;
	Thu, 13 Mar 2025 18:23:20 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1003241141
 for <dev@dpdk.org>; Thu, 13 Mar 2025 18:23:18 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2239aa5da08so25951985ad.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741886597;
 x=1742491397; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1XwWgM7tejlnXeOHdbgpL1yf9QYCw7hYaXWbABqWnzg=;
 b=g33sPAljb4PLCqxDaE0jZaMlcKQGc7cCSZmi2k/0hkXdOIIF6zBoBWPvfyWvrzRien
 fIHLKuB0rD+GfA5h/+Pri+K+Sk+2KbCtwTwPH3tLsT3ksfVGMxolK+ex0uHSRVARiGi+
 C3I7NdBdRPdAfPBfnEFq8e7SUFSmQcj+Ph1Mv5Rr6RSb6iFVTcag+PE2ZW/ON21C/f6n
 BeulUU5/I0faTetF4z2ETQIVy8xHjHYR3304MjQ2Tm5oS6qv+iUTqIHymcybH2Tk72es
 5Vzcq3LmiKXlcEI+FDx5xQpd7jB/UnzliDNxwQiQS1GxJf7Xj5Zd2aVs89RWyV6VMMBY
 ZO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886597; x=1742491397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1XwWgM7tejlnXeOHdbgpL1yf9QYCw7hYaXWbABqWnzg=;
 b=QR0QVlMvkt6JayDVUrzE/3PNUwJ2voJIiD4Eg/j4TeAvB+s6fq2LRi7MP28rcA8XmQ
 fvXvpCxsozcGicNYkdYpS/T57IULjYe4G4oCIdbOc9XiYfBEyAI04BPjR4iKxJY5Co7Z
 c+P1REF9EOCXVSZ8I/mafKzh8FqP/pUJ5iy5mnlzJKgePh2F0La9W+ATLjWLLaFJdPBR
 VFwiRTpTIj9LQAqfpTo37J+LtMwr0iFqslXcXeulZIJWebQAv3Y0OjHkgcLngY6JHnPs
 IEwRUU3dgdv9iS0ke9YARmD1Sf5FQMv2MgJ5sAtzusaQg+qzmEXjeoCDpZv4Twa73zP8
 3dog==
X-Gm-Message-State: AOJu0YwzJP3S3LP4swP3wp5U9FBe+KBDr0D/3Lw7xZILXlgbVLXDGBlZ
 robCdtBG1bxfL2AdDe8CWXGPU+Yc6YSXg1zZUqp52+Ye4gVrhE9/XyCKrlRcpk3/A6tDkkeLuI0
 I
X-Gm-Gg: ASbGncthV1q+TJoZ9x2TB6+GISBe3cUC88xYEuwHDc97s7v2wW8AFrrpO3JDdLk7Jfb
 tgNuaYRcLAwEF3VKOdWhYZfs8rcELm73qIYWfBI+h+dPIJ3ftNqVRu3tySKbimgCXV6aF6Jk6cW
 BC40DUWd9NRvnG3o4fiZ/pGuXKezXWrjhCbfYOOssvgZ5C1aDOEHQdmYjXfTycUoffx1T7mGhOO
 5k2r0eD5N4O7utwpRWApYIHa9jaUVTdY3Ze2rkuAhAX+HcQjdOS90VowWGJycdh00d20dWT3Ikm
 hOtJnxisCWn1qhUTmTHrO4TlGfkAgNFO41ikI0UPsIeowxRap5+j/p92hk2SZkDSINHAUf1dOJd
 7rq/EzuGcIMxwAbaiLWNJ3w==
X-Google-Smtp-Source: AGHT+IH3M3a1sXl3VAnasomLm9lBVK0FrGYmMGLeYAETqlO4KCFMgz6s3GLOiHsOYuscAk4JmiyHTw==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id
 d9443c01a7336-225dd84bd49mr4042015ad.2.1741886597099; 
 Thu, 13 Mar 2025 10:23:17 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6c5csm15867995ad.124.2025.03.13.10.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:23:16 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/2] fix use after free
Date: Thu, 13 Mar 2025 10:22:02 -0700
Message-ID: <20250313172307.274109-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

These are bug fixes reported by PVS studio.
Later patches can consolidate the FOREACH_SAFE macros,
but these patches are intended to fix the current bugs
in main and stable branches.

Stephen Hemminger (2):
  net/qede: fix use after free
  bus/fslmc: fix use after free

 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c | 10 +++++++++-
 drivers/net/qede/qede_filter.c           | 20 ++++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.47.2

