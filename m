Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4767C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 18:30:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F9D3402E2;
	Fri, 18 Apr 2025 20:30:40 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id DE185402D3
 for <dev@dpdk.org>; Fri, 18 Apr 2025 20:30:38 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso2447025b3a.1
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745001038;
 x=1745605838; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vy9f0afmihYhlORAO00bT7ZM7JiQdAGbrQwd5lX8mhU=;
 b=MhGhC0AI3jGDRCycNY8iWTsO780mZkBHwd5Z0vUmHqQgY82zLIIessArfgdFCEB0qv
 LqfwqI2KuQIa/erR9JBnTsKMY9rgu8Xk4EZox8YC3t/mOYg+TcU+SUR9AeYU2LZklRmd
 eCBJ2VycB6WuoWTv394vqUwCD0W7cAys1IMU16kbn7Ck2FEN9/hK7eq6kMAd+V0NvrcZ
 V6+/NBnNEJVabjbzh17YWHpRaZTkkyi94DG5lX2yj7zqPq1r8TYhzvR6nd+yChg/Q421
 boOVe9p5hB9IWMxi730Xxx9hagJ8s0QvhGCUbQscFo6iqqql3F1h2G3DKHSw3LvhXdLq
 kBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745001038; x=1745605838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vy9f0afmihYhlORAO00bT7ZM7JiQdAGbrQwd5lX8mhU=;
 b=lPTBxLn9hggT44xFFphgifbYNnLRiQaBURwJORjrDweDheJxvjoTIDWQ08lJztQqC4
 hR8j3kZ0/VLZr3kybriIzWjc7eRrgBjrrkGXuivtzKtNDmn287fjsRhOsNSusBinX6Vj
 BT13G6eI5v4vNnMwj5ypV8B0GhLnVhb8jb+94iUYs8+ZBSZt+Zou1obkdWPIyLwBOEKt
 g0ulQu1M3t1jXF3dtT/Shkg9uIvz2Pr8y29NCt7/1SUmHFtMXANKCuI7huOE8NMGE1hB
 n1Bbiish3G0LkA03+KwlSCYtMjIjuh2YJCtGcO7vQ/NYKvSU6G7nADVXQiZm7bv4MEQp
 q4kQ==
X-Gm-Message-State: AOJu0YyJYayxmvgCUV/GaSMqzrgAubfeRJqTkpJfuWnQBOoRVWCd0CiE
 CSl4RVO9s33ZPY+6LIubKR3G3VMo6PZs0xQGlWA4o7ODsoKdkfBfUA+U/TLbyCk=
X-Gm-Gg: ASbGncsIORvI/LaufRwERA9PyCCP8UjagiFdVuj23APtJEAN1SaEqLs5r0UhRuF/xFG
 S8FU46gSXaKnIHoXOX5yWq+ZaVxMs7hukUB8y5k9vuqG8+MfCfdR2SYNtelqTsT0U05JQzbByXY
 yHGB2CjNQe2M8EJJVAlgE+k4+CZcyUsgYKhQHGRSYp0csXlwtuGlCUdOgpicysyFtZmudzcI8Z8
 RvtwvoyYQwSyMqlZeRPpZE0Sxrke9ZhrPMKXAFV37+nmma+2cVwCf8NtQjlj8uTU3561KkHaZav
 xISKzpfLQwcwHdD2nkQeMT5ROzc1abaD33dxD8RYXm6wMiWlKnnfG3qevVdmHusB1oBB9JPmdsN
 mEuioC5a64VAgsPC2L3FIOYgYT+Q=
X-Google-Smtp-Source: AGHT+IHAnG6ZKTRtvuizoD7TrjJDvH7ilK7mnnYInNVghj1d88xub6jic53rOTaFDWVpgLWTh5OQ7g==
X-Received: by 2002:a05:6a00:1d9d:b0:736:ab49:a6e4 with SMTP id
 d2e1a72fcca58-73dc144d83emr5158437b3a.1.1745001037860; 
 Fri, 18 Apr 2025 11:30:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfab289asm1895746b3a.153.2025.04.18.11.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 11:30:37 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:30:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Feifei Wang <wff_light@vip.163.com>
Cc: dev@dpdk.org, Yi Chen <chenyi221@huawei.com>, Xin Wang
 <wangxin679@h-partners.com>, Feifei Wang <wangfeifei40@huawei.com>
Subject: Re: [RFC 17/18] net/hinic3: add FDIR flow control module
Message-ID: <20250418113036.2963a25c@hermes.local>
In-Reply-To: <20250418090621.9638-18-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250418090621.9638-18-wff_light@vip.163.com>
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

On Fri, 18 Apr 2025 17:06:03 +0800
Feifei Wang <wff_light@vip.163.com> wrote:

> +	/* Alloc TCAM filter memory. */
> +	tcam_filter = rte_zmalloc("hinic3_fdir_filter",
> +				  sizeof(struct hinic3_tcam_filter), 0);
> +	if (tcam_filter == NULL)
> +		return -ENOMEM;
> +	(void)rte_memcpy(&tcam_filter->tcam_key, tcam_key,
> +			 sizeof(struct hinic3_tcam_key));

This line has three issues.
  1. Don't use (void) cast, that is old BSD lint style.
  2. Don't use rte_memcpy() for simple fixed size things, use memcpy instead.
  3. Don't use memcpy when structure assignment would work.



