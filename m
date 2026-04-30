Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78159FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 14:05:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 334944021F;
	Thu, 30 Apr 2026 16:05:40 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 6B4D7400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 16:05:39 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12c88e5f4aeso681978c88.0
 for <dev@dpdk.org>; Thu, 30 Apr 2026 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777557938;
 x=1778162738; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhhZVM0/XA105f0xUVNPCNuKTpF9dODt0Q9giJOV5ao=;
 b=ZIFS1NbPtzfgjocRoFFHlEF3WcQizlCH3y3myCL81N5+ge3RiTn5stS8K+er6qkg+p
 3QkLu8J6JI5Y2r/KNOxb4f8FXlQ2NjzTUvuHzZ6RJHzzMNLZR9apvbGv7AGbr1vH4KIs
 g85/V8/keFlGo2+TJD7FQauU5Gga7ydYf3g+2KOWjD18fcsrkQZA/rox1y+s/EaSJ4/H
 NRMDmabYxTDDtALybeNks7MO1qLSjd4uum1OvrWfGABJbQ3yYQGalXHoX7gXlslwlbt/
 HPfIEwuGvF+swlqRLVxAnx2IJXYff8jFzFsPmW7s9Xokoq7KQftWC0we3QQqH+fwthpO
 nLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777557938; x=1778162738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zhhZVM0/XA105f0xUVNPCNuKTpF9dODt0Q9giJOV5ao=;
 b=UFjbS1SLphoPfl+bwro3gGW8iHTaDAVTb438a83QAwPcCUzE1topt7K5gHPhHsRJ2J
 fx0F5ZX7ZnKO8ubWu1KW5K5sLfaWoh5Q58jilxaYtfPaDABN5Sb22rom/Wl4h+uOEIsX
 SiQ48rxBtmz+Q2sGGz7jtm3eSOhEO6piclPwjU31mGWeTcmEH970tw8+ZXCfRhAsuZQ7
 9NXEbtxk+IrAZr9MYcAMQqZlkaXVTp6xpJ2wIwgCoPG+P0aKdc/4cGs4WF/3iIEbGcnr
 02zrqGZDBd9CJeBBXWOa95TQNlSo+2G+ivSaVNmkHyBZjxxtVBcCejplqeWreiRLmBAp
 VZCQ==
X-Gm-Message-State: AOJu0YwhrS7x7AQOavjHJ6ks3C2Xg6VzGfIiflF6Ne5KxyJ5loIopMNZ
 GbuWvDQhy3zjKxq55TzM62o+XYiNA9ZT3y676yLJXlBA7RFVHsFMIWExnUjymLtM4vo=
X-Gm-Gg: AeBDiesd25HSDzuKOxEYEWFrXEfB8NIohwPp7iaUDOCwXCXNUen5wEeH7qNp9eys4xE
 hQqkGHxUR7rkhRZLnJJjo4fBMRAXUHsqItZmUXqpz7aa+m1LhIgyCFKCPTMnFlmlpzb6pOupWxF
 ctXwm3OZ430kkoiAD77YfvPqjv2iyphriL2OVOIoRRCookhjyAHBjKuT9fZCgfQKXa90/cE4X5a
 8Ph0yg1tLg7IMm4tdQl2B8YHM88J7QwVj74L9u77coZ17bqoQ121paj9FpbGXQzMuyoDes1uuqE
 kV1HrbIIaH19jnudlgBKQeib6Ny7y8kLN9n4YFGTfEF5y65AHwt04+eu9yOHvtUcT2iaeFOkMaR
 HkBKO7ueXi9Apefyz4LEKjfh3KG8n3Y6H5IXNNgYUtSaQm9jzACdkcK6+EMLJpdvoxNyWE0rLiv
 PUSjcThp9XEXS5pU0oFV6+aMnzJEukVDfvznDUUNN+rAPplg==
X-Received: by 2002:a05:7022:6b9b:b0:128:ceac:6db4 with SMTP id
 a92af1059eb24-12dec70f651mr1017621c88.6.1777557937647; 
 Thu, 30 Apr 2026 07:05:37 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm9716516c88.5.2026.04.30.07.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:05:36 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:05:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dawid Wesierski <dawid.wesierski@intel.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, anatoly.burakov@intel.com,
 vladimir.medvedkin@intel.com, reshma.pattan@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, marek.kasiewicz@intel.com
Subject: Re: [PATCH 6/7] pcapng: add user-supplied timestamp support
Message-ID: <20260430070533.095c7e00@phoenix.local>
In-Reply-To: <20260429073111.3712950-7-dawid.wesierski@intel.com>
References: <20260429073111.3712950-1-dawid.wesierski@intel.com>
 <20260429073111.3712950-7-dawid.wesierski@intel.com>
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

On Wed, 29 Apr 2026 03:31:10 -0400
Dawid Wesierski <dawid.wesierski@intel.com> wrote:

> From: Marek Kasiewicz <marek.kasiewicz@intel.com>
> 
> Add rte_pcapng_copy_ts() which accepts an optional timestamp parameter
> in nanoseconds. When the timestamp is non-zero, it is used directly
> instead of reading the TSC. This allows applications to provide
> hardware PTP timestamps from the NIC, enabling accurate packet capture
> with PTP-domain timing rather than host-local TSC values.
> 
> The existing rte_pcapng_copy() function is preserved as a static inline
> wrapper that passes zero for backward compatibility.
> 
> The TSC-to-epoch conversion in the write path is removed since callers
> providing hardware timestamps have already performed the conversion.
> 
> 
> Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
> Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>

Rather than having two functions, it would simpler to just use function
versioning and add timestamp parameter. There is only one caller in the tree
right now.
