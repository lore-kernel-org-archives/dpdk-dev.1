Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ABAD3B7E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 19:14:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D2344060F;
	Mon,  8 Dec 2025 20:14:35 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 76E0D40395
 for <dev@dpdk.org>; Mon,  8 Dec 2025 20:14:33 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so29108945e9.2
 for <dev@dpdk.org>; Mon, 08 Dec 2025 11:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765221273;
 x=1765826073; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl4i5JAJFaisqFtpvh81U5TM8aaE61gQO3k4NmdjbqU=;
 b=0ET/FUHM5TERQXNSW05oXLnVkkUoLqt6qKABiVns5QQ0oDm3Edck3wxcdClE0BHXuo
 qCLXxp5wKsOkdC45l6y1ZMZTlnUCZDclSQkZa48zrlpXEMEcCpJjGlGJ8zSZrf620A69
 KAWH3DddxSlxDU65Zkp81WH41e5BVV70SDVGVdYFWWPP+te7hwUtx5SLahvhh53nqhEO
 U0Uw7uI/AFIvQ5nBR5PWhwzXxlFg7JiQq3Ffd6DcSUVpF13+o2ivPxREpkvVXNB3UwS/
 3UZHoXWiQlohJLNzjs867vQ/rQz0igE8Xzim0KVgGMLVRtvbUR9KHU0yghJhJJ9d5zss
 d8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765221273; x=1765826073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gl4i5JAJFaisqFtpvh81U5TM8aaE61gQO3k4NmdjbqU=;
 b=edAKve1EbY+majnRs+SqlVir9x6JtJUjJrz73iFf95Cp1LexmhxuyorDXsfYIxOQ2l
 JZRf5fpCGCTyBtMALhMzE1umoBgLBKjCj7NFp20eZTY1nr64OTxlTMFCl9N8C5NaUn27
 d4SkpJnkRd2Egt4bZnsXSKIPJln5eZjbsFlnpopAz6SIxF2BloOv1N42NbYkWA/No+qI
 UNMiUhqWTrIDjSM4sRu2pGjuzzPehX/hwT6uOk3Qec6YZUC86+3qzshdVQwqszPsF10v
 wdvGnJWjd+Q+1f7nqhP1fz47KYFVwbDUqCDrgZRfGk7EiD8kumX3kpHYxcWW4VOKuUh8
 AEZg==
X-Gm-Message-State: AOJu0YyBquirIrBIUsdSmVwoB3uG6Px65oHtP0XoHIfAWsJXYXBaEVNv
 2mID0PZyZp6kYzt+AAkEexmcnZyKeHwzT2YayWq3ZPkId0PaC0HcCxL34O1kPmkg0Pw=
X-Gm-Gg: ASbGncub5M5AeYqFQSvqcKGIubAU259O8x1nJEDdqtwVpRTgJqJuM9Gmprgm3InYnFM
 ifKiwM6Mt+e5M0cWcYrnCWSoo5Jaw6ctxhFrWTU6Cu6NpPKNKWKI0Wc112z6OLmBHrYNHIt2jjM
 fFl2PvJYCLLTQbCRkmnzGE48MlHedBWd7HQe95ZtbbM8mMBc4z2LVfYv6yF25Sv8GGtEC5JrW7/
 cTIhYpsRGW5HsH8dqk7eA5MIcOqZevZ+IjyPdxEa7QTYI6DdorUVRiEEZeErag0FW83WElzONYm
 Ur7AJrBFRZXZrqGFlM6qGafnzOhW7bZIJ84Ifn1jkvKhsqJZPhbDLAh5Um+qB6/q9dR5JEOMSQg
 uY7lfr76IpvCh/lUTu4syUzE530TS9EdpxhZScgQ0xW6GgzEwIU52yD6MzuvI8XN3bl59reTsXY
 ToX++1I4nb2S2zJtw/U/Z8j8ISoGfF0iTJLULLKtbkbWZDYG11WGZW
X-Google-Smtp-Source: AGHT+IGDmBsfwiuuJa9odX4UoYR3j298RY4LOR8mVFZkH41EfmR6az8r8G9yo9YakM4Bb8PnfwxmUA==
X-Received: by 2002:a05:600c:820e:b0:477:55ce:f3c2 with SMTP id
 5b1f17b1804b1-47939e0408bmr102656585e9.14.1765221273106; 
 Mon, 08 Dec 2025 11:14:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6228basm994245e9.4.2025.12.08.11.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 11:14:32 -0800 (PST)
Date: Mon, 8 Dec 2025 11:14:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Anatoly Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v3 10/16] eal: limit maximum runtime directory and
 socket paths
Message-ID: <20251208111427.34faf80c@phoenix.local>
In-Reply-To: <aTaTLpg2PL2khlVO@bricha3-mobl1.ger.corp.intel.com>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
 <20251205201537.251131-11-stephen@networkplumber.org>
 <aTaTLpg2PL2khlVO@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 8 Dec 2025 08:58:22 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Fri, Dec 05, 2025 at 12:11:39PM -0800, Stephen Hemminger wrote:
> > Linux (and FreeBSD) has a limitation of 108 characters for  
> 
> 108 characters -> "just over 100 characters"
> 
> make it generic to cover both linux and bsd
> 
> > any unix domain socket path. Therefore DPDK would not work
> > if a really large runtime directory was used.
> > 
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 

Since Windows defines UNIX_PATH_MAX in afunix.h probably
best to just compute the size based on sun_path which is what
follow up patch does.
