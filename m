Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC7606A324
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=hSyRaXxZ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BB7640264;
	Mon,  2 Nov 2026 09:41:57 +0100 (CET)
Received: from forward503d.mail.yandex.net (forward503d.mail.yandex.net
 [31.44.14.19]) by mails.dpdk.org (Postfix) with ESMTPS id CB18D4003C
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:41:55 +0100 (CET)
Received: from mail-nwsmtp-smtp-production-main-83
 (mail-nwsmtp-smtp-production-main-83.yp-c.yandex.net)
 by forward503d.mail.yandex.net (postfix) with ESMTPS id A6065100048;
 Mon, 02 Nov 2026 11:41:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-83 with ESMTPSA id
 pfiqwgCmIuQ0-1039eEmL; Mon, 02 Nov 2026 11:41:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1793608913; bh=jykYSIXE40FdjahPT30dBYHvRIUd1xwzN6hptxaJ+io=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hSyRaXxZC7GLetous3z+GA3IqG+IYtY7Irm5IBwbl9khS0YRBpUUAHGypIeL4PLZ0
 MU/a6qjx6OrCXVgV5bhfm/XBySwrydjY9ciBNGjifRBtGfo0T8AB4/+dfNi1LB1kIw
 bYrbjP56XfGGGR0nlBDjYLzN+AnbitceU05aZEvs=
Authentication-Results: mail-nwsmtp-smtp-production-main-83;
 dkim=pass header.i=@yandex.ru
Message-ID: <cac350a9-9d40-41d7-a136-0eb32a3813c0@yandex.ru>
Date: Mon, 2 Nov 2026 08:41:50 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] acl: avoid vector spills in the RVV search loops
To: Stephen Hemminger <stephen@networkplumber.org>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev <dev@dpdk.org>
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
 <CAOaVG14=ECO921X+DmupfY60Dpo9r2xq=Y4+QC22G=AQ0kALQA@mail.gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <CAOaVG14=ECO921X+DmupfY60Dpo9r2xq=Y4+QC22G=AQ0kALQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



01.11.2026 20:57, Stephen Hemminger пишет:
> The compiler is doing what we asked. Why workaround it.

Same thought: why simply not to use -O3 then?

>
> On Sun, Nov 1, 2026, 9:04 AM Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:
>
>     At -O2 the ACL match checks are not inlined into the RVV search
>     loops, so
>     a vector value live across those calls is spilled and the
>     remaining locals
>     are addressed through vlenb.  -O3 inlines them already and is
>     unchanged.
>
>     Add __rte_flatten, and apply it to the two search functions.
>
>     Sun Yuechi (2):
>       eal: add flatten function attribute
>       acl: inline the match checks into the RVV search loops
>
>      lib/acl/acl_run_rvv.h        |  8 +++++---
>      lib/eal/include/rte_common.h | 13 +++++++++++++
>      2 files changed, 18 insertions(+), 3 deletions(-)
>
>     -- 
>     2.56.0
>

