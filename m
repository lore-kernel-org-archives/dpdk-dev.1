Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2C6CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:45:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDBA4402A4;
	Wed, 14 Oct 2026 18:45:05 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 579614013F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:45:05 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30b6dad2382so10043832eec.0
 for <dev@dpdk.org>; Wed, 14 Oct 2026 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791996304; x=1792601104; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=36Cp9XZBiqzkOMHENogU5GBK4Q1ZvbZqkGMt28Eu/G0=;
 b=aZpEzl+Yl0SX6/9Ph5Av4Dv+o3PegQ0NA5EBWjkGJMCr00xxXifIN3W5E5k6T/9T/w
 u1Dq9ZaBMWD2ShTX1BzqcBljrMICziQVvG1wRJBZZNDdK03T/Vh7TwWq+XVu6ECXzl5v
 HlbtpkEFACytM/jTodr50pzFg9+AFpEzDAZudJYMBPiYCl8WGoS7Wh5bQFCl+Ow6K5OV
 e2GfCHjs+3fyfjS6AM9Ypl4hNuPfmQrAy1w8ZiE0KsEudNCiXKBh6ukc7tbfE26Qb3RL
 +6UKNu/kRQeKTZUJ1vR8HlTACvwbmZeZUak4N/2CtHUwXTkTHgc9o/h1tijDo54ZOhMW
 OM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791996304; x=1792601104;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36Cp9XZBiqzkOMHENogU5GBK4Q1ZvbZqkGMt28Eu/G0=;
 b=AcdlguIZS7tf2I6Y5CTgPhggbfL92i2DJcPcbfTA22aDgnV0NEGh8XI9M9HsJ+TYNy
 4zkDpowp/cqQVYgR6lxmgGlKJVVczhPqvDt7UxFLugqkuhgsNKuyu1GdZVfZYPzQNcVv
 MRjszq4e5eip1bCEA75CnglCFIt6gl8HPhw5YmbWT1Xkj7XBB4qshX1d5F3ET1PVS3MF
 nS8KazxHHl1+xYB00MOEvKWuaaVwvnvlbNsAJI32yj9HfMQQsF8tRrzxfbNd94AT6CFL
 x60pZgkXWSHIrPp8oTWT1AKnGmhn2xX689MkZPQf2JSwF3Xlr04FApaOkPQU5B7/dUOU
 hppQ==
X-Gm-Message-State: AFq9FYIrgkDzOlaVbBt2rWb0Dnprsqx1UqHQRcL3yf34lG4u5m/9mbxC
 7JdyexeVE6/Mi/M/XfeHEn5gWQ2CVIL6jthuv/ef9XHOUxgloOQtX2YS
X-Gm-Gg: AYBFou2dShCUuC5GMT0IJl5yJffU3kA8ibNIBj5couxOsVnh8PEM7g5nCX8o6riegTH
 A1JGKVuxNEEtTJ/+/4qDdIE1W2dqT5/QEoALhtxOAzHlVvl0ju/qUypo51nLXayhiUFYKxP2/+V
 oSHbL3HivnIKCfFKq4z30sP/dE3pQITjmmBlD4imDyn72afD3xs5e55Zz1VJ/tiI5WtFakW7xyI
 ZqffQkN/eeQHq4AC7ARGISIZZsWd+dvMlFuqIZu6R2ZuaP5if9bymyqqhb8fRNFQtWzo2jNIcFk
 21GKJXvxC7dAMufdfnFrrr0Gnqj6LY81VNewPuC27bGpPpswjH/6DuAC4FyAkWjqDrGYar1mF/j
 eZjxJKf7u02It3AOx2etZX3ud2O0BQgStng8tb5ohCCONSAIP1cYTQpLJIyPg4WS+eplIBHsCpa
 A6yFl6Z2ny7fnQW6/F9UEj8qGR6BWltOmBQsUtIO9tuRYxRyJuyCa9+S0KqTcxK35woB+6wikUf
 di9KzGe/HgRXKhE
X-Received: by 2002:a05:701b:4212:20b0:168:e942:4e62 with SMTP id
 a92af1059eb24-16a61789c56mr22503028c88.40.1791996304039; 
 Wed, 14 Oct 2026 09:45:04 -0700 (PDT)
Received: from [192.168.1.112] (mail.forbuysw.info. [66.175.223.235])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a6021e49sm49610493c88.20.2026.10.14.09.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 09:45:03 -0700 (PDT)
Message-ID: <3de75531-dd3f-4953-8fb8-1f654b74f050@gmail.com>
Date: Thu, 15 Oct 2026 00:45:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net/txgbe: fix FDIR Rx packet buffer handling
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com
References: <cover.1791898970.git.zhtfdev@gmail.com>
 <20261013074555.1ab5dc7c@phoenix.local>
Content-Language: en-US
From: Zhang Tengfei <zhtfdev@gmail.com>
In-Reply-To: <20261013074555.1ab5dc7c@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/13/26 22:45, Stephen Hemminger wrote:
> On Tue, 13 Oct 2026 22:00:16 +0800
> Zhang Tengfei <zhtfdev@gmail.com> wrote:
> [PATCH 2/3] net/txgbe: do not enable flow director on flow validate
> 
> Warning: validate now accepts rules that create will always reject.
> 
> txgbe_parse_fdir_filter_normal() can set
> rule->mode = RTE_FDIR_MODE_PERFECT_MAC_VLAN. Before this patch, with
> mode NONE, parse called txgbe_fdir_configure() which returns -ENOSYS
> for anything other than SIGNATURE or PERFECT, so validate failed.
> Now parse only checks for a mode mismatch, validate succeeds, and
> create fails later in txgbe_fdir_configure().
> 
> Keep the cheap mode check in parse so validate and create agree:
> 
> 	if (rule->mode != RTE_FDIR_MODE_SIGNATURE &&
> 	    rule->mode != RTE_FDIR_MODE_PERFECT)
> 		return -ENOTSUP;
> 
> 	if (fdir_conf->mode != RTE_FDIR_MODE_NONE &&
> 	    fdir_conf->mode != rule->mode)
> 		return -ENOTSUP;
> 
> [PATCH 3/3] net/txgbe: disable flow director when no rule is left
> 
> Info: txgbe_fdir_disable() restores a single packet buffer layout
> (PB0 = rx_pb_size, PB1-7 = 0), not what txgbe_configure_dcb() set at
> dev_start. That matches what txgbe_fdir_configure() already does, so
> FDIR with DCB is already broken and this is not a new problem. If
> you respin, consider saving the PBRXSIZE values before enabling FDIR
> and restoring them on disable, or reject FDIR when DCB Rx is
> configured.

Thanks for review.

Addressed in v2.

2/3 now rejects modes other than signature and perfect while
parsing, so validate and create both fail for a MAC VLAN rule.

On 3/3 I left the DCB packet buffer as it is. Enabling FDIR
already clears PBRXSIZE(1..7). Rejecting FDIR when DCB Rx is
configured can be a separate patch.
