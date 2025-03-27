Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBEEC3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 18:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19167406BB;
	Thu, 27 Mar 2025 19:12:09 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 73F5B40654
 for <dev@dpdk.org>; Thu, 27 Mar 2025 19:12:08 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-227b828de00so25980335ad.1
 for <dev@dpdk.org>; Thu, 27 Mar 2025 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743099127;
 x=1743703927; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPiX55iuHes9dWpgj2E2w9OD/6m60C/gwHQr8X3p3rI=;
 b=NUyRierS37x1Cll0ISfubG5E5MBEsQ2T1PsrSaW7vQD3/2+U1jeJ7xclHK0Xi1v4Cv
 KMOpdJVnetoFJfuza9Moya7Hdu0gf1u6DbKm97oVx/Py7RDDam0lYGHL9d0GLZmAOGwZ
 Angj3455OYCPLe1gvG1MdM093L/Ry9FXeP6yt/Y2OyJYnqEJBY3dJSSQLwW4GiIJj1yo
 JKVbUmZwnCfRlZtVM81ylfdMm+n26XLHllhPJvjHmTw0S5LrQVNZpnkCGytkP4w8ix7d
 A2vQFNL6iGRalIpDs2w7j+hG4oA9uiCWXt9hJWcmZwI8u5vp07X3lVLNIjx2T3xb41Sn
 a9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743099127; x=1743703927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPiX55iuHes9dWpgj2E2w9OD/6m60C/gwHQr8X3p3rI=;
 b=GnectpiBaRmNIMtRfAN0x7RIdMHChM2tIPgrSVWu5VKJlXEbvU6LEqlR9oHc8bjZg5
 NS8R06AT8ExTwkkXB+WbiLCxhdsk4QBPfxxFgN3Jcbx0kf7cNbwr2hnP8HfJ+IqGCLhI
 cegIBKN5r+Yhm8e8KCHrY4wvYYVb3gaxaboi6jHkMViXKBFGAk7XP8a0ThYgM8dCtY/f
 h1IhET5NeveSgxNYXn0LsHSlw+KjNOq5sAK08HSDzLeNr5AhaCShwuUXT54vERDqfEP/
 N0ijkBSPpnCCPVSHfVyWwkCEznRL3HItlxWVYLzPKWj5rm+Diei6pnmyVV3HUUwA9S52
 hnvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4tHTGwDPQnn2DX6QlsQcyMVUw2WQts/Odor62OoknAm3PDBqrGfhRK5o4uil+UZlbAKk=@dpdk.org
X-Gm-Message-State: AOJu0YxyL7fgkeJjkzTMioLEwCQubNT5C5X/uwaqItwuC14x1/gDrADO
 fTQnSWpJJjGv2LcsJWH3EClZJv8zCMoXDavzAr4Iae2bDKuYDkTLUtW/+P13cr0=
X-Gm-Gg: ASbGncv6wsQ5b4aS4hgSjpzIZ8yqqPboB7/8Esal/vhh5pu1VZfci83MZ1apS14kWnT
 bqqGXAqhTx4b7NxcW2hb2/teyAnwcwr1cf/bV2wkaHiQA3G7QKo6FqgVIrG7ps6baXIeiTTk7fJ
 wUizNEk7njRm3ZIC8EcLv/T7/DKn2fbnRauNf1VVbwZGesqOF8d9B0J2Qhyp40Yez5xK/QF9PNB
 nqCirZUW0zZA/WtMeim1VKtIrVa69z9QiZcsfXEP1A2O7VHOvaxZGt98UpNixcgyOYI67VZVPax
 X1k1UBvJx56+ktVXcGJg01/topt4qYrI9mQUytz6gQ2yrj5U226gtV15t3mgs/fiiQJino98wSa
 4V1o55r9HZ+FEN3tQrlLl
