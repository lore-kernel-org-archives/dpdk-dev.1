Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CA4C83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 20:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E69B04065F;
	Wed, 16 Jul 2025 22:16:26 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id B447F4065F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 22:16:25 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-748feca4a61so202776b3a.3
 for <dev@dpdk.org>; Wed, 16 Jul 2025 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752696985;
 x=1753301785; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/AtYD9Jpa1h9b2rOKfv0ARAI11DfXykPXpsug3dNHA=;
 b=CbaHC1Dmuq79GKZY9MfW7cqqqAQN+0CKkiqhQaBkxr5agej8j3vTvUAVtNZqWY1svy
 X16jSYngcHZ+oKhXsoaP1p8ytqPQvHxLajv7rljJnxyLnOklNa0wlgotF7E4zmksTiFB
 dPKHb3+ytasjWW1os8zzRf5z5mBsR5BTISlyVY5dB50W5M07Kz6yPy/QvlmNyyAc26e7
 J1Xycn2JDQc/Lb6ZKEPtmQC1QYBV4qI4IFy6gPU4aBvZ87wQxIlEIDvi/erU48XYDI8m
 KMB9t9aNxhrLfOmp+M7XbtnJJuaEZHFS2J/6ZKolzSFVRvuZhwlWcHACFjS8/fbTYC58
 pExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752696985; x=1753301785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/AtYD9Jpa1h9b2rOKfv0ARAI11DfXykPXpsug3dNHA=;
 b=E/nEgUmFeK6Ud0vJEBZHG3PzCRfYhj5lXmv5p6mdsql8XQyH6XhdZjd3qthu+iXuj1
 QVBaL05EZCBf+dAVCLTRgP3B11Lk+9oqr2p7+CPK+0eYBRcN3Ilnm5MTXBnq3D8tg9Gq
 3t3zYjZqXOO5pMAzldGfMQ2S239uEync5CgQMOie5dyoXxtUTStVIAKIsKuI6b1WIIqF
 0aWszWmJmldxd9ATTjr+1zQGNfbVnbXhr5S3BNSaEqqgKFv8QBr0f0Eo2icl0E7bjo8F
 07Ptx/+U3RHzJzsfsEVYoDJkd07zU7aJSBFHQQs3St8+bU9SKV/CWnL5WK7VCkfp5GvH
 q6Rw==
X-Gm-Message-State: AOJu0Yx8V61e9xUgqEW3Igx/waFkgO1o37aWRyloP+cXgR1yA65tQGIt
 UUMQysErVV68V1z/8glVHEN77GksJDJHqdEHY5DknkKKDlD0oRI5JX4Nx8bSw4P1ck2+mvvNJdG
 gXSrz
X-Gm-Gg: ASbGncs+R/fs7SuFv+k+/Dld9sJ999q5f5EvK11x+if07ZP1gpgA/QR8rJnuTT7QStu
 KmHVsQzH40Bf0DC3Cqn22W/o5/i3b4er3zdSh8kdxYDSh+nqW/2XAPltv4YfMxBAZyxoT2gztjx
 m4NQvj2eZQOq69xRMnJNl3pACZjVFH4smefnaqnJ5TK9+gY1M72ylJ+r19hyNsN58HkIDl/FkR6
 lAov0x3jwLqcBNlka1DLkkzpxlQJO2njFrruNNK4+6Ge5g45xXeyMcMfheT6qGS8o5R5xe0ynKw
 9EbmlB8M6fno7Dqmsy6fZELFcjNGWfe1xpX24J69mqY6/ZKm3EJeUgxQM8Jduq2ko73OP41g26l
 e5Xr9Bb4mM2WGJffrdVeqdMG7TafghalOI0ZnxCwr6FRs7jo2DmV4V1H7eitllrN/0zUrG4MH66
 U=
X-Google-Smtp-Source: AGHT+IH/KeUVAIpQ183Dtl5x9GUiIpHU7aMuFZsH7TnOGjiBKVaRLnpcErpoMNLLYqWVv8afh4HA5A==
X-Received: by 2002:a05:6a20:7283:b0:220:b161:431 with SMTP id
 adf61e73a8af0-23811d5b52dmr6814979637.7.1752696984903; 
 Wed, 16 Jul 2025 13:16:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe579b0esm14231805a12.22.2025.07.16.13.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 13:16:24 -0700 (PDT)
Date: Wed, 16 Jul 2025 10:51:15 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Liu <liujie5@linkdatatechnology.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v9 03/14] net/sxe: add tx rx setup and data path
Message-ID: <20250716105115.499a65f1@hermes.local>
In-Reply-To: <20250716082930.83026-3-liujie5@linkdatatechnology.com>
References: <20250715034152.7020-14-liujie5@linkdatatechnology.com>
 <20250716082930.83026-1-liujie5@linkdatatechnology.com>
 <20250716082930.83026-3-liujie5@linkdatatechnology.com>
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

On Wed, 16 Jul 2025 04:29:19 -0400
Jie Liu <liujie5@linkdatatechnology.com> wrote:

> +const alignas(RTE_CACHE_LINE_SIZE) u32 sxe_ptype_table[SXE_PACKET_TYPE_MAX] = {
> +

Prefer using DPDK macro __rte_cache_align where possible.
