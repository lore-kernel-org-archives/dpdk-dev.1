Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D1CC35FF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 15:34:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B959040613;
	Mon, 10 Mar 2025 16:34:39 +0100 (CET)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by mails.dpdk.org (Postfix) with ESMTP id 7AC9F4060C
 for <dev@dpdk.org>; Mon, 10 Mar 2025 16:34:38 +0100 (CET)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-224019ad9edso100616755ad.1
 for <dev@dpdk.org>; Mon, 10 Mar 2025 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741620877;
 x=1742225677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdWlvZbMFlDoR2ercLr8aRO6kL4TvXuYdTEm80Zithg=;
 b=xueEKsc2qyWU1WyS5+DT7BXBDPuhBQ/Iy96pPScq6k5P3l9Do1eAPYOrkX9nuHA9qT
 NcFrgIqaUrGzYYBuVhrV6CfW7AsybqCO3eZRT53P/N7jzhs2dew9m8j5XsXetvsMs/vd
 rKC0CicqL96JZshH6izBmLuMkhO2YVCN6lEOwTdhcyu7KzoSCXPJ7xkQlVCl3UHtrjzT
 rDvh+v4wZpqq8U748Igw7To/VnrbWJRr1lKvb0ywSBWrnMlr2IIFepa86RfjApFcniqO
 ItnrhFmbQIR5vh+bQjzR1Kb2x6hx0qmvWoUX/y1xLgoVEakapYneM34Y/9tEceiSgU9d
 2RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620877; x=1742225677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdWlvZbMFlDoR2ercLr8aRO6kL4TvXuYdTEm80Zithg=;
 b=eFvrZybvKdZvFWE2jy79DckwLhGa5cr/KxFuK6jTsi4biRtJ5UIl3HVA+XbvDPiApk
 bFKgdb/eACoscavEepwH8LHr7NFB6CjBio56S87rcBN5leVd80IE2ENNCbaFdwziCYmQ
 X8lqft93HiRMlBdrBbWIG6V8j6HRXgZ7VA3Xj0f3DOqT7ibsGnxOfZymcvAz5tXB4eSv
 BWrYQcLJ9puvNdokeBk2lRGjH/STaxSFbgyrY/Nrw8eN5+fH0VkHai2WQk0lT3WOIkhe
 RN+rbMsGUKLLnRETpdb6PJAuJgAJLWEknHxgaLQoKREa0xvZYo7egc3oojVFt/+j1Rew
 9ofg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZCTnGT2CMdNrbtD62aPmN1YKhOc9kECez857S2mnpF90f+UN/bN2JGMfYtN7UQrt7Ick=@dpdk.org
X-Gm-Message-State: AOJu0Yz1c2prZc8rS1zuqwvmRCEERlMWvWa0zB4omfhS39M9gHt3KBgV
 PNhtpTIRlRZJbg0kmW8Q3sJd8iB2QDqgNyK0KCcojOP+jCdiP19cxpE1M/PIJa8=
X-Gm-Gg: ASbGncsd+NY/+hhD6uWkRAEcaEXp9YT7CsoVSjGrO8J9Hj27HznvbqqMGpt1rcbvvOi
 C4tF/b/R8RJ264Xo7YFqQ+cWarQoIk1elYpRHH8K4pqjp1rEoQX9z3XuDOX0ElD2HE7dgYTZYih
 7WP81Zdut5Ln701aKHiXslkBl12r8Ka2o36wr10cu2aBQ7jFJLPgnxVGucazWz48O0JSPtkWkgJ
 H0pLR4TgzUKwGv1F4VxF3h1dbPPZgHYLp/EY1metE405DU9m6FCNBeixBU7MAufmQRUcNpr93ir
 FZoUKdEsEHJURtwRogTndEjtckvVZ+NDMKvPB62eXrZUCiykbYcrvIpz3jvARgb9EulBRyYodE/
 LESM5wD2qQn4sRg2d8kgXYw==
X-Google-Smtp-Source: AGHT+IEoS/HtqdLj3LqMTajQ2SVXBo4OJhOBudy7OOuEa1Xl5R47kf2npn3aUEKj9oMHNzM+WKBODQ==
X-Received: by 2002:a05:6a00:2351:b0:730:99cb:7c2f with SMTP id
 d2e1a72fcca58-736aa9d22f3mr21041828b3a.6.1741620877665; 
 Mon, 10 Mar 2025 08:34:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7369c682088sm8244167b3a.89.2025.03.10.08.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:34:37 -0700 (PDT)
Date: Mon, 10 Mar 2025 08:34:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Thierry Herbelot <thierry.herbelot@6wind.com>, <dev@dpdk.org>, Thomas
 Monjalon <thomas@monjalon.net>, <stable@dpdk.org>
Subject: Re: [PATCH] ethdev: fix get_reg_info
Message-ID: <20250310083433.39baff9c@hermes.local>
In-Reply-To: <11224e6b-4101-415e-bab3-b526688bace2@huawei.com>
References: <20250218115828.2107335-1-thierry.herbelot@6wind.com>
 <11224e6b-4101-415e-bab3-b526688bace2@huawei.com>
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

On Fri, 7 Mar 2025 17:40:17 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> I think there are ambiguities in the original API definition:
> 1) the width was used as an output parameter in current all PMD impl.
> 2) the offset was unused in current all PMD impl.
> 
> But maybe other non-opensource PMD will use these two field.
> So I think it's OK to copy the two fields (maybe another field "version") before invoke _ext API.

It is not necessary to accommodate drivers not in the current tree. If they get broken, not our problem.
Having a stable driver API was never agreed to.
