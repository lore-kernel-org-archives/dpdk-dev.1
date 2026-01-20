Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E395D2629C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EBC6410E4;
	Tue, 20 Jan 2026 20:54:34 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id DA07B4026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:25 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so4695790f8f.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938865;
 x=1769543665; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGNuRblYumtwqpN+9gqA2URFkAOSBLjfXWBeuth59Rc=;
 b=ckRT6fDqoHH6dDTku93yHXYdtbJOGaBx2EvYfQfwTIeV7dG4RbfxjOh4yuaDWvvHcI
 C2leeQQp+M/rgiB+mxk1kS8heeCZlDBu8xH1JI9BxWCimjV/PFregHXAPgcXs49NKKlW
 /TNZF9wnea5KM8kYM9TMSG9YxQi2RfggO7IUvIZq6hcPL6pbgMcG5CYbG07z1INDrSdY
 enuQxKVs1Jwgij8no+k3EPsOUxVf8tZwjsIw92ytzgHnTR7XKQHgXAR+E9YYZAZtN5Bz
 Uus3sRTdqI81gu7+iwK8/RqpynIZ5CtmVowHWMtN2x3ViIteqVuaZSlFfNVMkOYxnWvp
 YcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938865; x=1769543665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QGNuRblYumtwqpN+9gqA2URFkAOSBLjfXWBeuth59Rc=;
 b=mZKXyk5FiXJdtZeY4UyGsKzFBjGNeSMtdYdWUCwROPsXbn5rjptWqz10MfxWGMgRyA
 WOSElVe1u06vCmqywAZ54yKmRgJ00/CmeB6Irpilx/gKMPE9aXKfudYA4WLpcDZ0DY7X
 ih4aQnvCYDFippTtaPmaRQWJBW+thk0p6a3aObGoAHpmFDYUunzjMlZ8OWm/N9iM/KG5
 RuTdHz9zPPnOazcNo4ZiPv63B8C5xQvXP3vuYdfiXSMhG70lEDpFOS0Xlg0PeMeIjhMw
 yTEPoFpeaxZEsWV8h068Rws/AeVf3IIug/d2752Zr+D3tOvZgAb9C6Ps+XxaZF1ITcvY
 HfwQ==
X-Gm-Message-State: AOJu0YyHgUcAbUkh0z5/zHEv4MeqGtiv+Ig2Dvejjyvp+TO0y26b+a3g
 S3hKtDEkkwpPMa4T3EKblFWQB6ZcmB2/xLiIbktx5AYbmAQ0zNcDtkA8RoVmBh5LbQwIhwbJPdo
 fN4aK
X-Gm-Gg: AZuq6aInmi3mGoiSoC9qq+YAXGumIN+Mh9xaAuPfamsX1a2YVz9nRtvEZS1jBR73/92
 nRbW4Id2fj2yGcWZmFnXeh9/CNXE7JU0BlGMYrwtrRChoAUmiWsNY4SGdjspwFWv6OvTy6X1HNk
 fW9cxetNApeEkpM6mMVBmLCa9KUxVr4MTZM7Y73YoWRXrQ6pgAFtOVXjzyx0ehg5s1hTuPMohjG
 fv3hTlk88XVosGs5wBa7caEoZuLHA/IdxaunCJsqmTch0HgO2xs1NOearcgS9Z4m/4pI+ekz+6P
 nqqySTRqX+efqV5PZo6pQ8COvvlE4hIioHbqBh6ya1qd2D5CuRrJimlaJTssnmYU4F3y0Fx81NI
 PI6qQzkAAxgnjhd5Qm9RlkCspgsViYQNXRNmIUGkNtbl91XFiNmLadMqKpCSOft8Sv7VwNjSAEn
 Na/XRg8KaCpTxXfBRcENe9RK8gACa6fMHGBEa7aQPS2Nq3wAR6ZQ==
X-Received: by 2002:a05:6000:25c6:b0:430:fdb8:8516 with SMTP id
 ffacd0b85a97d-4358ff269c7mr4937112f8f.35.1768938865445; 
 Tue, 20 Jan 2026 11:54:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v5 1/6] common/cnxk: replace variable length state array
Date: Tue, 20 Jan 2026 11:52:06 -0800
Message-ID: <20260120195418.466318-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
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

The cipher function is always called with in_len = 16
and there is an existing define for that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_aes.c b/drivers/common/cnxk/roc_aes.c
index d84feb546a..babf149ccf 100644
--- a/drivers/common/cnxk/roc_aes.c
+++ b/drivers/common/cnxk/roc_aes.c
@@ -157,9 +157,10 @@ static void
 cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t in_len)
 {
 	uint8_t data_word_len = in_len / sizeof(uint32_t);
-	uint32_t state[data_word_len];
+	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];
 	unsigned int i, round;
 
+	PLT_ASSERT(in_len <= AES_HASH_KEY_LEN);
 	memcpy(state, in, sizeof(state));
 
 	/* AddRoundKey(state, w[0, Nb-1]) // See Sec. 5.1.4 */
-- 
2.51.0

