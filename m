Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FDC02199
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 00:21:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0D63402BB;
	Sat,  8 Feb 2025 01:21:29 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 99C2640280
 for <dev@dpdk.org>; Sat,  8 Feb 2025 01:21:27 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-21f40deb941so48271415ad.2
 for <dev@dpdk.org>; Fri, 07 Feb 2025 16:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738974086;
 x=1739578886; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9gfcKWJRl6EcJd6OfVeypd/BvyC1gS6+trm1hs7KIyI=;
 b=ZQT98XOPjeDyHhsFAD6TnquZEN3Ze7fsDPn4yxxCPPfDTtw7iVh8MP8YTJgaa3szSZ
 mIRvq/sB9AcS5HQN6E7m8/WKTjQBDpHizyXKtvrLVaX8QvD2a5v6QUFkgzTXS4XL4O5v
 KycU4M1RCAvZoj9LuN3A0DmOuMXcdcjkxgAnq8Tdg2T68osO/BtWGTbUvJj7a3YDo2SD
 bbCEmrFD7sLwwwTd/06lXXP/En7PLKdT+QvJegpYZNwXV3ZBTnsSEexdZ6XyxFs8xMtb
 u8TpNm5/kjcMPBEbL1SbEEt5Z2ovovzv31EtLaHGMD1VZaoU0+VpGIhkI2YJgEXH+zcQ
 6E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738974086; x=1739578886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9gfcKWJRl6EcJd6OfVeypd/BvyC1gS6+trm1hs7KIyI=;
 b=cp2Xt3kEMd1aQhQ5K9NIHBJ5Wkhvq1WLFQlaOVfHzQVZuqDqCNsVcqWxh6mTqtj3F0
 G1E3+UbH/zF4qNt7IJ7K/Aj9buXrtUzUk7Os84NCYI1iv54wOdKi0DXB2VEvt8e/8W0Z
 Q3STSH+SBWZP5Xqkp27FlEzvkF4kSA5bYgfIUBCkMIhfbAp0khxEVyY3ZCIFJD2H8e3m
 o++Ms0Z1WsZadPyG1VeWmdKHchvpE59BGF3Noe08M1x7C4zfiLFozBHZymu57MWz5IAc
 wbhcWNfyRkOA5Spl+1Wh0rK30T52PzQ9p8gr9HLXX8K87rjZYMgvUHkUZ/JJMJw78fyg
 6ljA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvrWTKA6YpDJnVUb72u2rBb4imrlM2V9lpmbyu2ew6TidKdbBD4ZdBN2vz7Ojj81eeT7s=@dpdk.org
X-Gm-Message-State: AOJu0YxSJRtavYUe10+yPIln177wYEhRx4i3wKnBXzHBK8U0bd/+yfPL
 aL9H0q/kZOyS6PMG3Gngpkqla/FbfGbJBf1Zp+dORMLe+SwtcuSvOjjLaVhGSzs=
X-Gm-Gg: ASbGncs3zR6bqYkV2GsJ/nE6OSKCLXcuQDtxUXO8yQOXTCZjqM/WD9+L3sMRPwCRRn/
 9EZgnRQHCkemU0Omy+OjXEafKk65UtAdle1dsoOTuoNj9WxWFJFSN0WvyrrrKj/FhzGkmGesT59
 5qF8JXscfAJD/Xr1IsZcnQfEwZogYJGL1Xf0YOp6W/xiDF2RgBA+PU6A1cPJ/iwP+8ctz8hB++R
 PB1zGzBXsDnD8WecBB8Qp5ug5uF0rHGjNGutKAAI73GROX+zU+o3/e9YvV++0vgiPHDWXr5g3e7
 YbQCSXiWCGcYF+0EMy5FQ0VPxzKzdeJL9n9H0W/I6xKjIwONJ+9hBLS1Fo0wIYcMKh9K
X-Google-Smtp-Source: AGHT+IFnRvsuOimGvDtczkkXjTJKj8piouCg9x7nYEXp17G4cB4+wBsEjx8bKIg1YcKFjdnZeNj/mA==
X-Received: by 2002:a17:902:d50f:b0:21f:78f:c178 with SMTP id
 d9443c01a7336-21f4e6cea22mr86052955ad.3.1738974086621; 
 Fri, 07 Feb 2025 16:21:26 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3656125esm36620485ad.95.2025.02.07.16.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 16:21:26 -0800 (PST)
Date: Fri, 7 Feb 2025 16:21:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: Ferruh Yigit <ferruh.yigit@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, Wei Hu <weh@microsoft.com>, dev@dpdk.org,
 Long Li <longli@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH] net/mana: use mana_local_data for tracking usage data
 for primary process
Message-ID: <20250207162124.112f0c00@hermes.local>
In-Reply-To: <1738970505-7864-1-git-send-email-longli@linuxonhyperv.com>
References: <1738970505-7864-1-git-send-email-longli@linuxonhyperv.com>
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

On Fri,  7 Feb 2025 15:21:45 -0800
longli@linuxonhyperv.com wrote:

> +	/* At least one eth_dev is probed, init shared data */
> +	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
> +		rte_spinlock_lock(&mana_shared_data_lock);
> +		mana_local_data.primary_cnt++;
> +		rte_spinlock_unlock(&mana_shared_data_lock);
> +	} else {
> +		rte_spinlock_lock(&mana_shared_data_lock);
> +		mana_local_data.secondary_cnt++;
> +		rte_spinlock_unlock(&mana_shared_data_lock);
> +
> +		rte_spinlock_lock(&mana_shared_data->lock);
> +		mana_shared_data->secondary_cnt++;
> +		rte_spinlock_unlock(&mana_shared_data->lock);

If all you are doing is wanting a MP safe counter, use atomic operations
instead of the overhead of a spin lock.
