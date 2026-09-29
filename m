Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D26FCA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:59:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FAC14278C;
	Tue, 29 Sep 2026 14:59:43 +0200 (CEST)
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net
 [31.44.14.16]) by mails.dpdk.org (Postfix) with ESMTP id 4C1E8402F2
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:59:42 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:d788:0:640:6e4d:0])
 by forward500d.mail.yandex.net (postfix) with ESMTPS id 8043C87E8B;
 Tue, 29 Sep 2026 15:59:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id cxhA975cP8c0-FlhkORZD; 
 Tue, 29 Sep 2026 15:59:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790686779; bh=16Tai4KyD1xvaMUCiSBDDmgKPnx6dqvLynHa536Nq7E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=iaGSUXcEz+C6YX8JatXQ+g9hbgxUjtm053G73CSKStxugVL2C36vxvZR1mrgcwdGX
 ywxvuBtBWC+EDrRqotRcOXmiNZ+Ztp4zUOS/Mz66sklX7UM2QhLMYjOjdCPn6j/s0X
 qX+iHz8h5uqc8JjhjORUD8C469Jz4tUK4ZZ4ODZo=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Message-ID: <0dd7b03d-0574-40eb-a129-28d07529af02@yandex.ru>
Date: Tue, 29 Sep 2026 13:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: remove obsolete email addresses
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org
References: <20260929124437.87637-1-konstantin.v.ananyev@yandex.ru>
 <CAJFAV8z5pdJ-dFLp8OsFTHD+S+6ty75QwuQUpfhNDT+-_0bx+A@mail.gmail.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <CAJFAV8z5pdJ-dFLp8OsFTHD+S+6ty75QwuQUpfhNDT+-_0bx+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



29.09.2026 13:51, David Marchand пишет:
> On Tue, 29 Sept 2026 at 14:45, <konstantin.v.ananyev@yandex.ru> wrote:
>> From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
>>
>> Remove email addresses that are either already obsolete,
>> or will become obsolete in the nearest future.
>>
>> Signed-off-by: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
> You should leave them here.
> The mailmap entry is used by get-maintainers.sh to find your up to
> date contact address.
>
> If you were involved in some (buggy) commit with your mail at @intel
> or @huawei, you don't want to expect the blame right ? ;-)
>
ok :)

