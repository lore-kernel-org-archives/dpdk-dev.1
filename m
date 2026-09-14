Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CBC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:51:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4505B40E2B;
	Mon, 14 Sep 2026 07:50:39 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id E5BBE406B4
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:50:37 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso2787275a91.1
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789365037;
 x=1789969837; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ATOKNKUSUdPuqj/ddz9dvp+dnGzSTbWmkfKu7MmHt5M=;
 b=PCaw7zeEs9+nWH+35sBiHHM5BuKmJuf5vda97vNL1Hu+R9cK0f3TWlEbXcOVD74PU8
 VWsMVRcKdwnDoo8cVnpXSuaR/9NVs2did0Ch8NhlSzb8LvS8UTn3QxZfD72WD/9Sn+rl
 Ghejz0i5zuzrhywbOdi8NZoPNaeBePaERet6lCULZm+aS8sWY8J5+JseyCT4IqJ6zkdI
 xRJgbFrtxpD6Kc7isNbonz6Rkc3gmB+aGVlSh/OFA/Up4ZSEE+8saLJFlTrV/EeHVCxD
 Aipf6REa6hoULfQL1rZjwxY5ILbC94F3k37CvQ1xDQ1wDiwbw32wFQhi7SHUlG8LB/22
 8Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789365037; x=1789969837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ATOKNKUSUdPuqj/ddz9dvp+dnGzSTbWmkfKu7MmHt5M=;
 b=EOpgPO/ZQyRjNmKiG0suTan58jZGSKOT1k+rvLWKnKw66mVn+saYtq+VN+OuzDZQOO
 jXJPaZ6g3qtJaAf8l3HFOdukPlms6i3BSMAmz/qTS2+VCpOF1kU+lniSnhSp8OOU6fbN
 QhUSj4pIPbJbBsxECRPHdKnO/PTwdT8K05LVQ4tvt3FYYLddLn9j22CoUCLZhzvmAV9E
 ANVXIXr0DxscXn00DMzMXtVB1SDQquEf52hUlBF5QeYQAg0B4hMe0Ni/LoYYHI3Zm1cQ
 ftuFx6Hl+izaIOXhIIylrX4bOXj8qbyBYV9/+1YoAoWxpDozhVx1ypz3MW3mGfmHXebJ
 qvAQ==
X-Gm-Message-State: AFuF++ktKxJ+adgK9f/HRphRN4Ru225zvTv8pwsbHeYywpG5tg1RqC+F
 1ahkizJBetG9LUlFZb4aquFNROyN+CaZG6yRNXe/vN73Y74UaUthpGEfTOQsv1hOqG6QSBwwN3L
 5nfjI+T8=
X-Gm-Gg: AYBFou1+NZjVq5Pyx6rEVBfR5NSvhUJtezZfX6AFXzaA1jHF2O6MbNMb67k0MgvtTAB
 TFd0m7ZVS0UBPWE3OXzCV2vSLZKC+ewtW9FTvgyXeDo3VOJlViI4gbHYEiCnkm1mFVLtVeyV7ND
 R8anNNR5DdIWpXL94AYtWHP2g/83nSBu/PWRflgAgAfGB5p44+HvPQSgMOhbNZEXT8rBAAZrmuE
 B734kaQ76k/pIyBMgksYDyqW0oMBI3yGojNxzaJ238bJFJABmkv0cCc8yf9SWzh8bwI5EZBbLaO
 rpgDo2PcKBG8xoLQ3Nx1+cDfC/Rmu+/dFQ7Ssq9aBjUs4afWhtSj2G3gASPrziBjBmE0DMSRC56
 QrQnhCAsUlqrJMsYEJpLfhO87W819v3poXoc++aId9z0aa9TmrGxpWEZC29sgupNC+SKP5KUHCt
 1wsD/6njJeHml0y1zo7dZLqisMaIkMPrvm4RuUSXzJesES/NU+vADZT4z+JN+31V+rBPUGX2GuU
 S/yp6ZyJ1EbQNQS67hyeh5tv3BSQx/+etgTOA==
X-Received: by 2002:a17:90b:3eca:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39dd5288e2fmr6496546a91.0.1789365037016; 
 Sun, 13 Sep 2026 22:50:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:50:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 23/62] net/netvsc: use kvargs numeric helpers
Date: Sun, 13 Sep 2026 22:46:54 -0700
Message-ID: <20260914054912.755403-24-stephen@networkplumber.org>
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

hn_set_parameter() does not check errno, so an out of range value is
accepted as ULONG_MAX, and the result is stored into 32-bit fields
without any range check.

This also drops support for octal, which base 0 accepted; hexadecimal
still works.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 9a193e4a7a..d9f60ec279 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -202,11 +202,9 @@ eth_dev_vmbus_release(struct rte_eth_dev *eth_dev)
 static int hn_set_parameter(const char *key, const char *value, void *opaque)
 {
 	struct hn_data *hv = opaque;
-	char *endp = NULL;
-	unsigned long v;
+	uint64_t v;
 
-	v = strtoul(value, &endp, 0);
-	if (*value == '\0' || *endp != '\0') {
+	if (rte_kvargs_to_uint(value, 0, UINT32_MAX, &v) < 0) {
 		PMD_DRV_LOG(ERR, "invalid parameter %s=%s", key, value);
 		return -EINVAL;
 	}
-- 
2.53.0

