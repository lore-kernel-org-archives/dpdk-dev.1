Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF8C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 15:36:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75BC74029E;
	Wed, 12 Mar 2025 16:36:17 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 4FF1540265
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:36:15 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-22185cddbffso20640025ad.1
 for <dev@dpdk.org>; Wed, 12 Mar 2025 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741793774;
 x=1742398574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P/2+WflOB4mHP8YlRDldi0exnr22U95yBqThVo2a5Y0=;
 b=OFY1sFbIo+0aAblftB5suZLfqY1FFe6PskDGH8ZX5KudL9lR4iMEatZ/8IUu36aSql
 Cq8yOG8PU7/5crUPQJmDqSPJh541gITQX074Ju5DltBwpvuP4Y5F/OdLfA7huBC5JNpN
 LWVMUHNQ5o7/VhfjTn3S/VS2h5pfbI+EOr4IvjfdfixQjRGMO543KD38DJmxhkSB7Lp0
 +DkoaAb5j1Mn/oTP4NpIHgifipIhHthjWpJADoUIlxokYYudIxiQxyfxZfHStYsbcUEv
 B8XoG4duNZt09msSFo3B4JEswHE0By3Y8oKc/tJVx9KOww888M80ekB+7BpA4pyedxIL
 dJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741793774; x=1742398574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P/2+WflOB4mHP8YlRDldi0exnr22U95yBqThVo2a5Y0=;
 b=d5Z12RQp7vJCIGVCQA6U7VyQ/HCT/UaWP+ZZ1fJJ3BH9B0slOzGoVzh+phNKMq9Z1v
 Ac9CVE992Szte1fhw2oaQew2RkoOYzCkxaQpIUaUhiewPXPlvcB9XYSvWnSqBVOEMsDM
 D0kO8k1PnOqZiqb6acpXhaa9RkRynYI0pTEWylNzBoGVPGPUZPObbL0j81IILfS+R6n2
 PcDHAzxJAXbTDtzSKiaB2JM7Ehd1iBvR5Jlxuz6s34is5vrhmyz1hneqiE9naQbH5xon
 z5UIbT61sLi8GU1aAZeQd7IMcbTHp9t83SK1sb13Y//KMIULSr+ytkSyL1lKknrah1nE
 n90A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBduBROpDQ2Ip4xh05xd+yNKcuilUlZACpuS2XNdYuiBVPVwhY+aepB4GYSC5GK3dKMjs=@dpdk.org
X-Gm-Message-State: AOJu0Yy5BSzYNrgSHMB5BUTM4SQZjapDgCwoE30YVqC6KvlltUkl1nf+
 hRqah6kLcr49E4jnOEEvUepzeuGh/x7sDm/6dakb+wL9iKzQcgWzjTgWhq0qXxY=
X-Gm-Gg: ASbGnct70sVu4eY0ii1hR8JWtnjppQ5zn6ugOCRqCW8HfMESDwjkWleK+LBVHhL4iUi
 s9qRxrw3KIyg93mVlj30EYSIE3BRXALHHgP3ZitThmZo06soyDAEw1ZPejFc7yHMdhFGblZ94LJ
 ojZYb4+82NzPTd7y5eu3GBMxS1ymPYNvl0Ay1UNSSsnnWrtseaFsyfvzt8ZbahZVz3BMVdQFNF1
 DJIjutRHHH2+e6NJwDWH1fPeIP0KqmcNZtUbQ1uHE7SL4Tp7+0rxGC4vu+HtKScIhEgqGXu1wlS
 SMNXtoGtdpUs+6CZE+ujkiNFvFD8Sk6nZB7QU/slA4D1c/DNRaCdLUaTPT9KPOJl2faDh605mqo
 1gJXrb/RrgLAqFgGWX/14Xg==
X-Google-Smtp-Source: AGHT+IHsLOFyga7Vzz6H3k4NE6/vzMQQVkz1SXeR6mDfOlapvbSmdME3qKoOJkPsbYjiW03Xeoylyw==
X-Received: by 2002:a17:902:e54a:b0:21f:6ce8:29df with SMTP id
 d9443c01a7336-225c1c84d80mr1373075ad.3.1741793774361; 
 Wed, 12 Mar 2025 08:36:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2257d5d4d1dsm55078935ad.231.2025.03.12.08.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 08:36:14 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:36:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, Wei Hu
 <weh@microsoft.com>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
 monitoring enabled
Message-ID: <20250312083611.5d34cd99@hermes.local>
In-Reply-To: <SA6PR21MB4231702177B6AACAF54FF40DCED02@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741642977-14297-1-git-send-email-longli@linuxonhyperv.com>
 <20250310162038.5c05ce8b@hermes.local>
 <SA6PR21MB4231702177B6AACAF54FF40DCED02@SA6PR21MB4231.namprd21.prod.outlook.com>
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

On Wed, 12 Mar 2025 00:33:52 +0000
Long Li <longli@microsoft.com> wrote:

> > Subject: [EXTERNAL] Re: [patch v2 0/6] Support VMBUS channels without
> > monitoring enabled
> > 
> > On Mon, 10 Mar 2025 14:42:51 -0700
> > longli@linuxonhyperv.com wrote:
> >   
> > > From: Long Li <longli@microsoft.com>
> > >
> > > Hyperv may expose VMBUS channels without monitoring enabled. In this
> > > case, it programs almost all the data traffic to VF.
> > >
> > > This patchset enabled vmbus/netvsc to use channels without monitoring
> > > enabled.  
> > 
> > 
> > CI still reports a build issue  
> 
> There are ABI changes to rte_vmbus_* calls. This patch added rte_vmbus_device* as the 1st parameter to those calls.
> 
> This will be a breaking change, and it only affects hn_netvsc as it's the only PMD using the vmbus.
> 
> Reading ./doc/guides/contributing/abi_policy.rst, I think the best option is to use RTE_NEXT_ABI. But I can't find its definition in the code base.
> 
> Please advise on how to proceed with making those breaking ABI changes.
> 
> Thanks,
> Long

Can't take it as is, here are some options:

1. Version the API even though should only be used internally. Use API versioning
   as transistion until 25.11.
2. Wait for 25.11 and just fix it now, and do deprecation notice now.

3. Mark the API's as internal (in 25.11) and do deprecation notice now.

4. Make new functions with different names, and mark old ones as deprecated, then remove in 25.11

