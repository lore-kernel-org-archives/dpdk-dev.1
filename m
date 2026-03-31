Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DEDFF60F4
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 18:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A888240613;
	Tue, 31 Mar 2026 20:07:17 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id C1907402B6
 for <dev@dpdk.org>; Tue, 31 Mar 2026 20:07:16 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35da9c0c007so2163255a91.2
 for <dev@dpdk.org>; Tue, 31 Mar 2026 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774980436;
 x=1775585236; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOvF1Dw0z4Rq775AgqFhWCA7Ubr2CIa9ImvRVb+cQZ8=;
 b=Xy8MtK8T6JW/Aie1J8xCsvE94ZsA6qbUxCGylCicoYAFsYzHbUB0fD9cAT8NiBn3QQ
 0hu0qDdkotzBmZN66QilCspQW6V5GvqPviAQ9NVVbf3GpBYfKl/JRfjLlDSbz9bBKvbh
 TqWhwSOnKm35U2PlsnGA+e/d1t4KM/5UhBvcquR5rW+VVDSshUnB/tD4K0GrE5GTkKAz
 3wppOa9WUBWoomFUh8+LOJw2pD/gc1l8bV+geYn0ZwKx9uSsQQPa81iLCwZHss1d2YBt
 0uRYAcrGyRmGqoX5cpNn0yUBEFaJM4SAKExOzhma5p21hr/OuRmZRcwsjLVhBbN6DpkF
 6yQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980436; x=1775585236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yOvF1Dw0z4Rq775AgqFhWCA7Ubr2CIa9ImvRVb+cQZ8=;
 b=ikk7LOAXqmUJdtU7a6zho+hJfIrSqhUcs9KC+tIyJB9cpYNr/fA/KGWb6JEuj55XJE
 eC4pVwb2DybJSRU8D4h6s1KSYkTNKPqDrLa9J7VRXmyQgZNm4GIhQkNcILSuQH8HqYKM
 CuB0mvxPUg/UHr9Llwpq2aQ2nuW3MNMFR3kFaIIbrE3lKGRJuCcGSmGwhtaAvom9phYx
 M3GbPAjByZ7MaH7+hymRRRLlfdtpRhWyyHo7k/YIRQwP/7tvX/BqbSYj9Fy9PH0M86SE
 en2fABzsnaspt50De9OjwgJZXRspVYHteDTAwm/2sGONeDst+i9xpnn8AhIBEJVjPRi/
 5MNg==
X-Gm-Message-State: AOJu0YzU06eQv2dUpqLcaIT8GlJY0pUmIYrCcI86tCRQg3DZYTHB3K+K
 x/CCwJEVyrpqOAHnhhV+pNSkgLHV59c0uZrqBdZpD9Q8jtPlS0C3+HiQ7JFWOUHhJgA=
X-Gm-Gg: ATEYQzxPKLcDJ2TGq6UUWl0OHxZAajoy5sEPWBuLB5S5SqErFBaZNMe6JeL9+0orv06
 +G12IWbbEYLEQB+YXmEt1KqiyROySwIhJ/qVzUX/DEl++G3xgLDECMovLNHTFvv2w6/tZiLfuOJ
 OCWFLWH1xp2HIPiyde7StDIwxh87mLbPuW5rVyB/5T93P7Ix4rMIn1MJBvl+jFXg6xwAB0UQW6M
 sVirHHHTu9Q/5UUbRH/zHJUb/1KgMjdizU70XQP46NC1tMR+8n7XKPxhtZXkE3cnneHVPbrD4Bo
 MbN732glM0BwkyRJqfP3gl3Ly7yf0PLjffb2oKX8buAsF7tSwR8qYMhbkzXsVgJtSr26S6lnsCD
 Y6IvYPoh0MydXcUXruHPepYPtPVgUVPkk5hn+0zqKQ/q75YWF5ugxm19JJBkkD8sxn5lESUHYJ7
 /SktyutifLB/bpLwcWjf7kfGWan96P4Gqf+HM=
X-Received: by 2002:a17:902:d2c9:b0:2b2:490c:411c with SMTP id
 d9443c01a7336-2b269c6f140mr1702195ad.21.1774980435709; 
 Tue, 31 Mar 2026 11:07:15 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24265aa9fsm115186985ad.20.2026.03.31.11.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 11:07:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:07:06 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, "luca.boccassi@gmail.com"
 <luca.boccassi@gmail.com>, Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH v3 4/5] pcapng: handle packets copied before file open
Message-ID: <20260331110706.0564ff8c@phoenix.local>
In-Reply-To: <28deabb2-361e-4379-9db2-42e94eb352c8@redhat.com>
References: <20260220184255.306368-1-stephen@networkplumber.org>
 <20260228175601.585102-1-stephen@networkplumber.org>
 <20260228175601.585102-5-stephen@networkplumber.org>
 <28deabb2-361e-4379-9db2-42e94eb352c8@redhat.com>
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

On Thu, 19 Mar 2026 10:34:18 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> On 2/28/26 5:35 PM, Stephen Hemminger wrote:
> > Either through misuse of the API, or races it might happen
> > that rte_pcapng_copy() is called before rte_pcapng_fdopen().
> > 
> > Simplest solution to handle this is to modify the logic for
> > TSC to nanosecond epoch conversion to handle the case where
> > the difference is negative.
> > 
> > Bugzilla ID: 1291
> > Fixes: 166591931b72 ("pcapng: modify timestamp calculation")
> > Cc: stable@dpdk.org
> >   


This is a corner case and doesn't need backport
