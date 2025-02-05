Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E7DC02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 18:35:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F1C540270;
	Wed,  5 Feb 2025 19:35:32 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 509B040261
 for <dev@dpdk.org>; Wed,  5 Feb 2025 19:35:31 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-21f2f386cbeso1299785ad.0
 for <dev@dpdk.org>; Wed, 05 Feb 2025 10:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738780530;
 x=1739385330; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIiDaMh6nwNN2VDUxM+P8cVTXEnJrtAbllEqifF2AyQ=;
 b=Qc/M+lgusFSijePo6map8VBOFFXC8pDcqApTOHzRWlMdwyy+fv8lIAFUc/yNRhF/X7
 VrLoU5mO0vlPGDmNT18fd1p0sBIE9QtTY4EVr6b7pDGC2sAZBZ0+8CpR3WoGjhbvVHDi
 SbOe7a3qvBp9mIE44Kzx1w5ptZbizOKSnOI33/Grc5ow0demFmPSXV5x+oZ9N03InFXU
 mZ/zX5oiFdRoW15TU3e21spZi4H4KH5lkq+KxlhcPdDBnDS1410oDnHpKUvoTnJCJViT
 1SEUY9BpytGvapeUxyLo5G6Rwg0ODfmQMIOLms+g8h8/T4rdbXXESyza7osztpHhI+oK
 wjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738780530; x=1739385330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KIiDaMh6nwNN2VDUxM+P8cVTXEnJrtAbllEqifF2AyQ=;
 b=UrOKN9IYnseL4V20J581iUhWmNTSluAd1b3SbM08IrNM36QcZ5xGOxoHC3lghPn+0h
 r/uQk0v7hHA9Pvwx66vzmY180zfgK8XqLnNRWRltpe02vvL33SR4Z1s1qEbpE/5EteCk
 PKu73rMZzEWcCP16qRmNaQG1eWaWSXW0nwvEXl0InGuqn4cwgNPixsPH0q155iT8tYcl
 jkrhs9ralpMPQ8cKzWNwaB08XwC85RTl4jf0ozONnSjPYSo1gurfFMEC3z/mOFXiEBe3
 Tt/VUlr/O/wcjs6CIkofrqUexScX7Yw4TdkHimuJo5MZfyep3BNCVi/vWSrlto5RHzlx
 QFjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMszt674vLWCo4MHzwdwESdbjh9IiSR/KaUbCNFVV6Xyc7EKvDSC/WPTlLHbYxmViWw40=@dpdk.org
X-Gm-Message-State: AOJu0YwUzexArJzRmHuJVBrguycjRUl+JMDY2cvTSaTJT64HPxf2IX8u
 IfbykC9uSaR1npqFXbfK7JrOgeT45ejFhDZVt0El8ZBgvo1gb88JEVnwsexomHE=
X-Gm-Gg: ASbGncurxyxLXeCYUIVK64k2vfNSlWoGNBcel9j0tllUU9FVuF1Royh3oLmX/3IJ+Rf
 dEyKwv7BB9j0WApNO/F8S0Jy3rND+2zJPmYYhuoczmtYtAk4DfvQedJ4AQLshtfrIXTmnFnpHBf
 xHv7PNyRCxYRD+Dvqymc20rOjYyT3kMMYjfCIHRErNqXSPeot0A2+kAgced4+0kJa1vclX9A7xW
 Ygmu9jTx4eSHAVFun5AkBzL5df4Sz8bx8kLkl6oZlqhtaGuPmBByql4WysLSSxcKgJYjtCkGnaA
 12yaAoahr/fU8D77yzZnBTb1GGL7tWUHNBpt85xtgtCiPn0rkau6f2A99UHgHnDM03ni
X-Google-Smtp-Source: AGHT+IEGuYaPepnUZumq2YeODMI96XLhz97YjXqDcXXtDCvAJ7YBboKgQdKS7UZmfDTa97HMTv9opg==
X-Received: by 2002:a17:902:ce87:b0:212:63db:bb15 with SMTP id
 d9443c01a7336-21f17ebee18mr73789645ad.38.1738780530460; 
 Wed, 05 Feb 2025 10:35:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f1aaa2f7asm16086635ad.109.2025.02.05.10.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 10:35:27 -0800 (PST)
Date: Wed, 5 Feb 2025 10:35:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: anatoly.burakov@intel.com, bruce.richardson@intel.com, dev@dpdk.org,
 ian.stokes@intel.com, jochen.behrens@broadcom.com,
 vladimir.medvedkin@intel.com
Subject: Re: [PATCH v3] drivers/net: use 64-bit shift and avoid
 signed/unsigned mismatch
Message-ID: <20250205103525.7966beed@hermes.local>
In-Reply-To: <1736888702-3253-1-git-send-email-andremue@linux.microsoft.com>
References: <1735246770-731-1-git-send-email-andremue@linux.microsoft.com>
 <1736888702-3253-1-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 14 Jan 2025 13:05:02 -0800
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
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

Needs rebase, the Intel drivers got reorganized.
