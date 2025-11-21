Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967DCFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94803402EE;
	Fri, 21 Nov 2025 18:12:05 +0100 (CET)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 391B840267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:12:03 +0100 (CET)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-bc8ceb76c04so1509906a12.1
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763745122;
 x=1764349922; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NydMEeRVBSTrU7RWQJWsBxYyJGcrnVfi0Ih3fQnSkc=;
 b=P+McosGhfi3h2mgWBI0E24alxovmEDYJE7y8XqIRHrM1pUjQxahFB/UM23biv8EmPU
 xMkiYJgRtfVdqRx+VVJ2xHixL+2DHGh/CvSiVXJn/WsqVbFWlG1Mg59WXVlJa8+5MgOo
 zSnkLi6nNRkCsrxAYerRYYvX+QzTuF0nIW/gSoXlSrs4OkThC7gfX9iJffm8f3phbbxs
 GKQlqedQXxe1S3xxOHO6PenZdzJ3o0TokkSHKa7vewMk3ML8SYHYUMjiGtv2gHdnQkis
 1/lEKgaQZhW7tu+X/sL/EVHQDdMz+e9//A253p9EQOHKFOXBqYdrhqn6PgbGtN2IXyd1
 3Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763745122; x=1764349922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6NydMEeRVBSTrU7RWQJWsBxYyJGcrnVfi0Ih3fQnSkc=;
 b=kO5CQeuGV68Q3l81Asbp6HcuFRSKs8htOZf4SoNVcU2sgYXxVwu6qti/U9A6LnTOSR
 IWa8c1+m6Di+pwDD/v4Yx3/uZR2ud6wRuEBX8CR/Bjx790KwaMnjmdCkxT5C8h/7STvl
 oCXR5TlF+2l7mFjPlLSN3G6l7uDo1/mhUbmW2LFQSoKgolbF/HIjMeSNGuyk+t86yCSV
 uRXjVm13ojBFGS8B+zHPeBophYYqR4/yJb5m/3bLeaPuiatQVkA2gV4htTC75gpaDgg9
 j6HrrLNaPGC//SgXbPaTDqQ3gZlR2k3r540Ne68A1OuYK4ZJnsfq8qTF7xf70blCxuCa
 WN7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs/vQZWQ/pswGDsIZ1IrEiqhKMP3isoskd5cvBKf6a+I1gFTo7xpwlZd2jFduySm5eUnU=@dpdk.org
X-Gm-Message-State: AOJu0YyOz0UAEJY/kIH7nmEJChoHdh7c4SaN7EwgLqsN1x6uvxxfr3q0
 CBhoMOKj8Gba12krVjAaVN4dj1G7iDk2sQ39XLOCjCLxbZeKEbFYzjkaT0yYsC+mv18=
X-Gm-Gg: ASbGncu4HLUodTxkU+ddsENLiB6uhYhFv1Liv/OvzSMlGNC4FWP4j5CeD/6aCMuZtO8
 tsntUXx2Dljkyp3to1bXqTFShJ8k+Tai3N81LV1zAwic7kmf9fZlLwql0Ff0/phr83OhK3QY6vQ
 G63VjRJ0sDviGsOfkpf3ZrORlPEqjR8S3kv5BpGMyxobNEFTg0kiDOwkBnc+W/nvO/B2kjlu0Z0
 ap1zRSt4Mn6bNo/2nyrgr/A0O+7pMJUDNjEHkekqUCHVKSSGsIwfhnd9qnUAZzJvKQ7BDyiuI1g
 mfC9mAv3QnLX2P8z+KT5KCCdtr1I6UGZTCL6WrcKVRs6IC5GBb+mEHinMff1P5Abf3ipYYyvpH5
 7NkaSlDG5BlOMArccffqD7EV/7FalyVQVwPDSmTqcYChLztdDcwymqvwAQkEqrzNb7VXtVYKjPx
 lQrtmwQ9JQJuhtgCCjH6ak6jb856NJ2jbSUN9l8XLKoytLbLiwwktZ
X-Google-Smtp-Source: AGHT+IGWWeqtPjTdcQEzl9bM4GtE3pFN5rWz/DbK8hdZyO9qxhMAQhx+h+EYQZxZzCqG2d7O8WFWdw==
X-Received: by 2002:a05:7301:fc0e:b0:2a4:7599:29fb with SMTP id
 5a478bee46e88-2a719c2944dmr889103eec.36.1763745122177; 
 Fri, 21 Nov 2025 09:12:02 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc3d0bb6sm31280612eec.2.2025.11.21.09.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:12:01 -0800 (PST)
Date: Fri, 21 Nov 2025 09:11:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>,
 <dev@dpdk.org>, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>, "Vipin
 Varghese" <vipin.varghese@amd.com>
Subject: Re: [PATCH v2] eal/x86: optimize memcpy of small sizes
Message-ID: <20251121091159.4783d97b@phoenix.local>
In-Reply-To: <aSCbGWNQ7dr7EE7A@bricha3-mobl1.ger.corp.intel.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251121103535.1273457-1-mb@smartsharesystems.com>
 <20251121085730.51f0466a@phoenix.local>
 <aSCbGWNQ7dr7EE7A@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 21 Nov 2025 17:02:17 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> > As I have said before would rather that DPDK move away from having its
> > own specialized memcpy.  How is this compared to stock inline gcc?
> > The main motivation is that the glibc/gcc team does more testing across
> > multiple architectures and has a community with more expertise on CPU
> > special cases.  
> 
> I would tend to agree. Even if we get rte_memcpy a few cycles faster, I
> suspect many apps wouldn't notice the difference. However, I understand
> that the virtio/vhost libraries gain from using rte_memcpy over standard
> memcpy - or at least used to. Perhaps we can consider deprecating
> rte_memcpy and just putting a vhost-specific memcpy in that library?

It would be good to figure out why vhost is better with rte_memcpy,
maybe there is some alignment assumption that is in one and not the other?
