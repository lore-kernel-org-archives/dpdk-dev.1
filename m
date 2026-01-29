Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8243AD61033
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 17:21:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72D61402D3;
	Thu, 29 Jan 2026 18:21:53 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id F2795402BA
 for <dev@dpdk.org>; Thu, 29 Jan 2026 18:21:51 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so15426655e9.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 09:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769707311;
 x=1770312111; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LV1p771MD1jtZ2OMuB50O6tz4Lms5sdwVU20uD9dYBw=;
 b=xsdWgf0qO2/Ao2Cf9zLfNI1pLSg3YHG6lxkIoKILvpW/Agblrlhs7m4LBPV/imltsr
 gRCTakKxCebFh8Ae3dusTIaVf6apUfnKVmTPyWg+Fto2ES4NzTBkflQkeGYxxBv2ItuZ
 6TPAsdDoEJWIUitbxCZdWjR/jrCBlYUQJeWv6wBVu3UXS+P8ZzrxDRxTkllNVPWMTHj0
 Vm13leib6wEfgKx8cpJN0R40ErdUDOnfDa4wgC408iyU7z8FWbQ8zuuj2UNN7RtPKP3F
 uROp1jYq5XmEXtvG6WgjERg0nBgjx1sUTZxuLg0NHofCeSWRdW4+N4ivTr0S3aY4rENp
 3wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707311; x=1770312111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LV1p771MD1jtZ2OMuB50O6tz4Lms5sdwVU20uD9dYBw=;
 b=S5zqTtkQj88+W52fIbrUq6bRkZ42F3bD23Zy4b3/RJpLTBBLLvydtKBp+zCpibeOrk
 Qy06PaY2QQ1gyJe1SNobRocs8BOM0DBpZ69wrWFOlEFhlqrV/nVAvfEHiKBli8zPW2G2
 Pc75H03ZiLkoPR3a+JmCNWEVb4ksgBv5aCfoY+xPb5rv/Bx8O/KHRe6ZsE5QD7sVhMyO
 CaDLLrdQHU79khFBpIcQsj3pDb6AAau4XWTLj+Cn4X7+cVE4SCjpDlpRoflyVlmm+h8i
 p6NwHRLBlQyjdqgcAM8uf2XGMH8CFEw+Dn7jhUZ+eEeTCXg7SOyiEzHj2qUNnXrwPV9c
 Sgiw==
X-Gm-Message-State: AOJu0YyeRBKge5jhN9XPRiP7oxhzN91H0iMpkefzy5YJX+IGCuYoB79Z
 hukxeT3wY2oU8pHaLy/R6QDfN7AYsEI0SdL6jumgGgcWeUmupz2nOeBHM3roLkcTTgE=
X-Gm-Gg: AZuq6aLRtqr8ARVcYd6T4TJHDBL9PRDTrz44a6S3NbHJAFRbVMURITJQiXDJNcX3V4j
 NZHaswggXB3Pr2UaswqMecgvwMqf0/lnhzjrzA0ugOAWI9CN6lQVMkyL4sqzyBN3axNvploe9/P
 sGlLgFpDsK56BCrl1FHw0sssnxaxCO8wKbCC+MjANcLAghaqLHsfAvZ+/WwFk6OefNzA3QIZM6p
 Q0KDMWFEE35gqxWQrg3lwt90nh8OMjnCWYpT39D7HVIXwx0MU3aPBu9N0i20KceC9gFF1DWiv0c
 0PFP1RcC7tfm0Gcr5DewQ1XSxSNkIQKszk+/KTrZqQ+ZKAS+lMNoyCuzmELndgh0W5VP1Zg3qCq
 wHQjq8F+4ZlQvOwcAQ7e4/umeeAvXw7aXjVjlxiPRywAMWah+PLqhiThHqhRxcjkqPK7N8q5fdL
 vcefE1S3/Llbtl4AppKSJZ9efNg8uiFXin/YHpgh6HOoKOYeJKcinh
X-Received: by 2002:a05:600c:154f:b0:47e:e2ec:9960 with SMTP id
 5b1f17b1804b1-48069c9a68amr149538695e9.35.1769707311035; 
 Thu, 29 Jan 2026 09:21:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c40e04sm207026555e9.13.2026.01.29.09.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:21:50 -0800 (PST)
Date: Thu, 29 Jan 2026 09:21:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shani Peretz <shperetz@nvidia.com>
Cc: <dev@dpdk.org>, <maxime.coquelin@redhat.com>, <stable@dpdk.org>, Chenbo
 Xia <chenbox@nvidia.com>, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v3] vhost: fix use-after-free race during cleanup
Message-ID: <20260129092143.578e9a6d@phoenix.local>
In-Reply-To: <20260129083435.5054-1-shperetz@nvidia.com>
References: <20251104080931.8102-1-shperetz@nvidia.com>
 <20260129083435.5054-1-shperetz@nvidia.com>
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

On Thu, 29 Jan 2026 10:34:34 +0200
Shani Peretz <shperetz@nvidia.com> wrote:

> During cleanup, a race condition existed:
> 
>   Main Thread:                    Event Dispatch Thread:
>   1. Remove fds from fdset        while (1) {
>   2. Close file descriptors           epoll_wait() [gets interrupted]
>   3. rte_eal_cleanup()                [continues loop]
>   4. Unmap hugepages                  Accesses fdset...   CRASH
>                                   }
> 
> There was no explicit cleanup of the fdset structure.
> The fdset structure is allocated with rte_zmalloc() and the memory would
> only be reclaimed at application shutdown when rte_eal_cleanup() is called,
> which invokes rte_eal_memory_detach() to unmap all the hugepage memory.
> Meanwhile, the event dispatch thread could still be running and accessing
> the fdset.
> 
> The code had a `destroy` flag that the event dispatch thread checked,
> but it was never set during cleanup, and the code never waited for
> the thread to actually exit before freeing memory.
> 
> To fix this, the commit implements fdset_destroy() that sets the destroy
> flag with mutex protection, waits for thread termination, and cleans up
> all resources including the fdset memory.
> 
> Update socket.c to call fdset_destroy() when the last vhost-user socket
> is unregistered.
> 
> Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>

It is preferable not to use posix mutex in DPDK code.
Can this be done with regular locks or better yet stdatomic instead.
