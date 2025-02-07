Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C21C0219D
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 21:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E9040280;
	Fri,  7 Feb 2025 22:36:53 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 46D9640270
 for <dev@dpdk.org>; Fri,  7 Feb 2025 22:36:52 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-21f0444b478so38644925ad.0
 for <dev@dpdk.org>; Fri, 07 Feb 2025 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738964211;
 x=1739569011; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94Il+tMCczjvVOBPNNRn/wjhutA41jVel2cPrOAQpko=;
 b=eG5DWUIi9XATbQkm3y+Q3eIQOLFG9nT0b1QUhm2phjK0/viCsORRerQdTDctWAeq/s
 puCNQDAl3UeSLXcw0EReD4jRzV/xLTr/Apn8+DIBOuLxWi1Ob9DMwXyJwDyMsVXy0pBv
 kB7xtanU9xFMJCJcugmazVwYkZEBL2t3RUVA08tTjheSLIYqvgzQ0La3S21G4IQwrIBT
 cJKCi9FpzRizMiMuxf01ieJ8Xc+HcOEld1C55yhO0CA7IFvT5si1jbWzk3SDvu1Upf73
 npO2cDUTbcuSuNvtj4kLjLK3LpP/86yx+9oG9rTuBixGxD+ZzDuJV/DnJB6FBI121u5w
 3R0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738964211; x=1739569011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94Il+tMCczjvVOBPNNRn/wjhutA41jVel2cPrOAQpko=;
 b=iePo4ssHedJsVoe5hAmoi0OsWchZGHpFf97Xs+V39zsFD+9R1/4KzChe06/aRK+kMh
 peyOe08YEvQUSMUVR6PDEbIS9KKjC44WVQhAnUQnhS3/6g/hxIV8VgEtYgUTHO5AY7wC
 dKa8YLJdjV3Jl+xOQWAkWVcI+INILSv72unafMJH4p71DNi8k6juxnUZDMqQghCncgJX
 Yk8eJCNCx9PBHuBEstYRcANoQZb/6V6CySJEgzTn5X20+0xfvyFfiZArSnlBrew0tXS6
 yLKYWQ0GZVSka4qQcCRZfs/IP8V4tsYCNb1p9LhBcytPqIOIUsWO1DVkJDYypPQrpLRx
 2+Xg==
X-Gm-Message-State: AOJu0YzAT7sIr3N+WHYy8FZChOsUhlteXmzxh8yun9AsPUVFc3yUH9FL
 cZZ4ARzHRfjnU2wL7LhQIAIrtiydYNWmZqfFHkD0Zzsfgl38Nvd17iAEXUn4kFE=
X-Gm-Gg: ASbGncvAoltbeAIhWxxhSqvzrO+WL5BBkDyLD8DROzvK05cDH1ifXb21jkTHLgM33E/
 tgONS1FctwvF5xniXnNRxDnYID+J+aDl1+JJfUleHuIKx5bpLBqnAhmkCpH/SNKtAFRyucydVwY
 cryyexhTETzZVd5vRCKwx4IMvrPWrIqgd9oW9hjuwwR0XBSR1PjwDG5I+HZxqyuY7fcDI7CY2y7
 MMoQpUt3R9bjeqPrImhzouL+uIcJErngbmhEo7pEgwN5A83D6nHwazJZoPxneb8kuDlmRKlQcv3
 4owSz0iXUySrSol87SIpPq8DC93929RyYrUg5nYc3WPGFLXpo8ilApfB0QXXqCs7TCv6
X-Google-Smtp-Source: AGHT+IF7Njmntl4A+6HIB/3N+FUjodELaqEaFVKIYF8sTFNxkz3dXcZ65UTLTqP9ejeB4dsfwwTYjQ==
X-Received: by 2002:a17:903:1c8:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-21f4e702dd6mr66195265ad.27.1738964210705; 
 Fri, 07 Feb 2025 13:36:50 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3650ce16sm35599475ad.9.2025.02.07.13.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:36:50 -0800 (PST)
Date: Fri, 7 Feb 2025 13:36:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Soumyadeep Hore <soumyadeep.hore@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, aman.deep.singh@intel.com
Subject: Re: [PATCH v1 3/3] net/intel: add Tx time queue
Message-ID: <20250207133648.4436473d@hermes.local>
In-Reply-To: <20250207124300.1022523-4-soumyadeep.hore@intel.com>
References: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
 <20250207124300.1022523-4-soumyadeep.hore@intel.com>
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

On Fri,  7 Feb 2025 12:43:00 +0000
Soumyadeep Hore <soumyadeep.hore@intel.com> wrote:

> diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
> index d9cf4474fc..f3777fa9e7 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -35,6 +35,7 @@ struct ci_tx_queue {
>  		volatile struct i40e_tx_desc *i40e_tx_ring;
>  		volatile struct iavf_tx_desc *iavf_tx_ring;
>  		volatile struct ice_tx_desc *ice_tx_ring;
> +		volatile struct ice_ts_desc *ice_tstamp_ring;
>  		volatile union ixgbe_adv_tx_desc *ixgbe_tx_ring;
>  	};
>  	volatile uint8_t *qtx_tail;               /* register address of tail */
> @@ -76,6 +77,10 @@ struct ci_tx_queue {

Why so heavy use of volatile here? Volatile generates worst case code is there something
odd about the hardware or driver?
