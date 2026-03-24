Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488AF54AD7
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:12:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9389C402BE;
	Tue, 24 Mar 2026 17:12:44 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 171024025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:12:43 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12a74039dc6so1271888c88.0
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774368762;
 x=1774973562; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8d6ocg5fVmsCUOmALrbQOkNm7wx1I51f2DnQ7OkYvo=;
 b=d23BJNypFtw2mJ7OU5qb2FUbaj/SIMcio7LVLxBhfQCrZ1e7c+UrC4cdYNNlwsxJpR
 0W+rS844rrdSB+vo8SBtLW9F5cdqX93YvUnmh9LbTzGkZIGmCvZRPXuJrRf8GPJ8Pitd
 SuMjfMlI5uSwU1kzhJHIxPYltEDwfk7wp6kz2NO1qCzTj7pBXhs3OYoRgSatnehWUpx7
 kF8OaesCTXmF1/tB55+LLGyf5tglF00nZYehNCBs2R+IJ6VnfrB2vLY4gdB07w0iu1hx
 4vfJHMUGIdhx2XbJpsxUMK62veuOSc8duCPIEj67D60M5MoXTS+jBP/E9JkHzAZl4nIc
 K1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774368762; x=1774973562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8d6ocg5fVmsCUOmALrbQOkNm7wx1I51f2DnQ7OkYvo=;
 b=VKpmTogE2sKbqfRdNHdUfnmG51t7iOZ0BdqkNXdvotfEKRwBaHb65jrenOE1o4hgSz
 csDKJLoRBx+MRnTM06D1AMGAK8lNz7EHA2QR7Cdd4GkDM5GvbsJBQw9CCqL5Lptbw9Rp
 JBivO1sf++HNIyfrSlbwsLgwoeSF5fVh7/BpzdCmMKQvZ78sVaUpLJdBPSjh6wJ0j6R0
 ryuumZPnVDSMkmDxsBF+XkgD/qdsey8VKfnEWviPJ+1ptg/9JAGgwbuQKWRFvO0YREnq
 9PaOGRvPPUEEDvPlgkjHRXF6jP30ta9Bfo2XLpA3lu13FwtUlD4xPSJtvyvsvZE2lh/h
 5tiA==
X-Gm-Message-State: AOJu0Yy2X0ejrmLJEKEekom8KuhAuGmDjsoEMwt67oE040TQcqYiuMdv
 ImU6ljjNY8tgWUhnAb3CKfP4J/E3u03pb7i2lUfGcPAY+wFcwogw0CP/fzlO/cAguWw=
X-Gm-Gg: ATEYQzyx9sZX92+L9Xf3mkQHeVQdCy8xtXF9wdto2YqMmF5K7aKYoZKSakIQOy8P8qQ
 4QYnus+1/+zcX1oVRqSRbHTxZa3mMvv6evwujp0dLic2HHlkptKKYD09DrseSLWi2yVMcEibZfo
 UdHTXWmTct4NKAw/Mo1pm022SF2REaxHcMjmIWlwvSWhyw7HuSCoZwGMvbfCzqttsOsBRbt2gFC
 zUpIEsFOb8cGki7u2KLxhebJtrbuMk6VYRmLBp3jiT0/SNiFxSFIyHXtq41hrhgcua3X8kzTI1t
 xKOGAoUAfnmxMMHhm0tnzX1NVBea1ZDX7J2LRFeynbdkt6ep+Zexd66yp1q86E3ELHBeirwXBcS
 9LVjQoq4cH1pIPq+sdlnsamcMMI1E53DukiY9LtvlkR0akWuqtXZJ6sN++5KVg0gdvAYef9q2mw
 A/L3k8gPvWgH4ZEVNR1E/X81iKwPXv5K81SHs=
X-Received: by 2002:a05:7022:ec16:b0:128:d375:f1cc with SMTP id
 a92af1059eb24-12a96e5f457mr54728c88.12.1774368761936; 
 Tue, 24 Mar 2026 09:12:41 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12a736bb1ccsm15239101c88.14.2026.03.24.09.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 09:12:41 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:12:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Robin Jarry
 <rjarry@redhat.com>, Parav Pandit <parav@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>, Tomasz
 Duszynski <tduszynski@marvell.com>, Chengwen Feng
 <fengchengwen@huawei.com>, Long Li <longli@microsoft.com>, Wei Hu
 <weh@microsoft.com>, Kevin Laatz <kevin.laatz@intel.com>
Subject: Re: [PATCH 6/8] bus: factorize device selection
Message-ID: <20260324091233.52e9babb@phoenix.local>
In-Reply-To: <20260323105306.1531689-7-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260323105306.1531689-7-david.marchand@redhat.com>
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

On Mon, 23 Mar 2026 11:53:00 +0100
David Marchand <david.marchand@redhat.com> wrote:

> All buses (thankfully) implement the same logic when it comes to
> selecting the devices to probe based on -a/-b options.
> As we want to adjust how devices are selected, provide a common helper
> in EAL and use it in the buses.
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> Reviewed-by: Robin Jarry <rjarry@redhat.com>
> ---
> Changes since RFC v2:
> - changed API to query about a device name and hide the devargs meaning
>   in the common code,

AI review found some issues in this one:

**Error**: In `drivers/dma/idxd/idxd_bus.c`, the refactored
`is_for_this_process_use` has a logic error. The old code could set
`retval` to 0 when a device was blocked:

```c
/* Old - retval could be set to 0 */
if (dsa_bus.bus.conf.scan_mode == RTE_BUS_SCAN_ALLOWLIST)
    retval = rte_bus_find_devargs(...) != NULL;
else
    retval = rte_bus_find_devargs(...) == NULL;
```

The new code only ever sets `retval = 1`, never clearing it:

```c
/* New - retval is never set to 0 */
if (retval && !rte_bus_is_ignored_device(&dsa_bus.bus, dev->device.name))
    retval = 1;
```

If a device should be ignored (blocked or not on the allow list),
`rte_bus_is_ignored_device` returns true, the condition is false, and
`retval` stays 1 from the earlier name-matching check. Blocked devices
will incorrectly pass through.

Suggested fix:
```c
if (retval)
    retval = !rte_bus_is_ignored_device(&dsa_bus.bus, dev->device.name);
```
