Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC13CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2685C42F79;
	Thu,  1 Oct 2026 00:44:28 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id D4EDA42F5B
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:44:26 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso2715299a91.3
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808266;
 x=1791413066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yU8LJ/ORSU+mIbPHWDoHNJh0jjlgqlfFZUk30xK1pcE=;
 b=jBZPnS+HA7BXLrkvLyE6zOqVioDDV9lK1/tUXSVGs72lKuRXBBh0zrBnvmeJU1khhj
 /+mqhfAZD/eJYTXh2TNG4l8Bx/pHxqQjMMFe3yYK5lLXWbz6DlnZ8tuRCOtItZ9KFVnG
 mEJOaSi3LE8u4+Wcxi+fmfLR3ejdrgNULQAnCzsmU+rqVabBdZPyNrTyFPmORQ3W2/oX
 Yh3S6ZGoOM8PQExJt0LYwvKNAZxtszueDs9lTbyrmcNNdSKeF7X/7nAh2uEtZdQnjAid
 a8LwsxSPwqAQyzPwj9AqElRe/kszFc4Io3/ljf5Rx3LVgJaRxKEtELKzqcEoDpiQxaLq
 KVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808266; x=1791413066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yU8LJ/ORSU+mIbPHWDoHNJh0jjlgqlfFZUk30xK1pcE=;
 b=CsacnkKYJLbh6mu8CZeEi35hMgFEs5/19CaANFkQe4fabQ7yySQXiL/GSGS/E9Nq3u
 RWQD54UoIN3KYaNrsMXYYXdfFUQ9Hrku5W7A6yIgLlnbkPJRCMd+mf1wU7TR340HV19j
 RVU2rXpbpiWfQckRV+kM8bZ/SgVcSIDe8U9YynlUSiDaqCDHNGgqGYsR3h1unvVqeC49
 am0fjFLb3lrRIa9vtVS0foM+sBGnf4MFeDiko0Ex0vPAu0GHJUYtEJ2QCLQbA0no5fYv
 Y9oQc0NFEVj5E3q9T+iBEV4vUIljKJGB1C4llnKmqdJiHQo9dk3nPKwKH3oQO+jqxXJF
 uHWA==
X-Gm-Message-State: AFq9FYIBYezQ4YWVRPvzXDiYzI7X0z7wmYi/kl6oDDY90YtErNKpsj11
 vi5+EM5G9N8LXpbY7ks9GP2d3AnQEt4RvibJeRpn7WQwSBYvkkQqrek3jw/a4Q+j4KyeXO8Dra4
 PtEmK
X-Gm-Gg: AYBFou1PRof52Ob9pfaRlXg25E45DqfzEw2rStQpkYV/O+4WAilaEP1GGapS/bu2fBF
 1KfWnHgTIPmEt7aDTfq9pZeq98goErwul0AqOMtM8W+Kb5abAn8Q86jmUX2BkOkiIalNRfIYPyU
 cDkg1aF6Sd7W1B8ncC6DVLjqzFmyvyQHextEHGDNDvIfkcW0gIruH7EBZ8O3shMySyhe8oISS9m
 1mw/W3LW1I/craEgPNCWflP0PrzDricMM3oFhRoK/3QPPya7qnW8Fr6gh1XhrgVKg7OjgaEstCY
 fWashSZEx5RN7D8/7RnJuPpFdSWju5FnOvlkfNQ8lZLEDXfwtA11QXmKpK1LK1OUCyj0w2G1v+4
 laP7PKEYOeqWZxWKGWxx5u/ycbpQJ4D0jsHM9J6HyVrO8yfbif5JGZZaQbCShz7yZqhRFMtF+qa
 LEx9XtnznQxXa3pVjodISN83iQ2BtuZJ6OVX8RAPqWPET3CWfDqRWHs49lrRyxStcqqX8Va8YxN
 +WGxPfhsrjPOT+DFn6GPn7Pz2vzBMzn3Ch/Ag==
X-Received: by 2002:a17:90b:3c89:b0:3a4:948d:9dc3 with SMTP id
 98e67ed59e1d1-3a4d197a3e1mr2428891a91.21.1790808265901; 
 Wed, 30 Sep 2026 15:44:25 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:44:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH v3 39/65] net/hns3: use kvargs numeric helpers
Date: Wed, 30 Sep 2026 15:40:57 -0700
Message-ID: <20260930224340.58580-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930224340.58580-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260930224340.58580-1-stephen@networkplumber.org>
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

hns3_parse_mbx_time_limit() checks neither errno nor the end pointer, so
a malformed value such as "abc" is taken as zero and then silently
ignored by the range test that follows.

The range test is now part of the conversion, which keeps the existing
behaviour of leaving the default in place when the value is out of
range.

The device capability mask parser is converted separately, later in this
series, since it needs the hexadecimal handler rather than a decimal one.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/hns3/hns3_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 29b51856d9..c21740ba5e 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -231,14 +231,13 @@ hns3_parse_mbx_time_limit(const char *key, const char *value, void *extra_args)
 	if (value == NULL || extra_args == NULL)
 		return 0;
 
-	val = strtoul(value, NULL, HNS3_CONVERT_TO_DECIMAL);
-
 	/*
 	 * 500ms is empirical value in process of mailbox communication. If
 	 * the delay value is set to one lower than the empirical value, mailbox
 	 * communication may fail.
 	 */
-	if (val > HNS3_MBX_DEF_TIME_LIMIT_MS && val <= UINT16_MAX)
+	if (rte_kvargs_to_uint(value, HNS3_MBX_DEF_TIME_LIMIT_MS + 1,
+			       UINT16_MAX, &val) == 0)
 		*(uint16_t *)extra_args = val;
 
 	return 0;
-- 
2.53.0

