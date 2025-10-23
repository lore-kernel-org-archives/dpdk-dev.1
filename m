Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427A3CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:54:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EE15402F1;
	Thu, 23 Oct 2025 18:54:14 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 8AA04402A1
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:54:12 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-292fd52d527so11775245ad.2
 for <dev@dpdk.org>; Thu, 23 Oct 2025 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761238452;
 x=1761843252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxwbxH0MC7Ia8rp2w1OHAKC7oBLPl6v/lfz1zjUSOaI=;
 b=qHS/nHAB2ak76SKJGJLdvf3AlBBT1r4xNpU4n6dSIwrQGO5hFd9sSwAUzkovo8gfr6
 z4YbUevsSKCYjJcLk59L9FG/711hp016/JDzyew4qWtziI/oSD292qXxUx/t93BJJkhL
 ZoHzfAtBWFHY9yexbSUHa+mPvaXC0Mjfp+OBziGJHtw6AJFBdrXxfwyKQi/e6WstVvdO
 17PcEaZmFNGclPnvoO+Qw/CIMASc6DvZZ+05qK6wAW4w0X/Bl6Z3nIQY0dBcBCvaXjYA
 eSrYdGbuZ46rZJN4/AX+ekxs8nUS0i9Sqao5Zjo869XyTtG3Xz5PcnzImMm2ToKqiQyi
 VPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761238452; x=1761843252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxwbxH0MC7Ia8rp2w1OHAKC7oBLPl6v/lfz1zjUSOaI=;
 b=XqwQIwUuywFu06fc9PATEuvfPSuNHNC7H0pQmlg7CcrNzDcDXajCxHvHYgYvwwADho
 8zwIz1A6wiixWTiuAxl1goop2HKWTC7fB2n5ps7iQff8VS9pqHgm6vmx8TXQ1gXpNdLs
 CdOeMd+lWybWvFyLQo7FvmocB0jjZUicYXPPb7K9fKwCHXWJiCWUwyYhQ0Mo4anH35Np
 KHltlr67B2k+SZxaX/gsGUyrp7AaJNcJcBkvSz2lCFhNlZROtoorwQG3LOCrm9KzAIu7
 beFkRTKyP52sZqjMAf2uTUEGGDsxyGBBMWQd5cc5tw+lHCxPgmabYxZpdm0VXiQr6pUj
 X2HQ==
X-Gm-Message-State: AOJu0YwU1yXlrSVzpxF3ft3aksmHvTwe2SmqcpD0YASsz32JsnbYpZp5
 NC1sJ3H3a+YneG+e5I+RKjzxD3ECI5RXQgK6fnbprJvbQCe501W7zBZpXZoLsya54rI=
X-Gm-Gg: ASbGnctF83hOpBHDhTQNpG5AjetSJa79N2P2dxfOZDUrBxRxjVcne3nYhi0gmFJiO8m
 t2TakCkspDIkgDVYHkkvz7z5PUZSMY/oUfpmo9vIfkiBPlBL157fTn0VDNjivBIBCc5//M9MHeC
 lR3IdBmglZdYCv4fbBwVgIqyUpiCPvT8p0uYth+hfM6cQlY7HKrmwgtlodoOpEZRJz/+ddbspNu
 L508Bvq5BwAj1eg4ihtnk2Sh1aZ4GDnjFIMdbwFsMjKeCcG4R4jNEPL8hlStHCuYL/ddWL/aGSd
 H5dLLd7qLvmicIuP5Visnn9TeduvqIYP/2QLj9xSUT952JavCw07Ja6PBZac9KaM2egNWrcxFdn
 t/c4H9IUdYVBVJHNmTp1eD1cLmCIAvxchGwXmn7rCn6EP2lE8HWvk0R5G66VsrtC8xvvY+xSFOq
 AZzs0pKFcfWo8OaduTBB8kOPoMQUJnr5FAhmMq1lwHxvQ=
X-Google-Smtp-Source: AGHT+IHIv6N98tHHuQssET2KtC5spTdHzxKGiyQpwI7sBWxWvsB9NfuZV8O0igb/PQWv6EUZdsn7pg==
X-Received: by 2002:a17:903:3d0c:b0:25d:d848:1cca with SMTP id
 d9443c01a7336-290ca30ddb5mr305958265ad.35.1761238451585; 
 Thu, 23 Oct 2025 09:54:11 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dda577csm28594795ad.13.2025.10.23.09.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:54:11 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:54:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v3] net/vmxnet3: disable RSS for single queue
 configuration for ESX8.0+ versions
Message-ID: <20251023095409.55bc74c4@phoenix>
In-Reply-To: <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
References: <20251022155651.9818-1-amiyaranjan.mohakud@gmail.com>
 <20251023083019.18792-1-amiyaranjan.mohakud@gmail.com>
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

On Thu, 23 Oct 2025 14:00:19 +0530
Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com> wrote:

> vmxnet3_v4_rss_configure() while writing to BAR register. It's very
> specific to single queue configuration.
> 
> https://mails.dpdk.org/archives/users/2025-April/008236.html
> 
> Bugzilla ID:1789
> Fixes: 52ec00fd1474e8 ("net/vmxnet3: fix RSS setting on v4")
> Cc: stable@dpdk.org
> 
> v2:
>  - Fixed typo in commit message
> v3:
>  - Checking if RSS is already enabled
> 
> Signed-off-by: Amiya Ranjan Mohakud <amiyaranjan.mohakud@gmail.com>

Queued to next-net
