Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708FAC021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 16:56:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F3CD4113C;
	Wed, 19 Feb 2025 17:56:51 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 8031C4028B
 for <dev@dpdk.org>; Wed, 19 Feb 2025 17:56:50 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-220c8eb195aso141937685ad.0
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739984209;
 x=1740589009; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71CWn3+7yzdV2nuPl4ZQU8yIv0d+NDwXV0UutKgvr1o=;
 b=yHlCeKIiRhXLG4o0mSKT8xbUSbecfRWK/4PMEm763yuBDu2LOXFjT3lFe8lxFWt8q1
 WIQfOTB10Be3XeKnJ9yTBnbsLbV8TsiCH33MwM/OzVOu3iVdU4v8nQPZAiJRVJTjfO2C
 /Vc3Od3W3DWZskjCt+r2LCm/iBCbelSiE8wMTFy42tag1jve41YwaiU0n0XJV/kypiYz
 Jn8hHcchJPt7t4aul+V57J2DvqScPo0PJzjgHOHWdKqMX41AGFvEaJnwIfaq9DE3RWfT
 vlMLdWdFecfrCVmPp1JOvP3qkUCsqzPZ5x7WTFKUsckQt2NRzeQVnalhj7lYBV7ew3cX
 ZOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739984209; x=1740589009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=71CWn3+7yzdV2nuPl4ZQU8yIv0d+NDwXV0UutKgvr1o=;
 b=GD3tkrUHJwvRMrCEIxn0HoeweZ7DPNkMe3NlNo4/6NNOSwECvFovB6w0as8UrJtQel
 Y34Q2Y1kKt8afVfS/zF6ZvxLJNiblWcdqyJkAT7j85NjZSoF+mQV4u7LC+7KejRcbqNc
 P9Ce3lQZTMAZopaedRQ0JnCqS5K1snFhC87K42zeCxkENHH0vtkJ80aRHNTzuV4q6+r3
 aCVAc+wc4ze6PIgIXy2Fs7TKE6R5MO2iz97v56zV+wWK/cFaKBk2PWbpohnvnukNlSKr
 ovktIyYzQkNYk+UbAjpsPtbVtb/UB2qW8K5+XFlMlSnZQ+UT/1Jgzj9ZxvQHlb0jGBdh
 HNrA==
X-Gm-Message-State: AOJu0YwJTgFrMO5CAk/G5LeZ7aYT5QOsqBL5DH5Kh0uvB5oROhvhOp94
 bJsmEFOHigx28e4hX0AfNs9EJqRa4u8hQJQIcQ6iJ9vgFjRZOknqOq8DDVz9DX0=
X-Gm-Gg: ASbGncstG+WMuWyJYc2jAsoZ9ODMDE1uGQ6xa7mDqs/Zcj0f98zVQIRS4wcZMaafDgI
 eD5AKQYXqXWMF3dZz6FSDdoYNM8GupBktf6keJqh/bxP6qhxQEnv+JJZrw8ng5C1RtU2rWg01UN
 wDU42JmDF2xtM1h53aAXANe/6lVcdNGqOTitqqyYzlfI1Lo0vTDtUQ7rESkOl7BAX9bbQjHgJtY
 m2+VQ+0hv36CvDXGsGmU2l2dIj5YKN6Ow7sdapaaXTn0s1d0ZQzbaUt2eIt1Rv6V2epqWWIfJa4
 P/KWNmoESGT+K6jDLSmYW8mdziC0F1OwMnexS2+D69CE/5wtTiJhqMtEHRAV7oVpt3Je
X-Google-Smtp-Source: AGHT+IG8bj5ycACyakMkOCzpmJnls2r+uGAZg2FXdmJZmClN/qsqYK3L+JN4FOHxE4ld3JhlAMzOqQ==
X-Received: by 2002:a05:6a20:9150:b0:1e1:e2d9:7f0a with SMTP id
 adf61e73a8af0-1eed4fb222dmr8958494637.34.1739984209608; 
 Wed, 19 Feb 2025 08:56:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73277135839sm6609269b3a.20.2025.02.19.08.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 08:56:49 -0800 (PST)
Date: Wed, 19 Feb 2025 08:44:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Gaetan Rivet <grive@u256.net>
Subject: Re: [PATCH v7 1/4] bus/pci: fix registration of PCI device
Message-ID: <20250219084434.33cb082b@hermes.local>
In-Reply-To: <20250212163836.178976-1-shperetz@nvidia.com>
References: <20250206105428.237346-1-shperetz@nvidia.com>
 <20250212163836.178976-1-shperetz@nvidia.com>
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

On Wed, 12 Feb 2025 18:38:32 +0200
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

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
