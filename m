Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B0C02198
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 16:33:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED3740279;
	Sat,  8 Feb 2025 17:33:28 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5E9E54025E
 for <dev@dpdk.org>; Sat,  8 Feb 2025 17:33:27 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so26584545ad.3
 for <dev@dpdk.org>; Sat, 08 Feb 2025 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739032406;
 x=1739637206; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IAQrpRpJcuhexC0Xprrs8qRTEuxjyMMOMis1wQNNQ0=;
 b=PbkRFUpU5Sq0DPsL7Rc+q/sTTLHWFsUVN1ZbMrE9EB98FIDIlMDbbed+5pGk67rD0p
 a4nRuCWGbUJW3fM7Sdp4qiFbAm2NdJRCeKay+ju49qZZyU98YPVzAbgsTyTR2bBhPWoQ
 wqxxtOqrWJv4xlPKknyiRDvB674wPcIQX2fCQC9kOMWgGiJC0l6j7Qnl6ipNZkUOWeiO
 OHCvkM9czq+R8hgfAYnIe3lAN8FCuQLYFgMCL3D/H23sU4MIPOHGE95HjQq42cMi7CNz
 IcA7A3SYBR1adsYt0l0723mYx4oY1EBHvskEisMgXEcvmAqSMNamLp9gUeMQKSfsGTAV
 OAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739032406; x=1739637206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9IAQrpRpJcuhexC0Xprrs8qRTEuxjyMMOMis1wQNNQ0=;
 b=nZy+CtwjbCwt/ETOY4g5K19f5CSDoapqBG26nzSOazXQkJGBhMWQGRFZqJdpe4RdMB
 D5JQgGpOXQhNiy8tWDt83GhWrg6vT+aVGyZiU+NR6Iel9mkqJESO6cPDB88WxR+piYvW
 zoJ6C6uTdSgeIGDKb56FR7RWI+hYSeb2tAYOH8xA2eToE/oc2LjC1fctGhyloin4iyPn
 vPL7m3ZPoIBRZRSgPpp68btFAQ6t3y7tXDuOJQpl/Uz0byTUTH1HdDnLXpXjjkAlwghZ
 fZ0uSaeKUiG9UTkHM9H45SM/kRcZZfqa2bQObvNAhD217oUQgHQ2trhRrSMh+oOtgt/M
 +auQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1AZQPireYGeRiuq9TUGc6malG1kJVVq5Y8wdXYXLc254GlbLHsJ/xpXe9I9HgA3+94gg=@dpdk.org
X-Gm-Message-State: AOJu0YwWGDMiV9WaB4qJoHJZFrF8GRIv2pV7eH3USQKjV8t66qb46qDC
 1KnSXgJMnNu8TRXR7gixeTeED61VUKHkAUS0Ndat+33gg9eHCG8gUbOJqvjx0OY=
X-Gm-Gg: ASbGncvKwSRmZoil5ZCHdqlitEMnrgvJEjXLTb0h8rdo4LqDp3lkN5cDKlMdMeSprtl
 kGNXWvyRW5Fch1iMnGrO7y4Mja2Wie1cvOeQuxvajbn6ubFNGIget2m/vew1vyf9x0XsT9zP0Xn
 PvkgqzpB9DalQwEzkBRUzwGGtYRAKfXv2NG1G6WRBu4Yvgik3f/rCl/UtrZf9M+nElTwwxQpnGr
 aqs9cC3dl18d6rigdlXjD+cESJcSNhHzYRM9Ufw72GgqQYg6mDmOBml4K7AZ02AhS36poOfC+We
 g6NTWexN3n+832sB5zJMv6wQuilbuqwtbR/I5yNjjL+enu+B0fkdbM1Pt8KYqVpxbgrH
X-Google-Smtp-Source: AGHT+IEixYCuH5wrU31Jhuoz7PQoYWq6nCCszTTnLA5KMCQIMFSwv7vwzY4yK/sZbDkEIiU4fadegw==
X-Received: by 2002:a17:902:e946:b0:215:352c:af73 with SMTP id
 d9443c01a7336-21f4e6c4c10mr107279495ad.18.1739032406323; 
 Sat, 08 Feb 2025 08:33:26 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368bb4bdsm48158025ad.235.2025.02.08.08.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 08:33:26 -0800 (PST)
Date: Sat, 8 Feb 2025 08:33:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v7 01/28] net/rnp: add skeleton
Message-ID: <20250208083323.314e90ff@hermes.local>
In-Reply-To: <1738982645-34550-2-git-send-email-caowenbo@mucse.com>
References: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
 <1738982645-34550-2-git-send-email-caowenbo@mucse.com>
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

On Sat,  8 Feb 2025 10:43:38 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> Add basic PMD library and doc build infrastructure
> Update maintainers file to claim responsibility.
> 
> Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
> Reviewed-by: Thomas Monjalon <thomas@monjalon.net>

The MAINTAINERS file has changed, and this patch does not apply cleanly.
Please rebase and submit v8
