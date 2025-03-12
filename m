Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFC7C28B2F
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 16:29:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0608740BA0;
	Wed, 12 Mar 2025 17:29:27 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 68C7E40B9B
 for <dev@dpdk.org>; Wed, 12 Mar 2025 17:29:25 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2239c066347so760795ad.2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741796964;
 x=1742401764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKbPOADSbzsfzB56O+zIWSE0cu2PoI+a1p69ZhemJyM=;
 b=zmm3PftMqj0WeaztQ6FVK5KUjjy3bpij3t4kYVH1rWIsQk8TjJ1bm4dHl2AuiVJCWv
 8jhcrBdVJwuHJPSB5CqZIZpsim1SGwkpUERjeDZfnxvPJLBi9Foo4pMBUFzccFcuUkYs
 lvEXE4FhVflGBu/Gq4Vz2ussWkHoxy8Sl8+jhYWk7u0PhsChHrYhm5TozHfTtgszhloA
 VoDkEfpFwySUhWy5FNxHMkcxTEl444YyG7hFXCmy4OLKX2t8aofwqr99tfe+2BXni9HW
 a//d+VGQl25ewhZgGNFUvWDvJBEDq/YgJdtwWEjWKyQxDoqQRxJ0g0ZAo3FqwPqUekGo
 AbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796964; x=1742401764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKbPOADSbzsfzB56O+zIWSE0cu2PoI+a1p69ZhemJyM=;
 b=WwGEV+qgCSki5mAdpLjekWwdkAVJ5TzGtD6R9sAGJ0+T4gTIy1p49Oqoa+Raunbe93
 y3yluZmRD7irc1rTZa4IxetJejJjRNbz2nUpZpV6qLQZkXVZJA4BLkRFmvaAh2S5KaX7
 /4RbOTmgD0yuXUy8QfVNnFfgQL5JTIGj9ATd+USH17mijguoNDRDVqgua+tj0vVAtSog
 aZjZAM+YxXlhbSKSwX5ASwnaLgg1cBccDM6nN6IRiUhG6gvvblYIdm52EwAORurEde94
 wEAms+17ggMTJZusTSPnYC6kozL/ezBDICfG9V9bu3L8taxHTBZ+PoRVdZCm3unUvWte
 9CwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBEzsLF01XvX4E+e6TclCQpL9fwmXqNiuoBUwu+M61eCKgCbw1khryYtGI+IUCG3Ul99M=@dpdk.org
X-Gm-Message-State: AOJu0YwqIDs4xsroLUpfUl/Qnb42thqfqh6Xd4SUDKgUdeCIMDE6lflx
 bW3WdFgIwyKd7pUIM8ArmHfdk+3hS7FpdEL8il8mP4GxtGXoMoSqjQQ0O0Mx5Eg=
X-Gm-Gg: ASbGncukwFnSCJ1uuHOlLEpT8loNWvwFoadcoBBkvoWq+DG4ohck3dmUPXjSBzLolCN
 n+iWbHEav+ofrTL20kf0J9G8tAIXkNQOh0dzUM+hN6XuHcwvdUVxY9Pcg3NIrxvCmf4h6uoLR7I
 FJExH74kO8655VmwwGgzYrGwJPxQlqGvifVCskZ+tA79a/r2ierwxffpFtUv9eBTKEi/jmAdWV4
 nvJeO+NZH2FmgXqOHX8umMquLP5BKyKF3mlAi85Y61GBvi4Mv4gCOCCvZFeptgZHBZ6kKbdPv+l
 ulDU0GAQ9hooNkmyz3UV9yi4Y88PxFsIllPzGxZlJBkERYvRuVdJ/AS5AsFbhRPNT3H+7O+k8kf
 0Xc1nGzEdh8hbx4dIlLt+Kw==
X-Google-Smtp-Source: AGHT+IFcia/JktOaIOJ2NQfkD46HYVJHGQFQ9RAm1q3InwSd59DINJSCKzYWr4BhsUHEBPFxpasWfA==
X-Received: by 2002:a05:6a00:21d1:b0:736:34a2:8a20 with SMTP id
 d2e1a72fcca58-736aaae4d01mr35737180b3a.21.1741796964239; 
 Wed, 12 Mar 2025 09:29:24 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736cc5b2c77sm7357074b3a.163.2025.03.12.09.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:29:24 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:29:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yang Ming <ming.1.yang@nokia-sbell.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] eal/linux: enhance ASLR verification
Message-ID: <20250312092922.32412cd7@hermes.local>
In-Reply-To: <82920758-20eb-442c-a62b-a3babb65bfa7@nokia-sbell.com>
References: <20250228094405.1437-1-ming.1.yang@nokia-sbell.com>
 <20250310144310.70ba71e6@hermes.local>
 <82920758-20eb-442c-a62b-a3babb65bfa7@nokia-sbell.com>
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

On Wed, 12 Mar 2025 11:13:27 +0800
Yang Ming <ming.1.yang@nokia-sbell.com> wrote:

> On 2025/3/11 05:43, Stephen Hemminger wrote:
> > Caution: This is an external email. Please be very careful when clicking links or opening attachments. See http://nok.it/nsb for additional information.
> >
> > On Fri, 28 Feb 2025 17:44:04 +0800
> > Yang Ming <ming.1.yang@nokia-sbell.com> wrote:
> >  
> >> This change ensures that the current process is checked for
> >> being run with 'setarch' before verifying the value of
> >> '/proc/sys/kernel/randomize_va_space'. The '-R' or
> >> '--addr-no-randomize' parameter of the 'setarch' command is used
> >> to disable the randomization of the virtual address space.
> >>
> >> Fixes: af75078fece3 ("first public release")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Yang Ming <ming.1.yang@nokia-sbell.com>  
> > Looks good, I wonder if the personality() check can supersede the need
> > to reference sysfs here?
> >  
> Hi Stephen,
> 
> Thank you for your feedback. The personality() check is indeed a useful 
> addition to determine if the current process is executed with the 
> ADDR_NO_RANDOMIZE flag set, which can disable ASLR (Address Space Layout 
> Randomization).
> 
> However, relying solely on the personality() check may not be sufficient 
> in all scenarios. The personality() function checks the attributes of 
> the current process, but it does not provide information about the 
> system-wide ASLR settings, which are typically controlled via sysfs 
> (/proc/sys/kernel/randomize_va_space). The sysfs file 
> RANDOMIZE_VA_SPACE_FILE indicates the global ASLR setting for the entire 
> system, which can affect all processes.
> 
> By including both checks, we ensure comprehensive coverage:
> 1. The personality() check verifies if the current process has ASLR 
> disabled.
> 2. The sysfs reference checks the global ASLR setting, which affects all 
> processes.
> 
> Therefore, while the personality() check is valuable, it does not 
> entirely supersede the need to reference sysfs. Both checks together 
> provide a more robust determination of ASLR status.
> 
> 
> Brs,
> Yang Ming

I wonder if EAL should have --no-aslr flag and call personality itself?
Maybe not since it would have to happen early before other areas are mapped.
