Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29485CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 18:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5ED840151;
	Sat, 25 Oct 2025 20:14:50 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id A9C034003C
 for <dev@dpdk.org>; Sat, 25 Oct 2025 20:14:48 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b5579235200so2269617a12.3
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761416087;
 x=1762020887; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiovL7K8XkxLY4g/ReN3mcszDEnHkOkKl6sawAfK5XE=;
 b=jgcwZyEOxRcW32XFAzGj9CX8wPdTjqRnw3N7Tl+pn9lHbOD1A4KcU6MEmBGs9xHVmL
 1Vy7vCT641mfj2tRy4kJBz0Aln4247ENPWOD51dvDxxNldOAwcq5ooSqsA0Z83ciqpDR
 2Vlr+9WQRJvabNZb2AYvy4apwxE0IxTuKl8Ofq6GaMOQScFn+FIl+HwlIkMPBYjuGMmZ
 Lfkr7vw4iSFZENN66k/2QCureHAT7Uk81nDaHzozqta1GpmZ+s9/MNYxEMrLE8t+GoZa
 BmhSa65tmi+bRil2QCbbRD2Kt1/mHFfikX84s4GBpjqAPCNSDP0Dz/2BufHZHNoYGVOK
 TVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761416087; x=1762020887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiovL7K8XkxLY4g/ReN3mcszDEnHkOkKl6sawAfK5XE=;
 b=eOvrMLYtojUARozpFw40bXLq3rxE15RliPw7MVM6Q2L4qskfx1sRk+BHn/wFcGfI0h
 6s1GWEwpv8MHMTYe3q4ASeK7og2WUf0Bi3zcYGQ8TbV+Xba80h3gUm1Qb8okimSsSOGR
 PbQU44dSpRO0egMNmBaWvu2T9Lz/CzGakWKCUa7E3w8ztSp3oit+iLVBlSsWswshFxeV
 bV99yJUauSJKA36d5w/vsU4OtXv/B1y6w5Z5wtNwDDRYNLJ6YtCpiuaDBWIQobmPDu0O
 bRlD0Touo0FOzTtBUoiWgbRvU5VlBjNE8ZX5SGz0PclT8sbRsHGjqB06Lw6Pbo5bCSWA
 k/1Q==
X-Gm-Message-State: AOJu0YyKwsr1NESTqOmJr8YCGJR/UKseTADHo6QzYpjINHCcRf7IfS4A
 xBMbFVPvi1WmgDgh+JA2EVM8yiYcMXzy34PdqyGzm5Jfe/vuoMxusFifWUzEoEqClL1ckanjzgb
 VNz4B
X-Gm-Gg: ASbGncuJQWaj/bIXD3ZzDYPOSmR4ZAwTgV2KTsh7k9SPNtKcOeM8rskt7toC9I7EV2p
 OMp7QH3DXpjGxQ3sKnTefRfo4qf10G6b6KEHloE5YHjhA6pdM/yGGHf8mEfPkfV62nvJdQsMBsl
 5nEWz/DDr6S5WR40cMsVZMzhLsagw2VPwqU7kD/tBaAYtwGfLt0RT80hDeV9P01xWiUxd6l4Paq
 vxTZGdB9Je5S+Xwzrw/EdfCCdEtBWwqOtykhN4OwcUap/lTKXjFzyhI5jHf5bw1c5+Cd5HKk27n
 0htojwm+k2S7MtDCmjwsUUSpgUqQatFfZevk5m9us6Ckt97K+giWJvqAOLN8y4zZpM8n9NyDHhW
 /Hl5nZb1F3gtDD41wajeIWl0MZb4kfQKVAkavYuzq0Ky51kYY0iqsIJCVoZirghUH1PuBkHRqGR
 wl5gUsEsv62PI9FcOa0/6zHVIaoIlcuPkFgobf219Ue506
X-Google-Smtp-Source: AGHT+IHOAea5SRAAQMy/GcQDODZN84kiDb6z/GoHdDZOYglbhzUGM3c6aE2ePj7QtGNvVAeUbx8LQQ==
X-Received: by 2002:a17:902:ea09:b0:271:479d:3dcb with SMTP id
 d9443c01a7336-2946de3a7f4mr130636925ad.6.1761416087419; 
 Sat, 25 Oct 2025 11:14:47 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d40166sm28906435ad.67.2025.10.25.11.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 11:14:47 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:14:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 08/13] net/sxe: add dcb function
Message-ID: <20251025111445.36598f91@phoenix>
In-Reply-To: <20250728090517.1811244-8-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-8-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:12 +0800
liujie5@linkdatatechnology.com wrote:

> +
> +RTE_EXPORT_SYMBOL(rte_pmd_sxe_tc_bw_set)
> +s32 rte_pmd_sxe_tc_bw_set(u8 port,
> +				u8 tc_num, u8 *bw_weight)
> +{

New API's should be marked EXPERIMENTAL to avoid having ABI requirements.
