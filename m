Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143B5C982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:55:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63C0742E50;
	Mon, 21 Sep 2026 17:55:17 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id A0CB342E4E
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:55:15 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so2208802a12.2
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006115;
 x=1790610915; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wYkyHA5JzAP1x8JPOVMc0yVmsj4gQwIBwVOerpmXfBU=;
 b=R4b8M7wb6i0yixuvP+J0sLO65wCXqc0cZ3bnzKFuQsqgoJKmI5X/25Mq8JEm/zid9T
 yFcoi3Gh4oHbNSJUULcP/ALcFVjNY1uZskJeZvfGiKNIOL1iOeP6FMs5ikTFdYGCWm3s
 dhCoJ2aAexsSTfuIuixA8ss1fnjP+lFxQ5A3fJAlaVpKOVgelsc5M6U2s3bob/cjXQPb
 ONTPouuDvBeICvuVav+esOIoB6G6YTricvIRiTfN5Jw+rQHRjPw+JlyxBdFJ9Zu9NQpL
 5tRPkilOhCCE++noLwfexoE9lwG/yuNoCvwhcZkuOllbg1h1tfNuzLcoljAHMMn14Kuu
 uU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006115; x=1790610915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wYkyHA5JzAP1x8JPOVMc0yVmsj4gQwIBwVOerpmXfBU=;
 b=N6GWXFq3RJGolqT5NwRHlH4XieZmYaYQUXWTzNGeJ9huYZ02H/wFRsCSeM9oUOQS6d
 txwum++zy+qmwDEneYTDkWOc49OPVVenP/J8sqfDxlQHqbUwpLNhskWhp4Et1y5yorY9
 xLYuY5S+hKYsMzfRcrHe+OVUdyp05YRm2eiASRwUqEjXCXHV0H7RKvvYWrdylHQTO4XZ
 /cisBgBeGQs0Rn/fdWRS2aiHigqLYj2wrAad76Eiw3X1vLAz6NvWWkA5lv59QfuBHgLk
 w4YhpBs5qkQYPWnO+QqObUPdctsMJQzaHKmZRRLqJDI/X4fD3UYjXoMUAeaCeu7EwOmM
 cMwg==
X-Gm-Message-State: AFuF++lylSEfSX9MrgJ/gZ28CixR+agOMsxnHTzIxiUaPBkwpO6UsD3c
 /uPkulYi5LcHUx6ebG+Qs5P/MyoQp6ucFNWFW5Bq/RzxQ2cLr1OOBa5Ruhx6wOK8ITM=
X-Gm-Gg: AYBFou1gLgTA/eiY969U3YRBNar3qA+OZYhjzJMPZ0QQFYoRj+ed3dA83duqwgjx5DD
 0u6UuO25MHRE+rSDx5IUa8k7tlrkEblgljC2hTr1M++xXryv0r0ModbhesULRbImfzQXMw89oKh
 fYnTwliN/a04y3hs4Z3uYwkOOUrMmzdjqeU6MICEogD5isCyOc32NHV75XkdaOsLLYC/PhOqstA
 E36xGbCptgE3LHqT5PCgdciXvPCz/W2L5AInKdLeoQ39Z2e9+s8Q/+3xj/e+rB4q5iZuRioCzzn
 V3c6SAPz9/kqSZxOcVWWl5Ms39BLy2uqju7ziiPJC9DvJkgVACcni5svtTulqXv4MZEAax82pzg
 vHVixPNAJ4XM9wBoUGm99IvVnsWmCCa3CpnohJiV/r6Hp7sTrPVXhYHHXm5TZj1jf7w1iCIAWBr
 UhKTf/1F3/0UAkJRRiEwekg0OaCyQvLMte8UXUPgfrAtGLvQTrZwGUYgYjbi7VfzeIK+K9iYR5l
 p79t5HhJrKKAoFfL3722cfIu/jp4sn4DMtHXhIQ
X-Received: by 2002:a17:90b:4d91:b0:39e:6c69:34db with SMTP id
 98e67ed59e1d1-39e6c6936e9mr9620593a91.63.1790006114645; 
 Mon, 21 Sep 2026 08:55:14 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:55:14 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:50:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Chenna Arnoori
 <chenna.arnoori@broadcom.com>, stable@dpdk.org
Subject: Re: [PATCH v2 4/5] net/bnxt: fix bounds in MAC pool index and flow
 parsing
Message-ID: <20260921085050.4ec87519@phoenix.local>
In-Reply-To: <20260921022420.1034071-5-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-5-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:24:19 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Chenna Arnoori <chenna.arnoori@broadcom.com>
> 
> Two independent out-of-bounds issues in the driver:
> 
> - bnxt_mac_addr_add_op() indexed bp->vnic_info[pool] with a
>   caller-supplied pool before validating it against bp->max_vnics, and
>   before checking bp->vnic_info was even allocated yet (it is NULL
>   until the port is started). The existing "if (!vnic)" check was
>   always false, since vnic held the address of an array element and
>   is never NULL. Reorder to check dev_started/vnic_info first, then
>   bounds-check pool against max_vnics before indexing.
> 
> - bnxt_flow_non_void_item()/bnxt_flow_non_void_action() looped
>   unconditionally until a non-VOID item/action was found, walking off
>   the end of a pattern/actions array that lacked a terminating END
>   item. Bound the skip loop and stop advancing once the limit is hit.
> 
> Fixes: 51fafb89a9a0 ("net/bnxt: get rid of ff pools and use VNIC info array")
> Fixes: 5c1171c97216 ("net/bnxt: refactor filter/flow")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Chenna Arnoori <chenna.arnoori@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---




[PATCH v2 4/5] net/bnxt: fix bounds in MAC pool index and flow
parsing

Warning: the bounded VOID skip does not bound the walk. The outer
loops in bnxt_filter_type_check() and
bnxt_validate_and_parse_flow_type() run while type != END. After 256
VOIDs the helper returns a VOID item, and the loop calls it again at
item + 1. A pattern without END is still walked off the end, and
non-VOID items are never counted. The rte_flow API requires the END
terminator. Drop this half of the patch.

The added "if (!cur) return NULL" paths return a value that no
caller checks.

Warning: in bnxt_mac_addr_add_op() the pool bounds check comes after
the dev_started early return. An invalid pool added while the port
is stopped returns 0, is recorded in mac_pool_sel, and then fails
later in bnxt_restore_mac_filters() at dev_start. Validate pool
against bp->max_vnics before the dev_started test. The
bp->vnic_info == NULL test after dev_started is dead code.
