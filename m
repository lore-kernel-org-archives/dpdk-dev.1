Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F719C88E67
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B96D40ED6;
	Mon, 14 Sep 2026 07:51:38 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 5CE7240BA5
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:51:36 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so1968791a12.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365095;
 x=1789969895; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yU8LJ/ORSU+mIbPHWDoHNJh0jjlgqlfFZUk30xK1pcE=;
 b=0wfFnU6yi8yQICMDaXJmbEtOii+glDdBuqKZPKlsqHO3oc6cR9zFneme1Xxt1oLIbv
 CKcwvfcrAwV7HoUs0opwrrgtkuB/zMS0tWuMzeBWuIR/TpA6Tlgx5eU1+C9jBcjIv/v0
 6q42OiY3N93lc+9VYbstKhV/1B8mlMY4+4kdPFB2rMJpWs9/qLsU+doy6sJ9wuj92kek
 tL9Bbblu1rtU/6UE9Wc4St/YoV2m37NLFKJVJsk6SaFVapt6luXei1xsylcuB1vvU93G
 tuFiFjmzxDHHJF8iJS6hIcClCyE18MS0LVYAIRgCAw9RcOSCsH3oQpouw+e6vfiK5BwW
 8Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365095; x=1789969895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yU8LJ/ORSU+mIbPHWDoHNJh0jjlgqlfFZUk30xK1pcE=;
 b=HtNfJf533pKX0BCCx9hOiN2Cz+ibbnLNLOZ3TecCQQ0SJLDvmRG6+ALa9FfYwxPwNX
 K8KpqXLIJsFD/r2A8+PVxwPAktsvuYx42dN2LmTvWpsJEjnEAi5n+RISx84/hWyn4S39
 1snCO98ZRVueqNBtn+zAoUw3Yw03fxK7Z1g5Rc/p7IFjazspQC2WNv1a9Puy6Xe+nYk2
 004tdmdmTIOVz5D++G27apDky351EyqWVn9l9ymS+v4wqZoaxySjwys7VOwbuy9J4U8G
 JD082MHDx6MOMwWFpxuS0yRdJYGojLxb41lT0SkpsbilSUIXfNGrgEdnYjEawgcmT8Xe
 W8LA==
X-Gm-Message-State: AFuF++kfpohGBIkBGDmmEkSoP1U/kJzqYr5XXnKUPVwLLaF42gefdWQb
 sa18a8315nKrFFoX49Vyqi7wC2C6a3KD1T0wgNBe8b7Ud0w/6fgpBarLhGTNusU1ASca49jRug9
 s0fAyG+w=
X-Gm-Gg: AYBFou3evCnaHJ8KLhDgacvCYOrkA2xK20GzLDqI9mZplIW2olusUhUVGXh1OqwVw5V
 0AXlftK/yJvfA90e8thuWP4+H2Rp2fVDrgHRd7lbR63Xtg7cs0myjXKQf0HDkKOc/pWVRTLg5Lk
 Ge83iovzNNmqdXWIxjQuJuvkyF18toEsHNXrzqp4cm1atl0CI38KHvnGA+tb5Wx4UWZ3sXpSpXA
 NevdMgdO/SqMXD2V5sjnB/Gruz7WdqAg+OucwDFEm0l8Vr5CfvY6AlNyY+Rgx2jgTGPSXEc/Cq/
 Mu06rOQphXAjWUkw+wjmd9j2OqAspIfjiArSgzJm9OKH8sZkTyLDIPbPCcCYPU4PHcDPG/y1vHA
 kwA8sxSaBH0+VeYOZbmMr0Neu0BJS8qararSOMnM01qoCklV1XqufMKywXPhe5GxNDraNy/Ym6p
 NroL3dZoe/6XR648DVReyy0Ak+m2Oi0iABZvBy6qz0Zaaj1INHas0wbEMBni+ZREZq14xuVsNqc
 fcrPmE5B1J7zJVXZQI4MNxjEbMJMcHEageRrw==
X-Received: by 2002:a17:90b:2885:b0:398:9bd1:3211 with SMTP id
 98e67ed59e1d1-39dec0be8cemr2765879a91.18.1789365095471; 
 Sun, 13 Sep 2026 22:51:35 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:51:35 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Xingui Yang <yangxingui@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 39/62] net/hns3: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:47:10 -0700
Message-ID: <20260914054912.755403-40-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

