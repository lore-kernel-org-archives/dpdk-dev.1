Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCEDCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBC8C4021F;
	Thu, 28 May 2026 23:10:21 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id CFB414003C
 for <dev@dpdk.org>; Thu, 28 May 2026 23:10:20 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304d8e3bb72so2460892eec.1
 for <dev@dpdk.org>; Thu, 28 May 2026 14:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780002620;
 x=1780607420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc1fYQ9bkrZKY/U55OyMvWypdapmF7vjl/IfugEAIR8=;
 b=ti22J+xxRDYSiiPxUjDeA+Uv6GBj+QHXg4ZbgsvAsgpn6LzstGZS2sB7aEsceKgm3Q
 +yJ1JVEX8dFkIsjMMDYXaArHLt3U6NFu19pI2udhIItxd5P5bt7A3+dW4qdZcmdOaFPa
 sY5qiTfZd4CqzYTrlbtvH2VsOAxMmIQlQVCmKgjIFMmHw8wpHC1O3HX8GnBIdszmDnBL
 N7jUhb7tob345y0r7MW+Kdu1J6w8J3fHTudGapjjJbnyljUFaIBtpblkM1Mz68ntzzEA
 bR75FePwpo0bPtCjc/pZeocn4N3GeJBoZbpFsyVbZy7h/MQwhDCs3a17KQMxDKNfH/8C
 qr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780002620; x=1780607420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bc1fYQ9bkrZKY/U55OyMvWypdapmF7vjl/IfugEAIR8=;
 b=cx5sto7ftmu7zelhsuzcUa/O2GQzAEfVIl/MXdH5nJU7SKLAZReuAn4dta7DGNEU7e
 w1fjZI/MKtYhVTZt5vNyXIjlC0I3NTkeSa7plkvsLIY+aJAI33LzEy0vyu+G6dqmCXoj
 Y64lg5jOg8ymtEqi0o8tkA9Cpb4HwnUNZ5inLEtaHK3Vuyazj7Iet4anyROnMHCPWKfH
 URyxv9+1pxOPU4NZFYEKnmevXlNBmvMu8tYwUogyEYcQx0ftYbglw4bU/MkXbd9sQXCe
 xfmGR/faBX+6dWHXYWoG9QSykupz8RcJS57WFvxMyh+HadzcUZZOHc+5KPhY8QqAcpdT
 MslQ==
X-Gm-Message-State: AOJu0YxBfIGr5ZC/7J1HzozFXXV8g0WXBRzTl6HG2DZGShfQFIvlW3/z
 yuKg0k2sR/4fqVfujZyDgkMsO5JrMecoDSvwjEXfVweBrnR4Rz4XG4w7RXwywQhsRK8=
X-Gm-Gg: Acq92OFFhrJli7H6DwL69zJUNUT+evCb2ynFEH4C7/5jvM3onx1MEKxd0PWLbRewjQG
 FIp3MKbr/wwHnkNagbSKvzhov9FoXHPmsNr19jywMDbtUuzhAnv/l60jYmEg1Jr7Fg/PWNJeP9m
 03uhPnGsdiDTkJ3j5dX9KrbRrW/ERUrW6dCj2YrRZEADYIibWIWlojJMIJF+wr20RxlfV6/vStG
 PQ2SxcZ+uFyY2lcukwdEwejsMOsFJZc7eo40SAJ+L+0dEkpxwhNjd6x6cvExDUUrYM0kVGwHXlc
 VA7/fa4qejk6WxY2uZ0y7Q1k/UJOkGdn/XdtrC/DyZHbqaT0iVsljd3Ionx+SuJ5aH+rD3euQVH
 ZJ6XvvPDjqMIb00qjtAD3ZiOfI1YIvJYvhHiEeYfY4XCeK0Z6wbl7+A0Na1CcHk8DgEdgeIMAgA
 yove1rPyh+1/JDXHHzDitk2gVzKusNI2CcV6I7+0AxfGMw/i4aIPBPVI5OJMjXFH37DGnFW443N
 3I=
X-Received: by 2002:a05:7300:cb11:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-304eb105720mr91143eec.4.1780002619717; 
 Thu, 28 May 2026 14:10:19 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e98c779dsm314431eec.17.2026.05.28.14.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 14:10:19 -0700 (PDT)
Date: Thu, 28 May 2026 14:10:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sudheendra Sampath <giveback4fun@gmail.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad
 Tummala <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermanager
Message-ID: <20260528141016.5470472d@phoenix.local>
In-Reply-To: <20260528190449.66254-1-giveback4fun@gmail.com>
References: <20260528190449.66254-1-giveback4fun@gmail.com>
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

On Thu, 28 May 2026 19:04:48 +0000
Sudheendra Sampath <giveback4fun@gmail.com> wrote:

> This patch for bug 1832 will do the following:
> 1.  If /run/dpdk is not present, it will create it first with and
>     then create powermanager directory underneath it.
> 2.  If /run/dpdk is present, it will verify it is actually a directory
>     before creating subdirectory, powermanager.
> 
> All directory permissions are 0700.
> 
> Signed-off-by: Sudheendra Sampath <giveback4fun@gmail.com>
> ---

Lots of issues with hardcoding the path here.
Longer explanation from AI review.


Thanks for the patch. A few issues to address before this can be merged:

Two correctness bugs in the new recovery block:

- After creating the directories, d is still NULL but the code falls through to readdir(d). The recovery path must call opendir() again (and return -1 if that also fails) before the readdir loop.

- path_stat is only populated when stat() succeeds. The S_ISDIR(path_stat.st_mode) check runs on uninitialised memory when stat() returned an error and mkdir() was used. Restructure as if (stat(...) == 0) { check S_ISDIR } else { mkdir }.

Other items:

- doc/guides/sample_app_ug/vm_power_management.rst still references /tmp/powermonitor/ in several places; code and docs need to change together.

- Hardcoding /run/dpdk does not follow the DPDK runtime-dir convention and breaks non-root usage. 
  Please consider using rte_eal_get_runtime_dir() (or at least the same getuid() / RUNTIME_DIRECTORY logic as eal_create_runtime_dir()) instead.

- Subject says "powermanager" but the path is "powermonitor".

- The two new RTE_LOG messages are missing trailing "\n".

- Please add a proper Fixes: tag (12-char hash) for the commit that introduced /tmp/powermonitor.

Stephen
