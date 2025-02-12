Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8389CC0219B
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 00:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92495402BB;
	Wed, 12 Feb 2025 01:39:18 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6865640269
 for <dev@dpdk.org>; Wed, 12 Feb 2025 01:39:17 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-21f49837d36so72386575ad.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 16:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739320756;
 x=1739925556; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5tPzGE2HWYCbyiS2V+d0yyuICrl4X6mb8/8hGL11/U=;
 b=N3AzouCnF2e8NwB4mcxQXD7ZqJBAQvHoiFjqzifdctiIheE9sZUcASwoP/ThGIXA+t
 4gyYpOuUNfNtkt2oG2uc60yKiXyWNI6DEFL5XQm3bv85HR5yD6QMyb+kw7IAtIZL8Tta
 NeHhdkWLAAh5mWSFaPA0GoESW3I0emht0vnqYi1Sg5KDx4kPjNoYa8ObvyR/z7fy3J3W
 uZ7APcEGc5GCtEHF6smUIgMa7hONnR2lwylTH1lxGhNsL3SSzq+cizLdSJHPxhlEVz4T
 84tTbyBVydp6K688cji2ffwj5U+eOX+iOjPvjP/5KrZh4XNZ5A8IGgBKY3zywlXacizP
 suCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739320756; x=1739925556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5tPzGE2HWYCbyiS2V+d0yyuICrl4X6mb8/8hGL11/U=;
 b=XDq2MT2LIfMst6CHFG/sc9WBNhumeEKarGSOYDrtlRgHGiHZXJ4u582KPk8ciXkuNa
 FjMWg6BQAEwgrOEgi10q9U46vCPSFg2AsnfwyOvTHm2l5NH6Fe4DN6xcaTpF/bHykZXV
 DwbXhq+SJqXv+a75UwmJiQnxQYfQEyyxpRCQBntizNDcfQu8HNSVHTISswsqKY2CyytF
 eUXaepxVRaahtK1XkhIExdqmDDRjMcMkf/vQl3Gob6XlAzh9vF1E0tW1C3wmPPX75S+v
 SGRMnu15/GOM3Y07iTDcTMoXlxDseJiNRBhLlx+IfsFR6zHmAjuwlO1rBDQ201u8mbtd
 UUxw==
X-Gm-Message-State: AOJu0YwG7+l3UthrflKhVHBXVGoCUUwmArYoDSxqCj8Sds3W1Y5h/TG/
 isfTQKR4EVXDkz5BrQWO/m6JiSML+miEjJd60hS0JnhuI7LzIWFvsXXCEuIBcM8=
X-Gm-Gg: ASbGncsKghBuBqiLRv8QA4CvJOK/edtYQz8KF2SvXvuu2nJ0qNoUl4vh4PnSSw9Na9Z
 VpvhWRPln0TuTjiiSK8fP1FE43RgDOSaELbLGLxJkHacp7ZCEZBxxpvfX264zb7Pvg5G99QX/NN
 mZo+J5L0BwKq9b8bUHJxHtkiqMDZnWznuipPdjRbTHlkbrnrY7yKDy2Y7z+7gOfe4ja3wa5JYsb
 AtCvYw+iYTbJ+11UpxFZxikYBpIaQrckynkj4FclQ0Fnomx7qoctz3lcXtTdZ+3AzWuTRSizgHu
 fZoY9swt0BSPMSqQF1xq24mOb+jHr5XhCVTaka6YU3dRsXZyzBSyTw/jGneUeSsk4pj6
X-Google-Smtp-Source: AGHT+IEj7wEu6IGzYolM/th4bGZdnMHijTJSWgUlHjbymhWPmgz3mqL3DLywIvStwrN/QDAwaCcV0A==
X-Received: by 2002:a17:903:32cb:b0:21c:17b2:d345 with SMTP id
 d9443c01a7336-220bbb11376mr18385805ad.3.1739320756465; 
 Tue, 11 Feb 2025 16:39:16 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf5b93282sm86500a91.1.2025.02.11.16.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 16:39:16 -0800 (PST)
Date: Tue, 11 Feb 2025 16:39:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: Re: [PATCH v6 1/4] bus/pci: fix registration of PCI device
Message-ID: <20250211163913.281f9cc6@hermes.local>
In-Reply-To: <20250206105428.237346-1-shperetz@nvidia.com>
References: <20250206000838.23428-5-shperetz@nvidia.com>
 <20250206105428.237346-1-shperetz@nvidia.com>
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

On Thu, 6 Feb 2025 12:54:24 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> When registering a new PCI device, the device->name field stored
> the user-provided string from devargs (e.g., "08:00.0" or "0000:08:00.0").
> This approach led to inconsistencies when registering new devices.
> 
> This patch fix this issue by saving the parsed PCI in device->name,
> so when a new PCI device is registering the name displayed in the device
> list will be the parsed version.
> 
> Fixes: 23eaa9059ec2 ("bus/pci: use given name as generic name")
> 
> Cc: stable@dpdk.org
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

This part looks good, second part needs work.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
