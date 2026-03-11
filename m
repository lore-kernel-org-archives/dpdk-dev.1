Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385F3112584E
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C50B4060A;
	Wed, 11 Mar 2026 17:03:32 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51]) by mails.dpdk.org (Postfix) with ESMTP id E6DDE402E7
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:03:30 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7d743cd9e5bso54357a34.2
 for <dev@dpdk.org>; Wed, 11 Mar 2026 09:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773245010;
 x=1773849810; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/yiJHY1qAppK6TGzpcgM6MUbxaBBNBN7zXtAEkj97Y=;
 b=tMNaiVuZE/52RU8zEenQ3N6ciBXFh4axgn6B/vqBQ4IDYqEebVR4iHQTN+FrjEVolw
 GLxAvuLZ25NOdlscDeCtNrsDGdi8Kmb6TsGShtXDwp9MLYV3eukemEzsXSa7wCiIxtt2
 DkJobgcobLvsdHZv/rTPNACUBa0Pln7TtiyvNeL6gSbv4Uop4kd3Lx3CrbIHLRaAJOf8
 lntcn1EufURc57Kfh4UkXAajRUN8aN76EvjccuNfqoo5xzrGZUGGpRuWGZgmRJ+4b9zB
 CY7jkb98i3FwiRBEmS/Qwkz9Rs72Xeh7SrUljrcTese/2LKPgZsEQX8EGDrfqdE02zqZ
 5vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245010; x=1773849810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/yiJHY1qAppK6TGzpcgM6MUbxaBBNBN7zXtAEkj97Y=;
 b=Y3X/9Mr26hyt9o/gh1NTEnRmYLgqkHUSW02KxAycGDxTW/hTQmFowAamB1FDwBsK1e
 8epqmUN7t/M6dcopJa+hgjwWPfFlWUy/81o/hta0uGHuwv5b7iVQcXTaOrEj0j21rGHO
 k8sEOcAX9lPwKXXWqMJBaem1tcPGeon+2pAckf90obPWb44gWzZWMxdtYvfHV8ChOM0J
 epHavwStf4b3XYshSGyDTnHt69UdHhJUQ2vzfdQ9pVSsepU2E67NlFdAz5k5fxXUCseT
 ohjGCgX+0YEFIMjtMAMHYokd9gTCT6pJeC+UHGzRMRPfu77TBUWDK6dl7dEGHzfKWu0h
 iytQ==
X-Gm-Message-State: AOJu0YyBakCaxVdBwpn5ozHQpRKRitVrTatR6HimW3hQuM4TTnE9XbOI
 LZZybdL6DCCALKzAPzNRWSOdKPqMZdVQOe8R1zADV/xLyG2p4YCgMY6lzVA+YpMq/jc=
X-Gm-Gg: ATEYQzwN+MU0lnV0Jk0wa3i9IUn2DrPV4VAGcOiP3zdtzfETjGvdT1l6HpLxojOhQFK
 Ngjo69mk2SlqsYoiXooskCnFbbTYwQd/5pL8smhl8H/n/DQh58rh94WMjBV4vxHpf3SF8rvfx5P
 jClWFgxBWrFRjT9OX1viCO66Fh/KGNbEsEnK3fxaDX/v5hgGzdWEBZ1MgVnBb53wGwpHF6hdJ7h
 IJmwpnvdrr3dSmoQd8zePmHgifcStXqoDwbXf4ym+L1v22ySriIUUjw5y7rVrhE/xtaAQzDScv5
 D/lsEUY2CJ/rPG9lOr7u2DDwK8WCzB15vSih4/x7hFYBgwraySF7ZH+Ge/7IJlHKVx1NeugPMT1
 U+/VwvEXHs0dgnI8TkN0SUyv/O59RqkaW267PwXzRMBJ8CM4WQpKvN9ZyokMqGP/Og0CKAGxRNH
 ILifZm+0d8x1b+p3obBS1M0ARq4x+KmWDnqvo=
X-Received: by 2002:a05:6830:4392:b0:7c7:6977:17cb with SMTP id
 46e09a7af769-7d76a84427dmr1980036a34.21.1773245009911; 
 Wed, 11 Mar 2026 09:03:29 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm2057564a34.18.2026.03.11.09.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:03:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 09:03:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v3 0/3] net/af_packet: fix MTU handling and add jumbo
 frame support
Message-ID: <20260311090322.736ed562@phoenix.local>
In-Reply-To: <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
References: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
 <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
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

On Tue, 10 Mar 2026 12:21:19 +0100
Xavier Guillaume <xavier.guillaume@ovhcloud.com> wrote:

> This series fixes two bugs in the af_packet PMD related to frame
> size calculations and buffer safety, then enables jumbo frame
> support by deriving the advertised capabilities from the actual
> TPACKET ring configuration.
> 
> Patch 1 fixes the data size calculation in eth_dev_mtu_set() which
> is too restrictive due to TPACKET2_HDRLEN including sizeof(struct
> sockaddr_ll) even though the sockaddr_ll does not consume frame
> data space. The formula is now consistent with the RX and TX paths.
> 
> Patch 2 adds a bounds check in the RX path to prevent a heap buffer
> overflow when the kernel delivers a packet larger than the mbuf data
> room (e.g. if the kernel interface MTU is raised externally).
> 
> Patch 3 replaces the static max_rx_pktlen (RTE_ETHER_MAX_LEN) and
> adds max_mtu, both derived from the configured TPACKET frame size.
> This enables jumbo frame support when the user specifies a larger
> framesz devarg at vdev creation time. Since the ethdev layer now
> validates mtu <= max_mtu before calling the PMD, the data_size
> bounds check in eth_dev_mtu_set() is converted to RTE_ASSERT().

Applied to next-net
