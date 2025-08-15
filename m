Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05484CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:01:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F5F64026A;
	Fri, 15 Aug 2025 18:01:37 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 731D2400EF
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:01:35 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b004a31so13257645e9.0
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755273695;
 x=1755878495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEJVl9l0yFQ4VsEUyJazA0ET/+Rj8XGHRHdr8jry7AI=;
 b=vXeyrO7ofJmIbgg8wN9c9alPM0UwckbcPFdPRNQfNe2BxzyH7+261EuSucVxzzZ1Mv
 yjTjjKJeG4YtTbGGEvzXX0KDyH9rdlhGdf/1vBHGfFwPUsnKmcsv//auJoOYgJo+6vrI
 0alcZLF2JT1mcBv/iyOJDP295mDOtdIKtzsMEi3OtVZofdqaW6FWatNhj+DbXXwuvE5o
 /4qVUsbicMvGLwDxsd1VFg/qF2CwG4P4fITi7TifMbGnGbegOPFcKPIoRXW1P20DC8FW
 QFRf1Xucnr2tGIdidN7sqv6SzROjsPCpMT/ZsQyjpBg8/9LtMbsn8Tm9xhbz0mJlUJ/1
 AqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755273695; x=1755878495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEJVl9l0yFQ4VsEUyJazA0ET/+Rj8XGHRHdr8jry7AI=;
 b=kwHDRm6yIKj6+CTPzosqV6tqkeHxLj395B/b9cr5CIXAuNgTS0S2I1iMt0ydn7ssfW
 ypWwdoYguT/trFFhxY+0eHzbJvNc9bqrrRPGWVUNT4SfNNwNvNSDyRogZRsdU+gHfZI7
 aASQWQFbanRSl5iCU+BEOscn/iRSUAIAkIz7fx2gKiSjp5iR0LAvbYIEJmgsYw220TXA
 uEtjPBZTnWlwbfSSSOl9LE043zqakzYVJ/yvcolzjt+ZI08fiTY8vO9XimYtVQ/++h1x
 sQY7QSWpKSMoABih5kW2mkgxChQXW992p+gVTitu45MN6Qbtb7kJF9f2KHIkoAK/bK41
 VLlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl2rXlze3icebB5ABdTxO6gAOeADc//j44oqgQCU4QO4CsXIP1YMu3HDKnT4BsQK4gilo=@dpdk.org
X-Gm-Message-State: AOJu0YwnoLvkjQezWV9e93yxFYQyEPDOKkB8AUGhgWDme2N4LgrLpqlt
 GDxgkOTSikO3+US+FcDpvxB2Ewi7MG+U2jPtPmNLWEBH5Zvo6HcqPOfqOJ6WlGjtyhY=
X-Gm-Gg: ASbGncuPIfClaKeZ/5Y1uosmIJaKkwiaH9GWr9mQPnV/WatcakVC+iJbYs29YGWKdoY
 pAg2aM8G3bH/Td2ISXdUyhMTfueIGfjs7upnCFtkrju9VQsZvjr/HYEbfF8PRs4Zsnd6/uGyPUC
 Zdi3rIku0jjHAB90RVZSJXe4nW+a8681BmJlIFzMPov0TiuFbp9AHierw+osUub3uloeFqUAxFp
 Ahk5P2Q/GXjROzfPo32KnJNrUAVFk7vX7DGGZPqvoL1f3n426sHymAWWjj4kBhSwWQ05ZeJVPDH
 4oosIAnMrwM1V0ItOfM+Rp67lJXi+1A2f9B5cRv72GLwbELIW7wCOE68bs1+eP+xt/msutYqmCM
 vHxylq6ckp75dvY4fpQ2k4arr1HoyaEfp+3UtzBwtEAPlMOCwbYM7ANKFQzedQLSmYJvsQNyTiO
 Y=
