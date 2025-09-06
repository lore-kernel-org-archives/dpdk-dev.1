Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD46CA1012
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Sep 2025 04:00:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A08DA402E5;
	Sat,  6 Sep 2025 06:00:03 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id AF3EA402AF
 for <dev@dpdk.org>; Sat,  6 Sep 2025 06:00:02 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-45dde80dea2so562135e9.0
 for <dev@dpdk.org>; Fri, 05 Sep 2025 21:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757131202;
 x=1757736002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOQ+W1M9v+oawoGkZHZxe+Fl3iQkx0uZTwAv/ocxVnE=;
 b=IMX1qU5iRjFZkueuX2wr4pIZcrNtKwQd3GCIOSBcVnGIZmNXoJe/weB+Ae3Da4HedB
 EkeYlXmPcpkYsQa8lbfGmk9u5eLooioTaFrkPJ1ALK8UKWWoLE6Jg2DO0d3mDAiXYBIh
 b3kS2V/36yCFSlOA+/vpRMhX+pwIKxEO/Z9uo1A6hS18QExAek0aHS470A2ML5iHq4qg
 y1sbERR2vrJgKwwb8e2aSKB/tC/WPa13sVzik5asZb3mtuqtpASCYJ25AvBzQ4ohxjy2
 uka4BGVP66HQ1nfHN9BUP8u0rFrVXTIX3BZdok9mWGJCjWg3D7HQ0m6cQgG2JXORWr5S
 nx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757131202; x=1757736002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOQ+W1M9v+oawoGkZHZxe+Fl3iQkx0uZTwAv/ocxVnE=;
 b=FXudAPFXtDuhN5Lj54zuexMR3PKITARCTY5f3PhmAwcH7u2P8uTe2f2d47yTMzipuM
 rUsz0HBJNewgpEPAO0rJ+FdP3J79KqV9Gx3ohy7yzjziNk/P5fuwcCLOnYqd+B6zctDp
 24acZ2ERD0HGdz0f4yaOE9ASRV8kpYftk3hkCbQ2CeRA0nOG3OxlgibRywpqeAKYXi3I
 GG5z7mTJhdLxJ03If64Jh8TBOnnuLtySYCjhak1nB3GlOUJrtFnxIX2YKjpm9CZ2zDwZ
 JHVqr59VknyxNZSxA7zWq9JzMQ9UiFRGPaTDYMs6xFU0PJMdGHv1yXZMONZxYkGvTZU4
 5FmA==
X-Gm-Message-State: AOJu0YwvjWcrRWiXlPvpuPRusahKOw1dITUFdEm9jYek7lJmPDE03lhD
 POxzQZhxJGl2Vmb1qKyFYFZLnyFZudxl8HR8s5HgDJmNXEHOVl3SiRW4mUj9eXwTipw=
X-Gm-Gg: ASbGncu5zkfG+n/9eDBqX3hSXfXD6FAvNSlODNIoYcvyLi+pg0zFyHLs+YGXtvOJ45D
 Xhfck061BWfurcy2ZIzxxG4rGduimTlKCJyGnpArCJMWxw8U1uVJbSIIUUGQd36IVgjTfljvN3L
 68BoBBT+X5V1p6hNaWQ+2mA3bGhXY1dUbG1OWyyZOF4tYFEUKA3p3cVLWHTphkwDBdKHE2BiyLQ
 TnGcB9M2qIBCmOctXcTEeIEBfv9fq/yFPLzE5TYKlIOADX9S07VgTqQA1r0q/tyVEKuY6Nh93dy
 FXygAZ31AEMRUoVSwEvE1/DEBEMxBRRAGLsAJ3XC3NQrabwZGnM9v45/U7DBn9V6clXkeQIO1ZH
 hIaH3g/qFArOfE2ItJAALp762wyg6KaW9BJactNSkoJ8UoPSyrQk8rRvfJnWBj7QAc0Qn7nTJgy
 vgrMdYRUaMVQ==
X-Google-Smtp-Source: AGHT+IG2rzzTObb0MR/qbAyQWM2W1s/3C7TUc1R+l4p1OAt/kdgau2cHbx0gi42s3XriulTWrXv/DQ==
X-Received: by 2002:a05:600c:548a:b0:45d:db33:fa0a with SMTP id
 5b1f17b1804b1-45dddee3772mr7107925e9.33.1757131201897; 
 Fri, 05 Sep 2025 21:00:01 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45ddb779eb6sm37072545e9.8.2025.09.05.20.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 21:00:01 -0700 (PDT)
Date: Fri, 5 Sep 2025 20:59:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Devendra Singh
 Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Olivier Matz <olivier.matz@6wind.com>, Edwin
 Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: Re: [PATCH] net/qede: reduce the optimization level
Message-ID: <20250905205955.74b15b75@hermes.local>
In-Reply-To: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
References: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
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

On Wed,  3 Sep 2025 13:32:52 +0200
Thierry Herbelot <thierry.herbelot@6wind.com> wrote:

> The qede PMD stopped working under Ubuntu-24.04 (using gcc-13) when
> compiled with -O3 (default level for all DPDK code). A bug is opened
> for this issue (see Link).
> 
> A first workaround is to just disable all optimizations (-O0), which
> restores packet Rx with Qlogic NICs. However, the performance impact
> is not acceptable (around 50% drop).
> 
> A better compromise is to use -O1 for the qede PMD:
> - there is some perf impact,
> - but the PMD is working as expected (packets are correctly received).
> 
> When compiling with both -O2 and -O3 and gcc-13, there is no packet
> reception when using the qede PMD. The root cause could be missing
> 'volatile' keywords or missing memory barriers in the qede PMD code.
> 
> Link: https://bugs.dpdk.org/show_bug.cgi?id=1379
> Signed-off-by: Thierry Herbelot <thierry.herbelot@6wind.com>

Since GCC 14 and 15 are available do they fix the problem?
If so, the the hack should be limited to Gcc 13 and with
more complete comment.
