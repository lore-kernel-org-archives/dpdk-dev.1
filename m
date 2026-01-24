Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED35CD715EE
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 17:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D689F40289;
	Sat, 24 Jan 2026 18:12:45 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id 4680640274
 for <dev@dpdk.org>; Sat, 24 Jan 2026 18:12:44 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so3001057f8f.1
 for <dev@dpdk.org>; Sat, 24 Jan 2026 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769274764;
 x=1769879564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvO4XocPMhc/KJC2GromDfAofqNT6USIbd2n4Iu1sYY=;
 b=MZSROBTyvb0x/udZWCdRaxe+md1H9n0AYmfQS2p9PpbbuN+1Vvw7BFoRtZgwE4casz
 MTLEAewcVAR8jvTTB04rdQf0RxRS1o9TkJqWpqWJoaURdDW30fl5nxK1gNPT0jEWWvvR
 vrPQFj1iPZ0LO7VhYRb4WlvO7/fGnl+pmWwYJPKGh/YV/ZZbzYjCUOKE/VlLKALQTAFr
 HEk6ty6zPcfBrkLFbiCWotV8vsNd5VDxr9hGYyFnKZg5y2fAfYRBcPXV0U8d6mfXrGcU
 n6i9xdkfw/4k++TegSxxtLbNlgXpUjH/gPMiXEWuv5ljJ2gNbaNckgr3PnrwWyZGMJGZ
 iRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769274764; x=1769879564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvO4XocPMhc/KJC2GromDfAofqNT6USIbd2n4Iu1sYY=;
 b=K4cvwDGAD1WAa1dPDAIkmVYjYZb/puI2X2Y3VhBfBIwJB9vezkrz6ltJiS1rC2NVPo
 /3NLhfF3kX1gOCHVOLjAPOAG4Qpnplfo4ogrEjKD6uw2qeK8+otma/WOdRcnNEPg3cyO
 l4eCfAUbX9uE9eXcSlN6otKZT5cDZlDTSofgNb2WorLhWngHhti2GNJtk4lMNQDB+WM5
 9jfdeNOYGN295EzJS393Do+/RPwBJjv65mic7HUd8MrlVMmI3lKTi6BZJ8v7x+3Z1ery
 NzBQ1sp7SOcPOtHInmq9UTXTEtrlu/xQtwrqnawroMcMbNe1eIj0/Dmk6NM/dz+Fx/qs
 PYiQ==
X-Gm-Message-State: AOJu0Yzp7PwXsE9YQa7he83W3pPIfyk5DXF2Qy+fpPngujPvYwpDxN0d
 /swTbnG5DM3RGcns4egwrS0jM9RNWQ6IDI5Z7oIjimXCWeTZJcta+u3HGlaL7Ot/ss4=
X-Gm-Gg: AZuq6aLwQOSsYVzuIjKyGSrRYX1NYbMG9DmISpC540VPVpyM1kYuHM60W61qtjLkkIH
 1/d0afZ7siwh4yFvYHV4WwGpgsV6NwOUTHpu/4BzZgaZKx9OnKigWGld3+DHJ4ekq3s1baOIZUh
 S5+ou4mjhSNJLeLx4/U8fAxNlYaEHSUOyaugBoKPwnZYHXlTrtMrQzPIknG1H1SMebPyP8i8TF3
 FtEjK+7gegEenNRvgpYo5T5fSOalXTwcey299QHmL7xcIlD08a7g7plc8Ek8ESnbxJJwsSqUPmM
 DY61U2Xkbdy4rLyTy2G7XZe4PCDsE2coe0FKS4PucrZvb3O3IQ5Vq5VsNRkzfwDvXKYyKRNVj09
 VRx/y3J0zdbxm3TEyzwDhkD+dUE/ZXetp5gA5//j9916FWWC+H5JKy0FPTwqVVE5yWaUk/3Igvq
 sxk3MYIPafD7miztFyPlGjGtllYuXoGGlm1GkCnwzFSYIe7Y/+zXKh
X-Received: by 2002:a05:6000:2212:b0:435:95c9:687a with SMTP id
 ffacd0b85a97d-435b158774emr10751746f8f.4.1769274763814; 
 Sat, 24 Jan 2026 09:12:43 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1b6e2besm15888538f8f.0.2026.01.24.09.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 09:12:43 -0800 (PST)
Date: Sat, 24 Jan 2026 09:12:38 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] test: split up BPF tests
Message-ID: <20260124091238.72c1aa33@phoenix.local>
In-Reply-To: <7207dfbe4aa74311aee79389af885703@huawei.com>
References: <20260122193923.49253-1-stephen@networkplumber.org>
 <7207dfbe4aa74311aee79389af885703@huawei.com>
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

On Fri, 23 Jan 2026 10:44:19 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> > The BPF tests have two sections. One is doing tests of the
> > BPF interpreter and the other is for testing the ELF load part.
> > The latter requires the null PMD to work, so only build it
> > present.  
> 
> Splitting BPF tests into multiple files makes sense, and not just because of
> dependencies.
> 
> Coupling ELF tests with the presence of null PMD is strange, there might be a
> lot of BPF ELF tests that do not depend on null or any PMD, and there might be
> other BPF tests depending on PMD. Maybe we should call the new file
> test_bpf_ethdev.c instead (following the header name rte_bpf_ethdev.h ,
> regardless of what one thinks of the name), or something like this.

I did more experiments and a simplistic split up (via AI)
did not work because the filter test is using similar test to call DPDK function.
There actually is a bunch of overlap, and duplicating code is worse.

But it is possible to just skip the filtering tests if null PMD
is not compiled in.  The filtering tests do need a device to hang
their filters off of and null was used elsewhere already.

Working on a revision to do that.
