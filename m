Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CB0C5DF81
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 21:04:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54EDC402CE;
	Wed, 19 Aug 2026 23:04:22 +0200 (CEST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mails.dpdk.org (Postfix) with ESMTP id 099C7402BD
 for <dev@dpdk.org>; Wed, 19 Aug 2026 23:04:20 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8518d5ddaabso1264872b3a.2
 for <dev@dpdk.org>; Wed, 19 Aug 2026 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787173460;
 x=1787778260; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kKIVZ20e+X84JlULcbp1mCZJrUzbnp14HFD6Qy/bnLE=;
 b=pV4Xz523POEXSjkAJ+u1vC5+9C8UybHAVetwBrb2rB8OGmU9DhU0kk6UBnqMiK5fgk
 NcdsLYIqNPsprpHzs95C2PSYFSZAj0dXQeHQA8GtudXULVg1Aku0eILag+ZwK3qlqMW8
 HY5Xh2KGx12TsDj3yxIxJUmdl6ietwKRr6XIn4GVXPuOmsymVHHOsrewBiiPNU5k4zap
 FOlQbIo2r2A62ZeXPjDWweLoqzZSMMEwA0h38eseTnxPaohN3tqClbjrBqGrqbXKmxdW
 im/1xpVjgIZGZxCjSNf6tkHg5slKFNAlXZnEcyI2WMHv4gDOtknb3x69q6F9AaOBhI+v
 KMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787173460; x=1787778260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kKIVZ20e+X84JlULcbp1mCZJrUzbnp14HFD6Qy/bnLE=;
 b=kzcDNXaGoZZj/iq0PeFEj1P5dOSa6i+sr7hXpDxuXh1QfCesn6rK4rOVoG/YOtdFYH
 7IVIebCiEqGxPJp9IgBt4Km8shvOFUg8gt+GFGHiRA3d1T6KLnpTX0hhZ64mPjcVKFwZ
 TvMs13uimVPzslR8xKkHgDJBk7hi+siVSNDQdacIJP5wJ7n8xFR8EJZmVfny19oPHe7d
 A9ZBhpdiV2+NTrDSO3l4AFYWDekhJN1Wmd7S1JOu9dlG3MF0lSERZugeEYxzgGVfN24Q
 fbP58jUC2baxcyQMxyoKpLmDZO1TCksnjTR15Rv5DJLLcPWZSDWTJCbSiKXSch9fvcwE
 et+A==
X-Gm-Message-State: AOJu0YxnZZczES+1/PvHXNyIaSzajjVuLTM5hKGOfFk1/iL86OOroE0c
 Mz7L0L7aXsuOnkPvPz5WTAKLvXunyp6x3ewLaXhqCdHpyyv7q0b4ZMtIfuC7PKiZnMk=
X-Gm-Gg: AR+sD137W1/BNzUob+gtPaq6lahgJjYV9orqQi7JdVWMH0yeiF8mX8IgVykX3EHn7pf
 eO/n8J8nZllPb5MOOhnnjap0G6FHTd97oQCEG1VBKEF5TpcTDcOegZxmoyNxiIbAFm7aaQgzoaN
 JxzEJlGJHXHTFw8txJEyM0559FoaBUZxdsuk16puw2BMy+bOglRTWkh0xIzlQhkQ7kBJts9HE7R
 YRKoR9/xa+hINlIUbqPdSgMwm2tRoZ9qYaZkdubUGmJIZMJs+R9aI2PdcIEWWbS6ogYAJJ0xeN2
 f17EFCcL5CSv8djWejhuEwn+H9HVq9p7wFfwl+9rAPc1HX5aovJsYZGwnLrFffDqRwlGJe4dE/w
 eIUM0b7A/xgw5q63peM7op7OOJfONfFFaPCrceOxzu0ztbWhKFq2KXUakFKuMWo9s2hqVNJORQX
 UOqboj/hSq/Qs3JvsuqzT5/9UBrqFsJuIKmlOugQ5TN169fGPcLFBzs+9g3Hj7PsDNyu7yPoQVq
 rEBMUDDIlTkFn1O1YKWHOhclLOHKEI=
X-Received: by 2002:a05:6a21:3282:b0:3cc:841d:bb26 with SMTP id
 adf61e73a8af0-3cd0122b2fbmr12811547637.15.1787173459795; 
 Wed, 19 Aug 2026 14:04:19 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1556753c2sm987082a12.21.2026.08.19.14.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 14:04:19 -0700 (PDT)
Date: Wed, 19 Aug 2026 14:04:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v11 0/4] net/zxdh: optimize Rx/Tx path performance
Message-ID: <20260819140410.4887a784@phoenix.local>
In-Reply-To: <20260819095304.3016940-1-wang.junlong1@zte.com.cn>
References: <20260803112419.2202150-1-wang.junlong1@zte.com.cn>
 <20260819095304.3016940-1-wang.junlong1@zte.com.cn>
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

On Wed, 19 Aug 2026 17:52:59 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> v11:
>   - Restructure queue types for cache locality and dead-code removal (patch 2/4),
>     optimize the packed-ring Rx path with a single-segment fast path,
>     MTU/scatter refactor, and xstats cleanup (patch 3/4), and rework the
>     packed-ring Tx flush with per-descriptor mbuf free, walk budget, and
>     masked prefetch index (patch 4/4).


Mostly ready, one more item flagged by AI review.
Sorry, for the typical AI flowery language here...



One item remains:

Warning -- patch 3/4 adds "uint64_t offloads;" to struct
zxdh_virtnet_rx (zxdh_rxtx.h). Patch 4/4's commit message says it
"drop[s] the unused uint64_t offloads field from struct
zxdh_virtnet_rx," but 4/4 never touches zxdh_rxtx.h -- the field is
still in the tree at the end of the series. It has no readers or
writers anywhere in the driver. Since patch 2/4 reorganised these
structs specifically for cache locality, please either drop the
field where it's introduced (3/4) or actually remove it in 4/4 so
the commit log matches the diff.