X-Google-Smtp-Source: AGHT+IE0kxblSRbNpgirYseefZ22qvO7ciYUA7SFUIFLGCL1MCQJhRbse/FyxeNJdxcz8bVzWBHAag==
X-Received: by 2002:a17:903:1744:b0:220:c63b:d93c with SMTP id
 d9443c01a7336-228049666c5mr74324045ad.44.1743099127324; 
 Thu, 27 Mar 2025 11:12:07 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ce127sm2717905ad.108.2025.03.27.11.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 11:12:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:12:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v6 00/14] net/zxdh: add network processor ops
Message-ID: <20250327111205.026b6e9b@hermes.local>
In-Reply-To: <20250321073200.2015711-1-chen.bingbin@zte.com.cn>
References: <20250319085808.1912523-1-chen.bingbin@zte.com.cn>
 <20250321073200.2015711-1-chen.bingbin@zte.com.cn>
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

On Fri, 21 Mar 2025 15:31:46 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> v6:
>   - Use byte stream to process bar channel return messages
>     and modify some issues to ensure proper functionality.
> 
> v5:
>   - the VF read/write table function is fixed.
> 
> v4:
>   - change some tables to const.
>   - use %u instead of %d.
>   - delete cast of ret_zmalloc() return.
>   - resolve code functionality issues.
> 
> V3:
>   - resolve code style.
>   - resolve spin lock build issue.
>   - rebase code baseline.
>   - modify parameters of the plcr function.
> 
> V2:
>   - resolve code style and github-robot build issue.
>   - eliminate commit warning.
>   - remove unnecessary initialization, which first usage will set.
>   - replace mutex lock with spinlock.
> 
> V1:
>   - updated network processor driver.
>   - improve insert/delete/get table code funcs.
> 
> Bingbin Chen (14):
>   net/zxdh: add network processor registers ops
>   net/zxdh: support compatibility check
>   net/zxdh: add agent channel
>   net/zxdh: modify dtb queue ops
>   net/zxdh: add tables dump address ops
>   net/zxdh: add eram tables ops
>   net/zxdh: get flow tables resources
>   net/zxdh: support hash resources configuration
>   net/zxdh: implement tables initialization
>   net/zxdh: support hash tables write and delete ops
>   net/zxdh: get hash table entry result
>   net/zxdh: delete all hash entries
>   net/zxdh: add acl tables ops
>   net/zxdh: optimize msg processing ops and modify some issues
> 
>  drivers/net/zxdh/zxdh_common.h     |   100 +
>  drivers/net/zxdh/zxdh_ethdev.c     |    88 +-
>  drivers/net/zxdh/zxdh_ethdev.h     |     1 +
>  drivers/net/zxdh/zxdh_ethdev_ops.c |   109 +-
>  drivers/net/zxdh/zxdh_ethdev_ops.h |    35 +
>  drivers/net/zxdh/zxdh_msg.c        |   381 +-
>  drivers/net/zxdh/zxdh_msg.h        |    99 +-
>  drivers/net/zxdh/zxdh_mtr.c        |    50 +-
>  drivers/net/zxdh/zxdh_mtr.h        |     5 +
>  drivers/net/zxdh/zxdh_np.c         | 11631 +++++++++++++++++++++++----
>  drivers/net/zxdh/zxdh_np.h         |  1243 ++-
>  drivers/net/zxdh/zxdh_pci.c        |    24 +-
>  drivers/net/zxdh/zxdh_pci.h        |     2 +-
>  drivers/net/zxdh/zxdh_rxtx.c       |    12 +-
>  drivers/net/zxdh/zxdh_tables.c     |    67 +-
>  drivers/net/zxdh/zxdh_tables.h     |    68 +-
>  16 files changed, 11983 insertions(+), 1932 deletions(-)
> 

Applied to next-net with a couple of small additions:
  1. Added Bingbing Chen to mailmap
  2. Removed unnecessary usage of VLA and enabled warning
