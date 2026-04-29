Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F80AFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 14:10:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 870ED402EE;
	Wed, 29 Apr 2026 16:10:10 +0200 (CEST)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by mails.dpdk.org (Postfix) with ESMTP id E8899400EF
 for <dev@dpdk.org>; Wed, 29 Apr 2026 16:10:08 +0200 (CEST)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-12c19d23b19so16583957c88.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777471808;
 x=1778076608; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paioziJrNrMd68sOUU8Jc/vhiTHvJjEKKN5EXa90VW8=;
 b=fcmqJtgDtMevOiAwIoW+CyeSUKzyEbi93hDaS5GHwc8lAN20hLrf5cCOgZFDCBDRvE
 R7iZ3FI110nEuCkmoZ1T92QrEpyLiokln0JXk5vA1FKgTkOUlleEoJTm6+PwOEISi2yd
 lCVEeuxLCM4giDsyn220iaL8pw8xyX1Hk7Xv5eOZd7kveCAvPPcDUcvcCnQcwyYb+nx8
 LZWagG20e5YLhfmD5vqAfPxdf1mvZzvI5h1DU9mc1Qf9g3W2qpu+xbP43DFvpMPnuU8k
 naSb/mZDSk/ZQe95+ND5AhPg1YU10ZWJlbXdtpvlYzHVnO/GhRJpZ0nyw870FMn5tz9r
 wAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777471808; x=1778076608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=paioziJrNrMd68sOUU8Jc/vhiTHvJjEKKN5EXa90VW8=;
 b=q/jSOGpjn0zjODP93TAwv6yvTp/plYz0/nPP6xiAp2UT/2b4d3ijuLXP3yabDWWpi+
 KoV4J8jKRp1nVgmxYwpmnHAuScQDgrqwwLwkxoEeVWt+GH8PM4xEn2hkPkIzjGIsNAyM
 MArbS53EXp6jYZytIJHxjni2ZM/jfTBBPP5yev8VLPdE5QY33erocH6Id/Ipmm2qP/Ob
 Ecv//NNI7YLg6gIoSsNyvEC6GrrdMFkk1Px4A//Xl8wlqV/+2tqnLVawk+/XekBtyDBr
 4OrN7aNK4hclYGK7H4Axyv0RlBGBAdKNd2pXfJWPUgH24R8Ris4tu7o9Z5oQPBlHK6gb
 QQwA==
X-Gm-Message-State: AOJu0Yy8GU3aemMSS6tZUt/Caj6V1iP3M7EGttUd2IuV7Z0xVkU0z3SF
 cDQjOZ4RdaSjYTX+v0U99Y2fw+w/3GlKdmnrRyyajQ4noKhBWSlF4t4KGNfBHiUmXGg=
X-Gm-Gg: AeBDievpucOLAqXMBlOCCw3PjXt7jyCpWlUnvRKr+a71qeGa5fHaYcM0Zjw7XqpkrFM
 6+QnOe3lxTBLZqu/DeCK8etseKrKyRKsKSNoJ3ks9ginNPg3zA/3g+suadAgO1XnN9wZaHZTfTq
 ARTtYKOm2muFHwa3ABZ9RRT5el0buoWjEYbTDNTkEg+ljhL1wJ2ZHC45JK/6gMlGyS5BJTAuJd1
 zeyi8BmNSLm9P+1Dpx+4iTRheLrLgp8rzJPIkt4fOohpY9QbAkXw7UD0nsnVDqurhSeGZsjgzh9
 sY6vMttyD2F6xdQ7CEwS+qpIGBf3HjVzVOeKc/QS74/pRxfuCkISqjtnld1G8TR8LlalVxMXtvw
 AZMb/WiF3UkG3AorgjeHfqyZc2T7uTONw/8x1BHVm7hQZnTo+ZwC3JEZ6FgofXDakr3aKDRzvYs
 B1PA8+CfQWzUWnwqwjBUBzWCGmnwUsQPsaZdLUJTkKCYIRyg==
X-Received: by 2002:a05:7022:618e:b0:12d:de3e:be8c with SMTP id
 a92af1059eb24-12de2a86d17mr1481091c88.40.1777471803957; 
 Wed, 29 Apr 2026 07:10:03 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf6d315sm2430943eec.1.2026.04.29.07.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:10:03 -0700 (PDT)
Date: Wed, 29 Apr 2026 07:10:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, stable@dpdk.org, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH] devtools: fix SPDX tag check
Message-ID: <20260429071000.6c2e3279@phoenix.local>
In-Reply-To: <20260429130935.3681177-1-thomas@monjalon.net>
References: <20260429130935.3681177-1-thomas@monjalon.net>
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

On Wed, 29 Apr 2026 15:09:35 +0200
Thomas Monjalon <thomas@monjalon.net> wrote:

> If a file has no SPDX tag and is not filtered out by no_license_list,
> there will be an error when using its path containing a slash
> in the sed command delimited with slashes.
> 
> It is fixed by using the pipe character as sed command delimiter.
> 
> Fixes: b99a3b8aa989 ("license: standardize SPDX tag")
> Cc: stable@dpdk.org
> 
> Reported-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
