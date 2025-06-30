Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149A0C83029
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 16:56:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8804402A5;
	Mon, 30 Jun 2025 18:56:31 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 895894025D
 for <dev@dpdk.org>; Mon, 30 Jun 2025 18:56:30 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so1483484b3a.1
 for <dev@dpdk.org>; Mon, 30 Jun 2025 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751302589;
 x=1751907389; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylAaMEoEoQBvorAPpO7VLR6Q3Yo3kro01kcqCDilVo8=;
 b=Lvzg9vqZHEBRUcZ5e7wE4SzTuO2m+WqsbytwBTSQazMxwtkva2VDpjQ5VqvBWS+3zq
 x34+O+D+OHobWynUa8XAfx+C5iKqoUyS+xgHT/5SnpBifKjzh3o5KC2Uri9Y49thdkjc
 9uY5iBX/zaRMcGnFqv+xnvqvpToeBIv3w4gXMZqHORzCRroTT9uJE+/mV1KGgncNfbiG
 pAVSsSKVhpxbxZG9t6rqIamxd9El1mUskisy4bG2/A9hEKy/TfjmVU3zOzgg+7WUxPvX
 Dv+etPpfaDGn7fx2yHZUg6TSxH/FPU1DGjcVt4MfqztmeiBdF09ssQ8ZpiPVJ4oyLWYD
 LLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302589; x=1751907389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylAaMEoEoQBvorAPpO7VLR6Q3Yo3kro01kcqCDilVo8=;
 b=g/7BHAk4P189IIWbxjV7Fan4dMKJjkhGBKjbr2YMJ5bP1w4QUbQGNGU/kviPKfANul
 QvnuYbrbUqN7hmhPoJ1lutW3BuEWzo9RHaorkEnuYTWFpSqzjJHqI9yaKHgkNOpJhb7K
 YHGQMNNDV+TAKrDtv7mYTMjHGxvbwinkTRYu6PiPjdM3OQlfR1gDNhzLaLkAR4QRAndR
 B8DP7QNEJjQ3ExSOBwrLtswIS584t66JXaBOvLfUClmThBOe0yF0hGuSickmPWNTmqO3
 BemAr/MiisS4mY/e+UVwURivfMBmyhMLwEeGswTmv3YXuNIchgo0X7fL7b8hERH34y0B
 iJhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSios8OhbiiUFIvNO3ZjfDtPsHeGw3GB90DeRwW4IYnV72D5JjOvrpJAu9Ip88ZpVOFyY=@dpdk.org
X-Gm-Message-State: AOJu0Yx0Jp8jnlKh6KP0ToF4rGPyv3ykvx4G7r/qJswEqbY58ZPSfsK3
 08/7dc0D89Is00YCXt7pFnt9BP61BBZrfdz3oimcyR63atMm0lMPmFyaSfX/kyyfa2I=
X-Gm-Gg: ASbGncsx4Z42VRKVy/0W8sL6wfYY8wK/rLz0bsJ3+dsiFMcFCCbIwWVUDmbix8Dn1rK
 dBpxLQKb0M05WStNwJCSA3PmoFqcw5TGJPfFto1Zeo1UxVoa2v7PVhBdQEi2TgRdWquHN7QRxCL
 E6ALwlsxM6RyHbMzZKNgERf7EgOjVzzDQSEXlhgqUKuvFWkC5BvBblVa6NBa6s0YeYduk66CniA
 7F4+UyDt9z3YnubEDn7yPdT1nq9CRv3rUN00KiC5xjJXqDFcOoKnYIOg+VNicOe/74WaAU4bVU6
 lzGgIO2pUhtKYVyBxujRWDez/GpgKAYsDR59GfX51x5DsBikXUYvhJfjMVtTE6NWPAGfU8GLvCK
 k89Vn4y7YMoKSUAcD+sjz8W2yT5ePpRmUDqgzBfkUfHhZK2uKwA==
X-Google-Smtp-Source: AGHT+IG+px8R6cjIq263AiQ4E2yeib5+w2w5EwkU22ixN8VEnB+H+ZWRXutBbD9/AgnmSMWjdE/0cw==
X-Received: by 2002:a05:6a00:929c:b0:748:3822:e8e0 with SMTP id
 d2e1a72fcca58-74af6fb6229mr19886880b3a.13.1751302589546; 
 Mon, 30 Jun 2025 09:56:29 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af56c0c8bsm9527966b3a.113.2025.06.30.09.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:56:29 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:56:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v2 2/2] net/zxdh: add support flow director ops
Message-ID: <20250630095626.679e0999@hermes.local>
In-Reply-To: <20250618074936.3616999-3-chen.bingbin@zte.com.cn>
References: <20250617093114.3570444-1-chen.bingbin@zte.com.cn>
 <20250618074936.3616999-1-chen.bingbin@zte.com.cn>
 <20250618074936.3616999-3-chen.bingbin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 18 Jun 2025 15:49:30 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN, and mask matching,
> supporting multiple actions include drop/count/mark/queue/rss,and vxlan decap/encap.
> 
> Signed-off-by: Bingbin Chen <chen.bingbin@zte.com.cn>
> ---

There are several checkpatch warnings in this file.
These are the ones that should be fixed (ignore complaints about stdio and macro arg reuse, etc).

Please fix and resubmit the patch set for 25.07


WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#60: 
Provide support for ETH, VLAN, IPv4/IPv6, TCP/UDP, VXLAN, and mask matching,

WARNING:TYPO_SPELLING: 'realease' may be misspelled - perhaps 'release'?
#1235: FILE: drivers/net/zxdh/zxdh_flow.c:904:
+						 "realease handle_idx to hw failed");

WARNING:TYPO_SPELLING: 'realease' may be misspelled - perhaps 'release'?
#1426: FILE: drivers/net/zxdh/zxdh_flow.c:1095:
+						"realease handle_idx to hw failed");

WARNING:TYPO_SPELLING: 'realease' may be misspelled - perhaps 'release'?
#1429: FILE: drivers/net/zxdh/zxdh_flow.c:1098:
+	PMD_DRV_LOG(DEBUG, "realease handle_idx to hw succ! %d", handle_idx);

ERROR:C99_COMMENTS: do not use C99 // comments
#1620: FILE: drivers/net/zxdh/zxdh_flow.c:1289:
+				//ether_type = rte_be_to_cpu_16(eth_spec->type);
