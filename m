Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33460CCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CFF840299;
	Tue,  4 Nov 2025 19:09:32 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 3317440269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:31 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-33067909400so4185385a91.2
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279770;
 x=1762884570; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtF8rR2TprqTamiQ/bZ9PB7xcVGrWFnZfOfLBqzaqVY=;
 b=1+3ak27Z7/KSXqmxCziwIOopzSf9PKigw1PVAlDrHwkjLGLGc+pEdie50KydfLxr0W
 INhZoOYbFQQmCG3WHZwpX5wVAstJw3jR7L/yuOe1RbmobN/Jv/eKb+RLw5Gb0aLD9IsU
 G3F2bNWXaQEhAnPlkp56wqD6pd4eGAN1jMdM6b0ieK2Qm2RhF74X272tl1hmEPLX5E2b
 6k9fr1zxXMIWz6todsvJinTwXhOm24fYEI7ZDA3gdGX8yPhJRwjwM9XZBDv5C+PtL90n
 Yb6BlLH+Ivk3p17QniDfRwQr9wbcbZ2Vn//HnGMT2Mm9iijVi0zGqqF3V9q2ao61ftC8
 dvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279770; x=1762884570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtF8rR2TprqTamiQ/bZ9PB7xcVGrWFnZfOfLBqzaqVY=;
 b=nzrj0oqQbr26jZYQaARDmt7qAyKLAaRMZpB149DOabH4cf/6NN6t+o9ljvHEL1QpvJ
 4Sn5cBS+7UyvJOS/1GcuBnFBfaNkZvqxRb29RJsMjW8ogDAGvUpSe4LokmivFsY1KJyN
 7HUFLgsHxj4jj7T8IWerb/gqKPHzlWpZoZBazCPzHsqcq1HTCPMXK/+zNtCVQgzCttIl
 xgAcycBr42NL9SHP/HGDfiwVzYyJgjdCi+dqtthFeR6GAP04D8uL2ZiePC8neLdD8twM
 geVujmzRLIoZQnJSo7ZIXW/DZxLaRWYaWGGESbeUYJDXU/6T7hz94y9fd/3ZoighdlZY
 ejcQ==
X-Gm-Message-State: AOJu0YxRxqiSkefpPtAbSuI415MZ0SJCDQIH5Ge+VmcAWUp/VM3nK6dL
 cAJ2EjoYTxAFK8LPzbZJzQllDvisjc5E9A9hUQG5jMrYQILFVwFiiOpyhhFssEMpJ9KFQpGiRW6
 JxhPX
X-Gm-Gg: ASbGncsPTxgAIJZcyGIOIWUHnOqRqRYy8Lq5F/yUujr+ymGMnJrH+QSgfc7sYeuTQOX
 9A0F9/bEedq4y2CUMpUdk14jd7fcXyaxp4huAj4C0YgMB91VARUsZsGrMJ+UA6D+34NgtFBftzl
 YUTNhjBta0d8D0bobpZmfWABKY6QZa5RDN0SuRyOCLLkRSulTxXMSq7qvFnGHdqxe9lyLhl9W7T
 bvDqusOtbNxRxpJm5DCyzQ5FcSLPMKA5MuKrmaVEHLltlTCBlHRe0SmWIywo14k9wY4o46Kkh9T
 RARZoiRKgHQSHtkEH0E7ZzYIjoC8UMPaHTov6QG276VJTVn4rmIkwtFgl3pXm81yTTljW7UYoQx
 vDmz6x7UkzaL+DYFsUEokLD9nKU0VkEJQ0y9c+rqh4ByDyrcHoZ2I0nhqrkSQk4V7cnhfltYJoy
 WgnDMRBlcekpr8T43vqU0wXoMGFRI+bEsKxZfsFUQ=
X-Google-Smtp-Source: AGHT+IGthieQQUDeinNuQ3d2aJ773cD0svVXRMTTQczZogni0ALAI9Rak+prH9ZkzhRC2TR3wbDeEA==
X-Received: by 2002:a17:903:19ee:b0:295:9cb5:ae12 with SMTP id
 d9443c01a7336-2962ad3d5c2mr6386775ad.25.1762279769926; 
 Tue, 04 Nov 2025 10:09:29 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:29 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 0/8] packet capture bugfixes and secondary support
Date: Tue,  4 Nov 2025 10:07:04 -0800
Message-ID: <20251104180927.403355-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250811213632.16023-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
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

This patch series addresses the problem of packet capture when
the secondary process is sending/receiving by using the same
mechanism as hot plug.  It also fixes some bugs on shutdown
of dumpcap (and pdump).

The documentation has been updated and improved as well.

v6 - reduce amount of changes when replacing VLA

v5 - fix signed/unsigned mismatch in RTE_MIN

Stephen Hemminger (8):
  dumpcap: handle primary process exit
  pdump: handle primary process exit
  pdump: fix races in callbacks
  dumpcap: handle pdump requests from primary
  pdump: handle pdump requests from primary
  pdump: forward callback enable to secondary
  pdump: remove use of VLA
  doc: update documentation on pdump library

 app/dumpcap/main.c                           |  14 +
 app/pdump/main.c                             |  16 +-
 doc/guides/prog_guide/img/pdump_overview.svg | 135 +++++++++
 doc/guides/prog_guide/pdump_lib.rst          | 183 ++++++-----
 doc/guides/rel_notes/release_25_11.rst       |   5 +
 lib/pdump/meson.build                        |   2 -
 lib/pdump/rte_pdump.c                        | 303 ++++++++++++++++---
 7 files changed, 544 insertions(+), 114 deletions(-)
 create mode 100644 doc/guides/prog_guide/img/pdump_overview.svg

-- 
2.51.0

