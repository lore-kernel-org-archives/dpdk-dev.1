Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AAFCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 03:00:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACA12402A7;
	Mon, 18 May 2026 04:59:59 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id 9274240264
 for <dev@dpdk.org>; Mon, 18 May 2026 04:59:58 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2f3c623322bso6397211eec.0
 for <dev@dpdk.org>; Sun, 17 May 2026 19:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779073197;
 x=1779677997; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3u8VBS9RIoQy5KJhne2JPOGgvZL9K9qrhOlg1a66x7E=;
 b=WzglRTs30Lx5K9p/m7NqOOSA8thGIeBUAQOvDV8r5sn3a93cdwh2U39GtxR5VQ/+c4
 qgUmk6z8r0+eedWiz6UdemusfvaY2o4l2KWA5znuoaU9BUhUckGI3PuD2M/yfJ0lJgLa
 nOvjtlXaWhEmO3+TEpOqCPDyAwL7OTEpHbkWiFEhSJhpKZYi9KkDcuQAIMqSZ1ePzfIF
 OJF40r5iiJYEEZT56t+3RJO0AiA7vm6iCrbw4i2rD0ynSOPUuGiE8gSjzPpg4kmVEGDQ
 0Vaqz40Ol/NhAASNp2aUzoWAzNJS+84qHVMpNj6RXDGuTNWkI317okuvBnzddwCrh+iP
 jvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779073197; x=1779677997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3u8VBS9RIoQy5KJhne2JPOGgvZL9K9qrhOlg1a66x7E=;
 b=eA57M6PuoRrdkizZeIfPkMTfuDiVk9TcWAcAx/lZnrgibQGYkP5vqyzoxIUwHt5JNl
 rvkYy2cKWm0mxgel2LdLgaBN1BMfXjUeUE/Sm01UmgENzF+snfryaI4Eue21kyrn6hwM
 KZsMa50Abl4u/viablbEZLqGt73BtVWFK5/jt6Kvdw5h5ilPonCmoAmbXCGHEEOT6aO3
 UIZ+RFdEvLRgyECK96wks/kNaKtCbVq8BygtIRhNFlZkfMv0W7/+/i3ySneaSosDDuiu
 GrJB4nk4iapPw9QdtPe06S6F20xolHfRB1vh6QfMaGYVWiX6U9FQYyIRak7R2k4HMi/C
 NH+g==
X-Gm-Message-State: AOJu0YyAjFk6bBb2lcbFPEq4TDhtBZjEPq1qTtsu0XTpk7MJXzvQbPg+
 V6X4DRF/IbQH5nnw5LymYAshZMBYJFLcfs9BOSFC+i0dwMnXmOZTkLrWMXswc0FddDM=
X-Gm-Gg: Acq92OEp+LrruV5IvmUw3jylMTuaIvkL4VEMTpbjRQgpxy9nqDjwd5bGFSH7RXrEbN6
 WqN2rkRmdzfwR4WKPhkn2FKrlOSJ6CIVMMeyKPr5ZYrKc8kCqiZv11P7k8gryJmmifc1V2WE/lm
 +fwNDWHAom7mRP8IOan1qHl3vQ6SHv8/gCTRHjX67tjVy9kZz2nRFjaHaqOVdA7pOXrkohDz2Bf
 rwhV19UwZPGjAmmEXtjqiY1DOx5hi516woOU+B50w5mK46rok9wWDRH6Z1ATCIOPrKFHFcgJpu7
 uMImxzqJyB/0idHMUb5Pguuonm65tUZhiSYHA65Fc/y6zR/RhtI1wtJVTEbZym07uH0nI9Ws+rn
 dBpzSEnCSRx2ye/3Lj6JHoNV3y9pcUbiplkAaAQzxmLxBeZ5LI/77NW57gL3eDhoLROV25awRLL
 W0DC1ajCU5iGABWW1tXBDvPDlXEfnrO4H/8HVPTOnk1yS3rA==
X-Received: by 2002:a05:7300:570e:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-303982ac579mr6621562eec.8.1779073197305; 
 Sun, 17 May 2026 19:59:57 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e6a9sm12690686eec.2.2026.05.17.19.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 19:59:57 -0700 (PDT)
Date: Sun, 17 May 2026 19:59:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH v3 0/7] net/netvsc: fix VF hotplug and service reset
 handling
Message-ID: <20260517195954.12865a1d@phoenix.local>
In-Reply-To: <20260515192843.552762-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
 <20260515192843.552762-1-longli@microsoft.com>
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

On Fri, 15 May 2026 12:28:34 -0700
Long Li <longli@microsoft.com> wrote:

> This series fixes several issues in the netvsc PMD's VF hot-plug retry
> logic and adds support for MANA service reset (suspend/resume) recovery.
> 
> Patches 1-5 fix the VF hot-add retry path to handle Azure-specific
> timing issues: slow MANA driver probe (>100s), udev interface renames,
> asynchronous mana_ib registration, and multi-NIC staggered VF
> appearance.
> 
> Patch 6 fixes per-queue stats forwarding from VF to netvsc.
> 
> Patch 7 adds recovery event handling for MANA service resets, where
> the kernel suspends/resumes the VF without PCI remove.
> 
> v3:
> - Patch 1: wrapped rte_eal_alarm_set lines to fix checkpatch
>   line-length warning
> - Patch 4: changed "retry loop exiting" log from NOTICE to DEBUG
>   to avoid noise on every successful VF re-attach
> - Patch 6: removed dead -ENOTSUP fallback to rte_eth_stats_get,
>   replaced with direct -ENOTSUP return; documented caller contract
>   for zeroed buffers
> - Patch 7: deferred all recovery callbacks via rte_eal_alarm_set
>   consistent with INTR_RMV pattern; dropped unlocked vf_attached
>   guard in recovery_failed; cancel new alarms in hn_vf_close
> 
> v2:
> - Patch 1: added comment explaining why indefinite retry is safe
> - Patch 2: changed SIOCGIFHWADDR retry log to DEBUG
> - Patch 3: restored ERR log for non-ENODEV/EEXIST failures
> - Patch 4: changed per-iteration logs from NOTICE to DEBUG;
>   used RTE_ETHER_ADDR_PRT_FMT macros
> - Patch 5: fixed commit message (limit 120 not 30); changed
>   mac_retry log to DEBUG; explicit NULL comparisons
> - Patch 6: added comment for direct dev_ops call; added -ENOTSUP
>   fallback
> - Patch 7: added dev_started check in recovery_success; added
>   vf_attached guard in recovery_failed
> 
> Long Li (7):
>   net/netvsc: retry VF hotplug indefinitely until PCI device disappears
>   net/netvsc: retry on SIOCGIFHWADDR failure during VF hotplug
>   net/netvsc: retry full probe when IB device not ready during hotplug
>   net/netvsc: add debug logging for VF hotplug retry
>   net/netvsc: retry when no matching MAC found in net directory
>   net/netvsc: forward per-queue stats from VF device
>   net/netvsc: handle VF recovery events for service reset
> 
>  drivers/net/netvsc/hn_ethdev.c | 142 +++++++++++++++++++++----
>  drivers/net/netvsc/hn_var.h    |   1 +
>  drivers/net/netvsc/hn_vf.c     | 182 ++++++++++++++++++++++++++++++++-
>  3 files changed, 302 insertions(+), 23 deletions(-)
> 

Applied to next-net
