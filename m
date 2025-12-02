Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF3ED1171E
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 17:26:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 015D040656;
	Tue,  2 Dec 2025 18:26:37 +0100 (CET)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 7E94C400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 18:26:35 +0100 (CET)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-8b2d7c38352so5132885a.0
 for <dev@dpdk.org>; Tue, 02 Dec 2025 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764696395;
 x=1765301195; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kl+nMGCbzsY7wpBsW42ipYcEgPWsUOOMfA0AdYbFZfU=;
 b=uNgFhmH1C/L5sfnTfJCNgBGx77kuCfgmZtW+TZeaovibIGC+V1aTvGiWisXJ44pRBW
 UuvU0+/0sCd2shMhfqArkdPYs72oLQlGIxaKhA5hBJ8YhWgWqHN3qxmeoR5hTAeRSas9
 M6a1g5Y9uCPkSwn7Qc4+0T0OUhoCYavGc2CLd21P8Gr3yysdH8SAh03mfIS/mMUVEuNd
 pTykgYzVBpn8loa6tMn7y2M3A/Av7bnpeGLyba9scKH1+ltibrs3cB1Ms/Iro/wDgN4X
 gIosakau4jBS+7ZMAiX4KSr7QB+1sYeo+e1oEZKHxCSeRb5LotvANBIwsS45BcDbZku/
 JsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696395; x=1765301195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kl+nMGCbzsY7wpBsW42ipYcEgPWsUOOMfA0AdYbFZfU=;
 b=Ml8Sh56c0l5+5cL7yZA698rLtsMBCkFs8VZsjkfGV1jafGFIRHWB0KeOIGnrxHGkI4
 PcYqz7lwfKag4fdSHkKR+vKarYmK9xRGiXx7kF2SDZElDDKGmTTRi5S3Ca6w63YgKmI1
 p38HCC43nbxjesByQGUM/Y58pIn/cZF6rgBbe9AxwH88Z9BVKNuvSz+CDphjesRM4buV
 SP8ztOG/sLz6NHrDXLQqzeTRyRv5HFU/hITdHArm8x8pNdCjG1xwwdlY9l5igf79Vxhg
 7Q7SYxytyGg8RNJZzRbfjF7cB4rdYmiDdAUXm1mOVb7oT9Q6+8BUqfdlRhVIN76bIKGy
 g5Vw==
X-Gm-Message-State: AOJu0YxqraD6zT7jVHjH2xeDwQyyew+QeIURbmfSANRSrkl9qiabxepp
 VxgPxKOfdbpNB5/NjC8zT6dk19POpjPSooKaCw+VB2kS6pH0dBgq36VrZlBjc81jxVwdqOniW7s
 m1/IB
X-Gm-Gg: ASbGnctEn017IQ9qfa/t07SjqUSpsiOOz5NCftZQs3nmjX1SLnKUjUD7DqXDqVwITkd
 4o9C7obBGws+iFNNZna81iuDgDau/dMkiLagvWZxyuqb337+kjZNyz3/2zYNgK8UxCKAMd+TR42
 cAkAE2azSBcc5wApAurfcP1Zgl3jjQH5M1wWbnQcLgXH4hkFdM/OhI9kFBsc1J6APaWcmJ64eMv
 UiZgxTWaozj51tLyEqPvwVOtOWv/WwMJSrHNrzDUPQFL0cWdkxv7bICnvVvjVaAhXKb8GKLNidO
 660n5Ktna50cuUCL9TYHKSZjqTxyucLXjVspong1VQlgoQ+tXcOjbhg4DkKmu/Sdxq8rCedDCmi
 4tXDLjmz4WQT3YgtOAudxUzl1ii2gaewX8XU9y5aXL4SjhiIbf3d7ds460SAuh6DCQ1zZvO8qoH
 ZThk4zlKazS/1QmvcbPQW4JLDCmTEM5dVRBVQUI5Tk6jCsCCP+Ig==
X-Google-Smtp-Source: AGHT+IFQtKDPcM8F+zN2hnowwtcRTDSyi+4q65VT7k9Tl7FTzxmhWt4S4eTPVT3tMBO9mzwvQR7WhA==
X-Received: by 2002:a05:620a:4455:b0:8b2:efe7:d829 with SMTP id
 af79cd13be357-8b5ac0adcf6mr525421585a.18.1764696394724; 
 Tue, 02 Dec 2025 09:26:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1c8405sm1113724885a.38.2025.12.02.09.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:26:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 3/8] eal: warn if thread name is truncated
Date: Tue,  2 Dec 2025 09:24:29 -0800
Message-ID: <20251202172626.283094-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251202172626.283094-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
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

Thread name is very short 16 characters and therefore the name
dpdk-worker-%d will overflow with more than 9999 worker cores.
Error should be non-fatal since name only matters for debug.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index b12f325ddd..d848de03d8 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -863,8 +863,10 @@ rte_eal_init(int argc, char **argv)
 			rte_panic("Cannot create thread\n");
 
 		/* Set thread_name for aid in debugging. */
-		snprintf(thread_name, sizeof(thread_name),
-			"dpdk-worker%d", i);
+		ret = snprintf(thread_name, sizeof(thread_name), "dpdk-worker%d", i);
+		if (ret >= RTE_THREAD_NAME_SIZE)
+			EAL_LOG(INFO, "Worker thread name %s truncated", thread_name);
+
 		rte_thread_set_name(lcore_config[i].thread_id, thread_name);
 
 		ret = rte_thread_set_affinity_by_id(lcore_config[i].thread_id,
-- 
2.51.0

