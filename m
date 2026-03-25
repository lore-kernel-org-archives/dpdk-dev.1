Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85394109C05D
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6DEE4270A;
	Wed, 25 Mar 2026 21:19:59 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 1FF57406BC
 for <dev@dpdk.org>; Wed, 25 Mar 2026 21:19:58 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c763c294cccso208329a12.1
 for <dev@dpdk.org>; Wed, 25 Mar 2026 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774469997;
 x=1775074797; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHkPtjXCZkQ+KDwt29z3kL/D6AZpv84Cl7VcDa1c3Rs=;
 b=zKWnCYUDWxw6gJPbhDRU8Q65AQocZz53/SyOioVx+Y/ASzqYhqOZNOMftAsMPTvnl5
 lbqh3NjnAsdgDHHU1O6EQtDPeIYJvh7o2zh3xem/heZM8c/4JLwVq8pHhVvhKFxu8OJT
 GVzIKNCpMBoYrNymnGuZUVjlWW5tHfxJstsyyiUvbuIjbDv/1bEXCVKQ//AjrJCZ+Yv6
 F8EU3ZJnWDvGyl6E9ULJSG2qjFtsq35/U313NBcr/u2Tpr7P7515K3x801bn8J0iAAPU
 mVvK+OXNWXHrFvdartj6936+w0aDrdv+7cVoVG0nhlCkpNjfRaes95tAYSLmZEIk3P0B
 deng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774469997; x=1775074797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DHkPtjXCZkQ+KDwt29z3kL/D6AZpv84Cl7VcDa1c3Rs=;
 b=H5zPimSiWIEjCMVzZh8VXyaaAqaJ4pKqBhQoiHj8cF6MSMPMmtn9R7uoX213TPRnHM
 cJRb2s3yoH7EOYSp/PsA/VK6zZh9NpslhxuaQAgo3DrXUzpDqJKrUL06+U939A9dmKkL
 wNHciJUopewDfOUsuJXexUPAPEkioxfSnQXugGK0vtOspFf3IMFphLVU5J3I/CP0hepQ
 /fY28HNn2VM3Fqv1W0986bTrbWMPQL5JMJwBIVr2IzLa2IBLFUCoPMu5D6Ro7phjG4kk
 KwX5sCMBICz3WI0KE529hBVLHOcJFzHXEWpR0QW0vsldAMMg8EP1aXb0hhjOC4KdEm9S
 cdEw==
X-Gm-Message-State: AOJu0Yxqfr3ONQn5YknOwAJOUUPMQecNWDeymBe9WJopYC7P4VRZvbWT
 ipH6wybxWkwKjvWc7IN9TUlBxcLNEoAGlORJNLGVL6c5BbIWM4ocq3aMkURHa9IHN3o=
X-Gm-Gg: ATEYQzzpx7d4p2vxbq0Xe9FJw9ZWfxbTkgHfIVpAliSfmOgvJiBxHWv7NEZbb5De7s+
 MUbOl6X5yBrHS5llw7gRkLvCerdYWiJt5uod9/jb/B9Wh0/L0OVfDxIrB56nss1q7RNEzDlOGYG
 egRbQsUVICGt7fH18HgtbtGvQ4bR6Oba7YuEQbkfQRClq0A5yM1Mvu8fB6NnBVgpBSKjHxrHyue
 a1PstOcL8VE7fdJ90Rp9i5sXVDPZgB3Db6imGwBVwOcKZCggi7n+6xhqBvN7ZIerRHgDMJeneHI
 rTKesmc1jzutrv60uJjH+pQsNDn4ij8SJlmm1PFV0ptDvoADnlIiuZhCKfK2AeUMXh9PBsDY3sk
 9bxUTPKM/445kzIpt7o9WOEF9ySvEml7RGySKVT5pRPJPCAvoWGAxxe4q0mgTf89ozodhYBfm3C
 QpLF632ZAU6o2Vs8SEhTubFFflvrzYbPZk108=
X-Received: by 2002:a05:6a00:1408:b0:824:9f22:1e95 with SMTP id
 d2e1a72fcca58-82c6e106ce1mr4643865b3a.55.1774469997082; 
 Wed, 25 Mar 2026 13:19:57 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e1960sm530627b3a.3.2026.03.25.13.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 13:19:56 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:19:47 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, weh@microsoft.com, stable@dpdk.org
Subject: Re: [PATCH v3] net/netvsc: switch data path to synthetic on device
 stop
Message-ID: <20260325131947.6d20a792@phoenix.local>
In-Reply-To: <20260325185750.1926356-1-longli@microsoft.com>
References: <20260325185750.1926356-1-longli@microsoft.com>
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

On Wed, 25 Mar 2026 11:57:50 -0700
Long Li <longli@microsoft.com> wrote:

> When DPDK stops a netvsc device (e.g. on testpmd quit), the data path
> was left pointing to the VF/MANA device. If the kernel netvsc driver
> subsequently reloads the MANA device and opens it, incoming traffic
> arrives on the MANA device immediately, before the queues are fully
> initialized. This causes bogus RX completion events to appear on the
> TX completion queue, triggering a kernel WARNING in mana_poll_tx_cq().
> 
> Fix this by switching the data path back to synthetic (via
> NVS_DATAPATH_SYNTHETIC) in hn_vf_stop() before stopping the VF device.
> This tells the host to route traffic through the synthetic path, so
> that when the MANA driver recreates its queues, no unexpected traffic
> arrives until netvsc explicitly switches back to VF.
> 
> Also update hn_vf_start() to switch the data path back to VF after the
> VF device is started, enabling correct stop/start cycling.
> 
> Both functions now use write locks instead of read locks since they
> modify vf_vsc_switched state.
> 
> Fixes: dc7680e8597c ("net/netvsc: support integrated VF")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> ---

Looks good applied to next-net
