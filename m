Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB63606A32F
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=t/nd2C5D
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B251402DE;
	Thu, 19 Nov 2026 04:15:27 +0100 (CET)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTPS id 65F36402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 04:15:25 +0100 (CET)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cdb9f760337so256672a12.0
 for <dev@dpdk.org>; Wed, 18 Nov 2026 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1795058123;
 x=1795662923; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KpvOBDLMm760Jj9aIiM/t4vryTkhaAmWluToSTe64sk=;
 b=t/nd2C5Dqm2/0t3fTpsFXNyTAszgaIkUAMLaHS40KV98tNvYnNnkJQGPD93hlzxm1y
 URWd0sv8QthWERY1wlYBAAlBLZV1cJ5kPj9FkN6JncsTLfB+bmkfO2d6a/V05IcqqLDg
 vz/n7xO8MEkIsUhT38eScCcpX7xvyFqZXDLlgEVOgtfb2GCLSXjhe2o//i5ACFtG8lD1
 xB8zs+LKuzTrVTA3DoxwHBsjDNWLxHudV8QuvpDu8X28QL583f8iK4JOHpqIdjF92iDC
 MBJPGbF8gX0EdFXHnVaBfpBS0VGTEm2+wMlE7nMWxA3OtSm6rqKc+CPnexGGaJcZOoGQ
 qXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795058123; x=1795662923;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KpvOBDLMm760Jj9aIiM/t4vryTkhaAmWluToSTe64sk=;
 b=oeN9P2QCXJs8qZxmXdhxTe7If6dSU5VeIwROiC46sd9js8bDgafPgC/s+PV8TPFjGa
 UOOHpEqCCFzo0NxfknqfBUYcwfn1/kZlEnOy4PFcmikEpLVXGanfPQiTZ3UY+yWUXyHm
 GMGfjOxNGSigZ9bN4Wq2JLep2P9q8jrHtHXv6IRPL243VwfKwJ3gFWRcbtN4/sI97CYa
 3pGB/DGeTiCVLGzEOnF2utH+PSO0aDP5hgpBcjwoNSaBPluAulBfZ5EPmsmUm8xt2Sv3
 EvGDeDbPgGC3SC1pmGRCkEyIkiyGVDHJfeFVt2NQOKCnz7IZjp3i3ysXnR1QQsBEXneI
 3Evg==
X-Gm-Message-State: APuU4Z/5T1k8Pu3lzSWiY+SNoT+o/IFBAiUGNI0Vhp52aJpdjGG6yXDf
 RzR0Bkk9vQG1foKSzBTUf4uuK14Urb0sIpyK5VKh8XPBhoSOYYuh/O8hkVWHTBs8E7o=
X-Gm-Gg: AZFdTZcCDYs5mnTizS/CI0OiigwEq51CH1jKTqgqH0Z+IcmL6tdygLK7sabUMqjPQBC
 eRwrJoEQBjP5XmxFq9KGTxw+675pPd36k29AP+Dw/yd5zGZvmX7ud20ahEpeVwo+5CApg/ACfzS
 pvzfpjG+e33L5FTRiEkoVwW8oBe1m1c5eCfy4NbkapBHoub3gkcgVSzKXX35Y/ExX+G6QWh0hRX
 y8zFAJOaNcaPoSgqk3bKAfuu5UkGYWMcdmIQ3Bc1Ll5Pvnmjk6oq6eAzd+u86QD8eA4Wp8YCNru
 Vm4DlvHBi6bJ5+rGcuphT5VEzzUOiPxU4eGZtHtCbl6BMbDGNWKZ7Mk16V58S3PQ/GSHq2qpfJG
 ZmGnYEGlFZpbU1jM/g4JuaXeeHd6A6SQsIcCjLQ9LULXbR8Kt6SzpzxIZ3oszW05DYs4f8V3YO+
 lHU55zr4k2nDKGDt7qeOGktZdRL+86gJLka/Zo2FSB6ICYhPLjkBuKu0LdOWPkqcXpl5bqjYpwl
 PbOZ3s4MOtOGhHJbMfmFwXXrNZp/xkcJDVYYMOMskcKPBrbNwotx3LrppvGUk6blfuvzE6z9Xho
 XLmCnw+Jf/Zr1tUWWWttIFATAW5jvu8/Nz55Nd6tex/LAWU8tM5TXl475TiGLRZ3RIq+PKM=
X-Received: by 2002:a17:90b:1d4e:b0:3b3:b3c0:71c8 with SMTP id
 98e67ed59e1d1-3b3ffa1cebemr436805a91.13.1795058123463; 
 Wed, 18 Nov 2026 19:15:23 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405776019sm241292a91.4.2026.11.18.19.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 19:15:23 -0800 (PST)
Date: Wed, 18 Nov 2026 19:15:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ajit Kumar <Ajit.Kumar@amd.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2] net/axgbe: serialize PHY and link status access
Message-ID: <20261118191521.6f272ebe@phoenix.local>
In-Reply-To: <20261117094805.4134371-1-Ajit.Kumar@amd.com>
References: <20261112135611.2757325-1-Ajit.Kumar@amd.com>
 <20261117094805.4134371-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 15:18:05 +0530
Ajit Kumar <Ajit.Kumar@amd.com> wrote:

> From: Ajit Kumar <ajit.kumar@amd.com>
> 
> The I2C and MDIO buses are shared by all ports on the device.
> axgbe_phy_get_comm_ownership() takes the per-port phy_mutex, which
> does not stop two ports in the same process from using the bus at
> once, causing I2C failures (-EAGAIN, -ENOTCONN, -ETIMEDOUT) and
> incorrect link status reporting.
> 
> Add a driver-wide mutex taken before the per-port one, as the Linux
> xgbe driver does (xgbe_phy_comm_lock), which this DPDK PMD lost when
> its equivalent global lock became the per-port pdata->phy_mutex.
> 
> This fix applies to ports owned by a single process. If ports of the
> same device are ever split across separate processes, or one port
> stays with the kernel xgbe driver, the hardware mutex registers
> remain the only arbitration between them; this is a pre-existing
> limitation, not something this patch changes.

Applied to next-net for 27.03 but I trimmed the commit message down.
The version change should be below cutline --- and the link status
part was not here anymore
