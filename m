Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9DDC982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 16:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 328F242F8B;
	Thu, 17 Sep 2026 18:19:31 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 95E9A42F95
 for <dev@dpdk.org>; Thu, 17 Sep 2026 18:19:29 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so744560a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789661969;
 x=1790266769; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+O+ecswsJWsBddr3ZvCdda2ehvghVAXyANDo4ZNLy3g=;
 b=CWEonXRNJbAikRSAmDevZ3dCwvt6BfZ4XV4n2erzs13mgo4hhWNaPH2WajPxgZ2BT7
 842Mx51ujTqsfUcCDcd7H0oOjVAzAYG6GMaUDu460NPD7djj13QflN8m8d6d87LvlYQT
 wWXkN2Q9DdpVMNwXm579EZzWPey6uZkik40cyvQ0IG0q88Ro+ke0qXDnU0eIMFsewuH/
 ddqMuYhPiuZW9N6kZpAAvB3KBGQ1X/pJKObJ9j+LaXsQgd+MBZjxzUlLUeSF2fLDnl+A
 XEhcGCCYvzygpB6sD03MD7huEM4MIQ1QCMEYfks5qszrxcTN2BdpN+IFbGSB0jAsgkrj
 BuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789661969; x=1790266769;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+O+ecswsJWsBddr3ZvCdda2ehvghVAXyANDo4ZNLy3g=;
 b=NoK4K23QqeVAPWGajUxsY3q0bS243AhSpPokpK5e8r7T1OSZDtncs0TQa1/ZstTltr
 kfbw+ArYXE+IgGcSZ+5Z6RuOrS2EP+GlP35numGslRCfZtLVEZcpIj/5UZk5XneScYFZ
 2CAnat7eS8skpsb8gSOCLEgT72Of7knghb/gxUfElSkrP8Fqt8Fr2hIu+YSejSkCKNt3
 5go/rbvNIVV94jUpFvnOz6lXvEop19TXJ+xOKuWmblc7AJSUdoqqk+R8w/FdopEwi4ju
 a2cyP8E+LRVr8vYEBAkv0e7s/Zophf5fvtFzmsqBQ1z3XKO4IuCOKxrDYYFxU7eqBq0z
 qz5g==
X-Gm-Message-State: AFuF++ls49g8VItHi966qA1pQzUjEq+H1eayVAZuVpr8qaDCM6PhsJfV
 8l6FFj6Fqw9rGIKxAb6hYrWON33QMCMAtkjl4RIL8jCARb1y+oLThd/HvCINlmtx+cw=
X-Gm-Gg: AYBFou01q76qpEND4xEUKitFrdp/+6lERov4sMUxfWHH3OuUUvUddIFPOQw5reuhiYt
 KN0fB0NRpokPtzisBLqvD/MwPsIElKHn3XIxqP2/ouY9Yqqf1JfT8kza2oQ4D126FrtkSGXeTuE
 75xP7BKsL3e3b3Nadu9mZIEYyJ3eJCdi9+HJ9KXgKAgps6vZgpy513mYBJQ24iK0mbmTG7ATt9z
 Qf6U+mqbfmu/93PU3OuuMUh1D0BCiLC1MS+0CNRhiWSC7ELNuxodXTnAPQyQ3gyoVkwaSphNJsh
 D+akNvTkZjAlNV/t3cIHnYsD6wvg19D3mxV6WaUbIF0yymHhSjYZQhiCMWMFzjKKDDxH9xAFWWE
 M7VJiZYxdYOl1la6ThBHf9SROFNgop8GEK/zlhm8QJbupAeNsRoxFYcuYgbWKJY4ScrM6Cm5mhL
 puYYE5wLTl2fRw+tuOsWHDoAIn5srzqc6djxYdG1hMKiAo9OHsAtr2jW2+eu5PRXF+di2Gp6/LU
 EADexKw3PhHrnOxgnNBUrfEqHeQ3eG3A60qmINS
X-Received: by 2002:a17:90b:4c88:b0:39d:fd82:de0c with SMTP id
 98e67ed59e1d1-39e1e278ae9mr15765922a91.2.1789661968663; 
 Thu, 17 Sep 2026 09:19:28 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e3c06423esm4824952a91.15.2026.09.17.09.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:19:27 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:17:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Rahul Bhansali <rbhansali@marvell.com>
Cc: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar
 K <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha
 Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 <jerinj@marvell.com>, Alok Mishra <almishra@marvell.com>
Subject: Re: [PATCH 12/14] common/cnxk: update mode param for link speed
Message-ID: <20260917091741.2884a723@phoenix.local>
In-Reply-To: <20260917071016.2366467-12-rbhansali@marvell.com>
References: <20260917071016.2366467-1-rbhansali@marvell.com>
 <20260917071016.2366467-12-rbhansali@marvell.com>
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

On Thu, 17 Sep 2026 12:40:14 +0530
Rahul Bhansali <rbhansali@marvell.com> wrote:

> From: Alok Mishra <almishra@marvell.com>
> 
> Populate mode for kernels that uses args.mode for link speed
> update.
> 
> Signed-off-by: Alok Mishra <almishra@marvell.com>
> ---


Patch 12/14 common/cnxk: update mode param for link speed
---------------------------------------------------------
Warning: args.mode keeps only one advertised mode.
  req->args.mode = plt_ctz64(link_info->advertising);
- With autoneg, nix_link_advertising_get() ORs in one bit per
  requested speed.
- mode therefore carries only the lowest one.
- args.multimode and args.mode_baseidx are left unset.

Warning: the commit log does not mention the new rsp->status
propagation from mbox_process_msg_tmo().
