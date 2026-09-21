Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8BC982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 434314029B;
	Mon, 21 Sep 2026 11:51:43 +0200 (CEST)
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99]) by mails.dpdk.org (Postfix) with ESMTP id D886C4021F
 for <dev@dpdk.org>; Mon, 21 Sep 2026 11:51:41 +0200 (CEST)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6aa053900f5so4562958a12.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789984301; x=1790589101; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iRRDY25bk/lJwI6iGXXIc3Hw0E0xvKQ5nzon9lo63dc=;
 b=LbRnIRPBhfEBRCO9GxQvQNj2OpfhyXuC7A/aqTREFioaT+tVPsxZGmXTqxmBL1wmiM
 Udm41g8AQlUhW57lpvFsrnbf6ZUZEoSY68t1oW5tY8in6bMIUp0OScWUoIVLn/94cbQ9
 3I1xVySz+wgxD3of7Qb4nIBWy2OvMIpqrXVXtI4mRCXHzi2tPQLukBXM5TsMq+OYOLnR
 vpgKuxtv5KF6oHCuD7rbIlHMNkjbS974fU2Ho2KC4WP5mMaHdaXl9m+YXvPZOM5wIaIV
 NM/ZDo2tvG6a4eyqOQ8e6Z1j14mp93uhL7T3V5+yV+3UBdV61ugCFyacUvcqjVL3jwtS
 I11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789984301; x=1790589101;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iRRDY25bk/lJwI6iGXXIc3Hw0E0xvKQ5nzon9lo63dc=;
 b=kHwIxuX5/946I8jO/Zhr3hRNLKP77+co+AChNKcpkIXGMqWGxz2Xdxor6X3mwLd+h7
 tUSieywKp/SuLu3IVTE1K98K92405eYKG35DF7SLaaoVSbUtYxlKNpi02QHNTq92im65
 a0pWE2LRvnDc/j/Oxepv4W22gwWL5QRVICTLvL36NOauzAEYipRXj/XDQSAJpESM+XB8
 ChfchU+pysk8w4u7l7o4hRZiVL9fUUNfDaXraHeLj5HfYtUdkDLYtH2KKyxF540bKAt+
 V+s9zrU/RlGbbdGgqXCzGkDKrPfGUrBrWtJmpOeZsQfueIgrikpV3vGmoSl9o19FbFpZ
 7qQA==
X-Gm-Message-State: AFuF++mk9FkkyhO8m/VE9Nbxhxldgr+g6lgvl5zTQC1qDlB2EFVU5rxa
 RxyDZkcneDL/k4GxXjAA5uS+mvHG/d9Yop4efgI0bezSNg7aFmkDWo1Qay4uBSNO
X-Gm-Gg: AYBFou2drOzAaX6VfeCq4f7bXq/RZxGtK5omyDxH6LODRUKNFCQ7GznvYePS2pVst55
 Fq2KBupBCS3vmQDX82GJFdc3YE8upa31t1IxxUY7NujKAwdFlq95JLISCbNAqDSLkYul6kFz4gU
 +V9zoJl3XfcEOtVD3jnRe/1gGAUoAThUm+RUe8rNbav80H1oB6mR32VUa9/odsirag1yafIeBwb
 BjAWPq0hqPthWUs8AfeucyiLmYpdPQdybmHdKL3IQllgWNHqDXzhpsnv2QsMMIC8HoIIKLDwXbB
 CzlDB5JXPiZ+9fxrK3uK4w0DFxoMYKfJDj6EtONpx5eTNy1ie/CcyAlrTA/C6cxMCujuBGaDcFa
 4nVLmsffK0SJCxu1TY79EUO1uQo8C8egI2BIKT1trvvu+CVgV786xuEfPnXbE/I9eDTqsm+35wB
 USDNCTKKwdyzi7OW+zSTGU5iMg/HO6jJbvrjXjwip119wbAKd7brddH7VRNT8BCwF6NQ1HkIQ=
X-Received: by 2002:a05:6402:438c:b0:6a3:ee60:b13f with SMTP id
 4fb4d7f45d1cf-6aa577f8829mr7014973a12.14.1789984301265; 
 Mon, 21 Sep 2026 02:51:41 -0700 (PDT)
Received: from [192.168.103.32] ([89.101.57.120])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa67dc582csm3972319a12.16.2026.09.21.02.51.40
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 02:51:40 -0700 (PDT)
Message-ID: <2801d980-791c-4552-a9cd-4ad705ebb196@gmail.com>
Date: Mon, 21 Sep 2026 10:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] examples/rpcapd: demo version of packet capture daemon
To: dev@dpdk.org
References: <20260908210832.1556291-1-stephen@networkplumber.org>
 <20260920190007.1128720-1-stephen@networkplumber.org>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20260920190007.1128720-1-stephen@networkplumber.org>
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

Very cool example, demonstrating many advanced DPDK features at once. In 
this regard, it really excels.

It could be however useful as a debug tool, and in this case having to 
deal with a secondary process is a hassle. Could we have this feature in 
dpdk-testpmd, instead or as well?

Otherwise, having seen the demonstration, I do not have many comments, 
except for a couple nits below.

On 20/09/2026 19:59, Stephen Hemminger wrote:
> This example adds RPCAP support over localhost TCP
> integrated with DPDK. It uses a secondary process that allows
> connections from using tcpdump defacto protocol rpcap.
>
> See: doc/guides/sample_app_ug/rpcapd.rst for more info
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> v2 - Build on Linux only
>     - add filter support
>     - fix lots of AI review feedback
>
>   MAINTAINERS                            |    2 +
>   doc/guides/rel_notes/release_26_11.rst |    4 +
>   doc/guides/sample_app_ug/index.rst     |    1 +
>   doc/guides/sample_app_ug/rpcapd.rst    |  216 ++++
>   examples/meson.build                   |    1 +
>   examples/rpcapd/main.c                 | 1430 ++++++++++++++++++++++++

main.c is a bit large and handles many different functions. It would be 
more readable if different aspects were handled by different files, or 
at least clearly marked sections of the file, with overall structure 
explained somewhere at the top.

>   examples/rpcapd/meson.build            |   19 +
>   examples/rpcapd/rpcap-protocol.h       |  127 +++
Could we just use one from libpcap?
