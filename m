Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EDC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:24:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17F6B402DA;
	Tue, 11 Feb 2025 17:24:38 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 4185B402C9
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:37 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-21f49837d36so67038865ad.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291076;
 x=1739895876; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSxRubKSgLZWVrsWNeUhL1kPYo18oemXwmvh6NdAlTw=;
 b=r83JHFfWOwQIa+K4FngFkGDYfCH0berUYA3SC+o6koaugMRqO+NyqMHtKeOoluwJQc
 19pwvClNm/Ads9hMFcxHmez5cbg/9QT33O5mhpW8PpXlxfDXrzOEMigvP0/RAj4B0KnX
 BJlA22txwk+zLVqRKoXaYggEkdDxaKbkSM1TwFq06x8v1uGU44VCneOBY0MjlJMQOm3a
 XB8FK2MNtcHaWsi/7VI9fTZJO3yN3q0vyZ2N0BQ32uAC98SCpzGXsaDsVaemnhJtjY50
 97ApNELoIBnCOPBkJbG/HU04LA4CQVvaND52ctGNpM9qcPuxOJAmE9BftJ/bjDeQpiGt
 VGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291076; x=1739895876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSxRubKSgLZWVrsWNeUhL1kPYo18oemXwmvh6NdAlTw=;
 b=iEUTXO9wGV9UZKZoBvNMT6PLL5SvHFeXqqZvII55Pda3fwTJCT1nDFI/scp7aCLjl2
 UltwcoPTD7aABNDiJKp/LOpN1sEFTa7xVb/gOv8njF3NYW4+98XSIp79QSsy6JXMBy4R
 Nao8owBdJ5W4/Df2nE8V6iCXjkbHAHAMD43v7p82b3SQEfsoJVUqdbuiSLAnpc0sKgyy
 nAbHWyMNiCPzr/hIO81b5cmzid7vcmAX5OQRjr5xOCBunjfeQDyyADRFYO00amqXkbq0
 qS9TA6TMHIAOIz4rgOBydHNZ1gJy5d5mWsbBlyTK5+039e0rHWFd24eKcLH1q+3bquA9
 X7qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl95dl7ymufgxVhpkNfsd2CT83F+tToWKGlXsYLJWVfG8S/G92QxG5aXpVzCkVCVmkX2s=@dpdk.org
X-Gm-Message-State: AOJu0YxehCxtfn3oR2Nvwh1mjzzSHc5kbjoZlCxUb8auQI59RbhrmK4T
 Mv+GDdmfRBsa2IqAA1N0pia3ov3Js7+cKGc4Z0qemCHIW7CqUYirjlBw6FztIMM=
X-Gm-Gg: ASbGncvZEggfC34TgosnmGnuz+6/+/vx/MaaopdQqCR35vLdndvTHR7aTiZrO5ENxnW
 Lo/c2BKqvy50dX717zQigSYRSXxjmUOTioqGbVc6oMuL1Iihv0Qk90oOS6iRtDb+C5JBh2RalBT
 2QWANiV9ou3zyrLBLXwECrv6+fiWPrun7IMAvEFuwJtkM2vfUGRZJ6WA85UGhlNXyQxexMzoSpX
 IR0UjVClCaNNkDdfOcPS0eIlm93OuaR+oOweVKqtqAP42V5PvOWD6qkCBwKrFSSxUDDZ4q4obXo
 eCjQRF19KdDMDasIfEzJBrgBzUbQRP8hg3E1fW449Uze8uItiLveGSweCnVOf7DVcU/g
X-Google-Smtp-Source: AGHT+IGJ+kg+3ua+exey0D/jQckVjyuU3++3Z2xLYTs5q8yV71LusNM6iltQJrL2i1O3rmF7/bUcJg==
X-Received: by 2002:a17:902:ea01:b0:216:5448:22a4 with SMTP id
 d9443c01a7336-21f4e6a037dmr273303615ad.10.1739291076289; 
 Tue, 11 Feb 2025 08:24:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:35 -0800 (PST)
Date: Tue, 11 Feb 2025 07:24:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 04/28] net/rnp: support mailbox basic operate
Message-ID: <20250211072406.59f15101@hermes.local>
In-Reply-To: <1739263818-59770-5-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-5-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 16:49:54 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> diff --git a/drivers/net/rnp/base/meson.build b/drivers/net/rnp/base/meson.build
> new file mode 100644
> index 0000000000..9ea88c3bff
> --- /dev/null
> +++ b/drivers/net/rnp/base/meson.build
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(C) 2023 Mucse IC Design Ltd.
> +
> +sources = [
> +        'rnp_mbx.c',
> +]
> +
> +error_cflags = ['-Wno-unused-value',
> +        '-Wno-unused-but-set-variable',
> +        '-Wno-unused-parameter',
> +        ]

Put the first item on new line, meson is like python and similar style applies.
It is disappointing that base code is so messy that you have to disable warnings.

> +c_args = cflags
> +foreach flag: error_cflags
> +    if cc.has_argument(flag)
> +        c_args += flag
> +    endif
> +endforeach
