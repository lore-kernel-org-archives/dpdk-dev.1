Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F8C88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:18:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E430240A7F;
	Mon, 14 Sep 2026 18:18:45 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id B32D740A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:18:44 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398c066106cso1868439a91.1
 for <dev@dpdk.org>; Mon, 14 Sep 2026 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789402724;
 x=1790007524; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rS38FKgIVr1cX9bo2mJ/2Q86A/DhY81UjazSdAgz+yI=;
 b=IqVU4PvgYxxu1khGjmRl1XfcLyfag5rpCQdcQo98P4Tnwf6u3BFOb4YxYuqkia6TJN
 CK986dynM5MPS+oUR4k4xPpya5zaPe/93m6HwcdDoHDXz+17iOISacfu0mTriblN+nu9
 OLnTZKaIhRo+mPelc6lTsQol1jj7hcBQaWlZktCII/jh/V6SvP+rDlwQgb2szA2hfpsk
 UmqKjIcMRjcCWvHLB5p2FjuN7NHsrD5f3vm4Tdv2WIim9/4q16Gj3mwV2cvyIC2rgfYU
 i8G/3pBf9T7Gc08FK3ILzVv/+HjXjwRjJtiAlWLTzWwPUG0AuenS8epfb8r9IIuBVSYm
 RKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402724; x=1790007524;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rS38FKgIVr1cX9bo2mJ/2Q86A/DhY81UjazSdAgz+yI=;
 b=XrTgrQzgVrF1AZjY7Fau91fdGviXy1BODeOanipD9i28D7M/S1x7s1hBWcls1qEr7A
 pZpKiQxq0TzhRQ350PbnW91Z10FsY1BE/AGXzcTD7U0xbeWFp76Fss+Maj9iBlyHcQvB
 tMHEYMqcA4PASLSu6P/cEGUsZD+sUrDY7RjbcFpJt+uzrwYQHAhq/vISJT2vqPsKIBDE
 ZFEukQTf151dQNaqwNIPey0cVHOmOm/8/cTFRzIeDZSydjk4YGRlW+DBbRzPiKu7Op2J
 O7f3Oq4teyfTYeHBy6QtYYmP8Yp5q7/Ehg+lhFLsRV2rU4lwv7RZEjaczr9HwxtzMw14
 LFug==
X-Gm-Message-State: AFuF++mbYnvOoFxuhN6F4nul0czJT9DQE798JKxKkyoFvGvszaedriEP
 icTkKx1X9Ouyh5UQCdBD4D91rkI/UkIPLw7GozmvfQycpLCH21j6WuzljcOZeIfBgicl0NmmCdD
 9404q3FM=
X-Gm-Gg: AYBFou2ST1dYKR/l2vkzA65aHxeJapC/6hqUGPxvxO5ij5cD7VGWET/U3fG3M2BlAUt
 HHRu4sXkTykeJnKfs4qSm7QQ83dmGb6DghzGqQVmVaqXS4iVrXdac3NbegZxJp7A2E6ZZguue9Q
 0r+m4s1xJ9cKqP9uAiE9di15+YJ/+uWVN48MJRMR1ZWmnAggtixSzFnMby8L4Lf58QygMw5kl57
 xKRzli+G+9dYAd0zCCfktr3Uezzqg35YqKZ4DM56d51XWAYTsRLbCBlAXsukF1zikxysg0Qv/Yh
 VUAOw39p5kt4h4z2k8MmexaDVt12IznlD4tO5ITpSb7CYmYZk99U3Tsh6Tbyq4cAWgFXaad10Sj
 TrCnL/LpxPPYk5Ddee63z0NLhUbn3L8k7EBEXVWWNrTkfu9LZ1bly3AmmJE1LKhcFvmhDtwvB00
 rNFXJ3imA6FgEFIN7acxaMZM68guEWSY2lRBagRwsKJB+Y+7KZhyTRUathhlQ6fp8vgwsergBkj
 PwcATdG3Rfls8YNFtW3SqtZOPK8IcdRiecV18k+
X-Received: by 2002:a17:90b:2803:b0:39d:ef3e:9035 with SMTP id
 98e67ed59e1d1-39def3e96e0mr6690364a91.10.1789402723797; 
 Mon, 14 Sep 2026 09:18:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfb8b7561sm466131a91.1.2026.09.14.09.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:18:43 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:18:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: 3chas3@gmail.com, humin29@huawei.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/8] net/bonding: fixes and per-member stats
Message-ID: <20260914091834.4d441b2b@phoenix.local>
In-Reply-To: <20260831161105.289670-1-stephen@networkplumber.org>
References: <20260708174204.72574-1-wpan3636@gmail.com>
 <20260831161105.289670-1-stephen@networkplumber.org>
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

On Mon, 31 Aug 2026 09:06:40 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The recent RFC's to bonding prompted me to (with AI assistance) to
> look at current state of bonding PMD. Several issues were found.
> 
> This incorporates the RFC patch series and modifies it to 
> have Fixes and more checks.
> 
> Added proper extended statistics which allows looking how
> members are doing.
> 
> Weijun Pan reported the stats double counting and the secondary
> process crash (Bugzilla 1900).
 
I would like one of the bonding maintainers to look at this please.
