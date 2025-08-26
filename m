Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4372CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 14:49:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30631402D4;
	Tue, 26 Aug 2025 16:49:30 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id DA1D0402AE
 for <dev@dpdk.org>; Tue, 26 Aug 2025 16:49:28 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso30986025e9.1
 for <dev@dpdk.org>; Tue, 26 Aug 2025 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756219768;
 x=1756824568; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRCh+gvgG/tzcDrAs3TkFkqn9B2bSp3Jx2geNZ49des=;
 b=v3Vo3ePtByXu8tTHdPgZrVl5d56o3xZVsfv/3/seHywrTmr0eflOqzICzrVyDt1WYX
 SEycgykLwoEQ4QNJLKRqdiXcfuXJl31nqtAVzHYOgxIHQoJHvJI1nIl1ZE0xCeenj3zp
 nPuIdTRxC6ZeuKs02zckDo/SzB+aHHD5VJ5uI3dOEg7eHmbOMnLXFr4kI5RPE/avu/EE
 urFYuoNvREdRuuE8UUZN5MOLoL7WarqEwF6/qy5FKKvOEVLjp1cFgshAiylSQSVlVsRC
 45StjcaWO843jITaRIEtJVP3I85WjBAzsDd0LN9jL80Y/ilz99H2J0g7haAZTHpHxQew
 etuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219768; x=1756824568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRCh+gvgG/tzcDrAs3TkFkqn9B2bSp3Jx2geNZ49des=;
 b=bSWwfWLAly4aDYZGERX10dukNX3vFJ4uaJ33CUXaD+i+ZBBWdVLMQtpapAfUyRYQYl
 1zw+eJ+mBp24vemZcEuRFII6klCGKspTEghLCdNGooTskeeW+KKSMon+UqtSFVW/ujbO
 ubwubuoLVNLN+1fSmsLdyIiZ51MaIVDhVcLrm0YQyLQzEUW9jla2flhVnaqRMH/+9I9A
 xeTqKvc0YictfSKb2x76frNkWjJwZUDSr2o3u/7rs4ZsSaEdd8PAffYHVZO8lQvCbkXq
 a6Gzz7Tcl26F/YSzOJm+RyiHpDArqLcbzIl0d0XQbVB1PcKH0bZPir2hMvV7O7HlYecS
 mfaA==
X-Gm-Message-State: AOJu0YxaqajUEJ8vShi/qvvsYoLOebsSj5V3/q5eEUoSWPglz1ESuyen
 aTINP21bxO4msQlDBkPxMb09yayUGiXBeLv8jQG1jR9JXrtz1hFlt53MNciwjTYZnO7GFptJNHo
 42cqM
X-Gm-Gg: ASbGnctxCS4+vIYpQP1TQ0D0KpuuuH468m8GI8nAnMp5PDVi/qRRgaNF6w6Ttf2V5PB
 7Zd/K6NyaaiqScdmYuuu/1k3TgmVl+1xS80XUFuFV2yN2IXACEJDs7My1ka/6kifCwng0/A/p0B
 ic5F9VTCIufZdKnLznvzgOgJvJqiMafOuzro+VhkTeS+acauSjvHsMAHkTHxuWbcRlFbWTlIKDt
 izEIgGvsQEas+LwW0rJNDRQxsxTG1MnJcSSZCfhS/xjpD72DrS7rW/ZBF+tn9A33HqFQOPszQaT
 w1R2ngQ3w0giDEXvQXj5UwcTIT/Hmpxy5Pab31l0zJi+gjiGeG9577oXhkgDwGbNm7h5qypQH31
 YiUv1RBls3UIeRGCF9LYdd8ISwUQdu1fc46woApJKx9xOzAfoebhiFQzkbPWc2bOmmBWnVEZD
X-Google-Smtp-Source: AGHT+IFPePkbFw0svxS8NekJO6FvwhQHX/5Ytkgw51uMpqM8j0clJzseJ4PxQ+KDj9/Wi3xpHoZp2A==
X-Received: by 2002:a05:600c:45c8:b0:45b:627a:60d8 with SMTP id
 5b1f17b1804b1-45b627a62f1mr56887155e9.10.1756219766710; 
 Tue, 26 Aug 2025 07:49:26 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492459sm154566785e9.18.2025.08.26.07.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 07:49:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 0/4] Cuckoo hash cleanup and optimizations
Date: Tue, 26 Aug 2025 07:48:27 -0700
Message-ID: <20250826144922.74010-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Recent discussion around handling small keys motivated furthur
examination of the compare logic.

Stephen Hemminger (4):
  hash: move table of hash compare functions out of header
  hash: use static_assert
  hash: reduce architecture special cases
  hash: add support for common small key sizes

v3 - review feedback

 app/test/test_hash.c       |   4 +-
 lib/hash/rte_cmp_arm64.h   |  56 +--------
 lib/hash/rte_cmp_generic.h |  35 ++++++
 lib/hash/rte_cmp_x86.h     |  60 +---------
 lib/hash/rte_cuckoo_hash.c | 238 +++++++++++++++++++++++++++++++++++--
 lib/hash/rte_cuckoo_hash.h |  84 +------------
 6 files changed, 275 insertions(+), 202 deletions(-)
 create mode 100644 lib/hash/rte_cmp_generic.h

-- 
2.47.2

