Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8949510F284A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 16:21:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2031642E5C;
	Fri, 27 Mar 2026 17:21:14 +0100 (CET)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id E52B840E49
 for <dev@dpdk.org>; Fri, 27 Mar 2026 17:21:12 +0100 (CET)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-1274204434bso2527888c88.1
 for <dev@dpdk.org>; Fri, 27 Mar 2026 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774628472;
 x=1775233272; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdc+d5VLo4ADmBcgAv97ktg3DjbYkrGdmkuQD/hL4y4=;
 b=PlpNgU+8G3zTxhG40Y5TKhj+QaIIDKPuvyZVIcerVOgOfFZsYb+Ng6uq4ZzcMg3/8C
 Llp7UfkaCT9yDfd5a77ee+eQ4rMCIrmt5mEvrrNaUrVidP2pW2PFX8aIt6emQdnwjT7p
 cbx2O6q1eQBOpW+pJSlQvEuBqCf8cvSNg6gPwYsyIxHVWdIrIur5QLxzOdcC8o4V7cQi
 KZ3Y20+VDvkzESTiksbqwoaryTD5Y/GBcGVJEFj7w6fg3A637iIOQ473qPb+IBtTV11l
 33SodXKrgRNoip+4kmOvXbR4WNvFtvH8m08WD5gO1rFwmoPSPFkbuO07kkhmkd7kwFun
 aKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774628472; x=1775233272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sdc+d5VLo4ADmBcgAv97ktg3DjbYkrGdmkuQD/hL4y4=;
 b=rkJE+lASQdd1uaybQsT1WHRGiWRsrN5h7dl46ndi84bl2dYMWSMx0AuAUzRNOBWlx6
 sgH5eXnuEgm4M5sWsXUjfcrgk/nU/U0r+Ci1+GmAgsBcZvf/qWWo+haLZEQXJkPq6FOK
 1mIhA2ILC+1oXAikdIszi9O+U9dlh9qL2irml/fatTlNlTbD6waxU2jquuvUy/K8hKsc
 IP/No1INdfdbcIy/RFw6lmio0nh3CQ3GQ3Gaq7NYPxRdEOQVaDjRTwyPcTA7O7ZU9VT1
 8PVlY0mQDsDqg4vn3OZmZ381KyUR0hsKQd/dDw+eN7DW+E/4BkMvREtFCg37mNLxxoMy
 un6w==
X-Gm-Message-State: AOJu0YxTir6FITvlqj4vqLWep2EZM3t6MaEvkQo30FTM6qpIKOX1hlz5
 Q3kU5KJFvQb4k8nL+JKrb+K7WnWSEoL0ydCSx/iPeMvAw0RGVQk2qp8cDTlboRFNcJA=
X-Gm-Gg: ATEYQzzCdLQr5Eyg//MdivKjWcYlz8Q9437+buDWMLNw7o4M4ni7rv6F4lNHdmWy2hX
 g3zAF2W8kZ5qSPQsSXgvhgQuOjtMF4KBZgO1DUBovOXCmxbz4wKgt1EvmlzAZS8tb1w2e0Dc3Ph
 kmz4g6J+wvcHkE9HkcvFr1Z4a/nTbA/WoWQgVPsCtuF7hP47bWnG4FrJgPzqp/EAQczYejqLfTh
 W3gbHcJwf2RoYwusqJJwdXxPP8X3dji/vtOx98HPVYXeIslQzt9O/8+pKr2Fy+KS3R/Ih+mWmQR
 b2RrzYWYSoqpVtkyLtQsUbC48fHCTwW8tf5ueWuVZzbV85wLdOcf2fYZRSctgsBrSHNYmNRDNyg
 n7v0NalKASV2ZwQK/FMwwB9mtsq07HZjXueCPPCzfLQp8+99u4LFGxFyDiabVGPGYFLbRUY/eMN
 Fr01V85YDR/snQbheCXmq0fhQVJ0snuKZh8UA=
X-Received: by 2002:a05:7022:4586:b0:12a:6d05:3941 with SMTP id
 a92af1059eb24-12aabb0b171mr2740105c88.2.1774628471788; 
 Fri, 27 Mar 2026 09:21:11 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12aa6e5b38csm8933502c88.2.2026.03.27.09.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:21:11 -0700 (PDT)
Date: Fri, 27 Mar 2026 09:21:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
Cc: <dev@dpdk.org>, <Selwin.Sebastian@amd.com>, <stable@dpdk.org>
Subject: Re: [PATCH v1 1/4] net/axgbe: fix MAC TCR speed select field width
Message-ID: <20260327092108.6117948f@phoenix.local>
In-Reply-To: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
References: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
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

On Fri, 27 Mar 2026 17:50:03 +0530
Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com> wrote:

> The MAC Transmit Configuration Register (TCR) speed select (SS)
> field is defined as 2 bits wide, while the hardware specification
> defines this field as 3 bits to encode all supported MAC speeds.
> 
> Update the SS field width to 3 bits to match the hardware
> specification and avoid truncation of speed select values.
> 
> Fixes: 69e209be5464 ("net/axgbe: add register map and related macros")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
> ---

Applied to next-net
