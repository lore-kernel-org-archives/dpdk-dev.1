Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E3DC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 19:01:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C90C642ED5;
	Fri,  7 Feb 2025 20:01:30 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 6B09542E90
 for <dev@dpdk.org>; Fri,  7 Feb 2025 20:01:29 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2166651f752so55077155ad.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 11:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738954888;
 x=1739559688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kIpy7M1Io5HfQCqkKdGWOhJzOWwGETjgS6vWLwuQHS8=;
 b=s07PNOgMY+OcThtj/raYNWFAYThIz/hXpmOnipxv1vTM1Tx+ztSzI4ovW+XNH6djxO
 JAGUqPSqJxYqEBRikaZLdf7NB+Ofyk3H9Ax6gS6nXlzVONsmZtoD2hefN/VmDK+05LmK
 YMw4eE51MwKdXe9u2hC0dbyyVvtSQMr/PhwlQRCqVyecKuu/6vgzcZxgyzaYfrnkibI7
 R3cpoP78vJ7S4YHLg14P55o8JI4a+tWcgLJi9X0X93tNdwTUYRR4Kiw3fcrBVY5Xqucy
 z2BS5qjOF1yYT9rSkn94D+wFb6BqxtS5JxquOAjpF8hjMqnyKUd8gE1dOQS7FNK0/JpD
 nGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738954888; x=1739559688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kIpy7M1Io5HfQCqkKdGWOhJzOWwGETjgS6vWLwuQHS8=;
 b=Lg6WlEzFqTPJ8+qXeCq9w3/VBGRVFaiWfTj/IQH9ne195VKc7B7lawRTCvSk3lTfiZ
 /TNp8ULNxqTuqf26Ktkd7jBLdFxoipj3+klKw/8asVEqWWiUplwgQ3+/je3rns09fitJ
 ErXf9klV2A5dLqEdOQgbWnJ0A2PwrmEHgVusnO70FaCBPKtd6wCpAnkngY+28nrUIcvK
 g2XZZN2BJjytH308d/fB5dLGw/qWHbp56eCuqSCB26PNm58WaYqdaqidkRVoDHucjANN
 KOgKNxoQ3XNo7c0osqxnx4BcfFrggnOqz7cxcMY3JFZS+E66W8ajN0F46OUf8S1ZcTLx
 Y7Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVke3pTQ6reBBjOqA4tX7oI+9Rlx0piNOn/zNYYuyaYcH2Rv74vynbv4ivu4rvwIIUuGvU=@dpdk.org
X-Gm-Message-State: AOJu0YzzgrgB/3YJRkN5gkZbkZVksLgfy+HIm2IDgu4DvXDDAJq8AuGz
 X14RHG18+QMbaJ4aBxA0a5cWKO65Y8RefXMDKJVJu+3NQ1g4vGs96LLIQyMGC04=
X-Gm-Gg: ASbGncvwHqRNByBL+wSc0Sni5miVS3zEDgjjES0j/+m9qC0UvDVcP6SfkMZ1vxysSMA
 L6u8UWzrIg/VMBteYm3c+xzx0pAOGukqqdXisbLrtgTyRN1xNyO3orq8O6H7AZSSH2vhkr3f3vC
 dqtK0I5rpU3A63sua2cZmeWtexE5fNg1pZYbZKjoheKxUr8DYeMxgNgF9qZt3wFhDl6rHUfP/wS
 O6Mxepf6Mfb9nkVKSz3S9v1PQM+DWJmlYnz3nFqsWC3wb2Voop+yM0LDL+MWJxTRguIIUZGv15A
 De5vkoD21iJ1IqdFQfso7IcSKOUy6tp4J1WyoAnvYsCetMT+E1mY617Iqs4u9ML3sIxi
X-Google-Smtp-Source: AGHT+IHVl/pLG/aIVe+bo9Q2xWWBz62E9/nqjgDzfZ8fiLHXMYG+0TDqAxo1WU27Cl9EjO0vjnIHEQ==
X-Received: by 2002:aa7:88cb:0:b0:725:eacf:cfda with SMTP id
 d2e1a72fcca58-7305d51bfafmr6647621b3a.17.1738954859682; 
 Fri, 07 Feb 2025 11:00:59 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048bf13d7sm3427202b3a.99.2025.02.07.11.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 11:00:59 -0800 (PST)
Date: Fri, 7 Feb 2025 11:00:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 ian.stokes@intel.com, jochen.behrens@broadcom.com,
 vladimir.medvedkin@intel.com
Subject: Re: [PATCH v5 0/1] use 64-bit shift, avoid signed/unsigned mismatch
Message-ID: <20250207110057.458f9188@hermes.local>
In-Reply-To: <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1738950069-21059-1-git-send-email-andremue@linux.microsoft.com>
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

On Fri,  7 Feb 2025 09:41:08 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> This patch avoids warnings like the ones below emitted by MSVC:
> 
> 1)
> ../drivers/net/ice/base/ice_flg_rd.c(71): warning C4334: '<<':
>     result of 32-bit shift implicitly converted to 64 bits
>     (was 64-bit shift intended?)
> 
> 2)
> ../drivers/net/ice/ice_dcf_sched.c(177): warning C4018: '>=':
>     signed/unsigned mismatch
> 
> The fix for (1) is to use 64-bit shifting when appropriate
> (according to what the result is used for).
> 
> The fix for (2) is to explicitly cast the variables used in the
> comparison.
> 
> v5:
>  * rebase
>  * use uint32_t instead of uint32, to better conform to DPDK standards
>  * rename variable rqID to rq_id to better conform to DPDK standards
>    and avoid checkpatch warning
>  * use 2U instead of (uint32)2, which is shorter
>  * simplify expression in meson.build using compiler id "gcc"
> 
> Andre Muezerie (1):
>   drivers/net: use 64-bit shift and avoid signed/unsigned mismatch
> 
>  drivers/net/intel/i40e/i40e_ethdev.c   | 22 +++++++++++-----------
>  drivers/net/intel/iavf/iavf_ethdev.c   |  2 +-
>  drivers/net/intel/iavf/iavf_rxtx.c     |  2 +-
>  drivers/net/intel/iavf/iavf_vchnl.c    |  2 +-
>  drivers/net/intel/ice/base/meson.build | 19 +++++++++++++------
>  drivers/net/intel/ice/ice_dcf_sched.c  |  2 +-
>  drivers/net/intel/ice/ice_ethdev.c     |  4 ++--
>  drivers/net/intel/ice/ice_rxtx.c       |  2 +-
>  drivers/net/intel/ixgbe/ixgbe_ethdev.c |  2 +-
>  9 files changed, 32 insertions(+), 25 deletions(-)

Okay, put this in next-net
