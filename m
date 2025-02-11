Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA15C021A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:25:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7D2A4069F;
	Tue, 11 Feb 2025 17:24:51 +0100 (CET)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 79A6A40A71
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:24:50 +0100 (CET)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so4487601a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 08:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739291090;
 x=1739895890; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hg9JDpdpsb66ahGhd9298SRkuhD7wL2EEO5c3Ddb5iQ=;
 b=fm3KxTAQnMHm5VTHGqPN6FI8xEVPZHqZQOhv/xH2k0Uo0iuVFkOepGMa0ULAV31pyi
 wJsfu+PsTvqnVwFHQRYWGinvSp6XFwaCS6BWOqb1EVM209jlh/8/Cd9l0g0OTPnsgyWP
 8zCeNyI/qddGVJlojTL82VjGq2TrU3eeG7u1dnGfFwWLhReVmqEXMhIUSVtfwxI2V0/H
 bEnKxDb9ROczBzqF+wug3+lAdpBpGlJmyrFowLrUSytIivh5qFdnz78UQwcJu7BrvrTx
 ceZC4BtaeYHsgs8/TquylAbNYjCMFQuwUy83QJ1JFOal/EiGcSFy4bUD4sRQNU020U+F
 G98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291090; x=1739895890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hg9JDpdpsb66ahGhd9298SRkuhD7wL2EEO5c3Ddb5iQ=;
 b=B2fPT2vY8+7mGzqTDVM0rjsMl/VuXKZEa5ev+nQyhwT8eAFp7vZvQI818mJQ5JZhnA
 KLpILnxEllEe4LKHJ417S86/A/v+nDSHjU9ia7jOELvvX96+4ExkWX7QJYvfNeFWHKzx
 mGDcd3jPR13i6bE0IE+Roz69ufuQwT7dN3KuNO5LnELxRge9aVQsjaEsF8iCT1dvbhNe
 hMah7Xl2eXOXzrPVke/RPAHgn8O8bDQkQDNv6GzS+hOiVd169wU9ud8b8VhJss9005g4
 YYUQndkAhacpZkleBAEf+HCrIW4UQSCn3yOn4EpgISkZG+ObNcFKtZYcXFgfZHAt5tHg
 ZoEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmMim4eFCBv5EPDXiKD7nJ6hp1fBKWsA0j/VB6wnRQ1k3/bqPmrwgRwPIpWmkwODg+ahI=@dpdk.org
X-Gm-Message-State: AOJu0YwXFSg2C86b02zmejD7sKgM5PhN6j7zkp2f9BRSe3aaioKug5rk
 MvuTxE/iTO82FBJlLZGxDdxWcFCt6yOCyUcyFAYOAkz0/r0XgBvPrqWV+qChJyE=
X-Gm-Gg: ASbGncv51X/+Ep6vGoOIVAKZ0pmcpKk72F4DeOOLmsigCwSyti+ApX4Gyar8YMOZPfg
 xwMid/rWgwKRVg2JiBRjOOn1sBHxTYhBEr8C5W9f1ajRWz0kEI1YO6FgJVERN4QhHd0gg+v1mFI
 OwE6yiiGKrSbPMaEZqwDA6LyIpDPTjRBiY2QO0VKxGOXKfVtJBFXnZt4qWgTpUsjK8c8WVBZjcN
 X2AgOmcCxmSWCTd7UStZRAp6ewziz9ORZwHkYd6a/52ADQr9NWQk5+8Ul+8M3wu5frWzbnSTbIC
 UVdNpWrVyXSq+l1mp+3qjkqVHMTNuS+Ih7zLt8EVTSiQFaMpwCB6XzDJaeY+2ZE89Zrr
X-Google-Smtp-Source: AGHT+IGVgXobvGSVpqmbql4SRJJxbNSbVa9p5K9W6sL8qjm66hlXbZn9KJmwKaNV6usuDrwYov0vfQ==
X-Received: by 2002:a17:90b:3552:b0:2f6:be57:49cd with SMTP id
 98e67ed59e1d1-2fa242d9f42mr27254035a91.25.1739291089703; 
 Tue, 11 Feb 2025 08:24:49 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa2d831a1csm8617326a91.44.2025.02.11.08.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:24:49 -0800 (PST)
Date: Tue, 11 Feb 2025 08:02:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wenbo Cao <caowenbo@mucse.com>
Cc: thomas@monjalon.net, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: Re: [PATCH v9 08/28] net/rnp: add queue setup and release operations
Message-ID: <20250211080202.621a091f@hermes.local>
In-Reply-To: <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
 <1739263818-59770-9-git-send-email-caowenbo@mucse.com>
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

On Tue, 11 Feb 2025 16:49:58 +0800
Wenbo Cao <caowenbo@mucse.com> wrote:

> diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
> index da2c1d3b0e..ea4e1b8d83 100644
> --- a/drivers/net/rnp/base/rnp_hw.h
> +++ b/drivers/net/rnp/base/rnp_hw.h
> @@ -120,6 +120,9 @@ struct rnp_hw {
>  	bool lane_is_sgmii[RNP_MAX_PORT_OF_PF];
>  	struct rnp_mbx_info mbx;
>  	struct rnp_fw_info fw_info;
> +
> +	spinlock_t rxq_reset_lock; /* reset op isn't thread safe */
> +	spinlock_t txq_reset_lock; /* reset op isn't thread safe */
>  };
>  

In DPDK control operations do not need to be thread safe.
Many other drivers do not allow start/stop in one thread while tx/rx are happening etc.
This is because rx/tx should not have overhead of any locks.
The cost of one spinlock at 10G will drop performance a lot
