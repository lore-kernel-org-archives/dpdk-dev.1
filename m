Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F1FC021B0
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 18:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E14F14028B;
	Wed, 19 Feb 2025 19:35:59 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id DD7504014F
 for <dev@dpdk.org>; Wed, 19 Feb 2025 19:35:58 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22104c4de96so436065ad.3
 for <dev@dpdk.org>; Wed, 19 Feb 2025 10:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739990158;
 x=1740594958; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0jEQHKmEitV8bIi2ubqKxqu1DK3qJrAjokII2PgoiA=;
 b=HhxCl98tBoCY86vZOx4pqxLRcwOza5HVq7EPQ2ZIzFQrIi9lr4/0HiofWM4R+IrnDw
 dAC1EtvrxRrlklhP5CMsnIs6mqdGRjzUoSgLbX66goNUfTTm6E2e9SsthZzz8eSfhQCQ
 f8trwFilGadIxXn1hoxfLBE4XKNWskQ2UbbBYpHVY5suDF4sBdB5e3R875UC7HCOml09
 qjNQoIXioNzCZiYZI5sXRgLlSui4OoRYGoEgxexPrE7gFQ1mb7KnjfE3CBsd4gZMVjGV
 Loen6PXq2wUPwzuusbXYGTG17LJdnivQwkUL1mdX1l82hmiYaVTfApIPy/yVGJ+Af8ro
 zhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739990158; x=1740594958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0jEQHKmEitV8bIi2ubqKxqu1DK3qJrAjokII2PgoiA=;
 b=UmkL3KvaLrpD2suQ0hTs9wY8VJ0NOeoUJDGXFIRzUjysBAY+mCSDyq9GfB1oCUmOze
 ytfAdPnczpZEoCtPZHUXnCCX/xyznse2B4bwtTrMm4KTj1YS1XqNQpaBiMq9BRz0tDZv
 zlPngt/Kv0Ff+AkIAM3j2217ePmhid+D+NNXFJkbEDAOA4pim3n/OWsuIGjBM/WSodDM
 D67hNu0OSVQlelz1PW+Goe1vXM/eURoENbWHnAM27fRCuLsyl9E6vWVy6XqLO7zRXiiQ
 vHxZBoG52v/A2ArtapCfhxS1p2Ddi/5XFLjXQs+RFSP7PwxBD7Tc+cOYgnlY24WhM0Jj
 oalg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVahnocFwfZ/M7hzMH5uZbvMoTwKkx5mk+JQvdkDY6+fdrqkjKSNB0Wy8A9p4Bm0jTTbgk=@dpdk.org
X-Gm-Message-State: AOJu0Yxj/iNt2bXTjFip5vNlsM8UFUxrup3UawSjiwjZ3Ukt/U3+Ah7L
 lqUv9Lvy9NB6zmHfBH7wHEpkf3viB65sZD3JoFeu1X1IgaKwvqrDFtXvtAT9l5w=
X-Gm-Gg: ASbGncuOlxqHBA5SKbGTVXAh2UK1PHavsz1Jg4+s+9Kk5zuIi9ROuh+1a+wkZFl5i0j
 njRYs6krJi6URLeq5/RaffDVTtVpygnQ7IoLNPxgEV3aJSjPK64/MYcOWsmkVgzZYX/SbOTv5aa
 9M7CKQ5u4QumTVWdpXJ/wQpdEv4NuBdOyf//X3eMB3pGLVcn8avp5vzFFrANDV2U9RqDhv35J3A
 6Q8vIWHT3M37jx2QT3LUHyMTh8ouBxCfwY1PFifmMWk/tmuwV8UYFeiuGl3wQkJ498UKGvqPnY2
 Rop0a6urATqUq6RS7zn8CnWm+BJj9IiXUgG8bYrgt9sKbkpaLX3O/xB5a3Lka6OXt9m3
X-Google-Smtp-Source: AGHT+IHGGUxmY2BH4xyp8oOzOByIktvzCiSAsVUWG+OvFrx/B4Jf5262E6TLFY5ES2Ru7wQ8AK7dMA==
X-Received: by 2002:a05:6a21:6d97:b0:1ee:be88:f5d3 with SMTP id
 adf61e73a8af0-1eebe88f840mr18999055637.41.1739990157933; 
 Wed, 19 Feb 2025 10:35:57 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73270398dc4sm7699990b3a.95.2025.02.19.10.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 10:35:57 -0800 (PST)
Date: Wed, 19 Feb 2025 10:35:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Wei Hu <weh@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, "dev@dpdk.org"
 <dev@dpdk.org>, "stable@dpdk.org" <stable@dpdk.org>, Long Li
 <longli@microsoft.com>
Subject: Re: [EXTERNAL] [Patch v2] net/mana: use mana_local_data for
 tracking usage data for primary process
Message-ID: <20250219103555.7e44aa91@hermes.local>
In-Reply-To: <OSQP153MB1307B222A37066A4D6746147BBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
References: <1739912366-6052-1-git-send-email-longli@linuxonhyperv.com>
 <OSQP153MB1307B222A37066A4D6746147BBC52@OSQP153MB1307.APCP153.PROD.OUTLOOK.COM>
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

On Wed, 19 Feb 2025 12:47:11 +0000
Wei Hu <weh@microsoft.com> wrote:

> > 
> > -/* Shared data between primary/secondary processes */  struct
> > mana_shared_data {
> > -	rte_spinlock_t lock;
> > -	int init_done;
> > -	unsigned int primary_cnt;
> > -	unsigned int secondary_cnt;
> > +	rte_atomic32_t secondary_cnt;
> >  };

The DPDK has converted to using the C11 atomic's so this should use
that (i.e RTE_ATOMIC() etc) instead of the older atomic primitives.
	
