Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B4FF8855
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Apr 2026 21:59:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16C35402A0;
	Fri, 24 Apr 2026 23:59:32 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 55F0040291
 for <dev@dpdk.org>; Fri, 24 Apr 2026 23:59:30 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-479d9b155deso2186380b6e.3
 for <dev@dpdk.org>; Fri, 24 Apr 2026 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777067969;
 x=1777672769; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ufb0s/gfUlTov0EsKmMzd0uPOYozRwJQdgBd/fl4lAI=;
 b=bphRHY+Gh5Dd4ntVWi2ADfYgmnsm53L7y7w4h7/XIRfN/rvP6XcR638dWpDZqs59tB
 ticIjCbBUfEirQcc9hsMlnPNv4QM1q1+8GCpKhBr+PPa3FspqPanrHoVk+RXR9E4566d
 FFK3ZDlQgwYIacw+ylGWwjN47j/lo8nRw9X0JrcvtIJipF5aO/cwAQBzzfnt5tS6c6qO
 4k9WzlJ4GHfuEGxC36ce7JQlZ6slvVfOhFFEBCE0G8kfokIDlywQRm+zoSoMdxgiJ2Jj
 jVQZK2KioqQSjAXLGh2bp0P4jZtZQip3GZcv7r7hBoNW1Py4F7XvFBti5vYm2V/MJ+Ay
 n19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777067969; x=1777672769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ufb0s/gfUlTov0EsKmMzd0uPOYozRwJQdgBd/fl4lAI=;
 b=jSvOqeqyJwWm5WEr9gRH4KNwEndGJZ3hElqrbT/4IBvfp5FgaNATOPn+B2Xo9ZbIk3
 KiOMaVL9vJJxLN3FjfK70GtsalyyttyflQ9GQ7Qt7Gs/f28jgut2uoRO5friD3yeM/vD
 MNrz12PeDGIMf61SEZyYahN6h/VLHTEv1lKdoW58/Fsf4f7fH+iOTIb7a89O+vTHjPAk
 +BY+gLMxOVPA6gA5MQJKULkYqHi+gfG3QOAqN+zrm8rmKptjSl6f4VbgRsJuUdEpFCV+
 L8/KcVFASBk59wHaLlhk5ty9kEqSIgCGj9PZrG+5QDeKnjhoxzKbxh6yYZjkqZOogh7s
 1JFg==
X-Gm-Message-State: AOJu0YyI/NCrAaqEsuZpSlUVKNF6NctH18ExW8PPlka/mgDzBPpuY2Vs
 mdSRiOe/mIOg8ahJFbbKFJjqK2QKX1ltjSDlvudWMScqWrdNdfqrY3q2PKVpY+gYpQU=
X-Gm-Gg: AeBDietpuJX6aXAyYKOamCGMVKvzQo+MeGVfhdwy+7ibUjjHaooXvDoxMUtefX/mJdG
 5rVALjKUOC1AW54qwEvGQil4nbiC8vfjYUaSoENs9AT3wfFz/7l/QU8hzq5w70cW+xlciuTQcb7
 GvHZZrlegB8tOTf5duqJMgKgsvfE7J2TfawT8i/lRwD3x0tBg2dGCSkbMT6m8cLbpyirV459nob
 8luuB22d8ByihkHTj+Jwe5ZHr9/bqLsFbFM6DQRQNJ4+e3yg2RGQRuLiwTQmDc7Bp3832RKWpmy
 poq9n745cwh5JG4EKWXTKBdKx8zvo3gcne6ui9LomjD4JMD1SVwMc4pCjFk/o3bVukq3rppiqS5
 JrS167UUOYOon0sbxPbFj3NvgxQ4b3PiEx1Shx79AWQUVEgUlVJuCCw905ZcCqHeaUhGPfBo1KD
 49ZbUpBwXu6+lPyEYYgy3BeMW/JoNpsIc82DuCPdLIFCQz7HOHXGagZGUl
X-Received: by 2002:a05:6808:1826:b0:46c:cdf4:1be4 with SMTP id
 5614622812f47-4799c81620fmr21473796b6e.10.1777067969294; 
 Fri, 24 Apr 2026 14:59:29 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-479f4a284d8sm7923310b6e.15.2026.04.24.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 14:59:28 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:59:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH 18/18] net/txgbe: fix get eeprom operation
Message-ID: <20260424145925.43e00e12@phoenix.local>
In-Reply-To: <20260423034024.14404-19-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260423034024.14404-19-zaiyuwang@trustnetic.com>
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

On Thu, 23 Apr 2026 11:40:23 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> The original I2C access flow in the module information retrieval
> process was flawed. Correct the implementation to properly fetch
> module info.
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>

Build errors. Must fix.
clang -Idrivers/libtmp_rte_net_txgbe.a.p -Idrivers -I../drivers -Idrivers/net/txgbe -I../drivers/net/txgbe -Idrivers/net/txgbe/base -I../drivers/net/txgbe/base -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common -I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/hash -I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/security -I../lib/security -Ilib/cryptodev -I../lib/cryptodev -Xclang -fcolor-diagnostics -pipe -D
 _FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wextra -Werror -std=c11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wcomma -Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith -Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC -march=native -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation -Wno-address-of-packed-member -Wno-vla -Wno-shadow -DRTE_LOG_DEFAULT_LOGTYPE=pmd.net.txgbe -DRTE_ANNOTATE_LOCKS -Wthread-safety -MD -MQ drivers/libtmp_rte_net_txgbe.a.p/net_txgbe_base_txgbe_e56_bp.c.o -MF drivers/libtmp_rte_net_txgbe.a.p/net_txgbe_base_txgbe_e56_bp.c.o.d -o drivers/libtmp_rte_net_txgbe.a.p/net_txgbe_base_txgbe_e56_bp.c.o -c ../drivers/net/txgbe/base/txgbe_e56_bp.c
../drivers/net/txgbe/base/txgbe_e56_bp.c:352:13: error: variable 'CMVAR_SEC_LOW_TH' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
352 |         } else if (speed == 25) {
|                    ^~~~~~~~~~~
../drivers/net/txgbe/base/txgbe_e56_bp.c:376:21: note: uninitialized use occurs here
376 |         if (SECOND_CODE <= CMVAR_SEC_LOW_TH) {
|                            ^~~~~~~~~~~~~~~~
../drivers/net/txgbe/base/txgbe_e56_bp.c:352:9: note: remove the 'if' if its condition is always true
352 |         } else if (speed == 25) {
|                ^~~~~~~~~~~~~~~~
../drivers/net/txgbe/base/txgbe_e56_bp.c:322:22: note: initialize the variable 'CMVAR_SEC_LOW_TH' to silence this warning
322 |         int CMVAR_SEC_LOW_TH;
|                             ^
|                              = 0
1 error generated.
