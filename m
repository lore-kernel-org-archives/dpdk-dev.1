Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A7EC369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 16:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F23240263;
	Thu, 24 Apr 2025 18:09:03 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id CC1ED400D7
 for <dev@dpdk.org>; Thu, 24 Apr 2025 18:09:01 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-22928d629faso13137075ad.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745510941;
 x=1746115741; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UY786rpbr0lgxXZZZSpdYWtGoq6EHnv7lRVJUZ0lygA=;
 b=m9P2HjOgZcG40+SRnrkykURxOLtzJ1rSIKywmg7Doo8xbXQa+7bTeAenil4iG4nqzP
 z5kT6c1eL6fH3XnOPcYrzjaoJrhWuz/7xxJrrG0oDDk6JXoP0V7zkU34tB2Ycm8qajs7
 2zXdgiaNmRNY6j+3mct+4PncWaRFmgzIEUov+y+sYOhUhTLy7vC4PLr6EogUdZ+ck1Ut
 gx99bMMVdd/88dT1XvJ5lvi8juM9PQIrp/QfkzbBYxBdoPn3oeDwbppAn4am6MJyEjhJ
 jIfang3IM+Hwx3snSGRRIB3oRv5HFk6+fUD83D4yMwbIzMNYzdpx34h0B82QI+wwAQQV
 8tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745510941; x=1746115741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UY786rpbr0lgxXZZZSpdYWtGoq6EHnv7lRVJUZ0lygA=;
 b=MXEdT6TvWyNl0XmOPD18E6YM6g+mPLZFvqEQmv2U9C+XgJTgIXM8tgMb2HC/5Z0RqG
 rthYXa6J1kcf1xfe4dFJA/JTpScGYxQnVctql/XXeNDCp+GVJsptQYqOjVuvp0HyamQj
 T3F29G5v3e9qw6Fs1EZsrN+Zt5/RB8nFyDF+lJMIn/uXLjLtTmY4a/pNEAjBQWLLdTIf
 6xV5nrCwRnKY1KOolbKVWufrpFh6v8Fc8qM+xfHb4HzT4TR4xRfM8yuJ8qdoy/qI/PvI
 I92mAfK1VlaS1ax+1j6R2F9kjUCm3WLc5f+/0qlnd4QZ5bdgNZzbS19jHZJNgfuWhrwM
 AbNw==
X-Gm-Message-State: AOJu0YzYbXX4nzk6LicSHRj6tu1EpwLSG9K+NPVbtr/+7Al+RcUzJCOp
 n+7LWN+C30K/R8zYHaeRHjcp02IqMQVvyWc3CmqDYEbI0pdXZOwH3/RlI+GQeCw=
X-Gm-Gg: ASbGnct5L3+I4s1ItkDJHESS8k9EdWz8h+Cj0OvCVEfBIxh+AFfUSuPAwOjb42Dm4St
 1ul170+gPH4KQcsEEPtukDx9OXqFWEDJsFgIKE++3KowTIg+I3glB/x5W0jntdhrucQK3P2MoQ6
 fDlCBCV0owz+dxCI3Fjug289DPNJQnJTr6EwpPZfcHZ20nbu5HMag4w5yBZKgP7ite7feyLgN0D
 OHQDjKMzaTgjZSvTig4tN10cFSvNQKj6fX0gtxp9PXt6T4mdm2UNt6cB6scQnpW9d8ypvZhXWD6
 3Q0jW8CbUE2q3bQjWII24RNCohWsxMl3qEGP5LRZBB0msNalNuRHp34yI+nWigNM05j8HK9ufrv
 DXeUFWDAFluYxFaA5sE/eJ4pEfDM=
X-Google-Smtp-Source: AGHT+IGpQMJjLyc7QBCgQ06tLPj5UcANwKaO+1i/VmhgaIkwXBLKXi/fSSrHwmLkfc9acCilPsR4Bg==
X-Received: by 2002:a17:903:1a23:b0:223:5525:6239 with SMTP id
 d9443c01a7336-22dbd4ac7a2mr186575ad.38.1745510940807; 
 Thu, 24 Apr 2025 09:09:00 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221c8dsm15221455ad.259.2025.04.24.09.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:09:00 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:08:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Nandini Persad <nandinipersad361@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] doc: reword flow offload and api docs
Message-ID: <20250424090858.7ef78315@hermes.local>
In-Reply-To: <20250410183931.40881-1-nandinipersad361@gmail.com>
References: <20250331214036.17295-1-nandinipersad361@gmail.com>
 <20250410183931.40881-1-nandinipersad361@gmail.com>
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

On Thu, 10 Apr 2025 11:39:31 -0700
Nandini Persad <nandinipersad361@gmail.com> wrote:

> I removed low level details of the code from the Flow Offload
> section of the Programmer's Guide so that it is more about
> the general usage of the APIs. I moved the specific details
> and definitions of the constants/function to the API docs
> if the details were not already there.
> 
> Signed-off-by: Nandini Persad <nandinipersad361@gmail.com>
> ---
>  doc/guides/prog_guide/ethdev/flow_offload.rst | 3584 +----------------

Looks good but does not apply cleanly to current main branch.
Tried manually fixing it but it was too hard and gave up.
