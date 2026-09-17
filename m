Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A158C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:19:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37A5842FA3;
	Thu, 17 Sep 2026 18:19:40 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0399242F99
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:19:39 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-398b3b189e0so905719a91.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661978;
 x=1790266778; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4LfwGd3F3+zVcvQgTx+V+MlxL/Uej571wJEZEOLW870=;
 b=SMmb+QyNVirjOjXYkj3fCZxxRAURgbBVG+41Mjeb2NnukAdgzKaaS0A6cjmUjX7Ebf
 GEuTejlTMHyhipO54qwnHXNctJmHcBRgHEXO3ylbzTvLx8p96E1MbvUpXjBSr5IZT97x
 NrqinrgLdcQ5DEqpLO72XUfDwvlCiT8k6knRD2yupZxof90PUq7JvVfS+OscrCtFPI3T
 AdvfOoznLYT4rxv9nDLiahqExovJ7X6Tnl05LJT5rXzXtDob9CI/JIBg1TnY4wJIcY1M
 tI46bBzy+UYH3yGEpCpg70TLZJx1NIYy/EKLWYgqqo1N2a7uY+ryvhfwvZ/VGYzp5ifX
 hxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661978; x=1790266778;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4LfwGd3F3+zVcvQgTx+V+MlxL/Uej571wJEZEOLW870=;
 b=PFz8vXtGkPwDgfs0pceFMs+vpikaC/FNicqQVMZgNz4qqN3cqrz5QyUL+sMmgglTAP
 R1Ht/XBEawfzyJ9HcpQEA9irCiTJCX3ot1Jh+ahBTXacwP4VFgNaJSUbUwIdGBDkvxf3
 AWuHpufx2QOZ24uavaXugASmKb/9PGKK0YqQQOhq+57VUBio15V4QZbNHCcESmK1xpIZ
 aIFfXXYwSHaajJ6KANLeDom1Bwds/3eIpZ4Vd0/pYEbooEvHhfLxjyjQCgV68OjdV5qW
 2N2Ib8PFlqVUUxMOovhmUcr25vxWnl+YFJVMiumIFBkSYGTLpRgTTlQkHl+5JD7paGjW
 +Y9Q==
X-Gm-Message-State: AFuF++k1mUGCveKeW14zwZdOoYbrkW28kT5UtPWRirHV45Ofr0jj2I1I
 1+FUIMC/2jDvcGoNbmUPFILS+QXP0CPu21hoAYN+j6PQZk8omac+rLzZtcBEcv4pKYQ=
X-Gm-Gg: AYBFou0h0+OtWnL7KNfCLEufQHj9dvIGDLyq03jjwRUgZWNdyOzRX78Oy86UGqJ3nxb
 27Qn6HdossGiAwal7uQSniJFhOfSaDb/Uo2lfL77c9TwH+JBMqejUhtx1VAz3gxAMkzhsgIKdA6
 20fdZm0LrHWj+a5+ZodnYj6oQhMOdFsT/QI/tvDNYg2e3SUoriLt6M9gOVNpku/2fbT/6mG66rP
 XezPAsObW6tA1Ms/g6jn/7hM/j97N7lOALKhU/fqXGSI0nV+DwoRhX7l+25PWZ3QmHCt7R07K83
 g+2HRXXs7g6RIyd1IPLASHQ1LUJyha3Wc/JuMczpzUUpSleIBSqnMVmfxH/6asOqwQVoy+RPZ/R
 TKjY1nzbGDbrXS2xpWGx5m7w1OXZDxZbpSCYhmlfLAPAi/02aA8f7tCOd12ichrMT+UmqJSO9We
 M6oclR0KadkgHi0D6JCjsOXvCa3pubB7SOVBK7S4FUiceQcshNDHWyulK7F/L+RHjbg+D9sHtke
 fSbuU0kddDfrNriLVNwWU5JGnI1FHvM0Sm7m61I
X-Received: by 2002:a17:90b:5550:b0:39e:4c7f:8b19 with SMTP id
 98e67ed59e1d1-39e4c7f920fmr1637887a91.30.1789661978021; 
 Thu, 17 Sep 2026 09:19:38 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:19:37 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:14:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>
Subject: Re: [PATCH 02/14] common/cnxk: disable CPT drop error in CQ
Message-ID: <20260917091408.4a2f03b9@phoenix.local>
In-Reply-To: <20260917071016.2366467-2-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-2-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:04 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> Disable CPT drop error in CQ context for cn20k platform.
> 
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
> ---

More detailed AI review.

Patch 2/14 common/cnxk: disable CPT drop error in CQ
----------------------------------------------------
Warning: the line above still does
  cq_ctx->cq_err_int_ena |= BIT(NIX_CQERRINT_CPT_DROP);
while cpt_drop_err_en is now 0. Either drop the interrupt enable too,
or explain why it stays. The commit log gives no reason for the
change and has no Fixes: tag if this corrects prior behaviour.
