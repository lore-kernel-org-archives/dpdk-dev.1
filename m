Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1CFCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 22:38:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A08640E3A;
	Thu, 13 Nov 2025 23:38:18 +0100 (CET)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1C7E640DCF
 for <dev@dpdk.org>; Thu, 13 Nov 2025 23:38:17 +0100 (CET)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-bc4b952cc9dso635506a12.3
 for <dev@dpdk.org>; Thu, 13 Nov 2025 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763073497;
 x=1763678297; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRVbZs1JNiUgDZzfgi4YVxQblLqhzf8TMSBqFSBt8QA=;
 b=JD6KgTKkuENUNueSkmRTq6S+DOBp9tpBF8pqjExRDIsuXdZegnIc7e8D1w3MYRc9rF
 9CXNbKJAt08jRqf/ZwsLc872bT7mZ3o7pj1fQFvL2jrvJBYuzR6XKzrSpk2EuaQiBaCs
 je6QTE60Hg0qlZSzF0u7unRSJHhkUbXfL3QfkZ/3spM7fDXdm07uUUDerqjBmMtZ9o1e
 wzw0sx4PQBZvgJPoJWWB6TmO64/PzTNxwxLsBuFkHA+5yWNApA9edtJzdEiKb87C9dWI
 w53Rb7ivbaIS3anCzoQwTDLuIZ/5OCiYF8YGBUed/aNqotcSXmEYQ+kY2U/42EA1BGWD
 ekrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763073497; x=1763678297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BRVbZs1JNiUgDZzfgi4YVxQblLqhzf8TMSBqFSBt8QA=;
 b=Ak3mmdu9ZjRLDEGuEr1FAWvHhFAaHadh8n/f3RQ3KzmMxbFw7JzhqBAy1cG+qyH6bL
 jht9sH7N0HCWZjPuJQHvXqMKbI9UTLseS+k9ObFF6CUeTjEaYsQeC767ScB5/TfUQZXV
 RohBs+xTKiyPpCcVI396Fv4jTrt139aFu/4ShMrGRqLzH/8vgVdffDDaTMJHFDnohlE/
 4vIFskweHnt6nhploGOMcNW469hwCQeUYfodw3a7EQvPnLHsU9CRQc2KN9yR4xlwkRIr
 UPZBo65N5oEX31kbpjN8u1Y0lGAH80MMHVoisSAty8qTLWWegACrDdb1eWaCSrujX3Va
 sH+g==
X-Gm-Message-State: AOJu0Ywuer8tKmZZjC2LSDFcgRFojWlp6q+AUNdnsTs3YskFNKNluYWC
 +wSBkTDx3kjGSvnNZmotVkPvtVIxteK0fNKGmn5p+oyUWKeK6371NgHHNG+P0V6P4eU=
X-Gm-Gg: ASbGncv/6z1g0mgYQDkrCXq6Ojuw2XAkIGy8BKseP+hxDK09ewUq63DUUHW0FqsAbxE
 ydB/sk9od3AmYywxRL1owh3fWuy2rgBf8WBpiCLewNAsXDqTAIka8/wsTCd5Z1THIt5HAGBaCv7
 fJbo/E1IwS90TQoAfVH2nkha+6vG0kZuUaZ1G7H8p0oiKT6bIwmEMvmPTyhPD0aClvTmQEqzmrP
 GZFcUeSxAsze6RyqmIxF0zlW8UUpaWqCaVsOhUmzrM/M09EZ3i/Cgge0ihsQnX/X+1O0Tb0i9Hi
 W1Ydcb8u0Aqd6pg96z+04VzgXK3A3i/7kPnwE69aWTgtCCny/hpOCbKd0e72ft2o057w2WN9UIv
 CKruII43VEs+T/c/eEV5jQ076Y5wKJRc67xiR0vB35KbL3P3YZ3W+GA1VsKUfSr8IPZ1sFhoJgz
 QgVz0Z7yCJNx4APdz19H+Nev/a92u2KuCt1AF9Rxnkpk5j
X-Google-Smtp-Source: AGHT+IGNFJ9TMlIqM3S0coKvVc6A1lHLq9LrRV+ghtPC0GF6vV20PWIRVQmLxUufL07kq3F8WWNwOQ==
X-Received: by 2002:a05:7022:1608:b0:119:e569:f279 with SMTP id
 a92af1059eb24-11b41200308mr389043c88.34.1763073497021; 
 Thu, 13 Nov 2025 14:38:17 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11b060885e3sm2390002c88.0.2025.11.13.14.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 14:38:16 -0800 (PST)
Date: Thu, 13 Nov 2025 14:38:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maayan Kashani <mkashani@nvidia.com>
Cc: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, Aman Singh
 <aman.deep.singh@intel.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Gregory Etelson <getelson@nvidia.com>
Subject: Re: [PATCH] app/testpmd: fix flex item link parsing
Message-ID: <20251113143813.5276622d@phoenix>
In-Reply-To: <20251113201726.10597-1-mkashani@nvidia.com>
References: <20251113201726.10597-1-mkashani@nvidia.com>
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

On Thu, 13 Nov 2025 22:17:25 +0200
Maayan Kashani <mkashani@nvidia.com> wrote:

> The flex_link_item_parse function was using FLEX_MAX_FLOW_PATTERN_LENGTH
> for all memcpy operations regardless of the actual flow item type. This
> could lead to copying incorrect amounts of data.
> 
> This patch adds a switch statement to determine the correct size based
> on the actual flow item type (IPv4, IPv6, UDP, TCP) and uses that size
> for the memcpy operations on spec, mask, and last fields.
> 
> Also adds validation to reject unsupported item types.
> 
> Fixes: 59f3a8acbcdb ("app/testpmd: add flex item commands")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
> ---
>  app/test-pmd/cmd_flex_item.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/app/test-pmd/cmd_flex_item.c b/app/test-pmd/cmd_flex_item.c
> index e6e1cefeb3d..ec19ab63e75 100644
> --- a/app/test-pmd/cmd_flex_item.c
> +++ b/app/test-pmd/cmd_flex_item.c
> @@ -134,6 +134,7 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
>  	struct rte_flow_attr *attr;
>  	struct rte_flow_item *pattern;
>  	struct rte_flow_action *actions;
> +	size_t sz = 0;
>  
>  	sprintf(flow_rule,
>  		"flow create 0 pattern %s / end actions drop / end", src);
> @@ -143,21 +144,24 @@ flex_link_item_parse(const char *src, struct rte_flow_item *item)
>  	if (ret)
>  		return ret;
>  	item->type = pattern->type;
> +	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ITEM_MASK, NULL, 0, item, NULL);
> +	if (ret > 0)
> +		sz = ret;

You don't really need a temporary variable sz, can't you just use the
return value directly or are you concerned about signed/unsigned mismatch.
If concerned about signed/unsigned mismatch warnings then would need
cast on the assignment to sz.
