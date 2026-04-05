Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F0E9D800
	for <dpdk-dev@archiver.kernel.org>; Sun,  5 Apr 2026 16:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BAE040296;
	Sun,  5 Apr 2026 18:48:20 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id EA86A40265
 for <dev@dpdk.org>; Sun,  5 Apr 2026 18:48:17 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12a74039dc6so2368798c88.0
 for <dev@dpdk.org>; Sun, 05 Apr 2026 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775407696;
 x=1776012496; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiooj7Bk6khfxTufGpoJKZ4WQOon9OVfSUrGSjIdFWM=;
 b=P48VKvJ6eEv3umGjsW4i1/Pic3hQOAHlejYBztDdiGoDlpfTE7RQBXILlNCt4iZRkP
 RTl85W5deyAcQGfMs0jbTZ4QzmR1NLgamG9WLJZ0OqeB0tH12zMWuPuivKU2KErt8tzI
 +difkZNLa9rbvsZZJW+sLpl5fjoZnauACs025MrZUFa6tPihVDaZpW6V16DkUIJIX+XY
 EfQLhWAgv0i8OSXeRuDjOOeR0Qwi9KRXQFPEk9AD2e7Gz3S3/ahlzaKaY7tvw54vG/wE
 MB/z8y2Ov02iM03tItmRifIHuHkxAugrrXt+9l4R9kCyM8RtdUue2mcbC3kARojH5CXP
 HijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775407696; x=1776012496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kiooj7Bk6khfxTufGpoJKZ4WQOon9OVfSUrGSjIdFWM=;
 b=WJrHP0GpkPyKLs5WNGRFYWxEaOGHCSLxYpcvri7WM6QqlCM71Jv8jBEt5Udke02GeE
 7iynejgKAbz3D/CXYNIbcXr2uY/zmbUVm/WYzclribdwND1U2UA1PxSdmcHT7XEzJkXJ
 dOaK1Ko4VpuA3f1yfvQF0Ky0UB8409ciBW7OejVVwfbgBXcy0p8nbnqPfqMmeDoDA40b
 YQTy6WtocgCYPsmhE/iUIILUO/4FVdP6OGbmVnOplRueO8fVFtm3e/5A0VBY6NhrC9SW
 tJBD5ordXTrcxp7KMID5f4v+kF+GjyMrw5k3zJKB5wmdjnPkXckKflFwUtMArZaT2LId
 oZlw==
X-Gm-Message-State: AOJu0YyklwSh7Yy6RZ5wWc8HLNjugDmPOSaN52mPJxbhrFbR7JGqtJ0o
 RFUNwXOuDWK+NU3IlHQMKcsjtGrYIDzCD2PRd1tx5nttZbDVzLkahofP40jlLr2qVco=
X-Gm-Gg: AeBDies8HOZ5VyaZiroa1NVfNrXBJiesZwYNFwnUtPgy6IxHQDlXQF6LbCIeoFxzTaY
 sEfQ5lg/m+DANfJkFV1zFGW8ak/CZHfv8GIvPxtkGC+lkp+s2HG7OKZ5bsF/n2Yq+Fdr1Z+DmJ9
 YhPkZL6Ok+fYTtWaGO3+8+nIaB3K9T868Y07x3KiOkzAYU1u5UOvRANkLm6NT8A1Jpi85QiCQi/
 x+Gq3RsHAkFk1qmilENM0C89i7yIGkcrldxdnpbLa2pBVrFFKSwx4PFhNho7B7e6X5nh8zXg2N+
 qIp33O7q4asQdiYzU7EbnRgjobKelQJrW2Dk9DE+5rclLRwmVHsrR/KB9iekE8wnCHythnYOPwv
 EoD77bsJQ7BUXMCYOrntwjqigVbZMpj/HxS70pzPjb1aKS1XiN94u6d/sSoxdE7yMptuAXztcTE
 /fRHw/EnN670czQsjqL1FgJbYR+wTqd64t3EnTt6rSHJQVhg==
X-Received: by 2002:a05:7022:6097:b0:128:d9a1:b68b with SMTP id
 a92af1059eb24-12bfb767ec5mr4583845c88.33.1775407695892; 
 Sun, 05 Apr 2026 09:48:15 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bf90973b6sm9690020c88.9.2026.04.05.09.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 09:48:15 -0700 (PDT)
Date: Sun, 5 Apr 2026 09:48:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>
Subject: Re: [PATCH v12 3/3] app/testpmd: add sleep command
Message-ID: <20260405094810.4247b2d3@phoenix.local>
In-Reply-To: <9190a614adc2b641b4be3f3160ec109cb087cb24.1772124281.git.anatoly.burakov@intel.com>
References: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
 <9190a614adc2b641b4be3f3160ec109cb087cb24.1772124281.git.anatoly.burakov@intel.com>
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

On Thu, 26 Feb 2026 16:44:50 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +static void cmd_sleep_parsed(void *parsed_result,
> +	__rte_unused struct cmdline *cl,
> +	__rte_unused void *data)
> +{
> +	struct cmd_sleep_result *res = parsed_result;
> +
> +	rte_delay_us_sleep(res->secs * 1E6);
> +}

AI spotted something here

Error: rte_delay_us_sleep() takes unsigned int us. 
The call rte_delay_us_sleep(res->secs * 1E6) silently converts a double to unsigned int. 
If the user passes a negative value (which RTE_FLOAT_DOUBLE allows), 
this is undefined behavior per C standard (negative floating point to unsigned integer conversion). 
There should be a validation check that res->secs >= 0 (and ideally an upper bound) before the call.
