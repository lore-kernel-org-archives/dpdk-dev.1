Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83813CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 17:11:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D53C402E4;
	Fri, 24 Oct 2025 19:11:21 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 62A1F402D6
 for <dev@dpdk.org>; Fri, 24 Oct 2025 19:11:19 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7a28c7e3577so501755b3a.1
 for <dev@dpdk.org>; Fri, 24 Oct 2025 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761325878;
 x=1761930678; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fx3C17lwF/fq77mcD3B2hEDRkpPWm0N33qL97L8a94w=;
 b=0hGe8SdcL2QC11ezFWyF8Lf3S1bpOL3me+X8bHo5yylLX5aT0b79FjhqMA4cwkWge1
 iu7PBgYCowUEe9uz61pj/jG0VRai1ul08D+ru3rE8cuUbanqj3ZSBKli2VCB1lEFpAdi
 PnxR+YmHLY3XDTbbAepKLOxMkteFtSkMEDU0ArUUt8bcmrTELdIT4RckM7kl4IpWlETp
 46rGpVnZb1fs/HdfiDygWUU7YvGIjY0ykr1CeF07GScnyaxTsPxzQLMMZQAOUOsEzQ8b
 75jvlQNWslYnntDkZd/ql8xhBBG7HS+ROWfsmUMYnZ0xcXgAenIsmEgWkR8ZU/G0WIsW
 XMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325878; x=1761930678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fx3C17lwF/fq77mcD3B2hEDRkpPWm0N33qL97L8a94w=;
 b=ROkwy6z7FbOE2Vz5gL/0bCPYKfaFqWRgJBpgCZLUThlLfW+0xMIGAhxkOmAMpG8ZJQ
 /KFSAVJaO4wSXfdkAoKVxQqE4n+AbSEhiFpRCs0tKNzOIQgAikSDEWXKgyhqMc97az83
 Snv9+ulj1J59gwfhaTwOp5i7DK+2jEJ5PUfW9wJ/R5n+IF9Z1pOqF9IHpLLyKXS94zRg
 lh6Xom6aKkbYhn/d3VZ9owY3+YbOC0rwtGPNOxVqKHHGGa/wBH47Qb8++Wj58SysP3M7
 HcMU0nlGL5yVUctIHYdM6Bn5djz3GnXyrgFOSitTQY3nM8v7hbct442NmSk6sF6Kh+wJ
 kkPQ==
X-Gm-Message-State: AOJu0YzZrmzDFVBBCAZV/P2oWxVolsDQgrfb7r7LQflHqwfnRae8AXU4
 1qQJAdTmsulMb7n9VahBQlsQMtj24WJcU+7sbV3T+1xXWyK+U1ExJeVhhDjCKPW6jkI=
X-Gm-Gg: ASbGncvZR2B5MYBwsGXQp5vDlYtIziHMnWfmrJO7FrhRC7ztg3MgRBd88sWOCOuw1I9
 L3O9fpnC7PFKZ6VBLAGAK62Q4Md7QOTikRupy3Kfy6Ebn13B1R2T5XhTI2zrl9AtKnNIp/6JQxl
 ZjP0UWxRWXBnfu8nwwfwfynttbUA3PIJcwOcGBSDZEECKiZbpHIDzXp3paduLmq3JWRhINgOgi1
 IHy2rVp44zwuZLKgO65ujL5BWg5X4xpGcIkgdSyPZRwZd/ouAhdcjBBjDhMqSerJiBiwxaPmBNG
 L6jHHmxII258gdxpyq/4IyuWMlJqZOyQqU0w3UmaznfbBnMb5oc6uV7VeTgwCBj68jeeEYSn3xP
 eMUlkeImUWdJT9mtMlJR+IuLJHjmDhVZjikj9grwIDw/pLQKBqeA9uiv991K46nhLHBxsJQb2uI
 w7apYMDsGIuFQtp+PNHNOFz1k9ZYV+6YBpMw==
X-Google-Smtp-Source: AGHT+IH1emx6qZ50wm9p1teuZ6EHSI+oPnf+c+ZHVHhOj04QwCduQq1m0n9BiFZwU+BPyhqFCQGBjA==
X-Received: by 2002:a05:6a00:2d8d:b0:77d:a490:269c with SMTP id
 d2e1a72fcca58-7a220b23f7fmr34646410b3a.29.1761325878436; 
 Fri, 24 Oct 2025 10:11:18 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a27d583970sm4669776b3a.51.2025.10.24.10.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:11:18 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:11:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 10/13] net/sxe: add xstats function
Message-ID: <20251024101103.5ddb977e@phoenix>
In-Reply-To: <20250728090517.1811244-10-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-10-liujie5@linkdatatechnology.com>
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

On Mon, 28 Jul 2025 17:05:14 +0800
liujie5@linkdatatechnology.com wrote:

> +s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
> +				struct rte_eth_stats *stats)
> +{
> +	struct sxe_adapter *adapter = eth_dev->data->dev_private;
> +	struct sxe_stats_info *stats_info = &adapter->stats_info;
> +	struct sxe_hw *hw = &adapter->hw;
> +	u32 i;
> +	u64 rx_packets = 0;
> +	u64 rx_bytes = 0;
> +	s32 ret = 0;
> +
> +	sxe_hw_stats_get(hw, &stats_info->hw_stats);
> +
> +	if (stats == NULL) {
> +		ret = -EINVAL;
> +		PMD_LOG_ERR(DRV, "input param stats is null.");
> +		goto l_out;
> +	}
> +

Several things wrong with the stats function:
   - first this function and others in ops are assuming s32 is the same as int.
     it is on the platforms you build on now, but it might not always be.
     It is best practice to implement the operation with the same function signature
     as it is defined in ethdev_driver.h

   - second, the stats pointer can not be NULL when called by ethdev stats.
     So the check here is unnecessary.  It looks like the code is also calling this
     internally, with stats = NULL to update hw_stats. If so just call sxe_hw_stats_get instead.

> +	for (i = 0; i < RTE_MIN_T(SXE_QUEUE_STAT_COUNT,
> +		RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
> +		rx_packets += stats_info->hw_stats.qprc[i];
> +		rx_bytes += stats_info->hw_stats.qbrc[i];

   - this loop is wrong, if there are more queues that RTE_ETHDEV_QUEUE_STAT_CNTRS
     then you still want to count those packets in the total.

   - lastly, the recent update to ethdev queue stats changed the args to the callback.
     you need to fix this for both PF and VF. Rebase on main.