X-Google-Smtp-Source: AGHT+IFSgAkWCAxrxrNBlyHQUUIeyKcw9WnQXNgvu4vd67x5tMAMZypbpKwc0vZbIyT73O4us2Wp+g==
X-Received: by 2002:a05:600c:2e95:b0:45a:236a:23ba with SMTP id
 5b1f17b1804b1-45a236a2561mr11508105e9.22.1755273694640; 
 Fri, 15 Aug 2025 09:01:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c74ad27sm67277555e9.18.2025.08.15.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:01:34 -0700 (PDT)
Date: Fri, 15 Aug 2025 09:01:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Bingbin Chen <chen.bingbin@zte.com.cn>, <ivan.malov@arknetworks.am>,
 <wang.junlong1@zte.com.cn>, <yang.yonggang@zte.com.cn>, <dev@dpdk.org>
Subject: Re: [PATCH v5 2/2] net/zxdh: add support flow director ops
Message-ID: <20250815090128.1eb86b40@hermes.local>
In-Reply-To: <8b5a9c85-0c12-4afd-997b-b190a426597d@huawei.com>
References: <20250808071048.1906724-1-wang.junlong1@zte.com.cn>
 <20250814025248.2194951-1-chen.bingbin@zte.com.cn>
 <20250814025248.2194951-3-chen.bingbin@zte.com.cn>
 <20250814095901.49018c75@hermes.local>
 <8b5a9c85-0c12-4afd-997b-b190a426597d@huawei.com>
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

On Fri, 15 Aug 2025 09:33:17 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> Hi Stephen,
> 
> On 8/15/2025 12:59 AM, Stephen Hemminger wrote:
> > On Thu, 14 Aug 2025 10:52:42 +0800
> > Bingbin Chen <chen.bingbin@zte.com.cn> wrote:
> >   
> >> +		} else {
> >> +			entry = calloc(1, sizeof(struct rte_flow));
> >> +			entry_flow = calloc(1, sizeof(struct zxdh_flow));
> >> +			TAILQ_FOREACH(entry, &hw->dh_flow_list, next) {
> >> +				entry_flow = (struct zxdh_flow *)entry->driver_flow;
> >> +				offlow_key_dump(&entry_flow->flowentry.fd_flow.key,
> >> +						&entry_flow->flowentry.fd_flow.key_mask, file);
> >> +				offlow_result_dump(&entry_flow->flowentry.fd_flow.result, file);
> >> +			}
> >> +			rte_free(entry_flow);
> >> +			rte_free(entry)  
> > 
> > Use the right free function!
> > 
> > ==== 20 line log output for Ubuntu 24.04 (dpdk_unit_test): ====
> > ../drivers/net/zxdh/zxdh_flow.c:641:36: note: returned from 'calloc'
> > 641 |                         key_mask = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
> > |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/net/zxdh/zxdh_flow.c:689:9: error: 'rte_free' called on pointer returned from a mismatched allocation function [-Werror=mismatched-dealloc]
> > 689 |         rte_free(key);
> > |         ^~~~~~~~~~~~~
> > ../drivers/net/zxdh/zxdh_flow.c:640:31: note: returned from 'calloc'
> > 640 |                         key = calloc(1, sizeof(struct fd_flow_key) * ZXDH_MAX_FLOW_NUM);
> > |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../drivers/net/zxdh/zxdh_flow.c:690:9: error: 'rte_free' called on pointer returned from a mismatched allocation function [-Werror=mismatched-dealloc]
> > 690 |         rte_free(fd_entry);
> > |         ^~~~~~~~~~~~~~~~~~
> > ../drivers/net/zxdh/zxdh_flow.c:639:36: note: returned from 'calloc'
> > 639 |                         fd_entry = calloc(1, sizeof(ZXDH_DTB_ACL_ENTRY_INFO_T) * ZXDH_MAX_FLOW_NUM);
> > |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors  
> 
> Just curiosity, which test catch this error? There are no driver rte_flow API test in meson test as I know.
> 
> Thanks
> 
> 

It is caught at compile time with any recent version of Gcc or Clang and glibc.
The function attributes used hint the compiler on what the object free routine is.
