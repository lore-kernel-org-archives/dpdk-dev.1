Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDAC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 21:57:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7208A406BC;
	Fri,  1 Aug 2025 23:57:51 +0200 (CEST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mails.dpdk.org (Postfix) with ESMTP id 75E6A40A4B
 for <dev@dpdk.org>; Fri,  1 Aug 2025 23:57:50 +0200 (CEST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-71b6703ba32so17290897b3.3
 for <dev@dpdk.org>; Fri, 01 Aug 2025 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754085470;
 x=1754690270; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCP1NzDBOMQBThf4wSdkODcvAlttppPk0LEl909lP3c=;
 b=xRn2VA9BzypnGx4NJt4IzH6ck0jAKi58e/iy9tG93OJfzsuoQ+Z5GWdYXapn2lo0B7
 FY6NDLkB2S3bsJZ+d5EdgO5xXGvbAxGivw/oRNj/WJOUJdCLFQnJBXfnMkxltdbLoCD8
 Lthj4l02ksNFzA/I1askCyieXqOgDRBpwNeP5DXpQdbzPrxtYrTPA5iMiLJqGUU4SwWO
 TGOjBwsWuWrXpnoZv7KrDitfUwcTyTUibjlf/ao/Wyt3oARFGHM16zIZhGagaEvb4MiH
 klRu42D/7Ad8MxPly1jZPIZxbYIuqxPic44fN//BvghqHqEzGE+s08w7KkRPDae1TSXW
 FsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754085470; x=1754690270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCP1NzDBOMQBThf4wSdkODcvAlttppPk0LEl909lP3c=;
 b=GPNgR58sUp2ZJnzjA4zaa4aG9FUTgPAleQf2l8Nh2VusmaFdLVXkbZbNvas7yT23HQ
 75hg9yGd/eV0qiysVrp8v/LXjC41NvitvCCLGRJgIUx84CFDGU5NoLIhr1l+ZEBNNEqI
 Syc3e+gSEyvlmh3PHwRDv+lwddtF9/aE5BFwnWkPBArC/OfncESKblEWQb0crea5y7fi
 I4PZdm3yFAPsKFZIuOWCbUBF9S/016RDLDY8fgfVxEtRe9d4zdqlXJVnYqC3XSJQywuC
 SJdZ75soFuWxrxjihAF0INlCQ3/d/w6D392JNDRO4JZD7I7ld6O9sJIU2frvoqSt4tyf
 a4gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW81EeOxKGs25fCrE6VFiDKv2gm3WvYQziHoVhA6NwZT41Yop6r2BVEA2023NA8WtgW5D8=@dpdk.org
X-Gm-Message-State: AOJu0YzBeLIQFMWHPtoWHvyl4GeWeO9ySMT5RUvmGX7z2bhrIEQoXa8i
 t6APozEAiRJKx3uBbJ+lShcww/ohvp7K6f/wPsFTzmdvwY+H3l4ShVIk9cQc9SozjkY=
X-Gm-Gg: ASbGncsbmXmFxBLQ6KHCzCwz8M7fYV3IqWONiyJyrDCFgPXh2jLDWIVMPocTZ6a3JG/
 1H1KsRWhBXZWcOmdXzYBcoiq6N3BbtJwtILUhpEfqhbV0AISMgQ4YLQCKIdicuPfFgp2khxQgAc
 Uw3wPIMM8ipmJFtE0ZzspB9s9ajF+gVYLUjG8U6AxEBBOhF/ApZqwUNPQcnKSICZUNvCbqTHRlW
 3IqPsJiA+cMTZtglz98hKUSL10RY5kDP3iVTsjQE8kVIpfoS3EfqPcgerBBxczkX3TIXKiDz8I8
 MeKtytbA1/JcLO1Cwvc361GTxG6vtAf8BsUybMxV1VngIydYVYKzpPOcCuP3TQNlAhtbuN8kyAd
 yF/7uoGKlRMjn0LOejNPsq0rd63RXYJwQgQvCx2HYdida8/u5Lle4nN1JNPLXSqKD0soxN2dI88
 I=
X-Google-Smtp-Source: AGHT+IFTyYa0O2gMY/7Z9nsBHqJmm1pW5J5svXlv7UNKIJQtjdN2kfTC05H3PbyFTZ7ptq85Z74njg==
X-Received: by 2002:a05:690c:f15:b0:71b:69fd:2571 with SMTP id
 00721157ae682-71b7f5bc079mr19454767b3.32.1754085469774; 
 Fri, 01 Aug 2025 14:57:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a5f71e4sm12999057b3.81.2025.08.01.14.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 14:57:49 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:49:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tomasz Duszynski <tduszynski@marvell.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>,
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: Re: [PATCH v10 06/10] lib/pmu: do not try enabling perf counter
 access on arm64
Message-ID: <20250801144926.07a4d97d@hermes.local>
In-Reply-To: <20250801102109.3544901-7-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
 <20250801102109.3544901-7-tduszynski@marvell.com>
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

On Fri, 1 Aug 2025 12:21:05 +0200
Tomasz Duszynski <tduszynski@marvell.com> wrote:

> /proc/sys/kernel/perf_user_access attribute allow user process to access
> perf counters. Though in order to change it binary requires elevated
> capabilities or must be run as root. If that's not the case counter
> access remains disabled. Hence to avoid confusion log message that
> that warns user about that.
> 
> Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
> ---

What do Linux perf tools do in this case?
