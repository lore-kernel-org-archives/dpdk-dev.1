Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D99CDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 22:07:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D28240279;
	Thu, 25 Jun 2026 00:07:41 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id 034334025E
 for <dev@dpdk.org>; Thu, 25 Jun 2026 00:07:40 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-139b5e604b9so1855138c88.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782338860;
 x=1782943660; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8YbYUmSH8Si6s0v4smhI5i8VgKEG6OxOBvJu38L9og=;
 b=zqRluZf2mP9M2eAWzEdzw7222hYWikdYWLwypQDtxcZd0dxl6ruBOZjWGn4fkGRRrZ
 gnzl3crTRNxUc/+hmreBztj1GLV1BtKgymqiQ0K4Oj8ybvuXuupbKNrjo2+QqKSSqIdz
 51uf+UUPe/9ULDUd5dykOhwvpM1XPVpbVORG46qQ+WE+z6S0RygLCf+Y9osad3Rpuvqj
 BlDhg63oiZGMhPBFge9eNyEWKg7vDSFYaOn6MV4V21NowU0vFaK1w2ufhzo5BBeVaup/
 Owuro9BSj/FwsnOf8C9Lx9IuGhiIOPJvGeX5lFKJyDtOwV3WUxQPoPjuVPvBCpfNznw6
 TKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782338860; x=1782943660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v8YbYUmSH8Si6s0v4smhI5i8VgKEG6OxOBvJu38L9og=;
 b=iOjT06Gt9i9OwYgVcXmasaWiBJ0/Xziq3wYtcgdx9BVOLis9KdhFNX81laL1CeHb/G
 nMmu7ikV/hvqa/XJxsLVlnQgUEWQLHSbUumlWi8nMevuATwnmIEZcyqicfEk4fa4I7y/
 CVURgA0FabDsamJl5dncJcNIA1V9ff3cH1icKIZFIOCa4UcfQPoS9e0xoSt02couzrQr
 75uAyChtFi8opbcmsBkf6Z8jdw7xBq3l96UHNAxQCiEUoxx5lkGBuNT19J13DnDHlXVg
 +Cjk6durS5RAaiXZWciAFaOnvEAy0dMXQAtVTUgCwzjvkDAS4BQtkPd9IyWVQ5LBBlld
 068g==
X-Gm-Message-State: AOJu0YwQd1bO/T7fclzDrBoCSDijJu/aPd7tI+/lKq8aokd/1mT48c2X
 hLLGNKTefYaFuj+uihqULHx/OXPSYhWbnVttvQudxv5M0s8bKPYPXBfJsl4uGOmUix4=
X-Gm-Gg: AfdE7cmpN1/Ccbd3LWnzo52LMUvf5k/tKzD2roQRSD4FRuGfBY62TNnRa6ALxdnwS+i
 DfUmiAa07DLgVw4JnJ0p+oCJkNY6qfBBSPP0R6327DMGEjrg8z1Z9qplou+94Od7BShAmwKGHR9
 poz1gsFgbJHejSj6RzM35r9EFB5T8fxYB6aTvfN7oBOdaxCAITFppOgMeUl00dA13NiOAuwVkQf
 tqaiQyoObx15T6D0k0d9dfcKH8L1rLUQTVPXZDugvdupryRpqdY84R1e3z+vjT9s3FX2T04Zqrn
 kzHk5O4LvAXDeeQG5fDnx9Injzb5VQ8Cn+23UQ5mc4qnUH9ZNePFfVGAxB++raT3702IMPTL6o6
 6BKN3lpKvSVkcp0zkae42ZgZchBh1oElURFAZ4BVzkMwcD58R3Qc8Qn5Gd+fc3ev9T2FivNiNWl
 2nlsXNFXWTDuOitbNI2GBamBN1N0n89X5Lbv/ZLPaAdZ6y5tA/RHsOAQ==
X-Received: by 2002:a05:7022:662a:b0:139:bf81:638b with SMTP id
 a92af1059eb24-139c5cd8a70mr6459756c88.4.1782338859724; 
 Wed, 24 Jun 2026 15:07:39 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e95c6sm2567456c88.11.2026.06.24.15.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 15:07:39 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:07:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, marek.kasiewicz@intel.com, thomas@monjalon.net,
 mb@smartsharesystems.com
Subject: Re: [PATCH v5] pcapng: add user-supplied timestamp support
Message-ID: <20260624150734.4311e330@phoenix.local>
In-Reply-To: <20260624215858.710217-1-dawid.wesierski@intel.com>
References: <20260623141302.486601-1-dawid.wesierski@intel.com>
 <20260624215858.710217-1-dawid.wesierski@intel.com>
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

On Wed, 24 Jun 2026 17:57:01 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> +	/*
> +	 * Use caller provided timestamp.
> +	 * If none provided, use current TSC and set flag.
> +	 */
> +	if (timestamp == 0)
> +		timestamp = rte_get_tsc_cycles() | PCAPNG_TSC_FLAG;
> +

If you are going to use high bit as flag, then probably need to 
enforce that that bit is not set on input from user.
