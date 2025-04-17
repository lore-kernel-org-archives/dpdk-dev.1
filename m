Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4FFC369B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Apr 2025 15:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6000C400D6;
	Thu, 17 Apr 2025 17:07:39 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8287D400D5
 for <dev@dpdk.org>; Thu, 17 Apr 2025 17:07:37 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-af589091049so684794a12.1
 for <dev@dpdk.org>; Thu, 17 Apr 2025 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744902456;
 x=1745507256; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVrSkNghrm5rcyZeAbqk5Q2OAK+AEuC22uNV1jlMWi0=;
 b=PlgCW7GBliN0KgMHj//svCs9xicNBVu8WUr5XZjEz9SbKWJ9mqgAmG1trEUTUwgvb9
 wWSkX30tTakz9oKEVsVD8iMXEPz9DH8hAkLEDwdL4+b7vfcl+pQlTQjTHRvFv2NMd4VG
 hP38D03iYw1ge6K44Y7qux2IX/9iz8M7de7teNxeHtN0tiJzF0V6YP/yB577zs2ZE1aV
 lJLPRoQXU/FaMzBoXclTJ14FNW3H/h2ElXkIqfxKSFc91oQ+CV3pvq9Ie96tlyyi0RVt
 EaRRZt7UE8PemKgpyRcGJiNEt3QBEa15fQcUveVFyQs75z8ADZZa4XXvHDwbxazdvWvB
 jE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744902456; x=1745507256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kVrSkNghrm5rcyZeAbqk5Q2OAK+AEuC22uNV1jlMWi0=;
 b=cMwZyVWNsDwHeNTTDRn8KtPYPXjS6qgVJxHD/5VUrRlTmlEBTctBM2F+ED73jkqFLK
 B42Y1aEvZgME1mG6qYlQ1r/lEa4VoG15SYwFJ9r6jud/yyW0HiiUCy074YRlzgl9uS+2
 EXXL6fv8ehf0MIK6hfFKi2QBwqTJZ2KmWmvMlP8Kkc7TFo4wyWhTvhT727OnbeACBs4D
 AnAzL0nekV4mxYVnyQMeRwJLyKwxt+2XiZ2Tq182XZpINyWe2xgto+B0G4gFneXbY/5k
 NQQ4RtbxIK9qK9ir9iMzJ5RXkFS2qi1FoeeIjhaNsgYRkbbGNbP1rF6OPxNzciHEOYQI
 UPSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzEHlxLsHqyrRJqmxEXLdBqCntH7BQFiRT9Do7HqLNcKProlvDWwkuhyBIw+64AZbvANM=@dpdk.org
X-Gm-Message-State: AOJu0YxNVsZX979xDtLJuxdlR9LWNCDosy46sRGIASoaalzZ1pgJBZU1
 KmjlwwxDO0GFN5pZOmds3d49pmknzdUXJStsoJ7IvRIEubdd5XpvNqDJtHvffU4=
X-Gm-Gg: ASbGncudOCrG0FiZB0Ri2LnjqTq/fWobkZW/jbWOiA/CMwFgMcAxmhKV9nKd6jibwPd
 QTaRWl0HAplxZjuyYutsrY8JwVTdloRtk9/dMd4957y8CGl37LN/76GJizVCpM1u/u7AUr/Yzfu
 Ql2oJA2oCBnk9rkARPPJVdMluvVbnATrY0SuczjwhWxIqP4UrrTwODLMZI2lXvR+gpSt44iIsFe
 ZG7+p+TJsqQ/g0qwAVtmYeHCfzapN6AYFqikszFyk6LfrvN/W1LvFR1ya+ik1rDZ3/yLhWfNRXB
 c7iheKEH00xtLs+7QGKpa2vvSDpz+s5TsJzlk7aq3ohfKDQ8U1A60vwBHnla8UrmXlYk/L2pFbN
 kCaUMxO3zLe69QGNM
X-Google-Smtp-Source: AGHT+IGAMQ2UA+ecJAtQj9HJ72iy4sWS4z+V0nRS6kUzXNtt8uGDW29wlA1SLcfLryYrufXAboPRmQ==
X-Received: by 2002:a17:90b:4ecf:b0:2ff:6788:cc67 with SMTP id
 98e67ed59e1d1-30864172844mr7223484a91.34.1744902456486; 
 Thu, 17 Apr 2025 08:07:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30879fa470dsm15540a91.47.2025.04.17.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 08:07:36 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:07:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org, Denis
 Pryazhennikov <denis.pryazhennikov@arknetworks.am>, Andy Moreton
 <andy.moreton@amd.com>, Pieter Jansen Van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>
Subject: Re: [PATCH 02/46] common/sfc_efx/base: add efsys option for Medford4
Message-ID: <20250417080734.4d5441eb@hermes.local>
In-Reply-To: <0c7ada9e-26ea-4dae-a1ce-39a3be6127c8@oktetlabs.ru>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250416140016.36127-3-ivan.malov@arknetworks.am>
 <0c7ada9e-26ea-4dae-a1ce-39a3be6127c8@oktetlabs.ru>
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

On Thu, 17 Apr 2025 10:08:20 +0300
Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru> wrote:

> >   #if EFSYS_OPT_ALLOW_UNCONFIGURED_NIC
> >   /* Support adapters with missing static config (for factory use only) */
> > -# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2)
> > -#  error "ALLOW_UNCONFIGURED_NIC requires RIVERHEAD or MEDFORD or MEDFORD2"
> > +# if !(EFSYS_OPT_RIVERHEAD || EFSYS_OPT_MEDFORD || EFSYS_OPT_MEDFORD2 || \
> > +	EFSYS_OPT_MEDFORD4)
> > +#  error "ALLOW_UNCONFIGURED_NIC requires RIVERHEAD or MEDFORD or MEDFORD2 " \
> > +	"or MEDFORD4"  
> 
> Typically it is a bad idea to split error message since it complicates grep.
> Please, double-check that base driver code style requires.
> As far as I remember - no.

Would a static_assert() logic be less complex here?
